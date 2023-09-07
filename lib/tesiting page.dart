
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Printing_Page/Print_Page.dart';
import 'package:pdf/pdf.dart';


class test_demo extends StatefulWidget {
  const test_demo({Key? key}) : super(key: key);

  @override
  State<test_demo> createState() => _test_demoState();
}

class _test_demoState extends State<test_demo> {

  List <Product> product=[];

  int test=50;
  String paymentinfo='Payment Mode: Online \nDate:${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}\nTime: ${DateFormat('hh:mm a').format(DateTime.now())}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){

            for(int k=0;k<test;k++){
              product.add(Product((int.parse(k.toString())+1).toString(), "Itemnam${k+1}", k.toDouble(), k));
            }
            print("Check");
            generateInvoice(PdfPageFormat.a4,product,);

          }, child: Text("Check"),
        ),
      ),
    );
  }
}
