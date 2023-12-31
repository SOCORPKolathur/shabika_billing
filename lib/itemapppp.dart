import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';
const List<String> list = <String>[
  'Please Select Category',
  'Two',
  'Three',
  'Four'
];

const List<String> list1 = <String>['Numbers(NOS)', 'Two', 'Three', 'Four'];

const List<String> list2 = <String>[
  'Please Select Category',
  'Two',
  'Three',
  'Four'
];



class ItemAddP extends StatefulWidget {
  const ItemAddP({Key? key}) : super(key: key);

  @override
  State<ItemAddP> createState() => _ItemAddPState();
}

class _ItemAddPState extends State<ItemAddP> {
  bool itemselect = false;

  // item variables and controller
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;
  TextEditingController itemcode = TextEditingController();
  TextEditingController HSNcode = TextEditingController();
  TextEditingController Newitemname = TextEditingController();
  TextEditingController Purchaseprice = TextEditingController();
  TextEditingController Landingcost = TextEditingController();
  TextEditingController Saleprice = TextEditingController();
  TextEditingController MRPPrice = TextEditingController();
  TextEditingController Loworder = TextEditingController();
  TextEditingController BoxNo = TextEditingController();
  TextEditingController IMEino = TextEditingController();
  TextEditingController SerialNo = TextEditingController();

  TextEditingController layourbuilderclear2 = TextEditingController();


  bool status=true;
  bool status2=false;

  TextfieldTagsController tagcontroller = TextfieldTagsController();

  final TextEditingController _typeAheadControllergender = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(categorylist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllergender2 = TextEditingController();
  final TextEditingController _typeAheadControllergender3 = TextEditingController();
  SuggestionsBoxController suggestionBoxController2 = SuggestionsBoxController();
  SuggestionsBoxController suggestionBoxController3 = SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query) {
    List<String> matches = <String>[];
    matches.addAll(Barndlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }


  List <Map<String,dynamic>> search=[];

  getdata()async{
    var document=await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<document.docs.length;i++){
      setState(() {
        search.add(document.docs[i]["Newitemname"],);
      });
    }

  }

  bool isserach=false;

  @override
  void initState() {
    categoryaddfunction();
    barndaddfunction();
    hsncodeaddfunction();
    getdata();
    getitename();
    itemcodegenrate();
    // TODO: implement initState
    super.initState();
  }

  NumberFormat F = NumberFormat('00');

  int itemcodes = 0;
  String shabikancount="";

  itemcodegenrate() async {
    var document = await FirebaseFirestore.instance.collection("Item ShabikaG").get();
    var document2 = await FirebaseFirestore.instance.collection("Item ShabikaN").get();
    setState(() {
      itemcodes = document.docs.length + 1;
      itemcode.text = "${"SBG"}${F.format(document.docs.length + 1)}";
      shabikancount = "${"SBN"}${F.format(document2.docs.length + 1)}";
    });
  }

  int landingcost = 0;

  checkgst(purchase) {
    setState(() {
      Landingcost.text =
          (((double.parse(purchase)) * 18 / 100) + double.parse(purchase))
              .toStringAsFixed(2);
    });
  }

  List<String> categorylist = <String>[];
  List<String> Barndlist = <String>[];
  List<String> Hsnlist = <String>[];

