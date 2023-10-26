import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../LandingPage/LandingPage.dart';
import '../const Pages.dart';

class Brand extends StatefulWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  bool brand = false;


  bool isserach=false;

  String Username="";
  TextEditingController Serachcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return brand == false
        ? Column(
            children: [
              SizedBox(height:height/40),

              //search bar and add brand button(text)....
              Row(
                children: [
                  //search bar
                  Padding(
                    padding:  EdgeInsets.only(left: width/28.458, right: width/34.15),
                    child: Container(
                      width: width / 3.90,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xffFFFFFF),
                      ),
                      child: TextField(
                        controller: Serachcontroller,
                        style: GoogleFonts.openSans(fontSize: width/68.3,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          contentPadding:  EdgeInsets.only(left: width/68.3, top:width/102.125,bottom:width/70.125),
                          border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            )
                        ),
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

                  //add brand button...
                  InkWell(
                    onTap: (){
                      setState(() {
                        brand=true;
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(
                                    top:height/657, left:width/ 91.06, right:width/ 68.3),
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
                                "Add Brand",
                                style: GoogleFonts.openSans(
                                    fontSize: width/68.3, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //table container....
              Padding(
                padding:  EdgeInsets.symmetric(
                vertical: height/36.5,
                  horizontal: width/75.888
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                      ),
                      color: const Color(0xffD4D4D4),
                      border: Border.all(color: Colors.black)),

                  width: width / 1.03,

                  height: height / 1.25,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //titilesssss....
                        Container(
                          width: width / 1.03,
                          height: height / 16.42,
                          // color: Color(0xff00A99D),
                          decoration: const BoxDecoration(
                              color: Color(0xff1D5B79),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12))),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(left: width/42.68, right: width/26.15),
                                child: Text("Sl.no",
                                    style: GoogleFonts.openSans(
                                        color:  Colors.white,
                                        fontSize: width / 88.3,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text("Brand Name",
                                  style: GoogleFonts.openSans(
                                      color:Colors.white,
                                      fontSize: width / 88.3,
                                      fontWeight: FontWeight.w600)),
                              Padding(
                                padding:
                                EdgeInsets.only(left: width/1.84, right: width/18.514),
                                child: Text("Edit",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: width / 88.3,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text("Delete",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: width / 88.3,
                                      fontWeight: FontWeight.w600)),
                              Padding(
                                padding:  EdgeInsets.only(left: width/12.523),
                                child: Text("Status",
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: width / 88.3,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),

                        //Brand stream
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Brand").orderBy("timestamp",descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData == null) {
                              return Center(
                                child: Container(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {

                                if(isserach==true&&snapshot.data!.docs[index]["Brandname"].toString().toLowerCase().contains(Username.toLowerCase())){
                                return Row(
                                  children: [
                                    //index (Serial number)
                                    Container(
                                      height: height / 20.14,
                                      width: width / 13.66,
                                      // color: Colors.grey,
                                      decoration:  const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          )),
                                      child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width / 95.888,
                                                color:Colors.black),
                                          )),
                                    ),

                                    //name text
                                    Container(
                                      height: height / 20.14,
                                      width: width / 1.70,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D4D4),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ),
                                          )),
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left: width/75.888, top: height/131.4),
                                        child: Text(
                                          snapshot.data!.docs[index]["Brandname"],
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width / 95.888,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),

                                    //edit icon(img)
                                    GestureDetector(
                                      onTap:(){
                                        editditem(snapshot.data!.docs[index].id);
                                      },
                                      child: Container(
                                          height: height / 20.14,
                                          width: width / 12.64,
                                          // color: Colors.grey,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD4D4D4),
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          child: Image.asset("assets/edit.png")),
                                    ),
                                    //

                                    //delete icon (img)
                                    InkWell(
                                      onTap: () {
                                        _Barnd(snapshot.data!.docs[index].id);
                                      },
                                      child: Container(
                                          height: height / 20.14,
                                          width: width / 12.41,
                                          // color: Colors.grey,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD4D4D4),
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          child: Image.asset("assets/delete.png")),
                                    ),

                                    //active text
                                    Container(
                                        height: height / 20.14,
                                        width: width / 6.83,
                                        // color: Colors.grey,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Center(
                                            child: Text(
                                              "Active",
                                              style: GoogleFonts.openSans(
                                                  fontSize: width / 95.888,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))),
                                  ],
                                );

                                }
                                else if(isserach==false&&snapshot.data!.docs[index]["Brandname"].toString().toLowerCase().contains(Username.toLowerCase())){
                                  return
                                    Row(
                                    children: [
                                      //index (Serial number)
                                      Container(
                                        height: height / 20.14,
                                        width: width / 13.66,
                                        // color: Colors.grey,
                                        decoration:  const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.black,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width / 95.888,
                                                  color:Colors.black),
                                            )),
                                      ),

                                      //name text
                                      Container(
                                        height: height / 20.14,
                                        width: width / 1.70,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD4D4D4),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.black,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: Padding(
                                          padding:  EdgeInsets.only(
                                              left: width/75.888, top: height/131.4),
                                          child: Text(
                                            snapshot.data!.docs[index]["Brandname"],
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width / 95.888,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),

                                      //edit icon(img)
                                      GestureDetector(
                                        onTap:(){
                                          editditem(snapshot.data!.docs[index].id);
                                        },
                                        child: Container(
                                            height: height / 20.14,
                                            width: width / 12.64,
                                            // color: Colors.grey,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffD4D4D4),
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            child: Image.asset("assets/edit.png")),
                                      ),
                                      //

                                      //delete icon (img)
                                      InkWell(
                                        onTap: () {
                                          _Barnd(snapshot.data!.docs[index].id);
                                        },
                                        child: Container(
                                            height: height / 20.14,
                                            width: width / 12.41,
                                            // color: Colors.grey,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffD4D4D4),
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            child: Image.asset("assets/delete.png")),
                                      ),

                                      //active text
                                      Container(
                                          height: height / 20.14,
                                          width: width / 6.83,
                                          // color: Colors.grey,
                                          decoration: const BoxDecoration(
                                              color: Color(0xffD4D4D4),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              )),
                                          child: Center(
                                              child: Text(
                                                "Active",
                                                style: GoogleFonts.openSans(
                                                    fontSize: width / 95.888,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ))),
                                    ],
                                  );

                                }
                                return
                                 const  SizedBox();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

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
                  SizedBox(
                    width: width/91.066,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        brand = false;
                      });
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(top: height/32.85),
                      child: Tooltip(
                        message: "Back",
                        child: Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          shadowColor: Colors.indigo,
                          child: Container(
                            height:height/ 21.9,
                            width:width/ 45.53,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: width/91.06,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: width/35.947, top: height/32.85),
                    child: Text(
                      "Add Brand ",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                         fontSize: width/59.39,
                          color: const Color(0xffFFFFFF)),
                    ),
                  ),
                  SizedBox(
                    width: width/1.517,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding:  EdgeInsets.only(left:width/ 35.94, top:height/ 32.85),
                      child: Text(
                        "Add Brand ",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                           fontSize: width/59.39,
                            color: const Color(0xffFFFFFF)),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:  EdgeInsets.symmetric(
                  vertical: height/36.5,
                  horizontal: width/75.88
                ),
                child: Image.asset("assets/Line13.png"),
              ),

              //First row container and text
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                      left:width/ 23.55,
                    ),
                    child: Text(
                      "Brand Name *",
                      style: GoogleFonts.openSans(
                          fontSize: width/97.57, color: const Color(0xff000000)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/65.7),

              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width/23.55),
                    child: Container(
                      width: width / 6.504,
                      height: height / 16.42,
                      decoration: BoxDecoration(
                          color: const Color(0xffDDDEEE),
                          borderRadius: BorderRadius.circular(4)),
                      child: TextField(
                        controller: Brandname,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.openSans(fontSize: width/136.6,fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: width/68.3, bottom:height/ 82.125),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:  EdgeInsets.only(top: height/36.5, left:width/ 19.51),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Brand();
                        showdialpogbox();
                        Future.delayed(Duration(seconds: 3),(){
                          setState(() {
                            brand = false;
                          });
                          Navigator.pop(context);
                        });

                      },
                      child: Container(
                        width: width / 13.6,
                        height: height / 16.42,
                        //color: Color(0xffD60A0B),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff25D366)
                        ),
                        child: Center(
                            child: Text(
                          "Save",
                          style: GoogleFonts.openSans(color: Colors.white),
                        )),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width/75.888),
                      child: InkWell(
                        onTap: () {
                          claercate();
                        },
                        child: Container(
                          width: width / 13.6,
                          height: height / 16.42,
                          //color: Color(0xffD60A0B),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Center(
                              child: Text(
                            "Reset",
                            style: GoogleFonts.openSans(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }

  TextEditingController Brandname = TextEditingController();


  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.760,bottom: height/4.76),
        child: SlideInLeft(
          animate: true,
          duration: const Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: const Color(0xff264656),
              content:
              SizedBox(
                width: width/3.902,
                child: Column(
                  children: [
                    SizedBox(height:height/ 32.85,),
                    Text("Add a Brand Successfully",style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height:height/ 32.85,),
                    SizedBox(
                      height:height/ 4.38,
                      width: width/9.106,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: height/ 32.85,),

                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //
                    //         Navigator.pop(context);
                    //       },
                    //       child: Material(
                    //         elevation: 15,
                    //         color: Colors.red,
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Container(
                    //           height: height/16.425,
                    //           width: width/9.588,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.red,
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //                 "Okay",
                    //                 style: GoogleFonts.openSans(
                    //                     letterSpacing: 1.5,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: width/85.375, color: Colors.white)
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width:width/68.3),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //       child: Material(
                    //         elevation: 15,
                    //         color: const Color(0xff263646),
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: Container(
                    //           height: height / 16.425,
                    //           width: width / 9.588,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.white,
                    //           ),
                    //           child: Center(
                    //             child: Text("Cancel",
                    //                 style: GoogleFonts.openSans(
                    //                     letterSpacing: 1.5,
                    //                     fontWeight: FontWeight.w500,
                    //                     fontSize: width / 85.375,
                    //                     color: Colors.black)),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )


                  ],
                ),

              )
          ),
        ),
      );
    },);


  }

  Brand() {
    FirebaseFirestore.instance.collection("Brand").doc().set({
      "Brandname":Brandname.text,
      "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "timestamp":DateTime.now().microsecondsSinceEpoch,
    });
    claercate();
  }

  claercate(){
    Brandname.clear();
  }

