import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../Customer_Page_Reports.dart';
import '../Edit_customer_Page.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';
import 'customer view page.dart';

class Customer extends StatefulWidget {
   Customer(this.Pages);
   String?Pages;

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  bool addcustomer=false;
  TextEditingController Suppliername=TextEditingController();
  TextEditingController Mobileno=TextEditingController();
  TextEditingController alMobileno=TextEditingController();
  TextEditingController Suppliercode=TextEditingController();
  TextEditingController homeno=TextEditingController();
  TextEditingController street=TextEditingController();
  TextEditingController Area=TextEditingController();
  TextEditingController CityDis=TextEditingController();
  TextEditingController State=TextEditingController();
  TextEditingController Pincode=TextEditingController();
  TextEditingController Gstno=TextEditingController();

  NumberFormat F=NumberFormat('00');

  int itemcodes=0;

  int customerview=0;
  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Customer").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"CUS"}${F.format(itemcodes)}";
    });

  }


  bool isserach=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();

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
    return widget.Pages =="Entry"? Scaffold(
      backgroundColor:  Color(0xff00A99D),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width/91.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Tooltip(
                  message: "Back",
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Colors.indigo,
                    child: Container(
                      height:height/ 21.9,
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
                width:  width/91.06,
              ),
              Padding(
                padding:  EdgeInsets.only(right: width/1.232,top: height/65.7,bottom: height/65.7),
                child: Text(
                  "Add New Customer",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold, fontSize:width/ 59.39,color: const Color(0xffFFFFFF)),
                ),
              ),
            ],
          ),
          Image.asset("assets/Line13.png"),
          Row(
            children: [
              //Customer Code
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Text("Customer ID",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child:
                    Container(width: width/6.83,
                      height: height/16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                      child: TextField(
                        controller: Suppliercode,
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.openSans(fontSize: width/136.6,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Customer Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Text("Customer Name",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
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
                        style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                          border: InputBorder.none,

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Mobile number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Text("Mobile",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Container(width: width/6.83,
                      height: height/16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                        controller:  Mobileno,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Text("Alternative Mobile",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Container(
                      width: width/6.83,
                      height: height/16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                      child:
                      TextField(
                        controller: alMobileno,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                          border: InputBorder.none,

                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Home No



            ],
          ),
          SizedBox(height:height/65.7),
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width/20.08,top:height/ 48.785),
                child: GestureDetector(
                  onTap: () {
                    addcustomers();
                    showdialpogbox();
                    Future.delayed(Duration(seconds: 3),(){
                      setState(() {
                        addcustomer = false;
                      });
                      clearallcontroller();
                      Navigator.pop(context);
                    });
                  },
                  child: Container(width:width/8.6,
                    height: height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff25D366),),child: Center(child: Text("Save Customer",style: GoogleFonts.openSans(color: Colors.white,fontSize:width/ 91.06),)),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  clearallcontroller();
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: width/75.888,top:height/ 48.785),
                  child: Container(width: width/13.6,
                    height:  height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),child: Center(child: Text("Reset",style: GoogleFonts.openSans(color: Colors.white),)),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    ):
      addcustomer==false?
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
                  style: GoogleFonts.openSans(fontSize: width/68.3,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    contentPadding:   EdgeInsets.only(left: width/68.3, top:width/102.125,bottom:width/70.125),
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
            GestureDetector(
              onTap:(){
                itemcodegenrate();
                setState(() {
                  addcustomer=true;
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
                          "Add Customer",
                          style: GoogleFonts.openSans(
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
          padding:  EdgeInsets.symmetric(horizontal: width / 75.88, vertical: height / 36.5),
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
              physics: const ScrollPhysics(),
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
                              style: GoogleFonts.openSans(
                                  color:  Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text("Customer Name",
                            style: GoogleFonts.openSans(
                                color:Colors.white,
                                fontSize: width / 88.3,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/1.88, right: width/18.514),
                          child: Text("Edit",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text("Delete",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: width / 88.3,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding:  EdgeInsets.only(left: width/12.523),
                          child: Text("Status",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: width / 88.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),

                  //Customer stream
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Customer").orderBy("timestamp",descending: true)
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if(isserach==true&&snapshot.data!.docs[index]["Customername"].toString().toLowerCase().contains(Username.toLowerCase())){
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
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 95.888,
                                              color:  Colors.black),
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
                                        ["Customername"],
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 95.888,
                                            color:  Colors.black),
                                      ),
                                    ),
                                  ),

                                  //edit icon(img)
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditCustomer_Page(snapshot.data!.docs[index].id,""),));
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
                                  ),



                                  //delete icon (img)
                                  InkWell(
                                    onTap:(){
                                      _customer(snapshot.data!.docs[index].id);
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
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const customeview_Page(),));
                                    },
                                    child: Container(
                                        height: height / 20.14,
                                        width: width / 6.83,
                                        // color: Colors.grey,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Center(
                                            child: Text(
                                              "View",
                                              style: GoogleFonts.openSans(
                                                  fontSize: width / 95.888,
                                                  fontWeight: FontWeight.bold,
                                                  color:  Colors.black),
                                            ))),
                                  ),
                                ],
                              );
                          }
                          else if(isserach==false&&snapshot.data!.docs[index]["Customername"].toString().toLowerCase().contains(Username.toLowerCase())){
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
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 95.888,
                                            color:  Colors.black),
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
                                      ["Customername"],
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width / 95.888,
                                          color:  Colors.black),
                                    ),
                                  ),
                                ),

                                //edit icon(img)
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCustomer_Page(snapshot.data!.docs[index].id,""),));
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
                                ),



                                //delete icon (img)
                                InkWell(
                                  onTap:(){
                                    _customer(snapshot.data!.docs[index].id);
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
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const customeview_Page(),));
                                  },
                                  child: Container(
                                      height: height / 20.14,
                                      width: width / 6.83,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          )),
                                      child: Center(
                                          child: Text(
                                            "View",
                                            style: GoogleFonts.openSans(
                                                fontSize: width / 95.888,
                                                fontWeight: FontWeight.bold,
                                                color:  Colors.black),
                                          ))),
                                ),
                              ],
                            );

                          }
                          return
                            const SizedBox();

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
      customerview==1?
      const Customer_Page_Reports():

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
                  addcustomer = false;
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
                    height:height/ 21.9,
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
              width:  width/91.06,
            ),
            Padding(
              padding:  EdgeInsets.only(right: width/1.232,top: height/65.7,bottom: height/65.7),
              child: Text(
                "Add New Customer",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize:width/ 59.39,color: const Color(0xffFFFFFF)),
              ),
            ),
          ],
        ),
        Image.asset("assets/Line13.png"),

        Row(
          children: [
            //Customer Code
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Customer Code",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child:
                  Container(width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      controller: Suppliercode,
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize: width/136.6,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Customer Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Customer Name",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
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
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Mobile number
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Mobile",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                      controller:  Mobileno,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Home No
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Home No",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child:
                    TextField(
                      controller: homeno,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),

        Row(
          children: [

            //Customer Street
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Street",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(
                    width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child:
                    TextField(
                      controller: street,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Customer Area
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Area",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(
                    width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child:
                    TextField(
                      controller: Area,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ],
            ),

            //City And District
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("City/District",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child:
                    TextField(
                      controller: CityDis,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //State
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("State",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      controller: State,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),

        Row(
          children: [

            //Customer Pincode
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("Pincode",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(
                    width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child:
                    TextField(
                      controller: Pincode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Customer Gstno
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Text("GST NO",style: GoogleFonts.openSans(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                  child: Container(
                    width: width/6.83,
                    height: height/16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                    child:
                    TextField(
                      controller: Gstno,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.openSans(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
        SizedBox(height:height/65.7),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/20.08,top:height/ 48.785),
              child: GestureDetector(
                onTap: () {
                  addcustomers();
                  showdialpogbox();
                  Future.delayed(Duration(seconds: 3),(){
                    setState(() {
                      addcustomer = false;
                    });
                    clearallcontroller();
                    Navigator.pop(context);
                  });
                },
                child: Container(width:width/8.6,
                  height: height/16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: const Color(0xff25D366),),child: Center(child: Text("Save Customer",style: GoogleFonts.openSans(color: Colors.white,fontSize:width/ 91.06),)),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                clearallcontroller();
              },
              child: Padding(
                padding:  EdgeInsets.only(left: width/75.888,top:height/ 48.785),
                child: Container(width: width/13.6,
                  height:  height/16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),child: Center(child: Text("Reset",style: GoogleFonts.openSans(color: Colors.white),)),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
  clearallcontroller(){
     Suppliername.clear();
     Mobileno.clear();
     alMobileno.clear();
     Suppliercode.clear();
      homeno.clear();
      street.clear();
      Area.clear();
      CityDis.clear();
      State.clear();
      Pincode.clear();
      Gstno.clear();
  }

  addcustomers(){
    FirebaseFirestore.instance.collection("Customer").doc().set({
      "Alphone":alMobileno.text,
      "Customermobileno":Mobileno.text,
      "Customerid":itemcodes,
      "Customername":Suppliername.text,
      "Customer address":"${homeno.text},${street.text},${Area.text},${CityDis.text},${State.text},${Pincode.text},${Gstno.text}",
      "Customer GstNo": Gstno.text,
      "Customer state ":State.text,
      "Customer pincode ": Pincode.text,
      "Customer city ": CityDis.text,
      "Customer street ": street.text,
      "Customer homeno ":homeno.text,
      "Customer area ": Area.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch,
    });
  }

  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.760,bottom: height/4.760),
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
                    SizedBox(height:height/32.85,),
                    Text("Add a Customer Successfully",style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height:height/32.85,),
                    SizedBox(
                      height: height/4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height:height/32.85,),

                    // InkWell(
                    //   onTap: (){
                    //
                    //   },
                    //   child: Material(
                    //     elevation: 15,
                    //       color: const Color(0xff25D366),
                    //     borderRadius: BorderRadius.circular(5),
                    //     child: Container(
                    //       height: height/16.425,
                    //       width: width/7.588,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //           color: const Color(0xff25D366),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //             "Okay",
                    //             style: GoogleFonts.openSans(
                    //                 letterSpacing: 1.5,
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: width/85.375, color: Colors.white)
                    //         ),
                    //       ),
                    //     ),
                    //   ),
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
  delete(customerid){
    FirebaseFirestore.instance.collection("Customer").doc(customerid).delete();

  }
  //Barnd showpopup(delete popup)
  _customer(customerid){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder:(context) {

      return Padding(
        padding:  EdgeInsets.only(top:height/4.38,bottom: height/4.38,left: width/3.902,right:width/3.902),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:height/21.9),
                Text("Are You Sure Want to Delete",style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize:width/75.88
                ),),

                SizedBox(height:height/32.85),

                SizedBox(
                  height:height/3.65,
                  width:width/7.588,
                  child: Lottie.network(deletefile),
                ),
                SizedBox(height:height/32.85),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        delete(customerid);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:height/16.425,
                        width:width/7.588,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xff25D366)
                        ),
                        child: Center(
                          child: Text("Okay",style: GoogleFonts.openSans(color:
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
                                style: GoogleFonts.openSans(
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


}
