import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../pattern_page.dart';

class Service_Update_Status_Page extends StatefulWidget {
  String docid;
  Service_Update_Status_Page(this.docid);

  @override
  State<Service_Update_Status_Page> createState() => _Service_Update_Status_PageState();
}

class _Service_Update_Status_PageState extends State<Service_Update_Status_Page> {

  TextEditingController totalcost=TextEditingController();
  TextEditingController advance=TextEditingController();
  TextEditingController balance=TextEditingController();
  TextEditingController amount=TextEditingController();

  @override
  void initState() {
    Stausfunction();
    addpaymentmode();
    setdata();
    // TODO: implement initState
    super.initState();
  }



  categoryaddfunction() async {
    var Document = await FirebaseFirestore.instance.collection('category').orderBy("categoryname", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
  }

  Servicestatuscreatefunction(){
    FirebaseFirestore.instance.collection("Service_Status").doc().set({
      "service status":Status.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });

  }

  Stausfunction() async {
    setState(() {
      statuslist.clear();
    });
    setState(() {
      statuslist.add("Please Select");
    });
    var Document = await FirebaseFirestore.instance.collection('Service_Status').orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        statuslist.add(Document.docs[i]['service status']);
      });

    }
  }





  List<String> categorylist = <String>[];
  List<String> statuslist=["Please Select"];
  String status="Please Select";

  String Payments = "Please Select Type";
  List<String> Payment = <String>[
    'Please Select Type',
  ];
  addpaymentmode() async {
    setState((){
      Payment.clear();
      Payment.add("Please Select Type");
    });
    var listofpayment=await FirebaseFirestore.instance.collection('PaymentTypes').orderBy("Paymentname").get();
    for(int k=0;k<listofpayment.docs.length;k++){
      setState((){
        Payment.add(listofpayment.docs[k]['Paymentname']);
      });
    }
  }

  TextEditingController Category=TextEditingController();

  TextEditingController itemdiscontroller=TextEditingController();

  TextEditingController sparesmontroller=TextEditingController();

  TextEditingController Status=TextEditingController();

  List<String>Mobile=[];
  List<String>Billno=[];
  String Customername="";
  List<String>Serviceproblem=[];



  serviceitem()async{
    setState(() {
      Serviceproblem.clear();
    });
    var Document2 = await FirebaseFirestore.instance.collection("Sevice_items").where("Category",isEqualTo: Category.text).get();
    for (int i = 0; i < Document2.docs.length; i++) {
      Serviceproblem.add(Document2.docs[i]['description']);

    }
  }


  String documentid="";
  String billno="";
  String Brand='';
  String Categorys='';
  String Date='';
  bool mmccard=false;
  bool battery=false;
  bool charger=false;
  bool simcard=false;
  String color='';
  String imeino='';
  String model='';
  String pattern="";
  List<int> patternlist=[];
  String receivedperson='';

  String Customerphone="";
  String CustomerAlphone="";
  String deviverlydate="";
  String deviverlytime="";
  String Paymentmode="";
  String remarks="";
  String passwordtype="";
  String password="";



   bool setvalid=false;


   setdata() async {
     print("Fun Called");
     var document =  await FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid).get();
     Map<String,dynamic> ? val = document.data();
     setState(() {
        billno=val!["billno"];
        Brand=val["brand"];
        Date=val["date"];
        mmccard=val["mmc"];
        battery=val["battery"];
        charger=val["charger"];
        color=val["color"];
        imeino=val["imei"];
        model=val["model"];
        receivedperson=val["received person"];
        simcard=val["sim"];
        Customerphone=val["cusmob"];
        CustomerAlphone=val["cusalmob"];
        Customername=val["cusname"];
        deviverlydate=val["deliverydate"];
        deviverlytime=val["deliverytime"];
        Paymentmode=val["Paymentmode"];
        remarks=val["remarks"];
        passwordtype=val["phonelocktype"];
        password=val["password"];
        status=val["status"];
        totalcost.text=val["totalcost"].toString();
        advance.text=val["advance"].toString();
        balance.text=val["balance"].toString();


        for(int i=0;i<val["patternlist"].length;i++){
          patternlist.add(val["patternlist"][i]);
        }
     });


     var document2 =  await FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid).collection("Problems").get();
     for(int i=0;i<document2.docs.length;i++){
       setState(() {
         Serviceproblems.add(document2.docs[i]["problem"]);
         Serviceproblemscost.add(document2.docs[i]["cost"]);
       });
     }

   }
   
   List Serviceproblems =[];
   List Serviceproblemscost =[];


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff263646),
        title: Text("Bill Details",style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          fontSize: width/70.39,
          color:Colors.white,
        )),
      ),
      backgroundColor: Color(0xff00A99D),
      body: Column(
        children: [

          SizedBox(
            height: height/70.32,
          ),
          //category container
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding:  EdgeInsets.only(
                    left:  width/170.75
                ),
                child: Container(
                  height: height/1.12,
                  width: width/1.632,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                         Row(
                           children: [
                             //bill no
                             SizedBox(
                               height:height/20.425,
                               width:width/9.106,
                               child: Text("Bill NO",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/79.39,
                                 color:Colors.black,
                               )),
                             ),
                             SizedBox(

                               height:height/20.425,
                               width:width/6.276,
                               child: Text(": $billno",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/79.39,
                                 color:Colors.black,
                               )),
                             ),
                             //item name
                             SizedBox(
                               height:height/20.425,
                               width:width/9.106,

                               child: Text("Received Date",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/79.39,
                                 color:Colors.black,
                               )),
                             ),
                             SizedBox(
                               height:height/20.425,
                               width:width/6.276,
                               child: Text(": $Date",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/79.39,
                                 color:Colors.black,
                               )),
                             ),
                           ],
                         ),

                          //category and brand
                          Row(
                            children: [
                              //category
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Customer Name",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $Customername",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              //brand
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Customer Phone",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $Customerphone",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                            ],
                          ),


                          //customer name and phone
                          Row(
                            children: [
                              //customer name
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Alternative Phone",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $CustomerAlphone",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              //customer phone

                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Delivery Date",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $deviverlydate",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),



                          //date and time
                          Row(
                            children: [
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Payment Mode",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $Paymentmode",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              //time
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Delivery Time",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $deviverlytime",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),

                          //mmc card and battery
                          Row(
                            children: [
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("MMC-Card",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child:
                                mmccard==false?
                                Text(": No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )):
                                Text(": Yes",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              //battery
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Battery",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                           SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child:
                                battery==false?
                                Text(": No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )):
                                Text(": Yes",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),


                          //charger and simcard
                          Row(
                            children: [
                            SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Charger",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child:charger==false?
                                Text(": No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )):
                                  Text(": Yes",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                              ),


                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Sim Card",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: simcard==false?
                                Text(": No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )):
                                Text(": Yes",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),


                          Row(
                            children: [
                              //color
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Brand",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $Brand",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              //imei no
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Imei No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $imeino",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              //color
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Model No",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $model",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Remarks",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $remarks",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              //color
                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,
                                child: Text("Color",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              SizedBox(
                                height:height/20.425,
                              width:width/6.276,
                                child: Text(": $color",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),
                              //imei no

                            ],
                          ),


                          //model no and pin






                          Row(
                            children: [

                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Password Type",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $passwordtype",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Password",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),

                              SizedBox(
                                height:height/20.425,
                                width:width/6.276,
                                child: Text(": $password",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              )

                            ],
                          ),


                          SizedBox(height:height/45.7),
                          Row(
                            children: [

                              SizedBox(
                                height:height/20.425,
                                width:width/9.106,

                                child: Text("Service Problems",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                )),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 500,
                                width: 645,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),

                                    itemCount: Serviceproblems.length,
                                    itemBuilder: (context,index){
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          child: Text("${(index+1).toString()}.",style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/79.39,
                                            color:Colors.black,
                                          )),
                                        ),
                                      ),
                                      SizedBox(

                                        width:width/3.106,

                                        child: Text(Serviceproblems[index],style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.w600,
                                          fontSize: width/79.39,
                                          color:Colors.black,
                                        )),
                                      ),
                                      SizedBox(
                                        height:height/20.425,
                                        width:width/9.106,

                                        child: Text(Serviceproblemscost[index],style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.w600,
                                          fontSize: width/79.39,
                                          color:Colors.black,
                                        )),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              SizedBox(
                                width:width/6.515,
                                height: height / 3,
                                child:  IgnorePointer(
                                  ignoring: true,
                                  child: PatternLock2(
                                    used: patternlist,
                                    // color of selected points.
                                    selectedColor: Colors.red,
                                    // radius of points.
                                    pointRadius: 10,
                                    // whether show user's input and highlight selected points.
                                    showInput: true,
                                    // count of points horizontally and vertically.
                                    dimension: 3,
                                    // padding of points area relative to distance between points.
                                    relativePadding: 0.7,
                                    // needed distance from input to point to select point.
                                    selectThreshold: 25,
                                    // whether fill points.
                                    fillPoints: true,
                                    // callback that called when user's input complete. Called if user selected one or more points.
                                    onInputComplete: (List<int> input) {
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  )

                ),
              ),

              Padding(
                padding:  EdgeInsets.only(right:  width/170.75
                ),
                child: Container(
                  height: height/1.72,
                  width: width/2.732,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Category
                      Padding(
                        padding:  EdgeInsets.only(left: width/53.55),
                        child:
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                ),),
                                Container(
                                    width: width / 7.0,
                                    height: height / 16.42,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: DropdownButton2<String>(
                                      value: status,
                                      isExpanded: true,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width / 105.07),
                                      underline: Container(
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          status = value!;
                                        });
                                      },
                                      items: statuslist.map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),

                                ),
                              ],
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: width/53.55),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment Mode",style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width/79.39,
                                    color:Colors.black,
                                  ),),
                                  Container(
                                      width: width / 7.0,
                                      height: height / 16.42,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: DropdownButton2<String>(
                                        value: Payments,
                                        isExpanded: true,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width / 105.07),
                                        underline: Container(
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            Payments = value!;
                                          });
                                        },
                                        items: Payment.map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),

                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),



                      //spare container
                      //Service Spares
                      Padding(
                        padding:  EdgeInsets.only(left: width/53.55),
                        child:
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Cost",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                ),),
                                Container(
                                    width: width / 7.0,
                                    height: height / 16.42,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: TextField(
                                      controller: totalcost,
                                      style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: width/53.55),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Advance",style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width/79.39,
                                    color:Colors.black,
                                  ),),
                                  Container(
                                      width: width / 7.0,
                                      height: height / 16.42,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(4)),
                                      child:
                                      TextField(
                                        controller: advance,
                                        style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Status
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: width/53.55),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Balance",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                ),),
                                Container(
                                  width: width / 7.0,
                                  height: height / 16.42,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: TextField(
                                    controller: balance,
                                    style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                      border: InputBorder.none,
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: width/53.55),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Amount",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/79.39,
                                  color:Colors.black,
                                ),),
                                Row(
                                  children: [
                                    Container(
                                        width: width / 6.504,
                                        height: height / 16.42,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDDDEEE),
                                            borderRadius: BorderRadius.circular(4)),
                                        child:
                                        TextField(
                                          controller: amount,
                                          style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                    ),
                                    SizedBox(
                                      width: width / 273.2,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height/32.85,),

                      Row(
                        children: [

                          //submit button
                          Padding(
                            padding:  EdgeInsets.only(left: width/53.55),
                            child: InkWell(
                              onTap: (){
                                updatestatus();
                                savebillshowdialpogbox();

                              },
                              child: Container(
                                height: height / 16.4,
                                width: width / 9.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xff4477CE),
                                  borderRadius: BorderRadius.circular(7),),
                                child:
                                Center(
                                  child: Text(
                                    "Update Bill",
                                    style: GoogleFonts.cairo(
                                        fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Clear button

                        ],
                      )
                    ],
                  ),

                ),
              ),

            ],
          ),




        ],
      ),
    );
  }

  //popup function
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.760,bottom: height/4.76),
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
                    SizedBox(height:height/ 32.85,),
                    Text("Add Data Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height:height/ 32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/ 32.85,),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                           Status.clear();
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/9.588,
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
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 85.375,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }




  updatestatus(){
    FirebaseFirestore.instance.collection("Service Bills").doc(widget.docid).update({
      "balance":FieldValue.increment(-int.parse(amount.text)),
      "status":status,
      "deliverytime":"${DateFormat('hh:mm a').format(DateTime.now())}",
      "deliverydate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    });
  }

  savebillshowdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.760,bottom: height/4.76),
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
                    SizedBox(height:height/ 32.85,),
                    Text("Updated Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height:height/ 32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/ 32.85,),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){

                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/9.588,
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
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text("Cancel",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 85.375,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }

  Widget textfield2(FocusNode focusNode, TextEditingController textEditingController, onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.only(  left: width / 130.6)),
      controller: Category,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }

  Widget textfield3(FocusNode focusNode, TextEditingController textEditingController, onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      TextFormField(
        style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.only(  left: width / 130.6)),
      controller: Status,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}
