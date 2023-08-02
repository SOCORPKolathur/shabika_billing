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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Column(
      children: [
        SizedBox(
            height: height / 43.8
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width / 91.06),
              child: Text("Customer Reports",
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width / 54.64),),
            )
          ],
        ),
        SizedBox(
            height: height / 43.8
        ),

        Container(
          height: height / 1.194,
          width: width / 1.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),

          child: Column(
            children: [
              SizedBox(height: height / 65.7,),
              Row(
                children: [
                  SizedBox(width: width / 34.15,),

                  Container(
                    width: width / 7.588,
                    height: height / 10.95,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2)
                    ),
                    child: Center(
                        child: Text("Customer Name",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600),)),
                  ),


                  Container(
                      width: width / 5.588,
                      height: height / 10.95,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2)
                      ),
                      child: Center(child: Text(
                        "Customer Mobileno",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600),))),

                  Container(
                      width: width / 5.588,
                      height: height / 10.95,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2)
                      ),
                      child: Center(child: Text(
                        "Customer GstNo",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600),))),


                  Container(
                    width: width / 3.588,
                    height: height / 10.95,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.2)
                    ),

                    child: Center(
                        child: Text("Customer Address",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600),)),
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 683, vertical: height / 328.5),
                  ),


                  SizedBox(width: width / 130.6,),


                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Customer")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == null) {
                    return Center(child: Container());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Container());
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var buillin1 = snapshot.data!.docs[index];
                      return
                        Row(
                          children: [
                            SizedBox(width: width / 34.15,),

                            Container(
                              width: width / 7.588,
                              height: height / 10.95,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.2)
                              ),
                              child: Center(child: Text(
                                buillin1['Customername'].toString(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600),)),
                            ),


                            Container(
                                width: width / 5.588,
                                height: height / 10.95,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2)
                                ),
                                child: Center(child: Text(
                                  buillin1['Customermobileno'].toString(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600),))),

                            Container(
                                width: width / 5.588,
                                height: height / 10.95,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2)
                                ),
                                child: Center(child: Text(
                                  buillin1['Customer GstNo'].toString(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600),))),


                            Container(
                              width: width / 3.588,
                              height: height / 10.95,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.2)
                              ),

                              child: Center(child: Text(
                                buillin1['Customer address'].toString(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600),)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 683,
                                  vertical: height / 328.5),
                            ),


                            SizedBox(width: width / 130.6,),
                            InkWell(
                              onTap: () {
                                showdialpogbox(buillin1.id);
                              },
                              child: Material(
                                elevation: 10,
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    width: width / 13.66,
                                    height: height / 21.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        color: Colors.green
                                    ),
                                    child: Center(child: Text("View",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),))),
                              ),
                            ),

                          ],
                        );
                    },);
                },
              ),
            ],
          ),
        )

      ],
    );
  }

  showdialpogbox(streamid) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
                height: height / 1.194,
                width: width / 0.5,
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
                      SizedBox(height: height/65.7,),


                      Row(
                        children: [
                          SizedBox(width: width / 100.53,),
                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(
                              child: Text("Item\nPurch NO".toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),),
                            ),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 5.8,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Description", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Hsncode", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Qty", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 10.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Payment", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Time", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Date", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 10.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Sales Price", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 13.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text("Dis Amt\nDis %",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                          Container(
                            height: height / 13.9,
                            width: width / 10.66,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: 1.2),
                            ),
                            child: Center(child: Text(
                              "Total", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                          ),


                        ],
                      ),


                      SizedBox(
                        height: height / 1.602,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("Customer").doc(streamid)
                              .collection("billing")
                              .orderBy("timestamp", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData == null) {
                              return Center(child: Container(),);
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Container(),);
                            }
                            if (snapshot.data!.docs.length == 0) {
                              return Center(child: Text("Field is empty",
                                style: GoogleFonts.poppins(),),);
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var customer = snapshot.data!.docs[index];
                                return
                                customer['save']==true?
                                  Row(
                                    children: [
                                      SizedBox(width: width / 100.53,),
                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          "${customer['itemcode']}${customer['purchaseno']}"
                                              .toString(),
                                          style: GoogleFonts.poppins(),),
                                        ),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 5.8,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 683,
                                            vertical: height / 328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Text(
                                          customer['Description'].toString(),
                                          style: GoogleFonts.poppins(),),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['Hsncode'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['Qty'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 10.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['Payment mode'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['time'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['date'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 10.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['Sales price'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 13.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          "${customer['Discountamount']}\n${customer['Discountamountpercentage']}"
                                              .toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                      Container(
                                        height: height / 13.9,
                                        width: width / 10.66,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(child: Text(
                                          customer['Totalamount'].toString(),
                                          style: GoogleFonts.poppins(),)),
                                      ),


                                    ],
                                  ):SizedBox();
                              },);
                          },),
                      ),

                      SizedBox(
                        height: height / 32.85,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Material(
                          elevation: 15,
                          color: Color(0xff25D366),
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height / 16.425,
                            width: width / 7.588,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff25D366),
                            ),
                            child: Center(
                              child: Text("Okay",
                                  style: GoogleFonts.poppins(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 85.37,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height / 32.85,
                      ),

                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

}
