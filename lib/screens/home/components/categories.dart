import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/section_title.dart';
import '../../../constants.dart';
import '../../../models/AvailableDoctor.dart';
import '../../../models/Category.dart';
import '../../../screens/details/doctor_details_screen.dart';

class Categories extends StatelessWidget {
  final List<AvailableDoctor> doctors;

  const Categories({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SectionTitle(
            title: "Categories",
            pressOnSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              demo_categories.length,
                  (index) => CategoryCard(
                category: demo_categories[index],
                doctors: doctors,
              ),
            ),
          ),
        )
      ],
    );
  }
}

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
    final doctorsInCategory = doctors.where((doctor) => doctor.categorie == category.title).toList();

    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorsInCategoryScreen(doctors: doctorsInCategory),
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

class DoctorsInCategoryScreen extends StatelessWidget {
  final List<AvailableDoctor> doctors;

  const DoctorsInCategoryScreen({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors in Category"),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doctors[index].username ?? ""),
            subtitle: Text(doctors[index].region ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsScreen(doctor: doctors[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