  categoryaddfunction() async {
    setState((){
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance.collection('category').orderBy("categoryname", descending: false).get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
  }

  barndaddfunction() async {
    setState((){
      categorylist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Barndlist.add(Document.docs[i]['Brandname']);
    }
  }

  hsncodeaddfunction() async {
    setState((){
      Hsnlist.clear();
    });
    var Document = await FirebaseFirestore.instance
        .collection('Hsncode')
        .orderBy("timestamp", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Hsnlist.add(Document.docs[i]['HSNCode']);
    }
  }


  bool isChecked = false; //imei
  bool isChecked2 = false; //serial
  bool isChecked3 = false; //color
  bool isChecked4 = false; //image

  bool status3=false;
  bool status4=false;

  List<String> tags = [];

  List Itemnamelists = [];

  getitename() async {
    setState(() {
      Itemnamelists.clear();
    });
    var docs = await FirebaseFirestore.instance.collection("Item").get();
    for (int i = 0; i < docs.docs.length; i++) {
      Itemnamelists.add(docs.docs[i]['Newitemname']);
    }
  }

  String Username="";

  final Formkey=GlobalKey<FormState>();
  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController textcat=TextEditingController();


  FocusNode Purchasepricefocus = FocusNode();
  FocusNode Salespricefocus = FocusNode();

  FocusNode MRPpricefocus = FocusNode();
  FocusNode Loworderfocus = FocusNode();
  FocusNode Boxnofocus = FocusNode();
  FocusNode Itenamefocus = FocusNode();

  FocusNode Imeifocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff00A99D),
      body: Form(
        key: Formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: width / 91.06),
                InkWell(
                  onTap: () {
                  Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: height / 66.85),
                    child: Tooltip(
                      message: "Back",
                      child: Material(
                        elevation: 10,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        shadowColor: Colors.indigo,
                        child: Container(
                          height: height / 21.9,
                          width: width / 45.53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: width / 91.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 35.947, top: height / 66.85),
                  child: Text(
                    "Add Item ",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: width / 59.39,
                        color: const Color(0xffFFFFFF)),
                  ),
                ),

                SizedBox(
                  width: width / 1.517,
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 35.947, top: height / 66.85),
                    child: Text(
                      "Add Category ",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: width / 59.39,
                          color: const Color(0xffFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 75.888, vertical: height / 76.5),
              child: Image.asset("assets/Line13.png"),
            ),

            //First row container and text
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width / 23.551,
                  ),
                  child: Text(
                    "Select Category Name *",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 11.383, top: height / 82.125),
                  child: Text(
                    "Brand Name",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 7.0),
                  child: Text(
                    "New Item Code *",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 10.3, right: width / 9.106),
                  child: Text(
                    "HSN Code ",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),

              ],
            ),

