import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';


class Simacard_Operator_Page extends StatefulWidget {
  const Simacard_Operator_Page({Key? key}) : super(key: key);

  @override
  State<Simacard_Operator_Page> createState() => _Simacard_Operator_PageState();
}

class _Simacard_Operator_PageState extends State<Simacard_Operator_Page> {



  @override
  void initState() {
    Billnofunction();
    Operatorsaddfunction();
    // TODO: implement initState
    super.initState();
  }
  int billcount=0;

  Billnofunction() async {

      var docus1 = await FirebaseFirestore.instance.collection("Simcard").get();
      setState(() {
        billcount = docus1.docs.length + 1;
        total=0;
        Billno.text = "SMI${(billcount).toString().padLeft(2, "0")}";
        Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
        Quvantity.text="1";
        Rate.text="0";
      });

  }

  //controllers
  TextEditingController Billno=TextEditingController();
  TextEditingController Date=TextEditingController();
  TextEditingController Quvantity=TextEditingController();
  TextEditingController Operatorname=TextEditingController();
  TextEditingController Rate=TextEditingController();
  TextEditingController Mobileno=TextEditingController();
  TextEditingController Customername=TextEditingController();
  TextEditingController Totalamount=TextEditingController();


  //controller clear function
  Clearcontroller(){
     Quvantity.clear();
     Operatorname.clear();
     Rate.clear();
     Mobileno.clear();
     Customername.clear();
     Totalamount.clear();
  }

  createdocumentfunction(){
    FirebaseFirestore.instance.collection("Simcard").doc().set({
      "billno":Billno.text,
      "Date":Date.text,
      "time": DateFormat.jm().format(DateTime.now()),
      "Quvantity":Quvantity.text,
      "Operator name":Operatorname.text,
      "Rate":Rate.text,
      "Mobileno":Mobileno.text,
      "Customer name":Customername.text,
      "Totalamount":Totalamount.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
  }


  //"Save bill message"
  Savebillpopup() {
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
                backgroundColor: const Color(0xff264656),
                content: SizedBox(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 99.85,
                      ),
                      Text(
                        "Save Succesfully..",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),

                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
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
                                height: height / 16.425,
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
                                      style: GoogleFonts.openSans(
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
  }

  double total=0;
  bool isserach=false;
  bool categoryclick=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();


  List<String> Operators=[];

  Operatorsaddfunction() async {
    setState(() {
      Operators.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('Operator').orderBy("timestamp", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      Operators.add(Document.docs[i]['Operatorname']);
    }

  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return

      Column(
      children: [
        SizedBox(height: height/20.8,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: width / 91.06),



            Padding(
              padding: EdgeInsets.only(
                  left: width / 27.947, top: height / 32.85),
              child: Text(
                "SimCard Opeartor",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: width / 59.39,
                    color: const Color(0xffFFFFFF)),
              ),
            ),

          ],
        ),


        Padding(
          padding: EdgeInsets.only(top: height / 131.4, left: width / 22.32),
          child: Row(

            children: [

              //Bill no
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Bill No",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Billno,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),

              //Date
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Date/Time",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Date,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),
              //Operator
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Operator Name",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
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
                                if(textEditingValue.text !=""){
                                  setState(() {
                                    Operatorname.text=textEditingValue.text;
                                  });
                                }

                                return Operators.where((String option) {
                                  return option.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                setState(() {
                                  Operatorname.text=selection;
                                });

                              },
                              displayStringForOption: (Value) {
                                return Value;
                              },
                            ),
                      )

                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),
              //Rate
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Rate",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Rate,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),

                        onSubmitted: (_){
                          if(Rate.text!="0"){
                            setState(() {
                              Totalamount.text=(double.parse(Rate.text)*double.parse(Quvantity.text)).toString();
                              total= double.parse(Totalamount.text);
                            });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
         SizedBox(height: height/43.8,),

        Padding(
          padding: EdgeInsets.only(top: height / 131.4, left: width / 22.32),
          child: Row(

            children: [
              //Quantity
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Quantity",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Quvantity,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                        onSubmitted: (_){
                          if(Rate.text!="0"){
                            setState(() {
                              Totalamount.text=(double.parse(Rate.text)*double.parse(Quvantity.text)).toString();
                              total= double.parse(Totalamount.text);
                            });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),

              //Mobile No
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Mobile No",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Mobileno,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),

              //Customer Name
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Customer Name",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Customername,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                width: width / 20.6,
              ),

              //Amount
              Column(
                children: [
                  SizedBox(
                      width: width / 6.83,
                      child: Text(
                        "Amount",
                        style: GoogleFonts.openSans(
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
                      height: height / 13.14,
                      width: width / 6.83,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: Colors.white),
                      child: TextField(
                        controller: Totalamount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 130.6)),
                        onSubmitted: (_){
                         setState(() {
                           total= double.parse(Totalamount.text);
                         });
                        },

                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
         SizedBox(height: height/3.8,),

        Padding(
          padding: EdgeInsets.only(top: height / 131.4,),
          child: Material(
            elevation: 50,
            shadowColor: Colors.black38,
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: width / 1.093,
              height: height / 6.14,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 70.83,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width / 250.888),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            //save invoive button
                            InkWell(
                              onTap: () {
                                createdocumentfunction();
                                Billnofunction();
                                Savebillpopup();
                                Future.delayed(const Duration(milliseconds: 100),(){
                                  Clearcontroller();
                                });
                              },
                              child: Container(
                                width: width / 8.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:  const Color(0xff013220),
                                ),
                                child: Center(
                                    child: Text(
                                      "Save",
                                      style:
                                      GoogleFonts.openSans(color: Colors.white),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: width / 70.83,
                            ),
                            //Print Invoice button
                            InkWell(
                              onTap:(){},
                              child: Container(
                                width: width / 8.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff0079FF),
                                ),
                                child: Center(
                                    child: Text(
                                      "Print",
                                      style:
                                      GoogleFonts.openSans(color: Colors.white),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: width / 2.83,
                            ),

                            //Total
                            SizedBox(
                                width: width / 10.5,
                                height:height/13.14,

                                child: Center(
                                  child: Text(
                                    "Total : ",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff00A99D),
                                        fontSize: width / 40.88),
                                  ),
                                )),
                            Container(
                                width: width / 5.5,
                                height:height/13.14,
                                decoration: BoxDecoration(
                                    color:  const Color(0xff00A99D),
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    total.toStringAsFixed(2),
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: width / 40.88),
                                  ),
                                )),


                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        )

      ],
    );
  }



  GlobalKey key1=GlobalKey();
  Widget textfield1(FocusNode focusNode, TextEditingController textEditingController, onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      TextFormField(
        key:key1 ,
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.only(  left: width / 130.6)),
      controller: Operatorname,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }

}
