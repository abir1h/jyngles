import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/profile/add_user.dart';
import 'package:jyngles/utils/colors.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({Key? key}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'User',
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
        child: Padding(
          padding: EdgeInsets.only(
            left: width / 15,
            right: width / 15,
            top: height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 216, 216, 216)
                          .withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/profilepic.png'),
                        ),
                        SizedBox(width: width * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Eric Schmidt',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            const Text(
                              'abcd@gmail.com',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // Container(
                    //   height: height * 0.05,
                    //   width: width * 0.25,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: AppColors.textColor2,
                    //     ),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: const Center(
                    //     child: Text(
                    //       'View Profile',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
