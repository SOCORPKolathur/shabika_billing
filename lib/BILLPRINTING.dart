import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;

class printing_Page extends StatefulWidget {
  const printing_Page({super.key});

  @override
  State<printing_Page> createState() => _printing_PageState();
}

class _printing_PageState extends State<printing_Page> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      getvalue("Suppilername", "Tax", "Suppilerinvoice", "purchaseno", "purchasedate", "payment","totalamountvalue");

    }, child: Text("Click"));
  }



}

getvalue(Suppilername, Tax, Suppilerinvoice, purchaseno, purchasedate, payment,totalamountvalue) async {



  List<p.Widget> widgets = [];

  //container for profile image decoration
  final container = p.Center(
    child: p.Container(
        child: p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
          p.Container(
              width: 20,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Si\nNo".toString(),
                    textAlign: p.TextAlign.center,
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 100,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Descriptions of Good".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 60,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("HSN/SAC".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 60,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Qty".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 60,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Column(
                  crossAxisAlignment: p.CrossAxisAlignment.center,
                  children:
                  [
                    p.Text("Rate".toString(),
                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    p.Text("(Incl of Tax)".toString(),
                      style: const p.TextStyle(color: PdfColors.black,fontSize: 8),),
                  ]
              )),
          p.Container(
              width: 40,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Rate".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 40,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Per".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),

          p.Container(
              width: 40,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Disc.%".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              )),
          p.Container(
              width: 60,
              height:22,
              decoration: p.BoxDecoration(
                  border: p.Border(
                    left: p.BorderSide(color: PdfColors.black),
                    top: p.BorderSide(color: PdfColors.black),
                    bottom: p.BorderSide(color: PdfColors.black),
                    right:  p.BorderSide(color: PdfColors.black),
                  )
              ),
              child: p.Center(
                child: p.Text("Amount".toString(),
                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              ))
        ])),
  );
  //widgets.add(container);

  widgets.add(p.SizedBox(height: 5));

  widgets.add(p.Stack(children: [

    p.Padding(
        padding: const p.EdgeInsets.only(top: 90),
        child: p.Container(
            child: p.Column(
                children: [
                  p.Row(
                      mainAxisAlignment: p.MainAxisAlignment.center,
                      children: [
                        p.SizedBox(width:140),
                        p.Text("GST INVOICE SALES",
                            style: const p.TextStyle(color: PdfColors.black)),
                        p.SizedBox(width:60),
                        p.Text("( ORIGINAL For RECIPIENT )",
                            style: const p.TextStyle(color: PdfColors.black)),
                      ]
                  ),

                  p.Container(
                      decoration: p.BoxDecoration(
                          border: p.Border.all(color: PdfColors.black)
                      ),

                      child: p.Column(
                          children: [
                            p.Row(
                                mainAxisAlignment: p.MainAxisAlignment.start,
                                crossAxisAlignment: p.CrossAxisAlignment.start,
                                children: [
                                  p.Container(
                                    child: p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.start,
                                        mainAxisAlignment: p.MainAxisAlignment.start,
                                        children: [
                                          p.SizedBox(height:4),
                                          p.Padding(
                                            padding: p.EdgeInsets.only(left:4),
                                            child:  p.SizedBox(
                                                child: p.Column(
                                                    crossAxisAlignment: p.CrossAxisAlignment.start,
                                                    children: [
                                                      p.Text("DIGITEK", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("RAHEJA COMPLEX", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("834.Mount Road", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("SHOP No.7,GF", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("CHENNAI 600002", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("CALL -42149750,9791072131", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("GSTIN/UIN:33CYPC2418E1ZU", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("STATE NAME:Tamil Nadu,code:33", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("CIN:", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("Email: digitek90@gmail.com", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                    ]
                                                )
                                            ),
                                          ),
                                          p.SizedBox(height:2),
                                          p.Container(height:1,width:260,color:PdfColors.black,),
                                          p.SizedBox(height:2),

                                          p.Padding(
                                            padding: p.EdgeInsets.only(left:4),
                                            child: p.SizedBox(
                                                child: p.Column(
                                                    crossAxisAlignment: p.CrossAxisAlignment.start,
                                                    children: [
                                                      p.Text("Buyer (Bill to)", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("Shabika Mobiles", style:  p.TextStyle(color: PdfColors.black,fontSize: 10,)),
                                                      p.Text("No.95/1,Krishna Tower,Valmigi Street East", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                      p.Text("Tambaram,Chennai-600059,M-9941114545", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),

                                                      p.Row(
                                                          crossAxisAlignment: p.CrossAxisAlignment.center,
                                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                                          children: [
                                                            p.Container(
                                                              width:80,
                                                              child:    p.Text("GSTIN/UIN", style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            ),
                                                            p.Text(": 33ESIPS9367G1Z3", style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      ),
                                                      p.Row(
                                                          crossAxisAlignment: p.CrossAxisAlignment.center,
                                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                                          children: [
                                                            p.Container(
                                                              width:80,
                                                              child:    p.Text("PAN/IT No", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            ),
                                                            p.Text(": ESIPS9367G", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      ),
                                                      p.Row(
                                                          crossAxisAlignment: p.CrossAxisAlignment.center,
                                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                                          children: [
                                                            p.Container(
                                                              width:80,
                                                              child:    p.Text("State Name", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            ),
                                                            p.Text(": Tamil Nadu ,Code:33", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      ),
                                                      p.Row(
                                                          crossAxisAlignment: p.CrossAxisAlignment.center,
                                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                                          children: [
                                                            p.Container(
                                                              width:80,
                                                              child:    p.Text("Place Of Supply", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            ),
                                                            p.Text(": Tamil Nadu", style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      ),

                                                    ]
                                                )
                                            ),
                                          ),
                                          p.SizedBox(height:4),

                                        ]
                                    ),
                                  ),

                                  p.SizedBox(width: 4),


                                  p.Container(
                                      child: p.Column(
                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                          mainAxisAlignment: p.MainAxisAlignment.start,
                                          children: [
                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            // top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Invoice No.",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("DTK/23-24/2518",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            // top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Dated",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("4-Nov-23",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),


                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Delivery Note",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Mode/Terms Of Payment",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("CASH",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),


                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Reference No.& Date",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("DTK/23-24/2518 dt  4-Nov-23",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Other References",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),


                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Buyer's Order No.",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Dated",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("CASH",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),


                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Dispatch Doc No.",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Delivery Note Date",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("CASH",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),


                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Dispatched through",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),


                                                  p.Container(
                                                      width: 110,
                                                      height: 25,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),

                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Column(
                                                          crossAxisAlignment: p.CrossAxisAlignment.start,
                                                          children: [
                                                            p.Text("Destination",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                            p.Text("",
                                                                style:  p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                          ]
                                                      )),

                                                ]),

                                            p.Row(
                                                children: [
                                                  p.Container(
                                                      width: 220,
                                                      height: 70,
                                                      decoration: p.BoxDecoration(
                                                          border: p.Border(
                                                            right: p.BorderSide(color: PdfColors.black),
                                                            top: p.BorderSide(color: PdfColors.black),
                                                            left: p.BorderSide(color: PdfColors.black),
                                                          )
                                                      ),
                                                      padding: p.EdgeInsets.only(left:3),
                                                      child: p.Text("Terms Of Delivery",
                                                          style:  p.TextStyle(color: PdfColors.black,fontSize: 10))),




                                                ]),

                                          ])),
                                ]),
                          ]
                      )
                  ),



                  ///ListView Builder Containers
                  container,
                  p.Container(
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          bottom: p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.ListView.builder(
                      itemCount:2,
                      itemBuilder: (context, index) {
                        return
                          p.Container(
                            child:
                            p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
                              p.Container(
                                  width: 20,
                                  height:22,   decoration: p.BoxDecoration(
                                  border: p.Border(
                                    left: p.BorderSide(color: PdfColors.black),
                                    //right:  p.BorderSide(color: PdfColors.black),
                                  )
                              ),
                                  child: p.Center(
                                    child: p.Text("${index+1}".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 100,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Descriptions of Good".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 60,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("HSN/SAC".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 60,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Qty".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 60,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Text("Rate".toString(),
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10))),
                              p.Container(
                                  width: 40,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Rate".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 40,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        //  right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Per".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),

                              p.Container(
                                  width: 40,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        // right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Disc.%".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  )),
                              p.Container(
                                  width: 60,
                                  height:22,
                                  decoration: p.BoxDecoration(
                                      border: p.Border(
                                        left: p.BorderSide(color: PdfColors.black),
                                        right:  p.BorderSide(color: PdfColors.black),
                                      )
                                  ),
                                  child: p.Center(
                                    child: p.Text("Amount".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  ))
                            ]),);
                      },
                    ),
                  ),



                ]))),
  ]));


  widgets.add(
    p.Container(
        child:p.Column(
            children: [
              p.Row(mainAxisAlignment: p.MainAxisAlignment.start, children: [
                p.Container(
                    width: 20,
                    height:22,   decoration: p.BoxDecoration(
                    border: p.Border(
                      left: p.BorderSide(color: PdfColors.black),
                      bottom:  p.BorderSide(color: PdfColors.black),
                    )
                ),
                    child: p.Center(
                      child: p.Text("${""}".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    )),
                p.Container(
                    width: 100,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Center(
                        child:  p.Row(
                            mainAxisAlignment: p.MainAxisAlignment.end,
                            children: [
                              p.Text("Total".toString(),
                                  style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                              p.SizedBox(width:2),
                            ]
                        )
                    )),
                p.Container(
                    width: 60,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Center(
                      child: p.Text("".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    )),
                p.Container(
                    width: 60,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.end,
                        children: [
                          p.Text("5 Nos".toString(),
                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                          p.SizedBox(width:2),
                        ]
                    )),
                p.Container(
                    width: 60,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Text("".toString(),
                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))),
                p.Container(
                    width: 40,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Center(
                      child: p.Text("".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    )),
                p.Container(
                    width: 40,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Center(
                      child: p.Text("".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    )),

                p.Container(
                    width: 40,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Center(
                      child: p.Text("".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    )),
                p.Container(
                    width: 60,
                    height:22,
                    decoration: p.BoxDecoration(
                        border: p.Border(
                          left: p.BorderSide(color: PdfColors.black),
                          right:  p.BorderSide(color: PdfColors.black),
                          bottom:  p.BorderSide(color: PdfColors.black),
                        )
                    ),
                    child: p.Row(
                        mainAxisAlignment: p.MainAxisAlignment.end,
                        children: [
                          p.Text("₹ ${"2,20,200"}".toString(),
                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                          p.SizedBox(width:2),
                        ]
                    ))
              ]
              ),


              p.Container(
                  decoration: p.BoxDecoration(
                      border: p.Border(
                        left: p.BorderSide(color: PdfColors.black),
                        right:  p.BorderSide(color: PdfColors.black),
                        bottom:  p.BorderSide(color: PdfColors.black),
                      )
                  ),
                  child:p.Column(
                      children: [
                        p.Row(

                            children: [
                              p.Padding(
                                padding: p.EdgeInsets.only(left:2),
                                child:p.Text("Amount Chargeable(in words)".toString(),
                                    textAlign: p.TextAlign.center,
                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 9)),
                              ),


                              p.Padding(
                                  padding: p.EdgeInsets.only(right:2),
                                  child: p.Text("E & O.E".toString(),
                                      textAlign: p.TextAlign.center,
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                              ),
                            ],
                            mainAxisAlignment: p.MainAxisAlignment.spaceBetween
                        ),
                        p.Row(
                            children: [
                              p.SizedBox(width:2),
                              p.Text("Indian Rupees Two Thousand Hundred Only".toString(),
                                  textAlign: p.TextAlign.center,
                                  style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),

                            ]
                        ),

                      ]
                  )
              ),

              p.Container(

                  decoration: p.BoxDecoration(
                      border: p.Border(

                      )
                  ),
                  child:p.Column(
                      children: [
                        p.Row(
                          children: [
                            p.Container(
                                width:223,
                                height:30,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("HSN/SAC".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),

                            p.Container(
                                width:60,
                                height:30,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("Taxable \nValue".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),

                            p.Container(
                                width:70,
                                height:30,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Column(
                                    children: [
                                      p.Container(
                                          width:70,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),

                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("Central Tax".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                      ),
                                      p.Row(
                                          children: [
                                            p.Container(
                                                width:35,
                                                height:15,
                                                decoration: p.BoxDecoration(
                                                    border: p.Border(
                                                      left: p.BorderSide(color: PdfColors.black),

                                                      bottom:  p.BorderSide(color: PdfColors.black),
                                                    )
                                                ),
                                                child:p.Text("Rate".toString(),
                                                    textAlign: p.TextAlign.center,
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                            ),
                                            p.Container(
                                                width:35,
                                                height:15,
                                                decoration: p.BoxDecoration(
                                                    border: p.Border(
                                                      left: p.BorderSide(color: PdfColors.black),

                                                      bottom:  p.BorderSide(color: PdfColors.black),
                                                    )
                                                ),
                                                child:p.Text("Amount".toString(),
                                                    textAlign: p.TextAlign.center,
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                            ),
                                          ]
                                      )
                                    ]
                                )
                            ),



                            p.Container(
                                width:70,
                                height:30,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Column(
                                    children: [
                                      p.Container(
                                          width:70,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),
                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("State Tax".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                      ),
                                      p.Row(
                                          children: [
                                            p.Container(
                                                width:35,
                                                height:15,
                                                decoration: p.BoxDecoration(
                                                    border: p.Border(
                                                      left: p.BorderSide(color: PdfColors.black),
                                                      bottom:  p.BorderSide(color: PdfColors.black),
                                                    )
                                                ),
                                                child:p.Text("Rate".toString(),
                                                    textAlign: p.TextAlign.center,
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                            ),
                                            p.Container(
                                                width:35,
                                                height:15,
                                                decoration: p.BoxDecoration(
                                                    border: p.Border(
                                                      left: p.BorderSide(color: PdfColors.black),
                                                      right:  p.BorderSide(color: PdfColors.black),
                                                      bottom:  p.BorderSide(color: PdfColors.black),
                                                    )
                                                ),
                                                child:p.Text("Amount".toString(),
                                                    textAlign: p.TextAlign.center,
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                            ),
                                          ]
                                      )
                                    ]
                                )
                            ),

                            p.Container(
                                width:60,
                                height:30,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      right:  p.BorderSide(color: PdfColors.black),
                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("Total \nTax Amount".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),



                          ],

                        ),

                      ]
                  )
              ),


              //values container-1
              p.Container(

                  decoration: p.BoxDecoration(
                      border: p.Border(
                        bottom:  p.BorderSide(color: PdfColors.black),
                      )
                  ),
                  child:p.Column(
                      children: [
                        p.Row(
                          children: [
                            p.Container(
                                width:223,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                    )
                                ),
                                child:p.Text("85542999".toString(),
                                    textAlign: p.TextAlign.center,
                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                            ),

                            p.Container(
                                width:60,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("1,8466.40".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),

                            p.Container(
                                width:70,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                    )
                                ),
                                child:
                                p.Row(
                                    children: [
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),


                                              )
                                          ),
                                          child:p.Text("9%".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),


                                              )
                                          ),
                                          child:p.Text("167.50".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                    ]
                                )
                            ),



                            p.Container(
                                width:70,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),


                                    )
                                ),
                                child:p.Row(
                                    children: [
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),


                                              )
                                          ),
                                          child:p.Text("9 %".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),

                                              )
                                          ),
                                          child:p.Text("167.80".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                    ]
                                )
                            ),

                            p.Container(
                                width:60,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      right:  p.BorderSide(color: PdfColors.black),

                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("18,780".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),



                          ],

                        ),

                      ]
                  )
              ),

              //value container-2

              p.Container(

                  decoration: p.BoxDecoration(
                      border: p.Border(
                        left: p.BorderSide(color: PdfColors.black),
                        right:  p.BorderSide(color: PdfColors.black),
                        bottom:  p.BorderSide(color: PdfColors.black),
                      )
                  ),
                  child:p.Column(
                      children: [
                        p.Row(
                          children: [
                            p.Container(
                                width:223,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Row(
                                    mainAxisAlignment: p.MainAxisAlignment.end,
                                    children: [

                                      p.Text("Total".toString(),
                                          textAlign: p.TextAlign.center,
                                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                      p.SizedBox(width:2),
                                    ]
                                )
                            ),

                            p.Container(
                                width:60,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("1,8466.40".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),

                            p.Container(
                                width:70,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:
                                p.Row(
                                    children: [
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),

                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("9%".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),

                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("167.50".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                    ]
                                )
                            ),



                            p.Container(
                                width:70,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),
                                      right:  p.BorderSide(color: PdfColors.black),
                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Row(
                                    children: [
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),
                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("9 %".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                      p.Container(
                                          width:35,
                                          height:15,
                                          decoration: p.BoxDecoration(
                                              border: p.Border(
                                                left: p.BorderSide(color: PdfColors.black),

                                                bottom:  p.BorderSide(color: PdfColors.black),
                                              )
                                          ),
                                          child:p.Text("167.80".toString(),
                                              textAlign: p.TextAlign.center,
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 8))
                                      ),
                                    ]
                                )
                            ),

                            p.Container(
                                width:60,
                                height:15,
                                decoration: p.BoxDecoration(
                                    border: p.Border(
                                      left: p.BorderSide(color: PdfColors.black),

                                      bottom:  p.BorderSide(color: PdfColors.black),
                                    )
                                ),
                                child:p.Center(
                                    child:p.Text("18,780".toString(),
                                        textAlign: p.TextAlign.center,
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                                )
                            ),






                          ],

                        ),

                        p.Row(children: [
                          p.SizedBox(width:2),
                          p.Text("Tax Amount(in words) ${"Indian Rupees Three Thousand Hundred only"}".toString(),
                              textAlign: p.TextAlign.center,
                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                        ]),

                        p.Row(children: [
                          p.SizedBox(width:2),
                          p.Text("Company's PAN  : ${"+"}".toString(),
                              textAlign: p.TextAlign.center,
                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10))
                        ]),

                        p.Row(children: [
                          p.SizedBox(width:2),
                          p.Column(
                              crossAxisAlignment: p.CrossAxisAlignment.start,
                              children: [
                                p.Text("Declaration".toString(),
                                    textAlign: p.TextAlign.center,
                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                p.SizedBox(height:2),
                                p.Container(
                                  width:240,
                                  child:p.Text("Declaration Quotes".toString(),
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                ),

                              ]
                          ),

                          p.Column(
                              children: [
                                p.Text("Company".toString(),
                                    textAlign: p.TextAlign.center,
                                    style: const p.TextStyle(color: PdfColors.white,fontSize: 10)),
                                p.SizedBox(height:2),
                                p.Container(
                                    width:240,
                                    child:p.Column(
                                        crossAxisAlignment: p.CrossAxisAlignment.start,
                                        children: [
                                          p.Text("Company's Bank Details".toString(),
                                              style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                          p.Row(

                                              children: [
                                                p.Container(
                                                  width:80,
                                                  child: p.Text("Bank Name".toString(),
                                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                ),
                                                p.Text(": Kotak Mahindra Bank".toString(),
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8)),
                                              ]
                                          ),


                                          p.Row(

                                              children: [
                                                p.Container(
                                                  width:80,
                                                  child: p.Text("Ac/No".toString(),
                                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                ),
                                                p.Text(": 9841022480".toString(),
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8)),
                                              ]
                                          ),
                                          p.Row(

                                              children: [
                                                p.Container(
                                                  width:80,
                                                  child: p.Text("Branch &IFSC Code".toString(),
                                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                                ),
                                                p.Text(": Mini Street& Sowcaepet&KKBk008478".toString(),
                                                    style: const p.TextStyle(color: PdfColors.black,fontSize: 8)),
                                              ]
                                          )
                                        ]
                                    )
                                ),
                              ]
                          )
                        ]),



                      ]
                  )
              ),
              p.Row(
                  children: [
                    p.Container(
                      width:241,
                      height:40,
                      decoration: p.BoxDecoration(
                          border: p.Border(
                            left: p.BorderSide(color: PdfColors.black),
                            right:  p.BorderSide(color: PdfColors.black),
                            bottom:  p.BorderSide(color: PdfColors.black),
                          )
                      ),
                      padding: p.EdgeInsets.only(left:2),
                      child:    p.Text("Customer's Seal and Signature".toString(),
                          style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                    ),
                    p.Container(
                        width:241,
                        height:40,
                        decoration: p.BoxDecoration(
                            border: p.Border(
                              right:  p.BorderSide(color: PdfColors.black),
                              bottom:  p.BorderSide(color: PdfColors.black),
                            )
                        ),
                        child:p.Column(
                            mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                            children: [
                              p.Row(
                                  children: [
                                    p.Text("for DIGITEK".toString(),
                                        style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                    p.SizedBox(width:2),
                                  ],
                                  mainAxisAlignment: p.MainAxisAlignment.end
                              ),

                              p.Row(
                                mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                                children: [
                                  p.Text("Purebred By".toString(),
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  p.Text("Verified By".toString(),
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
                                  p.Text("Authorised Signatory".toString(),
                                      style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),

                                ],

                              ),

                            ]
                        )
                    ),
                  ]
              ),
              p.SizedBox(height:2),
              p.Text("SUBJECT TO CHENNAI JURISDICTION".toString(),
                  style: const p.TextStyle(color: PdfColors.black,fontSize: 10)),
              p.Text("This is Computer generated invoice".toString(),
                  style: const p.TextStyle(color: PdfColors.black,fontSize: 8)),

            ]
        )
    ),
  );

  final pdf = p.Document();
  pdf.addPage(
    p.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => widgets, //here goes the widgets list
    ),
  );
  Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
