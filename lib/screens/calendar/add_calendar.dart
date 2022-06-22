import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/calendar/c2.dart';
import 'package:jyngles/widgets/chat_icon_button.dart';
import 'package:jyngles/widgets/drawer.dart';
import 'package:jyngles/widgets/notification_icon_button.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/colors.dart';
import 'c4.dart';

class AddCalendarScreen extends StatefulWidget {
  const AddCalendarScreen({Key? key}) : super(key: key);

  @override
  State<AddCalendarScreen> createState() => _AddCalendarScreenState();
}

class _AddCalendarScreenState extends State<AddCalendarScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: const Text(
              'Calendar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width / 15),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.04),

                    //!Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: height * 0.05,
                            width: width * 0.40,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColors.calendarIconColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'June 17, 2022',
                                    style: TextStyle(
                                      color: AppColors.disabledColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                const C4(),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.40,
                              decoration: BoxDecoration(
                                color: AppColors.calendarAddButtonColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //!Horizontal Bar
                    SizedBox(height: height * 0.03),
                    Container(
                      height: 0.5,
                      width: width,
                      color: AppColors.horizontalbarColor,
                    ),
                    SizedBox(height: height * 0.03),
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                    ),
                    SizedBox(height: height * 0.03),
                    Container(
                      height: 0.5,
                      width: width,
                      color: AppColors.horizontalbarColor,
                    ),

                    //!View button
                    SizedBox(height: height * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const C2());
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                              color: AppColors.viewButtonColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
