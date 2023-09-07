import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ReplaceMent_Page extends StatefulWidget {
  const ReplaceMent_Page({Key? key}) : super(key: key);

  @override
  State<ReplaceMent_Page> createState() => _ReplaceMent_PageState();
}

const List<String> list3 = <String>[
  "GST",
  "IGST",
];

class _ReplaceMent_PageState extends State<ReplaceMent_Page> {


TextEditingController customername=TextEditingController();
TextEditingController customeraddress=TextEditingController();
TextEditingController customerphone=TextEditingController();
TextEditingController purchase_Date=TextEditingController();
TextEditingController purchase_notes=TextEditingController();
TextEditingController purchase_No=TextEditingController();
TextEditingController Creadit_days=TextEditingController();
TextEditingController _typeAheadControllergender9=TextEditingController();
TextEditingController Box_NO=TextEditingController();
TextEditingController HSN_Code=TextEditingController();
TextEditingController taxitem=TextEditingController();
TextEditingController without_tax=TextEditingController();
TextEditingController Stocks=TextEditingController();
TextEditingController Qty=TextEditingController();
TextEditingController itemid=TextEditingController();
TextEditingController Sales=TextEditingController();
TextEditingController Itemname=TextEditingController();


   String returnid='';
  String dropdownValue3 = list3.first;

  getvalues(code)async{
    print("dgfdgfdgdfgfdgfdgfdg");
    var document=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo: true).get();
    for(int i=0;i<document.docs.length;i++){
      if(code==document.docs[i]['purchaseno']){
        if (mounted) {
          setState(()  {
            purchase_Date.text=document.docs[i]['date'].toString();
            purchase_No.text=document.docs[i]['purchaseno'].toString();
            customerphone.text=document.docs[i]['customerphone'].toString();
            customeraddress.text=document.docs[i]['customeraddress'].toString();
            customername.text=document.docs[i]['customername'].toString();
            returnid=document.docs[i].id;
          });
          print(returnid);
          print("function finish");
        }
      }

    }
  }

  List <String>billno=[];

  List <String>Suppier=[];

  billnoaddfuncxtion() async {
  setState(() {
    billno.clear();
    Suppier.clear();
  });
  var document=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo: true).get();
  for(int i=0;i<document.docs.length;i++){
    billno.add(document.docs[i]['purchaseno']);
  }
  var document2=await FirebaseFirestore.instance.collection("Supplier").orderBy("timestamp").get();
  for(int j=0;j<document2.docs.length;j++){
    Suppier.add(document2.docs[j]['Suppliername']);
  }

}


  final TextEditingController _typeAheadControllergender15 = TextEditingController();

  SuggestionsBoxController suggestionBoxController15 = SuggestionsBoxController();

  SuggestionsBoxController suggestionBoxController9 = SuggestionsBoxController();

   List<String> getSuggestionsgender15(String query) {
  List<String> matches = <String>[];
  matches.addAll(billno);
  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}

   List<String> getSippier(String query) {
  List<String> matches = <String>[];
  matches.addAll(Suppier);
  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}


