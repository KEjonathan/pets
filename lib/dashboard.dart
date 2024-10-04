import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class DashboardPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Initialize Firestore

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context), // Call logout method
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            _buildProfileInfo(user),
            const SizedBox(height: 20),

            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 20),

            // Doctor Appointment Card
            _buildAppointmentCard(),

            const SizedBox(height: 20),

            // Grid of Services
            _buildServicesGrid(context),

            const SizedBox(height: 20),

            // Top Doctors Section
            _buildTopDoctorsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(User? user) {
    if (user == null) {
      return Text('User is not logged in'); // Handle the null user case
    }

    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('users').doc(user.uid).get(), // Fetch user data from Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Handle error
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User not found'); // Handle case when user is not found
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>?; // Get user data

        if (userData == null) {
          return Text('User data not available'); // Handle null user data case
        }

        return Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/images/woman-dog.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${userData['name'] ?? "User"}', // Use the name from Firestore
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Email: ${userData['email'] ?? "No Email"}', // Display email
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: 'Search...',
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: Colors.blue[400],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/petdoc1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Alan Hathaway',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cardiovascular',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sun, Jan 15, 09:00am - 12:00pm',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.videocam, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildServiceSquareCard(Icons.pets, 'Pet Health', context, '/pet_health'),
        _buildServiceSquareCard(Icons.vaccines, 'Vaccination', context, '/vaccination'),
        _buildServiceSquareCard(Icons.schedule, 'Check-ups', context, '/appointments'),
        _buildServiceSquareCard(Icons.food_bank, 'Nutrition', context, '/nutrition'),
        _buildServiceSquareCard(Icons.healing, 'Reports', context, '/reports'),
        _buildServiceSquareCard(Icons.question_mark, 'Ask Doctor', context, '/grooming'),
        _buildServiceSquareCard(Icons.local_hospital, 'Emergency', context, '/emergency'),
        _buildServiceSquareCard(Icons.medical_services, 'Diagnostics', context, '/diagnostics'),
      ],
    );
  }

  Widget _buildServiceSquareCard(IconData icon, String label, BuildContext context, String routeName) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue[800], size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTopDoctorsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Doctors',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildDoctorCard('Dr. Jonathan', 'Cardiologist', const AssetImage('assets/images/petdoc1.jpg')),
                _buildDoctorCard('Dr. N Irene', 'Neurologist', const AssetImage('assets/images/doc.jpg')),
                _buildDoctorCard('Dr. S Richard', 'Orthopedic', const AssetImage('assets/images/petdoc2.jpg')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, ImageProvider image) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            specialty,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      // Navigate to the login screen after logging out
      Navigator.of(context).pushReplacementNamed('/login'); // Ensure you have a login route
    } catch (e) {
      // Handle any errors here
      print("Error during logout: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }
}
