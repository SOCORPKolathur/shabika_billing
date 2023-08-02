
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class Tesing extends StatefulWidget {
  const Tesing({Key? key}) : super(key: key);

  @override
  State<Tesing> createState() => _TesingState();
}

class _TesingState extends State<Tesing> {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
             shadowColor: Colors.indigo,
            child:
            Column(
              children: [

                GooglePlaceAutoCompleteTextField(
                    textEditingController: controller,
                    googleAPIKey: "AIzaSyB_eT3oT-cOgqnn4zY39efA9Spb9j7ZHyM",
                    inputDecoration: InputDecoration(
                    ),
                    debounceTime: 800 ,// default 600 ms,
                    countries: ["in","fr"],// optional by default null is set
                    isLatLngRequired:true,// if you required coordinates from place detail
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      // this method will return latlng with place detail
                      print("placeDetails" + prediction.lng.toString());

                    }, // this callback is called when isLatLngRequired is true
                    itmClick: (Prediction prediction) {
                      controller.text=prediction.description!;
                      controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



}