List<bool> Selected = List.generate(1000, (index) => false);

   @override
  void initState() {
    // TODO: implement initState
     billnoaddfuncxtion();
  }

  bool checkboxvalue=false;

   String Itemnamevalue='';
   String HsnCode="";
   String ItemCode="";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            //entry type container
            SizedBox(
              height: height / 5.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Customer Phone
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Customer Phone",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 43.0,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child:
                          TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff000000)),
                            controller:customerphone,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: width /220.78,
                                    bottom: height / 83.8)
                            ),

                          )
                        ),

                      ],
                    ),
                  ),

                  //Customer name
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Customer Name",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 41.39,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff000000)),
                            controller: customername,
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

                  //Customer Address
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Customer Address",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 75.88,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child:
                          TextField(
                            controller: customeraddress,
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff000000)),
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


                  //tax type
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Tax Type",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 15.701,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton2<String>(
                                  value: dropdownValue3,
                                  isExpanded: true,
                                  isDense: true,
                                  alignment: Alignment.topCenter,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 105.07),
                                  underline: Container(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue3 = value!;
                                    });

                                  },
                                  items: list3.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
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

            //entry type container-2
            SizedBox(
              height: height / 5.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Bill No
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Bill No",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 17.74,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child:  TypeAheadFormField(
                            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                color: Color(0xffDDDEEE),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                )),
                            textFieldConfiguration: TextFieldConfiguration(
                              onSubmitted: (_){
                                getvalues(_typeAheadControllergender15.text);
                              },
                              style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    bottom: height / 83.8
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _typeAheadControllergender15,
                            ),
                            suggestionsCallback: (pattern) {
                              return getSuggestionsgender15(pattern);
                            },
                            itemBuilder: (context, String suggestion) {
                              return ListTile(
                                title: Text(suggestion,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700),),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (String suggestion) {
                              getvalues(suggestion);
                              setState((){
                                purchase_No.text=suggestion;
                                _typeAheadControllergender15.text=suggestion;
                              });
                            },
                            suggestionsBoxController: suggestionBoxController15,
                            validator: (value) => value!.isEmpty
                                ? 'Please select a academic year'
                                : null,
                          ),


                        ),

                      ],
                    ),
                  ),

                  //Purchase  Date
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Purchase  Date",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 105.07,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff000000)),
                            controller: purchase_Date,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    top: height / 83.8),
                                border: InputBorder.none,
                                suffixIcon: const Icon(Icons.calendar_month)),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  purchase_Date.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),


                  //suppier name
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Supplier Name",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 100.74,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child:  TypeAheadFormField(
                            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                                color: Color(0xffDDDEEE),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                )),
                            textFieldConfiguration: TextFieldConfiguration(
                              style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    bottom: height / 83.8
                                ),
                                border: InputBorder.none,
                              ),
                              controller: _typeAheadControllergender9,
                            ),
                            suggestionsCallback: (pattern) {
                              return getSippier(pattern);
                            },
                            itemBuilder: (context, String suggestion) {
                              return ListTile(
                                title: Text(suggestion,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700),),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (String suggestion) {
                              setState((){
                                _typeAheadControllergender9.text=suggestion;
                              });
                            },
                            suggestionsBoxController: suggestionBoxController9,
                            validator: (value) => value!.isEmpty
                                ? 'Please select a academic year'
                                : null,
                          ),


                        ),

                      ],
                    ),
                  ),

                  //Remarks
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 328.5, left: width / 273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 273.2,
                        ),
                        Text(
                          "Remarks",
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width / 24.0,
                        ),
                        Container(
                          width: width / 3.415,
                          height: height / 21.9,
                          //color:Colors.white,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.571,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff000000)),
                            controller: purchase_notes,

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

                ],
              ),
            )
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Material(
              elevation: 50,
              shadowColor: Colors.black38,
              color: const Color(0xff7d99ab),
              child: Container(
                width: width / 0.976,
                height: height / 16.425,
                decoration: const BoxDecoration(
                  color: Color(0xff7d99ab),
                ),
                child: Row(
                  children: [
                    //Serial no
                    SizedBox(
                      width: width / 45.533,
                      child:
                      Center(
                          child: Text(
                            "Si No",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    //itemid
                    SizedBox(
                      width: width / 14.2,
                      child: Center(
                          child: Text(
                            "Item ID",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    //itemname
                    SizedBox(
                      width: width / 2.9,
                      child: Center(
                          child: Text(
                            "Item Name",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    SizedBox(width: width / 28.76),

                    //Box No
                    SizedBox(
                      width: width / 16.7,
                      child: Center(
                          child: Text(
                            "Box No",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),


                    //Hsn Code
                    SizedBox(
                      width: width / 17.8,
                      child: Center(
                          child: Text(
                            "HSN Code",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    //tax
                    SizedBox(
                      width: width / 16.18,
                      child: Center(
                          child: Text(
                            "Tax %",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),


                    //quvantity
                    SizedBox(
                      width: width / 15.18,
                      child: Center(
                          child: Text(
                            "Qnty",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),



                    //withou Tax
                    SizedBox(
                      width: width / 15.18,
                      child: Center(
                          child: Text(
                            "Price",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),



                    //Sales Price
                    SizedBox(
                      width: width / 14.0,
                      child: Center(
                          child: Text(
                            "Sales Price",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    //Stocks
                    SizedBox(
                      width: width / 15.0,
                      child: Center(
                          child: Text(
                            "Stocks",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    //Clear controllers
                    SizedBox(
                      width: width / 13.18,
                      child: Center(
                          child: Text(
                            "Clear ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: width / 0.976,
              decoration: const BoxDecoration(
                color: Color(0xffb7b0aa),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Serial no
                  Container(
                    width: width / 45.533,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),

                  ),

                  //itemid
                  Container(
                    width: width / 14.2,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child:
                    TextField(
                      controller: itemid,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),

                    ),
                  ),

                  //itemname
                  Container(
                    width: width / 2.7,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child:


                    Padding(
                      padding:  EdgeInsets.only(left:width/130,right: width/170,bottom:height/65.7),
                      child:
                      TextField(
                        controller: Itemname,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: width / 136.6, bottom: height / 65.7),
                        ),

                      ),
                    ),

                  ),

                  //Box No
                  Container(
                    width: width / 14.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: Box_NO,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                      onSubmitted: (_) {},
                    ),
                  ),

                  //Hsn Code
                  Container(
                    width: width / 14.9,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: HSN_Code,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                    ),
                  ),

                  //tax
                  Container(
                    width: width / 16.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: taxitem,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                    ),
                  ),

                  //quvantity
                  Container(
                    width: width / 16.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: Qty,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                      onSubmitted: (_) {

                      },
                      onTap: (){

                      },
                      onChanged: (_) {

                      },
                    ),
                  ),

                  // Price(without Tax)
                  Container(
                    width: width / 13.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: without_tax,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                    ),
                  ),


                  //Sales Price
                  Container(
                    width: width / 13.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: Sales,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),

                    ),
                  ),

                  //Stocks
                  Container(
                    width: width / 15.3,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: Stocks,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                    ),
                  ),

                  //Clear controllers
                  Container(
                      width: width / 14.0,
                      height: height / 21.9,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black, width: 0.6)),
                      child: Center(
                        child: InkWell(
                          onTap: () {

                          },
                          child: const Icon(Icons.delete),
                        ),
                      )),

                ],
              ),
            ),

            SizedBox(
              height: height / 164.25,
            ),

          ],
        ),

       Material(
          elevation: 50,
          shadowColor: Colors.black38,
          color: const Color(0xffFFFFFF),
          child: Container(
            width: width / 0.976,
            height: height / 2.6,
            decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
            ),
            child:
             returnid!=""?
              StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("billing").doc(returnid).collection(returnid)
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var billing = snapshot.data!.docs[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: height / 164.25),
                      child: Row(
                        children: [

                          //Serial no
                          SizedBox(
                            width: width / 45.533,
                            height: height / 16.425,
                            child:   Checkbox(
                                value:Selected[index] ,
                                onChanged:(_) async {
                                  setState((){
                                    Selected[index]=!Selected[index];
                                    checkboxvalue=true;
                                  });
                                  for (int i=0;i<Selected.length;i++){

                                    if(Selected[i]==true){

                                      if(i==index){
                                        var document=await FirebaseFirestore.instance.collection("billing").
                                        doc(returnid).collection(returnid).doc(billing.id).get();
                                        Map<String,dynamic>?values=document.data();
                                        setState(() {
                                          Selected[i]=true;
                                          checkboxvalue=true;
                                          Itemnamevalue=values!["Item"];
                                          HsnCode=values["Hsncode"];
                                          ItemCode=values["itemcode"];

                                        });
                                        print("ITem selected okay");
                                        print(Itemnamevalue);
                                        print(ItemCode);
                                        print(HsnCode);
                                      }
                                      else{
                                        setState(() {
                                          Selected[i]=false;
                                          Itemnamevalue='';
                                          HsnCode='';
                                          ItemCode='';
                                          checkboxvalue=false;
                                        });
                                      }
                                    }
                                  }
                                } ),),

                          //itemid
                          SizedBox(
                              width: width / 14.2,
                              height: height / 16.425,
                              child: Center(
                                  child: Text("${billing['itemcode']}"))),

                          //itemname
                          SizedBox(
                              width: width / 2.7,
                              child: Text(
                                '${billing['Description']},',
                                textAlign: TextAlign.left,
                              )),



                          SizedBox(
                            width: width / 13.32,
                          ),

                          //Hsn code
                          SizedBox(
                              width: width / 15.9,
                              height: height / 16.425,
                              child: Center(child: Text(billing['Hsncode']))),

                          //tax
                          SizedBox(
                              width: width / 20.8,
                              height: height / 16.425,
                              child: Center(child: Text(billing['tax']))),

                          //quvantity
                          SizedBox(
                              width: width / 18.8,
                              height: height / 16.425,
                              child: Center(
                                  child: Text(billing['Qty'].toString()))),

                          // Price
                          SizedBox(
                              width: width / 11.18,
                              height: height / 16.425,
                              child: Center(
                                  child: Text(
                                      billing['withouttaxprice'].toString()))),

                          //Sales Price
                          SizedBox(
                              width: width / 11.18,
                              height: height / 16.425,
                              child: Center(
                                  child:
                                  Text(billing['Sales price'].toString()))),


                          SizedBox(
                            width: width / 23.32,
                          ),

                          //remove
                          SizedBox(
                              width: width / 14.0,
                              height: height / 16.425,
                              child: Center(
                                child: InkWell(
                                  onTap: () {

                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                );
              },
            ):
        const SizedBox(),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: height / 30.4, right: width / 27.32),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {

                  documentctreatedunctiuon();
                  Savebillpopup();
                },
                child: Container(
                  width: width / 6.6,
                  height: height / 12.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:  const Color(0xff013220),
                  ),
                  child: Center(
                      child: Text(
                        "Update Invoice",
                        style:
                        GoogleFonts.poppins(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }


  documentctreatedunctiuon(){
     FirebaseFirestore.instance.collection("Replacement").doc().set({
       "Bill No":purchase_No.text,
       "Customername":customername.text,
       "Customerphone":customerphone.text,
       "CustomerAddress":customeraddress.text,
       "Suppliername":_typeAheadControllergender9.text,
       "Purchasedate":purchase_Date.text,
       "Itemname":Itemnamevalue,
       "itemhsncode":HsnCode,
       "Itemcode":ItemCode,
       "Status":"Ordered",
       "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
       "timestamp":DateTime.now().millisecondsSinceEpoch,
     });

  }

  ///save bill popup
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
                      "Save Replace Bill Successfully..",
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
                        SizedBox(width: width / 68.3),
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

}
