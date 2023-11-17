import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'Edit_billing_Page.dart';

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Split Amount"
];

const List<String> Paymentmode = <String>['Please Select', "Paid", "Un Paid"];

const List<String> Paymentmode2 = <String>['All','Cash', 'Card', 'Gpay', "Phone Pay", "Split Amount"];
const List<String> Paymentmode3 = <String>['Please Select', "G pay", "Cash","Paytm","Phonepe","Card"];


class WalkingCuReports extends StatefulWidget {
  const WalkingCuReports({super.key});

  @override
  State<WalkingCuReports> createState() => _WalkingCuReportsState();
}

class _WalkingCuReportsState extends State<WalkingCuReports> {

  int select = 0;
  //toggle switch boolean
  bool status=true;
  bool status2=false;

  int year1 = 0;
  int day1 = 0;
  int month1 = 0;
  int year2 = 0;
  int day2 = 0;
  int month2 = 0;
  List<String> mydate = [];
  TextEditingController Datecontroller = TextEditingController();
  TextEditingController Datecontroller2 = TextEditingController();
  final DateFormat formatter = DateFormat('d/M/yyyy');

  TextEditingController Invoicecontroller = TextEditingController();
  TextEditingController Suppilercontroller = TextEditingController();
  TextEditingController Paymenttype = TextEditingController();
  bool isserach = false;
  String Username2 = "";
  String Username = "";
  String Status1 = '';
  String Status2 = '';
  String Status3 = '';
  String itemsearch = '';
  String hsnsearch = '';
  String catsearch = '';
  String brandsearch = '';

  List<String> Suppilier = [];
  List<String> Invoice = [];

  List<String> PaymentType2 = [
    "Unpaid",
    "Paid",
  ];
  List<String> PaymentType = [];

  String Payments = Paymentmode.first;

  String Payments2 = Paymentmode3.first;

  String Paymentsmodevalue = Paymentmode2.first;
  String PaymentChangevalue = 'All';


  double salesamount=0;
  double salesamountG=0;
  double salesamountN=0;
  additemduntion() async {
    setState(() {
      Suppilier.clear();
      Invoice.clear();
      PaymentType.clear();

    });
    var document = await FirebaseFirestore.instance
        .collection("billing")
        .where("save", isEqualTo: true)
        .get();
    for (int i = 0; i < document.docs.length; i++) {
      setState(() {
        Suppilier.add(document.docs[i]['customerphone']);
        Invoice.add(document.docs[i]['purchaseno']);
      });
    }



    print(PaymentType);
  }
  datefun(){
    setState(() {


      setState(() {
        Datecontroller.text = DateFormat('dd/M/yyyy').format(DateTime.now());
        Datecontroller2.text =
            DateFormat('dd/M/yyyy').format(DateTime.now());
      });
      setState(() {

        year1 = DateTime.now().year;
        day1 = DateTime.now().day;
        month1 = DateTime.now().month;


        year2 = DateTime.now().year;
        day2 = DateTime.now().day;
        month2 = DateTime.now().month;

        //set output date to TextField value.
      });
      DateTime startDate = DateTime.utc(year1, month1, day1);
      DateTime endDate = DateTime.utc(year2, month2, day2);
      print(startDate);
      print(endDate);
      print("+++++++=================");
      getDaysInBetween() {
        final int difference =
            endDate.difference(startDate).inDays;
        return difference+1;
      }
      print(getDaysInBetween());


      final items =
      List<DateTime>.generate(getDaysInBetween(), (i) {
        DateTime date = startDate;
        return date.add(Duration(days: i));
      });
      setState(() {
        mydate.clear();
      });
      print(items.length);
      for (int i = 0; i < items.length; i++) {
        setState(() {
          isserach = true;
          mydate.add(formatter.format(items[i]).toString());
        });

      }
    });
    print(mydate);

    print(isserach);
    print("+++++++++++++000000000+++++++++++");
    setState(() {

    });

  }

