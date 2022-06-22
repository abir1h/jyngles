import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jyngles/screens/settings/privacy_policy.dart';
import 'package:jyngles/screens/sign_in_up/forgot_password.dart';
import 'package:jyngles/screens/sign_in_up/sign_up.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/utils/google_signin.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/appurl.dart';
import '../../widgets/custom_bottom_navigation.dart';
import '../fingerprint.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogginIn = false;

  saveprefs(String token, String phone, String username, String email,String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('phone', phone);
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('image', image);
  }
  var player_id;
  func() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    var playerId = status.subscriptionStatus.userId;
    print(playerId);
    setState(() {
      player_id = playerId;
    });
  }
  Map _userObj = {};
  Future login_api(String email, String password) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.login),
    );
    request.fields.addAll({
      'email': email,
      'password': password,
      'player_id':player_id,
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

            saveprefs(
              data['token']['plainTextToken'],
              data['data']['phone'],
              data['data']['username'],
              data['data']['email'],
              data['data']['image']!=null?data['data']['image']:'',
            );
            print(data['data']['image']);

            setState(() {
              isLogginIn = false;
            });
            
            Fluttertoast.showToast(
              msg: "Logged In Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.offAll(
              () => const CustomBottomNavigationBar(),
              transition: Transition.rightToLeft,
            );
          } else {
            print("Login Failed");
            var data = jsonDecode(response.body);
            print(data);

            setState(() {
              isLogginIn = false;
            });
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
        }else{
          var data = jsonDecode(response.body);
          print(data);

        }
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        title: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(
                  'Sign in with your account to continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
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
            SizedBox(height: height * 0.02),
            //!PASSWORD
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
            InkWell(
              onTap: () {
                Get.to(() => const ForgotPasswordScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 15, vertical: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('Forgot Password?'),
                  ],
                ),
              ),
            ),

            //! Singin Button
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
               if(passwordController.text.isEmpty || emailController.text.isEmpty ){
                 Fluttertoast.showToast(
                   msg: "Please fill all the boxes",
                   toastLength: Toast.LENGTH_LONG,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.black54,
                   textColor: Colors.white,
                   fontSize: 16.0,
                 );
               }else{
                 setState(() {
                   isLogginIn = true;
                 });
                 login_api(
                   emailController.text,
                   passwordController.text,
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
                  child: Center(
                    child: isLogginIn
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign In',
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

            //!Fingerprint
            SizedBox(height: height * 0.02),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width / 15),
            //   child: InkWell(
            //     onTap: (){
            //       Get.to(()=>finger());
            //     },
            //     child: Container(
            //       height: height * 0.06,
            //       width: width,
            //       padding: EdgeInsets.only(left: width * 0.04),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(8),
            //         border: Border.all(
            //           color: AppColors.buttonColorBlue,
            //         ),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           'Login With FINGERPRINT',
            //           style: TextStyle(
            //             color: AppColors.buttonColorBlue,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                InkWell(
                  onTap: (){

                  },
                  child: Text(
                    'Or Continue with',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),

            //! Facebook Google
            SizedBox(height: height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    facebook_signin();
                  },
                  child: Container(
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
                        SizedBox(width: width * 0.01),
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
                ),
                InkWell(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColorBlue4,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                        ),
                        SizedBox(width: width * 0.02),
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
                ),
              ],
            ),

            SizedBox(height: height * 0.12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: width * 0.02),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpPage());
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: AppColors.textColor2,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

              ],
            ), SizedBox(height: height * 0.04),

            Center(
              child: InkWell(
                onTap: (){
                  Get.to(()=>privacy_policy());
                },
                child: Text("Privacy Policy",style: TextStyle(
                    decoration:TextDecoration.underline,
                    color: Colors.grey),),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future signIn()async{
    final user=await GoogleSignInAPi.login();
if(user==null){
print('signin Failed');}else{
  print(user.toString());
  final GoogleSignInAccount get_user=user;
  Google_login(get_user.displayName.toString(),get_user.email,get_user.id.toString(),get_user.photoUrl!=null?get_user.photoUrl.toString():'0',);
}
  }
  Future facebook_signin()async{
    FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) async{
        print(userData.toString());
        print(userData['name']);
        Map<String, String> requestHeaders = {
          'Accept': 'application/json',
        };
        var request = await http.MultipartRequest(
          'POST',
          Uri.parse(AppUrl.facebook_login),
        );
        request.fields.addAll({
          'email':userData['email'],
          'facebook_id':userData['id'].toString(),
          'displayName':userData['name'],


          // 'player_id':player_id,
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

                saveprefs(
                  data['token']['plainTextToken'],
                  data['data']['phone']!=null?  data['data']['phone']:'',
                  data['data']['username'],
                  data['data']['email'],
                  data['data']['image']!=null?data['data']['image']:'',
                );
                print(data['data']['image']);

                setState(() {
                  isLogginIn = false;
                });

                Fluttertoast.showToast(
                  msg: "Logged In Successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Get.offAll(
                      () => const CustomBottomNavigationBar(),
                  transition: Transition.rightToLeft,
                );
              } else {
                print("Login Failed");
                var data = jsonDecode(response.body);

                setState(() {
                  isLogginIn = false;
                });
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
            }else{
              var data = jsonDecode(response.body);
              print(data);

            }
          });
        });

      });
    });
  }

  Future Google_login(String name, String enail,String id,String photo) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.google_login),
    );
    request.fields.addAll({
      'email':enail,
      'google_id':id,
      'displayName':name,


      // 'player_id':player_id,
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

            saveprefs(
              data['token']['plainTextToken'],
              data['data']['phone']!=null?  data['data']['phone']:'',
              data['data']['username'],
              data['data']['email'],
              data['data']['image']!=null?data['data']['image']:'',
            );
            print(data['data']['image']);

            setState(() {
              isLogginIn = false;
            });

            Fluttertoast.showToast(
              msg: "Logged In Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.offAll(
                  () => const CustomBottomNavigationBar(),
              transition: Transition.rightToLeft,
            );
          } else {
            print("Login Failed");
            var data = jsonDecode(response.body);

            setState(() {
              isLogginIn = false;
            });
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
        }else{
          var data = jsonDecode(response.body);
          print(data);

        }
      });
    });
  }
  Future FaceBook_login(String name, String enail,String id,String photo) async {
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };
    print(player_id);
    print(enail);
    print(id);
    print(name);
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(AppUrl.facebook_login),
    );
    request.fields.addAll({
      'email':enail,
      'facebook_id':id,
      'displayName':name,


      'player_id':player_id,
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

            saveprefs(
              data['token']['plainTextToken'],
              data['data']['phone']!=null?  data['data']['phone']:'',
              data['data']['username'],
              data['data']['email'],
              data['data']['image']!=null?data['data']['image']:'',
            );
            print(data['data']['image']);

            setState(() {
              isLogginIn = false;
            });

            Fluttertoast.showToast(
              msg: "Logged In Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.to(
                  () => const CustomBottomNavigationBar(),
              transition: Transition.rightToLeft,
            );
          } else {
            print("Login Failed");
            var data = jsonDecode(response.body);

            setState(() {
              isLogginIn = false;
            });
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
        }else{
          var data = jsonDecode(response.body);
          print(data);
          print('failed');

        }
      });
    });
  }

}
