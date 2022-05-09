import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/sign_in_up/forgot_password2.dart';
import 'package:jyngles/screens/sign_in_up/pass_changed_success.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'Confirm',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.1),
            Padding(
              padding: EdgeInsets.only(left: width / 15),
              child: const Text(
                'New Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            //!New Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the new password',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: width / 15),
              child: const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            //!Confirm Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm the new password',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //! Update Button
            SizedBox(height: height * 0.25),
            GestureDetector(
              onTap: () {
                Get.to(() => const PassChangedSuccess());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColorBlue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Center(
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
      
      
      ),
    );
  }
}
