import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Edit_billing_Page.dart';
import '../LandingPage/LandingPage.dart';
import '../Puchase edit_page1.dart';

class SL_return_reports extends StatefulWidget {
  const SL_return_reports({Key? key}) : super(key: key);

  @override
  State<SL_return_reports> createState() => _SL_return_reportsState();
}

class _SL_return_reportsState extends State<SL_return_reports> {

  @override
  void initState() {
    totalamount();
    // TODO: implement initState
    super.initState();
  }

  int Totalamount=0;

  totalamount()async{
    setState(() {
      Totalamount=0;
    });
    var fetchdata=await FirebaseFirestore.instance.collection("Purchase entry").get();
    for(int i=0;i<fetchdata.docs.length;i++){
      var fetchdata2=await FirebaseFirestore.instance.collection("Purchase entry").doc(fetchdata.docs[i].id)
          .collection(fetchdata.docs[i].id).where("return",isEqualTo:true).get();
      for(int j=0;j<fetchdata2.docs.length;j++){
        setState(() {
          Totalamount=(Totalamount+double.parse(fetchdata2.docs[j]['Total'])).toInt();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        //title and back button
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 91.066,
            ),
           /* InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  drawer(" "),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.only(top: height / 32.85),
                child: Tooltip(
                  message: "Back",
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Colors.indigo,
                    child: Container(
                      height: height / 21.9,
                      width: width / 45.53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: width / 91.06,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            Padding(
              padding:
              EdgeInsets.only(left: width / 35.947, top: height / 32.85),
              child: Text(
                "Sales Returns",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: width / 59.39,
                  color: Colors.black,
                ),
              ),
            ),

            //toggle switchs
            Padding(
              padding:  EdgeInsets.only(left: width/4.583, right: width/56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
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
              style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
            ),



            Padding(
              padding:  EdgeInsets.only(left: width/45.583, right: width/56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
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
              style: GoogleFonts.openSans(color: Colors.white, fontSize:width/80.353),
            ),
          ],
        ),

        //line image
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 36.5, horizontal: width / 75.88),
          child: Image.asset("assets/Line13.png"),
        ),

        Container(
          height: height/1.394,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child:SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height:25),
                Row(
                  children: [
                    SizedBox(width:width/34.15,),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Date",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Bill No",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Customer Gst No",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/4.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Customer Name",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.66,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Payment Type",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/10.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Total",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    Container(
                        width:width/6.507,
                        height:height/13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(child: Text("Actions",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                    //SizedBox(width:width/27.32,),

                  ],
                ),
                status==true?
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("billing ShabikaG").
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['return']==true?
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
                                  Center(
                                    child: Text(buillin1['purchasedate'].toString(),
                                      style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              ),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(buillin1['purchaseno'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
                                      buillin1['return']==true?
                                      Text("(Return)",
                                        style:
                                        GoogleFonts.openSans(fontSize: width/97.571, color:  Colors.red),
                                      ):const SizedBox(),
                                    ],
                                  )
                              ),



                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Customer GstNo'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/4.66,
                                  height:height/13.14,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/6.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //view button
                                      InkWell(
                                        onTap: (){
                                          showdialpogbox(
                                            buillin1.id,
                                            buillin1['Payment mode'],
                                            buillin1['Discountamount'],
                                            buillin1['Discountamountpercentage'],);
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
                                              child: Center(child: Text("View",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.white),))),
                                        ),
                                      ),

                                      SizedBox(width:width/136.6,),
                                      //edit button
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
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
                                  )
                              ),

                            ],
                          ):const SizedBox();
                      },);
                  },
                ):
                status2==true?
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("billing ShabikaN").
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['return']==true?
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
                                  Center(
                                    child: Text(buillin1['purchasedate'].toString(),
                                      style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              ),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(buillin1['purchaseno'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
                                      buillin1['return']==true?
                                      Text("(Return)",
                                        style:
                                        GoogleFonts.openSans(fontSize: width/97.571, color:  Colors.red),
                                      ):const SizedBox(),
                                    ],
                                  )
                              ),



                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Customer GstNo'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/4.66,
                                  height:height/13.14,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/6.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //view button
                                      InkWell(
                                        onTap: (){
                                          showdialpogbox(
                                            buillin1.id,
                                            buillin1['Payment mode'],
                                            buillin1['Discountamount'],
                                            buillin1['Discountamountpercentage'],);
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
                                              child: Center(child: Text("View",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.white),))),
                                        ),
                                      ),

                                      SizedBox(width:width/136.6,),
                                      //edit button
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
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
                                  )
                              ),

                            ],
                          ):const SizedBox();
                      },);
                  },
                ):

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("billing").
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {

                        var buillin1=snapshot.data!.docs[index];
                        return
                          buillin1['return']==true?
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
                                  Center(
                                    child: Text(buillin1['purchasedate'].toString(),
                                      style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              ),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(buillin1['purchaseno'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),),
                                      buillin1['return']==true?
                                      Text("(Return)",
                                        style:
                                        GoogleFonts.openSans(fontSize: width/97.571, color:  Colors.red),
                                      ):const SizedBox(),
                                    ],
                                  )
                              ),



                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Customer GstNo'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/4.66,
                                  height:height/13.14,
                                  padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['customername'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.66,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Payment mode'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/10.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2)
                                  ),
                                  child: Center(child: Text(buillin1['Total'].toString(),style: GoogleFonts.openSans(fontWeight: FontWeight.w600),))),

                              Container(
                                  width:width/6.507,
                                  height:height/13.14,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //view button
                                      InkWell(
                                        onTap: (){
                                          showdialpogbox(
                                            buillin1.id,
                                            buillin1['Payment mode'],
                                            buillin1['Discountamount'],
                                            buillin1['Discountamountpercentage'],);
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
                                              child: Center(child: Text("View",style: GoogleFonts.openSans(fontWeight: FontWeight.w600,color: Colors.white),))),
                                        ),
                                      ),

                                      SizedBox(width:width/136.6,),
                                      //edit button
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Billing_Page(buillin1.id),));
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
                                  )
                              ),

                            ],
                          ):const SizedBox();
                      },);
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: height/65.7,),

      ],
    );
  }

  //toggle switch boolean
  bool status=true;
  bool status2=false;
  int qty=0;
  double Total=0;
  String state="";
  String invoice="";
  String invoice_date="";
  String Suppiler="";
  String SGST='';
  String CGST="";
  String TotalAmount="";
  String purchasenTotalAmount="";

  checkqty(streamid) async {
    setState(() {
      qty=0;
      Total=0;
    });
    if(status==true){
      var document=await FirebaseFirestore.instance.collection("billing ShabikaG").doc(streamid).get();
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
      var documents=await FirebaseFirestore.instance.
      collection("billing ShabikaG").doc(streamid).collection(streamid).get();
      for(int i=0;i<documents.docs.length;i++){

        setState(() {
          Total=(Total+double.parse(documents.docs[i]['Total'].toString()));
          qty=(qty+int.parse(documents.docs[i]['Qty'].toString()));
        });

      }
    }

    else if(status2==true){
      var document=await FirebaseFirestore.instance.collection("billing ShabikaN").doc(streamid).get();
      Map<String,dynamic>?values=document.data();
      setState(() {
        invoice=values!['purchaseno'].toString();
        invoice_date=values['purchasedate'].toString();
        Suppiler=values['suppilername'].toString();
        SGST=double.parse(values['SGST'].toString()).toStringAsFixed(2);
        CGST=double.parse(values['CGST'].toString()).toStringAsFixed(2);
        TotalAmount=double.parse(values['Totalamount'].toString()).toStringAsFixed(2);
        purchasenTotalAmount=double.parse(values['Total'].toString()).toStringAsFixed(2);
        state=values['state'];
      });
      var documents=await FirebaseFirestore.instance.
      collection("billing ShabikaN").doc(streamid).collection(streamid).get();
      for(int i=0;i<documents.docs.length;i++){

        setState(() {
          Total=(Total+double.parse(documents.docs[i]['Total'].toString()));
          qty=(qty+int.parse(documents.docs[i]['Qty'].toString()));
        });

      }

    }
    else{
      var document=await FirebaseFirestore.instance.collection("billing").doc(streamid).get();
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
      var documents=await FirebaseFirestore.instance.
      collection("billing").doc(streamid).collection(streamid).get();
      for(int i=0;i<documents.docs.length;i++){

        setState(() {
          Total=(Total+double.parse(documents.docs[i]['Total'].toString()));
          qty=(qty+int.parse(documents.docs[i]['Qty'].toString()));
        });

      }

    }

  }



  showdialpogbox(streamid,
   Payment ,
  Discountamount,
  Discountamountpercentage,) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      showDialog(
        context: context,
        builder: (context) {
          return SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                  height:height/ 1.194,
                  width: width/0.975,
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
                                  child: const Center(child: Icon(Icons.clear,color: Colors.white,)),
                                ),
                              ),
                            ),
                            SizedBox(width: width/65.7,),


                          ],
                        ),
                        SizedBox(height: height/45.7,),

                        Padding(
                          padding:  EdgeInsets.only(left: width/50.2),
                          child: Row(

                            children: [

                              Container(
                                width: width/15.2,
                                height:height/13.13,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text("Item Code",
                                  textAlign:TextAlign.center,
                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(

                                width: width/8.0,
                                height:height/13.13,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text('Description',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),


                              Container(
                                height:height/13.13,
                                width: width/10.17,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Hsncode",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),


                              Container(
                                height:height/13.13,
                                width: width/10.691,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Payment",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),




                              Container(
                                height:height/13.13,
                                width: width/20.075,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Qty",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(
                                width: width/10.17,
                                height:height/13.13,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Sales Price",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(

                                width: width/10.17,
                                height:height/13.13,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),
                                ),
                                child: Center(child: Text("Without Tax",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(
                                height:height/13.13,
                                width: width/20.17,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Tax",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(
                                height:height/13.13,
                                width: width/20.66,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Dis %",
                                  textAlign:TextAlign.center,
                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),

                              Container(
                                height:height/13.13,
                                width: width/13.66,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 1.2),

                                ),
                                child: Center(child: Text("Date\nTime",
                                  textAlign:TextAlign.center,

                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),)),
                              ),




                            ],
                          ),
                        ),



                        Padding(
                          padding:  EdgeInsets.only(left: width/50.2),
                          child: SizedBox(
                            height:height/1.602,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("billing").
                              doc(streamid).collection(streamid).orderBy("timestamp",descending: true).snapshots(),
                              builder: (context, snapshot) {
                                if(snapshot.hasData==null){
                                  return Center(child: Container(),);
                                }
                                if(!snapshot.hasData){
                                  return Center(child: Container(),);
                                }
                                return  ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var customer=snapshot.data!.docs[index];
                                    return
                                      customer["return"]==true?
                                      Row(

                                        children: [

                                          Container(
                                            width: width/15.2,
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer["itemcode"].toString(),
                                              textAlign:TextAlign.center,
                                              style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(

                                            width: width/8.0,
                                            height:height/13.13,
                                            padding:EdgeInsets.symmetric(horizontal: width/683,vertical: height/328.5),
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer["Description"].toString(),style: GoogleFonts.openSans(),)),
                                          ),


                                          Container(
                                            height:height/13.13,
                                            width: width/10.17,

                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer['Hsncode'].toString(),style: GoogleFonts.openSans(),)),
                                          ),


                                          Container(
                                            height:height/13.13,
                                            width: width/10.691,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(Payment.toString(),style: GoogleFonts.openSans(),)),
                                          ),


                                          Container(
                                            height:height/13.13,
                                            width: width/20.075,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer['Qty'].toString(),style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(
                                            width: width/10.17,
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer['Sales price'].toString(),style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(

                                            width: width/10.17,
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            child: Center(child: Text(customer['withouttaxprice'].toString(),style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            width: width/20.17,

                                            child: Center(child: Text(customer['tax'].toString(),style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            width: width/20.66,

                                            child: Center(child: Text("$Discountamount\n$Discountamountpercentage".toString(),
                                              textAlign:TextAlign.center,
                                              style: GoogleFonts.openSans(),)),
                                          ),

                                          Container(
                                            height:height/13.13,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.2)),
                                            width: width/13.66,

                                            child: Center(child: Text("${customer['date']}\n${customer['time']}".toString(),
                                              textAlign:TextAlign.center,

                                              style: GoogleFonts.openSans(),)),
                                          ),




                                        ],
                                      )  : SizedBox();
                                  },);
                              },),
                          ),
                        ),

                        SizedBox(
                          height: height/32.85,
                        ),




                        SizedBox(
                          height: height/32.85,
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
