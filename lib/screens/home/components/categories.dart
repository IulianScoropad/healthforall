import 'package:flutter/material.dart';
import 'package:healthforall/screens/categorySearch/category_card.dart';
import '../../../components/section_title.dart';
import '../../../constants.dart';
import '../../doctors/components/AvailableDoctor.dart';
import '../../categorySearch/Category.dart';


class Categories extends StatelessWidget {
  final List<AvailableDoctor> doctors;

  const Categories({
    Key? key,
    required this.doctors,
  }) : super(key: key);

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




