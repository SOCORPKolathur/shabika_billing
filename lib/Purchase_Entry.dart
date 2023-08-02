import 'dart:html';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:random_string/random_string.dart';
import 'package:pdf/widgets.dart' as p;

const List<String> list = <String>[
  'Select Category',
];



const List<String> list2 = <String>[
  "Select Item",
];

const List<String> list3 = <String>[
  "GST",
  "IGST",
];

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Paytm",
  "Credit Amount"
];


const List<String> Stateslect = <String>[
  "Select State",
  " Andhra Pradesh",
  " Arunachal Pradesh",
  " Assam",
  "Bihar",
  "Chhattisgarh",
  " Goa",
  ' Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  " Uttar Pradesh",
  "West Bengal",
];

class Purchase_Entry extends StatefulWidget {

  @override
  State<Purchase_Entry> createState() => _Purchase_EntryState();

}

class _Purchase_EntryState extends State<Purchase_Entry> {
  //categrory item variables and controller
  String dropdownValue = list.first;
  String dropdownValue3 = list3.first;
  String dropdownValue4 = "";
  String Payments = Payment.first;
  TextEditingController Purchase_price = TextEditingController();
  TextEditingController Qty = TextEditingController();
  TextEditingController Landing_cost = TextEditingController();
  TextEditingController Mrp_Price = TextEditingController();
  TextEditingController Creadit_days = TextEditingController();

  //hasn code and box no copntroller
  TextEditingController Box_NO = TextEditingController();
  TextEditingController HSN_Code = TextEditingController();
  TextEditingController Sales = TextEditingController();

  //purchase number
  TextEditingController purchase_No = TextEditingController();


  //purchase Date
  TextEditingController purchase_Date = TextEditingController();

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
  TextEditingController itemname = TextEditingController();

  //tax
  TextEditingController taxitem = TextEditingController();
  TextEditingController valueitem = TextEditingController();

  int vaalue = 0;


  ///focus node

  FocusNode suppier_id = FocusNode();
  FocusNode suppiername = FocusNode();
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_payment = FocusNode();
  FocusNode purchase_note = FocusNode();

  //item focus node
  FocusNode items_id = FocusNode();
  FocusNode items_value = FocusNode();
  FocusNode Quvantitylist = FocusNode();
  FocusNode Creditnoptes = FocusNode();


  ///Suppier list and itemname
  bool Loading = false;
  String itemnames = '';

  ///suppiler name add list
  List<String> Suppierlist = [];

  ///item code
  int itemcodes = 0;

  ///number formater using Bill count and firebase item document
  NumberFormat F = NumberFormat('00');


  ///Item ShabikaG Add the item List
  List<String> Itemlist = [];

  ///Item Code  Add the item List
  List<String> Itemlist2 = [];


  ///check the suppier name and other details check variables
  String customerdocid = '';
  bool customervalid = false;


  ///Item shabikaG and Item ShabikaN (toggle switch boolean)
  bool status = true;
  bool status2 = false;

  ///s Gst variable
  double sgst = 0;

  ///total amount varibles
  double TotalAmount2 = 0;

  ///Supplier name Search TextEditing controller
  TextEditingController layourbuilderclear = TextEditingController();

  ///Item name Search TextEditing controller
  TextEditingController layourbuilderclear2 = TextEditingController();

  ///Item Code Search TextEditing controller
  TextEditingController layourbuilderclear3 = TextEditingController();

  ///supplier functuon start
  ///popup update suppier textcontrollers
  TextEditingController Suppliername = TextEditingController();
  TextEditingController Supplieremail = TextEditingController();
  TextEditingController Suppliercode = TextEditingController();
  TextEditingController SupplierAddress = TextEditingController();
  TextEditingController State = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController Pincode = TextEditingController();
  TextEditingController Mobileno = TextEditingController();
  TextEditingController Mobileno2 = TextEditingController();
  TextEditingController Panno = TextEditingController();
  TextEditingController Openingbalance = TextEditingController();
  TextEditingController Remarks = TextEditingController();
  TextEditingController Loworder = TextEditingController();
  TextEditingController Stocks = TextEditingController();

  ///  Round of textediting controller
   TextEditingController rounof = TextEditingController();

  ///C Gst variable
  double Cgst = 0;

  ///iGSt varible
  double ISgtvalue = 0;

  ///sales price variable its calculate to Sgst and Cgst function
  double salespriceff = 0;
  ///random string generate variable
  String random = "";


  ///check the firebase document  boolean varibles
  bool serialvalue = false;
  bool imeivalue = false;
  bool color = false;
  bool image = false;

  ///item document varibles
  String itemcode = "dsgdgd";
  String hsncpode = "";
  String Boxno = "";
  String itemcat = '';
  String itembrand = '';
  String itemimei = '';
  String itemserial = '';
  String itemcolor = '';
  String itemdocuid = '';

  ///selected to set the value variables
  String itempurchaseprice = '';
  String itemlandingprice = '';
  String itemsalesprice = '';
  String itemcategory = '';
  String itembarnd = '';

  ///itemID serach variable
  bool itemserch = false;


  ///change the Itemcode varicble (Firebase document length)
  int Itemcount= 0;

  /// print invoice lists
  List Destription = [];
  List Quvantity = [];
  List Totalamount = [];
  List Tax = [];
  List Items = [];
  List Rate = [];
  List HSNcode = [];

  ///purchase billing total variable
  double totalamount = 0;

  ///bill count and number formatter varibles
  int billcount = 0;
  NumberFormat Fotmaterr = NumberFormat('000');

  /// suppiler popup varibales
  String Bill_Time = "";
  String Shipped_to = "";
  String Billed_to = "";


