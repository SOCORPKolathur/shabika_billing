import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../pattern_page.dart';

class Service_Update_Status_Page extends StatefulWidget {
  const Service_Update_Status_Page({Key? key}) : super(key: key);

  @override
  State<Service_Update_Status_Page> createState() => _Service_Update_Status_PageState();
}

class _Service_Update_Status_PageState extends State<Service_Update_Status_Page> {

  TextEditingController DateTimecontroller=TextEditingController();
  TextEditingController Mobilecontroller=TextEditingController();
  TextEditingController Billnocontroller=TextEditingController();
  TextEditingController Customernamecontroller=TextEditingController();
  TextEditingController Remarkscontroller=TextEditingController();

  @override
  void initState() {
    setState(() {
      DateTimecontroller.text="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}-${DateFormat.jm().format(DateTime.now())}";
    });
    categoryaddfunction();
    addfunction();
    Stausfunction();
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
    var Document = await FirebaseFirestore.instance.collection('Service_Status').orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      statuslist.add(Document.docs[i]['service status']);
    }
  }

  clearallcontroller(){
     Category.clear();
     itemdiscontroller.clear();
     sparesmontroller.clear();
     Status.clear();
     Remarkscontroller.clear();
     Mobilecontroller.clear();
     Billnocontroller.clear();
     Customernamecontroller.clear();
     Mobilecontroller.clear();
     Billnocontroller.clear();
     Customernamecontroller.clear();
     setState(() {
       documentid="";
       billno="null";
       ItemName="null";
       Brand="null";
       Date="null";
       Time="null";
       mmccard="null";
       battery="null";
       charger="null";
       color="null";
       imeino="null";
       model="null";
       pin="null";
       password="null";
       pattern="null";
       receivedperson="null";
       simcard="null";
       serviceadvancebalance="null";
       servicebalance="null";
       servicecost="null";
       serviceproblem="null";
       serviceremark="null";
       serviceremark2="null";
       servicespares="null";
       ItemDescription="null";
       cusname="null";
       cusphone="null";
       Categorys="null";
     });
  }

  updatefuntion(){
    FirebaseFirestore.instance.collection("Service_Entry").doc(documentid).update({
      "servicespares":sparesmontroller.text,
      "item discount":itemdiscontroller.text,
      "service status":Status.text,
      "Remarks":Remarkscontroller.text,
      "Category":Category.text,
    });

    FirebaseFirestore.instance.collection("Service_Entry").doc(documentid).collection("Update").doc().set({
      "servicespares":sparesmontroller.text,
      "item discount":itemdiscontroller.text,
      "service status":Status.text,
      "Remarks":Remarkscontroller.text,
      "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat.jm().format(DateTime.now()),
      "customermobile":Mobilecontroller.text,
      "customername":Customernamecontroller.text,
      "Category":Category.text,
      "Billno":Billnocontroller.text,
      "documentid":documentid,
      "timestamp":DateTime.now().millisecondsSinceEpoch,

    });

  }

  List<String> categorylist = <String>[];
  List<String> statuslist=[];

  TextEditingController Category=TextEditingController();

  TextEditingController itemdiscontroller=TextEditingController();

  TextEditingController sparesmontroller=TextEditingController();

  TextEditingController Status=TextEditingController();

  List<String>Mobile=[];
  List<String>Billno=[];
  List<String>Customername=[];
  List<String>Serviceproblem=[];

  addfunction() async {
    setState(() {
      Mobile.clear();
      Billno.clear();
      Customername.clear();
    });
    var Document = await FirebaseFirestore.instance.collection("Service_Entry").orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      Mobile.add(Document.docs[i]['customermobile']);
      Billno.add(Document.docs[i]['Billno']);
      Customername.add(Document.docs[i]['customername']);
    }

    if(billno==""){
      setState(() {
        billno="null";
         ItemName="null";
         Brand="null";
         Date="null";
         Time="null";
         mmccard="null";
         battery="null";
         charger="null";
         color="null";
         imeino="null";
         model="null";
         pin="null";
         password="null";
         receivedperson="null";
         simcard="null";
         serviceadvancebalance="null";
         servicebalance="null";
         servicecost="null";
         serviceproblem="null";
         serviceremark="null";
         serviceremark2="null";
         servicespares="null";
         ItemDescription="null";
         cusname="null";
         cusphone="null";
         Categorys="null";
      });
    }

  }

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
  String cusname="";
  String cusphone="";
  String ItemName="";
  String Brand='';
  String Categorys='';
  String Date='';
  String Time='';
  String mmccard='';
  String battery='';
  String charger='';
  String color='';
  String imeino='';
  String model='';
  String pin='';
  String password='';
  String pattern="";
  List<int> patternlist=[];
  String receivedperson='';
  String simcard='';
  String serviceadvancebalance='';
  String servicebalance='';
  String servicecost='';
  String serviceproblem='';
  String serviceremark='';
  String serviceremark2='';
  String servicespares='';
  String ItemDescription="";

  onsubmmited()async{
    var documnet=await FirebaseFirestore.instance.collection("Service_Entry").get();
    for(int i=0;i<documnet.docs.length;i++){
      if(Mobilecontroller.text==documnet.docs[i]['customermobile']||
          Billnocontroller.text==documnet.docs[i]['Billno']||
          Customernamecontroller.text==documnet.docs[i]['customername']){
        setState(() {
          patternlist.clear();
          documentid=documnet.docs[i].id.toString();
          Mobilecontroller.text=documnet.docs[i]['customermobile'].toString();
          cusphone=documnet.docs[i]['customermobile'].toString();
          Billnocontroller.text=documnet.docs[i]['Billno'].toString();
          billno=documnet.docs[i]['Billno'].toString();
          Customernamecontroller.text=documnet.docs[i]['customername'].toString();
          cusname=documnet.docs[i]['customername'].toString();
          Categorys=documnet.docs[i]['Category'].toString();
          Category.text=documnet.docs[i]['Category'].toString();
          Brand=documnet.docs[i]['Brand'].toString();
          Date=documnet.docs[i]['Date'].toString();
          Time=documnet.docs[i]['time'].toString();
          mmccard=documnet.docs[i]['MMC'].toString();
          password=documnet.docs[i]['Password'].toString();
          pattern=documnet.docs[i]['Pattern'].toString();
          battery=documnet.docs[i]['battery'].toString();
          charger=documnet.docs[i]['charger'].toString();
          color=documnet.docs[i]['color'].toString();
          imeino=documnet.docs[i]['imei'].toString();
          model=documnet.docs[i]['modelno'].toString();
          pin=documnet.docs[i]['pin'].toString();
          receivedperson=documnet.docs[i]['receivedperson'].toString();
          serviceadvancebalance=documnet.docs[i]['serviceadvancebalance'].toString();
          servicebalance=documnet.docs[i]['servicebalance'].toString();
          servicecost=documnet.docs[i]['servicecost'].toString();
          simcard=documnet.docs[i]['simcard'].toString();
          servicespares=documnet.docs[i]['servicespares'].toString();
          sparesmontroller.text=documnet.docs[i]['servicespares'].toString();
          Status.text=documnet.docs[i]['service status'].toString();
          ItemName=documnet.docs[i]['itemname'].toString();
          ItemDescription=documnet.docs[i]['itemnamedecription'].toString();
          itemdiscontroller.text=documnet.docs[i]['itemnamedecription'].toString();
          Remarkscontroller.text=documnet.docs[i]["Remarks"].toString();
          setvalid=true;
          if(pattern!=""){
              setState(() {
                patternlist=documnet.docs[i]['Pattern'].cast<int>();
              });
          }
        });
      }
    }

  }

   bool setvalid=false;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [

        //customer name and bill container
        Padding(
          padding:  EdgeInsets.symmetric(
            vertical: height/82.125,
            horizontal: width/170.75
          ),
          child: Container(
            height: height/7.57,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Date Time
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date/Time",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      Container(
                        width: width / 6.504,
                        height: height / 16.42,
                        decoration: BoxDecoration(
                            color: const Color(0xffDDDEEE),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: DateTimecontroller,
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



                //Bill NO
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bill No",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      Container(
                        width: width / 6.504,
                        height: height / 16.42,
                        decoration: BoxDecoration(
                            color: const Color(0xffDDDEEE),
                            borderRadius: BorderRadius.circular(4)),
                        child:

                        LayoutBuilder(
                          builder: (BuildContext, BoxConstraints) =>
                              Autocomplete<String>(
                                initialValue: const TextEditingValue(
                                  selection: TextSelection(
                                    isDirectional: true,
                                    baseOffset: 10,
                                    extentOffset: 1,
                                  ),

                                ),
                                fieldViewBuilder: (context, Controller2,
                                    focusNode, onFieldSubmitted) {
                                  return
                                    TextFormField(
                                      style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                      onChanged: (_){
                                        setState((){
                                          Billnocontroller=Controller2;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                          EdgeInsets.only(  left: width / 130.6)),
                                      controller: Controller2,
                                      focusNode: focusNode,
                                      onFieldSubmitted: (String value) {
                                        onFieldSubmitted();
                                      },
                                    );
                                },
                                optionsViewBuilder:
                                    (context, onSelected, options) => Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.vertical(
                                            bottom:
                                            Radius.circular(4.0)),
                                      ),
                                      child: SizedBox(
                                        height: 52.0 * options.length,
                                        width:
                                        BoxConstraints.biggest.width,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: options.length,
                                          shrinkWrap: false,
                                          itemBuilder: (BuildContext, index) {
                                            final String option = options.elementAt(index);
                                            return InkWell(
                                              onTap: () =>
                                                  onSelected(option),
                                              child: Padding(padding: const EdgeInsets.all(16.0),
                                                child: Text(option),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return const Iterable<String>.empty();
                                  }
                                  return Billno.where((String option) {
                                    return option.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    Billnocontroller.text=selection;
                                  });

                                },
                                displayStringForOption: (Value) {
                                  return Value;
                                },
                              ),
                        )
                      ),
                    ],
                  ),
                ),

                //submit button
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      InkWell(
                        onTap: (){
                          onsubmmited();
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
                              "View",
                              style: GoogleFonts.cairo(
                                  fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                //Mobile
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mobile No",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      Container(
                          width: width / 6.504,
                          height: height / 16.42,
                          decoration: BoxDecoration(
                              color: const Color(0xffDDDEEE),
                              borderRadius: BorderRadius.circular(4)),
                          child:
                          TextField(
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                            controller: Mobilecontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: width / 136.6, bottom: height / 65.7)),
                          )

                      ),
                    ],
                  ),
                ),

                //Customer name
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer Name",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      Container(
                        width: width / 6.504,
                        height: height / 16.42,
                        decoration: BoxDecoration(
                            color: const Color(0xffDDDEEE),
                            borderRadius: BorderRadius.circular(4)),
                        child:

                        TextField(
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                          controller: Customernamecontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7)),
                        )
                      ),
                    ],
                  ),
                ),



                //Clear button
                Padding(
                  padding:  EdgeInsets.only(left: width/53.55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("",style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: width/79.39,
                        color:Colors.black,
                      ),),
                      InkWell(
                        onTap: (){
                          Billnocontroller.clear();
                          Mobilecontroller.clear();
                          Customernamecontroller.clear();
                          setState(() {
                            setvalid=false;
                            billno="null";
                            ItemName="null";
                            Brand="null";
                            Date="null";
                            Time="null";
                            mmccard="null";
                            battery="null";
                            charger="null";
                            color="null";
                            imeino="null";
                            model="null";
                            pin="null";
                            password="null";
                            pattern="";
                            receivedperson="null";
                            simcard="null";
                            serviceadvancebalance="null";
                            servicebalance="null";
                            servicecost="null";
                            serviceproblem="null";
                            serviceremark="null";
                            serviceremark2="null";
                            servicespares="null";
                            ItemDescription="null";
                            cusname="null";
                            cusphone="null";
                            Categorys="null";
                          });
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
                              "Clear",
                              style: GoogleFonts.cairo(
                                  fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
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
                height: height/1.32,
                width: width/1.632,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)
                ),
                child:
                SingleChildScrollView(
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

                             child: Text("Item Name",style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/79.39,
                               color:Colors.black,
                             )),
                           ),
                           SizedBox(
                             height:height/20.425,
                             width:width/6.276,
                             child: Text(": $ItemName",style: GoogleFonts.cairo(
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

                              child: Text("Category",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              height:height/20.425,
                            width:width/6.276,
                              child: Text(": $Categorys",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                            //brand
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

                          ],
                        ),


                        //customer name and phone
                        Row(
                          children: [
                            //customer name
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
                              child: Text(": $cusname",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            //customer phone

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
                              child: Text(": $cusphone",style: GoogleFonts.cairo(
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
                              child: Text("Date",style: GoogleFonts.cairo(
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

                            //time
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,
                              child: Text("Time",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              height:height/20.425,
                              width:width/6.276,
                              child: Text(": $Time",style: GoogleFonts.cairo(
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
                              mmccard=="null"?
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
                              battery=="null"?
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
                              child:charger=="null"?
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
                              child: simcard=="null"?
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


                        //model no and pin
                        Row(
                          children: [
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
                              child: Text("Pin No",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                            SizedBox(
                              height:height/20.425,
                              width:width/6.276,
                              child:
                              pin==""?
                              Text(": No",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )):
                              Text(": $pin",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                          ],
                        ),




                        //service  cost and advance balance amount
                        Row(
                          children: [
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,
                              child: Text("Service Cost",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              height:height/20.425,
                            width:width/6.276,
                              child: Text(": $servicecost",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                            //advance balance
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,

                              child: Text("Advance Balance",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              height:height/20.425,
                              width:width/6.276,
                              child: Text(": $serviceadvancebalance",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                          ],
                        ),


                        //balance amount and service problem
                        Row(
                          children: [
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,

                              child: Text("Balance",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              height:height/20.425,
                            width:width/6.276,
                              child: Text(": $servicebalance",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                            //service problem
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,

                              child: Text("Service Problem",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              width:width/6.276,
                              child: Text(": $serviceproblem",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                          ],
                        ),


                        //service spares and received person
                        Row(
                          children: [
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,
                              child: Text("Service Spares",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                            width:width/6.276,
                              child: Text(": $servicespares",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                            //received person
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,
                              child: Text("Received Person",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              width:width/6.276,
                              child: Text(": $servicespares",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                          ],
                        ),

                        //password and pattern
                        Row(
                          children: [
                            password==""? const SizedBox():
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,

                              child: Text("Password",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            password==""? const SizedBox():
                            SizedBox(
                              height:height/20.425,
                              width:width/6.276,
                              child: Text(": $password",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),

                          ],
                        ),

                        //item description
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,
                              child: Text("Item Description",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            SizedBox(
                              width:width/6.276,
                              height:height/10.425,
                              child: Text(": $ItemDescription",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                                textStyle: TextStyle(overflow: TextOverflow.ellipsis)
                              )),
                            ),

                            pattern==""? const SizedBox():
                            SizedBox(
                              height:height/20.425,
                              width:width/9.106,

                              child: Text("Pattern",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/79.39,
                                color:Colors.black,
                              )),
                            ),
                            pattern==""? const SizedBox():
                            SizedBox(
                              height:height/5.425,
                              width:width/6.276,
                              child:
                              IgnorePointer(
                                ignoring: true,
                                child: PatternLock2(
                                  used: patternlist,
                                  // color of selected points.
                                  selectedColor: Colors.red,
                                  // radius of points.
                                  pointRadius: 5,
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
                        ),

                        SizedBox(height:height/45.7)

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/79.39,
                            color:Colors.black,
                          ),),
                          Container(
                              width: width / 6.504,
                              height: height / 16.42,
                              decoration: BoxDecoration(
                                  color: const Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(4)),
                              child:
                           /*   TextField(
                                controller: Category,
                                style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                  border: InputBorder.none,
                                ),
                              ),*/
                              LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context, Controller4,
                                          focusNode, onFieldSubmitted) {
                                        return
                                          TextFormField(
                                            style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                Category=Controller4;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(  left: width / 130.6)),
                                            controller: Controller4,
                                            focusNode: focusNode,
                                            onFieldSubmitted: (String value) {
                                              onFieldSubmitted();
                                            },
                                          );
                                      },
                                      initialValue: const TextEditingValue(
                                        selection: TextSelection(
                                          isDirectional: true,
                                          baseOffset: 10,
                                          extentOffset: 1,
                                        ),

                                      ),
                                      optionsViewBuilder:
                                          (context, onSelected, options) => Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  bottom:
                                                  Radius.circular(4.0)),
                                            ),
                                            child: SizedBox(
                                              height: 52.0 * options.length,
                                              width:
                                              BoxConstraints.biggest.width,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: options.length,
                                                shrinkWrap: false,
                                                itemBuilder: (BuildContext, index) {
                                                  final String option = options.elementAt(index);
                                                  return InkWell(
                                                    onTap: () =>
                                                        onSelected(option),
                                                    child: Padding(padding: const EdgeInsets.all(16.0),
                                                      child: Text(option),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )),
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text == '') {
                                          return const Iterable<String>.empty();
                                        }

                                        return categorylist.where((String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          Category.text=selection;
                                        });
                                        serviceitem();
                                        debugPrint('You just selected $selection');
                                      },
                                      displayStringForOption: (Value) {
                                        return Value;
                                      },
                                    ),
                              )

                          ),
                        ],
                      ),
                    ),



                    //spare container
                    //Service Spares
                    Padding(
                      padding:  EdgeInsets.only(left: width/53.55),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Item Name",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/79.39,
                            color:Colors.black,
                          ),),
                          Container(
                              width: width / 3.0,
                              height: height / 10.42,
                              decoration: BoxDecoration(
                                  color: const Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(4)),
                              child:
                              LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      initialValue: const TextEditingValue(
                                        selection: TextSelection(
                                          isDirectional: true,
                                          baseOffset: 10,
                                          extentOffset: 1,
                                        ),

                                      ),
                                      fieldViewBuilder: (context, Controllers,
                                          focusNode, onFieldSubmitted) {
                                        return
                                          TextFormField(
                                            style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                sparesmontroller=Controllers;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(  left: width / 130.6)),
                                            controller: setvalid==true?sparesmontroller:Controllers,
                                            focusNode: focusNode,
                                            onFieldSubmitted: (String value) {
                                              onFieldSubmitted();
                                            },
                                          );
                                      },
                                      optionsViewBuilder:
                                          (context, onSelected, options) => Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  bottom:
                                                  Radius.circular(4.0)),
                                            ),
                                            child: SizedBox(
                                              height: 52.0 * options.length,
                                              width:
                                              BoxConstraints.biggest.width,
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: options.length,
                                                shrinkWrap: false,
                                                itemBuilder: (BuildContext, index) {
                                                  final String option = options.elementAt(index);
                                                  return InkWell(
                                                    onTap: () =>
                                                        onSelected(option),
                                                    child: Padding(padding: const EdgeInsets.all(16.0),
                                                      child: Text(option),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )),
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text == '') {
                                          return const Iterable<String>.empty();
                                        }


                                        return Serviceproblem.where((String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          sparesmontroller.text=selection;
                                        });

                                      },
                                      displayStringForOption: (Value) {
                                        return Value;
                                      },
                                    ),
                              )
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
                              Text("Remarks",style: GoogleFonts.cairo(
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
                                  controller: Remarkscontroller,
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
                              Text("Status",style: GoogleFonts.cairo(
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
                                      LayoutBuilder(
                                        builder: (BuildContext, BoxConstraints) =>
                                            Autocomplete<String>(
                                              fieldViewBuilder: (context, textEditing,
                                                  focusNode, onFieldSubmitted) {
                                                return TextFormField(
                                                  onChanged: (_){
                                                    setState(() {
                                                      Status=textEditing;
                                                    });
                                                  },
                                                  style: GoogleFonts.poppins(fontSize: width/86.6,fontWeight: FontWeight.w700),
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                      EdgeInsets.only(  left: width / 130.6)),
                                                  controller:setvalid==true?Status: textEditing,
                                                  focusNode: focusNode,
                                                  onFieldSubmitted: (String value) {
                                                    onFieldSubmitted();
                                                  },
                                                );
                                              },
                                              initialValue: const TextEditingValue(
                                                selection: TextSelection(
                                                  isDirectional: true,
                                                  baseOffset: 10,
                                                  extentOffset: 1,
                                                ),

                                              ),
                                              optionsViewBuilder:
                                                  (context, onSelected, options) => Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.vertical(
                                                          bottom:
                                                          Radius.circular(4.0)),
                                                    ),
                                                    child: SizedBox(
                                                      height: 52.0 * options.length,
                                                      width:
                                                      BoxConstraints.biggest.width,
                                                      child: ListView.builder(
                                                        padding: EdgeInsets.zero,
                                                        itemCount: options.length,
                                                        shrinkWrap: false,
                                                        itemBuilder: (BuildContext, index) {
                                                          final String option = options.elementAt(index);
                                                          return InkWell(
                                                            onTap: () =>
                                                                onSelected(option),
                                                            child: Padding(padding: const EdgeInsets.all(16.0),
                                                              child: Text(option),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                              optionsBuilder:
                                                  (TextEditingValue textEditingValue) {
                                                if (textEditingValue.text == '') {
                                                  return const Iterable<String>.empty();
                                                }

                                                return statuslist.where((String option) {
                                                  return option.toLowerCase().contains(
                                                      textEditingValue.text.toLowerCase());
                                                });
                                              },
                                              onSelected: (String selection) {
                                                setState(() {
                                                  Status.text=selection;
                                                });
                                              },
                                              displayStringForOption: (Value) {
                                                return Value;
                                              },
                                            ),
                                      )
                                  ),
                                  SizedBox(
                                    width: width / 273.2,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Servicestatuscreatefunction();
                                      Stausfunction();
                                      showdialpogbox();
                                    },
                                    child:ClipOval(
                                        child: Container(
                                            height: height / 21.9,
                                            width: width / 45.53,
                                            color: Colors.grey.shade300,
                                            child: const Icon(Icons.add))),
                                  )

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
                              updatefuntion();
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
                                  "Submit",
                                  style: GoogleFonts.cairo(
                                      fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Clear button
                        Padding(
                          padding:  EdgeInsets.only(left: width/53.55),
                          child: InkWell(
                            onTap: (){
                              clearallcontroller();
                            },
                            child: Container(
                              height: height / 16.4,
                              width: width / 9.5,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(7),),
                              child:
                              Center(
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.cairo(
                                      fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
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

          ],
        ),




      ],
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

  //save bill popup function
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
                    Text("Save Successfully",style: GoogleFonts.poppins(
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
                            clearallcontroller();
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
