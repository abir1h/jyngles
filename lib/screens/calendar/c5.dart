import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class C5 extends StatefulWidget {
  const C5({Key? key}) : super(key: key);

  @override
  State<C5> createState() => _C5State();
}

class _C5State extends State<C5> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.lightBlue,
          elevation: 0,
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
          title: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.08),
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  height: height * 0.05,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.lightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        width: width * 0.7,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '01.02.2022',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.disabledTextColor,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.iconColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),

                //!Amount
                const Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  height: height * 0.05,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.lightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        width: width * 0.7,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '\$ 0.00',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.disabledTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),

                //!title
                const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  height: height * 0.05,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.lightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        width: width * 0.7,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Your Title',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.disabledTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.065,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.containerButton,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