  ///text-field popup generate function(Listview Builder)
  List IMEISERIAL = [];
  List IMEI = [];
  List SERIAL = [];
  List colorlist = [];
  List Imagelist = [];
  bool popupLoading = false;
  bool popupLoading2 = false;
  bool Loading2 = false;



/// initstate function
  @override
  void initState() {
    setState(() {
      itemserch = false;
      status = true;
      purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      Qty.text = "1";
    });
    clearlistandname();
    suppiernameaddfunction();
    checkbillno();
    itemaddfunction();
    itemcodeaddfunction();

    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
        //Purchase_Entry
        Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //toggle switchs
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
                        billcounts();

                        if (val == true) {
                          setState(() {
                            status = val;
                            status2 = false;
                          });
                          billcounts();
                          landingcost();
                          itemaddfunction();
                          itemcodeaddfunction();
                          checkgst(Purchase_price.text, Qty.text);
                        } else {
                          setState(() {
                            status2 = val;
                            itemaddfunction();
                            itemcodeaddfunction();
                          });
                        }
                      });
                    },
                  ),
                ),
                Text(
                  "Shabika G",
                  style: GoogleFonts.solway(
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
                          billcounts();
                          landingcost();
                          itemaddfunction();
                          itemcodeaddfunction();
                          checkgst(Purchase_price.text, Qty.text);
                        } else {
                          setState(() {
                            status = val;
                          });
                          itemaddfunction();
                          itemcodeaddfunction();
                        }
                      });
                    },
                  ),
                ),
                Text(
                  "Shabika N",
                  style: GoogleFonts.solway(
                      color: Colors.white, fontSize: width / 80.353),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //entry type container
                SizedBox(
                  height: height / 4.054,
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
                              Text(
                                "Supplier ID",
                                style: GoogleFonts.poppins(
                                    fontSize: width / 97.57,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width / 21.9,
                              ),
                              Container(
                                width: width / 3.415,
                                height: height / 21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700),
                                  controller: suppierid,
                                  focusNode: suppier_id,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width / 130,
                                        bottom: height / 46.5),
                                    border: InputBorder.none,
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
                              InkWell(
                                onTap: () {
                                  if (customervalid == false) {
                                    alreadyexistshowdialpogbox();
                                  } else {
                                    itemcodegenrate();
                                    showdialpogbox2();
                                  }
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
                                    : ClipOval(
                                        child: Container(
                                            height: height / 21.9,
                                            width: width / 45.53,
                                            color: Colors.white,
                                            child: const Icon(Icons.add))),
                              )
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
                              Text(
                                "Supplier Name",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 97.57,
                                    color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width / 41.5,
                              ),
                              Container(
                                width: width / 3.415,
                                height: height / 21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: width / 130,
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
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: width / 273.2,
                                                  bottom: height / 43.8)),
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
                                            customervalid = false;
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
                            children: [
                              SizedBox(
                                width: width / 273.2,
                              ),
                              Text(
                                "Tax Type",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 97.57,
                                    color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width / 18.2,
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
                                    child: DropdownButton2<String>(
                                      value: dropdownValue3,
                                      focusNode: suppiertax,
                                      isExpanded: true,
                                      isDense: true,
                                      alignment: Alignment.topCenter,
                                      style: GoogleFonts.montserrat(
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
                                        if (dropdownValue3 == "IGST") {
                                          Dropdowncontrollerclear();
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
                              Text(
                                "Supplier Invoice No",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 97.57,
                                    color: const Color(0xff000000)),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Container(
                                width: width / 3.415,
                                height: height / 21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: suppiler_invoice,
                                  focusNode: suppierincoice_no,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width / 130,
                                        bottom: height / 46.5),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) {
                                    suppierincoice_no.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(purchase_no);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

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
                              Text(
                                "Supplier Gst No",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 97.57,
                                    color: const Color(0xff000000)),
                              ),
                              SizedBox(
                                width: width / 46.2,
                              ),
                              Container(
                                width: width / 3.415,
                                height: height / 21.9,
                                //color:Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  controller: suppiler_gstno,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width / 130,
                                        bottom: height / 46.5),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) {
                                    suppierincoice_no.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(purchase_no);
                                  },
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
                  height: height / 4.054,
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
                            Text(
                              "Purchase No",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 97.57,
                                  color: const Color(0xff000000)),
                            ),
                            SizedBox(
                              width: width / 44.0,
                            ),
                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                                controller: purchase_No,
                                focusNode: purchase_no,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130, bottom: height / 46.5),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  purchase_no.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(purchase_date);
                                },
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
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 97.57,
                                  color: const Color(0xff000000)),
                            ),
                            SizedBox(
                              width: width / 98.0,
                            ),
                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                                controller: purchase_Date,
                                focusNode: purchase_date,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: width / 130,
                                        bottom: height / 46.5),
                                    hintText: "Invoice Date",
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

                      //payment mode
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
                              "Payment Mode",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 97.57,
                                  color: const Color(0xff000000)),
                            ),
                            SizedBox(
                              width: width / 105.08,
                            ),
                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: DropdownButton2<String>(
                                value: Payments,
                                focusNode: purchase_payment,
                                isExpanded: true,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: width / 105.07),
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
                            Text(
                              "Purchase Notes",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 97.57,
                                  color: const Color(0xff000000)),
                            ),
                            SizedBox(
                              width: width / 147.6,
                            ),
                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                                controller: purchase_notes,
                                focusNode: purchase_note,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130, bottom: height / 46.5),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  purchase_note.unfocus();
                                  FocusScope.of(context).requestFocus(items_id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Craedit days
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
                              "Credit Days",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 97.57,
                                  color: const Color(0xff000000)),
                            ),
                            SizedBox(
                              width: width / 36.0,
                            ),
                            Container(
                              width: width / 3.415,
                              height: height / 21.9,
                              //color:Colors.white,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                                controller: Creadit_days,
                                focusNode: Creditnoptes,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: width / 130, bottom: height / 46.5),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  purchase_note.unfocus();
                                  FocusScope.of(context).requestFocus(items_id);
                                },
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
                          child: Center(
                              child: Text(
                            "Si No",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //itemid
                        SizedBox(
                          width: width / 14.2,
                          child: Center(
                              child: Text(
                            "Item ID",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //itemname
                        SizedBox(
                          width: width / 4.0,
                          child: Center(
                              child: Text(
                            "Item Name",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //Box No
                        SizedBox(
                          width: width / 18.0,
                          child: Center(
                              child: Text(
                            "Box No",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //Hsn Code
                        SizedBox(
                          width: width / 17.8,
                          child: Center(
                              child: Text(
                            "HSN Code",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //tax
                        SizedBox(
                          width: width / 27.18,
                          child: Center(
                              child: Text(
                            "Tax %",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //quvantity
                        SizedBox(
                          width: width / 21.7,
                          child: Center(
                              child: Text(
                            "Qnty",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //price
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                            "Price",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //landing cost
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                            "Landing Cost",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                        ),

                        //Sales Price
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                            "Sales Price",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //Mrp Price
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                            "MRP Price",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        //value
                        SizedBox(
                          width: width / 15.18,
                          child: Center(
                              child: Text(
                            "Value",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent),
                          )),
                        ),

                        //Low order quvantity
                        SizedBox(
                          width: width / 33.18,
                          child: Center(
                              child: Text(
                            "A\nQnty",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),

                        SizedBox(
                          width: width / 25.18,
                          child: Center(
                              child: Text(
                            "Stk",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                        //Clear controllers
                        SizedBox(
                          width: width / 16.18,
                          child: Center(
                              child: Text(
                            "Clear ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // color: Color(0xffFFFFFF),
                  width: width / 0.976,
                  decoration: const BoxDecoration(
                    color: Color(0xffb7b0aa),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Serial no
                      Container(
                        width: width / 46.533,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: width / 136.6, bottom: height / 65.7),
                              hintText: "1"),
                        ),
                      ),

                      //itemid
                      Container(
                        width: width / 14.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: LayoutBuilder(
                          builder: (BuildContext, BoxConstraints) =>
                              Autocomplete<String>(
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              return TextFormField(
                                onChanged: (_) {
                                  /*setState(() {
                                    layourbuilderclear3 = textEditingController;
                                  });

                                   */
                                },

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: width / 273.2,
                                        bottom: height / 43.8)),
                                controller: layourbuilderclear3,
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
                                          itemBuilder: (BuildContext, index) {
                                            final String option =
                                                options.elementAt(index);
                                            return InkWell(
                                              onTap: () => onSelected(option),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  option,
                                                ),
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
                               /* createpurchase3(
                                    textEditingValue.text.toString());
                                setState(() {
                                  itemid.text =
                                      textEditingValue.text.toString();
                                });
                                if (showpopup == true) {
                                  showdialpogboxitem();
                                }

                                */
                              }

                              return Itemlist2.where((String option) {
                                return option.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (String selection) {
                              /*
                              createpurchase3(selection.toString());
                              setState(() {
                                itemid.text = selection;
                              });
                              if (showpopup == true) {
                                showdialpogboxitem();
                              }

                              debugPrint('You just selected $selection');

                               */
                            },
                            displayStringForOption: (value) {
                              return value;
                            },
                          ),
                        ),
                        /* TextField(
                          controller: itemid,
                          focusNode: items_id,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                          ),
                          onSubmitted: (_){
                            items_id.unfocus();
                            FocusScope.of(context).requestFocus(items_value);
                          },

                        ),*/
                      ),

                      //itemname
                      Container(
                        width: width / 4.0,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width / 130, right: width / 170),
                          child:
                        /*  EasyAutocomplete(
                          controller:layourbuilderclear2 ,

                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              suggestions: Itemlist,
                              onChanged: (value2) {
                                createpurchase2(value2.toString());
                                setState(() {
                                  itemname.text = value2.toString();
                                  layourbuilderclear2.text = value2.toString();
                                });
                              },
                              onSubmitted: (value) {
                                createpurchase2(value.toString());
                                setState(() {
                                  itemname.text = value;
                                  layourbuilderclear2.text = value;
                                });

                                if(showpopup==true){
                                  showdialpogboxitem();
                                }
                              },
                                  ),*/
                        /*  TextField(
                            controller: layourbuilderclear2,
                            style: GoogleFonts.poppins(fontSize: width / 68.3,fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: width / 68.3, bottom: height / 82.125),
                              border: InputBorder.none,
                            ),
                            onTap: (){
                              setState(() {
                                isserach=true;
                              });
                            },
                            onChanged: (value){
                              if(layourbuilderclear2.text==""){
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
                          ),*/

                          LayoutBuilder(
                            builder: (BuildContext , BoxConstraints )=>
                                Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                    return
                                      TextFormField(
                                      onChanged: (_){
                                        setState(() {
                                          layourbuilderclear2=textEditingController;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/273.2,bottom:height/43.8)
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
                                                  child: Text(option,),
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

                                    if(textEditingValue.text!=""){
                                      /*
                                      createpurchase2(textEditingValue.text.toString());
                                      setState(() {
                                        itemname.text = textEditingValue.text.toString();
                                      });

                                       */


                                    }

                                    return
                                      Itemlist.where((String option) {
                                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                      });
                                  },
                                  onSelected: (String selection) {
                                    createpurchase2(selection.toString());
                                    setState(() {
                                      itemname.text = selection;
                                    });
                                    debugPrint('You just selected $selection');
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
                        width: width / 18.0,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
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
                        width: width / 17.8,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
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
                        width: width / 27.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
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
                        width: width / 21.7,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Qty,
                          focusNode: Quvantitylist,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            if (suppierid.text.length != 0 &&
                                suppiler_name.text.length != 0 &&
                                layourbuilderclear.text.length != 0 &&
                                Suppliername.text.length != 0) {
                              if (Qty.text.length > 0) {
                                if (Payments != 'Please Select Type') {
//Total function
                                  checkgst(Purchase_price.text, Qty.text);

                                  //check the imei and seriall functiom

                                  serialvalue == true ||
                                          imeivalue == true ||
                                          color == true ||
                                          image == true
                                      ?
                                      //create a document (Firebase)
                                      showtextfield(int.parse(Qty.text),
                                          serialvalue, imeivalue, color)
                                      : collectioncreatefunction();

                                  setState(() {
                                    IMEISERIAL.clear();
                                    IMEI.clear();
                                    SERIAL.clear();
                                    colorlist.clear();
                                    Imagelist.clear();
                                  });
                                  //multiple the value functions(Total)
                                  Quvantitylist.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(items_value);
                                } else {
                                  showdialpogboxsss();
                                }
                              }
                            } else {
                              showdialpogboxsss1();
                            }
                          },
                          onChanged: (_) {
                            if (suppierid.text.length != 0 &&
                                suppiler_name.text.length != 0 &&
                                layourbuilderclear.text.length != 0 &&
                                Suppliername.text.length != 0) {
                              if (Qty.text.length > 0) {
                                checkgst(Purchase_price.text, Qty.text);
                              }
                            } else {
                              showdialpogboxsss1();
                            }
                          },
                        ),
                      ),

                      //price
                      Container(
                        width: width / 15.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Purchase_price,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            alteritemcode();
                            landingcost();
                            checkgst(Purchase_price.text, Qty.text);
                          },
                        ),
                      ),

                      //landing cost
                      Container(
                        width: width / 15.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Landing_cost,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            alteritemcode();
                          },
                        ),
                      ),

                      //Sales Price
                      Container(
                        width: width / 15.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Sales,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            alteritemcode();
                          },
                        ),
                      ),

                      //Sales Price
                      Container(
                        width: width / 15.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Mrp_Price,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            alteritemcode();
                          },
                        ),
                      ),

                      //value
                      Container(
                        width: width / 15.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          style: const TextStyle(color: Colors.red),
                          controller: valueitem,
                          focusNode: items_value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                          onSubmitted: (_) {
                            if (suppierid.text.length != 0 &&
                                suppiler_name.text.length != 0 &&
                                layourbuilderclear.text.length != 0 &&
                                Suppliername.text.length != 0) {
                              if (Qty.text.length > 0) {
                                if (Payments != 'Please Select Type') {
                                  serialvalue == true ||
                                          imeivalue == true ||
                                          color == true ||
                                          image == true
                                      ?
                                      //create a document (Firebase)
                                      showtextfield(int.parse(Qty.text),
                                          serialvalue, imeivalue, color)
                                      : collectioncreatefunction();

                                  items_value.unfocus();
                                  FocusScope.of(context).requestFocus(items_id);
                                } else {
                                  showdialpogboxsss();
                                }
                              }
                            } else {
                              showdialpogboxsss1();
                            }
                          },
                        ),
                      ),

                      //Low order quvantity
                      Container(
                        width: width / 33.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
                        child: TextField(
                          controller: Loworder,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7),
                          ),
                        ),
                      ),

                      //Stock
                      Container(
                        width: width / 25.18,
                        height: height / 21.9,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 0.6)),
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
                          width: width / 16.18,
                          height: height / 21.9,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.6)),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                clearallcontroller();
                              },
                              child: const Icon(Icons.delete),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 131.4,
                ),
                Material(
                  elevation: 50,
                  shadowColor: Colors.black38,
                  color: const Color(0xffFFFFFF),
                  child: Container(
                    //color: Color(0xffFFFFFF),
                    width: width / 0.976,
                    height: height / 2.8,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Purchase entry")
                          .doc(random)
                          .collection(random)
                          .orderBy("timestamp")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData==null) {
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
                          physics: const ScrollPhysics(),
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
                                      child:
                                          Center(child: Text(" ${index + 1}"))),

                                  //itemid
                                  SizedBox(
                                      width: width / 14.2,
                                      height: height / 16.425,
                                      child: Center(
                                          child:
                                              Text("${billing['itemcode']}"))),

                                  //itemname
                                  SizedBox(
                                      width: width / 4.0,
                                      child: Text(
                                        '${billing['Description']},',
                                        textAlign: TextAlign.left,
                                      )),

                                  SizedBox(
                                    width: width / 18.0,
                                  ),

                                  //Hsn code
                                  SizedBox(
                                      width: width / 17.8,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(billing['Hsncode']))),

                                  //tax
                                  SizedBox(
                                      width: width / 27.18,
                                      height: height / 16.425,
                                      child:
                                          Center(child: Text(billing['tax']))),

                                  //quvantity
                                  SizedBox(
                                      width: width / 21.7,
                                      height: height / 16.425,
                                      child: Center(
                                          child:
                                              Text(billing['Qty'].toString()))),

                                  //price
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(billing['Purchase price']
                                              .toString()))),

                                  //landing cost
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(billing['Landing cost']
                                              .toString()))),

                                  //Sales Price
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(billing['Sales price']
                                              .toString()))),

                                  //MRP Price
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(billing['MRP price']
                                              .toString()))),

                                  //value
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                          child: Text(
                                        billing['Total'].toString(),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ))),

                                  //A Quvantity
                                  SizedBox(
                                      width: width / 18.5,
                                      height: height / 16.425,
                                      child: const Center(child: Text(""))),

                                  //remove
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            deletecollection(billing.id);
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
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding:
                  EdgeInsets.only(top: height / 131.4, left: width / 27.32),
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
                        width: width / 8.83,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width / 75.888),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  Loading = true;
                                });
                                //document create function
                                Purchaseitem();
                                //bill count function
                                Future.delayed(const Duration(seconds: 4), () {
                                  setState(() {
                                    Loading = false;
                                  });
                                  checkbillno();
                                  clearallcontroller();
                                  clearallcontroller2();
                                  //status update function
                                  Savebillpopup();
                                });
                              },
                              child: Container(
                                width: width / 5.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                    child: Text(
                                  "Save Invoice",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(height: height / 131.4),
                          Padding(
                            padding: EdgeInsets.only(left: width / 75.888),
                            child: InkWell(
                              onTap: () {
                                getvalue(
                                    suppierid.text,
                                    suppiler_name.text,
                                    dropdownValue3,
                                    suppiler_invoice.text,
                                    purchase_No.text,
                                    purchase_Date.text,
                                    Payments);
                              },
                              child: Container(
                                width: width / 5.6,
                                height: height / 16.42,
                                //color: Color(0xffD60A0B),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff0079FF),
                                ),
                                child: Center(
                                    child: Text(
                                  "Save And Print Invoice",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width / 6.415,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {

                            },
                            child: SizedBox(
                                width: width / 3.5,
                                height: height / 6.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          dropdownValue3 == "IGST"
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                      children: [
                                        dropdownValue3 == "IGST"
                                            ? SizedBox(width: width / 220.6)
                                            : const SizedBox(),

                                        //c gst amount
                                        dropdownValue3 == "IGST"
                                            ? SizedBox(
                                                height: height / 21.9,
                                                width: width / 14.0,
                                                child: Text(
                                                  "IGST(18%):",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              )
                                            : SizedBox(
                                                width: width / 14.0,
                                                height: height / 21.9,
                                                child: Text(
                                                  "C GST(9%):",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              ),
                                        dropdownValue3 == "IGST"
                                            ? SizedBox(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                child: Text(
                                                  IStfuntion(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              )
                                            : SizedBox(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                child: Text(
                                                  Cgst.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              ),
                                        SizedBox(height: height / 131.4),
                                        //S GSt amount
                                        dropdownValue3 == "IGST"
                                            ? const SizedBox()
                                            : SizedBox(
                                                width: width / 15.5,
                                                height: height / 21.9,
                                                child: Text(
                                                  "S GST(9%):",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              ),
                                        dropdownValue3 == "IGST"
                                            ? const SizedBox()
                                            : SizedBox(
                                                width: width / 13.66,
                                                height: height / 21.9,
                                                child: Text(
                                                  sgst.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: width / 85.375),
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: height / 65.7),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width / 455.33),
                                          child: SizedBox(
                                            width: width / 10.5,
                                            height: height / 16.42,
                                            child: Text(
                                              "Round Value",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: width / 85.375),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width / 6.83,
                                          height: height / 16.42,
                                          //color: Color(0xffDDDEEE),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: TextField(
                                            controller: rounof,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: GoogleFonts.poppins(
                                                fontSize: width / 91.06),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: width / 68.3,
                                                  bottom: height / 82.125),
                                              border: InputBorder.none,
                                            ),
                                            onSubmitted: (_) {
                                              totalamountwithroundof();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                              width: width / 6.0,
                              height: height / 6.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //sub total
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 17.075,
                                        child: Text(
                                          "Sub Total",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.indigoAccent,
                                              fontSize: width / 85.375),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 13.66,
                                        child: Text(
                                          ": ${totalamount.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.indigoAccent,
                                              fontSize: width / 85.375),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height / 131.4),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width / 17.075,
                                        height: height / 13.14,
                                        child: Text(
                                          "Total",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff00A99D),
                                              fontSize: width / 45.88),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 9.3,
                                        height: height / 13.14,
                                        child: Text(
                                          ":${TotalAmount2.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              textStyle: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              color: const Color(0xff00A99D),
                                              fontSize: width / 45.88),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Loading == true
            ? SizedBox(
                height: height / 2.38,
                width: width / 5.106,
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/FsRGzkbt6x.json",
                      height: height / 3.38,
                      width: width / 6.106,
                    ),
                    Text("Please Wait",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.black))
                  ],
                ),
              )
            : const SizedBox(),
      /*  isserach==true?SizedBox(
          height:200,
          width:300,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: Itemlist.length,
            itemBuilder: (context, index) {


              if(isserach==true&&Itemlist[index].toString().toLowerCase().startsWith(Username.toLowerCase())){
                return Container(
                  height:50,
                  width:200,
                  color:Colors.white,
                  child: Row(
                    children: [

                    GestureDetector(
                        onTap:(){
                          createpurchase2(Itemlist[index].toString());
                          setState(() {
                            itemname.text = Itemlist[index];
                            isserach=false;
                          });

                          if(showpopup==true){
                            showdialpogboxitem();
                          }
                        },
                        child: Text(Itemlist[index])),
                    ],
                  ),
                );
              }
              else if(isserach==false&&Itemlist[index].toString().toLowerCase().startsWith(Username.toLowerCase())){
                return
                  Container(
                height:50,
                width:200,
              color:Colors.white,
                child: Text(Itemlist[index]));
              }

              return  SizedBox();
            },
          ),
        ):SizedBox()*/
      ],
    );
  }




  ///Suppiler code genrate function.....
  itemcodegenrate() async {
    var document =
    await FirebaseFirestore.instance.collection("Supplier").get();
    setState(() {
      itemcodes = document.docs.length + 1;
      Suppliercode.text = "${"SB"}${F.format(itemcodes)}";
    });
  }

  ///Suppiler ID function.....
  setsuppierid(suppierids) async {
    var document =
    await FirebaseFirestore.instance.collection("Supplier").get();
    for (int i = 0; i < document.docs.length; i++) {
      if (suppierids == document.docs[i]['Suppliername']) {
        setState(() {
          suppierid.text = document.docs[i]['Suppliercode'];
        });
      }
    }
  }

  ///Suppiler name add function (Suppiler name to add to the supplier List ).....
  suppiernameaddfunction() async {
    setState(() {
      Suppierlist.clear();
    });

    var Document = await FirebaseFirestore.instance
        .collection('Supplier')
        .orderBy("Suppliername", descending: false)
        .get();
    for (int i = 0; i < Document.docs.length; i++) {
      Suppierlist.add(Document.docs[i]['Suppliername']);
    }
  }


  /// suppiler document create empty function
  customeradd() {
    FirebaseFirestore.instance.collection("Supplier").doc().set({
      "Suppliername": suppiler_name.text,
      "SupplierId": suppierid.text,
      "Suppliercode": "",
      "SupplierAddress": "",
      "State": "",
      "City": "",
      "Pincode": "",
      "Mobileno": "",
      "Panno": "",
      "Openingbalance": "",
      "Remarks": "",
      "Suppliername": "",
      "Email": "",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
    });
    clearcontroller();
  }

  ///Suppiler name and id and gst controller clear function
  clearcontroller() {
    suppiler_name.clear();
    suppierid.clear();
    suppiler_gstno.clear();
  }

  ///Item Name  Add the item List-function
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
          .orderBy("Newitemname", descending: false)
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
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          Itemlist.add(Document.docs[i]['Newitemname']);
        });
      }
    }
  }

  ///Item Code  Add the item List-function
  itemcodeaddfunction() async {
    setState(() {
      Itemlist2.clear();
    });
    if (status == true) {
      setState(() {
        Itemlist2.clear();
      });
      var Document = await FirebaseFirestore.instance.collection('Item ShabikaG').
      orderBy("Newitemname", descending: false).get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          Itemlist2.add(Document.docs[i]['Itemcode']);
        });
      }
    }
    if (status2 == true) {
      setState(() {
        Itemlist2.clear();
      });
      var Document = await FirebaseFirestore.instance
          .collection('Item ShabikaN')
          .orderBy("Newitemname", descending: false)
          .get();
      for (int i = 0; i < Document.docs.length; i++) {
        setState(() {
          Itemlist2.add(Document.docs[i]['Itemcode']);
        });
      }
    }
  }

  ///supplier name and other details is already exist or not check function
  check(name) async {
    var details = await FirebaseFirestore.instance.collection("Supplier").get();
    for (int i = 0; i < details.docs.length; i++) {
      if (name == details.docs[i]['Suppliername']) {
        setState(() {
          customervalid = false;
          suppiler_name.text = details.docs[i]['Suppliername'];
          suppiler_gstno.text = details.docs[i]['Panno'];
          customerdocid = details.docs[i].id;
          suppierid.text = details.docs[i]['Suppliercode'];
        });
      }
    }
  }

  ///supplier name and other details is already exist or not check(Status check and if is true change the state
  ///Boolean Variable --customervalid--) function
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

  ///histroy popup its item collection length 1 its show the popup
  showdialpogboxitem() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: Padding(
              padding: EdgeInsets.only(
                  top: height / 1.990,
                  bottom: height / 6.57,
                  left: width / 45.53,
                  right: width / 45.53),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  height: height / 2.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 65.7,
                        ),
                        Row(
                          children: [
                            SizedBox(width: width / 2.276),
                            Text(
                              "Purchase Histroy",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: width / 2.577),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ClipOval(
                                child: Container(
                                  height: height / 26.28,
                                  width: width / 54.64,
                                  color: Colors.red,
                                  child: const Center(
                                      child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height / 65.0,
                        ),
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
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: height / 164.25),
                              child: Row(
                                children: [
                                  //Serial no
                                  SizedBox(
                                      width: width / 45.533,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("Si\nNo"))),

                                  //itemid
                                  SizedBox(
                                      width: width / 14.2,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("Item Code"))),

                                  //itemname
                                  SizedBox(
                                      width: width / 4.5,
                                      child: const Text(
                                        'Item Name',
                                        textAlign: TextAlign.left,
                                      )),

                                  SizedBox(
                                      width: width / 11.8,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("Suppier Name"))),

                                  //Hsn code
                                  SizedBox(
                                      width: width / 11.8,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("HsnCode"))),

                                  //tax
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child:
                                          const Center(child: Text("Tax"))),

                                  //quvantity
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child:
                                          const Center(child: Text("Qty"))),

                                  //price
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child:
                                          const Center(child: Text("Price"))),

                                  //landing cost
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("Landing cost"))),

                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text(
                                        "Sales Price",
                                      ))),

                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text("Value",
                                              style: TextStyle(
                                                  color: Colors.red)))),
                                  SizedBox(
                                      width: width / 15.18,
                                      height: height / 16.425,
                                      child: const Center(
                                          child: Text(
                                        "Date\nTime",
                                      ))),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          elevation: 50,
                          shadowColor: Colors.black38,
                          color: const Color(0xffFFFFFF),
                          child: Container(
                            //color: Color(0xffFFFFFF),
                            width: width / 0.976,
                            height: height / 2.8,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: status == true
                                  ? FirebaseFirestore.instance
                                      .collection("Item ShabikaG")
                                      .doc(itemdocuid)
                                      .collection("Histroy")
                                      .orderBy("timestamp", descending: true)
                                      .snapshots()
                                  : status2 == true
                                      ? FirebaseFirestore.instance
                                          .collection("Item ShabikaN")
                                          .doc(itemdocuid)
                                          .collection("Histroy")
                                          .orderBy("timestamp",
                                              descending: true)
                                          .snapshots()
                                      : FirebaseFirestore.instance
                                          .collection("Item")
                                          .doc(itemdocuid)
                                          .collection("Histroy")
                                          .orderBy("timestamp",
                                              descending: true)
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
                                if (snapshot.data!.docs.length < 0) {
                                  return const Center(
                                    child: Text("NO Histroy"),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var billing = snapshot.data!.docs[index];
                                    return billing['save'] == true
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height / 164.25),
                                            child: Row(
                                              children: [
                                                //Serial no
                                                SizedBox(
                                                    width: width / 45.533,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(
                                                            " ${index + 1}"))),

                                                //itemid
                                                SizedBox(
                                                    width: width / 14.2,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(
                                                            "${billing['itemcode']}"))),

                                                //itemname
                                                SizedBox(
                                                    width: width / 4.5,
                                                    child: Text(
                                                      '${billing['Description']},',
                                                      textAlign:
                                                          TextAlign.left,
                                                    )),

                                                SizedBox(
                                                    width: width / 11.8,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                            'suppilername']))),

                                                //Hsn code
                                                SizedBox(
                                                    width: width / 11.8,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                            'Hsncode']))),

                                                //tax
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(
                                                            billing['tax']))),

                                                //quvantity
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                                'Qty']
                                                            .toString()))),

                                                //price
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                                'Purchase price']
                                                            .toString()))),

                                                //landing cost
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                                'Landing cost']
                                                            .toString()))),

                                                //Sales Price
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(billing[
                                                                'Sales price']
                                                            .toString()))),

                                                //value
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(
                                                      billing['Total']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ))),

                                                //remove
                                                SizedBox(
                                                    width: width / 15.18,
                                                    height: height / 16.425,
                                                    child: Center(
                                                        child: Text(
                                                      "${billing['date'].toString()}\n${billing['time'].toString()}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black),
                                                    ))),
                                              ],
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }


