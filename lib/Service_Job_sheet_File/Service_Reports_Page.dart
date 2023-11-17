import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shabika_billing/Service_Job_sheet_File/Serviceeditpage.dart';

import '../LandingPage/LandingPage.dart';
import 'Service_Entry_Page.dart';
import 'Service_Update_Status_Page.dart';


final List<String> Type = <String>[
  "Not Delivery",
  "Delivery"
];
class Service_Reports_Page extends StatefulWidget {
  const Service_Reports_Page({Key? key}) : super(key: key);

  @override
  State<Service_Reports_Page> createState() => _Service_Reports_PageState();
}

class _Service_Reports_PageState extends State<Service_Reports_Page> {
  String Filter = "All";
  bool all=true;

  List<bool> Selected = List.generate(100, (index) => false);

  String WantedType=Type.first;

  TextEditingController Customermobile=TextEditingController();
  String search='';
  TextEditingController searchfield=TextEditingController();
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
          mydate.add(formatter.format(items[i]).toString());
        });

      }
    });
    print(mydate);


    print("+++++++++++++000000000+++++++++++");
    setState(() {

    });

  }

  @override
  void initState() {
    //datefun();
    statusaddfunction();
    gettotal();
    // TODO: implement initState
    super.initState();
  }
  double totalprofit =0;
  gettotal() async {
    setState(() {
      totalprofit=0;
    });
    var docu = await FirebaseFirestore.instance.collection("Service Bills").get();
    for(int i=0;i<docu.docs.length;i++) {
      if (mydate.isNotEmpty) {
        if (mydate.contains(docu.docs[i]["date"])){
          setState(() {
            totalprofit= totalprofit + double.parse(docu.docs[i]["itemtotal"].toString());
          });
        }
      }
      else{
        setState(() {
          totalprofit= totalprofit + double.parse(docu.docs[i]["itemtotal"].toString());
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        //title and back button

        //line image


        //Filter
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 82.125, horizontal: width / 170.75),
          child: Container(
            height: height / 6.57,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: height/43.8),
            decoration: BoxDecoration(
                color: Color(0xff00A99D), borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding:  EdgeInsets.only(left: width / 50.504,),
              child: Column(
                children: [



                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      SizedBox(
                        width: width / 200.8,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:5),
                          Text(
                            "Date",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                                fontSize: width / 78.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height:3),
                          Row(
                            children: [
                              Container(
                                height: height / 16.4,
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

                                          mydate.add(formatter.format(items[i]).toString());
                                        });
                                        gettotal();
                                        print(mydate);
                                        print("+++++++++++++++++++++++++++++++++++++++kkkk");

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
                                height: height / 16.4,
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

                                          mydate.add(formatter.format(items[i]).toString());
                                        });
                                        gettotal();
                                        print(mydate);
                                        print("+++++++++++++++++++++++++++++++++++++++kkkk");

                                      }
                                    } else {}
                                  },
                                ),
                              ),
                            ],
                          ),




                        ],
                      ),
                      //textfield-1 fromdate
                      SizedBox(
                        width: width / 136.6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height:5),
                          Text("Search by Customer Name/Phone Bill No :",style: GoogleFonts.openSans(
                              fontSize: width / 78.3,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                          SizedBox(height:3),

                          Container(
                            width: width / 3.504,
                            height: height / 16.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: TextField(
                              onChanged: (val){
                                setState(() {
                                  search=val;
                                });

                              },
                              controller: searchfield,
                              style: GoogleFonts.openSans(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                border: InputBorder.none,
                              ),
                            ),
                          ),



                        ],
                      ),
                      SizedBox(
                        width: width / 136.6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height:5),
                          Text("Search by Status :",style: GoogleFonts.openSans(
                              fontSize: width / 78.3,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                          SizedBox(height:3),

                          Container(
                            width: width / 5.504,
                            height: height / 16.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
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



                        ],
                      ),
                      SizedBox(
                        width: width / 136.6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:5),
                          Text(
                            "Profit",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                                fontSize: width / 78.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height:3),
                          Container(
                            height: height / 16.4,
                            width: width / 9.106,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                totalprofit.toString(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.openSans(
                                    fontSize: width / 78.3,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),




                        ],
                      ),
                      SizedBox(
                        width: width / 136.6,
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            Datecontroller.clear();
                            Datecontroller2.clear();
                            searchfield.clear();
                            search="";
                            mydate.clear();
                          });
                          gettotal();
                        },
                        child: Container(
                          height: height / 16.4,
                          width: width / 9.106,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child:  Center(child: Text("Clear",
                            style: GoogleFonts.openSans(
                                fontSize: width / 78.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 170.75),
          child: Container(
            height: height/1.194,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),

            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width / 170.75),
                child: Column(
                  children: [
                    SizedBox(height:height/65.7,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                            width:width/16.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Date\nTime",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/20.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Bill No",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Alternative\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nName",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Cost",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Profit",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Delivery Date\nTime",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Payment",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/10.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Status",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/5.76,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Actions",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        //SizedBox(width:width/27.32,),

                      ],
                    ),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Service Bills").
                      orderBy("timestamp",descending: true).snapshots(),
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
                            if(mydate.isNotEmpty&& search!="" && statustype=="Please Select"){
                              if(mydate.contains(buillin1["date"]))
                                {

                                    if(buillin1['cusmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                        buillin1['cusalmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                        buillin1['cusname'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                        buillin1['billno'].toString().toLowerCase().startsWith(search.toLowerCase())
                                    ){
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                              width:width/16.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text("${buillin1["date"]}\n${buillin1["time"]}",
                                                textAlign: TextAlign.center,

                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          Container(
                                              width:width/20.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          Container(
                                              width:width/9.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["cusmob"],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          Container(
                                              width:width/9.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["cusalmob"],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          Container(
                                              width:width/9.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["cusname"],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          Container(
                                              width:width/13.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["totalcost"].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                          Container(
                                              width:width/13.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text((double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),


                                          Container(
                                              width:width/13.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text("${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                          Container(
                                              width:width/15.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),

                                          Container(
                                              width:width/10.66,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(child: Text("${buillin1["status"]}",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                          GestureDetector(
                                            onTap:(){
                                              showpaymenthistroypopup(buillin1.id,buillin1["totalcost"],buillin1["discount"],buillin1["pending"],buillin1["balance"]);
                                            },
                                            child: Container(
                                                width:width/15.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Center(child: Text("View\nPayment",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              showprofitpopup(buillin1.id,buillin1["totalcost"],buillin1["itemtotal"],(double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString());
                                            },
                                            child: Container(
                                                width:width/15.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Center(child: Text("View\nProfit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context)=>Serviceeditpage(buillin1.id))
                                              );
                                            },
                                            child: Container(
                                                width:width/21.66,
                                                height:height/13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                          ),

                                          //SizedBox(width:width/27.32,),

                                        ],
                                      );
                                    }


                                }
                              else {
                                return SizedBox();
                              }
                            }
                            else if(mydate.isNotEmpty&& search==""&&statustype=="Please Select"){
                              if(mydate.contains(buillin1["date"]))
                              {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                          width:width/16.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("${buillin1["date"]}\n${buillin1["time"]}",
                                            textAlign: TextAlign.center,

                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      Container(
                                          width:width/20.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      Container(
                                          width:width/9.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["cusmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      Container(
                                          width:width/9.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["cusalmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      Container(
                                          width:width/9.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["cusname"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      Container(
                                          width:width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["totalcost"].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                      Container(
                                          width:width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text((double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),


                                      Container(
                                          width:width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                      Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),

                                      Container(
                                          width:width/10.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("${buillin1["status"]}",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                      GestureDetector(
                                        onTap:(){
                                          showpaymenthistroypopup(buillin1.id,buillin1["totalcost"],buillin1["discount"],buillin1["pending"],buillin1["balance"]);
                                        },
                                        child: Container(
                                            width:width/15.66,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
                                            ),
                                            child: Center(child: Text("View\nPayment",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                      ),
                                      GestureDetector(
                                        onTap:(){
                                          showprofitpopup(buillin1.id,buillin1["totalcost"],buillin1["itemtotal"],(double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString());
                                        },
                                        child: Container(
                                            width:width/15.66,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
                                            ),
                                            child: Center(child: Text("View\nProfit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                      ),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>Serviceeditpage(buillin1.id))
                                          );
                                        },
                                        child: Container(
                                            width:width/21.66,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
                                            ),
                                            child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                      ),

                                      //SizedBox(width:width/27.32,),

                                    ],
                                  );
                              }
                              else {
                                return SizedBox();
                              }
                            }
                            else if(mydate.isEmpty&& search!=""&&statustype=="Please Select"){
                              if(buillin1['cusmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                  buillin1['cusalmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                  buillin1['cusname'].toString().toLowerCase().startsWith(search.toLowerCase())||
                                  buillin1['billno'].toString().toLowerCase().startsWith(search.toLowerCase())
                              ){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                        width:width/16.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["date"]}\n${buillin1["time"]}",
                                          textAlign: TextAlign.center,

                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/20.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusmob"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusalmob"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusname"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["totalcost"].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text((double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),


                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),

                                    Container(
                                        width:width/10.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["status"]}",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    GestureDetector(
                                      onTap:(){
                                        showpaymenthistroypopup(buillin1.id,buillin1["totalcost"],buillin1["discount"],buillin1["pending"],buillin1["balance"]);
                                      },
                                      child: Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("View\nPayment",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        showprofitpopup(buillin1.id,buillin1["totalcost"],buillin1["itemtotal"],(double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString());
                                      },
                                      child: Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("View\nProfit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>Serviceeditpage(buillin1.id))
                                        );
                                      },
                                      child: Container(
                                          width:width/21.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),

                                    //SizedBox(width:width/27.32,),

                                  ],
                                );
                              }
                              else{
                                return SizedBox();
                              }
                            }
                            else if(mydate.isEmpty&& search==""&&statustype!="Please Select"){
                              if(buillin1['status'] == statustype)
                              {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                        width:width/16.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["date"]}\n${buillin1["time"]}",
                                          textAlign: TextAlign.center,

                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/20.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusmob"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusalmob"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/9.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["cusname"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["totalcost"].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text((double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),


                                    Container(
                                        width:width/13.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                    Container(
                                        width:width/15.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),

                                    Container(
                                        width:width/10.66,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black)
                                        ),
                                        child: Center(child: Text("${buillin1["status"]}",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                    GestureDetector(
                                      onTap:(){
                                        showpaymenthistroypopup(buillin1.id,buillin1["totalcost"],buillin1["discount"],buillin1["pending"],buillin1["balance"]);
                                      },
                                      child: Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("View\nPayment",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        showprofitpopup(buillin1.id,buillin1["totalcost"],buillin1["itemtotal"],(double.parse(buillin1["totalcost"].toString())-double.parse(buillin1["itemtotal"].toString())).toString());
                                      },
                                      child: Container(
                                          width:width/15.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("View\nProfit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=>Serviceeditpage(buillin1.id))
                                        );
                                      },
                                      child: Container(
                                          width:width/21.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                    ),

                                    //SizedBox(width:width/27.32,),

                                  ],
                                );
                              }
                              else{
                                return SizedBox();
                              }
                            }

                            else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                      width: width / 16.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["date"]}\n${buillin1["time"]}",
                                        textAlign: TextAlign.center,

                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 20.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["billno"],
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 9.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 9.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusalmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 9.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusname"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 13.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["totalcost"].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 13.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text((double.parse(
                                          buillin1["totalcost"].toString()) -
                                          double.parse(
                                              buillin1["itemtotal"].toString()))
                                          .toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),


                                  Container(
                                      width: width / 13.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["balance"] != 0
                                            ? "UnPaid"
                                            : "Paid",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: buillin1["balance"] != 0
                                                ? Colors.red
                                                : Colors.green),))),

                                  Container(
                                      width: width / 10.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["status"]}",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),))),

                                  GestureDetector(
                                    onTap: () {
                                      showpaymenthistroypopup(
                                          buillin1.id, buillin1["totalcost"],
                                          buillin1["discount"],
                                          buillin1["pending"],
                                          buillin1["balance"]);
                                    },
                                    child: Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          "View\nPayment",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              color:  Colors.green),))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showprofitpopup(
                                          buillin1.id, buillin1["totalcost"],
                                          buillin1["itemtotal"], (double.parse(
                                          buillin1["totalcost"].toString()) -
                                          double.parse(
                                              buillin1["itemtotal"].toString()))
                                          .toString());
                                    },
                                    child: Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          "View\nProfit",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(
                                                  0xff5801e8)),))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Serviceeditpage(buillin1.id))
                                      );
                                    },
                                    child: Container(
                                        width: width / 21.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text("Edit",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              color:  Colors.red),))),
                                  ),

                                  //SizedBox(width:width/27.32,),

                                ],
                              );
                            }

                          },);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  showpaymenthistroypopup(streamid,cost,discount,total,pendingtotal) {
    setState(() {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        bool testBool = true;
        return StatefulBuilder(
          builder: (context, setState) {

            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 110.6,
                      bottom: height / 110.6,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 8.4,
                                ),
                                Text(
                                  "Payment History Details",
                                  style: GoogleFonts.openSans(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width / 40.4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
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
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                        "Cost: ",
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
                                        child: Center(
                                          child: Text(cost.toString(),style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        child: Center(
                                          child: Text(discount.toString(),style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        "Total Cost: ",
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
                                        child: Center(
                                          child: Text(total.toString(),style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),


                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              children: [
                                SizedBox(width: width / 136.6),
                                Container(
                                  width: width / 13.32,
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
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Date",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Time',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Type',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Payment Mode',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Amount Paid',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Balance Total',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),

                                SizedBox(
                                  width: width / 136.6,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 1.46,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Service Bills")
                                    .doc(streamid)
                                    .collection("Payment Histroy").orderBy("timestamp",/*descending: true*/)
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
                                      return Row(
                                        children: [
                                          SizedBox(width: width / 136.6),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${purchase['date']}"
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child:
                                            //${purchase['credit date']}
                                            Center(
                                              child: Text(
                                                "${purchase['time']}",
                                                style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                              // purchase['credit days'].toString()

                                                child: Text(
                                                  purchase['type']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold,
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['payment mode']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['Amount'].toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(purchase['balance'].toString(),
                                                  style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: height / 21.9,
                                    width: width / 6.53,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: const Color(0xff25d366)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text("Pending Total : ${pendingtotal.toStringAsFixed(2)}",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: width / 85.375,
                                                textStyle: const TextStyle(
                                                    overflow: TextOverflow
                                                        .ellipsis))),
                                      ],
                                    )),
                                SizedBox(width: 280,)
                              ],
                            )
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
  showprofitpopup(streamid,cost,itemcost,profit) {
    setState(() {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        bool testBool = true;
        return StatefulBuilder(
          builder: (context, setState) {

            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 110.6,
                      bottom: height / 110.6,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 8.4,
                                ),
                                Text(
                                  "Profit of bill",
                                  style: GoogleFonts.openSans(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width / 40.4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
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
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                        "Total Cost: ",
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
                                        child: Center(
                                          child: Text(cost.toString(),style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
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
                                          "Item Cost: ",
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
                                          child: Center(
                                            child: Text(itemcost.toString(),style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        "Profit: ",
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
                                        child: Center(
                                          child: Text(itemcost.toString(),style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),


                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

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
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Date\nTime",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 17.075,
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
                                  width: width / 3.54,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Description',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 22.76,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Hsn\nCode',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),

                                Container(
                                  width: width / 45.53,
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
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Without Tax',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Sales Price',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Landing Cost',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
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
                                        'Tax',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                ),
                                Container(
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  width: width / 10.507,
                                  child: Center(
                                      child: Text(
                                        "Total",
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
                                    .collection("Service Bills")
                                    .doc(streamid)
                                    .collection("Itemsused").orderBy("timestamp")
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
                                      return Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            width: width / 27.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  "${purchase['date']}\n${purchase['time']}"
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 17.075,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${purchase['itemcode']}",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width / 3.54,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  purchase['Description']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ),
                                                /* Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "Sold item : ${quvanotysolddunction(int.parse(purchase['Qty'].toString()), purchase['stocks'], purchase['return Quvantity'])}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    SizedBox(
                                                        width: width / 273.72),
                                                    Text(
                                                      "Balance item : ${purchase['stocks']}",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),*/
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width / 22.76,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['Hsncode'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),

                                          Container(
                                            width: width / 45.53,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase["Qty"].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['withouttaxprice']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['Sales price']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['Landing Cost']
                                                      .toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),

                                          Container(
                                            width: width / 27.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['tax'].toString(),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                          Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                            (int.parse(purchase['Qty'].toString()) * double.parse(purchase['Sales price'])).toStringAsFixed(2),
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: height / 21.9,
                                    width: width / 6.53,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: const Color(0xff25d366)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text("Pending Total : ${pendingtotal.toStringAsFixed(2)}",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: width / 85.375,
                                                textStyle: const TextStyle(
                                                    overflow: TextOverflow
                                                        .ellipsis))),
                                      ],
                                    )),
                                SizedBox(width: 280,)
                              ],
                            )*/
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
  showdialpogbox(streamid,) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return
          StatefulBuilder(
            builder: (context, setState) {
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child:
                Padding(
                  padding:  EdgeInsets.only(top: height/4.6,bottom:height/4.6,left: width/3.53,right: width/3.53),
                  child: Scaffold(
                    backgroundColor: const Color(0xff00A99D),
                    body:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height/22.53,),
                        Text("Status Update",style: GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),),
                        SizedBox(height:height/6.56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Status : ",style: GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.white),),
                            SizedBox(width: width/136.6,),
                            Container(
                              width: width / 7.415,
                              height: height / 18.9,
                              //color:Colors.white,
                              decoration:  BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:
                              DropdownButton2<String>(
                                value: WantedType,
                                style:GoogleFonts.openSans(
                                    fontSize: width/113.833,
                                    color:Colors.black,
                                    fontWeight: FontWeight.bold),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                iconStyleData: const IconStyleData(
                                    icon:Icon(Icons.arrow_back_ios_outlined),
                                    iconSize: 0
                                ),

                                onChanged: (String? value) {
                                  setState(() {
                                    WantedType=value!;
                                  });
                                },
                                items:
                                Type.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:GoogleFonts.openSans(
                                            fontSize: width/113.833,
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold),),
                                      );
                                    }).toList(),
                                dropdownStyleData: const DropdownStyleData(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:height/6.36),

                        InkWell(
                          onTap: () {
                            print(height);
                            print(width);
                            if(WantedType=='Delivery'){
                              FirebaseFirestore.instance.collection("Service_Entry").doc(streamid).update({
                                'Deliverydate':"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}\n${DateFormat.jm().format(DateTime.now())}",
                                "service status":"Delivery",
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width / 12.6,
                            height: height / 20.42,
                            //color: Color(0xffD60A0B),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366),
                            ),
                            child: Center(
                                child: Text(
                                  "Okay",
                                  style: GoogleFonts.openSans(color: Colors.white),
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            );
          },);
      },
    );
  }

}
