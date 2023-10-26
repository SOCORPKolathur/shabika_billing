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


class Reports_Page extends StatefulWidget {
  const Reports_Page({Key? key}) : super(key: key);

  @override
  State<Reports_Page> createState() => _Reports_PageState();
}

class _Reports_PageState extends State<Reports_Page> {
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
    categoryaddfunction();
    barndaddfunction();
    datefun();
    additemduntion();
    gettotal();

    setState(() {
      isserach=true;
    });

    print(mydate);
    //billingtotalamount();
    // TODO: implement initState
    super.initState();
  }

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
    return
      Column(
      children: [
        SizedBox(
          height: height/43.8,
        ),
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/91.06),
              child: Text(" Sales Reports",
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/54.64),),
            ),

            //toggle switchs
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
              "Shabika G",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/45.583, right: width/56.916),
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
              "Shabika N",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),
          ],
        ),
        SizedBox(
          height: height / 83.8,
        ),
        Row(
          children: [
            SizedBox(
              width: width / 200.8,
            ),
            Text(
              "Date",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 151.066,
            ),
            //textfield-1 fromdate
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "dd/mm/yyyy",
                  hintStyle: GoogleFonts.openSans(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    DateFormat('dd/M/yyyy').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      year1 = pickedDate.year;
                      day1 = pickedDate.day;
                      month1 = pickedDate.month;
                      Datecontroller.text = formattedDate;
                      //set output date to TextField value.
                    });
                    DateTime startDate = DateTime.utc(year1, month1, day1);
                    DateTime endDate = DateTime.utc(year2, month2, day2);
                    getDaysInBetween() {
                      final int difference =
                          endDate.difference(startDate).inDays;
                      return difference+1;
                    }

                    final items =
                    List<DateTime>.generate(getDaysInBetween(), (i) {
                      DateTime date = startDate;
                      return date.add(Duration(days: i));
                    });
                    setState(() {
                      mydate.clear();
                    });
                    for (int i = 0; i < items.length; i++) {
                      setState(() {
                        isserach = true;
                        mydate.add(formatter.format(items[i]).toString());
                      });
                      print(mydate);
                      print("+++++++++++++++++++++++++++++++++++++++kkkk");
                      //billingtotalamount();
                    }
                  } else {}
                },
              ),
            ),
            SizedBox(
              width: width / 101.066,
            ),
            Text(
              "To",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 151.066,
            ),

            //textfield-2 todate
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "dd/mm/yyyy",
                  hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('dd/M/yyyy').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      year2 = pickedDate.year;
                      day2 = pickedDate.day;
                      month2 = pickedDate.month;
                      Datecontroller2.text = formattedDate;

                      //set output date to TextField value.
                    });
                    DateTime startDate = DateTime.utc(year1, month1, day1);
                    DateTime endDate = DateTime.utc(year2, month2, day2);
                    getDaysInBetween() {
                      final int difference =
                          endDate.difference(startDate).inDays;
                      return difference+1;
                    }

                    final items =
                    List<DateTime>.generate(getDaysInBetween(), (i) {
                      DateTime date = startDate;
                      return date.add(Duration(days: i));
                    });
                    setState(() {
                      mydate.clear();
                    });
                    for (int i = 0; i < items.length; i++) {
                      setState(() {
                        isserach = true;
                        mydate.add(formatter.format(items[i]).toString());
                      });
                      print(mydate);
                      print("+++++++++++++++++++++++++++++++++++++++kkkk");
                      //billingtotalamount();
                    }
                  } else {}
                },
              ),
            ),

            SizedBox(
              width: width / 136.6,
            ),

            Text(
              "Item Name",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),

            Container(
              height: height / 21.9,
              width: width / 5.506, // width: width / 3.415,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    itemsearch=val;
                  });
                  print(Suppilercontroller.text);
                  },
                style: GoogleFonts.montserrat(
                    fontSize: width / 91.06, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        bottom: height / 43.8, left: width / 136.6)),
                controller: Suppilercontroller,
              ),
            ),
            SizedBox(
              width: width / 136.6,
            ),
            //Status-1
            Text(
              "HSN Code",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.106,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      hsnsearch=val;
                    });
                    print(Invoicecontroller.text);
                  },
                  style: GoogleFonts.montserrat(
                      fontSize: width / 91.06, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          bottom: height / 43.8, left: width / 136.6)),
                  controller: Invoicecontroller,
                ),),
            SizedBox(
              width: width / 136.6,
            ),

            SizedBox(
              width: width / 156.6,
            ),


            //Status-2
            Text(
              "Category",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.6,
            ),
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
             child: TextFormField(
               onChanged: (val){
                 setState(() {
                   catsearch=val;
                 });
                 print(_typeAheadControllergender.text);
               },
               style: GoogleFonts.montserrat(
                   fontSize: width / 91.06, fontWeight: FontWeight.w500),
               decoration: InputDecoration(
                   border: InputBorder.none,
                   contentPadding: EdgeInsets.only(
                       bottom: height / 43.8, left: width / 136.6)),
               controller: _typeAheadControllergender,
             ),
             /* child: LayoutBuilder(
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
                          baseOffset: 10,
                          extentOffset: 1,
                        ),

                      ),
                      optionsViewBuilder:
                          (context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.vertical(
                                  bottom:
                                  Radius.circular(4.0)),
                            ),
                            child: SizedBox(
                              height: 52.0 * options.length,
                              width:
                              BoxConstraints.biggest.width,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext, index) {
                                  final String option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () =>
                                        onSelected(option),
                                    child: Padding(padding: const EdgeInsets.all(16.0),
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
                          categoryitemcode(textEditingValue.text);

                        }

                        return categorylist.where((String option) {
                          return option.toLowerCase().contains(
                              textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        categoryitemcode(selection);
                        setState(() {
                          _typeAheadControllergender.text=selection;
                        });
                        debugPrint('You just selected $selection');
                      },
                      displayStringForOption: (Value) {
                        return Value;
                      },
                    ),
              ),*/
            ),
            SizedBox(
              width: width / 150.8,
            ),

            InkWell(
              onTap: () {
                setState(() {
                  Invoicecontroller.clear();
                  Suppilercontroller.clear();
                  Status1 = "";
                  Status2 = "";
                  Status3 = "";
                  Username = '';
                  Username2 = '';
                  hsnsearch="";
                  catsearch="";
                  brandsearch="";
                  itemsearch="";
                  _typeAheadControllergender.clear();
                  _typeAheadControllergender2.clear();
                  _typeAheadControllergender.text =="";
                  _typeAheadControllergender2.text=="";

                });

                //billingtotalamount();
              },
              child: Container(
                height: height / 21.9,
                width: width / 13.66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                child: Center(
                  child: Text(
                    "Clear",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: width / 84.64),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height / 83.8,
        ),
        Row(
          children: [

            SizedBox(
              width: width / 200.8,
            ),

            Text(
              "Brand",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.6,
            ),
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
             child: TextFormField(
                onChanged: (val){
                  setState(() {
                    brandsearch=val;
                  });
                  print(_typeAheadControllergender2.text);
                },
                style: GoogleFonts.montserrat(
                    fontSize: width / 91.06, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        bottom: height / 43.8, left: width / 136.6)),
                controller: _typeAheadControllergender2,
              ),
              /*child: LayoutBuilder(
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
                                itemBuilder:
                                    (BuildContext, index) {
                                  final String option =
                                  options.elementAt(index);
                                  return InkWell(
                                    onTap: () =>
                                        onSelected(option),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(16.0),
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
                        if (textEditingValue.text != '') {
                          Branditemcode(textEditingValue.text);
                        }

                        return Barndlist.where((String option) {
                          return option.toLowerCase().contains(
                              textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        Branditemcode(selection);
                        setState(() {
                          _typeAheadControllergender2.text=selection;
                        });
                        debugPrint('You just selected $selection');
                      },
                      displayStringForOption: (Value) {
                        return Value;
                      },
                    ),
              ),*/
            ),
            SizedBox(
              width: width / 100.8,
            ),
            Text(
              "Shabika G",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                      salesamountG.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 88.64),
                    ))),
            SizedBox(
              width: width / 100.066,
            ),
            Text(
              "Shabika N",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                      salesamountN.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 88.64),
                    ))),
            SizedBox(
              width: width / 100.066,
            ),
            Text(
              "Total Amount",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                      salesamount.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 88.64),
                    ))),
            SizedBox(
              width: width / 100.066,
            ),

          ],
        ),
        SizedBox(
          height: height/43.8,
        ),

        Container(
          height:height/ 1.194,
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
                          width:width/18.383,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Si.no',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                      Container(
                          width:width/16.383,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Date\nTime',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/18.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),

                          ),
                          child: Center(child: Text('Category',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                      Container(
                          width:width/18.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),

                          ),
                          child: Center(child: Text('Brand',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/18.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Item ID',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/3.5,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Item Name',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/12.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('HSN Code',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/20.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Quantity',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/12.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Without Tax',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/12.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Sales Price',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                      Container(
                          width:width/12.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Total',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


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

                            if(isserach==true){
                            if(mydate.isNotEmpty && itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch=="")
                            {
                              if(mydate.contains(buillin1["purchasedate"])) {
                                return Row(
                                  children: [
                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/16.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/3.5,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/20.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                  ],
                                );
                              }
                            }

                             if(mydate.isNotEmpty &&itemsearch!=""
                                &&hsnsearch==""&&brandsearch==""&&catsearch==""){
                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Item'].toString().toLowerCase().
                                startsWith(itemsearch.toLowerCase())
                                || buillin1['itemcode'].toString().toLowerCase().
                                    startsWith(itemsearch.toLowerCase()))
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }
                            }
                             if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch!=""&&brandsearch==""&&catsearch==""){

                               if(mydate.contains(buillin1["purchasedate"])) {
                                 if(
                                 buillin1['Hsncode'].toString().toLowerCase().
                                 startsWith(hsnsearch.toLowerCase())
                                 )
                                 {
                                   return Row(
                                     children: [
                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/16.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),

                                           ),
                                           child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),

                                           ),
                                           child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/3.5,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/20.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                     ],
                                   );
                                 }

                               }

                             }
                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch!=""){

                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Category'].toString().toLowerCase().
                                startsWith(catsearch.toLowerCase())

                                )
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }

                            }

                             if(mydate.isNotEmpty &&itemsearch==""
                                 &&hsnsearch==""&&brandsearch!=""&&catsearch==""){
                               if(mydate.contains(buillin1["purchasedate"])) {
                                 if(
                                 buillin1['Brand'].toString().toLowerCase().
                                 startsWith(brandsearch.toLowerCase()))
                                 {
                                   return Row(
                                     children: [
                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/16.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),

                                           ),
                                           child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),

                                           ),
                                           child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                       Container(
                                           width:width/18.588,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/3.5,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                       Container(
                                           width:width/20.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                       Container(
                                           width:width/12.0,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                     ],
                                   );
                                 }

                               }
                             }

                            }

                            else{
                              return Row(
                                children: [
                                  Container(
                                      width:width/18.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                  Container(
                                      width:width/16.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                  Container(
                                      width:width/18.588,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),

                                      ),
                                      child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                  Container(
                                      width:width/18.588,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),

                                      ),
                                      child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                  Container(
                                      width:width/18.588,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                  Container(
                                      width:width/3.5,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                  Container(
                                      width:width/12.0,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                  Container(
                                      width:width/20.0,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                  Container(
                                      width:width/12.0,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                  Container(
                                      width:width/12.0,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                  Container(
                                      width:width/12.0,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                ],
                              );
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

                          if(isserach==true){
                            if(mydate.isNotEmpty && itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch=="")
                            {
                              if(mydate.contains(buillin1["purchasedate"])) {
                                return Row(
                                  children: [
                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/16.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/3.5,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/20.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                  ],
                                );
                              }
                            }

                            if(mydate.isNotEmpty &&itemsearch!=""
                                &&hsnsearch==""&&brandsearch==""&&catsearch==""){
                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Item'].toString().toLowerCase().
                                startsWith(itemsearch.toLowerCase())
                                    || buillin1['itemcode'].toString().toLowerCase().
                                startsWith(itemsearch.toLowerCase()))
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }
                            }
                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch!=""&&brandsearch==""&&catsearch==""){

                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Hsncode'].toString().toLowerCase().
                                startsWith(hsnsearch.toLowerCase())
                                )
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }

                            }
                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch!=""){

                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Category'].toString().toLowerCase().
                                startsWith(catsearch.toLowerCase())

                                )
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }

                            }

                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch==""&&brandsearch!=""&&catsearch==""){
                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Brand'].toString().toLowerCase().
                                startsWith(brandsearch.toLowerCase()))
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }
                            }

                          }

                          else{
                            return Row(
                              children: [
                                Container(
                                    width:width/18.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/16.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/3.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/20.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                              ],
                            );
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

                          if(isserach==true){
                            if(mydate.isNotEmpty && itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch=="")
                            {
                              if(mydate.contains(buillin1["purchasedate"])) {
                                return Row(
                                  children: [
                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/16.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                    Container(
                                        width:width/18.588,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/3.5,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                    Container(
                                        width:width/20.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                    Container(
                                        width:width/12.0,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                  ],
                                );
                              }
                            }

                            if(mydate.isNotEmpty &&itemsearch!=""
                                &&hsnsearch==""&&brandsearch==""&&catsearch==""){
                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Item'].toString().toLowerCase().
                                startsWith(itemsearch.toLowerCase())
                                    || buillin1['itemcode'].toString().toLowerCase().
                                startsWith(itemsearch.toLowerCase()))
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }
                            }
                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch!=""&&brandsearch==""&&catsearch==""){

                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Hsncode'].toString().toLowerCase().
                                startsWith(hsnsearch.toLowerCase())
                                )
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }

                            }
                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch==""&&brandsearch==""&&catsearch!=""){

                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Category'].toString().toLowerCase().
                                startsWith(catsearch.toLowerCase())

                                )
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }

                            }

                            if(mydate.isNotEmpty &&itemsearch==""
                                &&hsnsearch==""&&brandsearch!=""&&catsearch==""){
                              if(mydate.contains(buillin1["purchasedate"])) {
                                if(
                                buillin1['Brand'].toString().toLowerCase().
                                startsWith(brandsearch.toLowerCase()))
                                {
                                  return Row(
                                    children: [
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/16.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                      Container(
                                          width:width/18.588,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/3.5,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                      Container(
                                          width:width/20.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                      Container(
                                          width:width/12.0,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                                    ],
                                  );
                                }

                              }
                            }

                          }

                          else{
                            return Row(
                              children: [
                                Container(
                                    width:width/18.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text((index+1).toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/16.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("${buillin1["purchasedate"]}\n${buillin1["time"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(buillin1["Category"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(buillin1["Brand"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.black),))),

                                Container(
                                    width:width/18.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["itemcode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/3.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Description"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Hsncode"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/20.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Qty"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["withouttaxprice"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),

                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Sales price"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),))),
                                Container(
                                    width:width/12.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text(buillin1["Total"],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:Colors.black),))),


                              ],
                            );
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
    );
  }

  showdialpogbox(streamid,name,phone,date,time,payment,address,disamount,disperamount) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      showDialog(
      context: context,
      builder: (context) {
        return SlideInLeft(
          animate: true,
          duration: const Duration(milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height:height/ 1.194,
                width: width/0.975,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height/65.7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: ClipOval(
                              child: Container(
                                height: height/26.28,
                                width:width/ 54.64,
                                color: Colors.red,
                                child: const Center(child: Icon(Icons.clear,color: Colors.white,)),
                              ),
                            ),
                          ),
                          SizedBox(width: width/65.7,),


                        ],
                      ),
                      SizedBox(height: height/45.7,),

                      Padding(
                        padding:  EdgeInsets.only(left: width/50.2),
                        child: Row(

                          children: [

                            Container(
                              width: width/15.2,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Item Code",
                                textAlign:TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(

                              width: width/8.0,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text('Description',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),


                            Container(
                              height:height/13.13,
                              width: width/10.17,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Hsncode",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),


                            Container(
                              height:height/13.13,
                              width: width/10.691,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Payment",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),




                            Container(
                              height:height/13.13,
                              width: width/20.075,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Qty",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/10.17,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Sales Price",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(

                              width: width/10.17,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Without Tax",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/20.17,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Tax",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/20.66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Dis %",
                                textAlign:TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/13.66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Date\nTime",
                                textAlign:TextAlign.center,

                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),




                          ],
                        ),
                      ),



                      Padding(
                        padding:  EdgeInsets.only(left: width/50.2),
                        child: SizedBox(
                          height:height/1.602,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("billing").
                            doc(streamid).collection(streamid).orderBy("timestamp",descending: true).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData==null){
                                return Center(child: Container(),);
                              }
                              if(!snapshot.hasData){
                                return Center(child: Container(),);
                              }
                              return  ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var customer=snapshot.data!.docs[index];
                                  return

                                    Row(

                                      children: [

                                        Container(
                                          width: width/15.2,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer["itemcode"].toString(),
                                            textAlign:TextAlign.center,
                                            style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/8.0,
                                          height:height/13.13,
                                          padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer["Description"].toString(),style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/10.17,

                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Hsncode'].toString(),style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/10.691,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(payment.toString(),style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/20.075,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Qty'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          width: width/10.17,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Sales price'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/10.17,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['withouttaxprice'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/20.17,

                                          child: Center(child: Text(customer['tax'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/20.66,

                                          child: Center(child: Text("$disamount\n$disperamount".toString(),
                                            textAlign:TextAlign.center,
                                            style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/13.66,

                                          child: Center(child: Text("${customer['date']}\n${customer['time']}".toString(),
                                            textAlign:TextAlign.center,

                                            style: GoogleFonts.poppins(),)),
                                        ),




                                      ],
                                    );
                                },);
                            },),
                        ),
                      ),

                      SizedBox(
                        height: height/32.85,
                      ),




                      SizedBox(
                        height: height/32.85,
                      ),

                    ],
                  ),
                ),
              )),
        );
      },
    );
  }


  double Total=0;
  String SGST='';
  String CGST="";
  String TotalAmount="";

  List<String> categorylist = <String>[];
  List<String> Barndlist = <String>[];

  String catitemcode = '';
  String branditemcode = '';

  categoryitemcode(itemcode) async {
    var document =
    await FirebaseFirestore.instance.collection("category").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (document.docs[i]["categoryname"] == itemcode) {
        setState(() {
          catitemcode = document.docs[i].id;
        });
      }
    }
  }

  Branditemcode(itemcode) async {
    var document = await FirebaseFirestore.instance.collection("Brand").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (document.docs[i]["Brandname"] == itemcode) {
        setState(() {
          branditemcode = document.docs[i].id;
        });
      }
    }
  }

   TextEditingController _typeAheadControllergender = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(categorylist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

   TextEditingController _typeAheadControllergender2 = TextEditingController();
   TextEditingController _typeAheadControllergender3 = TextEditingController();
  SuggestionsBoxController suggestionBoxController2 = SuggestionsBoxController();
  SuggestionsBoxController suggestionBoxController3 = SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query) {
    List<String> matches = <String>[];
    matches.addAll(Barndlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget textfield3(
      FocusNode focusNode,
      TextEditingController textEditingController,
      VoidCallback onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      TextFormField(
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only( bottom: height / 43.8,
                top: height / 43.8,
                left: width/136.6)),
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
  }
}



