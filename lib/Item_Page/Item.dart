import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class Item extends StatefulWidget {
  Item(this.pages);

  String pages;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool itemselect = false;

  // item variables and controller
  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;
  TextEditingController itemcode = new TextEditingController();
  TextEditingController HSNcode = new TextEditingController();
  TextEditingController Newitemname = new TextEditingController();
  TextEditingController Purchaseprice = new TextEditingController();
  TextEditingController Landingcost = new TextEditingController();
  TextEditingController Saleprice = new TextEditingController();
  TextEditingController MRPPrice = new TextEditingController();
  TextEditingController Loworder = new TextEditingController();
  TextEditingController BoxNo = new TextEditingController();
  TextEditingController IMEino = new TextEditingController();
  TextEditingController SerialNo = new TextEditingController();

  TextFieldTagsController tagcontroller = new TextFieldTagsController();

  final TextEditingController _typeAheadControllergender = TextEditingController();
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  List<String> getSuggestionsgender(String query) {
    List<String> matches = <String>[];
    matches.addAll(categorylist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllergender2 = TextEditingController();
  SuggestionsBoxController suggestionBoxController2 = SuggestionsBoxController();

  List<String> getSuggestionsgender2(String query) {
    List<String> matches = <String>[];
    matches.addAll(Barndlist);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



  @override
  void initState() {
    categoryaddfunction();
    barndaddfunction();
    getitename();
    // TODO: implement initState
    super.initState();
  }

  NumberFormat F = new NumberFormat('00');

  int itemcodes = 0;

  itemcodegenrate() async {
    var document = await FirebaseFirestore.instance.collection("Item").get();
    setState(() {
      itemcodes = document.docs.length + 1;
      itemcode.text = "${"SBI"}${F.format(itemcodes)}";
    });
    print(itemcode.text);
  }

  int landingcost = 0;

  checkgst(purchase) {
    setState(() {
      Landingcost.text =
          (((double.parse(purchase)) * 18 / 100) + double.parse(purchase))
              .toStringAsFixed(2);
    });
    print(Landingcost.text);
  }

  List<String> categorylist = <String>[];
  List<String> Barndlist = <String>[];

  categoryaddfunction() async {
    var Document = await FirebaseFirestore.instance
        .collection('category')
        .orderBy("categoryname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      categorylist.add(Document.docs[i]['categoryname']);
    }
    print(categorylist);
  }

  barndaddfunction() async {
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Barndlist.add(Document.docs[i]['Brandname']);
    }
    print(Barndlist);
  }

  String hint = "";

  checkcategoryaddfunction(name) async {
    var Document2 =
        await FirebaseFirestore.instance.collection('category').get();
    for (int i = 0; i < Document2.docs.length; i++) {
      if (name == Document2.docs[i]['categoryname']) {
        hint = Document2.docs[i]['categoryname'];
      }
      print(hint);
    }
  }

  String brandhint = "";

  checkbrandaddfunction(name) async {
    var Document2 = await FirebaseFirestore.instance.collection('Brand').get();
    for (int i = 0; i < Document2.docs.length; i++) {
      if (name == Document2.docs[i]['Brandname']) {
        brandhint = Document2.docs[i]['Brandname'];
      }
      print(brandhint);
    }
  }

  bool isChecked = false; //imei
  bool isChecked2 = false; //serial
  bool isChecked3 = false; //color

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

    return itemselect == false
        ? Column(
            children: [
              Row(
                children: [
                  SizedBox(width: width / 91.06),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => drawer(),
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 32.85),
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
                        left: width / 48.78, top: height / 32.85),
                    child: Text(
                      "Item",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: width / 59.39,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 1.241, top: height / 21.9),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => drawer(),
                        ));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width / 170.75, right: width / 170.75),
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: width / 136.6),
                              child: Text(
                                "Home",
                                style: GoogleFonts.cairo(
                                    color: Color(0xffFFFFFF),
                                    fontSize: width / 59.39),
                              ),
                            )
                          ],
                        ),
                        width: width / 11.38,
                        height: height / 16.42,
                        // color: Color(0xff00A99D),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff00A99D),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 75.88, vertical: height / 36.5),
                child: Image.asset("assets/Line13.png"),
              ),
              Padding(
                padding: EdgeInsets.only(right: width / 1.1478),
                child: Text("Search",
                    style: GoogleFonts.cairo(
                        fontSize: width / 68.3, fontWeight: FontWeight.bold)),
              ),

              Row(
                children: [

                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 28.458, right: width / 34.15),
                    child: Container(
                      child: TextField(
                        style: GoogleFonts.poppins(fontSize: width / 68.3),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          border: InputBorder.none,
                          suffix: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height / 82.125,
                                horizontal: width / 170.75),
                            child: Image.asset("assets/search.png"),
                          ),
                        ),
                      ),

                      width: width / 3.902,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        itemselect = true;
                      });
                      itemcodegenrate();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: height / 657,
                                left: width / 91.066,
                                right: width / 68.3),
                            child: Container(
                              child: Icon(Icons.add, color: Colors.teal),
                              width: width / 56.91,
                              height: height / 27.37,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Add Item",
                            style: GoogleFonts.cairo(
                                fontSize: width / 68.3, color: Colors.white),
                          ),
                        ],
                      ),
                      width: width / 5.46,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff00A99D),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 75.888, vertical: height / 36.5),
                child: Container(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        //titles texts
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width / 42.687, right: width / 34.15),
                                child: Text("Sl.no",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D),
                                        fontSize: width / 68.3)),
                              ),
                              Text("Item Name",
                                  style: GoogleFonts.cairo(
                                      color: Color(0xff00A99D),
                                      fontSize: width / 68.3)),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width / 1.876, right: width / 19.514),
                                child: Text("Edit",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D),
                                        fontSize: width / 68.3)),
                              ),
                              Text("Delete",
                                  style: GoogleFonts.cairo(
                                      color: Color(0xff00A99D),
                                      fontSize: width / 68.3)),
                              Padding(
                                padding: EdgeInsets.only(left: width / 15.523),
                                child: Text("Status",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D),
                                        fontSize: width / 68.3)),
                              ),
                            ],
                          ),
                          width: width / 1.01,
                          height: height / 16.42,
                          // color: Color(0xff00A99D),
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                        ),

                        //item stream
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Item")
                              .snapshots(),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasData == null) {
                              return Center(
                                child: Container(),
                              );
                            }
                            if (!snapshot2.hasData) {
                              return Center(
                                child: Container(),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot2.data!.docs.length,
                              itemBuilder: (context, index) {
                                var item = snapshot2.data!.docs[index];
                                return Row(
                                  children: [
                                    //index(serial text)
                                    Container(
                                      child: Center(
                                          child: Text(
                                        (index + 1).toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width / 75.888,
                                            color: Color(0xffFDFDFD)),
                                      )),
                                      height: height / 13.14,
                                      width: width / 13.66,
                                      // color: Colors.grey,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                    ),
                                    //item name text
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width / 75.888,
                                            top: height / 131.4),
                                        child: Text(
                                          item["Newitemname"],
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 75.888,
                                              color: Color(0xffFDFDFD)),
                                        ),
                                      ),
                                      height: height / 13.14,
                                      width: width / 1.70,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                    ),
                                    //edit icon(img)
                                    Container(
                                        child: Image.asset("assets/edit.png"),
                                        height: height / 13.14,
                                        width: width / 12.64,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00A99D),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.red,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ))),

                                    //delete icon (img)
                                    InkWell(
                                      onTap: () {
                                        _Item(item.id);
                                      },
                                      child: Container(
                                          child:
                                              Image.asset("assets/delete.png"),
                                          height: height / 13.14,
                                          width: width / 12.41,
                                          // color: Colors.grey,
                                          decoration: BoxDecoration(
                                              color: Color(0xff00A99D),
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.red,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ))),
                                    ),

                                    //active text
                                    Container(
                                        child: Center(
                                            child: Text(
                                          "Active",
                                          style: GoogleFonts.cairo(
                                              fontSize: width / 75.888,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffFDFDFD)),
                                        )),
                                        height: height / 13.14,
                                        width: width / 6.83,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00A99D),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ))),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                      ),
                      color: Color(0xff00A99D),
                      border: Border.all(color: Colors.red)),

                  width: width / 1.03,

                  height: height / 1.87,

                  //color: Colors.red,
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: width / 91.06),
                  InkWell(
                    onTap: () {
                      setState(() {
                        itemselect = false;
                      });
                      print(height);
                      print(width);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 32.85),
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
                        left: width / 35.947, top: height / 32.85),
                    child: Text(
                      "Add Item ",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: width / 59.39,
                          color: Color(0xffFFFFFF)),
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
                          left: width / 35.947, top: height / 32.85),
                      child: Text(
                        "Add Category ",
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: width / 59.39,
                            color: Color(0xffFFFFFF)),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 75.888, vertical: height / 36.5),
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
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 11.383, top: height / 82.125),
                    child: Text(
                      "Brand Name",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width / 6.83),
                    child: Text(
                      "New Item Code *",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 11.878, right: width / 9.106),
                    child: Text(
                      "HSN Code *",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
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
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: width / 455.33, right: width / 455.33),
                              child: TypeAheadFormField(
                                suggestionsBoxDecoration:
                                    SuggestionsBoxDecoration(
                                        color: Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )),
                                textFieldConfiguration: TextFieldConfiguration(
                                  style: GoogleFonts.poppins(fontSize: 15),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 10, bottom: 8),
                                    border: InputBorder.none,
                                  ),
                                  controller: this._typeAheadControllergender,
                                ),
                                suggestionsCallback: (pattern) {
                                  return getSuggestionsgender(pattern);
                                },
                                itemBuilder: (context, String suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (String suggestion) {
                                  this._typeAheadControllergender.text =
                                      suggestion;
                                  checkcategoryaddfunction(
                                      suggestion.toString());
                                  categoryitemcode(suggestion.toString());
                                },
                                suggestionsBoxController:
                                    suggestionBoxController,
                                validator: (value) => value!.isEmpty
                                    ? 'Please select a academic year'
                                    : null,
                                onSaved: (value) {
                                  checkcategoryaddfunction(value.toString());
                                  categoryitemcode(value.toString());
                                },
                              )
                              /*LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                  initialValue: TextEditingValue(
                                      text: hint,
                                      selection: TextSelection(
                                        isDirectional: true,
                                        baseOffset: 5,
                                        extentOffset: 1,
                                      )),
                                  optionsViewBuilder:
                                      (context, onSelected, options) => Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(4.0)),
                                            ),
                                            child: Container(
                                              height: 52.0 * options.length,
                                              width:
                                                  BoxConstraints.biggest.width,
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
                                                          EdgeInsets.all(16.0),
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

                                    if (textEditingValue.text != "") {
                                      checkcategoryaddfunction(
                                          textEditingValue.text);
                                      categoryitemcode(textEditingValue.text);
                                    }

                                    return categorylist.where((String option) {
                                      return option.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String selection) {
                                    setState(() {
                                      hint = selection;
                                    });
                                    debugPrint('You just selected $selection');
                                  },
                                  displayStringForOption: (Value) {
                                    return Value;
                                  },
                                ),
                              )*/

                              ),
                          width: width / 5.8,
                          height: height / 16.42,
                          //color: Color(0xffDDDEEE),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            //popup dialog
                            AddCateogorys();
                          },
                          child: Tooltip(
                            message: "Add Categorys",
                            child: Container(
                              height: height / 26.28,
                              width: width / 54.64,
                              child: CircleAvatar(
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
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 455.33, right: width / 455.33),
                          child: Container(
                            child: TypeAheadFormField(
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(
                                      color: Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      )),
                              textFieldConfiguration: TextFieldConfiguration(
                                style: GoogleFonts.poppins(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 10, bottom: 8),
                                  border: InputBorder.none,
                                ),
                                controller: this._typeAheadControllergender2,
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestionsgender2(pattern);
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              transitionBuilder:
                                  (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                this._typeAheadControllergender2.text =
                                    suggestion;
                                checkbrandaddfunction(
                                    suggestion.toString());
                              },
                              suggestionsBoxController: suggestionBoxController2,
                              validator: (value) => value!.isEmpty
                                  ? 'Please select a academic year'
                                  : null,
                              onSaved: (value) {
                                checkbrandaddfunction(
                                    value.toString());
                              },
                            )

                            /*LayoutBuilder(
                              builder: (BuildContext, BoxConstraints) =>
                                  Autocomplete<String>(
                                initialValue: TextEditingValue(
                                    text: brandhint,
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
                                          child: Container(
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
                                                        EdgeInsets.all(16.0),
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

                                  if (textEditingValue.text != "") {
                                    checkbrandaddfunction(
                                        textEditingValue.text);
                                  }

                                  return Barndlist.where((String option) {
                                    return option.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    brandhint = selection;
                                  });
                                  debugPrint('You just selected $selection');
                                },
                                displayStringForOption: (Value) {
                                  return Value;
                                },
                              ),
                            )*/
                            ,

                            width: width / 5.8,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            //popup dialog
                            Barnditem();
                          },
                          child: Tooltip(
                            message: "Add Categorys",
                            child: Container(
                              height: height / 26.28,
                              width: width / 54.64,
                              child: CircleAvatar(
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
                      child: TextField(
                        style: GoogleFonts.poppins(fontSize: 15),
                        controller: itemcode,
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          hintText: "PSDFG004",
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.504,
                      height: height / 16.42,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: height / 65.7),
                    child: Container(
                      child: TextField(
                        controller: HSNcode,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          hintText: "KIJHD0214",
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.504,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
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
                        right: width / 11.878),
                    child: Text(
                      "Purchase Price *",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 32.85),
                    child: Text(
                      "Landing Cost",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 32.85, left: width / 10.1),
                    child: Text(
                      "Sale Price *",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 32.85, left: width / 8.7),
                    child: Text(
                      "MRP Price/Unit",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
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
                      child: TextField(
                        controller: Purchaseprice,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          hintText: "0.00",
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) {
                          checkgst(Purchaseprice.text);
                        },
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(

                    padding:
                        EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                    child: Container(
                      child: TextField(
                        controller: Landingcost,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                    child: Container(
                      child: TextField(
                        controller: Saleprice,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                    child: Container(
                      child: TextField(
                        controller: MRPPrice,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
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
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    EdgeInsets.only(left: width / 24.836, top: height / 32.85),
                child: Text(
                  "Item Details",
                  style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
                            fontSize: width / 97.571,
                            color: Color(0xff000000))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 10.118, top: height / 82.125),
                    child: Text(
                      "Low Order Qunaity",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width / 9.757, top: height / 82.125),
                    child: Text(
                      "Box No",
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: width / 136.6, left: width / 136.6),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue1,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          style: GoogleFonts.poppins(fontSize: 15),
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
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 82.125, right: width / 136.6),
                    child: Container(
                      child: TextField(
                        controller: Loworder,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          hintText: "25",
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 82.125, left: width / 27.32),
                    child: Container(
                      child: TextField(
                        controller: BoxNo,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 164.25),
                          hintText: "Phone BOX NO",
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.5,
                      height: height / 16.42,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: width / 136.6,
                    ),
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
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                  ),

                  //color checkbox
                  Padding(
                    padding: EdgeInsets.only(
                      left: width / 106.6,
                    ),
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
                          style: GoogleFonts.poppins(
                              fontSize: width / 97.571,
                              color: Color(0xff000000)),
                        ),
                      ],
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
                      style: GoogleFonts.poppins(
                          fontSize: width / 97.571, color: Color(0xff000000)),
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
                      child: TextField(
                        controller: Newitemname,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),
                          hintText: "Item..",
                          border: InputBorder.none,
                        ),
                      ),
                      height: height / 7.3,
                      width: width / 1.70,
                      //color: Color(0xffDDDEEE),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    EdgeInsets.only(top: height / 36.5, left: width / 19.514),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        checkitemname();
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "Save",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )),
                        width: width / 13.6,
                        height: height / 16.42,
                        //color: Color(0xffD60A0B),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffD60A0B),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 75.888),
                      child: InkWell(
                        onTap: () {
                          clearallcontroller();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "Reset",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                          width: width / 13.6,
                          height: height / 16.42,
                          //color: Color(0xffD60A0B),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff00A0E3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
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
        print(catitemcode);
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
        print(branditemcode);
      }
    }
  }

  itempage() {
    FirebaseFirestore.instance
        .collection("category")
        .doc(catitemcode)
        .collection("Item")
        .doc()
        .set({
      "Category": hint,
      "Brand": brandhint,
      "Itemcode": itemcode.text,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Landingcost.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%"
    });

    FirebaseFirestore.instance.collection("Item").doc().set({
      "Category": hint,
      "Brand": brandhint,
      "Itemcode": itemcode.text,
      "HSNCode": HSNcode.text,
      "Newitemname": Newitemname.text,
      "Purchaseprice": double.parse(Purchaseprice.text).toStringAsFixed(2),
      "Landingcost": double.parse(Landingcost.text).toStringAsFixed(2),
      "Saleprice": double.parse(Saleprice.text).toStringAsFixed(2),
      "MRPPrice": double.parse(MRPPrice.text).toStringAsFixed(2),
      "Loworder": Loworder.text,
      "BoxNo": BoxNo.text,
      "IMEI NO": isChecked,
      "Serial NO": isChecked2,
      "Color": isChecked3,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "gst": "18%",
    });
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
      hint = '';
      brandhint = "";
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
    } else {
      itempage();
      showdialpogbox();
    }
      tagcontroller.clearTextFieldTags();

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
            duration: Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: Color(0xff264656),
                content: Container(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Text(
                        "Already Item Exits",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Container(
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height / 16.425,
                            width: width / 7.588,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
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
            duration: Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: Color(0xff264656),
                content: Container(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Text(
                        "Add a Category Item Successfully",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Container(
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
                          clearallcontroller();
                          Navigator.pop(context);
                        },
                        child: Material(
                          elevation: 15,
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height / 16.425,
                            width: width / 7.588,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
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
    FirebaseFirestore.instance.collection("Item").doc(itemid).delete();
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(height: height / 32.85),
                  Container(
                    height: height / 3.65,
                    width: width / 7.588,
                    child: Lottie.network(deletefile),
                  ),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      delete(itemid);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 16.425,
                      width: width / 7.588,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff263646)),
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

  //Add categorys function
  TextEditingController Categorys = new TextEditingController();

  addcategory() {
    FirebaseFirestore.instance.collection("category").doc().set({
      "Date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "categoryname": Categorys.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Add Category",
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
                        controller: Categorys,
                        decoration: InputDecoration(
                            hintText: "Add Category",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //create functions
                      addcategory();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 16.425,
                      width: width / 10.507,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff263646)),
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

  //add brand funtion
  TextEditingController Branditem = new TextEditingController();

  addbrand() {
    FirebaseFirestore.instance.collection("Brand").doc().set({
      "Date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "Brandname": Branditem.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Add Brand",
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
                        controller: Branditem,
                        decoration: InputDecoration(
                            hintText: "Add Brand",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //create functions
                      addbrand();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 16.425,
                      width: width / 10.507,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff263646)),
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
