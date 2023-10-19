import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding:  EdgeInsets.only(left: width / 50.504,),
              child: Column(
                children: [



                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Text("Customer Mobile :",style: GoogleFonts.cairo(
                              fontSize: width / 78.3,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                          SizedBox(height:3),

                          Container(
                            width: width / 6.504,
                            height: height / 16.4,
                            decoration: BoxDecoration(
                                color: const Color(0xffDDDEEE),
                                borderRadius: BorderRadius.circular(4)),
                            child: TextField(
                              controller: Customermobile,
                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                border: InputBorder.none,
                              ),
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
                      children: [

                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Date\nTime",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/17.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Bill No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Alternative\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/9.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nName",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Cost",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Advance",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Balance",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/13.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Delivery Date\nTime",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Payment",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/10.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Status",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/10.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Actions",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

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
                             return   Row(
                               children: [

                                 Container(
                                     width:width/15.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text("${buillin1["date"]}\n${buillin1["time"]}",
                                       textAlign: TextAlign.center,

                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/17.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["billno"],style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/9.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["cusmob"],
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/9.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["cusalmob"],
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/9.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["cusname"],
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/13.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["totalcost"].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/13.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["advance"],
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/13.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["balance"].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 Container(
                                     width:width/13.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text("${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),
                                 Container(
                                     width:width/15.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),

                                 Container(
                                     width:width/10.66,
                                     height:height/13.14,
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.black)
                                     ),
                                     child: Center(child: Text("${buillin1["status"]}",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color:  Colors.black),))),

                                 GestureDetector(
                                   onTap:(){
                                     Navigator.of(context).push(
                                       MaterialPageRoute(builder: (context)=>Service_Update_Status_Page(buillin1.id))
                                     );
                            },
                                   child: Container(
                                       width:width/10.66,
                                       height:height/13.14,
                                       decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black)
                                       ),
                                       child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: const Color(0xff5801e8)),))),
                                 ),

                                 //SizedBox(width:width/27.32,),

                               ],
                             );


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
                        Text("Status Update",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                        SizedBox(height:height/6.56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Status : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
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
                                style:GoogleFonts.montserrat(
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
                                        child: Text(value,style:GoogleFonts.montserrat(
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
                                  style: GoogleFonts.poppins(color: Colors.white),
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
