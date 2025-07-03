import 'dart:developer';

import 'package:drip_out/authentication/domain/services/google_sign_in_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInServiceImpl extends GoogleSignInService{

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '250090784649-lg749v5qao972e6bb1tpqj7g49o5pit8.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
    ],
  );

  @override
  Future<String?> signInAndGetIdToken() async {
    log('wewe');
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      log('account: $account');
      if (account == null) return null;
      final GoogleSignInAuthentication auth = await account.authentication;
      log('id token: ${auth.idToken}');
      return auth.idToken;
    } catch (e) {
      log('error in google login: ${e.toString()}');
      return null;
    }
  }
}