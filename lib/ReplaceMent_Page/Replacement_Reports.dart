import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Replacement_Reports extends StatefulWidget {


  @override
  State<Replacement_Reports> createState() => _Replacement_ReportsState();
}

class _Replacement_ReportsState extends State<Replacement_Reports> with SingleTickerProviderStateMixin {

  TabController? _tabController;
  int currentTabIndex=0;

  TextEditingController Datecontroller = TextEditingController();
  TextEditingController Datecontroller2 = TextEditingController();
  TextEditingController Suppilercontroller = TextEditingController();
  TextEditingController Itemanamecontroller = TextEditingController();
  final DateFormat formatter = DateFormat('d/M/yyyy');
  int year1 = 0;
  int day1 = 0;
  int month1 = 0;
  int year2 = 0;
  int day2 = 0;
  int month2 = 0;
  List<String> mydate = [];

  List<String> Suppilier = [];
  List<String> Itemname = [];

  bool isserach = false;
  String Username2 = "";
  String Username = "";
  String Status1 = '';
  String Status2 = '';
  String Status3 = '';
  
  additemduntion()async{
      setState(() {
        Suppilier.clear();

      });
    var document = await FirebaseFirestore.instance.collection("Replacement").orderBy("timestamp").get();
    for (int i = 0; i < document.docs.length; i++) {
      setState(() {
        Suppilier.add(document.docs[i]['suppliername']);
      });
    }

    print(Suppilier);
  }