  gettotal() async {

    setState(() {
      salesamount = 0;
      salesamountG = 0;
      salesamountN = 0;
    });
    var document = await FirebaseFirestore.instance.collection("billingItemreports").get();
    var document2 = await FirebaseFirestore.instance.collection("billingItemreportsG").get();
    var document3 =  await FirebaseFirestore.instance.collection("billingItemreportsN").get();




    for (int i = 0; i < document2.docs.length; i++) {
      if(mydate.isNotEmpty) {
        if(mydate.contains(document2.docs[i]["purchasedate"])) {
          setState(() {
            salesamountG = salesamountG + double.parse(document2.docs[i]["Total"].toString());
          });
        }
      }
      else{
        setState(() {
          salesamountG = salesamountG + double.parse(document2.docs[i]["Total"].toString());
        });
      }
    }

    for (int i = 0; i < document3.docs.length; i++) {
      if(mydate.isNotEmpty) {
        if(mydate.contains(document3.docs[i]["purchasedate"])) {
          setState(() {
            salesamountN = salesamountN + double.parse(document3.docs[i]["Total"].toString());
          });
        }
      }
      else{
        setState(() {
          salesamountN = salesamountN + double.parse(document3.docs[i]["Total"].toString());
        });
      }
    }

    for (int i = 0; i < document.docs.length; i++) {
      if(mydate.isNotEmpty) {
        if(mydate.contains(document.docs[i]["purchasedate"])) {
          setState(() {
            salesamount = salesamount + double.parse(document.docs[i]["Total"].toString());
          });
        }
      }
      else{
        setState(() {
          salesamount = salesamount + double.parse(document.docs[i]["Total"].toString());
        });
      }
    }


  }
  @override
  void initState() {
    //categoryaddfunction();
    //barndaddfunction();
   // datefun();
    //additemduntion();
   // gettotal();
    setState(() {
      status=true;
    });
    print(mydate);
    //billingtotalamount();
    // TODO: implement initState
    super.initState();
  }
  List<String> categorylist = <String>[];
  List<String> Barndlist = <String>[];

  categoryaddfunction() async {
    setState((){
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('category').orderBy("categoryname", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
  }

  barndaddfunction() async {
    setState((){
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Barndlist.add(Document.docs[i]['Brandname']);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body: Column(
        children: [
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
                style: GoogleFonts.openSans(
                    color: Colors.white, fontSize: width / 80.353),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 91.066,
              ),
              InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(top: height / 32.85),
                child: Tooltip(
                  message: "Back",
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Colors.indigo,
                    child: Container(
                      height: height / 21.9,
                      width: width / 45.53,
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
              Padding(
                padding:
                EdgeInsets.only(left: width / 35.947, top: height / 32.85),
                child: Text(
                  "Walking Customer Reports",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: width / 59.39,
                    color: Colors.white,
                  ),
                ),
              ),


            ],
          ), //line image
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height / 36.5, horizontal: width / 75.88),
            child: Image.asset("assets/Line13.png"),
          ),

          Container(
            height:height/ 1.294,
            width: width/1.050,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height/65.7,),
                  Padding(
                    padding:  EdgeInsets.only(left: width/273.2),
                    child: Row(
                      children: [
                        Container(
                            width:width/30.383,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Si.no',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/22.383,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Bill No',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/16.383,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Date\nTime',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/18.588,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),

                            ),
                            child: Center(child: Text('Category',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/18.588,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),

                            ),
                            child: Center(child: Text('Brand',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/18.588,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Item ID',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/3.5,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Item Name',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/17.3,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('HSN Code',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/20.0,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Quantity',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/12.0,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Without Tax',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/12.0,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Sales Price',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/12.0,
                            height:height/13.14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1.2),
                            ),
                            child: Center(child: Text('Total',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


                      ],
                    ),
                  ),
                  status==true?
                  Padding(
                    padding:  EdgeInsets.only(left: width/273.2),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("billingItemreportsG").orderBy("timestamp",descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData==null){
                          return Center(child: Container());
                        }
                        if(!snapshot.hasData){
                          return Center(child: Container());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            var buillin1=snapshot.data!.docs[index];
                            if(buillin1["customerphone"]=="Walking Customer") {
      if (isserach == true) {
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            return
              Row(
                children: [
                  Container(
                      width: width / 30.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text((index + 1).toString(),
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 22.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text("${buillin1["purchaseno"]}",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 16.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(
                        "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),

                      ),
                      child: Center(child: Text(buillin1["Category"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),

                      ),
                      child: Center(child: Text(buillin1["Brand"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["itemcode"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 3.5,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Description"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 17.3,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Hsncode"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 20.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Qty"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["withouttaxprice"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["withouttaxprice"] == "Return"
                                ? Colors.red
                                : Colors.black),))),

                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Sales price"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["Sales price"] == "Return" ? Colors
                                .red : Colors.black),))),
                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Total"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["Total"] == "Return"
                                ? Colors.red
                                : Colors.black),))),


                ],
              );
          }
        }

        if (mydate.isNotEmpty && itemsearch != ""
            && hsnsearch == "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Item'].toString().toLowerCase().
            startsWith(itemsearch.toLowerCase())
                || buillin1['itemcode'].toString().toLowerCase().
            startsWith(itemsearch.toLowerCase())) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch != "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Hsncode'].toString().toLowerCase().
            startsWith(hsnsearch.toLowerCase())
            ) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch == "" && catsearch != "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Category'].toString().toLowerCase().
            startsWith(catsearch.toLowerCase())

            ) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }

        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch != "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Brand'].toString().toLowerCase().
            startsWith(brandsearch.toLowerCase())) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
      }

