import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/chat_icon_button.dart';
import 'package:jyngles/widgets/notification_icon_button.dart';

class ReportABug extends StatefulWidget {
  const ReportABug({Key? key}) : super(key: key);

  @override
  State<ReportABug> createState() => _ReportABugState();
}

class _ReportABugState extends State<ReportABug> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.lightBlue,
            elevation: 2,
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
                // _key.currentState!.openDrawer();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              ChatIconButton(width: width),
              NotificationIconButton(width: width),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                children: [
                  SizedBox(height: height * 0.06),
                  Row(
                    children: const [
                      Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your title',
                        hintStyle: TextStyle(
                          color: AppColors.disabledColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Row(
                    children: const [
                      Text(
                        'Bug Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width,
                    height: height * 0.2,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: const TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter bug details',
                        hintStyle: TextStyle(
                          color: AppColors.disabledColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
