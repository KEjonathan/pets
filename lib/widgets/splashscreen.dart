import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 7), () {});
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'VetCare App')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Use a Stack to layer the background image and overlay
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/petPic.png"), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black54, // Semi-transparent overlay
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/petPic.png', height: 100), // Your logo
                const SizedBox(height: 20),
                const Text(
                  'VetCare App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Caring for Your Pets, One Click at a Time',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
