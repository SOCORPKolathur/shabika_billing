import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';

class ReplaceMent_Page extends StatefulWidget {
  const ReplaceMent_Page({Key? key}) : super(key: key);

  @override
  State<ReplaceMent_Page> createState() => _ReplaceMent_PageState();
}

const List<String> list3 = <String>[
  "GST",
  "IGST",
];

const List<String> list = <String>[
  'Select Category',
];

const List<String> list2 = <String>[
  "Select Item",
];



class _ReplaceMent_PageState extends State<ReplaceMent_Page> {


  String dropdownValue = list.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = "";

   @override
  void initState() {
     setState(() {
       purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
       purchase_Time.text = "${DateFormat('hh:mm a').format(DateTime.now())}";

     });
     suppiernameaddfunction();
     getbillno();
     genratedocid();
     itemaddfunction();


    // TODO: implement initState
  }

  bool checkboxvalue=false;

   String Itemnamevalue='';
   String HsnCode="";
   String ItemCode="";
  bool status = true;
  bool status2 = false;
  String random = "";


final Formkey=GlobalKey<FormState>();


  TextEditingController purchase_No = TextEditingController();


  //purchase Date
  TextEditingController purchase_Date = TextEditingController();
  TextEditingController purchase_Time = TextEditingController();

  //purchase NOtes
  TextEditingController purchase_notes = TextEditingController();

  //suppierid
  TextEditingController suppierid = TextEditingController();

  //suppiler name
  TextEditingController suppiler_name = TextEditingController();

  //suppiler invoiceno
  TextEditingController suppiler_invoice = TextEditingController();

  TextEditingController suppiler_gstno = TextEditingController();

  //itemid
  TextEditingController itemid = TextEditingController();

  //item name
  TextEditingController Itemname = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController Qty = TextEditingController();

  //tax
  TextEditingController taxitem = TextEditingController();
  TextEditingController valueitem = TextEditingController();




  ///focus node

  FocusNode suppier_id = FocusNode();
  FocusNode suppiername = FocusNode();
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_time = FocusNode();
  FocusNode purchase_payment = FocusNode();
  FocusNode purchase_note = FocusNode();

  //item focus node
  FocusNode items_id = FocusNode();
  FocusNode items_value = FocusNode();
  FocusNode Quvantitylist = FocusNode();
  FocusNode Creditnoptes = FocusNode();
  List<String> Suppierlist = [];

  String Payments = "Please Select Type";
  List<String> Payment = [];


  ///Supplier name Search TextEditing controller
  TextEditingController layourbuilderclear = TextEditingController();

  ///Item name Search TextEditing controller
  TextEditingController layourbuilderclear2 = TextEditingController();


  ///Item Code Search TextEditing controller
  TextEditingController layourbuilderclear3 = TextEditingController();
  TextEditingController Suppliername = TextEditingController();
  TextEditingController Salesmanname = TextEditingController();
  checkfunc() async {
    var Documen = await FirebaseFirestore.instance
        .collection('Supplier')
        .where("Suppliername", isEqualTo: Suppliername.text)
        .get();
    if (Documen.docs.length > 0) {
      setState(() {
        customervalid = false;
      });
    } else {
      setState(() {
        customervalid = true;
      });
    }
  }


  suppiernameaddfunction() async {
    setState(() {
      Suppierlist.clear();
    });

    var Document = await FirebaseFirestore.instance
        .collection('Supplier')
        .orderBy("Suppliername", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      setState(() {
        Suppierlist.add(Document.docs[i]['Suppliername']);
      });

    }
  }

  String customerdocid = '';
  bool customervalid = false;
  check(name) async {
    var details = await FirebaseFirestore.instance.collection("Supplier").get();
    for (int i = 0; i < details.docs.length; i++) {
      if (name == details.docs[i]['Suppliername']) {
        setState(() {
          customervalid = false;
          layourbuilderclear.text = name;
          suppiler_name.text = details.docs[i]['Suppliername'];
          suppiler_gstno.text = details.docs[i]['Panno'];
          customerdocid = details.docs[i].id;
          suppierid.text = details.docs[i]['Suppliercode'];
        });
      }
    }
  }

