import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


const List<String> Paymentmode3 = <String>['Please Select', "G pay", "Cash","Paytm","Phonepe","Card"];
class Wanted_reports_Page extends StatefulWidget {
  const Wanted_reports_Page({Key? key}) : super(key: key);

  @override
  State<Wanted_reports_Page> createState() => _Wanted_reports_PageState();
}

class _Wanted_reports_PageState extends State<Wanted_reports_Page> {

  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController Category=TextEditingController();
  TextEditingController Serachstatus=TextEditingController();
  TextEditingController Serachstatus2=TextEditingController();
  TextEditingController Serachstatus3=TextEditingController();
  bool isserach=false;
  String Username='';
  String Username2='';

  String Status1="Status-1";
  String Status2="Status-2";
  String Status3="Status-3";


  List <String>StatusType=[];
  List <String> StatusType2=[];
  List  <String> StatusType3=[];
  List<String> category=[];

  Starusnamelist()async{
    setState(() {
      StatusType.clear();
      StatusType2.clear();
      StatusType3.clear();
    });
    var document=await FirebaseFirestore.instance.collection("Status1").get();
    var document2=await FirebaseFirestore.instance.collection("Status2").get();
    var document3=await FirebaseFirestore.instance.collection("Status3").get();
    setState(() {
      StatusType.add("Status-1");
      StatusType2.add("Status-2");
      StatusType3.add("Status-3");
    });
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        StatusType.add(document.docs[i]['name']);
      });
    }
    for(int i=0;i<document2.docs.length;i++){
      setState(() {
        StatusType2.add(document2.docs[i]['name']);
      });
    }
    for(int i=0;i<document3.docs.length;i++){
      setState(() {
        StatusType3.add(document3.docs[i]['name']);
      });
    }

  }

  Cyegorydata() async {
    setState(() {
      category.clear();
    });
    var details = await FirebaseFirestore.instance.collection("category").get();
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        category.add(details.docs[i]["categoryname"]);
      });
    }
  }

  @override
  void initState() {
    Starusnamelist();
    Cyegorydata();
    // TODO: implement initState
    super.initState();
  }



