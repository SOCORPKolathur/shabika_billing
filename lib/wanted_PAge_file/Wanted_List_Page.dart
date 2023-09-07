import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';



final List<String> Type = <String>[
  "Service",
  "Accessories"
];


final List<String> Payment = <String>[
  "Payment Unpaid",
  "Payment Paid",
];

class WantedList_Page extends StatefulWidget {

  @override
  State<WantedList_Page> createState() => _WantedList_PageState();

}



class _WantedList_PageState extends State<WantedList_Page> {


   int dawer=0;

   TextEditingController Date=TextEditingController();
   TextEditingController Time=TextEditingController();

   @override
  void initState() {
     datetimefunction();
     Wantedlistfunction();
     Starusnamelist();
     Cyegorydata();
     // TODO: implement initState
    super.initState();
  }


   List <String>StatusType=[];
   List <String> StatusType2=[];
   List  <String> StatusType3=[];

  Starusnamelist()async{
     setState(() {
       StatusType.clear();
       StatusType2.clear();
       StatusType3.clear();
     });
     var document=await FirebaseFirestore.instance.collection("Wantedstatus").get();
     for(int i=0;i<document.docs.length;i++){
       setState(() {
         StatusType.add("Status-1");
         StatusType2.add("Status-2");
         StatusType3.add("Status-3");
         StatusType.add(document.docs[i]['Wantedstatus1']);
         StatusType2.add(document.docs[i]['Wantedstatus2']);
         StatusType3.add(document.docs[i]['Wantedstatus3']);
       });
     }

   }

  datetimefunction(){
    setState(() {
      Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      Time.text = DateFormat.jm().format(DateTime.now());
    });
  }

   int billcount=0;

  Wantedlistfunction() async {
    var docus1 = await FirebaseFirestore.instance.collection("Wantedlist").get();
    setState(() {
   billcount = docus1.docs.length + 1;
   Order.text = "Wl${(billcount).toString().padLeft(2, "0")}";

 });
  }

String Status1="Status-1";
String Status2="Status-2";
String Status3="Status-3";
String Paymenttype=Payment.first;
String WantedType=Type.first;

  TextEditingController Order =TextEditingController();
  TextEditingController Category =TextEditingController();
  TextEditingController Itemname =TextEditingController();
  TextEditingController Amount =TextEditingController();
  TextEditingController AdvanceAmount =TextEditingController();
  TextEditingController BalanceAmount =TextEditingController();
  TextEditingController Customername =TextEditingController();
  TextEditingController Customerphone =TextEditingController();

  clearcontroller(){
     Category  .clear();
     Itemname  .clear();
     Amount .clear();
     AdvanceAmount .clear();
     BalanceAmount .clear();
     Customername  .clear();
     Customerphone  .clear();
     Category.clear();
     setState(() {
       Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
       Time.text = DateFormat.jm().format(DateTime.now());
        Status1=StatusType.first;
        Status2=StatusType2.first;
        Status3=StatusType3.first;
        Paymenttype=Payment.first;
        WantedType=Type.first;
     });
     Wantedlistfunction();
  }

  craetefuntion(){
    FirebaseFirestore.instance.collection("Wantedlist").doc().set({
      "Date":Date.text,
      "time": DateFormat.jm().format(DateTime.now()),
      "Category":Category.text,
      "Itemname":Itemname.text,
      "Amount":Amount.text,
      "Order":Order.text,
      "AdvanceAmount":AdvanceAmount.text==""?"0":AdvanceAmount.text,
      "Balance amount":BalanceAmount.text==""?"0":BalanceAmount.text,
      "Customer name":Customername.text,
      "Customer Phone":Customerphone.text,
      "Payment":Paymenttype,
      "staus1":Status1,
      "staus2":Status2,
      "staus3":Status3,
      "WantedType":WantedType,
      "Update Person":"",
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
                         style: GoogleFonts.poppins(
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
                                       style: GoogleFonts.poppins(
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
   }

   List<String> category=[];

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
     itemadddunction();

   }
   List<String> Itemlist = [];

   itemadddunction() async {
     setState(() {
       Itemlist.clear();
     });
     if (Category.text != "") {
       var Document = await FirebaseFirestore.instance
           .collection('Item ShabikaG')
           .where("Category", isEqualTo: Category.text)
           .get();
       for (int i = 0; i < Document.docs.length; i++) {
         Itemlist.add(Document.docs[i]['Newitemname']);
       }
     }

     else {
       var Document = await FirebaseFirestore.instance.collection(
           'Item ShabikaG').get();
       for (int i = 0; i < Document.docs.length; i++) {
         Itemlist.add(Document.docs[i]['Newitemname']);
       }
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
                  "Wanted Lists",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: width / 59.39,
                      color: const Color(0xffFFFFFF)),
                ),
              ),

            ],
          ),