  List<String> Itemlist = [];


  itemaddfunction() async {
    setState(() {
      Itemlist.clear();
    });
    if (status == true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaG')
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          Itemlist.add(Document.docs[i]['Newitemname']);
        });
      }
    }
    if (status2 == true) {
      setState(() {
        Itemlist.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          Itemlist.add(Document.docs[i]['Newitemname']);
        });
      }
    }
  }

  int billcount =0;

  getbillno() async {
    var document =  await FirebaseFirestore.instance.collection("Replacement").where("save",isEqualTo: true).get();
    setState(() {
      billcount = document.docs.length + 1;
      purchase_No.text = "RE${(billcount).toString().padLeft(3,"0")}";
    });
  }

  genratedocid(){

    setState(() {
      random = randomAlphaNumeric(16);
    });
  }
  String itemnames = '';


  bool showrelatedoitem=false;
  String showrelatedoitemname='';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width / 4.583, right: width / 56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
                inactiveToggleColor: Colors.grey,
                width: width / 30.35,
                height: height / 32.85,
                valueFontSize: 5.0,
                toggleSize: 20.0,
                value: status,
                borderRadius: 10.0,

                padding: 2.0,
                //showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    //billcounts();

                    if (val == true) {
                      setState(() {
                        status = val;
                        status2 = false;
                      });
                      // checkbillno();
                      // landingcost();
                      itemaddfunction();
                      // itemcodeaddfunction();
                      // checkgst(Purchase_price.text, Qty.text);
                      // clearallcontroller();
                    }
                    else {
                      setState(() {
                        status2 = val;
                        itemaddfunction();
                        // itemcodeaddfunction();
                      });
                    }
                  });
                },
              ),
            ),
            Text(
              "Shabika G",
              style: GoogleFonts.openSans(
                  color: Colors.white, fontSize: width / 80.353),
            ),
            SizedBox(width: width / 5.0),
            Padding(
              padding: EdgeInsets.only(
                  left: width / 4.583, right: width / 56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
                inactiveToggleColor: Colors.grey,
                width: width / 30.35,
                height: height / 32.85,
                valueFontSize: 5.0,
                toggleSize: 20.0,
                value: status2,
                borderRadius: 10.0,

                padding: 2.0,
                //showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    if (val == true) {
                      setState(() {
                        status2 = val;
                        status = false;
                      });
                      // checkbillno();
                      // landingcost();
                      itemaddfunction();
                      // itemcodeaddfunction();
                      // checkgst(Purchase_price.text, Qty.text);
                      // clearallcontroller();
                    } else {
                      setState(() {
                        status = val;
                      });
                      itemaddfunction();
                      // itemcodeaddfunction();
                    }
                  });
                },
              ),
            ),
            Text(
              "Shabika N",
              style: GoogleFonts.openSans(
                  color: Colors.white, fontSize: width / 80.353),
            ),
          ],
        ),
        //bill details
        Form(
          key: Formkey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //entry type container
              SizedBox(
                height: height / 6.054,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //suppiler Id
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Supplier ID",
                                style: GoogleFonts.openSans(
                                    fontSize: width/85,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff000000)),
                              ),
                            ),

                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(

                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,fontSize: width/85,),
                                controller: suppierid,
                                focusNode: suppier_id,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),

                                  border: InputBorder.none,
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                ),
                                onSubmitted: (_) {
                                  suppier_id.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(suppiername);
                                },
                              ),
                            ),
                            SizedBox(
                              width: width / 273.2,
                            ),
                           /* InkWell(
                              onTap: () {

                              },
                              child: customervalid != false
                                  ? Material(
                                shadowColor: Colors.black12,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                child: Container(
                                    height: height / 21.9,
                                    width: width / 10.53,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: width / 400.33),
                                        const Text("New Suppiler"),
                                        SizedBox(width: width / 455.33),
                                        const Icon(Icons.add),
                                      ],
                                    )),
                              )
                                  : GestureDetector(
                                onTap: (){
                                  itemcodegenrate();
                                  showdialpogbox2();
                                },
                                child: ClipOval(
                                    child: Container(
                                        height: height / 21.9,
                                        width: width / 45.53,
                                        color: Colors.white,
                                        child: const Icon(Icons.add))),
                              ),
                            )*/
                          ],
                        ),
                      ),

                      //suppiler name
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Supplier Name",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/85,
                                    color: const Color(0xff000000)),
                              ),
                            ),

                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: LayoutBuilder(
                                builder: (BuildContext, BoxConstraints) =>
                                    Autocomplete<String>(
                                      fieldViewBuilder: (context,
                                          yourbuilderclear,
                                          focusNode,
                                          onFieldSubmitted) {
                                        return TextFormField(
                                          onChanged: (_) {
                                            setState(() {
                                              layourbuilderclear =
                                                  yourbuilderclear;
                                            });
                                          },
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,fontSize: width/85,),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: width /90.78,
                                                top: height / 153.8),

                                            border: InputBorder.none,
                                            suffixIcon:
                                            Icon(Icons.circle,color:Colors.white),),
                                          controller: layourbuilderclear,
                                          focusNode: focusNode,
                                          onFieldSubmitted: (String value) {
                                            onFieldSubmitted();
                                          },
                                        );
                                      },
                                      optionsViewBuilder: (context, onSelected,
                                          options) =>
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Material(
                                                shape:
                                                const RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                      Radius.circular(
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
                                                          padding:
                                                          const EdgeInsets
                                                              .all(8.0),
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
                                          setState(() {
                                            //customervalid = false;
                                          });
                                          return const Iterable<String>.empty();
                                        }
                                        if (textEditingValue.text != "") {
                                          check(
                                              textEditingValue.text.toString());
                                          setState(() {
                                            Suppliername.text = textEditingValue
                                                .text
                                                .toString();
                                          });
                                          checkfunc();
                                        }
                                        return Suppierlist.where(
                                                (String option) {
                                              return option.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase());
                                            });
                                      },
                                      onSelected: (String selection) {
                                        check(selection);
                                        setState(() {
                                          Suppliername.text = selection;
                                          customervalid = false;
                                        });
                                        checkfunc();

                                        debugPrint(
                                            'You just selected $selection');
                                      },
                                      displayStringForOption: (Value) {
                                        return Value;
                                      },
                                      optionsMaxHeight: 50,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: width / 273.2,
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  suppierid.clear();
                                  layourbuilderclear.clear();
                                  suppiler_invoice.clear();
                                  suppiler_gstno.clear();
                                });
                              },
                              child: ClipOval(

                                  child: Container(
                                      height: height / 21.9,
                                      width: width / 45.53,
                                      color: Colors.white,
                                      child: IgnorePointer(child: const Icon(Icons.cancel_outlined,size: 20,)))),
                            ),
                          ],
                        ),
                      ),

                     /* //tax type
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Tax Type",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/85,
                                    color: const Color(0xff000000)),
                              ),
                            ),


                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child:
                                  DropdownButton2<String>(

                                    value: dropdownValue3,
                                    focusNode: suppiertax,
                                    isExpanded: true,
                                    isDense: true,
                                    alignment: Alignment.topCenter,
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width/85,),
                                    underline: Container(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue3 = value!;
                                      });
                                      if (dropdownValue3 == "IGST") {
                                        //Dropdowncontrollerclear();
                                      }
                                      suppiertax.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(suppierincoice_no);
                                    },
                                    items: list3
                                        .map<DropdownMenuItem<String>>(
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
                          ],
                        ),
                      ),

                      //suppiler Invoice no
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Supplier Invoice",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/85,
                                    color: const Color(0xff000000)),
                              ),
                            ),

                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please select a  Supplier Invoice No'
                                    : null,
                                controller: suppiler_invoice,
                                focusNode: suppierincoice_no,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,fontSize: width/85,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),

                                  border: InputBorder.none,
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ), */

                      //suppiler Gst no
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 328.5, left: width / 273.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 273.2,
                            ),
                            Container(
                              width: width / 9.0,
                              child: Text(
                                "Sales Man Name",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/85,
                                    color: const Color(0xff000000)),
                              ),
                            ),

                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? "Field Can't Empty"
                                    : null,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,fontSize: width/85,
                                ),
                                controller: Salesmanname,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),

                                  border: InputBorder.none,
                                  suffixIcon:
                                  Icon(Icons.circle,color:Colors.white),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 6.054,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Purchase No
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Container(
                            width: width / 9.0,
                            child: Text(
                              "Replace No",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/85,
                                  color: const Color(0xff000000)),
                            ),
                          ),

                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,fontSize: width/85,
                              ),
                              controller: purchase_No,
                              focusNode: purchase_no,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    top: height / 153.8),

                                border: InputBorder.none,
                                suffixIcon:
                                Icon(Icons.circle,color:Colors.white),

                              ),

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
                          Container(
                            width: width / 9.0,
                            child: Text(
                              "Replace  Date",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/85,
                                  color: const Color(0xff000000)),
                            ),
                          ),

                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                                fontSize: width/85,
                              ),
                              controller: purchase_Date,
                              focusNode: purchase_date,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
                                  hintText: "Date",
                                  border: InputBorder.none,
                                  suffixIcon:
                                  const Icon(Icons.calendar_month)),
                              onSubmitted: (_) {
                                purchase_date.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(purchase_payment);
                              },
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
                                  DateFormat('dd/MM/yyyy')
                                      .format(pickedDate);
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Container(
                            width: width / 9.0,
                            child: Text(
                              "Replace  Time",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/85,
                                  color: const Color(0xff000000)),
                            ),
                          ),

                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                                fontSize: width/85,
                              ),
                              controller: purchase_Time,
                              focusNode: purchase_time,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width /90.78,
                                      top: height / 153.8),
                                  hintText: "Time",
                                  border: InputBorder.none,
                                  suffixIcon:
                                  const Icon(Icons.timer)),
                              onSubmitted: (_) {
                                purchase_date.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(purchase_payment);
                              },
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
                                  DateFormat('dd/MM/yyyy')
                                      .format(pickedDate);
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

                  /*  //payment mode
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Container(
                            width: width / 9.0,
                            child: Text(
                              "Payment Mode",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/85,
                                  color: const Color(0xff000000)),
                            ),
                          ),

                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child:
                            DropdownButton2<String>(
                              alignment: Alignment.center,
                              value: Payments,
                              focusNode: purchase_payment,
                              isExpanded: true,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                                fontSize: width/85,),
                              underline: Container(
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  Payments = value!;
                                });
                                purchase_payment.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(purchase_note);
                              },
                              items: Payment.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Purchase Notes
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 328.5, left: width / 273.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 273.2,
                          ),
                          Container(
                            width: width / 9.0,
                            child: Text(
                              "Purchase Notes",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/85,
                                  color: const Color(0xff000000)),
                            ),
                          ),

                          Container(
                            width: width / 3.415,
                            height: height / 21.9,
                            //color:Colors.white,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,fontSize: width/85,
                              ),
                              controller: purchase_notes,
                              focusNode: purchase_note,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width /90.78,
                                    top: height / 153.8),

                                border: InputBorder.none,
                                suffixIcon:
                                Icon(Icons.circle,color:Colors.white),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),*/

                    // Craedit days

                  ],
                ),
              )
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Material(
              elevation: 50,
              shadowColor: Colors.black38,
              color: const Color(0xff1D5B79),
              child: Container(
                width: width / 0.976,
                height: height / 16.425,
                decoration: const BoxDecoration(
                  color: Color(0xff1D5B79),
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
                                color: Colors.white,
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
                                color: Colors.white,
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
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ),

                    SizedBox(width: width / 28.76),

                    //Box No
                    SizedBox(
                      width: width / 2.6,
                      child: Center(
                          child: Text(
                            "Problem",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ),


                    //Hsn Code



                    //quvantity
                    SizedBox(
                      width: width / 15.18,
                      child: Center(
                          child: Text(
                            "Qnty",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ),



                    //withou Tax


                    //Clear controllers
                    SizedBox(
                      width: width / 13.18,
                      child: Center(
                          child: Text(
                            "Clear ",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
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
                color: Colors.white,
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
                      textAlign: TextAlign.center,
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
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width / 130, right: width / 170),
                      child:
                      LayoutBuilder(
                        builder: (BuildContext , BoxConstraints )=>
                            Autocomplete<String>(
                              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                return
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(fontWeight: FontWeight.w700,),
                                    onChanged: (_){
                                      setState(() {
                                        layourbuilderclear2=textEditingController;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,

                                      /*   contentPadding: EdgeInsets.only(
                                              left: width /90.78,
                                              top: height / 150.0),*/
                                    ),
                                    controller: layourbuilderclear2,
                                    focusNode: focusNode,
                                    onFieldSubmitted: (String value) {
                                      onFieldSubmitted();
                                    },
                                  );
                              },
                              initialValue: TextEditingValue(
                                text: itemnames,
                              ),
                              optionsViewBuilder:(context, onSelected, options) => Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                    ),
                                    child: SizedBox(
                                      height: 52.0 * options.length,
                                      width: BoxConstraints.biggest.width,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: options.length,
                                        shrinkWrap: false,
                                        itemBuilder: (BuildContext , index) {
                                          final String option = options.elementAt(index);
                                          return InkWell(
                                            onTap: () => onSelected(option),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Text(option, style: GoogleFonts.openSans(fontWeight: FontWeight.w700),),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                              ),
                              optionsBuilder: (TextEditingValue textEditingValue) {

                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();

                                }

                                return
                                  Itemlist.where((String option) {
                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                  });
                              },
                              onSelected: (String selection) async {
                                if (Formkey.currentState!.validate()) {
                                  createpurchase2(selection.toString());
                                  setState(() {
                                    Itemname.text = selection;

                                  });
                                  if(status==true){
                                    var documents2 = await FirebaseFirestore.instance.collection("Item ShabikaG").where("Newitemname",isEqualTo:Itemname.text).get();
                                    if(documents2.docs.length>0){
                                      setState((){
                                        showrelatedoitem=true;
                                        showrelatedoitemname=Itemname.text;
                                      });

                                    }
                                  }
                                  if(status2==true){
                                    var documents2 = await FirebaseFirestore.instance.collection("Item ShabikaN").where("Newitemname",isEqualTo:Itemname.text).get();
                                    if(documents2.docs.length>0){
                                      setState((){
                                        showrelatedoitem=true;
                                        showrelatedoitemname=Itemname.text;
                                      });

                                    }
                                  }
                                  debugPrint('You just selected $selection');
                                }

                              },
                              displayStringForOption: (value){
                                return value;
                              },
                            ),
                      ),
                    ),

                  ),

                  //Box No
                  Container(
                    width: width / 2.5,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: problem,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                      onSubmitted: (_) {},
                    ),
                  ),

                  //Hsn Code


                  //quvantity
                  Container(
                    width: width / 16.8,
                    height: height / 21.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.6)),
                    child: TextField(
                      controller: Qty,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: width / 136.6, bottom: height / 65.7),
                      ),
                      onSubmitted: (_) {
                        FirebaseFirestore.instance.collection("Replacement").doc(random).set({
                          "billno":purchase_No.text,
                          "date":purchase_Date.text,
                          "time":purchase_Time.text,
                          "suppliername":Suppliername.text,
                          "supplierId":suppierid.text,
                          "salesman":Salesmanname.text,
                          "save":false,
                          "status":"Replacement",
                          "timestamp":DateTime.now().millisecondsSinceEpoch

                        });
                        FirebaseFirestore.instance.collection("Replacement").doc(random).collection(random).doc().set({
                          "itemid":itemid.text,
                          "itemname":Itemname.text,
                          "problem":problem.text,
                          "Qty":Qty.text,
                          "timestamp":DateTime.now().millisecondsSinceEpoch,
                          "recived":false,
                          "remarks":""
                        });

                        setState(() {
                          itemid.clear();
                          Itemname.clear();
                          problem.clear();
                          Qty.clear();
                          layourbuilderclear2.clear();

                        });
                      },
                      onTap: (){

                      },
                      onChanged: (_) {

                      },
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

              StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Replacement").doc(random).collection(random).orderBy("timestamp").snapshots(),
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
                      padding: EdgeInsets.only(bottom: 0),

                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Serial no
                          Container(
                            width: width / 45.533,
                            height: height / 21.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.6)),
                            child: Center(
                              child: Text("${(index+1).toString()}",style: TextStyle(
                                  fontSize: 15
                              ),),
                            ),

                          ),

                          //itemid
                          Container(
                            width: width / 14.2,
                            height: height / 21.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.6)),
                            child:
                            Center(child: Text("${billing['itemid']}",style: TextStyle(
                              fontSize: 15
                            ),)),
                          ),

                          //itemname
                          Container(
                            width: width / 2.7,
                            height: height / 21.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.6)),
                            child: Center(
                              child: Text("${billing['itemname']}",style: TextStyle(
                                  fontSize: 15
                              ),),
                            )

                          ),

                          //Box No
                          Container(
                            width: width / 2.5,
                            height: height / 21.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.6)),
                            child:Center(
                              child: Text("${billing['problem']}",style: TextStyle(
                                  fontSize: 15
                              ),),
                            )
                          ),

                          //Hsn Code


                          //quvantity
                          Container(
                            width: width / 16.8,
                            height: height / 21.9,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.6)),
                            child: Center(
                              child: Text("${billing['Qty']}",style: TextStyle(
                                  fontSize: 15
                              ),),
                            )
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

                    );
                  },
                );
              },
            )

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

                Savebill();
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
                        "Save Invoice",
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
  String itemcode = "";
  String itemdocuid = '';

   createpurchase2(name) async {
print("++++++++++++++++++++++++++++");
print(name);
       if(status==true){
         var documents = await FirebaseFirestore.instance.collection("Item ShabikaG").get();
         for (int i = 0; i < documents.docs.length; i++) {
           if ('${documents.docs[i]["Newitemname"]}' == name) {
             setState(() {
               itemcode = documents.docs[i]["Itemcode"].toString();
               itemid.text = documents.docs[i]["Itemcode"].toString();
               layourbuilderclear3.text=documents.docs[i]["Itemcode"].toString();
               layourbuilderclear2.text=documents.docs[i]["Newitemname"].toString();
               itemdocuid = documents.docs[i].id.toString();
             });
           }
         }

       }

       if(status2==true){
         print("shabika N-------------------------------------");
         var documents = await FirebaseFirestore.instance.collection("Item ShabikaN").get();
         for (int i = 0; i < documents.docs.length; i++) {
           if ('${documents.docs[i]["Newitemname"]})' == name) {
             setState(() {
               itemcode = documents.docs[i]["Itemcode"].toString();
               itemid.text = documents.docs[i]["Itemcode"].toString();
               layourbuilderclear3.text=documents.docs[i]["Itemcode"].toString();
               layourbuilderclear2.text=documents.docs[i]["Newitemname"].toString();
               itemdocuid = documents.docs[i].id.toString();
                     });

           }
         }

       }




   }

  /*documentctreatedunctiuon(){
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

  }*/


  Savebill(){

    FirebaseFirestore.instance.collection("Replacement").doc(random).update({
      "billno":purchase_No.text,
      "date":purchase_Date.text,
      "time":purchase_Time.text,
      "suppliername":Suppliername.text,
      "supplierId":suppierid.text,
      "salesman":Salesmanname.text,
      "save":true,
      "status":"Replacement",
      "timestamp":DateTime.now().millisecondsSinceEpoch

    });
    //"billstatus":"Replacement"
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
                      "Replace Bill Saved Successfully..",
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
                            setState(() {
                              random=  randomAlphaNumeric(16);
                              Suppliername.clear();
                              suppierid.clear();
                              Salesmanname.clear();
                              layourbuilderclear.clear();
                              layourbuilderclear3.clear();
                              purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                              purchase_Time.text = "${DateFormat('hh:mm a').format(DateTime.now())}";
                            });
                            getbillno();
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
