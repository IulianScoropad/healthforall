import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:healthforall/components/section_title.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/controllers.dart';
import 'package:healthforall/models/AvailableDoctor.dart';
import 'package:healthforall/models/SearchDoctor.dart';
import 'package:healthforall/screens/details/doctor_details_screen.dart';
import 'package:healthforall/screens/home/components/available_doctors.dart';



import 'components/search_doctor_card.dart';


class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late Query _query;

  @override
  void initState() {
    super.initState();
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    _query = databaseReference.child('Doctors').orderByChild('region').equalTo(globalSelectedRegion);
  //  _query = _query.orderByChild('categorie').equalTo(globalSelectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Selected area",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text("Boston"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/Chat.svg"),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    SectionTitle(
                      title: "All Cardiologist",
                      pressOnSeeAll: () {},
                    ),
                    StreamBuilder(
                      stream: _query.onValue,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                          return Text('No data available');
                        }

                        Map<dynamic, dynamic> values = snapshot.data!.snapshot.value;
                        List<AvailableDoctor> searchDoctors = [];
                        values.forEach((key, value) {
                          searchDoctors.add(AvailableDoctor.fromMap(value));
                        });

                        return Column(
                          children: searchDoctors.map((doctor) => SearchDoctorCard(
                            info: SearchDoctor(
                              image: doctor.image,
                              name: doctor.username,
                              speciality: doctor.experience,
                              time: doctor.time,
                              hospitalName: doctor.hospitalname,
                            ),
                            press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsScreen(doctor: doctor),
                              ),
                            ),
                          )).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              AvailableDoctors(),
            ],
          ),
        ),
      ),
    );
  }
}