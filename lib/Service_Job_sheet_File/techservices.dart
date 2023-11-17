
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
import 'package:pattern_lock/pattern_lock.dart';
import 'package:random_string/random_string.dart';
import 'package:shabika_billing/Customer-Page/Customer.dart';
import 'package:shabika_billing/Edit_customer_Page.dart';
import 'package:shabika_billing/pattern_page.dart';

class techService extends StatefulWidget {
  const techService({Key? key}) : super(key: key);

  @override
  State<techService> createState() => _techServiceState();
}

class _techServiceState extends State<techService> {

  String dropdownValue3 = list3.first;
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_note = FocusNode();
  FocusNode customerphone2 = FocusNode();
  FocusNode customeraddress2 = FocusNode();
  FocusNode customername2 = FocusNode();
  FocusNode billno2 = FocusNode();
  FocusNode Quvantitylist = FocusNode();
  FocusNode boxno2 = FocusNode();
  FocusNode price2 = FocusNode();


  List<String> ImerisrialListitem = <String>[];
  List<String> ImerisrialListitem1 = <String>[];
  List<String> ImerisrialListitem2 = <String>[];
  List  Productinvoicelist =[];
  double salespriceff = 0;
  bool showpopup = false;

  final TextEditingController _typeAheadControllergender9 = TextEditingController();


  SuggestionsBoxController suggestionBoxController1 = SuggestionsBoxController();

  List<String> getSuggestionsgender1(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  TextEditingController customername = TextEditingController();
  TextEditingController customerphone = TextEditingController();

  //street name
  TextEditingController customeraddress = TextEditingController(); //street name1
  TextEditingController customerstreet2 = TextEditingController(); //street name1
  TextEditingController customerstate = TextEditingController(); //street state
  TextEditingController customerpincode = TextEditingController();
  TextEditingController customerhomeno = TextEditingController();
  TextEditingController customerarea = TextEditingController();


  SuggestionsBoxController suggestionBoxController2 = SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem1);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



  SuggestionsBoxController suggestionBoxController3 = SuggestionsBoxController();

  List<String> getSuggestionsgender3(String query) {
    List<String> matches = <String>[];
    matches.addAll(ImerisrialListitem2);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> User = [];
  TextEditingController AddnewcustomeGst = TextEditingController();
  TextEditingController Addnewcustomenumber = TextEditingController();
  TextEditingController purchase_No = TextEditingController();
  TextEditingController purchase_Date = TextEditingController();
  TextEditingController purchase_time = TextEditingController();

  //purchase NOtes
  TextEditingController purchase_notes = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController boxno = TextEditingController();


  final TextEditingController _typeAheadControllercateory = TextEditingController();


  final TextEditingController _typeAheadControllerbrand = TextEditingController();
  TextEditingController _typeAheadControllerbrand2 = TextEditingController();

  final TextEditingController _typeAheadControlleritem = TextEditingController();
  final TextEditingController _typeAheadControllerproblem = TextEditingController();

  List<String> categorylist = <String>[];
  List<String> Barndlist = <String>[];
  List<String> itemlist = <String>[];
  List<String> brandlist2 = <String>[];
  List<String> problemlist = <String>[];
  List<String> problemlist2 = <String>[];
  List<TextEditingController> problemcost = List.generate(20, (index) => TextEditingController());
  bool check=false;
  bool check2=false;
  bool check3=false;
  bool check4=false;
  bool status= true;
  bool status2= false;
  bool customervalid = false;

  double totalamount =0;
  double balanceamount =0;
  String Payments = "Please Select Type";
  List<String> Payment = <String>[
    'Please Select Type',
  ];
  addpaymentmode() async {
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

  TextEditingController alphone = new TextEditingController();
  TextEditingController billno = new TextEditingController();
  TextEditingController modelcon = new TextEditingController();
  TextEditingController colorcon = new TextEditingController();
  TextEditingController imeicon = new TextEditingController();
  TextEditingController  passwordcon = new TextEditingController();
  TextEditingController  remarkscon = new TextEditingController();
  TextEditingController  totalcon = new TextEditingController();
  TextEditingController  advancecon = new TextEditingController();
  TextEditingController  discountcon = new TextEditingController();
  TextEditingController  deliverydate = new TextEditingController();
  TextEditingController  deliverytime = new TextEditingController();
  TextEditingController  image1 = new TextEditingController();
  TextEditingController  image2 = new TextEditingController();
  TextEditingController  image3 = new TextEditingController();

  String locktype="Please Select";
  String statustype="Please Select";

  List<int> Patterlist=[];

  List<String> locktypelist=[
    "Please Select",
    "No",
    "Pin",
    "Password",
    "Pattern",
  ];
  List<String> statustypelist=[
    "Please Select",
  ];



  categoryaddfunction() async {
    setState(() {
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('category')
        .orderBy("categoryname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        categorylist.add(Document.docs[i]['categoryname']);
      });

    }
  }
  barndaddfunction() async {
    setState(() {
      Barndlist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        Barndlist.add(Document.docs[i]['Brandname']);
      });

    }
  }
  barndaddfunction2() async {
    setState(() {
      brandlist2.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Service_Brand')
        .orderBy("service brand", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        brandlist2.add(Document.docs[i]['service brand']);
      });

    }
    print(brandlist2);
  }
  itemaddfunction() async {
    setState(() {
      itemlist.clear();
    });
    if (status == true) {
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");
        });
      }
    }
    else{
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");

        });

      }
    }
  }
  itemaddfunctionbycat() async {
    setState(() {
      itemlist.clear();
    });
    if (status == true) {
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if (Document.docs[i]['Category'] == _typeAheadControllercateory.text) {
          setState(() {
            itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");

          });
        }
      }
    }
    else{
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if (Document.docs[i]['Category'] == _typeAheadControllercateory.text) {
          setState(() {
            itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");
          });
        }

      }
    }
  }
  itemaddfunctionbybrand() async {
    setState(() {
      itemlist.clear();
    });
    if (status == true) {
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if (Document.docs[i]['Brand'] == _typeAheadControllerbrand.text) {
          setState(() {
            itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");
          });
        }
      }
    }
    else{
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if (Document.docs[i]['Brand'] == _typeAheadControllerbrand.text) {
          setState(() {
            itemlist.add("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}");
          });
        }

      }
    }
  }
  getcutomerdetails(val) async {
    var Document =  await FirebaseFirestore.instance.collection("Customer").get();
    for (int i = 0; i < Document.docs.length; i++) {
      if (Document.docs[i]['Customermobileno']== val) {
        setState(() {
          alphone.text=Document.docs[i]['Alphone'].toString();
          customername.text=Document.docs[i]['Customername'].toString();
        });
      }
    }
  }
  getitemdetails(val) async {
    if (status == true) {
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if ("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}"== val) {
          setState(() {
            price.text=Document.docs[i]['Saleprice'].toString();
            boxno.text=Document.docs[i]['BoxNo'].toString();
          });
        }
      }
    }
    else{
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        if ("${Document.docs[i]['Newitemname']} - ${Document.docs[i]['Saleprice']} Stocks -  ${Document.docs[i]['TotalQuvantity']}"== val) {
          setState(() {
            price.text=Document.docs[i]['Saleprice'].toString();
            boxno.text=Document.docs[i]['BoxNo'].toString();
          });
        }
      }
    }
  }
  problemaddfunction() async {
    setState(() {
      problemlist.clear();
    });

    var Document = await FirebaseFirestore.instance
        .collection('Service_problem')
        .orderBy("Description", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        problemlist.add("${Document.docs[i]['Description']}");
      });
    }

  }
  statusaddfunction() async {
    setState(() {
      statustypelist.clear();
    });
    setState(() {
      statustypelist.add("Please Select");
    });

    var Document = await FirebaseFirestore.instance
        .collection('Service_Status')
        .orderBy("service status", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        statustypelist.add("${Document.docs[i]['service status']}");
      });
    }

  }

  Widget textfield2(FocusNode focusNode, TextEditingController textEditingController,  onFieldSubmitted) {
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
            style:  GoogleFonts.openSans(
                fontWeight:FontWeight.w700
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: width /220.78, bottom: height / 43.8)),
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
            //clearitemaddfunction();
            textEditingController.clear();
            _typeAheadControllercateory.clear();
            _typeAheadControllerbrand.clear();
            itemaddfunction();
          },
          child: ClipOval(
              child: Container(
                  height: height / 26.28,
                  width: width / 54.64,
                  color: Colors.white,
                  child: const Icon(Icons.clear))),
        )
      ],
    );
  }
  Widget textfield3(FocusNode focusNode, TextEditingController textEditingController,  onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          width: width / 3.515,
          height: height / 21.9,
          //color:Colors.white,
          decoration: const BoxDecoration(

          ),
          child: TextFormField(

            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: width /220.78, bottom: height / 43.8)),
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
            //clearitemaddfunction();

            setState(() {
              problemlist2.add(textEditingController.text);
              textEditingController.clear();
              _typeAheadControllerproblem.clear();
            });
            print(problemlist2);
          },
          child: Container(
              height: height / 26.28,
              width: width / 54.64,
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.black),
                  borderRadius: BorderRadius.circular(50)
              ),

              child: const Icon(Icons.add)),
        )
      ],
    );
  }
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
  int billcount=0;
  billcounts() async {
    print("ok++++++++++++++++");

    var docus1 = await FirebaseFirestore.instance
        .collection("billing ShabikaG")
        .where("save", isEqualTo: true)
        .get();
    print("ok 2++++++++++++++++");
    print("ok 2+++++++++${docus1.docs.length}");
    setState(() {
      billcount=docus1.docs.length + 1;
      print(billcount);
      billno.text = "${(billcount).toString().padLeft(3, "0")}";
    });
    print(billno.text);

  }

