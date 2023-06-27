import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Brand_Page/Brand.dart';
import '../Catogorys_Page/Catogory.dart';
import '../Customer-Page/Customer.dart';
import '../Customer_Page_Reports.dart';
import '../Item_Page/Item.dart';
import '../Home_Page/SecondScreen.dart';
import '../Purchase_Entry.dart';
import '../Purchase_Reports.dart';
import '../Reports_Page.dart';
import '../Suppiler_Pages/Supplier.dart';
import '../Suppiler_Reports.dart';
import '../billing_Page.dart';


const List<String> list = <String>[
  'Master',
  'Category',
  'Brand',
  'Item',
  "Customer",
  'Tax Main',
  'Supplier',
  "Expense Main",
  'Expense Sub',
];

const List<String> saleslist = <String>[
  'Sales',
  'Sales Reports',
  'Sales Entry',

];

const List<String> Purchaselist = <String>[
  'Purchase',
  'Purchase Reports',
  'Purchase Entry',

];

const List<String> Bankinglist = <String>[
  'Banking',
  'Category',
  'Brand',
  'Item',
  "Customer",
  'Tax Main',
  'Supplier',
  "Expense Main",
  'Expense Sub',
  'Finance'

];

const List<String> Stockslist = <String>[
  'Stocks',
  'Category',
  'Brand',
  'Item',
  "Customer",
  'Tax Main',
  'Supplier',
  "Expense Main",
  'Expense Sub',
  'Finance'

];

const List<String> Reportslist = <String>[
  'Reports',
  "Customer Reports",
  "Sales Reports",
  "Purchase Reports",
  "Expenses Reports",
  "Supplier Reports",
  "GST Reports",

];

