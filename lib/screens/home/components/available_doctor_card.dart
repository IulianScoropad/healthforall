import 'package:healthforall/screens/doctors/components/AvailableDoctor.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../components/rating.dart';

class AvailableDoctorCard extends StatelessWidget {
  const AvailableDoctorCard({
    super.key,
    required this.info,
  });

  final AvailableDoctor info;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: defaultPadding / 2),
                  child: Rating(score: 1),
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  "Experience",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${info.experience} Years",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: defaultPadding / 2),
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


