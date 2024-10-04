import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Emergency Dashboard'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Emergency Information',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Emergency Contacts', Icons.contact_phone, Colors.blue),
              const SizedBox(height: 10),
              _buildEmergencyContacts(context),
              const SizedBox(height: 20),
              _buildSectionTitle('Emergency Tips', Icons.info, Colors.orange),
              const SizedBox(height: 10),
              _buildEmergencyTips(),
              const SizedBox(height: 20),
              _buildSectionTitle('Nearby Veterinary Clinics', Icons.local_hospital, Colors.green),
              const SizedBox(height: 10),
              _buildNearbyClinics(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder for a call action
          _emergencyCall(context, '256-800-000-000');
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.call),
      ),
    );
  }

  // Method to display section titles with an icon
  Widget _buildSectionTitle(String title, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Emergency Contacts section
  Widget _buildEmergencyContacts(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactItem(
              context,
              'Poison Control Center',
              '256-800-408-0958',
              'tel:2568004080958',
              Icons.warning,
              Colors.red,
            ),
            _buildContactItem(
              context,
              'Animal Control',
              '256-800-058-0958',
              'tel:2568000580958',
              Icons.pets,
              Colors.blue,
            ),
            _buildContactItem(
              context,
              'Veterinary Clinic',
              '256-800-008-0958',
              'tel:2568000080958',
              Icons.local_hospital,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // Contact item widget with call functionality and icons
  Widget _buildContactItem(BuildContext context, String title, String contactInfo,
      String phoneNumber, IconData icon, Color iconColor) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(contactInfo),
      trailing: IconButton(
        icon: const Icon(Icons.call),
        color: Colors.green,
        onPressed: () async {
          await _emergencyCall(context, phoneNumber);
        },
      ),
    );
  }

  Future<void> _emergencyCall(BuildContext context, String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $phoneNumber')),
      );
    }
  }

  // Emergency Tips section
  Widget _buildEmergencyTips() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '• Stay calm and assess the situation.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Keep your pet safe and away from further harm.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Contact your veterinarian or emergency clinic immediately.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Have a pet first-aid kit ready for emergencies.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Nearby Clinics section
  Widget _buildNearbyClinics() {
    return Column(
      children: [
        _buildClinicCard('Pet Care Clinic', '3rd Floor, Quality Shopping Mall, Kiwatule, Kampala, Uganda', 'assets/images/petShop.png'),
        _buildClinicCard('Vets on Call', 'Plot 22, Bukoto Street, Kamwokya, Kampala, Uganda', 'assets/images/petShop.png'),
        _buildClinicCard('Nairobi Pet Clinic', '16 Kabuusu Road, Kampala, Uganda', 'assets/images/petShop.png'),
      ],
    );
  }

  // Clinic card widget with AssetImages and icons
  Widget _buildClinicCard(String name, String address, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(address, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Icon(Icons.directions, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