          Padding(
            padding: EdgeInsets.only(
                left: width / 27.947, top: height / 32.85),
            child: Row(
              children: [

                SizedBox(width: width / 91.06),
                Text("Type : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
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
                        color:dawer==1?Colors.black:Colors.white,
                        fontWeight: FontWeight.bold),
                    underline: Container(
                      color: Colors.deepPurpleAccent,
                    ),
                    iconStyleData: const IconStyleData(
                        icon:Icon(Icons.arrow_back_ios_outlined),
                        iconSize: 0
                    ),
                    onMenuStateChange: (isOpen){
                      setState(() {
                        dawer=0;
                      });
                    },

                    onChanged: (String? value) {
                      setState(() {
                        dawer=1;
                        WantedType=value!;
                      });
                    },
                    items:
                    Type.map<DropdownMenuItem<String>>(
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
                SizedBox(width: width/136.6,),

                //Date time conatainer
                Text("Date : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
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
                  Center(child:
                  Text(Date.text,style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.black),))
                ),
                SizedBox(width: width/136.6,),

                //Time container and text
                Text("Time : ",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.white),),
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
                    Center(child:
                    Text(Time.text,style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.black),))
                ),

              ],
            ),
          ),

          SizedBox(height: height/35.7,),

          Padding(
            padding:  EdgeInsets.only(left: width/303.55,right: width/303.55),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Order No",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              controller: Order,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Date",
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

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Category",
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
                                      });
                                      itemadddunction();
                                      debugPrint(
                                          'You just selected $selection');
                                    },
                                    displayStringForOption: (Value) {
                                      return Value;
                                    },
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Item Name",
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
                                    fieldViewBuilder: (context, textEditingController1,
                                        focusNode, onFieldSubmitted) {
                                      return
                                        TextFormField(
                                          onChanged: (_){
                                            setState((){
                                              Itemname=textEditingController1;
                                            });
                                          },
                                          style: GoogleFonts.montserrat(fontSize: width/91.06,fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                              EdgeInsets.only( bottom: height / 43.8,left: width/136.6)),
                                          controller: textEditingController1,
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
                                      return Itemlist.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    onSelected: (String selection) {
                                      setState(() {
                                        Itemname.text = selection;
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
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Payment",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value:Paymenttype,
                              style:GoogleFonts.montserrat(
                                  fontSize: width/113.833,
                                  fontWeight: FontWeight.bold),
                              underline: Container(
                                color: Colors.deepPurpleAccent,
                              ),
                              iconStyleData: const IconStyleData(
                                  icon:Icon(Icons.arrow_back_ios_outlined),
                                  iconSize: 0
                              ),
                              onMenuStateChange: (isOpen){
                                setState(() {
                                  dawer=5;
                                });
                              },

                              onChanged: (String? value) {
                                setState(() {
                                  dawer=5;
                                  Paymenttype=value!;
                                });
                              },
                              items:
                              Payment.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style:GoogleFonts.montserrat(
                                          fontSize: width/113.833,

                                          fontWeight: FontWeight.bold),),
                                    );
                                  }).toList(),

                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                SizedBox(height:height/32.85 ,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              controller: Amount,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                              onSubmitted: (_){
                                if(Amount.text!=""){
                                  setState((){
                                    Paymenttype="Payment Paid";
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Advance Amount",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              controller: AdvanceAmount,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                              onSubmitted: (_){
                                setState(() {
                                  BalanceAmount.text=(double.parse(Amount.text)-double.parse(AdvanceAmount.text)).toString();
                                  Paymenttype="Payment Paid";
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Balance Amount",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              controller: BalanceAmount,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Customer Name",
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

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Customer Phone",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              controller: Customerphone,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                SizedBox(height:height/32.85 ,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Status-1",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value:Status1,
                              style:GoogleFonts.montserrat(
                                  fontSize: width/113.833,
                                  fontWeight: FontWeight.bold),
                              underline: Container(
                                color: Colors.deepPurpleAccent,
                              ),
                              iconStyleData: const IconStyleData(
                                  icon:Icon(Icons.arrow_back_ios_outlined),
                                  iconSize: 0
                              ),
                              onMenuStateChange: (isOpen){
                                setState(() {
                                  dawer=2;
                                });
                              },

                              onChanged: (String? value) {
                                setState(() {
                                  dawer=2;
                                  Status1=value!;
                                });
                              },
                              items:
                              StatusType.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style:GoogleFonts.montserrat(
                                          fontSize: width/113.833,
                                          fontWeight: FontWeight.bold),),
                                    );
                                  }).toList(),

                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Status-2",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value:Status2,
                              style:GoogleFonts.montserrat(
                                  fontSize: width/113.833,
                                  fontWeight: FontWeight.bold),
                              underline: Container(
                                color: Colors.deepPurpleAccent,
                              ),
                              iconStyleData: const IconStyleData(
                                  icon:Icon(Icons.arrow_back_ios_outlined),
                                  iconSize: 0
                              ),
                              onMenuStateChange: (isOpen){
                                setState(() {
                                  dawer=3;
                                });
                              },

                              onChanged: (String? value) {
                                setState(() {
                                  dawer=3;
                                  Status2=value!;
                                });
                              },
                              items:
                              StatusType2.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style:GoogleFonts.montserrat(
                                          fontSize: width/113.833,
                                          fontWeight: FontWeight.bold),),
                                    );
                                  }).toList(),

                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Status-3",
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
                            height: height / 13.14,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value:Status3,
                              style:GoogleFonts.montserrat(
                                  fontSize: width/113.833,
                                  fontWeight: FontWeight.bold),
                              underline: Container(
                                color: Colors.deepPurpleAccent,
                              ),
                              iconStyleData: const IconStyleData(
                                  icon:Icon(Icons.arrow_back_ios_outlined),
                                  iconSize: 0
                              ),
                              onMenuStateChange: (isOpen){
                                setState(() {
                                  dawer=4;
                                });
                              },

                              onChanged: (String? value) {
                                setState(() {
                                  dawer=4;
                                  Status3=value!;
                                });
                              },
                              items:
                              StatusType3.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style:GoogleFonts.montserrat(
                                          fontSize: width/113.833,
                                          fontWeight: FontWeight.bold),),
                                    );
                                  }).toList(),

                            ),
                          ),
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "",
                              style: GoogleFonts.poppins(
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: height / 136.6,
                        ),
                        SizedBox(
                          height: height / 13.14,
                          width: width / 6.83,
                        )
                      ],
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "",
                              style: GoogleFonts.poppins(
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: height / 136.6,
                        ),
                        SizedBox(
                          height: height / 13.14,
                          width: width / 6.83,

                        )
                      ],
                    ),


                  ],
                ),
                SizedBox(height:height/32.85 ,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width:width/ 22.76),

                    //save invoive button
                    InkWell(
                      onTap: () {
                        craetefuntion();
                        Savebillpopup();
                        Future.delayed(const Duration(milliseconds: 100),(){
                          clearcontroller();
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
                              GoogleFonts.poppins(color: Colors.white),
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
                              GoogleFonts.poppins(color: Colors.white),
                            )),
                      ),
                    ),



                  ],
                )

              ],
            ),
          ),





        ],
      );
  }
}
