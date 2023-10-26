import 'package:flutter/material.dart';
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

const List<String> list3 = <String>[
  "GST",
  "IGST",
];


class Serviceeditpage extends StatefulWidget {
  String docid;
  Serviceeditpage(this.docid);

  @override
  State<Serviceeditpage> createState() => _ServiceeditpageState();
}

class _ServiceeditpageState extends State<Serviceeditpage> {
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
  List problemcost = [];
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
  TextEditingController  topaycon = new TextEditingController();
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
    if(savetapped==true){
      Formkey.currentState!.validate();
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
              servicepro = false;
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

    var docus1 = await FirebaseFirestore.instance.collection("Service Bills").get();
    print("ok 2++++++++++++++++");
    print("ok 2+++++++++${docus1.docs.length}");
    setState(() {
      billcount=docus1.docs.length + 1;
      print(billcount);
      billno.text = "${(billcount).toString().padLeft(3, "0")}";
    });
    print(billno.text);

  }

  bool servicepro = false;
  bool savetapped = false;


  @override
  void initState() {
    Userdata();
    categoryaddfunction();
    barndaddfunction();
    barndaddfunction2();
    itemaddfunction();
    problemaddfunction();
    statusaddfunction();
    addpaymentmode();
    setdata();

    // TODO: implement initState
    super.initState();
  }

  setdata() async {
    var docsu = await FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid).get();
    Map<String,dynamic> ? val =  docsu.data();

