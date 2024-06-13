import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthforall/constants.dart';
import 'package:healthforall/controllers.dart';
import 'package:healthforall/screens/categorySearch/Category.dart';
import 'package:healthforall/screens/categorySearch/doctors_in_category_screen.dart';
import 'package:healthforall/screens/doctors/components/AvailableDoctor.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final List<AvailableDoctor> doctors;

  const CategoryCard({
     super.key,
    required this.category,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding),
      child: InkWell(
        onTap: () async {

          doctorCategory = category.title;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DoctorsInCategoryScreen(),
            ),
          );
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          height: 90,
          width: 90,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(category.icon),
              const SizedBox(height: defaultPadding / 2),
              Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}