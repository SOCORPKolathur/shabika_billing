import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../LandingPage/LandingPage.dart';
import 'Service_Entry_Page.dart';


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
                      builder: (context) => drawer(" "),
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
                "Service Reports ",
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: width / 59.39,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        //line image
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 36.5, horizontal: width / 75.88),
          child: Image.asset("assets/Line13.png"),
        ),

        //Filter
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 82.125, horizontal: width / 170.75),
          child: Container(
            height: height / 4.57,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: height/43.8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                SizedBox(
                  height: height / 131.4,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 53.55),
                  child: Row(
                    children: [
                      Text(
                        "Filters",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 65.7,
                ),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("Service_Status")
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          return //submit button
                              Row(
                            children: snapshot.data!.docs.map((data) {
                              return Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width / 53.55),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Filter = data["service status"];
                                          Selected[index] = true;
                                          all=false;
                                        });
                                      },
                                      child: Container(
                                        height: height / 16.4,
                                        width: width / 9.5,
                                        decoration: BoxDecoration(
                                          color: Selected[index]==true&&Filter==data["service status"]?Colors.red:const Color(0xff4477CE),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data["service status"],
                                            style: GoogleFonts.cairo(
                                                fontSize: width / 68.3,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    );
                  },
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: width / 53.55),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Filter = "All";
                            all=true;
                            Customermobile.clear();
                            search='';
                          });
                          if(all==true){
                            for(int i=0;i<Selected.length;i++){
                              setState(() {
                                Selected[i]=false;
                              });
                            }
                          }

                        },
                        child: Container(
                          height: height / 16.4,
                          width: width / 9.5,
                          decoration: BoxDecoration(
                            color: all==true?Colors.red:const Color(0xff4477CE),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text(
                              "All",
                              style: GoogleFonts.cairo(
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width:30),
                    Text("Customer Mobile :",style: GoogleFonts.cairo(
                        fontSize: width / 78.3,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                    SizedBox(width:30),

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

                    Padding(
                      padding: EdgeInsets.only(left: width / 53.55),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            search= Customermobile.text;
                          });
                        },
                        child: Container(
                          height: height / 16.4,
                          width: width / 9.5,
                          decoration: BoxDecoration(
                            color:Colors.green,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text(
                              "Search",
                              style: GoogleFonts.cairo(
                                  fontSize: width / 68.3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),

        Container(
          height: height/1.194,
          width: width/1.050,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:height/65.7,),

                Row(
                  children: [
                    SizedBox(width:width/110.15,),

                    Container(
                        width:width/29.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Bil No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/17.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Custome\nMobile",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Custome\nName",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Model No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Cost",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Advance Balance",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Balance",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Delivery\nDate",
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
                  stream: FirebaseFirestore.instance.collection("Service_Entry").
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
                        if(buillin1['customermobile'].toString().toLowerCase().startsWith(search.toLowerCase())){
                        return
                          buillin1['service status']==Filter?
                        Row(
                          children: [
                            SizedBox(width:width/110.15,),

                            Container(
                                width:width/29.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['Billno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                              width:width/17.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Center(child: Text("${buillin1['date'].toString()}\n${buillin1['time'].toString()}",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),
                                textAlign: TextAlign.center,
                              )),
                            ),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['customermobile'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['customername'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['modelno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['servicecost'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['serviceadvancebalance'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['servicebalance'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: buillin1['Deliverydate']==""?
                                Center(child: Text("Null",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)):
                                Center(child: Text(buillin1['Deliverydate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))
                            ),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['service status'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))
                            ),

                            Container(
                                width:width/10.66,
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Service_Entry_Page("","setvalue",buillin1.id) ,));
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

                                  ],
                                )),

                            //SizedBox(width:width/27.32,),

                          ],
                        ):
                        Filter=="All"?
                        Row(
                          children: [
                            SizedBox(width:width/110.15,),

                            Container(
                                width:width/29.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['Billno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                              width:width/17.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Center(child: Text("${buillin1['date'].toString()}\n${buillin1['time'].toString()}",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),
                                textAlign: TextAlign.center,
                              )),
                            ),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['customermobile'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['customername'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['modelno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['servicecost'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['serviceadvancebalance'].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child: Center(child: Text(buillin1['servicebalance'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                            Container(
                              width:width/10.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              child: buillin1['Deliverydate']==""?
                              Center(child: Text("Null", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),),):
                              Center(child: Text(buillin1['Deliverydate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)),),

                            InkWell(
                              onTap:(){
                                showdialpogbox(buillin1.id);
                              },
                              child: Container(
                                width:width/10.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)
                                ),
                                child:Center(child: Text(buillin1['service status'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)),),
                            ),

                            Container(
                                width:width/10.66,
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Service_Entry_Page("","setvalue",buillin1.id) ,));
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

                                  ],
                                )),

                            //SizedBox(width:width/27.32,),

                          ],
                        ):SizedBox();
                        }

                        else if(search==""){
                          return
                            buillin1['service status']==Filter?
                            Row(
                              children: [
                                SizedBox(width:width/110.15,),

                                Container(
                                    width:width/29.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['Billno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                  width:width/17.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Center(child: Text("${buillin1['date'].toString()}\n${buillin1['time'].toString()}",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),
                                    textAlign: TextAlign.center,
                                  )),
                                ),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['customermobile'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['customername'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['modelno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['servicecost'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['serviceadvancebalance'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['servicebalance'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: buillin1['Deliverydate']==""?
                                    Center(child: Text("Null",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)):
                                    Center(child: Text(buillin1['Deliverydate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))
                                ),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['service status'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))
                                ),

                                Container(
                                    width:width/10.66,
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Service_Entry_Page("","setvalue",buillin1.id) ,));
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

                                      ],
                                    )),

                                //SizedBox(width:width/27.32,),

                              ],
                            ):
                            Filter=="All"?
                            Row(
                              children: [
                                SizedBox(width:width/110.15,),

                                Container(
                                    width:width/29.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['Billno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                  width:width/17.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Center(child: Text("${buillin1['date'].toString()}\n${buillin1['time'].toString()}",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),
                                    textAlign: TextAlign.center,
                                  )),
                                ),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['customermobile'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['customername'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['modelno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['servicecost'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['serviceadvancebalance'].toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(child: Text(buillin1['servicebalance'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: buillin1['Deliverydate']==""?
                                  Center(child: Text("Null", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.black),),):
                                  Center(child: Text(buillin1['Deliverydate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)),),

                                InkWell(
                                  onTap:(){
                                    showdialpogbox(buillin1.id);
                                  },
                                  child: Container(
                                    width:width/10.66,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child:Center(child: Text(buillin1['service status'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),)),),
                                ),

                                Container(
                                    width:width/10.66,
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Service_Entry_Page("","setvalue",buillin1.id) ,));
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

                                      ],
                                    )),

                                //SizedBox(width:width/27.32,),

                              ],
                            ):SizedBox();
                        }

                         return  const SizedBox();


                      },);
                  },
                ),
              ],
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
