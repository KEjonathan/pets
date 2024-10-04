import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class ScheduleAppointmentScreen extends StatefulWidget {
  @override
  _ScheduleAppointmentScreenState createState() => _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final doctorController = TextEditingController();
  final specialtyController = TextEditingController();
  DateTime? selectedDate;

  // Initialize Firestore and FirebaseAuth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> scheduleAppointment() async {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      // Get the current user
      User? user = _auth.currentUser;
      if (user != null) {
        // Save appointment to Firestore
        await _firestore.collection('users').doc(user.uid).collection('appointments').add({
          'doctor': doctorController.text,
          'specialty': specialtyController.text,
          'date': selectedDate!.toIso8601String(), // Store date as string
          'createdAt': Timestamp.now(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment scheduled successfully!')));
        Navigator.pop(context); // Go back to previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not authenticated!')));
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Request'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: doctorController,
                decoration: InputDecoration(labelText: 'Doctor\'s Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: specialtyController,
                decoration: InputDecoration(labelText: 'Specialty'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter specialty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(selectedDate != null
                      ? "Date: ${selectedDate!.toLocal()}".split(' ')[0]
                      : "No Date Chosen"),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Choose Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: scheduleAppointment,
                child: const Text('Schedule Appointment Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
