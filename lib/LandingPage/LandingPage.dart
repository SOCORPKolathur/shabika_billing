import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shabika_billing/Service_Job_sheet_File/techservices.dart';
import '../Banking_Page/Banking_Page.dart';
import '../Brand_Page/Brand.dart';
import '../Catogorys_Page/Catogory.dart';
import '../Customer-Page/Customer.dart';
import '../Customer_Page_Reports.dart';
import '../Item_Page/Item.dart';
import '../Home_Page/SecondScreen.dart';
import '../Payment _Page/Payment _Page.dart';
import '../Purchase_Entry.dart';
import '../Purchase_Reports.dart';
import '../Purchase_return file/Purchase_return_Page.dart';
import '../Purchase_return_Page.dart';
import '../ReplaceMent_Page/ReplaceMent_Page.dart';
import '../ReplaceMent_Page/Replacement_Reports.dart';
import '../Reports_Page.dart';
import '../Sales_return_File/Sales_Return_Page.dart';
import '../Sales_return_Page.dart';
import '../Service_Job_sheet_File/Item_Description_Page.dart';
import '../Service_Job_sheet_File/Service_Brand_Page.dart';
import '../Service_Job_sheet_File/Service_Entry_Page.dart';
import '../Service_Job_sheet_File/Service_Problem_Page.dart';
import '../Service_Job_sheet_File/Service_Reports_Page.dart';
import '../Service_Job_sheet_File/Service_Status.dart';
import '../Service_Job_sheet_File/Service_Update_Status_Page.dart';
import '../Simcard_Page-Files/Operator_Page.dart';
import '../Simcard_Page-Files/Simacard_Operator_Page.dart';
import '../Simcard_Page-Files/SimcardReport_Page.dart';
import '../Stocks_List-Page.dart';
import '../Suppiler_Pages/Supplier.dart';
import '../Suppiler_Reports.dart';
import '../billing_Page.dart';
import '../wanted_PAge_file/Wanted_List_Page.dart';
import '../wanted_PAge_file/Wanted_Report-Page.dart';
import '../wanted_PAge_file/Wanted_status_Page.dart';


const List<String> list = <String>[
  'Master',
  'Category',
  'Brand',
  'Item',
  "Customer",
  'Supplier',
  'Payment',
];

const List<String> saleslist = <String>[
  'Sales',
  'Sales\nEntry',
  'Sales\nReports',
  "Sales\nReturns",
  "SL-Returns\nReports",

];

const List<String> Purchaselist = <String>[
  'Purchase',
  'Purchase\nEntry',
  'Purchase\nReports',
  "Purchase\nReturns",
  "Returns\nReports"

];

const List<String> Bankinglist = <String>[
  'Banking',
  'Category',
  'Brand',
  'Item',
  "Customer",
  'Tax Main',
  'Supplier',
  "Expense\nMain",
  'Expense\nSub',
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
  "Expense\nMain",
  'Expense\nSub',
  'Finance'

];

const List<String> Reportslist = <String>[
  'Reports',
  "Customer\nReports",
  "Sales\nReports",
  "Purchase\nReports",
  "Expenses\nReports",
  "Supplier\nReports",
  "GST\nReports",

];

const List<String> Supportlists = <String>[
  'Service',
  'Service\nProblem',
  'Service\nBrand',
  'Service\nStatus',
  'Service\nEntry',
  'Service\nReports',
  'Work\nSheet',
];

const List<String> Simcardlists = <String>[
  'Simcard',
  'Operator',
  'Simcard\nEntry',
  'Simcard\nReports',

];

const List<String> Replacelists = <String>[
  'Replace',
  'Replace\nEntry',
  'Replace\nReports',

];

const List<String> Wantedlists = <String>[
  'Wanted',
  'Status',
  'Entry',
  'Reports',
];

class drawer extends StatefulWidget {
  String loginperson;
   drawer(this.loginperson);

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

