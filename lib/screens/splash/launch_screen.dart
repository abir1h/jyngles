import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/sign_in_up/signin.dart';
import 'package:jyngles/utils/colors.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Image.asset('assets/images/coin_large.png'),
              SizedBox(height: height * 0.15),
              const Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepBlue,
                ),
              ),
              SizedBox(height: height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEnglish = true;
                      });
                    },
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: isEnglish == true ? Colors.white : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isEnglish == true
                          ? AppColors.spanishButton
                          : Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEnglish = false;
                      });
                    },
                    child: Text(
                      'Española',
                      style: TextStyle(
                        color: isEnglish == true ? Colors.black : Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isEnglish == true
                          ? Colors.white
                          : AppColors.spanishButton,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.065),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SignInPage());
                },
                child: Container(
                  height: height * 0.08,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.tabbarindicatorColor,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Let\'s Get Lit  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
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
