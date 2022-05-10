import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/appurl.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  //!Edit Profile
  Future editProfile(
    String email,
    String phone,
    String username,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.editProfile),
    );
    request.fields.addAll({
      'email': email,
      'phone': phone,
      'username': username,
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
              msg:
                  "Profile Updated Successfully\nThe changes will take place on the next time you login",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            Get.offAll(
              () => const CustomBottomNavigationBar(),
              transition: Transition.rightToLeft,
            );
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

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
                        Text(
                          widget.name,
                          style: const TextStyle(
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
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.name,
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
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.email,
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
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.phone,
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
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _phoneController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        editProfile(
                          _emailController.text,
                          _phoneController.text,
                          _nameController.text,
                        );
                      }
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
