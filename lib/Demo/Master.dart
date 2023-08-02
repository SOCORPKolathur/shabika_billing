import 'dart:convert';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shabika_billing/stmodel.dart' as StatusModel;

/// Flutter code sample for [Autocomplete].

class demo2 extends StatefulWidget {
  const demo2({Key? key}) : super(key: key);

  @override
  State<demo2> createState() => _demo2State();
}

class _demo2State extends State<demo2> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  List<Location> locations = [];
  String status = '';
  List<String> _cities = ["Choose City"];
  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }


  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == "🇮🇳    India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == "Tamil Nadu");
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    print(_cities);
    return _cities;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country State and City Picker'),
      ),
      body:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 600,
          child:
          Column(
            children: [
              SelectState(

                // style: TextStyle(color: Colors.red),
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                  print(value);
                },
                onStateChanged:(value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged:(value) {
                  setState(() {
                    cityValue = value;
                  });
                },

              ),
              InkWell(
                 onTap:(){
                   getCity();
               },
               child: const Text("Cjodfg")
            ),
              Text(locations .toString()),
              Text(status),
            ],
          )
      ),
    );
  }
}

class Location {
  String name;
  String district;
  String region;
  String state;

  Location(this.name, this.district, this.region, this.state);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        json['Name'], json['District'], json['Region'], json['State']);
  }
}