///Add New Supplier Popup its click the new supplier its show the popup
  showdialpogbox2() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 131.4, bottom: height / 131.4),
          child: SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: const Color(0xff264656),
                content: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width / 91.06,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width / 1.517,
                              top: height / 65.7,
                              bottom: height / 65.7),
                          child: Text(
                            "Add New Supplier",
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: width / 59.39,
                                color: const Color(0xffFFFFFF)),
                          ),
                        ),
                      ],
                    ),
                    Image.asset("assets/Line13.png"),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 21.015, top: height / 82.125),
                          child: Text(
                            "Supplier Name *",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 9.486, top: height / 82.125),
                          child: Text("Supplier Code*",
                              style: GoogleFonts.poppins(
                                  fontSize: width / 97.57,
                                  color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 9.757, top: height / 82.125),
                          child: Text(
                            "Supplier Address *",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 25.77,
                              top: height / 65.7,
                              right: width / 22.76),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Suppliername,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: height / 65.7,
                          ),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Suppliercode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 136.6),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: width / 82.125),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7, left: width / 27.32),
                          child: Container(
                            width: width / 2.55,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: SupplierAddress,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "Suppiler Address",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 23.55, top: height / 32.85),
                          child: Text(
                            "State",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 6.266, top: height / 32.85),
                          child: Text(
                            "City",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 5.991, top: height / 32.85),
                          child: Text(
                            "Pincode",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 8.130, top: height / 32.85),
                          child: Text(
                            "Mobile Number",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 12.418, top: height / 32.85),
                          child: Text(
                            "Mobile Number-2",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7,
                              right: width / 22.76,
                              left: width / 27.32),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: LayoutBuilder(
                              builder: (BuildContext, BoxConstraints) =>
                                  Autocomplete<String>(
                                fieldViewBuilder: (context,
                                    textEditingController,
                                    focusNode,
                                    onFieldSubmitted) {
                                  return textfield2(
                                    focusNode,
                                    textEditingController,
                                    onFieldSubmitted,
                                  );
                                },
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
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width / 85.375,
                                                            vertical: height /
                                                                41.0625),
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

                                  if (textEditingValue.text != "") {}
                                  return Stateslect.where((String option) {
                                    return option.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase());
                                  });
                                },
                                onSelected: (String selection) {
                                  setState(() {
                                    dropdownValue4 = selection;
                                    //to aasign the controller value
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7, right: width / 27.32),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: City,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7, right: width / 45.53),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Pincode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height / 65.7),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Mobileno,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "Mobile No 1",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7, left: width / 68.3),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Mobileno2,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "Mobile No 2",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 24.39, top: height / 32.85),
                          child: Text(
                            "EMail Id",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 6.898, top: height / 32.85),
                          child: Text(
                            "GST Number",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 28.458,
                              top: height / 82.125,
                              right: width / 45.533),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Supplieremail,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                border: InputBorder.none,
                                hintText: "Email",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 65.7,
                              right: width / 27.32,
                              left: width / 47.103),
                          child: Container(
                            width: width / 6.83,
                            height: height / 16.42,
                            //color: Color(0xffDDDEEE),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              controller: Panno,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style:
                                  GoogleFonts.poppins(fontSize: width / 91.06),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: width / 68.3, bottom: 8),
                                hintText: "GSt No",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height / 32.85, right: width / 1.258),
                      child: Text(
                        "Remarks",
                        style: GoogleFonts.poppins(
                            fontSize: width / 97.57, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width / 3.902, top: height / 82.125),
                      child: Container(
                        height: height / 7.3,
                        width: width / 1.70,
                        //color: Color(0xffDDDEEE),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          controller: Remarks,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: GoogleFonts.poppins(fontSize: width / 91.06),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: width / 68.3),
                            hintStyle: GoogleFonts.poppins(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 20.08, top: height / 32.85),
                          child: GestureDetector(
                            onTap: () {
                              showdialpogbox();
                            },
                            child: Container(
                              width: width / 8.6,
                              height: height / 16.42,
                              //color: Color(0xffD60A0B),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffD60A0B),
                              ),
                              child: Center(
                                  child: Text(
                                "Save Supplier",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: width / 91.06),
                              )),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            clearallcontroller();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: width / 75.888, top: height / 32.85),
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
                  ],
                )),
          ),
        );
      },
    );
  }

  ///Add New Supplier successfull popup
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.760, bottom: height / 4.760),
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
                        "Add a Supplier Item Successfully",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.3,
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
                              Supplierfunction();
                              suppiernameaddfunction();
                              clearallcontrollers();
                              Navigator.pop(context);
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

  ///Add New Supplier Claer controller function
  clearallcontrollers() {
    Suppliercode.clear();
    SupplierAddress.clear();
    State.clear();
    City.clear();
    Pincode.clear();
    Mobileno.clear();
    Mobileno2.clear();
    Panno.clear();
    Openingbalance.clear();
    Remarks.clear();
    Suppliername.clear();
    Supplieremail.clear();
    setState(() {
      dropdownValue = 'Please Select Category';
      dropdownValue4 = 'Select State';
      hsncpode = "";
      Boxno = "";
    });
  }


  ///Suppiler document create function
  Supplierfunction() {
    FirebaseFirestore.instance.collection("Supplier").doc().set({
      "Suppliercode": Suppliercode.text,
      "SupplierAddress": SupplierAddress.text,
      "State": dropdownValue4,
      "City": City.text,
      "Pincode": Pincode.text,
      "Mobileno": Mobileno.text,
      "Mobileno2": Mobileno2.text,
      "Panno": Panno.text,
      "Remarks": Remarks.text,
      "Suppliername": Suppliername.text,
      "Email": Supplieremail.text,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "Openingbalance": ""
    });
  }

  //...................................end supplier functions

  ///item details clear controller-function(only)
  clearallcontroller() {
    setState(() {
      hsncpode = "";
      Boxno = "";
      vaalue = 0;
      itemsalesprice = "";
      itemlandingprice = "";
      itempurchaseprice = "";
      itemnames = "";
      itemcolor = '';
    });
    Purchase_price.clear();
    Qty.clear();
    layourbuilderclear2.clear();
    layourbuilderclear3.clear();
    Landing_cost.clear();
    Loworder.clear();
    Stocks.clear();
    //itemid
    itemid.clear();
    //item name
    itemname.clear();
    taxitem.clear();
    valueitem.clear();
    Sales.clear();
    Mrp_Price.clear();
    Box_NO.clear();
    HSN_Code.clear();

  }

  ///suppier name and payment and total and so on controller clear function
  clearallcontroller2() {
    setState(() {
      Payments = Payment.first;
      dropdownValue3 = list3.first;
    });
    //purchase Date
    //purchase NOtes
    purchase_notes.clear();
    //purchase number
    purchase_No.clear();
    //suppierid
    Creadit_days.clear();
    suppierid.clear();
    //suppiler name
    suppiler_name.clear();
    //suppiler invoiceno
    suppiler_invoice.clear();
    suppiler_gstno.clear();
    layourbuilderclear.clear();
    rounof.clear();
    setState(() {
      Cgst = 0;
      sgst = 0;
      totalamount = 0;
      TotalAmount2 = 0;
    });
  }

  ///dropdown selcted the IGSt to clear the all Controller
  ///clear the controller and its work if change the GSt To IGst to change dropdown the value its controller cleared
  Dropdowncontrollerclear() {
    setState(() {
      random = randomAlphaNumeric(16);
      Cgst = 0;
      sgst = 0;
      totalamount = 0;
      TotalAmount2 = 0;
    });

    layourbuilderclear.clear();
    rounof.clear();
    Purchase_price.clear();
    Qty.clear();
    Landing_cost.clear();
    Loworder.clear();
    Stocks.clear();
    //itemid
    itemid.clear();
    //item name
    itemname.clear();
    taxitem.clear();
    valueitem.clear();
    Sales.clear();
    Mrp_Price.clear();
    Box_NO.clear();
    HSN_Code.clear();
  }


  ///in this function to multiplay the item purchase price and item quvantity to result to set the value textediting controller
  checkgst(purchase, qty) {
    setState(() {
      valueitem.text =
          (((double.parse(purchase.toString())) * double.parse(qty))
              .toString());
    });
  }


  ///landing cost function and in this function  item purchase price to add 18%gst to add the show the result-- function
  landingcost() {
    if (status == true) {
      setState(() {
        Landing_cost.text = ((18 / 100) * double.parse(Purchase_price.text) +
                double.parse(Purchase_price.text))
            .toStringAsFixed(2);
      });
    }
    if (status2 == true) {
      Landing_cost.text = Purchase_price.text;
    }
  }


