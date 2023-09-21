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
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Image.asset('image/trashlogo.png', height: 30, width: 40),
                  const Text(
                    'IoT ~ SmartBin',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 22),
                  )
                ],
              ),
              const SizedBox(height: 130),
              Image.asset(
                'image/4881655.gif',
                height: 270,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to SmartBin!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Effortlessly monitor your wastes with our IoT based smart bin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 124, 122, 122),
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(270, 40),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
