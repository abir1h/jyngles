import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: width / 20),
        child: SvgPicture.asset(
          'assets/icons/notification_on.svg',
          color: Colors.black,
        ),
      ),
    );
  }
}
