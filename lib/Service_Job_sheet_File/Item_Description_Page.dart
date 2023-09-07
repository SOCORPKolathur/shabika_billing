import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';

class Item_Description_Page extends StatefulWidget {
  const Item_Description_Page({Key? key}) : super(key: key);

  @override
  State<Item_Description_Page> createState() => _Item_Description_PageState();
}

class _Item_Description_PageState extends State<Item_Description_Page> {


  List<String> categorylist = <String>[];

  categoryaddfunction() async {
    setState(() {
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('category').orderBy("categoryname", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
  }

  double total=0;
  bool isserach=false;
  bool categoryclick=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController Operator1=TextEditingController();
  TextEditingController Operator2=TextEditingController();
  TextEditingController Operator3=TextEditingController();


  @override
  void initState() {
    categoryaddfunction();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return categoryclick==false?
    Column(
      children: [
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left:width/48.785, top: height/32.85),
              child: Text(
                "Items",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize:width/59.391,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: width/13.66,
            ),
            Padding(
              padding:  EdgeInsets.only(left: width/1.355, top: height/21.9),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  drawer(" "),
                  ));
                },
                child: Container(
                  width: width / 11.38,
                  height: height / 16.42,
                  // color: Color(0xff00A99D),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff00A99D),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left:width/170.75, right: width/170.75),
                        child: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom:height/136.6),
                        child: Text(
                          "Home",
                          style: GoogleFonts.cairo(
                              color: const Color(0xffFFFFFF), fontSize:width/59.391),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/75.888,vertical: height/36.5),
          child: Image.asset("assets/Line13.png"),
        ),
        Padding(
          padding:  EdgeInsets.only(left: width/27.32),
          child: Row(
            children: [
              Text("Search",
                  style: GoogleFonts.cairo(
                      fontSize: width/68.3, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/28.458, right: width/34.15),
              child: Container(
                width: width/3.415,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffFFFFFF),
                ),
                child:
                TextField(
                  controller: Serachcontroller,
                  style: GoogleFonts.poppins(fontSize: width/68.3,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.only(left: width/68.3, top:width/102.125,bottom:width/102.125),
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      )),
                  onTap: (){
                    setState(() {
                      isserach=true;
                    });
                  },
                  onChanged: (value){
                    if(Serachcontroller.text==""){
                      setState(() {
                        isserach=false;
                      });
                    }
                    else{
                      setState(() {
                        isserach=true;
                      });
                    }
                    setState(() {
                      Username=value;
                    });
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  categoryclick = true;
                });
              },
              child: Container(
                width: width / 5.46,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff00A99D),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                top: height/657, left: width/136.6, right: width/91.06),
                            child: Container(
                              width: width / 56.91,
                              height: height / 27.37,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.add, color: Colors.teal),
                            ),
                          ),
                          Text(
                            "Add Category",
                            style: GoogleFonts.cairo(
                                fontSize: width/68.3, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        //table details
        Padding(
          padding:  EdgeInsets.symmetric(
              vertical: height/36.5,
              horizontal: width/75.88
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xff00A99D),
                border: Border.all(color: Colors.red)),

            width: width / 1.03,

            height: height / 1.87,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //titilesssss....
                  Container(
                    width: width / 1.03,
                    height: height / 16.42,
                    // color: Color(0xff00A99D),
                    decoration: const BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/42.68, right: width/34.15),
                          child: Text("Sl.no",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: height / 13.14,
                          width: width / 5.10,
                          child: Text("Category",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: height / 13.14,
                          width: width / 5.10,
                          child: Text("Item Name",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: height / 13.14,
                          width: width / 5.10,
                          child: Text("Description",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: width/55.985, right: width/19.514),
                          child: Text("Edit",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text("Delete",
                            style: GoogleFonts.cairo(
                                color: const Color(0xff00A99D),
                                fontSize: width/68.3,
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding:  EdgeInsets.only(left: width/15.523),
                          child: Text("Status",
                              style: GoogleFonts.cairo(
                                  color: const Color(0xff00A99D),
                                  fontSize: width/68.3,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),

                  //category stream
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Sevice_items").orderBy("timestamp",descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == null) {
                        return Center(
                          child: Container(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          if(isserach==true&&snapshot.data!.docs[index]["Category"].toString().toLowerCase().
                          startsWith(Username.toLowerCase()) ||
                              isserach==true&&snapshot.data!.docs[index]["Itemname"].toString().toLowerCase().
                              startsWith(Username.toLowerCase())||
                              isserach==true&&snapshot.data!.docs[index]["description"].toString().toLowerCase().
                              startsWith(Username.toLowerCase())
                          ){
                            return Row(
                              children: [

                                //index (Serial number)
                                Container(
                                  height: height / 13.14,
                                  width: width / 13.66,
                                  // color: Colors.grey,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width/75.888,
                                            color: const Color(0xffFDFDFD)),
                                      )),
                                ),

                                //name text
                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["Category"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["Itemname"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["description"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                //edit icon(img)
                                InkWell(
                                  onTap:(){
                                    editditem(snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 13.14,
                                      width: width / 12.64,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                      child: Image.asset("assets/edit.png")),
                                ),//


                                //delete icon (img)
                                InkWell(
                                  onTap:(){
                                    _catogory( snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 13.14,
                                      width: width / 12.41,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                      child: Image.asset("assets/delete.png")),
                                ),

                                //active text
                                Container(
                                    height: height / 13.14,
                                    width: width / 6.83,
                                    // color: Colors.grey,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff00A99D),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.red,
                                          ),
                                        )),
                                    child: Center(
                                        child: Text(
                                          "Active",
                                          style: GoogleFonts.cairo(
                                              fontSize: width/75.888,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xffFDFDFD)),
                                        ))),

                              ],
                            );
                          }
                          else if(isserach==false){
                            return Row(
                              children: [

                                //index (Serial number)
                                Container(
                                  height: height / 13.14,
                                  width: width / 13.66,
                                  // color: Colors.grey,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width/75.888,
                                            color: const Color(0xffFDFDFD)),
                                      )),
                                ),

                                //name text
                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["Category"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["Itemname"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Text(
                                      snapshot.data!.docs[index]
                                      ["description"],
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width/75.888,
                                          color: const Color(0xffFDFDFD)),
                                    ),
                                  ),
                                ),

                                //edit icon(img)
                                InkWell(
                                  onTap:(){
                                    editditem(snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 13.14,
                                      width: width / 12.64,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                      child: Image.asset("assets/edit.png")),
                                ),//


                                //delete icon (img)
                                InkWell(
                                  onTap:(){
                                    _catogory( snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                      height: height / 13.14,
                                      width: width / 12.41,
                                      // color: Colors.grey,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                      child: Image.asset("assets/delete.png")),
                                ),

                                //active text
                                Container(
                                    height: height / 13.14,
                                    width: width / 6.83,
                                    // color: Colors.grey,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff00A99D),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.red,
                                          ),
                                        )),
                                    child: Center(
                                        child: Text(
                                          "Active",
                                          style: GoogleFonts.cairo(
                                              fontSize: width/75.888,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xffFDFDFD)),
                                        ))),

                              ],
                            );

                          }
                          return const SizedBox();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            //color: Colors.red,
          ),
        )

      ],
    )
        :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  categoryclick = false;
                });
              },
              child: Padding(
                padding:  EdgeInsets.only(top: height/32.85),
                child: Tooltip(
                  message: "Back",
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Colors.indigo,
                    child: Container(
                      height: height/21.9,
                      width: width/45.53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: width/91.06,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(left: width/35.947, top: height/32.85),
              child: Text(
                "Add Item Details ",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize:width/59.391,
                    color: const Color(0xffFFFFFF)),
              ),
            ),

            SizedBox(
              width: width/1.517,
            ),
            InkWell(
              onTap: () {

              },
              child: Padding(
                padding:
                EdgeInsets.only(left: width/35.94, top: height/32.85),
                child: Text(
                  "Add Operators ",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize:width/59.391,
                      color: const Color(0xffFFFFFF)),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: width/75.88,
              vertical: height/36.5
          ),
          child: Image.asset("assets/Line13.png"),
        ),

        //First row container and text

        SizedBox(height:height/65.7),

        Row(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/23.55,),
                  child: Text(
                    "Category",
                    style: GoogleFonts.poppins(
                        fontSize: width/97.57, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left:width/23.55,),
                  child: Container(
                    width: width / 6.504,
                    height: height / 16.42,
                    decoration: BoxDecoration(
                        color: const Color(0xffDDDEEE),
                        borderRadius: BorderRadius.circular(4)),
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
                                    Operator1=textEditingController2;
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
                                Operator1.text=selection;
                              });
                              debugPrint('You just selected $selection');
                            },
                            displayStringForOption: (Value) {
                              return Value;
                            },
                          ),
                    )
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:width/23.55,),
                  child: Text(
                    "Item Name",
                    style: GoogleFonts.poppins(
                        fontSize: width/97.57, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left:width/23.55,),
                  child: Container(
                    width: width / 6.504,
                    height: height / 16.42,
                    decoration: BoxDecoration(
                        color: const Color(0xffDDDEEE),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: Operator2,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.poppins(fontSize: width/106.6,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(left: width/68.3, bottom: height/82.125),
                        border: InputBorder.none,
                      ),

                    ),
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(left:width/23.55,),
                  child: Text(
                    "Description",
                    style: GoogleFonts.poppins(
                        fontSize: width/97.57, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left:width/23.55,),
                  child: Container(
                    width: width / 4.504,
                    height: height / 16.42,
                    decoration: BoxDecoration(
                        color: const Color(0xffDDDEEE),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: Operator3,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.poppins(fontSize: width/106.6,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(left: width/68.3, bottom: height/82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),

        Padding(
          padding:  EdgeInsets.only(top: height/36.5, left: width/19.51),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showdialpogbox();
                },
                child: Container(
                  width: width / 13.6,
                  height: height / 16.42,
                  //color: Color(0xffD60A0B),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff25D366)
                  ),
                  child: Center(
                      child: Text(
                        "Save",
                        style:
                        GoogleFonts.poppins(color: Colors.white),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width/75.888),
                child: InkWell(
                  onTap: () {
                    claercate();
                  },
                  child: Container(
                    width: width / 13.6,
                    height: height / 16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    child: Center(
                        child: Text(
                          "Reset",
                          style: GoogleFonts.poppins(
                              color: Colors.white),
                        )),
                  ),
                ),
              ),
            ],
          ),
        )

      ],
    );
  }


  category() {
    FirebaseFirestore.instance.collection("Sevice_items").doc().set({
      "Category":Operator1.text,
      "Itemname":Operator2.text,
      "description":Operator3.text,
      "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp":DateTime.now().microsecondsSinceEpoch,
    });
    claercate();
  }

  claercate(){
    Operator1.clear();
    Operator2.clear();
    Operator3.clear();
  }

  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.76,bottom:height/4.76),
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
                    SizedBox(height: height/32.85,),
                    Text("Add a  Item Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: height/32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/32.85,),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            category();
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: const Color(0xff25D366),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height/16.425,
                              width: width/9.588,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366)
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



