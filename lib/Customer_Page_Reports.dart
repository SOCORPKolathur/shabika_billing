import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customer_Page_Reports extends StatefulWidget {
  const Customer_Page_Reports({Key? key}) : super(key: key);

  @override
  State<Customer_Page_Reports> createState() => _Customer_Page_ReportsState();
}

class _Customer_Page_ReportsState extends State<Customer_Page_Reports> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("Customer Reports",
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
                  SizedBox(width: 50,),
                  Text("Customer Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.w800,fontSize: width/75.888),),
                  SizedBox(width: 50,),
                  Text("Customer Mobile",style: GoogleFonts.montserrat(fontWeight: FontWeight.w800,fontSize: width/75.888),),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 5,right: 5),
                child: Divider(),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Customer").snapshots(),
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
                            child: Row(
                              children: [
                                SizedBox(width: 40,),

                                Container(
                                    width:180,
                                    child: Center(child: Text(buillin1['Customername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 30,),

                                Container(
                                    width:180,

                                    child: Center(child: Text(buillin1['Customermobileno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 720,),


                                InkWell(
                                  onTap: (){
                                    showdialpogbox(buillin1.id);
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
  
  showdialpogbox(streamid) {
    return showDialog(
      context: context,
      builder: (context) {
        return SlideInLeft(
          animate: true,
          duration: Duration(milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 550,
                width: 1300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Name',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Phone',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Address',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Bill no',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Discount',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Bill Type',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Total',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Date',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 100,
                            child: Center(child: Text('Time',style: GoogleFonts.poppins(),)),
                          ),



                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 5,right: 5),
                        child: Divider(),
                      ),

                      Container(
                        height:410,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("Customer").doc(streamid).collection("billing").orderBy("timestamp",descending: true).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData==null){
                              return Center(child: Container(),);
                            }
                            if(!snapshot.hasData){
                              return Center(child: Container(),);
                            }
                            if(snapshot.data!.docs.length==0){

                              return Center(child: Text("Field is empty",style: GoogleFonts.poppins(),),);
                            }
                            return  ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var customer=snapshot.data!.docs[index];
                                return
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Customer name'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Customer phone'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Customer address'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),

                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Bill no'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),

                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Discount'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),

                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Bill Type'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['Total'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['date'].toString(),style: GoogleFonts.poppins(),)),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      child: Center(child: Text(customer['time'].toString(),style: GoogleFonts.poppins(),)),
                                    ),



                                  ],
                                );
                              },);
                          },),
                      ),

                      SizedBox(
                        height: 20,
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
                            height: 40,
                            width: 180,
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
              )),
        );
      },
    );
  }
  
}
