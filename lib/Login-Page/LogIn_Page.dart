import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../LandingPage/LandingPage.dart';
import '../User_Page/User_Billing_Page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  TextEditingController _NameController=TextEditingController();
  TextEditingController _PasswordController=TextEditingController();

  bool nameclick=false;
  bool passclick=false;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;


    return   Scaffold(
      backgroundColor: const Color(0xff00A99D),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          SizedBox(
            width:width/2.276 ,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height/21.9,),
                Text("Welcome Admin",style: GoogleFonts.openSans(fontSize: width/39.02,
                    fontWeight: FontWeight.w700,color: Colors.white),),
                Text("Shabika Billing",style: GoogleFonts.openSans(fontSize: width/54.64,
                    fontWeight: FontWeight.w500,color: Colors.white)),
                Container(
                  height: height/1.342,
                  width: width/2.732,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/undraw_steps_re_odoy 1.png")
                    )
                  ),
                ),
                SizedBox(
                  height: height/65.7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Developed by SO CORP",style: GoogleFonts.openSans(fontSize: width/91.06,fontWeight: FontWeight.w500,color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: width/3.035,
            height: height/1.194,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xffBFE9E7)
            ),
            child: Column(

              children: [

                SizedBox(height: height/8.2125,),

                Row(
                  children: [
                    SizedBox(width: width/30.35,),
                    Text("Sign in",style: GoogleFonts.openSans(fontSize:
                    width/39.02,fontWeight: FontWeight.w900,color: Colors.black),),
                  ],
                ),

                SizedBox(height: height/13.14,),

                //user name text and container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter Your Username and or email  address",style: GoogleFonts.openSans(fontSize: width/113.83,color: Colors.black),),
                   SizedBox(height: height/65.7,),
                    Container(
                      height: height/13.14,
                      width: width/3.902,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFFFFF),
                          border: Border.all(color: nameclick==true?const Color(0xff4285F4):const Color(0xffADADAD))
                      ),
                      child:
                      TextField(
                        onTap: (){
                          setState(() {
                            nameclick=true;
                            passclick=false;
                          });
                        },
                        controller: _NameController,
                        style: GoogleFonts.openSans(fontSize: width/113.83,color: const Color(0xff808080)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: width/68.3),
                          border: InputBorder.none,
                          hintText:"User name or email address",labelStyle: GoogleFonts.openSans( color:Color(0xff808080)),
                          hintStyle: GoogleFonts.openSans(fontSize: width/113.83,color: const Color(0xff808080)),

                        ),
                      ),
                    )//808080

                  ],
                ),
                SizedBox(height: height/13.14,),

                // Password text and container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter Your Password ",style: GoogleFonts.openSans(fontSize: width/113.83,color: Colors.black),),
                    SizedBox(height: height/65.7,),
                    Container(
                      height: height/13.14,
                      width: width/3.902,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFFFFF),
                        border: Border.all(color: passclick==true?const Color(0xff4285F4):const Color(0xffADADAD))
                      ),
                      child: TextField(
                        onTap: (){
                          setState(() {
                            nameclick=false;
                            passclick=true;
                          });
                        },
                        controller: _PasswordController,
                        style: GoogleFonts.openSans(fontSize: width/113.83,color: const Color(0xff808080)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: width/68.3),
                          border: InputBorder.none,
                          hintText:"Password",labelStyle: GoogleFonts.openSans( color:Color(0xff808080)),
                          hintStyle: GoogleFonts.openSans(fontSize: width/113.83,color: const Color(0xff808080)),

                        ),
                        onSubmitted: (value){
                          if(_NameController.text=="admin"&&_PasswordController.text=="admin@123"){

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  drawer(_NameController.text),));
                          }
                          else if(_NameController.text=="user"&&_PasswordController.text=="user@123"){

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Billing_Page2(),));
                          }
                          else{
                            errorpopup();
                          }
                        },
                      ),
                    )

                  ],
                ),

                //forget text
                SizedBox(height: height/65.7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forget Password ",style: GoogleFonts.openSans(fontSize: width/113.83,color:
                    const Color(0xff4285F4)),),
                    SizedBox(width: width/27.32,),
                  ],
                ),

                SizedBox(height: height/13.14,),

                //submit buttton
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        if(_NameController.text=="admin"&&_PasswordController.text=="admin@123"){

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  drawer(_NameController.text),));
                        }
                        else if(_NameController.text=="user"&&_PasswordController.text=="user@123"){

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Billing_Page2(),));
                        }
                        else{
                          errorpopup();
                        }
                      },
                      child: Material(
                        shadowColor:  const Color(0xff9AD2C0),
                        elevation: 30,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff00A99D),
                        child: Container(
                          height: height/13.14,
                          width: width/6.83,
                          decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff00A99D),

                          ),
                          child: Center(
                            child: Text("Sign in",style: GoogleFonts.openSans(
                                fontSize: width/91.06,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xffFFFFFF)),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width/27.32,),
                  ],
                )

              ],
            ),
          )


        ],
      ),
    );
  }

  errorpopup(){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder:
        (context) {
      return Padding(
        padding:  EdgeInsets.only(top: height/4.516,bottom: height/4.516),
        child: AlertDialog(
          title: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: width/213.437,
                vertical: height/101.625
            ),
            child: Text("Oops Please Enter the valid  Name and Password !.. ",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(),),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height/32.52,),
              SizedBox(
                height: height/5.42,
                width: width/11.383,
                child: Lottie.asset("assets/animation_lktdcc5s.json",fit: BoxFit.fill),
              ),
              SizedBox(height: height/32.52,),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  color:  const Color(0xFF2D2D6D),
                  borderRadius: BorderRadius.circular(5),
                  elevation: 45,
                  shadowColor: Colors.black12,
                  child: Container(
                    height: height/16.26,
                    width: width/11.383,
                    decoration: BoxDecoration(
                      color:  const Color(0xFF2D2D6D),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text("Okay",style: GoogleFonts.openSans(color: Colors.white),),
                    ),
                  ),
                ),
              )



            ],
          ),
        ),
      );
    },);
  }

}
