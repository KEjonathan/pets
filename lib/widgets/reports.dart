import 'package:flutter/material.dart';

class ReportsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Medical Reports'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Access Your Pet\'s Medical History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildMedicalHistory(),
              const SizedBox(height: 20),
              _buildRecommendations(),
              const SizedBox(height: 20),
              _buildRelatedFiles(),
            ],
          ),
        ),
      ),
    );
  }

  // Medical History section
  Widget _buildMedicalHistory() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medical History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Visit on Jan 15, 2024: Vaccination.\n'
                  '• Visit on Jan 10, 2024: Check-up for allergies.\n'
                  '• Visit on Dec 25, 2023: Surgery for spaying.\n'
                  '• Visit on Nov 30, 2023: Annual health check.\n',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Recommendations section
  Widget _buildRecommendations() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vet Recommendations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Continue current medication.\n'
                  '• Schedule dental cleaning every 6 months.\n'
                  '• Maintain a balanced diet with prescribed food.\n'
                  '• Regular exercise to maintain a healthy weight.\n',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Related Files section
  Widget _buildRelatedFiles() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Related Files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFileItem('Vaccination Certificate', 'Download'),
            _buildFileItem('Surgery Report', 'Download'),
            _buildFileItem('Health Check Report', 'Download'),
          ],
        ),
      ),
    );
  }

  // File item widget
  Widget _buildFileItem(String fileName, String action) {
    return ListTile(
      title: Text(fileName),
      trailing: ElevatedButton(
        onPressed: () {
          // Implement download functionality here
          _downloadFile(fileName);
        },
        child: Text(action),
      ),
    );
  }

  // Function to simulate file download
  void _downloadFile(String fileName) {
    // Simulate download functionality (you would implement actual download logic)
    print('Downloading $fileName...');
    // You could integrate a package like 'dio' for actual file download
  }
}