//delete function
  delete(barndid) {
    FirebaseFirestore.instance.collection("Brand").doc(barndid).delete();
  }

  //Barnd showpopup(delete popup)
  _Barnd(barndid) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding:  EdgeInsets.only(
              top: height/ 4.38, bottom:height/ 4.38, left:  width/3.902, right: width/3.902),
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height/21.9),
                  Text(
                    "Are You Sure Want to Delete",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: width/75.888),
                  ),
                  SizedBox(height: height/32.85),
                  SizedBox(
                    height:height/ 3.65,
                    width: width/7.588,
                    child: Lottie.network(deletefile),
                  ),
                  SizedBox(height:height/ 32.85),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          delete(barndid);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height:height/ 16.425,
                          width:width/ 9.588,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff25D366)),
                          child: Center(
                            child: Text(
                              "Okay",
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontWeight: FontWeight.w600),
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
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text("Cancel",
                                  style: GoogleFonts.openSans(
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
        );
      },
    );
  }

  //eidt item popup

  TextEditingController edititem = TextEditingController();


  edidtheitemfunction(docid){
    FirebaseFirestore.instance.collection("Brand").doc(docid).update({
      "Brandname":edititem.text,
    });
  }
  ediditemsetfunction(docid)async{
    var getdatae=await FirebaseFirestore.instance.collection("Brand").doc(docid).get();
    Map<String,dynamic>?value=getdatae.data();
    setState(() {
      edititem.text=value!['Brandname'];
    });
  }
  editditem(docid) {
    ediditemsetfunction(docid);
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
                    "Are You Sure Want To Edit this Item ",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700, fontSize: width / 68.3),
                  ),
                  SizedBox(height: height / 32.85),
                  Row(
                    children: [
                      SizedBox(width: width / 7.805),
                      Text(
                        "Edit Item",
                        style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
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
                        style: GoogleFonts.openSans(fontWeight: FontWeight.w700),
                        controller: edititem,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: width / 136.6, bottom: height / 65.7)),
                      )),
                  SizedBox(height: height / 32.85),
                  InkWell(
                    onTap: () {
                      //update functions
                      edidtheitemfunction(docid);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 16.425,
                      width: width / 10.507,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff263646)),
                      child: Center(
                        child: Text(
                          "Okay",
                          style: GoogleFonts.openSans(
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
