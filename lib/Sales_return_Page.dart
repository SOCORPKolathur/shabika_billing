import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:random_string/random_string.dart';
import 'package:shabika_billing/printing_Page.dart';
import 'package:shabika_billing/stmodel.dart' as StatusModel;

import 'LandingPage/LandingPage.dart';





const List<String> list = <String>[
  'Please Select Category',
  'Two',
  'Three',
  'Four'
];
const List<String> list1 = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Online",
];

const List<String> list2 = <String>['Select Type', '20%', '50%', '70%'];

const List<String> list3 = <String>[
  "GST",
  "IGST",
];

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Split Amount"
];

const List<String> Payment2 = <String>[
  'Please Select Type',
  'Card',
  'Gpay',
  "Phone Pay",

];

const List<String> Payment3 = <String>[
  'Please Select Type',
  'Cash',
];

const List<String> Entry = <String>[
  'Please Select Type',
  'Purchase Entry',
  'Purchase Entry',
];

class Sales_Return_Page extends StatefulWidget {
  const Sales_Return_Page({Key? key}) : super(key: key);

  @override
  State<Sales_Return_Page> createState() => _Sales_Return_PageState();
}

class _Sales_Return_PageState extends State<Sales_Return_Page> {


  String dropdownValue3 = list3.first;
  String Payments = Payment.first;
  String Payments2 = Payment2.first;
  String Payments3 = Payment3.first;
  String Entry_type = Entry.first;
  TextEditingController Purchase_price = TextEditingController();
  TextEditingController Qty = TextEditingController();
  TextEditingController Landing_cost = TextEditingController();

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

  //itemid
  TextEditingController itemid = TextEditingController();

  //item name
  TextEditingController itemname = TextEditingController();

  TextEditingController Stocks = TextEditingController();

  //tax
  TextEditingController taxitem = TextEditingController();

  int vaalue = 0;

  //billed and shipped to text controller
  TextEditingController Billedto = TextEditingController();
  TextEditingController Shippedto = TextEditingController();
  TextEditingController Sales_Price = TextEditingController();
  TextEditingController Mrp_Price = TextEditingController();
  TextEditingController Location = TextEditingController();
  TextEditingController Supplier = TextEditingController();
  TextEditingController IMEI_No = TextEditingController();
  TextEditingController Serial_NO = TextEditingController();
  TextEditingController Invoice_NO = TextEditingController();
  TextEditingController Invoice_date = TextEditingController();
  TextEditingController Creadit_days = TextEditingController();

  TextEditingController without_tax = TextEditingController();

  //hasn code and box no copntroller
  TextEditingController Box_NO = TextEditingController();
  TextEditingController HSN_Code = TextEditingController();
  TextEditingController Sales = TextEditingController();
  TextEditingController Loworder = TextEditingController();

  //focus node

  FocusNode suppier_id = FocusNode();
  FocusNode suppiername = FocusNode();
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_payment = FocusNode();
  FocusNode purchase_note = FocusNode();
  FocusNode customerphone2 = FocusNode();
  FocusNode customeraddress2 = FocusNode();
  FocusNode customername2 = FocusNode();
  FocusNode listcustomername = FocusNode();
  FocusNode Quvantitylist = FocusNode();

  //item focus node
  FocusNode items_id = FocusNode();
  FocusNode items_name = FocusNode();
  FocusNode items_value = FocusNode();
  bool randomgenrate = false;

  @override
  void initState() {
    setState((){
      status=true;
       Discountamount.text="0";
      Discountamountpercentage.text="0";
      sgst=0;
      Cgst=0;
      totalamount=0;
      TotalAmount2=0;
    });
    Userdata();
    billnoaddfuncxtion();
    categoryaddfunction();
    barndaddfunction();
    edittoltalamount();
    itemaddfunction();
   // checkbillno();

    // TODO: implement initState
    super.initState();
  }

