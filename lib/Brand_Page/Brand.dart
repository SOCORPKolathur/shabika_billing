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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return brand == false
        ? Column(
            children: [
              //brand text and container....
              Row(
                children: [
                  //brand text....
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 20),
                    child: Text(
                      "Brand",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white),
                    ),
                  ),

                  SizedBox(
                    width: 100,
                  ),

                  //home icon and text container....
                  Padding(
                    padding: const EdgeInsets.only(left: 1008.0, top: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => drawer(),
                        ));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: width/136.6),
                              child: Text(
                                "Home",
                                style: GoogleFonts.cairo(
                                    color: Color(0xffFFFFFF), fontSize: 23),
                              ),
                            )
                          ],
                        ),
                        width: width / 11.38,
                        height: height / 16.42,
                        // color: Color(0xff00A99D),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff00A99D),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset("assets/Line13.png"),
              ),

              //search text
              Padding(
                padding: const EdgeInsets.only(right: 1178.0),
                child: Text("Search",
                    style: GoogleFonts.cairo(
                        fontSize: width/68.3, fontWeight: FontWeight.bold)),
              ),

              //search bar and add brand button(text)....
              Row(
                children: [
                  //search bar
                  Padding(
                    padding:  EdgeInsets.only(left: width/28.458, right: width/34.15),
                    child: Container(
                      child: TextField(
                        style: GoogleFonts.poppins(fontSize: width/68.3),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: width/68.3, bottom: 8),
                          border: InputBorder.none,
                          suffix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/search.png"),
                          ),
                        ),
                      ),

                      width: width / 3.90,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xffFFFFFF),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1.0, left: 15, right: 20),
                                child: Container(
                                  child: Icon(Icons.add, color: Colors.teal),
                                  width: width / 56.91,
                                  height: height / 27.37,
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                "Add Brand",
                                style: GoogleFonts.cairo(
                                    fontSize: width/68.3, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      width: width / 5.46,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff00A99D),
                      ),
                    ),
                  ),
                ],
              ),

              //table container....
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                     EdgeInsets.only(left: 32.0, right: width/34.15),
                                child: Text("Sl.no",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D), fontSize: width/68.3)),
                              ),
                              Text("Brand Name",
                                  style: GoogleFonts.cairo(
                                      color: Color(0xff00A99D), fontSize: width/68.3)),
                              Padding(
                                padding:
                                     EdgeInsets.only(left: 718.0, right: width/19.514),
                                child: Text("Edit",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D), fontSize: width/68.3)),
                              ),
                              Text("Delete",
                                  style: GoogleFonts.cairo(
                                      color: Color(0xff00A99D), fontSize: width/68.3)),
                              Padding(
                                padding:  EdgeInsets.only(left: width/15.523),
                                child: Text("Status",
                                    style: GoogleFonts.cairo(
                                        color: Color(0xff00A99D), fontSize: width/68.3)),
                              ),
                            ],
                          ),
                          width: width / 1.03,
                          height: height / 16.42,
                          // color: Color(0xff00A99D),
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12))),
                        ),

                        //Brand stream
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Brand")
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
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    //index (Serial number)
                                    Padding(
                                      padding: const EdgeInsets.only(right: .0),
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width/75.888,
                                              color: Color(0xffFDFDFD)),
                                        )),
                                        height: height / 13.14,
                                        width: width / 13.66,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00A99D),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.red,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.red,
                                              ),
                                            )),
                                      ),
                                    ),

                                    //name text
                                    Container(
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left: width/75.888, top: height/131.4),
                                        child: Text(
                                          snapshot.data!.docs[index]["Brandname"],
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width/75.888,
                                              color: Color(0xffFDFDFD)),
                                        ),
                                      ),
                                      height: height / 13.14,
                                      width: width / 1.70,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00A99D),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.red,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.red,
                                            ),
                                          )),
                                    ),

                                    //edit icon(img)
                                    Container(
                                        child: Image.asset("assets/edit.png"),
                                        height: height / 13.14,
                                        width: width / 12.64,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00A99D),
                                            border: Border(
                                              right: BorderSide(
                                                color: Colors.red,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ))), //

                                    //delete icon (img)
                                    InkWell(
                                      onTap: () {
                                        _Barnd(snapshot.data!.docs[index].id);
                                      },
                                      child: Container(
                                          child: Image.asset("assets/delete.png"),
                                          height: height / 13.14,
                                          width: width / 12.41,
                                          // color: Colors.grey,
                                          decoration: BoxDecoration(
                                              color: Color(0xff00A99D),
                                              border: Border(
                                                right: BorderSide(
                                                  color: Colors.red,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ))),
                                    ),

                                    //active text
                                    Container(
                                        child: Center(
                                            child: Text(
                                          "Active",
                                          style: GoogleFonts.cairo(
                                              fontSize: width/75.888,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffFDFDFD)),
                                        )),
                                        height: height / 13.14,
                                        width: width / 6.83,
                                        // color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Color(0xff00A99D),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ))),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      color: Color(0xff00A99D),
                      border: Border.all(color: Colors.red)),

                  width: width / 1.03,

                  height: height / 1.87,

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
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        brand = false;
                      });
                      print(height);
                      print(width);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Tooltip(
                        message: "Back",
                        child: Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          shadowColor: Colors.indigo,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0, top: 20),
                    child: Text(
                      "Add Brand ",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color(0xffFFFFFF)),
                    ),
                  ),
                  SizedBox(
                    width: 900,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 38.0, top: 20),
                      child: Text(
                        "Add Brand ",
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Color(0xffFFFFFF)),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset("assets/Line13.png"),
              ),

              //First row container and text
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 58.0,
                    ),
                    child: Text(
                      "Brand Name *",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Color(0xff000000)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 58),
                    child: Container(
                      child: TextField(
                        controller: Brandname,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.poppins(fontSize: 10),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, bottom: 8),
                          hintText: "Brand Name",
                          border: InputBorder.none,
                        ),
                      ),
                      width: width / 6.504,
                      height: height / 16.42,
                      decoration: BoxDecoration(
                          color: Color(0xffDDDEEE),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 70),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showdialpogbox();
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "Save",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )),
                        width: width / 13.6,
                        height: height / 16.42,
                        //color: Color(0xffD60A0B),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffD60A0B),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width/75.888),
                      child: InkWell(
                        onTap: () {
                          claercate();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            "Reset",
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                          width: width / 13.6,
                          height: height / 16.42,
                          //color: Color(0xffD60A0B),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff00A0E3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }

  TextEditingController Brandname = new TextEditingController();


  //showdialogbox..
  showdialpogbox() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 138.0,bottom: 138.0),
        child: SlideInLeft(
          animate: true,
          duration: Duration(
              milliseconds: 800),
          manualTrigger: false,
          child: AlertDialog(
              backgroundColor: Color(0xff264656),
              content:
              Container(
                width: 350,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Add a Category Item Successfully",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/68.3,
                        color: Colors.white),),
                    SizedBox(height: 20,),
                    Container(
                      height: 150,
                      width: 150,
                      child: Lottie.network("https://assets10.lottiefiles.com/temporary_files/ofgUtS.json"),
                    ),
                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        Brand();
                        Navigator.pop(context);
                      },
                      child: Material(
                        elevation: 15,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 40,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                                "Okay",
                                style: GoogleFonts.poppins(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16, color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    )


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
          padding: const EdgeInsets.only(
              top: 150.0, bottom: 150, left: 350, right: 350),
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Are You Sure Want to Delete",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: width/75.888),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 180,
                    width: 180,
                    child: Lottie.network(deletefile),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      delete(barndid);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff263646)),
                      child: Center(
                        child: Text(
                          "Okay",
                          style: GoogleFonts.poppins(
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
