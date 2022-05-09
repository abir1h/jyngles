import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/settings/report_bug.dart';
import 'package:jyngles/widgets/drawer.dart';

import '../../utils/colors.dart';
import '../../widgets/chat_icon_button.dart';
import '../../widgets/notification_icon_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String dropdownValue = '\$';
    String color = 'Blue';
    String language = 'English';
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                children: [
                  SizedBox(height: height * 0.08),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.6,
                          child: const Text(
                            'Currency',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['\$', '£', '€', '৳']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  //!Contact US
                  SizedBox(height: height * 0.06),
                  Row(
                    children: const [
                      Text(
                        'Contact Us',
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
                        hintText: 'info@gmail.com',
                        hintStyle: TextStyle(
                          color: AppColors.disabledColor,
                        ),
                      ),
                    ),
                  ),

                  //!Report bug
                  SizedBox(height: height * 0.04),
                  GestureDetector(
                    onTap: () {
                      //! Get to report a bug page
                      Get.to(() => const ReportABug());
                    },
                    child: Container(
                      width: width,
                      height: height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.lightBlue,
                      ),
                      child: const Center(
                        child: Text(
                          'Report a bug',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //!App Version
                  SizedBox(height: height * 0.03),
                  Row(
                    children: const [
                      Text(
                        'App Version',
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
                    height: height * 0.06,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '1.0.3',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  //!Color
                  SizedBox(height: height * 0.03),
                  Row(
                    children: const [
                      Text(
                        'Color',
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
                    height: height * 0.06,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: DropdownButton<String>(
                      value: color,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Blue', 'Red', 'Yellow', 'Green']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),

                  //!Language
                  SizedBox(height: height * 0.03),
                  Row(
                    children: const [
                      Text(
                        'Language',
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
                    height: height * 0.06,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: DropdownButton<String>(
                      value: language,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          color = newValue!;
                        });
                      },
                      items: <String>['English', 'Española']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
