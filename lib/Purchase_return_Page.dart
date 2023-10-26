import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:random_string/random_string.dart';
import 'package:pdf/widgets.dart' as p;


import 'LandingPage/LandingPage.dart';

const List<String> list = <String>[
  'Select Category',
];

const List<String> list1 = <String>[
  "Select Brand",
];

const List<String> list2 = <String>[
  "Select Item",
];

const List<String> list3 = <String>[
  "Gst",
  "IGst",

];



const List<String> Paymentmode = <String>[
  'Please Select',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Paytm",
  "Returns"
];

const List<String> Entry = <String>[
  'Please Select Type',
  'Purchase Entry',
  'Purchase Entry',
];

const List<String> Stateslect = <String>[
  "Select State",
  " Andhra Pradesh",
  " Arunachal Pradesh",
  " Assam",
  "Bihar",
  "Chhattisgarh",
  " Goa",
  ' Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  " Uttar Pradesh",
  "West Bengal",

];

class Purcharse_Return_Page extends StatefulWidget {
  const Purcharse_Return_Page({Key? key}) : super(key: key);

  @override
  State<Purcharse_Return_Page> createState() => _Purcharse_Return_PageState();
}

class _Purcharse_Return_PageState extends State<Purcharse_Return_Page> {


  //categrory item variables and controller
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = "";
  String Payments2 = Paymentmode.first;
  String Entry_type = Entry.first;
  TextEditingController Purchase_price = TextEditingController();
  TextEditingController Qty = TextEditingController();
  TextEditingController Landing_cost = TextEditingController();
  TextEditingController Mrp_Price = TextEditingController();
  TextEditingController Location = TextEditingController();
  TextEditingController Supplier = TextEditingController();
  TextEditingController IMEI_No = TextEditingController();
  TextEditingController Serial_NO = TextEditingController();
  TextEditingController Invoice_NO = TextEditingController();
  TextEditingController Invoice_date = TextEditingController();
  TextEditingController Creadit_days = TextEditingController();

  //hasn code and box no copntroller
  TextEditingController Box_NO = TextEditingController();
  TextEditingController HSN_Code = TextEditingController();
  TextEditingController Sales = TextEditingController();

  //reason textfield
  TextEditingController Reasoncontroller = TextEditingController();
  //current date and time TextField
  TextEditingController Currentdatecontroller = TextEditingController();
  TextEditingController Currenttimecontroller = TextEditingController();

  //purchase number
  TextEditingController purchase_No = TextEditingController();
  //Based on
  TextEditingController Basedon = TextEditingController();
  //purchase Date
  TextEditingController purchase_Date = TextEditingController();
  //purchase NOtes
  TextEditingController purchase_notes = TextEditingController();
  //suppierid
  TextEditingController suppierid = TextEditingController();
  //suppiler name
  TextEditingController suppiler_name = TextEditingController();
  //suppiler invoiceno
  TextEditingController suppiler_invoice = TextEditingController();
  TextEditingController suppiler_gstno = TextEditingController();
  //itemid
  TextEditingController itemid = TextEditingController();
  //item name
  TextEditingController itemname = TextEditingController();

  //tax
  TextEditingController taxitem = TextEditingController();
  TextEditingController valueitem = TextEditingController();

  int vaalue = 0;

  //billed and shipped to text controller
  TextEditingController Billedto = TextEditingController();
  TextEditingController Shippedto = TextEditingController();
//focus node

  FocusNode suppier_id = FocusNode();
  FocusNode suppiername = FocusNode();
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_payment = FocusNode();
  FocusNode purchase_note = FocusNode();
  //item focus node
  FocusNode items_id = FocusNode();
  FocusNode items_value = FocusNode();
  FocusNode items_name = FocusNode();
  bool randomgenrate=false;
  FocusNode Quvantitylist = FocusNode();
  FocusNode Creditnoptes = FocusNode();






  @override
  void initState() {
    suppiernameaddfunction();
    listoutpaymentfunction();
    //checkbillno();
    itemaddfunction();
    edittoltalamount();
    billnoaddfuncxtion();
    // TODO: implement initState
    super.initState();
  }





  ///payment function
  String Payments = "Please Select Type";
  List<String> Payment = [];

  listoutpaymentfunction()async{
    setState((){
      Payment.clear();
      Payment.add("Please Select Type");
    });
    var listofpayment=await FirebaseFirestore.instance.collection('PaymentTypes').orderBy("Paymentname").get();
    for(int k=0;k<listofpayment.docs.length;k++){
      setState((){
        Payment.add(listofpayment.docs[k]['Paymentname']);
      });
    }
  }