  edittoltalamount() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance
        .collection("billing").doc(returnid).collection(returnid).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Total'].toString()));
      });
    }
    print(totalamount);

    CGSTfunction();

    SGSTfunction();

    Totalamounts();
  }



  //cusdtomer name and phone
  List<String> User = [];
  String Userphone = "";
  bool search = false;
  bool onchangefield = false;
  int length = 0;
  String customerdocid = "";

  Userdata() async {
    setState(() {
      User.clear();
    });
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        User.add(details.docs[i]["Customermobileno"]);
      });
    }
  }

  bool customervalid = false;

  check(name) async {
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    for (int i = 0; i < details.docs.length; i++) {
      if (name== details.docs[i]['Customermobileno']) {
        setState(() {
          customername.text = details.docs[i]['Customername'];
          customeraddress.text = details.docs[i]['Customer address'];
          AddnewcustomeGst.text=details.docs[i]['Customer GstNo'];
          customerdocid = details.docs[i].id;
        });
      }
    }
  }

  checkphonum()async{
    if(_typeAheadControllergender9.text.length==10){
      var detailss = await FirebaseFirestore.instance.collection("Customer").where("Customermobileno",isEqualTo:_typeAheadControllergender9.text ).get();
      if (detailss.docs.length>0) {
        setState(() {
          customervalid=false;
        });
      }
      else{
        setState(() {
          customervalid=true;
        });
      }

    }


  }



  checkagain() async {
    var detailss = await FirebaseFirestore.instance.collection("Customer").where("Customermobileno",isEqualTo:_typeAheadControllergender9.text ).get();
    if (detailss.docs.length>0) {
      alreadyexistshowdialpogbox();
    }
    else{
      showdialpogbox();
    }
  }

  phonenumberfunctions(phoneno) {
    setState(() {
      customervalid = false;
    });
    if (User.asMap()[0] != phoneno) {
      if (User.asMap()[1] != phoneno) {
        if (User.asMap()[2] != phoneno) {
          if (User.asMap()[3] != phoneno) {
            if (User.asMap()[4] != phoneno) {
              setState(() {
                customervalid = true;
              });
            }
          }
        }
      }
    } else {
      setState(() {
        customervalid = false;
      });
    }
  }

  List<String> Itemlist = [];

  itemaddfunction() async {
    setState(() {
      Itemlist.clear();
    });
    if(_typeAheadControllerbrand.text.isNotEmpty&&_typeAheadControllercateory.text.isNotEmpty){
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance.collection('Item').where("Category",isEqualTo:_typeAheadControllercateory.text)
          .where("Brand",isEqualTo:_typeAheadControllerbrand.text).get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add(Document.docs[i]['Newitemname']);
      }
    }
    if(_typeAheadControllerbrand.text.isNotEmpty){
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance.collection('Item').where("Brand",isEqualTo:_typeAheadControllerbrand.text).get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add(Document.docs[i]['Newitemname']);
      }
    }
    if(_typeAheadControllercateory.text.isNotEmpty){
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance.collection('Item').where("Category",isEqualTo:_typeAheadControllercateory.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add(Document.docs[i]['Newitemname']);
      }
    }
    else{
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add(Document.docs[i]['Newitemname']);
      }
    }

  }

  double testvalue = 70.66;

  TextEditingController rounof = TextEditingController();

  testfunction() {
    if (testvalue > double.parse(testvalue.round().toString())) {
    } else {
    }
  }

  final TextEditingController _typeAheadControllergender = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  final TextEditingController _typeAheadControllergender9 = TextEditingController();

  SuggestionsBoxController suggestionBoxController9 = SuggestionsBoxController();
  List<String> getSuggestionsgender9(String query) {
    List<String> matches = <String>[];
    matches.addAll(User);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(Itemlist);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



  final TextEditingController _typeAheadControllergender1 = TextEditingController();

  SuggestionsBoxController suggestionBoxController1 = SuggestionsBoxController();

  List<String> getSuggestionsgender1(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllergender2 = TextEditingController();

  SuggestionsBoxController suggestionBoxController2 =
  SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem1);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllergender3 =
  TextEditingController();

  SuggestionsBoxController suggestionBoxController3 =
  SuggestionsBoxController();

  List<String> getSuggestionsgender3(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem2);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  bool serialvalue = false;
  bool imeivalue = false;
  bool color = false;

  List IMEISERIAL = [];

  bool popupLoading = false;

  TextEditingController quvantitycolor = TextEditingController();
  TextEditingController Imeinumber = TextEditingController();
  TextEditingController Serialnumber = TextEditingController();
  List Quvantitylists=[];




  List<String> imeinu = [];
  List<String> serialnu = [];
  List<String> colornu = [];

  showtextfield(Quvantity, serial, imei, colors) {
    print("Quvantityttttttttttttttttttttttttttttttttttttttttttttttt");
    print(Quvantity.runtimeType);
    print(Quvantity);
    setState(() {
      IMEISERIAL.clear();
    });

    List<TextEditingController> _controller = List.generate(
        Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 = List.generate(
        Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 = List.generate(
        Quvantity, (index) => TextEditingController());


    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    if(serial==true||imei==true||colors==true){
      return showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  left: width / 136.66,
                  right: width / 136.66,
                  top: height / 6.57,
                  bottom: height / 6.57),
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: height / 1.194,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height / 131.4,
                            ),
                            Text(
                              "Add IMEI And SERIAL No ",
                              style: GoogleFonts.montserrat(),
                            ),
                            SizedBox(
                              height: height / 131.4,
                            ),
                            SizedBox(
                              height: height / 1.728,
                              child: ListView.builder(
                                itemCount: Quvantity,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: width / 4.55),
                                    child: SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          imei == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical: height / 164.25),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width: width / 11.38,
                                                    child: Text(
                                                      "IMEi No",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
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
                                                          color: Colors.grey
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
                                                              Radius.circular(
                                                                  5),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize:
                                                              width /
                                                                  91.06),
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
                                                          _controller[index],
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return getSuggestionsgender1(
                                                              pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion,
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
                                                        onSuggestionSelected: (
                                                            String suggestion) {
                                                          _controller[index]
                                                              .text = suggestion;
                                                          setState(() {
                                                            _controller[index]
                                                                .text =
                                                                suggestion;
                                                          });
                                                        },
                                                        suggestionsBoxController:
                                                        suggestionBoxController1,
                                                        validator: (value) =>
                                                        value!.isEmpty
                                                            ? 'Please select a academic year'
                                                            : null,
                                                        onSaved: (value) {
                                                          setState(() {
                                                            _controller[index]
                                                                .text =
                                                            value!;
                                                          });
                                                        },
                                                      ),

                                                      /*TextField(
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
                                                      ),*/
                                                    )),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          serial == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical: height / 164.25),
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
                                                              .w600),
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
                                                          color: Colors.grey
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
                                                              Radius.circular(
                                                                  5),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize:
                                                              width /
                                                                  91.06),
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
                                                          return getSuggestionsgender2(
                                                              pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion,
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
                                                          _controller2[
                                                          index]
                                                              .text =
                                                              suggestion;

                                                          setState(() {
                                                            _controller2[
                                                            index]
                                                                .text =
                                                                suggestion;
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
                                                                .text =
                                                            value!;
                                                          });
                                                        },
                                                      ),
                                                      /* TextField(
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
                                                        )*/
                                                    )),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(),
                                          colors == true
                                              ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 341.5,
                                                vertical: height / 164.25),
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
                                                              .w600),
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
                                                          color: Colors.grey
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
                                                              Radius.circular(
                                                                  5),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                            )),
                                                        textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                          maxLines: null,
                                                          style: GoogleFonts
                                                              .poppins(
                                                              fontSize:
                                                              width /
                                                                  91.06),
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
                                                          _controller3[index],
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) {
                                                          return getSuggestionsgender3(
                                                              pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            String
                                                            suggestion) {
                                                          return ListTile(
                                                            title: Text(
                                                                suggestion,
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
                                                          _controller3[
                                                          index]
                                                              .text =
                                                              suggestion;

                                                          setState(() {
                                                            _controller3[
                                                            index]
                                                                .text =
                                                                suggestion;
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
                                                                .text =
                                                            value!;
                                                          });
                                                        },
                                                      ),
                                                      /*TextField(
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
                                                        )*/
                                                    )),
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

                              /* Padding(
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
                                                child:
                                                TypeAheadFormField(
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
                                                    controller: this._typeAheadControllergender1,
                                                  ),
                                                  suggestionsCallback: (pattern) {

                                                    return getSuggestionsgender1(pattern);
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
                                                    this._typeAheadControllergender1.text = suggestion;

                                                    setState(() {
                                                      Imeinumber.text=suggestion;
                                                    });

                                                  },
                                                  suggestionsBoxController: suggestionBoxController1,
                                                  validator: (value) =>
                                                  value!.isEmpty ? 'Please select a academic year' : null,
                                                  onSaved: (value) {

                                                    setState(() {
                                                      Imeinumber.text=value!;
                                                    });

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
                                                  child:
                                                  TypeAheadFormField(
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
                                                      controller: this._typeAheadControllergender2,
                                                    ),
                                                    suggestionsCallback: (pattern) {

                                                      return getSuggestionsgender2(pattern);
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
                                                      this._typeAheadControllergender2.text = suggestion;

                                                      setState(() {
                                                        Serialnumber.text=suggestion;
                                                      });

                                                    },
                                                    suggestionsBoxController: suggestionBoxController2,
                                                    validator: (value) =>
                                                    value!.isEmpty ? 'Please select a academic year' : null,
                                                    onSaved: (value) {

                                                      setState(() {
                                                        Serialnumber.text=value!;
                                                      });

                                                    },

                                                  ),
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
                                                  child:
                                                  TypeAheadFormField(
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
                                                      controller: this._typeAheadControllergender3,
                                                    ),
                                                    suggestionsCallback: (pattern) {

                                                      return getSuggestionsgender3(pattern);
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
                                                      this._typeAheadControllergender3.text = suggestion;

                                                      setState(() {
                                                        quvantitycolor.text=suggestion;
                                                      });

                                                    },
                                                    suggestionsBoxController: suggestionBoxController2,
                                                    validator: (value) =>
                                                    value!.isEmpty ? 'Please select a academic year' : null,
                                                    onSaved: (value) {

                                                      setState(() {
                                                        quvantitycolor.text=value!;
                                                      });

                                                    },

                                                  ),
                                              )),
                                        ],
                                      ),
                                    ):SizedBox(),

                                  ],
                                ),
                              ),
                            )*/
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      popupLoading = true;
                                    });
                                    for (int i = 0; i < Quvantity; i++) {
                                      setState(() {
                                        IMEISERIAL.add(
                                            "${_controller[i].text},${_controller2[i].text},${_controller3[i].text}");
                                      });
                                      if (imei == true){
                                        imeinu.add(_controller[i].text);
                                      }

                                      if (serial == true){
                                        serialnu.add(_controller2[i].text);
                                        print("serial removed");
                                      }

                                      if (colors == true){
                                        colornu.add(_controller3[i].text);
                                        print("color removed");
                                      }
                                    }

                                    Purchaseitem();
                                    Future.delayed(const Duration(milliseconds: 1500), () {
                                      setState(() {
                                        serial=false;
                                        imei=false;
                                        colors=false;
                                        serialvalue = false;
                                        imeivalue =false;
                                        color =false;
                                        popupLoading = false;
                                        print("end functionssssssssssssssssssssssssss");
                                        print(serial);
                                        print(imei);
                                        print(colors);
                                      });
                                      Navigator.pop(context);

                                    });

                                  },
                                  child: Material(
                                    elevation: 15,
                                    color: Color(0xff25D366),
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: height / 16.425,
                                      width: width / 7.588,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xff25D366),
                                      ),
                                      child: Center(
                                        child: Text("Okay",
                                            style: GoogleFonts.poppins(
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: width / 85.375,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width / 136.6),
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
                                      width: width / 7.588,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xff263646),
                                      ),
                                      child: Center(
                                        child: Text("Cancel",
                                            style: GoogleFonts.poppins(
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: width / 85.375,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    popupLoading == true
                        ? const CircularProgressIndicator()
                        : const SizedBox()
                  ],
                ),
              ));
        },
      );
    }
  }

  //s Gst
  double sgst = 0;

  SGSTfunction() {
    setState(() {
      sgst = 0;
    });
    setState(() {
      sgst =salespriceff-(salespriceff/(1.09));
    });
    return sgst;
  }

  Totalamounts() {
    setState(() {
      TotalAmount2 = 0;
    });
    setState(() {
      TotalAmount2 = totalamount;
    });
    if (TotalAmount2 > double.parse(TotalAmount2.round().toString())) {
      setState(() {
        rounof.text =
            (TotalAmount2 - double.parse(TotalAmount2.round().toString()))
                .toString();
        TotalAmount2 = TotalAmount2 -
            (TotalAmount2 - double.parse(TotalAmount2.round().toString()));
      });
    } else {
      setState(() {
        rounof.text =
            (double.parse(TotalAmount2.round().toString()) - TotalAmount2)
                .toStringAsFixed(2);
        TotalAmount2 = TotalAmount2 +
            (double.parse(TotalAmount2.round().toString()) - TotalAmount2);
      });
    }
  }

  double TotalAmount2 = 0;

  totalamountwithroundof() {
    setState(() {
      TotalAmount2 = 0;
    });
    setState(() {
      discountamountsvalue2 = totalamount + sgst + Cgst + double.parse(rounof.text);
      TotalAmount2 = totalamount + sgst + Cgst + double.parse(rounof.text);
    });

    print("${discountamountsvalue2}valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1111");
    print(discountamountsvalue2);
  }

  //s Gst
  double Cgst = 0;

  CGSTfunction() {
    setState(() {
      Cgst = 0;
    });
    setState(() {
      Cgst =salespriceff-(salespriceff/(1.09));
    });
    return Cgst;
  }

  empty() {}

  landingcost(landingcost) {
    setState(() {Landing_cost.text = ((18 / 100) * double.parse(landingcost) + double.parse(landingcost)).toStringAsFixed(2);
    });
  }

  clearallcontroller() {
    setState(() {
      hsncpode = "";
      Boxno = "";
      vaalue = 0;
      totalamount = 0;
      itemcolor = '';
      totalamount=0;
      sgst=0;
      Cgst=0;
      TotalAmount2=0;
    });
    Purchase_price.clear();
    Qty.clear();
    Landing_cost.clear();
    Sales_Price.clear();
    IMEI_No.clear();
    Serial_NO.clear();
    Invoice_NO.clear();
    Loworder.clear();
    Stocks.clear();
    //_controller.clear();
    // _controller2.clear();
    // _controller3.clear();


    //Based on
    Basedon.clear();
    //itemid
    itemid.clear();
    //item name
    itemname.clear();
    taxitem.clear();
    Sales.clear();
    without_tax.clear();
    Box_NO.clear();
    HSN_Code.clear();
    _typeAheadControllergender.clear();
    suggestionBoxController.close();
  }

  TextEditingController Discountamount = TextEditingController();
  TextEditingController Discountamountpercentage = TextEditingController();



  double discountamountsvalue=0;

  double discountamountsvalue2=0;

  discountamount(Discountamount){
    if(Discountamount!="") {
      setState(() {
        discountamountsvalue = (double.parse(TotalAmount2.toString())-(double.parse(Discountamount))).toDouble();
      });
      if(discountamountsvalue!=0){
        setState((){
          TotalAmount2= discountamountsvalue;
        });
      }
    }

    print(TotalAmount2);
    print(totalamount);
  }

  resetdiscountamount(Discountamountt){
    print("Discountamounttvalueeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print(discountamountsvalue2);
    print(Discountamountt);
    if(Discountamountt=="0"){
      print("enterrrrrrrrrrrrrrrrr");
      setState((){
        TotalAmount2=discountamountsvalue2;
      });
      print(discountamountsvalue2);

    }

  }

  discountamountpercentage(){
    if(Discountamountpercentage.text!="") {
      setState(() {
        discountamountsvalue = (double.parse(TotalAmount2.toString()) * double.parse(Discountamountpercentage.text) / 100 - (double.parse(TotalAmount2.toString()))).abs().toDouble();
      });
      if(discountamountsvalue!=0){
        setState((){
          TotalAmount2= discountamountsvalue;
        });
      }
    }


  }

  final TextEditingController _typeAheadControllercateory = TextEditingController();
  SuggestionsBoxController suggestionBoxControllercateory = SuggestionsBoxController();

  List<String> getSuggestionsgendercateory(String query) {
    List<String> matches = <String>[];
    matches.addAll(categorylist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerbrand = TextEditingController();
  SuggestionsBoxController suggestionBoxControllerbrand = SuggestionsBoxController();

  List<String> getSuggestionsgenderbrand(String query) {
    List<String> matches = <String>[];
    matches.addAll(Barndlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



  List<String> categorylist = <String>[];

  List<String> Barndlist = <String>[];
  categoryaddfunction() async {
    var Document = await FirebaseFirestore.instance
        .collection('category')
        .orderBy("categoryname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
    print(categorylist);
  }

  barndaddfunction() async {
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Barndlist.add(Document.docs[i]['Brandname']);
    }
    print(Barndlist);
  }



  bool payemtselect=false;

  totalcollectionamount() async {

    print("checkdk1");
    print(customerdocid);
    print(returnid);
    print(totalamount);
    print(TotalAmount2);
    print(paymenttype1.text);
    print(paymenttype2.text);
    print(paymenttype3.text);
    print(paymenttype4.text);
    print(Discountamount.text);
    print(Discountamountpercentage.text);
    FirebaseFirestore.instance.collection("billing").doc(returnid).update({
      "return":true,
    });
    FirebaseFirestore.instance.collection("billing ShabikaN").doc(returnid).update({
      "return":true,
    });
    FirebaseFirestore.instance.collection("billing ShabikaG").doc(returnid).update({
      "return":true,
    });

    FirebaseFirestore.instance.collection("billing").doc(returnid).update({
      "Total": totalamount,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
      "save":true,
      "payment-1":paymenttype1.text!=""?"${paymenttype1.text}":"0",
      "payment-2":paymenttype2.text!=""?"${paymenttype2.text}":"0",
      "payment-3":paymenttype3.text!=""?"${paymenttype3.text}":"0",
      "payment-4":paymenttype4.text!=""?"${paymenttype4.text}":"0",
      "Discountamount": Discountamount.text=="0"?0:double.parse(Discountamount.text).toStringAsFixed(2),
      "Discountamountpercentage": Discountamountpercentage.text=="0"?0:"${double.parse(Discountamountpercentage.text).toStringAsFixed(2)}%",
    });
    print("checkdk2");

    print("checkdk3");
    if (status2 == true) {
      FirebaseFirestore.instance.collection("billing ShabikaN").doc(returnid).update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        "save": true,
        "return":true,
        "payment-1":paymenttype1.text!=""?"${paymenttype1.text}":"0",
        "payment-2":paymenttype2.text!=""?"${paymenttype2.text}":"0",
        "payment-3":paymenttype3.text!=""?"${paymenttype3.text}":"0",
        "payment-4":paymenttype4.text!=""?"${paymenttype4.text}":"0",
        "Discountamount": Discountamount.text == "0" ? 0 : double.parse(Discountamount.text).toStringAsFixed(2),
        "Discountamountpercentage": Discountamountpercentage.text == "0" ? 0 : "${double.parse(Discountamountpercentage.text).toStringAsFixed(2)}%",
      });
    }

    if (status == true) {
      FirebaseFirestore.instance.collection("billing ShabikaG").doc(returnid).update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        "save": true,
        "return":true,
        "payment-1":paymenttype1.text!=""?"${paymenttype1.text}":"0",
        "payment-2":paymenttype2.text!=""?"${paymenttype2.text}":"0",
        "payment-3":paymenttype3.text!=""?"${paymenttype3.text}":"0",
        "payment-4":paymenttype4.text!=""?"${paymenttype4.text}":"0",
        "Discountamount": Discountamount.text == "0" ? 0 : double.parse(Discountamount.text).toStringAsFixed(2),
        "Discountamountpercentage": Discountamountpercentage.text == "0" ? 0 : "${double.parse(Discountamountpercentage.text).toStringAsFixed(2)}%",
      });
    }

    print("checkdk3");
    if(imeivalue==true&&imeinu.isNotEmpty){
      var collection = FirebaseFirestore.instance.collection('Item');
      collection.doc(itemdocuid).update(
          {
            'Imei no': FieldValue.arrayRemove(imeinu),
          }

      );
    }

    print("checkdk4");

    if(serialvalue==true&&serialnu.isNotEmpty){
      var collection = FirebaseFirestore.instance.collection('Item');
      collection.doc(itemdocuid).update(
          {
            'Serial no': FieldValue.arrayRemove(serialnu),
          }
      );
    }

    print("checkdk5");
    if(color==true&&colornu.isNotEmpty){
      var collection = FirebaseFirestore.instance.collection('Item');
      collection.doc(itemdocuid).update(
          {
            'color': FieldValue.arrayRemove(colornu),
          }
      );
    }

    FirebaseFirestore.instance.collection("Customer").doc(customerdocid).
    collection("billing").doc(returnid).update({
      "Total": totalamount,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
      "save": true,
      "return":true,
      "payment-1":paymenttype1.text!=""?"${paymenttype1.text}":"0",
      "payment-2":paymenttype2.text!=""?"${paymenttype2.text}":"0",
      "payment-3":paymenttype3.text!=""?"${paymenttype3.text}":"0",
      "payment-4":paymenttype4.text!=""?"${paymenttype4.text}":"0",
      "Discountamount": Discountamount.text == "0" ? 0 : double.parse(Discountamount.text).toStringAsFixed(2),
      "Discountamountpercentage": Discountamountpercentage.text == "0" ? 0 : "${double.parse(Discountamountpercentage.text).toStringAsFixed(2)}%",
    });


    print("checkdk6");

    print("checkdk7");

    print("checkdk8");
    checkbillno();
    print("checkdk9");

  }


  TextEditingController paymenttype1=TextEditingController();
  TextEditingController paymenttype2=TextEditingController();
  TextEditingController paymenttype3=TextEditingController();
  TextEditingController paymenttype4=TextEditingController();

  double decreaseamount=0;

  Showpayment(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState((){
      decreaseamount=TotalAmount2;
    });
    showDialog(context: context, builder: (context) {
      return
        StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding:  EdgeInsets.only(top:
              Payments=="Split Amount"?
              height/13.6:height/3.38,
                  bottom:
                  Payments=="Split Amount"?
                  height/13.6:height/3.38),
              child: AlertDialog(
                content: Column(
                  children: [
                    Text("Please Select Payment Type",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,
                        color: Colors.black,fontSize: 18),),
                    SizedBox(height:height/65.7),

                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Payment Mode",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 105.07,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: height / 164.25),
                              child: DropdownButton2<String>(
                                value: Payments,
                                isExpanded: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width / 105.07),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    Payments = value!;
                                  });

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
                          ),
                        ],
                      ),
                    ),

                    Payments=="Split Amount"
                        ?SizedBox(
                        child:Column(
                          children: [
                            //payment1
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      'Cash',
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        height:height/16.425,
                                        width:width/10.55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.grey.shade200
                                        ),
                                        child: TextField(
                                          style: GoogleFonts.montserrat(),
                                          controller:paymenttype1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left:width/136.6),
                                            hintStyle: GoogleFonts.montserrat(),
                                          ),
                                          onSubmitted: (_){
                                            setState((){
                                              decreaseamount=decreaseamount-double.parse(paymenttype1.text);
                                            });
                                          },
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),

                            //payment-2
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      "Card",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        height:height/16.425,
                                        width:width/10.55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.grey.shade200
                                        ),
                                        child: TextField(
                                          style: GoogleFonts.montserrat(),
                                          controller:paymenttype2,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left:width/136.6),
                                            hintStyle: GoogleFonts.montserrat(),
                                          ),
                                          onSubmitted: (_){
                                            setState((){
                                              decreaseamount=decreaseamount-double.parse(paymenttype2.text);
                                            });
                                          },
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),

                            //payment-3
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      "Gpay",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        height:height/16.425,
                                        width:width/10.55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.grey.shade200
                                        ),
                                        child: TextField(
                                          style: GoogleFonts.montserrat(),
                                          controller:paymenttype3,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left:width/136.6),
                                            hintStyle: GoogleFonts.montserrat(),
                                          ),
                                          onSubmitted: (_){
                                            setState((){
                                              decreaseamount=decreaseamount-double.parse(paymenttype3.text);
                                            });
                                          },
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),
                            //payment-4
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      "Phone Pay",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        height:height/16.425,
                                        width:width/10.55,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.grey.shade200
                                        ),
                                        child: TextField(
                                          style: GoogleFonts.montserrat(),
                                          controller:paymenttype4,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left:width/136.6),
                                            hintStyle: GoogleFonts.montserrat(),
                                          ),
                                          onSubmitted: (_){
                                            setState((){
                                              decreaseamount=decreaseamount-double.parse(paymenttype4.text);
                                            });

                                          },
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),

                            //payment-5
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      "Total To be\nPay",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                          height:height/16.425,
                                          width:width/10.55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child:
                                          Center(child: Text("RS: ${decreaseamount}",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.88),))
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),

                            //payment-6
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: width/341.5,
                                  vertical: height/164.25
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  SizedBox(
                                    width:width/13.66,
                                    child: Text(
                                      "Total",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 97.571,
                                          color: const Color(0xff000000)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 105.07,
                                  ),

                                  Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                          height:height/16.425,
                                          width:width/10.55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child:
                                          Center(child: Text("RS: ${TotalAmount2.toStringAsFixed(2)}",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/75.88)))
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height:height/65.7),



                          ],
                        )
                    )
                        :SizedBox(),
                    SizedBox(height:height/50.7),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(
                          onTap: (){
                            if(Payments.isNotEmpty){

                            }

                          },
                          child: Material(
                            elevation: 15,
                            color: Color(0xff25D366),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/7.588,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff25D366),
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

                        SizedBox(width: width/45.53,),

                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: Color(0xff263646),
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
            );
          },);
    },);
  }


  String random = "";
  String itemcode = "dsgdgd";
  String hsncpode = "";
  String itemcat = '';
  String itembrand = '';
  String itemimei = '';
  String itemserial = '';

  checkbillno() {
    setState(() {
      random = randomAlphaNumeric(16);
      sgst=0;
      Cgst=0;
      totalamount=0;
      TotalAmount2=0;
      // dropdownValue3 = list3.first;
    });
    //_typeAheadControllergender9.clear();
    // customername.clear();
    // customeraddress.clear();
    billcounts();

  }

  TextEditingController Cusname = TextEditingController();
  TextEditingController mobileno = TextEditingController();

  bool alreadyexit = false;

  final TextEditingController _typeAheadControllergender10 = TextEditingController();
  SuggestionsBoxController suggestionBoxController10 = SuggestionsBoxController();

  List<String> Stateslect = <String>[
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

  List<String> getSuggestionsgender10(String query) {
    List<String> matches = <String>[];
    matches.addAll(Stateslect);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllergender11 = TextEditingController();
  SuggestionsBoxController suggestionBoxController11= SuggestionsBoxController();

  List<String> getSuggestionsgender11(String query) {
    List<String> matches = <String>[];
    matches.addAll(_cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  customeradd() async {
    FirebaseFirestore.instance.collection("Customer").doc().set({
      "Customermobileno": Addnewcustomenumber.text,
      "Customername": customername.text,
      "Customer address": "${customerhomeno.text} ${customeraddress.text},${customerarea.text} ${_typeAheadControllergender11.text},${_typeAheadControllergender10.text} - ${customerpincode.text}",
      "Customer GstNo": AddnewcustomeGst.text,
      "Customer state ":_typeAheadControllergender10.text,
      "Customer pincode ":customerpincode.text,
      "Customer city ":_typeAheadControllergender11.text,
      "Customer street ":customeraddress.text,
      "Customer homeno ":customerhomeno.text,
      "Customer area ":customerarea.text,
    });
    setState(() {
      customervalid = false;
    });
    clearcontroller();

  }

  List<String> _cities = ["Choose City"];

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCity(state) async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == "🇮🇳    India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == state);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }


  //showdialogbox..
  alreadyexistshowdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 5.760, bottom: height / 5.760),
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
                        height: height / 32.85,
                      ),
                      Text(
                        "This Customer Already Exist in List.....",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.3,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            customervalid = false;
                          });
                          Navigator.pop(context);
                        },
                        child: Material(
                          elevation: 15,
                          color: Color(0xff25D366),
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height / 16.425,
                            width: width / 7.588,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff25D366),
                            ),
                            child: Center(
                              child: Text("Okay",
                                  style: GoogleFonts.poppins(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 85.375,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  updatetotalquvantity() {
    if(int.parse(Stocks.text)>0) {
      FirebaseFirestore.instance.collection('Item').doc(itemdocuid).update(
          {"TotalQuvantity": FieldValue.increment(-(double.parse(Qty.text)))});
    }

  }

  clearcontroller() {

    mobileno.clear();
    Cusname.clear();
    customerphone.clear();
    customername.clear();
    customeraddress.clear();
    customerpincode.clear();
    customerstate.clear();
    customerstreet2.clear();
    AddnewcustomeGst.clear();
    _typeAheadControllergender10.clear();
    _typeAheadControllergender15.clear();
    _typeAheadControllergender11.clear();
    _typeAheadControllergender9.clear();
    customerhomeno.clear();
    customerarea.clear();
    setState((){
      returnid="0";
    });
  }

  TextEditingController customername = TextEditingController();
  TextEditingController customerphone = TextEditingController();
  //street name
  TextEditingController customeraddress = TextEditingController();//street name1
  TextEditingController customerstreet2 = TextEditingController();//street name1
  TextEditingController customerstate = TextEditingController();//street state
  TextEditingController customerpincode = TextEditingController();
  TextEditingController customerhomeno = TextEditingController();
  TextEditingController customerarea = TextEditingController();

  int billingcountval = 0;

  clearlayout(name) {
    setState(() {
      name = '';
    });
  }

  double totalamount = 0;

  updatetotal() async {

      setState(() {
        totalamount = 0;
      });
      var documents = await FirebaseFirestore.instance.collection("billing").doc(returnid).collection(returnid).get();
      for (int i = 0; i < documents.docs.length; i++) {
        setState(() {
          totalamount = ((totalamount) + double.parse(documents.docs[i]['Sales price']));
        });
      }

      CGSTfunction();
      SGSTfunction();

      FirebaseFirestore.instance.collection("billing").doc(returnid).update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        "itemcode": status == true ? "G${itemcode}" : "N${itemcode}",

      });

      if (status == true) {
        FirebaseFirestore.instance
            .collection("billing ShabikaG")
            .doc(returnid)
            .update({
          "Total": totalamount,
          "Totalamount": TotalAmount2.toStringAsFixed(2),
        });
      }

      if (status2 == true) {
        FirebaseFirestore.instance
            .collection("billing ShabikaN")
            .doc(returnid)
            .update({
          "Total": totalamount,
          "Totalamount": TotalAmount2.toStringAsFixed(2),
        });
      }

      Totalamounts();

  }

  deleteupdatetotal() async {

    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance.collection("billing").doc(returnid).collection(returnid).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + double.parse(documents.docs[i]['Sales price']));
      });
    }

    CGSTfunction();
    SGSTfunction();

    FirebaseFirestore.instance.collection("billing").doc(returnid).update({
      "Total": totalamount,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
    });

    if (status == true) {
      FirebaseFirestore.instance
          .collection("billing ShabikaG")
          .doc(returnid)
          .update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
      });
    }

    if (status2 == true) {
      FirebaseFirestore.instance
          .collection("billing ShabikaN")
          .doc(returnid)
          .update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
      });
    }

    Totalamounts();


  }

  Purchaseitem() {

    print("check1");
    print(customerdocid);
    if(int.parse(Stocks.text)>0) {
      print("check2");
      FirebaseFirestore.instance.collection("billing").doc(returnid).update(
          {
            "Payment mode": Payments,
            "Total": double.parse(Sales.text).toStringAsFixed(2),
          });
      print("check3");
      if (status == true) {
        FirebaseFirestore.instance.collection("billing ShabikaG").doc(
            returnid).update({
          "Payment mode": Payments,
          "Total": double.parse(Sales.text).toStringAsFixed(2),
        });

        FirebaseFirestore.instance.collection("billing ShabikaG").doc(
            returnid).collection(returnid).doc()
            .set({
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": status == true ? "G${itemcode}" : "",
          "Hsncode": hsncpode,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Description":
          "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
        });
      }
      print("check4");
      if (status2 == true) {
        FirebaseFirestore.instance.collection("billing ShabikaN").doc(returnid).update({
          "Payment mode": Payments,
          "Total": double.parse(Sales.text).toStringAsFixed(2),
        });

        FirebaseFirestore.instance.collection("billing ShabikaN").doc(returnid).collection(returnid).doc().set({
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": status2 == true ? "N${itemcode}" : "",
          "Hsncode": hsncpode,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
          "${DateTime
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
          "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "Qty": Qty.text,
          //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description":
          "${itemname.text},${IMEISERIAL.isNotEmpty
              ? IMEISERIAL.toString()
              : ""}",
        });
      }
      print("check5");
      FirebaseFirestore.instance.collection("billing").doc(returnid).collection(returnid).doc().set({
        "Total": double.parse(Sales.text).toStringAsFixed(2),
        "Payment mode": Payments,
        "itemcode": status == true ? "G${itemcode}" : "N${itemcode}",
        "Hsncode": hsncpode,
        "customername": customername.text,
        "customerphone": customerphone.text,
        "customeraddress": customeraddress.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "time": DateFormat.jm().format(DateTime.now()),
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "Category": itemcat,
        "Brand": itembrand,
        "Item": itemname.text,
        "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
        "Sales price": double.parse(Sales.text).toStringAsFixed(2),
        "Qty": Qty.text,
        // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
        "Description":
        "${itemname.text},${IMEISERIAL.isNotEmpty
            ? IMEISERIAL.toString()
            : ""}",
      });
      print("check6");

      print("check7");
      setState(() {
        Destription.add(
            "${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty
                ? IMEISERIAL.toString()
                : ""}");
        Quvantity.add(Qty.text);
        Totalamount.add(double.parse(Sales.text));
        Tax.add(taxitem.text);
        Items.add(itemname.text);
        Rate.add(Purchase_price.text);
        HSNcode.add(hsncpode);
      });
      print("check8");
      updatetotalquvantity();
      print("check9");
      updatetotal();
      print("check10");
      clearallcontroller();
      print("check11");
    }

  }

  String Bill_total = '';
  List Destription = [];
  List Quvantity = [];
  List Totalamount = [];
  List Tax = [];
  List Items = [];
  List Rate = [];
  List HSNcode = [];

  clearlistandname() {
    setState(() {
      Destription.clear();
      Quvantity.clear();
      Totalamount.clear();
      Tax.clear();
      Items.clear();
      Rate.clear();
      HSNcode.clear();
      Payment_Mode = "";
      Suppiler_Id = "";
      Suppiler_name = "";
      Suppiler_date = "";
      Bill_no = "";
      Bill_total = "";
      Bill_Time = "";
      Shipped_to = "";
      Billed_to = "";
    });
  }

  checkgst(Salesvalue, qty) {
    setState(() {
      Sales.text = (salespriceff * double.parse(qty)).toString();
    });
  }



  //toggle switch boolean
  bool status = true;
  bool status2 = false;
  String itemcolor = '';
  String Boxno = '';
  String itemdocuid = '';

  List<String> ImerisrialListitem = <String>[];
  List<String> ImerisrialListitem1 = <String>[];
  List<String> ImerisrialListitem2 = <String>[];
  double salespriceff = 0;
  bool showpopup=false;
  int sec=0;

  createpurchase2(name) async {
    setState(() {
      ImerisrialListitem.clear();
      ImerisrialListitem1.clear();
      ImerisrialListitem2.clear();
    });

    var documents = await FirebaseFirestore.instance.collection("Item").get();
    for (int i = 0; i < documents.docs.length; i++) {
      if (documents.docs[i]["Newitemname"] == name) {
        setState(() {
          ImerisrialListitem.clear();
          ImerisrialListitem1.clear();
          ImerisrialListitem2.clear();
          itemcode = documents.docs[i]["Itemcode"].toString();
          itemdocuid = documents.docs[i].id.toString();
          hsncpode = documents.docs[i]["HSNCode"].toString();
          itemid.text = documents.docs[i]["Itemcode"].toString();
          itemname.text = documents.docs[i]["Newitemname"].toString();
          taxitem.text = documents.docs[i]["gst"].toString();
          Loworder.text = documents.docs[i]["Loworder"].toString();
          Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
          Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
          Qty.text = "1";
          itemcat = documents.docs[i]["Category"].toString();
          itembrand = documents.docs[i]["Brand"].toString();
          Boxno = documents.docs[i]["BoxNo"].toString();
          Box_NO.text = documents.docs[i]["BoxNo"].toString();
          HSN_Code.text = documents.docs[i]["HSNCode"].toString();
          Sales.text = documents.docs[i]["Saleprice"].toString();
          salespriceff = double.parse(documents.docs[i]["Saleprice"].toString());
          serialvalue = documents.docs[i]["Serial NO"];
          imeivalue = documents.docs[i]["IMEI NO"];
          color = documents.docs[i]["Color"];
          without_tax.text = (salespriceff / 1.18).round().toStringAsFixed(2);
        });
        for (int j = 0; j < documents.docs[i]["Imei no"].length; j++) {
          ImerisrialListitem.add(documents.docs[i]["Imei no"][j].toString());
        }
        for (int k = 0; k < documents.docs[i]["Serial no"].length; k++) {
          ImerisrialListitem1.add(documents.docs[i]["Serial no"][k].toString());
        }
        for (int l = 0; l < documents.docs[i]["color"].length; l++) {
          ImerisrialListitem2.add(documents.docs[i]["color"][l].toString());
        }

      }


    }

    /* if(int.parse(Stocks.text)>0) {
      FirebaseFirestore.instance.collection("billing").doc(random).set({
        "Total": "",
        "itemcode": itemcode,
        "Payment mode": Payments,
        "Hsncode": hsncpode,
        "customername": customername.text,
        "customerphone": customerphone.text,
        "customeraddress": customeraddress.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        "BoxNo": Boxno,
        "time": DateFormat.jm().format(DateTime.now()),
        "date":
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch
      });

      if (status == true) {
        FirebaseFirestore.instance.collection("billing ShabikaG").doc(random).set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": hsncpode,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
      }

      if (status2 == true) {
        FirebaseFirestore.instance.collection("billing ShabikaN").doc(random).set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": hsncpode,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
          "${DateTime
              .now()
              .day}/${DateTime
              .now()
              .month}/${DateTime
              .now()
              .year}",
          "timestamp": DateTime
              .now()
              .microsecondsSinceEpoch
        });
      }

      checkgst(Sales.text, Qty.text);
    }*/

    if(int.parse(Stocks.text)<1){
      setState((){
        showpopup=true;
      });
      if(showpopup==true){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Alert Stocks are Low....."),duration: Duration(milliseconds: 500),));
      }
      Future.delayed(Duration(milliseconds: 510),(){
        setState((){
          showpopup=false;
        });
      });
    }

  }


  String billcount="";

  billcounts()async{
    if(status==true){
      var docus1=await  FirebaseFirestore.instance.collection("billing ShabikaG").get();
      print(docus1.docs.length);
      setState(() {
        billcount = docus1.docs.length.toString();
        purchase_No.text = "SBG${(billcount).toString().padLeft(2,"0")}";
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    }
    if(status2==true){
      var docus2=await  FirebaseFirestore.instance.collection("billing ShabikaN").get();

      print(docus2.docs.length);

      setState(() {
        billcount = docus2.docs.length.toString();
        purchase_No.text = "SBN${(billcount).toString().padLeft(2,"0")}";
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });

    }
    else{
      var docus=await  FirebaseFirestore.instance.collection("billing").get();
      print(docus.docs.length);
      setState(() {
        billcount = docus.docs.length.toString();
        purchase_No.text = (docus.docs.length+1).toString();
        purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });
    }

  }
  String delteqty='0';
  String deltecode='0';
  String deltedocid='0';

  deletecollection(id) async {
    var documents=await FirebaseFirestore.instance.collection("billing").doc(returnid).
    collection(returnid.toString()).doc(id).get();
    Map<String,dynamic>?value=documents.data();
    setState((){
      delteqty=value!['Qty'];
      deltecode=value['Item'];
    });
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    for (int j = 0; j < details.docs.length; j++) {
      print(details.docs.length);
      if (_typeAheadControllergender9.text== details.docs[j]['Customermobileno']) {
        print("customerdociddfdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
        setState(() {
          customerdocid = details.docs[j].id;
        });
      }
    }
    var documents2=await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<documents2.docs.length;i++){
      if(deltecode==documents2.docs[i]['Newitemname']){
        print(delteqty);
        print("'''''''''''''''''fgh''''''''''delteqty'''''''fghfgh'''''hfghf'''''''''''''''");
        print(documents2.docs[i]['TotalQuvantity']);
        FirebaseFirestore.instance.collection("Item").doc(documents2.docs[i].id).update({
          "TotalQuvantity":FieldValue.increment(int.parse(delteqty)),
        });
        FirebaseFirestore.instance.collection("billing").doc(returnid).collection(returnid).doc(id).delete();
        updatetotal();
        FirebaseFirestore.instance.collection("Customer").doc(customerdocid).collection("billing").doc(id).delete();


      }
    }


  }

  String Payment_Mode = "";
  String Suppiler_Id = "";
  String Suppiler_name = "";
  String Suppiler_invoiceno = "";
  String Suppiler_date = "";
  String Bill_no = "";
  String Bill_Time = "";
  String Shipped_to = "";
  String Billed_to = "";

  TextEditingController AddnewcustomeGst=TextEditingController();
  TextEditingController Addnewcustomenumber=TextEditingController();


  //showdialogbox..
  showdialpogbox() {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 15.760, bottom: height / 15.760,left:width/ 5.760,right: width/ 5.760),
          child:
          Scaffold(
            backgroundColor: const Color(0xff263646),
            body:  SlideInLeft(
              animate: true,
              duration: const Duration(milliseconds: 800),
              manualTrigger: false,
              child:
              Center(
                child: SizedBox(
                  width: width / 2.902,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height / 25.85,
                      ),
                      Text(
                        "Are You Sure Want to Add Customer..",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.3,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),

                      SizedBox(
                          width:width/2.732,
                          child:Column(
                            children: [

                              //Customer name
                              //Customer Phone
                              Row(
                                children: [

                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer Name ",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child: TextField(
                                            controller:customername ,
                                            decoration:  InputDecoration(border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/130.6)
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                  SizedBox(width: width/20.6,),

                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer Phone",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child: TextField(
                                            controller:Addnewcustomenumber ,
                                            decoration:  InputDecoration(border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/130.6)
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                ],
                              ),

                              SizedBox(height: width/136.6,),


                              //Customer
                              Row(
                                children: [

                                  //Customer HomeNo
                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer Home No",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child: TextField(
                                            controller:customerhomeno ,
                                            decoration:  InputDecoration(border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/273.2)
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                  SizedBox(width: width/20.6,),

                                  //Customer Address(Streat name)
                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer Street",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child:
                                          TextField(
                                            controller:customeraddress ,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.only(left:width/273.2),
                                              border: InputBorder.none,),
                                            onTap:(){},
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height: width/136.6,),
                              //Customer Gst
                              Row(
                                children: [

                                  //Customer Area
                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer Area",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child:
                                          TextField(
                                            controller:customerarea ,
                                            decoration:  InputDecoration(border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/130.6)
                                            ),
                                            onTap:(){},
                                          ),
                                        ),
                                      )

                                    ],
                                  ),




                                  SizedBox(width: width/20.6,),

                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("City/District",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                            height:height/13.14,
                                            width:width/6.83,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Colors.white
                                            ),
                                            child:
                                            TypeAheadFormField(
                                              suggestionsBoxDecoration:
                                              const SuggestionsBoxDecoration(
                                                  color: Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(5),
                                                    bottomRight: Radius.circular(5),
                                                  )),
                                              textFieldConfiguration: TextFieldConfiguration(
                                                onChanged: (_){
                                                  getCity(_typeAheadControllergender11.text);
                                                },
                                                onSubmitted: (_){
                                                  getCity(_typeAheadControllergender11.text);
                                                },
                                                style: GoogleFonts.poppins(fontSize: 15),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(left: width/136.6, bottom: height/82.125),
                                                  border: InputBorder.none,
                                                ),
                                                controller: _typeAheadControllergender11,
                                              ),
                                              suggestionsCallback: (pattern) {

                                                return getSuggestionsgender11(pattern);
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
                                                _typeAheadControllergender11.text = suggestion;

                                              },
                                              suggestionsBoxController: suggestionBoxController11,
                                              validator: (value) => value!.isEmpty
                                                  ? 'Please select a academic year'
                                                  : null,
                                            )
                                          /*TextField(
                                           controller:customerstreet2 ,
                                           decoration: InputDecoration(border: InputBorder.none,),
                                         ),*/
                                        ),
                                      )

                                    ],
                                  ),



                                ],
                              ),
                              SizedBox(height: width/136.6,),




                              //Customer city and district
                              Row(
                                children: [

                                  //Customer State
                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer State",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                            height:height/13.14,
                                            width:width/6.83,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Colors.white
                                            ),
                                            child:
                                            TypeAheadFormField(
                                              suggestionsBoxDecoration:
                                              const SuggestionsBoxDecoration(
                                                  color: Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(5),
                                                    bottomRight: Radius.circular(5),
                                                  )),
                                              textFieldConfiguration: TextFieldConfiguration(
                                                onChanged: (_){
                                                  getCity(_typeAheadControllergender10.text);
                                                },
                                                onSubmitted: (_){
                                                  getCity(_typeAheadControllergender10.text);
                                                },
                                                style: GoogleFonts.poppins(fontSize: 15),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(left: width/136.6, bottom: height/82.125),
                                                  border: InputBorder.none,
                                                ),
                                                controller: _typeAheadControllergender10,
                                              ),
                                              suggestionsCallback: (pattern) {

                                                return getSuggestionsgender10(pattern);
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
                                                _typeAheadControllergender10.text = suggestion;

                                              },
                                              suggestionsBoxController: suggestionBoxController10,
                                              validator: (value) => value!.isEmpty
                                                  ? 'Please select a academic year'
                                                  : null,
                                            )
                                          /*TextField(
                                           controller:customerstate ,
                                           decoration: InputDecoration(border: InputBorder.none,),
                                         ),*/
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(width: width/20.6,),

                                  //customer gst no
                                  Column(
                                    children: [

                                      SizedBox(
                                          width:width/6.83,
                                          child: Text("Customer PinCode",style: GoogleFonts.poppins(color: Colors.white),)),
                                      SizedBox(height: height/136.6,),
                                      Material(
                                        shadowColor: Colors.indigo,
                                        elevation: 25,
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                        child: Container(
                                          height:height/13.14,
                                          width:width/6.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.white
                                          ),
                                          child: TextField(
                                            controller:
                                            customerpincode
                                            ,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.only(left:width/130.6),
                                              border: InputBorder.none,),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                ],

                              ),

                              SizedBox(height: width/136.6,),

                              //Customer pincode
                              Row(
                                children: [
                                  SizedBox(
                                      width:width/6.83,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Customer GST No",style: GoogleFonts.poppins(color: Colors.white),),
                                          SizedBox(height: height/136.6,),
                                          Material(
                                            shadowColor: Colors.indigo,
                                            elevation: 25,
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.white,
                                            child: Container(
                                              height:height/13.14,
                                              width:width/6.83,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: Colors.white
                                              ),
                                              child: TextField(
                                                controller: AddnewcustomeGst,
                                                decoration:  InputDecoration(border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(left:width/130.6)
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),



                                ],
                              ),
                            ],
                          )

                      ),

                      SizedBox(
                        height: height / 25.85,
                      ),

                      Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          InkWell(
                            onTap: () {
                              if(customeraddress==""||AddnewcustomeGst==""||Addnewcustomenumber==""||customername==""||customerpincode==""||
                                  customerstate==""||customerstreet2==""||customerarea==""||customerhomeno==""){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Fill the All The Field"),duration: Duration(milliseconds: 500)));
                              }
                              else{
                                customeradd();
                                Userdata();
                                Navigator.pop(context);
                              }
                            },
                            child: Material(
                              elevation: 15,
                              color: Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 16.425,
                                width: width / 7.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.poppins(
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width / 85.375,
                                          color: Colors.white)),
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
                                width: width / 7.588,
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
                      ),
                      SizedBox(
                        height: height / 48.85,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double printingtotal=0;

  printingtotalamountfunction(){
    setState(() {
      printingtotal=0;
    });
    for(int i=0;i<Totalamount.length;i++){
      setState((){
        printingtotal=printingtotal+Totalamount[i];
      });
    }
    print(printingtotal);
  }

  getvalue(Suppilername, Tax, Suppilerinvoice, purchaseno, purchasedate, payment,totalamountvalue) async {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {
      Billed_to = "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Shipped_to = "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Bill_Time = DateFormat.jm().format(DateTime.now());
    });

    List<p.Widget> widgets = [];

    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: const p.EdgeInsets.only(top: 5),
            child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("SNO".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 80,
                  child: p.Center(
                    child: p.Text("Descriptions".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("HSN/SAC".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Qty".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Rate".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
              p.Container(
                  width: 60,
                  child: p.Center(
                    child: p.Text("Gst".toString(),
                        style: const p.TextStyle(color: PdfColors.black)),
                  )),
              p.SizedBox(width: width / 273.2),
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

    widgets.add(p.Stack(children: [
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
          child: p.Container(
              height: 600,
              child: p.Column(children: [
                p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
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
                            p.SizedBox(height: 5),
                            p.Row(children: [
                              p.Container(
                                  width: 110,
                                  height: 20,
                                  child: p.Center(
                                    child: p.Text("Customer Name:",
                                        style: const p.TextStyle(color: PdfColors.black)),
                                  )),
                              p.Container(
                                  width: 140,
                                  height: 20,
                                  child: p.Center(
                                    child: p.Text(Suppilername,
                                        style: const p.TextStyle(color: PdfColors.black)),
                                  ))
                            ]),
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
                  p.SizedBox(width: width / 273.2),
                  p.Container(
                      child: p.Column(
                          crossAxisAlignment: p.CrossAxisAlignment.start,
                          mainAxisAlignment: p.MainAxisAlignment.start,
                          children: [

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
                                        style:
                                        const p.TextStyle(color: PdfColors.black))),
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
                      return p.Container(
                          child: p.Row(
                              mainAxisAlignment: p.MainAxisAlignment.start,
                              children: [
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text("${index + 1}",
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 80,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(Destription[index].toString(),
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(HSNcode[index].toString(),
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(Quvantity[index].toString(),
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(Rate[index].toString(),
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(Tax,
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    )),
                                p.SizedBox(width: width / 273.2),
                                p.Container(
                                    width: 60,
                                    height: height / 16.425,
                                    child: p.Center(
                                      child: p.Text(Totalamount[index].toString(),
                                          style:
                                          const p.TextStyle(color: PdfColors.black)),
                                    ))
                              ]));
                    },
                  ),
                ),
                p.Padding(
                    padding: p.EdgeInsets.only(
                        left: width / 136.6, right: 10, top: 200),
                    child: p.Divider(color: PdfColors.black, thickness: 0.8)),
                p.Padding(
                    padding: p.EdgeInsets.only(
                        left: width / 136.6, top: 500),
                    child: p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.end,
                        children: [
                          p.Container(
                            width: width / 300.20,
                            child: p.Text("Total :",
                                style: const p.TextStyle(color: PdfColors.black)),
                          ),
                          p.SizedBox(width: width / 136.6),
                          p.Container(
                            width: width / 13.66, //--100
                            child: p.Text(totalamountvalue.toString(),
                                style: const p.TextStyle(color: PdfColors.black)),
                          )
                        ]))
              ]))),
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

  String returnid='0';
  final TextEditingController _typeAheadControllergender15 = TextEditingController();

  SuggestionsBoxController suggestionBoxController15 = SuggestionsBoxController();
  List<String> getSuggestionsgender15(String query) {
    List<String> matches = <String>[];
    matches.addAll(billno);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List <String>billno=[];

  billnoaddfuncxtion() async {
    setState(() {
      billno.clear();
    });
    var document=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo: true).get();
    for(int i=0;i<document.docs.length;i++){
      billno.add(document.docs[i]['purchaseno']);
    }

  }
  getvalues(code)async{
    var document=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo: true).get();
  for(int i=0;i<document.docs.length;i++){
    if(code==document.docs[i]['purchaseno']){
      print("document.docs[i].id");
      print(document.docs[i].id);
      setState(() async {
        Box_NO.text=document.docs[i]['BoxNo'].toString();
        HSN_Code.text=document.docs[i]['Hsncode'].toString();
        Payments=document.docs[i]['Payment mode'].toString();
        Creadit_days.text=document.docs[i]['credit days'].toString();
        purchase_Date.text=document.docs[i]['date'].toString();
        itemid.text=document.docs[i]['itemcode'].toString();
        purchase_No.text=document.docs[i]['purchaseno'].toString();
        purchase_notes.text=document.docs[i]['purchasenote'].toString();
        AddnewcustomeGst.text=document.docs[i][ "Customer GstNo"].toString();
        _typeAheadControllergender9.text=document.docs[i]['customerphone'].toString();
        customeraddress.text=document.docs[i]['customeraddress'].toString();
        customername.text=document.docs[i]['customername'].toString();
        taxitem.text=document.docs[i]['tax'].toString();
        Discountamount.text=document.docs[i]['Discountamount'].toString();
        Discountamountpercentage.text=document.docs[i]['Discountamountpercentage'].toString();
        returnid=document.docs[i].id;

        edittoltalamount();

      });


    }

  }
    print(customerdocid);
  }

  TextEditingController layourbuilderclear=TextEditingController();

  clearitemaddfunction() async {
    setState(() {
      Itemlist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Item')
        .orderBy("Newitemname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Itemlist.add(Document.docs[i]['Newitemname']);
    }

  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //toggle switchs
          Row(
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: width / 4.583, right: width / 56.916),
                child: FlutterSwitch(
                  inactiveColor: const Color(0xffC9C9C9),
                  inactiveToggleColor: Colors.grey,
                  width: width / 30.35,
                  height: height / 32.85,
                  valueFontSize: 5.0,
                  toggleSize: 20.0,
                  value: status,
                  borderRadius: 10.0,

                  padding: 2.0,
                  //showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      if (val == true) {
                        setState(() {
                          status = val;
                          status2 = false;
                        });
                        billcounts();
                      } else {
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
                style: GoogleFonts.solway(
                    color: Colors.white, fontSize: width / 80.353),
              ),
              SizedBox(width: width / 5.0),
              Padding(
                padding:
                EdgeInsets.only(left: width / 4.583, right: width / 56.916),
                child: FlutterSwitch(
                  inactiveColor: const Color(0xffC9C9C9),
                  inactiveToggleColor: Colors.grey,
                  width: width / 30.35,
                  height: height / 32.85,
                  valueFontSize: 5.0,
                  toggleSize: 20.0,
                  value: status2,
                  borderRadius: 10.0,

                  padding: 2.0,
                  //showOnOff: true,
                  onToggle: (val) {
                    billcounts();
                    setState(() {
                      if (val == true) {
                        setState(() {
                          status2 = val;
                          status = false;
                        });
                        billcounts();
                      } else {
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
                style: GoogleFonts.solway(
                    color: Colors.white, fontSize: width / 80.353),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //entry type container
              SizedBox(
                height: height / 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Customer Phone
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Customer Phone",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 43.0,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Focus(
                                focusNode: customerphone2,
                                child:
                                /*  TypeAheadFormField(
                              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )),
                              textFieldConfiguration: TextFieldConfiguration(
                                maxLength: 10,
                                onChanged: (value){
                                  checkphonum();
                                },
                                style: GoogleFonts.poppins(fontSize: 15),
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
                                  customerphone.text = suggestion;
                                });
                                _typeAheadControllergender9.text = suggestion;
                                check(_typeAheadControllergender9.text.toString());
                              },
                              suggestionsBoxController: suggestionBoxController9,
                              validator: (value) => value!.isEmpty
                                  ? 'Please select a academic year'
                                  : null,
                            ),*/
                                Padding(
                                  padding:  EdgeInsets.only(left:width/130,right: width/170),
                                  child: LayoutBuilder(
                                    builder: (BuildContext, BoxConstraints) =>
                                        Autocomplete<String>(
                                          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                            return
                                              TextFormField(
                                                controller:_typeAheadControllergender9,
                                                onChanged: (_){
                                                  setState((){
                                                    _typeAheadControllergender9.text=textEditingController.text;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.only(left:width/273.2,bottom:height/43.8)
                                                ),
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  onFieldSubmitted();
                                                },
                                              );
                                          },
                                          initialValue: TextEditingValue(

                                              selection: TextSelection(
                                                isDirectional: true,
                                                baseOffset: 5,
                                                extentOffset: 1,
                                              )),
                                          optionsViewBuilder:
                                              (context, onSelected, options) => Align(
                                              alignment: Alignment.topLeft,
                                              child: Material(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                      Radius.circular(4.0)),
                                                ),
                                                child: Container(
                                                  height: 52.0 * options.length,
                                                  width:
                                                  BoxConstraints.biggest.width,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: options.length,
                                                    shrinkWrap: false,
                                                    itemBuilder:
                                                        (BuildContext, index) {
                                                      final String option =
                                                      options.elementAt(index);
                                                      return InkWell(
                                                        onTap: () =>
                                                            onSelected(option),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.all(16.0),
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
                                              return const Iterable<String>.empty();
                                            }

                                            if (textEditingValue.text != "") {
                                              check(textEditingValue.text.toString());
                                            }

                                            return User.where((String option) {
                                              return option.toLowerCase().contains(
                                                  textEditingValue.text.toLowerCase());
                                            });
                                          },
                                          onSelected: (String selection) {
                                            setState(() {
                                              customerphone.text = selection;
                                            });
                                            _typeAheadControllergender9.text = selection;
                                            check(_typeAheadControllergender9.text.toString());

                                            debugPrint('You just selected $selection');
                                          },
                                          displayStringForOption: (Value) {
                                            return Value;
                                          },
                                        ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(
                            width: width / 273.2,
                          ),
                          InkWell(
                            onTap: () {

                              if(customervalid==true){
                                checkagain();
                              }
                            },
                            child:
                            customervalid==true?
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
                                      const Text("New Customer"),
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

                    //Customer name
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Customer Name",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 41.39,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              focusNode: customername2,
                              controller: customername,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:width/130, bottom: height / 36.5),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                customername2.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(customeraddress2);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Customer Address
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Customer Address",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 75.88,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child:
                            TextField(
                              focusNode: customeraddress2,
                              controller: customeraddress,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:width/130, bottom: height / 36.5),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                customeraddress2.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(suppierincoice_no);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),


                    //tax type
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Tax Type",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 15.701,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton2<String>(
                                    value: dropdownValue3,
                                    focusNode: suppiertax,
                                    isExpanded: true,
                                    isDense: true,
                                    alignment: Alignment.topCenter,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width / 105.07),
                                    underline: Container(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue3 = value!;
                                      });
                                      suppiertax.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(suppierincoice_no);
                                    },
                                    items: list3.map<DropdownMenuItem<String>>(
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
                          ),
                        ],
                      ),
                    ),

                    //Customer  gstno
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Customer GST NO",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 55.701,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: AddnewcustomeGst,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left:width/130, bottom: height / 36.5),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  customeraddress2.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(suppierincoice_no);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              //entry type container-2
              SizedBox(
                height: height / 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Bill No
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Bill No",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 17.74,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child:  TypeAheadFormField(
                              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )),
                              textFieldConfiguration: TextFieldConfiguration(
                                onSubmitted: (_){
                                  getvalues(_typeAheadControllergender15.text);
                                },
                                maxLength: 10,
                                style: GoogleFonts.poppins(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width / 136.6,
                                      bottom: height / 82.125),
                                  border: InputBorder.none,
                                ),
                                controller: _typeAheadControllergender15,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsgender15(pattern);
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
                                getvalues(suggestion);
                                setState((){
                                  purchase_No.text=suggestion;
                                  _typeAheadControllergender15.text=suggestion;
                                });
                              },
                              suggestionsBoxController: suggestionBoxController15,
                              validator: (value) => value!.isEmpty
                                  ? 'Please select a academic year'
                                  : null,
                            ),

                           /* TextField(
                              controller: purchase_No,
                              focusNode: purchase_no,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:width/130, bottom: height / 36.5),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                getvalues(purchase_No.text);
                              },
                            ),*/
                          ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Category",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 32.3,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:width/130,right: width/170),
                            child: LayoutBuilder(
                              builder: (BuildContext, BoxConstraints) =>
                                  Autocomplete<String>(
                                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                      return textfield2(
                                        focusNode,
                                        textEditingController,
                                        onFieldSubmitted,
                                      );
                                    },
                                    initialValue: TextEditingValue(
                                        selection: TextSelection(
                                          isDirectional: true,
                                          baseOffset: 5,
                                          extentOffset: 1,
                                        )),
                                    optionsViewBuilder:
                                        (context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.vertical(
                                                bottom:
                                                Radius.circular(4.0)),
                                          ),
                                          child: Container(
                                            height: 52.0 * options.length,
                                            width:
                                            BoxConstraints.biggest.width,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: options.length,
                                              shrinkWrap: false,
                                              itemBuilder:
                                                  (BuildContext, index) {
                                                final String option =
                                                options.elementAt(index);
                                                return InkWell(
                                                  onTap: () =>
                                                      onSelected(option),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(16.0),
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
                                        return const Iterable<String>.empty();
                                      }

                                      if (textEditingValue.text != "") {
                                        setState(() {
                                          _typeAheadControllercateory.text = textEditingValue.text;
                                        });
                                        itemaddfunction();
                                      }
                                      return categorylist.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text.toLowerCase());
                                      });
                                    },
                                    onSelected: (String selection) {
                                      setState(() {
                                        _typeAheadControllercateory.text = selection;
                                      });
                                      itemaddfunction();
                                    },
                                    displayStringForOption: (Value) {
                                      return Value;
                                    },
                                  ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Brand",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 20.5,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:width/130,right: width/170,),
                            child: LayoutBuilder(
                              builder: (BuildContext, BoxConstraints) =>
                                  Autocomplete<String>(
                                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                      return textfield2(
                                        focusNode,
                                        textEditingController,
                                        onFieldSubmitted,
                                      );
                                    },
                                    initialValue: TextEditingValue(
                                        selection: TextSelection(
                                          isDirectional: true,
                                          baseOffset: 5,
                                          extentOffset: 1,
                                        )),
                                    optionsViewBuilder:
                                        (context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.vertical(
                                                bottom:
                                                Radius.circular(4.0)),
                                          ),
                                          child: Container(
                                            height: 52.0 * options.length,
                                            width:
                                            BoxConstraints.biggest.width,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: options.length,
                                              shrinkWrap: false,
                                              itemBuilder:
                                                  (BuildContext, index) {
                                                final String option =
                                                options.elementAt(index);
                                                return InkWell(
                                                  onTap: () =>
                                                      onSelected(option),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(16.0),
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
                                        return const Iterable<String>.empty();
                                      }

                                      if (textEditingValue.text != "") {
                                        setState(() {
                                          _typeAheadControllerbrand.text = textEditingValue.text;
                                        });
                                        itemaddfunction();
                                      }

                                      return Barndlist.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text.toLowerCase());
                                      });
                                    },
                                    onSelected: (String selection) {
                                      setState(() {
                                        _typeAheadControllerbrand.text = selection;
                                      });
                                      itemaddfunction();
                                    },
                                    displayStringForOption: (Value) {
                                      return Value;
                                    },
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
                          Text(
                            "Purchase  Date",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 105.07,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: purchase_Date,
                              focusNode: purchase_date,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left:width/130, bottom: height / 36.5),
                                  hintText: "Invoice Date",
                                  border: InputBorder.none,
                                  suffixIcon: const Icon(Icons.calendar_month)),
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
                    /* Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Payment Mode",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 105.07,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: height / 164.25),
                            child: DropdownButton2<String>(
                              value: Payments,
                              focusNode: purchase_payment,
                              isExpanded: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width / 105.07),
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
                        ),
                      ],
                    ),
                  ),*/

                    //Remarks
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Text(
                            "Remarks",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(
                            width: width / 23.5,
                          ),
                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: purchase_notes,
                              focusNode: purchase_note,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:width/130, bottom: height / 36.5),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
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
                color: const Color(0xff7d99ab),
                child: Container(
                  width: width / 0.976,
                  height: height / 16.425,
                  decoration: const BoxDecoration(
                    color: Color(0xff7d99ab),
                  ),
                  child: Row(
                    children: [
                      //Serial no
                      SizedBox(
                        width: width / 45.533,
                        child: Center(
                            child: Text(
                              "Si No",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //itemid
                      SizedBox(
                        width: width / 14.2,
                        child: Center(
                            child: Text(
                              "Item ID",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //itemname
                      SizedBox(
                        width: width / 2.9,
                        child: Center(
                            child: Text(
                              "Item Name",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      SizedBox(width: width / 28.76),

                      //Box No
                      SizedBox(
                        width: width / 16.7,
                        child: Center(
                            child: Text(
                              "Box No",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),


                      //Hsn Code
                      SizedBox(
                        width: width / 17.8,
                        child: Center(
                            child: Text(
                              "HSN Code",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //tax
                      SizedBox(
                        width: width / 16.18,
                        child: Center(
                            child: Text(
                              "Tax %",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),


                      //quvantity
                      SizedBox(
                        width: width / 15.18,
                        child: Center(
                            child: Text(
                              "Qnty",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),



                      //withou Tax
                      SizedBox(
                        width: width / 15.18,
                        child: Center(
                            child: Text(
                              "Price",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),



                      //Sales Price
                      SizedBox(
                        width: width / 14.0,
                        child: Center(
                            child: Text(
                              "Sales Price",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //Stocks
                      SizedBox(
                        width: width / 15.0,
                        child: Center(
                            child: Text(
                              "Stocks",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),

                      //Clear controllers
                      SizedBox(
                        width: width / 13.18,
                        child: Center(
                            child: Text(
                              "Clear ",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: width / 0.976,
                decoration: const BoxDecoration(
                  color: Color(0xffb7b0aa),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Serial no
                    Container(
                      width: width / 45.533,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: "1"),
                      ),
                    ),

                    //itemid
                    Container(
                      width: width / 14.2,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: itemid,
                        focusNode: items_id,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                        onSubmitted: (_) {
                          items_id.unfocus();
                          FocusScope.of(context).requestFocus(items_value);
                        },
                      ),
                    ),

                    //itemname
                    Container(
                      width: width / 2.7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child:

                      /* TypeAheadFormField(
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                          color: Color(0xffDDDEEE),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      textFieldConfiguration: TextFieldConfiguration(
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: width / 91.06),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: width / 136.6, bottom: 8),
                          border: InputBorder.none,
                        ),
                        controller: _typeAheadControllergender,
                      ),
                      suggestionsCallback: (pattern) {
                        return getSuggestionsgender(pattern);
                      },
                      itemBuilder: (context, String suggestion) {
                        return ListTile(
                          title: Text(suggestion, maxLines: null),
                        );
                      },
                      transitionBuilder:
                          (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (String suggestion) {
                        _typeAheadControllergender.text = suggestion;

                        createpurchase2(suggestion.toString());
                        setState(() {
                          itemname.text = suggestion;
                        });
                        FocusScope.of(context).requestFocus(Quvantitylist);
                      },
                      suggestionsBoxController: suggestionBoxController,
                      validator: (value) => value!.isEmpty
                          ? 'Please select a academic year'
                          : null,
                      onSaved: (value) {
                        createpurchase2(value.toString());
                        setState(() {
                          itemname.text = value!;
                        });
                        FocusScope.of(context).requestFocus(Quvantitylist);
                      },
                    ),*/

                      Padding(
                        padding:  EdgeInsets.only(left:width/130,right: width/170,bottom:height/65.7),
                        child: LayoutBuilder(
                          builder: (BuildContext , BoxConstraints )=>
                              Autocomplete<String>(
                                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                  return _AutocompleteField2(
                                    focusNode: focusNode,
                                    textEditingController: textEditingController,
                                    onFieldSubmitted: onFieldSubmitted,
                                  );
                                },
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
                                    Future.delayed(Duration(milliseconds: 510),(){
                                      setState((){
                                        showpopup=false;
                                      });
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
                                    showpopup=false;
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
                      width: width / 14.8,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: Box_NO,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                        onSubmitted: (_) {},
                      ),
                    ),

                    //Hsn Code
                    Container(
                      width: width / 14.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: HSN_Code,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                      ),
                    ),

                    //tax
                    Container(
                      width: width / 16.8,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: taxitem,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                      ),
                    ),

                    //quvantity
                    Container(
                      width: width / 16.8,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: Qty,
                        focusNode: Quvantitylist,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                        onSubmitted: (_) {
                          if(_typeAheadControllergender9.text!=""&&customername.text!=""&&int.parse(Stocks.text)>0) {
                            if (Qty.text.length > 0) {
                              checkgst(Sales.text, Qty.text);

                              //check the imei and seriall functiom
                              serialvalue == true ||
                                  imeivalue == true ||
                                  color == true||int.parse(Stocks.text)>0
                                  ? //create a document (Firebase)
                              showtextfield(int.parse(Qty.text), serialvalue, imeivalue, color)
                                  : empty();
                              serialvalue == false &&
                                  imeivalue == false &&
                                  color == false&&int.parse(Stocks.text)>0?updatetotalquvantity():empty();
                              serialvalue == false &&
                                  imeivalue == false &&
                                  color == false&&int.parse(Stocks.text)>0?Purchaseitem():empty();


                              Quvantitylist.unfocus();
                              FocusScope.of(context).requestFocus(items_value);
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect Format.."),duration: Duration(milliseconds: 500)));
                          }
                        },
                        onTap: (){
                          setState((){
                            showpopup=false;
                          });
                        },
                        onChanged: (_) {
                          setState((){
                            showpopup=false;
                          });
                          if(_typeAheadControllergender9.text.length>0||Cusname.text!="") {
                            if (Qty.text.length > 0) {
                              checkgst(Sales.text, Qty.text);
                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect Format.."),duration: Duration(milliseconds: 500)));
                          }
                        },
                      ),
                    ),

                    // Price(without Tax)
                    Container(
                      width: width / 13.8,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: without_tax,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                      ),
                    ),


                    //Sales Price
                    Container(
                      width: width / 13.8,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: Sales,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                        onSubmitted: (_){
                          //check the imei and seriall functiom
                          serialvalue == true ||
                              imeivalue == true ||
                              color == true||int.parse(Stocks.text)>0
                              ? //create a document (Firebase)
                          showtextfield(int.parse(Qty.text), serialvalue, imeivalue, color)
                              : empty();
                          serialvalue == false &&
                              imeivalue == false &&
                              color == false&&int.parse(Stocks.text)>0?updatetotalquvantity():empty();
                          serialvalue == false &&
                              imeivalue == false &&
                              color == false&&int.parse(Stocks.text)>0?Purchaseitem():empty();
                          serialvalue == false &&
                              imeivalue == false &&
                              color == false&&int.parse(Stocks.text)>0?clearallcontroller():empty();

                        },
                      ),
                    ),

                    //Stocks
                    Container(
                      width: width / 15.3,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: Stocks,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),
                      ),
                    ),

                    //Clear controllers
                    Container(
                        width: width / 14.0,
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
                height: height / 164.25,
              ),

            ],
          ),

          Material(
            elevation: 50,
            shadowColor: Colors.black38,
            color: const Color(0xffFFFFFF),
            child: Container(
              width: width / 0.976,
              height: height / 3.05,
              decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("billing")
                    .doc(returnid)
                    .collection(returnid)
                    .orderBy("timestamp")
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
                        padding: EdgeInsets.only(bottom: height / 164.25),
                        child: Row(
                          children: [

                            //Serial no
                            SizedBox(
                                width: width / 45.533,
                                height: height / 16.425,
                                child: Center(child: Text(" ${index + 1}"))),

                            //itemid
                            SizedBox(
                                width: width / 14.2,
                                height: height / 16.425,
                                child: Center(
                                    child: Text("${billing['itemcode']}"))),

                            //itemname
                            SizedBox(
                                width: width / 2.7,
                                child: Text(
                                  '${billing['Description']},',
                                  textAlign: TextAlign.left,
                                )),



                            SizedBox(
                              width: width / 13.32,
                            ),

                            //Hsn code
                            SizedBox(
                                width: width / 15.9,
                                height: height / 16.425,
                                child: Center(child: Text(billing['Hsncode']))),

                            //tax
                            SizedBox(
                                width: width / 20.8,
                                height: height / 16.425,
                                child: Center(child: Text(billing['tax']))),

                            //quvantity
                            SizedBox(
                                width: width / 18.8,
                                height: height / 16.425,
                                child: Center(
                                    child: Text(billing['Qty'].toString()))),

                            // Price
                            SizedBox(
                                width: width / 11.18,
                                height: height / 16.425,
                                child: Center(
                                    child: Text(
                                        billing['withouttaxprice'].toString()))),

                            //Sales Price
                            SizedBox(
                                width: width / 11.18,
                                height: height / 16.425,
                                child: Center(
                                    child:
                                    Text(billing['Sales price'].toString()))),


                            SizedBox(
                              width: width / 23.32,
                            ),

                            //remove
                            SizedBox(
                                width: width / 14.0,
                                height: height / 16.425,
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
                    SizedBox(
                      width: width / 20.83,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width / 250.888),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {

                                  totalcollectionamount();
                                  print("check1");
                                  clearallcontroller();
                                  print("check2");
                                  clearcontroller();
                                  print("check3");

                                  ScaffoldMessenger.of(context).showSnackBar
                                    (SnackBar(content:Text("Save Bill Succesfully...")));


                                },
                                child: Container(
                                  width: width / 5.6,
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
                              const SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: width / 5.6,
                                  height: height / 16.42,
                                  //color: Color(0xffD60A0B),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff075E54),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Share On WhatsApp",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Image.asset("assets/whats app final.png",
                                          height: height / 21.9,
                                          width: width / 45.53),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height / 131.4),
                        Padding(
                          padding: EdgeInsets.only(left: width / 250.888),
                          child: Row(
                            children: [

                              InkWell(
                                onTap: () {

                                  Invoice(
                                      products:Destription,
                                      customerName: 'Raja',
                                      customerAddress: 'chennai',
                                      invoiceNumber: '23544',
                                      tax: 18,
                                      paymentInfo: 'TEst',
                                      baseColor: PdfColors.indigo,
                                      accentColor: PdfColors.red
                                  );
                                  printingtotalamountfunction();
                                  getvalue(
                                      customername.text,
                                      dropdownValue3,
                                      suppiler_invoice.text,
                                      purchase_No.text,
                                      purchase_Date.text,
                                      Payments,
                                      printingtotal);
                                },
                                child: Container(
                                  width: width / 5.6,
                                  height: height / 16.42,
                                  //color: Color(0xffD60A0B),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff0079FF),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Save And Print Invoice",
                                        style: GoogleFonts.poppins(color: Colors.white),
                                      )),
                                ),
                              ),

                              SizedBox(
                                width: width / 65.18,

                              ),

                              //discount(normal Price)
                              //discount normal price
                              SizedBox(
                                width: width / 15.18,
                                child: Center(
                                    child: Text(
                                      "Discount\nAmount",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Container(
                                width: width / 15.8,
                                height: height / 21.9,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: TextField(
                                  controller: Discountamount,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: width / 136.6, bottom: height / 65.7),
                                  ),
                                  onSubmitted: (_){

                                  },
                                ),
                              ),

                              //discount(Percentage Price)
                              //discount Percentage
                              SizedBox(
                                width: width / 15.18,
                                child: Center(
                                    child: Text(
                                      "Discount %",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Container(
                                width: width / 15.8,
                                height: height / 21.9,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: TextField(
                                  controller: Discountamountpercentage,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: width / 136.6, bottom: height / 65.7),
                                  ),
                                  onSubmitted: (_){
                                    discountamountpercentage();
                                  },

                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width / 8.5,
                    ),
                    Row(
                      children: [
                        /*
                      GestureDetector(
                        onTap: () {
                          testfunction();
                        },
                        child: Container(
                            width: width / 3.5,
                            height: height / 6.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                              /*  Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //c gst amount
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width / 15.5,
                                            child: Text(
                                              "C GST(9%)",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            child: Text(
                                              ": ${Cgst.toStringAsFixed(2)}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: height / 131.4),

                                    //S GSt amount
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width / 15.5,
                                            child: Text(
                                              "S GST(9%)",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            child: Text(
                                              ": ${sgst.toStringAsFixed(2)}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: height / 65.7),

                               */

                                Row(
                                  children: [
                                    SizedBox(width: width / 136.6),
                                    Container(
                                      width: width / 10.5,
                                      child: Text(
                                        "Round Value",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: width / 85.375),
                                      ),
                                    ),
                                    Container(
                                      child: TextField(
                                        controller: rounof,
                                        keyboardType: TextInputType.multiline,
                                        style: GoogleFonts.poppins(
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
                                      width: width / 6.83,
                                      height: height / 16.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),

                       */

                        SizedBox(

                            height: height / 6.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*  //sub total
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width / 17.075,
                                    child: Text(
                                      "Sub Total",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.indigoAccent,
                                          fontSize: width / 85.375),
                                    ),
                                  ),
                                  Container(
                                    width: width / 13.66,
                                    child: Text(
                                      ": ${totalamount.toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.indigoAccent,
                                          fontSize: width / 85.375),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height / 131.4),


                             */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width / 10.075,
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.end ,
                                        children: [
                                          Text(
                                            "Total :",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: width / 50.88),
                                          ),
                                          SizedBox(width:width/273.2),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: width / 5.5,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child:
                                        Center(
                                          child: Text(( Discountamount.text==""||Discountamount.text=="0")?
                                          (TotalAmount2-int.parse(Discountamount.text)).toStringAsFixed(2):
                                          "${TotalAmount2.toStringAsFixed(2)}" ,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: width / 30.88),
                                          ),
                                        )
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
      );
  }

  Widget textfield2( FocusNode focusNode,TextEditingController textEditingController,VoidCallback onFieldSubmitted){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          width: width / 3.415,
          height: height / 21.9,
          //color:Colors.white,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left:width/91.06,bottom:height/43.8)

            ),
            controller: textEditingController,
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          ),
        ),
        SizedBox(
          width: width / 273.2,
        ),
        InkWell(
          onTap: () {
            clearitemaddfunction();
            textEditingController.clear();
          },
          child:
          ClipOval(
              child:
              Container(
                  height:height/26.28,
                  width:width/54.64,
                  color: Colors.white,
                  child: const Icon(Icons.clear))),

        )
      ],
    );
  }

}

class _AutocompleteField2 extends StatelessWidget {
  const _AutocompleteField2({
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left:width/273.2,bottom:height/43.8)
        ),
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
  }
}

// The default Material-style Autocomplete options.
class _AutocompleteOptions2<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions2({
    super.key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
  });

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(
                    builder: (BuildContext context) {
                      final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(displayStringForOption(option)),
                      );
                    }
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

