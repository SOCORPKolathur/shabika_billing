import 'dart:html';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LandingPage/LandingPage.dart';

class Stocks_Page extends StatefulWidget {
  const Stocks_Page({Key? key}) : super(key: key);

  @override
  State<Stocks_Page> createState() => _Stocks_PageState();
}

class _Stocks_PageState extends State<Stocks_Page> {

  bool status3=true;
  bool status4=false;


  List<String> caterorgey = [];
  List<String> brand = [];
  List<String> item = [];
  List<String> hsn = [];
  TextEditingController caterorgeycontroller = TextEditingController();
  TextEditingController brandcontroller = TextEditingController();
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController hsncontroller = TextEditingController();

  String catsearch="";
  String brandsearch="";
  String hsnsearch="";
  String itemsearch="";
  bool issearch= false;

  firstcall() async {
    var document = await FirebaseFirestore.instance
        .collection("category")
        .get();
    for (int i = 0; i < document.docs.length; i++) {
      setState(() {
        caterorgey.add(document.docs[i]['categoryname']);
      });
    }
    var document2 = await FirebaseFirestore.instance
        .collection("Brand")
        .get();
    for (int i = 0; i < document2.docs.length; i++) {
      setState(() {
        brand.add(document2.docs[i]['Brandname']);
      });
    }
    var document3 = await FirebaseFirestore.instance
        .collection("Item ShabikaG")
        .get();
    for (int i = 0; i < document3.docs.length; i++) {
      setState(() {
        item.add(document3.docs[i]['Newitemname']);
      });
    }
    var Document = await FirebaseFirestore.instance
        .collection('Hsncode')
        .orderBy("timestamp", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      hsn.add(Document.docs[i]['HSNCode']);
    }
  }

