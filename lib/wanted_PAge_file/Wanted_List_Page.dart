import 'dart:html';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';



final List<String> Type = <String>[
  "Service",
  "Accessories"
];

const List<String> Paymentmode3 = <String>['Please Select', "G pay", "Cash","Paytm","Phonepe","Card"];


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
   TextEditingController image=TextEditingController();
   String imageurl="";
   selectimage1(){
     setState(() {
       image.text="Loading...";
     });
     InputElement input =
     FileUploadInputElement()
     as InputElement
       ..accept = 'image/*';
     FirebaseStorage fs =
         FirebaseStorage
             .instance;
     input.click();
     input.onChange
         .listen(
             (event) {
           final file = input
               .files!.first;
           final reader =
           FileReader();
           reader.readAsDataUrl(file);
           reader.onLoadEnd.listen(
                   (event) async {
                 var snapshot = await fs.ref().child('ImageLIst').child(file.name).putBlob(file);
                 String downloadUrl = await snapshot.ref.getDownloadURL();
                 setState(() {
                   image.text=file.name;
                   imageurl=downloadUrl;
                 });

               });
         });
   }
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
   String Payments2 = Paymentmode3.first;
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
     image.clear();
     setState(() {
       imageurl="";
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
      "Amount2":"0.00",
      "imageurl":imageurl,
      "paymentmode":Payments2,
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

            /*  Padding(
                padding: EdgeInsets.only(
                    left: width / 27.947, top: height / 32.85),
                child: Text(
                  "Wanted Lists",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: width / 59.39,
                      color: const Color(0xffFFFFFF)),
                ),
              ),*/

            ],
          ),

          Padding(
            padding: EdgeInsets.only(
                left: width/303.55, top: height / 32.85),
            child: Row(
              children: [

                SizedBox(width: width / 20.06),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type : ",style: GoogleFonts.openSans(color: Colors.white),),
                    SizedBox(
                      height: height / 136.6,
                    ),
                    Container(
                      width: width / 6.83,
                      height: height / 18.9,
                      //color:Colors.white,
                      decoration:  BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child:
                      DropdownButton2<String>(
                        value: WantedType,
                        style:GoogleFonts.openSans(
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
                                child: Text(value,style:GoogleFonts.openSans(
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

                SizedBox(
                  width: width / 18.83,
                ),

                //Date time conatainer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date : ",style: GoogleFonts.openSans(color: Colors.white),),
                    SizedBox(
                      height: height / 136.6,
                    ),
                    Container(
                        width: width / 6.83,
                        height: height / 18.9,
                        //color:Colors.white,
                        decoration:  BoxDecoration(
                            color:  Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:
                        Center(child:
                        Text(Date.text,style: GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.black),))
                    ),
                  ],
                ),

                SizedBox(
                  width: width / 18.83,
                ),

                //Time container and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Time : ",style: GoogleFonts.openSans(color: Colors.white),),
                    SizedBox(
                      height: height / 136.6,
                    ),
                    Container(
                        width: width / 6.83,
                        height: height / 18.9,
                        //color:Colors.white,
                        decoration:  BoxDecoration(
                            color:  Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:
                        Center(child:
                        Text(Time.text,style: GoogleFonts.openSans(fontWeight: FontWeight.w700,color: Colors.black),))
                    ),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [



                    SizedBox(
                      width: width / 20.83,
                    ),

                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Category",
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
                            height: height / 18.9,
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
                                          style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w500),
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
                    SizedBox(
                      width: width / 18.83,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Item Name",
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
                          height: height / 18.9,
                            width: width / 1.83,
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
                                          style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w500),
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
                    SizedBox(
                      width: width / 18.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.95,
                            child: Text(
                              "Item Image",
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
                            height: height / 18.9,
                            width: width / 6.95,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child: TextField(
                              onTap: (){
                                selectimage1();
                              },
                            controller: image,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130.6)),
                            )
                          ),
                        )
                      ],
                    ),



                  ],
                ),
                SizedBox(height:height/32.85 ,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 20.83,
                    ),
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
                          height: height / 18.9,
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
                               /* if(Amount.text!=""){
                                  setState((){
                                    Paymenttype="Payment Paid";
                                  });*/

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: width / 18.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Advance Amount",
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
                          height: height / 18.9,
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
                                  if((double.parse(Amount.text)-double.parse(AdvanceAmount.text))==0){
                                    setState(() {
                                      Paymenttype="Payment Paid";
                                    });
                                  }
                                  else{
                                    setState(() {
                                      Paymenttype="Payment Unpaid";
                                    });
                                  }


                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: width / 18.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Balance Amount",
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
                          height: height / 18.9,
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
                    SizedBox(
                      width: width / 18.83,
                    ),
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
                          height: height / 18.9,
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
                      width: width / 18.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Customer Phone",
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
                          height: height / 18.9,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 20.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Payment",
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
                            height: height / 18.9,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value: Payments2,
                              isExpanded: true,
                              style: GoogleFonts.openSans(
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
                        )
                      ],
                    ),
                    SizedBox(
                      width: width / 18.83,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "Status-1",
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
                          height: height / 18.9,
                            width: width / 6.83,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(6),
                                color: Colors.white),
                            child:
                            DropdownButton2<String>(
                              value:Status1,
                              style:GoogleFonts.openSans(
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
                                      child: Text(value,style:GoogleFonts.openSans(
                                          fontSize: width/113.833,
                                          fontWeight: FontWeight.bold),),
                                    );
                                  }).toList(),

                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      width: width / 18.83,
                    ),


                    Column(
                      children: [
                        SizedBox(
                            width: width / 6.83,
                            child: Text(
                              "",
                              style: GoogleFonts.openSans(
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: height / 136.6,
                        ),
                        SizedBox(
                        height: height / 18.9,
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
                              style: GoogleFonts.openSans(
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: height / 136.6,
                        ),
                        SizedBox(
                        height: height / 18.9,
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
                              style: GoogleFonts.openSans(
                                  color: Colors.white),
                            )),
                        SizedBox(
                          height: height / 136.6,
                        ),
                        SizedBox(
                        height: height / 18.9,
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
                          color:   Colors.green
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




                  ],
                )

              ],
            ),
          ),





        ],
      );
  }
}
