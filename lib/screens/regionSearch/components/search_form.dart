import 'package:healthforall/controllers.dart';
import 'package:healthforall/screens/regionSearch/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';


class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  SearchFormState createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {


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
                globalSelectedRegion = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Select Area",
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          ElevatedButton(
            onPressed: () async {

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
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xfffea41d),
            ),
            child: const Text("Select Date"),
          ),

          const SizedBox(height: 50.0),
             ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchResultScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF6CD8D1),
              ),
              child: const Text("Search"),
            ),
        ],
      ),
    );
  }
}