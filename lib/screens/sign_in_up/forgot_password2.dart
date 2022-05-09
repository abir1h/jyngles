import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/sign_in_up/new_password.dart';
import 'package:jyngles/screens/sign_in_up/success_screen.dart';

import '../../utils/colors.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({Key? key}) : super(key: key);

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
  TextEditingController otp_1 = TextEditingController();
  TextEditingController otp_2 = TextEditingController();
  TextEditingController otp_3 = TextEditingController();
  TextEditingController otp_4 = TextEditingController();
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
            'Enter the verification code',
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Container(
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
                      height: 22,
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
                    SizedBox(height: height * 0.1),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const NewPassword(),
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
                            'Verify',
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
            
            
            ],
          ),
        ),
      ),
    );
  }
}
