import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAPi{
  static final _googleSignIn=GoogleSignIn();
  static Future login()=>_googleSignIn.signIn();
  static Future logout()=>_googleSignIn.disconnect();
}