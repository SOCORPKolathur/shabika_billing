import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPurchase_page2 extends StatefulWidget {
  String?docid;
  String?docid2;

  EditPurchase_page2(this.docid,this.docid2);

  @override
  State<EditPurchase_page2> createState() => _EditPurchase_page2State();
}

class _EditPurchase_page2State extends State<EditPurchase_page2> {

  TextEditingController Decription=TextEditingController();
  TextEditingController Hsncode2=TextEditingController();
  TextEditingController Quvantity=TextEditingController();
  TextEditingController Rate=TextEditingController();
  TextEditingController Tax=TextEditingController();
  TextEditingController Amount=TextEditingController();

  //get2 the purchase entry collection
  getvalur2() async {
    var getdate=await FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).doc(widget.docid2).get();
    Map<String,dynamic>?value=getdate.data();
    setState(() {
      Decription.text=value!["Description"];
      Hsncode2.text=value["Hsncode"];
      Quvantity.text=value["Qty"];
      Rate.text=value["Landing cost"];
      Tax.text=value["tax"];
      Amount.text=value["Total"];
    });
  }

  //edit function-2
  editfunction2(){
    FirebaseFirestore.instance.collection("Purchase entry").doc(widget.docid).collection(widget.docid.toString()).doc(widget.docid2).update({
      "Description":Decription.text,
      "Hsncode":Hsncode2.text,
      "Qty":Quvantity.text,
      "Landing cost":Rate.text,
      "tax":Tax.text,
      "Total":Amount.text,
    });
  }


@override
  void initState() {
  getvalur2();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:height/32.85),


          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: width / 91.06),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Tooltip(
                  message: "Back",
                  child: Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Colors.indigo,
                    child: Container(
                      height: height / 21.9,
                      width: width / 45.53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: width / 91.06,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width / 91.06),
              Text("Edit the Purchase Reports",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,
                  color: Colors.white,fontSize: 18),),
            ],
          ),

          SizedBox(height:height/45.53),
          Padding(
            padding:  EdgeInsets.only(left: width/6.83),
            child: Column(
              children: [


                Row(
                   children: [
                     Padding(
                       padding:  EdgeInsets.symmetric(
                           horizontal: width/341.5,
                           vertical: height/164.25
                       ),
                       child: Row(
                         children: [
                           SizedBox(
                               width:width/11.38,
                               child: Text("Description",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                           SizedBox(width:width/136.6),
                           Material(
                               color: Colors.white,
                               elevation: 20,
                               shadowColor: Colors.black12,
                               child: Container(
                                 height:height/16.425,
                                 width:width/4.55,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.grey.shade200
                                 ),
                                 child: TextField(
                                   style: GoogleFonts.montserrat(),
                                   controller:Decription,
                                   decoration: InputDecoration(
                                     border: InputBorder.none,
                                     contentPadding: EdgeInsets.only(left:width/136.6),
                                     hintStyle: GoogleFonts.montserrat(),
                                   ),
                                   onSubmitted: (_){

                                   },
                                 ),
                               )),
                         ],
                       ),
                     ),
                     SizedBox(width: width/130.6,),

                     Padding(
                       padding:  EdgeInsets.symmetric(
                           horizontal: width/341.5,
                           vertical: height/164.25
                       ),
                       child: Row(
                         children: [
                           SizedBox(
                               width:width/11.38,
                               child: Text("HSN code",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                           SizedBox(width:width/136.6),
                           Material(
                               color: Colors.white,
                               elevation: 20,
                               shadowColor: Colors.black12,
                               child: Container(
                                 height:height/16.425,
                                 width:width/4.55,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                     color: Colors.grey.shade200
                                 ),
                                 child: TextField(
                                   style: GoogleFonts.montserrat(),
                                   controller:Hsncode2,
                                   decoration: InputDecoration(
                                     border: InputBorder.none,
                                     contentPadding: EdgeInsets.only(left:width/136.6),
                                     hintStyle: GoogleFonts.montserrat(),
                                   ),
                                   onSubmitted: (_){

                                   },
                                 ),
                               )),
                         ],
                       ),
                     ),

                   ],
                ),
                SizedBox(height:height/65.7),

                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/341.5,
                          vertical: height/164.25
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width:width/11.38,
                              child: Text("Quantity",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                          SizedBox(width:width/136.6),
                          Material(
                              color: Colors.white,
                              elevation: 20,
                              shadowColor: Colors.black12,
                              child: Container(
                                height:height/16.425,
                                width:width/4.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(),
                                  controller:Quvantity,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left:width/136.6),
                                    hintStyle: GoogleFonts.montserrat(),
                                  ),
                                  onSubmitted: (_){

                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: width/130.6,),


                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/341.5,
                          vertical: height/164.25
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width:width/11.38,
                              child: Text("Rate",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                          SizedBox(width:width/136.6),
                          Material(
                              color: Colors.white,
                              elevation: 20,
                              shadowColor: Colors.black12,
                              child: Container(
                                height:height/16.425,
                                width:width/4.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(),
                                  controller:Rate,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left:width/136.6),
                                    hintStyle: GoogleFonts.montserrat(),
                                  ),
                                  onSubmitted: (_){

                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:height/65.7),

                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/341.5,
                          vertical: height/164.25
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width:width/11.38,
                              child: Text("Tax",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                          SizedBox(width:width/136.6),
                          Material(
                              color: Colors.white,
                              elevation: 20,
                              shadowColor: Colors.black12,
                              child: Container(
                                height:height/16.425,
                                width:width/4.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(),
                                  controller:Tax,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left:width/136.6),
                                    hintStyle: GoogleFonts.montserrat(),
                                  ),
                                  onSubmitted: (_){

                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: width/130.6,),

                    //Total amount
                    Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/341.5,
                          vertical: height/164.25
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width:width/11.38,
                              child: Text("Total",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),)),
                          SizedBox(width:width/136.6),
                          Material(
                              color: Colors.white,
                              elevation: 20,
                              shadowColor: Colors.black12,
                              child: Container(
                                height:height/16.425,
                                width:width/4.55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200
                                ),
                                child: TextField(
                                  style: GoogleFonts.montserrat(),
                                  controller:Amount,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left:width/136.6),
                                    hintStyle: GoogleFonts.montserrat(),
                                  ),
                                  onSubmitted: (_){

                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),

          SizedBox(height:height/45.53),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  editfunction2();
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 15,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: height/16.425,
                    width: width/7.588,
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
                              fontSize: width/85.375, color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width/45.53,),

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 15,
                  color: const Color(0xff263646),
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: height/16.425,
                    width: width/7.588,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff263646),
                    ),
                    child: Center(
                      child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                              fontSize: width/85.375, color: Colors.white)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),

    );
  }
}