  @override
  void initState() {
    firstcall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return   Column(
      children: [
        SizedBox(
          height:height/43.8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: width / 91.06),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => drawer(" "),));
              },
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
            Padding(
              padding:  EdgeInsets.only(left: width/91.06),
              child: Text("Item Lists",
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/54.64),),
            ),

            //toggle switchs-add item
            Padding(
              padding:  EdgeInsets.only(left: width/4.583, right: width/56.916),
              child:
                 FlutterSwitch(
                        inactiveColor: const Color(0xffC9C9C9),
                        inactiveToggleColor: Colors.grey,
                        width: width/30.35,
                        height: height/32.85,
                        valueFontSize: 5.0,
                        toggleSize: 20.0,
                        value: status3,
                        borderRadius: 10.0,

                        padding: 2.0,
                        //showOnOff: true,
                        onToggle: (val) {

                          setState(() {
                            if(val==true) {
                              setState(() {
                                status3 = val;
                                status4 = false;
                              });
                            }
                            else{
                              setState(() {
                                status3 = val;
                              });
                            }
                          });
                        },
                      ),

            ),
            Text(
              "Shabika G-Item",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),

            SizedBox(width:width/136.6),
             FlutterSwitch(
                      inactiveColor: const Color(0xffC9C9C9),
                      inactiveToggleColor: Colors.grey,
                      width: width/30.35,
                      height: height/32.85,
                      valueFontSize: 5.0,
                      toggleSize: 20.0,
                      value: status4,
                      borderRadius: 10.0,

                      padding: 2.0,
                      //showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          if(val==true) {
                            setState(() {
                              status4 = val;
                              status3 = false;
                            });
                          }
                          else{
                            status4 = val;
                          }

                        });
                      },
                    ),
            SizedBox(width:width/136.6),
            Text(
              "Shabika N-Item",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),
          ],
        ),
        SizedBox(
          height:height/43.8,
        ),
        Row(
          children: [
            SizedBox(
              width: width / 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Name",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
                Container(
                  height: height / 21.9,
                  width: width / 7.506, // width: width / 3.415,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        issearch=true;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                      catsearch=val;
                      //issearch=true;
                      });
                      print(catsearch);
                    },
                    style: GoogleFonts.montserrat(
                        fontSize: width / 91.06, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: height / 43.8, left: width / 136.6)),
                    controller: caterorgeycontroller,
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
                Text(
                  "Brand Name",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
                Container(
                  height: height / 21.9,
                  width: width / 7.506, // width: width / 3.415,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        issearch=true;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        brandsearch=val;
                      });
                    },
                    style: GoogleFonts.montserrat(
                        fontSize: width / 91.06, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: height / 43.8, left: width / 136.6)),
                    controller: brandcontroller,
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
                Text(
                  "HSN Code",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
                Container(
                  height: height / 21.9,
                  width: width / 7.506, // width: width / 3.415,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        issearch=true;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        hsnsearch=val;
                      });
                    },
                    style: GoogleFonts.montserrat(
                        fontSize: width / 91.06, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: height / 43.8, left: width / 136.6)),
                    controller: hsncontroller,
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
                Text(
                  "Item Name",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 98.64),
                ),
                Container(
                  height: height / 21.9,
                  width: width / 4.506, // width: width / 3.415,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        issearch=true;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        itemsearch=val;
                      });
                    },
                    style: GoogleFonts.montserrat(
                        fontSize: width / 91.06, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            bottom: height / 43.8, left: width / 136.6)),
                    controller: itemcontroller,
                  ),
                ),
              ],
            ),


            SizedBox(
              width: width / 136.6,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  caterorgeycontroller.clear();
                  brandcontroller.clear();
                  itemcontroller.clear();
                  hsncontroller.clear();
                  catsearch="";
                  brandsearch="";
                  hsnsearch="";
                  itemsearch="";
                  issearch=false;

                });

              },
              child: Container(
                height: height / 21.9,
                width: width / 13.66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                child: Center(
                  child: Text(
                    "Clear",
                    style: GoogleFonts.montserrat(
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
          height:height/43.8,
        ),
        Container(
          height: height/1.194,
          width: width/1.00,
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
                    SizedBox(width:width/68.3,),
                    Container(
                        width:width/26.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Si.No",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                              overflow: TextOverflow.ellipsis
                          )),))),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Category",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Brand",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Itemcode",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("HSNCode",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                    Container(
                        width:width/6.8,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Item Name",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))
                    ),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("BoxNo",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Purchase\nprice",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Landing\ncost",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),







                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Saleprice",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),


                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("MRPPrice",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/26.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Low\norder",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/26.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("GST",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/26.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Total\nQty",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/11.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Actions",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8),textStyle: const TextStyle(
                              overflow: TextOverflow.ellipsis
                          )),)))



                  ],
                ),

                StreamBuilder<QuerySnapshot>(
                  stream:status3==true?FirebaseFirestore.instance.collection("Item ShabikaG").orderBy("timestamp",descending: false).snapshots():
                      status4==true?FirebaseFirestore.instance.collection("Item ShabikaN").orderBy("timestamp",descending: false).snapshots():
                  FirebaseFirestore.instance.collection("Item").orderBy("timestamp",descending: false).snapshots(),
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
                        if (catsearch != "" || brandsearch != "" ||
                            hsnsearch != "" || itemsearch != "") {
                          if (catsearch != "" && brandsearch == "" &&
                              hsnsearch == "" && itemsearch == "") {
                            if (buillin1['Category'].toString()
                                .toLowerCase()
                                .contains(catsearch.toLowerCase()))
                              return Row(
                                children: [
                                  SizedBox(width: width / 68.3,),
                                  Container(
                                      width:width/26.38,
                                      height:height/13.0,
                                      decoration:BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text((index+1).toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,textStyle: const TextStyle(
                                            overflow: TextOverflow.ellipsis
                                        )),))),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Category'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Brand'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Itemcode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['HSNCode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 6.8,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Text(
                                        buillin1['Newitemname'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),)
                                  ),


                                  //Category


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['BoxNo'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Purchaseprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Landingcost'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Saleprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['MRPPrice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Loworder'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['gst'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['TotalQuvantity'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 11.38,
                                      height: height / 13.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child:

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showdialpogbox(buillin1.id);
                                            },
                                            child: Material(
                                              elevation: 10,
                                              color: Colors.green,
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                              child: Container(
                                                  width: width / 13.66,
                                                  height: height / 21.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(100),
                                                      color: Colors.green
                                                  ),
                                                  child: Center(child: Text(
                                                    "View", style: GoogleFonts
                                                      .montserrat(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors
                                                          .white),))),
                                            ),
                                          ),
                                        ],
                                      )
                                  )


                                ],
                              );
                          }
                          if (catsearch == "" && brandsearch != "" &&
                              hsnsearch == "" && itemsearch == "") {
                            if (buillin1['Brand'].toString()
                                .toLowerCase()
                                .contains(brandsearch.toLowerCase()))
                              return Row(
                                children: [
                                  SizedBox(width: width / 68.3,),
                                  Container(
                                      width:width/26.38,
                                      height:height/13.0,
                                      decoration:BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text((index+1).toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,textStyle: const TextStyle(
                                            overflow: TextOverflow.ellipsis
                                        )),))),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Category'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Brand'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Itemcode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['HSNCode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 6.8,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Text(
                                        buillin1['Newitemname'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),)
                                  ),


                                  //Category


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['BoxNo'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Purchaseprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Landingcost'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Saleprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['MRPPrice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Loworder'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['gst'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['TotalQuvantity'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 11.38,
                                      height: height / 13.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child:

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showdialpogbox(buillin1.id);
                                            },
                                            child: Material(
                                              elevation: 10,
                                              color: Colors.green,
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                              child: Container(
                                                  width: width / 13.66,
                                                  height: height / 21.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(100),
                                                      color: Colors.green
                                                  ),
                                                  child: Center(child: Text(
                                                    "View", style: GoogleFonts
                                                      .montserrat(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors
                                                          .white),))),
                                            ),
                                          ),
                                        ],
                                      )
                                  )


                                ],
                              );
                          }
                          if (catsearch == "" && brandsearch == "" &&
                              hsnsearch != "" && itemsearch == "") {
                            if (buillin1['HSNCode'].toString()
                                .toLowerCase()
                                .contains(hsnsearch.toLowerCase()))
                              return Row(
                                children: [
                                  SizedBox(width: width / 68.3,),
                                  Container(
                                      width:width/26.38,
                                      height:height/13.0,
                                      decoration:BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text((index+1).toString(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,textStyle: const TextStyle(
                                            overflow: TextOverflow.ellipsis
                                        )),))),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Category'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Brand'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Itemcode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['HSNCode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 6.8,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Text(
                                        buillin1['Newitemname'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),)
                                  ),


                                  //Category


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['BoxNo'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Purchaseprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Landingcost'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Saleprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['MRPPrice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Loworder'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['gst'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['TotalQuvantity'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 11.38,
                                      height: height / 13.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child:

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showdialpogbox(buillin1.id);
                                            },
                                            child: Material(
                                              elevation: 10,
                                              color: Colors.green,
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                              child: Container(
                                                  width: width / 13.66,
                                                  height: height / 21.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(100),
                                                      color: Colors.green
                                                  ),
                                                  child: Center(child: Text(
                                                    "View", style: GoogleFonts
                                                      .montserrat(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors
                                                          .white),))),
                                            ),
                                          ),
                                        ],
                                      )
                                  )


                                ],
                              );
                          }
                          if (catsearch == "" && brandsearch == "" &&
                              hsnsearch == "" && itemsearch != "") {
                            if (buillin1['Newitemname'].toString()
                                .toLowerCase()
                                .contains(itemsearch.toLowerCase())) {
                              return Row(
                                children: [
                                  SizedBox(width: width / 68.3,),
                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(
                                          child: Text((index + 1).toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                textStyle: const TextStyle(
                                                    overflow: TextOverflow
                                                        .ellipsis
                                                )),))),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Category'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Brand'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Itemcode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['HSNCode'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 6.8,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Text(
                                        buillin1['Newitemname'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),)
                                  ),


                                  //Category


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['BoxNo'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),


                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Purchaseprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),
                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Landingcost'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Saleprice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 15.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['MRPPrice'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['Loworder'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['gst'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 26.38,
                                      height: height / 13.0,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width / 683,
                                          vertical: height / 328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child: Center(child: Text(
                                        buillin1['TotalQuvantity'].toString(),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600),))
                                  ),

                                  Container(
                                      width: width / 11.38,
                                      height: height / 13.0,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1.2)
                                      ),
                                      child:

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showdialpogbox(buillin1.id);
                                            },
                                            child: Material(
                                              elevation: 10,
                                              color: Colors.green,
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                              child: Container(
                                                  width: width / 13.66,
                                                  height: height / 21.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(100),
                                                      color: Colors.green
                                                  ),
                                                  child: Center(child: Text(
                                                    "View", style: GoogleFonts
                                                      .montserrat(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors
                                                          .white),))),
                                            ),
                                          ),
                                        ],
                                      )
                                  )


                                ],
                              );
                            }
                            else{
                              return Container();
                            }
                          }
                          else{
                            return Container();
                          }
                        }
                        else {
                            return Row(
                              children: [
                                SizedBox(width: width / 68.3,),
                                Container(
                                    width:width/26.38,
                                    height:height/13.0,
                                    decoration:BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2)
                                    ),
                                    child: Center(child: Text((index+1).toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,textStyle: const TextStyle(
                                          overflow: TextOverflow.ellipsis
                                      )),))),
                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Category'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Brand'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Itemcode'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),
                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['HSNCode'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 6.8,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Text(
                                      buillin1['Newitemname'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),)
                                ),


                                //Category


                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['BoxNo'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),


                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Purchaseprice'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),
                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Landingcost'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Saleprice'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 15.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['MRPPrice'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 26.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['Loworder'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 26.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(
                                        child: Text(buillin1['gst'].toString(),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 26.38,
                                    height: height / 13.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 683,
                                        vertical: height / 328.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child: Center(child: Text(
                                      buillin1['TotalQuvantity'].toString(),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600),))
                                ),

                                Container(
                                    width: width / 11.38,
                                    height: height / 13.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2)
                                    ),
                                    child:

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showdialpogbox(buillin1.id);
                                          },
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                                100),
                                            child: Container(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(100),
                                                    color: Colors.green
                                                ),
                                                child: Center(child: Text(
                                                  "View",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors.white),))),
                                          ),
                                        ),
                                      ],
                                    )
                                )


                              ],
                            );
                          }
                      },);
                  },
                ),
                SizedBox(height:height/10.7,),
              ],
            ),
          ),
        ),
      ],
    );
  }


  showdialpogbox(streamid,) {

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
              padding:  EdgeInsets.only(top: height/136.6,bottom:height/136.6,left: width/45.53,right: width/45.53),
              child: Scaffold(

                body:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height:height/65.7,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width/2.4,),
                            Text("History Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700),),
                            SizedBox(width: width/2.4,),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: ClipOval(
                                child: Container(
                                  height: height/26.28,
                                  width:width/ 54.64,
                                  color: Colors.red,
                                  child: const Center(child: Icon(Icons.clear,color: Colors.white,)),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height:height/65.7,),





                        Row(
                          children: [
                            SizedBox(width:width/136.6,),
                            Container(
                              width:width/ 27.32,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Si.No",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(

                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Date\nTime",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Supplier\nID',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(

                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Supplier\nName',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(
                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Supplier\nInvoice No',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(
                              width: width/22.76,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Hsn\nCode',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/17.075,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Item\nID",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              width:width/ 10.507,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Description',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),



                            Container(
                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Payment',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(

                              width:width/ 45.53,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Qty",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),



                            Container(

                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Credit\nDays',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(

                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Purchase\nNote',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),
                            Container(

                              width: width/27.32,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Tax',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              width:width/ 10.507,

                              child: Center(child: Text("Total",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                            ),



                            SizedBox(width:width/136.6,),



                          ],
                        ),

                        SizedBox(
                          height: height/1.46,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: status3==true?
                            FirebaseFirestore.instance.collection("Item ShabikaG").doc(streamid).collection("Histroy").orderBy("timestamp",descending: true).snapshots():
                                status4==true?
                                FirebaseFirestore.instance.collection("Item ShabikaN").doc(streamid).collection("Histroy").orderBy("timestamp",descending: true).snapshots()
                                :FirebaseFirestore.instance.collection("Item").doc(streamid).collection("Histroy").orderBy("timestamp",descending: true).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData==null){
                                return Center(child: Container(),);
                              }
                              if(!snapshot.hasData){
                                return Center(child: Container(),);
                              }

                              return
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var purchase=snapshot.data!.docs[index];
                                    return  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width:width/136.6,),
                                        Container(
                                          width: width/27.32,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text("${index+1}",style: GoogleFonts.poppins(),)),
                                        ),
                                        Container(

                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text("${purchase['date']}\n${purchase['time']}".toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['suppilerid'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['suppilername'].toString(),style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['suppilierinvoiceno'].toString(),style: GoogleFonts.poppins(),)),
                                        ),
                                        Container(
                                          width: width/22.76,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['Hsncode'].toString(),style: GoogleFonts.poppins(),)),
                                        ),



                                        Container(
                                          width:width /17.075,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text("${purchase['purchaseno']}",style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          width: width/10.507,
                                          height:height/13.14,
                                          padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['Description'].toString(),style: GoogleFonts.poppins(),)),
                                        ),



                                        Container(
                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['Payment mode'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/45.53,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),

                                          child: Center(child: Text(purchase["Qty"].toString(),style: GoogleFonts.poppins(),)),
                                        ),




                                        Container(

                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['credit days'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/13.66,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['purchasenote'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width:width/ 27.32,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text(purchase['tax'].toString(),style: GoogleFonts.poppins(),)),
                                        ),



                                        Container(

                                          width:width/ 10.507,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2)
                                          ),
                                          child: Center(child: Text("${purchase['Total']}".toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                      ],
                                    );
                                  },);
                            },),
                        ),


                        SizedBox(height:height/65.7),

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


}
