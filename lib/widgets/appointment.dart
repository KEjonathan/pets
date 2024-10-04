import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'appointment_screen.dart'; // Import your appointment screen

class AppointmentsDashboard extends StatelessWidget {
  const AppointmentsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // My Appointment Requests Section
            _buildAppointmentRequestsSection(),

            const SizedBox(height: 20),

            // Upcoming Appointments Section
            _buildUpcomingAppointmentsSection(),

            const SizedBox(height: 20),

            // Past Appointments Section
            _buildPastAppointmentsSection(),

            const SizedBox(height: 20),

            // Button to Schedule New Appointment
            _buildScheduleAppointmentButton(context),
          ],
        ),
      ),
    );
  }

  // Widget for My Appointment Requests Section
  Widget _buildAppointmentRequestsSection() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('appointments')
          .get(), // Fetch appointment requests from Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Handle error
        }

        if (snapshot.data?.docs.isEmpty ?? true) {
          return const Text('No appointment requests available'); // No appointment requests
        }

        // Display appointment requests
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Appointment Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return _buildAppointmentTile(
                      data['doctor'] ?? 'Unknown Doctor',
                      data['specialty'] ?? 'Unknown Specialty',
                      data['date'] ?? 'Unknown Date',
                      Colors.blueAccent,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget for Upcoming Appointments Section
  Widget _buildUpcomingAppointmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Appointments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppointmentTile('Dr. Alan Hathaway', 'Cardiologist', 'Sun, Jan 15, 09:00 AM', Colors.blue),
                _buildAppointmentTile('Dr. Jane Doe', 'Veterinarian', 'Wed, Jan 25, 10:00 AM', Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget for Past Appointments Section
  Widget _buildPastAppointmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Past Appointments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppointmentTile('Dr. Emily White', 'Dermatologist', 'Mon, Dec 10, 02:00 PM', Colors.red),
                _buildAppointmentTile('Dr. John Smith', 'Neurologist', 'Fri, Nov 30, 01:00 PM', Colors.orange),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget to build individual appointment tiles
  Widget _buildAppointmentTile(String doctorName, String specialty, String dateTime, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    specialty,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dateTime,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Widget for Schedule New Appointment Button
  Widget _buildScheduleAppointmentButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScheduleAppointmentScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Request New Appointment',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
