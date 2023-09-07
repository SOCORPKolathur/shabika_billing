import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pattern_lock/pattern_lock.dart';


const List<String> Phonelook = <String>[
  "No",
  "Yes"
];

const List<String> Locktype = <String>[
  "Please select",
  "Pin",
  "Password",
  "Pattern",
];
class Service_Entry_Page extends StatefulWidget {
  String?Receivedperson;
  String?setvalue;
  String?docid;
   Service_Entry_Page(this.Receivedperson,this.setvalue,this.docid);

  @override
  State<Service_Entry_Page> createState() => _Service_Entry_PageState();
}

class _Service_Entry_PageState extends State<Service_Entry_Page> {


  List<String> barndlist=<String>[];
  List<String> statuslist=<String>[];
  List<String> Serviceproblemlist=<String>[];
  List<String> categorylist = <String>[];
  List<String> Itemlist = <String>[];

  barndaddfunction() async {
    setState(() {
      barndlist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('Service_Brand').orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      barndlist.add(Document.docs[i]['service brand']);
    }

  }

  categoryaddfunction() async {
    setState(() {
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('category').orderBy("categoryname", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
    itemdropdown();
  }

  itemdropdown()async{
    setState(() {
      Itemlist.clear();
    });
   if(Category.text==""){
     var Document2 = await FirebaseFirestore.instance.collection('Item ShabikaG').get();
     for (int i = 0; i < Document2.docs.length; i++) {
       setState(() {
         Itemlist.add(Document2.docs[i]['Newitemname']);
       });
     }
   }
   else{
     var Document = await FirebaseFirestore.instance.collection('Item ShabikaG').where("Category",isEqualTo:Category.text).get();
     for (int i = 0; i < Document.docs.length; i++) {
       setState(() {
         Itemlist.add(Document.docs[i]['Newitemname']);
       });
     }
   }
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

  Serviceprobloemfunction() async {
    setState(() {
      Serviceproblemlist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('Service_problem').orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      Serviceproblemlist.add(Document.docs[i]['Description']);
    }
  }


  @override
  void initState() {
    setState(() {
      receivedpersoncontroller.text=widget.Receivedperson!;
    });
    if(widget.setvalue=="setvalue"){
      setvalues();
    }
    else{
      barndaddfunction();
      categoryaddfunction();
      Stausfunction();
      itemcodegenrate();
      Serviceprobloemfunction();
    }
    // TODO: implement initState
    super.initState();
  }

  bool check=false;
  bool check2=false;
  bool check3=false;
  bool check4=false;

  TextEditingController Brand=TextEditingController();
  TextEditingController Status=TextEditingController();
  TextEditingController Category=TextEditingController();
  TextEditingController pincontroller=TextEditingController();
  TextEditingController Passwordcontroller=TextEditingController();
  TextEditingController Patterncontroller=TextEditingController();
  TextEditingController lastbillcontroller=TextEditingController();
  TextEditingController BillNocontroller=TextEditingController();
  TextEditingController Purchaseprice=TextEditingController();
  TextEditingController Salesprice=TextEditingController();
  TextEditingController  hancode=TextEditingController();
  TextEditingController boxno=TextEditingController();
  TextEditingController DateTimecontroller=TextEditingController();
  TextEditingController Timecontroller=TextEditingController();
  TextEditingController customermobilecontroller=TextEditingController();
  TextEditingController customerphonecontroller=TextEditingController();
  TextEditingController customernamecontroller=TextEditingController();
  TextEditingController modelnocontroller=TextEditingController();
  TextEditingController colorcontroller=TextEditingController();
  TextEditingController imeicontroller=TextEditingController();
  TextEditingController serviceproblemontroller=TextEditingController();
  TextEditingController serviceremarkmontroller=TextEditingController();
  TextEditingController serviceremark2montroller=TextEditingController();
  TextEditingController servicesparesmontroller=TextEditingController();
  TextEditingController servicecostcontroller=TextEditingController();
  TextEditingController serviceadvancebalancecontroller=TextEditingController();
  TextEditingController servicebalancecontroller=TextEditingController();
  TextEditingController itemnamecontroller=TextEditingController();
  TextEditingController itemnamedecriptioncontroller=TextEditingController();
  TextEditingController receivedpersoncontroller=TextEditingController();

  String dropdownValue=Phonelook.first;
  String dropdownValue2=Locktype.first;

  int dawer=0;

  NumberFormat F = NumberFormat('00');

  int itemcodes = 0;
  int itemcodes2 = 0;

  itemcodegenrate() async {
    var document = await FirebaseFirestore.instance.collection("Service_Entry").get();
    setState(() {
      itemcodes = document.docs.length + 1;
      BillNocontroller.text = "${"SB"}${F.format(itemcodes)}";
      lastbillcontroller.text = "${"SB"}${F.format(document.docs.length)}";
      DateTimecontroller.text="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      Timecontroller.text=DateFormat.jm().format(DateTime.now());
      servicecostcontroller.text="0";
      servicebalancecontroller.text="0";
      serviceadvancebalancecontroller.text="0";

    });

  }

  clearallcontroller(){
     Brand.clear();
     Status.clear();
     Category.clear();
     pincontroller.clear();
     Passwordcontroller.clear();
     Patterncontroller.clear();
     customermobilecontroller.clear();
     customerphonecontroller.clear();
     Purchaseprice.clear();
     Salesprice.clear();
     hancode.clear();
     boxno.clear();
     customernamecontroller.clear();
     modelnocontroller.clear();
     colorcontroller.clear();
     imeicontroller.clear();
     serviceproblemontroller.clear();
     serviceremarkmontroller.clear();
     serviceremark2montroller.clear();
     servicesparesmontroller.clear();
     servicecostcontroller.clear();
     serviceadvancebalancecontroller.clear();
     servicebalancecontroller.clear();
     itemnamecontroller.clear();
     itemnamedecriptioncontroller.clear();
     receivedpersoncontroller.clear();
     setState(() {
        check=false;
        check2=false;
        check3=false;
        check4=false;
        dropdownValue=Phonelook.first;
        dropdownValue2=Locktype.first;
     });
  }


 setvalues()async{
   clearallcontroller();
    var values=await FirebaseFirestore.instance.collection("Service_Entry").doc(widget.docid).get();
  Map<String,dynamic>?lastbills=values.data();
    setState((){
      Patterlist.clear();
      Brand.text=lastbills!['Brand'].toString();
      Status.text=lastbills['service status'].toString();
      Category.text=lastbills['Category'].toString();
      servicecostcontroller.text=lastbills['servicecost'].toString();
      serviceadvancebalancecontroller.text=lastbills['serviceadvancebalance'].toString();
      servicebalancecontroller.text=lastbills['servicebalance'].toString();
      BillNocontroller.text=lastbills['Billno'].toString();
      DateTimecontroller.text=lastbills['Date'].toString();
      Timecontroller.text=lastbills['time'].toString();
      customermobilecontroller.text=lastbills['customermobile'].toString();
      customerphonecontroller.text=lastbills['altermobile'].toString();
      customernamecontroller.text=lastbills['customername'].toString();
      modelnocontroller.text=lastbills['modelno'].toString();
      colorcontroller.text=lastbills['color'].toString();
      imeicontroller.text=lastbills['imei'].toString();
      serviceproblemontroller.text=lastbills['serviceproblem'].toString();
      serviceremarkmontroller.text=lastbills['serviceremark'].toString();
      serviceremark2montroller.text=lastbills['serviceremark2'].toString();
      servicesparesmontroller.text=lastbills['servicespares'].toString();
      itemnamecontroller.text=lastbills['itemname'].toString();
      itemnamedecriptioncontroller.text=lastbills['itemnamedecription'].toString();
      receivedpersoncontroller.text=lastbills['receivedperson'].toString();
      if(lastbills['pin']!=""){
        setState(() {
          pincontroller.text=lastbills['pin'].toString();
          dropdownValue="Yes";
          dropdownValue2="Pin";

        });

      }
      if(lastbills['Password']!=""){
        setState(() {
          Passwordcontroller.text=lastbills['Password'].toString();
          dropdownValue="Yes";
          dropdownValue2="Password";
        });
      }
      if(lastbills['Pattern']!=[]){
        setState(() {
          patternselected=false;
          Patterncontroller.text=lastbills['Pattern'].toString();
          dropdownValue="Yes";
          dropdownValue2="Pattern";
        });
      }
      if(lastbills['simcard']=="Simcard"){
        setState((){
          check=true;
        });
      }
      if(lastbills['battery']=="Battery"){
        setState((){
          check2=true;
        });
      }
      if(lastbills['MMC']=="MMC-Card"){
        setState((){
          check3=true;
        });
      }
      if(lastbills['charger']=="Charger"){
        setState((){
          check4=true;
        });
      }

    });
  }


  Servicecreatefunction(){
    FirebaseFirestore.instance.collection("Service_Brand").doc().set({
      "service brand":Brand.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });

  }

  Servicestatuscreatefunction(){
    FirebaseFirestore.instance.collection("Service_Status").doc().set({
      "service status":Status.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });

  }

  saveserviceentry(){
    FirebaseFirestore.instance.collection("Service_Entry").doc().set({
      "Billno":BillNocontroller.text,
      "Brand":Brand.text,
      "Category":Category.text,
      "pin":pincontroller.text,
      "Password":Passwordcontroller.text,
      "Pattern":Patterlist,
      "customermobile":customermobilecontroller.text,
      "altermobile":customerphonecontroller.text,
      "customername":customernamecontroller.text,
      "modelno":modelnocontroller.text,
      "color":colorcontroller.text,
      "imei":imeicontroller.text,
      "simcard":check==true?"Simcard":"",
      "battery":check2==true?"Battery":"",
      "MMC":check3==true?"MMC-Card":"",
      "charger":check4==true?"Charger":"",
      "serviceproblem":serviceproblemontroller.text,
      "serviceremark":serviceremarkmontroller.text,
      "serviceremark2":serviceremark2montroller.text,
      "servicespares":servicesparesmontroller.text,
      "servicecost":servicecostcontroller.text,
      "serviceadvancebalance":serviceadvancebalancecontroller.text,
      "servicebalance":servicebalancecontroller.text,
      "itemname":itemnamecontroller.text,
      "itemnamedecription":itemnamedecriptioncontroller.text,
      "receivedperson":receivedpersoncontroller.text,
       "Remarks":"",
      "Deliverydate":"",
      "Date":DateTimecontroller.text,
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat.jm().format(DateTime.now()),
      "service status":Status.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });
  }

  updateserviceentry(){
    FirebaseFirestore.instance.collection("Service_Entry").doc(widget.docid).update({
      "Billno":BillNocontroller.text,
      "Brand":Brand.text,
      "Category":Category.text,
      "pin":pincontroller.text,
      "Password":Passwordcontroller.text,
      "Pattern":Patterncontroller.text,
      "customermobile":customermobilecontroller.text,
      "altermobile":customerphonecontroller.text,
      "customername":customernamecontroller.text,
      "modelno":modelnocontroller.text,
      "color":colorcontroller.text,
      "imei":imeicontroller.text,
      "simcard":check==true?"Simcard":"",
      "battery":check2==true?"Battery":"",
      "MMC":check3==true?"MMC-Card":"",
      "charger":check4==true?"Charger":"",
      "serviceproblem":serviceproblemontroller.text,
      "serviceremark":serviceremarkmontroller.text,
      "serviceremark2":serviceremark2montroller.text,
      "servicespares":servicesparesmontroller.text,
      "servicecost":servicecostcontroller.text,
      "serviceadvancebalance":serviceadvancebalancecontroller.text,
      "servicebalance":servicebalancecontroller.text,
      "itemname":itemnamecontroller.text,
      "itemnamedecription":itemnamedecriptioncontroller.text,
      "receivedperson":receivedpersoncontroller.text,
      "Date":DateTimecontroller.text,
      "Remarks":"",
      "Deliverydate":"",
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "time":DateFormat.jm().format(DateTime.now()),
      "service status":Status.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });
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

//set the last bill function
  lastbillset()async{
    var lastbills=await FirebaseFirestore.instance.collection("Service_Entry").
    where("Billno",isEqualTo:lastbillcontroller.text).get();
     setState((){
       Patterlist.clear();
  Brand.text=lastbills.docs[0]['Brand'];
  Status.text=lastbills.docs[0]['service status'];
  Category.text=lastbills.docs[0]['Category'];
  BillNocontroller.text=lastbills.docs[0]['Billno'];
  DateTimecontroller.text=lastbills.docs[0]['Date'];
  Timecontroller.text=lastbills.docs[0]['time'];
  customermobilecontroller.text=lastbills.docs[0]['customermobile'];
  customerphonecontroller.text=lastbills.docs[0]['altermobile'];
  customernamecontroller.text=lastbills.docs[0]['customername'];
  modelnocontroller.text=lastbills.docs[0]['modelno'];
  colorcontroller.text=lastbills.docs[0]['color'];
  imeicontroller.text=lastbills.docs[0]['imei'];
  serviceproblemontroller.text=lastbills.docs[0]['serviceproblem'];
  serviceremarkmontroller.text=lastbills.docs[0]['serviceremark'];
  serviceremark2montroller.text=lastbills.docs[0]['serviceremark2'];
  servicesparesmontroller.text=lastbills.docs[0]['servicespares'];
  servicecostcontroller.text=lastbills.docs[0]['servicecost'];
  serviceadvancebalancecontroller.text=lastbills.docs[0]['serviceadvancebalance'];
  servicebalancecontroller.text=lastbills.docs[0]['servicebalance'];
  itemnamecontroller.text=lastbills.docs[0]['itemname'];
  itemnamedecriptioncontroller.text=lastbills.docs[0]['itemnamedecription'];
  receivedpersoncontroller.text=lastbills.docs[0]['receivedperson'];
  if(lastbills.docs[0]['pin']!=""){
    setState(() {
      pincontroller.text=lastbills.docs[0]['pin'];
      dropdownValue="Yes";
      dropdownValue2="Pin";

    });

  }
  if(lastbills.docs[0]['Password']!=""){
    setState(() {
      Passwordcontroller.text=lastbills.docs[0]['Password'];
      dropdownValue="Yes";
      dropdownValue2="Password";
    });
  }
  if(lastbills.docs[0]['Pattern']!=[]){
    setState(() {
      patternselected=false;
      Patterncontroller.text=lastbills.docs[0]['Pattern'].toString();
      dropdownValue="Yes";
      dropdownValue2="Pattern";
    });
  }
  if(lastbills.docs[0]['simcard']=="Simcard"){
    setState((){
      check=true;
    });
  }
  if(lastbills.docs[0]['battery']=="Battery"){
    setState((){
      check2=true;
    });
  }
  if(lastbills.docs[0]['MMC']=="MMC-Card"){
    setState((){
      check3=true;
    });
  }
  if(lastbills.docs[0]['charger']=="Charger"){
    setState((){
      check4=true;
    });
  }

});
    }

  bool patternselected=false;
  List Patterlist=[];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
   if(widget.setvalue=="setvalue"){
  return Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/131.4,),

              //billa no and cutstomer name and mobile number
              Row(
                children: [

                  //bill no
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Bill No",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 21.9,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            readOnly: true,
                            controller: BillNocontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Date Time
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Date",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),

                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                            color:  Colors.white,
                          ),
                          child: TextField(
                            controller: DateTimecontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Time
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Time",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),

                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                            color:  Colors.white,),
                          child: TextField(
                            controller: Timecontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only( left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Customer mobile
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(

                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Customer Mobile",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: width/99.39,
                              color:Colors.black,
                            ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                              color:  Colors.white),
                          child: TextField(
                            controller: customermobilecontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only( left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),

              SizedBox(height:height/82.125),

              //alter number and customer name and check boxes
              Row(
                children: [

                  //alter no for Customer
                  SizedBox(width:width/93.55),
                  SizedBox(
                    width:width/12.41,
                    height: height / 20.42,
                    child: Text("Alter Phone NO",style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: width/99.39,
                      color:Colors.black,
                    ),),
                  ),
                  Container(
                    width: width / 6.504,
                    height: height / 20.42,
                    decoration:const BoxDecoration(
                        color:  Colors.white),
                    child: TextField(
                      controller: customerphonecontroller,
                      style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width /90.78,
                            bottom: height / 83.8),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Customer Name
                  SizedBox(width:width/93.55),
                  SizedBox(
                    width:width/12.41,
                    height: height / 20.42,
                    child: Text("Customer Name",style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: width/99.39,
                      color:Colors.black,
                    ),),
                  ),
                  Container(
                    width: width / 6.504,
                    height: height / 20.42,
                    decoration:const BoxDecoration(
                        color:  Colors.white),
                    child: TextField(
                      controller: customernamecontroller,
                      style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only( left: width /90.78,
                            bottom: height / 83.8),
                        border: InputBorder.none,
                      ),
                    ),
                  ),


                  //check box1 and 2
                  SizedBox(width:width/93.55),
                  SizedBox( width:width/12.41, height: height / 20.42,),
                  Container(
                      width: width / 6.504,
                      height: height / 20.42,
                      decoration:const BoxDecoration(
                          color:  Colors.white),
                      child:Row(
                          children:[
                            Checkbox(
                              value: check,
                              onChanged: (value) {
                                setState(() {
                                  check= value!;

                                });

                              },
                            ),
                            Text(
                              "Battery",
                              style: GoogleFonts.cairo(
                                  fontSize: width/99.39, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: width/68.3,),
                            Checkbox(
                              value: check2,
                              onChanged: (value) {
                                setState(() {
                                  check2= value!;

                                });

                              },
                            ),
                            Text(
                              "Simcard",
                              style: GoogleFonts.cairo(
                                  fontSize: width/99.39, fontWeight: FontWeight.bold),
                            ),
                          ]
                      )),

                  //check box 3 and 4
                  SizedBox(width:width/93.55),
                  SizedBox( width:width/12.41, height: height / 20.42,),
                  Container(
                      width: width / 6.504,
                      height: height / 20.42,
                      decoration:const BoxDecoration(
                          color:  Colors.white),
                      child:Row(children:[
                        Checkbox(
                          value: check3,
                          onChanged: (value) {
                            setState(() {
                              check3= value!;

                            });

                          },
                        ),
                        Text(
                          "MMC-Card",
                          style: GoogleFonts.cairo(
                              fontSize: width/99.39, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: width/68.3,),
                        Checkbox(
                          value: check4,
                          onChanged: (value) {
                            setState(() {
                              check4= value!;

                            });

                          },
                        ),
                        Text(
                          "Charger",
                          style: GoogleFonts.cairo(
                              fontSize: width/99.39, fontWeight: FontWeight.bold),
                        ),
                      ])
                  )


                ],
              ),
              SizedBox(height:height/82.125),

              //brand and imei and so on container....
              Row(
                  children:[
                    //Brand
                    Padding(
                      padding:  EdgeInsets.only(left: width/93.55),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:width/12.41,
                            height: height / 20.42,
                            child: Text("Brand",style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: width/99.39,
                              color:Colors.black,
                            ),),
                          ),
                          Container(
                              width: width / 6.504,
                              height: height / 20.42,
                              decoration: const BoxDecoration(
                                  color:  Colors.white),
                              child:
                              LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context, Controller1,
                                          focusNode, onFieldSubmitted) {
                                        return
                                          TextFormField(
                                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                Brand=Controller1;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    Servicecreatefunction();
                                                    barndaddfunction();
                                                    showdialpogbox();
                                                  },
                                                  child:const Icon(Icons.add),
                                                ) ,
                                                contentPadding:
                                                EdgeInsets.only( left: width /90.78,
                                                    bottom: height / 83.8)),
                                            controller: Controller1,
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


                                        return barndlist.where((String option) {
                                          return option.toLowerCase().contains(
                                              textEditingValue.text.toLowerCase());
                                        });
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          Brand.text=selection;
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
                    // Model No
                    Padding(
                      padding:  EdgeInsets.only(left: width/93.55),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:width/12.41,
                            height: height / 20.42,
                            child: Text("Model No",style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: width/99.39,
                              color:Colors.black,
                            ),),
                          ),
                          Container(
                            width: width / 6.504,
                            height: height / 20.42,
                            decoration: const BoxDecoration(
                                color:  Colors.white),
                            child: TextField(
                              controller: modelnocontroller,
                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    bottom: height / 83.8),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Color
                    Padding(
                      padding:  EdgeInsets.only(left: width/93.55),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:width/12.41,
                            height: height / 20.42,
                            child: Text("Color",style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: width/99.39,
                              color:Colors.black,
                            ),),
                          ),
                          Container(
                            width: width / 6.504,
                            height: height / 20.42,
                            decoration: const BoxDecoration(
                                color:  Colors.white),
                            child: TextField(
                              controller: colorcontroller,
                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only( left: width /90.78,
                                    bottom: height / 83.8),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    //IMEI No
                    Padding(
                      padding:  EdgeInsets.only(left: width/93.55),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:width/12.41,
                            height: height / 20.42,
                            child: Text("IMEI No",style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: width/99.39,
                              color:Colors.black,
                            ),),
                          ),
                          Container(
                            width: width / 6.504,
                            height: height / 20.42,
                            decoration: const BoxDecoration(
                                color:  Colors.white),
                            child: TextField(
                              controller: imeicontroller,
                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only( left: width /90.78,
                                    bottom: height / 83.8),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]
              ),
              SizedBox(height:height/82.125),

              ///password and dropdown set the value the pattern
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Phone Lock",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration:const BoxDecoration(
                              color:  Colors.white),
                          child:
                          DropdownButton2<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            style:GoogleFonts.montserrat(
                                fontSize: width/113.833,
                                color:Colors.black,
                                fontWeight: FontWeight.bold),
                            underline: Container(
                              color: Colors.deepPurpleAccent,
                            ),
                            iconStyleData: const IconStyleData(
                                icon:Icon(Icons.arrow_drop_down),
                                iconSize: 25
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dawer = 12;
                                dropdownValue=value!;

                              });
                            },
                            items:
                            Phonelook.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style:GoogleFonts.montserrat(
                                        fontSize: width/113.833,
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  );
                                }).toList(),

                          ),
                        ),
                      ],
                    ),
                  ),

                  dropdownValue=="Yes"?
                  Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Lock Type",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                              color:  Colors.white),
                          child:
                          DropdownButton2<String>(
                            value: dropdownValue2,
                            isExpanded: true,
                            style:GoogleFonts.montserrat(
                                fontSize: width/113.833,
                                color:Colors.black,
                                fontWeight: FontWeight.bold),
                            underline: Container(
                              color: Colors.deepPurpleAccent,
                            ),
                            iconStyleData: const IconStyleData(
                                icon:Icon(Icons.arrow_drop_down),
                                iconSize: 25
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue2=value!;
                              });
                              if(dropdownValue2=='Pattern'){
                                setState((){
                                  patternselected=true;
                                });
                              }
                            },
                            items:
                            Locktype.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style:GoogleFonts.montserrat(
                                        fontSize: width/113.833,
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  );
                                }).toList(),

                          ),
                        ),
                      ],
                    ),
                  ): const SizedBox(),
                  //Pin
                  dropdownValue2=="Pin"? Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Pin",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                              color:  Colors.white),
                          child: TextField(
                            controller: pincontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only( left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ): const SizedBox(),
                  //Password
                  dropdownValue2=="Password"? Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Passsword",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                              color:  Colors.white),
                          child: TextField(
                            controller: Passwordcontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only( left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ): const SizedBox(),

                  dropdownValue2=="Pattern"&&patternselected==false? Padding(
                    padding:  EdgeInsets.only(left: width/93.55),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:width/12.41,
                          height: height / 20.42,
                          child: Text("Pattern",style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width/99.39,
                            color:Colors.black,
                          ),),
                        ),
                        Container(
                          width: width / 6.504,
                          height: height / 20.42,
                          decoration: const BoxDecoration(
                              color:  Colors.white),
                          child: TextField(
                            controller: Patterncontroller,
                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only( left: width /90.78,
                                  bottom: height / 83.8),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ): const SizedBox(),
                ],
              ),

              SizedBox(height:height/82.125),



              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      children:[
                        //Service Problem
                        Padding(
                          padding:  EdgeInsets.only(left: width/93.55),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:width/12.41,
                                height: height / 10.17,
                                child: Text("Service Problem",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/99.39,
                                  color:Colors.black,
                                ),),
                              ),
                              Container(
                                  width: width / 2.504,
                                  height: height / 10.17,
                                  decoration:const BoxDecoration(
                                      color:  Colors.white),
                                  child:
                                  LayoutBuilder(
                                    builder: (BuildContext, BoxConstraints) =>
                                        Autocomplete<String>(
                                          fieldViewBuilder: (context, Servicecontroller,
                                              focusNode, onFieldSubmitted) {
                                            return  TextFormField(
                                              maxLines: null,
                                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                              onChanged: (_){
                                                setState((){
                                                  serviceproblemontroller=Servicecontroller;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                  EdgeInsets.only(
                                                      left: width /90.78,
                                                      bottom: height / 83.8)),
                                              controller: Servicecontroller,
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

                                            return Serviceproblemlist.where((String option) {
                                              return option.toLowerCase().contains(
                                                  textEditingValue.text.toLowerCase());
                                            });
                                          },
                                          onSelected: (String selection) {
                                            setState(() {
                                              serviceproblemontroller.text=selection;
                                            });
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
                        SizedBox(height:height/82.125),

                        //Service Remarks
                        Padding(
                          padding:  EdgeInsets.only(left: width/93.55),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:width/12.41,
                                height: height / 10.17,
                                child: Text("Service Remarks",style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width/99.39,
                                  color:Colors.black,
                                ),),
                              ),
                              Container(
                                width: width / 2.504,
                                height: height / 10.17,
                                decoration:const BoxDecoration(
                                    color:  Colors.white),
                                child: TextField(
                                  maxLines: null,
                                  controller: serviceremarkmontroller,
                                  style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only( left: width /90.78,
                                        bottom: height / 83.8,top: height/ 82.125),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),

                  SizedBox(width:width/170.75),

                  Container(
                    height:height/4.728,
                    width:width/2.0,
                    decoration:const  BoxDecoration(
                      color: Colors.white,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:height/ 121.7,),

                        //Category&&Item Name
                        Row(
                          children: [
                            //Category
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Category",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                                width: width / 6.504,
                                height: height / 20.42,
                                decoration: const BoxDecoration(
                                  color:  Color(0xffDDDEEE),
                                ),
                                child:
                                LayoutBuilder(

                                  builder: (BuildContext, BoxConstraints) =>
                                      Autocomplete<String>(

                                        fieldViewBuilder: (context, textEditingController2,
                                            focusNode, onFieldSubmitted) {
                                          return  TextFormField(
                                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                Category=textEditingController2;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(  left: width /90.78,
                                                  bottom: height / 83.8,)),
                                            controller: textEditingController2,
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

                                          return categorylist.where((String option) {
                                            return option.toLowerCase().contains(
                                                textEditingValue.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (String selection) {
                                          setState(() {
                                            Category.text=selection;
                                          });
                                          itemdropdown();
                                          debugPrint('You just selected $selection');
                                        },
                                        displayStringForOption: (Value) {
                                          return Value;
                                        },
                                      ),
                                )

                            ),
                            //Item Name
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Item Name",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                                width: width / 6.504,
                                height: height / 20.42,
                                decoration: const BoxDecoration(
                                  color: Color(0xffDDDEEE),
                                ),
                                child:
                                LayoutBuilder(
                                  builder: (BuildContext, BoxConstraints) =>
                                      Autocomplete<String>(
                                        fieldViewBuilder: (context, textEditingController4,
                                            focusNode, onFieldSubmitted) {
                                          return  TextFormField(
                                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                itemnamecontroller=textEditingController4;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(left: width /90.78,
                                                    bottom: height / 83.8)),
                                            controller: textEditingController4,
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

                                          return Itemlist.where((String option) {
                                            return option.toLowerCase().contains(
                                                textEditingValue.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (String selection) async {
                                          setState(() {
                                            itemnamecontroller.text=selection;
                                          });
                                          var Document2 = await FirebaseFirestore.instance.collection('Item ShabikaG').where("Newitemname", isEqualTo: itemnamecontroller.text).get();
                                          setState(() {
                                            itemnamecontroller.text=Document2.docs[0]['Newitemname'];
                                            hancode.text=Document2.docs[0]['HSNCode'];
                                            boxno.text=Document2.docs[0]['BoxNo'];
                                            Salesprice.text=Document2.docs[0]['Saleprice'];
                                            Purchaseprice.text=Document2.docs[0]['Purchaseprice'];
                                          });
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
                        SizedBox(height:height/82.125),


                        SizedBox(height:height/82.125),
                        Row(
                          children: [

                            //Sales Price
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Sales Price",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                              width: width / 6.504,
                              height: height / 20.42,
                              decoration: const BoxDecoration(
                                color: Color(0xffDDDEEE),
                              ),
                              child: TextField(
                                controller: Salesprice,
                                style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only( left: width /90.78,
                                      bottom: height / 83.8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            //boxno
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Box No",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                              width: width / 6.504,
                              height: height / 20.42,
                              decoration: const BoxDecoration(
                                color: Color(0xffDDDEEE),
                              ),
                              child: TextField(
                                controller: boxno,
                                style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only( left: width /90.78,
                                    bottom: height / 83.8,),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),



                          ],
                        ),

                        SizedBox(height:height/82.125),

                        //status and received person
                        Row(
                          children: [

                            // Received Person
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Received Person",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                              width: width / 6.504,
                              height: height / 20.42,
                              decoration: const BoxDecoration(
                                color: Color(0xffDDDEEE),
                              ),
                              child: TextField(
                                controller: receivedpersoncontroller,
                                style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only( left: width /90.78,
                                      bottom: height / 83.8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),


                            //Status
                            SizedBox(width:width/93.55),
                            SizedBox(
                              width:width/13.41,
                              height: height / 20.42,
                              child: Text("Status",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                                width: width / 6.504,
                                height: height / 20.42,
                                decoration: const BoxDecoration(
                                  color:  Color(0xffDDDEEE),
                                ),
                                child:
                                LayoutBuilder(
                                  builder: (BuildContext, BoxConstraints) =>
                                      Autocomplete<String>(
                                        fieldViewBuilder: (context, textEditing,
                                            focusNode, onFieldSubmitted) {
                                          return  TextFormField(
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                Status=textEditing;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    Servicestatuscreatefunction();
                                                    Stausfunction();
                                                    showdialpogbox();
                                                  },
                                                  child:const Icon(Icons.add,),
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only( left: width /90.78,
                                                    bottom: height / 3.8)),
                                            controller: textEditing,
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
                                                      child: Text(option),
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
                                          setState((){
                                            Status.text=selection;
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
                        SizedBox(height:height/82.125),



                      ],
                    ),
                  ),
                ],
              ),





              SizedBox(height:height/3.4),
              //amount container
              Padding(
                padding:  EdgeInsets.only(left: width/103.55,right:width/93.55),
                child: Container(
                  height:height/7.457,
                  width:double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height:height/ 65.7,),

                      Row(
                        children: [
                          SizedBox(width:width/68.3,),
                          //Cost
                          Container(
                            width: width / 7.0,
                            height: height / 20.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff1D5B79),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 455.33),
                                  child: SizedBox(
                                    width: width / 12.5,
                                    height: height / 23.42,
                                    child: Center(
                                      child: Text(
                                        "Service Cost",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width / 16.83,
                                  height: height / 23.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  child:
                                  TextField(
                                    controller: servicecostcontroller,
                                    style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only( left: width /90.78,
                                          bottom: height / 83.8),
                                      border: InputBorder.none,
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width:width/68.3,),

                          //Advance amount
                          Container(
                            width: width / 7.0,
                            height: height / 20.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff1D5B79),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 455.33),
                                  child: SizedBox(
                                    width: width / 12.5,
                                    height: height / 23.42,
                                    child: Center(
                                      child: Text(
                                        "Advance Amt",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width / 16.83,
                                  height: height / 23.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  child:
                                  TextField(
                                    controller: serviceadvancebalancecontroller,
                                    style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only( left: width /90.78,
                                          bottom: height / 83.8),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (_){
                                      if(serviceadvancebalancecontroller.text=="0"){
                                        setState((){
                                          servicebalancecontroller.text="0";
                                          serviceadvancebalancecontroller.text="0";
                                        });
                                      }
                                      else{
                                        setState((){
                                          servicebalancecontroller.text=(int.parse(servicecostcontroller.text)-int.parse(serviceadvancebalancecontroller.text)).toString();
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width:width/68.3,),

                          //Balance Amount
                          Container(
                            width: width / 7.0,
                            height: height / 20.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff075E54),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 455.33),
                                  child: SizedBox(
                                    width: width / 12.5,
                                    height: height / 23.42,
                                    child: Center(
                                      child: Text(
                                        "Balance Amt",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width / 16.83,
                                  height: height / 23.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  child:
                                  TextField(
                                    controller: servicebalancecontroller,
                                    style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only( left: width /90.78,
                                          bottom: height / 83.8),
                                      border: InputBorder.none,
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width:width/68.3,),


                          InkWell(
                            onTap:(){
                              lastbillset();
                            },
                            child: Container(
                              width: width / 7.0,
                              height: height / 20.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0xff00A99D),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width / 455.33),
                                    child: SizedBox(
                                      width: width / 12.5,
                                      height: height / 23.42,
                                      child: Center(
                                        child: Text(
                                          "Last Bill No",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: width / 16.83,
                                      height: height / 23.42,
                                      //color: Color(0xffDDDEEE),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                          BorderRadius.circular(6)),
                                      child:
                                      Center(child: Text(lastbillcontroller.text,style:
                                      GoogleFonts.poppins(fontSize: width/119.6,fontWeight: FontWeight.w700),))
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width:width/5.3,),
                          InkWell(
                            onTap: () {
                              saveserviceentry();
                              itemcodegenrate();
                              savebillshowdialpogbox();
                            },
                            child: Container(
                              width: width / 8.6,
                              height: height / 20.42,
                              //color: Color(0xffD60A0B),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff075e54),
                              ),
                              child: Center(
                                  child: Text(
                                    "Update",
                                    style: GoogleFonts.poppins(color: Colors.white),
                                  )),
                            ),
                          ),





                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ],
          ),
          dropdownValue2=="Pattern"&&
              patternselected==true?
          Container(
            height:height/1.314,
            width:width/2.732,
            color:Colors.white,
            child: Column(

              children: [
                SizedBox(height:height/65.7),
                Text("Enter the Pattern-Lock",style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.w700),),
                SizedBox(height:height/65.7),
                SizedBox(
                  width:width/3.415,
                  height:height/1.642,
                  child: PatternLock(
                    // color of selected points.
                    selectedColor: Colors.red,
                    // radius of points.
                    pointRadius: 30,
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
                      Patterlist=input;
                      Patterncontroller.text=input .toString();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    InkWell(
                      onTap: (){
                        setState((){
                          patternselected=false;

                        });
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
                        setState((){
                          patternselected=false;
                        });
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
          ):
          const SizedBox()
        ],
      )
  );
    }


    else{
     return
       Stack(
         alignment: Alignment.center,
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: height/131.4,),

               //billa no and cutstomer name and mobile number
               Row(
                 children: [

                   //bill no
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Bill No",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 21.9,
                           decoration: const BoxDecoration(
                             color: Colors.white,
                           ),
                           child: TextField(
                             readOnly: true,
                             controller: BillNocontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   //Date Time
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Date",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),

                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                             color:  Colors.white,
                           ),
                           child: TextField(
                             controller: DateTimecontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   //Time
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Time",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),

                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                             color:  Colors.white,),
                           child: TextField(
                             controller: Timecontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),

                   // Customer mobile
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SizedBox(

                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Customer Mobile",
                             style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/99.39,
                               color:Colors.black,
                             ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                               color:  Colors.white),
                           child: TextField(
                             controller: customermobilecontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),


                 ],
               ),
               SizedBox(height:height/82.125),

               //alter number and customer name and check boxes
               Row(
                 children: [

                   //alter no for Customer
                   SizedBox(width:width/93.55),
                   SizedBox(
                     width:width/12.41,
                     height: height / 20.42,
                     child: Text("Alter Phone NO",style: GoogleFonts.cairo(
                       fontWeight: FontWeight.bold,
                       fontSize: width/99.39,
                       color:Colors.black,
                     ),),
                   ),
                   Container(
                     width: width / 6.504,
                     height: height / 20.42,
                     decoration:const BoxDecoration(
                         color:  Colors.white),
                     child: TextField(
                       controller: customerphonecontroller,
                       style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                       decoration: InputDecoration(
                         contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                         border: InputBorder.none,
                       ),
                     ),
                   ),

                   //Customer Name
                   SizedBox(width:width/93.55),
                   SizedBox(
                     width:width/12.41,
                     height: height / 20.42,
                     child: Text("Customer Name",style: GoogleFonts.cairo(
                       fontWeight: FontWeight.bold,
                       fontSize: width/99.39,
                       color:Colors.black,
                     ),),
                   ),
                   Container(
                     width: width / 6.504,
                     height: height / 20.42,
                     decoration:const BoxDecoration(
                         color:  Colors.white),
                     child: TextField(
                       controller: customernamecontroller,
                       style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                       decoration: InputDecoration(
                         contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                         border: InputBorder.none,
                       ),
                     ),
                   ),


                   //check box1 and 2
                   SizedBox(width:width/93.55),
                   SizedBox( width:width/12.41, height: height / 20.42,),
                  Container(
                          width: width / 6.504,
                      height: height / 20.42,
                      decoration:const BoxDecoration(
                          color:  Colors.white),
                      child:Row(
                      children:[
                    Checkbox(
                      value: check,
                      onChanged: (value) {
                        setState(() {
                          check= value!;

                        });

                      },
                    ),
                    Text(
                      "Battery",
                      style: GoogleFonts.cairo(
                          fontSize: width/99.39, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: width/68.3,),
                    Checkbox(
                      value: check2,
                      onChanged: (value) {
                        setState(() {
                          check2= value!;

                        });

                      },
                    ),
                    Text(
                      "Simcard",
                      style: GoogleFonts.cairo(
                          fontSize: width/99.39, fontWeight: FontWeight.bold),
                    ),
                  ]
                  )),

                   //check box 3 and 4
                   SizedBox(width:width/93.55),
                   SizedBox( width:width/12.41, height: height / 20.42,),
                  Container(
                          width: width / 6.504,
                      height: height / 20.42,
                      decoration:const BoxDecoration(
                          color:  Colors.white),
                      child:Row(children:[
                        Checkbox(
                          value: check3,
                          onChanged: (value) {
                            setState(() {
                              check3= value!;

                            });

                          },
                        ),
                        Text(
                          "MMC-Card",
                          style: GoogleFonts.cairo(
                              fontSize: width/99.39, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: width/68.3,),
                        Checkbox(
                          value: check4,
                          onChanged: (value) {
                            setState(() {
                              check4= value!;

                            });

                          },
                        ),
                        Text(
                          "Charger",
                          style: GoogleFonts.cairo(
                              fontSize: width/99.39, fontWeight: FontWeight.bold),
                        ),
                      ])
                  )

                   
                 ],
               ),
               SizedBox(height:height/82.125),

               //brand and imei and so on container....
               Row(
                   children:[
                     //Brand
                     Padding(
                       padding:  EdgeInsets.only(left: width/93.55),
                       child:
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width/12.41,
                             height: height / 20.42,
                             child: Text("Brand",style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/99.39,
                               color:Colors.black,
                             ),),
                           ),
                           Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: const BoxDecoration(
                                   color:  Colors.white),
                               child:
                               LayoutBuilder(
                                 builder: (BuildContext, BoxConstraints) =>
                                     Autocomplete<String>(
                                       fieldViewBuilder: (context, Controller1,
                                           focusNode, onFieldSubmitted) {
                                         return
                                           TextFormField(
                                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                             onChanged: (_){
                                               setState((){
                                                 Brand=Controller1;
                                               });
                                             },
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 suffixIcon: InkWell(
                                                   onTap: () {
                                                     Servicecreatefunction();
                                                     barndaddfunction();
                                                     showdialpogbox();
                                                   },
                                                   child:const Icon(Icons.add),
                                                 ) ,
                                                 contentPadding:
                                                 EdgeInsets.only(  left: width / 130.6,bottom:height/ 82.125,)),
                                             controller: Controller1,
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


                                         return barndlist.where((String option) {
                                           return option.toLowerCase().contains(
                                               textEditingValue.text.toLowerCase());
                                         });
                                       },
                                       onSelected: (String selection) {
                                         setState(() {
                                           Brand.text=selection;
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
                     // Model No
                     Padding(
                       padding:  EdgeInsets.only(left: width/93.55),
                       child:
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width/12.41,
                             height: height / 20.42,
                             child: Text("Model No",style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/99.39,
                               color:Colors.black,
                             ),),
                           ),
                           Container(
                             width: width / 6.504,
                             height: height / 20.42,
                             decoration: const BoxDecoration(
                                 color:  Colors.white),
                             child: TextField(
                               controller: modelnocontroller,
                               style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                 border: InputBorder.none,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),

                     //Color
                     Padding(
                       padding:  EdgeInsets.only(left: width/93.55),
                       child:
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width/12.41,
                             height: height / 20.42,
                             child: Text("Color",style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/99.39,
                               color:Colors.black,
                             ),),
                           ),
                           Container(
                             width: width / 6.504,
                             height: height / 20.42,
                             decoration: const BoxDecoration(
                                 color:  Colors.white),
                             child: TextField(
                               controller: colorcontroller,
                               style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                 border: InputBorder.none,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),


                     //IMEI No
                     Padding(
                       padding:  EdgeInsets.only(left: width/93.55),
                       child:
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             width:width/12.41,
                             height: height / 20.42,
                             child: Text("IMEI No",style: GoogleFonts.cairo(
                               fontWeight: FontWeight.bold,
                               fontSize: width/99.39,
                               color:Colors.black,
                             ),),
                           ),
                           Container(
                             width: width / 6.504,
                             height: height / 20.42,
                             decoration: const BoxDecoration(
                                 color:  Colors.white),
                             child: TextField(
                               controller: imeicontroller,
                               style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                 border: InputBorder.none,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),

                   ]
               ),
               SizedBox(height:height/82.125),

               ///password and dropdown set the value the pattern
               Row(
                 children: [
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Phone Lock",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration:const BoxDecoration(
                               color:  Colors.white),
                           child:
                           DropdownButton2<String>(
                             value: dropdownValue,
                             isExpanded: true,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:Colors.black,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_drop_down),
                                 iconSize: 25
                             ),
                             onChanged: (String? value) {
                               setState(() {
                                 dawer = 12;
                                 dropdownValue=value!;

                               });
                             },
                             items:
                             Phonelook.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:Colors.black,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),

                           ),
                         ),
                       ],
                     ),
                   ),

                   dropdownValue=="Yes"?
                   Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Lock Type",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                               color:  Colors.white),
                           child:
                           DropdownButton2<String>(
                             value: dropdownValue2,
                             isExpanded: true,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:Colors.black,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_drop_down),
                                 iconSize: 25
                             ),
                             onChanged: (String? value) {
                               setState(() {
                                 dropdownValue2=value!;
                               });
                               if(dropdownValue2=='Pattern'){
                                 setState((){
                                   patternselected=true;
                                 });
                               }
                             },
                             items:
                             Locktype.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:Colors.black,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),

                           ),
                         ),
                       ],
                     ),
                   ): const SizedBox(),
                   //Pin
                   dropdownValue2=="Pin"? Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Pin",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                               color:  Colors.white),
                           child: TextField(
                             controller: pincontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ): const SizedBox(),
                   //Password
                   dropdownValue2=="Password"? Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Passsword",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                               color:  Colors.white),
                           child: TextField(
                             controller: Passwordcontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ): const SizedBox(),

                   dropdownValue2=="Pattern"&&patternselected==false? Padding(
                     padding:  EdgeInsets.only(left: width/93.55),
                     child:
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           width:width/12.41,
                           height: height / 20.42,
                           child: Text("Pattern",style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,
                             fontSize: width/99.39,
                             color:Colors.black,
                           ),),
                         ),
                         Container(
                           width: width / 6.504,
                           height: height / 20.42,
                           decoration: const BoxDecoration(
                               color:  Colors.white),
                           child: TextField(
                             controller: Patterncontroller,
                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                               border: InputBorder.none,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ): const SizedBox(),
                 ],
               ),

               SizedBox(height:height/82.125),



               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Column(
                    children:[
                      //Service Problem
                      Padding(
                        padding:  EdgeInsets.only(left: width/93.55),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:width/12.41,
                              height: height / 10.17,
                              child: Text("Service Problem",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                                width: width / 2.504,
                                height: height / 10.17,
                                decoration:const BoxDecoration(
                                    color:  Colors.white),
                                child:
                                LayoutBuilder(
                                  builder: (BuildContext, BoxConstraints) =>
                                      Autocomplete<String>(
                                        fieldViewBuilder: (context, Servicecontroller,
                                            focusNode, onFieldSubmitted) {
                                          return  TextFormField(
                                            maxLines: null,
                                            style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                            onChanged: (_){
                                              setState((){
                                                serviceproblemontroller=Servicecontroller;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.only(  left: width / 130.6,bottom:height/ 82.125,)),
                                            controller: Servicecontroller,
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

                                          return Serviceproblemlist.where((String option) {
                                            return option.toLowerCase().contains(
                                                textEditingValue.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (String selection) {
                                          setState(() {
                                            serviceproblemontroller.text=selection;
                                          });
                                          debugPrint('You just selected $selection');
                                        },
                                        displayStringForOption: (Value) {
                                          return Value;
                                        },
                                      ),
                                )
                              /* TextField(
                              controller: serviceproblemontroller,
                              style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                border: InputBorder.none,
                              ),
                            ),*/
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:height/82.125),

                      //Service Remarks
                      Padding(
                        padding:  EdgeInsets.only(left: width/93.55),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:width/12.41,
                              height: height / 10.17,
                              child: Text("Service Remarks",style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width/99.39,
                                color:Colors.black,
                              ),),
                            ),
                            Container(
                              width: width / 2.504,
                              height: height / 10.17,
                              decoration:const BoxDecoration(
                                  color:  Colors.white),
                              child: TextField(
                                maxLines: null,
                                controller: serviceremarkmontroller,
                                style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,top: height/ 82.125),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                   ),
                   SizedBox(width:width/170.75),
                   Container(
                     height:height/4.728,
                     width:width/2.0,
                     decoration:const  BoxDecoration(
                         color: Colors.white,
                         
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height:height/ 121.7,),

                         //Category&&Item Name
                         Row(
                           children: [
                             //Category
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Category",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                                 width: width / 6.504,
                                 height: height / 20.42,
                                 decoration: const BoxDecoration(
                                   color:  Color(0xffDDDEEE),
                                 ),
                                 child:
                                 LayoutBuilder(

                                   builder: (BuildContext, BoxConstraints) =>
                                       Autocomplete<String>(

                                         fieldViewBuilder: (context, textEditingController2,
                                             focusNode, onFieldSubmitted) {
                                           return  TextFormField(
                                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                             onChanged: (_){
                                               setState((){
                                                 Category=textEditingController2;
                                               });
                                             },
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 contentPadding:
                                                 EdgeInsets.only(  left: width / 130.6,bottom:height/ 82.125,)),
                                             controller: textEditingController2,
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

                                           return categorylist.where((String option) {
                                             return option.toLowerCase().contains(
                                                 textEditingValue.text.toLowerCase());
                                           });
                                         },
                                         onSelected: (String selection) {
                                           setState(() {
                                             Category.text=selection;
                                           });
                                           itemdropdown();
                                           debugPrint('You just selected $selection');
                                         },
                                         displayStringForOption: (Value) {
                                           return Value;
                                         },
                                       ),
                                 )

                             ),
                             //Item Name
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Item Name",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                                 width: width / 6.504,
                                 height: height / 20.42,
                                 decoration: const BoxDecoration(
                                   color: Color(0xffDDDEEE),
                                 ),
                                 child:
                                 LayoutBuilder(
                                   builder: (BuildContext, BoxConstraints) =>
                                       Autocomplete<String>(
                                         fieldViewBuilder: (context, textEditingController4,
                                             focusNode, onFieldSubmitted) {
                                           return  TextFormField(
                                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                             onChanged: (_){
                                               setState((){
                                                 itemnamecontroller=textEditingController4;
                                               });
                                             },
                                             decoration: InputDecoration(
                                                 border: InputBorder.none,
                                                 contentPadding:
                                                 EdgeInsets.only(  left: width / 130.6,bottom:height/ 82.125,)),
                                             controller: textEditingController4,
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

                                           return Itemlist.where((String option) {
                                             return option.toLowerCase().contains(
                                                 textEditingValue.text.toLowerCase());
                                           });
                                         },
                                         onSelected: (String selection) async {
                                           setState(() {
                                             itemnamecontroller.text=selection;
                                           });
                                           var Document2 = await FirebaseFirestore.instance.collection('Item ShabikaG').where("Newitemname", isEqualTo: itemnamecontroller.text).get();
                                           setState(() {
                                             itemnamecontroller.text=Document2.docs[0]['Newitemname'];
                                             hancode.text=Document2.docs[0]['HSNCode'];
                                             boxno.text=Document2.docs[0]['BoxNo'];
                                             Salesprice.text=Document2.docs[0]['Saleprice'];
                                             Purchaseprice.text=Document2.docs[0]['Purchaseprice'];
                                           });
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
                         SizedBox(height:height/82.125),

                         //sales price and  box no
                       /*  Row(
                           children: [


                             //Purchase price
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/12.41,
                               height: height / 20.42,
                               child: Text("Purchase price",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: BoxDecoration(
                                 color: const Color(0xffDDDEEE),
                               ),
                               child: TextField(
                                 controller: Purchaseprice,
                                 style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),



                           ],
                         ),*/
                         SizedBox(height:height/82.125),
                         Row(
                           children: [

                            /* //hsncode
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/12.41,
                               height: height / 20.42,
                               child: Text("Hsn-code",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: const BoxDecoration(
                                 color:  Color(0xffDDDEEE),
                               ),
                               child: TextField(
                                 controller: hancode,
                                 style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),*/
                             //Sales Price
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Sales Price",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: const BoxDecoration(
                                 color: Color(0xffDDDEEE),
                               ),
                               child: TextField(
                                 controller: Salesprice,
                                 style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),

                             //boxno
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Box No",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: const BoxDecoration(
                                 color: Color(0xffDDDEEE),
                               ),
                               child: TextField(
                                 controller: boxno,
                                 style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),



                           ],
                         ),

                         SizedBox(height:height/82.125),

                         //status and received person
                         Row(
                           children: [

                             // Received Person
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Received Person",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                               width: width / 6.504,
                               height: height / 20.42,
                               decoration: const BoxDecoration(
                                 color: Color(0xffDDDEEE),
                               ),
                               child: TextField(
                                 controller: receivedpersoncontroller,
                                 style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125,),
                                   border: InputBorder.none,
                                 ),
                               ),
                             ),


                             //Status
                             SizedBox(width:width/93.55),
                             SizedBox(
                               width:width/13.41,
                               height: height / 20.42,
                               child: Text("Status",style: GoogleFonts.cairo(
                                 fontWeight: FontWeight.bold,
                                 fontSize: width/99.39,
                                 color:Colors.black,
                               ),),
                             ),
                             Container(
                                 width: width / 6.504,
                                 height: height / 20.42,
                                 decoration: const BoxDecoration(
                                   color:  Color(0xffDDDEEE),
                                 ),
                                 child:
                                 LayoutBuilder(
                                   builder: (BuildContext, BoxConstraints) =>
                                       Autocomplete<String>(
                                         fieldViewBuilder: (context, textEditing,
                                             focusNode, onFieldSubmitted) {
                                           return  TextFormField(
                                             style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                             onChanged: (_){
                                               setState((){
                                                 Status=textEditing;
                                               });
                                             },
                                             decoration: InputDecoration(
                                               suffixIcon: InkWell(
                                                 onTap: () {
                                                   Servicestatuscreatefunction();
                                                   Stausfunction();
                                                   showdialpogbox();
                                                 },
                                                 child:const Icon(Icons.add,),
                                               ),
                                                 border: InputBorder.none,
                                                 contentPadding:
                                                 EdgeInsets.only(  left: width / 130.6,bottom:height/ 82.125,)),
                                             controller: textEditing,
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
                                           setState((){
                                             Status.text=selection;
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
                         SizedBox(height:height/82.125),



                       ],
                     ),
                   ),
                 ],
               ),


               
               

               SizedBox(height:height/3.4),
               //amount container
               Padding(
                 padding:  EdgeInsets.only(left: width/103.55,right:width/93.55),
                 child: Container(
                   height:height/7.457,
                   width:double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     
                     children: [
                       SizedBox(height:height/ 65.7,),

                       Row(
                         children: [
                           SizedBox(width:width/68.3,),
                           //Cost
                           Container(
                             width: width / 7.0,
                             height: height / 20.42,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(4),
                               color: const Color(0xff1D5B79),
                             ),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(
                                       left: width / 455.33),
                                   child: SizedBox(
                                     width: width / 12.5,
                                     height: height / 23.42,
                                     child: Center(
                                       child: Text(
                                         "Service Cost",
                                         style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             color: Colors.white,
                                             ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: width / 16.83,
                                   height: height / 23.42,
                                   //color: Color(0xffDDDEEE),
                                   decoration: BoxDecoration(
                                       color: Colors.grey.shade300,
                                       borderRadius:
                                       BorderRadius.circular(6)),
                                   child:
                                   TextField(
                                     controller: servicecostcontroller,
                                     style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 42.125,),
                                       border: InputBorder.none,
                                     ),

                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(width:width/68.3,),

                           //Advance amount
                           Container(
                             width: width / 7.0,
                             height: height / 20.42,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(4),
                               color: const Color(0xff1D5B79),
                             ),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(
                                       left: width / 455.33),
                                   child: SizedBox(
                                     width: width / 12.5,
                                     height: height / 23.42,
                                     child: Center(
                                       child: Text(
                                         "Advance Amt",
                                         style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: width / 16.83,
                                   height: height / 23.42,
                                   //color: Color(0xffDDDEEE),
                                   decoration: BoxDecoration(
                                       color: Colors.grey.shade300,
                                       borderRadius:
                                       BorderRadius.circular(6)),
                                   child:
                                   TextField(
                                     controller: serviceadvancebalancecontroller,
                                     style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 42.125,),
                                       border: InputBorder.none,
                                     ),
                                     onSubmitted: (_){
                                       if(serviceadvancebalancecontroller.text=="0"){
                                         setState((){
                                           servicebalancecontroller.text="0";
                                           serviceadvancebalancecontroller.text="0";
                                         });
                                       }
                                       else{
                                         setState((){
                                           servicebalancecontroller.text=(int.parse(servicecostcontroller.text)-int.parse(serviceadvancebalancecontroller.text)).toString();
                                         });
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(width:width/68.3,),

                           //Balance Amount
                           Container(
                             width: width / 7.0,
                             height: height / 20.42,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(4),
                               color: const Color(0xff075E54),
                             ),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: EdgeInsets.only(
                                       left: width / 455.33),
                                   child: SizedBox(
                                     width: width / 12.5,
                                     height: height / 23.42,
                                     child: Center(
                                       child: Text(
                                         "Balance Amt",
                                         style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: width / 16.83,
                                   height: height / 23.42,
                                   //color: Color(0xffDDDEEE),
                                   decoration: BoxDecoration(
                                       color: Colors.grey.shade300,
                                       borderRadius:
                                       BorderRadius.circular(6)),
                                   child:
                                   TextField(
                                     controller: servicebalancecontroller,
                                     style: GoogleFonts.poppins(fontSize: width/99.6,fontWeight: FontWeight.w700),
                                     decoration: InputDecoration(
                                       contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 42.125,),
                                       border: InputBorder.none,
                                     ),

                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(width:width/68.3,),


                           InkWell(
                             onTap:(){
                               lastbillset();
                             },
                             child: Container(
                               width: width / 7.0,
                               height: height / 20.42,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(4),
                                 color: const Color(0xff00A99D),
                               ),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Padding(
                                     padding: EdgeInsets.only(
                                         left: width / 455.33),
                                     child: SizedBox(
                                       width: width / 12.5,
                                       height: height / 23.42,
                                       child: Center(
                                         child: Text(
                                           "Last Bill No",
                                           style: GoogleFonts.poppins(
                                               fontWeight: FontWeight.w600,
                                               color: Colors.white,
                                              ),
                                         ),
                                       ),
                                     ),
                                   ),
                                   Container(
                                       width: width / 16.83,
                                       height: height / 23.42,
                                       //color: Color(0xffDDDEEE),
                                       decoration: BoxDecoration(
                                           color: Colors.grey.shade300,
                                           borderRadius:
                                           BorderRadius.circular(6)),
                                       child:
                                       Center(child: Text(lastbillcontroller.text,style:
                                       GoogleFonts.poppins(fontSize: width/119.6,fontWeight: FontWeight.w700),))
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           
                           SizedBox(width:width/5.3,),
                           InkWell(
                             onTap: () {
                               saveserviceentry();
                               itemcodegenrate();
                               savebillshowdialpogbox();
                             },
                             child: Container(
                               width: width / 8.6,
                               height: height / 20.42,
                               //color: Color(0xffD60A0B),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 color: const Color(0xff075e54),
                               ),
                               child: Center(
                                   child: Text(
                                     "Save",
                                     style: GoogleFonts.poppins(color: Colors.white),
                                   )),
                             ),
                           ),





                         ],
                       ),



                     ],
                   ),
                 ),
               ),
             ],
           ),
           dropdownValue2=="Pattern"&&
               patternselected==true?
           Container(
             height:height/1.314,
             width:width/2.732,
             color:Colors.white,
             child: Column(

               children: [
                 SizedBox(height:height/65.7),
                 Text("Enter the Pattern-Lock",style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.w700),),
                 SizedBox(height:height/65.7),
                 SizedBox(
                   width:width/3.415,
                   height:height/1.642,
                   child: PatternLock(
                     // color of selected points.
                     selectedColor: Colors.red,
                     // radius of points.
                     pointRadius: 30,
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
                       Patterlist=input;
                       Patterncontroller.text=input .toString();
                     },
                   ),
                 ),
                 Row(
                   mainAxisAlignment:MainAxisAlignment.center ,
                   children: [
                     InkWell(
                       onTap: (){
                         setState((){
                           patternselected=false;

                         });
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
                         setState((){
                           patternselected=false;
                         });
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
           ):
           const SizedBox()

         ],
       );
   }
  }


}
