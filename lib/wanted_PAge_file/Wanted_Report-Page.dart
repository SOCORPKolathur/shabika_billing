import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  String Status1="";
  String Status2="";
  String Status3="";


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
    var document=await FirebaseFirestore.instance.collection("Wantedstatus").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        StatusType.add(document.docs[i]['Wantedstatus1']);
        StatusType2.add(document.docs[i]['Wantedstatus2']);
        StatusType3.add(document.docs[i]['Wantedstatus3']);
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
                child: Text("Wanted Reports",
                  style: GoogleFonts.montserrat(color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width/54.64),),
              ),


            ],
          ),
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
                  });
                },
                child: Container(
                  height: height/16.425,
                  width: width/13.66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),color:Colors.white
                  ),
                  child:  Center(
                    child: Text("Clear",style: GoogleFonts.montserrat(color: Colors.black,
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

          Container(
              height:height/ 1.194,
              width: width/1.050,
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
                              width:width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Date\nTime',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Order No',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),

                              ),
                              child: Center(child: Text('Category',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/11.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Item Name',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Amount',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
                              height:height/13.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1.2),
                              ),
                              child: Center(child: Text('Advance\nAmount',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                          Container(
                              width:width/15.383,
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
                              child: Center(child: Text('Customer\nName',
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
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Order'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['AdvanceAmount'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
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
                                          child: Center(child: Text(wantedlist['Customer name'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Payment'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus1'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus3'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),






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
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Order'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),

                                          ),
                                          child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/11.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['AdvanceAmount'],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
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
                                          child: Center(child: Text(wantedlist['Customer name'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['Payment'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus1'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                      Container(
                                          width:width/15.383,
                                          height:height/13.14,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black,width: 1.2),
                                          ),
                                          child: Center(child: Text(wantedlist['staus3'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),






                                    ],
                                  );
                              }
                            }

                              else if(isserach==false){
                                  if(Datecontroller.text==wantedlist['Date']){
                                   return  Row(
                                      children: [
                                        Container(
                                            width:width/30.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('${index+1}',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Order'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),

                                            ),
                                            child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/11.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['AdvanceAmount'],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
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
                                            child: Center(child: Text(wantedlist['Customer name'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['Payment'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus1'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                        Container(
                                            width:width/15.383,
                                            height:height/13.14,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black,width: 1.2),
                                            ),
                                            child: Center(child: Text(wantedlist['staus3'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),






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
                                      width:width/11.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text('${wantedlist['Date']}\n${wantedlist['time']}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/11.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(wantedlist['Order'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/11.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),

                                      ),
                                      child: Center(child: Text(wantedlist['Category'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/11.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(wantedlist['Itemname'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/15.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(wantedlist['Amount'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/15.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(wantedlist['AdvanceAmount'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/15.383,
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
                                      child: Center(child: Text(wantedlist['Customer name'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  Container(
                                      width:width/15.383,
                                      height:height/13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,width: 1.2),
                                      ),
                                      child: Center(child: Text(wantedlist['Payment'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),

                                  InkWell(
                                    onTap:(){
                                      showdialpogbox("Stutus1",wantedlist.id);
                                    },
                                    child: Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['staus1'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                  ),

                                  InkWell(
                                    onTap:(){
                                      showdialpogbox("Stutus2",wantedlist.id);
                                    },
                                    child: Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['staus2'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
                                  ),

                                  InkWell(
                                    onTap:(){
                                      showdialpogbox("Stutus3",wantedlist.id);
                                    },
                                    child: Container(
                                        width:width/15.383,
                                        height:height/13.14,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 1.2),
                                        ),
                                        child: Center(child: Text(wantedlist['staus3'],style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,),))),
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

}
