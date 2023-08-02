import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Edit_billing_Page.dart';


class Reports_Page extends StatefulWidget {
  const Reports_Page({Key? key}) : super(key: key);

  @override
  State<Reports_Page> createState() => _Reports_PageState();
}

class _Reports_PageState extends State<Reports_Page> {
  int select = 0;
  //toggle switch boolean
  bool status=true;
  bool status2=false;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Column(
      children: [
        SizedBox(
          height: height/43.8,
        ),
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/91.06),
              child: Text(" Sales Reports",
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/54.64),),
            ),

            //toggle switchs
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
                        status2 = false;
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
              "Shabika G",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/45.583, right: width/56.916),
              child: FlutterSwitch(
                inactiveColor: Color(0xffC9C9C9),
                inactiveToggleColor: Colors.grey,
                width: width/30.35,
                height: height/32.85,
                valueFontSize: 5.0,
                toggleSize: 20.0,
                value: status2,
                borderRadius: 10.0,

                padding: 2.0,
                //showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    if(val==true) {
                      setState(() {
                        status2 = val;
                        status = false;
                      });
                    }
                    else{
                      setState(() {
                        status2 = val;
                      });
                    }
                  });
                },
              ),
            ),

            Text(
              "Shabika N",
              style: GoogleFonts.solway(color: Colors.white, fontSize:width/80.353),
            ),
          ],
        ),
        SizedBox(
          height: height/43.8,
        ),

        Container(
          height:height/ 1.194,
          width: width/1.050,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(4),
           color: Colors.white,
         ),
          
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height/65.7,),
                Padding(
                  padding:  EdgeInsets.only(left: width/273.2),
                  child: Row(
                    children: [

                      Container(
                          width:width/15.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),

                          ),
                          child: Center(child: Text('Invoice No',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/7.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Customer name',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/6.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Customer phone',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/5.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Customer address',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/11.383,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Date',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/10.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Bill Type',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                      Container(
                          width:width/15.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Total',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),


                    ],
                  ),
                ),
                status==true?
                Padding(
                  padding:  EdgeInsets.only(left: width/273.2),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("billing ShabikaG").orderBy("timestamp",descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData==null){
                        return Center(child: Container());
                      }
                      if(!snapshot.hasData){
                        return Center(child: Container());
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          var buillin1=snapshot.data!.docs[index];
                          return
                          buillin1['save']==true?
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/15.588,
                                    child:
                                    Center(child:
                                    Text("${buillin1['purchaseno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    ))),

                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/7.588,
                                    child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width:width/ 45.53,),

                                Container(
                                    width:width/6.0,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['customerphone'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/ 45.53,),

                                Container(
                                    width:width/5.0,
                                    padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['customeraddress'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/27.32,),

                                Container(
                                    width:width/11.383,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/22.76,),

                                Container(
                                    width:width/10.0,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/27.32,),

                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/15.0,
                                    child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: width/130.32,),

                                InkWell(
                                  onTap: (){
                                    showdialpogbox(
                                      buillin1.id,
                                      buillin1['customername'],
                                      buillin1['customerphone'],
                                      buillin1['purchasedate'],
                                      buillin1['time'],
                                      buillin1['Payment mode'],
                                      buillin1['customeraddress'],
                                      buillin1['Discountamount'],
                                      buillin1['Discountamountpercentage'],);
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width:width/15.66,
                                        height:height/21.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.green
                                        ),
                                        child: Center(child: Text("View",style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600,
                                            color: Colors.white),))),
                                  ),
                                ),

                                SizedBox(width:width/136.6,),
                                //edit button
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
                                  },
                                  child: Material(
                                    elevation: 10,

                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width:width/45.53,
                                        height:height/21.9,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),

                                        ),
                                        child: Center(child: Icon(Icons.edit,color:
                                        Colors.black,size:width/68.3))),
                                  ),
                                ),

                              ],
                            ):SizedBox();
                        },);
                    },
                  ),
                ):
                status2==true?
                Padding(
                  padding:  EdgeInsets.only(left: width/273.2),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("billing ShabikaN").orderBy("timestamp",descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData==null){
                        return Center(child: Container());
                      }
                      if(!snapshot.hasData){
                        return Center(child: Container());
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          var buillin1=snapshot.data!.docs[index];
                          return
                            buillin1['save']==true?
                            Row(
                              children: [


                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/15.588,
                                    child:
                                    Center(child:
                                    Text("${buillin1['purchaseno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ))),

                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/7.588,
                                    child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width:width/ 45.53,),

                                Container(
                                    width:width/6.0,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['customerphone'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/ 45.53,),

                                Container(
                                    width:width/5.0,
                                    padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['customeraddress'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/27.32,),

                                Container(
                                    width:width/11.383,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/22.76,),

                                Container(
                                    width:width/10.0,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                //SizedBox(width: width/27.32,),

                                Container(
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                    height:height/12.14 ,
                                    width:width/15.0,
                                    child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: width/130.32,),

                                InkWell(
                                  onTap: (){
                                    showdialpogbox(
                                      buillin1.id,
                                      buillin1['customername'],
                                      buillin1['customerphone'],
                                      buillin1['purchasedate'],
                                      buillin1['time'],
                                      buillin1['Payment mode'],
                                      buillin1['customeraddress'],
                                      buillin1['Discountamount'],
                                      buillin1['Discountamountpercentage'],);


                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width:width/15.66,
                                        height:height/21.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.green
                                        ),
                                        child: Center(child: Text("View",style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600,
                                            color: Colors.white),))),
                                  ),
                                ),

                                SizedBox(width:width/136.6,),
                                //edit button
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
                                  },
                                  child: Material(
                                    elevation: 10,

                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width:width/45.53,
                                        height:height/21.9,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),

                                        ),
                                        child: Center(child: Icon(Icons.edit,color:
                                        Colors.black,size:width/68.3))),
                                  ),
                                ),

                              ],
                            ):SizedBox();
                        },);
                    },
                  ),
                ):
                Padding(
                  padding:  EdgeInsets.only(left: width/273.2),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("billing").orderBy("timestamp",descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData==null){
                        return Center(child: Container());
                      }
                      if(!snapshot.hasData){
                        return Center(child: Container());
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['save']==true?
                          Row(
                            children: [
                             // SizedBox(width: width/50.15,),

                              Container(
                                decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  width:width/15.588,
                                  child:
                                  Center(child:
                                  Text("${buillin1['purchaseno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ))),

                              Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  width:width/7.588,
                                  child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              //SizedBox(width:width/ 45.53,),

                              Container(
                                 width:width/6.0,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  child: Center(child: Text(buillin1['customerphone'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              //SizedBox(width: width/ 45.53,),

                              Container(
                                  width:width/5.0,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  child: Center(child: Text(buillin1['customeraddress'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              //SizedBox(width: width/27.32,),

                              Container(
                                  width:width/11.383,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              //SizedBox(width: width/22.76,),

                              Container(
                                  width:width/10.0,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              //SizedBox(width: width/27.32,),

                              Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                  height:height/12.14 ,
                                  width:width/15.0,
                                  child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              SizedBox(width: width/130.32,),

                              InkWell(
                                onTap: (){
                                  showdialpogbox(
                                    buillin1.id,
                                    buillin1['customername'],
                                    buillin1['customerphone'],
                                    buillin1['purchasedate'],
                                    buillin1['time'],
                                    buillin1['Payment mode'],
                                    buillin1['customeraddress'],
                                    buillin1['Discountamount'],
                                    buillin1['Discountamountpercentage'],);
                                },
                                child: Material(
                                  elevation: 10,
                                    color: Colors.green,
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      width:width/15.66,
                                      height:height/21.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.green
                                      ),
                                      child: Center(child: Text("View",style:
                                      GoogleFonts.montserrat(fontWeight: FontWeight.w600,
                                          color: Colors.white),))),
                                ),
                              ),

                              SizedBox(width:width/136.6,),
                              //edit button
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
                                },
                                child: Material(
                                  elevation: 10,

                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      width:width/45.53,
                                      height:height/21.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),

                                      ),
                                      child: Center(child: Icon(Icons.edit,color:
                                      Colors.black,size:width/68.3))),
                                ),
                              ),

                            ],
                          ):SizedBox();
                      },);
                    },
                  ),
                ),
              ],
            ),
          ),
        )

      ],
    );
  }

  showdialpogbox(streamid,name,phone,date,time,payment,address,disamount,disperamount) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      showDialog(
      context: context,
      builder: (context) {
        return SlideInLeft(
          animate: true,
          duration: Duration(milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height:height/ 1.194,
                width: width/0.975,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height/65.7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

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
                          SizedBox(width: width/65.7,),


                        ],
                      ),
                      SizedBox(height: height/45.7,),

                      Padding(
                        padding:  EdgeInsets.only(left: width/50.2),
                        child: Row(

                          children: [

                            Container(
                              width: width/15.2,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Item Code",
                                textAlign:TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(

                              width: width/8.0,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text('Description',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),


                            Container(
                              height:height/13.13,
                              width: width/10.17,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Hsncode",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),


                            Container(
                              height:height/13.13,
                              width: width/10.691,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Payment",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),




                            Container(
                              height:height/13.13,
                              width: width/20.075,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Qty",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/10.17,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Sales Price",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(

                              width: width/10.17,
                              height:height/13.13,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text("Without Tax",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/20.17,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Tax",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/20.66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Dis %",
                                textAlign:TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              height:height/13.13,
                              width: width/13.66,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text("Date\nTime",
                                textAlign:TextAlign.center,

                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),




                          ],
                        ),
                      ),



                      Padding(
                        padding:  EdgeInsets.only(left: width/50.2),
                        child: SizedBox(
                          height:height/1.602,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("billing").
                            doc(streamid).collection(streamid).orderBy("timestamp",descending: true).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData==null){
                                return Center(child: Container(),);
                              }
                              if(!snapshot.hasData){
                                return Center(child: Container(),);
                              }
                              return  ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var customer=snapshot.data!.docs[index];
                                  return

                                    Row(

                                      children: [

                                        Container(
                                          width: width/15.2,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text("${customer["itemcode"]}",
                                            textAlign:TextAlign.center,
                                            style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/8.0,
                                          height:height/13.13,
                                          padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer["Description"],style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/10.17,

                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Hsncode'],style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/10.691,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(payment,style: GoogleFonts.poppins(),)),
                                        ),


                                        Container(
                                          height:height/13.13,
                                          width: width/20.075,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Qty'],style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          width: width/10.17,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['Sales price'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(

                                          width: width/10.17,
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          child: Center(child: Text(customer['withouttaxprice'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/20.17,

                                          child: Center(child: Text(customer['tax'].toString(),style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/20.66,

                                          child: Center(child: Text("${disamount}\n${disperamount}",
                                            textAlign:TextAlign.center,
                                            style: GoogleFonts.poppins(),)),
                                        ),

                                        Container(
                                          height:height/13.13,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                          width: width/13.66,

                                          child: Center(child: Text("${customer['date']}\n${customer['time']}",
                                            textAlign:TextAlign.center,

                                            style: GoogleFonts.poppins(),)),
                                        ),




                                      ],
                                    );
                                },);
                            },),
                        ),
                      ),

                      SizedBox(
                        height: height/32.85,
                      ),




                      SizedBox(
                        height: height/32.85,
                      ),

                    ],
                  ),
                ),
              )),
        );
      },
    );
  }


  double Total=0;
  String SGST='';
  String CGST="";
  String TotalAmount="";





}
