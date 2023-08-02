
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'Puchase edit_page1.dart';
import 'Purchase_edit_Page2.dart';

class Purchase_Reports extends StatefulWidget {

  @override
  State<Purchase_Reports> createState() => _Purchase_ReportsState();
}

class _Purchase_ReportsState extends State<Purchase_Reports> {

  //toggle switch boolean
  bool status=false;
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
              child: Text(" Purchase Reports",
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
                    SizedBox(width:width/34.15,),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Invoice No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                    Container(
                        width:width/10.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Bill No",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Supplier ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/4.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Suppiler Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/15.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),



                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Payment",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),

                    Container(
                        width:width/10.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),))),
                    SizedBox(width:width/27.32,),

                  ],
                ),

                status==true?
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Purchase ShabikaG").
                  orderBy("timestamp",descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData==null){
                      return Center(child: Container());
                    }
                    if(!snapshot.hasData){
                      return Center(child: Container());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['save']==true?
                          Row(
                            children: [
                              SizedBox(width:width/34.15,),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child:
                                  Center(child:
                                  Text("${buillin1['suppilierinvoiceno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  ))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                              Container(
                                  width:width/4.66,
                                  height:height/13.14,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                              Container(
                                  width:width/15.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),


                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                              SizedBox(width:width/27.32,),


                              //view button
                              InkWell(
                                onTap: (){
                                  checkqty(buillin1.id);

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

                              SizedBox(width:width/136.6,),


                              //edit button
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));

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
                ):
                status2==true?
                StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Purchase ShabikaN").
                      orderBy("timestamp",descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData==null){
                          return Center(child: Container());
                        }
                        if(!snapshot.hasData){
                          return Center(child: Container());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            var buillin1=snapshot.data!.docs[index];
                            return
                              buillin1['save']==true?
                              Row(
                                children: [
                                  SizedBox(width:width/34.15,),

                                  Container(
                                      width:width/10.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child:
                                      Center(child:
                                      Text("${buillin1['suppilierinvoiceno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ))),

                                  Container(
                                      width:width/10.507,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                                  Container(
                                      width:width/10.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                                  Container(
                                      width:width/4.66,
                                      height:height/13.14,
                                      padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                                  Container(
                                      width:width/15.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),



                                  Container(
                                      width:width/10.66,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),


                                  Container(
                                      width:width/10.507,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2)
                                      ),
                                      child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                  SizedBox(width:width/27.32,),


                                  //view button
                                  InkWell(
                                    onTap: (){
                                      checkqty(buillin1.id);

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

                                  SizedBox(width:width/136.6,),


                                  //edit button
                                  InkWell(
                                    onTap: (){

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));


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
                    ):
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Purchase entry").
                  orderBy("timestamp",descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData==null){
                      return Center(child: Container());
                    }
                    if(!snapshot.hasData){
                      return Center(child: Container());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['save']==true?
                          Row(
                            children: [
                              SizedBox(width:width/34.15,),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child:
                                  Center(child:
                                  Text("${buillin1['suppilierinvoiceno'].toString()}\n${buillin1['return']==true?"Return":""}",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/4.66,
                                  height:height/13.14,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/15.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Totalamount'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                              SizedBox(width:width/27.32,),


                              //view button
                              InkWell(
                                onTap: (){
                                  checkqty(buillin1.id);
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

                              SizedBox(width:width/136.6,),
                              //edit button
                              InkWell(
                                onTap: (){

                               Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage1_purchase(buillin1.id),));


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
              ],
            ),
          ),
        )

      ],
    );
  }

  int qty=0;
  double Total=0;
  String state="";
  String invoice="";
  String invoice_date="";
  String Suppiler="";
  String SGST='';
  String CGST="";
  String TotalAmount="";

  checkqty(streamid) async {
    setState(() {
       qty=0;
       Total=0;
    });
    var document=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).get();
    Map<String,dynamic>?values=document.data();
    setState(() {
      invoice=values!['purchaseno'].toString();
      invoice_date=values['purchasedate'].toString();
      Suppiler=values['suppilername'].toString();
      SGST=double.parse(values['SGST'].toString()).toStringAsFixed(2);
      CGST=double.parse(values['CGST'].toString()).toStringAsFixed(2);
      TotalAmount=double.parse(values['Totalamount'].toString()).toStringAsFixed(2);
      state=values['state'];
    });
    print("Suppiler Nameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print(Suppiler);
    print(streamid);
    var documents=await FirebaseFirestore.instance.
    collection("Purchase entry").doc(streamid).collection(streamid).get();
    for(int i=0;i<documents.docs.length;i++){
      print(documents.docs.length.toString());
      print(documents.docs[i]['Total'].toString());

      setState(() {
        Total=(Total+double.parse(documents.docs[i]['Total'].toString()));
        qty=(qty+int.parse(documents.docs[i]['Qty'].toString()));
      });
      print(Total);
      print(qty);

    }

    showdialpogbox(streamid);
  }


  //edit textediticontroller
  TextEditingController Purchasename=TextEditingController();
  TextEditingController Purchasedate=TextEditingController();
  TextEditingController Suppilerid=TextEditingController();
  TextEditingController Suppilername=TextEditingController();
  TextEditingController Hsncode=TextEditingController();
  TextEditingController Payment=TextEditingController();
  TextEditingController Totalamount=TextEditingController();

  //get the purchase entry collection
  getvalur(docid) async {
    var getdate=await FirebaseFirestore.instance.collection("Purchase entry").doc(docid).get();
    Map<String,dynamic>?value=getdate.data();
    setState(() {
      Purchasename.text=value!["purchaseno"];
      Purchasedate.text=value["purchasedate"];
      Suppilerid.text=value["suppilerid"];
      Suppilername.text=value["suppilername"];
      Hsncode.text=value["Hsncode"];
      Payment.text=value["Payment mode"];
      Totalamount.text=value["Total"];
    });

}

clearallcontrolle1(){
   Purchasename.clear();
   Purchasedate.clear();
   Suppilerid.clear();
   Suppilername.clear();
   Hsncode.clear();
   Payment.clear();
   Totalamount.clear();
}

clearallcontrolle2(){
     Decription.clear();
     Hsncode2.clear();
     Quvantity.clear();
     Rate.clear();
     Tax.clear();
     Amount.clear();
  }

//edit popup dialog
  showtextfield(docid){

    getvalur(docid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return showDialog(context: context, builder:(context) {

      return
        Padding(
            padding:  EdgeInsets.only(left: width/13.66,right: width/13.66,top: height/66.7,
                bottom: height/66.7),
            child:
            Scaffold(
              body:  Center(
                child: Container(
                  height:height/1.095,
                  child: SingleChildScrollView(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:height/45.53),

                        Text("Edit the Purchase Reports",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),

                        SizedBox(height:height/45.53),

                        Padding(
                          padding:  EdgeInsets.only(left: width/6.83),
                          child: Container(
                            height:height/1.728,
                            child:
                            Column(
                              children: [

                                //invoice no
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                  vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Invoice No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Purchasename,
                                              decoration: InputDecoration(
                                                hintText: "Enter the IMEI NO",
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //purchase date
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Purchase Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Purchasedate,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Suppiler  no
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Suppiler ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Suppilerid,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Suppiler  name
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Suppiler Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Suppilername,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //hsn code
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Hsn No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Hsncode,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Payment
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Payment",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Payment,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Total amount
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Totalamount,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                              ],
                            )
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            editfunction(docid);
                            checkqty(docid);
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
                                color: Color(0xff25D366),
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
                  ),
                ),
              ),));

    },);

  }



  //editpopup2 textediting controller

  TextEditingController Decription=TextEditingController();
  TextEditingController Hsncode2=TextEditingController();
  TextEditingController Quvantity=TextEditingController();
  TextEditingController Rate=TextEditingController();
  TextEditingController Tax=TextEditingController();
  TextEditingController Amount=TextEditingController();

  //get2 the purchase entry collection
  getvalur2(streamid,docid) async {
    var getdate=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).doc(docid).get();
    Map<String,dynamic>?value=getdate.data();
    setState(() {
      Decription.text=value!["Description"];
      Hsncode2.text=value["Hsncode"];
      Quvantity.text=value["Qty"];
      Rate.text=value["Landing cost"];
      Tax.text=value["tax"];
      Amount.text=value["Total"];
    });

  }

  //edit function-2
  editfunction2(streamid,docid){
    FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).doc(docid).update({
      "Description":Decription.text,
      "Hsncode":Hsncode2.text,
      "Qty":Quvantity.text,
      "Landing cost":Rate.text,
      "tax":Tax.text,
      "Total":Amount.text,
    });
  }

  //edit2 popup dialog
  showtextfield2(stremdocid,docid){

    getvalur2(stremdocid,docid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return showDialog(context: context, builder:(context) {

      return
        Padding(
            padding:  EdgeInsets.only(left:width/13.66,right: width/13.66,top: height/65.7,bottom:  height/65.7),
            child:
            Scaffold(
              body:  Center(
                child: Container(
                  height:height/1.095,
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:height/131.4,),

                      Text("Edit the Purchase Reports",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),

                      SizedBox(height:height/131.4,),

                      Padding(
                        padding:  EdgeInsets.only(left: width/6.83),
                        child: Container(
                            height:height/1.728,
                            child:
                            Column(
                              children: [


                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Description",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Decription,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("HSN code",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Hsncode2,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Quantity",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Quvantity,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Rate",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Rate,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Tax",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Tax,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Total amount
                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: width/341.5,
                                      vertical: height/164.25
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:width/11.38,
                                          child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:width/136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                           height:height/16.425,
                                            width:width/4.55,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Amount,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left:width/136.6),
                                                hintStyle: GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_){

                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                              ],
                            )
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          editfunction2(stremdocid,docid);
                          checkqty(docid);
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
                              color: Color(0xff25D366),
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
                ),
              ),));

    },);

  }



  editfunction(docid){
    FirebaseFirestore.instance.collection("Purchase entry").doc(docid).update({
      "purchaseno":Purchasename.text,
      "purchasedate":Purchasedate.text,
      "suppilerid":Suppilerid.text,
      "suppilername":Suppilername.text,
      "Hsncode":Hsncode.text,
      "Payment mode":Payment.text,
      "Total":Totalamount.text,
    });
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
                            Text("Purchase Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width:width/136.6,),
                            Container(
                              height:height/ 21.9,
                              width: width/9.106,
                              child: Center(child: Text("Invoice: ${invoice.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height:height/ 21.9,
                              width: width/9.106,
                              child: Center(child: Text("Date: ${invoice_date.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              //height:height/ 21.9,
                              width: width/6.83,
                              child: Center(child: Text("Supplier Name: ${Suppiler.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height:height/ 21.9,
                              width:width/ 7.58,
                              child: Center(child: Text("State: ${state.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
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
                              child: Center(child: Text("Item Code",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/3.54,
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
                              child: Center(child: Text('Landing\nCost',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),

                            Container(
                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Purchase\nPrice',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Color(0xff5801e8)),)),
                            ),
                            Container(

                              width: width/13.66,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Sales\nPrice',
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
                            stream: FirebaseFirestore.instance.collection("Purchase entry").
                            doc(streamid).collection(streamid).snapshots(),
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
                                       child: Center(child: Text("${purchase['itemcode']}",style: GoogleFonts.poppins(),)),
                                     ),

                                     Container(
                                       width: width/3.54,
                                       height:height/13.14,
                                       padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                       decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black,width: 1.2)
                                       ),
                                       child: Center(child: Text(purchase['Description'].toString(),
                                         style: GoogleFonts.poppins(
                                           textStyle: TextStyle(
                                             overflow:TextOverflow.ellipsis
                                           )

                                         ),)),
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
                                       child: Center(child: Text(purchase['Landing cost'].toString(),style: GoogleFonts.poppins(),)),
                                     ),

                                     Container(
                                       width: width/13.66,
                                       height:height/13.14,
                                       decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black,width: 1.2)
                                       ),
                                       child: Center(child: Text(purchase['Purchase price'].toString(),style: GoogleFonts.poppins(),)),
                                     ),

                                     Container(

                                       width: width/13.66,
                                       height:height/13.14,
                                       decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black,width: 1.2)
                                       ),
                                       child: Center(child: Text(purchase['Sales price'].toString(),style: GoogleFonts.poppins(),)),
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

                        Row(
                          children: [
                            SizedBox(
                              width:width/27.32,
                            ),

                            Container(
                              height: height/21.9,
                              width: width/6.83,
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text("Sub Total: ${Total.toString()}",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,color: Colors.indigoAccent,fontSize: 15)),
                              ),
                            ),
                            SizedBox(
                              width: width/68.3,
                            ),

                            Container(
                              height: height/21.9,
                              width: width/6.83,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text("SGST(9%): ${SGST.toString()}",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600)),
                              ),
                            ),

                            SizedBox(
                              width: width/68.3,
                            ),
                            Container(
                              height: height/21.9,
                              width: width/6.83,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text("CGST(9%): ${CGST.toString()}",style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(
                              width: width/68.3,
                            ),

                            Container(
                              height: height/21.9,
                              width: width/6.83,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text("Total: ${TotalAmount.toString()}",style:
                                GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18)),
                              ),
                            ),
                          ],
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
