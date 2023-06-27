import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keymap/keymap.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:random_string/random_string.dart';
import 'const Pages.dart';






const List<String> list = <String>[
  'Please Select Category',
  'Two',
  'Three',
  'Four'
];
const List<String> list1 = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Online",
];

const List<String> list2 = <String>['Select Type', '20%', '50%', '70%'];

const List<String> list3 = <String>[
  "Gst",
  "IGSt",
];

const List<String> Payment = <String>[
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
];

const List<String> Entry = <String>[
  'Please Select Type',
  'Purchase Entry',
  'Purchase Entry',
];





//classse  ---2
class Billing_Page extends StatefulWidget {
  const Billing_Page({Key? key}) : super(key: key);

  @override
  State<Billing_Page> createState() => _Billing_PageState();
}

class _Billing_PageState extends State<Billing_Page> {

  String dropdownValue3 = list3.first;
  String Payments = Payment.first;
  String Entry_type = Entry.first;
  TextEditingController Purchase_price = new TextEditingController();
  TextEditingController Qty = new TextEditingController();
  TextEditingController Landing_cost = new TextEditingController();
  //purchase number
  TextEditingController purchase_No = new TextEditingController();
  //Based on
  TextEditingController Basedon = new TextEditingController();
  //purchase Date
  TextEditingController purchase_Date = new TextEditingController();
  //purchase NOtes
  TextEditingController purchase_notes = new TextEditingController();
  //suppierid
  TextEditingController suppierid = new TextEditingController();
  //suppiler name
  TextEditingController suppiler_name = new TextEditingController();
  //suppiler invoiceno
  TextEditingController suppiler_invoice = new TextEditingController();
  //itemid
  TextEditingController itemid = new TextEditingController();
  //item name
  TextEditingController itemname = new TextEditingController();

  //tax
  TextEditingController taxitem = new TextEditingController();
  TextEditingController valueitem = new TextEditingController();

  int vaalue = 0;

  //billed and shipped to text controller
  TextEditingController Billedto = new TextEditingController();
  TextEditingController Shippedto = new TextEditingController();
  //focus node

  FocusNode suppier_id = FocusNode();
  FocusNode suppiername = FocusNode();
  FocusNode suppiertax = FocusNode();
  FocusNode suppierincoice_no = FocusNode();
  FocusNode purchase_no = FocusNode();
  FocusNode purchase_date = FocusNode();
  FocusNode purchase_payment = FocusNode();
  FocusNode purchase_note = FocusNode();
  FocusNode customerphone2 = FocusNode();
  FocusNode customeraddress2 = FocusNode();
  FocusNode customername2 = FocusNode();
  FocusNode listcustomername = FocusNode();
  FocusNode Quvantitylist = FocusNode();
  //item focus node
  FocusNode items_id = FocusNode();
  FocusNode items_name = FocusNode();
  FocusNode items_value = FocusNode();
  bool randomgenrate=false;

  String itemnames='';

  @override
  void initState() {
    clearlistandname();
    setState(() {
      purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      Qty.text = "1";
      Billedto.text =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAMCHENNAI-600059";
      Shippedto.text =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
    });

    checkbillno();
    Userdata();
    itemaddfunction();
    // TODO: implement initState
    super.initState();
  }

  //cusdtomer name and phone
  List<String>User=[];
  String Userphone="";
  bool search=false;
  bool onchangefield=false;
  int length=0;
  String customerdocid="";


