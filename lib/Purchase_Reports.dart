
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Purchase_Reports extends StatefulWidget {
  const Purchase_Reports({Key? key}) : super(key: key);

  @override
  State<Purchase_Reports> createState() => _Purchase_ReportsState();
}

class _Purchase_ReportsState extends State<Purchase_Reports> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              child: Text(" Purchase Reports",
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
                        width:100,
                        child: Center(child: Text('Invoice',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 30,),

                    Container(
                        width:130,

                        child: Center(child: Text('Date',
                            textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 30,),

                    Container(
                        width:100,

                        child: Center(child: Text('State',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 50,),

                    Container(
                        width:100,

                        child: Center(child: Text('Supplier',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 60,),

                    Container(
                        width:100,

                        child: Center(child: Text('HSN Code',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                    SizedBox(width: 50,),

                    Container(
                        width:100,
                        child: Center(child: Text('Payment',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                    SizedBox(width: 50,),

                    Container(
                        width:130,
                        child: Center(child: Text('Total',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                    SizedBox(width: 50,),


                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 5,right: 5),
                  child: Divider(),
                ),

                Container(
                  child: StreamBuilder<QuerySnapshot>(
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
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child:
                              Row(
                                children: [
                                  SizedBox(width: 40,),

                                  Container(
                                      width:100,
                                      child: Center(child: Text(buillin1['purchaseno'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                  SizedBox(width: 30,),

                                  Container(
                                      width:130,

                                      child: Center(child: Text(buillin1['purchasedate'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                  SizedBox(width: 30,),

                                  Container(
                                      width:100,

                                      child: Center(child: Text(buillin1['suppilerid'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                  SizedBox(width: 50,),

                                  Container(
                                      width:100,

                                      child: Center(child: Text(buillin1['suppilername'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                  SizedBox(width: 60,),

                                  Container(
                                      width:100,

                                      child: Center(child: Text(buillin1['Hsncode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),

                                  SizedBox(width: 50,),

                                  Container(
                                      width:100,
                                      child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                  SizedBox(width: 50,),

                                  Container(
                                      width:130,
                                      child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),))),
                                  SizedBox(width: 50,),


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
                                          width:100,
                                          height:30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.green
                                          ),
                                          child: Center(child: Text("View",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),))),
                                    ),
                                  ),

                                  SizedBox(width: 10,),


                                  //edit button
                                  InkWell(
                                    onTap: (){

                                      showtextfield(buillin1.id);


                                    },
                                    child: Material(
                                      elevation: 10,

                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          width:30,
                                          height:30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),

                                          ),
                                          child: Center(child: Icon(Icons.edit,color: Colors.black,size:20))),
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

  int qty=0;
  double Total=0;
  String state="";
  String invoice="";
  String invoice_date="";
  String Suppiler="";
  String SGST="";
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
      SGST=values['SGST'].toString();
      CGST=values['CGST'].toString();
      TotalAmount=values['Totalamount'].toString();

    });


    var documents=await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).get();
    for(int i=0;i<documents.docs.length;i++){
      print(documents.docs.length.toString());
      print(documents.docs[i]['Total'].toString());

      setState(() {
        Total=(Total+double.parse(documents.docs[i]['Total'].toString()));
        qty=(qty+int.parse(documents.docs[i]['Qty'].toString()));
      });
      print(Total);
      print(qty);

      showdialpogbox(streamid);

    }


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
            padding:  EdgeInsets.only(left: 100.0,right: 100,top: 100,bottom: 100),
            child:
            Scaffold(
              body:  Center(
                child: Container(
                  height:600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5,),

                      Text("Edit the Purchase Reports",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),

                      SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.only(left: 200.0),
                        child: Container(
                          height:380,
                          child:
                          Column(
                            children: [

                              //invoice no
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Invoice No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
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
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Purchase Date",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child: TextField(
                                            style: GoogleFonts.montserrat(),
                                            controller:Purchasedate,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Suppiler ID",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child: TextField(
                                            style: GoogleFonts.montserrat(),
                                            controller:Suppilerid,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Suppiler Name",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child: TextField(
                                            style: GoogleFonts.montserrat(),
                                            controller:Suppilername,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Hsn No",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child: TextField(
                                            style: GoogleFonts.montserrat(),
                                            controller:Hsncode,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Payment",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey.shade200
                                          ),
                                          child: TextField(
                                            style: GoogleFonts.montserrat(),
                                            controller:Payment,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:120,
                                        child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                    SizedBox(width:10),
                                    Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height:40,
                                          width:300,
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
                                              contentPadding: EdgeInsets.only(left: 10),
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height/16.425,
                            width: width/7.588,
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
            padding:  EdgeInsets.only(left: 100.0,right: 100,top: 100,bottom: 100),
            child:
            Scaffold(
              body:  Center(
                child: Container(
                  height:600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5,),

                      Text("Edit the Purchase Reports",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),),

                      SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.only(left: 200.0),
                        child: Container(
                            height:380,
                            child:
                            Column(
                              children: [


                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("Description",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Decription,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("HSN code",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Hsncode2,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("Quantity",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Quvantity,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("Rate",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Rate,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("Tax",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.grey.shade200
                                            ),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller:Tax,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: 10),
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width:120,
                                          child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
                                      SizedBox(width:10),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height:40,
                                            width:300,
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
                                                contentPadding: EdgeInsets.only(left: 10),
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height/16.425,
                            width: width/7.588,
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
            padding:  EdgeInsets.only(top: 10.0,bottom:height/136.6,left: 200,right: 200),
            child: Scaffold(

              body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),

                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Purchase Details",style: GoogleFonts.poppins(decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              height: 30,
                              width: 150,
                              child: Center(child: Text("Invoice: ${invoice.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 30,
                              width: 150,
                              child: Center(child: Text("Date: ${invoice_date.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 50,
                              width: 200,
                              child: Center(child: Text("Supplier Name: ${Suppiler.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 30,
                              width: 180,
                              child: Center(child: Text("State: ${state.toString()}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Si.No",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Description",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("HSN Code",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),
                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Quantity",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),

                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Price",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),
                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Tax",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),
                            Container(
                              height: 30,
                              width: 130,
                              child: Center(child: Text("Amount",style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)),
                            ),
                          ],
                        ),
                        Divider(),

                        Container(
                          height: 450,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).snapshots(),
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
                                 return  Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     children: [
                                       SizedBox(width: 10,),
                                       Container(
                                         height: 30,
                                         width: 130,
                                         child: Center(child: Text("${index+1}",style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 60,
                                         width: 130,
                                         child: Center(child: Text(purchase['Description'].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 30,
                                         width: 130,
                                         child: Center(child: Text(purchase['Hsncode'].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 30,
                                         width: 130,
                                         child: Center(child: Text(purchase['Qty'].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 30,
                                         width: 130,
                                         child: Center(child: Text(purchase['Landing cost'].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 30,
                                         width: 130,
                                         child: Center(child: Text(purchase["tax"].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       Container(
                                         height: 30,
                                         width: 100,
                                         child: Center(child: Text(purchase['Total'].toString(),style: GoogleFonts.poppins(),)),
                                       ),

                                       SizedBox(width: 10,),

                                       //edit button
                                       InkWell(
                                         onTap: (){

                                           showtextfield2(streamid,purchase.id);

                                         },
                                         child: Material(
                                           elevation: 10,

                                           borderRadius: BorderRadius.circular(100),
                                           child: Container(
                                               width:30,
                                               height:30,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(100),

                                               ),
                                               child: Center(child: Icon(Icons.edit,color: Colors.black,size:20))),
                                         ),
                                       ),

                                     ],
                                   ),
                                 );
                               },);
                            },),
                        ),

                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),

                              Container(
                                height: 30,
                                  width: 200,
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
                                width: 20,
                              ),

                              Container(
                                height: 30,
                                width: 200,
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
                                width: 20,
                              ),
                              Container(
                                height: 30,
                                width: 200,
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
                                width: 20,
                              ),

                              Container(
                                height: 30,
                                width: 200,
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
                        )

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
