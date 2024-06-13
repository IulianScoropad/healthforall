import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:healthforall/components/section_title.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/controllers.dart';
import 'package:healthforall/screens/doctors/components/AvailableDoctor.dart';
import 'package:healthforall/screens/doctorDetails/doctor_details_screen.dart';
import 'package:healthforall/screens/home/components/available_doctors.dart';



import 'components/search_doctor_card.dart';


class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  SearchResultScreenState createState() => SearchResultScreenState();
}

class SearchResultScreenState extends State<SearchResultScreen> {
  late Query _query;

  @override
  void initState() {
    super.initState();
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    _query = databaseReference.child('Doctors').orderByChild('region').equalTo(globalSelectedRegion);

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
            Text(globalSelectedRegion ?? " "),
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
                      title: "All Doctors",
                      pressOnSeeAll: () {},
                    ),
                    StreamBuilder(
                      stream: _query.onValue,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                          return const Text('No data available');
                        }

                        Map<dynamic, dynamic> values = snapshot.data!.snapshot.value;
                        List<AvailableDoctor> searchDoctors = [];
                        values.forEach((key, value) {
                          searchDoctors.add(AvailableDoctor.fromMap(key,value));
                        });

                        return Column(
                          children: searchDoctors.map((doctor) => SearchDoctorCard(
                            info: AvailableDoctor(
                              image: doctor.image,
                              username: doctor.username,
                              categorie: doctor.experience,
                              time: doctor.time,
                              hospitalname: doctor.hospitalname, key: '',
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
              const AvailableDoctors(),
            ],
          ),
        ),
      ),
    );
  }
}