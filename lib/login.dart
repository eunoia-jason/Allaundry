import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email = "";
String uid = "";
String url = "";
String name = "";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user != null) {
        setState(() {
          email = user.email!;
          uid = user.uid;
          url = user.photoURL!;
          name = user.displayName!;
        });
      }

      Navigator.of(context).pushNamed('/');
    });
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user != null) {
        setState(() {
          email = user.email!;
          uid = user.uid;
          url = user.photoURL!;
          name = user.displayName!;
        });
      }

      Navigator.of(context).pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/project-e3738.appspot.com/o/source%2Fgoogle_logo.png?alt=media&token=adb498a0-1dfb-4eee-a8c6-d2fea2455f73',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    const Text('GOOGLE'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signInWithFacebook,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff3B5998),
                  onPrimary: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/project-e3738.appspot.com/o/source%2Ffacebook_logo.png?alt=media&token=528af1c1-72da-461e-9685-1b543d9e29f2',
                        width: 35,
                        height: 35,
                      ),
                    ),
                    const Text('FACEBOOK'),
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
