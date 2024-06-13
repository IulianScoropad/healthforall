import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:healthforall/screens/doctors/components/RecommendDoctor.dart';

class RecommendDoctorCard extends StatelessWidget {
  const RecommendDoctorCard({
    super.key,
    required this.doctor,
  });

  final RecommendedDoctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: Color(0xfffea41d),
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cauți medicul specialist dorit?",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: defaultPadding / 2),
                      width: 2,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFF83D047),
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultPadding)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "${doctor.speciality}\n${doctor.institute}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(doctor.image),
          ),
        ],
      ),
    );
  }
}
