import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';
import 'package:flutter/services.dart';
import 'package:shabika_billing/stmodel.dart' as StatusModel;

import '../edit_suppier_Page.dart';



class Supplier extends StatefulWidget {
  const Supplier({Key? key}) : super(key: key);

  @override
  State<Supplier> createState() => _SupplierState();
}
const List<String> list1 = <String>['Numbers(NOS)', 'Two', 'Three', 'Four'];
const List<String> list = <String>['Numbers(NOS)', 'Two', 'Three', 'Four'];

const List<String> Stateslect = <String>[
  "Select State",
 " Andhra Pradesh",
 " Arunachal Pradesh",
 " Assam",
  "Bihar",
  "Chhattisgarh",
 " Goa",
 ' Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
 " Uttar Pradesh",
  "West Bengal",

];

class _SupplierState extends State<Supplier> {

  bool suplierclick=false;
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  TextEditingController Suppliername=TextEditingController();
  TextEditingController Supplieremail=TextEditingController();
  TextEditingController Suppliercode=TextEditingController();
  TextEditingController SupplierAddress=TextEditingController();
  TextEditingController State=TextEditingController();
  TextEditingController City=TextEditingController();
  TextEditingController Pincode=TextEditingController();
  TextEditingController Mobileno=TextEditingController();
  TextEditingController Mobileno2=TextEditingController();
  TextEditingController Panno=TextEditingController();
  TextEditingController Openingbalance=TextEditingController();
  TextEditingController Remarks=TextEditingController();

