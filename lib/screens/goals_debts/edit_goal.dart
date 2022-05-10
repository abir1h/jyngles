import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class EditGoals extends StatefulWidget {
  const EditGoals({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<EditGoals> createState() => _EditGoalsState();
}

class _EditGoalsState extends State<EditGoals> {
  // bool value = false;
  List<bool> values = [false, false, false];

  GroupController controller = GroupController();

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
              'Update Goal',
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
                  SizedBox(height: height * 0.01),

                  //!Status
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  //!Checkbox group
                  Column(
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[0],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[0] = value!;
                                  values[2] = false;
                                  values[1] = false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Pending',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[1],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[2] = false;
                                  values[0] = false;
                                  values[1] = value!;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: values[2],
                              onChanged: (bool? value) {
                                setState(() {
                                  values[2] = value!;
                                  values[0] = false;
                                  values[1] = false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Failed',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SimpleGroupedCheckbox<int>(
                  //   controller: controller,
                  //   itemsTitle: ["1", "2", "4", "5"],
                  //   values: [1, 2, 4, 5],
                  //   groupStyle: GroupStyle(
                  //     activeColor: Colors.red,
                  //     itemTitleStyle: TextStyle(fontSize: 13),
                  //   ),
                  //   checkFirstElement: false,
                  // ),

                  SizedBox(height: height * 0.015),

                  //!Title
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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
                              hintText: 'Enter your title',
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

                  //!Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                    height: height * 0.05,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.lightBlue,
                    ),
                    child: SizedBox(
                      height: height * 0.04,
                      width: width * 0.7,
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your description',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.disabledTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  //!Amount
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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

                  //!Amount saved
                  const Text(
                    'Amount Saved',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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

                  SizedBox(height: height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                CustomDialog(height: height, width: width),
                          );
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.containerButton,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Center(
                            child: Text(
                              'Update Goal',
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
                ],
              ),
            ),
          ),
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
            const Text(
              'Are You Sure? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.02),
            const Text(
              'Do you really want to update?',
              style: TextStyle(
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
                          fontSize: 22,
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
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
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
            const Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
