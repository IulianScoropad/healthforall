import 'package:healthforall/models/AvailableDoctor.dart';
//import 'package:healthforall/models/SearchDoctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SearchDoctorCard extends StatelessWidget {
  const SearchDoctorCard({
    super.key,
    required this.info,
    required this.press,
  });

  final AvailableDoctor info;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding)),
      ),
      child: ListTile(
        onTap: press,
        contentPadding: const EdgeInsets.all(defaultPadding),
        leading: AspectRatio(
          aspectRatio: 0.85,
          child: Image.asset(
            info.image!,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          children: [
            Text(
              info.username!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
              child: Text(
                info.categorie!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/Clock.svg"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 4),
                  child: Text(
                    info.time!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 4),
                  child: SvgPicture.asset("assets/icons/location_pin.svg"),
                ),
                Expanded(
                  child: Text(
                    info.hospitalname!,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