///sgst function
  SGSTfunction() {
    setState(() {
      sgst = 0;
    });

    if (status2 == true) {
      setState(() {
        sgst = (salespriceff - (salespriceff / (1.18))) / 2;
      });
      return sgst;
    }
    if (status == true) {
      setState(() {
        sgst = (9 / 100) * totalamount;
      });
      return sgst;
    }
  }

  ///total amount functions
  Totalamounts() {
    setState(() {
      TotalAmount2 = 0;
    });

    if (status2 == true) {
      setState(() {
        TotalAmount2 = totalamount;
        totalamount = (totalamount / 1.18);
      });
    }
    if (status == true) {
      setState(() {
        TotalAmount2 = totalamount + sgst + Cgst;
      });
    }
    if (TotalAmount2 > double.parse(TotalAmount2.round().toString())) {
      setState(() {
        rounof.text =
            (TotalAmount2 - double.parse(TotalAmount2.round().toString()))
                .toStringAsFixed(2);
        TotalAmount2 = TotalAmount2 -
            (TotalAmount2 - double.parse(TotalAmount2.round().toString()));
      });
    } else {
      setState(() {
        rounof.text =
            (double.parse(TotalAmount2.round().toString()) - TotalAmount2)
                .toStringAsFixed(2);
        TotalAmount2 = TotalAmount2 +
            (double.parse(TotalAmount2.round().toString()) - TotalAmount2);
      });
    }
  }

  ///Total amount round opf function
  totalamountwithroundof() {
    setState(() {
      TotalAmount2 = 0;
    });
    if (status2 == true) {
      setState(() {
        TotalAmount2 =
            (totalamount / 1.18) + sgst + Cgst + double.parse(rounof.text);
      });
    }
    if (status == true) {
      setState(() {
        TotalAmount2 = totalamount + sgst + Cgst + double.parse(rounof.text);
      });
    }
  }

  ///cgst function
  CGSTfunction() {
    setState(() {
      Cgst = 0;
    });

    if (status2 == true) {
      setState(() {
        Cgst = (salespriceff - (salespriceff / (1.18))) / 2;
      });
    }
    if (status == true) {
      setState(() {
        Cgst = (9 / 100) * totalamount;
      });
      return Cgst;
    }

  }

  ///isgt function
  IStfuntion() {
    setState(() {
      ISgtvalue = 0;
    });
    ISgtvalue = Cgst + sgst;

    return ISgtvalue.toStringAsFixed(2);
  }

  ///random string generate function
  checkbillno() {
    setState(() {
      random = randomAlphaNumeric(16);
    });
    billcounts();
  }

  ///save bill function its change status  false into true(only show the true documents)
  savebillfunction() {
    FirebaseFirestore.instance.collection("Purchase entry").doc(random).update({"save": true});
    FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(random).update({"save": true});
    FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(random).update({"save": true});
  }

  ///item name search and set the value function
  createpurchase2(name) async {
    if (layourbuilderclear.text != "" &&
        Suppliername.text != "" &&
        suppiler_invoice.text != "") {
      if (status == true) {
        var documents =
            await FirebaseFirestore.instance.collection("Item ShabikaG").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if (name == documents.docs[i]["Newitemname"]) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              valueitem.text = documents.docs[i]["Purchaseprice"].toString();
              itemcategory = documents.docs[i]["Category"].toString();
              itembarnd = documents.docs[i]["Brand"].toString();
              itemdocuid = documents.docs[i].id.toString();
              hsncpode = documents.docs[i]["HSNCode"].toString();
              layourbuilderclear3.text = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text = documents.docs[i]["Newitemname"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              itemname.text = documents.docs[i]["Newitemname"].toString();
              itemnames = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Qty.text = "1";
              Purchase_price.text =
                  documents.docs[i]["Purchaseprice"].toString();
              Landing_cost.text = documents.docs[i]["Landingcost"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Mrp_Price.text = documents.docs[i]["MRPPrice"].toString();
              if (documents.docs[i]["Purchaseprice"] != "") {
                salespriceff =
                    double.parse(documents.docs[i]["Purchaseprice"].toString());
              } else {
                salespriceff = 0;
              }
              itemcat = documents.docs[i]["Category"].toString();
              itembrand = documents.docs[i]["Brand"].toString();
              itemimei = documents.docs[i]["IMEI NO"].toString();
              itemserial = documents.docs[i]["Serial NO"].toString();
              itemcolor = documents.docs[i]["Color"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              itemsalesprice = documents.docs[i]["Saleprice"].toString();
              itemlandingprice = documents.docs[i]["Landingcost"].toString();
              itempurchaseprice = documents.docs[i]["Purchaseprice"].toString();
              serialvalue = documents.docs[i]["Serial NO"];
              image = documents.docs[i]["Image"];
              imeivalue = documents.docs[i]["IMEI NO"];
              color = documents.docs[i]["Color"];
              itemserch = false;
            });
            landingcost();
          }
        }
      }

      //Item ShabikaG document length
      if (itemdocuid.isNotEmpty && status == true) {
        var histroycollection2 = await FirebaseFirestore.instance
            .collection("Item ShabikaG")
            .doc(itemdocuid)
            .collection("Histroy")
            .get();
        if (histroycollection2.docs.length > 1) {
            showdialpogboxitem();
        }
      }

      if (status2 == true) {
        var documents =
            await FirebaseFirestore.instance.collection("Item ShabikaN").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if (name == documents.docs[i]["Newitemname"]) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              itemcategory = documents.docs[i]["Category"].toString();
              itembarnd = documents.docs[i]["Brand"].toString();
              itemdocuid = documents.docs[i].id.toString();
              hsncpode = documents.docs[i]["HSNCode"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear3.text =
                  documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text =
                  documents.docs[i]["Newitemname"].toString();
              itemname.text = documents.docs[i]["Newitemname"].toString();
              itemnames = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Qty.text = "1";
              Purchase_price.text =
                  documents.docs[i]["Purchaseprice"].toString();
              Landing_cost.text = documents.docs[i]["Landingcost"].toString();
              valueitem.text = documents.docs[i]["Purchaseprice"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Mrp_Price.text = documents.docs[i]["MRPPrice"].toString();
              if (documents.docs[i]["Purchaseprice"] != "") {
                salespriceff =
                    double.parse(documents.docs[i]["Purchaseprice"].toString());
              } else {
                salespriceff = 0;
              }
              itemcat = documents.docs[i]["Category"].toString();
              itembrand = documents.docs[i]["Brand"].toString();
              itemimei = documents.docs[i]["IMEI NO"].toString();
              itemserial = documents.docs[i]["Serial NO"].toString();
              itemcolor = documents.docs[i]["Color"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              itemsalesprice = documents.docs[i]["Saleprice"].toString();
              itemlandingprice = documents.docs[i]["Landingcost"].toString();
              itempurchaseprice = documents.docs[i]["Purchaseprice"].toString();
              serialvalue = documents.docs[i]["Serial NO"];
              image = documents.docs[i]["Image"];
              imeivalue = documents.docs[i]["IMEI NO"];
              color = documents.docs[i]["Color"];
              itemserch = false;
            });
            landingcost();
          }
        }
      }
      //Item ShabikaN document length
      if (itemdocuid.isNotEmpty && status2 == true) {
        var histroycollection3 = await FirebaseFirestore.instance
            .collection("Item ShabikaN")
            .doc(itemdocuid)
            .collection("Histroy")
            .get();
        if (histroycollection3.docs.length > 1) {
            showdialpogboxitem();
        }
      }

      FirebaseFirestore.instance.collection("Purchase entry").doc(random).set({
        "Total": "",
        "itemcode": itemcode,
        "Payment mode": Payments,
        "Hsncode": HSN_Code.text,
        "suppilerid": suppierid.text,
        "suppilername": suppiler_name.text,
        "suppilergst": suppiler_gstno.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "suppilierinvoiceno": suppiler_invoice.text,
        "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        "BoxNo": Boxno,
        "save": false,
        "return": false,
        "time": DateFormat.jm().format(DateTime.now()),
        "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch
      });

      if (status == true) {
        FirebaseFirestore.instance
            .collection("Purchase ShabikaG")
            .doc(random)
            .set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": HSN_Code.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "save": false,
          "return": false,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
      }

      if (status2 == true) {
        FirebaseFirestore.instance
            .collection("Purchase ShabikaN")
            .doc(random)
            .set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": hsncpode,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "save": false,
          "return": false,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
      }
      checkgst(Purchase_price.text, Qty.text);

    } else {
      showdialpogboxsss1();
    }
  }

  ///item ID search and set the value function
  createpurchase3(name) async {
    setState(() {
      itemserch = false;
    });
    if (layourbuilderclear3.text != "" &&
        layourbuilderclear.text != "" &&
        Suppliername.text != "" &&
        suppiler_invoice.text != "") {
      if (status == true) {
        var documents =
            await FirebaseFirestore.instance.collection("Item ShabikaG").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if (name == documents.docs[i]["Itemcode"]) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              itemcategory = documents.docs[i]["Category"].toString();
              itembarnd = documents.docs[i]["Brand"].toString();
              itemdocuid = documents.docs[i].id.toString();
              hsncpode = documents.docs[i]["HSNCode"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear3.text =
                  documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text =
                  documents.docs[i]["Newitemname"].toString();
              itemnames = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Qty.text = "1";
              Purchase_price.text =
                  documents.docs[i]["Purchaseprice"].toString();
              Landing_cost.text = documents.docs[i]["Landingcost"].toString();
              valueitem.text = documents.docs[i]["Purchaseprice"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Mrp_Price.text = documents.docs[i]["MRPPrice"].toString();
              if (documents.docs[i]["Purchaseprice"] != "") {
                salespriceff =
                    double.parse(documents.docs[i]["Purchaseprice"].toString());
              } else {
                salespriceff = 0;
              }
              itemcat = documents.docs[i]["Category"].toString();
              itembrand = documents.docs[i]["Brand"].toString();
              itemimei = documents.docs[i]["IMEI NO"].toString();
              itemserial = documents.docs[i]["Serial NO"].toString();
              itemcolor = documents.docs[i]["Color"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              itemsalesprice = documents.docs[i]["Saleprice"].toString();
              itemlandingprice = documents.docs[i]["Landingcost"].toString();
              itempurchaseprice = documents.docs[i]["Purchaseprice"].toString();
              serialvalue = documents.docs[i]["Serial NO"];
              image = documents.docs[i]["Image"];
              imeivalue = documents.docs[i]["IMEI NO"];
              color = documents.docs[i]["Color"];
              itemserch = true;
            });
            landingcost();

          }
        }
      }

      if (status2 == true) {
        var documents =
            await FirebaseFirestore.instance.collection("Item ShabikaN").get();
        for (int i = 0; i < documents.docs.length; i++) {
          if (name == documents.docs[i]["Newitemname"]) {
            setState(() {
              itemcode = documents.docs[i]["Itemcode"].toString();
              itemcategory = documents.docs[i]["Category"].toString();
              itembarnd = documents.docs[i]["Brand"].toString();
              itemdocuid = documents.docs[i].id.toString();
              hsncpode = documents.docs[i]["HSNCode"].toString();
              itemid.text = documents.docs[i]["Itemcode"].toString();
              layourbuilderclear3.text =
                  documents.docs[i]["Itemcode"].toString();
              layourbuilderclear2.text =
                  documents.docs[i]["Newitemname"].toString();
              itemname.text = documents.docs[i]["Newitemname"].toString();
              itemnames = documents.docs[i]["Newitemname"].toString();
              taxitem.text = documents.docs[i]["gst"].toString();
              Loworder.text = documents.docs[i]["Loworder"].toString();
              Qty.text = "1";
              Purchase_price.text =
                  documents.docs[i]["Purchaseprice"].toString();
              Landing_cost.text = documents.docs[i]["Landingcost"].toString();
              valueitem.text = documents.docs[i]["Purchaseprice"].toString();
              Stocks.text = documents.docs[i]["TotalQuvantity"].toString();
              Mrp_Price.text = documents.docs[i]["MRPPrice"].toString();
              if (documents.docs[i]["Purchaseprice"] != "") {
                salespriceff =
                    double.parse(documents.docs[i]["Purchaseprice"].toString());
              } else {
                salespriceff = 0;
              }
              itemcat = documents.docs[i]["Category"].toString();
              itembrand = documents.docs[i]["Brand"].toString();
              itemimei = documents.docs[i]["IMEI NO"].toString();
              itemserial = documents.docs[i]["Serial NO"].toString();
              itemcolor = documents.docs[i]["Color"].toString();
              Box_NO.text = documents.docs[i]["BoxNo"].toString();
              HSN_Code.text = documents.docs[i]["HSNCode"].toString();
              Sales.text = documents.docs[i]["Saleprice"].toString();
              itemsalesprice = documents.docs[i]["Saleprice"].toString();
              itemlandingprice = documents.docs[i]["Landingcost"].toString();
              itempurchaseprice = documents.docs[i]["Purchaseprice"].toString();
              serialvalue = documents.docs[i]["Serial NO"];
              image = documents.docs[i]["Image"];
              imeivalue = documents.docs[i]["IMEI NO"];
              color = documents.docs[i]["Color"];
              itemserch = true;
            });
            landingcost();
          }
        }
      }



      //Item ShabikaG document length
      if (itemdocuid.isNotEmpty && status == true && itemserch == true) {
        var histroycollection2 = await FirebaseFirestore.instance
            .collection("Item ShabikaG")
            .doc(itemdocuid)
            .collection("Histroy")
            .get();
        if (histroycollection2.docs.length > 1) {
            showdialpogboxitem();
        }
      }

      //Item ShabikaN document length
      if (itemdocuid.isNotEmpty && status2 == true && itemserch == true) {
        var histroycollection3 = await FirebaseFirestore.instance
            .collection("Item ShabikaN")
            .doc(itemdocuid)
            .collection("Histroy")
            .get();
        if (histroycollection3.docs.length > 1) {
            showdialpogboxitem();
        }
      }

      FirebaseFirestore.instance.collection("Purchase entry").doc(random).set({
        "Total": "",
        "itemcode": itemcode,
        "Payment mode": Payments,
        "Hsncode": HSN_Code.text,
        "suppilerid": suppierid.text,
        "suppilername": suppiler_name.text,
        "suppilergst": suppiler_gstno.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "tax": taxitem.text,
        "suppilierinvoiceno": suppiler_invoice.text,
        "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        "BoxNo": Boxno,
        "save": false,
        "return": false,
        "time": DateFormat.jm().format(DateTime.now()),
        "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch
      });

      if (status == true) {
        FirebaseFirestore.instance
            .collection("Purchase ShabikaG")
            .doc(random)
            .set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": HSN_Code.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "save": false,
          "return": false,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
      }

      if (status2 == true) {
        FirebaseFirestore.instance
            .collection("Purchase ShabikaN")
            .doc(random)
            .set({
          "Total": "",
          "itemcode": itemcode,
          "Payment mode": Payments,
          "Hsncode": hsncpode,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          "BoxNo": Boxno,
          "save": false,
          "return": false,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch
        });
      }
      checkgst(Purchase_price.text, Qty.text);

    } else {
      showdialpogboxsss1();
    }
  }


  /// Stream document create functions and total sub total and item update and item create functions
  collectioncreatefunction() async {
    if (Payments != 'Please Select Type'&&itemdocuid.isNotEmpty) {
      FirebaseFirestore.instance.collection("Purchase entry").doc(random).collection(random).doc().set({
        "Total": double.parse(valueitem.text).toStringAsFixed(2),
        "Payment mode": Payments,
        "itemcode": status == true ? "G$itemcode" : "N$itemcode",
        "Hsncode": HSN_Code.text,
        "BoxNo": Box_NO.text,
        "suppilerid": suppierid.text,
        "suppilername": suppiler_name.text,
        "suppilergst": suppiler_gstno.text,
        "purchaseno": purchase_No.text,
        "purchasedate": purchase_Date.text,
        "purchasenote": purchase_notes.text,
        "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
        "tax": taxitem.text,
        "suppilierinvoiceno": suppiler_invoice.text,
        "time": DateFormat.jm().format(DateTime.now()),
        "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "Category": itemcat,
        "Brand": itembrand,
        "Item": itemname.text,
        "Purchase price": double.parse(Purchase_price.text).toStringAsFixed(2),
        "Sales price": double.parse(Sales.text).toStringAsFixed(2),
        "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
        "Qty": Qty.text,
        "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
        "IMEI NO": itemimei,
        "Serial NO": itemserial,
        "Color": itemcolor,
        "credit days": Creadit_days.text,
        // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
        "Description":
            "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
        "IMSlist": IMEISERIAL,
      });
      FirebaseFirestore.instance.collection("Supplier").doc(customerdocid).collection("billing").doc(random).set({
        "save": false,
      });
      if (customerdocid.isNotEmpty) {
        FirebaseFirestore.instance.collection("Supplier").doc(customerdocid).collection("billing").doc(random).collection("Purxhase billing").doc()
            .set({
          "Total": double.parse(valueitem.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": status == true ? "G$itemcode" : "N$itemcode",
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "Purchase price":
              double.parse(Purchase_price.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description": "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "IMSlist": IMEISERIAL,
        });
      }

      if (status == true) {
        FirebaseFirestore.instance.collection("Item ShabikaG").doc(itemdocuid).update({
          "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
          "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
          "gst": taxitem.text != "" ? taxitem.text : "",
          "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
          "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
          "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
          "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
          "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
          "IMSlist": IMEISERIAL,
          "Imei no": IMEI,
          "Serial no": SERIAL,
          "color": colorlist,
          "Image list": Imagelist,
          "Newitemname": layourbuilderclear2.text,
          "Itemcode": layourbuilderclear3.text,
        });

        FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(random).collection(random).doc().set({
          "Total": double.parse(valueitem.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": status == true ? "G$itemcode" : "N$itemcode",
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "Purchase price":
              double.parse(Purchase_price.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description":
              "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "IMSlist": IMEISERIAL,
        });

        FirebaseFirestore.instance.collection("Item ShabikaG").doc(itemdocuid).collection("Histroy").doc().set({
          "Total": double.parse(valueitem.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": itemcode,
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "save": true,
          "suppilierinvoiceno": suppiler_invoice.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "Purchase price":
              double.parse(Purchase_price.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description":
              "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "IMSlist": IMEISERIAL,
        });
      }

      if (status2 == true) {

        FirebaseFirestore.instance.collection("Item ShabikaN").doc(itemdocuid).update({
          "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
          "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
          "gst": taxitem.text != "" ? taxitem.text : "",
          "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
          "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
          "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
          "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
          "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
          "IMSlist": IMEISERIAL,
          "Imei no": IMEI,
          "Serial no": SERIAL,
          "color": colorlist,
          "Image list": Imagelist,
          "Newitemname": layourbuilderclear2.text,
          //"Itemcode": layourbuilderclear3.text,
        });

        FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(random).collection(random).doc()
            .set({
          "Total": double.parse(valueitem.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": status == true ? "G$itemcode" : "N$itemcode",
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "state": dropdownValue4 == "" ? "Tamil Nadu" : dropdownValue4,
          "tax": taxitem.text,
          "suppilierinvoiceno": suppiler_invoice.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "Purchase price":
              double.parse(Purchase_price.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          // "Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description":
              "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "IMSlist": IMEISERIAL,
        });
        FirebaseFirestore.instance.collection("Item ShabikaN").doc(itemdocuid).collection("Histroy").doc()
            .set({
          "Total": double.parse(valueitem.text).toStringAsFixed(2),
          "Payment mode": Payments,
          "itemcode": itemcode,
          "Hsncode": HSN_Code.text,
          "BoxNo": Box_NO.text,
          "suppilerid": suppierid.text,
          "suppilername": suppiler_name.text,
          "suppilergst": suppiler_gstno.text,
          "purchaseno": purchase_No.text,
          "purchasedate": purchase_Date.text,
          "purchasenote": purchase_notes.text,
          "tax": taxitem.text,
          "save": true,
          "suppilierinvoiceno": suppiler_invoice.text,
          "time": DateFormat.jm().format(DateTime.now()),
          "date":
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "Category": itemcat,
          "Brand": itembrand,
          "Item": itemname.text,
          "Purchase price":
              double.parse(Purchase_price.text).toStringAsFixed(2),
          "Sales price": double.parse(Sales.text).toStringAsFixed(2),
          "MRP price": double.parse(Mrp_Price.text).toStringAsFixed(2),
          "Qty": Qty.text,
          "Landing cost": double.parse(Landing_cost.text).toStringAsFixed(2),
          "IMEI NO": itemimei,
          "Serial NO": itemserial,
          "Color": itemcolor,
          "credit days": Creadit_days.text,
          //"Description":"${itemname.text},${itembrand},${itemcat}${IMEISERIAL.isNotEmpty?IMEISERIAL.toString():""}",
          "Description":
              "${itemname.text},${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}",
          "IMSlist": IMEISERIAL,
        });
      }

      if(status==true){
        var document3 = await FirebaseFirestore.instance.collection("Item ShabikaG").get();
        setState(() {
          Itemcount=document3.docs.length;
          layourbuilderclear3.text="SBG${(Itemcount).toString().padLeft(2, "0")}";
        });
        if (itemlandingprice != Landing_cost.text || itempurchaseprice != Purchase_price.text || itemlandingprice != Landing_cost.text)
        {
          var document2 = await FirebaseFirestore.instance.collection("Item ShabikaG").where("Itemcode",isEqualTo:layourbuilderclear3.text).get();

          if(document2.docs.length>0){
            FirebaseFirestore.instance.collection("Item ShabikaG").doc(document2.docs[0].id).update({
              "Category": itemcategory,
              "Brand": itembarnd,
              "Loworder": Loworder.text,
              "IMEI NO": imeivalue,
              "Serial NO": serialvalue,
              "Color": color,
              "Image": image,
              "timestamp": DateTime.now().microsecondsSinceEpoch,
              "gst": "18%",
              "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
              "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
                "gst": taxitem.text != "" ? taxitem.text : "",
              "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
              "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
              "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
              "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
              "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
              "IMSlist": IMEISERIAL,
              "Imei no": IMEI,
              "Serial no": SERIAL,
              "color": colorlist,
              "Image list": Imagelist,
              "Newitemname": layourbuilderclear2.text,
              "Itemcode": layourbuilderclear3.text
            });
          }

          else{
            FirebaseFirestore.instance.collection("Item ShabikaG").doc().set({
              "Category": itemcategory,
              "Brand": itembarnd,
              "Loworder": Loworder.text,
              "IMEI NO": imeivalue,
              "Serial NO": serialvalue,
              "Color": color,
              "Image": image,
              "timestamp": DateTime.now().microsecondsSinceEpoch,
              "gst": "18%",
              "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
              "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
              "gst": taxitem.text != "" ? taxitem.text : "",
              "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
              "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
              "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
              "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
              "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
              "IMSlist": IMEISERIAL,
              "Imei no": IMEI,
              "Serial no": SERIAL,
              "color": colorlist,
              "Image list": Imagelist,
              "Newitemname": layourbuilderclear2.text,
              "Itemcode": layourbuilderclear3.text
            });
          }

        }

      }

      if(status2==true){

        var document3 = await FirebaseFirestore.instance.collection("Item ShabikaN").get();
        setState(() {
          Itemcount=document3.docs.length;
          layourbuilderclear3.text="SBN${(Itemcount).toString().padLeft(2, "0")}";
        });
        if (itemlandingprice != Landing_cost.text || itempurchaseprice != Purchase_price.text || itemlandingprice != Landing_cost.text)
        {
          var document4 = await FirebaseFirestore.instance.collection("Item ShabikaN").where("Itemcode",isEqualTo:layourbuilderclear3.text).get();

          if(document4.docs.length>0){

            FirebaseFirestore.instance.collection("Item ShabikaN").doc(document4.docs[0].id).update({
              "Category": itemcategory,
              "Brand": itembarnd,
              "Loworder": Loworder.text,
              "IMEI NO": imeivalue,
              "Serial NO": serialvalue,
              "Color": color,
              "Image": image,
              "timestamp": DateTime.now().microsecondsSinceEpoch,
              "gst": "18%",
              "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
              "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
              "gst": taxitem.text != "" ? taxitem.text : "",
              "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
              "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
              "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
              "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
              "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
              "IMSlist": IMEISERIAL,
              "Imei no": IMEI,
              "Serial no": SERIAL,
              "color": colorlist,
              "Image list": Imagelist,
              "Newitemname": layourbuilderclear2.text,
              "Itemcode": layourbuilderclear3.text
            });
          }
          else{
            FirebaseFirestore.instance.collection("Item ShabikaN").doc().set({
              "Category": itemcategory,
              "Brand": itembarnd,
              "Loworder": Loworder.text,
              "IMEI NO": imeivalue,
              "Serial NO": serialvalue,
              "Color": color,
              "Image": image,
              "timestamp": DateTime.now().microsecondsSinceEpoch,
              "gst": "18%",
              "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
              "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
              "gst": taxitem.text != "" ? taxitem.text : "",
              "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
              "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
              "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
              "Saleprice": Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
              "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
              "IMSlist": IMEISERIAL,
              "Imei no": IMEI,
              "Serial no": SERIAL,
              "color": colorlist,
              "Image list": Imagelist,
              "Newitemname": layourbuilderclear2.text,
              "Itemcode": layourbuilderclear3.text
            });
          }


        }


      }

      await updatetotal();
      await CGSTfunction();
      await SGSTfunction();
      await Totalamounts();
      if(itemdocuid.isNotEmpty){
        FirebaseFirestore.instance.collection("Item").doc(itemdocuid).update({
          "HSNCode": HSN_Code.text != "" ? HSN_Code.text : "",
          "BoxNo": Box_NO.text != "" ? Box_NO.text : "",
          "gst": taxitem.text != "" ? taxitem.text : "",
          "TotalQuvantity": Qty.text != "" ? FieldValue.increment((int.parse(Qty.text))) : "",
          "Purchaseprice": Purchase_price.text != "" ? double.parse(Purchase_price.text).toStringAsFixed(2) : "",
          "Landingcost": Landing_cost.text != "" ? double.parse(Landing_cost.text).toStringAsFixed(2) : "",
          "Saleprice":
          Sales.text != "" ? double.parse(Sales.text).toStringAsFixed(2) : "",
          "MRPPrice": Mrp_Price.text != "" ? double.parse(Mrp_Price.text).toStringAsFixed(2) : "",
          "IMSlist": IMEISERIAL,
          "Imei no": IMEI,
          "Serial no": SERIAL,
          "color": colorlist,
          "Image list": Imagelist,
          "Newitemname": layourbuilderclear2.text,
          // "Itemcode": layourbuilderclear3.text,
        });
      }
      await clearallcontroller();
    } else {
      showdialpogboxsss();
    }
  }

  ///payment invalid popup function
  showdialpogboxsss() {
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
                        "Please Fill the Payment Mode",
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
                        child: Lottie.asset("assets/animation_lkc5owo7.json",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: height / 32.85,
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

  ///itemcode change function
  alteritemcode() async {

    if(status==true){
      var document = await FirebaseFirestore.instance.collection("Item ShabikaG").get();
      setState(() {
        Itemcount=document.docs.length+1;
        layourbuilderclear3.text="SBI${(Itemcount).toString().padLeft(2, "0")}";
      });

    }

    if(status2==true){
      var document3 = await FirebaseFirestore.instance.collection("Item ShabikaN").get();
      setState(() {
        Itemcount=document3.docs.length+1;
        layourbuilderclear3.text="SBN${(Itemcount).toString().padLeft(2, "0")}";
      });
    }


  }

  ///"Please Fill the Suppiler Name and Suppiler ID....."--popup function
  showdialpogboxsss1() {
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
                        "Please Fill the Suppiler \nName and Suppiler ID.....",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 4.7,
                        width: width / 9.106,
                        child: Lottie.asset("assets/animation_lkc5owo7.json",
                            fit: BoxFit.cover),
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

  ///"Save bill message"--popup function
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
                        "Save Purchase Bill Succesfully..",
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

  ///update function(Item and suppier and purchase shabikaG And ShabikN Documents)
  Purchaseitem() {
    FirebaseFirestore.instance.collection("Item").doc(itemdocuid).update({
      "Status": true,
    });

    if (status == true) {
      FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .doc(random)
          .update({
        "Payment mode": Payments,
        "Total": totalamount,
        "SGST": sgst,
        "CGST": Cgst,
        "save": true,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
      });
    }
    if (status2 == true) {
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(random)
          .update({
        "Payment mode": Payments,
        "Total": totalamount,
        "SGST": sgst,
        "CGST": Cgst,
        "save": true,
        "Totalamount": TotalAmount2.toStringAsFixed(2),
      });
    }
    FirebaseFirestore.instance.collection("Purchase entry").doc(random).update({
      "Payment mode": Payments,
      "Total": totalamount,
      "SGST": sgst,
      "CGST": Cgst,
      "save": true,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
    });

    FirebaseFirestore.instance
        .collection("Supplier")
        .doc(customerdocid)
        .collection("billing")
        .doc(random)
        .update({
      "Payment mode": Payments,
      "Total": totalamount.toStringAsFixed(2),
      "SGST": sgst.toStringAsFixed(2),
      "CGST": Cgst.toStringAsFixed(2),
      "save": true,
      "Totalamount": TotalAmount2.toStringAsFixed(2),
    });

    setState(() {
      Destription.add(
          "${itemname.text},$itembrand,$itemcat${IMEISERIAL.isNotEmpty ? IMEISERIAL.toString() : ""}");
      Quvantity.add(Qty.text);
      Totalamount.add(valueitem.text);
      Tax.add(taxitem.text);
      Items.add(itemname.text);
      Rate.add(Purchase_price.text);
      HSNcode.add(hsncpode);
    });
  }

  ///Purchase entry collection Total-update function
  updatetotal() async {
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance.collection("Purchase entry").doc(random).collection(random).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) +
            double.parse(documents.docs[i]['Total'].toString()));
      });
    }

    if (totalamount != 0) {
      CGSTfunction();
      SGSTfunction();
      Totalamounts();
    } else {
      setState(() {
        totalamount = 0;
        Cgst = 0;
        sgst = 0;
        TotalAmount2 = 0;
      });
    }
  }

  ///billcount bill no and its only show the true type document get count and show the value
  billcounts() async {
    if (status == true) {
      var docus1 = await FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .where("save", isEqualTo: true)
          .get();
      setState(() {
        billcount = docus1.docs.length + 1;
        purchase_No.text = "SBG${(billcount).toString().padLeft(2, "0")}";
        purchase_Date.text =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });
    }
    if (status2 == true) {
      var docus2 = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .where("save", isEqualTo: true)
          .get();

      setState(() {
        billcount = docus2.docs.length + 1;
        purchase_No.text = "SBN${(billcount).toString().padLeft(2, "0")}";
        purchase_Date.text =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });
    }
  }

  ///delete function--
  deletecollection(id) {
    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(random)
        .collection(random)
        .doc(id)
        .delete();
    FirebaseFirestore.instance
        .collection("Purchase ShabikaG")
        .doc(random)
        .collection(random)
        .doc(id)
        .delete();
    FirebaseFirestore.instance
        .collection("Purchase ShabikaN")
        .doc(random)
        .collection(random)
        .doc(id)
        .delete();
    setState(() {
      Cgst = 0;
      sgst = 0;
    });
    updatetotal();
    CGSTfunction();
    SGSTfunction();
    Totalamounts();
  }

  ///clear the controller and in this function calling initstate method
  clearlistandname() {
    setState(() {
      Destription.clear();
      Quvantity.clear();
      Totalamount.clear();
      Tax.clear();
      Items.clear();
      Rate.clear();
      HSNcode.clear();
      Bill_Time = "";
      Shipped_to = "";
      Billed_to = "";
      Sales.clear();
    });
  }


  ///showdialogbox..(already the document its show )
  alreadyexistshowdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 5.760, bottom: height / 5.760),
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
                        "This Customer Already Exist in List.....",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.3,
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
                          setState(() {
                            customervalid = false;
                          });
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
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  ///image and imei and serial no textfield generate and listview builder function
  showtextfield(Quvantity, serial, imei, color) {
    setState(() {
      IMEISERIAL.clear();
      IMEI.clear();
      SERIAL.clear();
      colorlist.clear();
      Imagelist.clear();
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<TextEditingController> _controller =
        List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller2 =
        List.generate(Quvantity, (index) => TextEditingController());
    List<TextEditingController> _controller3 =
        List.generate(Quvantity, (index) => TextEditingController());

    List<List> Imagelistitem= List<List>.generate(Quvantity,(index) =>[]);


    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
                padding: EdgeInsets.only(
                  left: width / 136.66,
                  right: width / 136.66,
                ),
                child: Scaffold(
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: height / 1.02,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height / 131.4,
                              ),

                              Text(
                                "Add IMEI And SERIAL No ",
                                style: GoogleFonts.montserrat(),
                              ),

                              SizedBox(
                                height: height / 131.4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //imei and serial and color textfield

                                  serialvalue == true ||
                                          imeivalue == true ||
                                          color == true
                                      ? SizedBox(
                                          height: height / 2.628,
                                          width: width / 1.821,
                                          child: ListView.builder(
                                            itemCount: Quvantity,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: width / 4.55),
                                                child: SizedBox(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      imei == true
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      width /
                                                                          341.5,
                                                                  vertical:
                                                                      height /
                                                                          164.25),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width /
                                                                          11.38,
                                                                      child:
                                                                          Text(
                                                                        "IMEi No",
                                                                        style: GoogleFonts.montserrat(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )),
                                                                  SizedBox(
                                                                      width: width /
                                                                          136.6),
                                                                  Material(
                                                                      color: Colors
                                                                          .white,
                                                                      elevation:
                                                                          20,
                                                                      shadowColor:
                                                                          Colors
                                                                              .black12,
                                                                      child:
                                                                          Container(
                                                                        height: height /
                                                                            16.425,
                                                                        width: width /
                                                                            4.55,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            color: Colors.grey.shade200),
                                                                        child:
                                                                            TextField(
                                                                          style:
                                                                              GoogleFonts.montserrat(),
                                                                          controller:
                                                                              _controller[index],
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "Enter the IMEI NO",
                                                                            border:
                                                                                InputBorder.none,
                                                                            contentPadding:
                                                                                EdgeInsets.only(left: width / 136.6),
                                                                            hintStyle:
                                                                                GoogleFonts.montserrat(),
                                                                          ),
                                                                          onSubmitted:
                                                                              (_) {},
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      serial == true
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      width /
                                                                          341.5,
                                                                  vertical:
                                                                      height /
                                                                          164.25),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width /
                                                                          11.38,
                                                                      child:
                                                                          Text(
                                                                        "Serial No",
                                                                        style: GoogleFonts.montserrat(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )),
                                                                  SizedBox(
                                                                      width: width /
                                                                          136.6),
                                                                  Material(
                                                                      color: Colors
                                                                          .white,
                                                                      elevation:
                                                                          20,
                                                                      shadowColor:
                                                                          Colors
                                                                              .black12,
                                                                      child: Container(
                                                                          height: height / 16.425,
                                                                          width: width / 4.55,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade200),
                                                                          child: TextField(
                                                                            style:
                                                                                GoogleFonts.montserrat(),
                                                                            controller:
                                                                                _controller2[index],
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Enter the Serial NO",
                                                                              border: InputBorder.none,
                                                                              contentPadding: EdgeInsets.only(left: width / 136.6),
                                                                              hintStyle: GoogleFonts.montserrat(),
                                                                            ),
                                                                            onSubmitted:
                                                                                (_) {},
                                                                          ))),
                                                                ],
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      color == true
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      width /
                                                                          341.5,
                                                                  vertical:
                                                                      height /
                                                                          164.25),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width: width /
                                                                          11.38,
                                                                      child:
                                                                          Text(
                                                                        "Color",
                                                                        style: GoogleFonts.montserrat(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )),
                                                                  SizedBox(
                                                                      width: width /
                                                                          136.6),
                                                                  Material(
                                                                      color: Colors
                                                                          .white,
                                                                      elevation:
                                                                          20,
                                                                      shadowColor:
                                                                          Colors
                                                                              .black12,
                                                                      child: Container(
                                                                          height: height / 16.425,
                                                                          width: width / 4.55,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade200),
                                                                          child: TextField(
                                                                            style:
                                                                                GoogleFonts.montserrat(),
                                                                            controller:
                                                                                _controller3[index],
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Color",
                                                                              border: InputBorder.none,
                                                                              contentPadding: EdgeInsets.only(left: width / 136.6),
                                                                              hintStyle: GoogleFonts.montserrat(),
                                                                            ),
                                                                            onSubmitted:
                                                                                (_) {},
                                                                          ))),
                                                                ],
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : SizedBox(width: width / 3.415),

                                  //image secelction
                                  SizedBox(
                                    width: width / 2.732,
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          width: width / 20.732,
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: height / 131.4),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width / 170.75,
                                                  ),
                                                  child: Text(
                                                    "Image&Videos ",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height / 131.4),
                                                const Divider(),
                                                SizedBox(
                                                  width: width / 2.732,
                                                  child: ListView.builder(
                                                    itemCount: int.parse(Qty.text),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return
                                                        SizedBox(
                                                          width: width / 2.732,
                                                          height:height/4.38,
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child: ListView.builder(
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemCount: Imagelistitem[index].length,
                                                                  itemBuilder: (context, index2) {
                                                                    return
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: width / 13.66,
                                                                            child: Column(
                                                                              children: [
                                                                                Text("Product Img${index2+1}",style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
                                                                                Padding(
                                                                                    padding: EdgeInsets
                                                                                        .symmetric(
                                                                                      vertical:
                                                                                      height / 82.125,
                                                                                      horizontal:
                                                                                      width / 170.75,
                                                                                    ),
                                                                                    child:
                                                                                    Material(
                                                                                      elevation: 20,
                                                                                      borderRadius:
                                                                                      BorderRadius.circular(4),
                                                                                      color: const Color(0xffe6ebef),
                                                                                      shadowColor: Colors.grey.shade100,
                                                                                      child: Container(
                                                                                          height: height / 6.212,
                                                                                          decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(4),
                                                                                              color: const Color(0xffe6ebef),
                                                                                              image: DecorationImage(fit: BoxFit.cover,
                                                                                                  image: Imagelistitem[index][index2] != "" && Imagelistitem[index][index2] != "loading"
                                                                                                      ? NetworkImage(Imagelistitem[index][index2].toString())
                                                                                                      : const NetworkImage(
                                                                                                      ""))),
                                                                                          child: Center(
                                                                                              child: Imagelistitem[index]== "loading" ?
                                                                                                   const CircularProgressIndicator():
                                                                                              Icon(Icons.add, color: const Color(0xffa3c9e2),
                                                                                            size: width / 34.15,
                                                                                          ))),
                                                                                    )
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                  },),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(
                                                                  vertical: height/82.125,
                                                                  horizontal: width/170.75,
                                                                ),
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      setState((){
                                                                        Loading2=true;
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
                                                                                    Imagelistitem[index].add(downloadUrl);
                                                                                    Imagelist=Imagelistitem;
                                                                                    Loading2=false;
                                                                                  });

                                                                                    });
                                                                          });
                                                                    },
                                                                  child: Material(
                                                                      elevation: 15,
                                                                      borderRadius: BorderRadius.circular(100),
                                                                      child:  Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child:
                                                                          Loading2==true?const CircularProgressIndicator():
                                                                        const Icon(Icons.add),
                                                                      )),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),

                              //button okay and cancle.....
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //okay button
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        popupLoading = true;
                                      });
                                      for (int i = 0; i < Quvantity; i++) {
                                        setState(() {
                                          IMEISERIAL.add(
                                              "${_controller[i].text}${_controller2[i].text}${_controller3[i].text}");
                                          IMEI.add(_controller[i].text);
                                          SERIAL.add(_controller2[i].text);
                                          colorlist.add(_controller3[i].text);
                                        });
                                      }

                                      for (int j=0;j<Imagelist.length;j++){
                                      if(status==true){
                                     FirebaseFirestore.instance.collection("Item ShabikaG").
                                     doc(itemdocuid).collection("Image").doc().set({
                                       "Image list1": Imagelist[j].length>0?Imagelist[j][0]:"",
                                       "Image list2": Imagelist[j].length>1?Imagelist[j][1]:"",
                                       "Image list3": Imagelist[j].length>2?Imagelist[j][2]:"",
                                       "Image list4": Imagelist[j].length>3?Imagelist[j][3]:"",
                                       "Image list5": Imagelist[j].length>4?Imagelist[j][4]:"",
                                       "Image list6": Imagelist[j].length>5?Imagelist[j][5]:"",
                                     });
                                      }
                                      if(status2==true){
                                     FirebaseFirestore.instance.collection("Item ShabikaN").doc(itemdocuid).
                                     collection("Image").doc().set({
                                       "Image list1": Imagelist[j].length>0?Imagelist[j][0]:"",
                                       "Image list2": Imagelist[j].length>1?Imagelist[j][1]:"",
                                       "Image list3": Imagelist[j].length>2?Imagelist[j][2]:"",
                                       "Image list4": Imagelist[j].length>3?Imagelist[j][3]:"",
                                       "Image list5": Imagelist[j].length>4?Imagelist[j][4]:"",
                                       "Image list6": Imagelist[j].length>5?Imagelist[j][5]:"",
                                     });
                                   }

                                      }


                                      collectioncreatefunction();
                                      Future.delayed(
                                          const Duration(milliseconds: 1500),
                                          () {
                                        setState(() {
                                          popupLoading = false;
                                          IMEISERIAL.clear();
                                          IMEI.clear();
                                          SERIAL.clear();
                                          colorlist.clear();
                                        });
                                        Navigator.pop(context);
                                        //clear the controller
                                        _controller.clear();
                                        _controller2.clear();
                                      });
                                    },
                                    child: Material(
                                      elevation: 15,
                                      color: const Color(0xff25D366),
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: height / 16.425,
                                        width: width / 7.588,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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

                                  SizedBox(width: width / 136.6),

                                  //cancel buttton
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color(0xff263646),
                                        ),
                                        child: Center(
                                          child: Text("Cancel",
                                              style: GoogleFonts.poppins(
                                                  letterSpacing: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width / 85.375,
                                                  color: Colors.white)),
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
                      image == false
                          ? popupLoading == true
                              ? const CircularProgressIndicator()
                              : const SizedBox()
                          : const SizedBox()
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  /// print function
  getvalue(Suppilerid, Suppilername, Tax, Suppilerinvoice, purchaseno, purchasedate, payment) async {
    setState(() {
      Billed_to =
          "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Shipped_to =
          "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Bill_Time = DateFormat.jm().format(DateTime.now());
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<p.Widget> widgets = [];

    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
        padding: const p.EdgeInsets.only(top: 5),
        child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("SNO".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 80,
              child: p.Center(
                child: p.Text("Descriptions".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("HSN/SAC".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("Qty".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("Rate".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("Gst".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              )),
          p.SizedBox(width: width / 273.2),
          p.Container(
              width: 60,
              child: p.Center(
                child: p.Text("Total".toString(),
                    style: const p.TextStyle(color: PdfColors.black)),
              ))
        ]),
      )),
    );
    //widgets.add(container);

    widgets.add(p.SizedBox(height: 5));

    widgets.add(p.Stack(children: [
      /*p.Container(
          height: 700,
          child: p.Image(await imageFromAssetBundle('assets/7728804.png'),
              fit: p.BoxFit.fill)),*/

      /*p.Padding(
          padding: p.EdgeInsets.only(top: 260),
     child: container,
        ),*/
      p.Padding(
          padding: const p.EdgeInsets.only(top: 90),
          child: p.Container(
              height: 600,
              child: p.Column(children: [
                p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
                  p.Container(
                      child: p.Column(
                          crossAxisAlignment: p.CrossAxisAlignment.start,
                          mainAxisAlignment: p.MainAxisAlignment.start,
                          children: [
                        /* p.Row(
                                              children: [
                                                p.Container(
                                                  child: p.Center(
                                                    child:  p.Text("Customer Name :",style: p.TextStyle(color: PdfColors.black)),
                                                  ),
                                                  width:110,
                                                  height: 20,
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child:p.Center(
                                                      child:  p.Text(Customer_name.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),*/
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Suppiler ID:",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 140,
                              height: 20,
                              child: p.Center(
                                child: p.Text(Suppilerid,
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                        ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Suppiler Name:",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 140,
                              height: 20,
                              child: p.Center(
                                child: p.Text(Suppilername,
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              ))
                        ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Date :",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 140,
                              height: 20,
                              child: p.Center(
                                child: p.Text(purchasedate,
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              ))
                        ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Billed To :",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 120,
                              child: p.Center(
                                child: p.Text(Billed_to,
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              ))
                        ]),
                      ])),
                  p.SizedBox(width: width / 273.2),
                  p.Container(
                      child: p.Column(
                          crossAxisAlignment: p.CrossAxisAlignment.start,
                          mainAxisAlignment: p.MainAxisAlignment.start,
                          children: [
                        p.Row(
                            crossAxisAlignment: p.CrossAxisAlignment.start,
                            children: [
                              p.Container(
                                  width: 120,
                                  height: 20,
                                  child: p.Center(
                                    child: p.Text("Suppiler Invoice No :",
                                        style: const p.TextStyle(
                                            color: PdfColors.black)),
                                  )),
                              p.Container(
                                  width: 140,
                                  height: 20,
                                  child: p.Center(
                                    child: p.Text(Suppilerinvoice,
                                        style: const p.TextStyle(
                                            color: PdfColors.black)),
                                  ))
                            ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Payment Type:",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 140,
                              height: 20,
                              child: p.Center(
                                child: p.Text(payment,
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              ))
                        ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Time :",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                            width: 140,
                            height: 20,
                            child: p.Center(
                                child: p.Text(Bill_Time,
                                    style: const p.TextStyle(
                                        color: PdfColors.black))),
                          )
                        ]),
                        p.SizedBox(height: 5),
                        p.Row(children: [
                          p.Container(
                              width: 110,
                              height: 20,
                              child: p.Center(
                                child: p.Text("Shipped To :",
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              )),
                          p.Container(
                              width: 120,
                              child: p.Center(
                                child: p.Text(Shipped_to.toString(),
                                    style: const p.TextStyle(
                                        color: PdfColors.black)),
                              ))
                        ]),
                      ])),
                ]),
                p.SizedBox(height: 5),
                container,
                p.SizedBox(height: 5),
                p.Container(
                  child: p.ListView.builder(
                    itemCount: Destription.length,
                    itemBuilder: (context, index) {
                      return p.Container(
                          child: p.Row(
                              mainAxisAlignment: p.MainAxisAlignment.start,
                              children: [
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text("${index + 1}",
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 80,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text(Destription[index].toString(),
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text(HSNcode[index].toString(),
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text(Quvantity[index].toString(),
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text(Rate[index].toString(),
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text("18%",
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                )),
                            p.SizedBox(width: width / 273.2),
                            p.Container(
                                width: 60,
                                height: height / 16.425,
                                child: p.Center(
                                  child: p.Text(Totalamount[index].toString(),
                                      style: const p.TextStyle(
                                          color: PdfColors.black)),
                                ))
                          ]));
                    },
                  ),
                ),
                p.Padding(
                    padding: p.EdgeInsets.only(
                        left: width / 136.6, right: 10, top: 200),
                    child: p.Divider(color: PdfColors.black, thickness: 0.8)),
                p.Padding(
                    padding: p.EdgeInsets.only(
                        left: width / 136.6, right: 10, top: 210),
                    child: p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.end,
                        children: [
                          p.Container(
                            width: 50,
                            child: p.Text("Total :",
                                style:
                                    const p.TextStyle(color: PdfColors.black)),
                          ),
                          p.SizedBox(width: 10),
                          p.Container(
                            width: width / 13.66,
                            child: p.Text(totalamount.toString(),
                                style:
                                    const p.TextStyle(color: PdfColors.black)),
                          )
                        ]))
              ]))),
    ]));

    final pdf = p.Document();
    pdf.addPage(
      p.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

///layout builder return the widgets
  Widget textfield2(FocusNode focusNode, TextEditingController textEditingController, onFieldSubmitted) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: width / 273.2, bottom: height / 43.8)),
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}