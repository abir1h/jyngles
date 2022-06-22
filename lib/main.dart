import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:jyngles/screens/splash/launch_screen.dart';
import 'package:jyngles/screens/splash/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  OneSignal.shared.init("9c5dea4f-525c-47a8-84c0-64c90cc916ab", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false

  },

  );
  Stripe.publishableKey = 'pk_test_51L0i1BSChOU0ArmZKcpUWkk7hKtf76JtJsyrOQeoOUW9PfZI4vyZq8LryLw0MpA8qff178LPUYD5I3sxbLrfrJCi00loRtljO8';

  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
    );
  }
}
