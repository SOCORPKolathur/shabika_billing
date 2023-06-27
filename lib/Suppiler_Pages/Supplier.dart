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
  TextEditingController Suppliername=new TextEditingController();
  TextEditingController Supplieremail=new TextEditingController();
  TextEditingController Suppliercode=new TextEditingController();
  TextEditingController SupplierAddress=new TextEditingController();
  TextEditingController State=new TextEditingController();
  TextEditingController City=new TextEditingController();
  TextEditingController Pincode=new TextEditingController();
  TextEditingController Mobileno=new TextEditingController();
  TextEditingController Mobileno2=new TextEditingController();
  TextEditingController Panno=new TextEditingController();
  TextEditingController Openingbalance=new TextEditingController();
  TextEditingController Remarks=new TextEditingController();

  NumberFormat F=new NumberFormat('00');
  int itemcodes=0;

  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Supplier").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"SB"}${F.format(itemcodes)}";
    });
    print(Suppliercode.text);

  }
  String dropdownValue3 = "";
  String dropdownValue4 = "";

  @override
  void initState() {
    itemcodegenrate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
    suplierclick==false?
      Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 20),
              child: Text(
                "Supplier",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 100,),
            Padding(
              padding: const EdgeInsets.only(left: 1008.0, top: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => drawer(),
                  ));
                },
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Home",
                          style: GoogleFonts.cairo(
                              color: Color(0xffFFFFFF), fontSize: 23),
                        ),
                      )
                    ],
                  ),
                  width: width / 11.38,
                  height: height / 16.425,
                  // color: Color(0xff00A99D),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff00A99D),
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset("assets/Line13.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 1208.0),
          child: Text("Search",
              style:
                  GoogleFonts.cairo(fontSize: width/68.3, fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left:width/28.458, right: width/34.15),
              child: Container(
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: width/68.3),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: width/68.3, bottom: 8),
                    border: InputBorder.none,
                    suffix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/search.png"),
                    ),
                  ),
                ),

                width: width / 3.90,
                height: height / 16.425,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffFFFFFF),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 1.0, left: 15, right: 20),
                          child: Container(
                            child: Icon(Icons.add, color: Colors.teal),
                            width: width / 56.91,
                            height: height / 27.37,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.white,
                            ),
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
                width: width / 5.464,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff00A99D),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 32.0, right: width/34.15),
                          child: Text("Sl.no",
                              style: GoogleFonts.cairo(
                                  color: Color(0xff00A99D), fontSize: width/68.3)),
                        ),
                        Text("Supplier Name",
                            style: GoogleFonts.cairo(
                                color: Color(0xff00A99D), fontSize: width/68.3)),
                        Padding(
                          padding:  EdgeInsets.only(left: width/1.985, right: width/19.514),
                          child: Text("Edit",
                              style: GoogleFonts.cairo(
                                  color: Color(0xff00A99D), fontSize: width/68.3)),
                        ),
                        Text("Delete",
                            style: GoogleFonts.cairo(
                                color: Color(0xff00A99D), fontSize: width/68.3)),
                        Padding(
                          padding:  EdgeInsets.only(left: width/15.523),
                          child: Text("Status",
                              style: GoogleFonts.cairo(
                                  color: Color(0xff00A99D), fontSize: width/68.3)),
                        ),
                      ],
                    ),
                    width: width / 1.03,
                    height: height / 16.42,
                    // color: Color(0xff00A99D),
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                  ),

                  //Supplier stream
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Supplier")
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
                          return Row(
                            children: [

                              //index (Serial number)
                              Padding(
                                padding: const EdgeInsets.only(right: .0),
                                child: Container(
                                  child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width/75.888,
                                            color: Color(0xffFDFDFD)),
                                      )),
                                  height: height / 13.14,
                                  width: width / 13.66,
                                  // color: Colors.grey,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                ),
                              ),

                              //name text
                              Container(
                                child: Padding(
                                  padding:  EdgeInsets.only(
                                      left: width/75.888, top: height/131.4),
                                  child: Text(
                                    snapshot.data!.docs[index]
                                    ["Suppliername"],
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width/75.888,
                                        color: Color(0xffFDFDFD)),
                                  ),
                                ),
                                height: height / 13.14,
                                width: width / 1.70,
                                decoration: BoxDecoration(
                                    color: Color(0xff00A99D),
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.red,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.red,
                                      ),
                                    )),
                              ),

                              //edit icon(img)
                              Container(
                                  child: Image.asset("assets/edit.png"),
                                  height: height / 13.14,
                                  width: width / 12.64,
                                  // color: Colors.grey,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ))),//


                              //delete icon (img)
                              InkWell(
                                onTap:(){
                                  _suppilier(snapshot.data!.docs[index].id);
                                },
                                child: Container(
                                    child: Image.asset("assets/delete.png"),
                                    height: height / 13.14,
                                    width: width / 12.41,
                                    // color: Colors.grey,
                                    decoration: BoxDecoration(
                                        color: Color(0xff00A99D),
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.red,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ))),
                              ),

                              //active text
                              Container(
                                  child: Center(
                                      child: Text(
                                        "Active",
                                        style: GoogleFonts.cairo(
                                            fontSize: width/75.888,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffFDFDFD)),
                                      )),
                                  height: height / 13.14,
                                  width: width / 6.83,
                                  // color: Colors.grey,
                                  decoration: BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ))),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff00A99D),
                border: Border.all(color: Colors.red)),

            width: width / 1.03,

            height: height / 1.87,

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
              width: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  suplierclick = false;
                });
                print(height);
                print(width);
              },
              child: Tooltip(
                message: "Back",
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  shadowColor: Colors.indigo,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 1108.0,top: 10,bottom: 10),
              child: Text(
                "Add New Supplier",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, fontSize: 23,color: Color(0xffFFFFFF)),
              ),
            ),
          ],
        ),

        Image.asset("assets/Line13.png"),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 65.0,top: 8),
              child: Text("Supplier Name *",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 144.0,top: 8),
              child: Text("Supplier Code*",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140.0,top: 8),
              child: Text("Supplier Address *",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 53.0,top: 10,right: 60),
              child: Container(
                child:
                TextField(
                  controller: Suppliername,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                    border: InputBorder.none,
                  ),
                ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: 10.0,),
              child:
              Container(child: TextField(
                controller: Suppliercode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 10),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  border: InputBorder.none,
                ),
              ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 50),
              child: Container(child: TextField(
                controller: SupplierAddress,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "Suppiler Address",
                  border: InputBorder.none,
                ),
              ),
                width: width/2.55,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 58.0,top: 20),
              child: Text("State",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 218.0,top: 20),
              child: Text("City",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 228.0,top: 20),
              child: Text("Pincode",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 168.0,top: 20),
              child: Text("Mobile Number",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 110.0,top: 20),
              child: Text("Mobile Number-2",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 60,left: 50),
              child: Container(child:
              LayoutBuilder(
                builder: (BuildContext , BoxConstraints )=>
                    Autocomplete<String>(
                      optionsViewBuilder:(context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                            ),
                            child: Container(
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
             /* DropdownButton<String>(
                value: dropdownValue3,
                isExpanded: true,
                style:  TextStyle(color: Colors.black, fontSize: width/105.07),
                underline: Container(
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue3 = value!;
                  });
                },

                items:
                Stateslect.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),*/
             /* TextField(
                controller:  State,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "State",
                  border: InputBorder.none,
                ),
              ),*/
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 50),
              child: Container(child: LayoutBuilder(
                builder: (BuildContext , BoxConstraints )=>
                    Autocomplete<String>(
                      optionsViewBuilder:(context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                            ),
                            child: Container(
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
              /*TextField(
                controller: City,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "",
                  border: InputBorder.none,
                ),
              ),

               */
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 30),
              child: Container(child: TextField(
                controller: Pincode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "",
                  border: InputBorder.none,
                ),
              ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(child: TextField(
                controller: Mobileno,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "Mobile No 1",
                  border: InputBorder.none,
                ),
              ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 20),
              child: Container(child: TextField(
                controller: Mobileno2,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "Mobile No 2",
                  border: InputBorder.none,
                ),
              ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 56.0,top: 20),

              child: Text("EMail Id",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 198.0,top: 20),
              child: Text("GST Number",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),

          ],
        ),

        Row(
          children: [

            Padding(
              padding:  EdgeInsets.only(left: width/28.458,top: 8,right: 30),
              child: Container(
                child:
                TextField(
                  controller: Supplieremail,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                    border: InputBorder.none,  hintText: "Email",

                  ),
                ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 50,left: 29),
              child: Container(child: TextField(
                controller: Panno,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "Gst No",
                  border: InputBorder.none,
                ),
              ),
                width: width/6.83,
                height: height/16.42,
                //color: Color(0xffDDDEEE),
                decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
              ),
            ),

          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20.0,right: 1200),
          child: Text("Remarks",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 468.0,top: 8),
          child: Container(child: TextField(
            controller: Remarks,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: GoogleFonts.poppins(fontSize: 15),
            decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20),
              hintStyle: GoogleFonts.poppins(color: Colors.black),
              border: InputBorder.none,
            ),
          ),
            height: height/7.3,
            width: width/1.70,
            //color: Color(0xffDDDEEE),
            decoration: BoxDecoration( color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(12)),
          ),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 68.0,top: 20),
              child: GestureDetector(
                onTap: () {

                  showdialpogbox();
                },
                child: Container(child: Center(child: Text("Save Supplier",style: GoogleFonts.poppins(color: Colors.white,fontSize: 15),)),
                  width:width/8.6,
                  height: height/16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Color(0xffD60A0B),),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                clearallcontroller();
              },
              child: Padding(
                padding:  EdgeInsets.only(left: width/75.888,top: 20),
                child: Container(child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                  width: width/13.6,
                  height:  height/16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Color(0xff00A0E3),),
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
        padding: const EdgeInsets.only(top: 138.0,bottom: 138.0),
        child: SlideInLeft(
          animate: true,
          duration: Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Color(0xff264656),
              content:
              Container(
                width: 350,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Add a Supplier Item Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: 20,),
                    Container(
                      height: 150,
                      width: 150,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        Supplier();
                        clearallcontroller();
                        Navigator.pop(context);
                        setState(() {
                          suplierclick=false;
                        });
                      },
                      child: Material(
                        elevation: 15,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 40,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                                "Okay",
                                style: GoogleFonts.poppins(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16, color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    )


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

    return showDialog(context: context, builder:(context) {

      return Padding(
        padding: const EdgeInsets.only(top: 150.0,bottom: 150,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:30),
                Text("Are You Sure Want to Delete",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:18
                ),),

                SizedBox(height:20),

                Container(
                  height:180,
                  width:180,
                  child: Lottie.network(deletefile),
                ),
                SizedBox(height:20),
                InkWell(
                  onTap: (){
                    delete(suppilierid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height:40,
                    width:180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xff263646)
                    ),
                    child: Center(
                      child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    },);
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
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    print(_cities);
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
