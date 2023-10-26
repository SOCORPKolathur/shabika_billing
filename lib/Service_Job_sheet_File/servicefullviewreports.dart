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

class ServiceFullview extends StatefulWidget {
  const ServiceFullview({Key? key}) : super(key: key);

  @override
  State<ServiceFullview> createState() => _ServiceFullviewState();
}

class _ServiceFullviewState extends State<ServiceFullview> {
  String Filter = "All";
  bool all=true;

  List<bool> Selected = List.generate(100, (index) => false);

  String WantedType=Type.first;

  TextEditingController Customermobile=TextEditingController();
  TextEditingController searchfield=TextEditingController();
  String search='';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 82.125, horizontal: width / 170.75),
          child: Container(
            height: height / 12.57,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: height/80.8),
            decoration: BoxDecoration(
                color: Color(0xff00A99D), borderRadius: BorderRadius.circular(7)),
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
                          Container(
                            width: width / 3.504,
                            height: height / 16.4,
                            decoration: BoxDecoration(
                                color:  Colors.white,
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
                                hintText: "Search by Customer Name/Phone Bill No",
                                suffixIcon: Icon(Icons.search),


                                contentPadding: EdgeInsets.only(left: width/68.3, top:height/ 82.125,),
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
                padding:  EdgeInsets.symmetric(),
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
                            child: Center(child: Text("Date\nTime",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/30.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Bill No",
                              textAlign:  TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Alternative\nMobile",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Customer\nName",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Brand",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Model",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Color",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("IMEI",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/30.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Batt",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/30.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Sim",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/30.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("MCC",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/30.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("CH",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


                        Container(
                            width:width/25.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Phone Lock",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/25.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("PIN",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                        Container(
                            width:width/25.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Cost",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/25.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Adv",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                        Container(
                            width:width/25.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Bal",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


                        Container(
                            width:width/15.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Delivery Date\nTime",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


                        Container(
                            width:width/20.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Status",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      /*  Container(
                            width:width/10.66,
                            height:height/13.14,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Center(child: Text("Actions",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),*/

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

                            if(search!="") {
                              if(buillin1['cusmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                              buillin1['cusalmob'].toString().toLowerCase().startsWith(search.toLowerCase())||
                              buillin1['cusname'].toString().toLowerCase().startsWith(search.toLowerCase())||
                              buillin1['billno'].toString().toLowerCase().startsWith(search.toLowerCase())
                              ){
                                return Row(
                                  children: [

                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          "${buillin1["date"]}\n${buillin1["time"]}",
                                          textAlign: TextAlign.center,

                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),

                                    Container(
                                        width: width / 30.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["billno"],
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),

                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["cusmob"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),

                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["cusalmob"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),

                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["cusname"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),
                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["brand"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),
                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["model"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),
                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["color"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),
                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["imei"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),

                                    Container(
                                        width: width / 30.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["battery"] == true
                                              ? " Yes"
                                              : "No",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    Container(
                                        width: width / 30.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["sim"] == true ? " Yes" : "No",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    Container(
                                        width: width / 30.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["mmc"] == true ? " Yes" : "No",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    Container(
                                        width: width / 30.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["charger"] == true
                                              ? " Yes"
                                              : "No",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),


                                    Container(
                                        width: width / 25.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["phonelocktype"],
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    Container(
                                        width: width / 25.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["password"],
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    Container(
                                        width: width / 25.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["totalcost"].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),

                                    Container(
                                        width: width / 25.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(
                                            child: Text(buillin1["advance"],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w700,fontSize:12,
                                                  color: Colors.black),))),

                                    Container(
                                        width: width / 25.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          buillin1["balance"].toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),

                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          "${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),
                                    /*  Container(
                                    width:width/20.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),*/

                                    Container(
                                        width: width / 20.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)
                                        ),
                                        child: Center(child: Text(
                                          "${buillin1["status"]}",
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,fontSize:12,
                                              color: Colors.black),))),

                                    /*   GestureDetector(
                                  onTap:(){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>Service_Update_Status_Page(buillin1.id))
                                    );
                                  },
                                  child: Container(
                                      width:width/21.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)
                                      ),
                                      child: Center(child: Text("View",style: GoogleFonts.openSans(fontWeight: FontWeight.w700,fontSize:12,color: const Color(0xff5801e8)),))),
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
                                      child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w700,fontSize:12,color: const Color(0xff5801e8)),))),
                                ),
                                */
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
                                children: [

                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["date"]}\n${buillin1["time"]}",
                                        textAlign: TextAlign.center,

                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 30.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["billno"],
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusalmob"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["cusname"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),
                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["brand"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),
                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["model"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),
                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["color"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),
                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["imei"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 30.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["battery"] == true
                                            ? " Yes"
                                            : "No",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 30.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["sim"] == true ? " Yes" : "No",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 30.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["mmc"] == true ? " Yes" : "No",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 30.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["charger"] == true
                                            ? " Yes"
                                            : "No",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),


                                  Container(
                                      width: width / 25.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["phonelocktype"],
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 25.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["password"],
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  Container(
                                      width: width / 25.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["totalcost"].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 25.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(
                                          child: Text(buillin1["advance"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w700,fontSize:12,
                                                color: Colors.black),))),

                                  Container(
                                      width: width / 25.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        buillin1["balance"].toString(),
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),

                                  Container(
                                      width: width / 15.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["deliverydate"]}\n${buillin1["deliverytime"]}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            color: Colors.black),))),
                                  /*  Container(
                                    width:width/20.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1["balance"]!=0 ? "UnPaid":"Paid",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: buillin1["balance"]!=0 ? Colors.red: Colors.green),))),*/

                                  Container(
                                      width: width / 20.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black)
                                      ),
                                      child: Center(child: Text(
                                        "${buillin1["status"]}",
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize:12,
                                            ),))),

                                  /*   GestureDetector(
                                  onTap:(){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>Service_Update_Status_Page(buillin1.id))
                                    );
                                  },
                                  child: Container(
                                      width:width/21.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)
                                      ),
                                      child: Center(child: Text("View",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: const Color(0xff5801e8)),))),
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
                                      child: Center(child: Text("Edit",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: const Color(0xff5801e8)),))),
                                ),
                                */
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
