import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Item_edit_Page extends StatefulWidget {
  String ?docid;
  String ?type;
   Item_edit_Page(this.docid,this.type);

  @override
  State<Item_edit_Page> createState() => _Item_edit_PageState();
}

class _Item_edit_PageState extends State<Item_edit_Page> {

  final Formkey=GlobalKey<FormState>();


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
  }

  barndaddfunction() async {
    var Document = await FirebaseFirestore.instance
        .collection('Brand')
        .orderBy("Brandname", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Barndlist.add(Document.docs[i]['Brandname']);
    }
  }



  bool isChecked = false; //imei
  bool isChecked2 = false; //serial
  bool isChecked3 = false; //color
  bool isChecked4 = false; //image

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
  getdateiten();
    // TODO: implement initState
    super.initState();
  }

  //controller
  TextEditingController itemcode = TextEditingController();
  TextEditingController HSNcode = TextEditingController();
  TextEditingController Newitemname = TextEditingController();
  TextEditingController Purchaseprice = TextEditingController();
  TextEditingController Landingcost = TextEditingController();
  TextEditingController Saleprice = TextEditingController();
  TextEditingController MRPPrice = TextEditingController();
  TextEditingController Loworder = TextEditingController();
  TextEditingController BoxNo = TextEditingController();
  TextEditingController Categorycont = TextEditingController();
  TextEditingController Barndcont = TextEditingController();
  
  
  getdateiten()async{

    if(widget.type=='Item'){
      var document =await FirebaseFirestore.instance.collection("Item").doc(widget.docid).get();
      Map<String,dynamic>?value=document.data();
      setState(() {
        itemcode.text=value!["Itemcode"];
        HSNcode.text=value["HSNCode"];
        Newitemname.text=value["Newitemname"];
        Purchaseprice.text=value["Purchaseprice"];
        Landingcost.text=value["Landingcost"];
        Saleprice.text=value["Saleprice"];
        MRPPrice.text=value["MRPPrice"];
        Loworder.text=value["Loworder"];
        BoxNo.text=value["BoxNo"];
        Categorycont.text=value["Category"];
        Barndcont.text=value["Brand"];
        if(value["IMEI NO"]==true){
          setState(() {
            isChecked=true;
          });

        }
        if(value["Serial NO"]==true){
          setState(() {
            isChecked2=true;
          });

        }
        if(value["Color"]==true){
          setState(() {
            isChecked3=true;
          });
        }
        if(value["Image"]==true){
          setState(() {
            isChecked4=true;
          });
        }


      });
    }
    if(widget.type=='ShabikaG'){
      var document =await FirebaseFirestore.instance.collection("Item ShabikaG").doc(widget.docid).get();
      Map<String,dynamic>?value=document.data();
      setState(() {
        itemcode.text=value!["Itemcode"];
        HSNcode.text=value["HSNCode"];
        Newitemname.text=value["Newitemname"];
        Purchaseprice.text=value["Purchaseprice"];
        Landingcost.text=value["Landingcost"];
        Saleprice.text=value["Saleprice"];
        MRPPrice.text=value["MRPPrice"];
        Loworder.text=value["Loworder"];
        BoxNo.text=value["BoxNo"];
        Categorycont.text=value["Category"];
        Barndcont.text=value["Brand"];
        if(value["IMEI NO"]==true){
          setState(() {
            isChecked=true;
          });

        }
        if(value["Serial NO"]==true){
          setState(() {
            isChecked2=true;
          });

        }
        if(value["Color"]==true){
          setState(() {
            isChecked3=true;
          });
        }
        if(value["Image"]==true){
          setState(() {
            isChecked4=true;
          });
        }

      });
    }
    if(widget.type=='ShabikaN'){
      var document =await FirebaseFirestore.instance.collection("Item ShabikaN").doc(widget.docid).get();
      Map<String,dynamic>?value=document.data();
      setState(() {
        itemcode.text=value!["Itemcode"];
        HSNcode.text=value["HSNCode"];
        Newitemname.text=value["Newitemname"];
        Purchaseprice.text=value["Purchaseprice"];
        Landingcost.text=value["Landingcost"];
        Saleprice.text=value["Saleprice"];
        MRPPrice.text=value["MRPPrice"];
        Loworder.text=value["Loworder"];
        BoxNo.text=value["BoxNo"];
        Categorycont.text=value["Category"];
        Barndcont.text=value["Brand"];
        if(value["IMEI NO"]==true){
          setState(() {
            isChecked=true;
          });

        }
        if(value["Serial NO"]==true){
          setState(() {
            isChecked2=true;
          });

        }
        if(value["Color"]==true){
          setState(() {
            isChecked3=true;
          });
        }
        if(value["Image"]==true){
          setState(() {
            isChecked4=true;
          });
        }

      });
    }

    
  }

  updatedocument(){
    if(widget.type=='Item'){
      FirebaseFirestore.instance.collection("Item").doc(widget.docid).update({
        "Category": Categorycont.text,
        "Brand": Barndcont.text,
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
        "Image": isChecked4,
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "gst": "18%"
      });
    }
    if(widget.type=='ShabikaG'){
      FirebaseFirestore.instance.collection("Item ShabikaG").doc(widget.docid).update({
        "Category": Categorycont.text,
        "Brand": Barndcont.text,
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
        "Image": isChecked4,
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "gst": "18%"
      });
    }
    if(widget.type=='ShabikaN'){
      FirebaseFirestore.instance.collection("Item ShabikaN").doc(widget.docid).update({
        "Category": Categorycont.text,
        "Brand": Barndcont.text,
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
        "Image": isChecked4,
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "gst": "18%"
      });
    }

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
                        " Edit Item Successfully",
                        style: GoogleFonts.poppins(
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
                        children: [
                          InkWell(
                            onTap: () {
                              clearallcontroller();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 16.425,
                                width: width / 9.588,
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
      backgroundColor: const Color(0xff00A99D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: width / 91.06),
              InkWell(
                onTap: () {

                  Navigator.pop(context);
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
                  "Edit Item ",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: width / 59.39,
                      color: const Color(0xffFFFFFF)),
                ),
              ),
              SizedBox(
                width: width / 1.517,
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
                  "Category Name *",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width / 11.383, top: height / 82.125),
                child: Text(
                  "Brand Name",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width / 6.83),
                child: Text(
                  "New Item Code *",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width / 11.878, right: width / 9.106),
                child: Text(
                  "HSN Code *",
                  style: GoogleFonts.poppins(
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
                child: Container(
                  width: width / 5.8,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: width / 455.33, right: width / 455.33),
                      child:TextField(
                        style: GoogleFonts.poppins(fontSize: 15),
                        controller: Categorycont,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: width / 68.3, bottom: height / 82.125),

                          border: InputBorder.none,
                        ),
                      ),
                      /*
                          TypeAheadFormField(
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
                                    EdgeInsets.only(left: width/136.6, bottom: height/82.125),
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
                              this._typeAheadControllergender.text = suggestion;
                              categoryitemcode(_typeAheadControllergender.text);
                            },
                            suggestionsBoxController: suggestionBoxController,
                            validator: (value) => value!.isEmpty
                                ? 'Please select a academic year'
                                : null,
                          )

                               */
                   /*   LayoutBuilder(
                        builder: (BuildContext, BoxConstraints) =>
                            Autocomplete<String>(
                              initialValue: TextEditingValue(

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
                      )*/

                  ),
                ),
              ),

              //brand stream dropdown
              Padding(
                padding: EdgeInsets.only(
                    top: height / 65.7, right: width / 68.3),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width / 455.33, right: width / 455.33),
                  child: Container(
                    width: width / 5.8,
                    height: height / 16.42,
                    //color: Color(0xffDDDEEE),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child:
                    TextField(
                      style: GoogleFonts.poppins(fontSize: 15),
                      controller: Barndcont,
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
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: height / 65.7, right: width / 68.3),
                child: Container(
                  width: width / 6.504,
                  height: height / 16.42,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child:
                  TextField(
                    style: GoogleFonts.poppins(fontSize: 15),
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
                  width: width / 6.504,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    controller: HSNcode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width / 68.3, bottom: height / 82.125),

                      border: InputBorder.none,
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
                    right: width / 11.878),
                child: Text(
                  "Purchase Price *",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 32.85),
                child: Text(
                  "Landing Cost",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height / 32.85, left: width / 10.1),
                child: Text(
                  "Sale Price *",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: height / 32.85, left: width / 8.7),
                child: Text(
                  "MRP Price/Unit",
                  style: GoogleFonts.poppins(
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
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextFormField(

                    validator: (value) => value!.isEmpty
                        ? "Field Can't Empty"
                        : null,
                    controller: Purchaseprice,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width / 68.3, bottom: height / 82.125),

                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Padding(

                padding:
                EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                child: Container(
                  width: width / 6.5,
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
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width / 68.3, bottom: height / 82.125),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding:
                EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                child: Container(
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextFormField(
                    validator: (value) => value!.isEmpty
                        ? "Field Can't Empty"
                        : null,
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
                ),
              ),

              Padding(
                padding:
                EdgeInsets.only(top: height / 65.7, left: width / 65.7),
                child: Container(
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextFormField(
                    validator: (value) => value!.isEmpty
                        ? "Field Can't Empty"
                        : null,
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

              /*Padding(
                padding: EdgeInsets.only(
                    left: width / 25.773, top: height / 82.125),
                child: Text("Select Item Unit",
                    style: GoogleFonts.poppins(
                        fontSize: width / 97.571,
                        color: Color(0xff000000))),
              ),*/

              Padding(
                padding: EdgeInsets.only(
                    left: width / 25.773, top: height / 82.125),
                child: Text(
                  "Low Order Qunaity",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: width / 8.2, top: height / 82.125),
                child: Text(
                  "Box No",
                  style: GoogleFonts.poppins(
                      fontSize: width / 97.571, color: const Color(0xff000000)),
                ),
              ),

            ],
          ),

          Row(
            children: [

              /*Padding(
                padding: EdgeInsets.only(
                    left: width / 25.773,
                    top: height / 82.125,
                    right: width / 45.53),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width / 136.6, left: width / 136.6),

                  ),
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),*/

              Padding(
                padding: EdgeInsets.only(
                    left: width / 25.773,
                    top: height / 82.125,
                    right: width / 45.53),
                child: Container(
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    controller: Loworder,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width / 68.3, bottom: height / 82.125),

                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: height / 82.125, left: width / 27.32),
                child: Container(
                  width: width / 6.5,
                  height: height / 16.42,
                  //color: Color(0xffDDDEEE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    controller: BoxNo,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: width / 68.3, bottom: height / 164.25),

                      border: InputBorder.none,
                    ),
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
                  style: GoogleFonts.poppins(
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.poppins(fontSize: 15),
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
                          style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                    updatedocument();
                    showdialpogbox();
                  },
                  child: Container(
                    width: width / 13.6,
                    height: height / 16.42,
                    //color: Color(0xffD60A0B),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffD60A0B),
                    ),
                    child: Center(
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(color: Colors.white),
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
                        color: const Color(0xff00A0E3),
                      ),
                      child: Center(
                          child: Text(
                            "Reset",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
    Categorycont.clear();
    Barndcont.clear();
    _typeAheadControllergender.clear();
    suggestionBoxController.close();
    _typeAheadControllergender2.clear();
    suggestionBoxController2 .close();
    setState(() {
      isChecked = false;
      isChecked2 = false;
      isChecked3 = false;
      isChecked4 = false;

    });
  }

}