            Row(
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      left: width / 25.773,
                      top: height / 65.7,
                      right: width / 68.3),
                  child: Row(
                    children: [
                      Container(
                        width: width / 5.8,
                        height: height / 16.42,

                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: width / 130.33, right: width / 455.33),
                            child:

                            LayoutBuilder(
                              builder: (BuildContext, BoxConstraints) =>
                                  Autocomplete<String>(
                                    fieldViewBuilder: (context, textEditingController,
                                        focusNode, onFieldSubmitted) {
                                      return textfield3(
                                        focusNode,
                                        textEditingController,
                                        onFieldSubmitted,

                                      );
                                    },
                                    initialValue: const TextEditingValue(

                                      selection: TextSelection(
                                        isDirectional: true,
                                        baseOffset: 10,
                                        extentOffset: 1,
                                      ),

                                    ),
                                    optionsViewBuilder: (context, onSelected, options) => Align(
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
                                    optionsBuilder: (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text == '') {
                                        return const Iterable<String>.empty();
                                      }

                                      if (textEditingValue.text != "") {
                                        categoryitemcode(textEditingValue.text);

                                      }

                                      return categorylist.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text.toLowerCase());
                                      });
                                    },

                                    onSelected: (String selection) {
                                      categoryitemcode(selection);
                                      setState(() {
                                        _typeAheadControllergender.text=selection;
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
                      SizedBox(width: width/273.2),
                      InkWell(
                        onTap: () {
                          //popup dialog
                          AddCateogorys();
                        },
                        child: Tooltip(
                          message: "Add Categorys",
                          child: SizedBox(
                            height: height / 26.28,
                            width: width / 54.64,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //brand stream dropdown
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 65.7, right: width / 68.3),
                  child: Row(
                    children: [
                      Container(
                        width: width / 5.8,
                        height: height / 16.42,
                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child:


                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 130.33, right: width / 455.33),
                          child:
                          LayoutBuilder(
                            builder: (BuildContext, BoxConstraints) =>
                                Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController,
                                      focusNode, onFieldSubmitted) {
                                    return textfield3(
                                      focusNode,
                                      textEditingController,
                                      onFieldSubmitted,
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
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(4.0)),
                                        ),
                                        child: SizedBox(
                                          height: 52.0 * options.length,
                                          width: BoxConstraints.biggest.width,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: options.length,
                                            shrinkWrap: false,
                                            itemBuilder:
                                                (BuildContext, index) {
                                              final String option =
                                              options.elementAt(index);
                                              return InkWell(
                                                onTap: () =>
                                                    onSelected(option),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(16.0),
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
                                    if (textEditingValue.text != '') {
                                      Branditemcode(textEditingValue.text);
                                    }

                                    return Barndlist.where((String option) {
                                      return option.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String selection) {
                                    Branditemcode(selection);
                                    setState(() {
                                      _typeAheadControllergender2.text=selection;
                                    });
                                    debugPrint('You just selected $selection');
                                  },
                                  displayStringForOption: (Value) {
                                    return Value;
                                  },
                                ),
                          ),
                        ),
                      ),
                      SizedBox(width:width/ 273.2),
                      InkWell(
                        onTap: () {
                          //popup dialog
                          Barnditem();
                        },
                        child: Tooltip(
                          message: "Add Brand",
                          child: SizedBox(
                            height: height / 26.28,
                            width: width / 54.64,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: height / 65.7, right: width / 68.3),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      controller: itemcode,
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: height / 65.7),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child:

                    LayoutBuilder(
                      builder: (BuildContext, BoxConstraints) =>
                          Autocomplete<String>(
                            fieldViewBuilder: (context, _Controller,
                                focusNode, onFieldSubmitted) {
                              return TextFormField(
                                onChanged: (_){
                                  setState(() {
                                    HSNcode= _Controller;
                                  });
                                },
                                style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only( bottom: height / 43.8, top: height / 43.8,
                                        left: width/136.6)),
                                controller: _Controller,
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
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(4.0)),
                                  ),
                                  child: SizedBox(
                                    height: 52.0 * options.length,
                                    width: BoxConstraints.biggest.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: options.length,
                                      shrinkWrap: false,
                                      itemBuilder:
                                          (BuildContext, index) {
                                        final String option =
                                        options.elementAt(index);
                                        return InkWell(
                                          onTap: () =>
                                              onSelected(option),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(16.0),
                                            child: Text(option),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {

                              //if the controlller is not empty set the value
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }

                              return Hsnlist.where((String option) {
                                return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (String selection) {
                              setState(() {
                                _typeAheadControllergender3.text=selection;
                                HSNcode.text=selection;
                              });
                              debugPrint('You just selected $selection');
                            },
                            displayStringForOption: (Value) {
                              return Value;
                            },
                          ),
                    ),

                  ),
                ),


              ],
            ),

            //second row container and text
            Row(
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      left: width / 23.551,
                      top: height / 32.85,
                      right: width / 10.0),
                  child: Text(
                    "Purchase Price *",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                SizedBox(width: width/35.94,),

                Padding(
                  padding: EdgeInsets.only(top: height / 32.85),
                  child: Text(
                    "Landing Cost",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                SizedBox(width: width/68.3,),
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 32.85, left: width / 8.1),
                  child: Text(
                    "Sale Price *",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),

                Padding(
                  padding:
                  EdgeInsets.only(top: height / 32.85, left: width / 7.7),
                  child: Text(
                    "MRP Price/Unit",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      top: height / 65.7, left: width / 25.773),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextFormField(
                      focusNode: Purchasepricefocus,
                      validator: (value) => value!.isEmpty
                          ? "Field Can't Empty"
                          : null,
                      controller: Purchaseprice,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),

                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        checkgst(Purchaseprice.text);
                        Purchasepricefocus.unfocus();
                        FocusScope.of(context)
                            .requestFocus(Salespricefocus);
                      },
                    ),
                  ),
                ),
                SizedBox(width: width/45.53,),
                Padding(

                  padding:
                  EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? "Field Can't Empty"
                          : null,
                      controller: Landingcost,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width/54.64,),
                Padding(
                  padding:
                  EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextFormField(
                      focusNode: Salespricefocus,
                      validator: (value) => value!.isEmpty
                          ? "Field Can't Empty"
                          : null,
                      controller: Saleprice,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),
                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        Salespricefocus.unfocus();
                        FocusScope.of(context)
                            .requestFocus(MRPpricefocus);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding:
                  EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextFormField(
                      focusNode: MRPpricefocus,
                      validator: (value) => value!.isEmpty
                          ? "Field Can't Empty" : null,
                      controller: MRPPrice,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),
                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        MRPpricefocus.unfocus();
                        FocusScope.of(context)
                            .requestFocus(Loworderfocus);
                      },
                    ),
                  ),
                ),


              ],
            ),

            Padding(
              padding:
              EdgeInsets.only(left: width / 24.836, top: height / 32.85),
              child: Text(
                "Item Details",
                style: GoogleFonts.openSans(
                    fontSize: width / 71.894, fontWeight: FontWeight.bold),
              ),
            ),

            //third row container and text
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 25.773, top: height / 82.125),
                  child: Text("Select Item Unit",
                      style: GoogleFonts.openSans(
                          fontSize: width / 97.571,
                          color: const Color(0xff000000))),
                ),
                SizedBox(width: width/28.45,),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 10.118, top: height / 82.125),
                  child: Text(
                    "Low Order Qunaity",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
                SizedBox(width: width/91.06,),
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 9.757, top: height / 82.125),
                  child: Text(
                    "Box No",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),

              ],
            ),

            Row(
              children: [

                Padding(
                  padding: EdgeInsets.only(
                      left: width / 25.773,
                      top: height / 82.125,
                      right: width / 45.53),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: width / 136.6, left: width / 136.6),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue1,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                        underline: Container(
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue1 = value!;
                          });
                        },
                        items: list1
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width/68.3,),
                Padding(
                  padding: EdgeInsets.only(
                    top: height / 82.125, ),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: Loworder,
                      focusNode: Loworderfocus,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),

                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        Loworderfocus.unfocus();
                        FocusScope.of(context)
                            .requestFocus(Boxnofocus);
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: height / 82.125, left: width / 27.9),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: BoxNo,
                      focusNode: Boxnofocus,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 164.25),
                        border: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        Boxnofocus.unfocus();
                        //FocusScope.of(context).requestFocus(Itenamefocus);

                      },
                    ),
                  ),
                ),



              ],
            ),

            //Add Item Tag  container
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 25.773,
                      top: height / 65.7,
                      bottom: height / 54.75),
                  child: Text(
                    "Add New Item Name *",
                    style: GoogleFonts.openSans(
                        fontSize: width / 97.571, color: const Color(0xff000000)),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 24.836, top: height / 164.25),
                  child: Container(
                    height: height / 5.6,
                    width: width / 1.70,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      controller: Newitemname,
                      focusNode: Itenamefocus,
                      textInputAction: TextInputAction.done,

                      maxLines: null,


                      style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: width / 68.3, bottom: height / 82.125),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width / 136.6),
                      child: Row(
                        children: [
                          Checkbox(
                            focusNode: Imeifocus,
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 136.6,
                          ),
                          Text(
                            "IMEI Number",
                            style: GoogleFonts.openSans(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: width / 136.6),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 136.6,
                          ),
                          Text(
                            "Serial Number",
                            style: GoogleFonts.openSans(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),

                    //color checkbox
                    Padding(
                      padding: EdgeInsets.only(left: width / 136.6),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            value: isChecked3,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked3 = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 136.6,
                          ),
                          Text(
                            "Color",
                            style: GoogleFonts.openSans(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),

                    //image checkbox
                    Padding(
                      padding: EdgeInsets.only(left: width / 136.6),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            value: isChecked4,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked4 = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: width / 136.6,
                          ),
                          Text(
                            "Image",
                            style: GoogleFonts.openSans(
                                fontSize: width / 97.571,
                                color: const Color(0xff000000)),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),

            Padding(
              padding:
              EdgeInsets.only(top: height / 36.5, left: width / 19.514),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {

                      if (Formkey.currentState!.validate()) {
                        checkitemname();

                      }

                    },
                    child: Container(
                      width: width / 13.6,
                      height: height / 16.42,
                      //color: Color(0xffD60A0B),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff25D366),
                      ),
                      child: Center(
                          child: Text(
                            "Save",
                            style: GoogleFonts.openSans(color: Colors.white),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width / 75.888),
                    child: InkWell(
                      onTap: () {
                        clearallcontroller();
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
                              style: GoogleFonts.openSans(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String catitemcode = '';
  String branditemcode = '';

  categoryitemcode(itemcode) async {
    var document =
    await FirebaseFirestore.instance.collection("category").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (document.docs[i]["categoryname"] == itemcode) {
        setState(() {
          catitemcode = document.docs[i].id;
        });
      }
    }
  }

  Branditemcode(itemcode) async {
    var document = await FirebaseFirestore.instance.collection("Brand").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (document.docs[i]["Brandname"] == itemcode) {
        setState(() {
          branditemcode = document.docs[i].id;
        });
      }
    }
  }

  itempage() async {

    FirebaseFirestore.instance.collection("Item ShabikaG").doc().set({
      "Category":  _typeAheadControllergender.text,
      "Brand": _typeAheadControllergender2.text,
      "Itemcode": itemcode.text,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Landingcost.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "TotalQuvantity": 0,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "Image": isChecked4,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%",
    });
    FirebaseFirestore.instance.collection("Item ShabikaN").doc().set({
      "Category":  _typeAheadControllergender.text,
      "Brand": _typeAheadControllergender2.text,
      "Itemcode": shabikancount,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "TotalQuvantity": 0,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "Image": isChecked4,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%",
    });
    FirebaseFirestore.instance.collection("category").doc(catitemcode).collection("Item ShabikaN").doc().set({
      "Category": _typeAheadControllergender.text,
      "Brand": _typeAheadControllergender2.text,
      "Itemcode": shabikancount,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "TotalQuvantity": 0,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "Image": isChecked4,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%",
    });
    FirebaseFirestore.instance.collection("category").doc(catitemcode).collection("Item ShabikaG").doc().set({
      "Category": _typeAheadControllergender.text,
      "Brand": _typeAheadControllergender2.text,
      "Itemcode": itemcode.text,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Landingcost.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "TotalQuvantity": 0,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "Image": isChecked4,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%"
    });

    var document=await FirebaseFirestore.instance.collection("Hsncode").where("HSNCode",isEqualTo:HSNcode.text).get();
    if(document.docs.length>0){

      FirebaseFirestore.instance.collection("Hsncode").doc(document.docs[0].id).update({
        "HSNCode":HSNcode.text,
        "timestamp":DateTime.now().millisecondsSinceEpoch
      });
    }
    else{
      FirebaseFirestore.instance.collection("Hsncode").doc().set({
        "HSNCode":HSNcode.text,
        "timestamp":DateTime.now().millisecondsSinceEpoch
      });
    }

    hsncodeaddfunction();
  }

  clearallcontroller() {
    itemcode.clear();
    HSNcode.clear();
    Newitemname.clear();
    Purchaseprice.clear();
    Landingcost.clear();
    Saleprice.clear();
    MRPPrice.clear();
    Loworder.clear();
    BoxNo.clear();
    IMEino.clear();
    SerialNo.clear();
    tags.clear();
    _typeAheadControllergender.clear();
    suggestionBoxController.close();
    _typeAheadControllergender2.clear();
    suggestionBoxController2 .close();
    setState(() {
      isChecked = false;
      isChecked2 = false;
      isChecked3 = false;
      itemselect = false;
      dropdownValue1 = 'Numbers(NOS)';
      dropdownValue = 'Please Select Category';
    });
  }

  //already exits ppopup
  checkitemname() async {

    var document = await FirebaseFirestore.instance
        .collection("Item")
        .where("Newitemname", isEqualTo: Newitemname.text)
        .get();
    if (document.docs.length > 0) {
      return alreadyshowdialpogbox();
    }
    else {
      itempage();
      showdialpogbox();
    }
  }


  //showdialogbox..
  alreadyshowdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.761, bottom: height / 4.761),
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
                        height: height / 32.85,
                      ),
                      Text(
                        "Already Item Exits",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
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
                            width: width / 7.588,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff25D366)
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
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  alreadyshowdialpogbox2() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.761, bottom: height / 4.761),
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
                        height: height / 32.85,
                      ),
                      Text(
                        "Already Item Exits-ShabikaG",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
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
                            width: width / 7.588,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff25D366)
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
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  alreadyshowdialpogbox3() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.761, bottom: height / 4.761),
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
                        height: height / 32.85,
                      ),
                      Text(
                        "Already Item Exits-ShabikaN",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
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
                            width: width / 7.588,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff25D366)
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
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.761, bottom: height / 4.761),
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
                        height: height / 32.85,
                      ),
                      Text(
                        "Add a Category Item Successfully",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              clearallcontroller();
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
                                    color: const Color(0xff25D366)
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

  //delete function
  delete(itemid) {
    if(status==true){
      FirebaseFirestore.instance.collection("Item ShabikaG").doc(itemid).delete();
    }
    if(status2==true){
      FirebaseFirestore.instance.collection("Item ShabikaN").doc(itemid).delete();
    }

  }

  //Barnd showpopup(delete popup)
  _Item(itemid) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: height / 4.38,
              bottom: height / 4.38,
              left: width / 3.902,
              right: width / 3.902),
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: height / 21.9),
                  Text(
                    "Are You Sure Want to Delete",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(height: height / 32.85),
                  SizedBox(
                    height: height / 3.65,
                    width: width / 7.588,
                    child: Lottie.network(deletefile),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          delete(itemid);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height / 16.425,
                          width: width / 9.588,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff263646)),
                          child: Center(
                            child: Text(
                              "Okay",
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontWeight: FontWeight.w600),
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
            ),
          ),
        );
      },
    );
  }

  //Add categorys function
  TextEditingController Categorys = TextEditingController();

  addcategory() {
    FirebaseFirestore.instance.collection("category").doc().set({
      "Date":
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "categoryname": Categorys.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    setState(() {
      Categorys.clear();
    });
  }

//categorys add popup
  AddCateogorys() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: height / 3.65,
              bottom: height / 3.65,
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
                    "Add Category Item ",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Add Category",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
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
                        controller: Categorys,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //create functions
                      addcategory();
                      categoryaddfunction();
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
                          style: GoogleFonts.openSans(
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

  //add brand funtion
  TextEditingController Branditem = TextEditingController();

  addbrand() {
    FirebaseFirestore.instance.collection("Brand").doc().set({
      "Date":
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "Brandname": Branditem.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    setState(() {
      Branditem.clear();
    });
  }

  //brand item popup
  Barnditem() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: height / 3.65,
              bottom: height / 3.65,
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
                    "Add Brand Item ",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Add Brand",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
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
                        controller: Branditem,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //create functions
                      addbrand();
                      barndaddfunction();
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
                          style: GoogleFonts.openSans(
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

  //eidt item popup

  TextEditingController edititem = TextEditingController();


  edidtheitemfunction(docid){
    FirebaseFirestore.instance.collection("Item").doc(docid).update({
      "Newitemname":edititem.text,
    });
  }

  ediditemsetfunction(docid)async{
    var getdatae=await FirebaseFirestore.instance.collection("Item").doc(docid).get();
    Map<String,dynamic>?value=getdatae.data();
    setState(() {
      edititem.text=value!['Newitemname'];
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
              top: height / 3.65,
              bottom: height / 3.65,
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
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Edit Item",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
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
                        controller: edititem,
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
                          style: GoogleFonts.openSans(
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

  Widget textfield3(
      FocusNode focusNode,
      TextEditingController textEditingController,
      VoidCallback onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return
      TextFormField(
        style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only( bottom: height / 43.8,
                top: height / 43.8,
                left: width/136.6)),
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
  }
}
