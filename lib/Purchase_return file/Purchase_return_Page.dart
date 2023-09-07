import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../LandingPage/LandingPage.dart';
import '../Puchase edit_page1.dart';

class Purchase_return_Page extends StatefulWidget {
  const Purchase_return_Page({Key? key}) : super(key: key);

  @override
  State<Purchase_return_Page> createState() => _Purchase_return_PageState();
}

class _Purchase_return_PageState extends State<Purchase_return_Page> {

  @override
  void initState() {
    totalamount();
    additemduntion();
    // TODO: implement initState
    super.initState();
  }


  TextEditingController Invoicecontroller=TextEditingController();
  TextEditingController Suppilercontroller=TextEditingController();
  TextEditingController Paymenttype=TextEditingController();
  bool isserach=false;
  String  Username2="";
  String Username="";
  String Status1='';
  String Status2='';
  String Status3='';

  List <String>Suppilier=[];
  List <String>Invoice=[];
  List <String>PaymentType=[];

  additemduntion()async{
    setState(() {
      Suppilier.clear();
      Invoice.clear();
      PaymentType.clear();
      isserach=false;
    });

    if(status==true){
      var document=await FirebaseFirestore.instance.collection("Purchase ShabikaG").where("return",isEqualTo: true).get();
      for(int i=0;i<document.docs.length;i++){
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
          PaymentType.add(document.docs[i]['Payment mode']);
        });
      }

    }
    else if(status2==true){
      var document=await FirebaseFirestore.instance.collection("Purchase ShabikaN").where("return",isEqualTo: true).get();
      for(int i=0;i<document.docs.length;i++){
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
          PaymentType.add(document.docs[i]['Payment mode']);
        });
      }
    }
    else{
      var document=await FirebaseFirestore.instance.collection("Purchase entry").where("return",isEqualTo: true).get();
      for(int i=0;i<document.docs.length;i++){
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
          PaymentType.add(document.docs[i]['Payment mode']);
        });
      }
    }

  }

  int Totalamount=0;

  totalamount()async{
    setState(() {
      Totalamount=0;
    });
    var fetchdata=await FirebaseFirestore.instance.collection("Purchase entry").get();
    for(int i=0;i<fetchdata.docs.length;i++){
      var fetchdata2=await FirebaseFirestore.instance.collection("Purchase entry").doc(fetchdata.docs[i].id)
          .collection(fetchdata.docs[i].id).where("return",isEqualTo:true).get();
      for(int j=0;j<fetchdata2.docs.length;j++){
        setState(() {
          Totalamount=(Totalamount+double.parse(fetchdata2.docs[j]['Total'])).toInt();
        });
      }
    }
  }
  TextEditingController Datecontroller = TextEditingController();
  TextEditingController Datecontroller2 = TextEditingController();
  final DateFormat formatter = DateFormat('d/M/yyyy');
  int year1 = 0;
  int day1 = 0;
  int month1 = 0;
  int year2 = 0;
  int day2 = 0;
  int month2 = 0;
  List<String> mydate = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [

        //title and back button
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 91.066,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  drawer(" "),
                    ));
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
                "Purchase Returns",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: width / 59.39,
                  color: Colors.black,
                ),
              ),
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
          height: height/43.8,
        ),

        Row(children: [
            SizedBox(
              width: width/43.8,
            ),

            Text("Sort by Date  ",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/95.64),),
            SizedBox(width:width/273.5),
            //textfield-1 fromdate
            Container(
              height: height / 21.9,
              width: width / 9.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "mm/dd/yyyy",
                  hintStyle: const TextStyle(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now()
                  );

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('dd / M / yyyy').format(
                        pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      year1 = pickedDate.year;
                      day1 = pickedDate.day;
                      month1 = pickedDate.month;
                      Datecontroller.text = formattedDate;
                      //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),

            SizedBox(width: width / 91.066,),

            //textfield-2 todate
            Container(
              height: height / 21.9,
              width: width / 9.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "mm/dd/yyyy",
                  hintStyle: const TextStyle(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('d/M/yyyy').format(
                        pickedDate);
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
                      final int difference = endDate
                          .difference(startDate)
                          .inDays;
                      return difference;
                    }
                    final items = List<DateTime>.generate(
                        getDaysInBetween(), (i) {
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
                    }
                  } else {}
                },
              ),
            ),
            SizedBox(width: width/136.6,),

            Text("Supplier Name  ",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/95.64),),
            SizedBox(width: width/136.6,),


            Container(
              height: height / 21.9,
              width: width / 3.106,
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(5)
              ),
              child:
              LayoutBuilder(
                builder: (BuildContext, BoxConstraints) =>
                    Autocomplete<String>(
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        return
                          TextFormField(
                            onChanged: (_){
                              setState((){
                                Suppilercontroller=textEditingController;
                              });
                            },
                            style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
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

                        return Suppilier.where((String option) {
                          return option.toLowerCase().contains(
                              textEditingValue.text
                                  .toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          Suppilercontroller.text = selection;
                          isserach=true;
                          Username2=selection;
                        });
                        debugPrint(
                            'You just selected $selection');
                      },
                      displayStringForOption: (Value) {
                        return Value;
                      },
                    ),
              ),

            ),
            SizedBox(width: width/136.6,),

            //Status-1
            Text("Invoice  ",style: GoogleFonts.montserrat(color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: width/95.64),),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child:
                LayoutBuilder(
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
                            onChanged: (_){
                              setState((){
                                Invoicecontroller=textEditingController;
                              });
                            },
                            style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                            controller: textEditingController,
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
                          return Invoice.where((String option) {
                            return option.toLowerCase().contains(
                                textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            Invoicecontroller.text=selection;
                            Status1=selection;
                            isserach=true;
                            Username=selection;
                          });

                        },
                        displayStringForOption: (Value) {
                          return Value;
                        },
                      ),
                )

            ),
            SizedBox(width: width/136.6,),


            SizedBox(width: width/200.6,),

            InkWell(
              onTap: (){
                setState(() {
                  Invoicecontroller.clear();
                  Datecontroller.clear();
                  Datecontroller2.clear();
                  Suppilercontroller.clear();
                  Paymenttype.clear();
                  mydate.clear();
                  Status1="";
                  Status2="";
                  Status3="";
                  isserach=false;
                  Username='';
                  Username2='';
                });
                additemduntion();
              },
              child: Container(
                height: height/16.425,
                width: width/13.66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),color:Colors.red
                ),
                child:  Center(
                  child: Text("Clear",style: GoogleFonts.montserrat(color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width/84.64),),
                ),
              ),
            ),
          ],),

        SizedBox(
          height: height/43.8,
        ),

        Row(
          children: [
            SizedBox(
              width: width/43.8,
            ),
            //Status-2
            Text("Payment\nType  ",style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: width/95.64),),
            SizedBox(width:width/35.6),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child:
                LayoutBuilder(
                  builder: (BuildContext, BoxConstraints) =>
                      Autocomplete<String>(
                        initialValue: const TextEditingValue(
                          selection: TextSelection(
                            isDirectional: true,
                            baseOffset: 10,
                            extentOffset: 1,
                          ),

                        ),
                        fieldViewBuilder: (context, Controller2, focusNode, onFieldSubmitted){
                          return
                            TextFormField(
                              onChanged: (_){
                                setState((){
                                  Paymenttype=Controller2;
                                });
                              },
                              style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                              controller: Controller2,
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

                          return PaymentType.where((String option) {
                            return option.toLowerCase().contains(
                                textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            Status2=selection;
                            isserach=true;
                            Username=selection;
                            Paymenttype.text=selection;
                          });

                        },
                        displayStringForOption: (Value) {
                          return Value;
                        },
                      ),
                )

            ),
          ],
        ),

        //line image
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 36.5, horizontal: width / 75.88),
          child: Image.asset("assets/Line13.png"),
        ),

        Container(
          height: height/1.394,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child:SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height:25),
                Row(
                  children: [
                    SizedBox(width:width/54.15,),

                    Container(
                        width:width/15.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/18.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Bill No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/15.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Invoice No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/15.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Supplier ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/4.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Suppiler Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/4.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Reason",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Payment Type",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/13.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/8.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Actions",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    //SizedBox(width:width/27.32,),

                  ],
                ),

                StreamBuilder<QuerySnapshot>(
                  stream:
                   status==true?
                  FirebaseFirestore.instance.collection("Purchase ShabikaG").orderBy("timestamp",descending: true).snapshots():
                    status2==true?
                  FirebaseFirestore.instance.collection("Purchase ShabikaN").orderBy("timestamp",descending: true).snapshots():
                  FirebaseFirestore.instance.collection("Purchase entry").orderBy("timestamp",descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData==null){
                      return Center(child: Container());
                    }
                    if(!snapshot.hasData){
                      return Center(child: Container());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];

                          if (isserach == true && buillin1['return'] == true) {

                            if (mydate.isNotEmpty && Suppilercontroller.text == "" && Invoicecontroller.text == "" && Paymenttype.text == '') {
                              if (mydate.contains(buillin1['purchasedate'].toString())) {
                                return
                                  Row(
                                    children: [
                                      SizedBox(width:width/54.15,),

                                      Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child:
                                          Center(child:
                                          Text(buillin1['purchasedate'].toString(),
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ))),

                                      Container(
                                          width:width/18.507,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),
                                              buillin1['return']==true?
                                              Text("(Return)",
                                                style:
                                                GoogleFonts.poppins(fontSize: width/97.571, color:  Colors.red),
                                              ):const SizedBox(),
                                            ],
                                          )
                                      ),

                                      Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),

                                          child: Center(child: Text(buillin1['suppilierinvoiceno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/4.66,
                                          height:height/13.14,
                                          padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/4.66,
                                          height:height/13.14,
                                          padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(buillin1['Reason']==""?"null":buillin1['Reason'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/10.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/13.507,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                      Container(
                                          width:width/8.507,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              //view button
                                              InkWell(
                                                onTap: (){
                                                  checkqty(buillin1.id);

                                                },
                                                child: Material(
                                                  elevation: 10,
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: Container(
                                                      width:width/13.66,
                                                      height:height/21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(100),
                                                          color: Colors.green
                                                      ),
                                                      child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                                ),
                                              ),

                                              SizedBox(width:width/136.6,),
                                              //edit button
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));
                                                },
                                                child: Material(
                                                  elevation: 10,

                                                  borderRadius: BorderRadius.circular(100),
                                                  child: Container(
                                                      width:width/45.53,
                                                      height:height/21.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),

                                                      ),
                                                      child: Center(child: Icon(Icons.edit,color:
                                                      Colors.black,size:width/68.3))),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),

                                    ],
                                  );
                              }
                            }


                            else if (buillin1['suppilername'].toString().toLowerCase().startsWith(Suppilercontroller.text.toLowerCase())
                                &&Invoicecontroller.text==""&&Paymenttype.text==""&&Datecontroller.text==""&&Datecontroller2.text=="" ||
                                buillin1['suppilierinvoiceno'].toString().toLowerCase().startsWith(Invoicecontroller.text.toLowerCase())
                                    &&Suppilercontroller.text==""&&Paymenttype.text==""&&Datecontroller.text==""&&Datecontroller2.text==""
                            )
                            {
                              return
                                Row(
                                  children: [
                                    SizedBox(width:width/54.15,),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child:
                                        Center(child:
                                        Text(buillin1['purchasedate'].toString(),
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                    Container(
                                        width:width/18.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),
                                            buillin1['return']==true?
                                            Text("(Return)",
                                              style:
                                              GoogleFonts.poppins(fontSize: width/97.571, color:  Colors.red),
                                            ):const SizedBox(),
                                          ],
                                        )
                                    ),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),

                                        child: Center(child: Text(buillin1['suppilierinvoiceno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Reason']==""?"null":buillin1['Reason'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/10.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/13.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/8.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //view button
                                            InkWell(
                                              onTap: (){
                                                checkqty(buillin1.id);

                                              },
                                              child: Material(
                                                elevation: 10,
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/13.66,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: Colors.green
                                                    ),
                                                    child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                              ),
                                            ),

                                            SizedBox(width:width/136.6,),
                                            //edit button
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));
                                              },
                                              child: Material(
                                                elevation: 10,

                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/45.53,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),

                                                    ),
                                                    child: Center(child: Icon(Icons.edit,color:
                                                    Colors.black,size:width/68.3))),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),

                                  ],
                                );
                            }

                            else if (
                            buillin1['Payment mode'].toString().toLowerCase().startsWith(Paymenttype.text.toLowerCase())
                                &&Suppilercontroller.text==""&&Invoicecontroller.text==""&&Datecontroller.text==""&&Datecontroller2.text==""
                            )
                            {
                              return
                                Row(
                                  children: [
                                    SizedBox(width:width/54.15,),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child:
                                        Center(child:
                                        Text(buillin1['purchasedate'].toString(),
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                    Container(
                                        width:width/18.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),
                                            buillin1['return']==true?
                                            Text("(Return)",
                                              style:
                                              GoogleFonts.poppins(fontSize: width/97.571, color:  Colors.red),
                                            ):const SizedBox(),
                                          ],
                                        )
                                    ),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),

                                        child: Center(child: Text(buillin1['suppilierinvoiceno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Reason']==""?"null":buillin1['Reason'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/10.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/13.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/8.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //view button
                                            InkWell(
                                              onTap: (){
                                                checkqty(buillin1.id);

                                              },
                                              child: Material(
                                                elevation: 10,
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/13.66,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: Colors.green
                                                    ),
                                                    child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                              ),
                                            ),

                                            SizedBox(width:width/136.6,),
                                            //edit button
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));
                                              },
                                              child: Material(
                                                elevation: 10,

                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/45.53,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),

                                                    ),
                                                    child: Center(child: Icon(Icons.edit,color:
                                                    Colors.black,size:width/68.3))),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),

                                  ],
                                );
                            }

                            else  if ( buillin1['suppilername'].toString().toLowerCase().startsWith(Username2.toLowerCase())
                                      && buillin1['suppilierinvoiceno'].toString().toLowerCase().startsWith(Username.toLowerCase())
                                      && buillin1['Payment mode'].toString().toLowerCase().startsWith(Username.toLowerCase()))
                            {
                              return
                                Row(
                                  children: [
                                    SizedBox(width:width/54.15,),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child:
                                        Center(child:
                                        Text(buillin1['purchasedate'].toString(),
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                    Container(
                                        width:width/18.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),
                                            buillin1['return']==true?
                                            Text("(Return)",
                                              style:
                                              GoogleFonts.poppins(fontSize: width/97.571, color:  Colors.red),
                                            ):const SizedBox(),
                                          ],
                                        )
                                    ),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),

                                        child: Center(child: Text(buillin1['suppilierinvoiceno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/4.66,
                                        height:height/13.14,
                                        padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Reason']==""?"null":buillin1['Reason'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/10.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/13.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2)
                                        ),
                                        child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                    Container(
                                        width:width/8.507,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //view button
                                            InkWell(
                                              onTap: (){
                                                checkqty(buillin1.id);

                                              },
                                              child: Material(
                                                elevation: 10,
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/13.66,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        color: Colors.green
                                                    ),
                                                    child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                              ),
                                            ),

                                            SizedBox(width:width/136.6,),
                                            //edit button
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));
                                              },
                                              child: Material(
                                                elevation: 10,

                                                borderRadius: BorderRadius.circular(100),
                                                child: Container(
                                                    width:width/45.53,
                                                    height:height/21.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),

                                                    ),
                                                    child: Center(child: Icon(Icons.edit,color:
                                                    Colors.black,size:width/68.3))),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),

                                  ],
                                );
                            }

                          }

                        else if(isserach==false&&buillin1['return']==true&&mydate.isEmpty){

                         return
                           Row(
                           children: [
                             SizedBox(width:width/54.15,),

                             Container(
                                 width:width/15.66,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child:
                                 Center(child:
                                 Text(buillin1['purchasedate'].toString(),
                                   style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                   textAlign: TextAlign.center,
                                 ))),

                             Container(
                                 width:width/18.507,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),
                                     buillin1['return']==true?
                                     Text("(Return)",
                                       style:
                                       GoogleFonts.poppins(fontSize: width/97.571, color:  Colors.red),
                                     ):const SizedBox(),
                                   ],
                                 )
                             ),

                             Container(
                                 width:width/15.66,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),

                                 child: Center(child: Text(buillin1['suppilierinvoiceno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/15.66,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/4.66,
                                 height:height/13.14,
                                 padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/4.66,
                                 height:height/13.14,
                                 padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Center(child: Text(buillin1['Reason']==""?"null":buillin1['Reason'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/10.66,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/13.507,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black,width: 1.2)
                                 ),
                                 child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                             Container(
                                 width:width/8.507,
                                 height:height/13.14,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black)
                                 ),
                                 child:
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     //view button
                                     InkWell(
                                       onTap: (){
                                         checkqty(buillin1.id);

                                       },
                                       child: Material(
                                         elevation: 10,
                                         color: Colors.green,
                                         borderRadius: BorderRadius.circular(100),
                                         child: Container(
                                             width:width/13.66,
                                             height:height/21.9,
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(100),
                                                 color: Colors.green
                                             ),
                                             child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                       ),
                                     ),

                                     SizedBox(width:width/136.6,),
                                     //edit button
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));
                                       },
                                       child: Material(
                                         elevation: 10,

                                         borderRadius: BorderRadius.circular(100),
                                         child: Container(
                                             width:width/45.53,
                                             height:height/21.9,
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(100),

                                             ),
                                             child: Center(child: Icon(Icons.edit,color:
                                             Colors.black,size:width/68.3))),
                                       ),
                                     ),
                                   ],
                                 )
                             ),

                           ],
                         );
                        }
                        return
                           const SizedBox();
                      },);
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: height/65.7,),

      ],
    );
  }

  //toggle switch boolean
  bool status=true;
  bool status2=false;
  int qty=0;
  double Total=0;
  String state="";
  String invoice="";
  String invoice_date="";
  String Suppiler="";
  String SGST='';
  String CGST="";
  double TotalAmount=0;
  double purchasenbalanceAmount=0;
  String Date="";
  String Time="";
  String payemntype="";
  double finalamount=0;
  double Totalamountitem=0;

  checkqty(streamid) async {
    setState(() {
      qty=0;
      Total=0;
      finalamount= 0;
      purchasenbalanceAmount=0;
      Totalamountitem=0;
    });

    var document=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).get();
    Map<String,dynamic>?values=document.data();
    setState(() {
      invoice=values!['purchaseno'].toString();
      invoice_date=values['purchasedate'].toString();
      Suppiler=values['suppilername'].toString();
      Date=values['date'].toString();
      Time=values['time'].toString();
      payemntype=values['Payment mode 2'].toString();
      SGST=double.parse(values['SGST'].toString()).toStringAsFixed(2);
      CGST=double.parse(values['CGST'].toString()).toStringAsFixed(2);
      TotalAmount=double.parse(values['Totalamount'].toString());
      // purchasenbalanceAmount=values['balance amount'];
      state=values['state'];
    });

    // ///sold item Total Amount functions  and Balanace Item functions
    // var data=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).
    // collection(streamid).get();
    //
    // for(int i=0;i<data.docs.length;i++){
    //   //quvantity-stocks
    //   if(data.docs[i]['Qty']!=data.docs[i]['stocks']){
    //     setState((){
    //       purchasenbalanceAmount=purchasenbalanceAmount+((int.parse(data.docs[i]['Qty'].toString())-data.docs[i]['stocks'])*double.parse(data.docs[i]['Landing cost'].toString()));
    //     });
    //   }
    //
    //
    //
    // }
    //
    // ///returm item Total Amount function
    // var data2=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).
    // collection(streamid).where("return",isEqualTo:true).get();
    // for(int j=0;j<data2.docs.length;j++){
    //   print("Enter the Loop");
    //
    //   setState((){
    //     Total=Total+((data2.docs[j]['return Quvantity'])*double.parse(data2.docs[j]['Landing cost'].toString()));
    //   });
    //
    //   print("Enter the Loop-end");
    //
    // }
    //
    //
    // ///balance Item Total Ammount
    // var data3=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).
    // collection(streamid).get();
    // for(int k=0;k<data3.docs.length;k++){
    //   if(int.parse(data3.docs[k]['Qty'].toString())-((int.parse(data3.docs[k]['Qty'].toString())-data3.docs[k]['stocks']))!=0){
    //     setState((){
    //       Totalamountitem=Totalamountitem+(data3.docs[k]['stocks'])*double.parse(data3.docs[k]['Landing cost'].toString());
    //     });
    //   }
    // }
    await  showallitemapopup(streamid);

  }


  quvanotysolddunction(quvantity,stocks){
    return (quvantity-stocks);
  }

  quvanotyblancedunction(quvantity,stocks){
    return (quvantity-(quvantity-stocks));
  }

  quvanodunction(quvantity,stocks,purchase){
    return ((quvantity-(quvantity-stocks))*purchase);
  }

  quvantitybalanceduntion(int quvantity,int stocks,double purchaseprice){

    return ((quvantity-stocks)*purchaseprice).toString();
  }

  quvantitybalanceAmountduntion(int Quvantity,landingcost){
    return Quvantity*landingcost;

  }
  totalamountmultiplefunction(int stocks,double item){
    return (item*stocks).toString();
  }



  String Itemtype="";
  showdialpogbox(streamid,) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return
        StatefulBuilder(builder: (context, setState) {

          return SlideInLeft(
              animate: true,
              duration: const Duration(milliseconds: 800),
              manualTrigger: false,
              child:
              Padding(
                padding:  EdgeInsets.only(top: height/136.6,bottom:height/136.6,left: width/45.53,right: width/45.53),
                child: Scaffold(

                  body:
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),

                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [

                          SizedBox(height:height/65.7,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: width/2.4,),
                              Text("Purchase Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700),),
                              SizedBox(width: width/2.4,),
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

                            ],
                          ),

                          SizedBox(height:height/65.7,),
                          Row(
                            children: [
                              SizedBox(width: 70,),
                              Container(
                                  height:50,
                                  width:240,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00008B),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(width:100,
                                      height:30,
                                      child: Center(child: Text("Total Amount",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),)),
                                      ),
                                      Container(width:100,

                                        height:30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Text("${TotalAmount.toString()}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),)),
                                      )

                                    ],
                                  )

                              ),
                              Container(
                                  height:50,
                                  width:240,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00008B),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:
                                  Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(width:100,
                                      height:30,
                                      child: Center(child: Text("Balance Amount",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),)),
                                      ),
                                      Container(width:100,

                                        height:30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Text("${Totalamountitem.toString()}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),)),
                                      )

                                    ],
                                  )

                              ),
                            ],
                          ),

                          SizedBox(height:height/65.7,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              ///to pay suppier container
                              Container(
                                  height:200,
                                  width:520,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00008B),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height:10),
                                          Text("Paid to the\nSupplier Amount",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18

                                            ),),
                                          SizedBox(height:10),
                                          Padding(
                                            padding:  EdgeInsets.only(top:65.0,left: 15),
                                            child: Container(
                                              height:50,
                                              width:180,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(purchasenbalanceAmount.toString(),style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700

                                                )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height:10),


                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          SizedBox(height:10),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:160,
                                                height:30,
                                                child: Center(
                                                  child: Text("Date",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                              Container(
                                                width:150,
                                                height:30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(Date.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:10),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:160,
                                                height:30,
                                                child: Center(
                                                  child: Text("Time",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                              Container(
                                                width:150,
                                                height:30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(Time.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:160,
                                                height:30,
                                                child: Center(
                                                  child: Text("Payment",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                              Container(
                                                width:150,
                                                height:30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(payemntype.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:10),

                                          GestureDetector(
                                            onTap: (){
                                              ///show the another sold popup items
                                              setState(() {
                                              Itemtype="sold";
                                            });
                                              showallitemapopup(streamid,);

                                            },
                                            child: Container(
                                              height:50,
                                              width:180,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xffC70039),
                                              ),
                                              child: Center(
                                                child: Text("View Product\nSold items",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700

                                                    )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height:10),


                                        ],
                                      )
                                    ],
                                  )

                              ),

                              ///return paye container
                              Container(
                                  height:200,
                                  width:520,
                                  decoration: BoxDecoration(
                                      color: Color(0xffC70039),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height:10),
                                          Text("Total Amount 0f\nItems Returns",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18

                                            ),),
                                          SizedBox(height:10),
                                          Padding(
                                            padding:  EdgeInsets.only(top:65.0,left: 15),
                                            child: Container(
                                              height:50,
                                              width:180,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(Total.toString(),style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700

                                                )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height:10),


                                        ],
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          SizedBox(height:10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:160,
                                                height:30,
                                                child: Center(
                                                  child: Text("Date",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                              Container(

                                                width:150,
                                                height:30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text(Date.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:160,
                                                height:30,
                                                child: Center(
                                                  child: Text("Time",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                              Container(
                                                width:150,
                                                height:30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(
                                                  child: Text( Time.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18

                                                    ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:10),


                                          SizedBox(height:40),

                                          GestureDetector(
                                            onTap: (){
                                              ///show the another return popup items
                                              setState(() {
                                                Itemtype="return";
                                              });
                                              showallitemapopup(streamid,);
                                            },
                                            child: Container(
                                              height:50,
                                              width:180,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text("View Return\nProduct",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.montserrat(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700

                                                    )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height:10),


                                        ],
                                      )
                                    ],
                                  )
                              ),




                            ],
                          ),
                          SizedBox(height:height/65.7,),

                          Row(
                            children: [
                              SizedBox(width: 75,),

                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    Itemtype="Balance";
                                  });
                                  showallitemapopup(streamid,);
                                },
                                child: Container(
                                  height: 50,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child:  Text("View Balance Items",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18

                                      ),),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),

                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    Itemtype="All";
                                  });
                                  showallitemapopup(streamid,);
                                },
                                child: Container(
                                  height: 50,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Color(0xff252B48),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child:  Text("View All Items",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18

                                      ),),
                                  ),
                                ),
                              )

                            ],
                          ),






                          SizedBox(height:height/65.7),

                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },);
      },
    );
  }



  showallitemapopup(streamid) async {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return showDialog(
      context: context,
      builder: (context) {
        return SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child:
            Padding(
              padding:  EdgeInsets.only(top: height/136.6,bottom:height/136.6,left: width/45.53,right: width/45.53),
              child: Scaffold(

                body:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),

                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [

                        SizedBox(height:height/65.7,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width/2.4,),
                            Text("Purchase Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700),),
                            SizedBox(width: width/2.4,),
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

                          ],
                        ),

                        SizedBox(height:height/65.7,),

                        SizedBox(
                          height: 550,
                          child:Column(
                            children: [
                              SizedBox(height:height/65.7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("View all Items",style:TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              ),
                              SizedBox(height:height/65.7),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  CircleAvatar(
                                    radius: 8,
                                 foregroundColor: Colors.pink,
                                    backgroundColor: Colors.pink,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Return",style:TextStyle(fontWeight: FontWeight.w700)),

                                  SizedBox(width: 15,),
                                  CircleAvatar(
                                    radius: 8,
                                    foregroundColor: Colors.red,
                                    backgroundColor: Colors.red,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Sold",style:TextStyle(fontWeight: FontWeight.w700)),

                                  SizedBox(width: 15,),
                                  CircleAvatar(
                                    radius: 8,
                                    foregroundColor: Colors.green,
                                    backgroundColor: Colors.green,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Balance",style:TextStyle(fontWeight: FontWeight.w700)),
                                  SizedBox(width: 20,),
                                ],
                              ),
                              SizedBox(height:height/65.7),
                              Row(
                                children: [
                                  SizedBox(width:width/136.6,),

                                  Container(
                                    width:width/ 27.32,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Si.No",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(

                                    width: width/13.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Date\nTime",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/17.075,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Item Code",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/5.54,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Description',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/22.76,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Hsn\nCode',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/16.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Payment',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(

                                    width:width/ 45.53,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Qty",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(

                                    width:width/ 25.53,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Sold",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),


                                  Container(

                                    width:width/ 20.53,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Balance",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(

                                    width:width/ 25.53,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text("Return",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/17.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Purchase\nPrice',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    width: width/17.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Landing\nCost',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),


                                  Container(

                                    width: width/17.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Sales\nPrice',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(

                                    width: width/27.32,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child: Text('Tax',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),


                                  Container(
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    width: width/17.66,

                                    child: Center(child: Text("Total",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),

                                  Container(
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    width: width/17.66,

                                    child: Center(child: Text("Balance\nAmount",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                                  ),



                                  SizedBox(width:width/136.6,),



                                ],
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream:
                                FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData==null){
                                    return Center(child: Container(),);
                                  }
                                  if(!snapshot.hasData){
                                    return Center(child: Container(),);
                                  }

                                  return
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var purchase=snapshot.data!.docs[index];
                                        return
                                        //    int.parse(purchase['Qty'].toString()) != purchase['stocks'] ?
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              SizedBox(width:width/136.6,),

                                              Container(
                                                width: width/27.32,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text("${index+1}",style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width: width/13.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text("${purchase['date']}\n${purchase['time']}".toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(
                                                width:width /17.075,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text("${purchase['itemcode']}",style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(
                                                width: width/5.54,
                                                height:height/13.14,
                                                padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(
                                                  child: Text(purchase['Description'].toString(),
                                                    style: GoogleFonts.poppins(
                                                        textStyle: const TextStyle(
                                                            overflow:TextOverflow.ellipsis
                                                        )

                                                    ),),
                                                ),
                                              ),

                                              Container(
                                                width: width/22.76,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['Hsncode'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(
                                                width: width/16.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['Payment mode'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width: width/45.53,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),

                                                child: Center(child: Text(purchase['Qty'].toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                                              ),

                                              //sold Items
                                              Container(

                                                width:width/ 25.53,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),

                                                child: Center(child: Text(quvanotysolddunction(int.parse(purchase['Qty'].toString()),purchase['stocks']).toString(),style: GoogleFonts.poppins(color: Colors.red,fontWeight: FontWeight.bold),)),
                                              ),

                                              //balnce items
                                              Container(

                                                width: width/20.53,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),

                                                child: Center(child: Text(quvanotyblancedunction(int.parse(purchase['Qty'].toString()),purchase['stocks']).toString(),style: GoogleFonts.poppins(color: Colors.green,fontWeight: FontWeight.bold),)),
                                              ),

                                              //return items
                                              Container(

                                                width:width/ 25.53,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),

                                                child: Center(child: Text(purchase['return Quvantity'].toString(),style: GoogleFonts.poppins(color: Colors.pink,fontWeight: FontWeight.bold),)),
                                              ),

                                              Container(
                                                width: width/17.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['Purchase price'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(
                                                width: width/17.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['Landing cost'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width: width/17.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['Sales price'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width:width/ 27.32,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(purchase['tax'].toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width: width/17.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(quvantitybalanceduntion(int.parse(purchase['Qty'].toString()),purchase['stocks'],double.parse(purchase['Purchase price'].toString())).toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                              Container(

                                                width: width/17.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black,width: 1.2)
                                                ),
                                                child: Center(child: Text(quvantitybalanceAmountduntion(int.parse(purchase['Qty'].toString()),double.parse(purchase['Landing cost'].toString())).toString(),style: GoogleFonts.poppins(),)),
                                              ),

                                            ],
                                          );
                                      },);
                                },),
                            ],
                          )

                        ),

                        SizedBox(height:height/65.7),

                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }


}
