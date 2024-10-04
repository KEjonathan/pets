import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets/widgets/appointment.dart';
import 'package:pets/widgets/diagnosis.dart';
import 'package:pets/widgets/emergency.dart';
import 'package:pets/widgets/grooming.dart';
import 'package:pets/widgets/health.dart';
import 'package:pets/widgets/nutrition.dart';
import 'package:pets/widgets/reports.dart';
import 'package:pets/widgets/splashscreen.dart';
import 'package:pets/widgets/vaccination.dart';
import 'package:pets/widgets/login.dart';
import 'package:pets/widgets/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetCare App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/pet_health': (context) => const HealthScreen(),
        '/vaccination': (context) =>  VaccinationDashboard(),
        '/appointments': (context) => const AppointmentsDashboard(),
        '/nutrition': (context) =>  NutritionDashboard(),
        '/grooming': (context) =>  AskScreen(),
        '/reports': (context) =>  ReportsDashboard(),
        '/emergency': (context) =>  EmergencyDashboard(),
        '/diagnostics': (context) =>  DiagnosisDashboard(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