  String Receivedperson='';

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

  String dropdownValue9=Simcardlists.first;

  String dropdownValue10=Wantedlists.first;

  String dropdownValue11=Replacelists.first;

  @override
  void initState() {
    setState(() {
      Receivedperson=widget.loginperson;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //dropdown lists....(all)--top container
            Container(
              height: height/13.14,
              width: double.infinity,
              color: const Color(0xff263646),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                child: Row(
                 children: [

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
                          dropdownValue=list.first;
                          dropdownValue2=saleslist.first;
                          dropdownValue3=Purchaselist.first;
                          dropdownValue5=Bankinglist.first;
                          dropdownValue6=Stockslist.first;
                          dropdownValue7=Reportslist.first;
                          dropdownValue8=Supportlists.first;
                          dropdownValue9=Simcardlists.first;
                          dropdownValue10=Wantedlists.first;
                          dropdownValue11=Replacelists.first;
                       });
                     },
                     child: Container(
                       height: height/16.425,
                       width: width/19.075,
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
                     width:100,
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

                           DropdownButton2<String>(
                             value: dropdownValue,
                              style:GoogleFonts.montserrat(
                               fontSize: width/113.833,
                               color:dawer==1?Colors.black:Colors.white,
                               fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                               icon:Icon(Icons.arrow_back_ios_outlined),
                               iconSize: 0
                             ),
                             onMenuStateChange: (isOpen){
                               setState(() {
                                 dawer=0;
                               });
                             },

                             onChanged: (String? value) {
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
                                   dropdownValue = value!;
                                   Pages=dropdownValue;
                                   select=0;

                                    dropdownValue2=saleslist.first;

                                    dropdownValue3=Purchaselist.first;

                                    dropdownValue5=Bankinglist.first;

                                    dropdownValue6=Stockslist.first;

                                    dropdownValue7=Reportslist.first;

                                    dropdownValue8=Supportlists.first;

                                    dropdownValue9=Simcardlists.first;

                                    dropdownValue10=Wantedlists.first;

                                   dropdownValue11=Replacelists.first;
                                 });
                             },
                             items:
                             list.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==1?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                               decoration: BoxDecoration(
                                   color: dawer==1?Colors.white:const Color(0xff263646)
                               )
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                   //item container
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
                         dawer = 9;
                         Pages="Item";
                         dropdownValue=list.first;
                         dropdownValue2=saleslist.first;
                         dropdownValue3=Purchaselist.first;
                         dropdownValue5=Bankinglist.first;
                         dropdownValue6=Stockslist.first;
                         dropdownValue7=Reportslist.first;
                         dropdownValue8=Supportlists.first;
                         dropdownValue9=Simcardlists.first;
                         dropdownValue10=Wantedlists.first;
                         dropdownValue11=Replacelists.first;
                       });
                     },
                     child: Container(
                         height: height/16.425,
                         width: width/19.5,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(7),
                           color: dawer==9?Colors.white:Colors.transparent,
                         ),
                         child:Row(
                           children: [
                             Icon(Icons.data_thresholding_sharp,color: dawer==9?Colors.black:Colors.white,),
                             SizedBox(width: width/273.2,),
                             Text("Items",style:  GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==9?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),),
                           ],
                         )
                     ),
                   ),


                   //Purchase dropdown
                   SizedBox(width: width/136.6,),
                   Container(
                     height: height/16.425,
                     width:width/12.757,
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
                           DropdownButton2<String>(
                             value: dropdownValue3,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==3?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),
                             onMenuStateChange: (isOpen){
                               setState(() {
                                 dawer=0;
                               });
                             },

                             onChanged: (String? value) {
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
                                 dropdownValue3 = value!;
                                 Pages=dropdownValue3;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue9=Simcardlists.first;
                                 dropdownValue10=Wantedlists.first;
                                 dropdownValue11=Replacelists.first;
                               });
                             },
                             items:
                             Purchaselist.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==3?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==3?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                   //sales dropdown
                   SizedBox(width: width/136.6,),
                   Container(
                    height: height/16.425,
                     width:width/14.0,
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

                           DropdownButton2<String>(
                             value: dropdownValue2,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==2?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),


                             onChanged: (String? value) {
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
                                 dropdownValue2 = value!;
                                 sales=false;
                                 Pages=dropdownValue2;
                                 dropdownValue=list.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue9=Simcardlists.first;
                                 dropdownValue10=Wantedlists.first;
                                 dropdownValue11=Replacelists.first;
                               });
                             },
                             items:
                             saleslist.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==2?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==2?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                   //Barcode container
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
                         dawer = 10;
                         dropdownValue=list.first;
                         dropdownValue2=saleslist.first;
                         dropdownValue3=Purchaselist.first;
                         dropdownValue5=Bankinglist.first;
                         dropdownValue6=Stockslist.first;
                         dropdownValue7=Reportslist.first;
                         dropdownValue8=Supportlists.first;
                         dropdownValue9=Simcardlists.first;
                         dropdownValue10=Wantedlists.first;
                         dropdownValue11=Replacelists.first;

                       });
                     },
                     child: Container(
                         height: height/16.425,
                         width: width/16.2,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(7),
                           color: dawer==10?Colors.white:Colors.transparent,
                         ),
                         child:Row(
                           children: [
                             Icon(Icons.barcode_reader,color: dawer==10?Colors.black:Colors.white,),
                             SizedBox(width: width/273.2,),
                             Text("Barcode",style:  GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==10?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),),
                           ],
                         )
                     ),
                   ),

                   //Banking dropdown
                   SizedBox(width: width/136.6),
                   GestureDetector(
                     onTap: (){
                       setState(() {
                         master = false;
                         sales = false;
                         purchase = false;
                         Transfers = false;
                         Banking = false;
                         Reports = false;
                         Support = false;
                         Pages="Banking";
                         Banking=!Banking;
                         dawer=5;
                         dropdownValue=list.first;
                         dropdownValue2=saleslist.first;
                         dropdownValue3=Purchaselist.first;
                         dropdownValue5=Bankinglist.first;
                         dropdownValue6=Stockslist.first;
                         dropdownValue7=Reportslist.first;
                         dropdownValue8=Supportlists.first;
                         dropdownValue9=Simcardlists.first;
                         dropdownValue10=Wantedlists.first;
                         dropdownValue11=Replacelists.first;
                       });
                     },
                     child: Container(
                       height: height/16.425,
                       width:width/16.0,
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
                             Text("Banking",style: TextStyle(color: dawer==5?Colors.black:Colors.white,
                                 fontWeight: FontWeight.w700),)




                           ],
                         ),
                       ),
                     ),
                   ),


                   //stocks dropdown
                   SizedBox(width: width/136.6,),
                   GestureDetector(
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
                         Pages="Stocks";
                         dropdownValue=list.first;
                         dropdownValue2=saleslist.first;
                         dropdownValue3=Purchaselist.first;
                         dropdownValue5=Bankinglist.first;
                         dropdownValue6=Stockslist.first;
                         dropdownValue7=Reportslist.first;
                         dropdownValue8=Supportlists.first;
                         dropdownValue9=Simcardlists.first;
                         dropdownValue10=Wantedlists.first;
                         dropdownValue11=Replacelists.first;
                       });
                     },
                     child: Container(
                      height: height/16.425,
                       width:width/23.0,
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
                             Text("Stocks",style: TextStyle(color: dawer==6?Colors.black:Colors.white,
                                 fontWeight: FontWeight.w700),)




                           ],
                         ),
                       ),
                     ),
                   ),

                   //Reports dropdown
                   SizedBox(width: width/136.6,),
                   Container(
                    height: height/16.425,
                     width:width/11.383,
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
                           DropdownButton2<String>(
                             value: dropdownValue7,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==7?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData:const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),


                             onChanged: (String? value) {
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
                                 dropdownValue7 = value!;
                                 Pages=dropdownValue7;
                                 Reports=false;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue9=Simcardlists.first;
                                 dropdownValue10=Wantedlists.first;
                                 dropdownValue11=Replacelists.first;
                               });
                             },
                             items:
                             Reportslist.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==7?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==7?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),

                   //Service dropdown
                   SizedBox(width: width/136.6),
                   Container(
                    height: height/16.425,
                     width:width/12.418,
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


                           DropdownButton2<String>(
                             value: dropdownValue8,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==8?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData:const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),


                             onChanged: (String? value) {
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
                                 dropdownValue8 = value!;
                                 Pages=value;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue9=Simcardlists.first;
                                 dropdownValue10=Wantedlists.first;
                                 dropdownValue11=Replacelists.first;
                               });
                             },
                             items:
                             Supportlists.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==8?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==8?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),

                   //wanted container
                   SizedBox(width: width/136.6,),
                   Container(
                     height: height/16.425,
                     width:width/13.383,
                     decoration: BoxDecoration(
                         color: dawer==11?Colors.white:Colors.transparent,
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
                           Icon(Icons.data_saver_on,color: dawer==11?Colors.black:Colors.white,),
                           SizedBox(width: width/273.2,),
                           DropdownButton2<String>(
                             value: dropdownValue10,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==12?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),
                             onChanged: (String? value) {
                               setState(() {
                                 dropdownValue10=value!;
                                 Pages=value;
                                 master = false;
                                 sales = false;
                                 purchase = false;
                                 Transfers = false;
                                 Banking = false;
                                 stocks = false;
                                 Reports = false;
                                 Support = false;
                                 dawer = 11;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue9=Simcardlists.first;
                                 dropdownValue11=Replacelists.first;

                               });
                             },
                             items:
                             Wantedlists.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==11?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==11?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),



                   //SimCards container
                   SizedBox(width: width/136.6,),
                   Container(
                     height: height/16.425,
                     width:width/11.383,
                     decoration: BoxDecoration(
                         color: dawer==12?Colors.white:Colors.transparent,
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
                           Icon(Icons.sim_card,color: dawer==12?Colors.black:Colors.white,),
                           SizedBox(width: width/273.2,),
                           DropdownButton2<String>(
                             value: dropdownValue9,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==12?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),
                             onChanged: (String? value) {
                               setState(() {
                                 master = false;
                                 sales = false;
                                 purchase = false;
                                 Transfers = false;
                                 Banking = false;
                                 stocks = false;
                                 Reports = false;
                                 Support = false;
                                 dawer = 12;
                                 dropdownValue9=value!;
                                 Pages=dropdownValue9;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue10=Wantedlists.first;
                                 dropdownValue11=Replacelists.first;

                               });
                             },
                             items:
                             Simcardlists.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==12?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==12?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),


                   //replacement dropdown
                   SizedBox(width: width/136.6,),
                   Container(
                     height: height/16.425,
                     width:width/11.383,
                     decoration: BoxDecoration(
                         color: dawer==13?Colors.white:Colors.transparent,
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
                           Icon(Icons.replay_circle_filled_rounded,color: dawer==13?Colors.black:Colors.white,),
                           SizedBox(width: width/273.2,),
                           DropdownButton2<String>(
                             value: dropdownValue11,
                             style:GoogleFonts.montserrat(
                                 fontSize: width/113.833,
                                 color:dawer==13?Colors.black:Colors.white,
                                 fontWeight: FontWeight.bold),
                             underline: Container(
                               color: Colors.deepPurpleAccent,
                             ),
                             iconStyleData: const IconStyleData(
                                 icon:Icon(Icons.arrow_back_ios_outlined),
                                 iconSize: 0
                             ),
                             onChanged: (String? value) {
                               setState(() {
                                 master = false;
                                 sales = false;
                                 purchase = false;
                                 Transfers = false;
                                 Banking = false;
                                 stocks = false;
                                 Reports = false;
                                 Support = false;
                                 dawer = 13;
                                 dropdownValue11=value!;
                                 Pages=dropdownValue11;
                                 dropdownValue=list.first;
                                 dropdownValue2=saleslist.first;
                                 dropdownValue3=Purchaselist.first;
                                 dropdownValue5=Bankinglist.first;
                                 dropdownValue6=Stockslist.first;
                                 dropdownValue7=Reportslist.first;
                                 dropdownValue8=Supportlists.first;
                                 dropdownValue10=Wantedlists.first;
                               });
                             },
                             items:
                             Replacelists.map<DropdownMenuItem<String>>(
                                     (String value) {
                                   return DropdownMenuItem<String>(
                                     value: value,
                                     child: Text(value,style:GoogleFonts.montserrat(
                                         fontSize: width/113.833,
                                         color:dawer==13?Colors.black:Colors.white,
                                         fontWeight: FontWeight.bold),),
                                   );
                                 }).toList(),
                             dropdownStyleData: DropdownStyleData(
                                 decoration: BoxDecoration(
                                     color: dawer==13?Colors.white:const Color(0xff263646)
                                 )
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),
                   SizedBox(width: width/136.6,),

                 ],
                ),
              ),
            ),

            Container(
              color: const Color(0xff00A99D),
              width: width/1,
              height: height/1,
              child: SingleChildScrollView(child:
              Pages=="Home"?Home("Home"):
              Pages=="Category"?const Category():
              Pages=="Brand"?const Brand():
              Pages=="Item"?Item(Pages):
              Pages=="Customer"? Customer(Pages):
              Pages=="Supplier"?const Supplier():
              Pages=="Sales\nEntry"?const Billing_Page():
              Pages=="Sales\nReports"?const Reports_Page():
              Pages=="Purchase\nEntry"?Purchase_Entry():
              Pages=="Purchase\nReports"?Purchase_Reports():
              Pages=="Customer\nReports"?const Customer_Page_Reports():
              Pages=="Supplier\nReports"?const Supplier_Reports():
              Pages=="Banking"? const Banking_Page():
              Pages=="Stocks"?const Stocks_Page():
              Pages=="Purchase\nReturns"?const Purcharse_Return_Page():
              Pages=="Sales\nReturns"?const Sales_Return_Page():
              Pages=="Returns\nReports"?const Purchase_return_Page():
              Pages=="Sales\nReturns"?const Sales_Return_Page():
              Pages=="SL-Returns\nReports"? const SL_return_reports():
              Pages=='Operator'?const Opeartor_Page():
              Pages=='Simcard\nEntry'?const Simacard_Operator_Page():
              Pages=='Simcard\nReports'?const SimcardReport_Page():
              Pages== 'Entry'? WantedList_Page():
              Pages== 'Status'? const Wanted_status_Page():
              Pages=='Reports'? const Wanted_reports_Page():
              Pages== 'Service\nProblem'?  const Service_Problem_Page():
              Pages== 'Service\nBrand'?   const Service_Brand_Page():
              Pages== 'Service\nStatus'?  const  Service_Status_Page():
              Pages== 'Service\nEntry'?    Service_Entry_Page2(widget.loginperson,"",""):
              Pages== 'Work\nSheet'?    techService():
              Pages== 'Service\nReports'?   const Service_Reports_Page():
              Pages== 'Items\nMaster'?  const  Item_Description_Page():
              Pages== "Payment"?  const  Payment_Page():
              Pages== 'Replace\nEntry'?    const ReplaceMent_Page():
              Pages== 'Replace\nReports'?      Replacement_Reports():
              Container()),
            )
          ],
        ),
      ),
    );
  }
}
