import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Banking_Page extends StatefulWidget {
  const Banking_Page({Key? key}) : super(key: key);

  @override
  State<Banking_Page> createState() => _Banking_PageState();
}

class _Banking_PageState extends State<Banking_Page> {



  TextEditingController pos1=TextEditingController();
  TextEditingController pos2=TextEditingController();
  final DateFormat formatter = DateFormat('d/M/yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];

  bool datesearch=false;
  bool check=false;
  bool check2=false;
  bool check3=true;


  double totalamount=0;
  double totalamount2=0;
  double totalprofitamount=0;

  Future<void> totalamountfunction() async {

    setState(() {
      totalamount=0;
      totalamount2=0;
      totalprofitamount=0;
    });


    if(check==true){
      var purchase=await FirebaseFirestore.instance.collection("Purchase ShabikaG").where("save",isEqualTo:true).get();

      for(int i=0;i<purchase.docs.length;i++){
        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var purchase2=await FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(purchase.docs[i].id).collection(purchase.docs[i].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<purchase2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[s]['Total']);
            });
          }

        }
        else{
          var purchase2=await FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(purchase.docs[i].id).collection(purchase.docs[i].id).get();
          for(int j=0;j<purchase2.docs.length;j++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[j]['Total']);
            });



          }
        }

      }

      var Billing=await FirebaseFirestore.instance.collection("billing ShabikaG").where("save",isEqualTo:true).get();

      for(int k=0;k<Billing.docs.length;k++){

        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var Billing2=await FirebaseFirestore.instance.collection("billing ShabikaG").doc(Billing.docs[k].id).collection(Billing.docs[k].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<Billing2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(Billing2.docs[s]['Total']);
            });
          }

        }

        else{
          var Billing2=await FirebaseFirestore.instance.collection("billing ShabikaG").doc(Billing.docs[k].id).collection(Billing.docs[k].id).get();

          for(int l=0;l<Billing2.docs.length;l++){
            if(mydate.isNotEmpty){
              if(mydate.contains(Billing2.docs[l]['date'].toString())){
                setState(() {
                  totalamount=totalamount+double.parse(Billing2.docs[l]['Total']);
                });
              }
            }
            else{
              setState(() {
                totalamount2=totalamount2+double.parse(Billing2.docs[l]['Total']);
              });
            }
          }
        }


      }
      setState(() {
        totalprofitamount=totalamount+totalamount2;
      });

    }

    if(check2==true){
      var purchase=await FirebaseFirestore.instance.collection("Purchase ShabikaN").where("save",isEqualTo:true).get();

      for(int i=0;i<purchase.docs.length;i++){
        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var purchase2=await FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(purchase.docs[i].id).collection(purchase.docs[i].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<purchase2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[s]['Total']);
            });
          }

        }
        else{
          var purchase2=await FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(purchase.docs[i].id).collection(purchase.docs[i].id).get();
          for(int j=0;j<purchase2.docs.length;j++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[j]['Total']);
            });



          }
        }

      }

      var Billing=await FirebaseFirestore.instance.collection("billing ShabikaN").where("save",isEqualTo:true).get();

      for(int k=0;k<Billing.docs.length;k++){

        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var Billing2=await FirebaseFirestore.instance.collection("billing ShabikaN").doc(Billing.docs[k].id).collection(Billing.docs[k].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<Billing2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(Billing2.docs[s]['Total']);
            });
          }

        }

        else{
          var Billing2=await FirebaseFirestore.instance.collection("billing ShabikaN").doc(Billing.docs[k].id).collection(Billing.docs[k].id).get();

          for(int l=0;l<Billing2.docs.length;l++){
            if(mydate.isNotEmpty){
              if(mydate.contains(Billing2.docs[l]['date'].toString())){
                setState(() {
                  totalamount=totalamount+double.parse(Billing2.docs[l]['Total']);
                });
              }
            }
            else{
              setState(() {
                totalamount2=totalamount2+double.parse(Billing2.docs[l]['Total']);
              });
            }
          }
        }


      }
      setState(() {
        totalprofitamount=totalamount+totalamount2;
      });

    }

    if(check3==true){
      var purchase=await FirebaseFirestore.instance.collection("Purchase entry").where("save",isEqualTo:true).get();

      for(int i=0;i<purchase.docs.length;i++){
        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var purchase2=await FirebaseFirestore.instance.collection("Purchase entry").doc(purchase.docs[i].id).collection(purchase.docs[i].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<purchase2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[s]['Total']);
            });
          }

        }
        else{
          var purchase2=await FirebaseFirestore.instance.collection("Purchase entry").doc(purchase.docs[i].id).collection(purchase.docs[i].id).get();
          for(int j=0;j<purchase2.docs.length;j++){
            setState(() {
              totalamount=totalamount+double.parse(purchase2.docs[j]['Total']);
            });



          }
        }

      }

      var Billing=await FirebaseFirestore.instance.collection("billing").where("save",isEqualTo:true).get();

      for(int k=0;k<Billing.docs.length;k++){

        if(mydate.isNotEmpty){
          setState(() {
            totalamount=0;
          });
          var Billing2=await FirebaseFirestore.instance.collection("billing").doc(Billing.docs[k].id).collection(Billing.docs[k].id).where("date",isEqualTo:mydate).get();
          for(int s=0;s<Billing2.docs.length;s++){
            setState(() {
              totalamount=totalamount+double.parse(Billing2.docs[s]['Total']);
            });
          }

        }
        else{
          var Billing2=await FirebaseFirestore.instance.collection("billing").doc(Billing.docs[k].id).collection(Billing.docs[k].id).get();

          for(int l=0;l<Billing2.docs.length;l++){
            if(mydate.isNotEmpty){
              if(mydate.contains(Billing2.docs[l]['date'].toString())){
                setState(() {
                  totalamount=totalamount+double.parse(Billing2.docs[l]['Total']);
                });
              }
            }
            else{
              setState(() {
                totalamount2=totalamount2+double.parse(Billing2.docs[l]['Total']);
              });
            }
          }
        }


      }
      setState(() {
        totalprofitamount=totalamount+totalamount2;
      });

    }






  }
  
  
  @override
  void initState() {
  setState(() {
  datesearch=false;
  });
    totalamountfunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(

            horizontal: width/170.75
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            child:
            Column(
              children: [
                //fromdate and todate text
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: width/23.551, right: width/34.15),
                      child: Text(
                        "From Date",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: width/68.3,),
                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/170.75,
                          vertical: height/82.125
                      ),
                      child: Text(
                        "To Date",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                //date and year and alarm icon container
                Row(
                  children: [

                    //textfield-1 fromdate
                    Padding(
                      padding:  EdgeInsets.only(left: width/25.77,),
                      child: Container(
                        height: height / 16.4,
                        width: width / 9.5,
                        decoration: BoxDecoration(
                            color: const Color(0xffE7E7E7),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0xff01A99E))),
                        child: TextField(
                          controller: pos1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                            hintText: "mm/dd/yyyy",
                            hintStyle: const TextStyle(color: Color(0xff00A99D)),
                            border: InputBorder.none,
                          ),
                          onTap: () async {

                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now()
                            );

                            if(pickedDate != null ){
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('d/ M/yyyy').format(pickedDate);
                              //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                year1= pickedDate.year;
                                day1= pickedDate.day;
                                month1= pickedDate.month;
                                pos1.text = formattedDate;
                                //set output date to TextField value.
                              });
                            }else{
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(width: width/91.066,),

                    //textfield-2 todate
                    Container(
                      height: height / 16.4,
                      width: width / 9.5,
                      decoration: BoxDecoration(
                          color: const Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: const Color(0xff01A99E))),
                      child: TextField(
                        controller: pos2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: width/136.6, left: width/91.06),
                          hintText: "mm/dd/yyyy",
                          hintStyle: const TextStyle(color: Color(0xff00A99D)),
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('d/M/yyyy').format(pickedDate);
                            //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              year2= pickedDate.year;
                              day2= pickedDate.day;
                              month2= pickedDate.month;
                              pos2.text = formattedDate;

                              //set output date to TextField value.
                            });
                            DateTime startDate = DateTime.utc(year1, month1, day1);
                            DateTime endDate = DateTime.utc(year2, month2, day2);
                            getDaysInBetween() {
                              final int difference = endDate.difference(startDate).inDays;
                              return difference;
                            }
                            final items = List<DateTime>.generate(getDaysInBetween(), (i) {
                              DateTime date = startDate;
                              return date.add(Duration(days: i));
                            });
                            setState(() {
                              mydate.clear();
                            });
                            for(int i =0;i<items.length;i++) {
                              setState(() {
                                mydate.add(formatter.format(items[i]).toString());
                              });

                            }

                          }else{
                          }
                        },
                      ),
                    ),

                    SizedBox(width: width/91.066,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          datesearch=true;
                        });
                        totalamountfunction();

                      },
                      child: Container(
                        height: height / 16.4,
                        width: width / 9.5,
                        decoration: BoxDecoration(
                            color: const Color(0xff4477CE),
                            borderRadius: BorderRadius.circular(7),),
                        child:
                        Center(
                          child: Text(
                            "Submit",
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width/91.066,),

                    InkWell(
                      onTap: (){
                        setState(() {
                          datesearch=false;
                          pos1.clear();
                          pos2.clear();
                        });
                        totalamountfunction();

                      },
                      child: Container(
                        height: height / 16.4,
                        width: width / 9.5,
                        decoration: BoxDecoration(
                          color: const Color(0xff4477CE),
                          borderRadius: BorderRadius.circular(7),),
                        child:
                        Center(
                          child: Text(
                            "Clear",
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: width/2.9,),

                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        height: height / 16.4,
                        width: width / 7.5,
                        decoration: BoxDecoration(
                            color: const Color(0xffC8E4B2),
                            borderRadius: BorderRadius.circular(7),
                            ),
                        child:
                        Center(
                          child: Text(
                            "Download Excel",
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.indigo),
                          ),
                        ),
                      ),
                    ),




                  ],
                ),

                SizedBox(height: height/21.9,),

                Padding(
                  padding:  EdgeInsets.only(left: width/25.77,),
                  child: Row(
                    children: [

                      Checkbox(
                        value: check,
                        onChanged: (value) {
                          setState(() {
                            check= value!;
                            check2= false;
                            check3= false;
                          });
                          totalamountfunction();
                        },
                      ),
                      Text(
                        "Shabika G",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: width/68.3,),

                      Checkbox(
                        value: check2,
                        onChanged: (value) {
                          setState(() {
                            check2= value!;
                            check= false;
                            check3= false;
                          });
                          totalamountfunction();
                        },
                      ),
                      Text(
                        "Shabika N",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: width/68.3,),

                      Checkbox(
                        value: check3,
                        onChanged: (value) {
                          setState(() {
                            check3= value!;
                            check= false;
                            check2= false;
                          });
                          totalamountfunction();
                        },
                      ),
                      Text(
                        "Both",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),

                      //Total amount
                      SizedBox(width: width/68.3,),
                      Text(
                        "Total Balance : ",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: width/68.3,),
                      Container(
                        height: height / 16.4,
                        width: width / 10.5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:
                        Center(
                          child: Text(
                            totalprofitamount.toStringAsFixed(2),
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),

                      //Credit amount
                      SizedBox(width: width/68.3,),
                      Text(
                        "Credit Balance : ",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: width/68.3,),
                      Container(
                        height: height / 16.4,
                        width: width / 10.5,
                        decoration: BoxDecoration(
                          color: const Color(0xff7A9D54),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:
                        Center(
                          child: Text(
                            totalamount2.toStringAsFixed(2),
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),

                      //debit amount
                      SizedBox(width: width/68.3,),
                      Text(
                        "Debit Balance : ",
                        style: GoogleFonts.cairo(
                            fontSize:width/68.3, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: width/68.3,),
                      Container(
                        height: height / 16.4,
                        width: width / 10.5,
                        decoration: BoxDecoration(
                          color: const Color(0xff900C3F),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child:
                        Center(
                          child: Text(
                            totalamount.toStringAsFixed(2),
                            style: GoogleFonts.cairo(
                                fontSize:width/68.3, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
                SizedBox(height: height/21.9,),
              ],
            ),
          ),
        ),
        SizedBox(height: height/101.9,),
        
        
        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: width/170.75),
          child: Container(
              height: height/13.14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(child:
        datesearch==true&&pos1.text!=""&&pos2.text!=""?
           Text("From Date : ${pos1.text} - To Date : ${pos2.text}",
          style: GoogleFonts.cairo(fontWeight: FontWeight.w700 ,fontSize:width/68.3),) :
              Text("Today Reports",

                style: GoogleFonts.cairo(fontWeight: FontWeight.w700 ,fontSize:width/68.3),))),
        ),
        SizedBox(height: height/101.9,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //credits container
            Column(
              children: [
                Container(
                  height: 50,
                  width: 670,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white
                  ),
                  child: Center(
                    child: Text(
                      "Credits",
                      style: GoogleFonts.cairo(
                          fontSize:width/68.3, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  width: 670,
                  height: 400,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        //titles
                        Row(
                          children: [

                            Container(
                                height: 40,
                                width:100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(7))
                                ),
                                child: Center(child: Text("Date/Time",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),
                            Container(
                                height: 40,
                                width:450,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5)
                                ),

                                child: Center(child: Text("Descriptions",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),
                            Container(
                                height: 40,
                                width:120,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(7))
                                ),
                                child: Center(child: Text("Amount",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                          ],
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream: check==true?
                          FirebaseFirestore.instance.collection("billing ShabikaG").orderBy("timestamp",descending: false).snapshots():
                          check2==true?FirebaseFirestore.instance.collection("billing ShabikaN").orderBy("timestamp",descending: false).snapshots():
                          FirebaseFirestore.instance.collection("billing").orderBy("timestamp",descending: false).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData==null){
                              return  Center(child: Container(),);
                            }
                            if(!snapshot.hasData){
                              return
                                Center(child: Container(),);
                            }
                            return
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  if( snapshot.data!.docs[index]['save']==true){
                                    return StreamBuilder<QuerySnapshot>(
                                      stream:
                                      check==true?
                                      FirebaseFirestore.instance.collection("billing ShabikaG").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots():
                                      check2==true?FirebaseFirestore.instance.collection("billing ShabikaN").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots():
                                      FirebaseFirestore.instance.collection("billing").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots() ,
                                      builder: (context, snapshot2) {
                                        if(snapshot2.hasData==null){
                                          return
                                            Center(
                                            child: SizedBox(
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
                                            ),
                                          );
                                        }
                                        if(!snapshot2.hasData){
                                          return      Center(
                                            child: SizedBox(
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
                                            ),
                                          );
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot2.data!.docs.length,
                                          itemBuilder: (context, index) {

                                            var debitdata=snapshot2.data!.docs[index];

                                            if(mydate.isNotEmpty&&datesearch==true&&mydate.contains(debitdata
                                            ['date'].toString())){
                                                return
                                                  Row(
                                                  children: [



                                                    Container(
                                                        height: 40,
                                                        width:100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black,width: 1.5)
                                                        ),
                                                        child: Center(child: Text("${debitdata['date']}\n${debitdata['time']}",
                                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                          textAlign: TextAlign.center,
                                                        ))),

                                                    Container(
                                                        height: 40,
                                                        width:450,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black,width: 1.5)
                                                        ),

                                                        child: Center(child: Text(debitdata['Description'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                                                    Container(
                                                        height: 40,
                                                        width:120,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5),
                                                        ),
                                                        child: Center(child: Text(debitdata['Total'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.green),))),

                                                  ],
                                                );

                                            }

                                            if(mydate.isEmpty||datesearch==false){
                                              return Row(
                                                children: [

                                                  Container(
                                                      height: 40,
                                                      width:100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5)
                                                      ),
                                                      child: Center(child: Text("${debitdata['date']}\n${debitdata['time']}",
                                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        textAlign: TextAlign.center,
                                                      ))),

                                                  Container(
                                                      height: 40,
                                                      width:450,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5)
                                                      ),

                                                      child: Center(child: Text(debitdata['Description'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                                                  Container(
                                                      height: 40,
                                                      width:120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black,width: 1.5),
                                                      ),
                                                      child: Center(child: Text(debitdata['Total'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.green),))),

                                                ],
                                              );
                                            }

                                          },);
                                      },);
                                  }


                                  return const SizedBox();


                                },);
                          },
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Debits container
            Column(
              children: [
                Container(
                  height: 50,
                  width: 670,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white
                  ),
                  child: Center(
                    child: Text(
                      "Debits",
                      style: GoogleFonts.cairo(
                          fontSize:width/68.3, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                Container(
                  width: 670,
                  height: 400,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        //titles
                        Row(
                          children: [

                            Container(
                                height: 40,
                                width:100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(7))
                                ),
                                child: Center(child: Text("Date/Time",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),
                            Container(
                                height: 40,
                                width:450,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5)
                                ),

                                child: Center(child: Text("Descriptions",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),
                            Container(
                                height: 40,
                                width:120,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1.5),
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(7))
                                ),
                                child: Center(child: Text("Amount",style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                          ],
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream: check==true?
                          FirebaseFirestore.instance.collection("Purchase ShabikaG").orderBy("timestamp",descending: false).snapshots():
                          check2==true?FirebaseFirestore.instance.collection("Purchase ShabikaN").orderBy("timestamp",descending: false).snapshots():
                          FirebaseFirestore.instance.collection("Purchase entry").orderBy("timestamp",descending: false).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData==null){
                              return     Center(
                                child: SizedBox(
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
                                ),
                              );
                            }
                            if(!snapshot.hasData){
                              return    Center(
                                child: SizedBox(
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
                                ),
                              );
                            }
                            return
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {

                                  if( snapshot.data!.docs[index]['save']==true){
                                    return StreamBuilder<QuerySnapshot>(
                                      stream:
                                      check==true?
                                      FirebaseFirestore.instance.collection("Purchase ShabikaG").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots():
                                      check2==true?FirebaseFirestore.instance.collection("Purchase ShabikaN").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots():
                                      FirebaseFirestore.instance.collection("Purchase entry").doc(snapshot.data!.docs[index].id).collection(snapshot.data!.docs[index].id).orderBy("timestamp",descending: false).snapshots() ,
                                      builder: (context, snapshot2) {
                                        if(snapshot2.hasData==null){
                                          return  Center(
                                            child:
                                            Container()
                                          );
                                        }
                                        if(!snapshot2.hasData){
                                          return  Center(
                                            child:
                                           Container()
                                          );
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot2.data!.docs.length,
                                          itemBuilder: (context, index) {

                                            var debitdata=snapshot2.data!.docs[index];

                                            if(mydate.isNotEmpty&&datesearch==true&&mydate.contains(debitdata['date'].toString())){
                                                return Row(
                                                  children: [



                                                    Container(
                                                        height: 40,
                                                        width:100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black,width: 1.5)
                                                        ),
                                                        child: Center(child: Text("${debitdata['date']}\n${debitdata['time']}",
                                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                          textAlign: TextAlign.center,
                                                        ))),

                                                    Container(
                                                        height: 40,
                                                        width:450,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.black,width: 1.5)
                                                        ),

                                                        child: Center(child: Text(debitdata['Description'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                                                    Container(
                                                        height: 40,
                                                        width:120,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5),
                                                        ),
                                                        child: Center(child: Text(debitdata['Total'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.red),))),

                                                  ],
                                                );
                                            }
                                            if(mydate.isEmpty||datesearch==false){
                                              return Row(
                                                children: [



                                                  Container(
                                                      height: 40,
                                                      width:100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5)
                                                      ),
                                                      child: Center(child: Text("${debitdata['date']}\n${debitdata['time']}",
                                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                                                        textAlign: TextAlign.center,
                                                      ))),

                                                  Container(
                                                      height: 40,
                                                      width:450,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black,width: 1.5)
                                                      ),

                                                      child: Center(child: Text(debitdata['Description'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),))),

                                                  Container(
                                                      height: 40,
                                                      width:120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black,width: 1.5),
                                                      ),
                                                      child: Center(child: Text(debitdata['Total'],style: GoogleFonts.montserrat(fontWeight: FontWeight.w700,color: Colors.red),))),

                                                ],
                                              );
                                            }

                                          },);
                                      },);
                                  }


                                  return const SizedBox();


                                },);
                          },
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: height/61.9,),





      ],
    );
  }
}
