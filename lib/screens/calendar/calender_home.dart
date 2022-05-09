import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/calendar/add_calendar.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/drawer.dart';
import '../../widgets/notification_icon_button.dart';
import 'c4.dart';

class CalenderHome extends StatefulWidget {
  const CalenderHome({Key? key}) : super(key: key);

  @override
  State<CalenderHome> createState() => _CalenderHomeState();
}

class _CalenderHomeState extends State<CalenderHome> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 41, 68, 121),
            AppColors.chatBackgroundColor,
            AppColors.chatBackgroundColor,
          ],
        ),
      ),
      child: Scaffold(
        key: _key,
        drawer: CustomDrawer(height: height, width: width),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.lightBlue,
          elevation: 2,
          title: Text(
            'calendar'.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            ChatIconButton(width: width),
            NotificationIconButton(width: width),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                Image.asset('assets/images/emoji.png'),
                SizedBox(height: height * 0.05),
                const Text(
                  'You have not added yet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.065),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      const C4(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Container(
                    height: height * 0.065,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      color: AppColors.containerButton,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Center(
                      child: Text(
                        'ADD',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
