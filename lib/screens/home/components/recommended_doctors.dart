import 'package:flutter/material.dart';

import '../../../controllers.dart';
import 'recommended_doctor_card.dart';
import '../../../models/RecommendDoctor.dart';

class RecommendedDoctors extends StatelessWidget {
  const RecommendedDoctors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecommendedDoctor>>(
        future: RecommendedDoctorService().getRecommendedDoctors(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        List<RecommendedDoctor> recommendedDoctors = snapshot.data!;
        return AspectRatio(
          aspectRatio: 2.5,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85, initialPage: 3),
            itemCount: recommendedDoctors.length,
            itemBuilder: (context, index) =>
                RecommendDoctorCard(
                  doctor: recommendedDoctors[index],
                ),
          ),
        );
      }
    },
    );
    }

  }
