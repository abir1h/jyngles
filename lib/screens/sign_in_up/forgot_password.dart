import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jyngles/screens/sign_in_up/new_password.dart';
import 'package:jyngles/screens/sign_in_up/pass_changed_success.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:http/http.dart' as http;
import '../../utils/appurl.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool phoneSubmitted = false;
  bool correctOtp = false;
  bool showSetPassword = false;
  TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();

  String _password = '';
  String _confirmPassword = '';

  TextEditingController otp_1 = TextEditingController();
  TextEditingController otp_2 = TextEditingController();
  TextEditingController otp_3 = TextEditingController();
  TextEditingController otp_4 = TextEditingController();

  String initialCountry = 'BD';
  var phone;

  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller_}) {
    return SizedBox(
      height: 85,
      // width: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller_,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: AppColors.blue,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Future sendOTP(String phone) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.sendPhoneNumber),
    );
    request.fields.addAll({'phone': phone});

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print('response.body ' + data.toString());
          if (data['status'] == 200) {
            Fluttertoast.showToast(
              msg: "OTP has been sent to your phone",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            setState(() {
              phoneSubmitted = true;
              showSetPassword = false;
            });
          } else {
            print(data['message']);
            Fluttertoast.showToast(
              msg: 'Fail',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          print(response.statusCode);
          return response.body;
        }
      });
    });
  }

  //TODO

  Future changepass(String otp, String phone, String password) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.changePassword),
    );
    request.fields.addAll({
      'otp': otp,
      'phone': phone,
      'password': password,
    });

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print('response.body ' + data.toString());
          if (data['status'] == 200) {
            Fluttertoast.showToast(
              msg: "Password Changed Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.to(
              () => const PassChangedSuccess(),
              duration: const Duration(
                milliseconds: 500,
              ),
              transition: Transition.zoom,
            );
          } else {
            print(data['message']);
            Fluttertoast.showToast(
              msg: 'Fail',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          print("Fail!");
          return response.body;
        }
      });
    });
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
          'Forgot Password',
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
            SizedBox(height: height * 0.05),
            phoneSubmitted
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: width / 15),
                    child: const Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            SizedBox(height: height * 0.01),
            //!Phone
            phoneSubmitted
                ? Container()
                : Padding(
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
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
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

            //!OTP
            phoneSubmitted
                ? Padding(
                    padding: EdgeInsets.only(left: width / 10),
                    child: const Text(
                      'OTP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Container(),
            phoneSubmitted
                ? Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _textFieldOTP(
                                  first: true,
                                  last: false,
                                  controller_: otp_1,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: _textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller_: otp_2,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: _textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller_: otp_3,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: _textFieldOTP(
                                  first: false,
                                  last: true,
                                  controller_: otp_4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Expire',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff403F3F),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  const Text(
                                    '00:06',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff0DAEC4),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Resend Code',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.05),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.06,
                                      width: width,
                                      padding:
                                          EdgeInsets.only(left: width * 0.04),
                                      color: AppColors.textFieldBackground1,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          if (value.trim().length < 8) {
                                            return 'Password must be at least 8 characters in length';
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: width / 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.06,
                                      width: width,
                                      padding:
                                          EdgeInsets.only(left: width * 0.04),
                                      color: AppColors.textFieldBackground1,
                                      child:

                                          /// Confirm Password
                                          TextFormField(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
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
                                        onChanged: (value) =>
                                            _confirmPassword = value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),

            //! Next Button
            SizedBox(height: height * 0.1),

            phoneSubmitted
                ? Container()
                : GestureDetector(
                    onTap: () {
                      print(phone);
                      sendOTP(phone);
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
                                'Next',
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
            phoneSubmitted
                ? GestureDetector(
                    onTap: () {
                      final bool? isValid = _formKey.currentState?.validate();
                      if (isValid == true) {
                        changepass(
                          otp_1.text + otp_2.text + otp_3.text + otp_4.text,
                          phone,
                          _password,
                        );
                      }
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
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
