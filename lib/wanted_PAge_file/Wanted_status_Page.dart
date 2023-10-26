
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';

class Wanted_status_Page extends StatefulWidget {
  const Wanted_status_Page({Key? key}) : super(key: key);

  @override
  State<Wanted_status_Page> createState() => _Wanted_status_PageState();
}

class _Wanted_status_PageState extends State<Wanted_status_Page> {

  double total=0;
  bool isserach=false;
  bool categoryclick=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController Operator1=TextEditingController();
  TextEditingController Operator2=TextEditingController();
  TextEditingController Operator3=TextEditingController();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left:width/48.785, top: height/32.85),
              child: Text(
                "Status",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize:width/59.391,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: width/13.66,
            ),
            Padding(
              padding:  EdgeInsets.only(left: width/1.355, top: height/21.9),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  drawer(" "),
                  ));
                },
                child: Container(
                  width: width / 11.38,
                  height: height / 16.42,
                  // color: Color(0xff00A99D),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff00A99D),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left:width/170.75, right: width/170.75),
                        child: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom:height/136.6),
                        child: Text(
                          "Home",
                          style: GoogleFonts.openSans(
                              color: const Color(0xffFFFFFF), fontSize:width/59.391),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/75.888,vertical: height/36.5),
          child: Image.asset("assets/Line13.png"),
        ),
       /* Padding(
          padding:  EdgeInsets.only(left: width/27.32),
          child: Row(
            children: [
              Text("Search",
                  style: GoogleFonts.openSans(
                      fontSize: width/68.3, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/28.458, right: width/34.15),
              child: Container(
                width: width/3.415,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffFFFFFF),
                ),
                child:
                TextField(
                  controller: Serachcontroller,
                  style: GoogleFonts.openSans(fontSize: width/68.3,fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.only(left: width/68.3, top:width/102.125,bottom:width/102.125),
                      border: InputBorder.none,
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      )),
                  onTap: (){
                    setState(() {
                      isserach=true;
                    });
                  },
                  onChanged: (value){
                    if(Serachcontroller.text==""){
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
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  categoryclick = true;
                });
              },
              child: Container(
                width: width / 5.46,
                height: height / 16.42,
                //color: Color(0xff00A99D),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff00A99D),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                top: height/657, left: width/136.6, right: width/91.06),
                            child: Container(
                              width: width / 56.91,
                              height: height / 27.37,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.add, color: Colors.teal),
                            ),
                          ),
                          Text(
                            "Add Category",
                            style: GoogleFonts.openSans(
                                fontSize: width/68.3, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),*/
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width/75.88),
          child: Row(
            children: [

              //index (Serial number)
              Container(
                height: height / 16.42,
                width: width / 13.66,
                // color: Colors.grey,
                decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(

                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    ),
                child: Center(
                    child: Text(
                      "Add",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: width/75.888,
                         ),
                    )),
              ),

              //name text
              Container(
                height: height / 16.42,
                width: width / 5.10,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                   ),
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: width/75.888, top: height/131.4),
                  child: TextField(
                    controller: Operator1,

                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: width/75.888,
                       ),
                    decoration:  InputDecoration(
                        hintText: "Status 1",
                        contentPadding: EdgeInsets.only(bottom: height/100),
                      border: InputBorder.none,
                        suffixIcon: InkWell(
                            onTap: (){
                              FirebaseFirestore.instance.collection("Status1").doc().set({
                                "name":Operator1.text,
                                "timestamp":DateTime.now().millisecondsSinceEpoch
                              });
                              setState(() {
                                Operator1.clear();
                              });
                            },
                            child: Icon(Icons.add))
                    ),
                  ),
                ),
              ),

              Container(
                height: height / 16.42,
                width: width / 5.10,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                   ),
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: width/75.888, top: height/131.4),
                  child: TextField(
                    controller: Operator2,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: width/75.888,
                        ),
                    decoration:  InputDecoration(
                        hintText: "Status 2",
                        contentPadding: EdgeInsets.only(bottom: height/100),
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                            onTap: (){
                              FirebaseFirestore.instance.collection("Status2").doc().set({
                                "name":Operator2.text,
                                "timestamp":DateTime.now().millisecondsSinceEpoch
                              });
                              setState(() {
                                Operator2.clear();
                              });
                            },
                            child: Icon(Icons.add))
                    ),
                  ),
                ),
              ),

              Container(
                height: height / 16.42,
                width: width / 5.10,
                decoration: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(

                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),

                    ),
                child: Padding(
                  padding:  EdgeInsets.only(
                      left: width/75.888, top: height/131.4),
                  child: TextField(
                    controller: Operator3,

                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: width/75.888,
                       ),
                    decoration:  InputDecoration(
                      hintText: "Status 3",
                      contentPadding: EdgeInsets.only(bottom: height/100),
                        border: InputBorder.none,
                      suffixIcon: InkWell(
                          onTap: (){
                            FirebaseFirestore.instance.collection("Status3").doc().set({
                              "name":Operator3.text,
                              "timestamp":DateTime.now().millisecondsSinceEpoch
                            });
                            setState(() {
                              Operator3.clear();
                            });
                          },
                          child: Icon(Icons.add))
                    ),
                  ),
                ),
              ),



              //active text


            ],
          ),
        ),
        SizedBox(height: height / 26.42,),
        Padding(
          padding:  EdgeInsets.symmetric( horizontal: width/75.88),
          child: Container(
            width: (  width / 5.10* 3)+ width / 13.66 +15,
            height: height / 16.42,
            // color: Color(0xff00A99D),
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12))),
            child: Row(
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(left: width/42.68, right: width/34.15),
                  child: Text("Sl.no",
                      style: GoogleFonts.openSans(
                          color: const Color(0xff00A99D),
                          fontSize: width/68.3,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: height / 13.14,
                  width: width / 5.10,
                  child: Text("Status-1",
                      style: GoogleFonts.openSans(
                          color: const Color(0xff00A99D),
                          fontSize: width/68.3,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: height / 13.14,
                  width: width / 5.10,
                  child: Text("Status-2",
                      style: GoogleFonts.openSans(
                          color: const Color(0xff00A99D),
                          fontSize: width/68.3,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: height / 13.14,
                  width: width / 5.10,
                  child: Text("Status-3",
                      style: GoogleFonts.openSans(
                          color: const Color(0xff00A99D),
                          fontSize: width/68.3,
                          fontWeight: FontWeight.w600)),
                ),

              ],
            ),
          ),
        ),
        //table details
        Padding(
          padding:  EdgeInsets.symmetric(

              horizontal: width/75.88
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                color: const Color(0xff00A99D),
                border: Border.all(color: Colors.red)),

            width: (  width / 5.10* 3)+ width / 13.66 +15,

            height: height / 1.87,
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Container(
                    width: (  width / 5.10* 3)+ width / 13.66 +15,
                    height: height / 1.87,
                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [

                        //index (Serial number)
                        Container(
                          width: width / 13.66,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 25,
                            itemBuilder: (context,index) {
                              return Container(
                                height: height / 13.14,
                                width: width / 13.66,
                                // color: Colors.grey,
                                decoration: const BoxDecoration(
                                    color: Color(0xff00A99D),
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.red,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.red,
                                      ),
                                    )),
                                child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width / 75.888,
                                          color: const Color(0xffFDFDFD)),
                                    )),
                              );

                            },
                          ),
                        ),


                        Container(
                          width: width / 5.10,
                          child: StreamBuilder(stream: FirebaseFirestore.instance.collection("Status1").orderBy("timestamp").snapshots(),
                              builder: (context,snap){

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snap.data!.docs.length,
                              itemBuilder: (context,index) {
                                return Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width / 6.2,
                                          child: Text(
                                            snap.data!.docs[index]
                                            ["name"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/75.888,
                                                color: const Color(0xffFDFDFD)),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (){
                                              delete1(snap.data!.docs[index].id);
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                );

                              },
                            );
                          }),
                        ),
                        Container(
                          width: width / 5.10,
                          child: StreamBuilder(stream: FirebaseFirestore.instance.collection("Status2").orderBy("timestamp").snapshots(),
                              builder: (context,snap){

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snap.data!.docs.length,
                              itemBuilder: (context,index) {
                                return Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.red,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width / 6.2,
                                          child: Text(
                                            snap.data!.docs[index]
                                            ["name"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/75.888,
                                                color: const Color(0xffFDFDFD)),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (){
                                              delete2(snap.data!.docs[index].id);
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                );

                              },
                            );
                          }),
                        ),
                        Container(
                          width: width / 5.10,
                          child: StreamBuilder(stream: FirebaseFirestore.instance.collection("Status3").orderBy("timestamp").snapshots(),
                              builder: (context,snap){

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snap.data!.docs.length,
                              itemBuilder: (context,index) {
                                return Container(
                                  height: height / 13.14,
                                  width: width / 5.10,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff00A99D),
                                      border: Border(

                                        bottom: BorderSide(
                                          color: Colors.red,
                                        ),
                                      )),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        left: width/75.888, top: height/131.4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width / 6.2,
                                          child: Text(
                                            snap.data!.docs[index]
                                            ["name"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width/75.888,
                                                color: const Color(0xffFDFDFD)),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (){
                                              delete3(snap.data!.docs[index].id);
                                            },
                                            child: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                );

                              },
                            );
                          }),
                        ),




                      ],
                    ),
                  )
                ],
              ),
            ),

            //color: Colors.red,
          ),
        )

      ],
    );

  }








//delete function
  delete1(catid){
    FirebaseFirestore.instance.collection("Status1").doc(catid).delete();

  }
  delete2(catid){
    FirebaseFirestore.instance.collection("Status2").doc(catid).delete();

  }
  delete3(catid){
    FirebaseFirestore.instance.collection("Status3").doc(catid).delete();

  }

  //_catogory showpopup(delete popup)



}