  @override
  void initState() {
    _tabController=TabController(length: 3, vsync: this);
    additemduntion();
    // TODO: implement initState
    super.initState();
  }
  String status = "Please Select";
  List<String> statuslist = ["Please Select","Replacement","Received"];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [

        SizedBox(
          height: height / 83.8,
        ),

        Row(
          children: [
            SizedBox(
              width: width / 43.8,
            ),
            Text(
              "Date",
              textAlign: TextAlign.start,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 30.8,
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
                  hintText: "mm/dd/yyyy",
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
                    DateFormat('dd / M / yyyy').format(pickedDate);
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
                  hintText: "mm/dd/yyyy",
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
                    String formattedDate =
                    DateFormat('d/M/yyyy').format(pickedDate);
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
                      return difference;
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
                
                    }
                  } else {}
                },
              ),
            ),

            SizedBox(
              width: width / 136.6,
            ),

            Text(
              "Supplier Name",
              textAlign: TextAlign.start,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),

            Container(
              height: height / 21.9,
              width: width / 6.106, // width: width / 3.415,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: LayoutBuilder(
                builder: (BuildContext, BoxConstraints) => Autocomplete<String>(
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextFormField(
                      onChanged: (_) {
                        setState(() {
                          Suppilercontroller = textEditingController;
                        });
                      },
                      style: GoogleFonts.openSans(
                          fontSize: width / 91.06, fontWeight: FontWeight.w500),
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
                  initialValue: const TextEditingValue(
                      selection: TextSelection(
                        isDirectional: true,
                        baseOffset: 5,
                        extentOffset: 1,
                      )),
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

                    return Suppilier.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    setState(() {
                      isserach = true;
                      Suppilercontroller.text = selection;
                    });
                    debugPrint('You just selected $selection');
                  },
                  displayStringForOption: (Value) {
                    return Value;
                  },
                ),
              ),
            ),
            SizedBox(
              width: width / 136.6,
            ),

            Text(
              "Status",
              textAlign: TextAlign.start,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),

            Container(
              height: height / 21.9,
              width: width / 6.106, // width: width / 3.415,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child:  DropdownButton2<String>(
                value: status,
                isExpanded: true,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: width / 105.07),
                underline: Container(
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    status = value!;
                    isserach = true;
                  });
                },
                items: statuslist.map<
                    DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(
              width: width / 136.6,
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
                  Suppilercontroller.clear();
                  Itemanamecontroller.clear();
                  Status1 = "";
                  Status2 = "";
                  Status3 = "";
                  isserach = false;
                  Username = '';
                  Username2 = '';
                  status="Please Select";
                });
              },
              child: Container(
                height: height / 16.425,
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
          ],
        ),

        SizedBox(
          height: height / 83.8,
        ),



        Padding(
          padding:  EdgeInsets.only(left:30,right:30),
          child: SizedBox(
            height: height / 1.194,
            width: double.infinity,
            child:  Container(
              height: height / 1.194,
              width: width / 1.050,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 65.7,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 34.15,
                        ),

                        Container(
                            width: width / 20.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Si No",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 15.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Date",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 15.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Time",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 8.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Bill No",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 8.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Supplier ID",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 8.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Supplier Name",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        Container(
                            width: width / 6.66,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Sales Man",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),



                        Container(
                            width: width / 10.507,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Status",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),
                        Container(
                            width: width / 10.507,
                            height: height / 13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Text(
                                  "Actions",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5801e8)),
                                ))),

                        //SizedBox(width:width/27.32,),
                      ],
                    ),

                    StreamBuilder<QuerySnapshot>(
                      stream:  FirebaseFirestore.instance.collection("Replacement").
                      orderBy("timestamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == null) {
                          return Center(child: Container());
                        }
                        if (!snapshot.hasData) {
                          return Center(child: Container());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var buillin1 = snapshot.data!.docs[index];

                            if(buillin1['save']==true){
                              if(isserach == true){

                                if (mydate.isNotEmpty && Suppilercontroller.text==""&&status=="Please Select") {
                                  if (mydate.contains(buillin1['date'].toString())) {

                                    return     Row(
                                      children: [
                                        SizedBox(
                                          width: width / 34.15,
                                        ),


                                        Container(
                                            width: width / 20.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${index+1}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ))),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                              child: Text(
                                                buillin1['date'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['time'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['billno'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['supplierId'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['suppliername'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))


                                        ),

                                        Container(
                                            width: width / 6.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['salesman'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['status'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        GestureDetector(
                                          onTap:() async {
                                            //updateOrderPopUp(buillin1['Bill No'].toString(),buillin1.id);

                                            var docu =  await FirebaseFirestore.instance
                                                .collection("Replacement")
                                                .doc(buillin1.id)
                                                .collection(buillin1.id).orderBy("timestamp").get();
                                            for(int i=0;i<docu.docs.length;i++){
                                              setState(() {
                                                valuescon[i]=docu.docs[i]["remarks"];
                                              });
                                            }
                                            showdialpogbox(buillin1.id);
                                          },
                                          child: Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Material(
                                                    borderRadius: BorderRadius.circular(100),
                                                    elevation: 10,
                                                    color: Color(0xff00A99D),
                                                    child: Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                          color: Color(0xff00A99D)),
                                                      child: Center(
                                                        child:
                                                        Text(
                                                          "View",
                                                          style: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.w600,
                                                              color:  Colors.white),
                                                        ),
                                                      ),
                                                    ),

                                                  ),

                                                ],

                                              )),
                                        ),


                                      ],
                                    );

                                  }
                                }

                                 if(buillin1['suppliername'].toString().toLowerCase().startsWith(Suppilercontroller.text.toLowerCase())&&mydate.isEmpty && status=="Please Select"){
                                  return
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 34.15,
                                        ),


                                        Container(
                                            width: width / 20.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${index+1}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ))),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                              child: Text(
                                                buillin1['date'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['time'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['billno'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['supplierId'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['suppliername'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))


                                        ),

                                        Container(
                                            width: width / 6.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['salesman'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['status'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        GestureDetector(
                                          onTap:() async {
                                            //updateOrderPopUp(buillin1['Bill No'].toString(),buillin1.id);

                                            var docu =  await FirebaseFirestore.instance
                                                .collection("Replacement")
                                                .doc(buillin1.id)
                                                .collection(buillin1.id).orderBy("timestamp").get();
                                            for(int i=0;i<docu.docs.length;i++){
                                              setState(() {
                                                valuescon[i]=docu.docs[i]["remarks"];
                                              });
                                            }
                                            showdialpogbox(buillin1.id);
                                          },
                                          child: Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Material(
                                                    borderRadius: BorderRadius.circular(100),
                                                    elevation: 10,
                                                    color: Color(0xff00A99D),
                                                    child: Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                          color: Color(0xff00A99D)),
                                                      child: Center(
                                                        child:
                                                        Text(
                                                          "View",
                                                          style: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.w600,
                                                              color:  Colors.white),
                                                        ),
                                                      ),
                                                    ),

                                                  ),

                                                ],

                                              )),
                                        ),


                                      ],
                                    );
                                }

                                 if(buillin1['status'].toString() == status &&mydate.isEmpty && Suppilercontroller.text==""){
                                  return
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 34.15,
                                        ),


                                        Container(
                                            width: width / 20.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${index+1}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ))),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                              child: Text(
                                                buillin1['date'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['time'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  buillin1['billno'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['supplierId'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))),

                                        Container(
                                            width: width / 8.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child:
                                            Center(
                                                child: Text(
                                                  buillin1['suppliername'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.w600),
                                                ))


                                        ),

                                        Container(
                                            width: width / 6.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['salesman'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black, width: 1.2)),
                                            child: //Itemname
                                            Center(
                                              child: Text(
                                                buillin1['status'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )),

                                        GestureDetector(
                                          onTap:() async {
                                            //updateOrderPopUp(buillin1['Bill No'].toString(),buillin1.id);

                                            var docu =  await FirebaseFirestore.instance
                                                .collection("Replacement")
                                                .doc(buillin1.id)
                                                .collection(buillin1.id).orderBy("timestamp").get();
                                            for(int i=0;i<docu.docs.length;i++){
                                              setState(() {
                                                valuescon[i]=docu.docs[i]["remarks"];
                                              });
                                            }
                                            showdialpogbox(buillin1.id);
                                          },
                                          child: Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Material(
                                                    borderRadius: BorderRadius.circular(100),
                                                    elevation: 10,
                                                    color: Color(0xff00A99D),
                                                    child: Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                          color: Color(0xff00A99D)),
                                                      child: Center(
                                                        child:
                                                        Text(
                                                          "View",
                                                          style: GoogleFonts.openSans(
                                                              fontWeight: FontWeight.w600,
                                                              color:  Colors.white),
                                                        ),
                                                      ),
                                                    ),

                                                  ),

                                                ],

                                              )),
                                        ),


                                      ],
                                    );
                                }

                              }

                               if (isserach == false&&status=="Please Select"&&Suppilercontroller.text==""&&mydate.isEmpty) {
                                return
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width / 34.15,
                                      ),


                                      Container(
                                          width: width / 20.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: Center(
                                              child: Text(
                                                "${index+1}",
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.center,
                                              ))),

                                      Container(
                                          width: width / 15.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: Center(
                                            child: Text(
                                              buillin1['date'].toString(),
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),

                                      Container(
                                          width: width / 15.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: Center(
                                              child: Text(
                                                buillin1['time'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ))),

                                      Container(
                                          width: width / 8.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: Center(
                                              child: Text(
                                                buillin1['billno'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ))),

                                      Container(
                                          width: width / 8.66,
                                          height: height / 13.14,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width / 683,
                                              vertical: height / 328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child:
                                          Center(
                                              child: Text(
                                                buillin1['supplierId'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ))),

                                      Container(
                                          width: width / 8.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child:
                                          Center(
                                              child: Text(
                                                buillin1['suppliername'].toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600),
                                              ))


                                      ),

                                      Container(
                                          width: width / 6.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: //Itemname
                                          Center(
                                            child: Text(
                                              buillin1['salesman'].toString(),
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),

                                      Container(
                                          width: width / 10.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2)),
                                          child: //Itemname
                                          Center(
                                            child: Text(
                                              buillin1['status'].toString(),
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )),

                                      GestureDetector(
                                        onTap:() async {
                                          //updateOrderPopUp(buillin1['Bill No'].toString(),buillin1.id);

                                          var docu =  await FirebaseFirestore.instance
                                              .collection("Replacement")
                                              .doc(buillin1.id)
                                              .collection(buillin1.id).orderBy("timestamp").get();
                                          for(int i=0;i<docu.docs.length;i++){
                                            setState(() {
                                              valuescon[i]=docu.docs[i]["remarks"];
                                            });
                                          }
                                          showdialpogbox(buillin1.id);
                                        },
                                        child: Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Material(
                                                  borderRadius: BorderRadius.circular(100),
                                                  elevation: 10,
                                                  color: Color(0xff00A99D),
                                                  child: Container(
                                                    width: width / 13.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        color: Color(0xff00A99D)),
                                                    child: Center(
                                                      child:
                                                      Text(
                                                        "View",
                                                        style: GoogleFonts.openSans(
                                                            fontWeight: FontWeight.w600,
                                                            color:  Colors.white),
                                                      ),
                                                    ),
                                                  ),

                                                ),

                                              ],

                                            )),
                                      ),


                                    ],
                                  );
                              }
                            }
                            return const SizedBox();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        /*Container(
          height: height / 1.194,
          width: width / 1.050,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height / 65.7,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 34.15,
                    ),

                    Container(
                        width: width / 15.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Si No",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 15.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Date",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 15.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Bill No",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 6.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Customer Name",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 6.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Customer Phone",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 6.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Supplier Name",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 6.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Item Name",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    Container(
                        width: width / 10.507,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                              "Item Hsn Code",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff5801e8)),
                            ))),

                    //SizedBox(width:width/27.32,),
                  ],
                ),

                StreamBuilder<QuerySnapshot>(
                  stream:  FirebaseFirestore.instance.collection("Replacement").orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == null) {
                      return Center(child: Container());
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Container());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var buillin1 = snapshot.data!.docs[index];

                      if(isserach == true){

                        if (mydate.isNotEmpty && Suppilercontroller.text==""&&Itemanamecontroller.text=="") {

                          if (mydate.contains(buillin1['Date'].toString())) {

                            return  Row(
                              children: [
                                SizedBox(
                                  width: width / 34.15,
                                ),


                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          "${index+1}",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                      child: Text(
                                        buillin1['Date'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Bill No'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Customername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Customerphone'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Suppliername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))


                                ),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['Itemname'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 10.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['itemhsncode'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                /*Container(
                                    width: width / 6.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //view button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100),
                                                    color: Colors.green),
                                                child: Center(
                                                    child: Text(
                                                      "View",
                                                      style: GoogleFonts.openSans(
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ))),
                                          ),
                                        ),

                                        SizedBox(
                                          width: width / 136.6,
                                        ),
                                        //edit button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 45.53,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: Center(
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black,
                                                        size: width / 68.3))),
                                          ),
                                        ),
                                      ],
                                    )),*/
                              ],
                            );

                          }
                        }

                         else if(mydate.isEmpty &&Suppilercontroller.text!=""&&Itemanamecontroller.text==""){
                          return
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 34.15,
                                ),


                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          "${index+1}",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                      child: Text(
                                        buillin1['Date'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Bill No'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Customername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Customerphone'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Suppliername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))


                                ),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['Itemname'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 10.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['itemhsncode'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                /*Container(
                                    width: width / 6.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //view button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100),
                                                    color: Colors.green),
                                                child: Center(
                                                    child: Text(
                                                      "View",
                                                      style: GoogleFonts.openSans(
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ))),
                                          ),
                                        ),

                                        SizedBox(
                                          width: width / 136.6,
                                        ),
                                        //edit button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 45.53,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: Center(
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black,
                                                        size: width / 68.3))),
                                          ),
                                        ),
                                      ],
                                    )),*/
                              ],
                            );
                        }

                        else if(mydate.isEmpty &&Suppilercontroller.text==""&&Itemanamecontroller.text!=""){
                          return
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 34.15,
                                ),


                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          "${index+1}",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                      child: Text(
                                        buillin1['Date'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Bill No'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Customername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Customerphone'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Suppliername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))


                                ),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['Itemname'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 10.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['itemhsncode'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                /*Container(
                                    width: width / 6.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //view button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100),
                                                    color: Colors.green),
                                                child: Center(
                                                    child: Text(
                                                      "View",
                                                      style: GoogleFonts.openSans(
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ))),
                                          ),
                                        ),

                                        SizedBox(
                                          width: width / 136.6,
                                        ),
                                        //edit button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 45.53,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: Center(
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black,
                                                        size: width / 68.3))),
                                          ),
                                        ),
                                      ],
                                    )),*/
                              ],
                            );
                        }

                       }

                         else if (isserach == false && mydate.isEmpty) {
                          return
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 34.15,
                                ),


                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          "${index+1}",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                      child: Text(
                                        buillin1['Date'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 15.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Bill No'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: Center(
                                        child: Text(
                                          buillin1['Customername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Customerphone'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child:
                                    Center(
                                        child: Text(
                                          buillin1['Suppliername'].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600),
                                        ))


                                ),

                                Container(
                                    width: width / 6.66,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['Itemname'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                Container(
                                    width: width / 10.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)),
                                    child: //Itemname
                                    Center(
                                      child: Text(
                                        buillin1['itemhsncode'].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),

                                /*Container(
                                    width: width / 6.507,
                                    height: height / 13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //view button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        100),
                                                    color: Colors.green),
                                                child: Center(
                                                    child: Text(
                                                      "View",
                                                      style: GoogleFonts.openSans(
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white),
                                                    ))),
                                          ),
                                        ),

                                        SizedBox(
                                          width: width / 136.6,
                                        ),
                                        //edit button
                                        InkWell(
                                          onTap: () {

                                          },
                                          child: Material(
                                            elevation: 10,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            child: Container(
                                                width: width / 45.53,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                ),
                                                child: Center(
                                                    child: Icon(Icons.edit,
                                                        color: Colors.black,
                                                        size: width / 68.3))),
                                          ),
                                        ),
                                      ],
                                    )),*/
                              ],
                            );
                        }
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )*/
      ],
    );
  }

  List<String> valuescon = List.generate(10, (index) => "");

  ///status update popup
  String orderStatusController= "Select Status";

  updateOrderPopUp(order,docid){
    Size size = MediaQuery.of(context).size;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
            builder: (context,setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.07,
                        decoration:const  BoxDecoration(
                            color: Color(0xff00A99D),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                 "Update Order Status",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                   "Bill No : ",
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                     order,
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                    "Status",
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          offset: Offset(2, 3),
                                        )
                                      ],
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      value: orderStatusController,
                                      icon:
                                      const Icon(Icons.keyboard_arrow_down),
                                      items: ["Select Status", "Ordered", "Delivered","Canceled"]
                                          .map((items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          orderStatusController = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context,false);
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Center(
                                          child: Text(
                                           "Cancel",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      updatecollectiondata(docid);
                                      Navigator.pop(context,true);
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xff00A99D),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Center(
                                          child: Text(
                                            "Apply",
                                            style: GoogleFonts.openSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }
  showdialpogbox(streamid) {
    setState(() {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context)  {
        bool testBool = true;
        int count =0;

        List<TextEditingController> _controller = List.generate(10, (index) => TextEditingController());



        return StatefulBuilder(
          builder: (context, setState) {
            for(int i=0;i<valuescon.length;i++){
              setState(() {
                _controller[i].text= valuescon[i];
              });
            }
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 136.6,
                      bottom: height / 136.6,
                      left: width / 45.53,
                      right: width / 45.53),
                  child: Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width / 2.4,
                                ),
                                Text(
                                  "Item Details",
                                  style: GoogleFonts.openSans(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width / 2.4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      height: height / 26.28,
                                      width: width / 54.64,
                                      color: Colors.red,
                                      child: const Center(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 136.6,
                                ),
                                Container(
                                  width: width / 27.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Si.No",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),

                                Container(
                                  width: width / 12.075,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Item Code",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 3.5,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Item Name',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),

                                Container(
                                  width: width / 3.5,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Problem',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: (width / 10.075)/2,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Qty",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: (width / 10.075)/2,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Status",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 6.5,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Remarks",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: height / 1.56,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Replacement")
                                    .doc(streamid)
                                    .collection(streamid).orderBy("timestamp")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData == null) {
                                    return Center(
                                      child: Container(),
                                    );
                                  }
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Container(),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var purchase = snapshot.data!.docs[index];
                                      return   Row(
                                        children: [
                                          SizedBox(
                                            width: width / 136.6,
                                          ),
                                          Container(
                                            width: width / 27.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  (index+1).toString(),
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black),
                                                )),
                                          ),

                                          Container(
                                            width: width / 12.075,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  purchase["itemid"],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black),
                                                )),
                                          ),
                                          Container(
                                            width: width / 3.5,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  purchase["itemname"],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black),
                                                )),
                                          ),

                                          Container(
                                            width: width / 3.5,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  purchase["problem"],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black),
                                                )),
                                          ),
                                          Container(
                                            width: (width / 10.075)/2,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                                  purchase["Qty"],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Container(
                                            width: (width / 10.075)/2,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: Checkbox(
                                                  value: purchase["recived"],
                                                  onChanged: (val){
                                                    FirebaseFirestore.instance.collection("Replacement").doc(streamid).collection(streamid).doc(purchase.id).update({
                                                      "recived":val
                                                    });
                                                  },
                                                )


                                            ),
                                          ),
                                          Container(
                                            width: width / 6.5,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black, width: 1.2),
                                            ),
                                            child: Center(
                                                child: TextField(

                                                  controller:_controller[index],
                                                  decoration: InputDecoration(

                                                    border:  InputBorder.none
                                                  ),
                                                )


                                            ),
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                           Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width / 50.32,
                                ),

                                Column(
                                  children: [
                                    // showallitemapopup(streamid)
                                    GestureDetector(
                                      onTap: () async {

                                        print(_controller[0].text);
                                        print(_controller[1].text);
                                        print(_controller[2].text);
                                        var docu = await FirebaseFirestore.instance.collection(
                                            "Replacement").doc(streamid)
                                            .collection(streamid).orderBy("timestamp").get();
                                        for(int i=0;i<docu.docs.length;i++) {
                                          print("++++++++++++++");
                                          print(_controller[0].text);
                                          print("++++++++++++++");
                                          print(_controller[i].text);
                                          print(i);
                                          FirebaseFirestore.instance.collection(
                                              "Replacement").doc(streamid)
                                              .collection(streamid).doc(docu.docs[i].id)
                                              .update({
                                            "remarks": _controller[i].text,
                                          });
                                          print(docu.docs[i]["recived"]);
                                          if(docu.docs[i]["recived"]==false){
                                            setState((){
                                              count = count+1;
                                            });
                                          }
                                        }
                                        print(count);
                                        if(count==0){
                                          FirebaseFirestore.instance.collection("Replacement").doc(streamid).update({
                                            "status":"Received"
                                          });
                                        }

                                        Navigator.of(context).pop();



                                      },
                                      child: Container(
                                        height: height / 15.9,
                                        width: width / 6.7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            color: Color(0xff128c7e)),
                                        child: Center(
                                            child: Text("Update Bill",
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: width / 91.06))),
                                      ),
                                    ),
                                    SizedBox(height: height / 65.7),


                                  ],
                                ),
                                SizedBox(width: width / 170.75),


                                //balance

                              ],
                            ),
                            SizedBox(height: height / 25.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
  ///update Function
 updatecollectiondata(docid){
    FirebaseFirestore.instance.collection("Replacement").doc(docid).update({
      "Status":orderStatusController,
    });
}
}