const List<String> Supportlists = <String>[
  'Service',
  'Service job sheet',
];

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  bool master = false;
  bool sales = false;
  bool purchase = false;
  bool Transfers = false;
  bool Banking = false;
  bool stocks = false;
  bool Reports = false;
  bool Support = false;
  int dawer = 0;
  int select=0;

  String Pages="Home";

  //dropdown variables...
  //master variable
  String dropdownValue=list.first;
  //sales variable
  String dropdownValue2=saleslist.first;

  String dropdownValue3=Purchaselist.first;


  String dropdownValue5=Bankinglist.first;

  String dropdownValue6=Stockslist.first;

  String dropdownValue7=Reportslist.first;

  String dropdownValue8=Supportlists.first;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff00A99D),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //dropdown lists....(all)--top container
            Container(
              height: height/13.14,
              width: double.infinity,
              color: Color(0xff263646),
              child: Row(
               children: [
                 //shabika image
                 Padding(
                   padding:  EdgeInsets.only(left: width/136.6),
                   child: Image.asset("assets/Vector4.png"),
                 ),

                 //shabika text
                 InkWell(
                   onTap: (){
                     print(height);
                     print(width);
                   },
                   child: Padding(
                     padding:  EdgeInsets.symmetric(
                         horizontal: width/170.75,
                         vertical: height/82.125
                     ),
                     child: Text(
                       "Shabika",
                       style: GoogleFonts.poppins(
                           fontSize: width/75.888, color: Colors.white),
                     ),
                   ),
                 ),

                 //home container
                 SizedBox(width: width/136.6,),
                 InkWell(
                   onTap: (){
                     setState(() {
                        master = false;
                        sales = false;
                        purchase = false;
                        Transfers = false;
                        Banking = false;
                        stocks = false;
                        Reports = false;
                        Support = false;
                        dawer = 0;
                        Pages="Home";
                     });
                   },
                   child: Container(
                     height: height/16.425,
                     width: width/17.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: dawer==0?Colors.white:Colors.transparent,
                    ),
                     child:Row(
                       children: [
                         Icon(Icons.home,color: dawer==0?Colors.black:Colors.white,),
                         SizedBox(width: width/273.2,),
                         Text("Home",style:  GoogleFonts.montserrat(
                             fontSize: width/113.833,
                             color:dawer==0?Colors.black:Colors.white,
                             fontWeight: FontWeight.bold),),
                       ],
                     )
                   ),
                 ),

                 //master dropdowmn
                 SizedBox(width: width/136.6,),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                     color: dawer==1?Colors.white:Colors.transparent,
                     borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                     padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector1.png",color: dawer==1?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           dropdownColor:dawer==1?Colors.white :Color(0xff263646),
                           value: dropdownValue,
                           onTap: (){
                             setState(() {
                               master=!master;
                               dawer=1;
                                sales = false;
                                purchase = false;
                                Transfers = false;
                                Banking = false;
                                stocks = false;
                                Reports = false;
                                Support = false;
                               Pages="Home";
                               select=1;
                             });

                           },
                           icon:  master == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue = value!;
                               Pages=dropdownValue;
                                 select=0;
                             });

                           },
                           items: list.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child:
                               Text(value,style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color:dawer==1?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //sales dropdown
                 SizedBox(width: width/136.6,),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==2?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector3.png",color:dawer==2?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           value: dropdownValue2,
                           dropdownColor:dawer==2?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               sales=!sales;
                               dawer=2;
                               master = false;
                               purchase = false;
                               Transfers = false;
                               Banking = false;
                               stocks = false;
                               Reports = false;
                               Support = false;
                             });
                           },
                           icon:sales == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue2 = value!;
                               sales=false;
                               Pages=dropdownValue2;
                             });
                           },
                           items: saleslist.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color: dawer==2?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //Purchase dropdown
                 SizedBox(width: width/136.6,),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==3?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector5.png",color:dawer==3?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           value: dropdownValue3,
                           dropdownColor:dawer==3?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               purchase=!purchase;
                               dawer=3;
                               master = false;
                               sales = false;
                               Transfers = false;
                               Banking = false;
                               stocks = false;
                               Reports = false;
                               Support = false;
                             });
                           },
                           icon:   purchase == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue3 = value!;
                               Pages=dropdownValue3;
                             });
                           },
                           items: Purchaselist.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color:dawer==3?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //Banking dropdown
                 SizedBox(width: width/136.6),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==5?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector7.png",color:dawer==5?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           value: dropdownValue5,
                           dropdownColor:dawer==5?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               Banking=!Banking;
                               dawer=5;
                               master = false;
                               sales = false;
                               purchase = false;
                               Transfers = false;
                               stocks = false;
                               Reports = false;
                               Support = false;
                             });
                           },
                           icon:   Banking == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue5 = value!;
                             });
                           },
                           items: Bankinglist.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color:dawer==5?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //stocks dropdown
                 SizedBox(width: width/136.6,),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==6?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector8.png",color:dawer==6?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           value: dropdownValue6,
                           dropdownColor:dawer==6?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               stocks=!stocks;
                               dawer=6;
                               master = false;
                               sales = false;
                               purchase = false;
                               Transfers = false;
                               Banking = false;
                               Reports = false;
                               Support = false;
                             });
                           },
                           icon:   stocks == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue6 = value!;
                             });
                           },
                           items: Stockslist.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,
                                   style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color:dawer==6?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //Reports dropdown
                 SizedBox(width: width/136.6,),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==7?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child:
                   Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector9.png",color:dawer==7?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),
                         DropdownButton<String>(
                           value: dropdownValue7,
                           dropdownColor:dawer==7?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               Reports=!Reports;
                               dawer=7;
                               master = false;
                               sales = false;
                               purchase = false;
                               Transfers = false;
                               Banking = false;
                               stocks = false;
                               Support = false;
                             });
                           },
                           icon:  Reports == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue7 = value!;
                               Pages=dropdownValue7;
                               Reports=false;
                             });
                           },
                           items: Reportslist.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,
                                   style:GoogleFonts.montserrat(
                                       fontSize: width/113.833,
                                       color:dawer==7?Colors.black:Colors.white,
                                       fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),

                       ],
                     ),
                   ),
                 ),

                 //Service dropdown
                 SizedBox(width: width/136.6),
                 Container(
                  height: height/16.425,
                   decoration: BoxDecoration(
                       color: dawer==8?Colors.white:Colors.transparent,
                       borderRadius: BorderRadius.circular(7)
                   ),
                   child: Padding(
                   padding:  EdgeInsets.symmetric(
                       horizontal: width/455.33,
                       vertical: height/219
                     ),
                     child: Row(
                       children: [
                         Image.asset("assets/Vector10.png",color:dawer==8?Colors.transparent:Colors.white),
                         SizedBox(width: width/273.2,),

                         DropdownButton<String>(
                           value: dropdownValue8,
                           dropdownColor:dawer==8?Colors.white :Color(0xff263646),
                           onTap: (){
                             setState(() {
                               Support=!Support;
                               dawer=8;
                               master = false;
                               sales = false;
                               purchase = false;
                               Transfers = false;
                               Banking = false;
                               stocks = false;
                               Reports = false;
                             });
                           },
                           icon:   Support == false
                               ? Icon(
                             Icons.arrow_forward_ios_sharp,
                             color: Colors.white,
                             size: width/80.353,
                           )
                               : Icon(
                             Icons.arrow_downward,
                             color: Colors.black,
                             size: width/80.353,
                           ),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 0,
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue8 = value!;
                             });
                           },
                           items: Supportlists.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value,style:GoogleFonts.montserrat(
                                   fontSize: width/113.833,
                                   color:dawer==8?Colors.black:Colors.white,
                                   fontWeight: FontWeight.bold)),
                             );
                           }).toList(),
                         ),
                       ],
                     ),
                   ),
                 ),

               ],
              ),
            ),

            Container(
              color: Color(0xff00A99D),
              width: width/1,
              height: height/1,
              child: SingleChildScrollView(child:
              Pages=="Home"?Home("Home"):
              Pages=="Category"?Category():
              Pages=="Brand"?Brand():
              Pages=="Item"?Item(Pages):
              Pages=="Customer"?Customer():
              Pages=="Supplier"?Supplier():
              Pages=="Sales Entry"?Billing_Page():
              Pages=="Sales Reports"?Reports_Page():
              Pages=="Purchase Entry"?Purchase_Entry():
              Pages=="Purchase Reports"?Purchase_Reports():
              Pages=="Customer Reports"?Customer_Page_Reports():
              Pages=="Supplier Reports"?Supplier_Reports():
              Container()),
            )
          ],
        ),
      ),
    );
  }
}
