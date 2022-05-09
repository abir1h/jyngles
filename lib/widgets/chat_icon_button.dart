import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../screens/chat/chat_screen.dart';

class ChatIconButton extends StatelessWidget {
  const ChatIconButton({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ChatScreen());
      },
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.02),
        child: SvgPicture.asset(
          'assets/icons/chat_icon.svg',
          color: Colors.black,
        ),
      ),
    );
  }
}