String random ="";
  @override
  void initState() {
    setState(() {
      purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      deliverydate.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      random = randomAlphaNumeric(16);
    });

    statusaddfunction();
    itemaddfunction2();
    //billcounts()();
    // TODO: implement initState
    super.initState();
  }


  String docid= "";
  Saveinvoice(){
    setState(() {
      docid= randomAlphaNumeric(16);
    });
    FirebaseFirestore.instance.collection("Service Bills").doc(docid).set({
      "save":true,
      "billno":billno.text,
      "date": purchase_Date.text,
      "time": "${DateFormat('hh:mm a').format(DateTime.now())}",
      "cusmob": _typeAheadControllergender9.text,
      "cusalmob": alphone.text,
      "cusname": customername.text,
      "brand": _typeAheadControllerbrand2.text,
      "model": modelcon.text,
      "color":colorcon.text,
      "imei":imeicon.text,
      "battery":check,
      "sim":check2,
      "mmc":check3,
      "charger":check4,
      "phonelocktype":locktype,
      "password":passwordcon.text,
      "status":statustype,
      "received person":"",
      "totalcost":totalamount,
      "advance":advancecon.text,
      "balance":balanceamount,
      "discount":discountcon.text,
      "img1":img1url,
      "img2":img2url,
      "img3":img3url,
      "deliverydate":deliverydate.text,
      "deliverytime":deliverytime.text,
      "patternlist":Patterlist,
      "timestamp":DateTime.now().millisecondsSinceEpoch,
      "Paymentmode":Payments,
      "remarks":remarkscon.text
    });
    for(int i=0;i<problemlist2.length;i++) {
      FirebaseFirestore.instance.collection("Service Bills").doc(docid)
          .collection("Problems").doc()
          .set({
        "problem":problemlist2[i],
        "cost":problemcost[i].text
      });
    }
  }
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
                        "Bill Saved Successfully..",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                _typeAheadControllergender9.text="";
                                customername.text="";
                                customerphone.text="";
                                _typeAheadControllerbrand2.clear();
                                alphone.clear();
                                billno.clear();
                                modelcon.clear();
                                colorcon.clear();
                                imeicon.clear();
                                passwordcon.clear();
                                remarkscon.clear();
                                totalcon.clear();
                                advancecon.clear();
                                discountcon.clear();
                                check=false;
                                check2=false;
                                check3=false;
                                check4=false;
                                problemlist2.clear();
                                problemcost.clear();
                                totalamount=0;
                                advancecon.clear();
                                balanceamount=0;
                                discountcon.clear();
                                locktype ="Please Select";
                                statustype= "Please Select";
                                _typeAheadControllercateory.clear();
                                _typeAheadControllerbrand.clear();
                                _typeAheadControlleritem.clear();
                                price.clear();
                                boxno.clear();
                                purchase_Date.clear();
                                purchase_time.clear();
                                deliverytime.clear();
                                deliverydate.clear();
                                Serviceproblems.clear();
                                Serviceproblemscost.clear();
                                random= randomAlphaNumeric(16);


                              });

                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 21.9,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.openSans(
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
                                height: height / 21.9,
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
                )),
          ),
        );
      },
    );
  }
  viewimage(n,val,name) {
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

                content: SizedBox(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 99.85,
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),

                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Image.network(val),
                      ),
                      SizedBox(
                        height: height / 53.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 21.9,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.openSans(
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
                              if(n==1){
                                selectimage1();
                              }
                              if(n==2){
                                selectimage2();
                              }
                              if(n==3){
                                selectimage3();
                              }
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff263646),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 21.9,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text("Re-Take",
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
                )),
          ),
        );
      },
    );
  }


  String img1url= "";
  String img2url= "";
  String img3url= "";

  selectimage1(){
    setState(() {
      image1.text="Loading...";
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
                  image1.text=file.name;
                  img1url=downloadUrl;
                });

              });
        });
  }
  selectimage2(){
    setState(() {
      image2.text="Loading...";
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
                  image2.text=file.name;
                  img2url=downloadUrl;
                });

              });
        });
  }
  selectimage3(){
    setState(() {
      image3.text="Loading...";
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
                  image3.text=file.name;
                  img3url=downloadUrl;
                });

              });
        });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
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
                          // billcounts();
                          // itemaddfunction();
                          // itemcodeaddfunction();
                        }
                        else {
                          setState(() {
                            status2 = val;
                          });

                          // itemcodeaddfunction();
                        }
                        itemaddfunction2();
                      });
                    },
                  ),
                ),
                Text(
                  "Shabika G",
                  style: GoogleFonts.openSans(
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

                      setState(() {
                        if (val == true) {
                          setState(() {
                            status2 = val;
                            status = false;
                          });
                          // billcounts();
                          // itemaddfunction();
                          // itemcodeaddfunction();
                        }
                        else {
                          setState(() {
                            status = val;
                          });
                          //itemaddfunction();
                          //itemcodeaddfunction();
                        }
                        itemaddfunction2();
                      });
                    },
                  ),
                ),
                Text(
                  "Shabika N",
                  style: GoogleFonts.openSans(
                      color: Colors.white, fontSize: width / 80.353),
                ),
              ],
            ),
            /*  Row(
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Customer Phone",
                                style:GoogleFonts.openSans(
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
                              child: Focus(
                                  focusNode: customerphone2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 130, right: width / 170),
                                    child:
                                    LayoutBuilder(
                                      builder: (BuildContext, BoxConstraints) =>
                                          Autocomplete<String>(
                                            fieldViewBuilder: (context, textEditingController,
                                                focusNode, onFieldSubmitted) {

                                              return  TextFormField(
                                                onChanged: (_){
                                                  setState((){
                                                    _typeAheadControllergender9.text=textEditingController.text;
                                                  });
                                                },
                                                style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize: width/85,),
                                                decoration: InputDecoration(

                                                  suffixIcon: Container(
                                                    width: 70,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                            onTap: (){
                                                              Userdata();
                                                              //AddnewcustomeGst.clear();
                                                            },
                                                            child:  const Icon(Icons.refresh,size: 20)),
                                                        InkWell(
                                                            onTap: (){

                                                              setState(() {
                                                                customerphone.clear();
                                                                alphone.clear();
                                                                customername.clear();
                                                                textEditingController.clear();
                                                              });

                                                              //AddnewcustomeGst.clear();
                                                            },
                                                            child:  const Icon(Icons.clear,size: 20)),
                                                      ],
                                                    ),
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.only(
                                                      left: width /90.78,
                                                      top: height / 153.8),

                                                ),
                                                controller: textEditingController,
                                                focusNode: focusNode,
                                                onFieldSubmitted: (String value) {
                                                  onFieldSubmitted();
                                                },
                                              );

                                            },
                                            initialValue: const TextEditingValue(
                                                text:"",
                                                selection: TextSelection(
                                                  isDirectional: true,
                                                  baseOffset: 5,
                                                  extentOffset: 1,
                                                )),
                                            optionsViewBuilder:
                                                (context, onSelected, options) => Align(
                                                alignment: Alignment.topLeft,
                                                child: Material(
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom: Radius.circular(
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
                                                            padding: const EdgeInsets.all(
                                                                16.0),
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
                                                //check(textEditingValue.text.toString());
                                              }

                                              return User.where((String option) {
                                                return option.toLowerCase().contains(
                                                    textEditingValue.text
                                                        .toLowerCase());
                                              });
                                            },
                                            onSelected: (String selection) {
                                              setState(() {
                                                customerphone.text = selection;
                                                _typeAheadControllergender9.text = selection;
                                              });
                                              getcutomerdetails(selection);

                                              // check(_typeAheadControllergender9.text.toString());

                                              debugPrint(
                                                  'You just selected $selection');
                                            },
                                            displayStringForOption: (Value) {
                                              return Value;
                                            },
                                          ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: width / 273.2,
                            ),
                            InkWell(
                              onTap: () {
                                //checkagain();
                              },
                              child:  GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>Customer("Entry"))
                                  );
                                },
                                child: ClipOval(
                                    child: Container(
                                        height: height / 21.9,
                                        width: width / 45.53,
                                        color: Colors.white,
                                        child: const Icon(Icons.add))),
                              ),
                            ),
                            SizedBox(
                              width: width / 273.2,
                            ),
                            InkWell(
                              onTap: () {
                                //checkagain();
                              },
                              child:  GestureDetector(
                                onTap: () async {
                                  String userid='';
                                  var document = await FirebaseFirestore.instance.collection("Customer").get();
                                  for(int i=0; i<document.docs.length;i++) {
                                    if (document.docs[i]["Customermobileno"] == _typeAheadControllergender9.text){
                                      setState(() {
                                        userid = document.docs[i].id;
                                      });
                                    }
                                  }
                                  if(userid!='') {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          EditCustomer_Page(userid,"Entry"),));
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Kindly add the customer")));
                                  }
                                },
                                child: ClipOval(
                                    child: Container(
                                        height: height / 21.9,
                                        width: width / 45.53,
                                        color: Colors.white,
                                        child: const Icon(Icons.edit))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Alternative No: ",
                                style:GoogleFonts.openSans(
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
                                focusNode: customeraddress2,
                                controller: alphone,
                                decoration: InputDecoration(
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  customeraddress2.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(customername2);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Customer name
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Customer Name",
                                style:GoogleFonts.openSans(
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
                                focusNode: customername2,
                                controller: customername,
                                decoration: InputDecoration(
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
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




                      //tax type
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Bill No",
                                style:GoogleFonts.openSans(
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
                              child: Container(
                                width: width / 3.415,
                                height: height / 21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,fontSize: width/85,),
                                  focusNode: billno2,
                                  controller: billno,
                                  decoration: InputDecoration(
                                    suffixIcon:
                                    Icon(Icons.circle,color:Colors.white),
                                    contentPadding: EdgeInsets.only(
                                        left: width /90.78,
                                        top: height / 153.8),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) {
                                    customername2.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(customeraddress2);
                                  },
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Date Time",
                                style:GoogleFonts.openSans(
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
                                controller: purchase_Date,
                                focusNode: purchase_date,
                                decoration: InputDecoration(

                                    contentPadding: EdgeInsets.only(
                                        left: width /90.78,
                                        top: height / 153.8),
                                    hintText: "Invoice Date",
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(Icons.calendar_month)),
                                onSubmitted: (_) {
                                  purchase_date.unfocus();

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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Category",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,fontSize: width/85,),

                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  right: width / 170),
                              child: LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context, textEditingController,
                                          focusNode, onFieldSubmitted) {
                                        return textfield2(
                                          focusNode,
                                          textEditingController,
                                          onFieldSubmitted,
                                        );
                                      },
                                      initialValue: const TextEditingValue(
                                          selection: TextSelection(
                                            isDirectional: true,
                                            baseOffset: 5,
                                            extentOffset: 1,
                                          )),
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
                                                      padding: const EdgeInsets.all(16.0),
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
                                            _typeAheadControllercateory.text =
                                                textEditingValue.text;
                                          });
                                          //itemaddfunction();
                                          //itemcodeaddfunction();
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
                                        itemaddfunctionbycat();
                                        //itemaddfunction();
                                        //itemcodeaddfunction();
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Brand",
                                style:GoogleFonts.openSans(
                                    fontSize: width/85,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff000000)),

                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: width / 170),
                              child: LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context, textEditingController,
                                          focusNode, onFieldSubmitted) {
                                        return textfield2(
                                          focusNode,
                                          textEditingController,
                                          onFieldSubmitted,
                                        );
                                      },
                                      initialValue: const TextEditingValue(
                                          selection: TextSelection(
                                            isDirectional: true,
                                            baseOffset: 5,
                                            extentOffset: 1,
                                          )),
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
                                                      padding: const EdgeInsets.all(16.0),
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
                                            _typeAheadControllerbrand.text =
                                                textEditingValue.text;
                                          });
                                          itemaddfunctionbybrand();
                                          //itemaddfunction();
                                          //itemcodeaddfunction();
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
                                        //itemaddfunction();
                                        //itemcodeaddfunction();
                                      },
                                      displayStringForOption: (Value) {
                                        return Value;
                                      },
                                    ),
                              ),),


                          ],
                        ),
                      ),
                      //Purchase  Date





                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Item Name",
                                style:GoogleFonts.openSans(
                                    fontSize: width/85,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff000000)),

                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(

                                right: width / 170,
                              ),
                              child: LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context, textEditingController,
                                          focusNode, onFieldSubmitted) {
                                        return textfield2(
                                          focusNode,
                                          textEditingController,
                                          onFieldSubmitted,
                                        );
                                      },
                                      initialValue: const TextEditingValue(
                                          selection: TextSelection(
                                            isDirectional: true,
                                            baseOffset: 5,
                                            extentOffset: 1,
                                          )),
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
                                                      padding: const EdgeInsets.all(16.0),
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
                                            _typeAheadControlleritem.text =
                                                textEditingValue.text;
                                          });

                                          //itemaddfunction();
                                          //itemcodeaddfunction();
                                        }

                                        return itemlist.where((String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          _typeAheadControlleritem.text = selection;

                                        });
                                        getitemdetails(selection);
                                        //itemaddfunction();
                                        //itemcodeaddfunction();
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

                      //Remarks
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Price",
                                style:GoogleFonts.openSans(
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
                                controller: price,
                                focusNode: price2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
                                  border: InputBorder.none,
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                ),
                                onSubmitted: (_) {
                                  price2.unfocus();
                                  FocusScope.of(context).requestFocus(boxno2);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Box No",
                                style:GoogleFonts.openSans(
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
                                controller: boxno,
                                focusNode: boxno2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
                                  border: InputBorder.none,
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                ),
                                onSubmitted: (_) {
                                  boxno2.unfocus();
                                  //FocusScope.of(context).requestFocus(items_id);
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
            ),*/
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
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Bill No",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Customer Phone",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Alternative Phone",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //itemid
                        //itemname
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Customer Name",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Received Date",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),



                        //Box No
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Received Time",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //Hsn Code
                        SizedBox(
                          width: width / 2.5,
                          child: Center(
                              child: Text(
                                "Remarks",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //tax



                      ],
                    ),
                  ),
                ),

                Container(
                  width: width / 0.976,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Serial no
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:TextField(
                          onSubmitted: (val){
                            getbilldetails(val);

                          },
                          controller: billno,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: _typeAheadControllergender9,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: alphone,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),

                      //itemid


                      //itemname
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: customername,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:  TextField(
                          controller: purchase_Date,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),

                      ),

                      //Box No
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
child:TextField(
  controller: purchase_time,
  decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: width / 136.6, bottom: height / 65.7),
          hintText: ""),
),
                      ),

                      //Hsn Code
                      Container(
                        width: width / 2.5,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:  TextField(
                          controller: remarkscon,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),



                    ],
                  ),
                ),


              ],
            ),
            SizedBox(height:  height / 100.4,),
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
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Brand",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Model",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: width / 10.533,
                          child: Center(
                              child: Text(
                                "Color",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //itemid
                        //itemname
                        SizedBox(
                          width: width / 3.5,
                          child: Center(
                              child: Text(
                                "Service Problem",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(width: width / 28.76),
                        SizedBox(
                          width: width / 8.2,
                          child: Center(
                              child: Text(
                                "IMEI NO",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),



                        //Box No
                        SizedBox(
                          width: width / 16.7,
                          child: Center(
                              child: Text(
                                "Battery",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //Hsn Code
                        SizedBox(
                          width: width / 17.8,
                          child: Center(
                              child: Text(
                                "SIM",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //tax
                        SizedBox(
                          width: width / 16.18,
                          child: Center(
                              child: Text(
                                "MMC",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //quvantity
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                                "Charger",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),


                      ],
                    ),
                  ),
                ),

                Container(
                  width: width / 0.976,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Serial no
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:  LayoutBuilder(
                          builder: (BuildContext, BoxConstraints) =>
                              Autocomplete<String>(
                                fieldViewBuilder: (context, textEditingController,
                                    focusNode, onFieldSubmitted) {
                                  return TextFormField(

                                    onChanged: (_) {
                                      setState(() {
                                        _typeAheadControllerbrand2 = textEditingController;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 273.2,top:height/80.8
                                        )),
                                    controller: _typeAheadControllerbrand2,
                                    focusNode: focusNode,
                                    onFieldSubmitted: (String value) {
                                      onFieldSubmitted();
                                    },
                                  );
                                },
                                optionsViewBuilder: (context, onSelected, options) =>
                                    Align(
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
                                                      option,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )),
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return const Iterable<String>.empty();
                                  }

                                  return brandlist2.where((String option) {
                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                  });
                                },
                                onSelected: (String selection) {

                                  setState(() {
                                    _typeAheadControllerbrand2.text = selection;
                                    showpopup = false;
                                  });

                                  debugPrint('You just selected $selection');
                                },
                                displayStringForOption: (Value) {
                                  return Value;
                                },
                              ),
                        ),
                      ),
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: modelcon,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),
                      Container(
                        width: width / 10.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: colorcon,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),
                      ),

                      //itemid


                      //itemname
                      Container(
                        width: width / 3.2,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:LayoutBuilder(
                          builder: (BuildContext, BoxConstraints) =>
                              Autocomplete<String>(
                                fieldViewBuilder: (context, textEditingController,
                                    focusNode, onFieldSubmitted) {
                                  return textfield3(
                                    focusNode,
                                    textEditingController,
                                    onFieldSubmitted,
                                  );
                                },
                                initialValue: const TextEditingValue(
                                    selection: TextSelection(
                                      isDirectional: true,
                                      baseOffset: 5,
                                      extentOffset: 1,
                                    )),
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
                                                padding: const EdgeInsets.all(16.0),
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
                                      _typeAheadControllerproblem.text =
                                          textEditingValue.text;
                                    });
                                    //itemaddfunction();
                                    //itemcodeaddfunction();
                                  }
                                  return problemlist.where((String option) {
                                    return option.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    _typeAheadControllerproblem.text = selection;
                                  });
                                  //itemaddfunctionbycat();

                                },
                                displayStringForOption: (Value) {
                                  return Value;
                                },
                              ),
                        ),
                      ),
                      Container(
                        width: width / 8.2,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:  TextField(
                          controller: imeicon,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: ""),
                        ),

                      ),

                      //Box No
                      Container(
                        width: width / 14.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:    Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check= value!;

                            });

                          },
                        ),
                      ),

                      //Hsn Code
                      Container(
                        width: width / 14.9,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:    Checkbox(
                          value: check2,
                          onChanged: (value) {
                            setState(() {
                              check2= value!;

                            });

                          },
                        ),
                      ),

                      //tax
                      Container(
                        width: width / 16.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:    Checkbox(
                          value: check3,
                          onChanged: (value) {
                            setState(() {
                              check3= value!;

                            });

                          },
                        ),
                      ),

                      //quvantity
                      Container(
                        width: width / 16.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:    Checkbox(
                          value: check4,
                          onChanged: (value) {
                            setState(() {
                              check4= value!;

                            });

                          },
                        ),
                      ),


                    ],
                  ),
                ),


              ],
            ),
            SizedBox(height:  height / 100.4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xff1D5B79),
                      width: width / 8.9,
                      height: height / 16.425,
                      child: Center(
                          child: Text(
                            "Phone Lock",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 8.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child:
                      Padding(
                        padding: EdgeInsets.only(
                          left: width / 130,
                          right: width / 170,
                        ),
                        child: DropdownButton2<String>(
                          value: locktype,
                          isExpanded: true,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: width / 105.07),
                          underline: Container(
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              locktype = value!;
                            });
                          },
                          items: locktypelist.map<DropdownMenuItem<String>>(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xff1D5B79),
                      width: width / 8.9,
                      height: height / 16.425,
                      child: Center(
                          child: Text(
                            "Password/PN",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 8.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: passwordcon,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
                      ),

                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xff1D5B79),
                      width: width / 8.9,
                      height: height / 16.425,
                      child: Center(
                          child: Text(
                            "Delivery Date",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 8.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: deliverydate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
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
                              deliverydate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },

                      ),

                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xff1D5B79),
                      width: width / 8.9,
                      height: height / 16.425,
                      child: Center(
                          child: Text(
                            "Delivery Time",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 8.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: deliverytime,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (picked != null && picked != TimeOfDay.now()) {
                            _formatTime(picked!);
                          }

                        },
                      ),

                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 8.9,
                      height: height / 16.425,
                      color: Color(0xff1D5B79),
                      child: Center(
                          child: Text(
                            "Status",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 8.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width / 130,
                          right: width / 170,
                        ),
                        child: DropdownButton2<String>(
                          value: statustype,
                          isExpanded: true,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: width / 105.07),
                          underline: Container(
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              statustype = value!;
                            });
                          },
                          items: statustypelist.map<DropdownMenuItem<String>>(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 6.9,
                      height: height / 16.425,
                      color: Color(0xff1D5B79),
                      child: Center(
                          child: Text(
                            "Image 1",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 6.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: image1,
                        onTap: (){
                         /* if(img1url=="") {
                            selectimage1();
                          }
                          else{
                            viewimage(1,img1url,image1.text);
                          }*/
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
                      ),

                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 6.9,
                      height: height / 16.425,
                      color: Color(0xff1D5B79),
                      child: Center(
                          child: Text(
                            "Image 2",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 6.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: image2,
                        onTap: (){
                         /* if(img2url=="") {
                            selectimage2();
                          }
                          else{
                            viewimage(2,img2url,image2.text);
                          }*/
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 6.9,
                      height: height / 16.425,
                      color: Color(0xff1D5B79),
                      child: Center(
                          child: Text(
                            "Image 3",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 6.9,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
                        controller: image3,
                        onTap: (){
                          /*if(img3url=="") {
                            selectimage3();
                          }
                          else{
                            viewimage(3,img3url,image3.text);
                          }*/
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                            hintText: ""),
                      ),
                    ),
                  ],
                ),

              ],
            ),



            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: height / 100.4, left: width / 80.32),
                  child: Material(
                    elevation: 50,
                    shadowColor: Colors.black38,
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        width: width / 2.05,
                        height: height / 5.14,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12)),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                children:[
                                  Container(
                                    width: 552,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Color(0xff1D5B79),
                                        border: Border.all(color: Colors.black, width: 0.6),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12)
                                        )
                                    ),
                                    child: Center(
                                      child: Text( "Service Problems",
                                        style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),),
                                    ),
                                  ),
                                  Container(

                                    width: width / 9.6,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                      color: Color(0xff1D5B79),
                                      border: Border.all(color: Colors.black, width: 0.6),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12)
                                      ),
                                    ),
                                    child: Center(
                                      child: Text( "Cost",
                                        style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),),
                                    ),
                                  ),
                                ]
                            ),

                            Container(
                              height: height / 5.14-height / 21.9,
                              child: ListView.builder(
                                itemCount: Serviceproblems.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return  Row(
                                      children:[
                                        Container(
                                          width: 552,
                                          height: height / 21.9,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 0.6),

                                          ),
                                          child: Center(
                                            child: Text(Serviceproblems[index],
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800),overflow: TextOverflow.ellipsis,),
                                          ),
                                        ),
                                        Container(

                                          width: width / 9.6,
                                          height: height / 21.9,
                                          decoration: BoxDecoration(

                                            border: Border.all(color: Colors.black, width: 0.6),

                                          ),
                                          child: Center(
                                            child: Text(
                                              Serviceproblemscost[index],

                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800),

                                            ),
                                          ),
                                        ),
                                      ]
                                  );

                                },

                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
                locktype=="Pattern"?
                Padding(
                  padding:  EdgeInsets.only(top: height / 100.4, left: width / 80.32),
                  child: Container(
                    height: height / 5.14,
                    width:width/7.732,
                    color:Colors.white,
                    child: Column(

                      children: [
                        Text( "Pattern",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),),
                        SizedBox(
                          width:width/8.415,
                          height: height / 6,
                          child: PatternLock2(
                            used: patternlist,
                            // color of selected points.
                            selectedColor: Colors.red,
                            // radius of points.
                            pointRadius: 10,
                            // whether show user's input and highlight selected points.
                            showInput: true,
                            // count of points horizontally and vertically.
                            dimension: 3,
                            // padding of points area relative to distance between points.
                            relativePadding: 0.7,
                            // needed distance from input to point to select point.
                            selectThreshold: 25,
                            // whether fill points.
                            fillPoints: true,
                            // callback that called when user's input complete. Called if user selected one or more points.
                            onInputComplete: (List<int> input) {
                              setState(() {
                                Patterlist.clear();
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                setState(() {
                                  Patterlist=input;
                                  passwordcon.text=input.toString();
                                });
                              });


                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ): SizedBox(),


              ],
            ),
            SizedBox(height:  height / 100.4,),
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
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //itemid
                        SizedBox(
                          width: width / 14.2,
                          child: Center(
                              child: Text(
                                "Item ID",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //itemname
                        SizedBox(
                          width: width / 2.9,
                          child: Center(
                              child: Text(
                                "Item Name",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        SizedBox(width: width / 24.76),

                        //Box No
                        SizedBox(
                          width: width / 16.7,
                          child: Center(
                              child: Text(
                                "Box No",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                        SizedBox(width: width / 24.76),
                        //Hsn Code
                        SizedBox(
                          width: width / 17.8,
                          child: Center(
                              child: Text(
                                "HSN Code",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //tax

                        SizedBox(width: width / 104.76),
                        //quvantity
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                                "Qnty",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //withou Tax
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                                "Price",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //Sales Price
                        SizedBox(
                          width: width / 14.0,
                          child: Center(
                              child: Text(
                                "Sales Price",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //Stocks
                        SizedBox(
                          width: width / 15.0,
                          child: Center(
                              child: Text(
                                "Stocks",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),

                        //Clear controllers
                        SizedBox(
                          width: width / 13.18,
                          child: Center(
                              child: Text(
                                "Clear ",
                                style:
                                GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: width / 0.976,
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                        child: LayoutBuilder(
                          builder: (BuildContext , BoxConstraints )=>
                              Autocomplete<String>(
                                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                  return
                                    TextFormField(
                                      style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                      onChanged: (_){
                                        setState(() {
                                          layourbuilderclear3=textEditingController;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: width /220.78,bottom:height/43.8)
                                      ),
                                      controller: layourbuilderclear3,
                                      focusNode: focusNode,
                                      onFieldSubmitted: (String value) {
                                        onFieldSubmitted();
                                      },
                                    );
                                },
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
                                                child: Text(option,     style:GoogleFonts.openSans(fontWeight: FontWeight.w700),),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                ),
                                optionsBuilder: (TextEditingValue textEditingValue) {

                                  if (textEditingValue.text == '') {
                                    setState(() {});
                                    return const Iterable<String>.empty();

                                  }
                                  return
                                    Itemlist2.where((String option) {
                                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                    });
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    itemid.text = selection;
                                  });
                                  //createpurchase3(selection.toString());

                                  debugPrint('You just selected $selection');
                                },
                                displayStringForOption: (value){
                                  return value;
                                },
                              ),
                        ),

                      ),

                      //itemname
                      Container(
                        width: width / 2.7,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child:
                        Padding(
                          padding: EdgeInsets.only(
                            left: width / 130,
                            right: width / 170,
                          ),
                          child:
                          LayoutBuilder(
                            builder: (BuildContext, BoxConstraints) =>
                                Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController,
                                      focusNode, onFieldSubmitted) {
                                    return TextFormField(
                                      style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                      onChanged: (_) {
                                        setState(() {
                                          layourbuilderclear2 = textEditingController;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: width / 273.2,top:height/80.8
                                          )),
                                      controller: layourbuilderclear2,
                                      focusNode: focusNode,
                                      onFieldSubmitted: (String value) {
                                        onFieldSubmitted();
                                      },
                                    );
                                  },
                                  optionsViewBuilder: (context, onSelected, options) =>
                                      Align(
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
                                                        option, style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )),
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return const Iterable<String>.empty();
                                    }

                                    return Itemlist.where((String option) {
                                      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String selection) {
                                    createpurchase2(selection.toString());
                                    setState(() {
                                      itemname.text = selection;
                                      layourbuilderclear2.text = selection;
                                      showpopup = false;
                                    });
                                    debugPrint('You just selected $selection');
                                  },
                                  displayStringForOption: (Value) {
                                    return Value;
                                  },
                                ),
                          ),
                        ),
                      ),

                      //Box No
                      Container(
                        width: width / 10.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                        width: width / 10.9,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                          controller: HSN_Code,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                        ),
                      ),

                      //tax


                      //quvantity
                      Container(
                        width: width / 16.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                          controller: Qty,
                          focusNode: Quvantitylist,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            if (int.parse(Stocks.text) > 0) {

                              if (Qty.text.length > 0) {

                                checkgst(Sales.text, Qty.text);

                                //check the imei and seriall functiom
                                serialvalue == true ||
                                    imeivalue == true ||
                                    color == true &&
                                        int.parse(Stocks.text) > 0
                                    ?
                                //create a document (Firebase)
                                showtextfield(int.parse(Qty.text), serialvalue, imeivalue, color,image,context):
                                serialvalue == false && imeivalue == false &&
                                    color == false && int.parse(Stocks.text) > 0
                                    ? Purchaseitem()
                                    : empty();
                                Quvantitylist.unfocus();
                              }
                            } else {
                              incorrectpopup();
                            }
                          },
                          onTap: () {
                            setState(() {
                              showpopup = false;
                            });
                          },
                          onChanged: (_) {
                            setState(() {
                              showpopup = false;
                            });
                            if (_typeAheadControllergender9.text.length > 0 ||
                                Cusname.text != "") {
                              if (Qty.text.length > 0) {
                                checkgst(Sales.text, Qty.text);
                              }
                            } else {
                              incorrectpopup();
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
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
                          controller: Sales,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                        ),
                      ),

                      //Stocks
                      Container(
                        width: width / 15.3,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          style:GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                              border: Border.all(color: Colors.black, width: 0.6)),
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
                Material(
                  elevation: 50,
                  shadowColor: Colors.black38,
                  color: const Color(0xffFFFFFF),
                  child: Container(
                    width: width / 0.976,
                    height: height / 6.15,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("billing").doc(random).collection(random).orderBy("timestamp").snapshots(),
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
                                children: [
                                  //Serial no
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
                                      width: width / 45.533,
                                      height: height / 16.425,
                                      child:
                                      TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: " ${index + 1}",
                                            hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                        ),
                                      )
                                  ),

                                  //itemid
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
                                      width: width / 14.2,
                                      height: height / 16.425,

                                      child:
                                      TextField(
                                        controller: _Streamcontroller1[index],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "${billing['itemcode']}",
                                            hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                        ),
                                        onSubmitted: (_){
                                          FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                            'itemcode':_Streamcontroller1[index].text,
                                          });

                                        },
                                      )
                                  ),

                                  //itemname
                                  Tooltip(
                                    message:"${billing['Description']}",
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
                                      width: width / 2.7+width / 10.8,
                                      height: height / 16.425,
                                      child:
                                      TextField(

                                        controller: _Streamcontroller2[index],
                                        decoration: InputDecoration(

                                            border: InputBorder.none,
                                            hintText: "${billing['Description']}",
                                            hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                        ),
                                        onSubmitted: (_){
                                          FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                            'Description':_Streamcontroller2[index].text,
                                          });

                                        },
                                      ),


                                    ),
                                  ),


                                  //Hsn code
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),

                                      width: width / 10.9,
                                      height: height / 16.425,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:width/136.6),
                                        child: TextField(
                                          controller: _Streamcontroller3[index],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "${billing['Hsncode']}",
                                              hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                          ),
                                          onSubmitted: (_){
                                            FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                              'Hsncode':_Streamcontroller3[index].text,
                                            });
                                          },
                                        ),
                                      )),

                                  //quvantity
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
                                     width: width / 16.8,
                                      height: height / 16.425,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:width/68.3),
                                        child: TextField(

                                          controller: _Streamcontroller5[index],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "${billing['Qty']}",
                                              hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                          ),
                                          onSubmitted: (_) async {
                                            //create a document (Firebase)
                                           /* FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                              'Qty':int.parse(_Streamcontroller5[index].text),
                                              'Sales price': (int.parse(_Streamcontroller5[index].text.toString())* double.parse(salespriceff.toString())).toString(),
                                            });
                                            billing['Serial NO']==true||
                                                billing['IMEI NO']==true||
                                                billing['Color']==true?

                                            showquvantitytextfield(
                                                int.parse(_Streamcontroller5[index].text),
                                                billing['Serial NO'],
                                                billing['IMEI NO'],
                                                billing['Color']):
                                            updatetotal();
                                            setState((){
                                              _Streamcontroller7[index].text= (int.parse(_Streamcontroller5[index].text)*double.parse(salespriceff.toString())) .toString();
                                              _Streamcontroller6[index].text=(double.parse(_Streamcontroller6[index].text) / 1.18).round().toStringAsFixed(2);
                                            });
*/
                                          },
                                        ),
                                      )),

                                  // Price
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),

                                      width: width / 13.8,
                                      height: height / 16.425,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:width/136.6),
                                        child: TextField(
                                          controller: _Streamcontroller6[index],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "${billing['withouttaxprice']}",
                                              hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                          ),
                                          onSubmitted: (_){
                                            setState((){
                                              _Streamcontroller6[index].text=(double.parse(_Streamcontroller6[index].text) / 1.18).round().toStringAsFixed(2);
                                            });
                                            FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                              'withouttaxprice':_Streamcontroller6[index].text,
                                            });

                                            //updatetotal();

                                          },
                                        ),
                                      )),

                                  //Sales Price
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
                                      width: width / 13.8,
                                      height: height / 16.425,
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:width/136.6),
                                        child: TextField(
                                          controller: _Streamcontroller7[index],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: billing['Sales price'].toString(),
                                              hintStyle:  GoogleFonts.openSans(color: Colors.black)
                                          ),
                                          onSubmitted: (_){
                                            FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(billing.id).update({
                                              'Sales price': int.parse(_Streamcontroller5[index].text)* double.parse(_Streamcontroller7[index].text),
                                            });

                                            // updatetotal();
                                            // SGSTfunction();
                                            // CGSTfunction();
                                            // Totalamounts();

                                          },
                                        ),
                                      )),
                                  Container(
                                    decoration: BoxDecoration(
                                        border:Border.all(
                                            color:Colors.black87
                                        )
                                    ),width: width / 15.3, height: height / 16.425,),

                                  //remove
                                  Container(
                                      decoration: BoxDecoration(
                                          border:Border.all(
                                              color:Colors.black87
                                          )
                                      ),
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
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:0.0,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:(){
                      totalcollectionamount();
                      Savebillpopup();
                      },
                    child: Container(
                      width: width / 5.6,
                      height: height / 16.42,
                      //color: Color(0xffD60A0B),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff1D5B79),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Update Status",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
        isloading ==true? Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: CircularProgressIndicator(color: Colors.white,),
        ) : SizedBox()
      ],
    );
  }

  String documentid="";
  getbilldetails(value) async {
    var document1 =  await FirebaseFirestore.instance.collection("Service Bills").get();
    for(int i=0;i<document1.docs.length;i++){
      if(document1.docs[i]["billno"]==value){
        setState(() {
          documentid=document1.docs[i].id;
        });

      }
    }
    print("Fun Called");
    var document =  await FirebaseFirestore.instance.collection("Service Bills").doc(documentid).get();
    Map<String,dynamic> ? val = document.data();
    setState(() {

      _typeAheadControllerbrand2.text =val!["brand"];
      purchase_Date.text=val["date"];
      purchase_time.text=val["time"];
      check3=val["mmc"];
      check=val["battery"];
      check4=val["charger"];
      check2=val["sim"];
      colorcon.text=val["color"];
      imeicon.text=val["imei"];
      modelcon.text=val["model"];
      //receivedperson=val["received person"];

      _typeAheadControllergender9.text=val["cusmob"];
      alphone.text=val["cusalmob"];
      customername.text=val["cusname"];
      cusid=val["cusid"];
      deliverydate.text=val["deliverydate"];
      deliverytime.text=val["deliverytime"];
      Payments=val["Paymentmode"];
      remarkscon.text=val["remarks"];
      locktype=val["phonelocktype"];
      passwordcon.text=val["password"];
      statustype=val["status"];



      for(int i=0;i<val["patternlist"].length;i++){
        patternlist.add(val["patternlist"][i]);
      }
    });


    var document2 =  await FirebaseFirestore.instance.collection("Service Bills").doc(documentid).collection("Problems").get();
    for(int i=0;i<document2.docs.length;i++){
      setState(() {
        Serviceproblems.add(document2.docs[i]["problem"]);
        Serviceproblemscost.add(document2.docs[i]["cost"]);
      });
    }

  }
  List Serviceproblems =[];
  List Serviceproblemscost =[];
  List<int> patternlist =[];

  itemaddfunction2() async {
    setState(() {
      Itemlist.clear();
    });
    if (_typeAheadControllerbrand.text.isNotEmpty &&
        _typeAheadControllercateory.text.isNotEmpty&&status==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .where("Category", isEqualTo: _typeAheadControllercateory.text)
          .where("Brand", isEqualTo: _typeAheadControllerbrand.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {

        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllerbrand.text.isNotEmpty &&
        _typeAheadControllercateory.text.isNotEmpty&&status2==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .where("Category", isEqualTo: _typeAheadControllercateory.text)
          .where("Brand", isEqualTo: _typeAheadControllerbrand.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllerbrand.text.isNotEmpty &&
        _typeAheadControllercateory.text.isEmpty&&status==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .where("Brand", isEqualTo: _typeAheadControllerbrand.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllerbrand.text.isNotEmpty &&
        _typeAheadControllercateory.text.isEmpty&&status2==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .where("Brand", isEqualTo: _typeAheadControllerbrand.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }


    if (_typeAheadControllercateory.text.isNotEmpty &&
        _typeAheadControllerbrand.text.isEmpty&&status==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .where("Category", isEqualTo: _typeAheadControllercateory.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllercateory.text.isNotEmpty &&
        _typeAheadControllerbrand.text.isEmpty&&status2==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .where("Category", isEqualTo: _typeAheadControllercateory.text)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllerbrand.text.isEmpty &&
        _typeAheadControllercateory.text.isEmpty&&status==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

    if (_typeAheadControllerbrand.text.isEmpty &&
        _typeAheadControllercateory.text.isEmpty&&status2==true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        Itemlist.add("${Document.docs[i]['Newitemname']}-(${Document.docs[i]['Itemcode']})");
      }
    }

  }
  String deletewuvantity = "";
  String deletestocksitems = "";

  deletecollection(id) async {
    setState((){
      deletewuvantity="";
    });
    var documentget = await FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(id).get();
    Map<String, dynamic>? values = documentget.data();
    setState(() {
      deletewuvantity = values!['Qty'];
      deletestocksitems = values['Item'];
    });

    var documentgetdate=await FirebaseFirestore.instance.collection("Purchase entry").get();

    for(int p=0;p<documentgetdate.docs.length;p++){

      var documentgetdate2=await FirebaseFirestore.instance.collection("Purchase entry").
      doc(documentgetdate.docs[p].id).collection(documentgetdate.docs[p].id).
      where("Item",isEqualTo:deletestocksitems).get();

      for(int x=0;x<documentgetdate2.docs.length;x++){

        if(Productinvoicelist[x]==documentgetdate.docs[x].id){

          if(documentgetdate2.docs[x]['IMEI NO']&&documentgetdate2.docs[x]['Imei no'].contains(imeinu[x])){
            FirebaseFirestore.instance.collection("Purchase entry").doc(documentgetdate.docs[p].id).
            collection(documentgetdate.docs[p].id)
                .doc(documentgetdate2.docs[x].id).update({
              "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
            });
            if(status==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }

            if(status2==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }
          }

          else if(documentgetdate2.docs[x]['Serial NO']&&documentgetdate2.docs[x]['Serial no'].contains(serialnu[x])){
            FirebaseFirestore.instance.collection("Purchase entry").doc(documentgetdate.docs[p].id).
            collection(documentgetdate.docs[p].id)
                .doc(documentgetdate2.docs[x].id).update({
              "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
            });
            if(status==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }

            if(status2==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }
          }

          else if(documentgetdate2.docs[x]['Color']&&documentgetdate2.docs[x]['color'].contains(colornu[x])){
            FirebaseFirestore.instance.collection("Purchase entry").doc(documentgetdate.docs[p].id).
            collection(documentgetdate.docs[p].id)
                .doc(documentgetdate2.docs[x].id).update({
              "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
            });
            if(status==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }

            if(status2==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }
          }

          else{
            FirebaseFirestore.instance.collection("Purchase entry").doc(documentgetdate.docs[p].id).
            collection(documentgetdate.docs[p].id)
                .doc(documentgetdate2.docs[x].id).update({
              "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
            });
            if(status==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }

            if(status2==true){
              FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(documentgetdate.docs[p].id).
              collection(documentgetdate.docs[p].id)
                  .doc(documentgetdate2.docs[x].id).update({
                "stocks":FieldValue.increment(int.parse(deletewuvantity.toString()))
              });
            }

          }

        }



      }



    }

    if (deletewuvantity.isNotEmpty) {
      var itemdata=await FirebaseFirestore.instance.collection('Item ShabikaG').
      where("Newitemname",isEqualTo:deletestocksitems).get();
      for(int k=0;k<itemdata.docs.length;k++){
        if(status==true){
          await FirebaseFirestore.instance.collection('Item ShabikaG').doc(itemdata.docs[k].id).update(
              {"TotalQuvantity": FieldValue.increment(int.parse(deletewuvantity)),
                'Imei no': FieldValue.arrayUnion(imeinu),
                'Serial no': FieldValue.arrayUnion(serialnu),
                'color': FieldValue.arrayUnion(colornu),

              });
        }

        if(status2==true){
          await FirebaseFirestore.instance.collection('Item ShabikaN').doc(itemdata.docs[k].id).update(
              {"TotalQuvantity": FieldValue.increment(int.parse(deletewuvantity)),
                'Imei no': FieldValue.arrayUnion(imeinu),
                'Serial no': FieldValue.arrayUnion(serialnu),
                'color': FieldValue.arrayUnion(colornu),});
        }
      }



      FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(id).delete();
    }

    //updatetotal();
    setState((){
      salespriceff=0;
    });
    //_controller.clear();
    //_controller2.clear();
    //_controller3.clear();
  }


  final List<TextEditingController> _Streamcontroller1= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller2= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller3= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller4= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller5= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller6= List.generate(100, (index) => TextEditingController());
  final List<TextEditingController> _Streamcontroller7= List.generate(100, (index) => TextEditingController());

  TextEditingController layourbuilderclear2 = TextEditingController();

  TextEditingController layourbuilderclear3=TextEditingController();
  TextEditingController itemid = TextEditingController();
  TextEditingController itemname = TextEditingController();
  
  List<String> Itemlist = [];
  List <String>Itemlist2=[];
  TextEditingController Box_NO = TextEditingController();
  TextEditingController HSN_Code = TextEditingController();
  TextEditingController Sales = TextEditingController();
  TextEditingController Loworder = TextEditingController();
  TextEditingController PPrice = TextEditingController();
  TextEditingController Stocks = TextEditingController();
  TextEditingController Qty = TextEditingController();
  //tax
  TextEditingController taxitem = TextEditingController();
  TextEditingController Cusname = TextEditingController();
  TextEditingController without_tax = TextEditingController();



  bool serialvalue = false;
  bool imeivalue = false;
  bool color = false;
  bool image = false;
  List IMEISERIAL = [];
  bool popupLoading = false;
  List Quvantitylists = [];
  List<String> imeinu = [];
  List<String> serialnu = [];
  List<String> colornu = [];
  clearallcontroller() {
    setState(() {
    


    //Landing_cost.clear();
    Loworder.clear();
    Stocks.clear();
    Qty.clear();
    //itemid
    itemid.clear();
    //item name
    itemname.clear();
    taxitem.clear();
    Sales.clear();
    PPrice.clear();
    without_tax.clear();
    Box_NO.clear();
    HSN_Code.clear();
    layourbuilderclear2.clear();
    layourbuilderclear3.clear();
    });

  }
  
  checkgst(Salesvalue, qty) {
    setState(() {
      Sales.text = (salespriceff * double.parse(qty)).toString();
    });
  }
  showtextfield(Quvantity, serial, imei, colors,image,cxt) {
    setState(() {
      IMEISERIAL.clear();
    });

    List<TextEditingController> _controller = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 = List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 = List.generate(Quvantity, (index) => TextEditingController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      showDialog(
        context: cxt,
        builder: (context) {
          return
            StatefulBuilder(builder: (cxt, setState) {
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
                                  "Add IMEI No /SERIAL No/Color/Image ",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700
                                  ),
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
                                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w700,fontSize: width / 91.06),
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
                                                                return getSuggestionsgender1(pattern);
                                                              },
                                                              itemBuilder: (context,
                                                                  String
                                                                  suggestion) {
                                                                return ListTile(
                                                                  title: Text(
                                                                      suggestion, style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                                                                  ImerisrialListitem. remove(suggestion);
                                                                  //ImerisrialListitem.remove(_controller[index].text);
                                                                  Quvantitylists.add(_controller[index].text);
                                                                  _controller[index].text = suggestion;
                                                                });
                                                              },
                                                              suggestionsBoxController: suggestionBoxController1,
                                                              validator: (value) => value!.isEmpty
                                                                  ? 'Please select a academic year'
                                                                  : null,
                                                              onSaved: (value) {
                                                                setState(() {
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
                                                                .openSans(
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
                                                                    .openSans(
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
                                                                return getSuggestionsgender2(pattern);
                                                              },
                                                              itemBuilder: (context,
                                                                  String
                                                                  suggestion) {
                                                                return ListTile(
                                                                  title: Text(
                                                                      suggestion, style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                                                                  ImerisrialListitem1.remove(suggestion);
                                                                  Quvantitylists.add(_controller2[index].text);
                                                                  _controller2[index].text = suggestion;
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
                                                colors == true
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
                                                                .openSans(
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
                                                                    .openSans(
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
                                                                    pattern);
                                                              },
                                                              itemBuilder: (context,
                                                                  String
                                                                  suggestion) {
                                                                return ListTile(
                                                                  title: Text(
                                                                      suggestion, style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
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
                                                                  ImerisrialListitem2.remove(suggestion);
                                                                  Quvantitylists.add(_controller3[index].text);
                                                                  _controller3[index].text = suggestion;
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
                                    },
                                  ),

                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          popupLoading = true;
                                        });
                                        print("++++++++++");
                                        print("++++${Quvantity}++++++");


                                        for (int i = 0; i < Quvantity; i++) {
              print("++++${_controller[i].text}++++++");
                                          setState(() {
                                            IMEISERIAL.add("${_controller[i].text},${_controller2[i].text},${_controller3[i].text}");
                                          });

                                          if (imei == true) {

                                            imeinu.add(_controller[i].text);

                                          }

                                          if (serial == true) {
                                            serialnu.add(_controller2[i].text);
                                          }

                                          if (colors == true) {
                                            colornu.add(_controller3[i].text);
                                          }
                                        }
                                        Purchaseitem();


                                        Future.delayed(
                                            const Duration(milliseconds: 1500), () {
                                          setState(() {
                                            popupLoading = false;
                                          });
                                          _controller.clear();
                                          _controller2.clear();
                                          _controller3.clear();
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Material(
                                        elevation: 15,
                                        color: const Color(0xff25D366),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          height: height / 16.425,
                                          width: width / 7.588,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: const Color(0xff25D366),
                                          ),
                                          child: Center(
                                            child: Text("Okay",
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
            },);
        },
      );

  }
  empty() {}
  incorrectpopup() {
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
                        "Incorrect Format..",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),

                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Lottie.asset(
                            "assets/animation_lkc5owo7.json"),
                      ),
                      SizedBox(
                        height: height / 53.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {

                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 16.425,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.openSans(
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
                )),
          ),
        );
      },
    );
  }

  String itemcode="";
  String itemdocuid="";

  bool isloading =false;

  int temp=0;

  List <String> temporary=[];
  String itemcat = '';
  String itembrand = '';
  String cusid = '';

  Purchaseitem() async {
    print("List assign in billing");
    print(imeinu);
    print(serialnu);
    print(colornu);
    print(ImerisrialListitem);
    print(ImerisrialListitem1);
    print(ImerisrialListitem2);

      if (status == true) {
        var docus1 = await FirebaseFirestore.instance
            .collection("billing ShabikaG")
            .where("save", isEqualTo: true)
            .get();
        setState(() {
          billcount = docus1.docs.length + 1;
          purchase_No.text = "SBG${(billcount).toString().padLeft(2, "0")}";
          purchase_Date.text =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
        });
      }
      if (status2 == true) {
        var docus2 = await FirebaseFirestore.instance
            .collection("billing ShabikaN")
            .where("save", isEqualTo: true)
            .get();
        setState(() {
          billcount = docus2.docs.length + 1;
          purchase_No.text = "SBN${(billcount).toString().padLeft(2, "0")}";
          purchase_Date.text =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
        });
      }
    print("List assign in billing--end");
    if (int.parse(Stocks.text) > 0) {



      for(int i=0;i<Productinvoicelist.length;i++){
        print("Function Start---------------------");
        print("Productinvoicelist.length Value");
        print(Productinvoicelist.length);
        print(i);
        var purchasedocument=await FirebaseFirestore.instance.collection("Purchase entry").doc(Productinvoicelist[i]).
        collection(Productinvoicelist[i]).get();
        for(int j=0;j<purchasedocument.docs.length;j++){
          print("purchasedocument.docs.length Value");
          print(purchasedocument.docs.length);
          print(j);

          if(imeivalue==true){
            for(int k=0;k<imeinu.length;k++){
              if(itemcode==purchasedocument.docs[j]["itemcode"]) {
                if (purchasedocument.docs[j]['Imei no'].contains(
                    imeinu[k].toString())) {
                  temporary.add(imeinu[k]);
                  FirebaseFirestore.instance.collection("Purchase entry").doc(
                      Productinvoicelist[i]).
                  collection(Productinvoicelist[i]).doc(
                      purchasedocument.docs[j].id).update({
                    "stocks": FieldValue.increment(-1),
                    "returnimei": temporary,
                    "Imei no": ImerisrialListitem
                  });
                }
              }
            }
          }

          else if(serialvalue==true){
            for(int k=0;k<serialnu.length;k++){
              if(itemcode==purchasedocument.docs[j]["itemcode"]) {
                if (purchasedocument.docs[j]['Serial no'].contains(
                    serialnu[k])) {
                  temporary.add(serialnu[k]);
                  FirebaseFirestore.instance.collection("Purchase entry").doc(
                      Productinvoicelist[i]).
                  collection(Productinvoicelist[i]).doc(
                      purchasedocument.docs[j].id).update({
                    "stocks": FieldValue.increment(-1),
                    "returnserial": temporary,
                    "Serial no": ImerisrialListitem1
                  });
                }
              }
            }
          }

          else if(color==true){
            for(int k=0;k<colornu.length;k++){
              if(itemcode==purchasedocument.docs[j]["itemcode"]) {
                if (purchasedocument.docs[j]['color'].contains(colornu[k])) {
                  temporary.add(colornu[k]);
                  FirebaseFirestore.instance.collection("Purchase entry").doc(
                      Productinvoicelist[i]).
                  collection(Productinvoicelist[i]).doc(
                      purchasedocument.docs[j].id).update({
                    "stocks": FieldValue.increment(-1),
                    "returncolor": temporary,
                    "color": ImerisrialListitem2
                  });
                }
              }
            }
          }

          else if(imeivalue==false && serialvalue==false && color==false){
            if(temp!=int.parse(purchasedocument.docs[j]["Qty"].toString())){
              if(itemcode==purchasedocument.docs[j]["itemcode"]){
                print("Last function-2");
                if((purchasedocument.docs[j]['stocks']-int.parse(Qty.text))>0){
                  print("All are function to enter the function---2");
                  print("Total Stocks in database ${purchasedocument.docs[j]['stocks']}");
                  print("Quvantity USertype ${int.parse(Qty.text)}");
                  print("balance stocks in reault ${(purchasedocument.docs[j]['stocks']-int.parse(Qty.text)).toString()}");
                  print("Result is printed--------------");
                  FirebaseFirestore.instance.collection("Purchase entry").doc(Productinvoicelist[i]).
                  collection(Productinvoicelist[i]).doc(purchasedocument.docs[j].id).update({
                    //"stocks":FieldValue.increment(-(int.parse(Qty.text)+(purchasedocument.docs[j]['stocks']-int.parse(Qty.text)))),
                    "stocks":FieldValue.increment(-int.parse(Qty.text)),
                  });
                  break;
                }
                print(temp);
                print("end Function");
                // else{
                //   print("All are function to enter the function---3");
                //   FirebaseFirestore.instance.collection("Purchase entry").doc(Productinvoicelist[i]).
                //   collection(Productinvoicelist[i]).doc(purchasedocument.docs[j].id).update({
                //    // "stocks":FieldValue.increment(-(int.parse(Qty.text)+(purchasedocument.docs[j]['stocks']-int.parse(Qty.text)))),
                //     "stocks":(int.parse(Qty.text)+(purchasedocument.docs[j]['stocks']-int.parse(Qty.text))),
                //   });
                //   setState((){
                //     //temp=temp+int.parse((int.parse(Qty.text)+(purchasedocument.docs[j]['stocks']-int.parse(Qty.text))).toString());
                //     temp=temp+(int.parse(Qty.text)+(purchasedocument.docs[j]['stocks']-int.parse(Qty.text))).toInt();
                //   });
                //   print(temp);
                //   print("end Function");
                // }
              }
            }
          }
        }
      }
      FirebaseFirestore.instance.collection("billing").doc(random).update({
        "Payment mode": "Service",
        "Total": double.parse(Sales.text).toStringAsFixed(2),
        "purchasenote": "Service Bill",
      });
      FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc().set(
          {
            "Total": double.parse(Sales.text).toStringAsFixed(2),
            "Totalamount":"",
            "Payment mode": Payments,
            "itemcode":itemcode,
            "Hsncode": HSN_Code.text,
            "BoxNo": Box_NO.text,
            "customername": customername.text,
            "customerphone": customerphone.text,
            "customeraddress": customeraddress.text,
            "Customer GstNo": status2 == true ? "" : AddnewcustomeGst.text,
            "purchaseno": purchase_No.text,
            "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "purchasenote": purchase_notes.text,
            "tax": taxitem.text,
            "Itemdocid":itemdocuid,
            "time": DateFormat.jm().format(DateTime.now()),
            "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch,
            "Category": itemcat,
            "Brand": itembrand,
            "Item": itemname.text,
            "margin":margin,
            "save": false,
            "return": false,
            "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
            "Sales price": double.parse(Sales.text).toStringAsFixed(2),
            "Qty": Qty.text,
             // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
            "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
            "Imei no": imeinu,
            "Serial no": serialnu,
            "color": colornu,
            "Serial NO": serialvalue,
            "IMEI NO": imeivalue,
            "Image": image,
            "Color": color,
            "Landing Cost": Landingcost,
          });


      if (status == true) {
        FirebaseFirestore.instance.collection("billing ShabikaG").doc(random).update({
          "Payment mode": "Service",
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "purchasenote": "Service Bill",
        });

        FirebaseFirestore.instance
            .collection("billing ShabikaG")
            .doc(random)
            .collection(random)
            .doc()
            .set({
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": itemcode,
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
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
          "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "Imei no": imeinu,
          "Serial no": serialnu,
          "color": colornu,
        });

      }

      if (status2 == true) {
        FirebaseFirestore.instance.collection("billing ShabikaN").doc(random).update({
          "Payment mode": Payments,
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "purchasenote": purchase_notes.text,
        });

        FirebaseFirestore.instance.collection("billing ShabikaN").doc(random).collection(random).doc()
            .set({
          "Total": double.parse(Sales.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": itemcode,
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "customername": customername.text,
          "customerphone": customerphone.text,
          "customeraddress": customeraddress.text,
          "purchaseno": purchase_No.text,
          "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
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
          //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "Imei no": imeinu,
          "Serial no": serialnu,
          "color": colornu,
        });
      }

      FirebaseFirestore.instance.collection("Service Bills").doc(documentid).collection("Itemsused").doc().set({
        "itemcode": itemcode,
        "Hsncode": HSN_Code.text,
        "BoxNo": Box_NO.text,
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
        "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
        "Imei no": imeinu,
        "Serial no": serialnu,
        "color": colornu,
        "Landing Cost": Landingcost,
        "margin":margin
      });

      FirebaseFirestore.instance.collection("Customer").doc(cusid).collection("billing").doc(random).set({
        "Total": totalamount,
        "Payment mode": Payments,
        "Totalamount":double.parse(Sales.text).toStringAsFixed(2),
        "itemcode": status2 == true ? "N$itemcode" : "",
        "Itemdocid":itemdocuid,
        "Hsncode": HSN_Code.text,
        "BoxNo": Box_NO.text,
        "customername": customername.text,
        "customerphone": customerphone.text,
        "customeraddress": customeraddress.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        'customerdocid': cusid,
        "payment-1": Payments,
        "payment-2":  "0",
        "payment-3": "0",
        "payment-4": "0",
        "Discountamount": "0.00",
        "Discountamountpercentage": "0.00%",
        "time": DateFormat.jm().format(DateTime.now()),
        "date":
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "save": true,
        "return": false,
        "Category": itemcat,
        "Brand": itembrand,
        "Item": itemname.text,
        "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
        "Sales price": double.parse(Sales.text).toStringAsFixed(2),
        "Qty": Qty.text,
        //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
        "Description":
        "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
      });


      updatetotalquvantity();


    }
    clearallcontroller();
  }
  String margin ="";
  updatetotalquvantity() {
    print("decrease total qty");
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    if (int.parse(Stocks.text) > 0) {
      print("Qty.text");
      print(Qty.text);
      if(status==true){
        FirebaseFirestore.instance.collection('Item ShabikaG').doc(itemdocuid).update({
          "TotalQuvantity": FieldValue.increment(-(int.parse(Qty.text))),
          'Imei no': FieldValue.arrayRemove(imeinu),
          'Serial no': FieldValue.arrayRemove(serialnu),
          'color': FieldValue.arrayRemove(colornu),
        });
      }

      if(status2==true){
        FirebaseFirestore.instance.collection('Item ShabikaN').doc(itemdocuid).update({
          "TotalQuvantity": FieldValue.increment(-(int.parse(Qty.text))),
          'Imei no': FieldValue.arrayRemove(imeinu),
          'Serial no': FieldValue.arrayRemove(serialnu),
          'color': FieldValue.arrayRemove(colornu),
        });
      }

    }
  }
  double TotalAmount2 = 0;
  totalcollectionamount() async{
    print("identifi+++++++++++++++++++++++++++++3");
    setState(() {
      TotalAmount2=0;
    });
    print(random);



    var document1=await FirebaseFirestore.instance.collection("Service Bills").doc(documentid).collection("Itemsused").get();
    for(int i=0;i<document1.docs.length;i++){
      TotalAmount2= TotalAmount2 + double.parse(document1.docs[i]["margin"]);
    }

    FirebaseFirestore.instance.collection("billing").doc(random).update({
      "Total": totalamount,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
      "Payment mode": "Service",
      "save": true,
      'customerdocid': "SERVICE",
      "Customer GstNo": status2 == true ? "" : AddnewcustomeGst.text,
      "purchasenote": purchase_notes.text,
      "payment-1": "0",
      "payment-2": "0",
      "payment-3":"0",
      "payment-4":"0",
      "Discountamount": "0",
      "Discountamountpercentage": "0",
    });
    FirebaseFirestore.instance.collection("Service Bills").doc(documentid).update(
        {
          "status":statustype,
          "remarks":remarkscon.text,
          "itemtotal":TotalAmount2.toStringAsFixed(2)
        });
    if (status == true) {
      FirebaseFirestore.instance.collection("billing ShabikaG").doc(random).update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        "Payment mode": "Service",
        "save": true,
        'customerdocid': "SERVICE",
        "Customer GstNo": status2 == true ? "" : AddnewcustomeGst.text,
        "purchasenote": purchase_notes.text,
        "payment-1": "0",
        "payment-2": "0",
        "payment-3":"0",
        "payment-4":"0",
        "Discountamount": "0",
        "Discountamountpercentage": "0",
      });

    }

    if (status2 == true) {

      FirebaseFirestore.instance.collection("billing ShabikaN").doc(random).update({
        "Total": totalamount,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
        "Payment mode": "Service",
        "save": true,
        'customerdocid': "SERVICE",
        "Customer GstNo": status2 == true ? "" : AddnewcustomeGst.text,
        "purchasenote": purchase_notes.text,
        "payment-1": "0",
        "payment-2": "0",
        "payment-3":"0",
        "payment-4":"0",
        "Discountamount": "0",
        "Discountamountpercentage": "0",
           });



    }



    var document2=await FirebaseFirestore.instance.collection("billing").doc(random).collection(random).get();
    for(int i=0;i<document2.docs.length;i++){
      FirebaseFirestore.instance.collection("billingItemreports").doc().set({
        "Total": document2.docs[i]["Total"],
        "billtype":"Service",
        "margin":document2.docs[i]["margin"],
        "Totalamount": document2.docs[i]["Totalamount"],
        "Payment mode": document2.docs[i]["Payment mode"],
        "itemcode": document2.docs[i]["itemcode"],
        "Hsncode": document2.docs[i]["Hsncode"],
        "BoxNo": document2.docs[i]["BoxNo"],
        "customername": document2.docs[i]["customername"],
        "customerphone": document2.docs[i]["customerphone"],
        "customeraddress": document2.docs[i]["customeraddress"],
        "purchaseno": document2.docs[i]["purchaseno"],
        "purchasedate": document2.docs[i]["purchasedate"],
        "purchasenote": document2.docs[i]["purchasenote"],
        "tax": document2.docs[i]["tax"],
        "time": document2.docs[i]["time"],
        "date": document2.docs[i]["date"],
        "timestamp": document2.docs[i]["timestamp"],
        "Category": document2.docs[i]["Category"],
        "Brand": document2.docs[i]["Brand"],
        "Item": document2.docs[i]["Item"],
        "withouttaxprice": document2.docs[i]["withouttaxprice"],
        "Sales price": document2.docs[i]["Sales price"],
        "Qty": document2.docs[i]["Qty"],
        "Description": document2.docs[i]["Description"],
        "Imei no": document2.docs[i]["Imei no"],
        "Serial no": document2.docs[i]["Serial no"],
        "color": document2.docs[i]["color"],

      });
      if(status==true){
        FirebaseFirestore.instance.collection("billingItemreportsG").doc().set({
          "Total": document2.docs[i]["Total"],
          "billtype":"Service",
          "margin":document2.docs[i]["margin"],
          "Totalamount": document2.docs[i]["Totalamount"],
          "Payment mode": document2.docs[i]["Payment mode"],
          "itemcode": document2.docs[i]["itemcode"],
          "Hsncode": document2.docs[i]["Hsncode"],
          "BoxNo": document2.docs[i]["BoxNo"],
          "customername": document2.docs[i]["customername"],
          "customerphone": document2.docs[i]["customerphone"],
          "customeraddress": document2.docs[i]["customeraddress"],
          "purchaseno": document2.docs[i]["purchaseno"],
          "purchasedate": document2.docs[i]["purchasedate"],
          "purchasenote": document2.docs[i]["purchasenote"],
          "tax": document2.docs[i]["tax"],
          "time": document2.docs[i]["time"],
          "date": document2.docs[i]["date"],
          "timestamp": document2.docs[i]["timestamp"],
          "Category": document2.docs[i]["Category"],
          "Brand": document2.docs[i]["Brand"],
          "Item": document2.docs[i]["Item"],
          "withouttaxprice": document2.docs[i]["withouttaxprice"],
          "Sales price": document2.docs[i]["Sales price"],
          "Qty": document2.docs[i]["Qty"],
          "Description": document2.docs[i]["Description"],
          "Imei no": document2.docs[i]["Imei no"],
          "Serial no": document2.docs[i]["Serial no"],
          "color": document2.docs[i]["color"],
        });}
      if(status2==true){
        FirebaseFirestore.instance.collection("billingItemreportsN").doc().set({
          "Total": document2.docs[i]["Total"],
          "billtype":"Service",
          "margin":document2.docs[i]["margin"],
          "Totalamount": document2.docs[i]["Totalamount"],
          "Payment mode": document2.docs[i]["Payment mode"],
          "itemcode": document2.docs[i]["itemcode"],
          "Hsncode": document2.docs[i]["Hsncode"],
          "BoxNo": document2.docs[i]["BoxNo"],
          "customername": document2.docs[i]["customername"],
          "customerphone": document2.docs[i]["customerphone"],
          "customeraddress": document2.docs[i]["customeraddress"],
          "purchaseno": document2.docs[i]["purchaseno"],
          "purchasedate": document2.docs[i]["purchasedate"],
          "purchasenote": document2.docs[i]["purchasenote"],
          "tax": document2.docs[i]["tax"],
          "time": document2.docs[i]["time"],
          "date": document2.docs[i]["date"],
          "timestamp": document2.docs[i]["timestamp"],
          "Category": document2.docs[i]["Category"],
          "Brand": document2.docs[i]["Brand"],
          "Item": document2.docs[i]["Item"],
          "withouttaxprice": document2.docs[i]["withouttaxprice"],
          "Sales price": document2.docs[i]["Sales price"],
          "Qty": document2.docs[i]["Qty"],
          "Description": document2.docs[i]["Description"],
          "Imei no": document2.docs[i]["Imei no"],
          "Serial no": document2.docs[i]["Serial no"],
          "color": document2.docs[i]["color"],
        });
      }
    }
    print("All completed sucessfully");
    print("++++++++++++++++++++++++++++++++============================+++++++++++++++++++++++");



  /*  FirebaseFirestore.instance.collection("Accounts").doc("AxQxYGPKUB5qGzllyfpY").update({
      "Totalamount":Discountamount.text == "0"&&Discountamountpercentage.text == "0" ? FieldValue.increment(TotalAmount2):FieldValue.increment(disacountamountcalue),
    });*/


    print(itemdocuid);
    print(imeinu);
    print(imeivalue);
    print("Identification+++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    if (imeivalue == true&&status==true) {
      FirebaseFirestore.instance.collection('Item ShabikaG').doc(itemdocuid).update({
        'Imei no': FieldValue.arrayRemove(imeinu),
      });
    }
    if (imeivalue == true&&status2==true) {
      FirebaseFirestore.instance.collection('Item ShabikaN').doc(itemdocuid).update({
        'Imei no': FieldValue.arrayRemove(imeinu),
      });
    }
    if (serialvalue==true&&status==true) {
      FirebaseFirestore.instance.collection('Item ShabikaG').doc(itemdocuid).update({
        'Serial no': FieldValue.arrayRemove(serialnu),
      });
    }
    if (serialvalue==true&&status2==true) {
      FirebaseFirestore.instance.collection('Item ShabikaN').doc(itemdocuid).update({
        'Serial no': FieldValue.arrayRemove(serialnu),
      });
    }
    if (color == true&&status==true) {
      FirebaseFirestore.instance.collection('Item ShabikaG').doc(itemdocuid).update({
        'color': FieldValue.arrayRemove(colornu),
      });
    }
    if (color == true&&status2==true) {
      FirebaseFirestore.instance.collection('Item ShabikaN').doc(itemdocuid).update({
        'color': FieldValue.arrayRemove(colornu),
      });
    }



    setState(() {
      serialvalue = false;
      imeivalue = false;
      color = false;
      popupLoading = false;
    });
  }
  String itemimei = '';
  String itemserial = '';
  String itemcolor = '';
  String Landingcost = '';
  createpurchase2(name) async {

      setState(() {
        isloading = true;
        ImerisrialListitem.clear();
        ImerisrialListitem1.clear();
        ImerisrialListitem2.clear();
        Productinvoicelist.clear();
      });

      if(status==true){
        var documents = await FirebaseFirestore.instance.collection("Item ShabikaG").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if ('${documents.docs[i]["Newitemname"]}-(${documents.docs[i]["Itemcode"]})' == name) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear3.text=documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text=documents.docs[i]["Newitemname"].toString();
              itemdocuid = documents.docs[i].id.toString();
              //hsncpode = documents.docs[i]["HSNCode"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              itemname.text = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Qty.text = "1";
             itemcat = documents.docs[i]["Category"].toString();
             itembrand = documents.docs[i]["Brand"].toString();
             // Boxno = documents.docs[i]["BoxNo"].toString();
              margin = documents.docs[i]["margin"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              PPrice.text=documents.docs[i]["Landingcost"].toString();
              Landingcost=documents.docs[i]["Landingcost"].toString();
              margin=documents.docs[i]["margin"].toString();
              salespriceff = double.parse(documents.docs[i]["Saleprice"].toString());//sales price
              serialvalue = documents.docs[i]["Serial NO"];
              imeivalue = documents.docs[i]["IMEI NO"];
              image = documents.docs[i]["Image"];
              color = documents.docs[i]["Color"];
              Productinvoicelist = documents.docs[i]["purchaseinvoiceid"];
              without_tax.text = (salespriceff / 1.18).round().toStringAsFixed(2);
              //changewithoutprice = (salespriceff / 1.18).round().toStringAsFixed(2);//change the price the value
            });
            for (int j = 0; j < documents.docs[i]["Imei no"].length; j++) {
              setState((){
                ImerisrialListitem.add(documents.docs[i]["Imei no"][j].toString());
              });
            }

            for (int k = 0; k < documents.docs[i]["Serial no"].length; k++) {
              setState((){
                ImerisrialListitem1.add(documents.docs[i]["Serial no"][k].toString());
              });
            }

            for (int l = 0; l < documents.docs[i]["color"].length; l++) {
              setState((){
                ImerisrialListitem2.add(documents.docs[i]["color"][l].toString());
              });
            }

          }
        }
        if (int.parse(Stocks.text) < 1) {
          Alertbillpopup();
        }
      }

      if(status2==true){
        print("shabika N-------------------------------------");
        var documents = await FirebaseFirestore.instance.collection("Item ShabikaN").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if ('${documents.docs[i]["Newitemname"]}-(${documents.docs[i]["Itemcode"]})' == name) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear3.text=documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text=documents.docs[i]["Newitemname"].toString();
              itemdocuid = documents.docs[i].id.toString();
             // hsncpode = documents.docs[i]["HSNCode"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              itemname.text = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Qty.text = "1";
              margin = documents.docs[i]["margin"].toString();
              itemcat = documents.docs[i]["Category"].toString();
              itembrand = documents.docs[i]["Brand"].toString();
              // Boxno = documents.docs[i]["BoxNo"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              print(documents.docs[i]["Saleprice"].toString());
              print(documents.docs[i]["Landingcost"].toString());
              print("ppppppppp=========================================");
              print(documents.docs[i]["Landingcost"].toString());
              PPrice.text=documents.docs[i]["Landingcost"].toString();
              Landingcost=documents.docs[i]["Landingcost"].toString();
              margin=documents.docs[i]["margin"].toString();
              salespriceff = double.parse(documents.docs[i]["Saleprice"].toString());
              serialvalue = documents.docs[i]["Serial NO"];
              imeivalue = documents.docs[i]["IMEI NO"];
              color = documents.docs[i]["Color"];
              image = documents.docs[i]["Image"];
              Productinvoicelist = documents.docs[i]["purchaseinvoiceid"];
              without_tax.text = (salespriceff / 1.18).round().toStringAsFixed(2);
             // changewithoutprice = (salespriceff / 1.18).round().toStringAsFixed(2);//change the price the value
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
            /*if (int.parse(Stocks.text) > 0) {
              FirebaseFirestore.instance.collection("billing").doc(random).set({
                "Total": "",
                "itemcode": itemcode,
                "Itemdocid":itemdocuid,
                "Payment mode": Payments,
                "Hsncode": HSN_Code.text,
                "BoxNo": Box_NO.text,
                "customername": customername.text,
                "customerphone": customerphone.text,
                "customeraddress": customeraddress.text,
                "Customer GstNo": status2 == true?"":AddnewcustomeGst.text,
                "purchaseno": purchase_No.text,
                "purchasedate": purchase_Date.text,
                "purchasenote": purchase_notes.text,
                "tax": taxitem.text,
                "IMEI NO": itemimei,
                "Serial NO": itemserial,
                "Color": itemcolor,
                "credit days": Creadit_days.text,
                "save": false,
                "return": false,
                "time": DateFormat.jm().format(DateTime.now()),
                "date":
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                "timestamp": DateTime.now().microsecondsSinceEpoch
              });
              if (status == true) {
                FirebaseFirestore.instance
                    .collection("billing ShabikaG")
                    .doc(random)
                    .set({
                  "Total": "",
                  "itemcode": itemcode,
                  "Itemdocid":itemdocuid,
                  "Payment mode": Payments,
                  "Hsncode": HSN_Code.text,
                  "BoxNo": Box_NO.text,
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
                  "save": false,
                  "return": false,
                  "time": DateFormat.jm().format(DateTime.now()),
                  "date":
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "timestamp": DateTime.now().microsecondsSinceEpoch
                });
              }
              if (status2 == true) {
                FirebaseFirestore.instance
                    .collection("billing ShabikaN")
                    .doc(random)
                    .set({
                  "Total": "",
                  "itemcode": itemcode,
                  "Itemdocid":itemdocuid,
                  "Payment mode": Payments,
                  "Hsncode": HSN_Code.text,
                  "BoxNo": Box_NO.text,
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
                  "save": false,
                  "return": false,
                  "time": DateFormat.jm().format(DateTime.now()),
                  "date":
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "timestamp": DateTime.now().microsecondsSinceEpoch
                });
              }
              FirebaseFirestore.instance.collection("Customer").doc(customerdocid).collection("billing").doc(random).set({
                "Total": totalamount,
                "Payment mode": Payments,
                "itemcode": status2 == true ? "N$itemcode" : "",
                "Itemdocid":itemdocuid,
                "Hsncode": HSN_Code.text,
                "BoxNo": Box_NO.text,
                "customername": customername.text,
                "customerphone": customerphone.text,
                "customeraddress": customeraddress.text,
                "purchaseno": purchase_No.text,
                "purchasedate": purchase_Date.text,
                "purchasenote": purchase_notes.text,
                "tax": taxitem.text,
                'customerdocid': customerdocid,
                "payment-1": paymenttype1.text != "" ? paymenttype1.text : "0",
                "payment-2": paymenttype2.text != "" ? paymenttype2.text : "0",
                "payment-3": paymenttype3.text != "" ? paymenttype3.text : "0",
                "payment-4": paymenttype4.text != "" ? paymenttype4.text : "0",
                "Discountamount": Discountamount.text == ""
                    ? "0"
                    : double.parse(Discountamount.text).toStringAsFixed(2),
                "Discountamountpercentage": Discountamountpercentage.text == ""
                    ? "0"
                    : "${double.parse(Discountamountpercentage.text).toStringAsFixed(2)}%",
                "time": DateFormat.jm().format(DateTime.now()),
                "date":
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                "timestamp": DateTime.now().microsecondsSinceEpoch,
                "save": false,
                "return": false,
                "Category": itemcat,
                "Brand": itembrand,
                "Item": itemname.text,
                "withouttaxprice": double.parse(without_tax.text).toStringAsFixed(2),
                "Sales price": double.parse(Sales.text).toStringAsFixed(2),
                "Qty": Qty.text,
                //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
                "Description":
                "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
              });
              checkgst(Sales.text, Qty.text);

            }*/
          }
        }
        if (int.parse(Stocks.text) < 1) {
          Alertbillpopup();
        }
      }

      setState(() {
        isloading=false;
      });
      if (int.parse(Stocks.text) > 0) {
        FirebaseFirestore.instance.collection("billing").doc(random).set({
          "Total": "",
          "Totalamount":"",
          "itemcode": itemcode,
          "Itemdocid":itemdocuid,
          "Payment mode": "Service",
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "customername": "Service Bill",
          "customerphone": "Service Bill",
          "customeraddress": "Service Bill",
          "Customer GstNo": "Service Bill",
          "purchaseno": purchase_No.text,
          "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "purchasenote": "Service Item",
          "tax": "18%",
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": "",
          "save": false,
          "return": false,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
        if (status == true) {
          FirebaseFirestore.instance.collection("billing ShabikaG").doc(random).set({
            "Total": "",
            "itemcode": itemcode,
            "Itemdocid":itemdocuid,
            "Payment mode": "Service",
            "Hsncode": HSN_Code.text,
            "BoxNo": Box_NO.text,
            "customername": "Service Bill",
            "customerphone": "Service Bill",
            "customeraddress": "Service Bill",
            "Customer GstNo": "Service Bill",
            "purchaseno": purchase_No.text,
            "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "purchasenote": "Service Item",
            "tax": "18%",
            "IMEI NO": itemimei,
            "Serial NO": itemserial,
            "Color": itemcolor,
            "credit days": "",
            "save": false,
            "return": false,
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
            "Itemdocid":itemdocuid,
            "Payment mode": "Service",
            "Hsncode": HSN_Code.text,
            "BoxNo": Box_NO.text,
            "customername": "Service Bill",
            "customerphone": "Service Bill",
            "customeraddress": "Service Bill",
            "Customer GstNo": "Service Bill",
            "purchaseno": purchase_No.text,
            "purchasedate": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "purchasenote": "Service Item",
            "tax": "18%",
            "IMEI NO": itemimei,
            "Serial NO": itemserial,
            "Color": itemcolor,
            "credit days": "",
            "save": false,
            "return": false,
            "time": DateFormat.jm().format(DateTime.now()),
            "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "timestamp": DateTime.now().microsecondsSinceEpoch
          });
        }
        checkgst(Sales.text, Qty.text);

      }


    }




  Alertbillpopup() {
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
                        "Alert Stocks are Low..",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),

                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Lottie.asset(
                            "assets/animation_lkc5owo7.json",fit:BoxFit.cover),
                      ),
                      SizedBox(
                        height: height / 53.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {

                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 16.425,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.openSans(
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
                )),
          ),
        );
      },
    );
  }
  
  String _formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    setState(() {
      deliverytime.text ='${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    });

    return  '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

}
const List<String> list3 = <String>[
  "GST",
  "IGST",
];