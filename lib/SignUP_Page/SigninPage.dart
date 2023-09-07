

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../LandingPage/LandingPage.dart';


class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff01A99E),
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, right: 60),
                    child: Text("Welcome Admin",
                        style: GoogleFonts.poppins(
                            fontSize: 29, color: const Color(0xffFFFFFF))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18, right: 149),
                    child: Text("Shabika Billing",
                        style: GoogleFonts.poppins(
                            fontSize: width/68.3, color: const Color(0xffFFFFFF))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, bottom: 5),
                    child: Image.asset(
                      "assets/undraw.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text("Developed by SO CORP",
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: const Color(0xffFFFFFF))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 798.0, top: 100),
                child: Container(width: width/3,
                  height: height/1.3,
                  decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(12)),child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 220,top: 60),
                      child: Text("Sign In",style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0,right: 146,bottom: 8),
                      child: Text("Enter your username or email address",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 10),),
                    ),
                    SizedBox(
                      height: height/16,
                      width:width/3.9,
                      child: const TextField(
                          decoration: InputDecoration(contentPadding: EdgeInsets.only(top: 10,left: 10),
                              hintText: "Username or email address",
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                  color: Colors.blue), ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,

                                ),
                              )

                          ) ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0,right: 240,bottom: 8),
                      child: Text("Enter your password",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 10),),
                    ),
                    SizedBox(
                      height: height/16.4,
                      width: width/3.9,
                      child: const TextField(
                          decoration: InputDecoration(contentPadding: EdgeInsets.only(top: 10,left: 10),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                  color: Colors.grey), ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,

                                ),
                              )

                          ) ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 258.0,top: 8),
                      child: Text("Forgot Password",style: GoogleFonts.poppins(color: Colors.blue,fontSize: 10),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0,top: 30),
                      child: GestureDetector(onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => drawer(" ")));
                      },
                        child: Container(width: width/7.5,
                          height: height/13.14,
                          // color: Colors.teal,
                          decoration: BoxDecoration(color: const Color(0xff00A99D),borderRadius: BorderRadius.circular(12)),child: Center(child: Text("Sign in",style: GoogleFonts.poppins(color: Colors.white),)),

                        ),
                      ),
                    )
                  ],
                ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
