import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'LandingPage/LandingPage.dart';

class Stocks_Page extends StatefulWidget {
  const Stocks_Page({Key? key}) : super(key: key);

  @override
  State<Stocks_Page> createState() => _Stocks_PageState();
}

class _Stocks_PageState extends State<Stocks_Page> {

  bool status3=true;
  bool status4=false;

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => drawer(),));
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
                        inactiveColor: Color(0xffC9C9C9),
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
                      inactiveColor: Color(0xffC9C9C9),
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
                    SizedBox(width:width/68.3,),

                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Item Name",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))
                    ),




                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Category",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),




                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Brand",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),




                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Itemcode",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),




                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("BoxNo",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),




                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("HSNCode",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Landing\ncost",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Purchase\nprice",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Saleprice",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),


                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("MRPPrice",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8),textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Loworder",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8),textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("GST",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8),textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),

                    Container(
                        width:width/15.38,
                        height:height/13.0,
                        decoration:BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2)
                        ),
                        child: Center(child: Text("Total\nQuvantity",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8),textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        )),))),



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
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          Row(
                            children: [
                              SizedBox(width:width/68.3,),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Newitemname'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              //Category
                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Category'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Brand'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Itemcode'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['BoxNo'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['HSNCode'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Landingcost'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Purchaseprice'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Saleprice'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['MRPPrice'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Loworder'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['gst'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              Container(
                                  width:width/15.38,
                                  height:height/13.0,padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['TotalQuvantity'].toString(),
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))
                              ),

                              SizedBox(width:width/68.3,),

                              InkWell(
                                onTap: (){
                                  showdialpogbox(buillin1.id);
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
                          );
                      },);
                  },
                ),
                SizedBox(height:height/65.7,),
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
      context: context,
      builder: (context) {
        return SlideInLeft(
            animate: true,
            duration: Duration(milliseconds: 800),
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
                    child: Container(
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
                                    child: Center(child: Icon(Icons.clear,color: Colors.white,)),
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
                                child: Center(child: Text("Si.No",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/17.075,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text("Item\nPurch No",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width:width/ 10.507,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Description',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/22.76,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Hsn\nCode',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Payment',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(

                                width:width/ 45.53,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text("Qty",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Supplier\nInvoice No',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Supplier\nID',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(

                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Supplier\nName',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(

                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Credit\nDays',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(

                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Purchase\nNote',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(

                                width: width/27.32,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text('Tax',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(

                                width: width/13.66,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text("Date\nTime",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),
                              Container(
                                height:height/13.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                width:width/ 10.507,

                                child: Center(child: Text("Total",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                              ),



                              SizedBox(width:width/136.6,),



                            ],
                          ),

                          SizedBox(
                            height: height/1.46,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: status3==true?
                              FirebaseFirestore.instance.collection("Item ShabikaG").doc(streamid).collection("Histroy").snapshots():
                                  status4==true?
                                  FirebaseFirestore.instance.collection("Item ShabikaN").doc(streamid).collection("Histroy").snapshots()
                                  :FirebaseFirestore.instance.collection("Item").doc(streamid).collection("Histroy").snapshots(),
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
                                            width: width/22.76,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2)
                                            ),
                                            child: Center(child: Text(purchase['Hsncode'].toString(),style: GoogleFonts.poppins(),)),
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
                                            child: Center(child: Text(purchase['suppilierinvoiceno'].toString(),style: GoogleFonts.poppins(),)),
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

                                            width: width/13.66,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2)
                                            ),
                                            child: Center(child: Text("${purchase['date']}\n${purchase['time']}".toString(),style: GoogleFonts.poppins(),)),
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
              ),
            )
        );
      },
    );
  }
}