  NumberFormat F=NumberFormat('00');
  int itemcodes=0;

  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"SB"}${F.format(itemcodes)}";
    });

  }
  String dropdownValue3 = "";
  String dropdownValue4 = "";

  @override
  void initState() {
    itemcodegenrate();
    // TODO: implement initState
    super.initState();
  }

  bool isserach=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
    suplierclick==false?
      Column(
      children: [
        SizedBox(height:height/40),
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left:width/28.458, right: width/34.15),
              child: Container(
                width: width / 3.90,
                height: height / 16.425,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffFFFFFF),
                ),
                child: TextField(
                  controller: Serachcontroller,
                  style: GoogleFonts.poppins(fontSize: width/68.3,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: width/68.3, top:width/102.125,bottom:width/70.125),
                    border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      )
                  ),
                  onTap: (){
                    setState(() {
                      isserach=true;
                    });
                  },
                  onChanged: (value){
                    if(Serachcontroller.text==""){
                      setState(() {
                        isserach=false;
                      });
                    }
                    else{
                      setState(() {
                        isserach=true;
                      });
                    }
                    setState(() {
                      Username=value;
                    });
                  },
                ),
              ),
            ),
            InkWell(
              onTap: (){
                itemcodegenrate();
                setState(() {
                  suplierclick=true;
                });
              },
              child: Container(
                width: width / 5.464,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff00A99D),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(
                              top: height/657, left: width/91.06, right: width/68.3),
                          child: Container(
                            width: width / 56.91,
                            height: height / 27.37,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.add, color: Colors.teal),
                          ),
                        ),
                        Text(
                          "Add Supplier",
                          style: GoogleFonts.cairo(
                              fontSize: width/68.3, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: width/75.88,
              vertical: height/36.5
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                ),
                color: const Color(0xffD4D4D4),
                border: Border.all(color: Colors.black)),

            width: width / 1.03,

            height: height / 1.25,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //titilesssss....
                  Container(
                    width: width / 1.03,
                    height: height / 16.42,
                    // color: Color(0xff00A99D),
                    decoration: const BoxDecoration(
                        color: Color(0xff1D5B79),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/42.68, right: width/26.15),
                          child: Text("Sl.no",
                              style: GoogleFonts.cairo(
                                  color:  Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text("Supplier Name",
                            style: GoogleFonts.cairo(
                                color:Colors.white,
                                fontSize: width / 88.3,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/1.88, right: width/18.514),
                          child: Text("Edit",
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text("Delete",
                            style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontSize: width / 88.3,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding:  EdgeInsets.only(left: width/12.523),
                          child: Text("Status",
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),

                  //Supplier stream
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Supplier").orderBy("timestamp",descending: true)
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

                          if(isserach==true&&snapshot.data!.docs[index]["Suppliername"].toString().toLowerCase().contains(Username.toLowerCase())){
                            return
                              Row(
                                children: [

                                  //index (Serial number)
                                  Container(
                                    height: height / 20.14,
                                    width: width / 13.66,
                                    // color: Colors.grey,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffD4D4D4),
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                          ),
                                        )),
                                    child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 95.888,
                                              color: Colors.black),
                                        )),
                                  ),

                                  //name text
                                  Container(
                                    height: height / 20.14,
                                    width: width / 1.70,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffD4D4D4),
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                          ),
                                        )),
                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                          left: width/75.888, top: height/131.4),
                                      child: Text(
                                        snapshot.data!.docs[index]
                                        ["Suppliername"],
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 95.888,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),

                                  //edit icon(img)
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_suppiler_Paghe(snapshot.data!.docs[index].id),));
                                    },
                                    child: Container(
                                        height: height / 20.14,
                                        width: width / 12.64,
                                        // color: Colors.grey,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.black,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Image.asset("assets/edit.png")),
                                  ),//


                                  //delete icon (img)
                                  InkWell(
                                    onTap:(){
                                      _suppilier(snapshot.data!.docs[index].id);
                                    },
                                    child: Container(
                                        height: height / 20.14,
                                        width: width / 12.41,
                                        // color: Colors.grey,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.black,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Image.asset("assets/delete.png")),
                                  ),

                                  //active text
                                  GestureDetector(
                                    onTap:(){
                                      showdialpogboxss(snapshot.data!.docs[index].id);
                                    },
                                    child: Container(
                                        height: height / 20.14,
                                        width: width / 6.83,
                                        // color: Colors.grey,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              bottom: BorderSide(
                                                color:Colors.black,
                                              ),
                                            )),
                                        child: Center(
                                            child: Text(
                                              "View",
                                              style: GoogleFonts.cairo(
                                                  fontSize: width / 95.888,
                                                  fontWeight: FontWeight.bold,
                                                  color:  Colors.black),
                                            ))),
                                  ),
                                ],
                              );
                          }
                          else if(isserach==false&&snapshot.data!.docs[index]["Suppliername"].toString().toLowerCase().contains(Username.toLowerCase())){
                            return
                              Row(
                              children: [

                                //index (Serial number)
                                Container(
                                  height: height / 20.14,
                                  width: width / 13.66,
                                  // color: Colors.grey,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffD4D4D4),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      )),
                                  child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 95.888,
                                            color: Colors.black),
                                      )),
                                ),

                                //name text
                                Container(
                                  height: height / 20.14,
                                  width: width / 1.70,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffD4D4D4),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.black,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["Suppliername"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width / 95.888,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),

                                //edit icon(img)
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_suppiler_Paghe(snapshot.data!.docs[index].id),));
                                  },
                                  child: Container(
                                      height: height / 20.14,
                                      width: width / 12.64,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          )),
                                      child: Image.asset("assets/edit.png")),
                                ),//


                                //delete icon (img)
                                InkWell(
                                  onTap:(){
                                    _suppilier(snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 20.14,
                                      width: width / 12.41,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          )),
                                      child: Image.asset("assets/delete.png")),
                                ),

                                //active text
                                GestureDetector(
                                  onTap:(){
                                    showdialpogboxss(snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 20.14,
                                      width: width / 6.83,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            bottom: BorderSide(
                                              color:Colors.black,
                                            ),
                                          )),
                                      child: Center(
                                          child: Text(
                                            "View",
                                            style: GoogleFonts.cairo(
                                                fontSize: width / 95.888,
                                                fontWeight: FontWeight.bold,
                                                color:  Colors.black),
                                          ))),
                                ),
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

            //color: Colors.red,
          ),
        )
      ],
    ):

    Column(
      children: [

        Row(
          children: [
            SizedBox(
              width: width/91.06,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  suplierclick = false;
                });
              },
              child: Tooltip(
                message: "Back",
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  shadowColor: Colors.indigo,
                  child: Container(
                    height: height/21.9,
                    width: width/45.53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: width/91.06,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width/91.06,
            ),
            Padding(
              padding:  EdgeInsets.only(right: width/1.232,top: height/65.7,bottom: height/65.7),
              child: Text(
                "Add New Supplier",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, fontSize:width/59.39,color: const Color(0xffFFFFFF)),
              ),
            ),
          ],
        ),

        Image.asset("assets/Line13.png"),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/21.01,top: height/82.125),
              child: Text("Supplier Name *",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width/9.486,top: height/82.125),
              child: Text("Supplier Code*",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),
            Padding(
              padding:  EdgeInsets.only(left:width/9.757,top: height/82.125),
              child: Text("Supplier Address *",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/25.773,top: height/65.7,right: width/22.766),
              child: Container(
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                child:
                TextField(
                  controller: Suppliername,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(contentPadding:
                  EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,),
              child:
              Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: Suppliercode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: width/136.6,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                  border: InputBorder.none,
                ),
              ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,left:width/27.32),
              child: Container(width: width/2.55,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: SupplierAddress,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,
                    bottom:height/82.125),
                  border: InputBorder.none,
                ),
              ),
              ),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding:  EdgeInsets.only(left: width/23.55,top:height/32.85),
              child: Text("State",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/6.266,top:height/32.85),
              child: Text("City",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/5.991,top:height/32.85),
              child: Text("Pincode",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/8.130,top:height/32.85),
              child: Text("Mobile Number",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

            Padding(
              padding:  EdgeInsets.only(left:width/12.418,top:height/32.85),
              child: Text("Mobile Number-2",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,right: width/22.76,left:width/27.32),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child:


              LayoutBuilder(
                builder: (BuildContext , BoxConstraints )=>
                    Autocomplete<String>(
                      optionsViewBuilder:(context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                            ),
                            child: SizedBox(
                              height: 52.0 * options.length,
                              width: BoxConstraints.biggest.width,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext , index) {
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
                          )
                      ),
                      optionsBuilder: (TextEditingValue textEditingValue) {

                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }

                        if(textEditingValue.text!=""){
                          getCity(textEditingValue.text.toString());
                        }
                        return
                          Stateslect.where((String option) {
                            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          dropdownValue3=selection;
                          //to aasign the controller value
                        });
                        debugPrint('You just selected $selection');
                      },
                      displayStringForOption: (Value){
                        return Value;
                      },
                    ),
              ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,right:width/27.32),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child:

              LayoutBuilder(
                builder: (BuildContext , BoxConstraints )=>
                    Autocomplete<String>(
                      optionsViewBuilder:(context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                            ),
                            child: SizedBox(
                              height: 52.0 * options.length,
                              width: BoxConstraints.biggest.width,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext , index) {
                                  final String option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(
                                        vertical: height/41.062,
                                        horizontal: width/85.375
                                      ),
                                      child: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                      ),
                      optionsBuilder: (TextEditingValue textEditingValue) {

                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }

                        if(textEditingValue.text!=""){
                          getCity(textEditingValue.text.toString());
                        }
                        return
                          _cities.where((String option) {
                            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          dropdownValue4=selection;
                          //to aasign the controller value
                        });
                        debugPrint('You just selected $selection');
                      },
                      displayStringForOption: (Value){
                        return Value;
                      },
                    ),
              ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,right: width/45.53),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: Pincode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding:
                EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                  border: InputBorder.none,
                ),
              ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: Mobileno,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                  border: InputBorder.none,
                ),
              ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,left:width/68.3),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: Mobileno2,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                  border: InputBorder.none,
                ),
              ),
              ),
            ),

          ],
        ),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/24.39,top:height/32.85),

              child: Text("EMail Id",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width/6.89,top:height/32.85),
              child: Text("GST Number",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding:  EdgeInsets.only(left: width/28.458,top: height/82.125,right: width/45.53),
              child: Container(
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                child:
                TextField(
                  controller: Supplieremail,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    border: InputBorder.none,

                  ),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top:height/65.7,right:width/27.32,left: 29),
              child: Container(width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                controller: Panno,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),

                  border: InputBorder.none,
                ),
              ),
              ),
            ),

          ],
        ),

        Padding(
          padding:  EdgeInsets.only(top:height/32.85,right: width/1.1383),
          child: Text("Remarks",style: GoogleFonts.poppins(fontSize:width/97.57,color: const Color(0xff000000)),),
        ),

        Padding(
          padding:  EdgeInsets.only(right: width/2.918,top: height/82.125),
          child: Container(height: height/7.3,
            width: width/1.70,
            //color: Color(0xffDDDEEE),
            decoration: BoxDecoration( color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(12)),child: TextField(
            controller: Remarks,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: GoogleFonts.poppins(fontSize:width/91.06,fontWeight: FontWeight.w700),
            decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3),
              hintStyle: GoogleFonts.poppins(color: Colors.black),
              border: InputBorder.none,
            ),
          ),
          ),
        ),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/20.088,top:height/32.85),
              child: GestureDetector(
                onTap: () {
                  Supplier();
                  showdialpogbox();
                  Future.delayed(Duration(seconds: 3),(){
                    setState(() {
                      suplierclick=false;
                    });
                    clearallcontroller();
                    Navigator.pop(context);
                  });
                },
                child: Container(width:width/8.6,
                  height: height/16.42,

                  decoration: BoxDecoration(
                    color: const Color(0xff25D366),
                    borderRadius:
                  BorderRadius.circular(5),),child: Center(child: Text("Save Supplier",style: GoogleFonts.poppins(color: Colors.white,fontSize:width/91.06),)),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                clearallcontroller();
              },
              child: Padding(
                padding:  EdgeInsets.only(left: width/75.888,top:height/32.85),
                child: Container(width: width/13.6,
                  height:  height/16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                ),
              ),
            ),
          ],
        ),
      ],

    );
  }

  Supplier(){
    FirebaseFirestore.instance.collection("Supplier").doc().set({
      "Suppliercode":Suppliercode.text,
      "SupplierAddress":SupplierAddress.text,
      "State":dropdownValue3,
      "City":dropdownValue4,
      "Pincode":Pincode.text,
      "Mobileno":Mobileno.text,
      "Mobileno2":Mobileno2.text,
      "Panno":Panno.text,
      "Remarks":Remarks.text,
      "Suppliername":Suppliername.text,
      "Email":Supplieremail.text,
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "Openingbalance":""
    });
  }

  clearallcontroller() {
     Suppliercode.clear();
     SupplierAddress.clear();
     State.clear();
     City.clear();
     Pincode.clear();
     Mobileno.clear();
     Mobileno2.clear();
     Panno.clear();
     Openingbalance.clear();
     Remarks.clear();
     Suppliername.clear();
     Supplieremail.clear();
    setState(() {
      dropdownValue1 = 'Numbers(NOS)';
      dropdownValue = 'Please Select Category';
    });
  }



  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top:height/4.760,bottom: height/4.760),
        child: SlideInLeft(
          animate: true,
          duration: const Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: const Color(0xff264656),
              content:
              SizedBox(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height: height/32.85,),
                    Text("Add a Supplier Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width:width/ 9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height:  height/32.85,),

                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //
                    //       },
                    //       child: Material(
                    //         elevation: 15,
                    //         color: Colors.red,
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Container(
                    //           height: height/16.425,
                    //           width: width/9.588,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.red,
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //                 "Okay",
                    //                 style: GoogleFonts.poppins(
                    //                     letterSpacing: 1.5,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: width/85.375, color: Colors.white)
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width:width/68.3),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //       child: Material(
                    //         elevation: 15,
                    //         color: const Color(0xff263646),
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Container(
                    //           height: height / 16.425,
                    //           width: width / 9.588,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.white,
                    //           ),
                    //           child: Center(
                    //             child: Text("Cancel",
                    //                 style: GoogleFonts.poppins(
                    //                     letterSpacing: 1.5,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: width / 85.375,
                    //                     color: Colors.black)),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }

  //delete function
  delete(suppilierid){
    FirebaseFirestore.instance.collection("Supplier").doc(suppilierid).delete();

  }
  //Barnd showpopup(delete popup)
  _suppilier(suppilierid){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder:(context) {

      return Padding(
        padding:  EdgeInsets.only(top: height/4.38,bottom: height/4.38,left: width/3.902,right:width/3.902),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:height/21.9),
                Text("Are You Sure Want to Delete",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:width/75.88
                ),),

                SizedBox(height:height/32.85),

                SizedBox(
                  height:height/3.65,
                  width:width/7.588,
                  child: Lottie.network(deletefile),
                ),
                SizedBox(height:height/32.8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        delete(suppilierid);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:height/16.425,
                        width:width/9.588,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xff25D366)
                        ),
                        child: Center(
                          child: Text("Okay",style: GoogleFonts.poppins(color:
                          Colors.white,fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    SizedBox(width:width/68.3),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Material(
                        elevation: 15,
                        color: const Color(0xff263646),
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height / 16.425,
                          width: width / 9.588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text("Cancel",
                                style: GoogleFonts.poppins(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 85.375,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      );
    },);
  }
  showdialpogboxss(streamid,) {
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
              padding:  EdgeInsets.only(top:height/65.7,bottom: height/65.7,left: width/6.83,right: width/6.83),
              child: Scaffold(
                backgroundColor:  Colors.white,
                body: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),

                  child: SingleChildScrollView(
                    child: Row(
                      children: [

                        SizedBox(
                          width: width/3.035,
                          height: height/1.095,
                          child: Lottie.network("https://assets8.lottiefiles.com/packages/lf20_j2hgsqs5.json"),
                        ),

                        SizedBox(
                          width: width/2.652,
                          child: Column(
                            children: [
                              SizedBox(height:height/65.7,),
                              Text("Supplier Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700),),
                              SizedBox(height:height/65.7,),

                              FutureBuilder<dynamic>(
                                future: FirebaseFirestore.instance.collection("Supplier").doc(streamid).get(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData==null){
                                    return Center(child: Container(),);
                                  }
                                  if(!snapshot.hasData){
                                    return Center(child: Container(),);
                                  }
                                  var purchase=snapshot.data.data();
                                  return
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: width/45.53),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Name :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              //height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Suppliername'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Code :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Suppliercode'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Address :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              //height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['SupplierAddress'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Mobile :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Mobileno'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Mobile-2 :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Mobileno2'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left: width/27.32),
                                              child: SizedBox(
                                                height:height/21.9,
                                                width:width/10.507,
                                                child: Text("Supplier Email :",style: GoogleFonts.poppins(),),
                                              ),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width: width/7.588,
                                              child: Text(purchase['Email'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),


                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier City :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['City'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Pincode :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Pincode'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Pan no :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              // height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Panno'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier State :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['State'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Balance :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text(purchase['Openingbalance'].toString(),style: GoogleFonts.poppins(),),
                                            ),
                                          ],
                                        ),

                                        SizedBox(width:width/136.6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height:height/21.9,
                                              width:width/10.507,
                                              child: Text("Supplier Remarks :",style: GoogleFonts.poppins(),),
                                            ),
                                            SizedBox(
                                              //height: height/10.95,
                                              width:width/10.507,
                                              child: Text(purchase['Remarks'].toString(),

                                                style: GoogleFonts.poppins(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    );
                                },),

                              SizedBox(
                                height:height/21.9,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Material(
                                  elevation: 15,
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height/18.77,
                                    width: width/8.537,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xff25D366),
                                    ),
                                    child: Center(
                                      child: Text("Okay",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
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

  List<Location> locations = [];
  String status = '';
  List<String> _cities = ["Choose City"];

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCity(state) async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == "🇮🇳    India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == state);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }
}

class Location {
  String name;
  String district;
  String region;
  String state;

  Location(this.name, this.district, this.region, this.state);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        json['Name'], json['District'], json['Region'], json['State']);
  }
}
