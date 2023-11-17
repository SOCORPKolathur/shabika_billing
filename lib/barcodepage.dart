import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';


class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {


  bool status=true;
  bool status2=false;



  TextEditingController Invoicecontroller = TextEditingController();
  TextEditingController Suppilercontroller = TextEditingController();
  TextEditingController Paymenttype = TextEditingController();
  bool isserach = false;
  String Username2 = "";
  String Username = "";
  String Status1 = '';
  String Status2 = '';
  String Status3 = '';

  List<String> Invoice = [];
  List<String> Suppilier = [];
  List<String> PaymentType = [];




  additemduntion() async {
    setState(() {
      Suppilier.clear();
      Invoice.clear();
      PaymentType.clear();

    });

    if (status == true) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }
    } else if (status2 == true) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }
    } else if (status == false && status2 == false) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase entry")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }

    }

    print(PaymentType);
  }

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
  datefun2(){
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

  @override
  void initState() {
    additemduntion();
    datefun();
    getlist();
    // TODO: implement initState
    super.initState();
  }
  bool chechmain = false;
  List<bool> check = List.generate(200, (index) => false);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Column(

        children: [
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

                      }
                      else{
                        setState(() {
                          status2 = val;
                        });
                      }
                    });
                    additemduntion();
                    getlist();
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

                      }
                      else{
                        setState(() {
                          status = val;
                        });
                      }
                    });
                    additemduntion();
                    getlist();
                  },
                ),
              ),
              Text(
                "Shabika N",
                style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
              ),
            ],
          ),
          SizedBox(height: height / 100.8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 200.8,
              ),
              Container(
                width: width / 12.6,
                child: Text(
                  "Date",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
              ),
              SizedBox(
                width: width / 136.6,
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
                    hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
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
                        getlist();
                      }
                    } else {}
                  },
                ),
              ),

              SizedBox(
                width: width / 91.066,
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
                       // billingtotalamount();
                        getlist();
                      }
                    } else {}
                  },
                ),
              ),

              SizedBox(
                width: width / 50.6,
              ),

              SizedBox(
                width: width / 156.6,
              ),


              //Status-2


              InkWell(
                onTap: () {
                  setState(() {

                  });
                },
                child: Container(
                  height: height / 21.9,
                  width: width / 7.66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      "Generate Barcode",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 84.64),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width / 156.6,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Datecontroller.clear();
                    Datecontroller2.clear();
                    mydate.clear();
                    isserach = false;
                    productsid2.clear();
                  });
                  // additemduntion();
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
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 84.64),
                    ),
                  ),
                ),
              ),
              Container(
              width: width/9,
    height:height / 16.42,)


              //Status-1

            ],
          ),
          SizedBox(
            height: height / 100.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 200.8,
              ),


              //Status-1
              Container(
                width: width / 12.6,
                child: Text(
                  "Invoice",
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
              ),

              SizedBox(
                width: width / 136.6,
              ),
              Container(
                  height: height / 21.9,
                  width: width / 4.106,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: LayoutBuilder(
                    builder: (BuildContext, BoxConstraints) =>
                        Autocomplete<String>(
                          initialValue: const TextEditingValue(
                            selection: TextSelection(
                              isDirectional: true,
                              baseOffset: 10,
                              extentOffset: 1,
                            ),
                          ),
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextFormField(
                              onChanged: (_) {
                                setState(() {
                                  Invoicecontroller = textEditingController;
                                });
                              },
                              style: GoogleFonts.openSans(
                                  fontSize: width / 91.06,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      bottom: height / 43.8, left: width / 136.6)),
                              controller: textEditingController,
                              focusNode: focusNode,
                              onFieldSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) => Align(
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
                                      final String option = options.elementAt(index);
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
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }
                            return Invoice.where((String option) {
                              return option
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            setState(() {
                              Invoicecontroller.text = selection;
                              Status1 = selection;
                              isserach = true;
                              Username = selection;
                            });
                          },
                          displayStringForOption: (Value) {
                            return Value;
                          },
                        ),
                  )),
              SizedBox(
                width: width / 136.6,
              ),

              SizedBox(
                width: width / 156.6,
              ),


              //Status-2


              InkWell(
                onTap: () {

                    getlist();

                },
                child: Container(
                  height: height / 21.9,
                  width: width / 7.66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      "Generate Bill Wise",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 84.64),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width / 156.6,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Invoicecontroller.clear();
                    productsid2.clear();
                  });
                  // additemduntion();
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
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 84.64),
                    ),
                  ),
                ),
              ),

              Padding(

                padding: EdgeInsets.only(
                    left:width/ 30.15, right: width / 100.15),
                child: InkWell(
                  onTap: () async {
                    getlist2();
                  },
                  child: Container(
                    width: width/7,
                    height:height / 16.42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),

                    child: Center(
                      child: Text(" Print Barcode  ",
                          style: GoogleFonts.openSans(
                              color: Color(0xff1D5B79),
                              fontWeight: FontWeight.w700,
                              fontSize: width / 60.3)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 100.8,
          ),
          SizedBox(
            height: height / 83.8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 75.888, vertical: height / 76.5),
            child: Image.asset("assets/Line13.png"),
          ),


          Container(
            width: width / 1.01,
            height: height / 16.42,
            // color: Color(0xff00A99D),
            decoration:  BoxDecoration(
                color: Color(0xff1D5B79),
                border: Border.all(
                    color: Colors.black
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Row(
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      left: 5, right: 5),
                  child: Checkbox(
                    value:  chechmain,
                    onChanged: (val){
                      setState(() {
                        chechmain=val!;
                        for(int i=0;i<200;i++){
                          setState(() {
                            check[i]=val;
                          });
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5, right: width / 64.15),
                  child: Text("Sl.no",
                      style: GoogleFonts.openSans(
                          color:  Colors.white,
                          fontSize: width / 88.3)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left:width/ 20.15, right: width / 40.15),
                  child: Text("Item ID",
                      style: GoogleFonts.openSans(
                          color:  Colors.white,
                          fontSize: width / 88.3)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left:width/ 20.15, right: width / 5.15),
                  child: Text("Item Description",
                      style: GoogleFonts.openSans(
                          color:  Colors.white,
                          fontSize: width / 88.3)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left:width/ 16.15, right: width / 40.15),
                  child: Text("Sale Price",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: width / 88.3)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left:width/ 16.15, right: width / 40.15),
                  child: Text("Quantity",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: width / 88.3)),
                ),

                Padding(

                  padding: EdgeInsets.only(
                      left:width/ 10.15, right: width / 100.15),
                  child: Text(" Barcode  ",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: width / 88.3)),
                ),


              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: productsid2.length,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Container(
                    width: width/40,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Checkbox(
                        value:  check[index],
                        onChanged: (val){
                          setState(() {
                            check[index]=val!;
                            print(index);
                            print(val);


                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: width/19,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text((index+1).toString(),
                          style: GoogleFonts.openSans(
                              color:  Colors.white,
                              fontSize: width / 88.3)),
                    ),
                  ),
                  Container(
                    width: width/8,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("${productsid2[index]}",
                          style: GoogleFonts.openSans(
                              color:  Colors.white,
                              fontSize: width / 88.3)),
                    ),
                  ),
                  Container(
                    width: width/3,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("${description2[index]}",
                          style: GoogleFonts.openSans(
                              color:  Colors.white,
                              fontSize: width / 88.3),overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                  Container(
                    width: width/5.9,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("${salesprice2[index]}",
                          style: GoogleFonts.openSans(
                              color:  Colors.white,
                              fontSize: width / 88.3)),
                    ),
                  ),
                  Container(
                    width: width/6.5,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("${qty2[index]}",
                          style: GoogleFonts.openSans(
                              color:  Colors.white,
                              fontSize: width / 88.3)),
                    ),
                  ),
                  Container(
                    width: width/8,
                    height: height/20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                        child:Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: BarcodeWidget(
                            barcode: Barcode.code128(),
                            drawText: false,
                            data: '${productsid2[index]}',
                          ),
                        )
                    ),
                  ),


                ],
              ),
            );
          }),
          SizedBox(height: height/10,)
        ],

    );
  }

