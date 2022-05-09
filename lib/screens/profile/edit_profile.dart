import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/profile/add_user.dart';
import 'package:jyngles/screens/profile/view_user.dart';
import 'package:jyngles/utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height * 0.23,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/profilepic.png'),
                    ),
                    SizedBox(width: width * 0.1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AL Mamun',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/icons/coin.png'),
                            const Text(' Point: 100'),
                          ],
                        )
                      ],
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       child: const Text('Add User'),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: AppColors.buttonColorBlue,
                    //       ),
                    //     ),
                    //     SizedBox(height: height * 0.015),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Get.to(
                    //           const ViewUser(),
                    //           transition: Transition.rightToLeft,
                    //         );
                    //       },
                    //       child: const Text('View User'),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: AppColors.buttonColorBlue,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.05),
            //!NAME
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'AL Mamun',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            //!EMAIL
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'abcd@gmail.com',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            //!PHONE
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '+8801234567890',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
            ), //! Edit Button
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.buttonColorRed,
                      side: const BorderSide(
                        width: 0.5,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.lightBlue,
                      side: const BorderSide(
                        width: 0.5,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
