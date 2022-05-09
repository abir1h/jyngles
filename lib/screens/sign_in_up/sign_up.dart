// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, await_only_futures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jyngles/screens/sign_in_up/otp.dart';
import 'package:jyngles/screens/sign_in_up/signin.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appurl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String initialCountry = 'BD';
  var phone;

  PhoneNumber number = PhoneNumber(isoCode: 'BD');
  Future registerApi_(String username, String email, String phone,
      String password, String confirm_pass) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.reg),
    );
    request.fields.addAll({
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 201) {
          var data = jsonDecode(response.body);
          print(data);
          print('response.body ' + data.toString());
          Fluttertoast.showToast(
            msg: "OTP sent Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(phone: phone),
            ),
          );
        } else {
          print("Fail! ");
          var data = jsonDecode(response.body);

          Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return response.body;
        }
      });
    });
  }

  saveprefs(String token, String phone, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    prefs.setString('phone', phone);
    prefs.setString('name', name);
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
          'Sing Up',
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
            SizedBox(height: height * 0.02),
            //!Username
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            //!Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            //!Phone
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    color: AppColors.textFieldBackground1,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        setState(() {
                          phone = number.phoneNumber;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: phoneNumberController,
                      validator: (v) =>
                          v!.isEmpty ? "Field can't be empty" : null,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: InputBorder.none,
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            //!Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            //!Confirm Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Container(
                    height: height * 0.06,
                    width: width,
                    padding: EdgeInsets.only(left: width * 0.04),
                    color: AppColors.textFieldBackground1,
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //! Signup Button
            SizedBox(height: height * 0.04),
            GestureDetector(
              //TODO:
              onTap: () {
                if (passwordController.text == confirmPasswordController.text) {
                  registerApi_(
                    usernameController.text,
                    emailController.text,
                    phone,
                    passwordController.text,
                    confirmPasswordController.text,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Password dosen\'t match',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 15),
                child: Container(
                  height: height * 0.06,
                  width: width,
                  padding: EdgeInsets.only(left: width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColorBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Or Continue with',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            //! Facebook Google
            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColorBlue3,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/fb.png',
                      ),
                      const Text(
                        'Facebook',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColorBlue4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google.png'),
                      SizedBox(width: width * 0.01),
                      const Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: width * 0.02),
                InkWell(
                  onTap: () {
                    Get.offAll(() => const SignInPage());
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppColors.textColor2,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
