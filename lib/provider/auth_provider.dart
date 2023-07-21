import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/pages/otp_page.dart';
import 'package:todo_list/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isSignedIn = prefs.getBool('isSignedIn') ?? false;
    _isSignedIn = isSignedIn;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          // final SharedPreferences prefs =
          //     await SharedPreferences.getInstance();
          // prefs.setBool('isSignedIn', true);
          // _isSignedIn = true;
          // notifyListeners();
          // Navigator.pushNamedAndRemoveUntil(
          //     context, '/home', (route) => false);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: ((verificationId, forceResendingToken) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OptPage(
              verificationId: verificationId,
            );
          }));
        }),
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }
}
