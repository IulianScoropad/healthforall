import 'package:healthforall/models/AvailableDoctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import 'rating.dart';

class AvailableDoctorCard extends StatelessWidget {
  const AvailableDoctorCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final AvailableDoctor info;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.username!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  info.region!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                  child: Rating(score: 5),
                ),
                SizedBox(height: defaultPadding / 2),
                Text(
                  "Experience",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${info.experience} Years",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: defaultPadding / 2),
                Text(
                  "Patients",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  info.numarpacienti!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Image.asset(
              info.image!,
              height: 120,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}


