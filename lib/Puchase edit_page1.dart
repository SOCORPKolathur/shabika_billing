
import 'dart:html';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Credit Amount"
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



class EditPage1_purchase extends StatefulWidget {
  String?docid;

  EditPage1_purchase(this.docid);

  @override
  State<EditPage1_purchase> createState() => _EditPage1_purchaseState();
}


class _EditPage1_purchaseState extends State<EditPage1_purchase> {


  //categrory item variables and controller
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = "";
  String Payments = Payment.first;
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



  DateTime creditdate= DateTime.now();


  @override
  void initState() {
    suppiernameaddfunction();
    //checkbillno();
    itemaddfunction();
    print("jnbnbinin");
    getvalues();
    edittoltalamount();

    // TODO: implement initState
    super.initState();
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


  getvalues()async{
    var document=await FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).get();
    Map<String,dynamic>?values=document.data();
    setState((){
      Payments=values!['Payment mode'];
      sgst=values['Total'].toString() !=""||values['Total'].toString() !=" "?double.parse(values['Total'].toString()) : 0;
      Creadit_days.text=values['credit days'];
      purchase_Date.text=values['date'];
      purchase_No.text=values['purchaseno'];
      purchase_notes.text=values['purchasenote'];
      suppiler_invoice.text=values['suppilierinvoiceno'];
      suppierid.text=values['suppilerid'];
      suppiler_name.text=values['suppilername'];
      suppiler_gstno.text=values['suppilergst'];
      //taxitem.text=values['tax'];
      Cgst=double.parse(values['CGST'].toString());
      sgst=double.parse(values['SGST'].toString());
      print("Shabika ++++++++++++++++A+++++++");
      if(values['type'] =="ShabikaG"){
        status= true;
        status2=false;
      }
      else{
        status2=true;
        status=false;
      }

      print("Shabika +++++++++++++++++++++++");
      print(status);
      print(status2);
    });
    var getdata= await FirebaseFirestore.instance.collection("Purchase entry").
    doc(widget.docid).collection(widget.docid.toString()).get();

    for(int i=0;i<getdata.docs.length;i++){
      setState((){
        colorlist=getdata.docs[i]['color'];
        IMEI=getdata.docs[i]['Imei no'];
        SERIAL=getdata.docs[i]['Serial no'];
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

  double totalamount = 0;

  edittoltalamount() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance
        .collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }

    CGSTfunction();

    SGSTfunction();

    Totalamounts();
  }

  bool image = false;

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
  TextEditingController margin = TextEditingController();

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




   TextEditingController _typeAheadControllergender9 = TextEditingController();

  SuggestionsBoxController suggestionBoxController9 = SuggestionsBoxController();
  List<String> getSuggestionsgender9(String query) {
    List<String> matches = <String>[];
    matches.addAll(Suppierlist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  String UpdateItemlistid="";
  ///stream controllers lists
  final List<TextEditingController> _Streamcontroller1= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller2= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller3= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller4= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller5= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller6= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller7= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller8= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller9= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller10= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller11= List.generate(1000, (index) => TextEditingController());


  bool Loading=false;
  String toolhint= "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //Purchase_Entry
      Scaffold(
        backgroundColor:const Color(0xff00A99D),
       body: Stack(
           alignment: Alignment.center,
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [

               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding:  EdgeInsets.symmetric(
                       horizontal: width/341.5,
                       vertical: height/164.25
                     ),
                     child: InkWell(
                       onTap: () {

                         Navigator.pop(context);
                       },
                       child: Tooltip(
                         message: "Back",
                         child: Material(
                           elevation: 10,
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(100),
                           shadowColor: Colors.indigo,
                           child: Container(
                             height:height/ 26.28,
                             width:width/54.64,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(100),
                             ),
                             child: Center(
                               child: Icon(
                                 Icons.arrow_back,
                                 color: Colors.black,
                                 size: width / 91.06,
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),


                 ],
               ),

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
                     style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
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
                     style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
                   ),
                 ],
               ),



               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   //entry type container
                   SizedBox(
                     height: height / 4.054,
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           //suppiler Id
                           Padding(
                             padding: EdgeInsets.only(
                                 top: height / 328.5, left: width / 273.2),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 Container(
                                   width: width / 9.0,
                                   child: Text(
                                     "Supplier ID",
                                     style: GoogleFonts.openSans(
                                         fontSize: width/85,
                                         fontWeight: FontWeight.w700,
                                         color: const Color(0xff000000)),
                                   ),
                                 ),

                                 Container(
                                   width: width / 3.415,
                                   height: height / 21.9,
                                   //color:Colors.white,
                                   decoration: const BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: TextField(

                                     style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,fontSize: width/85,),
                                     controller: suppierid,
                                     focusNode: suppier_id,
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(
                                           left: width /90.78,
                                           top: height / 153.8),

                                       border: InputBorder.none,
                                       suffixIcon:
                                       Icon(Icons.circle,color:Colors.white),
                                     ),
                                     onSubmitted: (_) {
                                       suppier_id.unfocus();
                                       FocusScope.of(context)
                                           .requestFocus(suppiername);
                                     },
                                   ),
                                 ),
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 InkWell(
                                   onTap: () {
                                     if (customervalid == false) {
                                       alreadyexistshowdialpogbox();
                                     } else {
                                       itemcodegenrate();
                                       showdialpogbox2();
                                     }
                                   },
                                   child: customervalid != false
                                       ? Material(
                                     shadowColor: Colors.black12,
                                     elevation: 25,
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.white,
                                     child: Container(
                                         height: height / 21.9,
                                         width: width / 10.53,
                                         decoration: BoxDecoration(
                                           borderRadius:
                                           BorderRadius.circular(5),
                                           color: Colors.white,
                                         ),
                                         child: Row(
                                           children: [
                                             SizedBox(width: width / 400.33),
                                             const Text("New Suppiler"),
                                             SizedBox(width: width / 455.33),
                                             const Icon(Icons.add),
                                           ],
                                         )),
                                   )
                                       : GestureDetector(
                                     onTap: (){
                                       itemcodegenrate();
                                       showdialpogbox2();
                                     },
                                     child: ClipOval(
                                         child: Container(
                                             height: height / 21.9,
                                             width: width / 45.53,
                                             color: Colors.white,
                                             child: const Icon(Icons.add))),
                                   ),
                                 )
                               ],
                             ),
                           ),

                           //suppiler name
                           Padding(
                             padding: EdgeInsets.only(
                                 top: height / 328.5, left: width / 273.2),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 Container(
                                   width: width / 9.0,
                                   child: Text(
                                     "Supplier Name",
                                     style: GoogleFonts.openSans(
                                         fontWeight: FontWeight.w700,
                                         fontSize: width/85,
                                         color: const Color(0xff000000)),
                                   ),
                                 ),

                                 Container(
                                   width: width / 3.415,
                                   height: height / 21.9,
                                   //color:Colors.white,
                                   decoration: const BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: TextField(

                                     style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,fontSize: width/85,),
                                     controller: suppiler_name,
                                     focusNode: suppiername,
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(
                                           left: width /90.78,
                                           top: height / 153.8),

                                       border: InputBorder.none,
                                       suffixIcon:
                                       Icon(Icons.circle,color:Colors.white),
                                     ),
                                     onSubmitted: (_) {
                                       suppiername.unfocus();
                                     },
                                   ),



                                     /*LayoutBuilder(
                                     builder: (BuildContext, BoxConstraints) =>
                                         Autocomplete<String>(
                                           fieldViewBuilder: (context,
                                               yourbuilderclear,
                                               focusNode,
                                               onFieldSubmitted) {
                                             return TextFormField(
                                               onChanged: (_) {
                                                 setState(() {
                                                   _typeAheadControllergender9.text =
                                                       yourbuilderclear.text;
                                                 });
                                               },
                                               style: GoogleFonts.openSans(
                                                 fontWeight: FontWeight.w700,fontSize: width/85,),
                                               decoration: InputDecoration(
                                                 contentPadding: EdgeInsets.only(
                                                     left: width /90.78,
                                                     top: height / 153.8),

                                                 border: InputBorder.none,
                                                 suffixIcon:
                                                 GestureDetector(
                                                     onTap:(){
                                                       setState(() {
                                                         suppierid.clear();
                                                         yourbuilderclear.clear();
                                                         _typeAheadControllergender9.clear();
                                                         suppiler_invoice.clear();
                                                         suppiler_gstno.clear();
                                                       });
                                                     },
                                                     child: Icon(Icons.clear,color:Colors.black,size:20)),),
                                               controller: yourbuilderclear,
                                               focusNode: focusNode,
                                               onFieldSubmitted: (String value) {
                                                 onFieldSubmitted();
                                               },
                                             );
                                           },
                                           optionsViewBuilder: (context, onSelected,
                                               options) =>
                                               Align(
                                                   alignment: Alignment.topLeft,
                                                   child: Material(
                                                     shape:
                                                     const RoundedRectangleBorder(
                                                       borderRadius:
                                                       BorderRadius.vertical(
                                                           bottom:
                                                           Radius.circular(
                                                               4.0)),
                                                     ),
                                                     child: SizedBox(
                                                       height: 52.0 * options.length,
                                                       width: BoxConstraints
                                                           .biggest.width,
                                                       child: ListView.builder(
                                                         padding: EdgeInsets.zero,
                                                         itemCount: options.length,
                                                         shrinkWrap: false,
                                                         itemBuilder:
                                                             (BuildContext, index) {
                                                           final String option =
                                                           options
                                                               .elementAt(index);
                                                           return InkWell(
                                                             onTap: () =>
                                                                 onSelected(option),
                                                             child: Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(8.0),
                                                               child: Text(option),
                                                             ),
                                                           );
                                                         },
                                                       ),
                                                     ),
                                                   )),
                                           optionsBuilder:
                                               (TextEditingValue textEditingValue) {
                                             if (textEditingValue.text == '') {
                                               setState(() {
                                                 customervalid = false;
                                               });
                                               return const Iterable<String>.empty();
                                             }
                                             if (textEditingValue.text != "") {
                                               check(
                                                   textEditingValue.text.toString());
                                               setState(() {
                                                 Suppliername.text = textEditingValue
                                                     .text
                                                     .toString();
                                               });
                                               checkfunc();
                                             }
                                             return Suppierlist.where(
                                                     (String option) {
                                                   return option.toLowerCase().contains(
                                                       textEditingValue.text
                                                           .toLowerCase());
                                                 });
                                           },
                                           onSelected: (String selection) {
                                             check(selection);
                                             setState(() {
                                               Suppliername.text = selection;
                                               customervalid = false;
                                             });
                                             checkfunc();

                                             debugPrint(
                                                 'You just selected $selection');
                                           },
                                           displayStringForOption: (Value) {
                                             return Value;
                                           },
                                           optionsMaxHeight: 50,
                                         ),
                                   ),*/
                                 ),
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 //
                                 // GestureDetector(
                                 //   onTap: (){
                                 //     setState(() {
                                 //
                                 //     });
                                 //
                                 //
                                 //   },
                                 //   child: ClipOval(
                                 //       child: Container(
                                 //           height: height / 21.9,
                                 //           width: width / 45.53,
                                 //           color: Colors.white,
                                 //           child: IgnorePointer(child: const Icon(Icons.cancel_outlined,size: 20,)))),
                                 // ),
                               ],
                             ),
                           ),

                           //tax type
                           Padding(
                             padding: EdgeInsets.only(
                                 top: height / 328.5, left: width / 273.2),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 Container(
                                   width: width / 9.0,
                                   child: Text(
                                     "Tax Type",
                                     style: GoogleFonts.openSans(
                                         fontWeight: FontWeight.w700,
                                         fontSize: width/85,
                                         color: const Color(0xff000000)),
                                   ),
                                 ),


                                 Container(
                                   width: width / 3.415,
                                   height: height / 21.9,
                                   //color:Colors.white,
                                   decoration: const BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: DropdownButtonHideUnderline(
                                     child: ButtonTheme(
                                       alignedDropdown: true,
                                       child:
                                       DropdownButton2<String>(

                                         value: dropdownValue3,
                                         focusNode: suppiertax,
                                         isExpanded: true,
                                         isDense: true,
                                         alignment: Alignment.topCenter,
                                         style: GoogleFonts.openSans(
                                           fontWeight: FontWeight.w700,
                                           fontSize: width/85,),
                                         underline: Container(
                                           color: Colors.deepPurpleAccent,
                                         ),
                                         onChanged: (String? value) {
                                           // This is called when the user selects an item.
                                           setState(() {
                                             dropdownValue3 = value!;
                                           });
                                           if (dropdownValue3 == "IGST") {

                                           }
                                           suppiertax.unfocus();
                                           FocusScope.of(context)
                                               .requestFocus(suppierincoice_no);
                                         },
                                         items: list3
                                             .map<DropdownMenuItem<String>>(
                                                 (String value) {
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
                             padding: EdgeInsets.only(
                                 top: height / 328.5, left: width / 273.2),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 Container(
                                   width: width / 9.0,
                                   child: Text(
                                     "Supplier Invoice",
                                     style: GoogleFonts.openSans(
                                         fontWeight: FontWeight.w700,
                                         fontSize: width/85,
                                         color: const Color(0xff000000)),
                                   ),
                                 ),

                                 Container(
                                   width: width / 3.415,
                                   height: height / 21.9,
                                   //color:Colors.white,
                                   decoration: const BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: TextFormField(
                                     validator: (value) => value!.isEmpty
                                         ? 'Please select a  Supplier Invoice No'
                                         : null,
                                     controller: suppiler_invoice,
                                     focusNode: suppierincoice_no,
                                     style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,fontSize: width/85,
                                     ),
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(
                                           left: width /90.78,
                                           top: height / 153.8),

                                       border: InputBorder.none,
                                       suffixIcon:
                                       Icon(Icons.circle,color:Colors.white),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           //suppiler Gst no
                           Padding(
                             padding: EdgeInsets.only(
                                 top: height / 328.5, left: width / 273.2),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width: width / 273.2,
                                 ),
                                 Container(
                                   width: width / 9.0,
                                   child: Text(
                                     "Supplier Gst No",
                                     style: GoogleFonts.openSans(
                                         fontWeight: FontWeight.w700,
                                         fontSize: width/85,
                                         color: const Color(0xff000000)),
                                   ),
                                 ),

                                 Container(
                                   width: width / 3.415,
                                   height: height / 21.9,
                                   //color:Colors.white,
                                   decoration: const BoxDecoration(
                                     color: Colors.white,
                                   ),
                                   child: TextFormField(
                                     validator: (value) => value!.isEmpty
                                         ? "Field Can't Empty"
                                         : null,
                                     style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,fontSize: width/85,
                                     ),
                                     controller: suppiler_gstno,
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(
                                           left: width /90.78,
                                           top: height / 153.8),

                                       border: InputBorder.none,
                                       suffixIcon:
                                       Icon(Icons.circle,color:Colors.white),
                                     ),

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
                     height: height / 4.054,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         //Purchase No
                         Padding(
                           padding: EdgeInsets.only(
                               top: height / 328.5, left: width / 273.2),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: width / 273.2,
                               ),
                               Container(
                                 width: width / 9.0,
                                 child: Text(
                                   "Purchase No",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,
                                       fontSize: width/85,
                                       color: const Color(0xff000000)),
                                 ),
                               ),

                               Container(
                                 width: width / 3.415,
                                 height: height / 21.9,
                                 //color:Colors.white,
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                 ),
                                 child: TextFormField(
                                   style: GoogleFonts.openSans(
                                     fontWeight: FontWeight.w700,fontSize: width/85,
                                   ),
                                   controller: purchase_No,
                                   focusNode: purchase_no,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.only(
                                         left: width /90.78,
                                         top: height / 153.8),

                                     border: InputBorder.none,
                                     suffixIcon:
                                     Icon(Icons.circle,color:Colors.white),

                                   ),

                                 ),
                               ),
                             ],
                           ),
                         ),

                         //Purchase  Date
                         Padding(
                           padding: EdgeInsets.only(
                               top: height / 328.5, left: width / 273.2),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: width / 273.2,
                               ),
                               Container(
                                 width: width / 9.0,
                                 child: Text(
                                   "Purchase  Date",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,
                                       fontSize: width/85,
                                       color: const Color(0xff000000)),
                                 ),
                               ),

                               Container(
                                 width: width / 3.415,
                                 height: height / 21.9,
                                 //color:Colors.white,
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                 ),
                                 child: TextField(
                                   style: GoogleFonts.openSans(
                                     fontWeight: FontWeight.w700,
                                     fontSize: width/85,
                                   ),
                                   controller: purchase_Date,
                                   focusNode: purchase_date,
                                   decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(
                                           left: width /90.78,
                                           top: height / 153.8),
                                       hintText: "Invoice Date",
                                       border: InputBorder.none,
                                       suffixIcon:
                                       const Icon(Icons.calendar_month)),
                                   onSubmitted: (_) {
                                     purchase_date.unfocus();
                                     FocusScope.of(context)
                                         .requestFocus(purchase_payment);
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
                                       DateFormat('dd/MM/yyyy')
                                           .format(pickedDate);
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
                           padding: EdgeInsets.only(
                               top: height / 328.5, left: width / 273.2),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: width / 273.2,
                               ),
                               Container(
                                 width: width / 9.0,
                                 child: Text(
                                   "Payment Mode",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,
                                       fontSize: width/85,
                                       color: const Color(0xff000000)),
                                 ),
                               ),

                               Container(
                                 width: width / 3.415,
                                 height: height / 21.9,
                                 //color:Colors.white,
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                 ),
                                 child:
                                 DropdownButton2<String>(
                                   alignment: Alignment.center,
                                   value: Payments,
                                   focusNode: purchase_payment,
                                   isExpanded: true,
                                   style: GoogleFonts.openSans(
                                     fontWeight: FontWeight.w700,
                                     fontSize: width/85,),
                                   underline: Container(
                                     color: Colors.deepPurpleAccent,
                                   ),
                                   onChanged: (String? value) {
                                     // This is called when the user selects an item.
                                     setState(() {
                                       Payments = value!;
                                     });
                                     purchase_payment.unfocus();
                                     FocusScope.of(context)
                                         .requestFocus(purchase_note);
                                   },
                                   items: Payment.map<DropdownMenuItem<String>>(
                                           (String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(value),
                                         );
                                       }).toList(),
                                 ),
                               ),
                             ],
                           ),
                         ),

                         //Purchase Notes
                         Padding(
                           padding: EdgeInsets.only(
                               top: height / 328.5, left: width / 273.2),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: width / 273.2,
                               ),
                               Container(
                                 width: width / 9.0,
                                 child: Text(
                                   "Purchase Notes",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,
                                       fontSize: width/85,
                                       color: const Color(0xff000000)),
                                 ),
                               ),

                               Container(
                                 width: width / 3.415,
                                 height: height / 21.9,
                                 //color:Colors.white,
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                 ),
                                 child: TextFormField(
                                   style: GoogleFonts.openSans(
                                     fontWeight: FontWeight.w700,fontSize: width/85,
                                   ),
                                   controller: purchase_notes,
                                   focusNode: purchase_note,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.only(
                                         left: width /90.78,
                                         top: height / 153.8),

                                     border: InputBorder.none,
                                     suffixIcon:
                                     Icon(Icons.circle,color:Colors.white),
                                   ),

                                 ),
                               ),
                             ],
                           ),
                         ),

                         // Craedit days
                         Padding(
                           padding: EdgeInsets.only(
                               top: height / 328.5, left: width / 273.2),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               SizedBox(
                                 width: width / 273.2,
                               ),
                               Container(
                                 width: width / 9.0,
                                 child: Text(
                                   "Credit Days",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700,
                                       fontSize: width/85,
                                       color: const Color(0xff000000)),
                                 ),
                               ),

                               Container(
                                 width: width / 3.415,
                                 height: height / 21.9,
                                 //color:Colors.white,
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                 ),
                                 child: TextFormField(
                                   style: GoogleFonts.openSans(
                                     fontWeight: FontWeight.w700,fontSize: width/85,
                                   ),
                                   controller: Creadit_days,
                                   focusNode: Creditnoptes,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.only(
                                         left: width /90.78,
                                         top: height / 153.8),

                                     border: InputBorder.none,
                                     suffixIcon:
                                     Icon(Icons.circle,color:Colors.white),
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
                     color: const Color(0xff1D5B79),
                     child: Container(
                       width: width / 0.976,
                       height: height / 16.425,
                       decoration: const BoxDecoration(
                         color: Color(0xff1D5B79),
                       ),
                       child: Row(
                         children: [
                           //Serial no
                           SizedBox(
                             width: width / 45.533,
                             child: Center(
                                 child: Text(
                                   "Si No",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700, color:Colors.white),

                                 )),
                           ),

                           //itemid
                           SizedBox(
                             width: width / 14.2,
                             child: Center(
                                 child: Text(
                                   "Item ID",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700, color:Colors.white),
                                 )),
                           ),

                           //itemname
                           SizedBox(
                             width: width / 4.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   "Item Name",
                                   style: GoogleFonts.openSans(
                                       fontWeight: FontWeight.w700, color:Colors.white),
                                 ),
                                 SizedBox(width:width/170.75),

                               /*  InkWell(onTap:(){
                                  *//* if(itemdocuid.isNotEmpty){
                                     setState((){
                                       histroyshow=true;
                                     });
                                     showdialpogboxitem();
                                   }*//*

                                 },
                                   child: Container(
                                     height:height/21.9,
                                     width:width/22.76,
                                     decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
                                     child: const Center(child: Text("View",style: TextStyle(color:Colors.white),)),
                                   ),
                                 ),
                                 SizedBox(width:width/170.75),
                                 InkWell(
                                   onTap:(){
                                     //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Item("Purchase")));
                                   },
                                   child: Container(
                                     height:height/21.9,
                                     width:width/20.76,
                                     decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(5)),
                                     child: const Center(child: Text("Add Item",style: TextStyle(color:Colors.white),)),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: InkWell(
                                       onTap:(){
                                         itemaddfunction();
                                       },
                                       child: Icon(Icons.refresh)),
                                 )*/

                               ],
                             ),
                           ),

                           //Box No
                           SizedBox(
                             width: width / 23.0,
                             child: Center(
                                 child: Text(
                                   "Box No",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //Hsn Code
                           SizedBox(
                             width: width / 12.0,
                             child: Center(
                                 child: Text(
                                   "HSN Code",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //tax


                           //quvantity
                           SizedBox(
                             width: width / 24.7,
                             child: Center(
                                 child: Text(
                                   "Qnty",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //price
                           SizedBox(
                             width: width / 15.50,
                             child: Center(
                                 child: Text(
                                   "Price",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //landing cost
                           SizedBox(
                             width: width / 15.18,
                             child: Center(
                                 child: Text(
                                   "Landing Cost",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                   textAlign: TextAlign.center,
                                 )),
                           ),

                           //Sales Price
                           SizedBox(
                             width: width / 15.18,
                             child: Center(
                                 child: Text(
                                   "Sales Price",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           SizedBox(
                             width: width / 15.18,
                             child: Center(
                                 child: Text(
                                   "Profit",
                                   style: GoogleFonts.openSans( color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //Mrp Price
                           SizedBox(
                             width: width / 15.18,
                             child: Center(
                                 child: Text(
                                   "MRP Price",
                                   style: GoogleFonts.openSans(color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           //value
                           SizedBox(
                             width: width / 15.18,
                             child: Center(
                                 child: Text(
                                   "Value",
                                   style: GoogleFonts.openSans(color:Colors.white,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 )),
                           ),

                           //Low order quvantity
                           SizedBox(
                             width: width / 35.18,
                             child: Center(
                                 child: Text(
                                   "A\nQnty",
                                   textAlign: TextAlign.center,
                                   style: GoogleFonts.openSans(color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),

                           SizedBox(
                             width: width / 30.18,
                             child: Center(
                                 child: Text(
                                   "Stk",
                                   style: GoogleFonts.openSans(color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),
                           //Clear controllers
                           SizedBox(
                             width: width / 30.18,
                             child: Center(
                                 child: Text(
                                   "Clear ",
                                   style: GoogleFonts.openSans(color:Colors.white,
                                       fontWeight: FontWeight.w700),
                                 )),
                           ),
                         ],
                       ),
                     ),
                   ),

                   Container(
                     // color: Color(0xffFFFFFF),
                     width: width / 0.976,
                     decoration: const BoxDecoration(
                       color:Colors.white,
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         //Serial no
                         Container(
                           width: width / 46.533,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             decoration: InputDecoration(
                                 border: InputBorder.none,
                                 contentPadding: EdgeInsets.only(
                                     left: width / 136.6, bottom: height / 65.7),
                                 hintText: "1"),
                           ),
                         ),

                         //itemid
                         Container(
                           width: width / 14.8,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: LayoutBuilder(
                             builder: (BuildContext, BoxConstraints) =>
                                 Autocomplete<String>(
                                   fieldViewBuilder: (context, textEditingController,
                                       focusNode, onFieldSubmitted) {
                                     return TextFormField(
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                                       onChanged: (_) {
                                         setState(() {
                                           //layourbuilderclear3 = textEditingController;
                                         });
                                       },
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                         /*contentPadding: EdgeInsets.only(
                              left: width /90.78,
                              top: height / 150.0),*/),
                                       //controller: layourbuilderclear3,
                                       focusNode: focusNode,
                                       onFieldSubmitted: (String value) {
                                         onFieldSubmitted();
                                       },
                                     );
                                   },
                                   optionsViewBuilder:
                                       (context, onSelected, options) => Align(
                                       alignment: Alignment.topLeft,
                                       child: Material(
                                         shape: const RoundedRectangleBorder(
                                           borderRadius: BorderRadius.vertical(
                                               bottom: Radius.circular(4.0)),
                                         ),
                                         child: SizedBox(
                                           height: 52.0 * options.length,
                                           width: BoxConstraints.biggest.width,
                                           child: ListView.builder(
                                             padding: EdgeInsets.zero,
                                             itemCount: options.length,
                                             shrinkWrap: false,
                                             itemBuilder: (BuildContext, index) {
                                               final String option =
                                               options.elementAt(index);
                                               return InkWell(
                                                 onTap: () => onSelected(option),
                                                 child: Padding(
                                                   padding:
                                                   const EdgeInsets.all(16.0),
                                                   child: Text(
                                                     option,  style: GoogleFonts.openSans(
                                                       fontWeight: FontWeight.w700),
                                                   ),
                                                 ),
                                               );
                                             },
                                           ),
                                         ),
                                       )),
                                   optionsBuilder:
                                       (TextEditingValue textEditingValue) {
                                     if (textEditingValue.text == '') {
                                       return const Iterable<String>.empty();
                                     }



                                     return Itemlist2.where((String option) {
                                       return option.toLowerCase().contains(
                                           textEditingValue.text.toLowerCase());
                                     });
                                   },
                                   onSelected: (String selection) {
                                     //createpurchase3(selection.toString());
                                     setState(() {
                                       itemid.text = selection;
                                     });
                                     debugPrint('You just selected $selection');

                                   },
                                   displayStringForOption: (value) {
                                     return value;
                                   },
                                 ),
                           ),

                         ),

                         //itemname
                         Tooltip(
                           message:toolhint,
                           child: Container(
                             width: width / 4.0,
                             height: height / 21.9,
                             decoration: BoxDecoration(
                                 border:
                                 Border.all(color: Colors.black, width: 0.6)),
                             child: Padding(
                               padding: EdgeInsets.only(
                                   left: width / 130, right: width / 170),
                               child:
                               LayoutBuilder(
                                 builder: (BuildContext , BoxConstraints )=>
                                     Autocomplete<String>(
                                       fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                         return
                                           TextFormField(
                                             textAlign: TextAlign.center,
                                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                                             onChanged: (_){
                                               setState(() {
                                                 _typeAheadControllergender9=textEditingController;
                                               });
                                             },
                                             decoration: InputDecoration(
                                               border: InputBorder.none,

                                               /*   contentPadding: EgeInsets.only(
                                              left: width /90.78,
                                              top: height / 150.0),*/
                                             ),
                                             controller: _typeAheadControllergender9,
                                             focusNode: focusNode,
                                             onFieldSubmitted: (String value) {
                                               onFieldSubmitted();
                                             },
                                           );
                                       },
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
                                                       child: Text(option, style: GoogleFonts.openSans(fontWeight: FontWeight.w700),),
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

                                         return
                                           Itemlist.where((String option) {
                                             return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                           });
                                       },
                                       onSelected: (String selection) async {

                                           createpurchase2(selection.toString());
                                           setState(() {
                                             itemname.text = selection;

                                           });
                                           if(status==true){
                                             var documents2 = await FirebaseFirestore.instance.collection("Item ShabikaG").where("Newitemname",isEqualTo:itemname.text).get();
                                             if(documents2.docs.length>0){
                                               setState((){
                                                /* showrelatedoitem=true;
                                                 showrelatedoitemname=itemname.text;*/
                                               });

                                             }
                                           }
                                           if(status2==true){
                                             var documents2 = await FirebaseFirestore.instance.collection("Item ShabikaN").where("Newitemname",isEqualTo:itemname.text).get();
                                             if(documents2.docs.length>0){
                                               setState((){
                                               /*  showrelatedoitem=true;
                                                 showrelatedoitemname=itemname.text;*/
                                               });

                                             }
                                           }
                                           debugPrint('You just selected $selection');


                                       },
                                       displayStringForOption: (value){
                                         return value;
                                       },
                                     ),
                               ),
                             ),
                           ),
                         ),

                         //Box No
                         Container(
                           width: width / 23.0,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Box_NO,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /* contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {},
                           ),
                         ),

                         //Hsn Code
                         Container(
                           width: width / 12.0,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: HSN_Code,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /* contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                           ),
                         ),

                         //tax


                         //quvantity
                         Container(
                           width: width / 24.7,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Qty,
                             focusNode: Quvantitylist,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*  contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {
                               if (suppierid.text.length != 0 &&
                                   suppiler_name.text.length != 0 &&
                                   //layourbuilderclear.text.length != 0 &&
                                   Suppliername.text.length != 0) {
                                 if (Qty.text.length > 0) {
                                   if (Payments != 'Please Select Type'||Payments=="Credit Amount"&&Creadit_days.text!="") {
//Total function
                                     checkgst(Purchase_price.text, Qty.text);

                                     //check the imei and seriall functiom

                                     serialvalue == true ||
                                         imeivalue == true ||
                                         color == true ||
                                         image == true
                                         ?
                                     //create a document (Firebase)
                                     showtextfield(int.parse(Qty.text), serialvalue, imeivalue, color,image)
                                         : collectioncreatefunction(valueitem.text,Purchase_price.text,Sales.text,Landing_cost.text,"");

                                     // setState(() {
                                     //   IMEISERIAL.clear();
                                     //   IMEI.clear();
                                     //   SERIAL.clear();
                                     //   colorlist.clear();
                                     //   Imagelist.clear();
                                     // });
                                     //multiple the value functions(Total)
                                     Quvantitylist.unfocus();
                                     FocusScope.of(context)
                                         .requestFocus(items_value);
                                   }
                                   else {
                                     //showdialpogboxsss();
                                   }
                                 }
                               } else {
                                 //showdialpogboxsss1();
                               }
                             },
                             onChanged: (_) {
                               if (suppierid.text.length != 0 &&
                                   suppiler_name.text.length != 0 &&
                                   //layourbuilderclear.text.length != 0 &&
                                   Suppliername.text.length != 0) {
                                 if (Qty.text.length > 0) {
                                   checkgst(Purchase_price.text, Qty.text);
                                 }
                               } else {
                                 //showdialpogboxsss1();
                               }
                             },
                           ),
                         ),

                         //price
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Purchase_price,
                             decoration: InputDecoration(
                               border: InputBorder.none,

                             ),
                             onSubmitted: (_) {
                               //alteritemcode();
                               landingcost(Purchase_price.text);
                               checkgst(Purchase_price.text, Qty.text);
                             },
                           ),
                         ),

                         //landing cost
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Landing_cost,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*  contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {
                               //alteritemcode();
                             },
                           ),
                         ),

                         //Sales Price
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Sales,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*   contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {
                               //alteritemcode();
                             },
                           ),
                         ),
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: margin,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*   contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {
                               //alteritemcode();
                             },
                           ),
                         ),

                         //mrp Price
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Mrp_Price,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*  contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                             onSubmitted: (_) {
                               //alteritemcode();
                             },
                           ),
                         ),

                         //value
                         Container(
                           width: width / 15.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.red,),

                             controller: valueitem,
                             focusNode: items_value,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.only(
                                   left: width /90.78,
                                   top: height / 150.0),
                             ),
                             onSubmitted: (_) {
                               if (suppierid.text.length != 0 &&
                                   suppiler_name.text.length != 0 &&
                                   //layourbuilderclear.text.length != 0 &&
                                   Suppliername.text.length != 0) {
                                 if (Qty.text.length > 0) {
                                   if (Payments != 'Please Select Type'||Payments=="Credit Amount"&&Creadit_days.text!="") {
                                     serialvalue == true ||
                                         imeivalue == true ||
                                         color == true ||
                                         image == true
                                         ?
                                     //create a document (Firebase)
                                     showtextfield(int.parse(Qty.text),serialvalue, imeivalue, color,image)

                                         : collectioncreatefunction(valueitem.text,Purchase_price.text,Sales.text,Landing_cost.text,"");


                                     items_value.unfocus();
                                     FocusScope.of(context).requestFocus(items_id);
                                   } else {
                                     //showdialpogboxsss();
                                   }
                                 }
                               } else {
                                //showdialpogboxsss1();
                               }
                             },
                           ),
                         ),

                         //Low order quvantity
                         Container(
                           width: width / 35.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                             controller: Loworder,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /* contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                           ),
                         ),

                         //Stock
                         Container(
                           width: width / 30.18,
                           height: height / 21.9,
                           decoration: BoxDecoration(
                               border:
                               Border.all(color: Colors.black, width: 0.6)),
                           child: TextField(
                             textAlign: TextAlign.center,
                             style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                             controller: Stocks,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               /*contentPadding: EdgeInsets.only(
                                left: width /90.78,
                                top: height / 150.0),*/
                             ),
                           ),
                         ),

                         //Clear controllers
                         Container(
                             width: width / 30.18,
                             height: height / 21.9,
                             decoration: BoxDecoration(
                                 border:
                                 Border.all(color: Colors.black, width: 0.6)),
                             child: Center(
                               child: InkWell(
                                 onTap: () {
                                   clearallcontroller();
                                 },
                                 child: const Icon(Icons.delete),
                               ),
                             )),
                       ],
                     ),
                   ),

                   SizedBox(
                     height: height / 131.4,
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
                       child: StreamBuilder<QuerySnapshot>(
                         stream: FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid)
                             .collection(widget.docid.toString()).orderBy("timestamp")
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
                               var billing = snapshot.data!.docs[index];
                               return Padding(
                                 padding: EdgeInsets.only(bottom: 0),
                                 child:
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     //Serial no
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 45.533,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: " ${index + 1}",
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                           ),
                                         )

                                     ),

                                     //itemid
                                     Container(

                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 14.8,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             controller: _Streamcontroller1[index],
                                             textAlign: TextAlign.center,
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: "${billing['itemcode']}",
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "itemcode":_Streamcontroller1[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),

                                     //itemname
                                     Tooltip(
                                       message: '${billing['Description']}',
                                       child: Container(
                                           decoration: BoxDecoration(
                                               border:Border.all(color:Colors.black54)
                                           ),
                                           width: width / 4.0,
                                           height: height / 21.9,
                                           child:
                                           Padding(
                                             padding:  EdgeInsets.only(left:width/136.6),
                                             child: TextField(
                                               textAlign: TextAlign.center,
                                               controller: _Streamcontroller2[index],

                                               decoration: InputDecoration(

                                                   border: InputBorder.none,
                                                   hintText: '${billing['Description']},',

                                                   hintStyle: const TextStyle(color: Colors.black,)
                                               ),
                                               onSubmitted: (_){
                                                 FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                     .collection(random).doc(billing.id).update({
                                                   "Description":_Streamcontroller2[index].text
                                                 });

                                               },
                                             ),
                                           )
                                       ),
                                     ),


                                     Container(
                                       decoration: BoxDecoration(
                                           border:Border.all(color:Colors.black54)
                                       ),
                                       width: width / 23.0,
                                       height: height / 21.9,
                                     ),

                                     //Hsn code
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 12.0,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller3[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Hsncode'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Hsncode":_Streamcontroller3[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),

                                     //tax


                                     //quvantity
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 24.7,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller5[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Qty'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),

                                             onSubmitted: (_) async {


                                               print("Check-1");
                                               setState((){
                                                 _Streamcontroller10[index].text = (((double.parse(billing['Purchase price'].toString())) * double.parse(_Streamcontroller5[index].text)).toStringAsFixed(2));
                                                 _Streamcontroller11[index].text = (((double.parse(billing['margin'].toString())) * double.parse(_Streamcontroller5[index].text)).toStringAsFixed(2));
                                               });
                                               FirebaseFirestore.instance.collection(
                                                   "Purchase entry").doc(widget.docid)
                                                   .collection(widget.docid!).doc(billing.id)
                                                   .update({
                                                 "Qty": _Streamcontroller5[index].text,
                                                 "Total": _Streamcontroller10[index].text
                                               });

                                                 if(status==true){
                                                   var documents = await FirebaseFirestore.instance.collection("Item ShabikaG").where("Itemcode", isEqualTo:billing['itemcode']).get();
                                                   FirebaseFirestore.instance.collection("Item ShabikaG").doc(documents.docs[0].id).update({
                                                     "TotalQuvantity": int.parse(_Streamcontroller5[index].text),
                                                   });
                                                   if(documents.docs[0]['IMEI NO']==true){
                                                     setState((){
                                                       IMEI=documents.docs[0]['Imei no'];
                                                       UpdateItemlistid=documents.docs[0].id;
                                                     });
                                                   }
                                                   if(documents.docs[0]['Serial NO']==true){
                                                     setState((){
                                                       SERIAL=documents.docs[0]['Serial no'];
                                                       UpdateItemlistid=documents.docs[0].id;
                                                     });
                                                   }
                                                   if(documents.docs[0]['Color']==true){
                                                     setState((){
                                                       colorlist=documents.docs[0]['color'];
                                                       UpdateItemlistid=documents.docs[0].id;
                                                     });
                                                   }
                                                   updatetotal();
                                                   CGSTfunction();
                                                   SGSTfunction();
                                                   Totalamounts();
                                                   if(billing['IMEI NO']==true || billing['Serial NO']==true || billing['Color']==true) {
                                                     Future.delayed(Duration(seconds: 1), () {

                                   showquvantitytextfield(
                                       int.parse(_Streamcontroller5[index]
                                           .text),
                                       documents.docs[0]['Serial NO'],
                                       documents.docs[0]['IMEI NO'],
                                       documents.docs[0]['Color'],
                                       documents.docs[0]['Image'],
                                       documents.docs[0].id,
                                       billing['Item'],
                                       billing.id,
                                       billing['Total'],
                                       billing['Purchase price'],
                                       billing['Sales price'],
                                       billing['Landing cost']);
                                 });
                               }
                                                 }

                                                 print("Check-4");

                                                 if(status2==true){
                                                   var documents2 = await FirebaseFirestore.instance.collection("Item ShabikaN").
                                                   where("Itemcode", isEqualTo:billing['itemcode']).get();
                                                   FirebaseFirestore.instance.collection("Item ShabikaG").doc(documents2.docs[0].id).update({
                                                     "TotalQuvantity": int.parse(_Streamcontroller5[index].text),
                                                   });

                                                   if(documents2.docs[0]['IMEI NO']==true){
                                                     print("popuop start");
                                                     setState((){
                                                       IMEI=documents2.docs[0]['Imei no'];
                                                       UpdateItemlistid=documents2.docs[0].id;
                                                     });
                                                   }

                                                   if(documents2.docs[0]['Serial NO']==true){
                                                     setState((){
                                                       SERIAL=documents2.docs[0]['Serial no'];
                                                       UpdateItemlistid=documents2.docs[0].id;
                                                     });
                                                   }

                                                   if(documents2.docs[0]['Color']==true){
                                                     setState((){
                                                       colorlist=documents2.docs[0]['color'];
                                                       UpdateItemlistid=documents2.docs[0].id;
                                                     });
                                                   }

                                                   updatetotal();
                                                   CGSTfunction();
                                                   SGSTfunction();
                                                   Totalamounts();

                                                   Future.delayed(Duration(seconds: 1),(){
                                                     showquvantitytextfield(int.parse(_Streamcontroller5[index].text), documents2.docs[0]['Serial NO'],
                                                         documents2.docs[0]['IMEI NO'],documents2.docs[0]['Color'],documents2.docs[0]['Image'],documents2.docs[0].id,documents2.docs[0]['Item'],billing.id,billing['Total'],billing['Purchase price'],billing['Sales price'],billing['Landing cost']);
                                                   });

                                                 }




                                               print("Check-2");
                                               if(billing['IMEI NO']==true || billing['Serial NO']==true || billing['Color']==true) {

                               }

                                               print("Check-3");



                                             },
                                           ),
                                         )
                                     ),

                                     //price
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),

                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller6[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Purchase price'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Purchase price":_Streamcontroller6[index].text,
                                                 "Landing cost":_Streamcontroller7[index].text,
                                                 "Total":_Streamcontroller10[index].text
                                               });
                                               setState((){
                                                 salespriceff=double.parse(_Streamcontroller6[index].text);
                                                 _Streamcontroller10[index].text = (((double.parse(_Streamcontroller6[index].text.toString())) * double.parse(_Streamcontroller5[index].text)).toString());
                                               });
                                               if (status == true) {
                                                 setState(() {
                                                   _Streamcontroller7[index].text = ((18 / 100) * double.parse(_Streamcontroller6[index].text.toString()) + double.parse(_Streamcontroller6[index].text.toString())).toStringAsFixed(2);
                                                 });
                                               }
                                               if (status2 == true) {
                                                 _Streamcontroller7[index].text = _Streamcontroller6[index].text.toString();
                                               }
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Total":_Streamcontroller10[index].text
                                               });

                                               updatetotal();
                                               CGSTfunction();
                                               SGSTfunction();
                                               Totalamounts();

                                             },
                                           ),
                                         )
                                     ),

                                     //landing cost
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller7[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Landing cost'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Landing cost":_Streamcontroller7[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),

                                     //Sales Price
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller8[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Sales price'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Sales price":_Streamcontroller8[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller11[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['margin'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){


                                             },
                                           ),
                                         )
                                     ),

                                     //MRP Price
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),

                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller9[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['MRP price'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "MRP price":_Streamcontroller9[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),

                                     //value
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 15.18,
                                         height: height / 21.9,
                                         child:
                                         Padding(
                                           padding:  EdgeInsets.only(left:width/136.6),
                                           child: TextField(
                                             maxLines: 1,
                                             textAlign: TextAlign.center,
                                             controller: _Streamcontroller10[index],
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 hintText: billing['Total'],
                                                 hintStyle: const TextStyle(color: Colors.black)
                                             ),
                                             onSubmitted: (_){
                                               FirebaseFirestore.instance.collection("Purchase entry").doc(random)
                                                   .collection(random).doc(billing.id).update({
                                                 "Total":_Streamcontroller10[index].text
                                               });

                                             },
                                           ),
                                         )
                                     ),

                                     //A Quvantity
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 35.18 + width / 30.18,
                                         height: height / 21.9,
                                         child: const Center(child: Text(""))),

                                     //remove
                                     Container(
                                         decoration: BoxDecoration(
                                             border:Border.all(color:Colors.black54)
                                         ),
                                         width: width / 30.18,
                                         height: height / 21.9,
                                         child: Center(
                                           child: InkWell(
                                             onTap: () {
                                               deletecollection(billing.id);
                                             },
                                             child: const Icon(Icons.delete),
                                           ),
                                         )),
                                   ],
                                 ),
                               );

                             },
                           );
                         },
                       ),
                     ),
                   ),
                 ],
               ),

             /*  Padding(
                 padding: EdgeInsets.only(top: height / 131.4, left: width/27.32),
                 child: Material(
                   elevation: 50,
                   shadowColor: Colors.black38,
                   color: Color(0xffFFFFFF),
                   borderRadius: BorderRadius.circular(12),
                   child: Container(
                     width: width/1.093,
                     height: height/6.14,
                     decoration: BoxDecoration(
                         color: Color(0xffFFFFFF),
                         borderRadius: BorderRadius.circular(12)),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [

                         SizedBox(width: width/8.83,),

                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(left: width / 75.888),
                               child: InkWell(
                                 onTap: () {

                                   //check bill no function
                                   checkbillno();
                                   Purchaseitem();
                                   //status update function
                                   savebillfunction();
                                   clearallcontroller();
                                   clearallcontroller2();
                                   Navigator.pop(context);
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Save Purchase Bill Succesfully..")));
                                 },
                                 child: Container(
                                   child: Center(
                                       child: Text(
                                         "Update Invoice",
                                         style: GoogleFonts.openSans(color: Colors.white),
                                       )),
                                   width: width / 5.6,
                                   height: height / 16.42,
                                   //color: Color(0xffD60A0B),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(4),
                                     color: Color(0xffD60A0B),
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(height:height/131.4),
                             Padding(
                               padding: EdgeInsets.only(left: width / 75.888),
                               child: InkWell(
                                 onTap: () {

                                   getvalue(suppierid.text,
                                       suppiler_name.text,
                                       dropdownValue3,
                                       suppiler_invoice.text,
                                       purchase_No.text,
                                       purchase_Date.text,
                                       Payments
                                   );
                                 },
                                 child: Container(
                                   child: Center(
                                       child: Text(
                                         "Save And Print Invoice",
                                         style: GoogleFonts.openSans(color: Colors.white),
                                       )),
                                   //width: width / 4.6,
                                   width: width / 5.6,
                                   height: height / 16.42,
                                   //color: Color(0xffD60A0B),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(4),
                                     color: Color(0xff0079FF),
                                   ),
                                 ),
                               ),
                             ),

                           ],
                         ),

                         SizedBox(width: width/6.415,),

                         Row(
                           children: [

                             GestureDetector(
                               onTap:(){
                                 testfunction();
                               },
                               child: Container(
                                   width: width / 3.5,
                                   height: height/6.8,

                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [

                                       Row(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment:dropdownValue3=="IGST" ? MainAxisAlignment.start: MainAxisAlignment.center,
                                         children: [
                                           dropdownValue3=="IGST" ? SizedBox(width:width/220.6):const SizedBox(),

                                           //c gst amount
                                           dropdownValue3=="IGST" ?
                                           SizedBox(
                                             height:height/21.9,

                                             width:width/14.0,
                                             child: Text(
                                               "IGST(18%):",
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                             ),
                                           ):
                                           SizedBox(
                                             width:width/14.0,
                                             height:height/21.9,
                                             child: Text(
                                               "C GST(9%):",
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                             ),
                                           ),
                                           dropdownValue3=="IGST" ?
                                           SizedBox(
                                             width:width/13.66,
                                             height:height/21.9,
                                             child: Text(
                                               IStfuntion(),
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,
                                                   fontSize: width/85.375),
                                             ),
                                           ):
                                           SizedBox(
                                             width:width/13.66,
                                             height:height/21.9,
                                             child: Text(
                                               Cgst.toStringAsFixed(2),
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,
                                                   fontSize: width/85.375),
                                             ),
                                           ),
                                           SizedBox(height:height/131.4),
                                           //S GSt amount
                                           dropdownValue3=="IGST" ? const SizedBox():
                                           SizedBox(
                                             width:width/15.5,
                                             height:height/21.9,
                                             child: Text(
                                               "S GST(9%):",
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                             ),
                                           ),
                                           dropdownValue3=="IGST" ? const SizedBox(): SizedBox(
                                             width:width/13.66,
                                             height:height/21.9,
                                             child: Text(
                                               sgst.toStringAsFixed(2),
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height:height/65.7),

                                       Row(
                                         children: [
                                           SizedBox(width:width/136.6),
                                           Container(
                                             width:width/10.5,
                                             child: Text(
                                               "Round Value",
                                               style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                             ),
                                           ),
                                           Container(
                                             child:
                                             TextField(
                                               controller: rounof,
                                               keyboardType: TextInputType.multiline,
                                               style: GoogleFonts.openSans(fontSize:width/ 91.06),
                                               decoration: InputDecoration(contentPadding: EdgeInsets.only(left: width/68.3,bottom: height/82.125),
                                                 border: InputBorder.none,
                                               ),
                                               onSubmitted: (_){
                                                 totalamountwithroundof();
                                               },
                                             ),
                                             width: width/6.83,
                                             height: height/16.42,
                                             //color: Color(0xffDDDEEE),
                                             decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                                           ),
                                         ],
                                       ),

                                     ],
                                   )),
                             ),

                             SizedBox(
                                 width: width / 6.0,
                                 height: height/6.8,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     //sub total
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [

                                         Container(
                                           width:width/17.075,
                                           child: Text(
                                             "Sub Total",
                                             style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.indigoAccent,fontSize: width/85.375),
                                           ),
                                         ),

                                         Container(
                                           width:width/13.66,
                                           child: Text(
                                             ": ${totalamount.toStringAsFixed(2)}",
                                             style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.indigoAccent,fontSize: width/85.375),
                                           ),
                                         ),
                                       ],
                                     ),
                                     SizedBox(height:height/131.4),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         SizedBox(
                                           width:width/17.075,
                                           height:height/13.14,
                                           child: Text(
                                             "Total",
                                             style: GoogleFonts.openSans(
                                                 fontWeight: FontWeight.bold,
                                                 color:const Color(0xff00A99D),
                                                 fontSize: width/45.88),
                                           ),
                                         ),
                                         SizedBox(
                                           width:width/9.3,
                                           height:height/13.14,
                                           child: Text(
                                             ":${TotalAmount2.toStringAsFixed(2)}",
                                             style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                                                 textStyle: TextStyle(
                                                     overflow: TextOverflow.ellipsis
                                                 ),
                                                 color: const Color(0xff00A99D), fontSize: width/45.88),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 )),

                           ],
                         ),

                       ],
                     ),
                   ),
                 ),
               )*/
               Padding(
                 padding:
                 EdgeInsets.only(top: height / 131.4, left: width / 27.32),
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
                               child: InkWell(
                                 onTap: () {
                                   setState(() {
                                     Loading = true;
                                   });
                                   print("Clieddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
                                   print(Creadit_days.text);
                                   //document create function
                                   Purchaseitem();
                                   //bill count function
                                   Future.delayed(const Duration(seconds: 4), () {
                                     setState(() {
                                       Loading = false;
                                     });
                                     checkbillno();
                                     clearallcontroller();
                                     clearallcontroller2();
                                     //status update function
                                     Savebillpopup();
                                   });
                                   Future.delayed(const Duration(seconds: 6), () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
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
                                         GoogleFonts.openSans(color: Colors.white),
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
                                         GoogleFonts.openSans(color: Colors.white),
                                       )),
                                 ),
                               ),
                             ),
                           ],
                         ),

                         SizedBox(
                           width: width / 4.0,
                         ),

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
                                                       style: GoogleFonts.openSans(
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
                                                       style: GoogleFonts.openSans(
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
                                                         IStfuntion(),
                                                         style: GoogleFonts.openSans(
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
                                                         Cgst.toStringAsFixed(2),
                                                         style: GoogleFonts.openSans(
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
                                                       style: GoogleFonts.openSans(
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
                                                         sgst.toStringAsFixed(2),
                                                         style: GoogleFonts.openSans(
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
                                                     style: GoogleFonts.openSans(
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
                                                   style: GoogleFonts.openSans(
                                                       color: Colors.black,
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
                                                 style: GoogleFonts.openSans(
                                                     fontWeight: FontWeight.w600,
                                                     color: Colors.indigoAccent,
                                                     fontSize: width / 85.375),
                                               ),
                                             ),
                                           ),
                                           SizedBox(
                                             width: width / 13.66,
                                             child: Text(
                                               ": ${totalamount.toStringAsFixed(2)}",
                                               style: GoogleFonts.openSans(
                                                   fontWeight: FontWeight.w600,
                                                   color: Colors.indigoAccent,
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
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Padding(
                                             padding:  EdgeInsets.only(left:width/227.66),
                                             child: SizedBox(

                                               width: width / 17.075,
                                               height: height / 13.14,
                                               child: Text(
                                                 "Total",
                                                 style: GoogleFonts.openSans(
                                                     fontWeight: FontWeight.bold,
                                                     color:  Colors.white,
                                                     fontSize: width / 55.88),
                                               ),
                                             ),
                                           ),
                                           SizedBox(
                                             width: width / 12.8,
                                             height: height / 13.14,
                                             child: Text(
                                               ":${TotalAmount2.toStringAsFixed(2)}",
                                               style: GoogleFonts.openSans(
                                                   fontWeight: FontWeight.bold,
                                                   textStyle: const TextStyle(
                                                       overflow:
                                                       TextOverflow.ellipsis),
                                                   color:  Colors.white,
                                                   fontSize: width / 55.88),
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
               )
             ],
           ),
           Loading == true
               ? SizedBox(
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
                     style: GoogleFonts.openSans(
                         fontWeight: FontWeight.w600, color: Colors.black))
               ],
             ),
           )
               : const SizedBox(),
         ],
       ),);
  }


  //supplier functuon start

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
                            style: GoogleFonts.openSans(
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
                          child: Text("Supplier Name *",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: width/9.486,top: height/82.125),
                          child: Text("Supplier Code*",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white)),),

                        Padding(
                          padding:  EdgeInsets.only(left: width/9.757,top: height/82.125),
                          child: Text("Supplier Address *",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
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
                              style: GoogleFonts.openSans(fontSize:width/91.06),
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
                            style: GoogleFonts.openSans(fontSize: width/136.6),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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
                          child: Text("State",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/6.266,top: height/32.85),
                          child: Text("City",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:width/5.991,top: height/32.85),
                          child: Text("Pincode",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/8.130,top: height/32.85),
                          child: Text("Mobile Number",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: width/12.418,top: height/32.85),
                          child: Text("Mobile Number-2",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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

                          child: Text("EMail Id",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: width/6.898,top: height/32.85),
                          child: Text("GST Number",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
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
                              style: GoogleFonts.openSans(fontSize:width/91.06),
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
                            style: GoogleFonts.openSans(fontSize:width/91.06),
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
                      child: Text("Remarks",style: GoogleFonts.openSans(fontSize:width/97.57,color: Colors.white),),
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
                        style: GoogleFonts.openSans(fontSize:width/91.06),
                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3),
                          hintStyle: GoogleFonts.openSans(color: Colors.black),
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
                            GoogleFonts.openSans(color: Colors.white,fontSize:width/91.06),)),
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
                                color: const Color(0xff00A0E3),),child: Center(child: Text("Reset",style: GoogleFonts.openSans(color: Colors.white),)),
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
                    Text("Add a Supplier Item Successfully",style: GoogleFonts.openSans(
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/9.588,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                    "Okay",
                                    style: GoogleFonts.openSans(
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
                                    style: GoogleFonts.openSans(
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
      Payments = Payment.first;
      dropdownValue3=list3.first;
    });
    //purchase Date
    //purchase NOtes
    purchase_notes.clear();
    //purchase number
    purchase_No.clear();
    //suppierid
    Creadit_days.clear();
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


  //total Amount
  //total Amount



  Totalamounts(){
    setState(() {
      TotalAmount2=0;
    });

    if(status2==true) {
      setState(() {
        TotalAmount2 = totalamount + sgst + Cgst;
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
      setState(() {
        Cgst =salespriceff-(salespriceff/(1.09));
      });
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

  savebillfunction(){
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).update({
      "save":true
    });
    FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).update({
      "save":true
    });
    FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).update({
      "save":true
    });
  }


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


  String itemdocuid='';

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

    /*FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).set({
      "Total": "",
      "itemcode":itemcode,
      "Payment mode":Payments,
      "Hsncode": hsncpode,
      "suppilerid":suppierid.text,
      "suppilername":suppiler_name.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "tax":taxitem.text,
      "suppilierinvoiceno":suppiler_invoice.text,
      "state":dropdownValue4==""?"Tamil Nadu":dropdownValue4,
      "IMEI NO":itemimei,
      "Serial NO":itemserial,
      "Color":itemcolor,
      "credit days":Creadit_days.text,
      "BoxNo":Boxno,
      "save":false,
      "time":DateFormat.jm().format(DateTime.now()),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });

    if(status==true){
      FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).update({
        "Total": "",
        "itemcode":itemcode,
        "Payment mode":Payments,
        "Hsncode": hsncpode,
        "suppilerid":suppierid.text,
        "suppilername":suppiler_name.text,
        "purchaseno":purchase_No.text,
        "purchasedate":purchase_Date.text,
        "purchasenote":purchase_notes.text,
        "tax":taxitem.text,
        "suppilierinvoiceno":suppiler_invoice.text,
        "state":dropdownValue4==""?"Tamil Nadu":dropdownValue4,
        "IMEI NO":itemimei,
        "Serial NO":itemserial,
        "Color":itemcolor,
        "credit days":Creadit_days.text,
        "BoxNo":Boxno,
        "save":false,
        "time":DateFormat.jm().format(DateTime.now()),
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch
      });
    }

    if(status2==true){
      FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).update({
        "Total": "",
        "itemcode":itemcode,
        "Payment mode":Payments,
        "Hsncode": hsncpode,
        "suppilerid":suppierid.text,
        "suppilername":suppiler_name.text,
        "purchaseno":purchase_No.text,
        "purchasedate":purchase_Date.text,
        "purchasenote":purchase_notes.text,
        "state":dropdownValue4==""?"Tamil Nadu":dropdownValue4,
        "tax":taxitem.text,
        "suppilierinvoiceno":suppiler_invoice.text,
        "IMEI NO":itemimei,
        "Serial NO":itemserial,
        "Color":itemcolor,
        "credit days":Creadit_days.text,
        "BoxNo":Boxno,
        "save":false,
        "time":DateFormat.jm().format(DateTime.now()),
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch
      });
    }*/

    checkgst(Purchase_price.text,Qty.text);

  }

  collectioncreatefunction(valueitem2,pprice,sprice,landingcost,docid)
  {

    print(valueitem2);
    print(pprice);
    print(sprice);
    print(landingcost);
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).
    collection(widget.docid.toString()).doc(docid).update({
      "Total": valueitem2!=""? double.parse(valueitem2.toString()).toStringAsFixed(2): 0,
      "Payment mode":Payments,
      "itemcode":status==true?"G$itemcode":"N$itemcode",
      "Hsncode": HSN_Code.text,
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
      "Purchase price":pprice !=""? double.parse(pprice.toString()).toStringAsFixed(2) :0,
      "Sales price": sprice !=""?double.parse(sprice.toString()).toStringAsFixed(2): 0,
      "Qty": Qty.text,
      "Landing cost": landingcost !=""?double.parse(landingcost.toString()).toStringAsFixed(2) :0,
      "IMEI NO":itemimei,
      "Serial NO":itemserial,
      "Color":itemcolor,
      "credit days":Creadit_days.text,
      // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "Description":"${itemname.text},${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "IMSlist":IMEISERIAL,
    });


    if(status==true) {
      FirebaseFirestore.instance.collection("Purchase ShabikaG").
      doc(widget.docid).collection(widget.docid.toString()).doc(docid).update({
        "Total": valueitem2!=""? double.parse(valueitem2.toString()).toStringAsFixed(2): 0,
        "Payment mode": Payments,
        "itemcode": status == true ? "G$itemcode" : "",
        "Hsncode": HSN_Code.text,
        "suppilerid": suppierid.text,
        "suppilername": suppiler_name.text,
        "purchaseno": status == true ? 'G${purchase_No.text}' : "",
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "suppilierinvoiceno": suppiler_invoice.text,
        "time": DateFormat.jm().format(DateTime.now()),
        "date": "${DateTime
            .now()
            .day}/${DateTime
            .now()
            .month}/${DateTime
            .now()
            .year}",
        "timestamp": DateTime
            .now()
            .microsecondsSinceEpoch,
        "Category": itemcat,
        "Brand": itembrand,
        "Item": itemname.text,
        "Purchase price":pprice !=""? double.parse(pprice.toString()).toStringAsFixed(2) :0,
        "Sales price": sprice !=""?double.parse(sprice.toString()).toStringAsFixed(2): 0,
        "Qty": Qty.text,
        "Landing cost": landingcost !=""?double.parse(landingcost.toString()).toStringAsFixed(2) :0,
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
        "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL
            .toString() : ""}",
        "IMSlist": IMEISERIAL,
      });
    }
    if(status2==true) {
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(widget.docid)
          .collection(widget.docid.toString())
          .doc(docid)
          .update({
        "Total": valueitem2!=""? double.parse(valueitem2.toString()).toStringAsFixed(2): 0,
        "Payment mode": Payments,
        "itemcode": status2 == true ? "N$itemcode" : "",
        "Hsncode": HSN_Code.text,
        "suppilerid": suppierid.text,
        "suppilername": suppiler_name.text,
        "purchaseno": "N${purchase_No.text}",
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "suppilierinvoiceno": suppiler_invoice.text,
        "time": DateFormat.jm().format(DateTime.now()),
        "date": "${DateTime
            .now()
            .day}/${DateTime
            .now()
            .month}/${DateTime
            .now()
            .year}",
        "timestamp": DateTime
            .now()
            .microsecondsSinceEpoch,
        "Category": itemcat,
        "Brand": itembrand,
        "Item": itemname.text,
        "Purchase price":pprice !=""? double.parse(pprice.toString()).toStringAsFixed(2) :0,
        "Sales price": sprice !=""?double.parse(sprice.toString()).toStringAsFixed(2): 0,
        "Qty": Qty.text,
        "Landing cost": landingcost !=""?double.parse(landingcost.toString()).toStringAsFixed(2) :0,
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
        "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL
            .toString() : ""}",
        "IMSlist": IMEISERIAL,
      });
    }

    updatetotal();
  }


  Purchaseitem() {
    print("Purchase Entru enterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
   setState((){
     creditdate= DateTime(
       Creadit_days.text==""?
       DateTime.now().day + 0: DateTime.now().day + int.parse(Creadit_days.text),
       DateTime.now().month,DateTime.now().year,
     );
   });

    print(Creadit_days.text);
    print("Controllerrrrrr${Creadit_days.text}");
    print("creatdate ${creditdate.day}");
    print("creatdate ${creditdate.month}");
    print("creatdate ${creditdate.year}");
    print("creatdate ${creditdate.day}/${creditdate.month}/${creditdate.year}-------------------------------------------------------");
    print("Cureent dataeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee----enddddddd");
    if(status==true){
      FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).update({
        "Total": totalamount.toStringAsFixed(2),
        "SGST": sgst.toStringAsFixed(2),
        "CGST": Cgst.toStringAsFixed(2),
        "Payment mode": Payments,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        'credit days':Creadit_days.text,
        "credit date":"${creditdate.day}/${creditdate.month}/${creditdate.year}",
        'date':  purchase_Date.text,
        'purchaseno': purchase_No.text,
        'purchasenote':purchase_notes.text,
        'suppilierinvoiceno':suppiler_invoice.text,
        'suppilerid':suppierid.text,
        'suppilername':suppiler_name.text,
        'suppilergst':suppiler_gstno.text,
      });
    }
    if(status2==true){

      FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).update({
        "Total": totalamount.toStringAsFixed(2),
        "SGST": sgst.toStringAsFixed(2),
        "CGST": Cgst.toStringAsFixed(2),
        "Payment mode": Payments,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        'credit days':Creadit_days.text,
        "credit date":"${creditdate.day}/${creditdate.month}/${creditdate.year}",
        'date':  purchase_Date.text,
        'purchaseno': purchase_No.text,
        'purchasenote':purchase_notes.text,
        'suppilierinvoiceno':suppiler_invoice.text,
        'suppilerid':suppierid.text,
        'suppilername':suppiler_name.text,
        'suppilergst':suppiler_gstno.text,

      });



    }
    if(itemdocuid.isNotEmpty){
    FirebaseFirestore.instance.collection("Item").doc(itemdocuid).update({
      "IMSlist":IMEISERIAL,
      "Imei no":IMEI,
      "Serial no":SERIAL,
      "color":colorlist,
    });
  }
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).update({
      "Total": totalamount.toStringAsFixed(2),
      "SGST": sgst.toStringAsFixed(2),
      "CGST": Cgst.toStringAsFixed(2),
      "Payment mode": Payments,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
      'credit days':Creadit_days.text,
      "credit date":"${creditdate.day}/${creditdate.month}/${creditdate.year}",
      'date':  purchase_Date.text,
      'purchaseno': purchase_No.text,
      'purchasenote':purchase_notes.text,
      'suppilierinvoiceno':suppiler_invoice.text,
      'suppilerid':suppierid.text,
      'suppilername':suppiler_name.text,
      'suppilergst':suppiler_gstno.text,
    });

    setState(() {
      Destription.add("${itemname.text},$itembrand,$itemcat${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}");
      Quvantity.add(Qty.text);
      Totalamount.add(valueitem.text);
      Tax.add(taxitem.text);
      Items.add(itemname.text);
      Rate.add(Purchase_price.text);
      HSNcode.add(HSN_Code.text);
    });


  }

  List Destription=[];
  List Quvantity=[];
  List Totalamount=[];
  List Tax=[];
  List Items=[];
  List Rate=[];
  List HSNcode=[];



  updatetotal() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance
        .collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }

    CGSTfunction();

    SGSTfunction();

    Totalamounts();
    if(status2==true) {
      FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(
          widget.docid).update({
        "Total": totalamount
      });
    }
    if(status==true) {
      FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(
          widget.docid).update({
        "Total": totalamount
      });
    }
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).update({
      "Total":totalamount
    });




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

  deletecollection(id) {
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).doc(id).delete();
    FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).collection(widget.docid.toString()).doc(id).delete();
    FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).collection(widget.docid.toString()).doc(id).delete();

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
    var document = await FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).get();
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

  List IMEI=[];
  List SERIAL=[];
  List colorlist=[];
  List Imagelist = [];
  bool popupLoading = false;
  bool popupLoading2 = false;
  bool Loading2 = false;

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
                    Text("This Customer Already Exist in List.....",style: GoogleFonts.openSans(
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
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height/16.425,
                          width: width/7.588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                                "Okay",
                                style: GoogleFonts.openSans(
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



  showtextfield(Quvantity,serial,imei,color,image){

    setState(() {
      IMEISERIAL.clear();
      IMEI.clear();
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

                          Text("Add IMEI And SERIAL No ",style: GoogleFonts.openSans(),),

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
                                  child: SizedBox(

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
                                                  child: Text("IMEi No",style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),
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
                                                      style: GoogleFonts.openSans(),
                                                      controller: _controller[index],
                                                      decoration: InputDecoration(
                                                        hintText: "Enter the IMEI NO",
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(left:width/136.6),
                                                        hintStyle: GoogleFonts.openSans(),
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
                                                  child: Text("Serial No",style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),

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
                                                        style: GoogleFonts.openSans(),
                                                        controller: _controller2[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Enter the Serial NO",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle: GoogleFonts.openSans(),
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
                                                  child: Text("Color",style: GoogleFonts.openSans(fontWeight: FontWeight.w600),)),

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
                                                        style: GoogleFonts.openSans(),
                                                        controller: _controller3[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Color",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle: GoogleFonts.openSans(),
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
                                      IMEI.add(_controller[i].text);
                                      SERIAL.add(_controller2[i].text);
                                      colorlist.add(_controller3[i].text);
                                    });
                                  }

                                  collectioncreatefunction(valueitem.text,Purchase_price.text,Sales.text,Landing_cost.text,"");



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
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/16.425,
                                    width: width/7.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                          "kay",
                                          style: GoogleFonts.openSans(
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
                                          style: GoogleFonts.openSans(
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

  ///"Save bill message"--popup function
  Savebillpopup() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.4, bottom: height / 4.4),
          child: SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: const Color(0xff264656),
                content: SizedBox(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 99.85,
                      ),
                      Text(
                        "Save Purchase Bill Succesfully..",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 53.85,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Material(
                      //         elevation: 15,
                      //         color: const Color(0xff25D366),
                      //         borderRadius: BorderRadius.circular(5),
                      //         child: Container(
                      //           height: height / 16.425,
                      //           width: width / 9.588,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             color: const Color(0xff25D366),
                      //           ),
                      //           child: Center(
                      //             child: Text("Okay",
                      //                 style: GoogleFonts.openSans(
                      //                     letterSpacing: 1.5,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: width / 85.375,
                      //                     color: Colors.white)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: width / 68.3),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Material(
                      //         elevation: 15,
                      //         color: const Color(0xff263646),
                      //         borderRadius: BorderRadius.circular(5),
                      //         child: Container(
                      //           height: height / 16.425,
                      //           width: width / 9.588,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             color: Colors.white,
                      //           ),
                      //           child: Center(
                      //             child: Text("Cancel",
                      //                 style: GoogleFonts.openSans(
                      //                     letterSpacing: 1.5,
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: width / 85.375,
                      //                     color: Colors.black)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                )),
          ),
        );
      },
    );
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
double  ISgtvalue=0;
  IStfuntion(){
    setState((){
      ISgtvalue=0;
    });
    ISgtvalue=Cgst+sgst;

    return ISgtvalue.toStringAsFixed(2);
  }
  ///Quvantity change to set the imei and serial no and image list listview builder function

  List IMEI2 = [];
  List SERIAL2 = [];
  List colorlist2 = [];

  showquvantitytextfield(Quvantity, serial, imei, color,images,docid,itemname2,purchaseid,valueitem,pprice,sprice,landingcost) {

    print("Quvantity controlllerrrrrrrrrr");
    print(Quvantity);
    print(IMEI.length);
    print(colorlist.length);
    print(SERIAL.length);

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    List<TextEditingController> _controller = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 = List.generate(Quvantity, (index) => TextEditingController());
    List<List> Imagelistitem= List<List>.generate(Quvantity,(index) =>[]);

    if(imei==true){
      for(int i=0;i<Quvantity;i++){
        setState(() {
          _controller[i].text=IMEI[i];
        });
        if(IMEI.length<Quvantity){
          setState((){
            IMEI.add("");
          });
        }
      }

    }

    if(serial==true){
      for(int i=0;i<Quvantity;i++){
        setState(() {
          _controller2[i].text=SERIAL[i];

        });
        if(SERIAL.length<Quvantity){
          setState((){
            SERIAL.add("");
          });
        }
      }

    }

    if(color==true){
      for(int i=0;i<Quvantity;i++){
        setState(() {
          _controller3[i].text=colorlist[i];

        });
        if(colorlist.length<Quvantity){
          setState((){
            colorlist.add("");
          });
        }
      }

    }

    if(images==true){
      for(int i=0;i<Imagelist.length;i++){
        setState(() {
          Imagelistitem[i]=Imagelist[i];

        });
        if(Imagelist.length<Quvantity){
          setState((){
            Imagelist.add("");
          });
        }
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
                padding: EdgeInsets.only(
                  left: width / 136.66,
                  right: width / 136.66,
                ),
                child: Scaffold(
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: height / 1.02,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(
                                height: height / 131.4,
                              ),

                              Text(
                                "Add IMEI No/SERIAL No/Color/Image ",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700
                                ),
                              ),

                              SizedBox(
                                height: height / 131.4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //imei and serial and color textfield

                                  serial == true ||
                                      imei == true ||
                                      color == true
                                      ? SizedBox(
                                    height: height / 1.15,
                                    width: width / 1.821,
                                    child: ListView.builder(
                                      itemCount: Quvantity,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: width / 4.55),
                                          child: SizedBox(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                imei == true
                                                    ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                      width /
                                                          341.5,
                                                      vertical:
                                                      height /
                                                          164.25),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: width /
                                                              11.38,
                                                          child:
                                                          Text(
                                                            "IMEi No",
                                                            style: GoogleFonts.openSans(
                                                                fontWeight:
                                                                FontWeight.w700),
                                                          )),
                                                      SizedBox(
                                                          width: width /
                                                              136.6),
                                                      Material(
                                                          color: Colors
                                                              .white,
                                                          elevation:
                                                          20,
                                                          shadowColor:
                                                          Colors
                                                              .black12,
                                                          child:
                                                          Container(
                                                            height: height /
                                                                16.425,
                                                            width: width /
                                                                4.55,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(5),
                                                                color: Colors.grey.shade200),
                                                            child:
                                                            TextField(
                                                              style:
                                                              GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                              controller:
                                                              _controller[index],
                                                              decoration:
                                                              InputDecoration(
                                                                hintText:
                                                                "Enter the IMEI NO",
                                                                border:
                                                                InputBorder.none,
                                                                contentPadding:
                                                                EdgeInsets.only(left: width / 136.6),
                                                                hintStyle:
                                                                GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                              ),
                                                              onSubmitted:
                                                                  (_) {},
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                )
                                                    : const SizedBox(),
                                                serial == true
                                                    ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                      width /
                                                          341.5,
                                                      vertical:
                                                      height /
                                                          164.25),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: width /
                                                              11.38,
                                                          child:
                                                          Text(
                                                            "Serial No",
                                                            style: GoogleFonts.openSans(
                                                                fontWeight:
                                                                FontWeight.w700),
                                                          )),
                                                      SizedBox(
                                                          width: width /
                                                              136.6),
                                                      Material(
                                                          color: Colors
                                                              .white,
                                                          elevation:
                                                          20,
                                                          shadowColor:
                                                          Colors
                                                              .black12,
                                                          child: Container(
                                                              height: height / 16.425,
                                                              width: width / 4.55,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade200),
                                                              child: TextField(
                                                                style:
                                                                GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                                controller:
                                                                _controller2[index],
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: "Enter the Serial NO",
                                                                  border: InputBorder.none,
                                                                  contentPadding: EdgeInsets.only(left: width / 136.6),
                                                                  hintStyle: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                                ),
                                                                onSubmitted:
                                                                    (_) {},
                                                              ))),
                                                    ],
                                                  ),
                                                )
                                                    : const SizedBox(),
                                                color == true
                                                    ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                      width /
                                                          341.5,
                                                      vertical:
                                                      height /
                                                          164.25),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: width /
                                                              11.38,
                                                          child:
                                                          Text(
                                                            "Color",
                                                            style: GoogleFonts.openSans(
                                                                fontWeight:
                                                                FontWeight.w700),
                                                          )),
                                                      SizedBox(
                                                          width: width /
                                                              136.6),
                                                      Material(
                                                          color: Colors
                                                              .white,
                                                          elevation:
                                                          20,
                                                          shadowColor:
                                                          Colors
                                                              .black12,
                                                          child: Container(
                                                              height: height / 16.425,
                                                              width: width / 4.55,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade200),
                                                              child: TextField(
                                                                style:
                                                                GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                                controller:
                                                                _controller3[index],
                                                                decoration:
                                                                InputDecoration(
                                                                  hintText: "Color",
                                                                  border: InputBorder.none,
                                                                  contentPadding: EdgeInsets.only(left: width / 136.6),
                                                                  hintStyle: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                                ),
                                                                onSubmitted:
                                                                    (_) {},
                                                              ))),
                                                    ],
                                                  ),
                                                )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                      : SizedBox(width: width / 3.415),

                                  //image secelction
                                  images==true?
                                  SizedBox(
                                    width: width / 2.732,
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(4),
                                          ),
                                          width: width / 20.732,
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: height / 131.4),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width / 170.75,
                                                  ),
                                                  child: Text(
                                                    "Image",
                                                    style:
                                                    GoogleFonts.openSans(
                                                        fontWeight:
                                                        FontWeight
                                                            .w700),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height / 131.4),
                                                const Divider(),
                                                SizedBox(
                                                  width: width / 2.732,
                                                  child: ListView.builder(
                                                    itemCount: int.parse(Qty.text),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return
                                                        SizedBox(
                                                          width: width / 2.732,
                                                          height:height/4.38,
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: ListView.builder(
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemCount: Imagelistitem[index].length,
                                                                  itemBuilder: (context, index2) {
                                                                    return
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: width / 13.66,
                                                                            child: Column(
                                                                              children: [
                                                                                Text("Product Img${index2+1}",style: GoogleFonts.openSans(fontWeight: FontWeight.w700),),
                                                                                Padding(
                                                                                    padding: EdgeInsets
                                                                                        .symmetric(
                                                                                      vertical:
                                                                                      height / 82.125,
                                                                                      horizontal:
                                                                                      width / 170.75,
                                                                                    ),
                                                                                    child:
                                                                                    Material(
                                                                                      elevation: 20,
                                                                                      borderRadius:
                                                                                      BorderRadius.circular(4),
                                                                                      color: const Color(0xffe6ebef),
                                                                                      shadowColor: Colors.grey.shade100,
                                                                                      child: Container(
                                                                                          height: height / 6.212,
                                                                                          decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(4),
                                                                                              color: const Color(0xffe6ebef),
                                                                                              image: DecorationImage(fit: BoxFit.cover,
                                                                                                  image: Imagelistitem[index][index2] != "" && Imagelistitem[index][index2] != "loading"
                                                                                                      ? NetworkImage(Imagelistitem[index][index2].toString())
                                                                                                      : const NetworkImage(
                                                                                                      ""))),
                                                                                          child: Center(
                                                                                              child: Imagelistitem[index]== "loading" ?
                                                                                              const CircularProgressIndicator():
                                                                                              Icon(Icons.add, color: const Color(0xffa3c9e2),
                                                                                                size: width / 34.15,
                                                                                              ))),
                                                                                    )
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                  },),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(
                                                                  vertical: height/82.125,
                                                                  horizontal: width/170.75,
                                                                ),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState((){
                                                                      Loading2=true;
                                                                    });
                                                                    InputElement input =
                                                                    FileUploadInputElement()
                                                                    as InputElement
                                                                      ..accept = 'image/*';
                                                                    FirebaseStorage fs =
                                                                        FirebaseStorage
                                                                            .instance;
                                                                    input.click();
                                                                    input.onChange
                                                                        .listen(
                                                                            (event) {
                                                                          final file = input
                                                                              .files!.first;
                                                                          final reader =
                                                                          FileReader();
                                                                          reader.readAsDataUrl(file);
                                                                          reader.onLoadEnd.listen(
                                                                                  (event) async {
                                                                                var snapshot = await fs.ref().child('ImageLIst').child(file.name).putBlob(file);
                                                                                String downloadUrl = await snapshot.ref.getDownloadURL();
                                                                                setState(() {
                                                                                  Imagelistitem[index].add(downloadUrl);
                                                                                  Imagelist=Imagelistitem;
                                                                                  Loading2=false;
                                                                                });

                                                                              });
                                                                        });
                                                                  },
                                                                  child: Material(
                                                                      elevation: 15,
                                                                      borderRadius: BorderRadius.circular(100),
                                                                      child:  Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child:
                                                                        Loading2==true?const CircularProgressIndicator():
                                                                        const Icon(Icons.add),
                                                                      )),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ):
                                  const SizedBox(),
                                ],
                              ),

                              //button okay and cancle.....
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //okay button
                                  InkWell(
                                    onTap: () {
                                      print("ime save-1");
                                      print("ime save-1++++++++++++++++++++++++++++++++++++++++++++++++++++");
                                      setState(() {
                                        popupLoading=true;
                                      });
                                      print("ime save-2");
                                      for (int i = 0; i < Quvantity; i++) {
                                        setState(() {
                                          IMEISERIAL.add("${_controller[i].text}${_controller2[i].text}${_controller3[i].text}");
                                          IMEI.add(_controller[i].text);
                                          IMEI2.add(_controller[i].text);
                                          SERIAL.add(_controller2[i].text);
                                          SERIAL2.add(_controller2[i].text);
                                          colorlist.add(_controller3[i].text);
                                          colorlist2.add(_controller3[i].text);
                                        });
                                      }
                                      print("ime save-3");
                                      print(docid);
                                      print(purchaseid);
                                      print("ime save-5");
                                      print("ime save - 6");
                                      FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).collection(widget.docid!).doc(purchaseid).update({
                                        "Description":  "${itemname2},${itemimei==true ? IMEI2.toString() : ""}${itemcolor==true ? colorlist2.toString() : ""}${itemserial==true ? SERIAL.toString() : ""}",
                                        "IMSlist": IMEISERIAL,
                                        "Imei no": IMEI2,
                                        "Serial no": SERIAL2,
                                        "color": colorlist2,
                                      });
                                      print("Checnkfghgfhfghfghfghgfhfg");
                                      print(IMEISERIAL);
                                      print(IMEI);
                                      print(SERIAL);
                                      print(colorlist);
                                      for (int j=0;j<Imagelist.length;j++){

                                        if(status==true){
                                          FirebaseFirestore.instance.collection("Item ShabikaG").
                                          doc(itemdocuid).collection("Image").doc().set({
                                            "Image list1": Imagelist[j].length>0?Imagelist[j][0]:"",
                                            "Image list2": Imagelist[j].length>1?Imagelist[j][1]:"",
                                            "Image list3": Imagelist[j].length>2?Imagelist[j][2]:"",
                                            "Image list4": Imagelist[j].length>3?Imagelist[j][3]:"",
                                            "Image list5": Imagelist[j].length>4?Imagelist[j][4]:"",
                                            "Image list6": Imagelist[j].length>5?Imagelist[j][5]:"",
                                          });
                                        }

                                        if(status2==true){
                                          FirebaseFirestore.instance.collection("Item ShabikaN").doc(itemdocuid).
                                          collection("Image").doc().set({
                                            "Image list1": Imagelist[j].length>0?Imagelist[j][0]:"",
                                            "Image list2": Imagelist[j].length>1?Imagelist[j][1]:"",
                                            "Image list3": Imagelist[j].length>2?Imagelist[j][2]:"",
                                            "Image list4": Imagelist[j].length>3?Imagelist[j][3]:"",
                                            "Image list5": Imagelist[j].length>4?Imagelist[j][4]:"",
                                            "Image list6": Imagelist[j].length>5?Imagelist[j][5]:"",
                                          });
                                        }

                                      }
                                      print("Checnkfghgfhfghfghfghgfhfg++++++++");
                                      collectioncreatefunction(valueitem,pprice,sprice,landingcost,docid);
                                      print("Checnkfghgfhfghfghfghgfhfg++++JJJ++++");
                                      if(status==true){
                                        FirebaseFirestore.instance.collection("Item ShabikaG").doc(docid).update({
                                          "Imei no": IMEI,
                                          "Serial no": SERIAL,
                                          "color": colorlist,
                                        });
                                      }

                                      if(status2==true){
                                        FirebaseFirestore.instance.collection("Item ShabikaN").doc(docid).update({
                                          "Imei no": IMEI,
                                          "Serial no": SERIAL,
                                          "color": colorlist,
                                        });
                                      }
                                      setState(() {
                                        popupLoading = false;

                                      });
                                      for (int k = 0; k < Quvantity; k++) {
                                        setState((){
                                          _controller[k].clear();
                                          _controller2[k].clear();
                                          _controller3[k].clear();
                                        });
                                      }
                                      print("ime save-4");
                                      Future.delayed(const Duration(milliseconds: 1800), () {

                                        setState(() {
                                          IMEI.clear();
                                          IMEI2.clear();
                                          SERIAL.clear();
                                          SERIAL2.clear();
                                          colorlist.clear();
                                          colorlist2.clear();
                                          IMEISERIAL.clear();
                                        });
                                        Navigator.pop(context);
                                      });
                                      print("ime save-6");
                                    },
                                    child: Material(
                                      elevation: 15,
                                      color: const Color(0xff25D366),
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: height / 16.425,
                                        width: width / 7.588,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: const Color(0xff25D366),
                                        ),
                                        child: Center(
                                          child: Text("Oky",
                                              style: GoogleFonts.openSans(
                                                  letterSpacing: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width / 85.375,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: width / 136.6),

                                  //cancel buttton
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Material(
                                      elevation: 15,
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: height / 16.425,
                                        width: width / 7.588,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: const Color(0xff263646),
                                        ),
                                        child: Center(
                                          child: Text("Cancel",
                                              style: GoogleFonts.openSans(
                                                  letterSpacing: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width / 85.375,
                                                  color: Colors.white)),
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
                      image == false
                          ? popupLoading == true
                          ? const CircularProgressIndicator()
                          : const SizedBox()
                          : const SizedBox()
                    ],
                  ),
                ));
          },
        );
      },
    );



  }

}