      else {
        return
          Row(
            children: [
              Container(
                  width: width / 30.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text((index + 1).toString(),
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 22.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text("${buillin1["purchaseno"]}",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: Colors.black),))),

              Container(
                  width: width / 16.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(
                    "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),

                  ),
                  child: Center(child: Text(buillin1["Category"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),

                  ),
                  child: Center(child: Text(buillin1["Brand"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["itemcode"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 3.5,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Description"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 17.3,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Hsncode"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 20.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Qty"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["withouttaxprice"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["withouttaxprice"] == "Return" ? Colors
                            .red : Colors.black),))),

              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Sales price"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["Sales price"] == "Return"
                            ? Colors.red
                            : Colors.black),))),
              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Total"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["Total"] == "Return"
                            ? Colors.red
                            : Colors.black),))),


            ],
          );
      }
    }

                          },);
                      },
                    ),
                  ):
                  status2==true?
                  Padding(
                    padding:  EdgeInsets.only(left: width/273.2),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("billingItemreportsN").orderBy("timestamp",descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData==null){
                          return Center(child: Container());
                        }
                        if(!snapshot.hasData){
                          return Center(child: Container());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            var buillin1=snapshot.data!.docs[index];
                            if(buillin1["customerphone"]=="Walking Customer") {
      if (isserach == true) {
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            return
              Row(
                children: [
                  Container(
                      width: width / 30.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text((index + 1).toString(),
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 22.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text("${buillin1["purchaseno"]}",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 16.383,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(
                        "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),

                      ),
                      child: Center(child: Text(buillin1["Category"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),

                      ),
                      child: Center(child: Text(buillin1["Brand"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 18.588,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["itemcode"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 3.5,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Description"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 17.3,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Hsncode"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 20.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Qty"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: Colors.black),))),

                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["withouttaxprice"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["withouttaxprice"] == "Return"
                                ? Colors.red
                                : Colors.black),))),

                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Sales price"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["Sales price"] == "Return" ? Colors
                                .red : Colors.black),))),
                  Container(
                      width: width / 12.0,
                      height: height / 13.14,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Center(child: Text(buillin1["Total"],
                        style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                            color: buillin1["Total"] == "Return"
                                ? Colors.red
                                : Colors.black),))),


                ],
              );
          }
        }

        if (mydate.isNotEmpty && itemsearch != ""
            && hsnsearch == "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Item'].toString().toLowerCase().
            startsWith(itemsearch.toLowerCase())
                || buillin1['itemcode'].toString().toLowerCase().
            startsWith(itemsearch.toLowerCase())) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch != "" && brandsearch == "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Hsncode'].toString().toLowerCase().
            startsWith(hsnsearch.toLowerCase())
            ) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch == "" && catsearch != "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Category'].toString().toLowerCase().
            startsWith(catsearch.toLowerCase())

            ) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }

        if (mydate.isNotEmpty && itemsearch == ""
            && hsnsearch == "" && brandsearch != "" && catsearch == "") {
          if (mydate.contains(buillin1["purchasedate"])) {
            if (
            buillin1['Brand'].toString().toLowerCase().
            startsWith(brandsearch.toLowerCase())) {
              return
                Row(
                  children: [
                    Container(
                        width: width / 30.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text((index + 1).toString(),
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 22.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text("${buillin1["purchaseno"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 16.383,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(
                          "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Category"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),

                        ),
                        child: Center(child: Text(buillin1["Brand"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 18.588,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["itemcode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 3.5,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Description"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 17.3,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Hsncode"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 20.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Qty"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["withouttaxprice"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["withouttaxprice"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),

                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Sales price"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Sales price"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),
                    Container(
                        width: width / 12.0,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: Center(child: Text(buillin1["Total"],
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: buillin1["Total"] == "Return"
                                  ? Colors.red
                                  : Colors.black),))),


                  ],
                );
            }
          }
        }
      }

      else {
        return
          Row(
            children: [
              Container(
                  width: width / 30.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text((index + 1).toString(),
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 22.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text("${buillin1["purchaseno"]}",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: Colors.black),))),

              Container(
                  width: width / 16.383,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(
                    "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),

                  ),
                  child: Center(child: Text(buillin1["Category"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),

                  ),
                  child: Center(child: Text(buillin1["Brand"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 18.588,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["itemcode"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 3.5,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Description"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 17.3,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Hsncode"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 20.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Qty"],
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.black),))),

              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["withouttaxprice"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["withouttaxprice"] == "Return" ? Colors
                            .red : Colors.black),))),

              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Sales price"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["Sales price"] == "Return"
                            ? Colors.red
                            : Colors.black),))),
              Container(
                  width: width / 12.0,
                  height: height / 13.14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: Center(child: Text(buillin1["Total"],
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold,
                        color: buillin1["Total"] == "Return"
                            ? Colors.red
                            : Colors.black),))),


            ],
          );
      }
    }
                          },);
                      },
                    ),
                  ):

                  Padding(
                    padding:  EdgeInsets.only(left: width/273.2),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("billingItemreports").orderBy("timestamp",descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData==null){
                          return Center(child: Container());
                        }
                        if(!snapshot.hasData){
                          return Center(child: Container());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            var buillin1=snapshot.data!.docs[index];
                            if(buillin1["customerphone"]=="Walking Customer") {
                              if (isserach == true) {
                                if (mydate.isNotEmpty && itemsearch == ""
                                    && hsnsearch == "" && brandsearch == "" &&
                                    catsearch == "") {
                                  if (mydate.contains(
                                      buillin1["purchasedate"])) {
                                    return
                                      Row(
                                        children: [
                                          Container(
                                              width: width / 30.383,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                (index + 1).toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 22.383,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                "${buillin1["purchaseno"]}",
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 16.383,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 18.588,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),

                                              ),
                                              child: Center(child: Text(
                                                buillin1["Category"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 18.588,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),

                                              ),
                                              child: Center(child: Text(
                                                buillin1["Brand"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 18.588,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["itemcode"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 3.5,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["Description"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 17.3,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["Hsncode"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 20.0,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["Qty"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),))),

                                          Container(
                                              width: width / 12.0,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["withouttaxprice"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: buillin1["withouttaxprice"] ==
                                                        "Return"
                                                        ? Colors.red
                                                        : Colors.black),))),

                                          Container(
                                              width: width / 12.0,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["Sales price"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: buillin1["Sales price"] ==
                                                        "Return"
                                                        ? Colors.red
                                                        : Colors.black),))),
                                          Container(
                                              width: width / 12.0,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              child: Center(child: Text(
                                                buillin1["Total"],
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: buillin1["Total"] ==
                                                        "Return"
                                                        ? Colors.red
                                                        : Colors.black),))),


                                        ],
                                      );
                                  }
                                }

                                if (mydate.isNotEmpty && itemsearch != ""
                                    && hsnsearch == "" && brandsearch == "" &&
                                    catsearch == "") {
                                  if (mydate.contains(
                                      buillin1["purchasedate"])) {
                                    if (
                                    buillin1['Item'].toString().toLowerCase().
                                    startsWith(itemsearch.toLowerCase())
                                        || buillin1['itemcode'].toString()
                                        .toLowerCase()
                                        .
                                    startsWith(itemsearch.toLowerCase())) {
                                      return
                                        Row(
                                          children: [
                                            Container(
                                                width: width / 30.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  (index + 1).toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 22.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchaseno"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 16.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Category"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Brand"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["itemcode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 3.5,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Description"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 17.3,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Hsncode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 20.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Qty"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["withouttaxprice"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["withouttaxprice"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Sales price"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Sales price"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),
                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Total"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Total"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),


                                          ],
                                        );
                                    }
                                  }
                                }
                                if (mydate.isNotEmpty && itemsearch == ""
                                    && hsnsearch != "" && brandsearch == "" &&
                                    catsearch == "") {
                                  if (mydate.contains(
                                      buillin1["purchasedate"])) {
                                    if (
                                    buillin1['Hsncode'].toString()
                                        .toLowerCase()
                                        .
                                    startsWith(hsnsearch.toLowerCase())
                                    ) {
                                      return
                                        Row(
                                          children: [
                                            Container(
                                                width: width / 30.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  (index + 1).toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 22.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchaseno"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 16.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Category"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Brand"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["itemcode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 3.5,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Description"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 17.3,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Hsncode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 20.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Qty"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["withouttaxprice"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["withouttaxprice"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Sales price"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Sales price"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),
                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Total"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Total"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),


                                          ],
                                        );
                                    }
                                  }
                                }
                                if (mydate.isNotEmpty && itemsearch == ""
                                    && hsnsearch == "" && brandsearch == "" &&
                                    catsearch != "") {
                                  if (mydate.contains(
                                      buillin1["purchasedate"])) {
                                    if (
                                    buillin1['Category']
                                        .toString()
                                        .toLowerCase()
                                        .
                                    startsWith(catsearch.toLowerCase())

                                    ) {
                                      return
                                        Row(
                                          children: [
                                            Container(
                                                width: width / 30.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  (index + 1).toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 22.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchaseno"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 16.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Category"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Brand"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["itemcode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 3.5,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Description"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 17.3,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Hsncode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 20.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Qty"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["withouttaxprice"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["withouttaxprice"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Sales price"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Sales price"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),
                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Total"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Total"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),


                                          ],
                                        );
                                    }
                                  }
                                }

                                if (mydate.isNotEmpty && itemsearch == ""
                                    && hsnsearch == "" && brandsearch != "" &&
                                    catsearch == "") {
                                  if (mydate.contains(
                                      buillin1["purchasedate"])) {
                                    if (
                                    buillin1['Brand'].toString().toLowerCase().
                                    startsWith(brandsearch.toLowerCase())) {
                                      return
                                        Row(
                                          children: [
                                            Container(
                                                width: width / 30.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  (index + 1).toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 22.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchaseno"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 16.383,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Category"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),

                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Brand"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 18.588,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["itemcode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 3.5,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Description"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 17.3,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Hsncode"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 20.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Qty"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["withouttaxprice"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["withouttaxprice"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),

                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Sales price"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Sales price"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),
                                            Container(
                                                width: width / 12.0,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2),
                                                ),
                                                child: Center(child: Text(
                                                  buillin1["Total"],
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: buillin1["Total"] ==
                                                          "Return"
                                                          ? Colors.red
                                                          : Colors.black),))),


                                          ],
                                        );
                                    }
                                  }
                                }
                              }

                              else {
                                return
                                  Row(
                                    children: [
                                      Container(
                                          width: width / 30.383,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            (index + 1).toString(),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 22.383,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            "${buillin1["purchaseno"]}",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 16.383,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            "${buillin1["purchasedate"]}\n${buillin1["time"]}",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 18.588,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),

                                          ),
                                          child: Center(child: Text(
                                            buillin1["Category"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 18.588,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),

                                          ),
                                          child: Center(child: Text(
                                            buillin1["Brand"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 18.588,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["itemcode"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 3.5,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["Description"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 17.3,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["Hsncode"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 20.0,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["Qty"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),))),

                                      Container(
                                          width: width / 12.0,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["withouttaxprice"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: buillin1["withouttaxprice"] ==
                                                    "Return"
                                                    ? Colors.red
                                                    : Colors.black),))),

                                      Container(
                                          width: width / 12.0,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["Sales price"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: buillin1["Sales price"] ==
                                                    "Return"
                                                    ? Colors.red
                                                    : Colors.black),))),
                                      Container(
                                          width: width / 12.0,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2),
                                          ),
                                          child: Center(child: Text(
                                            buillin1["Total"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: buillin1["Total"] ==
                                                    "Return"
                                                    ? Colors.red
                                                    : Colors.black),))),


                                    ],
                                  );
                              }
                            }
                          },);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}
