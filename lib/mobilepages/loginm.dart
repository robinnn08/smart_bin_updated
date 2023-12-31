// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bin/mobilepages/navsm.dart';
import 'package:smart_bin/widget/button.dart';
import 'package:smart_bin/widget/textfield.dart';
import 'package:smart_bin/widget/tile.dart';
import 'package:smart_bin/google_auth.dart';

// halaman login
class LoginPage extends StatefulWidget {
  static const id = "LoginPage";
  final String data;
  final Function() onTap;
  const LoginPage({required this.data, required this.onTap, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // fungsi untuk sign in user
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: Center(
                child: CircularProgressIndicator(
          color: Colors.white,
        )));
      },
    );

    try {
      // sign in user dari email dan password yang diisi di textfield menggunakan firebase auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavPage()),
      );

      // apabila firebase auth menangkap error pada credential user
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // menampilkan popup tergantung\kesalahan credential yang ada pada textfield
      if (e.code == 'user-not-found') {
        showError('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        showError('Email format is invalid.');
      } else {
        showError('Password is incorrect.');
      }
    }
  }

  // fungsi menunjukkan pop up pesan error
  void showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Failed to sign in'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 75),

              // logo
              const Image(
                image: AssetImage('image/trashgif.gif'),
                height: 80,
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Let\'s start managing the waste!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                    fontFamily: 'Work',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Your Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 216, 216, 216),
                        fontFamily: 'Work',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Column(
                children: [
                  MyButton(
                    text: 'Sign In',
                    onPressed: () {
                      signUserIn();
                    },
                  ),
                  const SizedBox(height: 15),
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Color.fromARGB(255, 225, 225, 225),
                              fontFamily: 'Work',
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SquareTile(
                    imagePath: 'image/google.png',
                    onTap: () async {
                      final user = await GoogleAuth().googleSignIn(context);

                      if (user != null) {
                        // Google Sign-In was successful, navigate to the NavPage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavPage(),
                          ),
                        );
                      } else {
                        // Google Sign-In was canceled or failed
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 225, 225, 225),
                          fontFamily: 'Work',
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Gesture detector pada tulisan register untuk berpindah ke halaman register
                      // yang dimana fungsi onTap ini adalah fungsi switchPage yang di passing dari login_register.dart
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Work',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              // sign in button
            ],
          ),
        ),
      ),
    );
  }
}
