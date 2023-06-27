
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
  "Select Tax",
  "18%",
  "15%",
  "12%",
];

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Online",
];

const List<String> Entry = <String>[
  'Please Select Type',
  'Purchase Entry',
  'Purchase Entry',
];


class Billin_PAge extends StatefulWidget {
  const Billin_PAge({Key? key}) : super(key: key);

  @override
  State<Billin_PAge> createState() => _Billin_PAgeState();
}

class _Billin_PAgeState extends State<Billin_PAge> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      //billing Designs And contains
      Column(
        children: [


          Row(
            children: [

              //contauiner-1
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20),
                child:
                Material(
                  elevation: 50,
                  shadowColor: Colors.black38,
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    child: Column(
                      children: [

                        Row(
                          children: [

                            //item code  container
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20.0, top:20),
                              child: Text(
                                "Item Code",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Padding(
                                padding:
                                const EdgeInsets.only(left: 20.0, top:20),
                                child:
                                Container(
                                  width: 200,
                                  height:30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey.shade200
                                  ),
                                  child: TextField(
                                    controller: Itemcode,
                                    focusNode: Itemcodes,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left:20,bottom:15),
                                        hintText: "Item Code"
                                    ),
                                    onSubmitted: (_){
                                      Itemvalue();
                                      Itemcodes.unfocus();
                                      FocusScope.of(context).requestFocus(discount);
                                    },
                                  ),
                                )
                            ),

                          ],
                        ),

                        //top tiles (ext.. si no and detailes text).....
                        Padding(
                          padding: const EdgeInsets.only(top: 19.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 20.0, ),
                                child: Text(
                                  "Si.No",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Text(
                                  "Item Name",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:80.0),
                                child: Text(
                                  "Description",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding:
                                const EdgeInsets.only(left: 145.0, right: 50),
                                child: Text(
                                  "QTY",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 48.0),
                                child: Text(
                                  "Rate",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 2),
                                child: Text(
                                  "GST",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding:
                                EdgeInsets.only(left:width/28.458, right: 30),
                                child: Text(
                                  "Discount",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 55.0),
                                child: Text(
                                  "Total",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Stock",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: height/131.4),
                          child: Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                //Item Name textfield
                                SizedBox(width: 70,),

                                Container(
                                  width: 130,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: Itemname,
                                        focusNode: Itemcat,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 15,left: 3),
                                          border: InputBorder.none,
                                          hintText: "Item Name",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //Item Des textfield
                                SizedBox(width: 25,),
                                Container(
                                  width: 130,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: Itemdescription,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 15,left: 3),
                                          border: InputBorder.none,
                                          hintText: "Item description",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //qty textfield
                                SizedBox(width: 100,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: qty,
                                        textInputAction: TextInputAction.next,
                                        focusNode: Qty,
                                        onChanged: (value){
                                          setState(() {
                                            _total = int.parse(value);
                                            print( _total);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 15,left: 25),
                                          border: InputBorder.none,
                                          hintText: "0",
                                        ),
                                        onEditingComplete:(){
                                          Qty.unfocus();
                                          FocusScope.of(context).requestFocus(rate);
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //Rate textfield
                                SizedBox(width: 20,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: Rate,
                                        textInputAction: TextInputAction.next,
                                        focusNode: rate,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 15,left: 25),
                                            border: InputBorder.none,
                                            hintText: "0"
                                        ),
                                        onEditingComplete:(){
                                          rate.unfocus();
                                          FocusScope.of(context).requestFocus(gst);
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //Gst textfield
                                SizedBox(width: 25,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: Gst,
                                        textInputAction: TextInputAction.next,
                                        focusNode: gst,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 15,left: 25),
                                            border: InputBorder.none,
                                            hintText: "0"
                                        ),
                                        onEditingComplete:(){
                                          gst.unfocus();
                                          FocusScope.of(context).requestFocus(discount);
                                        },
                                      ),
                                    ),
                                  ),
                                ),


                                //discount textfield
                                SizedBox(width: 35,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: TextField(
                                        controller: Discount,
                                        textInputAction: TextInputAction.next,
                                        focusNode: discount,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 15,left: 25),
                                            border: InputBorder.none,
                                            hintText: "0"
                                        ),
                                        onEditingComplete:(){
                                          discount.unfocus();
                                          FocusScope.of(context).requestFocus(Customermobileno);
                                          setState(() {
                                            search=true;
                                          });
                                        },
                                        onSubmitted: (_){
                                          if(stocksvalue!=0) {
                                            //update the billing collection
                                            Updatebillingw();
                                            //total amount billinmf collectiion
                                            billingcount();
                                            //stock update function
                                            updateitem();


                                          }

                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //total textfield
                                SizedBox(width: 25,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child:
                                      Text(totalamount(int.parse(qty.text.toString()),int.parse(Rate.text.toString()))),
                                    ),
                                  ),
                                ),

                                //stocks
                                SizedBox(width: 35,),
                                Container(
                                  width: 60,
                                  height:25,
                                  decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child:
                                        TextField(
                                          controller: Stocks,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(bottom: 15,left: 25),
                                              border: InputBorder.none,
                                              hintText: stocksvalue.toString()
                                          ),
                                        )
                                    ),
                                  ),
                                ),


                              ],
                            ),
                            // color: Color(0xffFFFFFF),
                            width: 980,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xff6EC3C5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                                border: Border.all(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                    // color: Color(0xffFFFFFF),
                    width: 980,
                    height: 130,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ),

              //container-2
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 20),
                child: Material(
                  elevation: 50,
                  shadowColor: Colors.black38,
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    child: Row(
                      children: [

                        //perivious billing amount price Text
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, right: 5),
                          child: Text(
                            "Previous Bill Amount:",
                            style: GoogleFonts.poppins(
                                color: Color(0xff000000),
                                fontSize: width/75.888,
                                fontWeight: FontWeight.bold),
                          ),
                        ),


                        //perivious billing amount price container
                        Container(
                          width: 80,
                          child: Text(
                            billingcountval.toString(),
                            style: GoogleFonts.poppins(
                                color: Color(0xff000000),
                                fontSize: width/75.888,
                                textStyle: TextStyle(
                                    overflow: TextOverflow.ellipsis
                                ),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // color: Color(0xffFFFFFF),
                    width: 320,
                    height: 125,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              )

            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              //container-3,//container-4
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 12,top:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //container-3
                    Material(
                      elevation: 50,
                      shadowColor: Colors.black38,
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        //color: Color(0xffFFFFFF),
                        width: 980,
                        height: 300,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("billing").doc(random).collection(random).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData==null){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            if(!snapshot.hasData){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var billing=snapshot.data!.docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [

                                        SizedBox(width: 15,),
                                        Container(
                                            width:30,
                                            child: Center(child: Text(billing["billingid"].toString()))),
                                        SizedBox(width: 25,),

                                        Container(
                                            width:300,
                                            child: Row(
                                              children: [
                                                Text(billing["billingname1"].toString()),
                                                SizedBox(width:100),
                                                Text(billing["billingname2"].toString()),
                                              ],
                                            )),
                                        SizedBox(width: 85,),

                                        Container(
                                            width:30,
                                            child: Center(child: Text(billing["Qty"].toString()))),
                                        SizedBox(width: 45,),


                                        Container(

                                            width:50,

                                            child: Center(child: Text(billing["Rate"].toString()))),
                                        SizedBox(width: 40,),

                                        Container(
                                            width:30,

                                            child: Center(child: Text(billing["Gst"].toString()))),
                                        SizedBox(width: 50,),

                                        Container(
                                            width:55,

                                            child: Center(child: Text("${billing["Discount"].toString()}%"))),
                                        SizedBox(width: 40,),

                                        Container(
                                            width:60,

                                            child: Center(child: Text(billing["Total"].toString()))),
                                        SizedBox(width: 35,),

                                        /*  Container(
                                         width:30,

                                         child: Center(child: Text(billing["stocks"].toString()))),*/
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              deletebittling(billing.id);
                                              billingcount();
                                            },
                                            child: Tooltip(
                                                message: "Delete",
                                                child: Icon(Icons.delete)))

                                      ],
                                    ),
                                  );
                                },);
                          },
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),

                    SizedBox(height:10),

                    //container-4
                    Material(
                      elevation: 50,
                      shadowColor: Colors.black38,
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("Total :",style:GoogleFonts.poppins(
                                color: Color(0xffFF2C2C),
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),

                            //price text-3
                            Padding(
                              padding: const EdgeInsets.only(left: 28.0, right: 20),
                              child: Text(
                                "₹${billingtotal.toString()}",
                                style:
                                GoogleFonts.poppins(
                                    color: Color(0xffFF2C2C),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Image.asset("assets/line14.png"),

/*
                            //Rate Type text..
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20),
                              child: Text(
                                "Rate Type:",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000), fontWeight: FontWeight.bold),
                              ),
                            ),

                            //dropdown-3
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child:
                              DropdownButton<String>(
                                value: dropdownValue2,
                                isExpanded: true,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 13),
                                underline: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue2 = value!;
                                  });
                                },
                                items: list2
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              height: 40,
                              width: 130,
                              //color: Color(0xffDDDEEE),
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(6)),
                            ),

                            //Sales Man text
                            Padding(
                              padding: const EdgeInsets.only(left: 58.0, right: 20),
                              child: Text(
                                "Sales Man:",
                                style: GoogleFonts.poppins(
                                    color: Color(0xff000000), fontWeight: FontWeight.bold),
                              ),
                            ),

                            //Sales Man  container...
                            Container(
                              child: TextField(
                                controller: Saleman,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: GoogleFonts.poppins(fontSize: 10),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20, bottom: 8),
                                  border: InputBorder.none,
                                ),
                              ),
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDEEE),
                                  borderRadius: BorderRadius.circular(6)),
                            )

 */

                            //save bill buttton
                            SizedBox(width: 30,),

                            KeyboardWidget(
                              bindings: [
                                KeyAction.fromString('F2','increment the counter', () {
                                  savebills();
                                  previousamount();
                                  checkbillno();
                                })
                              ],
                              child: InkWell(
                                onTap: (){
                                  savebills();
                                  previousamount();
                                  checkbillno();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          "Save Bill",
                                          style: GoogleFonts.poppins(color: Colors.white),
                                        )),
                                    width: width / 8.6,
                                    height: height / 16.42,
                                    //color: Color(0xffD60A0B),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffD60A0B),
                                    ),
                                  ),
                                ),
                              ),
                            ),



                            //save bill and print buttton
                            SizedBox(width: 30,),
                            KeyboardWidget(
                              bindings: [
                                KeyAction.fromString('F5','increment the counter', () {
                                  getthevalue();
                                })
                              ],
                              child: InkWell(
                                onTap: () async {

                                  //get the value of stream form the villing collection
                                  getthevalue();



                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          "Save and Print Bill",
                                          style: GoogleFonts.poppins(color: Colors.white),
                                        )),
                                    width: width / 6.4,
                                    height: height / 16.42,
                                    //color: Color(0xffD60A0B),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffD60A0B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),

                            KeyboardWidget(
                              bindings: [
                                KeyAction.fromString('F6','increment the counter', () {
                                  getthevalue();
                                })
                              ],
                              child: InkWell(
                                onTap: () async {
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Save Bill\nShare",
                                          style: GoogleFonts.poppins(color: Colors.white),
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                            height:25,
                                            width:25,
                                            child: SvgPicture.asset("assets/whatsapp.svg",color: Colors.white,)),
                                      ],
                                    ),
                                    width: width / 6.4,
                                    height: height / 16.42,
                                    //color: Color(0xffD60A0B),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffD60A0B),
                                    ),
                                  ),
                                ),
                              ),
                            ),



                          ],
                        ),
                        //color: Color(0xffFFFFFF),
                        width: 980,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),

              //comtainer-5
              Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Material(
                      elevation: 50,
                      shadowColor: Colors.black38,
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [

                                //billol number text
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 28.0, top: 10),
                                  child: Text(
                                    "Bill No:",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff000000),
                                        fontSize: width/75.888,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                //bill amount text-1
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0, top: 10),
                                  child: Container(
                                    width: 120,
                                    child: Text(
                                      billcount.toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: width/75.888,
                                          color: Color(0xff000000),
                                          textStyle: TextStyle(
                                              overflow: TextOverflow.ellipsis
                                          ),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //mobile text
                            SizedBox(height: 10,),
                            Row(

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0, ),
                                  child: Text(
                                    "Mobile:",
                                    style: GoogleFonts.poppins(
                                        fontSize: width/75.888,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                SizedBox(width: 40,),

                                Padding(
                                  padding: const EdgeInsets.only(top:18.0),
                                  child: Container(
                                      width:180,
                                      height:30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child:
                                      TextField(
                                        focusNode: Customermobileno,
                                        onTap: (){
                                          setState(() {
                                            search=true;
                                          });
                                        },
                                        onChanged: (value){

                                          if(value.isEmpty){
                                            setState(() {
                                              onchangefield=false;
                                              search=false;
                                            });
                                          }
                                          else {
                                            setState(() {
                                              Userphone = value;
                                              onchangefield = true;
                                            });
                                          }

                                        },
                                        onEditingComplete:(){
                                          Customermobileno.unfocus();
                                          FocusScope.of(context).requestFocus(Customernamefield);
                                        },
                                        controller: mobileno,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 15,left: 5),
                                            border: InputBorder.none,
                                            hintText: "Customner mobile"
                                        ),
                                      )
                                  ),
                                )

                              ],
                            ),

                            //customet text and container...
                            SizedBox(height:search==true?60:0,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0,),
                                  child: Text(
                                    "Customer:",
                                    style: GoogleFonts.poppins(
                                        fontSize: width/75.888,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                SizedBox(width: 10,),

                                Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      width:180,
                                      height:30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child:
                                      TextField(
                                        focusNode: Customernamefield,
                                        onEditingComplete:(){
                                          Customernamefield.unfocus();
                                          FocusScope.of(context).requestFocus(Customeraddressfield);
                                        },
                                        controller: Cusname,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 15,left: 5),
                                            border: InputBorder.none,
                                            hintText: "Customner Name"
                                        ),
                                      ),

                                    ),
                                    SizedBox(height:8),

                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff263646),
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: InkWell(
                                          onTap: (){
                                            customeradd();
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text("Add Customer Successfully",style: GoogleFonts.poppins(),)));

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                Text("Add Customer",style: GoogleFonts.poppins(color:Colors.white),),
                                                Icon(Icons.add,color: Colors.white,),
                                              ],
                                            ),
                                          )),
                                    )

                                  ],
                                )

                              ],
                            ),

                            //Customer Address container
                            SizedBox(height: 20,),
                            Row(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0, ),
                                  child: Text(
                                    "Customer \nAddress:",
                                    style: GoogleFonts.poppins(
                                        fontSize: width/75.888,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 20,),

                                Container(
                                  width:170,
                                  height:30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child:
                                  TextField(
                                    focusNode: Customeraddressfield,
                                    controller: customeraddress,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 15,left: 5),
                                      border: InputBorder.none,
                                      hintText: "Customer Address",

                                    ),
                                  ),
                                )
                              ],
                            ),

                            //bill type text and bill type dropdown-2
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 15),
                              child: Row(
                                children: [

                                  //bill type text
                                  Text(
                                    "Payment\nMode:",
                                    style: GoogleFonts.poppins(
                                        fontSize: width/75.888,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),

                                  //bill type dropdown-2
                                  SizedBox(width: 30,),
                                  Container(
                                    child:
                                    DropdownButton<String>(
                                      value: dropdownValue1,
                                      isExpanded: true,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
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
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                    height: 40,
                                    width: 170,

                                  )
                                ],
                              ),
                            ),



                          ],
                        ),
                        //color: Color(0xffFFFFFF),
                        width: 320,
                        height: 430,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top:104.0,left:135),
                    child: Container(
                      width:180,
                      height:search==false?0:60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade100
                      ),
                      child:search==true?
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Customer").snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData==null){
                            return Center(child: Container(),);
                          }
                          if(snapshot.hasData==null){
                            return Center(child: Container(),);
                          }
                          return
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount:snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var data=snapshot.data!.docs[index];
                                if(onchangefield==true && data['Customermobileno'].toString().toLowerCase().startsWith(Userphone.toLowerCase())){
                                  return
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          mobileno.text=data['Customermobileno'].toString();
                                          Cusname.text=data['Customername'].toString();
                                          customerdocid=snapshot.data!.docs[index].id;
                                          search=false;
                                        });
                                      },
                                      child: ListTile(
                                        title: Text(data['Customername'].toString()),
                                        subtitle: Text(data['Customermobileno'].toString()),
                                      ),
                                    );
                                };
                                return Container();
                              },);
                        },) :
                      Container(),
                    ),
                  )
                ],
              ),
            ],
          ),

        ],
      );
  }


  String dropdownValue = list.first;
  String dropdownValue1 = list1.first;
  String dropdownValue2 = list2.first;




  TextEditingController qty=TextEditingController();
  TextEditingController Rate=TextEditingController();
  TextEditingController Gst=TextEditingController();
  TextEditingController Discount=TextEditingController();
  TextEditingController Total=TextEditingController();
  TextEditingController Stocks=TextEditingController();

  TextEditingController saveDiscount=TextEditingController();
  TextEditingController Cusname=TextEditingController();
  TextEditingController mobileno=TextEditingController();
  TextEditingController Saleman=TextEditingController();

  TextEditingController Itemname=TextEditingController();
  TextEditingController Itemdescription=TextEditingController();
  TextEditingController Itemcode=TextEditingController();
  String categorytype="";

  String dropdown2selctvalue="";
  String stockid="";

  int _total =0;
  bool onchangefield=false;

  NumberFormat id=new NumberFormat('0');


  String pramount="";

  int billingcountval=0;

  previousamount()async{
    var docus=await  FirebaseFirestore.instance.collection("billing").orderBy("timestamp",descending: true).get();
    print(docus.docs.length);
    setState(() {
      billingcountval=docus.docs[1]["Total"];
    });


  }

  int stocksvalue=0;

  String Docid="";
  //item
  Itemvalue()async{
    var document=await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<document.docs.length;i++){
      var document2=await FirebaseFirestore.instance.collection("Item").doc(document.docs[i].id).get();
      Map<String,dynamic>?valued=document2.data();
      if(Itemcode.text==document.docs[i]["Itemcode"]){
        setState(() {
          itemid=document.docs[i].id;
          Itemcode.text=document.docs[i]["Itemcode"].toString();
          Itemname.text=document.docs[i]["Newitemname"].toString();
          Itemdescription.text=document.docs[i]["Category"].toString();
          Gst.text=document.docs[i]["gst"].toString();
          Docid=document.docs[i].id;
          Stocks.text=valued!["Loworder"].toString();
          stocksvalue=valued["Loworder"];
          Rate.text= valued["Saleprice"].toString();
        });
        print(stocksvalue.toString());
        print(Stocks.text.toString());
      }

    }
  }

  //craete bills
  billcounts()async{
    var docus=await  FirebaseFirestore.instance.collection("billing").get();
    print(docus.docs.length);
    setState(() {
      billcount=docus.docs.length;
    });

  }

  createbilling()  {
    checkbillno();
    FirebaseFirestore.instance.collection("billing").doc(random).set({
      "Bill no":billcount,
      "Customer name":"",
      "Customer phone":"",
      "Discount":"",
      "Bill Type":"",
      "timestamp":"",
      "time": "",
      "date": "",
    });
    billcounts();
    setState(() {
      qty.text="1";
      Rate.text="1";
    });
    billing_no.clear();
    product_name.clear();
    product_subname.clear();
    product_total.clear();
    product_qty.clear();
    product_gst.clear();
    product_discount.clear();
    Product_id.clear();
    print(qty.text);

  }

  //update the bills
  Updatebillingw()  {
    FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc().set({
      "productid":random,
      "productno":"${id}${count}",
      "billingid":billcount,
      "billingname1":Itemname.text,
      "billingname2":Itemdescription.text,
      "Qty":qty.text,
      "Rate":Rate.text,
      "Gst":Gst.text,
      "Discount":Discount.text,
      "Total":int.parse(qty.text)*int.parse(Rate.text),
      "timestamp":DateTime.now().microsecondsSinceEpoch,
    });
    setState(() {
      qty.text="1";
      Rate.text=0.toString();
      Gst.text=0.toString();
      Discount.text=0.toString();
      Stocks.text=0.toString();
      dropdownValue = list.first;
      dropdownValue1 = list1.first;
      dropdownValue2 = list2.first;
      dropdown2selctvalue="";
      Saleman.clear();
    });
    billcounts();
  }

  //delete function
  deletebittling(id){
    FirebaseFirestore.instance.collection("billing").doc(random).collection(random).doc(id).delete();
  }


  String random="";
  String printvalue="";

  checkbillno(){
    setState((){
      random = randomAlphaNumeric(10);
      printvalue=random;
    });
    print(random);
  }

  savebills() async {
    FirebaseFirestore.instance.collection("billing").doc(random).update({
      "billingid":random,
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      "Customer name":Cusname.text,
      "Customer phone":mobileno.text,
      "Customer address":customeraddress.text,
      "Bill Type":dropdownValue1,
      "Discount":saveDiscount.text,
      "Bill no":billcount,
      "Total":billingtotal,
    });
    FirebaseFirestore.instance.collection("Customer").doc(customerdocid).collection("billing").doc(random).set({
      "billingid":random,
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      "Customer name":Cusname.text,
      "Customer phone":mobileno.text,
      "Customer address":customeraddress.text,
      "Bill Type":dropdownValue1,
      "Discount":saveDiscount.text,
      "Bill no":billcount,
      "Total":billingtotal,
    });
    Clearall();
  }

  int count=0;
  int docscount=0;
  int billcount=0;

  counts()async{
    var docus=await  FirebaseFirestore.instance.collection("billing").get();
    print(docus.docs.length);
    setState(() {
      count=docus.docs.length+1;
    });

  }



  Clearall(){
    setState(() {
      dropdownValue= 'Please Select Category';
      dropdownValue = list.first;
      dropdownValue1 = list1.first;
      dropdownValue2 = list2.first;
      dropdown2selctvalue="";
      total=0;
      qty.text=1.toString();
      Rate.text=0.toString();
      Gst.text=0.toString();
      Discount.text=0.toString();
      Total.text=0.toString();
      Stocks.text=0.toString();
      billingtotal=0;
    });
    mobileno.clear();
    saveDiscount.clear();
    Cusname.clear();
    customeraddress.clear();
    mobileno.clear();
    Saleman.clear();





  }

  int price=0;
  int total=0;

  /*setvalue(name,quvantity)async{
    var doc=await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<doc.docs.length;i++){
      var document=await FirebaseFirestore.instance.collection("Item").doc(doc.docs[i].id).get();
      if(name==doc.docs[i]["Newitemname"]){
        Map<String,dynamic>?value=document.data();
        setState(() {
          Docid=doc.docs[i].id;
          stocksvalue=value!["Loworder"];
          Stocks.text=stocksvalue.toString();
          Rate.text= value["Saleprice"].toString();
          Gst.text=value["gst"].toString();
        });
        print(stocksvalue);
        print(price);
        print("rtgrdgdgdgdgdgdgdgdg");
        print(total);

      }
    }

  }

   */

  double billingtotal=0;

  billingcount()async{
    setState(() {
      billingtotal=0;
    });
    var billingcount=await FirebaseFirestore.instance.collection("billing").doc(random).collection(random).get();
    for(int i=0;i<billingcount.docs.length;i++){
      print(i);
      setState(() {
        billingtotal=billingtotal+int.parse(billingcount.docs[i]["Total"].toString());
      });
    }

  }


  totalamount(quvantity,amount){

    return (quvantity*amount).toString();
  }


  String itemid="";

  itemnameID(name)async{
    var document= await FirebaseFirestore.instance.collection("Item").get();
    for(int i=0;i<document.docs.length;i++){
      if(document.docs[i]["Newitemname"]==name){
        setState(() {
          itemid=document.docs[i].id;
        });
        print(itemid);
      }
    }


  }


  updateitem(){
    FirebaseFirestore.instance.collection("Item").doc(itemid).update({
      "Loworder":FieldValue.increment(-int.parse(qty.text))
    });
  }


  //showpopup

  _savebillpoprup(){
    print("sdfd");

    return showDialog(context: context, builder:(context) {

      return Padding(
        padding: const EdgeInsets.only(top: 150.0,bottom: 150,left: 350,right:350),
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:30),
                Text("Are You Sure Want to Save Bills",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:18
                ),),

                SizedBox(height:20),

                Container(
                  height:180,
                  width:180,
                  child: Lottie.network(savefile),
                ),
                SizedBox(height:20),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height:40,
                    width:180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xff263646)
                    ),
                    child: Center(
                      child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billingcount();
    previousamount();
    Userdata();
    counts();
    checkbillno();
    createbilling();
  }


  //itemcode find
  String catitemcode='';

  categoryitemcode(itemcode)async{
    var document=await FirebaseFirestore.instance.collection("category").get();
    for(int i=0;i<document.docs.length;i++){
      if(document.docs[i]["categoryname"]==itemcode){
        setState(() {
          catitemcode=document.docs[i]["categoryItemcode"];
        });
        print(catitemcode);

      }
    }

  }


  //cusdtomer name and phone
  List User=[];
  String Userphone="";
  bool search=false;
  int length=0;
  String customerdocid="";


  Userdata()async {
    var details = await FirebaseFirestore.instance.collection("Customer").get();
    print(User);
    for (int i = 0; i < details.docs.length; i++) {
      setState(() {
        User.add(details.docs[i]["Customermobileno"]);
      });
      print(User);
    }
  }

  FocusNode Itemcodes=FocusNode();
  FocusNode Qty=FocusNode();
  FocusNode rate=FocusNode();
  FocusNode gst=FocusNode();
  FocusNode discount=FocusNode();
  FocusNode Customermobileno=FocusNode();
  FocusNode Customernamefield=FocusNode();
  FocusNode Customeraddressfield=FocusNode();
  FocusNode Itemcat=FocusNode();



  customeradd(){
    FirebaseFirestore.instance.collection("Customer").doc().set({
      "Customermobileno":mobileno.text,
      "Customername":Cusname.text,
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

  _customer(){
    return showDialog(context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 150.0,bottom: 150,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:30),
                Text("Are you sure want Add Customer",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:18
                ),),



                Container(
                  height:120,
                  width:120,
                  child: Lottie.network(additem),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Customer Name :",style: GoogleFonts.poppins(),),
                    SizedBox(width:15),
                    Container(
                      height:30,
                      width:200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade400
                      ),
                      child: TextField(
                        controller: customername,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,bottom: 12),
                            border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ),


                SizedBox(height:20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Customer Phone :",style: GoogleFonts.poppins(),),
                    SizedBox(width:15),
                    Container(
                      height:30,
                      width:200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade400
                      ),
                      child: TextField(
                        controller: customerphone,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10,bottom: 12),
                            border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height:20),

                InkWell(
                  onTap: (){
                    customeradd();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height:40,
                    width:180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xff263646)
                    ),
                    child: Center(
                      child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    },);
  }

  bool getvalue=false;

  //print page variables
  String Customer_name="";
  String Customer_phone="";
  String Customer_address="";
  String Customer_date="";
  String Customer_time="";
  String Saleman_name="";
  String rate_type="";
  String bill_type="";
  String customerdiscount="";


  List<int> billing_no=[];
  List<String> product_name=[];
  List<String> product_subname=[];
  List<int> product_total= [];
  List<String> product_qty= [];
  List<String> product_gst= [];
  List<String> product_discount=[];
  List<String> Product_id=[];

  getthevalue()async{
    savebills();
    previousamount();
    var  document= await FirebaseFirestore.instance.collection("billing").doc(random).get();
    Map<String,dynamic>?value=document.data();
    setState(() {
      Customer_name=value!['Customer name'];
      Customer_phone=value['Customer phone'];
      Customer_address=value['Customer address'];
      Customer_date=value['date'];
      Customer_time=value['time'];
      customerdiscount=value['Discount'];
      bill_type=value['Bill Type'];
    });


    var  document2= await FirebaseFirestore.instance.collection("billing").
    doc(random).collection(random).orderBy("timestamp",descending: true).get();
    for(int i=0;i<document2.docs.length;i++){
      if(document2.docs[i]["productid"]==random) {
        setState(() {
          billing_no.add(document2.docs[i]["billingid"]);
          product_name.add(document2.docs[i]["billingname1"]);
          product_subname.add(document2.docs[i]["billingname2"]);
          product_total.add(document2.docs[i]["Total"]);
          product_qty.add(document2.docs[i]["Qty"]);
          product_gst.add(document2.docs[i]["Gst"]);
          product_discount.add(document2.docs[i]["Discount"]);
        });

        print(billing_no);
        print(product_name);
        print(product_subname);
        print(product_total);
        print(product_qty);
        print(product_gst);
        print(product_discount);

      }
    }

    printvalues();
    setState(() {
      //state change boolean
      getvalue=true;
    });

    if(getvalue==true) {
      List<p.Widget> widgets = [];

      //Profile image
      final image = p.ClipOval(
        child:
        p.Image(
          await imageFromAssetBundle(
              'assets/print temp.jpg'),
          fit: p.BoxFit.cover,
          width: 300,
          height: 300,
        ),
      );

      //container for profile image decoration
      final container = p.Center(
        child: p.Container(
            child:
            p.Padding(
              padding: p.EdgeInsets.only(top: 175),
              child: p.Row(
                  children: [
                    p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.start,
                        children: [

                          p.Container(
                              width: 60,
                              child:  p.Center(
                                child: p.Text("Bill NO".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),

                          p.SizedBox(width:5),

                          p.Container(
                              width: 80,
                              child:   p.Center(
                                child:  p.Text("Product Name".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),

                          p.SizedBox(width:5),

                          p.Container(
                              width: 60,
                              child:    p.Center(
                                child:  p.Text("Items".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),

                          p.SizedBox(width:5),
                          p.Container(
                              width: 60,
                              child: p.Center(
                                child:  p.Text("Qty".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),
                          p.SizedBox(width:5),
                          p.Container(
                              width: 60,
                              child:  p.Center(
                                child:  p.Text("Dis %".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),
                          p.SizedBox(width:5),
                          p.Container(
                              width: 60,
                              child:  p.Center(
                                child: p.Text("Gst".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          ),
                          p.SizedBox(width:5),
                          p.Container(
                              width: 60,
                              child:p.Center(
                                child:   p.Text("Total".toString(),style: p.TextStyle(color: PdfColors.black)),
                              )
                          )

                        ]
                    ),

                  ]
              ),
            )

        ),
      );
      //widgets.add(container);

      widgets.add(p.SizedBox(height: 22));

      widgets.add(
          p.Stack(
              children: [

                p.Container(
                    height: 600,
                    child:
                    p.Image(
                        await imageFromAssetBundle(
                            'assets/print temp.jpg'),
                        fit: p.BoxFit.fill
                    )
                ),
                container,
                p.Padding(
                    padding: p.EdgeInsets.only(top:90),
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
                                          p.Row(
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
                                          ),
                                          p.SizedBox(height:5),
                                          p.Row(
                                              children: [
                                                p.Container(
                                                    width:110,
                                                    height: 20,
                                                    child:  p.Center(
                                                      child: p.Text("Customer Address:",style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child: p.Center(
                                                      child:
                                                      p.Text(Customer_address.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),
                                          p.SizedBox(height:5),
                                          p.Row(
                                              children: [
                                                p.Container(
                                                    width:110,
                                                    height: 20,
                                                    child:  p.Center(
                                                      child:  p.Text("Date :",style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child: p.Center(
                                                      child:  p.Text(Customer_date.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),
                                        ]
                                    )
                                ),

                                p.SizedBox(width:5),

                                p.Container(

                                    child:   p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.start,
                                        mainAxisAlignment: p.MainAxisAlignment.start,
                                        children: [
                                          p.Row(
                                              crossAxisAlignment: p.CrossAxisAlignment.start,
                                              children: [
                                                p.Container(
                                                    width:110,
                                                    height: 20,
                                                    child: p.Center(
                                                      child: p.Text("Customer phone :",style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child:  p.Center(
                                                      child: p.Text(Customer_phone.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),
                                          p.SizedBox(height:5),
                                          p.Row(
                                              children: [
                                                p.Container(
                                                    width:110,
                                                    height: 20,
                                                    child:  p.Center(
                                                      child:  p.Text("Payment Type:",style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                ),
                                                p.Container(
                                                    width:140,
                                                    height: 20,
                                                    child: p.Center(

                                                      child: p.Text(bill_type.toString(),style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                )
                                              ]
                                          ),
                                          p.SizedBox(height:5),
                                          p.Row(
                                              children: [
                                                p.Container(
                                                    width:110,
                                                    height: 20,
                                                    child: p.Center(
                                                      child:  p.Text("Time :",style: p.TextStyle(color: PdfColors.black)),
                                                    )
                                                ),
                                                p.Container(
                                                  width:140,
                                                  height: 20,
                                                  child: p.Center(
                                                      child: p.Text(Customer_time.toString(),style: p.TextStyle(color: PdfColors.black))
                                                  ),
                                                )
                                              ]
                                          )
                                        ]
                                    )
                                ),

                              ]
                          ),
                          p.SizedBox(height:35),


                          p.ListView.builder(
                              itemBuilder: (context, index) {
                                return
                                  p.Row(
                                      mainAxisAlignment: p.MainAxisAlignment.start,
                                      children: [

                                        p.Container(
                                            width: 60,
                                            child: p.Center(
                                              child:  p.Text(billing_no[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),

                                        p.SizedBox(width:5),

                                        p.Container(
                                            width: 80,
                                            child:   p.Center(
                                              child:  p.Text(product_name[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),

                                        p.SizedBox(width:5),

                                        p.Container(
                                            width: 60,
                                            child:     p.Center(
                                              child: p.Text(product_subname[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),

                                        p.SizedBox(width:5),
                                        p.Container(
                                            width: 60,
                                            child: p.Center(
                                              child:  p.Text(product_qty[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),
                                        p.SizedBox(width:5),
                                        p.Container(
                                            width: 60,
                                            child:   p.Center(
                                              child: p.Text(product_discount[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),
                                        p.SizedBox(width:5),
                                        p.Container(
                                            width: 60,
                                            child:p.Center(
                                              child:   p.Text(product_gst[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        ),
                                        p.SizedBox(width:5),
                                        p.Container(
                                            width: 60,
                                            child:  p.Center(
                                              child: p.Text(product_total[index].toString(),style: p.TextStyle(color: PdfColors.black)),
                                            )
                                        )

                                      ]
                                  );
                              }, itemCount:product_name.length ),


                          p.Padding(
                              padding: p.EdgeInsets.only(left:10,right: 10,top:200),
                              child: p.Divider(
                                  color: PdfColors.black,
                                  thickness: 0.8
                              )
                          ),
                          p.Padding(
                              padding: p.EdgeInsets.only(left:10,right: 10,top:210),
                              child: p.Row(
                                  mainAxisAlignment: p.MainAxisAlignment.end,
                                  children: [
                                    p.Container(
                                      width:50,
                                      child:  p.Text("Total :", style: p.TextStyle(color: PdfColors.black)),
                                    ),
                                    p.SizedBox(width:10),
                                    p.Container(
                                      width:100,
                                      child:  p.Text(billingtotal.toString(), style: p.TextStyle(color: PdfColors.black)),
                                    )
                                  ]
                              )
                          )


                        ]
                    )
                )
              ]
          )
      );


      final pdf = p.Document();
      pdf.addPage(
        p.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (
              context) => widgets, //here goes the widgets list
        ),
      );
      Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async =>
            pdf.save(),
      );

      Future.delayed(Duration(seconds: 5),(){
        setState(() {
          getvalue=false;
        });
      });

    }


  }


  printvalues(){

    print(Customer_name);
    print(Customer_phone);
    print(Customer_address);
    print(Customer_date);
    print(Customer_time);
    print(Saleman_name);
    print(product_name);
    print(product_subname);
    print(product_total);
    print(product_qty);
  }





}