//delete function
  delete(catid){
    FirebaseFirestore.instance.collection("Sevice_items").doc(catid).delete();

  }

  //_catogory showpopup(delete popup)
  _catogory(catid){

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(context: context, builder:(context) {

      return Padding(
        padding:  EdgeInsets.only(top: height/4.38,bottom: height/4.38,left: width/3.902,right:width/3.902),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:height/21.9),
                Text("Are You Sure Want to Delete",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:width/75.88
                ),),

                SizedBox(height:height/32.85),

                SizedBox(
                  height:height/3.65,
                  width:width/7.588,
                  child: Lottie.network(deletefile),
                ),
                SizedBox(height:height/32.85),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        delete(catid);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:height/16.425,
                        width:width/9.588,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xff263646)
                        ),
                        child: Center(
                          child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,
                              fontWeight: FontWeight.w600),),
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
          ),
        ),
      );
    },);
  }

  //eidt item popup

  TextEditingController edititem1 = TextEditingController();
  TextEditingController edititem2 = TextEditingController();
  TextEditingController edititem3 = TextEditingController();


  edidtheitemfunction(docid){
    FirebaseFirestore.instance.collection("Sevice_items").doc(docid).update({
      "Category":edititem1.text,
      "Itemname":edititem2.text,
      "description":edititem3.text,
    });
  }

  ediditemsetfunction(docid)async{
    var getdatae=await FirebaseFirestore.instance.collection("Sevice_items").doc(docid).get();
    Map<String,dynamic>?value=getdatae.data();
    setState(() {
      edititem1.text=value!['Category'];
      edititem2.text=value['Itemname'];
      edititem3.text=value['description'];
    });
  }

  editditem(docid) {
    ediditemsetfunction(docid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: height / 5.35,
              bottom: height / 5.35,
              left: width / 3.415,
              right: width / 3.415),
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height / 21.9),
                  Text(
                    "Are You Sure Want To Edit this Item ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Category",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 131.4),
                  Container(
                      height: height / 16.425,
                      width: width / 6.209,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.cyan),
                      child:
                      TextField(
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        controller: edititem1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Item Name",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 131.4),
                  Container(
                      height: height / 16.425,
                      width: width / 6.209,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.cyan),
                      child: TextField(
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        controller: edititem2,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 131.4),
                  Container(
                      height: height / 16.425,
                      width: width / 6.209,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.cyan),
                      child: TextField(
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        controller: edititem3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //update functions
                      edidtheitemfunction(docid);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 16.425,
                      width: width / 10.507,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff263646)),
                      child: Center(
                        child: Text(
                          "Okay",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