  Userdata()async {
    setState(() {
      User.clear();
    });
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    print(User);
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        User.add(details.docs[i]["Customername"]);
      });
      print(User);
    }
  }

  check(name) async {
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    for(int i=0;i<details.docs.length;i++){
      if(name==details.docs[i]['Customername']){
        setState(() {
          customerphone.text=details.docs[i]['Customermobileno'];
          customerdocid=details.docs[i].id;
        });
      }

    }
  }


  List <String>Itemlist=[];

  itemaddfunction()async{
    setState(() {
      Itemlist.clear();
    });
    var Document=await FirebaseFirestore.instance.collection('Item').
    orderBy("Newitemname",descending: false).get();
    for(int i=0;i<Document.docs.length;i++){
      Itemlist.add(Document.docs[i]['Newitemname']);
    }
    print(Itemlist);

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: height/328.5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //entry type container
            Container(
              height: height/5.053,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Customer Name
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Customer Name",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/41.39,
                        ),

                        Container(
                          child:
                          InputDecorator(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            child:
                            LayoutBuilder(
                              builder: (BuildContext , BoxConstraints )=>
                                  Autocomplete<String>(
                                    optionsViewBuilder:(context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                          ),
                                          child: Container(
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
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(option),
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
                                        check(textEditingValue.text.toString());
                                      }

                                      return
                                        User.where((String option) {
                                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        });
                                    },
                                    onSelected: (String selection) {

                                      clearlayout(selection);
                                      setState(() {
                                        customername.text=selection;
                                      });

                                      debugPrint('You just selected $selection');
                                    },
                                    displayStringForOption: (Value){
                                      return Value;
                                    },
                                    optionsMaxHeight: 50,
                                  ),




                            ),
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),

                        SizedBox(width: width/273.2,),

                        InkWell(
                        onTap:(){
                          customeradd();
                          Userdata();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Add Customer Successfully",style: GoogleFonts.poppins(),)));
                        },
                          child: ClipOval(
                              child: Container(
                                  height:height/21.9,
                                  width:width/45.53,
                                  color: Colors.white,
                                  child: Icon(Icons.add))),
                        )
                      ],
                    ),
                  ),

                  //Customer Phone
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Customer Phone",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        Container(
                          child: TextField(
                            focusNode: customerphone2,
                            controller: customerphone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: width/273.2,
                                  bottom: height/36.5),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_){
                              customerphone2.unfocus();
                              FocusScope.of(context).requestFocus(customeraddress2);
                            },
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),

                  //Customer Address
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5,
                        left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Customer Address",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/75.88,
                        ),
                        Container(
                          child: TextField(
                            focusNode: customeraddress2,
                            controller: customeraddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: width/273.2,
                                  bottom: height/36.5),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_){
                              customeraddress2.unfocus();
                              FocusScope.of(context).requestFocus(suppierincoice_no);
                            },
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),

                  //tax type
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Tax Type",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/15.701,
                        ),
                        Container(
                          child:
                          InputDecorator(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            child: LayoutBuilder(
                              builder: (BuildContext , BoxConstraints )=>
                                  Autocomplete<String>(
                                    optionsViewBuilder:(context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                          ),
                                          child: Container(
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
                                                  child: Text(option),
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
                                        check(textEditingValue.text.toString());
                                      }

                                      return
                                        list3.where((String option) {
                                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        });
                                    },
                                    onSelected: (String selection) {
                                      suppierincoice_no.unfocus();
                                      FocusScope.of(context).requestFocus(purchase_no);
                                      setState(() {
                                        dropdownValue3=selection;
                                      });
                                      clearlayout(selection);
                                      debugPrint('You just selected $selection');
                                    },
                                    displayStringForOption: (Value){
                                      return Value;
                                    },
                                  ),




                            ),
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),

            //entry type container-2
            Container(
              height: height/5.053,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Bill No
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5,
                        left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Bill No",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/17.74,
                        ),
                        Container(
                          child: TextField(
                            controller: purchase_No,
                            focusNode: purchase_no,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: width/273.2,
                                  bottom: height/36.5),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_){
                              purchase_no.unfocus();
                              FocusScope.of(context).requestFocus(purchase_date);
                            },
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),

                  //Purchase  Date
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5, left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Purchase  Date",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/105.07,
                        ),
                        Container(

                          child: TextField(
                            controller: purchase_Date,
                            focusNode: purchase_date,
                            
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: width/273.2, bottom: height/36.5),
                              hintText: "Invoice Date",
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.calendar_month)
                            ),
                            onSubmitted: (_){
                              purchase_date.unfocus();
                              FocusScope.of(context).requestFocus(purchase_payment);
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  purchase_Date.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //payment mode
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5,
                        left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Payment Mode",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/105.07,
                        ),
                        Container(
                          child:
                          Padding(
                            padding: EdgeInsets.only(bottom: height/164.25),
                            child:
                            LayoutBuilder(
                              builder: (BuildContext , BoxConstraints )=>
                                  Autocomplete<String>(
                                    optionsViewBuilder:(context, onSelected, options) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                          ),
                                          child: Container(
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
                                                  child: Text(option),
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
                                        check(textEditingValue.text.toString());
                                      }

                                      return
                                        Payment.where((String option) {
                                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        });
                                    },
                                    onSelected: (String selection) {
                                      setState(() {
                                        Payments=selection;
                                      });
                                      clearlayout(selection);
                                      debugPrint('You just selected $selection');
                                    },
                                    displayStringForOption: (Value){
                                      return Value;
                                    },
                                    optionsMaxHeight: 50,
                                  ),




                            ),
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),


                  //Purchase Notes
                  Padding(
                    padding: EdgeInsets.only(top: height/328.5,
                        left: width/273.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width/273.2,
                        ),
                        Text(
                          "Purchase Notes",
                          style: GoogleFonts.poppins(
                              fontSize: width/97.571, color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: width/136.6,
                        ),
                        Container(
                          child: TextField(
                            controller: purchase_notes,
                            focusNode: purchase_note,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: width/273.2,
                                  bottom: height/36.5),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_){
                              purchase_note.unfocus();
                              FocusScope.of(context).requestFocus(items_id);
                            },
                          ),
                          width: width/3.415,
                          height: height/21.9,
                          //color:Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,),
                        ),
                      ],
                    ),
                  ),




                ],
              ),
            )

          ],
        ),

        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Material(
                elevation: 50,
                shadowColor: Colors.black38,
                color: Color(0xff7d99ab),
                child: Container(
                  child: Row(
                    children: [

                      Text(
                        "Si No",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/136.6,
                      ),
                      Text(
                        "Item ID",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/3.794,
                      ),
                      Text(
                        "Item Name",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/4.406
                      ),
                      Text(
                        "Tax %",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width:width/22.766
                      ),

                      Text(
                        "Qnty",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),

                      SizedBox(
                        width: width/273.20,
                      ),

                      Text(
                        "Price",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/45.53,
                      ),
                      Text(
                        "Landing Cost",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/68.3
                      ),

                      Text(
                        "Value",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width/45.53,
                      ),

                      Text(
                        "Remove",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),

                    ],
                  ),
                  // color: Color(0xffFFFFFF),
                  width: width/0.975,
                  height: height/16.425,
                  decoration: BoxDecoration(
                    color: Color(0xff7d99ab),),
                ),
              ),

              Container(
                child: Row(
                  children: [

                    //Serial no
                    Container(
                      width: width/45.533,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: width/136.6,
                                bottom: height/65.7),
                            hintText: "1"
                        ),
                      ),
                    ),

                    //itemid
                    Container(
                      width: width/3.458,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child:
                      TextField(
                        controller: itemid,
                        focusNode: items_id,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                        onSubmitted: (_){
                          createpurchase(itemid.text);
                          items_id.unfocus();
                          FocusScope.of(context).requestFocus(items_name);
                        },

                      ),
                    ),

                    //itemname
                    Container(
                      width: width/3.458,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child:
                      LayoutBuilder(
                        builder: (BuildContext , BoxConstraints )=>
                            Autocomplete<String>(
                              initialValue: TextEditingValue(
                                text: itemnames,
                              ),
                              optionsViewBuilder:(context, onSelected, options) => Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                    ),
                                    child: Container(
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
                                              child: Text(option),
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
                                  createpurchase2(textEditingValue.text.toString());
                                }

                                return
                                  Itemlist.where((String option) {
                                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                  });
                              },
                              onSelected: (String selection) {

                                suppierincoice_no.unfocus();
                                FocusScope.of(context).requestFocus(purchase_no);

                                setState(() {
                                  itemnames=selection;
                                  //to aasign the controller value
                                });
                                print(itemnames);

                                debugPrint('You just selected $selection');
                              },
                              displayStringForOption: (Value){
                                return Value;
                              },
                            ),
                      ),
                      /*TextField(
                        controller: itemname,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,bottom: height/65.7),
                        ),
                      ),*/
                    ),

                    //tax
                    Container(
                      width: width/15.177,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        controller: taxitem,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                      ),
                    ),

                    //quvantity
                    Container(
                      width: width/15.177,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        controller: Qty,
                        focusNode: Quvantitylist,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                        onSubmitted: (_){
                          checkgst(Landing_cost.text,Qty.text);
                          Purchaseitem();
                          updatetotal();
                          Quvantitylist.unfocus();
                          FocusScope.of(context).requestFocus(items_value);
                        },
                      ),
                    ),

                    //price
                    Container(
                      width: width/15.177,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        controller: Purchase_price,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                      ),
                    ),

                    //landing cost
                    Container(
                      width: width/15.177,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        controller: Landing_cost,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                      ),
                    ),

                    //value
                    Container(
                      width: width/15.177,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,width: 0.6
                          )
                      ),
                      child: TextField(
                        controller: valueitem,
                        focusNode: items_value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: width/136.6,
                              bottom: height/65.7),
                        ),
                        onSubmitted: (_){

                          Purchaseitem();

                          updatetotal();

                          items_value.unfocus();

                          FocusScope.of(context).requestFocus(items_id);

                        },
                      ),
                    ),

                    //remove
                    Container(
                        width: width/15.177,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,width: 0.6
                            )
                        ),
                        child:
                        Center(
                          child: InkWell(
                            onTap: (){

                              clearallcontroller();
                            },
                            child: Icon(
                                Icons.delete
                            ),
                          ),
                        )
                    ),

                  ],
                ),
                // color: Color(0xffFFFFFF),
                width: width/0.975,
                height: height/21.9,
                decoration: BoxDecoration(
                  color: Color(0xffb7b0aa),),
              ),

              SizedBox(
                height: height/164.25,
              ),

            ],
          ),
        ),

        Material(
          elevation: 50,
          shadowColor: Colors.black38,
          color: Color(0xffFFFFFF),
          child: Container(
            //color: Color(0xffFFFFFF),
            width: width/0.975,
            height:height/ 1.932,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("billing").doc(random).
              collection(random).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox(
                  width: width/0.975,
                  height:height/ 1.932,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var billing = snapshot.data!.docs[index];
                      return
                        Row(
                          children: [

                            //Serial no
                            Container(
                                width: width/45.533,
                                height: height/16.425,
                                child:
                                Center(child: Text(" ${index+1}"))
                            ),

                            //itemid
                            Container(
                                width: width/3.458,
                                height: height/16.425,
                                child: Center(child: Text(billing['itemcode']))
                            ),

                            //itemname
                            Container(
                                width: width/3.458,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['Description'],textAlign: TextAlign.left,))
                            ),

                            //tax
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['tax']))
                            ),

                            //quvantity
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['Qty']))
                            ),

                            //price
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['Purchase price']))
                            ),

                            //landing cost
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['Landing cost']))
                            ),

                            //value
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(child: Text(billing['Total']))
                            ),

                            //remove
                            Container(
                                width: width/15.177,
                                height: height/16.425,
                                child:
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      deletecollection(billing.id);
                                      updatetotal();
                                    },
                                    child: Icon(
                                        Icons.delete
                                    ),
                                  ),
                                )
                            ),

                          ],
                        );
                    },
                  ),
                );
              },
            ),
            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: height / 131.4, left: 50),
          child: Material(
            elevation: 50,
            shadowColor: Colors.black38,
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: width/1.0928,
              height: height/13.14,
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  SizedBox(
                    width: width/13.66,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        random = "23656";
                      });
                      clearallcontroller();
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                            "Save Invoice",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                      width: width / 7.6,
                      height: height / 16.42,
                      //color: Color(0xffD60A0B),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xffD60A0B),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: width / 75.888),
                    child: InkWell(
                      onTap: () {
                        getvalue(
                            suppierid.text,
                            customername.text,
                            dropdownValue3,
                            suppiler_invoice.text,
                            purchase_No.text,
                            purchase_Date.text,
                            Payments
                        );
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                              "Save And Print Invoice",
                              style: GoogleFonts.poppins(color: Colors.white),
                            )),
                        width: width / 4.6,
                        height: height / 16.42,
                        //color: Color(0xffD60A0B),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff0079FF),
                        ),
                      ),
                    ),
                  ),

                  KeyboardWidget(
                    bindings: [
                      KeyAction.fromString('F6','increment the counter', () {

                      })
                    ],
                    child: InkWell(
                      onTap: () async {
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: width / 75.888),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save Bill\nShare",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              SizedBox(width: width/68.3,),
                              Container(
                                  height:height/23.46,
                                  width:width/48.78,
                                  child: Image.asset("assets/whats app final.png")),
                            ],
                          ),
                          width: width / 6.4,
                          height: height / 16.42,
                          //color: Color(0xffD60A0B),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff482121),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width:width/ 7.189,
                  ),

                  Container(
                      width: width / 6.6,
                      height: height / 16.42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade200),
                      child: Center(
                          child: Text(
                            "Total : ${totalamount}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }


  String random = "";
  String itemcode = "dsgdgd";
  String hsncpode = "";
  String itemcat='';
  String itembrand='';
  String itemimei='';
  String itemserial='';

  checkbillno() {
    setState(() {
      random = randomAlphaNumeric(16);
    });
    print(random);
    billcounts();
  }

  TextEditingController Cusname=TextEditingController();
  TextEditingController mobileno=TextEditingController();

  customeradd(){
    FirebaseFirestore.instance.collection("Customer").doc().set({
      "Customermobileno":customerphone.text,
      "Customername":customername.text,
      "Customer address":customeraddress.text,
    });
    clearcontroller();
  }

  clearcontroller(){
    mobileno.clear();
    Cusname.clear();
  }
  TextEditingController customername=TextEditingController();
  TextEditingController customerphone=TextEditingController();
  TextEditingController customeraddress=TextEditingController();

  int billingcountval=0;

  previousamount()async{
    var docus=await  FirebaseFirestore.instance.collection("billing").orderBy("timestamp",descending: true).get();
    print(docus.docs.length);
    setState(() {
      billingcountval=docus.docs[1]["Total"];
    });


  }
  clearlayout(name){
    setState(() {
      name='';
    });

  }



  int totalamount = 0;

  updatetotal() async {

    print(random);
    setState(() {
      totalamount = 0;
    });
    var documents = await FirebaseFirestore.instance.collection("billing").
    doc(random).collection(random).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        totalamount = ((totalamount) + int.parse(documents.docs[i]['Total']));
      });
    }
    print(totalamount);
    FirebaseFirestore.instance.collection("billing").doc(random).update({
      "Total": totalamount,
    });
  }

  int billcount=0;

  Purchaseitem() {
    FirebaseFirestore.instance.collection("billing").doc(random).update({
      "Payment mode": Payments,
      "Loworder":FieldValue.increment(-int.parse(Qty.text))
    });
    FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc()
        .set({
      "Total": valueitem.text,
      "Payment mode":Payments,
      "itemcode":itemcode,
      "Hsncode": hsncpode,
      "customername":customername.text,
      "customerphone":customerphone.text,
      "customeraddress":customeraddress.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "tax":taxitem.text,
      "time":DateFormat.jm().format(DateTime.now()),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "Category": itemcat,
      "Brand": itembrand,
      "Item": itemname.text,
      "Purchase price": Purchase_price.text,
      "Qty": Qty.text,
      "Landing cost": Landing_cost.text,
      "Description":"${itemcat}${itembrand}${itemname.text}",
    });

    FirebaseFirestore.instance.collection("Customer").doc(customerdocid).collection(random).doc()
        .set({
      "Total": valueitem.text,
      "Payment mode":Payments,
      "itemcode":itemcode,
      "Hsncode": hsncpode,
      "customername":customername.text,
      "customerphone":customerphone.text,
      "customeraddress":customeraddress.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "tax":taxitem.text,
      "time":DateFormat.jm().format(DateTime.now()),
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "Category": itemcat,
      "Brand": itembrand,
      "Item": itemname.text,
      "Purchase price": Purchase_price.text,
      "Qty": Qty.text,
      "Landing cost": Landing_cost.text,
      "Description":"${itemcat}${itembrand}${itemname.text}",
    });
    setState(() {
      Destription.add("${itemcat}${itembrand}${itemname.text}");
      Quvantity.add(Qty.text);
      Totalamount.add(valueitem.text);
      Tax.add(taxitem.text);
      Items.add(itemname.text);
      Rate.add(Purchase_price.text);
      HSNcode.add(hsncpode);
    });

    print(Destription);
    print(Quvantity);
    print(Totalamount);
    print(Tax);
    print(Items);
    print(Rate);
    print(HSNcode);
    print(Bill_total);



  }

  String Bill_total='';
  List Destription=[];
  List Quvantity=[];
  List Totalamount=[];
  List Tax=[];
  List Items=[];
  List Rate=[];
  List HSNcode=[];

  clearlistandname(){
    setState(() {
      Destription.clear();
      Quvantity.clear();
      Totalamount.clear();
      Tax.clear();
      Items.clear();
      Rate.clear();
      HSNcode.clear();
      Payment_Mode="";
      Suppiler_Id="";
      Suppiler_name="";
      Suppiler_invoiceno="";
      Suppiler_date="";
      Bill_no="";
      Bill_total="";
      Bill_Time="";
      Shipped_to="";
      Billed_to="";
    });

  }

  checkgst(purchase, qty) {

    print("entreeeeeeeeeeeeeeeeeeeeeeeeeeeee");

    setState(() {
      valueitem.text = (((int.parse(purchase.toString())) * int.parse(qty)).toString());
    });
    print(valueitem.text);
  }

  clearallcontroller() {
    setState(() {
      Payments = Payment.first;
      vaalue = 0;
      totalamount = 0;
      dropdownValue3=list3.first;
      Userphone="";
    });
    Purchase_price.clear();
    Qty.clear();
    Landing_cost.clear();
    //purchase number
    purchase_No.clear();
    //Based on
    Basedon .clear();
    //purchase Date
    //purchase NOtes
    purchase_notes.clear();
    //suppierid
    suppierid.clear();
    //suppiler name
    suppiler_name.clear();
    //suppiler invoiceno
    suppiler_invoice .clear();
    //itemid
    itemid .clear();
    //item name
    itemname.clear();
    taxitem.clear();
    valueitem.clear();
    customerphone.clear();
    customername.clear();
    customeraddress.clear();
  }

  createpurchase(name) async {
    var documents = await FirebaseFirestore.instance.collection("Item").get();
    for (int i = 0; i < documents.docs.length; i++) {
      if (documents.docs[i]["Itemcode"] == name) {
        setState(() {
          itemcode = documents.docs[i]["Itemcode"].toString();
          hsncpode = documents.docs[i]["HSNCode"].toString();
          itemid.text=documents.docs[i]["Itemcode"].toString();
          itemname.text=documents.docs[i]["Newitemname"].toString();
          itemnames=documents.docs[i]["Newitemname"].toString();
          taxitem.text=documents.docs[i]["gst"].toString();
          Qty.text="1";
          Purchase_price.text=documents.docs[i]["Purchaseprice"].toString();
          Landing_cost.text=documents.docs[i]["Landingcost"].toString();
          itemcat=documents.docs[i]["Category"].toString();
          itembrand=documents.docs[i]["Landingcost"].toString();
        });
      }
      print("ghggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
      print(itemcode);

    }
    FirebaseFirestore.instance.collection("billing").doc(random).set({
      "Total": "",
      "itemcode":itemcode,
      "Payment mode":Payments,
      "Hsncode": hsncpode,
      "customername":customername.text,
      "customerphone":customerphone.text,
      "customeraddress":customeraddress.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "tax":taxitem.text,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    checkgst(Landing_cost.text,Qty.text);
  }

  createpurchase2(name) async {
    var documents = await FirebaseFirestore.instance.collection("Item").get();
    for (int i = 0; i < documents.docs.length; i++) {
      if (documents.docs[i]["Newitemname"] == name) {
        setState(() {
          itemcode = documents.docs[i]["Itemcode"].toString();
          hsncpode = documents.docs[i]["HSNCode"].toString();
          itemid.text=documents.docs[i]["Itemcode"].toString();
          itemname.text=documents.docs[i]["Newitemname"].toString();
          itemnames=documents.docs[i]["Newitemname"].toString();
          taxitem.text=documents.docs[i]["gst"].toString();
          Qty.text="1";
          Purchase_price.text=documents.docs[i]["Purchaseprice"].toString();
          Landing_cost.text=documents.docs[i]["Landingcost"].toString();
          valueitem.text=documents.docs[i]["Landingcost"].toString();
          itemcat=documents.docs[i]["Category"].toString();
          itembrand=documents.docs[i]["Landingcost"].toString();
        });
      }
      print("ghggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
      print(itemcode);

    }
    FirebaseFirestore.instance.collection("billing").doc(random).set({
      "Total": "",
      "itemcode":itemcode,
      "Payment mode":Payments,
      "Hsncode": hsncpode,
      "customername":customername.text,
      "customerphone":customerphone.text,
      "customeraddress":customeraddress.text,
      "purchaseno":purchase_No.text,
      "purchasedate":purchase_Date.text,
      "purchasenote":purchase_notes.text,
      "tax":taxitem.text,
      "date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    checkgst(Landing_cost.text,Qty.text);
  }

  billcounts()async{
    var docus=await  FirebaseFirestore.instance.collection("billing").get();
    print(docus.docs.length);

    setState(() {
      billcount = docus.docs.length;
      purchase_No.text = (docus.docs.length+1).toString();
      purchase_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    });


  }

  deletecollection(id) {
    FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(id).delete();
  }

  String Payment_Mode="";
  String Suppiler_Id="";
  String Suppiler_name="";
  String Suppiler_invoiceno="";
  String Suppiler_date="";
  String Bill_no="";
  String Bill_Time="";
  String Shipped_to="";
  String Billed_to="";

  getvalue(Suppilerid,Suppilername,Tax,Suppilerinvoice,purchaseno,purchasedate,payment)  async {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {
      Billed_to =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Shipped_to =
      "SHABIKA MOBILES,95/1,VALMIGI STREET,EAST TAMBARAM,CHENNAI-600059";
      Bill_Time=DateFormat.jm().format(DateTime.now());
    });

    List<p.Widget> widgets = [];

    //container for profile image decoration
    final container = p.Center(
      child: p.Container(
          child: p.Padding(
            padding: p.EdgeInsets.only(top: 5),
            child:  p.Row(
                mainAxisAlignment: p.MainAxisAlignment.start,
                children: [
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("SNO".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 80,
                      child: p.Center(
                        child: p.Text("Descriptions".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("HSN/SAC".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Qty".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Rate".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Gst".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      )),
                  p.SizedBox(width: width/273.2),
                  p.Container(
                      width: 60,
                      child: p.Center(
                        child: p.Text("Total".toString(),
                            style: p.TextStyle(color: PdfColors.black)),
                      ))
                ]),
          )),
    );
    //widgets.add(container);

    widgets.add(p.SizedBox(height: 5));

    widgets.add(
        p.Stack(
            children: [

              /*p.Container(
          height: 700,
          child: p.Image(await imageFromAssetBundle('assets/7728804.png'),
              fit: p.BoxFit.fill)),*/

              /*p.Padding(
          padding: p.EdgeInsets.only(top: 260),
     child: container,
        ),*/
              p.Padding(
                  padding: p.EdgeInsets.only(top: 90),
                  child:
                  p.Container(
                      height: 600,
                      child: p.Column(
                          children: [
                            p.Row(
                                mainAxisAlignment: p.MainAxisAlignment.start,
                                children: [
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
                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler ID:",
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerid,
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),

                                                ]),
                                            p.SizedBox(height: 5),
                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler Name:",
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilername,
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      ))
                                                ]
                                            ),

                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Date :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(purchasedate,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),

                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Billed To :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Billed_to,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                          ])),

                                  p.SizedBox(width: width/273.2),

                                  p.Container(
                                      child: p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                          children: [
                                            p.Row(crossAxisAlignment: p.CrossAxisAlignment.start,
                                                children: [
                                                  p.Container(
                                                      width: 120,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text("Suppiler Invoice No :",
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      )),
                                                  p.Container(
                                                      width: 140,
                                                      height: 20,
                                                      child: p.Center(
                                                        child: p.Text(Suppilerinvoice,
                                                            style: p.TextStyle(color: PdfColors.black)),
                                                      ))
                                                ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Payment Type:",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 140,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text(payment,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Time :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                width: 140,
                                                height: 20,
                                                child: p.Center(
                                                    child: p.Text(Bill_Time,
                                                        style: p.TextStyle(color: PdfColors.black))),
                                              )
                                            ]),
                                            p.SizedBox(height: 5),
                                            p.Row(children: [
                                              p.Container(
                                                  width: 110,
                                                  height: 20,
                                                  child: p.Center(
                                                    child: p.Text("Shipped To :",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.Container(
                                                  width: 120,
                                                  child: p.Center(
                                                    child: p.Text(Shipped_to.toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
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
                                  return
                                    p.Container(
                                        child: p.Row(
                                            mainAxisAlignment: p.MainAxisAlignment.start,
                                            children: [
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text("${index+1}",
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 80,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Destription[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(HSNcode[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Quvantity[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Rate[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Tax,
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  )),
                                              p.SizedBox(width: width/273.2),
                                              p.Container(
                                                  width: 60,
                                                  height: height/16.425,
                                                  child: p.Center(
                                                    child: p.Text(Totalamount[index].toString(),
                                                        style: p.TextStyle(color: PdfColors.black)),
                                                  ))
                                            ])
                                    );
                                },
                              ),
                            ),
                            p.Padding(
                                padding: p.EdgeInsets.only(left: width/136.6, right: 10, top: 200),
                                child: p.Divider(color: PdfColors.black, thickness: 0.8)),
                            p.Padding(
                                padding: p.EdgeInsets.only(left: width/136.6, right: 10, top: 210),
                                child: p.Row(
                                    mainAxisAlignment: p.MainAxisAlignment.end,
                                    children: [
                                      p.Container(
                                        //width: width/273.20,--50
                                        width: width/273.20,
                                        child: p.Text("Total :",
                                            style: p.TextStyle(color: PdfColors.black)),
                                      ),
                                      p.SizedBox(width: width/136.6),
                                      p.Container(
                                        width: width/13.66,//--100
                                        child: p.Text(totalamount.toString(),
                                            style: p.TextStyle(color: PdfColors.black)),
                                      )
                                    ]))
                          ])
                  )),

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

}

