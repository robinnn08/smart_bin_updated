import 'package:flutter/material.dart';
import 'package:smart_bin/mobilepages/login_register.dart';

// halaman boarding yang terdiri dari 2 halaman dalam sebuah pageview
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 14, 14, 14),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: Image.asset(
                      'image/frieren.png',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'WasteWizard Solutions',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 130),
              Image.asset(
                'image/trashgif.gif',
                height: 230,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to WasteWizard!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Seamless waste management system for your waste disposal needs.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 210, 209, 209),
                    fontFamily: 'Nunito',
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(270, 50),
                  backgroundColor: Color.fromARGB(255, 32, 32, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 43, 43, 43), width: 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LogOrRegister()),
                  );
                },
                child: const Text(
                  'Get Started!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
