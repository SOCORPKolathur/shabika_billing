import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Reports_Page extends StatefulWidget {
  const Reports_Page({Key? key}) : super(key: key);

  @override
  State<Reports_Page> createState() => _Reports_PageState();
}

class _Reports_PageState extends State<Reports_Page> {
  int select = 0;

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(" Sales Reports",
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
          
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(width: 40,),

                    Container(
                        width:180,
                        child: Center(child: Text('Customer name',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 30,),

                    Container(
                        width:180,

                        child: Center(child: Text('Customer phone',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 30,),

                    Container(
                        width:180,

                        child: Center(child: Text('Customer address',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 50,),

                    Container(
                        width:120,

                        child: Center(child: Text('Date',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 60,),

                    Container(
                        width:100,

                        child: Center(child: Text('Bill Type',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 50,),

                    Container(
                        width:100,
                        child: Center(child: Text('Total',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                    SizedBox(width: 50,),


                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 5,right: 5),
                child: Divider(),
                ),
                Container(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child:
                            Row(
                              children: [
                                SizedBox(width: 40,),

                                Container(
                                    width:180,
                                    child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 30,),

                                Container(
                                    width:180,

                                    child: Center(child: Text(buillin1['customerphone'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 30,),

                                Container(
                                    width:180,

                                    child: Center(child: Text(buillin1['customeraddress'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 50,),

                                Container(
                                    width:120,

                                    child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 60,),

                                Container(
                                    width:100,

                                    child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                SizedBox(width: 50,),

                                Container(
                                    width:100,
                                    child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                SizedBox(width: 50,),

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
          ),
        )

      ],
    );
  }

  showdialpogbox(streamid,name,phone,date,time,payment,address) {
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
                width: 1400,
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
                            width: 90,
                            child: Center(child: Text("Name",style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),

                          Container(
                            height: 30,
                            width: 90,

                            child: Center(child: Text("Phone",style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),

                          Container(
                            height: 30,
                            width: 90,
                            child: Center(child: Text("Address",style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 240,
                            child: Center(child: Text('Description',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),

                          Container(
                            height: 30,
                            width: 90,
                            child: Center(child: Text("Payment Type",style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 90,
                            child: Center(child: Text('Total',style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 90,
                            child: Center(child: Text("Date",style: GoogleFonts.poppins(),)),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            height: 30,
                            width: 90,
                            child: Center(child: Text("Time",style: GoogleFonts.poppins(),)),
                          ),

                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 5,right: 5),
                        child: Divider(),
                      ),

                      Container(
                        height:410,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("billing").doc(streamid).collection(streamid).orderBy("timestamp",descending: true).snapshots(),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 30,),
                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Center(child: Text(name,style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 30,),

                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Center(child: Text(phone,style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 20,),

                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Center(child: Text(address,style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 20,),
                                      Container(
                                        height: 30,
                                        width: 240,
                                        child: Center(child: Text(customer['Description'].toString(),style: GoogleFonts.poppins(),)),
                                      ),


                                      SizedBox(width: 30,),

                                      Container(
                                        height: 30,
                                        width: 80,
                                        child: Center(child: Text(payment,style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Center(child: Text(customer['Total'].toString(),style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 20,),
                                      Container(
                                        height: 30,
                                        width: 100,
                                        child: Center(child: Text(date,style: GoogleFonts.poppins(),)),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Center(child: Text(time,style: GoogleFonts.poppins(),)),
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
