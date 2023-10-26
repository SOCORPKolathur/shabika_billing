import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'Puchase edit_page1.dart';

class Purchase_Reports extends StatefulWidget {
  @override
  State<Purchase_Reports> createState() => _Purchase_ReportsState();
}

const List<String> Payment = <String>[
  'Please Select Type',
  'Cash',
  'Card',
  'Gpay',
  "Phone Pay",
  "Split Amount"
];

const List<String> Paymentmode = <String>['Please Select', "Paid", "Un Paid"];

const List<String> Paymentmode2 = <String>['Please Select', "Paid", "Un Paid"];
const List<String> Paymentmode3 = <String>['Please Select', "G pay", "Cash","Paytm","Phonepe","Card"];

class _Purchase_ReportsState extends State<Purchase_Reports> {
  //toggle switch boolean
  bool status = false;
  bool status2 = false;

  TextEditingController Invoicecontroller = TextEditingController();
  TextEditingController Suppilercontroller = TextEditingController();
  TextEditingController Paymenttype = TextEditingController();
  bool isserach = false;
  String Username2 = "";
  String Username = "";
  String Status1 = '';
  String Status2 = '';
  String Status3 = '';

  List<String> Suppilier = [];
  List<String> Invoice = [];

  List<String> PaymentType2 = [
    "Unpaid",
    "Paid",
  ];
  List<String> PaymentType = [];

  String Payments = Paymentmode.first;

  String Payments2 = Paymentmode3.first;

  String Paymentsmodevalue = Paymentmode2.first;
  String PaymentChangevalue = '';

  additemduntion() async {
    setState(() {
      Suppilier.clear();
      Invoice.clear();
      PaymentType.clear();

    });

    if (status == true) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }
    } else if (status2 == true) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }
    } else if (status == false && status2 == false) {
      setState(() {
        Suppilier.clear();
        Invoice.clear();
        PaymentType.clear();

      });
      var document = await FirebaseFirestore.instance
          .collection("Purchase entry")
          .where("save", isEqualTo: true)
          .get();
      for (int i = 0; i < document.docs.length; i++) {
        setState(() {
          Suppilier.add(document.docs[i]['suppilername']);
          Invoice.add(document.docs[i]['suppilierinvoiceno']);
        });
      }
      for (int z = 0; z < PaymentType2.length; z++) {
        setState(() {
          PaymentType.add(PaymentType2[z]);
        });
      }
    }

    print(PaymentType);
  }
  int year1 = 0;
  int day1 = 0;
  int month1 = 0;
  int year2 = 0;
  int day2 = 0;
  int month2 = 0;
  List<String> mydate = [];
  TextEditingController Datecontroller = TextEditingController();
  TextEditingController Datecontroller2 = TextEditingController();
  final DateFormat formatter = DateFormat('d/M/yyyy');
