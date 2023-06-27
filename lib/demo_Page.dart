import 'package:flutter/material.dart';

class test_PAge extends StatefulWidget {
  const test_PAge({Key? key}) : super(key: key);

  @override
  State<test_PAge> createState() => _test_PAgeState();
}
const List<String> Stateslect = <String>[
  "Select State",
  " Andhra Pradesh",
  " Arunachal Pradesh",
  " Assam",
  "Bihar",
  "Chhattisgarh",
  " Goa",
  ' Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  " Uttar Pradesh",
  "West Bengal",

];
class _test_PAgeState extends State<test_PAge> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0,right: 60,left: 50),
            child: Container(child:
            LayoutBuilder(
              builder: (BuildContext , BoxConstraints )=>
                  Autocomplete<String>(
                    optionsViewBuilder:(context, onSelected, options) => Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                          ),
                          child: Container(
                            height: 52.0 * options.length,
                            width: BoxConstraints.biggest.width,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              shrinkWrap: false,
                              itemBuilder: (BuildContext , index) {
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
                        )
                    ),
                    optionsBuilder: (TextEditingValue textEditingValue) {

                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }

                      if(textEditingValue.text!=""){
                      }
                      return
                        Stateslect.where((String option)=>option.toLowerCase().contains(textEditingValue.text.toLowerCase(),));
                    },
                    onSelected: (String selection) {
                      setState(() {
                        //to aasign the controller value
                      });
                      debugPrint('You just selected $selection');
                    },
                    displayStringForOption: (Value){
                      return Value;
                    },
                  ),
            ),
              /* DropdownButton<String>(
                value: dropdownValue3,
                isExpanded: true,
                style:  TextStyle(color: Colors.black, fontSize: width/105.07),
                underline: Container(
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue3 = value!;
                  });
                },

                items:
                Stateslect.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),*/
              /* TextField(
                controller:  State,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 20,bottom: 8),
                  hintText: "State",
                  border: InputBorder.none,
                ),
              ),*/
              width: width/6.83,
              height: height/16.42,
              //color: Color(0xffDDDEEE),
              decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }
}