List productsid =[];
List productsid2 =[];
List productsid3 =[];
List salesprice =[];
List salesprice2 =[];
List salesprice3 =[];
List description2 =[];
List qty2 =[];
  getlist() async {
setState(() {
   productsid.clear();
   productsid2.clear();
   productsid3.clear();
   salesprice.clear();
   salesprice2.clear();
   salesprice3.clear();
   description2.clear();
});
    var document = status==true?


    await FirebaseFirestore.instance.collection("Purchase ShabikaG").orderBy('timestamp').get():
    status2==true?
    await FirebaseFirestore.instance.collection("Purchase ShabikaN").orderBy('timestamp').get():
    await FirebaseFirestore.instance.collection("Purchase entry").orderBy('timestamp').get();
    for(int i=0;i<document.docs.length;i++){
      print(Invoicecontroller.text);
      print(document.docs[i]["suppilierinvoiceno"]);
      if(document.docs[i]["save"]==true) {
        if (Invoicecontroller.text == "") {
          if (mydate.contains(document.docs[i]["purchasedate"])) {
            var document2 = status==true?
            await FirebaseFirestore.instance.collection(
                "Purchase ShabikaG").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get():
            status2==true? await FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get():
            await FirebaseFirestore.instance.collection("Purchase entry").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get();
            for (int j = 0; j < document2.docs.length; j++) {
              print(document2.docs[j]["itemcode"]);
              print("Loop ${j}");
              setState(() {
                description2.add(document2.docs[j]["Description"]);
                productsid2.add(document2.docs[j]["itemcode"]);
                salesprice2.add((document2.docs[j]["Sales price"]).toString().substring(0, (document2.docs[j]["Sales price"]).indexOf('.')));
                qty2.add(document2.docs[j]["Qty"]);
              });

              for (int k = 0; k < int.parse(document2.docs[j]["Qty"]); k++) {
                setState(() {
                  productsid.add(document2.docs[j]["itemcode"]);
                  salesprice.add((document2.docs[j]["Sales price"]).toString().substring(0, (document2.docs[j]["Sales price"]).indexOf('.')));
                });
              }
            }
          }
        }
        else{
          print("Invoic NO==============");
          if (Invoicecontroller.text == document.docs[i]["suppilierinvoiceno"]) {
            var document2 = status==true ?
            await FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get():
            status2==true ? await FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get():
            await FirebaseFirestore.instance.collection("Purchase entry").doc(document.docs[i].id).collection(document.docs[i].id).orderBy('timestamp').get();
            for (int j = 0; j < document2.docs.length; j++) {
              print(document2.docs[j]["itemcode"]);
              print("Loop ${j}");
              setState(() {
                description2.add(document2.docs[j]["Description"]);
                productsid2.add(document2.docs[j]["itemcode"]);
                salesprice2.add((document2.docs[j]["Sales price"]).toString().substring(0, (document2.docs[j]["Sales price"]).indexOf('.')));
                qty2.add(document2.docs[j]["Qty"]);
              });

              for (int k = 0; k < int.parse(document2.docs[j]["Qty"]); k++) {
                setState(() {
                  productsid.add(document2.docs[j]["itemcode"]);
                  salesprice.add((document2.docs[j]["Sales price"]).toString().substring(0, (document2.docs[j]["Sales price"]).indexOf('.')));
                });
              }
            }
          }
        }
      }

    }
    print(productsid2);
    print(salesprice2);
  }
  getlist2() async {
    setState(() {
      productsid3.clear();
      salesprice3.clear();
    });
    print(productsid.length);
    print("Printing on progess");

  for(int i=0;i<productsid2.length;i++){
    if(check[i]==true){
      print(productsid2[i]);
      print("loop id");
      for(int j=0;j<int.parse(qty2[i]);j++){
      setState(() {
        productsid3.add(productsid2[i]);
        salesprice3.add(salesprice2[i]);
      });
      }
    }
    print(productsid3);
  }
  List<p.Widget> widgets = [];
    final container = p.Center(

      child:

      p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.all(10.0),
            child: p.GridView(
                crossAxisCount: 4,
                childAspectRatio: (0.7),
                children: [
                  for(int i=0; i<productsid3.length;i++)
                    p.Container(

                      child: p.Padding(
                          padding:  p.EdgeInsets.symmetric(horizontal: 4.0),
                          child: p.Column(
                            crossAxisAlignment: p.CrossAxisAlignment.center,
                              children: [
                                p.Padding(
                                  padding:  p.EdgeInsets.only(bottom: 0.0),
                                  child: p.Text("Sale Price",style: p.TextStyle(
                                      fontWeight: p.FontWeight.bold,
                                      fontSize: 13
                                  )),

                                ),
                                p.Padding(
                                  padding:  p.EdgeInsets.only(bottom: 0.0),
                                  child: p.Text("Rs. ${salesprice3[i]}",style: p.TextStyle(
                                      fontWeight: p.FontWeight.bold,
                                      fontSize: 20
                                  )),

                                ),
                                p.Container(
                                  height: 18,

                                  child: p.BarcodeWidget(
                                    height: 18,
                                    width: 80,
                                    data: productsid3[i],
                                    drawText: false,

                                    barcode: p.Barcode.code128(

                                    ),
                                  ),
                                ),
                                p.Padding(
                                  padding:  p.EdgeInsets.only(bottom: 0.0),
                                  child: p.Text("${productsid3[i]}",style: p.TextStyle(
                                      fontWeight: p.FontWeight.bold,
                                      fontSize: 13
                                  )),

                                ),

                                /*    p.Padding(
                                                    padding:  p.EdgeInsets.symmetric(vertical: 4.0),
                                                    child: p.Text(productsid[i]),
                                                  ),*/
                              ]
                          )







                      ),
                    ),
                ]
            ),)

      ),
    );

//add decorated image container to widgets list
    widgets.add(container);
    widgets.add(p.SizedBox(height: 22));//some space beneath image

//add all other data which may be in the form of list
//use a loop to create pdf widget and add it to list
//one by one


//pdf document
    final pdf = p.Document();
    pdf.addPage(
      p.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: p.EdgeInsets.zero,

        build: (context) => widgets,//here goes the widgets list
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

  }
}