datefun(){
    setState(() {


  setState(() {
    Datecontroller.text = DateFormat('dd/M/yyyy').format(DateTime.now());
    Datecontroller2.text =
        DateFormat('dd/M/yyyy').format(DateTime.now());
  });
  setState(() {

    year1 = DateTime.now().year;
    day1 = DateTime.now().day;
    month1 = DateTime.now().month;


    year2 = DateTime.now().year;
    day2 = DateTime.now().day;
    month2 = DateTime.now().month;

    //set output date to TextField value.
  });
  DateTime startDate = DateTime.utc(year1, month1, day1);
  DateTime endDate = DateTime.utc(year2, month2, day2);
  print(startDate);
  print(endDate);
  print("+++++++=================");
  getDaysInBetween() {
    final int difference =
        endDate.difference(startDate).inDays;
    return difference+1;
  }
  print(getDaysInBetween());


  final items =
  List<DateTime>.generate(getDaysInBetween(), (i) {
    DateTime date = startDate;
    return date.add(Duration(days: i));
  });
  setState(() {
    mydate.clear();
  });
  print(items.length);
  for (int i = 0; i < items.length; i++) {
    setState(() {
      isserach = true;
      mydate.add(formatter.format(items[i]).toString());
    });

  }
    });
  print(mydate);

  print(isserach);
  print("+++++++++++++000000000+++++++++++");
  setState(() {

  });

}
  @override
  void initState() {

    datefun();
    additemduntion();
    setState(() {
      isserach=true;
    });
    print(mydate);
    billingtotalamount();
    // TODO: implement initState
    super.initState();
  }



  double salesamount = 0;
  double balanceamountpurchase = 0;

  billingtotalamount() async {
    setState(() {
      salesamount = 0;
      balanceamountpurchase = 0;
      returnalltotal = 0;
      balancealltotal = 0;
    });
    if (status == true) {
      setState(() {
        salesamount = 0;
        balanceamountpurchase = 0;
      });
      var billingtotal = await FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {
        for (int i = 0; i < billingtotal.docs.length; i++) {
          if (mydate.contains(billingtotal.docs[i]["purchasedate"])) {
            setState(() {
              salesamount = salesamount +
                  double.parse(billingtotal.docs[i]["Totalamount"]);
              balanceamountpurchase = balanceamountpurchase +
                  billingtotal.docs[i]["balance amount"];
            }
            );
          }
        }
      } else {
        for (int i = 0; i < billingtotal.docs.length; i++) {
          setState(() {
            salesamount =
                salesamount + double.parse(billingtotal.docs[i]["Totalamount"]);
            balanceamountpurchase =
                balanceamountpurchase + billingtotal.docs[i]["balance amount"];
          });
        }
      }
    }
    else if (status2 == true) {
      var billingtotal = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {

        for (int i = 0; i < billingtotal.docs.length; i++) {
          if (mydate.contains(billingtotal.docs[i]["purchasedate"])) {
            setState(() {
              salesamount = salesamount +
                  double.parse(billingtotal.docs[i]["Totalamount"]);
              balanceamountpurchase = balanceamountpurchase +
                  billingtotal.docs[i]["balance amount"];
            });
          }
        }
      } else {
        for (int i = 0; i < billingtotal.docs.length; i++) {
          setState(() {
            salesamount =
                salesamount + double.parse(billingtotal.docs[i]["Totalamount"]);
            balanceamountpurchase =
                balanceamountpurchase + billingtotal.docs[i]["balance amount"];
          });
        }
      }
    }
    else {
      setState(() {
        salesamount = 0;
        balanceamountpurchase = 0;
      });
      var billingtotal = await FirebaseFirestore.instance
          .collection("Purchase entry")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {
        setState(() {
          salesamount = 0;
          balanceamountpurchase = 0;
        });
        for (int i = 0; i < billingtotal.docs.length; i++) {
          if (mydate.contains(billingtotal.docs[i]["purchasedate"])) {

            setState(() {
              salesamount = salesamount + double.parse(billingtotal.docs[i]["Totalamount"]);
              balanceamountpurchase = balanceamountpurchase +
                  billingtotal.docs[i]["balance amount"];
            });
          }
        }
      }
      else {
        for (int i = 0; i < billingtotal.docs.length; i++) {
          setState(() {
            salesamount = salesamount + double.parse(billingtotal.docs[i]["Totalamount"]);
            balanceamountpurchase =
                balanceamountpurchase + billingtotal.docs[i]["balance amount"];
          });
        }
      }
    }

    if(status == true) {
      setState(() {
        returnalltotal=0;
      });
      var doc1 = await FirebaseFirestore.instance.collection("Purchase ShabikaG")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {
      for (int i = 0; i < doc1.docs.length; i++) {
        if (mydate.contains(doc1.docs[i]["purchasedate"])) {
          var doc2 = await FirebaseFirestore.instance.collection(
              "Purchase ShabikaG")
              .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
              .get();

          for (int j = 0; j < doc2.docs.length; j++) {
            setState(() {

              returnalltotal = returnalltotal +
                  (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                      double.parse(doc2.docs[j]['Landing cost'].toString()));
            });
          }
        }
      }
      }
      else{
        setState(() {
          returnalltotal=0;
        });
        for (int i = 0; i < doc1.docs.length; i++) {

            var doc2 = await FirebaseFirestore.instance.collection(
                "Purchase ShabikaG")
                .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
                .get();

            for (int j = 0; j < doc2.docs.length; j++) {
              setState(() {
                returnalltotal = returnalltotal +
                    (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                        double.parse(doc2.docs[j]['Landing cost'].toString()));
              });
            }

        }
      }
      setState(() {
        balancealltotal = salesamount - returnalltotal;
      });
    }
    else if(status2 == true){
      setState(() {
        returnalltotal=0;
      });
      print("Shabika N ================++++++++++++++++++++++++++++++++++++");
      var doc1 = await FirebaseFirestore.instance.collection("Purchase ShabikaN")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {
        for (int i = 0; i < doc1.docs.length; i++) {
          if (mydate.contains(doc1.docs[i]["purchasedate"])) {
            var doc2 = await FirebaseFirestore.instance.collection(
                "Purchase ShabikaN")
                .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
                .get();

            for (int j = 0; j < doc2.docs.length; j++) {
              setState(() {
                returnalltotal = returnalltotal +
                    (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                        double.parse(doc2.docs[j]['Landing cost'].toString()));
              });
            }
          }
        }
      }
      else{
        setState(() {
          returnalltotal=0;
        });
        for (int i = 0; i < doc1.docs.length; i++) {

          var doc2 = await FirebaseFirestore.instance.collection(
              "Purchase ShabikaN")
              .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
              .get();

          for (int j = 0; j < doc2.docs.length; j++) {
            print(returnalltotal);

            print(double.parse(doc2.docs[j]['return Quvantity'].toString()));
            print("---------------------------------------------");
            setState(() {
              returnalltotal = returnalltotal +
                  (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                      double.parse(doc2.docs[j]['Landing cost'].toString()));
            });
          }

        }
      }
      setState(() {
        balancealltotal = salesamount - returnalltotal;
      });

    }
    else{
      setState(() {
        returnalltotal=0;
      });

      var doc1 = await FirebaseFirestore.instance.collection("Purchase entry")
          .where("save", isEqualTo: true)
          .get();
      if (mydate.isNotEmpty) {
        for (int i = 0; i < doc1.docs.length; i++) {
          if (mydate.contains(doc1.docs[i]["purchasedate"])) {
            var doc2 = await FirebaseFirestore.instance.collection(
                "Purchase entry")
                .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
                .get();

            for (int j = 0; j < doc2.docs.length; j++) {
              setState(() {
                returnalltotal = returnalltotal +
                    (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                        double.parse(doc2.docs[j]['Landing cost'].toString()));
              });
            }
          }
        }
      }
      else{
        setState(() {
          returnalltotal=0;
        });
        for (int i = 0; i < doc1.docs.length; i++) {

          var doc2 = await FirebaseFirestore.instance.collection(
              "Purchase entry")
              .doc(doc1.docs[i].id).collection(doc1.docs[i].id)
              .get();

          for (int j = 0; j < doc2.docs.length; j++) {
            setState(() {
              returnalltotal = returnalltotal +
                  (double.parse(doc2.docs[j]['return Quvantity'].toString()) *
                      double.parse(doc2.docs[j]['Landing cost'].toString()));
            });
          }

        }
      }
      setState(() {
        balancealltotal = salesamount - returnalltotal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: width / 10.06),
            //toggle switchs
            Padding(
              padding:
                  EdgeInsets.only(left: width / 4.583, right: width / 56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
                inactiveToggleColor: Colors.grey,
                width: width / 30.35,
                height: height / 32.85,
                valueFontSize: 5.0,
                toggleSize: 20.0,
                value: status,
                borderRadius: 10.0,
                padding: 2.0,
                //showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    if (val == true) {
                      setState(() {
                        status = val;
                        status2 = false;
                      });
                      billingtotalamount();
                    } else {
                      setState(() {
                        status = val;
                      });
                      billingtotalamount();
                    }
                  });
                },
              ),
            ),

            Text(
              "Shabika G",
              style: GoogleFonts.solway(
                  color: Colors.white, fontSize: width / 80.353),
            ),

            Padding(
              padding:
                  EdgeInsets.only(left: width / 45.583, right: width / 56.916),
              child: FlutterSwitch(
                inactiveColor: const Color(0xffC9C9C9),
                inactiveToggleColor: Colors.grey,
                width: width / 30.35,
                height: height / 32.85,
                valueFontSize: 5.0,
                toggleSize: 20.0,
                value: status2,
                borderRadius: 10.0,

                padding: 2.0,
                //showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    if (val == true) {
                      setState(() {
                        status2 = val;
                        status = false;
                      });
                      billingtotalamount();
                    } else {
                      setState(() {
                        status2 = val;
                      });
                      billingtotalamount();
                    }
                  });
                },
              ),
            ),

            Text(
              "Shabika N",
              style: GoogleFonts.solway(
                  color: Colors.white, fontSize: width / 80.353),
            ),
          ],
        ),
        SizedBox(
          height: height / 83.8,
        ),
        Row(
          children: [
            SizedBox(
              width: width / 200.8,
            ),
            Text(
              "Date",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 30.8,
            ),
            //textfield-1 fromdate
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "dd/mm/yyyy",
                  hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd/M/yyyy').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      year1 = pickedDate.year;
                      day1 = pickedDate.day;
                      month1 = pickedDate.month;
                      Datecontroller.text = formattedDate;
                      //set output date to TextField value.
                    });
                    DateTime startDate = DateTime.utc(year1, month1, day1);
                    DateTime endDate = DateTime.utc(year2, month2, day2);
                    getDaysInBetween() {
                      final int difference =
                          endDate.difference(startDate).inDays;
                      return difference+1;
                    }

                    final items =
                    List<DateTime>.generate(getDaysInBetween(), (i) {
                      DateTime date = startDate;
                      return date.add(Duration(days: i));
                    });
                    setState(() {
                      mydate.clear();
                    });
                    for (int i = 0; i < items.length; i++) {
                      setState(() {
                        isserach = true;
                        mydate.add(formatter.format(items[i]).toString());
                      });
                      print(mydate);
                      print("+++++++++++++++++++++++++++++++++++++++kkkk");
                      billingtotalamount();
                    }
                  } else {}
                },
              ),
            ),

            SizedBox(
              width: width / 91.066,
            ),

            //textfield-2 todate
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: TextField(
                controller: Datecontroller2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: width / 90.6, left: width / 91.06),
                  hintText: "dd/mm/yyyy",
                  hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                  border: InputBorder.none,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('dd/M/yyyy').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      year2 = pickedDate.year;
                      day2 = pickedDate.day;
                      month2 = pickedDate.month;
                      Datecontroller2.text = formattedDate;

                      //set output date to TextField value.
                    });
                    DateTime startDate = DateTime.utc(year1, month1, day1);
                    DateTime endDate = DateTime.utc(year2, month2, day2);
                    getDaysInBetween() {
                      final int difference =
                          endDate.difference(startDate).inDays;
                      return difference+1;
                    }

                    final items =
                        List<DateTime>.generate(getDaysInBetween(), (i) {
                      DateTime date = startDate;
                      return date.add(Duration(days: i));
                    });
                    setState(() {
                      mydate.clear();
                    });
                    for (int i = 0; i < items.length; i++) {
                      setState(() {
                        isserach = true;
                        mydate.add(formatter.format(items[i]).toString());
                      });
                      print(mydate);
                      print("+++++++++++++++++++++++++++++++++++++++kkkk");
                      billingtotalamount();
                    }
                  } else {}
                },
              ),
            ),

            SizedBox(
              width: width / 136.6,
            ),

            Text(
              "Supplier Name",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),

            Container(
              height: height / 21.9,
              width: width / 5.506, // width: width / 3.415,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: LayoutBuilder(
                builder: (BuildContext, BoxConstraints) => Autocomplete<String>(
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextFormField(
                      onChanged: (_) {
                        setState(() {
                          Suppilercontroller = textEditingController;
                        });
                      },
                      style: GoogleFonts.montserrat(
                          fontSize: width / 91.06, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              bottom: height / 43.8, left: width / 136.6)),
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                    );
                  },
                  initialValue: const TextEditingValue(
                      selection: TextSelection(
                    isDirectional: true,
                    baseOffset: 5,
                    extentOffset: 1,
                  )),
                  optionsViewBuilder: (context, onSelected, options) => Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(4.0)),
                        ),
                        child: SizedBox(
                          height: 52.0 * options.length,
                          width: BoxConstraints.biggest.width,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            shrinkWrap: false,
                            itemBuilder: (BuildContext, index) {
                              final String option = options.elementAt(index);
                              return InkWell(
                                onTap: () => onSelected(option),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }

                    return Suppilier.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    setState(() {
                      Suppilercontroller.text = selection;
                      isserach = true;
                      Username2 = selection;
                    });
                    debugPrint('You just selected $selection');
                  },
                  displayStringForOption: (Value) {
                    return Value;
                  },
                ),
              ),
            ),
            SizedBox(
              width: width / 136.6,
            ),
            //Status-1
            Text(
              "Invoice",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 136.6,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.106,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: LayoutBuilder(
                  builder: (BuildContext, BoxConstraints) =>
                      Autocomplete<String>(
                    initialValue: const TextEditingValue(
                      selection: TextSelection(
                        isDirectional: true,
                        baseOffset: 10,
                        extentOffset: 1,
                      ),
                    ),
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      return TextFormField(
                        onChanged: (_) {
                          setState(() {
                            Invoicecontroller = textEditingController;
                          });
                        },
                        style: GoogleFonts.montserrat(
                            fontSize: width / 91.06,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                bottom: height / 43.8, left: width / 136.6)),
                        controller: textEditingController,
                        focusNode: focusNode,
                        onFieldSubmitted: (String value) {
                          onFieldSubmitted();
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) => Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(4.0)),
                          ),
                          child: SizedBox(
                            height: 52.0 * options.length,
                            width: BoxConstraints.biggest.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              shrinkWrap: false,
                              itemBuilder: (BuildContext, index) {
                                final String option = options.elementAt(index);
                                return InkWell(
                                  onTap: () => onSelected(option),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(option),
                                  ),
                                );
                              },
                            ),
                          ),
                        )),
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return Invoice.where((String option) {
                        return option
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      setState(() {
                        Invoicecontroller.text = selection;
                        Status1 = selection;
                        isserach = true;
                        Username = selection;
                      });
                    },
                    displayStringForOption: (Value) {
                      return Value;
                    },
                  ),
                )),
            SizedBox(
              width: width / 136.6,
            ),

            SizedBox(
              width: width / 156.6,
            ),


            //Status-2
            Text(
              "Payment\nType",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.6,
            ),
            Container(
              height: height / 21.9,
              width: width / 9.106,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: DropdownButton2<String>(
                value: Paymentsmodevalue,
                isExpanded: true,
                isDense: true,
                alignment: Alignment.topCenter,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700, fontSize: width / 105.07),
                underline: Container(
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  setState(() {
                    Paymentsmodevalue = value!;
                    isserach = true;
                  });
                  // This is called when the user selects an item.
                  if (value == "Un Paid") {
                    setState(() {
                      Paymenttype.text = "Credit Amount";
                    });
                    print("PaymentChangevalue");
                    print(Paymenttype.text);
                    print(Paymentsmodevalue);
                    print(Suppilercontroller.text);
                    print(Invoicecontroller.text);
                    print(Datecontroller2.text);
                    print(Datecontroller.text);
                    print("++++++++++++++++++++++++++++++++++++++++++++++++++++");
                  } else {
                    setState(() {
                      Paymenttype.text = "Cash";
                    });
                    print("else");
                    print("Payments");
                    print(Paymenttype.text);
                  }
                },
                items:
                Paymentmode2.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: width / 150.8,
            ),

            InkWell(
              onTap: () {
                setState(() {
                  Invoicecontroller.clear();
                  Datecontroller.clear();
                  Datecontroller2.clear();
                  mydate.clear();
                  Suppilercontroller.clear();
                  Paymenttype.clear();
                  Status1 = "";
                  Status2 = "";
                  Status3 = "";
                  PaymentChangevalue = '';
                  Paymentsmodevalue = Paymentmode2.first;
                  isserach = false;
                  Username = '';
                  Username2 = '';
                });
                additemduntion();
                billingtotalamount();
              },
              child: Container(
                height: height / 21.9,
                width: width / 13.66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                child: Center(
                  child: Text(
                    "Clear",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: width / 84.64),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height / 83.8,
        ),
        Row(
          children: [

            SizedBox(
              width: width / 200.8,
            ),

            Text(
              "Total Amount",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                  salesamount.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 88.64),
                ))),
            SizedBox(
              width: width / 100.066,
            ),
            Text(
              "Returned Amount",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                      returnalltotal.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 88.64),
                    ))),
            SizedBox(
              width: width / 100.066,
            ),
            Text(
              "Current Balance",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 100.5,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                      balancealltotal.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: width / 88.64),
                    ))),
            SizedBox(
              width: width / 100.066,
            ),
            Text(
              "UnPaid Amount",
              textAlign: TextAlign.start,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width / 98.64),
            ),
            SizedBox(
              width: width / 236.6,
            ),
            Container(
                height: height / 21.9,
                width: width / 9.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                    child: Text(
                  balanceamountpurchase.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: width / 88.64),
                ))),
          ],
        ),
        SizedBox(
          height: height / 83.8,
        ),
        Container(
          height: height / 1.194,
          width: width / 1.050,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: height / 65.7,
                ),

                Row(
                  children: [
                    SizedBox(
                      width: width / 34.15,
                    ),

                    Container(
                        width: width / 10.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Date",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 10.507,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Bill No",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 15.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Invoice No",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 10.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Supplier ID",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 4.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Suppiler Name",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 10.66,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Payment Type",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        )
                        )
                    ),

                    Container(
                        width: width / 10.507,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Total",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    Container(
                        width: width / 6.507,
                        height: height / 13.14,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                            child: Text(
                          "Actions",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5801e8)),
                        ))),

                    //SizedBox(width:width/27.32,),
                  ],
                ),

                StreamBuilder<QuerySnapshot>(
                        stream: status == true
                            ? FirebaseFirestore.instance
                                .collection("Purchase ShabikaG")
                                .orderBy("timestamp", descending: true)
                                .snapshots()
                            : status2 == true
                                ? FirebaseFirestore.instance
                                    .collection("Purchase ShabikaN")
                                    .orderBy("timestamp", descending: true)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection("Purchase entry")
                                    .orderBy("timestamp", descending: true)
                                    .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData == null) {
                            return Center(child: Container());
                          }
                          if (!snapshot.hasData) {
                            return Center(child: Container());
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              print(mydate);
                              print(Paymentsmodevalue);

                              var buillin1 = snapshot.data!.docs[index];

                              if (isserach == true && buillin1['save'] == true) {
                                if (mydate.isNotEmpty &&
                                    Suppilercontroller.text == "" &&
                                    Invoicecontroller.text == "" &&
                                    Paymentsmodevalue == "Please Select") {
                                  if (mydate.contains(buillin1['purchasedate'].toString())) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: width / 34.15,
                                        ),
                                        Container(
                                            width: width / 10.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${buillin1['purchasedate'].toString()}",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ))),
                                        Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  buillin1['purchaseno']
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),

                                              ],
                                            )),
                                        Container(
                                            width: width / 15.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              buillin1['suppilierinvoiceno']
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                        Container(
                                            width: width / 10.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              buillin1['suppilerid'].toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                        Container(
                                            width: width / 4.66,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              buillin1['suppilername']
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            ))),
                                        Container(
                                            width: width / 10.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: buillin1['balance amount'] != 0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color: Colors.red),
                                                        child: Center(
                                                          child: Text(
                                                            "Unpaid",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          width: width / 13.66,
                                                          height: height / 21.9,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color:
                                                                  Colors.green),
                                                          child: Center(
                                                              child: Text(
                                                            "Paid",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                          ))),
                                                    ],
                                                  )),
                                        Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                    child: Text(
                                                      buillin1['Totalamount']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  )),
                                        Container(
                                            width: width / 6.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                //view button
                                                InkWell(
                                                  onTap: () {
                                                    checkqty(buillin1.id);
                                                  },
                                                  child: Material(
                                                    elevation: 10,
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                Colors.green),
                                                        child: Center(
                                                            child: Text(
                                                          "View",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                        ))),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: width / 136.6,
                                                ),
                                                //edit button
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditPage1_purchase(
                                                                  buillin1.id),
                                                        ));
                                                  },
                                                  child: Material(
                                                    elevation: 10,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Container(
                                                        width: width / 45.53,
                                                        height: height / 21.9,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .black,
                                                                size: width /
                                                                    68.3))),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                                }
                                else if(mydate.isNotEmpty &&
                                    Suppilercontroller.text == "" &&
                                    Invoicecontroller.text == "" &&
                                    Paymentsmodevalue != "Please Select") {
                                  if (mydate.contains(buillin1['purchasedate'].toString())) {

                                    if (Paymentsmodevalue == "Un Paid") {
                                      if (buillin1['balance amount'] != 0) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: width / 34.15,
                                            ),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      "${buillin1['purchasedate']
                                                          .toString()}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                      textAlign: TextAlign
                                                          .center,
                                                    ))),
                                            Container(
                                                width: width / 10.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      buillin1['purchaseno']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),

                                                  ],
                                                )),
                                            Container(
                                                width: width / 15.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilierinvoiceno']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilerid']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 4.66,
                                                height: height / 13.14,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width / 683,
                                                    vertical: height / 328.5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilername']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: buillin1['Payment mode'] ==
                                                    "Credit Amount"
                                                    ? Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          "Unpaid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                100),
                                                            color:
                                                            Colors.green),
                                                        child: Center(
                                                            child: Text(
                                                              "Paid",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ))),
                                                  ],
                                                )),
                                            Container(
                                                width: width / 10.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                  child: Text(
                                                    buillin1['Totalamount']
                                                        .toString(),
                                                    style:
                                                    GoogleFonts.montserrat(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                )),
                                            Container(
                                                width: width / 6.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    //view button
                                                    InkWell(
                                                      onTap: () {
                                                        checkqty(buillin1.id);
                                                      },
                                                      child: Material(
                                                        elevation: 10,
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        child: Container(
                                                            width: width /
                                                                13.66,
                                                            height: height /
                                                                21.9,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    100),
                                                                color: Colors
                                                                    .green),
                                                            child: Center(
                                                                child: Text(
                                                                  "View",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      color: Colors
                                                                          .white),
                                                                ))),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: width / 136.6,
                                                    ),
                                                    //edit button
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  EditPage1_purchase(
                                                                      buillin1
                                                                          .id),
                                                            ));
                                                      },
                                                      child: Material(
                                                        elevation: 10,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        child: Container(
                                                            width: width /
                                                                45.53,
                                                            height: height /
                                                                21.9,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100),
                                                            ),
                                                            child: Center(
                                                                child: Icon(
                                                                    Icons.edit,
                                                                    color:
                                                                    Colors
                                                                        .black,
                                                                    size: width /
                                                                        68.3))),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      }
                                    }
                                    else {
                                      if (buillin1['balance amount'] == 0) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                              width: width / 34.15,
                                            ),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      "${buillin1['purchasedate']
                                                          .toString()}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                      textAlign: TextAlign
                                                          .center,
                                                    ))),
                                            Container(
                                                width: width / 10.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      buillin1['purchaseno']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),

                                                  ],
                                                )),
                                            Container(
                                                width: width / 15.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilierinvoiceno']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilerid']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 4.66,
                                                height: height / 13.14,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width / 683,
                                                    vertical: height / 328.5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                    child: Text(
                                                      buillin1['suppilername']
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            Container(
                                                width: width / 10.66,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: buillin1['balance amount'] !=
                                                    0
                                                    ? Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          "Unpaid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                100),
                                                            color:
                                                            Colors.green),
                                                        child: Center(
                                                            child: Text(
                                                              "Paid",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ))),
                                                  ],
                                                )),
                                            Container(
                                                width: width / 10.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.2)),
                                                child: Center(
                                                  child: Text(
                                                    buillin1['Totalamount']
                                                        .toString(),
                                                    style:
                                                    GoogleFonts.montserrat(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                )),
                                            Container(
                                                width: width / 6.507,
                                                height: height / 13.14,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    //view button
                                                    InkWell(
                                                      onTap: () {
                                                        checkqty(buillin1.id);
                                                      },
                                                      child: Material(
                                                        elevation: 10,
                                                        color: Colors.green,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        child: Container(
                                                            width: width /
                                                                13.66,
                                                            height: height /
                                                                21.9,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    100),
                                                                color: Colors
                                                                    .green),
                                                            child: Center(
                                                                child: Text(
                                                                  "View",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      color: Colors
                                                                          .white),
                                                                ))),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: width / 136.6,
                                                    ),
                                                    //edit button
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  EditPage1_purchase(
                                                                      buillin1
                                                                          .id),
                                                            ));
                                                      },
                                                      child: Material(
                                                        elevation: 10,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        child: Container(
                                                            width: width /
                                                                45.53,
                                                            height: height /
                                                                21.9,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100),
                                                            ),
                                                            child: Center(
                                                                child: Icon(
                                                                    Icons.edit,
                                                                    color:
                                                                    Colors
                                                                        .black,
                                                                    size: width /
                                                                        68.3))),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      }
                                    }
                                  }
                                }

                                else if (buillin1['suppilername'].toString().toLowerCase().startsWith(Suppilercontroller.text.toLowerCase()) &&
                                        Invoicecontroller.text == "" &&
                                        Datecontroller.text == "" &&
                                        Datecontroller2.text == "" &&
                                    Paymentsmodevalue == "Please Select" ||
                                    buillin1['suppilierinvoiceno'].toString().toLowerCase().
                                    startsWith(Invoicecontroller.text.toLowerCase()) &&
                                        Suppilercontroller.text == "" &&
                                        Datecontroller.text == "" &&
                                        Paymentsmodevalue == "Please Select" &&
                                        Datecontroller2.text == "") {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: width / 34.15,
                                      ),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            "${buillin1['purchasedate'].toString()}",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ))),
                                      Container(
                                          width: width / 10.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                buillin1['purchaseno']
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),

                                            ],
                                          )),
                                      Container(
                                          width: width / 15.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilierinvoiceno']
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilerid'].toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 4.66,
                                          height: height / 13.14,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width / 683,
                                              vertical: height / 328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilername'].toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: buillin1['balance amount'] != 0
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          "Unpaid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                Colors.green),
                                                        child: Center(
                                                            child: Text(
                                                          "Paid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                        ))),
                                                  ],
                                                )),
                                      Container(
                                          width: width / 10.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                                  child: Text(
                                                    buillin1['Totalamount']
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                )),
                                      Container(
                                          width: width / 6.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //view button
                                              InkWell(
                                                onTap: () {
                                                  checkqty(buillin1.id);
                                                },
                                                child: Material(
                                                  elevation: 10,
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.green),
                                                      child: Center(
                                                          child: Text(
                                                        "View",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ))),
                                                ),
                                              ),

                                              SizedBox(
                                                width: width / 136.6,
                                              ),
                                              //edit button
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPage1_purchase(
                                                                buillin1.id),
                                                      ));
                                                },
                                                child: Material(
                                                  elevation: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                      width: width / 45.53,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black,
                                                              size: width /
                                                                  68.3))),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  );
                                }


                                else if (Paymentsmodevalue!="Please Select"
                                    && Suppilercontroller.text == "" &&
                                    Invoicecontroller.text == "" &&
                                    Datecontroller.text == "" &&
                                    Datecontroller2.text == "")
                                {

                                  if(Paymentsmodevalue=="Un Paid") {
                                    if(buillin1['balance amount']!=0) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: width / 34.15,
                                          ),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    "${buillin1['purchasedate']
                                                        .toString()}",
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                    textAlign: TextAlign.center,
                                                  ))),
                                          Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    buillin1['purchaseno']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),

                                                ],
                                              )),
                                          Container(
                                              width: width / 15.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilierinvoiceno']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilerid']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 4.66,
                                              height: height / 13.14,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width / 683,
                                                  vertical: height / 328.5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilername']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: buillin1['Payment mode'] ==
                                                  "Credit Amount"
                                                  ? Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width / 13.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            100),
                                                        color: Colors.red),
                                                    child: Center(
                                                      child: Text(
                                                        "Unpaid",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          color:
                                                          Colors.green),
                                                      child: Center(
                                                          child: Text(
                                                            "Paid",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ],
                                              )),
                                          Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                child: Text(
                                                  buillin1['Totalamount']
                                                      .toString(),
                                                  style:
                                                  GoogleFonts.montserrat(
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              )),
                                          Container(
                                              width: width / 6.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  //view button
                                                  InkWell(
                                                    onTap: () {
                                                      checkqty(buillin1.id);
                                                    },
                                                    child: Material(
                                                      elevation: 10,
                                                      color: Colors.green,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                      child: Container(
                                                          width: width / 13.66,
                                                          height: height / 21.9,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100),
                                                              color: Colors
                                                                  .green),
                                                          child: Center(
                                                              child: Text(
                                                                "View",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    color: Colors
                                                                        .white),
                                                              ))),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: width / 136.6,
                                                  ),
                                                  //edit button
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                EditPage1_purchase(
                                                                    buillin1
                                                                        .id),
                                                          ));
                                                    },
                                                    child: Material(
                                                      elevation: 10,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                      child: Container(
                                                          width: width / 45.53,
                                                          height: height / 21.9,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                          ),
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                  Colors.black,
                                                                  size: width /
                                                                      68.3))),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      );
                                    }
                                  }
                                  else{
                                    if(buillin1['balance amount']==0) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: width / 34.15,
                                          ),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    "${buillin1['purchasedate']
                                                        .toString()}",
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                    textAlign: TextAlign.center,
                                                  ))),
                                          Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    buillin1['purchaseno']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),

                                                ],
                                              )),
                                          Container(
                                              width: width / 15.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilierinvoiceno']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilerid']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 4.66,
                                              height: height / 13.14,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width / 683,
                                                  vertical: height / 328.5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                    buillin1['suppilername']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .montserrat(
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ))),
                                          Container(
                                              width: width / 10.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: buillin1['balance amount'] != 0
                                                  ? Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width / 13.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            100),
                                                        color: Colors.red),
                                                    child: Center(
                                                      child: Text(
                                                        "Unpaid",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              100),
                                                          color:
                                                          Colors.green),
                                                      child: Center(
                                                          child: Text(
                                                            "Paid",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ],
                                              )),
                                          Container(
                                              width: width / 10.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                child: Text(
                                                  buillin1['Totalamount']
                                                      .toString(),
                                                  style:
                                                  GoogleFonts.montserrat(
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              )),
                                          Container(
                                              width: width / 6.507,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  //view button
                                                  InkWell(
                                                    onTap: () {
                                                      checkqty(buillin1.id);
                                                    },
                                                    child: Material(
                                                      elevation: 10,
                                                      color: Colors.green,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                      child: Container(
                                                          width: width / 13.66,
                                                          height: height / 21.9,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  100),
                                                              color: Colors
                                                                  .green),
                                                          child: Center(
                                                              child: Text(
                                                                "View",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    color: Colors
                                                                        .white),
                                                              ))),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: width / 136.6,
                                                  ),
                                                  //edit button
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                EditPage1_purchase(
                                                                    buillin1
                                                                        .id),
                                                          ));
                                                    },
                                                    child: Material(
                                                      elevation: 10,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                      child: Container(
                                                          width: width / 45.53,
                                                          height: height / 21.9,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                          ),
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                  Colors.black,
                                                                  size: width /
                                                                      68.3))),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      );
                                    }
                                  }
                                }


                                else if (buillin1['suppilername'].toString().toLowerCase().startsWith(Suppilercontroller.text.toLowerCase()) &&
                                    buillin1['suppilierinvoiceno'].toString().toLowerCase().startsWith(Invoicecontroller.text.toLowerCase()) &&
                                    buillin1['Payment mode'].toString().toLowerCase().startsWith(PaymentChangevalue))
                                {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: width / 34.15,
                                      ),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            "${buillin1['purchasedate'].toString()}",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ))),
                                      Container(
                                          width: width / 10.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                buillin1['purchaseno']
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),

                                            ],
                                          )),
                                      Container(
                                          width: width / 15.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilierinvoiceno']
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilerid'].toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 4.66,
                                          height: height / 13.14,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width / 683,
                                              vertical: height / 328.5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: Center(
                                              child: Text(
                                            buillin1['suppilername'].toString(),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          ))),
                                      Container(
                                          width: width / 10.66,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child: buillin1['balance amount'] != 0
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          "Unpaid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: width / 13.66,
                                                        height: height / 21.9,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                Colors.green),
                                                        child: Center(
                                                            child: Text(
                                                          "Paid",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                        ))),
                                                  ],
                                                )),
                                      Container(
                                          width: width / 10.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2)),
                                          child:  Center(
                                                  child: Text(
                                                    buillin1['Totalamount']
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                )),
                                      Container(
                                          width: width / 6.507,
                                          height: height / 13.14,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //view button
                                              InkWell(
                                                onTap: () {
                                                  checkqty(buillin1.id);
                                                },
                                                child: Material(
                                                  elevation: 10,
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.green),
                                                      child: Center(
                                                          child: Text(
                                                        "View",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ))),
                                                ),
                                              ),

                                              SizedBox(
                                                width: width / 136.6,
                                              ),
                                              //edit button
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPage1_purchase(
                                                                buillin1.id),
                                                      ));
                                                },
                                                child: Material(
                                                  elevation: 10,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                      width: width / 45.53,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black,
                                                              size: width /
                                                                  68.3))),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  );
                                }

                              }

                              else if (isserach == false &&
                                  buillin1['save'] == true &&
                                  mydate.isEmpty) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: width / 34.15,
                                    ),
                                    Container(
                                        width: width / 10.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(
                                            child: Text(
                                          "${buillin1['purchasedate'].toString()}",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ))),
                                    Container(
                                        width: width / 10.507,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              buillin1['purchaseno'].toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            ),

                                          ],
                                        )),
                                    Container(
                                        width: width / 15.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(
                                            child: Text(
                                          buillin1['suppilierinvoiceno']
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),
                                        ))),
                                    Container(
                                        width: width / 10.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(
                                            child: Text(
                                          buillin1['suppilerid'].toString(),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),
                                        ))),
                                    Container(
                                        width: width / 4.66,
                                        height: height / 13.14,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 683,
                                            vertical: height / 328.5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: Center(
                                            child: Text(
                                          buillin1['suppilername'].toString(),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600),
                                        ))),
                                    Container(
                                        width: width / 10.66,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child: buillin1['balance amount'] != 0
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width / 13.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.red),
                                                    child: Center(
                                                      child: Text(
                                                        "Unpaid",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: width / 13.66,
                                                      height: height / 21.9,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: Colors.green),
                                                      child: Center(
                                                          child: Text(
                                                        "Paid",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ))),
                                                ],
                                              )),
                                    Container(
                                        width: width / 10.507,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.2)),
                                        child:  Center(
                                                child: Text(
                                                  buillin1['Totalamount']
                                                      .toString(),
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )),
                                    Container(
                                        width: width / 6.507,
                                        height: height / 13.14,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //view button
                                            InkWell(
                                              onTap: () {
                                                checkqty(buillin1.id);
                                              },
                                              child: Material(
                                                elevation: 10,
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                    width: width / 13.66,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.green),
                                                    child: Center(
                                                        child: Text(
                                                      "View",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                    ))),
                                              ),
                                            ),

                                            SizedBox(
                                              width: width / 136.6,
                                            ),
                                            //edit button
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditPage1_purchase(
                                                              buillin1.id),
                                                    ));
                                              },
                                              child: Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                    width: width / 45.53,
                                                    height: height / 21.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: Center(
                                                        child: Icon(Icons.edit,
                                                            color: Colors.black,
                                                            size:
                                                                width / 68.3))),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              }
                              return  Container();
                            },
                          );
                        },
                      )

              ],
            ),
          ),
        )
      ],
    );
  }

  int qty = 0;
  double Total = 0;
  String state = "";
  String invoice = "";
  String invoice_date = "";
  String creditdate = "";
  String Suppiler = "";
  String SGST = '';
  String CGST = "";
  String TotalAmount = "";
  String purchasenTotalAmount = "";
  String Amounttype = "";
  String getcreditdays = "";

  checkqty(streamid) async {
    setState(() {
      qty = 0;
      Total = 0;
      soldtotal= 0;
      returnedtotal= 0;
      balancetotal= 0;
      viewalltotal= 0;
    });





    var document = await FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .get();
    Map<String, dynamic>? values = document.data();
    setState(()
    {
      invoice = values!['purchaseno'].toString();
      invoice_date = values['purchasedate'].toString();
      creditdate = values['purchasedate'].toString();
      Suppiler = values['suppilername'].toString();
      Amounttype = values['Payment mode'].toString();
      balanceamount = double.parse(values['balance amount'].toString());
      values['credit days'] == "" ? getcreditdays = "0" : getcreditdays = values['credit days'].toString();
      SGST = double.parse(values['SGST'].toString()).toStringAsFixed(2);
      CGST = double.parse(values['CGST'].toString()).toStringAsFixed(2);
      TotalAmount = double.parse(values['Totalamount'].toString()).toStringAsFixed(2);
      purchasenTotalAmount = double.parse(values['Total'].toString()).toStringAsFixed(2);
      creaditupdatedate=values['credit date'];
     // state = values['state'];
      // if (values['Payment mode'] == "Credit Amount"&&values['credit days']!="") {
      //   Changedate = DateTime(year, month, day).add(Duration(days: int.parse(values['credit days'].toString()))).toString();
      //   formattedDate = DateFormat('d/MM/yyyy').format(DateTime.parse(Changedate));
      // }
    }
    );


    var documents = await FirebaseFirestore.instance.collection("Purchase entry").doc(streamid).collection(streamid).get();
    for (int i = 0; i < documents.docs.length; i++) {
      setState(() {
        Total = (Total + double.parse(documents.docs[i]['Total'].toString()));
        qty = (qty + int.parse(documents.docs[i]['Qty'].toString()));
        // TotalAmount=(Total+double.parse(SGST)+double.parse(CGST)).toString();
        soldtotal= soldtotal + ((((double.parse(documents.docs[i]['Qty'].toString())-double.parse(documents.docs[i]['stocks'].toString()))-double.parse(documents.docs[i]['return Quvantity'].toString())) * double.parse(documents.docs[i]['Landing cost'].toString())));
        returnedtotal= returnedtotal + (double.parse(documents.docs[i]['return Quvantity'].toString()) * double.parse(documents.docs[i]['Landing cost'].toString()));
        balancetotal= balancetotal + (double.parse(documents.docs[i]['stocks'].toString()) * double.parse(documents.docs[i]['Landing cost'].toString()));
        viewalltotal= viewalltotal + (double.parse(documents.docs[i]['stocks'].toString()) * double.parse(documents.docs[i]['Landing cost'].toString()));
      });
    }

    if (status2 == true) {
      var document = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .get();
      Map<String, dynamic>? values = document.data();
      setState(() {
        invoice = values!['purchaseno'].toString();
        invoice_date = values['purchasedate'].toString();
        Suppiler = values['suppilername'].toString();
        Amounttype = values['Payment mode'].toString();
        values['credit days'] == ""
            ? getcreditdays = "0"
            : getcreditdays = values['credit days'].toString();
        values['balance amount'] == 0
            ? balanceamount = double.parse(values['Totalamount'].toString())
            : balanceamount = values['balance amount'];
        SGST = double.parse(values['SGST'].toString()).toStringAsFixed(2);
        CGST = double.parse(values['CGST'].toString()).toStringAsFixed(2);
        TotalAmount =
            double.parse(values['Totalamount'].toString()).toStringAsFixed(2);
        purchasenTotalAmount =
            double.parse(values['Total'].toString()).toStringAsFixed(2);
       // state = values['state'];
        if (values['Payment mode'] == "Credit Amount" &&
            values['credit days'] != "") {
          Changedate = DateTime(year, month, day)
              .add(Duration(days: int.parse(values['credit days'].toString())))
              .toString();
          creaditupdatedate=values['credit date'];
          formattedDate =
              DateFormat('d/MM/yyyy').format(DateTime.parse(Changedate));
        }
      });

      var documents = await FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .collection(streamid)
          .get();
      for (int i = 0; i < documents.docs.length; i++) {
        setState(() {
          Total = (Total + double.parse(documents.docs[i]['Total'].toString()));
          qty = (qty + int.parse(documents.docs[i]['Qty'].toString()));
        });
      }
    }
    histotytotal(streamid);

    showdialpogbox(streamid);

  }
  double returnalltotal=0;
  double balancealltotal=0;


  //edit textediticontroller
  TextEditingController Purchasename = TextEditingController();
  TextEditingController Purchasedate = TextEditingController();
  TextEditingController Suppilerid = TextEditingController();
  TextEditingController Suppilername = TextEditingController();
  TextEditingController Hsncode = TextEditingController();
  TextEditingController Payment = TextEditingController();
  TextEditingController Totalamount = TextEditingController();

  //get the purchase entry collection
  getvalur(docid) async {
    var getdate = await FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(docid)
        .get();
    Map<String, dynamic>? value = getdate.data();
    setState(() {
      Purchasename.text = value!["purchaseno"];
      Purchasedate.text = value["purchasedate"];
      Suppilerid.text = value["suppilerid"];
      Suppilername.text = value["suppilername"];
      Hsncode.text = value["Hsncode"];
      Payment.text = value["Payment mode"];
      Totalamount.text = value["Total"];
    });
  }

  clearallcontrolle1() {
    Purchasename.clear();
    Purchasedate.clear();
    Suppilerid.clear();
    Suppilername.clear();
    Hsncode.clear();
    Payment.clear();
    Totalamount.clear();
  }

  clearallcontrolle2() {
    Decription.clear();
    Hsncode2.clear();
    Quvantity.clear();
    Rate.clear();
    Tax.clear();
    Amount.clear();
  }

  ///edit popup dialog

  showtextfield(docid) {
    getvalur(docid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
                left: width / 13.66,
                right: width / 13.66,
                top: height / 66.7,
                bottom: height / 66.7),
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  height: height / 1.095,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height / 45.53),
                        Text(
                          "Edit the Purchase Reports",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: height / 45.53),
                        Padding(
                          padding: EdgeInsets.only(left: width / 6.83),
                          child: SizedBox(
                              height: height / 1.728,
                              child: Column(
                                children: [
                                  //invoice no
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Invoice No",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Purchasename,
                                                decoration: InputDecoration(
                                                  hintText: "Enter the IMEI NO",
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //purchase date
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Purchase Date",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Purchasedate,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //Suppiler  no
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Suppiler ID",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Suppilerid,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //Suppiler  name
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Suppiler Name",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Suppilername,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //hsn code
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Hsn No",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Hsncode,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //Payment
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Payment",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Payment,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),

                                  //Total amount
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 341.5,
                                        vertical: height / 164.25),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: width / 11.38,
                                            child: Text(
                                              "Total",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(width: width / 136.6),
                                        Material(
                                            color: Colors.white,
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: Container(
                                              height: height / 16.425,
                                              width: width / 4.55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey.shade200),
                                              child: TextField(
                                                style: GoogleFonts.montserrat(),
                                                controller: Totalamount,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: width / 136.6),
                                                  hintStyle:
                                                      GoogleFonts.montserrat(),
                                                ),
                                                onSubmitted: (_) {},
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            editfunction(docid);
                            checkqty(docid);
                            Navigator.pop(context);
                          },
                          child: Material(
                            elevation: 15,
                            color: const Color(0xff25D366),
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: height / 16.425,
                              width: width / 7.588,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff25D366),
                              ),
                              child: Center(
                                child: Text("Okay",
                                    style: GoogleFonts.poppins(
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 85.375,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  ///editpopup2 textediting controller

  TextEditingController Decription = TextEditingController();
  TextEditingController Hsncode2 = TextEditingController();
  TextEditingController Quvantity = TextEditingController();
  TextEditingController Rate = TextEditingController();
  TextEditingController Tax = TextEditingController();
  TextEditingController Amount = TextEditingController();

  //get2 the purchase entry collection
  getvalur2(streamid, docid) async {
    var getdate = await FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .collection(streamid)
        .doc(docid)
        .get();
    Map<String, dynamic>? value = getdate.data();
    setState(() {
      Decription.text = value!["Description"];
      Hsncode2.text = value["Hsncode"];
      Quvantity.text = value["Qty"];
      Rate.text = value["Landing cost"];
      Tax.text = value["tax"];
      Amount.text = value["Total"];
    });
  }

  //edit function-2
  editfunction2(streamid, docid) {
    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .collection(streamid)
        .doc(docid)
        .update({
      "Description": Decription.text,
      "Hsncode": Hsncode2.text,
      "Qty": Quvantity.text,
      "Landing cost": Rate.text,
      "tax": Tax.text,
      "Total": Amount.text,
    });
  }

  //edit2 popup dialog
  showtextfield2(stremdocid, docid) {
    getvalur2(stremdocid, docid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
                left: width / 13.66,
                right: width / 13.66,
                top: height / 65.7,
                bottom: height / 65.7),
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  height: height / 1.095,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height / 131.4,
                      ),
                      Text(
                        "Edit the Purchase Reports",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height / 131.4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 6.83),
                        child: SizedBox(
                            height: height / 1.728,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "Description",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Decription,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "HSN code",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Hsncode2,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "Quantity",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Quvantity,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "Rate",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Rate,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "Tax",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Tax,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),

                                //Total amount
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 341.5,
                                      vertical: height / 164.25),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: width / 11.38,
                                          child: Text(
                                            "Total",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(width: width / 136.6),
                                      Material(
                                          color: Colors.white,
                                          elevation: 20,
                                          shadowColor: Colors.black12,
                                          child: Container(
                                            height: height / 16.425,
                                            width: width / 4.55,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey.shade200),
                                            child: TextField(
                                              style: GoogleFonts.montserrat(),
                                              controller: Amount,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(
                                                    left: width / 136.6),
                                                hintStyle:
                                                    GoogleFonts.montserrat(),
                                              ),
                                              onSubmitted: (_) {},
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          editfunction2(stremdocid, docid);
                          checkqty(docid);
                          Navigator.pop(context);
                        },
                        child: Material(
                          elevation: 15,
                          color: const Color(0xff25D366),
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: height / 16.425,
                            width: width / 7.588,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff25D366),
                            ),
                            child: Center(
                              child: Text("Okay",
                                  style: GoogleFonts.poppins(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 85.375,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  editfunction(docid) {
    FirebaseFirestore.instance.collection("Purchase entry").doc(docid).update({
      "purchaseno": Purchasename.text,
      "purchasedate": Purchasedate.text,
      "suppilerid": Suppilerid.text,
      "suppilername": Suppilername.text,
      "Hsncode": Hsncode.text,
      "Payment mode": Payment.text,
      "Total": Totalamount.text,
    });
  }

  ///purchase details popup
  quvanotysolddunction(quvantity, stocks, retrun) {
    return (quvantity - stocks) - retrun;
  }
double soldtotal=0;
double returnedtotal=0;
double balancetotal=0;
double viewalltotal=0;
  showdialpogbox(streamid) {
    setState(() {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        bool testBool = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 136.6,
                      bottom: height / 136.6,
                      left: width / 45.53,
                      right: width / 45.53),
                  child: Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width / 2.4,
                                ),
                                Text(
                                  "Purchase Details",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width / 2.4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: ClipOval(
                                    child: Container(
                                      height: height / 26.28,
                                      width: width / 54.64,
                                      color: Colors.red,
                                      child: const Center(
                                          child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: width / 200.6,
                                ),
                                SizedBox(
                                  height: height / 21.9,
                                  width: width / 9.106,
                                  child: Center(
                                      child: Text(
                                    "Invoice: ${invoice.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                SizedBox(
                                  height: height / 21.9,
                                  width: width / 9.106,
                                  child: Center(
                                      child: Text(
                                    "Date: ${invoice_date.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                SizedBox(
                                  //height:height/ 21.9,
                                  width: width / 6.83,
                                  child: Center(
                                      child: Text(
                                    "Supplier Name: ${Suppiler.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),

                                Amounttype == "Credit Amount"
                                    ? Container(
                                        height: height / 21.9,
                                        width: width / 4.58,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff313866),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Date To Be Paid :  ${creaditupdatedate.toString()}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width / 136.6,
                                ),
                                Container(
                                  width: width / 27.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Si.No",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Date\nTime",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 17.075,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Item Code",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 3.54,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Description',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 22.76,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Hsn\nCode',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Payment',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 45.53,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Qty",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Purchase\nPrice',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Landing\nCost',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.66,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Sales\nPrice',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 27.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Tax',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  width: width / 10.507,
                                  child: Center(
                                      child: Text(
                                    "Total",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                SizedBox(
                                  width: width / 136.6,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 1.56,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Purchase entry")
                                    .doc(streamid)
                                    .collection(streamid).orderBy("timestamp")
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
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var purchase = snapshot.data!.docs[index];
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width / 136.6,
                                          ),
                                          Container(
                                            width: width / 27.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${purchase['date']}\n${purchase['time']}"
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 17.075,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${purchase['itemcode']}",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width / 3.54,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  purchase['Description']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ),
                                               /* Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "Sold item : ${quvanotysolddunction(int.parse(purchase['Qty'].toString()), purchase['stocks'], purchase['return Quvantity'])}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    SizedBox(
                                                        width: width / 273.72),
                                                    Text(
                                                      "Balance item : ${purchase['stocks']}",
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),*/
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width / 22.76,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Hsncode'].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Payment mode']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 45.53,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase["Qty"].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Purchase price']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Landing cost']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.66,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Sales price']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 27.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['tax'].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            width: width / 10.507,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${purchase['Total']}".toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width / 50.32,
                                ),

                                Column(
                                  children: [
                                    // showallitemapopup(streamid)
                                    GestureDetector(
                                      onTap: () {
                                        showallitemapopup(streamid);
                                      },
                                      child: Container(
                                        height: height / 21.9,
                                        width: width / 9.7,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green),
                                        child: Center(
                                            child: Text("View All",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: width / 91.06))),
                                      ),
                                    ),
                                    SizedBox(height: height / 65.7),

                                    Container(
                                      height: height / 21.9,
                                      width: width / 7.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey.shade200),
                                      child: Center(
                                        child: status2 == true
                                            ? Text(
                                                "Sub Total: ${purchasenTotalAmount.toString()}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigoAccent,
                                                    fontSize: width / 91.06))
                                            : Text(
                                                "Sub Total: ${Total.toStringAsFixed(2)}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigoAccent,
                                                    fontSize: width / 91.06)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width / 170.75),

                                Column(
                                  children: [


                                    Container(
                                      height: height / 21.9,
                                      width: width / 9.7,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff128c7e)),
                                      child: Center(
                                        child: Text("Sold Cost: ${soldtotal.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    SizedBox(height: height / 65.7),
                                    Container(
                                      height: height / 21.9,
                                      width: width / 9.7,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade200),
                                      child: Center(
                                        child: Text("SGST(9%): ${SGST.toString()}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  width: width / 68.3,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: height / 21.9,
                                      width: width / 9.7,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff128c7e)),
                                      child: Center(
                                        child: Text("Return Cost: ${returnedtotal.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    SizedBox(height: height / 65.7),
                                    Container(
                                      height: height / 21.9,
                                      width: width / 9.7,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade200),
                                      child: Center(
                                        child: Text("CGST(9%): ${CGST.toString()}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width / 170.75),

                                Column(
                                  children: [
                                    Container(
                                      height: height / 21.9,
                                      width: width / 6.83,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff128c7e)),
                                      child: Center(
                                        child: Text("Balance Cost: ${balancetotal.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    SizedBox(height: height / 65.7),
                                    Container(
                                      height: height / 21.9,
                                      width: width / 6.83,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade200),
                                      child: Center(
                                        child: Text(
                                            "Total: ${TotalAmount.toString()}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: width / 75.88)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width / 170.75),

                                //payed
                                Amounttype == "Credit Amount"
                                    ? Container(
                                        height: height / 21.9,
                                        width: width / 8.83,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0xff128c7e)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                             Text("Payed : ${(double.parse(TotalAmount.toString())-double.parse(balanceamount.toString())).toString()}",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize:
                                                            width / 85.375,
                                                        textStyle: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis))),
                                          ],
                                        ))
                                    : const SizedBox(),
                                SizedBox(width: width / 170.75),

                                //balance
                                Amounttype == "Credit Amount"
                                    ? Container(
                                        height: height / 21.9,
                                        width: width / 8.83,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0xff25d366)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("Balance : ${balanceamount.toStringAsFixed(2)}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: width / 85.375,
                                                    textStyle: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis))),
                                          ],
                                        ))
                                    : const SizedBox(),
                                SizedBox(width: width / 170.75),

                                //Pay Now
                                balanceamount != 0
                                    ? GestureDetector(
                                        onTap: () {
                                          Payedpopup(streamid);
                                        },
                                        child: Container(
                                          height: height / 21.9,
                                          width: width / 11.83,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color(0xff34b7f1)),
                                          child: Center(
                                            child: Text("Pay Now",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: width / 85.375,
                                                )),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(width: width / 170.75),

                                Amounttype == "Credit Amount"
                                    ? GestureDetector(
                                        onTap: () {
                                          showpaymenthistroypopup(streamid);
                                        },
                                        child: Container(
                                          height: height / 21.9,
                                          width: width / 11.83,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color(0xff322653)),
                                          child: Center(
                                            child: Text("Histroy",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: width / 85.375,
                                                )),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            SizedBox(height: height / 25.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  /// payment histoey popup
  ///
  ///
  histotytotal(streamid) async {
    setState(() {
      hisbalanceamount=0;
    });
    var document= await FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .collection("Payment Histroy").orderBy("timstamp",descending: true).get();
print("sddfd---------------------------------------------");
    for(int i=0;i<document.docs.length;i++)
      {
        setState(() {

        hisbalanceamount=document.docs[i]['discount'].toString()!=""&&document.docs[i]['discount'].toString()!=" "?
        (hisbalanceamount + double.parse(document.docs[i]['discount'].toString()) + double.parse(document.docs[i]['Amount'].toString())) : hisbalanceamount +double.parse(document.docs[i]['Amount']);
        });

        }
    //showpaymenthistroypopup(streamid);
  }

  showpaymenthistroypopup(streamid) {
    setState(() {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        bool testBool = true;
        return StatefulBuilder(
          builder: (context, setState) {

            return SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 110.6,
                      bottom: height / 110.6,
            left: width / 45.53,
            right: width / 45.53),
                  child: Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 8.4,
                                ),
                                Text(
                                  "Purchase History Payment Details",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: width / 40.4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ClipOval(
                                      child: Container(
                                        height: height / 26.28,
                                        width: width / 54.64,
                                        color: Colors.red,
                                        child: const Center(
                                            child: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 65.7,
                            ),
                            Row(
                              children: [
                                SizedBox(width: width / 136.6),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Si.No",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Date\nTime",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Credit\nDate',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 13.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Extra Credit\nDays',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Payment Mode',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Amount Paid',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Discount',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),
                                Container(
                                  width: width / 6.32,
                                  height: height / 13.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.2),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Total',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff5801e8)),
                                  )),
                                ),

                                SizedBox(
                                  width: width / 136.6,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 1.46,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Purchase entry")
                                    .doc(streamid)
                                    .collection("Payment Histroy").orderBy("timstamp",descending: true)
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
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var purchase = snapshot.data!.docs[index];
                                      return Row(
                                        children: [
                                          SizedBox(width: width / 136.6),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              "${purchase['Date']}\n${purchase['time']}"
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child:
                                                //${purchase['credit date']}
                                                Center(
                                              child: Text(
                                                purchase['credit date'],
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width / 13.32,
                                            height: height / 13.14,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width / 683,
                                                vertical: height / 328.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                // purchase['credit days'].toString()

                                                child: Text(
                                              purchase['credit days']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  textStyle: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['payment mode']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['Amount'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                              purchase['discount'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                          Container(
                                            width: width / 6.32,
                                            height: height / 13.14,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.2)),
                                            child: Center(
                                                child: Text(
                                                  purchase['discount'].toString()!=""&&purchase['discount'].toString()!=" "?
                                      (double.parse(purchase['discount'].toString()) + double.parse(purchase['Amount'].toString())).toString(): purchase['Amount'].toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: height / 21.9,
                                    width: width / 7.83,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: const Color(0xff25d366)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text("Total : ${hisbalanceamount.toStringAsFixed(2)}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: width / 85.375,
                                                textStyle: const TextStyle(
                                                    overflow: TextOverflow
                                                        .ellipsis))),
                                      ],
                                    )),
                                SizedBox(width: 10,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  TextEditingController Amounts = TextEditingController();
  TextEditingController Amountstopay = TextEditingController();
  TextEditingController balancepay = TextEditingController();
  TextEditingController creditdat = TextEditingController();
  TextEditingController Payment_detatils_Date = TextEditingController();
  TextEditingController Payment_detatils_Time = TextEditingController();
  TextEditingController Discountbalnce = TextEditingController();

  Payedpopup(streamid) {
    setState(() {
      Amountstopay.text = balanceamount.toStringAsFixed(2);
      Payment_detatils_Date.text = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      Payment_detatils_Time.text = DateFormat.jm().format(DateTime.now());
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(top: height / 8.4, bottom: height / 18.4),
              child: SlideInLeft(
                animate: true,
                duration: const Duration(milliseconds: 800),
                manualTrigger: false,
                child: AlertDialog(
                    backgroundColor: const Color(0xff264656),
                    content: SizedBox(
                      width: width / 3.902,
                      height: 700,
                      child: Column(
                        children: [
                          Text(
                            "Payment Details..",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width / 68.30,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 120.85,
                          ),
                          //amount to payed
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Total Amount:",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: Amountstopay,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //AMount
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Amount",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: Amounts,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                    onSubmitted: (_) {
                                      setState(() {
                                        balancepay.text = (balanceamount -
                                                double.parse(Amounts.text))
                                            .abs()
                                            .toStringAsFixed(2);
                                        balanceamount = (balanceamount -
                                                double.parse(Amounts.text))
                                            .abs();
                                        Payedamount =
                                            double.parse(Amounts.text).abs();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),
                          //discount
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Discount",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    onSubmitted: (val){
            setState(() {
              balancepay.text = (balanceamount -
                  double.parse(Discountbalnce.text))
                  .abs()
                  .toStringAsFixed(2);
              balanceamount = (balanceamount -
                  double.parse(Discountbalnce.text))
                  .abs();
            });
                                    },
                                    controller: Discountbalnce,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //balance to pay
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Balance",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: balancepay,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //Credit day
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Extra Credit days",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: creditdat,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //Payment MOde
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Payment Mode",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: DropdownButton2<String>(
                                    value: Payments2,
                                    isExpanded: true,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 105.07),
                                    underline: Container(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        Payments2 = value!;
                                      });
                                    },
                                    items: Paymentmode3.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: height / 65.7,
                          ),

                          //Date TextField
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Date ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: Payment_detatils_Date,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 65.7,
                          ),

                          //Time TextField
                          Row(
                            children: [
                              SizedBox(
                                  width: width / 8.83,
                                  child: Text(
                                    "Time ",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )),
                              SizedBox(
                                height: height / 136.6,
                              ),
                              Material(
                                shadowColor: Colors.indigo,
                                elevation: 25,
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                child: Container(
                                  height: height / 18.14,
                                  width: width / 7.83,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: Payment_detatils_Time,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: width / 130.6)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 40.7,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  print("Pay now button pressed");
                                    printdate(streamid);

                                },
                                child: Material(
                                  elevation: 15,
                                  color: const Color(0xff25D366),
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: height / 16.425,
                                    width: width / 9.588,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xff25D366),
                                    ),
                                    child: Center(
                                      child: Text("Okay",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width / 85.375,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width / 68.3),
                              InkWell(
                                onTap: () {
                                  Amounts.clear();
                                  Amountstopay.clear();
                                  balancepay.clear();
                                  creditdat.clear();
                                  Payment_detatils_Date.clear();
                                  Payment_detatils_Time.clear();
                                  setState(() {
                                    balanceamount = 0;
                                    Payments = Paymentmode.first;
                                  });
                                  print("POP");
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
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text("Cancel",
                                          style: GoogleFonts.poppins(
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width / 85.375,
                                              color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            );
          },
        );
      },
    );
  }

  String Changedate = "";
  double balanceamount = 0;
  double hisbalanceamount = 0;
  double Payedamount = 0;
  String creaditupdatedate = "";
  String formattedDate = '';

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  String billtype ="";

  printdate(streamid) async {
    print("Pay now called");
    print(streamid);
   var testdoc= await FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid).get();

   Map<String, dynamic>? val = testdoc.data();
   setState(() {
     billtype=val!["type"];
   });
    var date = DateTime.now();
    var newDate=DateTime.now();
    if(creditdat.text!=""&&creditdat.text!=" ") {
      print("Pay now has credit day");
      setState(() {
        newDate = DateTime(date.year, date.month, date.day + int.parse(creditdat.text));
      });

    }

    print("Pay now work started");

    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .update({
      "credit days": creditdat.text,
      "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
      "balance amount": balanceamount,
    });
    print("Pay now work started");
    FirebaseFirestore.instance
        .collection("Purchase entry")
        .doc(streamid)
        .collection("Payment Histroy")
        .doc()
        .set({
      "credit days": creditdat.text,
      "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
      "balance amount": balanceamount,
      "Amount": Payedamount.toString(),
      "Date": Payment_detatils_Date.text,
      "time": Payment_detatils_Time.text,
      "payment mode": Payments2,
      "discount": Discountbalnce.text,
      "timstamp": DateTime.now().millisecondsSinceEpoch,
    });
    print("Pay now work started++++++++++++++++++++++++++");
    if (billtype == "ShabikaG") {
      print("Pay now -2 ${balanceamount}");
      FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .doc(streamid)
          .update({
        "credit days": creditdat.text,
        "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
        "balance amount": balanceamount,
      });

      FirebaseFirestore.instance
          .collection("Purchase ShabikaG")
          .doc(streamid)
          .collection("Payment Histroy")
          .doc()
          .set({
        "credit days": creditdat.text,
        "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
        "balance amount": balanceamount,
        "Amount": Payedamount.toString(),
        "Date": Payment_detatils_Date.text,
        "time": Payment_detatils_Time.text,
        "payment mode": Payments,
        "discount": Discountbalnce.text,
        "timstamp": DateTime.now().millisecondsSinceEpoch,
      });
    }
    if (billtype == "ShabikaN") {
      print("Pay now -3 ${balanceamount}");
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .update({
        "credit days": creditdat.text,
        "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
        "balance amount": balanceamount,
      });
      FirebaseFirestore.instance
          .collection("Purchase ShabikaN")
          .doc(streamid)
          .collection("Payment Histroy")
          .doc()
          .set({
        "credit days": creditdat.text,
        "credit date": "${newDate.day}/${newDate.month}/${newDate.year}",
        "balance amount": balanceamount,
        "Amount": Payedamount.toString(),
        "Date": Payment_detatils_Date.text,
        "time": Payment_detatils_Time.text,
        "payment mode": Payments,
        "discount": Discountbalnce.text,
        "timstamp": DateTime.now().millisecondsSinceEpoch,
      });
    }

    Amounts.clear();
    Amountstopay.clear();
    balancepay.clear();
    creditdat.clear();
    Payment_detatils_Date.clear();
    Payment_detatils_Time.clear();
    setState(() {
      balanceamount = 0;
      Payments = Paymentmode.first;
    });
    print("POP");
    Navigator.pop(context);
   Navigator.pop(context);
    billingtotalamount();
  }

  //payment invalid popup
  showdialpogboxsss() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(top: height / 4.761, bottom: height / 4.761),
          child: SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: AlertDialog(
                backgroundColor: const Color(0xff264656),
                content: SizedBox(
                  width: width / 3.902,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Text(
                        "Please Fill the Payment Mode",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width / 68.30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      SizedBox(
                        height: height / 4.38,
                        width: width / 9.106,
                        child: Lottie.asset("assets/animation_lkc5owo7.json",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: height / 32.85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Material(
                              elevation: 15,
                              color: const Color(0xff25D366),
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: height / 16.425,
                                width: width / 9.588,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff25D366),
                                ),
                                child: Center(
                                  child: Text("Okay",
                                      style: GoogleFonts.poppins(
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width / 85.375,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width / 68.3),
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
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text("Cancel",
                                      style: GoogleFonts.poppins(
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width / 85.375,
                                          color: Colors.black)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  ///all items show popup
  showallitemapopup(streamid) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return showDialog(
      context: context,
      builder: (context) {
        return SlideInLeft(
            animate: true,
            duration: const Duration(milliseconds: 800),
            manualTrigger: false,
            child: Padding(
              padding: EdgeInsets.only(
                  top: height / 136.6,
                  bottom: height / 136.6,
                  left: width / 45.53,
                  right: width / 45.53),
              child: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 65.7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 2.4,
                            ),
                            Text(
                              "Purchase Details",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: width / 2.4,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ClipOval(
                                child: Container(
                                  height: height / 26.28,
                                  width: width / 54.64,
                                  color: Colors.red,
                                  child: const Center(
                                      child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 65.7,
                        ),
                        SizedBox(
                            height: 550,
                            child: Column(
                              children: [
                                SizedBox(height: height / 65.7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("View all Items",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                SizedBox(height: height / 65.7),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    CircleAvatar(
                                      radius: 8,
                                      foregroundColor: Colors.pink,
                                      backgroundColor: Colors.pink,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Return",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      foregroundColor: Colors.red,
                                      backgroundColor: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Sold",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      radius: 8,
                                      foregroundColor: Colors.green,
                                      backgroundColor: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Balance",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(height: height / 65.7),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 136.6,
                                    ),
                                    Container(
                                      width: width / 27.32,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Si.No",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 13.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Date\nTime",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 17.075,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Item Code",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 5.54,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Description',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 22.76,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Hsn\nCode',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 16.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Payment',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 45.53,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Qty",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 25.53,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Sold",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )
                                      ),
                                    ),
                                    Container(
                                      width: width / 20.53,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Balance",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 25.53,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Return",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 17.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Purchase\nPrice',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 17.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Landing\nCost',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 17.66,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Sales\nPrice',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      width: width / 27.32,
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Tax',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      width: width / 17.66,
                                      child: Center(
                                          child: Text(
                                        "Total",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    Container(
                                      height: height / 13.14,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.2),
                                      ),
                                      width: width / 17.66,
                                      child: Center(
                                          child: Text(
                                        "Balance\nAmount",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff5801e8)),
                                      )),
                                    ),
                                    SizedBox(
                                      width: width / 136.6,
                                    ),
                                  ],
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Purchase entry")
                                      .doc(streamid)
                                      .collection(streamid).orderBy("timestamp")
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
                                      physics: const ScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var purchase =
                                            snapshot.data!.docs[index];
                                        return
                                            //    int.parse(purchase['Qty'].toString()) != purchase['stocks'] ?
                                            Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width / 136.6,
                                            ),

                                            Container(
                                              width: width / 27.32,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                "${index + 1}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 13.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                "${purchase['date']}\n${purchase['time']}"
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.075,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                "${purchase['itemcode']}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 5.54,
                                              height: height / 13.14,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width / 683,
                                                  vertical: height / 328.5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                child: Text(
                                                  purchase['Description']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: width / 22.76,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Hsncode'].toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 16.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Payment mode']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 45.53,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Qty'].toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            //sold Items
                                            Container(
                                              width: width / 25.53,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                quvanotysolddunction(
                                                        int.parse(
                                                            purchase['Qty']
                                                                .toString()),
                                                        purchase['stocks'],
                                                        purchase[
                                                            'return Quvantity'])
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            //balnce items
                                            Container(
                                              width: width / 20.53,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['stocks'].toString(),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            //return items
                                            Container(
                                              width: width / 25.53,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['return Quvantity']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.pink,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Purchase price']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Landing cost']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['Sales price']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 27.32,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                purchase['tax'].toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                "${(double.parse(purchase['Landing cost']
                                                    .toString())*double.parse(purchase['Qty'].toString())).toString()}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),

                                            Container(
                                              width: width / 17.66,
                                              height: height / 13.14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              child: Center(
                                                  child: Text(
                                                quvantitybalanceAmountduntion(
                                                        purchase['stocks'],
                                                        double.parse(purchase[
                                                                'Landing cost']
                                                            .toString()))
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                        SizedBox(height: height / 65.7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: height / 21.9,
                                width: width / 7.83,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    color: const Color(0xff25d366)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text("Total : ${viewalltotal.toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width / 85.375,
                                            textStyle: const TextStyle(
                                                overflow: TextOverflow
                                                    .ellipsis))),
                                  ],
                                )),
                            SizedBox(width: 10,)
                          ],
                        )

                      ],
                    ),

                  ),
                ),
              ),
            ));
      },
    );
  }

  quvanotyblancedunction(quvantity, stocks) {
    return (quvantity - (quvantity - stocks));
  }

  quvantitybalanceduntion(int quvantity, int stocks, double purchaseprice) {
    return ((quvantity - stocks) * purchaseprice).toString();
  }

  quvantitybalanceAmountduntion(int Quvantity, landingcost) {
    return Quvantity * landingcost;
  }
}
