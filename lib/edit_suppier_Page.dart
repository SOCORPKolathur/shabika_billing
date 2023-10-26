import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:shabika_billing/stmodel.dart' as StatusModel;





class Edit_suppiler_Paghe extends StatefulWidget {
  String ?docid;
  Edit_suppiler_Paghe(this.docid);

  @override
  State<Edit_suppiler_Paghe> createState() => _Edit_suppiler_PagheState();
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
class _Edit_suppiler_PagheState extends State<Edit_suppiler_Paghe> {


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
  TextEditingController States=TextEditingController();
  TextEditingController city=TextEditingController();

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
    getsuppilerdata();
    // TODO: implement initState
    super.initState();
  }
getsuppilerdata()async{
    var Suppielrdata=await FirebaseFirestore.instance.collection("Supplier").doc(widget.docid).get();
    Map<String,dynamic>?value=Suppielrdata.data();
    setState(() {
      Suppliercode.text=value!["Suppliercode"];
      SupplierAddress.text=value["SupplierAddress"];
      States.text=value["State"];
      city.text=value["City"];
      Pincode.text=value["Pincode"];
      Mobileno.text=value["Mobileno"];
      Mobileno2.text=value["Mobileno2"];
      Panno.text=value["Panno"];
      Suppliername.text=value["Suppliername"];
      Supplieremail.text=value["Email"];
     // Remarks.text=value!["Openingbalance"];

    });
}
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body:
      Column(
        children: [

          Row(
            children: [
              SizedBox(
                width: width/91.06,
              ),
              InkWell(
                onTap: () {
                Navigator.pop(context);
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
                    style: GoogleFonts.poppins(fontSize:width/91.06),
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
                  style: GoogleFonts.poppins(fontSize: 10),
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
                  style: GoogleFonts.poppins(fontSize:width/91.06),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,
                      bottom:height/82.125),
                    hintText: "Suppiler Address",
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


                  TextField(
                    controller: States,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize:width/91.06),
                    decoration: InputDecoration(contentPadding:
                    EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top:height/65.7,right:width/27.32),
                child: Container(width: width/6.83,
                  height: height/16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child:TextField(
                      controller: city,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.poppins(fontSize:width/91.06),
                      decoration: InputDecoration(contentPadding:
                      EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),

               /* LayoutBuilder(
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
                ),*/
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
                  style: GoogleFonts.poppins(fontSize:width/91.06),
                  decoration: InputDecoration(contentPadding:
                  EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    hintText: "",
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
                  style: GoogleFonts.poppins(fontSize:width/91.06),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    hintText: "Mobile No 1",
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
                  style: GoogleFonts.poppins(fontSize:width/91.06),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    hintText: "Mobile No 2",
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
                    style: GoogleFonts.poppins(fontSize:width/91.06),
                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                      border: InputBorder.none,  hintText: "Email",

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
                  style: GoogleFonts.poppins(fontSize:width/91.06),
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                    hintText: "Gst No",
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
              style: GoogleFonts.poppins(fontSize:width/91.06),
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

                    showdialpogbox();
                  },
                  child: Container(width:width/8.6,
                    height: height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xff25D366),),child: Center(child: Text("Save Supplier",style: GoogleFonts.poppins(color: Colors.white,fontSize:width/91.06),)),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  clearallcontroller();
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: width/75.888,top:height/32.85),
                  child: Container(child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                    width: width/13.6,
                    height:  height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color:  Colors.red,),
                  ),
                ),
              ),
            ],
          ),
        ],

      )
    );
  }

  Supplier(){
    FirebaseFirestore.instance.collection("Supplier").doc(widget.docid).update({
      "Suppliercode":Suppliercode.text,
      "SupplierAddress":SupplierAddress.text,
      "State":States.text,
      "City":city.text,
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
   States.clear();
    city.clear();
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
                    Text("Add a Supplier Item Successfully",style: GoogleFonts.poppins(
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

                    Row(
                      children: [
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
                              height: height/16.425,
                              width: width/9.588,
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
                                        fontSize: width/85.375, color: Colors.white)
                                ),
                              ),
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
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 85.375,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )


                  ],
                ),

              )
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