TextEditingController Datecontroller=TextEditingController();
TextEditingController namecon=TextEditingController();
String nameval="";

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

              SizedBox(width: width/136.6,),

              //textfield-1 fromdate
              Text("Sort by\nDate :",
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/84.64),),
              SizedBox(width: width/136.6,),

              Container(
                height: height / 16.4,
                width: width / 9.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xff01A99E))),
                child: TextField(
                  controller: Datecontroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                    hintText: "mm/dd/yyyy",
                    hintStyle: const TextStyle(color: Color(0xff00A99D)),
                    border: InputBorder.none,
                  ),
                  onTap: () async {

                    DateTime? pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now()
                    );

                    if(pickedDate != null ){
                      //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('d/M/yyyy').format(pickedDate);
                      //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement
                      setState(() {
                        Datecontroller.text=formattedDate;
                      });
                      print("Datecontroller.text");
                      print(Datecontroller.text);
                    }
                    else{
                    }
                  },
                ),
              ),
              SizedBox(width: width/136.6,),

              Text("Sort by\nCategory :",
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/84.64),),
              SizedBox(width: width/136.6,),


              Container(
                height: height/16.425,
                width: width/9.106,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child:
                LayoutBuilder(
                  builder: (BuildContext, BoxConstraints) =>
                      Autocomplete<String>(
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return
                            TextFormField(
                              onChanged: (_){
                                setState((){
                                  Category=textEditingController;
                                });
                              },
                              style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                              controller: textEditingController,
                              focusNode: focusNode,
                              onFieldSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            );
                        },
                        initialValue: const TextEditingValue(
                            selection: TextSelection(
                              isDirectional: true,
                              baseOffset: 5,
                              extentOffset: 1,
                            )),
                        optionsViewBuilder:
                            (context, onSelected, options) => Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                    bottom: Radius.circular(
                                        4.0)),
                              ),
                              child: SizedBox(
                                height: 52.0 * options.length,
                                width: BoxConstraints
                                    .biggest.width,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  shrinkWrap: false,
                                  itemBuilder:
                                      (BuildContext, index) {
                                    final String option =
                                    options
                                        .elementAt(index);
                                    return InkWell(
                                      onTap: () =>
                                          onSelected(option),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            16.0),
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

                          return category.where((String option) {
                            return option.toLowerCase().contains(
                                textEditingValue.text
                                    .toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            Category.text = selection;
                            isserach=true;
                            Username2=selection;
                          });
                          debugPrint(
                              'You just selected $selection');
                        },
                        displayStringForOption: (Value) {
                          return Value;
                        },
                      ),
                ),

              ),
              SizedBox(width: width/136.6,),

              //Status-1
              Text("Status-1 : ",style: GoogleFonts.montserrat(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/84.64),),
              Container(
                  height: height/16.425,
                  width: width/9.106,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
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
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextFormField(
                              onChanged: (_){
                                setState((){
                                  Serachstatus=textEditingController;
                                });
                              },
                              style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                              controller: textEditingController,
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
                            return StatusType.where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            setState(() {
                              Serachstatus.text=selection;
                              Status1=selection;
                              isserach=true;
                              Username=selection;
                            });

                          },
                          displayStringForOption: (Value) {
                            return Value;
                          },
                        ),
                  )

              ),
              SizedBox(width: width/136.6,),

              //Status-2
              Text("Status-2 : ",style: GoogleFonts.montserrat(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/84.64),),
              Container(
                  height: height/16.425,
                  width: width/9.106,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
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
                          fieldViewBuilder: (context, Controller2, focusNode, onFieldSubmitted){
                            return
                              TextFormField(
                                onChanged: (_){
                                  setState((){
                                    Serachstatus2=Controller2;
                                  });
                                },
                                style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
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

                            return StatusType2.where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            setState(() {
                              Status2=selection;
                              isserach=true;
                              Username=selection;
                              Serachstatus2.text=selection;
                            });

                          },
                          displayStringForOption: (Value) {
                            return Value;
                          },
                        ),
                  )

              ),
              SizedBox(width: width/136.6,),

              //Status-3
              Text("Status-3 : ",style: GoogleFonts.montserrat(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/84.64),),
              Container(
                  height: height/16.425,
                  width: width/9.106,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child:      LayoutBuilder(
                    builder: (BuildContext, BoxConstraints) =>
                        Autocomplete<String>(
                          initialValue: const TextEditingValue(
                            selection: TextSelection(
                              isDirectional: true,
                              baseOffset: 10,
                              extentOffset: 1,
                            ),

                          ),
                          fieldViewBuilder: (context, Controller3, focusNode, onFieldSubmitted){
                            return
                              TextFormField(
                                onChanged: (_){
                                  setState((){
                                    Serachstatus3=Controller3;
                                  });
                                },
                                style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                                controller: Controller3,
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

                            return StatusType3.where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
                            setState(() {
                              Status3=selection;
                              Serachstatus3.text=selection;
                              isserach=true;
                              Username=selection;
                            });

                          },
                          displayStringForOption: (Value) {
                            return Value;
                          },
                        ),
                  )

              ),
              SizedBox(width: width/136.6,),

              SizedBox(width: width/136.6,),

              InkWell(
                onTap: (){
                  setState(() {
                    Serachcontroller.clear();
                    Category.clear();
                    Serachstatus.clear();
                    Serachstatus2.clear();
                    Serachstatus3.clear();
                    Datecontroller.clear();
                    Status1="";
                    Status2="";
                    Status3="";
                    isserach=false;
                    Username='';
                    nameval="";
                    namecon.clear();
                  });
                },
                child: Container(
                  height: height/16.425,
                  width: width/13.66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),color:Colors.red
                  ),
                  child:  Center(
                    child: Text("Clear",style: GoogleFonts.montserrat(color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: width/84.64),),
                  ),
                ),
              ),
              SizedBox(width: width/136.6,),

            ],
          ),
          SizedBox(
            height: height/43.8,
          ),
          Row(
            children: [

              SizedBox(width: width/136.6,),

              //textfield-1 fromdate
              Text("Customer Phone/Name :",
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: width/84.64),),
              SizedBox(width: width/136.6,),

              Container(
                height: height / 16.4,
                width: width / 4.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xff01A99E))),
                child: TextField(
                  onChanged: (val){
                    setState(() {
                      nameval=val;
                    });
                    print(nameval);

                  },
                  controller: namecon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                    border: InputBorder.none,
                  ),

                ),
              ),
              SizedBox(width: width/136.6,),





            ],
          ),
          SizedBox(
            height: height/43.8,
          ),

          Container(
              height:height/ 1.194,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child:  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height/65.7,),
                    Padding(
                      padding:  EdgeInsets.only(left: width/273.2),
                      child:
                      Row(
                        children: [
                          Container(
                              width:width/30.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Si No',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Date\nTime',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),



                          Container(
                              width:width/12.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text('Category',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/11.383+ width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Item Name',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/18.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Amount',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/18.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Advance\nAmount',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),
                          Container(
                              width:width/18.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Second\nPayment',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/18.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Balance\nAmount',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Customer\nName\nMobile',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Payment',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Status-1',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Status-2',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Status-3',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/14.583,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Actions',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),





                        ],
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: width/273.2),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Wantedlist").
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
                            physics: const ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {

                              var wantedlist=snapshot.data!.docs[index];

                            if(isserach==true){
                              if(
                              wantedlist['Category'].toString().toLowerCase().startsWith(Username2.toLowerCase())&&
                                  Serachstatus.text==""&&Serachstatus2.text==""&&Serachstatus3.text==""||
                                  (wantedlist['Category'].toString().toLowerCase().startsWith(Username2.toLowerCase())&&
                                     wantedlist['staus1'].toString().toLowerCase().startsWith(Serachstatus.text.toLowerCase()))
                                  && Serachstatus2.text==""&&Serachstatus3.text=="" ||

                                  (wantedlist['Category'].toString().toLowerCase().startsWith(Username2.toLowerCase())&&
                                      wantedlist['staus2'].toString().toLowerCase().startsWith(Serachstatus2.text.toLowerCase()))
                                      && Serachstatus.text==""&&Serachstatus3.text=="" ||

                                  (wantedlist['Category'].toString().toLowerCase().startsWith(Username2.toLowerCase())&&
                                      wantedlist['staus3'].toString().toLowerCase().startsWith(Serachstatus3.text.toLowerCase()))
                                      && Serachstatus.text==""&&Serachstatus2.text=="" ||

                                  wantedlist['staus1'].toString().toLowerCase().startsWith(Serachstatus.text.toLowerCase())
                                      && Serachstatus2.text==""&&Serachstatus3.text==""&&Username2=="" ||

                                  wantedlist['staus2'].toString().toLowerCase().startsWith(Serachstatus2.text.toLowerCase())
                                      && Serachstatus.text==""&&Serachstatus3.text=="" &&Username2==""||

                                  wantedlist['staus3'].toString().toLowerCase().startsWith(Serachstatus3.text.toLowerCase())
                                      && Serachstatus.text==""&&Serachstatus2.text==""&&Username2==""
                              )
                              {
                                return
                                  Datecontroller.text==wantedlist['Date']?
                                  Row(
                                    children: [
                                      Container(
                                          width:width/30.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                      Container(
                                          width:width/12.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383 +width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['AdvanceAmount'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Balance amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${wantedlist['Customer name']}\n${wantedlist['Customer Phone']}",

                                            textAlign : TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Payment'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                color: wantedlist['Payment']=="Payment Paid"? Colors.green : Colors.red

                                            ),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus1'],

                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      InkWell(
                                        onTap:(){
                                          showdialpogbox2(wantedlist.id);
                                        },
                                        child: Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus2'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      ),

                                      InkWell(

                                        onTap:(){
                                          showdialpogbox3(wantedlist.id);
                                        },
                                        child: Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus3'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      ),

                                      InkWell(
                                        onTap:(){
                                          Payedpopup(wantedlist.id,wantedlist['Amount'],wantedlist['Balance amount'],wantedlist['AdvanceAmount']);
                                        },
                                        child: Container(
                                            width:(width/14.583)/2,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('Pay ',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.green),))),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          viewimage(wantedlist['imageurl']);
                                        },
                                        child: Container(
                                            width:(width/14.583)/2,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: wantedlist['imageurl']!=""? Icon(Icons.image):SizedBox())),
                                      ),






                                    ],
                                  ):
                                  Row(
                                    children: [
                                      Container(
                                          width:width/30.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                      Container(
                                          width:width/12.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383 +width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['AdvanceAmount'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      Container(
                                          width:width/18.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Balance amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text("${wantedlist['Customer name']}\n${wantedlist['Customer Phone']}",

                                            textAlign : TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Payment'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                color: wantedlist['Payment']=="Payment Paid"? Colors.green : Colors.red

                                            ),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus1'],

                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      InkWell(
                                        onTap:(){
                                          showdialpogbox2(wantedlist.id);
                                        },
                                        child: Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus2'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      ),

                                      InkWell(

                                        onTap:(){
                                          showdialpogbox3(wantedlist.id);
                                        },
                                        child: Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus3'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                      ),

                                      InkWell(
                                        onTap:(){
                                          Payedpopup(wantedlist.id,wantedlist['Amount'],wantedlist['Balance amount'],wantedlist['AdvanceAmount']);
                                        },
                                        child: Container(
                                            width:(width/14.583)/2,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('Pay ',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.green),))),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          viewimage(wantedlist['imageurl']);
                                        },
                                        child: Container(
                                            width:(width/14.583)/2,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: wantedlist['imageurl']!=""? Icon(Icons.image):SizedBox())),
                                      ),






                                    ],
                                  );
                              }
                            }
                            if(nameval!=""){
                              if(wantedlist['Customer name'].toLowerCase().startsWith(nameval.toString().toLowerCase())||wantedlist['Customer Phone'].toLowerCase().startsWith(nameval.toString().toLowerCase())){
                                return Row(
                                  children: [
                                    Container(
                                        width:width/30.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                    Container(
                                        width:width/12.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),

                                        ),
                                        child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/11.383 +width/11.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['AdvanceAmount'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['Amount2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                    Container(
                                        width:width/18.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['Balance amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/11.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text("${wantedlist['Customer name']}\n${wantedlist['Customer Phone']}",

                                          textAlign : TextAlign.center,
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['Payment'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                              color: wantedlist['Payment']=="Payment Paid"? Colors.green : Colors.red

                                          ),))),

                                    Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['staus1'],

                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                    InkWell(
                                      onTap:(){
                                        showdialpogbox2(wantedlist.id);
                                      },
                                      child: Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus2'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                    ),

                                    InkWell(

                                      onTap:(){
                                        showdialpogbox3(wantedlist.id);
                                      },
                                      child: Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus3'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                    ),

                                    InkWell(
                                      onTap:(){
                                        Payedpopup(wantedlist.id,wantedlist['Amount'],wantedlist['Balance amount'],wantedlist['AdvanceAmount']);
                                      },
                                      child: Container(
                                          width:(width/14.583)/2,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('Pay ',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.green),))),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        viewimage(wantedlist['imageurl']);
                                      },
                                      child: Container(
                                          width:(width/14.583)/2,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: wantedlist['imageurl']!=""? Icon(Icons.image):SizedBox())),
                                    ),






                                  ],
                                );
                              }
                            }
                              else if(isserach==false){
                                  if(Datecontroller.text==wantedlist['Date']){
                                   return Row(
                                     children: [
                                       Container(
                                           width:width/30.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/15.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                             textAlign: TextAlign.center,
                                             style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                       Container(
                                           width:width/12.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),

                                           ),
                                           child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/11.383 +width/11.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['AdvanceAmount'],
                                             textAlign: TextAlign.center,
                                             style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['Amount2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                       Container(
                                           width:width/18.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['Balance amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/11.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text("${wantedlist['Customer name']}\n${wantedlist['Customer Phone']}",

                                             textAlign : TextAlign.center,
                                             style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       Container(
                                           width:width/15.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['Payment'],
                                             textAlign: TextAlign.center,
                                             style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                                 color: wantedlist['Payment']=="Payment Paid"? Colors.green : Colors.red

                                             ),))),

                                       Container(
                                           width:width/15.383,
                                           height:height/13.14,
                                           decoration: BoxDecoration(
                                             border: Border.all(color: Colors.black,width: 1.2),
                                           ),
                                           child: Center(child: Text(wantedlist['staus1'],

                                             textAlign: TextAlign.center,
                                             style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                       InkWell(
                                         onTap:(){
                                           showdialpogbox2(wantedlist.id);
                                         },
                                         child: Container(
                                             width:width/15.383,
                                             height:height/13.14,
                                             decoration: BoxDecoration(
                                               border: Border.all(color: Colors.black,width: 1.2),
                                             ),
                                             child: Center(child: Text(wantedlist['staus2'],
                                               textAlign: TextAlign.center,
                                               style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                       ),

                                       InkWell(

                                         onTap:(){
                                           showdialpogbox3(wantedlist.id);
                                         },
                                         child: Container(
                                             width:width/15.383,
                                             height:height/13.14,
                                             decoration: BoxDecoration(
                                               border: Border.all(color: Colors.black,width: 1.2),
                                             ),
                                             child: Center(child: Text(wantedlist['staus3'],
                                               textAlign: TextAlign.center,
                                               style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                       ),

                                       InkWell(
                                         onTap:(){
                                           Payedpopup(wantedlist.id,wantedlist['Amount'],wantedlist['Balance amount'],wantedlist['AdvanceAmount']);
                                         },
                                         child: Container(
                                             width:(width/14.583)/2,
                                             height:height/13.14,
                                             decoration: BoxDecoration(
                                               border: Border.all(color: Colors.black,width: 1.2),
                                             ),
                                             child: Center(child: Text('Pay ',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.green),))),
                                       ),
                                       InkWell(
                                         onTap:(){
                                           viewimage(wantedlist['imageurl']);
                                         },
                                         child: Container(
                                             width:(width/14.583)/2,
                                             height:height/13.14,
                                             decoration: BoxDecoration(
                                               border: Border.all(color: Colors.black,width: 1.2),
                                             ),
                                             child: Center(child: wantedlist['imageurl']!=""? Icon(Icons.image):SizedBox())),
                                       ),






                                     ],
                                   );
                                  }

                                  else if(Datecontroller.text==""){
                                    return Row(
                                      children: [
                                        Container(
                                            width:width/30.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                        Container(
                                            width:width/12.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),

                                            ),
                                            child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383 +width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/18.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/18.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['AdvanceAmount'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),



                                        Container(
                                            width:width/18.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Amount2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                        Container(
                                            width:width/18.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Balance amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text("${wantedlist['Customer name']}\n${wantedlist['Customer Phone']}",

                                              textAlign : TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Payment'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,
                                            color: wantedlist['Payment']=="Payment Paid"? Colors.green : Colors.red

                                            ),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus1'],

                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        InkWell(
                                          onTap:(){
                                            showdialpogbox2(wantedlist.id);
                              },
                                          child: Container(
                                              width:width/15.383,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2),
                                              ),
                                              child: Center(child: Text(wantedlist['staus2'],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                        ),

                                        InkWell(

                                          onTap:(){
                                showdialpogbox3(wantedlist.id);
                              },
                                          child: Container(
                                              width:width/15.383,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2),
                                              ),
                                              child: Center(child: Text(wantedlist['staus3'],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                        ),

                                        InkWell(
                                          onTap:(){
                                            Payedpopup(wantedlist.id,wantedlist['Amount'],wantedlist['Balance amount'],wantedlist['AdvanceAmount']);
                                          },
                                          child: Container(
                                              width:(width/14.583)/2,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2),
                                              ),
                                              child: Center(child: Text('Pay ',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color:  Colors.green),))),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            viewimage(wantedlist['imageurl']);
                                          },
                                          child: Container(
                                              width:(width/14.583)/2,
                                              height:height/13.14,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 1.2),
                                              ),
                                              child: Center(child: wantedlist['imageurl']!=""? Icon(Icons.image):SizedBox())),
                                        ),






                                      ],
                                    );
                                  }
                                  return SizedBox();
                              }

                              return const SizedBox(

                              );

                            },);
                        },
                      ),
                    )

                  ],
                ),
              )
          ),
        ],
      );
  }


  TextEditingController total= new TextEditingController();
  TextEditingController topay= new TextEditingController();
  TextEditingController amount= new TextEditingController();
  TextEditingController balance= new TextEditingController();
  String Payments2 = Paymentmode3.first;

  Payedpopup(streamid,total2,balance2,advance) {
    setState(() {
      total.text=total2;
      topay.text=balance2;
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(top: height / 8.4, bottom: height / 18.4),
              child: SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: AlertDialog(
                    backgroundColor: const Color(0xff264656),
                    content: SizedBox(
                      width: width / 3.902,
                      height: 350,
                      child: Column(
                        children: [
                          Text(
                            "Payment Details..",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width / 68.30,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 120.85,
                          ),
                          //amount to payed
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Total Amount:",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: total,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //AMount
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "To Pay",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: topay,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                    onSubmitted: (_) {
                                      setState(() {
                                        /*balancepay.text = (balanceamount -
                                            double.parse(Amounts.text))
                                            .abs()
                                            .toStringAsFixed(2);
                                        balanceamount = (balanceamount -
                                            double.parse(Amounts.text))
                                            .abs();
                                        Payedamount =
                                            double.parse(Amounts.text).abs();*/
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),
                          //discount
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Amount",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    onSubmitted: (val){
                                      setState(() {
                                        balance.text=(double.parse(topay.text)- double.parse(amount.text)).toString();
                                      });
                                    },
                                    controller: amount,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //balance to pay
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Balance",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: balance,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //Credit day


                          //Payment MOde
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Payment Mode",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: DropdownButton2<String>(
                                    value: Payments2,
                                    isExpanded: true,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 105.07),
                                    underline: Container(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        Payments2 = value!;
                                      });
                                    },
                                    items: Paymentmode3.map<
                                        DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: height / 65.7,
                          ),



                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  print("Pay now button pressed");
                                 paynow(streamid,amount.text,balance.text);

                                },
                                child: Material(
                                  elevation: 15,
                                  color: const Color(0xff25D366),
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height / 16.425,
                                    width: width / 9.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff25D366),
                                    ),
                                    child: Center(
                                      child: Text("Okay",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width / 85.375,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 68.3),
                              InkWell(
                                onTap: () {

                                  setState(() {
                                    Payments2 = Paymentmode3.first;
                                  });
                                  print("POP");
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
                    )),
              ),
            );
          },
        );
      },
    );
  }
  viewimage(val) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.4, bottom: height / 4.4),
          child: SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(

                content: SizedBox(
                  width: width / 3.902,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height / 99.85,
                      ),

                      val!=""?
                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Image.network(val),
                      ) : Text("No Image Uploaded"),
                      SizedBox(
                        height: height / 53.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 21.9,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
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
                )),
          ),
        );
      },
    );
  }
  paynow(docid,amount,balance){
    FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
      "Amount2":amount,
      "Balance amount":balance,
      "Payment":balance=="0"?"Payment Paid":"Payment Unpaid"
    });
    Navigator.of(context).pop();
  }

  Widget textfield1(
      FocusNode focusNode,
      TextEditingController Controller1,
      VoidCallback onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      onChanged: (_){
        setState(() {
          Serachstatus.text=Controller1.text;
        });
      },
      style:  GoogleFonts.montserrat(
          fontWeight:FontWeight.w700
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: width / 91.06, bottom: height / 43.8)),
      controller: Controller1,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
  Widget textfield2(
      FocusNode focusNode,
      TextEditingController Controller2,
      VoidCallback onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      style:  GoogleFonts.montserrat(
          fontWeight:FontWeight.w700
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: width / 91.06, bottom: height / 43.8)),
      controller: Controller2,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }

  Widget textfield3(
      FocusNode focusNode,
      TextEditingController Controller3,
      VoidCallback onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      style:  GoogleFonts.montserrat(
          fontWeight:FontWeight.w700
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              left: width / 91.06, bottom: height / 43.8)),
      controller: Controller3,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }


  ///status update popup dialog box///------
  String WantedType="Select";
  List <String> dropdownlist=[];

  showdialpogbox(checkstatus,docid) {
    setState(() {
      dropdownlist.clear();
    });
    if(checkstatus=="Stutus1"){
      for(int i=0;i<StatusType.length;i++){
        setState(() {
          dropdownlist.add("Select");
          dropdownlist.add(StatusType[i]);
        });
      }
    }
    if(checkstatus=="Stutus2"){
      for(int i=0;i<StatusType2.length;i++){
        setState(() {
          dropdownlist.add("Select");
          dropdownlist.add(StatusType2[i]);
        });
      }
    }
    if(checkstatus=="Stutus3"){
      for(int i=0;i<StatusType3.length;i++){
        setState(() {
          dropdownlist.add("Select");
          dropdownlist.add(StatusType3[i]);
        });
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return 
          StatefulBuilder(builder: (context, setState) {
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child:
                Padding(
                  padding:  EdgeInsets.only(top: height/4.6,bottom:height/4.6,left: width/3.53,right: width/3.53),
                  child: Scaffold(
                    backgroundColor: const Color(0xff00A99D),
                    body:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height/22.53,),
                        Text("Status Update",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                        SizedBox(height:height/6.56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Status : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                            SizedBox(width: width/136.6,),
                            Container(
                              width: width / 7.415,
                              height: height / 18.9,
                              //color:Colors.white,
                              decoration:  BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:
                              DropdownButton2<String>(
                                value: WantedType,
                                style:GoogleFonts.montserrat(
                                    fontSize: width/113.833,
                                    color:Colors.black,
                                    fontWeight: FontWeight.bold),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                iconStyleData: const IconStyleData(
                                    icon:Icon(Icons.arrow_back_ios_outlined),
                                    iconSize: 0
                                ),

                                onChanged: (String? value) {
                                  setState(() {
                                    WantedType=value!;
                                  });
                                  print(WantedType);
                                },
                                items:
                                dropdownlist.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:GoogleFonts.montserrat(
                                            fontSize: width/113.833,
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold),),
                                      );
                                    }).toList(),
                                dropdownStyleData: const DropdownStyleData(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height:height/6.36),
                        InkWell(
                          onTap: () {
                            if(checkstatus=="Stutus1"){
                              FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
                                "staus1":WantedType,
                              });
                              setState((){
                                 WantedType="Select";
                              });

                            }
                            if(checkstatus=="Stutus2"){
                              FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
                                "staus2":WantedType,
                              });
                              setState((){
                                WantedType="Select";
                              });
                            }
                            if(checkstatus=="Stutus3"){
                              FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
                                "staus3":WantedType,
                              });
                              setState((){
                                WantedType="Select";
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width / 12.6,
                            height: height / 20.42,
                            //color: Color(0xffD60A0B),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366),
                            ),
                            child: Center(
                                child: Text(
                                  "Okay",
                                  style: GoogleFonts.poppins(color: Colors.white),
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            );
          },);
      },
    );
  }
  showdialpogbox2(docid) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return
          StatefulBuilder(builder: (context, setState) {
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child:
                Padding(
                  padding:  EdgeInsets.only(top: height/4.6,bottom:height/4.6,left: width/3.53,right: width/3.53),
                  child: Scaffold(
                    backgroundColor: const Color(0xff00A99D),
                    body:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height/22.53,),
                        Text("Status Update",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                        SizedBox(height:height/6.56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Status : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                            SizedBox(width: width/136.6,),
                            Container(
                              width: width / 7.415,
                              height: height / 18.9,
                              //color:Colors.white,
                              decoration:  BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:
                              DropdownButton2<String>(
                                value: Status2,
                                style:GoogleFonts.montserrat(
                                    fontSize: width/113.833,
                                    color:Colors.black,
                                    fontWeight: FontWeight.bold),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                iconStyleData: const IconStyleData(
                                    icon:Icon(Icons.arrow_back_ios_outlined),
                                    iconSize: 0
                                ),

                                onChanged: (String? value) {
                                  setState(() {
                                    Status2=value!;
                                  });
                                  print(WantedType);
                                },
                                items:
                                StatusType2.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:GoogleFonts.montserrat(
                                            fontSize: width/113.833,
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold),),
                                      );
                                    }).toList(),
                                dropdownStyleData: const DropdownStyleData(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height:height/6.36),
                        InkWell(
                          onTap: () {
                              FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
                                "staus2":Status2,
                              });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width / 12.6,
                            height: height / 20.42,
                            //color: Color(0xffD60A0B),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366),
                            ),
                            child: Center(
                                child: Text(
                                  "Okay",
                                  style: GoogleFonts.poppins(color: Colors.white),
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            );
          },);
      },
    );
  }
  showdialpogbox3(docid) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return
          StatefulBuilder(builder: (context, setState) {
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child:
                Padding(
                  padding:  EdgeInsets.only(top: height/4.6,bottom:height/4.6,left: width/3.53,right: width/3.53),
                  child: Scaffold(
                    backgroundColor: const Color(0xff00A99D),
                    body:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height/22.53,),
                        Text("Status Update",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                        SizedBox(height:height/6.56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Status : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
                            SizedBox(width: width/136.6,),
                            Container(
                              width: width / 7.415,
                              height: height / 18.9,
                              //color:Colors.white,
                              decoration:  BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:
                              DropdownButton2<String>(
                                value: Status3,
                                style:GoogleFonts.montserrat(
                                    fontSize: width/113.833,
                                    color:Colors.black,
                                    fontWeight: FontWeight.bold),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                iconStyleData: const IconStyleData(
                                    icon:Icon(Icons.arrow_back_ios_outlined),
                                    iconSize: 0
                                ),

                                onChanged: (String? value) {
                                  setState(() {
                                    Status3=value!;
                                  });
                                  print(WantedType);
                                },
                                items:
                                StatusType3.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style:GoogleFonts.montserrat(
                                            fontSize: width/113.833,
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold),),
                                      );
                                    }).toList(),
                                dropdownStyleData: const DropdownStyleData(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height:height/6.36),
                        InkWell(
                          onTap: () {
                              FirebaseFirestore.instance.collection("Wantedlist").doc(docid).update({
                                "staus3":Status3,
                              });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width / 12.6,
                            height: height / 20.42,
                            //color: Color(0xffD60A0B),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366),
                            ),
                            child: Center(
                                child: Text(
                                  "Okay",
                                  style: GoogleFonts.poppins(color: Colors.white),
                                )),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            );
          },);
      },
    );
  }

}
