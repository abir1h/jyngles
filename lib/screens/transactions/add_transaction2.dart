import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/widgets/controller.dart';

import '../../utils/colors.dart';

class AddTransactions2 extends StatefulWidget {
  const AddTransactions2({Key? key}) : super(key: key);

  @override
  State<AddTransactions2> createState() => _AddTransactions2State();
}

class _AddTransactions2State extends State<AddTransactions2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String category = 'Select Category';
  String category2 = 'Select Category';
  String dropdownValue = '\$';
  final MyHomePageController? controller = Get.put(MyHomePageController());
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
              'ADD TRANSACTIONS',
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.lightBlue,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: false,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 5.0,
                        color: AppColors.tabbarindicatorColor,
                      ),
                    ),
                    tabs: [
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.4,
                        child: const Center(
                          child: Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.4,
                        child: const Center(
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Main Body
                SizedBox(
                  height: height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //!Income
                      Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //!Amount
                                SizedBox(height: height * 0.03),
                                const Text(
                                  'Amount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.05,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.015),
                                    child:  TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${controller!.count.value}'+' 0.00',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //!Category
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Category',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  width: width,
                                  height: height * 0.05,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.textFieldBackground1,
                                  ),
                                  child: DropdownButton<String>(
                                    value: category,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        category = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Select Category',
                                      'Salary',
                                      'Income from rent',
                                      'Interest',
                                      'Pension',
                                      'Work on demand',
                                      'Tax return',
                                      'Coupon',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                //!Description
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.17,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.015,
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Description',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => CustomDialog(
                                              height: height,
                                              width: width,
                                              string: 'income',
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor1,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.buttonColorBlue2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //!Expenses
                      Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //!Amount
                                SizedBox(height: height * 0.03),
                                const Text(
                                  'Amount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.05,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.015),
                                    child:  TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${controller!.count.value}'+' 0.00',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //!Category
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Category',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  width: width,
                                  height: height * 0.05,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.textFieldBackground1,
                                  ),
                                  child: DropdownButton<String>(
                                    value: category2,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        category2 = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Select Category',
                                      'Salary',
                                      'Income from rent',
                                      'Interest',
                                      'Pension',
                                      'Work on demand',
                                      'Tax return',
                                      'Coupon',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                //!Description
                                SizedBox(height: height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    const Text(
                                      '(optional)',
                                      style: TextStyle(
                                        color: AppColors.optionalColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                Container(
                                  height: height * 0.17,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldBackground1,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.015,
                                    ),
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Your Description',
                                        hintStyle: TextStyle(
                                          color: AppColors.disabledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.05,
                                      width: width * 0.25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => CustomDialog(
                                              height: height,
                                              width: width,
                                              string: 'expense',
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textColor1,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.buttonColorBlue2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.image,
    required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.115,
      width: width * 0.26,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.023, top: height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            SizedBox(height: height * 0.005),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.height,
    required this.width,
    required this.string,
  }) : super(key: key);

  final double height;
  final double width;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: height * 0.35,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundColor: Color(0xff0DAEC4),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(height: height * 0.03),
            const Text(
              'Are You Sure? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(
              'Do you really want to add this $string?',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.textColor2),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.textColor2,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomDialog2(height: height, width: width),
                    );
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    decoration: const BoxDecoration(
                      color: AppColors.textColor2,
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialog2 extends StatelessWidget {
  const CustomDialog2({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: height * 0.35,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 33,
              backgroundColor: Color(0xff0DAEC4),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(height: height * 0.03),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
