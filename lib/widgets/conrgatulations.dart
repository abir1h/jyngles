import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:lottie/lottie.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({
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
      child: Stack(
        children: [
          Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_prpslttf.json',
            height: height * 0.35,
            width: width * 0.7,
          ),
          SizedBox(
            height: height * 0.45,
            width: width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Congratulations !!! ',
                    style: TextStyle(
                      color: Color(0xffCC002A),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 9, 46, 77),
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'You have completed\nA GOAL!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Image.asset('assets/icons/medal.png'),
                Container(
                  width: width * 0.4,
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.buttonColorBlue5,
                      elevation: 2,
                      side: const BorderSide(
                        width: 1.0,
                        color: AppColors.buttonColorBlueBorder,
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
