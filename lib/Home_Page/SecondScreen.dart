import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder_alternative/flutter_geocoder_alternative.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


 class Home extends StatefulWidget {
   Home(this.type);
   String?type;

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  bool status = true;
  bool statusA = false;
  bool AllReports = false;
  bool homeclick=false;

@override
  void initState() {
  Future.delayed(Duration(seconds: 6),(){
  _showAddress();
  });
  billingtotalamount();
  // TODO: implement initState
    super.initState();
  }

  Geocoder geocoder = Geocoder();

  Future<String> getAddress(double pLon, double pLat) {
    return geocoder.getAddressFromLonLat(pLon, pLat);
  }

  String _address='';

  _showAddress() async {
    print("_addressddddddddddddddddd");
    _address = await getAddress(-6.1805312, 106.8282181);
    print(_address);
  }




  TextEditingController pos1=new TextEditingController();
  TextEditingController pos2=new TextEditingController();
  final DateFormat formatter = DateFormat('dd / M / yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //home page design and contains
      Column(

        children: [
          //toggle switchs......
          Padding(
            padding:  EdgeInsets.only(top:height/82.125,left: width/9.106),
            child: Row(
              children: [

                //toggle switch-1
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
                            statusA = false;
                            AllReports = false;
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
                  "Shabika",
                  style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
                ),

                //toggle switch-2
                Padding(
                  padding:  EdgeInsets.only(left:width/56.916),
                  child: FlutterSwitch(
                    inactiveColor: Color(0xffC9C9C9),
                    inactiveToggleColor: Colors.grey,
                    width:  width/30.35,
                    height: height/32.85,
                    valueFontSize: 5.0,
                    toggleSize: 20.0,
                    value: statusA,
                    borderRadius: 10.0,
                    padding: 2.0,
                    //showOnOff: true,
                    onToggle: (val) {
                      if(val==true) {
                        setState(() {
                          statusA = val;
                          status = false;
                          AllReports = false;
                        });
                      }
                      else{
                        setState(() {
                          statusA = val;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width/56.916, right: width/68.3),
                  child: Text(
                    "Shabika  A",
                    style:
                    GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
                  ),
                ),

                //toggle switch-3
                Padding(
                  padding:  EdgeInsets.only(left: width/56.916),
                  child: FlutterSwitch(
                    inactiveColor: Color(0xffC9C9C9),
                    inactiveToggleColor: Colors.grey,
                    width:  width/30.35,
                    height:  height/32.85,
                    valueFontSize: 5.0,
                    toggleSize: 20.0,
                    value: AllReports,
                    borderRadius: 10.0,
                    padding: 2.0,
                    //showOnOff: true,
                    onToggle: (val) {
                      if(val==true) {
                        setState(() {
                          AllReports = val;
                          statusA = false;
                          status = false;
                        });
                      }
                      else{
                        setState(() {
                          AllReports = val;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width/56.916),
                  child: Text(
                    "All Reports",
                    style:
                    GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
                  ),
                ),
              ],
            ),
          ),


          //fromdate and todate text
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width/23.551, right: width/34.15),
                child: Text(
                  "From Date",
                  style: GoogleFonts.cairo(
                      fontSize:width/68.3, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: width/68.3,),
              Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: width/170.75,
                    vertical: height/82.125
                ),
                child: Text(
                  "To Date",
                  style: GoogleFonts.cairo(
                      fontSize:width/68.3, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          //date and year and alarm icon container
          Row(
            children: [

              //textfield-1 fromdate
              Padding(
                padding:  EdgeInsets.only(left: width/25.77,),
                child: Container(
                  child: TextField(
                    controller: pos1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                      hintText: "mm/dd/yyyy",
                      hintStyle: TextStyle(color: Color(0xff00A99D)),
                      border: InputBorder.none,
                    ),
                    onTap: () async {

                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now()
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          year1= pickedDate.year;
                          day1= pickedDate.day;
                          month1= pickedDate.month;
                          pos1.text = formattedDate;
                          //set output date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                  //color: Colors.teal[300],
                  height: height / 16.4,
                  width: width / 9.5,
                  decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Color(0xff01A99E))),
                ),
              ),

              SizedBox(width: width/91.066,),

              //textfield-2 todate
              Container(
                child: TextField(
                  controller: pos2,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                    hintText: "mm/dd/yyyy",
                    hintStyle: TextStyle(color: Color(0xff00A99D)),
                    border: InputBorder.none,
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        year2= pickedDate.year;
                        day2= pickedDate.day;
                        month2= pickedDate.month;
                        pos2.text = formattedDate;

                        //set output date to TextField value.
                      });
                      print(year2);
                      print(day2);
                      print(month2);
                      DateTime startDate = DateTime.utc(year1, month1, day1);
                      DateTime endDate = DateTime.utc(year2, month2, day2);
                      print(startDate);
                      print(endDate);
                      getDaysInBetween() {
                        final int difference = endDate.difference(startDate).inDays;
                        print(difference);
                        return difference;
                      }
                      final items = List<DateTime>.generate(getDaysInBetween(), (i) {
                        DateTime date = startDate;
                        return date.add(Duration(days: i));
                      });
                      setState(() {
                        mydate.clear();
                      });
                      for(int i =0;i<items.length;i++) {
                        setState(() {
                          mydate.add(formatter.format(items[i]).toString());
                        });

                      }
                      print(mydate);
                      billingtotalamount();
                    }else{
                      print("Date is not selected");
                    }
                  },
                ),
                //color: Colors.teal[300],
                height: height / 16.4,
                width: width / 9.5,
                decoration: BoxDecoration(
                    color: Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Color(0xff01A99E))),
              ),
              SizedBox(width: width/91.066,),



              //alaram image
              Padding(
                padding:  EdgeInsets.only(left: width/1.607),
                child: Container(
                  child: Image.asset(
                    "assets/alarm.png",
                    fit: BoxFit.cover,
                  ),
                  width: width / 45,
                  height: height / 21.9,
                ),
              )

            ],
          ),

          //First container(total sales and total purchase..)
          Padding(
            padding:  EdgeInsets.only(right: width/34.15, top: height/32.85),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left: width/50.592),
                        child: Container(
                          child: Image.asset("assets/image.png"),
                          width: width / 17.07,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/36.5, left:width/85.375),
                        child: Image.asset("assets/linered.png"),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                top: height/32.85, left:width/85.375, right: width/136.6),
                            child: Text(
                              "Total sales",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/75.88),
                            child: Text(
                              salesamount.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize:width/85.375, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding:  EdgeInsets.only(top:height/36.5, right:width/75.888),
                        child: Image.asset("assets/linegrey.png"),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, right:width/75.888),
                        child: Container(
                          child: Image.asset("assets/cart.png"),
                          width: width / 17.05,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right:width/75.888, top:height/34.578),
                        child: Image.asset(
                          "assets/linered.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:height/23.464),
                            child: Text(
                              "Total Purchase",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/20.088),
                            child: Text(
                              purchasetotal.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize:width/85.375, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/36.5, left: width/683, right: width/170.75),
                        child: Image.asset("assets/linegrey.png"),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left:width/91.06),
                        child: Container(
                          child: Image.asset("assets/people.png"),
                          width: width / 17.0,
                          height: height / 8,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffFFF2D8),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                            top: height/54.75, left: width/47.103, right: width/273.2),
                        child: Image.asset(
                          "assets/linered.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [

                          Padding(
                            padding:  EdgeInsets.only(left: width/97.571),
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top:height/23.464),
                                  child: Text(
                                    "Total Profit",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffA3A3A3), fontSize:width/105.076),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(
                                      bottom: height/82.125, right:width/75.888),
                                  child: Text(
                                    profitss.abs().toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(top: height/109.5, left: width/37.94),
                            child: Container(
                              child: Image.asset("assets/symbol.png"),
                              width: width / 17,
                              height: height / 8.2,
                              //color: Color(0xffD1F3E0),
                              decoration: BoxDecoration(
                                  color: Color(0xffFFEAEA),
                                  borderRadius: BorderRadius.circular(52)),
                            ),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(
                                right:width/75.888, top:height/34.578, left:width/75.888),
                            child: Image.asset(
                              "assets/linered.png",
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(top:height/23.464),
                            child: Column(
                              children: [
                                Text(
                                  "Total Customer",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffA3A3A3), fontSize:width/105.076),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: width/48.785),
                                  child: Text(
                                    "\$${customtotal.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontSize:width/85.375,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              width:width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),

          //second container(student and teacher and total expensive..)
          Padding(
            padding:
            EdgeInsets.only(right:width/34.15, top: height/65.7, bottom: height/65.7),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left: width/52.538),
                        child: Container(
                          child: Image.asset("assets/group1.png"),
                          width: width / 17.0,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/36.5, left:width/75.888),
                        child: Image.asset("assets/linered.png"),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                            top:height/36.5, left:width/75.888, right:width/75.888),
                        child: Column(
                          children: [
                            /*Text(
                              "Students",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),

                             */
                            Padding(
                              padding:  EdgeInsets.only(right: width/113.83),
                              child: Text(
                                "50000",
                                style: GoogleFonts.poppins(
                                    fontSize:width/85.375,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left:width/85.375),
                        child: Container(
                          child: Image.asset("assets/group.png"),
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                            right:width/75.888, top:height/34.578,left:width/68.3),
                        child: Image.asset(
                          "assets/linered.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [

                          /* Padding(
                            padding: const EdgeInsets.only(top: 28),
                            child: Text(
                              "Teachers",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          */
                          Padding(
                            padding:  EdgeInsets.only(top:height/23.464, right: width/68.3, bottom: height/82.125),
                            child: Text(
                              "1500",
                              style: GoogleFonts.poppins(
                                  fontSize:width/85.375,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/36.5, left: width/29.063),
                        child: Image.asset("assets/linegrey.png"),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left: width/54.64),
                        child: Container(
                          child: Image.asset("assets/students.png"),
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffFFF2D8),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                            top:height/36.5, left: width/62.090, right: width/85.375),
                        child: Image.asset("assets/linered.png"),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                              top:height/36.5,
                            ),
                            child: Text(
                              "Total Expense",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/35.947),
                            child: Text(
                              "60000",
                              style: GoogleFonts.poppins(
                                  fontSize:width/85.375,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left:width/85.375),
                        child: Container(
                          child: Image.asset("assets/supplier.png"),
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffFFEAEA),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(
                            right:width/75.888, top:height/34.578,left:width/68.3),
                        child: Image.asset(
                          "assets/linered.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top:height/82.125),
                            child: Text(
                              "Supplier Outstanding",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/20.088),
                            child: Text(
                              "0",
                              style: GoogleFonts.poppins(
                                  fontSize:width/85.375,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              width: width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),

          //third container(total service and total profits)
          Padding(
            padding:  EdgeInsets.only(right:width/34.15),
            child: Container(
              child: Column(
                children: [

                  Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/131.4, left: width/52.538),
                        child: Container(
                          child: Image.asset("assets/newimg.png"),
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/36.5, left:width/75.888),
                        child: Image.asset("assets/linered.png"),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                top:height/82.125, left:width/91.06),
                            child: Text(
                              "Total Services",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3),
                                  fontSize:width/91.066),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                                right: width/35.947, left:width/136.6),
                            child: Text(
                              "50000",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:width/85.375),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/131.4, left: width/52.538),
                        child: Container(
                          child: Image.asset("assets/newimg1.png"),
                          width: width / 17.0,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/36.5, left:width/75.888),
                        child: Image.asset("assets/linered.png"),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                top:height/82.125,left:width/68.3),
                            child: Text(
                              "Total Profit",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA3A3A3),
                                  fontSize:width/91.066),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: width/151.77),
                            child: Text(
                              "50000",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:width/85.375),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
              width: width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),



          //last container and total amount and name text
          Padding(
            padding:  EdgeInsets.only(left:width/27.32),
            child: Row(
              children: [

                Padding(
                  padding:  EdgeInsets.only(
                      top:height/36.5, left: width/30.355, right: width/27.32),
                  child: Container(
                    child: Column(
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(bottom: height/131.4),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff000000),
                                      borderRadius: BorderRadius.only(
                                          topLeft:
                                          Radius.circular(22),
                                          topRight:
                                          Radius.circular(22))),
                                  //color: Colors.teal,
                                  width: double.infinity,
                                  height: height / 18.7,
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/34.15, top: height/82.125),
                                    child: Text(
                                      "Today Over All Sales Value",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ),
                                )

                              ],
                            ),
                            // color: Color(0xff00A99D),
                            width: width /2.5,
                            height: height / 14.6,

                            //color: Color(0xff00A99D),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(
                              top:height/131.4, left: width/34.15, bottom: height/131.4),
                          child: Row(
                            children: [
                              Text(
                                "Shabika",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/5.464),
                                child: Container(
                                  width: width/9.757,
                                  child: Center(
                                    child: Text(
                                      "1000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:
                          EdgeInsets.only(left: width/34.15, bottom:height/164.25),
                          child: Row(
                            children: [
                              Text(
                                "Shabika A",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: width/5.691, bottom: height/131.4),
                                child: Container(
                                  width:width/9.757,
                                  child: Center(
                                    child: Text(
                                      "15000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Image.asset("assets/linered1.png"),

                        Padding(
                          padding:
                          EdgeInsets.only(top:height/164.25, left: width/4.406),
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/75.888),
                                child: Container(
                                  width:width/9.757,
                                  child: Center(
                                    child: Text(
                                      "16000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    width: width / 2.5,
                    height: height / 3.9,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(22)),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top:height/36.5),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom:height/131.4),
                          child: Stack(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff000000),
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                              Radius.circular(22),
                                              topRight:
                                              Radius.circular(22))),
                                      //color: Colors.teal,
                                      width: width / 2.5,
                                      height: height / 18.7,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left: width/34.15, top: height/82.125),
                                        child: Text(
                                          "Today Over All Sales Value",
                                          style: GoogleFonts.poppins(
                                              color: Color(0xffFFFFFF)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // color: Color(0xff00A99D),
                                width: width /2.5,
                                height: height / 14.6,

                                //color: Color(0xff00A99D),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(
                              top:height/131.4, left: width/34.15, bottom: height/131.4),
                          child: Row(
                            children: [
                              Text(
                                "Sales",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left: width/4.913),
                                child: Container(
                                  width: width/13.66,
                                  child: Center(
                                    child: Text(
                                      "1000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/34.15, bottom:height/164.25),
                          child: Row(
                            children: [
                              Text(
                                "Service",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: width/5.154, bottom: height/131.4),
                                child: Container(
                                  width:width/13.66,
                                  child: Center(
                                    child: Text(
                                      "15000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("assets/linered1.png"),
                        Padding(
                          padding:
                          EdgeInsets.only(top: height/164.25, left: width/4.406),
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/75.888),
                                child: Container(
                                  width:width/13.66,
                                  child: Center(
                                    child: Text(
                                      "16000",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize:width/75.888),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    width: width / 2.5,
                    height: height / 3.9,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(22)),
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }
  
  double salesamount=0;


  billingtotalamount() async {
    setState(() {
      salesamount=0;
    });
    var billingtotal=await FirebaseFirestore.instance.collection("billing").get();
    if(mydate.isNotEmpty) {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if (mydate.contains(billingtotal.docs[i]["date"])) {
          setState(() {
            salesamount = salesamount + billingtotal.docs[i]["Total"];
          });
        }
      }
    }
    else {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if(billingtotal.docs[i]['date']=="${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}")
        setState(() {
          salesamount = salesamount + billingtotal.docs[i]["Total"];
        });
      }
    }
      print("billing");
     print(salesamount.toString());
    purchasetotalamount();
  }


  double purchasetotal=0;

  
  purchasetotalamount() async {
    setState(() {
      purchasetotal=0;
    });
    var billingtotal=await FirebaseFirestore.instance.collection("Purchase entry").get();
    if(mydate.isNotEmpty) {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if (mydate.contains(billingtotal.docs[i]["date"])) {
          setState(() {
            purchasetotal = purchasetotal + billingtotal.docs[i]["Sales price"];
          });
        }
        print("Purchase");
        print(purchasetotal.toString());
        custotalamount();
      }
    }
    else{
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if (billingtotal.docs[i]["date"]=="${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}") {
          setState(() {
            purchasetotal = purchasetotal + billingtotal.docs[i]["Sales price"];
          });
        }
        print("Purchase");
        print(purchasetotal.toString());
        custotalamount();
      }
    }
  }

  
  double customtotal=0;

  
  custotalamount()async{
    setState(() {
      customtotal=0;
    });
    var cus=await FirebaseFirestore.instance.collection("Customer").get();
   if(mydate.isNotEmpty){
     for(int i=0;i<cus.docs.length;i++){
       var cus2=await FirebaseFirestore.instance.collection("Customer").doc(cus.docs[i].id).collection("billing").get();
       for(int j=0;j<cus2.docs.length;j++){
         if(mydate.contains(cus2.docs[j]["date"])){
           setState(() {
             customtotal=customtotal+cus2.docs[j]["Total"];
           });
         }
       }
     }
   }

   else{
     for(int i=0;i<cus.docs.length;i++){
       var cus2=await FirebaseFirestore.instance.collection("Customer").doc(cus.docs[i].id).collection("billing").get();
       for(int j=0;j<cus2.docs.length;j++){
         if(cus2.docs[j]["date"]=="${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}"){
           setState(() {
             customtotal=customtotal+cus2.docs[j]["Total"];
           });
         }
       }
     }
   }

    profitfuntion();
    
  }


  double profitss=0;


  profitfuntion(){
    setState(() {
      profitss=0;
    });
    if(mydate.isNotEmpty){
      setState(() {
        profitss = salesamount-purchasetotal;
      });
    }
    else{
      setState(() {
        profitss = salesamount-purchasetotal;
      });
    }
    print(profitss.abs().toString());
  }


}
