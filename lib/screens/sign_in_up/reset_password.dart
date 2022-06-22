// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/controller.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appurl.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final MyHomePageController? controller = Get.put(MyHomePageController());

  Future resetPass(String password, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.resetPassword),
    );
    request.fields.addAll({
      'password': password,
      'new_password': newPassword,
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['status_code'] == 200) {
            var data = jsonDecode(response.body);
            print(data);
            print('response.body ' + data.toString());

            Fluttertoast.showToast(
              msg: "Password Changed Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.back();
          } else {
            print("post have no Data${response.body}");
            var data = jsonDecode(response.body);
            Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          return response.body;
        }
      });
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller!.change_color.value,
        elevation: 2,
        title: const Text(
          'Reset Password',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Padding(
                padding: EdgeInsets.only(left: width / 15),
                child: const Text(
                  'Old Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              //!Old Password
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
                      child: TextField(
                        controller: oldPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //!New Password
              SizedBox(height: height * 0.01),
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
                      child: TextFormField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must be at least 6 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        onChanged: (value) => _password = value,
                      ),
                    ),
                  ],
                ),
              ),

              //!Confirm Password
              SizedBox(height: height * 0.01),
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
                      child: TextFormField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }

                          if (value != _password) {
                            return 'Confimation password does not match the entered password';
                          }

                          return null;
                        },
                        onChanged: (value) => _confirmPassword = value,
                      ),
                    ),
                  ],
                ),
              ),

              //! Confirm Button
              SizedBox(height: height * 0.15),
              GestureDetector(
                onTap: () {
                  final bool? isValid = _formKey.currentState?.validate();

                  if (isValid == true) {
                    resetPass(
                      oldPasswordController.text,
                      _password,
                    );
                  }

                  // showDialog(
                  //   context: context,
                  //   builder: (context) =>
                  //       CustomDialog(height: height, width: width),
                  // );
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
                            'Confirm',
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
      ),
    );
  }
}

// class CustomDialog extends StatelessWidget {
//   const CustomDialog({
//     Key? key,
//     required this.height,
//     required this.width,
//   }) : super(key: key);

//   final double height;
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SizedBox(
//         height: height * 0.35,
//         width: width * 0.8,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 33,
//               backgroundColor: Color(0xff0DAEC4),
//               child: Icon(
//                 Icons.done,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             const Text(
//               'Are You Sure? ',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Text(
//               'Do you really want to update?',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: height * 0.06,
//                     width: width * 0.3,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: AppColors.textColor2),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                           color: AppColors.textColor2,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                     showDialog(
//                       context: context,
//                       builder: (context) =>
//                           CustomDialog2(height: height, width: width),
//                     );
//                   },
//                   child: Container(
//                     height: height * 0.06,
//                     width: width * 0.3,
//                     decoration: const BoxDecoration(
//                       color: AppColors.textColor2,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Confirm',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomDialog2 extends StatelessWidget {
//   const CustomDialog2({
//     Key? key,
//     required this.height,
//     required this.width,
//   }) : super(key: key);

//   final double height;
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: SizedBox(
//         height: height * 0.35,
//         width: width * 0.8,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 33,
//               backgroundColor: Color(0xff0DAEC4),
//               child: Icon(
//                 Icons.done,
//                 color: Colors.white,
//                 size: 35,
//               ),
//             ),
//             SizedBox(height: height * 0.03),
//             GestureDetector(
//               onTap: () {
//                 Get.offAll(const CustomBottomNavigationBar());
//               },
//               child: const Text(
//                 'Done',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
