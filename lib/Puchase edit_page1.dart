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
  TextEditingController Purchase_price = new TextEditingController();
  TextEditingController Qty = new TextEditingController();
  TextEditingController Landing_cost = new TextEditingController();
  TextEditingController Mrp_Price = new TextEditingController();
  TextEditingController Location = new TextEditingController();
  TextEditingController Supplier = new TextEditingController();
  TextEditingController IMEI_No = new TextEditingController();
  TextEditingController Serial_NO = new TextEditingController();
  TextEditingController Invoice_NO = new TextEditingController();
  TextEditingController Invoice_date = new TextEditingController();
  TextEditingController Creadit_days = new TextEditingController();

  //hasn code and box no copntroller
  TextEditingController Box_NO = new TextEditingController();
  TextEditingController HSN_Code = new TextEditingController();
  TextEditingController Sales = new TextEditingController();

  //purchase number
  TextEditingController purchase_No = new TextEditingController();
  //Based on
  TextEditingController Basedon = new TextEditingController();
  //purchase Date
  TextEditingController purchase_Date = new TextEditingController();
  //purchase NOtes
  TextEditingController purchase_notes = new TextEditingController();
  //suppierid
  TextEditingController suppierid = new TextEditingController();
  //suppiler name
  TextEditingController suppiler_name = new TextEditingController();
  //suppiler invoiceno
  TextEditingController suppiler_invoice = new TextEditingController();

  TextEditingController suppiler_gstno = new TextEditingController();
  //itemid
  TextEditingController itemid = new TextEditingController();
  //item name
  TextEditingController itemname = new TextEditingController();

  //tax
  TextEditingController taxitem = new TextEditingController();
  TextEditingController valueitem = new TextEditingController();

  int vaalue = 0;

  //billed and shipped to text controller
  TextEditingController Billedto = new TextEditingController();
  TextEditingController Shippedto = new TextEditingController();
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
    //checkbillno();
    itemaddfunction();
    getvalues();
    edittoltalamount();

    // TODO: implement initState
    super.initState();
  }
  NumberFormat F=new NumberFormat('00');
  int itemcodes=0;

  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"SB"}${F.format(itemcodes)}";
    });
    print(Suppliercode.text);

  }

  setsuppierid(suppierids) async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    for(int i=0;i<document.docs.length;i++){
      if(suppierids==document.docs[i]['Suppliername']){
        setState(() {
          suppierid.text=document.docs[i]['Suppliercode'];
        });
      }
      print(suppierid.text.toString());
    }



  }


  List<String> supplier=[];
  String itemnames='';

  Userdata()async {
    setState(() {
      supplier.clear();
    });
    var details = await FirebaseFirestore.instance.collection("Supplier").get();
    print(supplier);
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        supplier.add(details.docs[i]["Suppliername"]);
      });
      print(supplier);
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
    print(Itemlist);

  }

  List <String>Suppierlist=[];

  suppiernameaddfunction()async{
    print("suppier name dropdown");
    setState(() {
      Suppierlist.clear();
    });

    var Document=await FirebaseFirestore.instance.collection('Supplier').
    orderBy("Suppliername",descending: false).get();
    for(int i=0;i<Document.docs.length;i++){
      Suppierlist.add(Document.docs[i]['Suppliername']);
    }
    print(Suppierlist);

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

    print(_typeAheadControllergender.text);

  }

  List <String>Tagitemlists= <String>[];

  tagaddfunction()async{
    var tagdocument=await FirebaseFirestore.instance.collection('Item').get();
    for(int i=0;i<tagdocument.docs.length;i++){
      setState(() {
        Tagitemlists.add(tagdocument.docs[i]['Tags']);
      });
    }
    print("Tagitemlistssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    print(Tagitemlists);
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


  getvalues()async{
    var document=await FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).get();
    Map<String,dynamic>?values=document.data();
    setState((){

      Box_NO.text=values!['BoxNo'];
      Payments=values['Payment mode'];
      HSN_Code.text=values['Hsncode'];
      sgst=double.parse(values['Total'].toString());
      Creadit_days.text=values['credit days'];
      purchase_Date.text=values['date'];
      itemid.text=values['itemcode'];
      purchase_No.text=values['purchaseno'];
      purchase_notes.text=values['purchasenote'];
      suppiler_invoice.text=values['suppilierinvoiceno'];
      suppierid.text=values['suppilerid'];
      _typeAheadControllergender9.text=values['suppilername'];
      suppiler_gstno.text=values['suppilergst'];
      taxitem.text=values['tax'];
      Cgst=double.parse(values['CGST'].toString());
      sgst=double.parse(values['SGST'].toString());

    });
  }

  final TextEditingController _typeAheadControllergender9 = TextEditingController();

  SuggestionsBoxController suggestionBoxController9 = SuggestionsBoxController();
  List<String> getSuggestionsgender9(String query) {
    List<String> matches = <String>[];
    matches.addAll(Suppierlist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //Purchase_Entry
      Scaffold(
        backgroundColor:Color(0xff00A99D),
       body: Column(
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
                   inactiveColor: Color(0xffC9C9C9),
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
                   inactiveColor: Color(0xffC9C9C9),
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
                                   fontSize: width/97.57, color: Color(0xff000000)),
                             ),
                             SizedBox(
                               width: width/22.03,
                             ),
                             Container(
                               width: width/3.415,
                               height: height/21.9,
                               //color:Colors.white,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                               ),
                               child: TextField(
                                 style: GoogleFonts.montserrat(
                                   fontWeight:FontWeight.w700,
                                 ),
                                 controller: suppierid,
                                 focusNode: suppier_id,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(
                                       left:width/130, bottom: height / 36.5),
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
                                         Text("New Suppiler"),
                                         SizedBox(width:width/455.33),
                                         Icon(Icons.add),
                                       ],
                                     )),
                               ):
                               ClipOval(
                                   child:
                                   Container(
                                       height:height/21.9,
                                       width:width/45.53,
                                       color: Colors.white,
                                       child: Icon(Icons.add))),
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
                                   fontSize: width/97.57, color: Color(0xff000000)),
                             ),
                             SizedBox(
                               width: width/42.687,
                             ),
                             Container(
                               width: width/3.415,
                               height: height/21.9,
                               //color:Colors.white,
                               decoration: BoxDecoration(
                                 color: Colors.white,),
                               child:

                              /* Padding(
                                 padding: EdgeInsets.only(
                                     left:width/130,bottom:height/height/65.7),
                                 child: LayoutBuilder(
                                   builder: (BuildContext , BoxConstraints )=>
                                       Autocomplete<String>(
                                         optionsViewBuilder:(context, onSelected, options) => Align(

                                             alignment: Alignment.topLeft,
                                             child: Material(
                                               shape: const RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                               ),
                                               child: Container(
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
                                                         padding: const EdgeInsets.all(8.0),
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
                                             setState(() {
                                               customervalid=false;
                                             });
                                             return const Iterable<String>.empty();
                                           }
                                           if(textEditingValue.text!=""){
                                             check(textEditingValue.text.toString());
                                             setState(() {
                                               Suppliername.text=textEditingValue.text.toString();
                                             });
                                             checkfunc();
                                           }
                                           return
                                             Suppierlist.where((String option) {
                                               return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                             });
                                         },
                                         onSelected: (String selection) {
                                           setsuppierid(selection);
                                           setState(() {
                                             Suppliername.text=selection;
                                             customervalid=false;
                                           });
                                           checkfunc();

                                           debugPrint('You just selected $selection');
                                         },
                                         displayStringForOption: (Value){
                                           return Value;
                                         },
                                         optionsMaxHeight: 50,
                                       ),




                                 ),
                               ),*/
                               TypeAheadFormField(
                                 suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                     color: Color(0xffDDDEEE),
                                     borderRadius: BorderRadius.only(
                                       bottomLeft: Radius.circular(5),
                                       bottomRight: Radius.circular(5),
                                     )),
                                 textFieldConfiguration: TextFieldConfiguration(
                                   maxLength: 10,
                                   style: GoogleFonts.montserrat(
                                     fontWeight:FontWeight.w700,
                                   ),
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.only(
                                         left: width / 136.6,
                                         bottom: height / 82.125),
                                     border: InputBorder.none,
                                   ),
                                   controller: _typeAheadControllergender9,
                                 ),
                                 suggestionsCallback: (pattern) {
                                   return getSuggestionsgender9(pattern);
                                 },
                                 itemBuilder: (context, String suggestion) {
                                   return ListTile(
                                     title: Text(suggestion),
                                   );
                                 },
                                 transitionBuilder:
                                     (context, suggestionsBox, controller) {
                                   return suggestionsBox;
                                 },
                                 onSuggestionSelected: (String suggestion) {
                                   setState(() {
                                     customervalid=false;
                                   });
                                   setsuppierid(suggestion);
                                   setState(() {
                                     suppiler_name.text=suggestion;
                                     _typeAheadControllergender9.text=suggestion;
                                     customervalid=false;
                                   });
                                   checkfunc();
                                   check(suggestion.toString());
                                   setState(() {
                                     suppiler_name.text=suggestion.toString();
                                     _typeAheadControllergender9.text=suggestion.toString();
                                   });
                                   checkfunc();

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
                                   fontSize: width/97.57, color: Color(0xff000000)),
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
                                     style: GoogleFonts.montserrat(
                                       fontWeight:FontWeight.w700,
                                         fontSize: width/105.07
                                     ),

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
                                   fontSize: width/97.57, color: Color(0xff000000)),
                             ),
                             const SizedBox(
                               width: 2,
                             ),
                             Container(
                               width: width/3.415,
                               height: height/21.9,
                               //color:Colors.white,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                               ),
                               child: TextField(
                                 style: GoogleFonts.montserrat(
                                     fontWeight:FontWeight.w700,
                                 ),
                                 controller: suppiler_invoice,
                                 focusNode: suppierincoice_no,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(
                                       left:width/130, bottom: height / 36.5),
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
                                   fontSize: width/97.57, color: Color(0xff000000)),
                             ),
                             SizedBox(
                               width: width/47.103,
                             ),
                             Container(
                               width: width/3.415,
                               height: height/21.9,
                               //color:Colors.white,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                               ),
                               child: TextField(
                                 style: GoogleFonts.montserrat(
                                   fontWeight:FontWeight.w700,
                                 ),
                                 controller: suppiler_gstno,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(
                                       left:width/130, bottom: height / 36.5),
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
                     //Purchase No
                     Padding(
                       padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(
                             width: width/273.2,
                           ),
                           Text(
                             "Purchase No",
                             style: GoogleFonts.poppins(
                                 fontSize: width/97.57, color: Color(0xff000000)),
                           ),
                           SizedBox(
                             width: width/44.064,
                           ),
                           Container(
                             width: width/3.415,
                             height: height/21.9,
                             //color:Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,),
                             child: TextField(
                               style: GoogleFonts.montserrat(
                                 fontWeight:FontWeight.w700,
                               ),
                               controller: purchase_No,
                               focusNode: purchase_no,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(
                                     left:width/130, bottom: height / 36.5),
                                 border: InputBorder.none,
                               ),
                               onSubmitted: (_){
                                 purchase_no.unfocus();
                                 FocusScope.of(context).requestFocus(purchase_date);
                               },
                             ),
                           ),
                         ],
                       ),
                     ),

                     //Purchase  Date
                     Padding(
                       padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(
                             width: width/273.2,
                           ),
                           Text(
                             "Purchase  Date",
                             style: GoogleFonts.poppins(
                                 fontSize: width/97.57, color: Color(0xff000000)),
                           ),
                           SizedBox(
                             width: width/105.08,
                           ),
                           Container(
                             width: width/3.415,
                             height: height/21.9,
                             //color:Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,
                             ),
                             child: TextField(
                               style: GoogleFonts.montserrat(
                                 fontWeight:FontWeight.w700,
                               ),
                               controller: purchase_Date,
                               focusNode: purchase_date,
                               decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(
                                       left:width/130, bottom: height / 36.5),
                                   hintText: "Invoice Date",
                                   border: InputBorder.none,
                                   suffixIcon: Icon(Icons.calendar_month)
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
                                   print(
                                       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                   String formattedDate =
                                   DateFormat('dd/MM/yyyy').format(pickedDate);
                                   print(
                                       formattedDate); //formatted date output using intl package =>  2021-03-16
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
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(
                             width: width/273.2,
                           ),
                           Text(
                             "Payment Mode",
                             style: GoogleFonts.poppins(
                                 fontSize: width/97.57, color: Color(0xff000000)),
                           ),
                           SizedBox(
                             width: width/105.08,
                           ),
                           Container(
                             width: width/3.415,
                             height: height/21.9,
                             //color:Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,),
                             child: DropdownButton2<String>(
                               value: Payments,
                               focusNode: purchase_payment,
                               isExpanded: true,
                               style: GoogleFonts.montserrat(
                                 fontWeight:FontWeight.w700,
                                   fontSize: width/105.07
                               ),
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
                                 fontSize: width/97.57, color: Color(0xff000000)),
                           ),
                           SizedBox(
                             width: width/136.6,
                           ),
                           Container(
                             width: width/3.415,
                             height: height/21.9,
                             //color:Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,),
                             child: TextField(
                               style: GoogleFonts.montserrat(
                                 fontWeight:FontWeight.w700,
                               ),
                               controller: purchase_notes,
                               focusNode: purchase_note,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(
                                     left:width/130, bottom: height / 36.5),
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
                                 fontSize: width/97.57, color: Color(0xff000000)),
                           ),

                           SizedBox(
                             width: width/36.0,
                           ),

                           Container(
                             width: width/3.415,
                             height: height/21.9,
                             //color:Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,),
                             child: TextField(
                               style: GoogleFonts.montserrat(
                                 fontWeight:FontWeight.w700,
                               ),
                               controller: Creadit_days,
                               focusNode: Creditnoptes,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(
                                     left:width/130, bottom: height / 36.5),
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
                 color: Color(0xff7d99ab),
                 child: Container(
                   child: Row(
                     children: [

                       //Serial no
                       Container(
                         width: width/45.533,
                         child:
                         Center(child: Text("Si No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //itemid
                       Container(
                         width: width/14.2,

                         child:
                         Center(child: Text("Item ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //itemname
                       Container(
                         width: width/3.7,

                         child:Center(child: Text("Item Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),


                       ),

                       //Box No
                       Container(
                         width: width/16.8,
                         child:
                         Center(child: Text("Box No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //Hsn Code
                       Container(
                         width: width/17.8,

                         child:
                         Center(child: Text("HSN Code",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //tax
                       Container(
                         width: width/17.18,

                         child:
                         Center(child: Text("Tax %",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //quvantity
                       Container(
                         width: width/15.18,
                         child:
                         Center(child: Text("Qnty",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),


                       //price
                       Container(
                         width: width/15.18,
                         child:
                         Center(child: Text("Price",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //landing cost
                       Container(
                         width: width/15.18,

                         child:
                         Center(child: Text("Landing Cost",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                       ),

                       //Sales Price
                       Container(
                         width: width/15.18,
                         child:
                         Center(child: Text("Sales Price",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //value
                       Container(
                         width: width/15.18,
                         child:
                         Center(child: Text("Value",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.redAccent),)),
                       ),

                       //Low order quvantity
                       Container(
                         width: width/15.18,

                         child:
                         Center(child: Text("A Quantity",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                       //Clear controllers
                       Container(
                         width: width/15.18,
                         child:
                         Center(child: Text("Clear ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),)),
                       ),

                     ],
                   ),
                   // color: Color(0xffFFFFFF),
                   width: width/0.976,
                   height: height/16.425,
                   decoration: BoxDecoration(
                     color: Color(0xff7d99ab),),
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
                       child: TextField(
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                             hintText: "1"
                         ),
                       ),
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
                         controller: itemid,
                         focusNode: items_id,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
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
                       decoration: BoxDecoration(
                           border: Border.all(
                               color: Colors.black,width: 0.6
                           )
                       ),
                       child:

                       /*TypeAheadFormField(

                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          color: Color(0xffDDDEEE),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                      ),
                      textFieldConfiguration: TextFieldConfiguration(
                        maxLines: null,
                        style:  GoogleFonts.poppins(
                            fontSize:width/91.06
                        ),
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.only(left:width/136.6,bottom: 8),
                          border: InputBorder.none,
                        ),
                        controller: this._typeAheadControllergender,
                      ),
                      suggestionsCallback: (pattern) {

                        return getSuggestionsgender(pattern);
                      },
                      itemBuilder: (context, String suggestion) {
                        return ListTile(
                          title: Text(suggestion,maxLines: null),
                        );
                      },

                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (String suggestion) {
                        this._typeAheadControllergender.text = suggestion;
                        createpurchase2(suggestion.toString());
                        setState(() {
                          itemname.text = suggestion;
                        });
                        FocusScope.of(context).requestFocus(Quvantitylist);
                        print(itemnames);
                      },
                      suggestionsBoxController: suggestionBoxController,
                      validator: (value) =>
                      value!.isEmpty ? 'Please select a academic year' : null,
                      onSaved: (value) {
                        createpurchase2(value.toString());
                        setState(() {
                          itemname.text = value!;
                        });
                        FocusScope.of(context).requestFocus(Quvantitylist);
                        print(itemnames);

                      },

                    ),

                     */


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
                                       child: Container(
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
                                                 child: Text(option,),
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
                                     print(itemnames);
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
                                   print(itemnames);

                                   debugPrint('You just selected $selection');
                                 },
                                 displayStringForOption: (Value){
                                   return Value;
                                 },
                               ),
                         ),
                       ),



                       /* TextField(
                      controller: itemname,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                      ),
                    ),*/
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
                         controller: Qty,
                         focusNode: Quvantitylist,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                         ),
                         onSubmitted: (_){
                           if(suppierid.text.length!=0||suppiler_name.text.length!=0) {
                             if (Qty.text.length > 0) {
                               //Total function
                               checkgst(Purchase_price.text, Qty.text);

                               updatetotalquvantity(Qty.text);

                               //check the imei and seriall functiom

                               serialvalue == true || imeivalue == true || color ==
                                   true ?
                               //create a document (Firebase)
                               showtextfield(
                                   int.parse(Qty.text), serialvalue, imeivalue,
                                   color) : collectioncreatefunction();

                               //multiple the value functions(Total)
                               serialvalue == true || imeivalue == true
                                   ? updatetotal()
                                   : empty();
                               Quvantitylist.unfocus();
                               FocusScope.of(context).requestFocus(items_value);
                             }
                           }
                           else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the Suppiler Name and Suppiler ID.....")));
                           }
                         },
                         onChanged: (_){
                           if(suppierid.text.length!=0||suppiler_name.text.length!=0) {
                             if (Qty.text.length > 0) {
                               checkgst(Purchase_price.text, Qty.text);
                             }
                           }
                           else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the Suppiler Name and Suppiler ID.....")));
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
                         style: TextStyle(color: Colors.red),
                         controller: valueitem,
                         focusNode: items_value,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                         ),
                         onSubmitted: (_){
                           if (Qty.text.length > 0) {
                             //Total function
                             updatetotalquvantity(Qty.text);

                             //check the imei and seriall functiom

                             serialvalue == true || imeivalue == true || color ==
                                 true ?
                             //create a document (Firebase)
                             showtextfield(
                                 int.parse(Qty.text), serialvalue, imeivalue,
                                 color) : collectioncreatefunction();

                             //multiple the value functions(Total)
                             serialvalue == true || imeivalue == true
                                 ? updatetotal()
                                 : empty();
                             Quvantitylist.unfocus();
                             FocusScope.of(context).requestFocus(items_value);
                           }

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
                             child: Icon(
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
                 color: Color(0xffFFFFFF),
                 child: Container(
                   //color: Color(0xffFFFFFF),
                   width: width/0.976,
                   height: height/2.8,
                   child: StreamBuilder<QuerySnapshot>(
                     stream: FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid)
                         .collection(widget.docid.toString()).orderBy("timestamp")
                         .snapshots(),
                     builder: (context, snapshot) {

                       if (snapshot.hasData == null) {
                         return Center(
                           child: CircularProgressIndicator(),
                         );
                       }

                       if (!snapshot.hasData) {
                         return Center(
                           child: CircularProgressIndicator(),
                         );
                       }

                       return ListView.builder(
                         shrinkWrap: true,
                         physics: ScrollPhysics(),
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index) {
                           var billing = snapshot.data!.docs[index];
                           return

                             Padding(
                               padding:  EdgeInsets.only(bottom:height/164.25),
                               child: Row(
                                 children: [

                                   //Serial no
                                   Container(
                                       width: width/45.533,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(" ${index+1}"))
                                   ),

                                   //itemid
                                   Container(
                                       width: width/14.2,
                                       height: height/16.425,
                                       child: Center(child: Text("${billing['itemcode']}"))
                                   ),

                                   //itemname
                                   Container(
                                       width: width/3.7,
                                       child: Text('${billing['Description']},',textAlign: TextAlign.left,)),

                                   SizedBox(width:width/ 27.32,),




                                   //Hsn code
                                   Container(
                                       width: width/11.8,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Hsncode']))
                                   ),


                                   //tax
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['tax']))
                                   ),


                                   //quvantity
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Qty'].toString()))
                                   ),



                                   //price
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Purchase price'].toString()))
                                   ),

                                   //landing cost
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Landing cost'].toString()))
                                   ),

                                   //Sales Price
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Sales price'].toString()))
                                   ),

                                   //value
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(billing['Total'].toString(),style: TextStyle(color: Colors.red),))
                                   ),

                                   //A Quvantity
                                   Container(
                                       width: width/18.5,
                                       height: height/16.425,
                                       child:
                                       Center(child: Text(""))
                                   ),

                                   //remove
                                   Container(
                                       width: width/15.18,
                                       height: height/16.425,
                                       child:
                                       Center(
                                         child: InkWell(
                                           onTap: (){
                                             deletecollection(billing.id);
                                             updatetotal();
                                           },
                                           child: Icon(
                                               Icons.delete
                                           ),
                                         ),
                                       )
                                   ),

                                 ],
                               ),
                             );

                         },
                       );
                     },
                   ),
                   decoration: BoxDecoration(
                     color: Color(0xffFFFFFF),
                   ),
                 ),
               ),
             ],
           ),

           Padding(
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
                                     style: GoogleFonts.poppins(color: Colors.white),
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
                                     style: GoogleFonts.poppins(color: Colors.white),
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
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                         ),
                                       ):
                                       SizedBox(
                                         width:width/14.0,
                                         height:height/21.9,
                                         child: Text(
                                           "C GST(9%):",
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                         ),
                                       ),
                                       dropdownValue3=="IGST" ?
                                       SizedBox(
                                         width:width/13.66,
                                         height:height/21.9,
                                         child: Text(
                                           IStfuntion(),
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,
                                               fontSize: width/85.375),
                                         ),
                                       ):
                                       SizedBox(
                                         width:width/13.66,
                                         height:height/21.9,
                                         child: Text(
                                           Cgst.toStringAsFixed(2),
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,
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
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                         ),
                                       ),
                                       dropdownValue3=="IGST" ? const SizedBox(): SizedBox(
                                         width:width/13.66,
                                         height:height/21.9,
                                         child: Text(
                                           sgst.toStringAsFixed(2),
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
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
                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black,fontSize: width/85.375),
                                         ),
                                       ),
                                       Container(
                                         child:
                                         TextField(
                                           controller: rounof,
                                           keyboardType: TextInputType.multiline,
                                           style: GoogleFonts.poppins(fontSize:width/ 91.06),
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
                                         style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.indigoAccent,fontSize: width/85.375),
                                       ),
                                     ),

                                     Container(
                                       width:width/13.66,
                                       child: Text(
                                         ": ${totalamount.toStringAsFixed(2)}",
                                         style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.indigoAccent,fontSize: width/85.375),
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
                                         style: GoogleFonts.poppins(
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
                                         style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
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
           )
         ],
       ),);
  }


  //supplier functuon start

  //popup update suppier textcontrollers
  TextEditingController Suppliername=new TextEditingController();
  TextEditingController Supplieremail=new TextEditingController();
  TextEditingController Suppliercode=new TextEditingController();
  TextEditingController SupplierAddress=new TextEditingController();
  TextEditingController State=new TextEditingController();
  TextEditingController City=new TextEditingController();
  TextEditingController Pincode=new TextEditingController();
  TextEditingController Mobileno=new TextEditingController();
  TextEditingController Mobileno2=new TextEditingController();
  TextEditingController Panno=new TextEditingController();
  TextEditingController Openingbalance=new TextEditingController();
  TextEditingController Remarks=new TextEditingController();

  TextEditingController Loworder=new TextEditingController();
  TextEditingController Stocks=new TextEditingController();


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
            duration: Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: Color(0xff264656),
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
                                fontWeight: FontWeight.bold, fontSize: width/59.39,color: Color(0xffFFFFFF)),
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
                            width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,),
                          child:
                          Container(child: TextField(
                            controller: Suppliercode,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: GoogleFonts.poppins(fontSize: width/136.6),
                            decoration: InputDecoration(contentPadding:
                            EdgeInsets.only(left: width/68.3,bottom: width/82.125),
                              border: InputBorder.none,
                            ),
                          ),
                            width: width/6.83,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/65.7,left: width/27.32),
                          child: Container(child: TextField(
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
                            width: width/2.55,
                            height: height/16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                            child: LayoutBuilder(
                            builder: (BuildContext , BoxConstraints )=>
                                Autocomplete<String>(
                                  optionsViewBuilder:(context, onSelected, options) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                        ),
                                        child: Container(
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
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
                            decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
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
                        decoration: BoxDecoration( color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(12)),child: TextField(
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
                                color: Color(0xffD60A0B),),child: Center(child: Text("Save Supplier",style:
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
                                color: Color(0xff00A0E3),),child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
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
              backgroundColor: Color(0xff264656),
              content:
              Container(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height: height/32.85,),
                    Text("Add a Supplier Item Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    Container(
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
                            color: Color(0xff263646),
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
    print("cleared");
    print("clearedddddddddddddddddddddddddddddddddddddddddd");
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
    print(valueitem.text);
  }

  landingcost(landingcost) {
    print(landingcost);
    setState(() {
      Landing_cost.text = ((18/100)*double.parse(landingcost)+double.parse(landingcost)).toStringAsFixed(2);
    });
    if(status2==true){
      Landing_cost.text=landingcost;
    }
    print(Landing_cost.text);
  }

  //s Gst
  double sgst=0;

  SGSTfunction(SGST) {
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
        sgst = (9/100)*SGST;
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
    print(testvalue.round());
    if(TotalAmount2>double.parse(TotalAmount2.round().toString())){
      print(TotalAmount2-double.parse(TotalAmount2.round().toString()));
      setState(() {
        rounof.text=(TotalAmount2-double.parse(TotalAmount2.round().toString())).toStringAsFixed(2);
        TotalAmount2=TotalAmount2-(TotalAmount2-double.parse(TotalAmount2.round().toString()));
      });
      print(TotalAmount2);
      print("fgggggggggggggggggggggggggggggggggggggggg");
      print(double.parse(TotalAmount2.round().toString())-TotalAmount2);
    }
    else {
      setState(() {
        rounof.text=(double.parse(TotalAmount2.round().toString())-TotalAmount2).toStringAsFixed(2);
        TotalAmount2=TotalAmount2+(double.parse(TotalAmount2.round().toString())-TotalAmount2);
      });
      print(double.parse(TotalAmount2.round().toString())-TotalAmount2);
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

    print(testvalue.round());
    if(testvalue>double.parse(testvalue.round().toString())){
      print(testvalue-double.parse(testvalue.round().toString()));
    }
    else {
      print(double.parse(testvalue.round().toString())-testvalue);
    }

  }

  //s Gst
  double Cgst=0;

  double salespriceff = 0;

  CGSTfunction(CGST) {
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
        Cgst = (9 / 100) * CGST;
      });
      return Cgst;
    }

  }


  String random = "";

  checkbillno() {
    setState(() {
      random = randomAlphaNumeric(16);
    });
    print(random);
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



      print(itemcode);

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

  collectioncreatefunction(){
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).
    collection(widget.docid.toString()).doc().set({
      "Total": double.parse(valueitem.text).toStringAsFixed(2),
      "Payment mode":Payments,
      "itemcode":status==true?"G${itemcode}":"N${itemcode}",
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
    FirebaseFirestore.instance.collection("Purchase ShabikaG").
    doc(widget.docid).collection(widget.docid.toString()).doc().set({
      "Total": double.parse(valueitem.text).toStringAsFixed(2),
      "Payment mode":Payments,
      "itemcode":status==true?"G${itemcode}":"",
      "Hsncode": HSN_Code.text,
      "suppilerid":suppierid.text,
      "suppilername":suppiler_name.text,
      "purchaseno":status==true?'G${purchase_No.text}':"",
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
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
      //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "Description":"${itemname.text},${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "IMSlist":IMEISERIAL,
    });

    FirebaseFirestore.instance
        .collection("Purchase ShabikaN")
        .doc(widget.docid)
        .collection(widget.docid.toString())
        .doc()
        .set({
      "Total":  double.parse(valueitem.text).toStringAsFixed(2),
      "Payment mode":Payments,
      "itemcode":status2==true?"N${itemcode}":"",
      "Hsncode": HSN_Code.text,
      "suppilerid":suppierid.text,
      "suppilername":suppiler_name.text,
      "purchaseno":"N${purchase_No.text}",
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
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
      //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "Description":"${itemname.text},${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
      "IMSlist":IMEISERIAL,
    });

    updatetotal();
  }


  Purchaseitem() {

print("check-1");
    if(status==true){
      FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).update({
        "Total": totalamount.toStringAsFixed(2),
        "SGST": sgst.toStringAsFixed(2),
        "CGST": Cgst.toStringAsFixed(2),
        "Payment mode": Payments,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        'credit days':Creadit_days.text,
        'date':  purchase_Date.text,
        'purchaseno': purchase_No.text,
        'purchasenote':purchase_notes.text,
        'suppilierinvoiceno':suppiler_invoice.text,
        'suppilerid':suppierid.text,
        'suppilername':_typeAheadControllergender9.text,
        'suppilergst':suppiler_gstno.text,
      });
    }
print("check-2");
    if(status2==true){

      FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).update({
        "Total": totalamount.toStringAsFixed(2),
        "SGST": sgst.toStringAsFixed(2),
        "CGST": Cgst.toStringAsFixed(2),
        "Payment mode": Payments,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        'credit days':Creadit_days.text,
        'date':  purchase_Date.text,
        'purchaseno': purchase_No.text,
        'purchasenote':purchase_notes.text,
        'suppilierinvoiceno':suppiler_invoice.text,
        'suppilerid':suppierid.text,
        'suppilername':_typeAheadControllergender9.text,
        'suppilergst':suppiler_gstno.text,

      });



    }
   print("check-3");

  if(itemdocuid.isNotEmpty){
    FirebaseFirestore.instance.collection("Item").doc(itemdocuid).update({
      "IMSlist":IMEISERIAL,
      "Imei no":IMEI,
      "Serial no":SERIAL,
      "color":colorlist,
    });
  }


print("check-4");

    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).update({
      "Total": totalamount.toStringAsFixed(2),
      "SGST": sgst.toStringAsFixed(2),
      "CGST": Cgst.toStringAsFixed(2),
      "Payment mode": Payments,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
      'credit days':Creadit_days.text,
      'date':  purchase_Date.text,
      'purchaseno': purchase_No.text,
      'purchasenote':purchase_notes.text,
      'suppilierinvoiceno':suppiler_invoice.text,
      'suppilerid':suppierid.text,
      'suppilername':_typeAheadControllergender9.text,
      'suppilergst':suppiler_gstno.text,
    });

print("check-5");
    setState(() {
      Destription.add("${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}");
      Quvantity.add(Qty.text);
      Totalamount.add(valueitem.text);
      Tax.add(taxitem.text);
      Items.add(itemname.text);
      Rate.add(Purchase_price.text);
      HSNcode.add(HSN_Code.text);
    });
print("check-6");
    print(Destription);
    print(Quvantity);
    print(Totalamount);
    print(Tax);
    print(Items);
    print(Rate);
    print(HSNcode);
    print(Bill_total);


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
        .collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }
    print(totalamount);

    CGSTfunction(totalamount);

    SGSTfunction(totalamount);

    Totalamounts();
  }

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
    print(totalamount);

    CGSTfunction(totalamount);

    SGSTfunction(totalamount);

    Totalamounts();
    FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(widget.docid).update({
      "Total":totalamount
    });
    FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(widget.docid).update({
      "Total":totalamount
    });
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).update({
      "Total":totalamount
    });




  }

  int billcount=0;

  NumberFormat Fotmaterr=new NumberFormat('000');

  billcounts()async{
    if(status==true){
      var docus1=await  FirebaseFirestore.instance.collection("Purchase ShabikaG").get();
      print(docus1.docs.length);
      setState(() {
        billcount = docus1.docs.length+1;
        purchase_No.text = "SBG${(billcount).toString().padLeft(2,"0")}";
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    }
    if(status2==true){
      var docus2=await  FirebaseFirestore.instance.collection("Purchase ShabikaN").get();
      print(Fotmaterr.format(billcount));

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

    print(Bill_Time);
    print(Bill_total);
    print(Suppiler_name);
    print(Suppiler_Id);
    print(Suppiler_invoiceno);
    print(Payment_Mode);
    print(Suppiler_date);
    print(Bill_no);
    print(Billed_to);
    print(Shipped_to);


  }

  //empty function
  empty(){}

  //textfield popup genrate function(Listview Builder)


  List IMEISERIAL=[];

  List IMEI=[];
  List SERIAL=[];
  List colorlist=[];

  bool popupLoading=false;

  updatetotalquvantity(quvantity){
    print(Purchase_price.text);
    print(Landing_cost.text);
    print(Sales.text);

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
          duration: Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Color(0xff264656),
              content:
              Container(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height: height/32.85,),
                    Text("This Customer Already Exist in List.....",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    Container(
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



  showtextfield(Quvantity,serial,imei,color){

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
                    child: Container(
                      height:height/1.194,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height:height/ 131.4,),

                          Text("Add IMEI And SERIAL No ",style: GoogleFonts.montserrat(),),

                          SizedBox(height: height/ 131.4,),

                          Container(
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
                                              Container(
                                                  width:width/11.38,
                                                  child: Text("IMEi No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
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
                                                      style: GoogleFonts.montserrat(),
                                                      controller: _controller[index],
                                                      decoration: InputDecoration(
                                                        hintText: "Enter the IMEI NO",
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.only(left:width/136.6),
                                                        hintStyle: GoogleFonts.montserrat(),
                                                      ),
                                                      onSubmitted: (_){

                                                      },
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ):SizedBox(),

                                        serial==true?
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/341.5,
                                              vertical: height/164.25
                                          ),
                                          child: Row(
                                            children: [

                                              Container(
                                                  width:width/11.38,
                                                  child: Text("Serial No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),

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
                                                        style: GoogleFonts.montserrat(),
                                                        controller: _controller2[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Enter the Serial NO",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle: GoogleFonts.montserrat(),
                                                        ),
                                                        onSubmitted: (_){

                                                        },
                                                      )
                                                  )),
                                            ],
                                          ),
                                        ):SizedBox(),

                                        color==true?
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: width/341.5,
                                              vertical: height/164.25
                                          ),
                                          child: Row(
                                            children: [

                                              Container(
                                                  width:width/11.38,
                                                  child: Text("Color",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),

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
                                                        style: GoogleFonts.montserrat(),
                                                        controller: _controller3[index],
                                                        decoration: InputDecoration(
                                                          hintText: "Color",
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.only(left:width/136.6),
                                                          hintStyle: GoogleFonts.montserrat(),
                                                        ),
                                                        onSubmitted: (_){

                                                        },
                                                      )
                                                  )),
                                            ],
                                          ),
                                        ):SizedBox(),

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
                                  print(IMEISERIAL);

                                  collectioncreatefunction();


                                  Future.delayed(Duration(milliseconds: 1500),(){
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
                                      color: Color(0xff263646),
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
                  popupLoading==true?CircularProgressIndicator():SizedBox()
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
            padding: p.EdgeInsets.only(top: 5),
            child:  p.Row(
                mainAxisAlignment: p.MainAxisAlignment.start,
                children: [
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("SNO".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 80,
                      child: p.Center(
                        child: p.Text("Descriptions".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("HSN/SAC".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Qty".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Rate".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Gst".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Total".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
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
                  padding: p.EdgeInsets.only(top: 90),
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
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerid,
                                                            style: p.TextStyle(color: PdfColors.black)),
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
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilername,
                                                            style: p.TextStyle(color: PdfColors.black)),
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
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(purchasedate,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),

                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Billed To :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Billed_to,
                                                        style: p.TextStyle(color: PdfColors.black)),
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
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerinvoice,
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      ))
                                                ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Payment Type:",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(payment,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Time :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                width: 140,
                                                height: 20,
                                                child: p.Center(
                                                    child: p.Text(Bill_Time,
                                                        style: p.TextStyle(color: PdfColors.black))),
                                              )
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Shipped To :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Shipped_to.toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
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
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 80,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Destription[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(HSNcode[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Quvantity[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Rate[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text("18%",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Totalamount[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
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
                                            style: p.TextStyle(color: PdfColors.black)),
                                      ),
                                      p.SizedBox(width: 10),
                                      p.Container(
                                        width: width/13.66,
                                        child: p.Text(totalamount.toString(),
                                            style: p.TextStyle(color: PdfColors.black)),
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


}