  NumberFormat F=NumberFormat('00');
  int itemcodes=0;

  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"SB"}${F.format(itemcodes)}";
    });

  }

  setsuppierid(suppierids) async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    for(int i=0;i<document.docs.length;i++){
      if(suppierids==document.docs[i]['Suppliername']){
        setState(() {
          suppierid.text=document.docs[i]['Suppliercode'];
        });
      }
    }



  }


  List<String> supplier=[];
  String itemnames='';

  Userdata()async {
    setState(() {
      supplier.clear();
    });
    var details = await FirebaseFirestore.instance.collection("Supplier").get();
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        supplier.add(details.docs[i]["Suppliername"]);
      });
    }
  }

  customeradd(){
    FirebaseFirestore.instance.collection("Supplier").doc().set({
      "Suppliername":suppiler_name.text,
      "SupplierId":suppierid.text,
      "Suppliercode":"",
      "SupplierAddress":"",
      "State":"",
      "City":"",
      "Pincode":"",
      "Mobileno":"",
      "Panno":"",
      "Openingbalance":"",
      "Remarks":"",
      "Suppliername":"",
      "Email":"",
      "timestamp":DateTime.now().microsecondsSinceEpoch,
    });
    clearcontroller();
  }

  clearcontroller(){
    suppiler_name.clear();
    suppierid.clear();
  }
  List <String>Itemlist=[];
  List <String>Itemlist2=[];



  itemaddfunction()async{
    setState(() {
      Itemlist.clear();
    });
    var Document=await FirebaseFirestore.instance.collection('Item').orderBy("Newitemname",descending: false).get();
    for(int i=0;i<Document.docs.length;i++){
      setState(() {
        Itemlist.add(Document.docs[i]['Newitemname']);
      });

    }

  }

  List <String>Suppierlist=[];

  suppiernameaddfunction()async{
    setState(() {
      Suppierlist.clear();
    });

    var Document=await FirebaseFirestore.instance.collection('Supplier').
    orderBy("Suppliername",descending: false).get();
    for(int i=0;i<Document.docs.length;i++){
      Suppierlist.add(Document.docs[i]['Suppliername']);
    }

  }



  String customerphone='';

  String customerdocid='';

  bool customervalid=false;

  check(name) async {
    var details = await FirebaseFirestore.instance.collection("Supplier").get();
    for(int i=0;i<details.docs.length;i++){
      if(name==details.docs[i]['Suppliername']){
        setState(() {
          customervalid=false;
          suppiler_name.text=details.docs[i]['Suppliername'];
          customerdocid=details.docs[i].id;
        });
      }
    }
  }




  //toggle switch boolean
  bool status=true;
  bool status2=false;

  final TextEditingController _typeAheadControllergender = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(Itemlist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



  checkitemtagefunction(query) async {
    var tagdocument=await FirebaseFirestore.instance.collection('Item').get();
    for(int i=0;i<tagdocument.docs.length;i++){
      if(query==tagdocument.docs[i]['Tags']){
        setState(() {
          itemname.text=tagdocument.docs[i]['Tags'];
        });
        List<String> Tagitemlists = <String>[];
        Tagitemlists.addAll(Tagitemlists);
        Tagitemlists.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
        return Tagitemlists.toString();
      }
    }


  }

  List <String>Tagitemlists= <String>[];

  tagaddfunction()async{
    var tagdocument=await FirebaseFirestore.instance.collection('Item').get();
    for(int i=0;i<tagdocument.docs.length;i++){
      setState(() {
        Tagitemlists.add(tagdocument.docs[i]['Tags']);
      });
    }
  }

  checkfunc()async{
    var Documen=await FirebaseFirestore.instance.collection('Supplier').where("Suppliername",isEqualTo:Suppliername.text).get();
    if(Documen.docs.length>0){
      setState((){
        customervalid=false;
      });
    }
    else{
      setState((){
        customervalid=true;
      });
    }
  }

  List <String>billno=[];

  billnoaddfuncxtion() async {
    setState(() {
      billno.clear();
    });
    var document=await FirebaseFirestore.instance.collection("Purchase entry").where("save",isEqualTo:true).get();
    for(int i=0;i<document.docs.length;i++){
      billno.add(document.docs[i]['suppilierinvoiceno']);
    }

  }

  String returnid='0';
   bool gettotal=false;

  ///PURCHASE histroy cash Totalamount variable
  double purchasehistroytotalamount=0;


  
  getvalues(code)async{
    var document=await FirebaseFirestore.instance.collection("Purchase entry").where("save",isEqualTo: true).get();
    for(int i=0;i<document.docs.length;i++){
     if(code==document.docs[i]['suppilierinvoiceno']){
       setState((){
         Totalamountoftopay=0;
         purchasehistroytotalamount=0;
         returnid =document.docs[i].id;
         Payments=document.docs[i]['Payment mode'];
         Creadit_days.text=document.docs[i]['credit days'];
         purchase_Date.text=document.docs[i]['date'];
         purchase_notes.text=document.docs[i]['purchasenote'];
         suppiler_invoice.text=document.docs[i]['suppilierinvoiceno'];
         _typeAheadControllergender9.text=document.docs[i]['suppilierinvoiceno'];
         suppierid.text=document.docs[i]['suppilerid'];
         Suppliername.text=document.docs[i]['suppilername'];
         purchase_No.text=document.docs[i]['purchaseno'];
         suppiler_gstno.text=document.docs[i]['suppilergst'];
         Currentdatecontroller .text="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
         Currenttimecontroller.text=DateFormat.jm().format(DateTime.now());
         gettotal=true;
         if(document.docs[i]['type']=="ShabikaG"){
           status=true;
           status2=false;
         }
         else{
           status2=true;
           status=false;
         }
       });
       if(returnid.isNotEmpty){

         var getdate = await FirebaseFirestore.instance.collection("Purchase entry").
         doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();

         for(int i=0;i<getdate.docs.length;i++){
           setState(() {
             _Streamcontroller1[i].text= getdate.docs[i]["stocks"].toString();
           });


         }
       }


       /*if(returnid.isNotEmpty){

         var getdate = await FirebaseFirestore.instance.collection("Purchase entry").
         doc(returnid).collection(returnid.toString()).get();

         for(int i=0;i<getdate.docs.length;i++){
           if(((int.parse(getdate.docs[i]['Qty'].toString()))-getdate.docs[i]['stocks'])>0){

             if (mounted) {
               setState(() {
                // Totalamountoftopay=Totalamountoftopay+ ((((int.parse(getdate.docs[i]['Qty'].toString())-getdate.docs[i]['stocks'])-getdate.docs[i]['return Quvantity']))*(double.parse(getdate.docs[i]['Landing cost'].toString())));
               });
             }
             print(Totalamountoftopay);
           }
           
         }

         var Purchasehistroy = await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).
         collection("Payment Hisroy").where("payment mode",isNotEqualTo:"Return").get();

         for(int k=0;k<Purchasehistroy.docs.length;k++){
           setState((){
            // purchasehistroytotalamount=purchasehistroytotalamount+double.parse(Purchasehistroy.docs[k]['Amount'].toString());
           });
         }
         print(purchasehistroytotalamount);

         setState((){
        //   Totalamountoftopay=Totalamountoftopay-purchasehistroytotalamount;
         });
         
       }
        */
       print("Qtydecrease lists");
       print(Qtydecrease);

     }

    }


  }


  final TextEditingController _typeAheadControllergender9 = TextEditingController();

  SuggestionsBoxController suggestionBoxController9 = SuggestionsBoxController();
  List<String> getSuggestionsgender9(String query) {
    List<String> matches = <String>[];
    matches.addAll(Suppierlist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  SuggestionsBoxController suggestionBoxController10 = SuggestionsBoxController();

  List<String> getSuggestionsgender10(String query) {
    List<String> matches = <String>[];
    matches.addAll(billno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  bool checkbox=false;

  List<bool> Selected = List.generate(100, (index) => false);
  List Returnlists=[];
  List documentlists=[];
  bool Loading=false;

   double topayamount=0;

  quvanotysolddunction(quvantity,stocks){
      return (quvantity-stocks);
  }

  quvanotyblancedunction(quvantity,stocks){

    return (quvantity-(quvantity-stocks));
  }

  quvantitybalanceduntion(int quvantity,int stocks,double purchaseprice){

    return ((quvantity-stocks)*purchaseprice).toString();
  }

  totalamountmultiplefunction(int stocks,double item){

    return (item*stocks).toStringAsFixed(2);

  }


  double Totalamountoftopay=0;

  final List<TextEditingController> _Streamcontroller1= List.generate(1000, (index) => TextEditingController());
  ///Total Bill Amount CalCulation Function

  Totalbillcalculationamount()async{
    setState((){
      totalamount=0;
      sgst=0;
      Cgst=0;
      TotalAmount2=0;
      salespriceff=0;
      ///document id and purchase random id lists...
      Returnlists.clear();
      documentlists.clear();
      gettotal=false;
    });
    for(int i=0;i<Selected.length;i++){
      setState(() {
        Selected[i]=true;
      });
      var document=await FirebaseFirestore.instance.collection("Purchase entry").
      doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
      for(int k=0;k<document.docs.length;k++){
        if(i==k){
          if((int.parse(document.docs[k]["Qty"].toString())-(((int.parse(document.docs[k]["Qty"].toString()))-document.docs[k]['stocks'])))!=0){
            setState((){
              Returnlists.add(document.docs[k]['itemcode']);
              documentlists.add(document.docs[k]['Itemdocid']);
            });
            totalamount=totalamount+(document.docs[k]["stocks"]*double.parse(document.docs[k]["Purchase price"].toString()));
            salespriceff=salespriceff+(double.parse(document.docs[k]["Purchase price"].toString()));

          }
        }

      }

    }
    CGSTfunction();
    SGSTfunction();
    Totalamounts();
  }


  ///balance Stream Total amount dunction
  streambalnaceamount()async{
    setState((){
      totalamount=0;
      sgst=0;
      Cgst=0;
      TotalAmount2=0;
      salespriceff=0;
      gettotal=false;
      Returnlists.clear();
      documentlists.clear();
    });
    print("funcalled");
    var document=await FirebaseFirestore.instance.collection("Purchase entry").
    doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
    for(int k=0;k<document.docs.length;k++){
      if((int.parse(document.docs[k]["Qty"].toString())-(((int.parse(document.docs[k]["Qty"].toString()))-document.docs[k]['stocks'])))!=0)
      {
        if(Selected[k]==true){
          print("Enter The selected qty value");
          setState((){
            Returnlists.add(document.docs[k]['itemcode']);
            documentlists.add(document.docs[k]['Itemdocid']);
          });
          totalamount=totalamount+((int.parse(_Streamcontroller1[k].text))*double.parse(document.docs[k]["Purchase price"].toString()));
          salespriceff=salespriceff+(double.parse(document.docs[k]["Purchase price"].toString()));

          print(totalamount);
        }
      }
    }
    CGSTfunction();
    SGSTfunction();
    Totalamounts();
    print("Qtydecrease add to data list");
    print(Qtydecrease);
    print("return  litssssssss");
    print(Returnlists);
    print("return  litssssssss");
    print(documentlists);


  }

  ///stream controller add to the quvantity value list
  List<int> Qtydecrease=List.generate(50, (index) => 0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //Purchase_Entry
      Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              //toggle switchs
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width/4.583, right: width/56.916),
                    child: FlutterSwitch(
                      inactiveColor: const Color(0xffC9C9C9),
                      inactiveToggleColor: Colors.grey,
                      width: width/30.35,
                      height: height/32.85,
                      valueFontSize: 5.0,
                      toggleSize: 20.0,
                      value: status,
                      borderRadius: 10.0,

                      padding: 2.0,
                      //showOnOff: true,
                      onToggle: (val) {

                        setState(() {
                          if(val==true) {
                            setState(() {
                              status = val;
                              status2 = false;
                            });
                            billcounts();
                            landingcost(Purchase_price.text);
                            checkgst(Purchase_price.text, Qty.text);
                          }
                          else{
                            setState(() {
                              status2 = val;
                            });
                          }
                        });
                      },
                    ),
                  ),
                  Text(
                    "Shabika G",
                    style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
                  ),

                  SizedBox(width:width/5.0),

                  Padding(
                    padding:  EdgeInsets.only(left: width/4.583, right: width/56.916),
                    child: FlutterSwitch(
                      inactiveColor: const Color(0xffC9C9C9),
                      inactiveToggleColor: Colors.grey,
                      width: width/30.35,
                      height: height/32.85,
                      valueFontSize: 5.0,
                      toggleSize: 20.0,
                      value: status2,
                      borderRadius: 10.0,

                      padding: 2.0,
                      //showOnOff: true,
                      onToggle: (val) {

                        setState(() {
                          if(val==true) {
                            setState(() {
                              status2 = val;
                              status = false;
                            });
                            billcounts();
                            landingcost(Purchase_price.text);
                            checkgst(Purchase_price.text, Qty.text);
                          }
                          else{
                            setState(() {
                              status = val;
                            });
                          }
                        });
                      },
                    ),
                  ),
                  Text(
                    "Shabika N",
                    style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //entry type container
                  SizedBox(
                    height: height/4.054,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //suppiler Id
                          Padding(
                            padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width/273.2,
                                ),
                                Text(
                                  "Supplier ID",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                      fontSize: width/97.57, color: const Color(0xff000000),

                                  ),
                                ),
                                SizedBox(
                                  width: width/22.03,
                                ),
                                Container(
                                  width: width/3.415,
                                  height: height/21.9,
                                  //color:Colors.white,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                    controller: suppierid,
                                    focusNode: suppier_id,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: width /90.78,
                                          bottom: height / 83.8
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (_){
                                      suppier_id.unfocus();
                                      FocusScope.of(context).requestFocus(suppiername);
                                    },
                                  ),
                                ),
                                SizedBox(width: width/273.2,),
                                InkWell(
                                  onTap:(){
                                    if(customervalid==false){
                                      alreadyexistshowdialpogbox();

                                    }
                                    else {
                                      itemcodegenrate();
                                      showdialpogbox2();

                                    }
                                  },
                                  child:
                                  customervalid!=false?
                                  Material(
                                    shadowColor: Colors.black12,
                                    elevation: 25,
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    child: Container(
                                        height:height/21.9,
                                        width:width/10.53,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width:width/400.33),
                                            const Text("New Suppiler"),
                                            SizedBox(width:width/455.33),
                                            const Icon(Icons.add),
                                          ],
                                        )),
                                  ):
                                  ClipOval(
                                      child:
                                      Container(
                                          height:height/21.9,
                                          width:width/45.53,
                                          color: Colors.white,
                                          child: const Icon(Icons.add))),
                                )
                              ],
                            ),
                          ),

                          //suppiler name
                          Padding(
                            padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width/273.2,
                                ),
                                Text(
                                  "Supplier Name",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width/97.57, color: const Color(0xff000000)),
                                ),
                                SizedBox(
                                  width: width/42.687,
                                ),
                                Container(
                                  width: width/3.415,
                                  height: height/21.9,
                                  //color:Colors.white,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,),
                                  child:      TextField(
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700),
                                    controller: Suppliername,
                                    focusNode: suppiername,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: width /90.78,
                                          bottom: height / 83.8),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (_){
                                      suppiername.unfocus();
                                      FocusScope.of(context).requestFocus(suppier_id);
                                    },
                                  ),




                                ),
                              ],
                            ),
                          ),

                          //tax type
                          Padding(
                            padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width/273.2,
                                ),
                                Text(
                                  "Tax Type",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width/97.57, color: const Color(0xff000000)),
                                ),
                                SizedBox(
                                  width: width/18.46,
                                ),
                                Container(
                                  width: width/3.415,
                                  height: height/21.9,
                                  //color:Colors.white,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton2<String>(
                                        value: dropdownValue3,
                                        focusNode:suppiertax ,
                                        isExpanded: true,
                                        isDense: true,
                                        alignment: Alignment.topCenter,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: width/105.07),
                                        underline: Container(
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue3 = value!;
                                          });
                                          suppiertax.unfocus();
                                          FocusScope.of(context).requestFocus(suppierincoice_no);
                                        },

                                        items:
                                        list3.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //suppiler Invoice no
                          Padding(
                            padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width/273.2,
                                ),
                                Text(
                                  "Supplier Invoice No",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width/97.57, color: const Color(0xff000000)),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  width: width/3.415,
                                  height: height/21.9,
                                  //color:Colors.white,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child:
                                  TypeAheadFormField(
                                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                        color: Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )),
                                    textFieldConfiguration: TextFieldConfiguration(
                                      maxLength: 10,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: width/91.07),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: width /90.78,
                                            bottom: height / 83.8),
                                        border: InputBorder.none,
                                      ),
                                      controller: _typeAheadControllergender9,
                                    ),
                                    suggestionsCallback: (pattern) {
                                      return getSuggestionsgender10(pattern);
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion,style:GoogleFonts.montserrat(fontWeight: FontWeight.w700,),)
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      getvalues(suggestion);
                                      setState(() {
                                        suppiler_invoice.text=suggestion.toString();
                                      });
                                    },
                                    suggestionsBoxController: suggestionBoxController9,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please select a academic year'
                                        : null,
                                  ),

                                ),
                              ],
                            ),
                          ),

                          //suppiler Gst no
                          Padding(
                            padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width/273.2,
                                ),
                                Text(
                                  "Supplier Gst No",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width/97.57, color: const Color(0xff000000)),
                                ),
                                SizedBox(
                                  width: width/47.103,
                                ),
                                Container(
                                  width: width/3.415,
                                  height: height/21.9,
                                  //color:Colors.white,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,),
                                    controller: suppiler_gstno,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: width /90.78,
                                          bottom: height / 83.8),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (_){
                                      suppierincoice_no.unfocus();
                                      FocusScope.of(context).requestFocus(purchase_no);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height/4.054,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Purchase  Date
                        Padding(
                          padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                          child: Row(

                            children: [
                              SizedBox(
                                width: width/273.2,
                              ),
                              Text(
                                "Purchase  Date",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/97.57, color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width/105.08,
                              ),
                              Container(
                                width: width/3.415,
                                height: height/21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child:
                                TextField(
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,),
                                  controller: purchase_Date,
                                  focusNode: purchase_date,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: width /90.78,
                                          top: height / 83.8),
                                      border: InputBorder.none,
                                      suffixIcon: const Icon(Icons.calendar_month)
                                  ),
                                  onSubmitted: (_){
                                    purchase_date.unfocus();
                                    FocusScope.of(context).requestFocus(purchase_payment);
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        purchase_Date.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //payment mode
                        Padding(
                          padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width/273.2,
                              ),
                              Text(
                                "Payment Mode",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/97.57, color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width/105.08,
                              ),
                              Container(
                                width: width/3.415,
                                height: height/21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,),
                                child: DropdownButton2<String>(
                                  value: Payments,
                                  focusNode: purchase_payment,
                                  isExpanded: true,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: width/105.07),
                                  underline: Container(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      Payments = value!;
                                    });
                                    purchase_payment.unfocus();
                                    FocusScope.of(context).requestFocus(purchase_note);
                                  },
                                  items:
                                  Payment.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:  EdgeInsets.only(   left: width /95.78,),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Purchase Notes
                        Padding(
                          padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width/273.2,
                              ),
                              Text(
                                "Purchase Notes",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/97.57, color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width/136.6,
                              ),
                              Container(
                                width: width/3.415,
                                height: height/21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,),
                                child: TextField(
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                  controller: purchase_notes,
                                  focusNode: purchase_note,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width /90.78,
                                        bottom: height / 83.8),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_){
                                    purchase_note.unfocus();
                                    FocusScope.of(context).requestFocus(items_id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Craedit days
                        Padding(
                          padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(
                                width: width/273.2,
                              ),

                              Text(
                                "Credit Days",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/97.57, color: const Color(0xff000000)),
                              ),

                              SizedBox(
                                width: width/36.0,
                              ),

                              Container(
                                width: width/3.415,
                                height: height/21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,),
                                child: TextField(
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                  controller: Creadit_days,
                                  focusNode: Creditnoptes,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width /90.78,
                                        bottom: height / 83.8),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_){
                                    purchase_note.unfocus();
                                    FocusScope.of(context).requestFocus(items_id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Reason
                        Padding(
                          padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width/273.2,
                              ),
                              Text(
                                "Reason",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/97.57, color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width/20.064,
                              ),
                              Container(
                                width: width/3.415,
                                height: height/21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,),
                                child:
                                TextField(
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                  controller: Reasoncontroller,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width /90.78,
                                        bottom: height / 83.8),
                                    border: InputBorder.none,

                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Material(
                    elevation: 50,
                    shadowColor: Colors.black38,
                    color: const Color(0xff7d99ab),
                    child: Container(
                      width: width/0.976,
                      height: height/16.425,
                      decoration: const BoxDecoration(
                        color: Color(0xff7d99ab),),
                      child: Row(
                        children: [

                          //Serial no
                          SizedBox(
                            width: width/45.533,
                            child:
                            Center(child: Text("",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //itemid
                          SizedBox(
                            width: width/14.2,

                            child:
                            Center(child: Text("Item ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //itemname
                          SizedBox(
                            width: width/3.7,

                            child:Center(child: Text("Item Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),


                          ),

                          //Box No
                          SizedBox(
                            width: width/16.8,
                            child:
                            Center(child: Text("Box No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //Hsn Code
                          SizedBox(
                            width: width/17.8,

                            child:
                            Center(child: Text("HSN Code",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //tax
                          SizedBox(
                            width: width/17.18,

                            child:
                            Center(child: Text("Tax %",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //quvantity
                          SizedBox(
                            width: width/15.18,
                            child:
                            Center(child: Text("Qnty",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),


                          //price
                          SizedBox(
                            width: width/15.18,
                            child:
                            Center(child: Text("Price",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //landing cost
                          SizedBox(
                            width: width/15.18,

                            child:
                            Center(child: Text("Landing Cost",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                          ),

                          //Sales Price
                          SizedBox(
                            width: width/15.18,
                            child:
                            Center(child: Text("Sales Price",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          //value
                          SizedBox(
                            width: width/15.18,
                            child:
                            Center(child: Text("Value",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.redAccent),)),
                          ),

                          //Low order quvantity
                          SizedBox(
                            width: width/35.18,

                            child:
                            Center(child: Text("A\nQnty",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                          SizedBox(
                            width: width/25.18,

                            child:
                            Center(child: Text("Stk",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),


                          //Clear controllers
                          SizedBox(
                            width: width/15.18,
                            child:
                            Center(child: Text("Clear ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                          ),

                        ],
                      ),
                    ),
                  ),

                  Container(
                    // color: Color(0xffFFFFFF),
                    width: width/0.976,
                    decoration: const BoxDecoration(
                      color: Color(0xffb7b0aa),),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Serial no
                        Container(
                          width: width/45.533,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child:
                          Checkbox(
                              value:checkbox ,
                              onChanged:(_) async {

                                setState((){
                                  checkbox=!checkbox;
                                });

                                ///total bill amount calculation function
                                if(checkbox==true){
                                  Totalbillcalculationamount();
                                }

                                ///clear the generated boolean and clear the list methods...
                                else if(checkbox==false){
                                  for(int i=0;i<Selected.length;i++){
                                    setState(() {
                                      Selected[i]=false;
                                      gettotal=true;
                                      totalamount=0;
                                      salespriceff=0;
                                      Cgst=0;
                                      sgst=0;
                                      totalamount=0;
                                      TotalAmount2=0;
                                      Returnlists.clear();
                                      documentlists.clear();
                                    });
                                  }

                                }

                              } ),
                        ),

                        //itemid
                        Container(
                          width: width/14.2,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: itemid,
                            focusNode: items_id,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only( left: width /48.78,bottom: height/65.7),
                            ),
                            onSubmitted: (_){
                              items_id.unfocus();
                              FocusScope.of(context).requestFocus(items_value);
                            },

                          ),
                        ),

                        //itemname
                        Container(
                          width: width/3.7,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child:



                          Padding(
                            padding:  EdgeInsets.only(left:width/130,right: width/170),
                            child: LayoutBuilder(
                              builder: (BuildContext , BoxConstraints )=>
                                  Autocomplete<String>(
                                    initialValue: TextEditingValue(
                                      text: itemnames,
                                    ),
                                    optionsViewBuilder:(context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                          ),
                                          child: SizedBox(
                                            height: 52.0 * options.length,
                                            width: BoxConstraints.biggest.width,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: options.length,
                                              shrinkWrap: false,
                                              itemBuilder: (BuildContext , index) {
                                                final String option = options.elementAt(index);
                                                return InkWell(
                                                  onTap: () => onSelected(option),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Text(option,style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                    ),
                                    optionsBuilder: (TextEditingValue textEditingValue) {

                                      if (textEditingValue.text == '') {
                                        return const Iterable<String>.empty();
                                      }

                                      if(textEditingValue.text!=""){
                                        createpurchase2(textEditingValue.text.toString());
                                        setState(() {
                                          itemname.text = textEditingValue.text.toString();
                                        });
                                      }

                                      return
                                        Itemlist.where((String option) {
                                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        });
                                    },
                                    onSelected: (String selection) {
                                      createpurchase2(selection.toString());
                                      setState(() {
                                        itemname.text = selection;
                                      });

                                      debugPrint('You just selected $selection');
                                    },
                                    displayStringForOption: (Value){
                                      return Value;
                                    },
                                  ),
                            ),
                          ),

                        ),

                        //Box No
                        Container(
                          width: width/16.8,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Box_NO,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                            onSubmitted: (_){
                            },

                          ),
                        ),

                        //Hsn Code
                        Container(
                          width: width/17.8,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: HSN_Code,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),


                          ),
                        ),

                        //tax
                        Container(
                          width: width/17.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: taxitem,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                          ),
                        ),

                        //quvantity
                        Container(
                          width: width/15.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Qty,
                            focusNode: Quvantitylist,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                            onSubmitted: (_){

                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Fill the Suppiler Name and Suppiler ID.....")));

                            },
                            onChanged: (_){
                              if(suppierid.text.length!=0||suppiler_name.text.length!=0) {
                                if (Qty.text.length > 0) {
                                  checkgst(Purchase_price.text, Qty.text);
                                }
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Fill the Suppiler Name and Suppiler ID.....")));
                              }
                            },
                          ),
                        ),

                        //price
                        Container(
                          width: width/15.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Purchase_price,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                            onSubmitted: (_){
                              landingcost(Purchase_price.text);
                              checkgst(Purchase_price.text, Qty.text);
                            },
                          ),
                        ),

                        //landing cost
                        Container(
                          width: width/15.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Landing_cost,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),

                          ),
                        ),

                        //Sales Price
                        Container(
                          width: width/15.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Sales,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                          ),
                        ),


                        //value
                        Container(
                          width: width/15.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color:Colors.red),
                            controller: valueitem,
                            focusNode: items_value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                            onSubmitted: (_){
                              serialvalue == true || imeivalue == true || color ==
                                  true ?
                              //create a document (Firebase)
                              showtextfield(int.parse(Qty.text), serialvalue, imeivalue, color,0) :
                              collectioncreatefunction();

                              updatetotal();
                              CGSTfunction();
                              SGSTfunction();
                              Totalamounts();
                              items_value.unfocus();
                              FocusScope.of(context).requestFocus(items_id);
                              items_value.unfocus();
                              FocusScope.of(context).requestFocus(items_id);

                            },
                          ),
                        ),

                        //Low order quvantity
                        Container(
                          width: width/30.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Loworder,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                          ),
                        ),

                        //Stock
                        Container(
                          width: width/30.18,
                          height: height/21.9,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,width: 0.6
                              )
                          ),
                          child: TextField(
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                            controller: Stocks,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                            ),
                          ),
                        ),

                        //Clear controllers
                        Container(
                            width: width/15.18,
                            height: height/21.9,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,width: 0.6
                                )
                            ),
                            child:
                            Center(
                              child: InkWell(
                                onTap: (){
                                  clearallcontroller();
                                },
                                child: const Icon(
                                    Icons.delete
                                ),
                              ),
                            )
                        ),

                      ],
                    ),

                  ),

                  SizedBox(
                    height: height/131.4,
                  ),

                  Material(
                    elevation: 50,
                    shadowColor: Colors.black38,
                    color: const Color(0xffFFFFFF),
                    child: Container(
                      //color: Color(0xffFFFFFF),
                      width: width/0.976,
                      height: height/2.8,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFFFFF),
                      ),

                      child:
                      ListView(
                        shrinkWrap: true,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                                Text("Balance  Items",style:GoogleFonts.openSans(fontWeight: FontWeight.w700)),
                            ],
                          ),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Purchase entry").doc(returnid)
                                .collection(returnid.toString()).orderBy("timestamp").snapshots(),
                            builder: (context, snapshot) {

                              if (snapshot.hasData == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  var stocksitem=snapshot.data!.docs[index];

                                  return quvanotyblancedunction(int.parse(stocksitem['Qty'].toString()),stocksitem['stocks'])!=0 ?

                                  Padding(
                                    padding:  EdgeInsets.only(),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        //Serial no
                                        Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                          width: width/45.533,
                                         height: height/20.0,
                                           child: Checkbox(
                                              value:Selected[index] ,
                                              onChanged:(_) async {
                                                setState((){
                                                  Selected[index]=!Selected[index];
                                                });
                                                if(Selected[index]==true){
                                                  setState((){
                                                    Qtydecrease.replaceRange(index,index+1,[stocksitem["stocks"]]);
                                                  });
                                                  streambalnaceamount();
                                                }


                                              } ),
                                        ),

                                        //itemid
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/14.2,
                                            height: height/20.0,
                                            child: Center(child: Text("${stocksitem['itemcode']}"))
                                        ),

                                        //itemname
                                         Tooltip(
                                           message: "${stocksitem['Description']}\n${stocksitem['Imei no']
                                               .toString()}\n${stocksitem['Serial no']
                                               .toString()}\n${stocksitem['color']
                                               .toString()}",
                                           child: Container(
                                            decoration: BoxDecoration(
                                              border:Border.all(
                                                color:Colors.black87
                                              )
                                            ),
                                              width: width/3.7 +width/ 27.32,
                                               height: height/20.0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: width/3.7 +width/ 27.32,
                                                      height: height/35.9,
                                                      child: Text('${stocksitem['Description']},',textAlign: TextAlign.left,)),
                                                  stocksitem['IMEI NO']==true?
                                                  Text(
                                                    "IMEI No: ${stocksitem['Imei no']
                                                        .toString()}",
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.green,
                                                        textStyle:  TextStyle(
                                                            overflow: TextOverflow
                                                                .ellipsis)),
                                                  ):
                                                  stocksitem['Serial NO']==true?
                                                  Text(
                                                    "Serial No: ${stocksitem['Serial no']
                                                        .toString()}",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.green,
                                                        textStyle: const TextStyle(
                                                            overflow: TextOverflow
                                                                .ellipsis)),
                                                  ):
                                                  stocksitem['Color']==true?
                                                  Text(
                                                    "Color: ${stocksitem['color']
                                                        .toString()}",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.green,
                                                        textStyle:  TextStyle(
                                                            overflow: TextOverflow
                                                                .ellipsis)),
                                                  ):const SizedBox()

                                                ],
                                              )),
                                         ),




                                        //Hsn code
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/11.8,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(stocksitem['Hsncode']))
                                        ),


                                        //tax
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(stocksitem['tax']))
                                        ),


                                        //quvantity
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            TextField(
                                              controller: _Streamcontroller1[index],

                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left:width/34.15,bottom:10),


                                                  border: InputBorder.none
                                              ),
                                              onSubmitted: (_) async {
                                                setState((){
                                                  Selected[index]=!Selected[index];
                                                });
                                                if(Selected[index]==true){
                                                  setState((){
                                                    Qtydecrease.replaceRange(index,index+1,[int.parse(_Streamcontroller1[index].text)]);
                                                  });
                                                  print("Qtydecrease Listsssss");
                                                  print(Qtydecrease);

                                                  if(stocksitem['IMEI NO']==true){
                                                    print("Imei Number True");
                                                    setState((){
                                                      ImerisrialListitem[index].clear();
                                                    });
                                                    for (int i = 0; i < stocksitem['Imei no'].length; i++) {
                                                      setState(() {
                                                        ImerisrialListitem[index].add(stocksitem['Imei no'][i].toString());
                                                      });

                                                    }
                                                  }
                                                  print(ImerisrialListitem[index]);
                                                  print(ImerisrialListitem);
                                                   if(stocksitem['Serial NO']==true){
                                                    setState((){
                                                      ImerisrialListitem1[index].clear();
                                                    });
                                                    for (int j = 0; j < stocksitem['Serial no'].length; j++) {
                                                      ImerisrialListitem1[index].add(stocksitem['Serial no'][j].toString());
                                                    }

                                                  }
                                                   if(stocksitem['Color']==true){
                                                    setState((){
                                                      ImerisrialListitem2[index].clear();
                                                    });
                                                    for (int k = 0; k < stocksitem['color'].length; k++) {
                                                      ImerisrialListitem2[index].add(stocksitem['color'][k].toString());
                                                    }

                                                  }
                                                   print( _Streamcontroller1[index].text);
                                                   print( stocksitem['IMEI NO']);
                                                   print( stocksitem['Serial NO']);
                                                   print( stocksitem['Color']);
                                                   if(
                                                     stocksitem['IMEI NO']==false&&
                                                      stocksitem['Serial NO']==false&&
                                                      stocksitem['Color']==false&&
                                                      _Streamcontroller1[index].text!=""){
                                                    print("Enter The All Condition False");
                                                    streambalnaceamount();
                                                  }

                                                  print("Check-4");
                                                  Future.delayed(Duration(seconds:1),(){
                                                    stocksitem['Color']==true||
                                                        stocksitem['Serial no']==true||
                                                        stocksitem['IMEI NO']==true?

                                                    showstocksupdate(
                                                        int.parse(_Streamcontroller1[index].text),
                                                        stocksitem['Serial NO'],
                                                        stocksitem['IMEI NO'],
                                                        stocksitem['Color'],
                                                        ///list items
                                                        stocksitem['Imei no'],
                                                        stocksitem['Serial no'],
                                                        stocksitem['color'],
                                                        stocksitem.id,
                                                        ///purchase price
                                                        double.parse( stocksitem['Purchase price']),index
                                                    ):
                                                    totalamountmultiplefunction(int.parse(_Streamcontroller1[index].text),
                                                        double.parse( stocksitem['Purchase price']));

                                                  });
                                                }
                                              },
                                            )
                                        ),



                                        //price
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(stocksitem['Purchase price'].toString()))
                                        ),

                                        //landing cost
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(stocksitem['Landing cost'].toString()))
                                        ),

                                        //Sales Price
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(stocksitem['Sales price'].toString()))
                                        ),

                                        //value
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(child: Text(
                                                _Streamcontroller1[index].text==""?
                                              totalamountmultiplefunction(stocksitem['stocks'],double.parse(stocksitem['Purchase price'].toString())):
                                                totalamountmultiplefunction(int.parse( _Streamcontroller1[index].text),double.parse(stocksitem['Purchase price'].toString()))

                                              ,style:  GoogleFonts.openSans(color: Colors.red),))
                                        ),

                                        //A Quvantity
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/18.5,
                                            height: height/20.0,
                                            child:
                                            const Center(child: Text(""))
                                        ),

                                        //remove
                                         Container(
                                          decoration: BoxDecoration(
                                            border:Border.all(
                                              color:Colors.black87
                                            )
                                          ),
                                            width: width/15.18,
                                            height: height/20.0,
                                            child:
                                            Center(
                                              child: InkWell(
                                                onTap: (){
                                                  deletecollection(stocksitem.id);

                                                },
                                                child: const Icon(
                                                    Icons.delete
                                                ),
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  ) :
                                  Container();




                                },
                              );
                            },
                          ),

                        /*    Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Sold  Items",style:TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Purchase entry").doc(returnid)
                                .collection(returnid.toString()).orderBy("timestamp")
                                .snapshots(),
                            builder: (context, snapshot) {

                              if (snapshot.hasData == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  var stocksitem=snapshot.data!.docs[index];

                                  return
                                    int.parse(stocksitem['Qty'].toString()) != stocksitem['stocks'] ?
                                    Padding(
                                    padding:  EdgeInsets.only(bottom:height/164.25),
                                    child: Row(
                                      children: [

                                        //Serial no
                                        SizedBox(
                                          width: width/45.533,
                                          height: height/16.425,

                                        ),

                                        //itemid
                                        SizedBox(
                                            width: width/14.2,
                                            height: height/16.425,
                                            child: Center(child: Text("${stocksitem['itemcode']}"))
                                        ),

                                        //itemname
                                        SizedBox(
                                            width: width/3.7,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${stocksitem['Description']},',textAlign: TextAlign.left,),
                                                SizedBox(height:height/131.4),
                                                Row(
                                                  children: [
                                                    Text("Sold item : ${quvanotysolddunction(int.parse(stocksitem['Qty'].toString()),stocksitem['stocks'])}",textAlign: TextAlign.left,
                                                      style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                stocksitem['IMEI NO']==true?
                                                Text(
                                                  "IMEI No: ${stocksitem['returnimei']
                                                      .toString()}",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ):
                                                stocksitem['Serial NO']==true?
                                                Text(
                                                  "Serial No: ${stocksitem['returnserial']
                                                      .toString()}",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ):
                                                stocksitem['Color']==true?
                                                Text(
                                                  "Color: ${stocksitem['returncolor']
                                                      .toString()}",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ):const SizedBox()

                                              ],
                                            )),

                                        SizedBox(width:width/ 27.32,),

                                        //Hsn code
                                        SizedBox(
                                            width: width/11.8,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Hsncode']))
                                        ),

                                        //tax
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['tax']))
                                        ),

                                        //quvantity
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child:Text(quvanotysolddunction(int.parse(stocksitem['Qty'].toString()),stocksitem['stocks']).toString()))
                                        ),

                                        //price
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Purchase price'].toString()))
                                        ),

                                        //landing cost
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Landing cost'].toString()))
                                        ),

                                        //Sales Price
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Sales price'].toString()))
                                        ),

                                        //value
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(quvantitybalanceduntion(int.parse(stocksitem['Qty'].toString()),stocksitem['stocks'],double.parse(stocksitem['Purchase price'].toString())).toString(),style: const TextStyle(color: Colors.red),))
                                        ),

                                        //A Quvantity
                                        SizedBox(
                                            width: width/18.5,
                                            height: height/16.425,
                                            child:
                                            const Center(child: Text(""))
                                        ),

                                        //remove
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(
                                              child: InkWell(
                                                onTap: (){
                                                  deletecollection(stocksitem.id);



                                                },
                                                child: const Icon(
                                                    Icons.delete
                                                ),
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  ):Container();




                                },
                              );
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Returned  Items",style:TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Purchase entry").doc(returnid)
                                .collection(returnid.toString()).orderBy("timestamp")
                                .snapshots(),
                            builder: (context, snapshot) {

                              if (snapshot.hasData == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  var stocksitem=snapshot.data!.docs[index];

                                  return
                                    stocksitem['return']==true?
                                    Padding(
                                    padding:  EdgeInsets.only(bottom:height/164.25),
                                    child: Row(
                                      children: [

                                        //Serial no
                                        SizedBox(
                                          width: width/45.533,
                                          height: height/16.425,
                                            child: Center(child: Text("${index+1}"))
                                        ),

                                        //itemid
                                        SizedBox(
                                            width: width/14.2,
                                            height: height/16.425,
                                            child: Center(child: Text("${stocksitem['itemcode']}"))
                                        ),

                                        //itemname
                                        SizedBox(
                                            width: width/3.7,
                                            child: Center(child: Text('${stocksitem['Description']},',textAlign: TextAlign.left,))),

                                        SizedBox(width:width/ 27.32,),




                                        //Hsn code
                                        SizedBox(
                                            width: width/11.8,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Hsncode']))
                                        ),


                                        //tax
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['tax']))
                                        ),


                                        //quvantity
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child:Text(stocksitem['Qty'].toString()))
                                        ),



                                        //price
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Purchase price'].toString()))
                                        ),

                                        //landing cost
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Landing cost'].toString()))
                                        ),

                                        //Sales Price
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Sales price'].toString()))
                                        ),

                                        //value
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(child: Text(stocksitem['Total'],style: const TextStyle(color: Colors.red),)),
                                        ),

                                        //A Quvantity
                                        SizedBox(
                                            width: width/18.5,
                                            height: height/16.425,
                                            child:
                                            const Center(child: Text(""))
                                        ),

                                        //remove
                                        SizedBox(
                                            width: width/15.18,
                                            height: height/16.425,
                                            child:
                                            Center(
                                              child: InkWell(
                                                onTap: (){
                                                  deletecollection(stocksitem.id);

                                                },
                                                child: const Icon(
                                                    Icons.delete
                                                ),
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  ):const SizedBox();




                                },
                              );
                            },
                          ),

                         */



                        ],
                      )

                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: height / 131.4, left: width / 27.32),
                child: Material(
                  elevation: 50,
                  shadowColor: Colors.black38,
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: width / 1.093,
                    height: height / 6.14,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: width /25.83,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width / 75.888),
                              child:
                              InkWell(
                                onTap: () {
                                  print("Hello 1 ---------------------------------------------------");
                                  savedatefunction();
                                  setState(() {
                                    Loading = true;
                                  });
                                  print("Hello 2 ---------------------------------------------------");
                                  retrninvoice();
                                  print("Hello 3 ---------------------------------------------------");
                                  //check bill no function
                                 Purchaseitem();
                                  print("Hello 4 ---------------------------------------------------");
                                  printdate(returnid);
                                  //  printdate();
                                  Future.delayed(const Duration(seconds: 3),(){
                                    ///stream controller clear function
                                   // Streamcontrollerclear();
                                    setState(() {
                                      Loading = false;
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => drawer(" "),));
                                  });

                                },
                                child:
                                Container(
                                  width: width / 7.0,
                                  height: height / 16.42,
                                  //color: Color(0xffD60A0B),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff25D366),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Update Invoice",
                                        style:
                                        GoogleFonts.poppins(color: Colors.white),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height: height / 131.4),
                            Padding(
                              padding: EdgeInsets.only(left: width / 75.888),
                              child: InkWell(
                                onTap: () {
                                  getvalue(
                                      suppierid.text,
                                      suppiler_name.text,
                                      dropdownValue3,
                                      suppiler_invoice.text,
                                      purchase_No.text,
                                      purchase_Date.text,
                                      Payments);
                                },
                                child: Container(
                                  width: width / 7.0,
                                  height: height / 16.42,
                                  //color: Color(0xffD60A0B),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff0079FF),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Update And Print Invoice",
                                        style:
                                        GoogleFonts.poppins(color: Colors.white),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width:width/91.066),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //
                            //   height: height / 16.42,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4),
                            //     color: const Color(0xff075E54),
                            //   ),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Padding(
                            //         padding: EdgeInsets.only(
                            //             left: width / 455.33),
                            //         child: SizedBox(
                            //           width: width / 4.3,
                            //           height: height / 19.42,
                            //           child:
                            //           Row(
                            //             children: [
                            //               Text(
                            //                 "Payment",
                            //                 style: GoogleFonts.poppins(
                            //                     fontWeight: FontWeight.w600,
                            //                     color: Colors.white,
                            //                     fontSize: width / 85.375),
                            //               ),
                            //                   SizedBox(width:width/30.6),
                            //                   DropdownButton2<String>(
                            //                 value: Payments2,
                            //                 iconStyleData: IconStyleData(
                            //                   iconEnabledColor: Colors.white
                            //                 ),
                            //                 dropdownStyleData: DropdownStyleData(
                            //                   decoration: BoxDecoration(color: Color(0xff00A99D))
                            //                 ),
                            //                 style: GoogleFonts.montserrat(
                            //                     fontWeight: FontWeight.w700,
                            //                     color: Colors.white,
                            //                     fontSize: width / 105.07),
                            //                 underline: Container(
                            //                   color: Colors.deepPurpleAccent,
                            //                 ),
                            //                 onChanged: (String? value) {
                            //                   // This is called when the user selects an item.
                            //                   setState(() {
                            //                     Payments2 = value!;
                            //                   });
                            //                 },
                            //                 items: Paymentmode.map<
                            //                     DropdownMenuItem<String>>(
                            //                         (String value) {
                            //                       return DropdownMenuItem<String>(
                            //                         value: value,
                            //                         child: Text(value),
                            //                       );
                            //                     }).toList(),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            SizedBox(height: height / 131.4),

                              ///date and time container in current Date and Time
                              Row(
                                children: [
                                  Container(
                                  width: width / 9.0,
                                  height: height / 16.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff0C356A),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 455.33),
                                        child: SizedBox(
                                          width: width / 30.5,
                                          height: height / 19.42,
                                          child: Center(
                                            child: Text(
                                              "Date",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width / 13.83,
                                        height: height / 19.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: TextField(
                                          readOnly: true,
                                          controller: Currentdatecontroller,
                                          keyboardType:
                                          TextInputType.multiline,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width / 91.06),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: width / 120.3,
                                                bottom: height / 82.125),
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (_) {
                                            totalamountwithroundof();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                                  SizedBox(width:width/91.066),

                                  Container(
                                    width: width / 9.0,
                                  height: height / 16.42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff191D88),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 455.33),
                                        child: SizedBox(
                                          width: width / 30.5,
                                          height: height / 19.42,
                                          child: Center(
                                            child: Text(
                                              "Time",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width / 13.83,
                                        height: height / 19.42,
                                        //color: Color(0xffDDDEEE),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: TextField(
                                          readOnly: true,
                                          controller: Currenttimecontroller,
                                          keyboardType:
                                          TextInputType.multiline,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width / 91.06),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: width / 68.3,
                                                bottom: height / 82.125),
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (_) {
                                            totalamountwithroundof();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                                ],
                              ),
                          ],
                        ),
                        SizedBox(width:width/91.066),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: height / 6.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      dropdownValue3 == "IGST"
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                      children: [

                                        SizedBox(width: width / 220.6),


                                        //c gst amount
                                        Container(
                                            width: width / 7.0,
                                            height: height / 16.42,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: const Color(0xff1D5B79),
                                            ),
                                            child:Padding(
                                              padding:  EdgeInsets.only(left:width/341.5),
                                              child: Row(
                                                mainAxisAlignment:
                                                dropdownValue3 == "IGST"
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.center,
                                                children: [
                                                  dropdownValue3 == "IGST"
                                                      ? SizedBox(
                                                    height: height / 21.9,
                                                    width: width / 14.0,
                                                    child: Text(
                                                      "IGST(18%):",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: width / 85.375),
                                                    ),
                                                  )
                                                      : SizedBox(
                                                    width: width / 14.0,
                                                    height: height / 21.9,
                                                    child: Text(
                                                      "C GST(9%):",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: width / 85.375),
                                                    ),
                                                  ),
                                                  dropdownValue3 == "IGST"
                                                      ? Container(
                                                    width: width / 15.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: Colors.grey.shade300
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "",
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: Colors.black,
                                                            fontSize: width / 85.375),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                    width: width / 15.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: Colors.grey.shade300
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        gettotal==true?"0":   Cgst.toStringAsFixed(2),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: Colors.black,
                                                            fontSize: width / 85.375),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                        SizedBox(width:width/91.066),


                                        //S GSt amount

                                        dropdownValue3 == "IGST" ?
                                        SizedBox(
                                          width: width / 7.0,
                                          height: height / 16.42,
                                        ):
                                        Container(
                                            width: width / 7.0,
                                            height: height / 16.42,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: const Color(0xff1D5B79),
                                            ),
                                            child:Padding(
                                              padding:  EdgeInsets.only(left:width/341.5),
                                              child: Row(
                                                children: [
                                                  SizedBox(width:width/683),
                                                  dropdownValue3 == "IGST"
                                                      ? const SizedBox()
                                                      : SizedBox(
                                                    width: width / 14.0,
                                                    height: height / 21.9,
                                                    child: Text(
                                                      "S GST(9%):",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: width / 85.375),
                                                    ),
                                                  ),
                                                  dropdownValue3 == "IGST"
                                                      ? const SizedBox()
                                                      : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.shade300,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    width: width / 15.66,
                                                    height: height / 21.9,
                                                    child: Center(
                                                      child: Text(
                                                        gettotal==true?"0":  sgst.toStringAsFixed(2),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: Colors.black,
                                                            fontSize: width / 85.375),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        )

                                      ],
                                    ),

                                    SizedBox(height: height / 65.7),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width:width/227.66),
                                        Container(
                                          width: width / 7.0,
                                          height: height / 16.42,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xff075E54),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width / 455.33),
                                                child: SizedBox(
                                                  width: width / 12.5,
                                                  height: height / 19.42,
                                                  child: Text(
                                                    "Round Value",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white,
                                                        fontSize: width / 85.375),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width / 16.83,
                                                height: height / 19.42,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                    BorderRadius.circular(6)),
                                                child: TextField(
                                                  controller: rounof,
                                                  keyboardType:
                                                  TextInputType.multiline,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: width / 91.06),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(
                                                        left: width / 68.3,
                                                        bottom: height / 82.125),
                                                    border: InputBorder.none,
                                                  ),
                                                  onSubmitted: (_) {
                                                    totalamountwithroundof();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width:width/91.066),
                                       /* Container(
                                          width: width / 7.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0xff00A99D),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left:width/227.66),
                                                child: SizedBox(
                                                  width: width / 17.3,
                                                  height: height / 13.14,
                                                  child: Center(
                                                    child: Text(
                                                      "To Pay :",
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.bold,
                                                          color:  Colors.white,
                                                          fontSize: width / 80.88),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 12.8,
                                                height: height / 13.14,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [

                                                    Text(
                                                      Totalamountoftopay.toStringAsFixed(2),
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.bold,
                                                          textStyle: const TextStyle(
                                                              overflow:
                                                              TextOverflow.ellipsis),
                                                          color:  Colors.white,
                                                          fontSize: width / 80.88),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ],
                                )),

                            SizedBox(width:width/68.3),

                            SizedBox(
                                height: height / 6.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //sub total
                                    Container(
                                      width: width / 7.0,
                                      height: height / 16.42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0xff00A99D),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left:width/227.66),
                                            child: SizedBox(
                                              width: width / 17.075,
                                              child: Text(
                                                "Sub Total",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: width / 85.375),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 13.66,
                                            child: Text(
                                              gettotal==true?"0":": ${totalamount.toStringAsFixed(2)}"
                                              ,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height / 131.4),

                                    Container(
                                      width: width / 7.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0xff00A99D),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left:width/227.66),
                                            child: SizedBox(
                                              width: width / 17.3,
                                              height: height / 13.14,
                                              child: Center(
                                                child: Text(
                                                  "Total :",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                      color:  Colors.white,
                                                      fontSize: width / 55.88),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 12.8,
                                            height: height / 13.14,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                              gettotal==true?"0":  TotalAmount2.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                      textStyle: const TextStyle(
                                                          overflow:
                                                          TextOverflow.ellipsis),
                                                      color:  Colors.white,
                                                      fontSize: width / 58.88),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),



            ],
          ),
          Loading == true
              ?
          SizedBox(
            height: height / 2.38,
            width: width / 5.106,
            child: Column(
              children: [
                Lottie.asset(
                  "assets/FsRGzkbt6x.json",
                  height: height / 3.38,
                  width: width / 6.106,
                ),
                Text("Please Wait",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ],
            ),
          )
              : const SizedBox(),
        ],
      );
  }








  //popup update suppier textcontrollers
  TextEditingController Suppliername=TextEditingController();
  TextEditingController Supplieremail=TextEditingController();
  TextEditingController Suppliercode=TextEditingController();
  TextEditingController SupplierAddress=TextEditingController();
  TextEditingController State=TextEditingController();
  TextEditingController City=TextEditingController();
  TextEditingController Pincode=TextEditingController();
  TextEditingController Mobileno=TextEditingController();
  TextEditingController Mobileno2=TextEditingController();
  TextEditingController Panno=TextEditingController();
  TextEditingController Openingbalance=TextEditingController();
  TextEditingController Remarks=TextEditingController();

  TextEditingController Loworder=TextEditingController();
  TextEditingController Stocks=TextEditingController();


  showdialpogbox2() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding:  EdgeInsets.only(top: height/131.4, bottom: height/131.4),
          child: SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: const Color(0xff264656),
                content:
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width/91.06,
                        ),

                        Padding(
                          padding:  EdgeInsets.only(right: width/1.517,
                              top: height/65.7,bottom: height/65.7),
                          child: Text(
                            "Add New Supplier",
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold, fontSize: width/59.39,color: const Color(0xffFFFFFF)),
                          ),
                        ),
                      ],
                    ),
                    Image.asset("assets/Line13.png"),
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left:width/21.015,top: height/82.125),
                          child: Text("Supplier Name *",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: width/9.486,top: height/82.125),
                          child: Text("Supplier Code*",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white)),),

                        Padding(
                          padding:  EdgeInsets.only(left: width/9.757,top: height/82.125),
                          child: Text("Supplier Address *",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),
                      ],
                    ),
                    Row(
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(left: width/25.77,top: height/65.7,
                              right: width/22.76),
                          child: Container(
                            width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                            child:
                            TextField(
                              controller: Suppliername,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,),
                          child:
                          Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                            controller: Suppliercode,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: GoogleFonts.poppins(fontSize: width/136.6),
                            decoration: InputDecoration(contentPadding:
                            EdgeInsets.only(left: width/68.3,bottom: width/82.125),
                              border: InputBorder.none,
                            ),
                          ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,left: width/27.32),
                          child: Container(width: width/2.55,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                            controller: SupplierAddress,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: GoogleFonts.poppins(fontSize:width/91.06),
                            decoration: InputDecoration(contentPadding:
                            EdgeInsets.only(left:width/68.3,bottom: 8),
                              hintText: "Suppiler Address",
                              border: InputBorder.none,
                            ),
                          ),
                          ),
                        ),

                      ],
                    ),

                    Row(
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(left: width/23.55,top: height/32.85),
                          child: Text("State",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/6.266,top: height/32.85),
                          child: Text("City",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:width/5.991,top: height/32.85),
                          child: Text("Pincode",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/8.130,top: height/32.85),
                          child: Text("Mobile Number",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/12.418,top: height/32.85),
                          child: Text("Mobile Number-2",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:height/65.7,right: width/22.76,left: width/27.32),
                          child: Container(
                            width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                            child: LayoutBuilder(
                              builder: (BuildContext , BoxConstraints )=>
                                  Autocomplete<String>(
                                    optionsViewBuilder:(context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                          ),
                                          child: SizedBox(
                                            height: 52.0 * options.length,
                                            width: BoxConstraints.biggest.width,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: options.length,
                                              shrinkWrap: false,
                                              itemBuilder: (BuildContext , index) {
                                                final String option = options.elementAt(index);
                                                return InkWell(
                                                  onTap: () => onSelected(option),
                                                  child: Padding(
                                                    padding:  EdgeInsets.symmetric(
                                                        horizontal: width/85.375,
                                                        vertical: height/41.0625
                                                    ),
                                                    child: Text(option),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                    ),
                                    optionsBuilder: (TextEditingValue textEditingValue) {

                                      if (textEditingValue.text == '') {
                                        return const Iterable<String>.empty();
                                      }

                                      if(textEditingValue.text!=""){
                                      }
                                      return
                                        Stateslect.where((String option) {
                                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        });
                                    },
                                    onSelected: (String selection) {
                                      setState(() {
                                        dropdownValue4=selection;
                                        //to aasign the controller value
                                      });
                                      debugPrint('You just selected $selection');
                                    },
                                    displayStringForOption: (Value){
                                      return Value;
                                    },
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,right:  width/27.32),
                          child: Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                              controller: City,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                hintText: "",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,right: width/45.53),
                          child: Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                              controller: Pincode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                hintText: "",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7),
                          child: Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                              controller: Mobileno,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                hintText: "Mobile No 1",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,left:width/68.3),
                          child: Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                              controller: Mobileno2,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                hintText: "Mobile No 2",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: width/24.39,top: height/32.85),

                          child: Text("EMail Id",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: width/6.898,top: height/32.85),
                          child: Text("GST Number",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                        ),

                      ],
                    ),

                    Row(
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(left: width/28.458,top: height/82.125,right: width/45.533),
                          child: Container(
                            width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                            child:
                            TextField(
                              controller: Supplieremail,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                border: InputBorder.none,  hintText: "Email",

                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,right: width/27.32,left: width/47.103),
                          child: Container(width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                              controller: Panno,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: GoogleFonts.poppins(fontSize:width/91.06),
                              decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom: 8),
                                hintText: "GSt No",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(top: height/32.85,right:width/ 1.258),
                      child: Text("Remarks",style: GoogleFonts.poppins(fontSize:width/97.57,color: Colors.white),),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(right: width/3.902,top: height/82.125),
                      child: Container(height: height/7.3,
                        width: width/1.70,
                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration( color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(12)),child: TextField(
                          controller: Remarks,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: GoogleFonts.poppins(fontSize:width/91.06),
                          decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3),
                            hintStyle: GoogleFonts.poppins(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: width/20.08,top: height/32.85),
                          child: GestureDetector(
                            onTap: () {
                              showdialpogbox();

                            },
                            child: Container(width:width/8.6,
                              height: height/16.42,
                              //color: Color(0xffD60A0B),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffD60A0B),),child: Center(child: Text("Save Supplier",style:
                              GoogleFonts.poppins(color: Colors.white,fontSize:width/91.06),)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            clearallcontroller();
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: width/75.888,top: height/32.85),
                            child: Container(width: width/13.6,
                              height:  height/16.42,
                              //color: Color(0xffD60A0B),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff00A0E3),),child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                )
            ),
          ),
        );
      },
    );
  }

  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.760,bottom: height/4.760),
        child: SlideInLeft(
          animate: true,
          duration: const Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: const Color(0xff264656),
              content:
              SizedBox(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height: height/32.85,),
                    Text("Add a Supplier Item Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/32.85,),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Supplierfunction();
                            suppiernameaddfunction();
                            clearallcontrollers();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: const Color(0xff25D366),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/9.588,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff25D366),
                              ),
                              child: Center(
                                child: Text(
                                    "Okay",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/85.375, color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width:width/68.3),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: const Color(0xff263646),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height / 16.425,
                              width: width / 9.588,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 85.375,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }

  clearallcontrollers() {
    Suppliercode.clear();
    SupplierAddress.clear();
    State.clear();
    City.clear();
    Pincode.clear();
    Mobileno.clear();
    Mobileno2.clear();
    Panno.clear();
    Openingbalance.clear();
    Remarks.clear();
    Suppliername.clear();
    Supplieremail.clear();
    setState(() {
      dropdownValue1 = 'Numbers(NOS)';
      dropdownValue = 'Please Select Category';
      dropdownValue4 = 'Select State';
      hsncpode="";
      Boxno="";
    });
  }

  Supplierfunction(){
    FirebaseFirestore.instance.collection("Supplier").doc().set({
      "Suppliercode":Suppliercode.text,
      "SupplierAddress":SupplierAddress.text,
      "State":dropdownValue4,
      "City":City.text,
      "Pincode":Pincode.text,
      "Mobileno":Mobileno.text,
      "Mobileno2":Mobileno2.text,
      "Panno":Panno.text,
      "Remarks":Remarks.text,
      "Suppliername":Suppliername.text,
      "Email":Supplieremail.text,
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "Openingbalance":""
    });
  }
  //...................................end supplier functions

  clearallcontroller() {
    setState(() {
      hsncpode="";
      Boxno="";
      vaalue = 0;
      totalamount = 0;
      itemnames="";
      itemcolor='';
    });
    Purchase_price.clear();
    Qty.clear();
    Landing_cost.clear();
    IMEI_No.clear();
    Serial_NO.clear();
    Invoice_NO.clear();
    Loworder.clear();
    Stocks.clear();

    //Based on
    Basedon .clear();
    //itemid
    itemid .clear();
    //item name
    itemname.clear();
    taxitem.clear();
    valueitem.clear();
    Sales.clear();
    Box_NO.clear();
    HSN_Code.clear();
    _typeAheadControllergender.clear();
    suggestionBoxController.close();

  }


  clearallcontroller2(){
    setState(() {
      Payments = "Please Select Type";
      dropdownValue3=list3.first;
    });
    //purchase Date
    //purchase NOtes
    purchase_notes.clear();
    //purchase number
    purchase_No.clear();
    //suppierid
    Creadit_days.clear();
    Reasoncontroller.clear();
    suppierid.clear();
    //suppiler name
    suppiler_name.clear();
    //suppiler invoiceno
    suppiler_invoice .clear();

    rounof.clear();

    setState((){
      Cgst=0;
      sgst=0;
      totalamount=0;
      TotalAmount2=0;
    });

  }

  checkgst(purchase, qty) {
    setState(() {
      valueitem.text = (((double.parse(purchase.toString())) * double.parse(qty)).toString());
    });
  }

  landingcost(landingcost) {
    setState(() {
      Landing_cost.text = ((18/100)*double.parse(landingcost)+double.parse(landingcost)).toStringAsFixed(2);
    });
    if(status2==true){
      Landing_cost.text=landingcost;
    }
  }

  //s Gst
  double sgst=0;

  SGSTfunction() {
    setState(() {
      sgst=0;
    });

    if(status2==true){
      setState(() {
        sgst =salespriceff-(salespriceff/(1.09));
      });
      return sgst;
    }
    else{
      setState(() {
        sgst = (9/100)*totalamount;
      });
      return sgst;
    }
  }






  Totalamounts(){
    setState(() {
      TotalAmount2=0;
    });

    if(status2==true) {

      setState(() {
        TotalAmount2 = totalamount;
        totalamount = totalamount - sgst - Cgst;
      });
    }
    else{
      setState(() {
        TotalAmount2 = totalamount + sgst + Cgst;
      });
    }
    if(TotalAmount2>double.parse(TotalAmount2.round().toString())){
      setState(() {
        rounof.text=(TotalAmount2-double.parse(TotalAmount2.round().toString())).toStringAsFixed(2);
        TotalAmount2=TotalAmount2-(TotalAmount2-double.parse(TotalAmount2.round().toString()));
      });
    }
    else {
      setState(() {
        rounof.text=(double.parse(TotalAmount2.round().toString())-TotalAmount2).toStringAsFixed(2);
        TotalAmount2=TotalAmount2+(double.parse(TotalAmount2.round().toString())-TotalAmount2);
      });
    }



  }


  double TotalAmount2=0;

  totalamountwithroundof(){
    setState(() {
      TotalAmount2=0;
    });
    if(status2==true){
      setState(() {
        TotalAmount2=  (totalamount/1.18)+sgst+Cgst+double.parse(rounof.text);
      });
    }
    else{
      setState(() {
        TotalAmount2=  totalamount+sgst+Cgst+double.parse(rounof.text);
      });
    }
  }


  double testvalue=70.66;

  TextEditingController rounof=TextEditingController();

  testfunction(){

    if(testvalue>double.parse(testvalue.round().toString())){
    }
    else {
    }

  }

  //s Gst
  double Cgst=0;

  double salespriceff = 0;

  CGSTfunction() {
    setState(() {
      Cgst=0;
    });

    if(status2==true) {
      print("CGST FUNCTION +++++++++++++++++++++++++++++");
      print(salespriceff);
      setState(() {
        Cgst =salespriceff-(salespriceff/(1.09));
      });
      print(Cgst);
    }
    else{
      setState(() {
        Cgst = (9 / 100) * totalamount;
      });
      return Cgst;
    }

  }


  String random = "";

  checkbillno() {
    setState(() {
      random = randomAlphaNumeric(16);
    });
    billcounts();
  }

  int reducequvanity=0;
  String Itemcode="";
  String Item="";
  String itemdocuid="";
  double AccountTotalamount=0;


  String itemcode = "dsgdgd";
  String hsncpode = "";
  String Boxno = "";
  String itemcat='';
  String itembrand='';
  String itemimei='';
  String itemserial='';
  String itemcolor='';
  bool serialvalue=false;
  bool imeivalue=false;
  bool color=false;



  createpurchase2(name) async {

    var documents = await FirebaseFirestore.instance.collection("Item").get();
    for (int i = 0; i < documents.docs.length; i++) {
      if (documents.docs[i]["Newitemname"] == name) {
        setState(() {
          itemcode = documents.docs[i]["Itemcode"].toString();
          itemdocuid = documents.docs[i].id.toString();
          hsncpode = documents.docs[i]["HSNCode"].toString();
          itemid.text=documents.docs[i]["Itemcode"].toString();
          itemname.text=documents.docs[i]["Newitemname"].toString();
          itemnames=documents.docs[i]["Newitemname"].toString();
          taxitem.text=documents.docs[i]["gst"].toString();
          Loworder.text=documents.docs[i]["Loworder"].toString();
          Stocks.text=documents.docs[i]["TotalQuvantity"].toString();
          Qty.text="1";
          Purchase_price.text=documents.docs[i]["Purchaseprice"].toString();
          Landing_cost.text=documents.docs[i]["Landingcost"].toString();
          valueitem.text=documents.docs[i]["Purchaseprice"].toString();
          salespriceff=double.parse(documents.docs[i]["Purchaseprice"].toString());
          itemcat=documents.docs[i]["Category"].toString();
          itembrand=documents.docs[i]["Brand"].toString();
          itemimei=documents.docs[i]["IMEI NO"].toString();
          itemserial=documents.docs[i]["Serial NO"].toString();
          itemcolor=documents.docs[i]["Color"].toString();
          Boxno=documents.docs[i]["BoxNo"].toString();
          Box_NO.text=documents.docs[i]["BoxNo"].toString();
          HSN_Code.text = documents.docs[i]["HSNCode"].toString();
          Sales.text = documents.docs[i]["Saleprice"].toString();
          serialvalue=documents.docs[i]["Serial NO"];
          imeivalue=documents.docs[i]["IMEI NO"];
          color=documents.docs[i]["Color"];
        });
      }




    }



    checkgst(Purchase_price.text,Qty.text);

  }

  collectioncreatefunction(){
    FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).
    collection(returnid.toString()).doc().set({
      "Total": totalamount.toStringAsFixed(2),
      "Payment mode":Payments,
      "itemcode":status==true?"G$itemcode":"N$itemcode",
      "Hsncode": HSN_Code.text ,
      "suppilerid":suppierid.text,
      "suppilername":suppiler_name.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "state":dropdownValue4==""?"Tamil Nadu":dropdownValue4,
      "tax":taxitem.text,
      "suppilierinvoiceno":suppiler_invoice.text,
      "time":DateFormat.jm().format(DateTime.now()),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "Category": itemcat,
      "Brand": itembrand,
      "Item": itemname.text,
      "Purchase price": double.parse(Purchase_price.text).toStringAsFixed(2),
      "Sales price": double.parse(Sales.text).toStringAsFixed(2),
      "Qty": Qty.text,
      "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
      "IMEI NO":itemimei,
      "Serial NO":itemserial,
      "Color":itemcolor,
      "credit days":Creadit_days.text,
      // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "Description":"${itemname.text},${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "IMSlist":IMEISERIAL,
    });
  }


String  creaditedatevalue="";


  Purchaseitem()async {
    print("exit-1=================================================");
    setState((){
      reducequvanity=0;
      Itemcode="";
      Item="";
    });
    var documentget=await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).get();
    Map<String,dynamic>?values=documentget.data();
    setState((){
      values!["credit date"]!=""?creaditedatevalue=values["credit date"].toString():"";
    }); print("exit-1===================Credit date check==============================");

    if(creditdate.text!=""){
      setState((){
        Changedate = DateTime(year, month, day).add(Duration(days: int.parse(creditdate.text))).toString();
        creaditupdatedate = DateFormat('d/MM/yyyy').format(DateTime.parse(Changedate));
        formattedDate = DateFormat('d/MM/yyyy').format(DateTime.parse(Changedate));
      });
    }
    print("exit-2");
    /// items stocks update function (for loop)...to selected item to get quantity (Purchase entry collection) and to add the item collections....

    print("exit-3");
    print("Returnlists.length");
    print(Returnlists.length);

    for(int j=0;j<Returnlists.length;j++){
      var document=await FirebaseFirestore.instance.collection("Purchase entry").
      doc(returnid).collection(returnid.toString()).where("itemcode",isEqualTo:Returnlists[j]).get();
      print(document.docs.length);
      for(int k=0;k<document.docs.length;k++){
        var document3=await FirebaseFirestore.instance.collection("Purchase entry").
        doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).get();
        Map<String, dynamic>?values=document3.data();
        setState((){
          reducequvanity=int.parse(values!['Qty'].toString());
          Itemcode=values!['itemcode'].toString();
          Item=values['Item'].toString();
          itemdocuid=values["Itemdocid"].toString();
          AccountTotalamount=double.parse(values["Total"].toString());
        });
      }
    }

      print("documentlists.length");
    print(documentlists.length);

    for(int s=0;s<documentlists.length;s++){
      print("Enter docuemnt length==${s}");

      print(documentlists.length);
      if(reducequvanity>0){

       if(status==true){
         print("Qtydecrease[s]");
         print(Qtydecrease[s]);
         print(s);
         print(IMEI[s]);
         print(SERIAL[s]);
         print(colorlist[s]);
         var documentget = await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).collection(returnid).get();

         for(int a=0;a<documentget.docs.length;a++) {
           print(IMEI[a]);
           print(SERIAL[a]);
           print(colorlist[a]);
           if(Selected[a]==true) {
             print(Qtydecrease[s]);
             FirebaseFirestore.instance.collection("Item ShabikaG").doc(documentlists[s]).update({
               "TotalQuvantity": FieldValue.increment(-Qtydecrease[s]),
               "Imei no": FieldValue.arrayRemove(IMEI[a]),
               "Serial no": FieldValue.arrayRemove(SERIAL[a]),
               "color": FieldValue.arrayRemove(colorlist[a]),
             });
           }
         }
       }

        if(status2==true){
          FirebaseFirestore.instance.collection("Item ShabikaN").doc(documentlists[s]).update({
            "TotalQuvantity":FieldValue.increment(-Qtydecrease[s]),
            "Imei no": FieldValue.arrayRemove(IMEI[s]),
            "Serial no": FieldValue.arrayRemove(SERIAL[s]),
            "color": FieldValue.arrayRemove(colorlist[s]),
          });
        }

      }
    }

    print("exit-4");

    FirebaseFirestore.instance.collection("Accounts").doc("AxQxYGPKUB5qGzllyfpY").update({
      "Totalamount":FieldValue.increment(-AccountTotalamount)
    });

    print("exit-5");
    print(TotalAmount2);




/// check the amount and subtract to the total amount and to create a purchase Histroy collection and to craete a new document....

    print("exit-6");



    print("exit-7");
    if(Totalamountoftopay!=0){
      print("entered the TotalPay");
      print(creaditupdatedate);

    }
    print("exit-8");

    if(status==true&&returnid.isNotEmpty){
      print("exit-8");


      if(Totalamountoftopay>0){

      }






    }

    print("exit-9");

    if(status2==true&&returnid.isNotEmpty){
      print("exit-8");



      if(Totalamountoftopay>0){

      }






    }

    print("exit-10");

    setState((){

    });

  }

  retrninvoice() async {
    print("Retrun invoic e started-------------------------------------");
    print("Retrun invoic e started-------------------------------------");
    print("Retrun invoic e started-------------------------------------");
    var documentget = await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).collection(returnid).get();

    if (status == true) {
      FirebaseFirestore.instance.collection("ReturnG entry").doc(returnid).set(
          {
            "Total": TotalAmount2.toStringAsFixed(2),
            "Payment mode": Payments,
            "Payment mode 2": "",
            "suppilerid": suppierid.text,
            "suppilername": Suppliername.text,
            "suppilergst": suppiler_gstno.text,
            "purchaseno": purchase_No.text,
            "purchasedate": purchase_Date.text,
            "purchasenote": purchase_notes.text,
            "suppilierinvoiceno": suppiler_invoice.text,
            "credit days": Creadit_days.text,
            "credit date":"",
            "balance amount":0,
            "purchaseinvoiceid":[],
            "Reason":"",
            "save": false,
            "return": false,
            "time": DateFormat.jm().format(DateTime.now()),
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch

          }
      );

      for(int i=0;i<documentget.docs.length;i++) {
        print("Retrun invoic e started--------length--------------------${documentget.docs.length}");
        if (Selected[i] == true) {
          print("Retrun invoic e started----------------------------${Selected[i]}");
          print("Retrun invoic e started----------Docid------------------${returnid}");
          FirebaseFirestore.instance.collection("ReturnG entry").doc(returnid)
              .collection(returnid).doc()
              .set({
            "Total": int.parse(_Streamcontroller1[i].text) * double.parse(documentget.docs[i]["Purchase price"].toString()),
            "itemcode": documentget.docs[i]["itemcode"],
            "Hsncode": documentget.docs[i]["Hsncode"],
            "BoxNo": documentget.docs[i]["BoxNo"],
            "return Quvantity": 0,
            "tax": taxitem.text,
            "stocks": _Streamcontroller1[i].text,
            "time": DateFormat.jm().format(DateTime.now()),
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch,
            "Item": documentget.docs[i]["Item"],
            "Purchase price": documentget.docs[i]["Purchase price"],
            "Sales price": documentget.docs[i]["Sales price"],
            "MRP price": documentget.docs[i]["MRP price"],
            "Qty": documentget.docs[i]["Qty"],
            "Landing cost": documentget.docs[i]["Landing cost"],
            "IMEI NO": IMEI[i],
            "Serial NO": SERIAL[i],
            "Color": colorlist[i],
            "Description": documentget.docs[i]["Description"],
            "Imei no": IMEI[i],
            "Serial no": SERIAL[i],
            "color": colorlist[i],
          });
        }
      }
    }
    else if (status2 == true) {
      FirebaseFirestore.instance.collection("ReturnN entry").doc(returnid).set(
          {
            "Total": TotalAmount2.toStringAsFixed(2),
            "Payment mode": Payments,
            "Payment mode 2": "",
            "suppilerid": suppierid.text,
            "suppilername": Suppliername.text,
            "suppilergst": suppiler_gstno.text,
            "purchaseno": purchase_No.text,
            "purchasedate": purchase_Date.text,
            "purchasenote": purchase_notes.text,
            "suppilierinvoiceno": suppiler_invoice.text,
            "credit days": Creadit_days.text,
            "credit date":"",
            "balance amount":0,
            "purchaseinvoiceid":[],
            "Reason":"",
            "save": false,
            "return": false,
            "time": DateFormat.jm().format(DateTime.now()),
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch

          }
      );

      for(int i=0;i<documentget.docs.length;i++) {
        print("Retrun invoic e started--------length--------------------${documentget.docs.length}");
        if (Selected[i] == true) {
          print("Retrun invoic e started----------------------------${Selected[i]}");
          print("Retrun invoic e started----------Docid------------------${returnid}");
          FirebaseFirestore.instance.collection("ReturnN entry").doc(returnid)
              .collection(returnid).doc()
              .set({
            "Total": int.parse(_Streamcontroller1[i].text) * double.parse(documentget.docs[i]["Purchase price"].toString()),
            "itemcode": documentget.docs[i]["itemcode"],
            "Hsncode": documentget.docs[i]["Hsncode"],
            "BoxNo": documentget.docs[i]["BoxNo"],
            "return Quvantity": 0,
            "tax": taxitem.text,
            "stocks": _Streamcontroller1[i].text,
            "time": DateFormat.jm().format(DateTime.now()),
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch,
            "Item": documentget.docs[i]["Item"],
            "Purchase price": documentget.docs[i]["Purchase price"],
            "Sales price": documentget.docs[i]["Sales price"],
            "MRP price": documentget.docs[i]["MRP price"],
            "Qty": documentget.docs[i]["Qty"],
            "Landing cost": documentget.docs[i]["Landing cost"],
            "IMEI NO": IMEI[i],
            "Serial NO": SERIAL[i],
            "Color": colorlist[i],
            "Description": documentget.docs[i]["Description"],
            "Imei no": IMEI[i],
            "Serial no": SERIAL[i],
            "color": colorlist[i],
          });
        }
      }
    }
    FirebaseFirestore.instance.collection("Return entry").doc(returnid).set(
        {
          "Total": TotalAmount2.toStringAsFixed(2),
          "Payment mode": Payments,
          "Payment mode 2": "",
          "suppilerid": suppierid.text,
          "suppilername": Suppliername.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "credit days": Creadit_days.text,
          "credit date":"",
          "balance amount":0,
          "purchaseinvoiceid":[],
          "Reason":"",
          "save": false,
          "return": false,
          "time": DateFormat.jm().format(DateTime.now()),
          "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch

        }
    );

    for(int i=0;i<documentget.docs.length;i++) {
      print("Retrun invoic e started--------length--------------------${documentget.docs.length}");
      if (Selected[i] == true) {
        print("Retrun invoic e started----------------------------${Selected[i]}");
        print("Retrun invoic e started----------Docid------------------${returnid}");
        FirebaseFirestore.instance.collection("Return entry").doc(returnid)
            .collection(returnid).doc()
            .set({
          "Total": int.parse(_Streamcontroller1[i].text) * double.parse(documentget.docs[i]["Purchase price"].toString()),
          "itemcode": documentget.docs[i]["itemcode"],
          "Hsncode": documentget.docs[i]["Hsncode"],
          "BoxNo": documentget.docs[i]["BoxNo"],
          "return Quvantity": 0,
          "tax": taxitem.text,
          "stocks": _Streamcontroller1[i].text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Item": documentget.docs[i]["Item"],
          "Purchase price": documentget.docs[i]["Purchase price"],
          "Sales price": documentget.docs[i]["Sales price"],
          "MRP price": documentget.docs[i]["MRP price"],
          "Qty": documentget.docs[i]["Qty"],
          "Landing cost": documentget.docs[i]["Landing cost"],
          "IMEI NO": IMEI[i],
          "Serial NO": SERIAL[i],
          "Color": colorlist[i],
          "Description": documentget.docs[i]["Description"],
          "Imei no": IMEI[i],
          "Serial no": SERIAL[i],
          "color": colorlist[i],
        });
      }
    }
  }

  List Destription=[];
  List Quvantity=[];
  List Totalamount=[];
  List Tax=[];
  List Items=[];
  List Rate=[];
  List HSNcode=[];

  double totalamount = 0;

  edittoltalamount() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance
        .collection("Purchase entry").doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }

    CGSTfunction();

    SGSTfunction();

    Totalamounts();
  }

  updatetotal() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance
        .collection("Purchase entry").doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }

    CGSTfunction();

    SGSTfunction();

    Totalamounts();

    setState((){});



  }

  int billcount=0;

  NumberFormat Fotmaterr=NumberFormat('000');

  billcounts()async{
    if(status==true){
      var docus1=await  FirebaseFirestore.instance.collection("Purchase ShabikaG").get();
      setState(() {
        billcount = docus1.docs.length+1;
        purchase_No.text = "SBG${(billcount).toString().padLeft(2,"0")}";
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    }
    if(status2==true){
      var docus2=await  FirebaseFirestore.instance.collection("Purchase ShabikaN").get();

      setState(() {
        billcount = docus2.docs.length+1;
        purchase_No.text = "SBN${(billcount).toString().padLeft(2,"0")}";
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    }


  }

  String delteqty='0';
  String deltecode='0';
  String deltedocid='0';

  deletecollection(id)async {

   var documents=await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).
   collection(returnid.toString()).doc(id).get();
    Map<String,dynamic>?value=documents.data();
    setState((){
      delteqty=value!['Qty'];
      deltecode=value['Item'];
    });
    var documents2=await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<documents2.docs.length;i++){
      if(deltecode==documents2.docs[i]['Newitemname']){
        FirebaseFirestore.instance.collection("Item").doc(documents2.docs[i].id).update({
          "TotalQuvantity":FieldValue.increment(-int.parse(delteqty)),
        });
        FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).collection(returnid.toString()).doc(id).delete();
        updatetotal();
        FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(returnid).collection(returnid.toString()).doc(id).delete();
        FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(returnid).collection(returnid.toString()).doc(id).delete();
      }
    }



  }

  String Payment_Mode="";
  String Suppiler_Id="";
  String Suppiler_name="";
  String Suppiler_invoiceno="";
  String Suppiler_date="";
  String Bill_no="";
  String Bill_total="";
  String Bill_Time="";
  String Shipped_to="";
  String Billed_to="";


  clearlistandname(){
    setState(() {
      Destription.clear();
      Quvantity.clear();
      Totalamount.clear();
      Tax.clear();
      Items.clear();
      Rate.clear();
      HSNcode.clear();
      Payment_Mode="";
      Suppiler_Id="";
      Suppiler_name="";
      Suppiler_invoiceno="";
      Suppiler_date="";
      Bill_no="";
      Bill_total="";
      Bill_Time="";
      Shipped_to="";
      Billed_to="";
      Sales.clear();
    });

  }

  checkvalue()async{
    var document = await FirebaseFirestore.instance.collection("Purchase entry").doc(returnid).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      Bill_Time=DateFormat.jm().format(DateTime.now());
      Bill_total=value!['Total'].toString();
      Bill_no=value['purchaseno'].toString();
      Suppiler_name=value['suppilername'].toString();
      Suppiler_Id=value['suppilerid'].toString();
      Suppiler_invoiceno=value['suppilierinvoiceno'].toString();
      Payment_Mode=value['Payment mode'].toString();
      Suppiler_date=value['purchasedate'].toString();


    });



  }

  //empty function
  empty(){}

  //textfield popup genrate function(Listview Builder)


  List IMEISERIAL=[];

  List<List> IMEI=List.generate(50, (index) => []);
  List SERIAL=List.generate(50, (index) => []);
  List colorlist=List.generate(50, (index) => []);

  bool popupLoading=false;

  updatetotalquvantity(quvantity){

    FirebaseFirestore.instance.collection('Item').doc(itemdocuid).update({
      "TotalQuvantity":FieldValue.increment((double.parse(quvantity))),
      "Purchaseprice": double.parse(Purchase_price.text).toStringAsFixed(2),
      "Landingcost": double.parse(Landing_cost.text).toStringAsFixed(2),
      "Saleprice": double.parse(Sales.text).toStringAsFixed(2),
      "BoxNo": Box_NO.text,
    });
  }

  //showdialogbox..
  alreadyexistshowdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/5.760,bottom: height/5.760),
        child: SlideInLeft(
          animate: true,
          duration: const Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: const Color(0xff264656),
              content:
              SizedBox(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height: height/32.85,),
                    Text("This Customer Already Exist in List.....",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/32.85,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          customervalid=false;
                        });
                        Navigator.pop(context);
                      },
                      child: Material(
                        elevation: 15,
                        color: const Color(0xff25D366),
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height/16.425,
                          width: width/7.588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff25D366),
                          ),
                          child: Center(
                            child: Text(
                                "Okay",
                                style: GoogleFonts.poppins(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/85.375, color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }



  showtextfield(Quvantity,serial,imei,color,index){

    setState(() {
      IMEISERIAL.clear();
      IMEI[index].clear();
      SERIAL.clear();
      colorlist.clear();
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<TextEditingController> _controller = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 = List.generate(Quvantity, (index) => TextEditingController());

    return showDialog(context: context, builder:(context) {

      return
        Padding(
            padding:  EdgeInsets.only(left: width/136.66,right: width/136.66,
                top: height/6.57,bottom: height/6.57),
            child:
            Scaffold(
              body:  Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height:height/1.194,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height:height/ 131.4,),

                          Text("Add IMEI No/SERIAL No/Color/Image",style: GoogleFonts.
                          montserrat(fontWeight:FontWeight.w700),),

                          SizedBox(height: height/ 131.4,),

                          SizedBox(
                            height:380,
                            child:
                            ListView.builder(
                              itemCount: Quvantity,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:  EdgeInsets.only(left: width/4.55),
                                  child:
                                SizedBox(

                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        imei==true?
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/341.5,
                                              vertical: height/164.25
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width:width/11.38,
                                                  child: Text("IMEi No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),
                                              SizedBox(width:width/136.6),
                                              Material(
                                                  color: Colors.white,
                                                  elevation: 20,
                                                  shadowColor: Colors.black12,
                                                  child: Container(
                                                    height:height/16.425,
                                                    width:width/4.55,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: Colors.grey.shade200
                                                    ),
                                                    child: TextField(
                                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                      controller: _controller[index],
                                                      decoration: InputDecoration(
                                                        hintText: "Enter the IMEI NO",
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(left:width/136.6),
                                                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                      ),
                                                      onSubmitted: (_){

                                                      },
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ):const SizedBox(),

                                        serial==true?
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/341.5,
                                              vertical: height/164.25
                                          ),
                                          child: Row(
                                            children: [

                                              SizedBox(
                                                  width:width/11.38,
                                                  child: Text("Serial No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),

                                              SizedBox(width:width/136.6),

                                              Material(
                                                  color: Colors.white,
                                                  elevation: 20,
                                                  shadowColor: Colors.black12,
                                                  child: Container(
                                                      height:height/16.425,
                                                      width:width/4.55,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.grey.shade200
                                                      ),
                                                      child:TextField(
                                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        controller: _controller2[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Enter the Serial NO",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle:  GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        ),
                                                        onSubmitted: (_){

                                                        },
                                                      )
                                                  )),
                                            ],
                                          ),
                                        ):const SizedBox(),

                                        color==true?
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/341.5,
                                              vertical: height/164.25
                                          ),
                                          child: Row(
                                            children: [

                                              SizedBox(
                                                  width:width/11.38,
                                                  child: Text("Color",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),)),

                                              SizedBox(width:width/136.6),

                                              Material(
                                                  color: Colors.white,
                                                  elevation: 20,
                                                  shadowColor: Colors.black12,
                                                  child: Container(
                                                      height:height/16.425,
                                                      width:width/4.55,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.grey.shade200
                                                      ),
                                                      child:TextField(
                                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        controller: _controller3[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Color",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle:   GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        ),
                                                        onSubmitted: (_){

                                                        },
                                                      )
                                                  )),
                                            ],
                                          ),
                                        ):const SizedBox(),

                                      ],
                                    ),
                                  ),
                                );
                              },),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    popupLoading=true;
                                  });

                                  for(int i=0;i<Quvantity;i++){
                                    setState(() {
                                      IMEISERIAL.add("${_controller[i].text}${_controller2[i].text}${_controller3[i].text}");
                                      IMEI[index].add(_controller[i].text);
                                      SERIAL[index].add(_controller2[i].text);
                                      colorlist[index].add(_controller3[i].text);
                                    });
                                  }

                                  collectioncreatefunction();

                                  updatetotal();

                                  Future.delayed(const Duration(milliseconds: 1500),(){
                                    setState(() {
                                      popupLoading=false;
                                    });
                                    Navigator.pop(context);
                                    //clear the controller
                                    _controller.clear();
                                    _controller2.clear();
                                  });
                                },
                                child: Material(
                                  elevation: 15,
                                  color: const Color(0xff25D366),
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/16.425,
                                    width: width/7.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff25D366),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "Okay",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width/85.375, color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width:width/136.6),
                              InkWell(
                                onTap:(){
                                  Navigator.pop(context);

                                },
                                child: Material(
                                  elevation: 15,
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/16.425,
                                    width: width/7.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff263646),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "Cancel",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width/85.375, color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  popupLoading==true?const CircularProgressIndicator():const SizedBox()
                ],
              ),));

    },);

  }


  List ImerisrialListitem=List.generate(50, (index) => [""]);
  List ImerisrialListitem1=List.generate(50, (index) => [""]);
  List ImerisrialListitem2=List.generate(50, (index) => [""]);


  SuggestionsBoxController suggestionBoxController1 = SuggestionsBoxController();

  List<String> getSuggestionsgender1(String query,index) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem[index]);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  SuggestionsBoxController suggestionBoxController2 = SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query,index) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem1[index]);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  SuggestionsBoxController suggestionBoxController3 = SuggestionsBoxController();

  List<String> getSuggestionsgender3(String query,index) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem2[index]);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> Addlist=[];

  showstocksupdate(Quvantity,serial,imei,color, imeilist,seriallist, colorlistvalue,documentid,purchaseprice,indexm){
    print("Check-enter popup");
  setState((){
  IMEISERIAL.clear();
  IMEI[indexm].clear();
  SERIAL[indexm].clear();
  colorlist[indexm].clear();
  Addlist.clear();
  });
  print(imei);
  print(color);
  print(serial);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<TextEditingController> _controller = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 = List.generate(Quvantity, (index) => TextEditingController());


    return showDialog(context: context, builder:(context) {

      return
        Padding(
            padding:  EdgeInsets.only(left: width/136.66,right: width/136.66,
                top: height/6.57,bottom: height/6.57),
            child:
            Scaffold(
              body:  Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height:height/1.194,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height:height/ 131.4,),

                          Text("Add IMEI No/SERIAL No/Color/Image",style: GoogleFonts.
                          montserrat(fontWeight:FontWeight.w700),),

                          SizedBox(height: height/ 131.4,),

                          SizedBox(
                            height:380,
                            child:
                            ListView.builder(
                              itemCount: Quvantity,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: width / 4.55),
                                    child: SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          imei == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical:
                                                height / 164.25),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width: width / 11.38,
                                                    child: Text(
                                                      "IMEi No",
                                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                    )),
                                                SizedBox(
                                                    width: width / 136.6),
                                                Material(
                                                    color: Colors.white,
                                                    elevation: 20,
                                                    shadowColor:
                                                    Colors.black12,
                                                    child: Container(
                                                      height:
                                                      height / 16.425,
                                                      width: width / 4.55,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          color: Colors
                                                              .grey
                                                              .shade200),
                                                      child:
                                                      TypeAheadFormField(

                                                        suggestionsBoxDecoration:
                                                        const SuggestionsBoxDecoration(

                                                            color: Color(
                                                                0xffDDDEEE),
                                                            borderRadius:
                                                            BorderRadius
                                                                .only(
                                                              bottomLeft:
                                                              Radius.circular(5),
                                                              bottomRight:
                                                              Radius.circular(5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width / 91.06),
                                                          decoration:
                                                          InputDecoration(
                                                            contentPadding: EdgeInsets.only(left: width / 136.6, bottom: 8),
                                                            border:
                                                            InputBorder
                                                                .none,
                                                          ),
                                                          controller: _controller[index],
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return getSuggestionsgender1(pattern,indexm);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion, style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                                maxLines:
                                                                null),
                                                          );
                                                        },
                                                        transitionBuilder:
                                                            (context,
                                                            suggestionsBox,
                                                            controller) {
                                                          return suggestionsBox;
                                                        },
                                                        onSuggestionSelected: (String suggestion) {
                                                          setState(() {
                                                             _controller[index].text = suggestion;
                                                             ImerisrialListitem[indexm].remove(_controller[index].text);
                                                            print(_controller[index].text);
                                                             print("Imei Removed=====================================");
                                                             print("${ImerisrialListitem}=====================================");
                                                             print("${ImerisrialListitem[index]}=====================================");

                                                          });
                                                        },
                                                        suggestionsBoxController: suggestionBoxController1,
                                                        validator: (value) => value!.isEmpty
                                                            ? 'Please select a  value'
                                                            : null,
                                                        onSaved: (value) {
                                                          setState(() {
                                                            print("Imei Removed222222=====================================");
                                                            _controller[index].text = value!;
                                                          });
                                                        },
                                                      ),


                                                    )),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          serial == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical:
                                                height / 164.25),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width: width / 11.38,
                                                    child: Text(
                                                      "Serial No",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700),
                                                    )),
                                                SizedBox(
                                                    width: width / 136.6),
                                                Material(
                                                    color: Colors.white,
                                                    elevation: 20,
                                                    shadowColor:
                                                    Colors.black12,
                                                    child: Container(
                                                      height:
                                                      height / 16.425,
                                                      width: width / 4.55,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          color: Colors
                                                              .grey
                                                              .shade200),
                                                      child:
                                                      TypeAheadFormField(
                                                        suggestionsBoxDecoration:
                                                        const SuggestionsBoxDecoration(
                                                            color: Color(
                                                                0xffDDDEEE),
                                                            borderRadius:
                                                            BorderRadius
                                                                .only(
                                                              bottomLeft:
                                                              Radius.circular(5),
                                                              bottomRight:
                                                              Radius.circular(5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize:
                                                              width /
                                                                  91.06 ,fontWeight: FontWeight.w700),
                                                          decoration:
                                                          InputDecoration(
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                left: width /
                                                                    136.6,
                                                                bottom:
                                                                8),
                                                            border:
                                                            InputBorder
                                                                .none,
                                                          ),
                                                          controller:
                                                          _controller2[
                                                          index],
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return getSuggestionsgender2(pattern,indexm);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion, style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                                maxLines:
                                                                null),
                                                          );
                                                        },
                                                        transitionBuilder:
                                                            (context,
                                                            suggestionsBox,
                                                            controller) {
                                                          return suggestionsBox;
                                                        },
                                                        onSuggestionSelected:
                                                            (String
                                                        suggestion) {
                                                          setState(() {
                                                            _controller2[index].text = suggestion;
                                                            ImerisrialListitem1[indexm].remove(_controller2[index].text);

                                                          });
                                                        },
                                                        suggestionsBoxController:
                                                        suggestionBoxController2,
                                                        validator: (value) =>
                                                        value!.isEmpty
                                                            ? 'Please select a academic year'
                                                            : null,
                                                        onSaved: (value) {
                                                          setState(() {
                                                            _controller2[
                                                            index]
                                                                .text = value!;
                                                          });
                                                        },
                                                      ),

                                                    )),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          color == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical:
                                                height / 164.25),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width: width / 11.38,
                                                    child: Text(
                                                      "Color",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700),
                                                    )),
                                                SizedBox(
                                                    width: width / 136.6),
                                                Material(
                                                    color: Colors.white,
                                                    elevation: 20,
                                                    shadowColor:
                                                    Colors.black12,
                                                    child: Container(
                                                      height:
                                                      height / 16.425,
                                                      width: width / 4.55,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          color: Colors
                                                              .grey
                                                              .shade200),
                                                      child:
                                                      TypeAheadFormField(
                                                        suggestionsBoxDecoration:
                                                        const SuggestionsBoxDecoration(
                                                            color: Color(
                                                                0xffDDDEEE),
                                                            borderRadius:
                                                            BorderRadius
                                                                .only(
                                                              bottomLeft:
                                                              Radius.circular(5),
                                                              bottomRight:
                                                              Radius.circular(5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize:
                                                              width /
                                                                  91.06,fontWeight: FontWeight.w700),
                                                          decoration:
                                                          InputDecoration(
                                                            contentPadding:
                                                            EdgeInsets.only(
                                                                left: width /
                                                                    136.6,
                                                                bottom:
                                                                8),
                                                            border:
                                                            InputBorder
                                                                .none,
                                                          ),
                                                          controller:
                                                          _controller3[
                                                          index],
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return getSuggestionsgender3(
                                                              pattern,indexm);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion, style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                                maxLines:
                                                                null),
                                                          );
                                                        },
                                                        transitionBuilder:
                                                            (context,
                                                            suggestionsBox,
                                                            controller) {
                                                          return suggestionsBox;
                                                        },
                                                        onSuggestionSelected: (String suggestion) {
                                                          setState(() {
                                                            _controller3[index].text = suggestion;
                                                            ImerisrialListitem2[indexm].remove(_controller3[index].text);

                                                          });
                                                        },
                                                        suggestionsBoxController:
                                                        suggestionBoxController3,
                                                        validator: (value) =>
                                                        value!.isEmpty
                                                            ? 'Please select a academic year'
                                                            : null,
                                                        onSaved: (value) {
                                                          setState(() {
                                                            _controller3[
                                                            index]
                                                                .text = value!;
                                                          });
                                                        },
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  );
                              },),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    popupLoading=true;
                                  });
                                  for(int i=0;i<Quvantity;i++){
                                    setState(() {
                                      IMEISERIAL.add("${_controller[i].text}${_controller2[i].text}${_controller3[i].text}");
                                      Addlist.add("${_controller[i].text}${_controller2[i].text}${_controller3[i].text}");
                                    });
                                    if(imei == true){
                                      setState((){
                                        IMEI[indexm].add(_controller[i].text);
                                      });
                                    }

                                    if(serial == true){
                                      setState((){
                                        SERIAL[indexm].add(_controller2[i].text);
                                      });
                                    }

                                    if(color == true){
                                      setState((){
                                        colorlist[indexm].add(_controller3[i].text);
                                      });
                                    }

                                  }
                                  print("okkkkkkkkkkkkkkkkkkkkkkk---------------------------------------");
                                  streambalnaceamount();

                                  Future.delayed(const Duration(milliseconds: 1500),(){
                                    print("Shp-9");
                                    ///total bill amount calculation function(Balance amount)
                                    print("Show poup-10");
                                    setState(() {
                                      popupLoading=false;
                                    });

                                    ///muyltiplication function
                                    totalamountmultiplefunction(Quvantity,purchaseprice);


                                    Navigator.pop(context);

                                    //clear the controller
                                    _controller.clear();
                                    _controller2.clear();

                                  });
                                },
                                child: Material(
                                  elevation: 15,
                                  color: const Color(0xff25D366),
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/16.425,
                                    width: width/7.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff25D366),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "Okay",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width/85.375, color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width:width/136.6),
                              InkWell(
                                onTap:(){
                                  Navigator.pop(context);

                                },
                                child: Material(
                                  elevation: 15,
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/16.425,
                                    width: width/7.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff263646),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "Cancel",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width/85.375, color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  popupLoading==true?const CircularProgressIndicator():const SizedBox()
                ],
              ),));

    },);

  }


  getvalue(Suppilerid,Suppilername,Tax,Suppilerinvoice,purchaseno,purchasedate,payment)  async {
    setState(() {
      Billed_to =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Shipped_to =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Bill_Time=DateFormat.jm().format(DateTime.now());
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<p.Widget> widgets = [];

    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: const p.EdgeInsets.only(top: 5),
            child:  p.Row(
                mainAxisAlignment: p.MainAxisAlignment.start,
                children: [
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("SNO".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 80,
                      child: p.Center(
                        child: p.Text("Descriptions".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("HSN/SAC".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Qty".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Rate".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Gst".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Total".toString(),
                            style: const p.TextStyle(color: PdfColors.black)),
                      ))
                ]),
          )),
    );
    //widgets.add(container);

    widgets.add(p.SizedBox(height: 5));

    widgets.add(
        p.Stack(
            children: [

              /*p.Container(
          height: 700,
          child: p.Image(await imageFromAssetBundle('assets/7728804.png'),
              fit: p.BoxFit.fill)),*/

              /*p.Padding(
          padding: p.EdgeInsets.only(top: 260),
     child: container,
        ),*/
              p.Padding(
                  padding: const p.EdgeInsets.only(top: 90),
                  child:
                  p.Container(
                      height: 600,
                      child: p.Column(
                          children: [
                            p.Row(
                                mainAxisAlignment: p.MainAxisAlignment.start,
                                children: [
                                  p.Container(
                                      child: p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                          children: [
                                            /* p.Row(
                                              children: [
                                                p.Container(
                                                  child: p.Center(
                                                    child:  p.Text("Customer Name :",style: p.TextStyle(color: PdfColors.black)),
                                                  ),
                                                  width:110,
                                                  height: 20,
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child:p.Center(
                                                      child:  p.Text(Customer_name.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),*/
                                            p.SizedBox(height: 5),
                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler ID:",
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerid,
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      )),

                                                ]),
                                            p.SizedBox(height: 5),
                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler Name:",
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilername,
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      ))
                                                ]
                                            ),

                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Date :",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(purchasedate,
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),

                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Billed To :",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Billed_to,
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                          ])),

                                  p.SizedBox(width: width/273.2),

                                  p.Container(
                                      child: p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                          children: [
                                            p.Row(crossAxisAlignment: p.CrossAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                      width: 120,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler Invoice No :",
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerinvoice,
                                                            style: const p.TextStyle(color: PdfColors.black)),
                                                      ))
                                                ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Payment Type:",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(payment,
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Time :",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                width: 140,
                                                height: 20,
                                                child: p.Center(
                                                    child: p.Text(Bill_Time,
                                                        style: const p.TextStyle(color: PdfColors.black))),
                                              )
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Shipped To :",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Shipped_to.toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                          ])),
                                ]),

                            p.SizedBox(height: 5),

                            container,

                            p.SizedBox(height: 5),

                            p.Container(
                              child: p.ListView.builder(
                                itemCount: Destription.length,
                                itemBuilder: (context, index) {
                                  return
                                    p.Container(
                                        child: p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.start,
                                            children: [
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text("${index+1}",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 80,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Destription[index].toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(HSNcode[index].toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Quvantity[index].toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Rate[index].toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text("18%",
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Totalamount[index].toString(),
                                                        style: const p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ])
                                    );
                                },
                              ),
                            ),
                            p.Padding(
                                padding: p.EdgeInsets.only(left: width/136.6, right: 10, top: 200),
                                child: p.Divider(color: PdfColors.black, thickness: 0.8)),
                            p.Padding(
                                padding: p.EdgeInsets.only(left: width/136.6, right: 10, top: 210),
                                child: p.Row(
                                    mainAxisAlignment: p.MainAxisAlignment.end,
                                    children: [
                                      p.Container(
                                        width: 50,
                                        child: p.Text("Total :",
                                            style: const p.TextStyle(color: PdfColors.black)),
                                      ),
                                      p.SizedBox(width: 10),
                                      p.Container(
                                        width: width/13.66,
                                        child: p.Text(totalamount.toString(),
                                            style: const p.TextStyle(color: PdfColors.black)),
                                      )
                                    ]))
                          ])
                  )),

            ]));

    final pdf = p.Document();
    pdf.addPage(
      p.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Streamcontrollerclear(){
    for (var controllerList in [
      _Streamcontroller1,

    ]) {
      for (var controller in controllerList) {
        controller.clear();
      }
    }


    balancepay.clear();
    creditdate.clear();
    Payment_detatils_Date.clear();
    Payment_detatils_Time.clear();
    setState(() {
      balanceamount = 0;
      Payments = Paymentmode.first;
    });
  }
  printdate(streamid) async {
    print("Pay now called");
    print(streamid);



    print("Pay now work started");
    print("Total AMount");
    print(TotalAmount2);

    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .update({
      "credit days": "",
      "credit date": "",
      "balance amount": FieldValue.increment(-TotalAmount2),
    });
    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .collection("Payment Histroy")
        .doc()
        .set({
      "credit days": "",
      "credit date": "",
      "balance amount": FieldValue.increment(-TotalAmount2),
      "Amount": TotalAmount2,
      "Date": "${DateTime.now().day}/${DateTime.now().hour}/${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}",
      "payment mode": "Return",
      "discount": "",
      "timstamp": DateTime.now().millisecondsSinceEpoch,
    });
    if (status == true) {
      FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .doc(streamid)
          .update({
        "credit days": "",
        "credit date": "",
        "balance amount": FieldValue.increment(-TotalAmount2),
      });

      FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .doc(streamid)
          .collection("Payment Histroy")
          .doc()
          .set({
        "credit days": "",
        "credit date": "",
        "balance amount": FieldValue.increment(-TotalAmount2),
        "Amount": TotalAmount2,
        "Date": "${DateTime.now().day}/${DateTime.now().hour}/${DateTime.now().year}",
        "time": "${DateTime.now().hour}:${DateTime.now().minute}",
        "payment mode": "Return",
        "discount": "",
        "timstamp": DateTime.now().millisecondsSinceEpoch,
      });
    }
    if (status2 == true) {
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .update({
        "credit days": "",
        "credit date": "",
        "balance amount": FieldValue.increment(-TotalAmount2),
      });
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .collection("Payment Histroy")
          .doc()
          .set({
        "credit days": "",
        "credit date": "",
        "balance amount": FieldValue.increment(-TotalAmount2),
        "Amount": TotalAmount2,
        "Date": "${DateTime.now().day}/${DateTime.now().hour}/${DateTime.now().year}",
        "time": "${DateTime.now().hour}:${DateTime.now().minute}",
        "payment mode": "Return",
        "discount": "",
        "timstamp": DateTime.now().millisecondsSinceEpoch,
      });
    }


    print("POP");

  }



  ///update save poup



  TextEditingController balancepay = TextEditingController();
  TextEditingController creditdate = TextEditingController();
  TextEditingController Payment_detatils_Date = TextEditingController();
  TextEditingController Payment_detatils_Time = TextEditingController();
  TextEditingController Discountbalnce = TextEditingController();
  double balanceamount = 0;
  double Payedamount = 0;

  String Changedate = "";

  String creaditupdatedate = "";
  String formattedDate = '';
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  ///stream controller


  savedatefunction()async{
    print("savedatefunction");
    print(returnid);
    var document=await FirebaseFirestore.instance.collection("Purchase entry").
    doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
    print("Length of k : ${document.docs.length}");
    for(int k=0;k<document.docs.length;k++){
      print("savedatefunction2");
      if((int.parse(document.docs[k]["Qty"].toString())-(((int.parse(document.docs[k]["Qty"].toString()))-document.docs[k]['stocks'])))!=0)
      {
        print("savedatefunction");
        if(Selected[k]==true){
          print("Qtydecrease List");
          print(Qtydecrease);

          ///imei number true
          print("Show poup-1");
          if(document.docs[k]['IMEI NO']==true){
            FirebaseFirestore.instance.collection("Purchase entry").
            doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
              "stocks":FieldValue.increment(-Qtydecrease[k]),
              "Imei no":ImerisrialListitem[k],
              "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              "returnimei":Addlist
            });
          }

          ///serial  number true
          else if(document.docs[k]['Serial NO']==true){
            FirebaseFirestore.instance.collection("Purchase entry").
            doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
              "stocks":FieldValue.increment(-Qtydecrease[k]),
              "Serial no":ImerisrialListitem1[k],
              "returnserial":Addlist,
              "return Quvantity":FieldValue.increment(Qtydecrease[k]),
            });

          }

          ///Color true
          else  if(document.docs[k]['Color']==true){
            FirebaseFirestore.instance.collection("Purchase entry").
            doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
              "stocks":FieldValue.increment(-Qtydecrease[k]),
              "color":ImerisrialListitem2[k],
              "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              "returncolor":Addlist
            });

          }

          else{
            FirebaseFirestore.instance.collection("Purchase entry").
            doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
              "stocks":FieldValue.increment(-Qtydecrease[k]),
              "return Quvantity":FieldValue.increment(Qtydecrease[k]),
            });
          }


        }
      }
    }
    print("Status of status${status} --*************************************************");
    if(status==true){
      print("Shabika G Started --*************************************************");
      print("${returnid}--*************************************************");

      var document=await FirebaseFirestore.instance.collection("Purchase ShabikaG").
      doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
      print("YES 00000001--*************************************************");
      print("${document.docs.length}--*************************************************");
      for(int k=0;k<document.docs.length;k++){
        if((int.parse(document.docs[k]["Qty"].toString())-(((int.parse(document.docs[k]["Qty"].toString()))-document.docs[k]['stocks'])))!=0)
        {
          print("YES 00000002--*************************************************");
          if(Selected[k]==true){

            print("Qtydecrease List");
            print(Qtydecrease);

            ///imei number true
            print("Show poup-1");
            if(document.docs[k]['IMEI NO']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "Imei no":ImerisrialListitem[k],
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
                "returnimei":Addlist
              });
            }

            ///serial  number true
            else if(document.docs[k]['Serial NO']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "Serial no":ImerisrialListitem1[k],
                "returnserial":Addlist,
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              });

            }

            ///Color true
            else  if(document.docs[k]['Color']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "color":ImerisrialListitem2[k],
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
                "returncolor":Addlist
              });

            }

            else{
              FirebaseFirestore.instance.collection("Purchase ShabikaG").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              });
            }


          }
        }
      }
    }
    else{
      var document=await FirebaseFirestore.instance.collection("Purchase ShabikaN").
      doc(returnid).collection(returnid.toString()).orderBy("timestamp").get();
      for(int k=0;k<document.docs.length;k++){
        if((int.parse(document.docs[k]["Qty"].toString())-(((int.parse(document.docs[k]["Qty"].toString()))-document.docs[k]['stocks'])))!=0)
        {
          if(Selected[k]==true){

            print("Qtydecrease List");
            print(Qtydecrease);

            ///imei number true
            print("Show poup-1");
            if(document.docs[k]['IMEI NO']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "Imei no":ImerisrialListitem[k],
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
                "returnimei":Addlist
              });
            }

            ///serial  number true
            else if(document.docs[k]['Serial NO']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "Serial no":ImerisrialListitem1[k],
                "returnserial":Addlist,
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              });

            }

            ///Color true
            else  if(document.docs[k]['Color']==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "color":ImerisrialListitem2[k],
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
                "returncolor":Addlist
              });

            }

            else{
              FirebaseFirestore.instance.collection("Purchase ShabikaN").
              doc(returnid).collection(returnid.toString()).doc(document.docs[k].id).update({
                "stocks":FieldValue.increment(-Qtydecrease[k]),
                "return Quvantity":FieldValue.increment(Qtydecrease[k]),
              });
            }


          }
        }
      }

    }
  }


}
