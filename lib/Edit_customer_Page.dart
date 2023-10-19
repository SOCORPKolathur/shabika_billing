import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EditCustomer_Page extends StatefulWidget {
   String?docid;
   String?page;
   EditCustomer_Page(this.docid,this.page);

  @override
  State<EditCustomer_Page> createState() => _EditCustomer_PageState();
}

class _EditCustomer_PageState extends State<EditCustomer_Page> {

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
        alMobileno.text=value['Alphone'];
        Gstno.text=value['Customer GstNo'];
        State.text=value["Customer state "];
        Pincode.text=value["Customer pincode "];
        CityDis.text=value["Customer city "];
        street.text=value["Customer street "];
        homeno.text=value["Customer homeno "];
        Area.text=value["Customer area "];
        Suppliername.text=value['Customername'];
        itemcodes=value["Customerid"].toString();
        Suppliercode.text=value["Customerid"].toString();
      });

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return widget.page == "Entry"?
    Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body:
      Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width/91.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                  "Edit Customer",
                  style: GoogleFonts.cairo(
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
                    child: Text("Customer ID",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize: width/136.6,fontWeight: FontWeight.w700),
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
                    child: Text("Customer Name",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Mobile",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Alternative Mobile",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:width/25.77,top: height/65.7,right: width/62.76),
                    child: Container(width: width/6.83,
                      height: height/16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(color: const Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),child:
                      TextField(
                        controller: alMobileno,
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


            ],
          ),


          SizedBox(height:height/65.7),

          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width/20.08,top:height/ 48.785),
                child: GestureDetector(
                  onTap: () {

                    showdialpogbox();
                  },
                  child: Container(width:width/8.6,
                    height: height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff25D366),),child: Center(child: Text("Edit Customer",style: GoogleFonts.poppins(color: Colors.white,fontSize:width/ 91.06),)),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
              ),
            ],
          ),

        ],
      )
    ):
    Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body:
      Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width/91.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                  "Edit Customer",
                  style: GoogleFonts.cairo(
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
                    child: Text("Customer Code",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize: width/136.6,fontWeight: FontWeight.w700),
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
                    child: Text("Customer Name",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Mobile",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Home No",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Street",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Area",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("City/District",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("State",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("Pincode",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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
                    child: Text("GST NO",style: GoogleFonts.poppins(fontSize:width/ 97.57,color: const Color(0xff000000)),),
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
                        style: GoogleFonts.poppins(fontSize:width/ 91.06,fontWeight: FontWeight.w700),
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

                    showdialpogbox();
                  },
                  child: Container(width:width/8.6,
                    height: height/16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff25D366),),child: Center(child: Text("Edit Customer",style: GoogleFonts.poppins(color: Colors.white,fontSize:width/ 91.06),)),
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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.red,),child: Center(child: Text("Reset",style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
              ),
            ],
          ),

        ],
      )
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
                    Text("Edit Customer  Successfully",style: GoogleFonts.poppins(
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

                    InkWell(
                      onTap: (){
                        upadtecustomers();
                        clearallcontroller();
                        Navigator.pop(context);

                      },
                      child: Material(
                        elevation: 15,
                          color: const Color(0xff25D366),
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height/16.425,
                          width: width/7.588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366)
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
    homeno.clear();
    street.clear();
    Area.clear();
    CityDis.clear();
    State.clear();
    Pincode.clear();
    Gstno.clear();
  }

  upadtecustomers(){
    FirebaseFirestore.instance.collection("Customer").doc(widget.docid).update({
      "Alphone":alMobileno.text,
      "Customermobileno":Mobileno.text,
      "Customername":Suppliername.text,
      "Customer address":"${homeno.text},${street.text},${Area.text},${CityDis.text},${State.text},${Pincode.text},${Gstno.text}",
      "Customer GstNo": Gstno.text,
      "Customer state ":State.text,
      "Customer pincode ": Pincode.text,
      "Customer city ": CityDis.text,
      "Customer street ": street.text,
      "Customer homeno ":homeno.text,
      "Customer area ": Area.text,
    });
  }

}
