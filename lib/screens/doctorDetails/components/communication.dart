import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthforall/controllers.dart';

import '../../../chat/chat.dart';
import '../../../constants.dart';

class Communication extends StatelessWidget {
  const Communication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF51BEFB).withOpacity(0.75),
            ),
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/Call.svg"),
            label: const Text("Voice Call"),
          ),
        ),
        const SizedBox(width: defaultPadding / 2),
        Expanded(
          child: ElevatedButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF7E51FB).withOpacity(0.75),
            ),
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/Video.svg",
              width: 11,
            ),
            label: const Text("Video Call"),
          ),
        ),
        const SizedBox(width: defaultPadding / 2),
        Expanded(
          child: ElevatedButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFFFBA351).withOpacity(0.75),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatId: "${doctorID!}_${globalUserId!}", userId: globalUserId!),
                ),
              );
            },
            icon: SvgPicture.asset(
              "assets/icons/Chat.svg",
              width: 11,
            ),
            label: const Text("Message"),
          ),
        ),
      ],
    );
  }
}