    billno.text=val!["billno"];
    purchase_Date.text=val["date"];
   // billno.text=val["time"];
    _typeAheadControllergender9.text=val["cusmob"];
    alphone.text=val["cusalmob"];
    customername.text=val["cusname"];
    _typeAheadControllerbrand2.text=val["brand"];
    modelcon.text=val["model"];
    colorcon.text=val["color"];
    imeicon.text=val["imei"];
    check=val["battery"];
    check2=val["sim"];
    check3=val["mmc"];
    check4=val["charger"];
    locktype=val["phonelocktype"];
    passwordcon.text=val["password"];
    statustype=val["status"];
    totalamount=val["totalcost"];
    advancecon.text=val["advance"];
    balanceamount=val["balance"];
    discountcon.text=val["discount"];
    deliverydate.text=val["deliverydate"];
    deliverytime.text=val["deliverytime"];
    Payments=val["Paymentmode"];
    remarkscon.text=val["remarks"];
    for(int i=0;i<val["patternlist"].length;i++){
    Patterlist.add(val["patternlist"][i]);
    }
    var doc2= await FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid)
        .collection("Problems").get();
    for(int i=0;i<doc2.docs.length;i++) {

          setState((){
       problemlist2.add(doc2.docs[i]["problem"]);
       problemcost.add(doc2.docs[i]["cost"]);
      });
    }


  }


  String docid= "";
  Saveinvoice(){
    setState(() {
      docid= randomAlphaNumeric(16);
    });
    FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid).update({
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
    /*for(int i=0;i<problemlist2.length;i++) {
      FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid)
          .collection("Problems").doc()
          .set({
        "problem":problemlist2[i],
        "cost":problemcost[i].text
      });
    }*/

    if(topaycon.text!="") {
      FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid)
          .collection("Payment Histroy").doc()
          .set({
        "type":"Payment",
        "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "time": "${DateFormat('hh:mm a').format(DateTime.now())}",
        'payment mode':Payments,
        'Amount':topaycon.text,
        "balance":balanceamount,
        "timestamp":DateTime.now().millisecondsSinceEpoch,

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
                        "Bill Edited Successfully..",
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



                              });
                              billcounts();
                              setState(() {
                                savetapped=false;
                              });
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



  final Formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff263646),
        title: Text("Edit Bill Details",style: GoogleFonts.openSans(
          fontWeight: FontWeight.bold,
          fontSize: width/70.39,
          color:Colors.white,
        )),
      ),
      backgroundColor: Color(0xff00A99D),
      body: Form(
        key: Formkey,
        child: Column(
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
                        } else {
                          setState(() {
                            status2 = val;
                          });
                          // itemaddfunction();
                          // itemcodeaddfunction();
                        }
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
                        } else {
                          setState(() {
                            status = val;
                          });
                          //itemaddfunction();
                          //itemcodeaddfunction();
                        }
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
                                    child: TextFormField(
                                                onChanged: (_){
                                                  if(savetapped==true){
                                                    Formkey.currentState!.validate();
                                                  }
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
                                                controller: _typeAheadControllergender9,

                                                validator: (value) => value!.isEmpty
                                                    ? "Field Can't Empty"
                                                    : null,

                                                onFieldSubmitted: (String value) {

                                                  if(savetapped==true){
                                                    Formkey.currentState!.validate();
                                                  }
                                                },
                                              )




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
                              child: TextFormField(
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
                                onChanged: (_){
                                  if(savetapped==true){
                                    Formkey.currentState!.validate();
                                  }
                                },
                                validator: (value) => value!.isEmpty
                                    ? "Field Can't Empty"
                                    : null,
                                onFieldSubmitted: (_) {
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
                                child: TextFormField(
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
                                  validator: (value) => value!.isEmpty
                                      ? "Field Can't Empty"
                                      : null,
                                  onChanged: (_){
                                    if(savetapped==true){
                                      Formkey.currentState!.validate();
                                    }
                                  },
                                  onFieldSubmitted: (_) {
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
                              child: TextFormField(
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
                                onChanged: (_){
                                  if(savetapped==true){
                                    Formkey.currentState!.validate();
                                  }
                                },
                                validator: (value) => value!.isEmpty
                                    ? "Field Can't Empty"
                                    : null,
                                onFieldSubmitted: (_) {
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

                                      if(savetapped==true) {
                                        Formkey.currentState!.validate();
                                      }
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

                                    validator: (value) => value!.isEmpty
                                        ? "Field Can't Empty"
                                        : null,
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
                        child: TextFormField(
                          controller: modelcon,
                          onChanged: (_){
                            if(savetapped==true){
                              Formkey.currentState!.validate();
                            }
                          },
                          validator: (value) => value!.isEmpty
                              ? "Field Can't Empty"
                              : null,
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
                        child: TextFormField(
                          controller: colorcon,
                          onChanged: (_){
                            if(savetapped==true){
                              Formkey.currentState!.validate();
                            }
                          },
                          validator: (value) => value!.isEmpty
                              ? "Field Can't Empty"
                              : null,
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
                      child: TextFormField(
                        controller: passwordcon,
                        onChanged: (_){
                          if(savetapped==true){
                            Formkey.currentState!.validate();
                          }
                        },
                        validator: (value) => value!.isEmpty
                            ? "Field Can't Empty"
                            : null,
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
                      child: TextFormField(
                        validator: (value) => value!.isEmpty
                            ? "Field Can't Empty"
                            : null,
                        onChanged: (_){
                          if(savetapped==true){
                            Formkey.currentState!.validate();
                          }
                        },
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
                            if(savetapped==true){
                              Formkey.currentState!.validate();
                            }
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
                      child: TextFormField(
                        controller: deliverytime,
                        validator: (value) => value!.isEmpty
                            ? "Field Can't Empty"
                            : null,
                        onChanged: (_){
                          if(savetapped==true){
                            Formkey.currentState!.validate();
                          }
                        },
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
                          if(img1url=="") {
                            selectimage1();
                          }
                          else{
                            viewimage(1,img1url,image1.text);
                          }
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
                          if(img2url=="") {
                            selectimage2();
                          }
                          else{
                            viewimage(2,img2url,image2.text);
                          }
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
                          if(img3url=="") {
                            selectimage3();
                          }
                          else{
                            viewimage(3,img3url,image3.text);
                          }
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
            SizedBox(height:  height / 100.4,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xff1D5B79),
                      width: width / 1,
                      height: height / 16.425,
                      child: Center(
                          child: Text(
                            "Remarks",
                            style:
                            GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),
                          )),
                    ),
                    Container(
                      width: width / 1,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.6)),
                      child: TextField(
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
              ],
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
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
                                    itemCount: problemlist2.length,
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
                                                child: Text(problemlist2[index],
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
                                              child: Text(
                                               problemcost[index],

                                                style: GoogleFonts.openSans(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800),



                                              ),
                                            ),
                                          ]
                                      );

                                    },

                                  ),
                                )
                              ],
                            ),

                            servicepro == true ?Text("Service Problem Cannot be empty",style: GoogleFonts.openSans(color:Colors.red),) : SizedBox()
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
                        Text( "Draw Pattern",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),),
                        SizedBox(
                          width:width/8.415,
                          height: height / 6,
                          child: PatternLock(
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
                locktype=="Pattern" && Patterlist.isNotEmpty?  Padding(
                  padding:  EdgeInsets.only(top: height / 100.4, left: width / 80.32),
                  child: Container(
                    height: height / 5.14,
                    width:width/7.732,
                    color:Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text( "Confirm Pattern",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),),
                        SizedBox(
                          width:width/8.415,
                          height: height / 6,
                          child:  IgnorePointer(
                            ignoring: true,
                            child: PatternLock2(
                              used: Patterlist,
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
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ): SizedBox(),
                Padding(
                  padding:  EdgeInsets.only(right: width / 80.32),
                  child: Column(
                    children: [
                      Container(
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
                              "Last Bill No  ",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width:width / 12.2,
                              height: height / 21.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                // controller: PPrice,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 136.6,
                                      bottom: height / 65.7),
                                ),
                                onSubmitted: (_) {

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
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
                              "Received By   ",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width:width / 12.2,
                              height: height / 21.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                // controller: PPrice,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 136.6,
                                      bottom: height / 65.7),
                                ),
                                onSubmitted: (_) {

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: height / 100.4, ),
              child: Material(
                elevation: 50,
                shadowColor: Colors.black38,
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width / 1.0,
                  height: height / 12.14,
                  decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(left: width/130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [

                            //save invoive button
                            InkWell(
                              onTap: () {
                                setState(() {
                                  savetapped= true;
                                });
                                if (Formkey.currentState!.validate() && problemlist2.length!=0) {

                                  Saveinvoice();
                                  Savebillpopup();
                                }

                                if(problemlist2.length!=0){
                                  setState(() {
                                    servicepro=false;
                                  });
                                }
                                else if (problemlist2.length==0){
                                  setState(() {
                                    servicepro=true;
                                  });
                                }

                              },
                              child: Container(
                                width: width / 10.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  const Color(0xff013220),
                                ),
                                child: Center(
                                    child: Text(
                                      "Update Invoice",
                                      style:
                                      GoogleFonts.openSans(color: Colors.white),
                                    )),
                              ),
                            ),
                           /* SizedBox(
                              width: width/90.53,
                            ),
                            InkWell(
                              onTap: () {
                                Saveinvoice();
                                Savebillpopup();
                              },
                              child: Container(
                                width: width / 9.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  const Color(0xff0079FF),
                                ),
                                child: Center(
                                    child: Text(
                                      "Update & Print",
                                      style:
                                      GoogleFonts.openSans(color: Colors.white),
                                    )),
                              ),
                            ),
*/
                            SizedBox(
                              width: width/100.53,
                            ),

                            Container(
                              width: width / 7.3,
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
                                    "Payment Mode: ",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:width / 14.2,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: DropdownButton2<String>(
                                      value: Payments,
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
                                ],
                              ),
                            ),

                            SizedBox(
                              width: width/100.53,
                            ),

                            //L-BILL button

                            Container(
                              width: width / 7.3,
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
                                    "Total: ",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:width / 13.2,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      controller: totalcon,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 136.6,
                                            bottom: height / 65.7),
                                      ),
                                      onSubmitted: (_) {
                                        //discountamount();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/90.53,
                            ),
                            Container(
                              width: width / 7.3,
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
                                    "Advance: ",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:width / 13.2,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      controller: advancecon,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 136.6,
                                            bottom: height / 65.7),
                                      ),
                                      onSubmitted: (_) {
                                        if(advancecon.text!="") {
                                          if(discountcon.text=="") {
                                            setState(() {
                                              balanceamount = totalamount -
                                                  double.parse(advancecon.text);
                                            });
                                          }
                                          else{
                                            setState(() {
                                              balanceamount = totalamount - double.parse(discountcon.text) -
                                                  double.parse(advancecon.text);
                                            });
                                          }
                                        }
                                        else{
                                          if(discountcon.text=="") {
                                            setState(() {
                                              balanceamount = totalamount;
                                            });

                                          }
                                          else{
                                            setState(() {
                                              balanceamount = totalamount- double.parse(discountcon.text);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/90.53,
                            ),
                            Container(
                              width: width / 7.3,
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
                                    "Discount: ",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:width / 13.2,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      controller: discountcon,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 136.6,
                                            bottom: height / 65.7),
                                      ),
                                      onSubmitted: (_) {
                                        if(discountcon.text!="") {
                                          if(advancecon.text=="") {
                                            setState(() {
                                              balanceamount = totalamount -
                                                  double.parse(discountcon.text);
                                            });
                                          }
                                          else{
                                            setState(() {
                                              balanceamount = totalamount - double.parse(advancecon.text) -
                                                  double.parse(discountcon.text);
                                            });
                                          }
                                        }
                                        else{
                                          if(advancecon.text=="") {
                                            setState(() {
                                              balanceamount = totalamount;
                                            });

                                          }
                                          else{
                                            setState(() {
                                              balanceamount = totalamount- double.parse(advancecon.text);
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/90.53,
                            ),
                            Container(
                              width: width / 7.3,
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
                                    "Pay Now: ",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:width / 13.2,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextField(
                                      controller: topaycon,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 136.6,
                                            bottom: height / 65.7),
                                      ),
                                      onSubmitted: (_) {
                                        if(topaycon.text!="") {
                                            setState(() {
                                              balanceamount = balanceamount -
                                                  double.parse(topaycon.text);
                                            });
                                        }

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/90.53,
                            ),
                            InkWell(
                              onTap: () {

                              },
                              child: Container(
                                width: width / 7.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  const Color(0xff00A99D),
                                ),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Balance: ",
                                          style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${balanceamount.toStringAsFixed(2)}",
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                                              textStyle:  TextStyle(overflow: TextOverflow.ellipsis),
                                              color:  Colors.white, fontSize: width / 58.88),
                                        ),
                                      ],
                                    )),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
