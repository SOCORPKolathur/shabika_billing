import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder_alternative/flutter_geocoder_alternative.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Notidication-Page/Notidication_Page.dart';



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
  Future.delayed(const Duration(seconds: 6),(){
  _showAddress();
  });
  getdatestream();
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
    _address = await getAddress(-6.1805312, 106.8282181);
  }




  TextEditingController pos1=TextEditingController();
  TextEditingController pos2=TextEditingController();
  final DateFormat formatter = DateFormat('dd / M / yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];

int totalsales=0;
int totalpurchase=0;
int totalcustomer=0;
double totalprofit=0;
int Service_entry_count=0;




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //home page design and contains
      Column(

        children: [

          //fromdate and todate text
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width/23.551, right: width/34.15),
                child: Text(
                  "From Date",
                  style: GoogleFonts.openSans(
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
                  style: GoogleFonts.openSans(
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
                  height: height / 16.4,
                  width: width / 9.5,
                  decoration: BoxDecoration(
                      color: const Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: const Color(0xff01A99E))),
                  child: TextField(
                    controller: pos1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                      hintText: "mm/dd/yyyy",
                      hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                      border: InputBorder.none,
                    ),
                    onTap: () async {

                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now()
                      );

                      if(pickedDate != null ){
                        //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                        //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          year1= pickedDate.year;
                          day1= pickedDate.day;
                          month1= pickedDate.month;
                          pos1.text = formattedDate;
                          //set output date to TextField value.
                        });
                      }else{
                      }
                    },
                  ),
                ),
              ),

              SizedBox(width: width/91.066,),

              //textfield-2 todate
              Container(
                height: height / 16.4,
                width: width / 9.5,
                decoration: BoxDecoration(
                    color: const Color(0xffE7E7E7),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xff01A99E))),
                child: TextField(
                  controller: pos2,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                    hintText: "mm/dd/yyyy",
                    hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                    border: InputBorder.none,
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );

                    if(pickedDate != null ){
                      //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                      //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        year2= pickedDate.year;
                        day2= pickedDate.day;
                        month2= pickedDate.month;
                        pos2.text = formattedDate;

                        //set output date to TextField value.
                      });
                      DateTime startDate = DateTime.utc(year1, month1, day1);
                      DateTime endDate = DateTime.utc(year2, month2, day2);
                      getDaysInBetween() {
                        final int difference = endDate.difference(startDate).inDays;
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
                      billingtotalamount();
                    }else{
                    }
                  },
                ),
              ),
              SizedBox(width: width/91.066,),
              //toggle switch-1
              Padding(
                padding:  EdgeInsets.only(left: width/20.583, right: width/56.916),
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
                          statusA = false;
                          AllReports = false;
                        });
                      }

                    });
                  },
                ),
              ),
              Text(
                "Shabika G",
                style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
              ),

              //toggle switch-2
              Padding(
                padding:  EdgeInsets.only(left:width/56.916),
                child: FlutterSwitch(
                  inactiveColor: const Color(0xffC9C9C9),
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


                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width/56.916, right: width/68.3),
                child: Text(
                  "Shabika N",
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
                ),
              ),

              //toggle switch-3
              Padding(
                padding:  EdgeInsets.only(left: width/56.916),
                child: FlutterSwitch(
                  inactiveColor: const Color(0xffC9C9C9),
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

                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width/56.916),
                child: Text(
                  "All Reports",
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
                ),
              ),

              //alaram image
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Notidication_Page(),));
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: width/5.2),
                  child: SizedBox(
                    width: width / 45,
                    height: height / 21.9,
                    child: Image.asset(
                      "assets/alarm.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )

            ],
          ),

          //First container(total sales and total purchase..)
          Padding(
            padding:  EdgeInsets.only(right: width/34.15, top: height/66.85),
            child: Container(
              width:width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left: width/50.592),
                        child: Container(
                          width: width / 17.07,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/image.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/75.88),
                            child: Text(
                           totalsales.toString(),
                              style: GoogleFonts.openSans(
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
                          width: width / 17.05,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/cart.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/20.088),
                            child: Text(
                          totalpurchase.toString(),
                              style: GoogleFonts.openSans(
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
                          width: width / 17.0,
                          height: height / 8,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFF2D8),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/people.png"),
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
                                    style: GoogleFonts.openSans(
                                        color: const Color(0xffA3A3A3), fontSize:width/105.076),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(
                                      bottom: height/82.125, right:width/75.888),
                                  child: Text(
                                    profitss.toString(),
                                    style: GoogleFonts.openSans(
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
                              width: width / 17,
                              height: height / 8.2,
                              //color: Color(0xffD1F3E0),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFEAEA),
                                  borderRadius: BorderRadius.circular(52)),
                              child: Image.asset("assets/symbol.png"),
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
                                  style: GoogleFonts.openSans(
                                      color: const Color(0xffA3A3A3), fontSize:width/105.076),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(right: width/48.785),
                                  child: Text(
                                    totalcustomer.toString(),
                                    style: GoogleFonts.openSans(
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
            ),
          ),

          //second container(student and teacher and total expensive..)
          Padding(
            padding:
            EdgeInsets.only(right:width/34.15, top: height/66.7, bottom: height/65.7),
            child: Container(
              width: width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left: width/52.538),
                        child: Container(
                          width: width / 17.0,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/group1.png"),
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
                              style: GoogleFonts.openSans(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),

                             */
                            Padding(
                              padding:  EdgeInsets.only(right: width/113.83),
                              child: Text(
                                totalprofits.toString(),
                                style: GoogleFonts.openSans(
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
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/group.png"),
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
                              style: GoogleFonts.openSans(
                                  color: Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          */
                          Padding(
                            padding:  EdgeInsets.only(top:height/23.464, right: width/68.3, bottom: height/82.125),
                            child: Text(
                              "1500",
                              style: GoogleFonts.openSans(
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
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFF2D8),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/students.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/35.947),
                            child: Text(
                              "60000",
                              style: GoogleFonts.openSans(
                                  fontSize:width/85.375,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:height/131.4, left:width/85.375),
                        child: Container(
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFEAEA),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/supplier.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3), fontSize:width/105.076),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right:width/20.088),
                            child: Text(
                              suppilieroutstandingtotal.toStringAsFixed(2),
                              style: GoogleFonts.openSans(
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
            ),
          ),

          //third container(total service and total profits)
          Padding(
            padding:  EdgeInsets.only(right:width/34.15),
            child: Container(
              width: width/1.1,
              height: height / 6.57,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [

                  Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(top:height/131.4, left: width/52.538),
                        child: Container(
                          width: width / 17,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffD1F3E0),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/newimg.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3),
                                  fontSize:width/91.066),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                                right: width/35.947, left:width/136.6),
                            child: Text(
                              Service_entry_count.toString(),
                              style: GoogleFonts.openSans(
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
                          width: width / 17.0,
                          height: height / 8.2,
                          //color: Color(0xffD1F3E0),
                          decoration: BoxDecoration(
                              color: const Color(0xffE1F1FF),
                              borderRadius: BorderRadius.circular(52)),
                          child: Image.asset("assets/newimg1.png"),
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
                              style: GoogleFonts.openSans(
                                  color: const Color(0xffA3A3A3),
                                  fontSize:width/91.066),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: width/151.77),
                            child: Text(
                              "50000",
                              style: GoogleFonts.openSans(
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
            ),
          ),

          //last container and total amount and name text
          Padding(
            padding:  EdgeInsets.only(left:width/27.32),
            child: Row(
              children: [

                Padding(
                  padding:  EdgeInsets.only(
                      top:height/80.5, left: width/30.355, right: width/27.32),
                  child: Container(
                    width: width / 2.5,
                    height: height / 3.9,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(bottom: height/131.4),
                          child: SizedBox(
                            width: width /2.5,
                            height: height / 14.6,
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
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
                                      style: GoogleFonts.openSans(
                                          color: const Color(0xffFFFFFF)),
                                    ),
                                  ),
                                )

                              ],
                            ),

                            //color: Color(0xff00A99D),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(
                              top:height/131.4, left: width/34.15, bottom: height/131.4),
                          child: Row(
                            children: [
                              Text(
                                "Shabika G",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/5.464),
                                child: SizedBox(
                                  width: width/9.757,
                                  child: Center(
                                    child: Text(
                                      "1000",
                                      style: GoogleFonts.openSans(
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
                                "Shabika N",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: width/5.691, bottom: height/131.4),
                                child: SizedBox(
                                  width:width/9.757,
                                  child: Center(
                                    child: Text(
                                      "15000",
                                      style: GoogleFonts.openSans(
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
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/75.888),
                                child: SizedBox(
                                  width:width/9.757,
                                  child: Center(
                                    child: Text(
                                      "16000",
                                      style: GoogleFonts.openSans(
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
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top:height/80.5),
                  child: Container(
                    width: width / 2.5,
                    height: height / 3.9,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom:height/131.4),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: width /2.5,
                                height: height / 14.6,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
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
                                          style: GoogleFonts.openSans(
                                              color: const Color(0xffFFFFFF)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

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
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left: width/4.913),
                                child: SizedBox(
                                  width: width/13.66,
                                  child: Center(
                                    child: Text(
                                      "1000",
                                      style: GoogleFonts.openSans(
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
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left: width/5.154, bottom: height/131.4),
                                child: SizedBox(
                                  width:width/13.66,
                                  child: Center(
                                    child: Text(
                                      "15000",
                                      style: GoogleFonts.openSans(
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
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize:width/75.888),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(left:width/75.888),
                                child: SizedBox(
                                  width:width/13.66,
                                  child: Center(
                                    child: Text(
                                      "16000",
                                      style: GoogleFonts.openSans(
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
                  ),
                ),
              ],
            ),
          )

        ],
      );
  }



  getdatestream() async {

    final collection3 = FirebaseFirestore.instance.collection("Customer");
    final countQuery3 = collection3.count();
    final AggregateQuerySnapshot snapshot4 = await countQuery3.get();

    final Serviceentry=await FirebaseFirestore.instance.collection("Service_Entry");
    final ServiceentrytQuery = Serviceentry.count();
    final AggregateQuerySnapshot serviceentrycount = await ServiceentrytQuery.get();


    setState((){
      totalcustomer=snapshot4.count;
      Service_entry_count=serviceentrycount.count;
    });

  }
  
  double salesamount=0;
  double profit=0;
  double totalprofits=0;
  double purchaseProfits=0;

 double servicecostvalue=0;
  billingtotalamount() async {
    setState(() {
      salesamount=0;
    });
    ///billing all reports total amount
    var billingtotal=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo: true).get();
    if(mydate.isNotEmpty) {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if (mydate.contains(billingtotal.docs[i]["date"])) {
          setState(() {
            salesamount = (salesamount + double.parse(billingtotal.docs[i]["Total"].toString()));
          });
        }
      }
    }
    else {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        if (billingtotal.docs[i]["date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
        setState(() {
          salesamount = (salesamount + double.parse(billingtotal.docs[i]["Total"].toString()));
          totalsales=billingtotal.docs.length;
        });
      }
    }
    }

    ///Shabika  G reports Total amount
   if(status==true){

     ///billing Shabika G Reports Total Amount
  var billingtotal2=await FirebaseFirestore.instance.collection("billing ShabikaG").where("save",isEqualTo: true).get();
  if(mydate.isNotEmpty) {
    for (int i = 0; i < billingtotal2.docs.length; i++) {
      if (mydate.contains(billingtotal2.docs[i]["date"])) {
        setState(() {
          salesamount = (salesamount + double.parse(billingtotal2.docs[i]["Total"].toString()));
        });
      }
    }
  }
  else {
    for (int i = 0; i < billingtotal2.docs.length; i++) {
      if (billingtotal2.docs[i]["date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
        setState(() {
          salesamount = (salesamount +
              double.parse(billingtotal2.docs[i]["Total"].toString()));
        });
      }
    }
  }

   }

    ///Shabika  N reports Total amount
    if(statusA==true){

      ///billing Shabika N Reports Total Amount
      var billingtotal2=await FirebaseFirestore.instance.collection("billing ShabikaN").where("save",isEqualTo: true).get();
      if(mydate.isNotEmpty) {
        for (int i = 0; i < billingtotal2.docs.length; i++) {
          if (mydate.contains(billingtotal2.docs[i]["date"])) {
            setState(() {
              salesamount = (salesamount + double.parse(billingtotal2.docs[i]["Total"].toString()));
            });
          }
        }
      }
      else {
        for (int i = 0; i < billingtotal2.docs.length; i++) {
          if (billingtotal2.docs[i]["date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
            setState(() {
              salesamount = (salesamount +
                  double.parse(billingtotal2.docs[i]["Total"].toString()));
            });
          }
        }
      }

    }

    ///simcard total amount value

    var profits2=await FirebaseFirestore.instance.collection("Simcard").get();

    for(int i=0;i<profits2.docs.length;i++){
      if(profits2.docs[i]["Date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"){
        setState(() {
          profit=profit+int.parse(profits2.docs[i]['Quvantity'].toString());
          totalprofits=profit*100;
        });
      }

    }

    ///servide Entry Document length and total amount function
    var Serviceentry=await FirebaseFirestore.instance.collection("Service_Entry").get();

    for(int k=0;k<Serviceentry.docs.length;k++){
      if(Serviceentry.docs[k]["date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"){
        setState(() {
          servicecostvalue=(servicecostvalue+double.parse(Serviceentry.docs[k]["servicecost"].toString()));
          Service_entry_count=Serviceentry.docs.length;
        });
      }
    }

    purchasetotalamount();
  }


  double purchasetotal=0;
  double suppilieroutstandingtotal=0;
  double Purchaselandingcost=0;

  
  purchasetotalamount() async {

    setState(() {
      purchasetotal=0;
      Purchaselandingcost=0;
      suppilieroutstandingtotal=0;
    });

    ///all Purchase Total Amount values
    var billingtotal=await FirebaseFirestore.instance.collection("Purchase entry").where("save",isEqualTo: true).get();

    if(mydate.isNotEmpty) {
      for (int i = 0; i < billingtotal.docs.length; i++) {
        ///billing amount
        if (mydate.contains(billingtotal.docs[i]["date"])) {
          setState(() {
            suppilieroutstandingtotal = (suppilieroutstandingtotal + double.parse(billingtotal.docs[i]["balance amount"]));
          });
        }

        var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString())
        .get();

        for(int j=0;j<billingtotalamount.docs.length;j++){
          if (mydate.contains(billingtotalamount.docs[j]["purchasedate"])) {
            setState(() {
              purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
              Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));
              totalpurchase=billingtotalamount.docs.length;
            });
          }
        }

      }
    }

    else{

      for (int i = 0; i < billingtotal.docs.length; i++) {
        ///billing amount
        if(billingtotal.docs[i]["date"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"){

          suppilieroutstandingtotal = (suppilieroutstandingtotal +billingtotal.docs[i]["balance amount"]);
        }

        var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString()).get();
        for(int j=0;j<billingtotalamount.docs.length;j++){
          if (billingtotalamount.docs[j]["purchasedate"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
            setState(() {
              purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
              Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));
              totalpurchase=billingtotalamount.docs.length;

            });

          }
        }



      }
    }



    ///purchas entry shabika G reports Total Amount
    if(status==true){
      var billingtotal=await FirebaseFirestore.instance.collection("Purchase ShabikaG").where("save",isEqualTo: true).get();
      if(mydate.isNotEmpty) {
        print("enter date function-1");
        for (int i = 0; i < billingtotal.docs.length; i++) {
          setState(() {
            suppilieroutstandingtotal = (suppilieroutstandingtotal + double.parse(billingtotal.docs[i]["balance amount"]));
          });
          var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString())
              .get();
          for(int j=0;j<billingtotalamount.docs.length;j++){
            if (mydate.contains(billingtotalamount.docs[j]["purchasedate"])) {
              setState(() {
                purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
                Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));

              });
            }
          }

        }
      }
      else{
        print("enter else function-1");
        for (int i = 0; i < billingtotal.docs.length; i++) {

          setState(() {
            suppilieroutstandingtotal = (suppilieroutstandingtotal +billingtotal.docs[i]["balance amount"]);
          });
          var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString()).get();
          for(int j=0;j<billingtotalamount.docs.length;j++){
            if (billingtotalamount.docs[j]["purchasedate"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
              print("enter if function-1");
              setState(() {
                purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
                Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));
              });
              print(purchasetotal);
              print(suppilieroutstandingtotal);
              print("suppilieroutstandingtotal-value");
            }
          }



        }
      }
    }

    ///purchas entry shabika N reports Total Amount
    if(statusA==true){
      var billingtotal=await FirebaseFirestore.instance.collection("Purchase ShabikaN").where("save",isEqualTo: true).get();
      if(mydate.isNotEmpty) {
        print("enter date function-1");
        for (int i = 0; i < billingtotal.docs.length; i++) {
          setState(() {
            suppilieroutstandingtotal = (suppilieroutstandingtotal + double.parse(billingtotal.docs[i]["balance amount"]));
          });
          var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString())
              .get();
          for(int j=0;j<billingtotalamount.docs.length;j++){
            if (mydate.contains(billingtotalamount.docs[j]["purchasedate"])) {
              setState(() {
                purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
                Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));

              });
            }
          }

        }
      }
      else{
        print("enter else function-1");
        for (int i = 0; i < billingtotal.docs.length; i++) {

          setState(() {
            suppilieroutstandingtotal = (suppilieroutstandingtotal +billingtotal.docs[i]["balance amount"]);
          });
          var billingtotalamount=await FirebaseFirestore.instance.collection("Purchase entry").doc(billingtotal.docs[i].id).collection(billingtotal.docs[i].id.toString()).get();
          for(int j=0;j<billingtotalamount.docs.length;j++){
            if (billingtotalamount.docs[j]["purchasedate"]=="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
              print("enter if function-1");
              setState(() {
                purchasetotal = (purchasetotal + double.parse(billingtotalamount.docs[j]["Sales price"].toString()));
                Purchaselandingcost = (Purchaselandingcost + double.parse(billingtotalamount.docs[j]["Landing cost"].toString()));
              });
              print(purchasetotal);
              print(suppilieroutstandingtotal);
              print("suppilieroutstandingtotal-value");
            }
          }



        }
      }
    }

    ///customer Count Function
    custotalamount();
  }

  
  double customtotal=0;

  
  custotalamount()async{
    setState(() {
      customtotal=0;
    });
    var cus=await FirebaseFirestore.instance.collection("Customer").get();
   if(mydate.isNotEmpty){
     print("enter Date function-2");
     for(int i=0;i<cus.docs.length;i++){
       var cus2=await FirebaseFirestore.instance.collection("Customer").doc(cus.docs[i].id).collection("billing").get();
       for(int j=0;j<cus2.docs.length;j++){
         if(mydate.contains(cus2.docs[j]["date"])){
           setState(() {
             customtotal=(customtotal+double.parse(cus2.docs[j]["Total"].toString()));
           });
         }
       }
     }
   }
   else{
     print("enter else function-2");
     for(int i=0;i<cus.docs.length;i++){
       var cus2=await FirebaseFirestore.instance.collection("Customer").doc(cus.docs[i].id).collection("billing").get();
       for(int j=0;j<cus2.docs.length;j++){
         if(cus2.docs[j]["date"]=="${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}"){
           setState(() {
             customtotal=(customtotal+double.parse(cus2.docs[j]["Total"].toString()));
           });
         }
       }
     }
   }

    profitfuntion();
    
  }


  double profitss=0;


  profitfuntion(){
    print("Total Profit function");
    print(profitss);
    print(Purchaselandingcost);
    print(purchasetotal);
    setState(() {
      profitss=0;
    });
    if(mydate.isNotEmpty){
      setState(() {
        profitss = (Purchaselandingcost-purchasetotal).abs();
      });
    }
    else{
      setState(() {
        profitss = (Purchaselandingcost-purchasetotal).abs();
      });
    }
    print(profitss);
    print("Total Profit function--end");
  }


  ServiceTotalamount()async{
    var Service=await FirebaseFirestore.instance.collection("Service_Entry").get();

  }


}
