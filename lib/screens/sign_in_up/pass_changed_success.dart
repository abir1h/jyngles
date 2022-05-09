import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';

import '../../utils/colors.dart';

class PassChangedSuccess extends StatelessWidget {
  const PassChangedSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBlue,
          elevation: 2,
          title: const Text(
            'Success',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.15),
                const CircleAvatar(
                  backgroundColor: AppColors.textColor2,
                  radius: 33,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Text(
                  'Password Changed Successfully',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9E9E9E),
                  ),
                ),
                SizedBox(height: height * 0.01),
                const Text(
                  'Successful',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor2,
                  ),
                ),
                SizedBox(height: height * 0.1),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      const CustomBottomNavigationBar(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.textColor2,
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
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
