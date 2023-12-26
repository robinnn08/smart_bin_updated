import 'package:flutter/material.dart';
import 'loginm.dart';
import 'registerm.dart';

// halaman login atau register jika user belum login
class LogOrRegister extends StatefulWidget {
  const LogOrRegister({super.key});

  @override
  State<LogOrRegister> createState() => _LogOrRegisterState();
}

class _LogOrRegisterState extends State<LogOrRegister> {
  // nilai boolean untuk menentukan halaman mana yang akan ditampilkan
  bool isLoginPage = true;
  // nilai boolean untuk menentukan apakah sedang loading atau tidak
  bool isLoading = false;

  // fungsi unguk mengubah state isLoginPage dan isLoading
  // digunakan untuk bertukar halaman antara login dan register serta menampilkan loading indicator saat halaman berpindah
  void switchPage() {
    setState(() {
      isLoading = true;
      isLoginPage = !isLoginPage;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // jika isLoading bernilai true maka akan menampilkan loading indicator
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 14, 14, 14),
        body: Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 201, 201, 201),
          ),
        ),
      );
    } else {
      // jika isLoading bernilai salah, maka akan dicek nilai isLoginPage.
      // Jika benar, tampilkan halaman login. Jika salah, tampikan halaman register
      if (isLoginPage) {
        return WillPopScope(
            onWillPop: () async => false,
            // passing data dan fungsi switchPage ke halaman login agar dapat diakses
            child: LoginPage(data: 'Login Page', onTap: switchPage));
      } else {
        return WillPopScope(
            onWillPop: () async => false,
            // passing data dan fungsi switchPage ke halaman register agar dapat diakses
            child: RegisterPage(data: 'Register Page', onTap: switchPage));
      }
    }
  }
}
