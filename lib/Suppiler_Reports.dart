
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Supplier_Reports extends StatefulWidget {
  const Supplier_Reports({Key? key}) : super(key: key);

  @override
  State<Supplier_Reports> createState() => _Supplier_ReportsState();
}

class _Supplier_ReportsState extends State<Supplier_Reports> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(" Supplier Reports",
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 25),),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),

        Container(
          height: 550,
          width: 1300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),

          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 20,),

                  Container(
                      width:120,
                      child: Center(child: Text('Supplier name',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                  SizedBox(width: 20,),


                  Container(
                      width:120,

                      child: Center(child: Text('Supplier Code',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                  SizedBox(width: 20,),


                  Container(
                      width:125,

                      child: Center(child: Text('Supplier address',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                  SizedBox(width: 20,),


                  Container(
                      width:120,

                      child: Center(child: Text('Supplier Mobile',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                  SizedBox(width: 20,),


                  Container(
                      width:60,

                      child: Center(child: Text('Email',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                  SizedBox(width: 20,),


                  Container(
                      width:60,
                      child: Center(child: Text('City',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                  SizedBox(width: 20,),


                  Container(
                      width:60,
                      child: Center(child: Text('Pincode',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                  SizedBox(width: 20,),


                  Container(
                      width:70,
                      child: Center(child: Text('Pan No',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                  SizedBox(width: 20,),


                  Container(
                      width:60,
                      child: Center(child: Text('State',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                  SizedBox(width: 20,),

                  Container(
                      width:60,
                      child: Center(child: Text('Balance',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                  SizedBox(width: 20,),


                ],
              ),
              Padding(padding: EdgeInsets.only(left: 5,right: 5),
                child: Divider(),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Supplier").orderBy("timestamp",descending: true).snapshots(),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child:
                            Row(
                              children: [
                                SizedBox(width: 20,),

                                Container(
                                    width:120,
                                    child: Center(child: Text(buillin1['Suppliername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 20,),


                                Container(
                                    width:120,

                                    child: Center(child: Text(buillin1['Suppliercode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 20,),


                                Container(
                                    width:125,

                                    child: Center(child: Text(buillin1['SupplierAddress'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 20,),


                                Container(
                                    width:120,

                                    child: Center(child: Text(buillin1['Mobileno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 20,),


                                Container(
                                    width:60,
                                    child: Center(child: Text(buillin1['Email'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 20,),


                                Container(
                                    width:60,
                                    child: Center(child: Text(buillin1['City'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                SizedBox(width: 20,),


                                Container(
                                    width:60,
                                    child: Center(child: Text(buillin1['Pincode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                SizedBox(width: 20,),


                                Container(
                                    width:70,
                                    child: Center(child: Text(buillin1['Panno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                SizedBox(width: 20,),


                                Container(
                                    width:60,
                                    child: Center(child: Text(buillin1['State'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                SizedBox(width: 20,),

                                Container(
                                    width:60,
                                    child: Center(child: Text(buillin1['Openingbalance'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,textStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis
                                    )),))),

                                SizedBox(width: 50,),

                                InkWell(
                                  onTap: (){
                                    showdialpogbox(
                                      buillin1.id,
                                    );
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width:100,
                                        height:30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.green
                                        ),
                                        child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                  ),
                                ),


                              ],
                            ),

                          );
                      },);
                  },
                ),
              ),
            ],
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
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 200,right: 200),
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

                        Container(
                          width: 450,
                          height: 600,
                          child: Lottie.network("https://assets8.lottiefiles.com/packages/lf20_j2hgsqs5.json"),
                        ),

                        Container(
                          width: 515,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text("Supplier Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),

                              Container(
                                child: FutureBuilder<dynamic>(
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
                                          SizedBox(width: 30,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Name ",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Suppliername'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Code",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Suppliercode'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Address",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['SupplierAddress'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Mobile",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Mobileno'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: width/27.32),
                                                child: Container(
                                                  height: 30,
                                                  width: 130,
                                                  child: Text("Supplier Email",style: GoogleFonts.poppins(),),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 180,
                                                child: Text(": ${purchase['Email'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),


                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier City",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['City'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Pincode",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Pincode'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Pan no",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Panno'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier State",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['State'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Balance",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text(": ${purchase['Openingbalance'].toString()}",style: GoogleFonts.poppins(),),
                                              ),
                                            ],
                                          ),

                                          SizedBox(width: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 130,
                                                child: Text("Supplier Remarks",style: GoogleFonts.poppins(),),
                                              ),
                                              Container(
                                                height: 60,
                                                width: 130,
                                                child: Text(": ${purchase['Remarks'].toString()}",

                                                  style: GoogleFonts.poppins(),
                                                textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      );
                                  },),
                              ),

                              SizedBox(
                                height: 30,
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
                                    height: 35,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red,
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
}
