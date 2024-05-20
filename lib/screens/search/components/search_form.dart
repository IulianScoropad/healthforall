import 'package:healthforall/controllers.dart';
import 'package:healthforall/screens/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

import 'package:flutter/material.dart';
import 'package:healthforall/screens/search/search_result_screen.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField(
            icon: SvgPicture.asset("assets/icons/address.svg"),
            items: list.map<DropdownMenuItem<String>>((String region) {
              return DropdownMenuItem(
                value: region,
                child: Text(region),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                globalSelectedRegion = value as String?;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Select Area",
            ),
          ),
          DropdownButtonFormField(
            icon: SvgPicture.asset(
              "assets/icons/stethoscope.svg",
              height: 17,
              color: Color(0xFF677B92),
            ),
            items: categoryList.map<DropdownMenuItem<String>>((String category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                globalSelectedCategory = value as String?;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Select Category",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Afisare calendar pentru selectarea datei
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );

              if (pickedDate != null && pickedDate != globalSelectedDate) {
                setState(() {
                  globalSelectedDate = pickedDate;
                });
              }
            },
            child: Text("Select Date"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Filtrare si navigare catre rezultatele cautarii
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultScreen(),
                  ),
                );
              },
              child: Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}