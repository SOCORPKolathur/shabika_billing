import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EditCustomer_Page extends StatefulWidget {
   String?docid;
   EditCustomer_Page(this.docid);

  @override
  State<EditCustomer_Page> createState() => _EditCustomer_PageState();
}

class _EditCustomer_PageState extends State<EditCustomer_Page> {

  TextEditingController Suppliername=new TextEditingController();
  TextEditingController Mobileno=new TextEditingController();
  TextEditingController Suppliercode=new TextEditingController();
  TextEditingController SupplierAddress=new TextEditingController();


  @override
  void initState() {
    setcustomers();
    // TODO: implement initState
    super.initState();
  }

String itemcodes='';

  setcustomers()async{
   var user=await FirebaseFirestore.instance.collection("Customer").doc(widget.docid).get();
      Map<String,dynamic>?value=user.data();
      setState(() {
        Mobileno.text=value!['Customermobileno'];
        Suppliername.text=value['Customername'];
        SupplierAddress.text=value['Customeraddress'];
        itemcodes=value["Customerid"];
      });

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff00A99D),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width/91.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold, fontSize:width/ 59.39,color: Color(0xffFFFFFF)),
                ),
              ),
            ],
          ),
          Image.asset("assets/Line13.png"),
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:width/21.015,top: height/82.125),
                child: Text("Customer Name *",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: Color(0xff000000)),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width/9.48,top: height/82.125),
                child: Text("Customer Code*",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: Color(0xff000000)),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width/9.75,top: height/82.125),
                child: Text("Customer Address *",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: Color(0xff000000)),),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/22.76),
                child: Container(
                  width: width/6.83,
                  height: height/16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                  child:
                  TextField(
                    controller: Suppliername,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
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
                  decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    controller: Suppliercode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: width/136.6,fontWeight: FontWeight.w700),
                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top:height/65.7,left: width/27.32),
                child: Container(width: width/2.55,
                  height: height/16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    controller: SupplierAddress,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
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
                padding:  EdgeInsets.only(left: width/23.55,top:height/ 48.785),
                child: Text("Mobile Number",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: Color(0xff000000)),),
              ),


            ],
          ),

          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: height/65.7,right: width/22.76,left: width/27.32),
                child: Container(width: width/6.83,
                  height: height/16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child: TextField(
                    controller:  Mobileno,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left:width/68.3,bottom:height/82.125),
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
                padding:  EdgeInsets.only(left: width/20.08,top:height/ 48.785),
                child: GestureDetector(
                  onTap: () {

                    showdialpogbox();
                  },
                  child: Container(child: Center(child: Text("Edit Customer",style: GoogleFonts.poppins(color: Colors.white,fontSize:width/ 91.06),)),
                    width:width/8.6,
                    height: height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color: Color(0xff25D366),),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  clearallcontroller();
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: width/75.888,top:height/ 48.785),
                  child: Container(child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                    width: width/13.6,
                    height:  height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),
                  ),
                ),
              ),
            ],
          ),



        ],
      ),
    );
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
          duration: Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Color(0xff264656),
              content:
              Container(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height:height/32.85,),
                    Text("Edit Customer  Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height:height/32.85,),
                    Container(
                      height: height/4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height:height/32.85,),

                    InkWell(
                      onTap: (){
                        upadtecustomers();
                        clearallcontroller();
                        Navigator.pop(context);

                      },
                      child: Material(
                        elevation: 15,
                          color: Color(0xff25D366),
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height/16.425,
                          width: width/7.588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                              color: Color(0xff25D366)
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
                    )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }

  clearallcontroller(){
    Suppliername.clear();
    Mobileno.clear();
    Suppliercode.clear();
    SupplierAddress.clear();
  }

  upadtecustomers(){
    FirebaseFirestore.instance.collection("Customer").doc(widget.docid).update({
      "Customermobileno":Mobileno.text,
      "Customername":Suppliername.text,
      "Customeraddress":SupplierAddress.text,
      "Customerid":itemcodes,
    });
  }

}
