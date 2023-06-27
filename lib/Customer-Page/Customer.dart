import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {

  bool addcustomer=false;
  TextEditingController Suppliername=new TextEditingController();
  TextEditingController Mobileno=new TextEditingController();
  TextEditingController Suppliercode=new TextEditingController();
  TextEditingController SupplierAddress=new TextEditingController();

  NumberFormat F=new NumberFormat('00');

  int itemcodes=0;

  itemcodegenrate() async {
    var document=await FirebaseFirestore.instance.collection("Customer").get();
    setState(() {
      itemcodes=document.docs.length+1;
      Suppliercode.text="${"CUS"}${F.format(itemcodes)}";
    });
    print(Suppliercode.text);

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      addcustomer==false?
      Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 20),
              child: Text(
                "Customer",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white),
              ),
            ),
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
                        padding:  EdgeInsets.only(bottom: width/136.6),
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
          padding: const EdgeInsets.only(right: 1178.0),
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
            GestureDetector(
              onTap:(){
                itemcodegenrate();
                setState(() {
                  addcustomer=true;
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
                          "Add Customer",
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
                        Text("Customer Name",
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

                  //Customer stream
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Customer")
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
                                    ["Customername"],
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
                                      ))),



                              //delete icon (img)
                              InkWell(
                                onTap:(){
                                  _customer(snapshot.data!.docs[index].id);
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
                  addcustomer = false;
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
                "Add New Customer",
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
              child: Text("Customer Name *",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 144.0,top: 8),
              child: Text("Customer Code*",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140.0,top: 8),
              child: Text("Customer Address *",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
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
                    hintText: "Customer Name",
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
                  hintText: "Customer Address",
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
              child: Text("Mobile Number",style: GoogleFonts.poppins(fontSize: 14,color: Color(0xff000000)),),
            ),


          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0,right: 60,left: 50),
              child: Container(child: TextField(
                controller:  Mobileno,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "Customer Mobile",
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
              padding: const EdgeInsets.only(left: 68.0,top: 20),
              child: GestureDetector(
                onTap: () {

                  showdialpogbox();
                },
                child: Container(child: Center(child: Text("Save Customer",style: GoogleFonts.poppins(color: Colors.white,fontSize: 15),)),
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
  clearallcontroller(){
     Suppliername.clear();
     Mobileno.clear();
     Suppliercode.clear();
     SupplierAddress.clear();
  }

  addcustomers(){
    FirebaseFirestore.instance.collection("Customer").doc().set({
      "Customermobileno":Mobileno.text,
      "Customerid":itemcodes,
      "Customername":Suppliername.text,
      "Customeraddress":SupplierAddress.text
    });
  }

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
                    Text("Add a Customer  Successfully",style: GoogleFonts.poppins(
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
                        addcustomers();
                        clearallcontroller();
                        Navigator.pop(context);
                        setState(() {
                          addcustomer=false;
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
  delete(customerid){
    FirebaseFirestore.instance.collection("Customer").doc(customerid).delete();

  }
  //Barnd showpopup(delete popup)
  _customer(customerid){

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
                    delete(customerid);
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


}
