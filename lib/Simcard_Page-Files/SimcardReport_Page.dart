import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimcardReport_Page extends StatefulWidget {
  const SimcardReport_Page({Key? key}) : super(key: key);

  @override
  State<SimcardReport_Page> createState() => _SimcardReport_PageState();
}

class _SimcardReport_PageState extends State<SimcardReport_Page> {

  @override
  void initState() {
    totalprofit();
    operatornamelist();
    // TODO: implement initState
    super.initState();
  }

  int profit=0;
  int totalprofits=0;

  totalprofit()async{
    setState(() {
      profit=0;
      totalprofits=0;
    });
    if(Serachcontroller.text!=""){
      var profits=await FirebaseFirestore.instance.collection("Simcard").where("Operator name",isEqualTo:Serachcontroller.text ).get();
      for(int i=0;i<profits.docs.length;i++){
        setState(() {
          profit=profit+int.parse(profits.docs[i]['Quvantity'].toString());
          totalprofits=profit*100;
        });
      }
    }
    else{
      var profits2=await FirebaseFirestore.instance.collection("Simcard").get();
      for(int i=0;i<profits2.docs.length;i++){
        setState(() {
          profit=profit+int.parse(profits2.docs[i]['Quvantity'].toString());
          totalprofits=profit*100;
        });
      }
      FirebaseFirestore.instance.collection("Accounts").doc("AxQxYGPKUB5qGzllyfpY").update({
        "Totalamount":FieldValue.increment(int.parse(totalprofits .toString()))
      });
    }
  }

  TextEditingController Serachcontroller=TextEditingController();
  bool isserach=false;
  String Username='';
  
  List <String>Operatorlist=[];
  
  operatornamelist()async{
    setState(() {
      Operatorlist.clear();
    });
    var document=await FirebaseFirestore.instance.collection("Operator").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        Operatorlist.add(document.docs[i]['Operatorname']);
      });
    }

  }
  
  totalamountsorfunction(){
    
  }
  
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
                child: Text("Simcard Reports",
                  style: GoogleFonts.openSans(color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: width/54.64),),
              ),
              SizedBox(width: width/9.106,),

              Text("Sort by Operator :",style: GoogleFonts.openSans(color: Colors.white,
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
                        initialValue: const TextEditingValue(
                          selection: TextSelection(
                            isDirectional: true,
                            baseOffset: 10,
                            extentOffset: 1,
                          ),
                        ),
                        fieldViewBuilder: (context, Controller,
                            focusNode, onFieldSubmitted) {

                          return  TextFormField(
                            textDirection:TextDirection.ltr,
                            onChanged: (_){
                              setState((){
                                Serachcontroller=Controller ;
                              });
                            },
                            style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(  left: width / 130.6),
                                border: InputBorder.none,),
                            controller: Controller,
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
                          return Operatorlist.where((String option) {
                            return option.toLowerCase().contains(
                                textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          setState(() {
                            Serachcontroller.text=selection;
                            isserach=true;
                          });
                          totalprofit();

                        },
                        displayStringForOption: (Value) {
                          return Value;
                        },
                      ),
                )


              ),
              SizedBox(width: width/136.6,),

              InkWell(
                onTap: (){
                 setState(() {
                   Serachcontroller.clear();
                   isserach=false;
                   Username='';
                 });
                 totalprofit();
                },
                child: Container(
                  height: height/16.425,
                  width: width/13.66,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),color:Colors.white
                ),
                child:  Center(
                  child: Text("Clear",style: GoogleFonts.openSans(color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: width/84.64),),
                ),
                ),
              ),
              const SizedBox(width: 10,),

              Text("Total Profits:",style: GoogleFonts.openSans(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/84.64),),
              const SizedBox(width: 10,),
              Container(
                  height: height/16.425,
                  width: width/13.66,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child:Text(totalprofits.toStringAsFixed(2),style: GoogleFonts.openSans(color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: width/84.64),),),
              ),
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
            child:  Column(
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
                          child: Center(child: Text('Si No',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/11.383,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Date',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/11.383,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Time',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/15.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),

                          ),
                          child: Center(child: Text('Bill No',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/7.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Customer name',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/8.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Mobile No',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/5.0,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Operator Name',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/23.588,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),

                          ),
                          child: Center(child: Text('Qty',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/11.5,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Rate',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),

                      Container(
                          width:width/11.5,
                          height:height/13.14,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1.2),
                          ),
                          child: Center(child: Text('Amount',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color(0xff5801e8)),))),




                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width/273.2),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Simcard").orderBy("timestamp",descending: true).snapshots(),
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

                          var Simacrd=snapshot.data!.docs[index];
                          if(isserach==true&&Serachcontroller.text==Simacrd['Operator name']){
                            return
                              Row(
                              children: [
                                Container(
                                    width:width/30.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:Text("${index+1}",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/11.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Date"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    )
                                    )
                                ),

                                Container(
                                    width:width/11.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["time"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/15.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child:
                                    Text(Simacrd["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/7.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Customer name"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/8.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Mobileno"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/5.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Operator name"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/23.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(Simacrd['Quvantity'],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/11.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(
                                        child:
                                        Text(Simacrd["Rate"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                        ))),

                                Container(
                                    width:width/11.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Totalamount"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                              ],
                            );
                          }
                          else if(isserach==false&&Serachcontroller.text!=Simacrd['Operator name']){
                            return Row(
                              children: [
                                Container(
                                    width:width/30.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:Text("${index+1}",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/11.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Date"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    )
                                    )
                                ),

                                Container(
                                    width:width/11.383,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["time"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/15.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child:
                                    Text(Simacrd["billno"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/7.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Customer name"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/8.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Mobileno"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/5.0,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Operator name"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),

                                Container(
                                    width:width/23.588,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),

                                    ),
                                    child: Center(child: Text(Simacrd['Quvantity'],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.black),))),

                                Container(
                                    width:width/11.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(
                                        child:
                                        Text(Simacrd["Rate"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                        ))),

                                Container(
                                    width:width/11.5,
                                    height:height/13.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black,width: 1.2),
                                    ),
                                    child: Center(child:
                                    Text(Simacrd["Totalamount"],style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color:Colors.black),
                                    ))),




                              ],
                            );
                          }

                          return const SizedBox(


                          );

                        },);
                    },
                  ),
                )
              ],
            )
          ),
        ],
      );

  }
}
