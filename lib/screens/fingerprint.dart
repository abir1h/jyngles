import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:jyngles/screens/sign_in_up/signin.dart';
import 'package:jyngles/utils/colors.dart';
import 'package:jyngles/widgets/custom_bottom_navigation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class finger extends StatefulWidget {
  @override
  _fingerState createState() => _fingerState();
}
class _fingerState extends State<finger> {
  var _message='';
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticateMe() async {
// 8. this method opens a dialog for fingerprint authentication.
//    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: "Authenticate for Testing", // message for dialog
          options: const AuthenticationOptions(biometricOnly: true)
      );
      setState(() {
        _message = authenticated ? "Authorized" : "Not Authorized";
      });
      authenticated==true?Get.to(()=>CustomBottomNavigationBar()): AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie.asset(
            //   'assets/images/congrats.json',
            //   controller: _controller,
            //   onLoaded: (composition) {
            //     // Configure the AnimationController with the duration of the
            //     // Lottie file and start the animation.
            //     _controller
            //       ..duration = composition.duration
            //       ..forward();
            //   },
            // ),
            Text('Opps!!',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            Text('Fingerprint not Recognised',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please try again',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),

              ],
            )
          ],
        ),
        title: 'This is Ignored',
        desc:   'This is also Ignored',
        btnOkOnPress: () {
          Get.to(
                () => finger(),
            transition: Transition.rightToLeft,
          );
        },
      ).show();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }
  @override
  void initState() {
// TODO: implement initState
    checkingForBioMetrics();
    super.initState();
    _authenticateMe();
  }  var token;

  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print(canCheckBiometrics);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    setState(() {
      status=canCheckBiometrics;
    });
    token!=null? canCheckBiometrics==false?Get.to(()=>SignInPage()):null:Get.to(()=>SignInPage());
    return canCheckBiometrics;
  }
  bool status=false;
  @override
  Widget build(BuildContext context) { final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height/3,),
            InkWell(
              onTap: _authenticateMe,
              child: Container(
                  child:  Icon(Icons.fingerprint_outlined,color: Colors.blue,size: 80,)),
            ),
            Text('Tap here'),
            SizedBox(height: height/10,),
            Center(child: Text("Authenticate using your ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),),
            Center(child: Text("finger print instead of  ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),),
            Center(child: Text("your password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Biometrics staus : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
                Center(child: Text(status==true?'Available':'Device does not have biometrics support',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                )],
            ),
            Center(
              child: Container(
                child: Text(_message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Get.to(()=>SignInPage());
                },
                child: Container(
                  height: height/18,
                  width: width,
                  decoration: BoxDecoration(color: AppColors.container1,
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text("Authenticate by login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //   onPressed: _authenticateMe,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}