import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'Add User',
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
            SizedBox(height: height * 0.03),
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
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
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
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
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
                    'Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //! Submit Button
            SizedBox(height: height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(
                        () => const CustomBottomNavigationBar(),
                        transition: Transition.leftToRight,
                      );
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: AppColors.textColor1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.buttonColorBlue2,
                      side: const BorderSide(
                        width: 0.5,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
