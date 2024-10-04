import 'package:flutter/material.dart';

class DiagnosisDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Diagnosis Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Understanding Your Pet\'s Health',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildDiagnosticServices(),
              const SizedBox(height: 20),
              _buildCommonHealthIssues(),
              const SizedBox(height: 20),
              _buildHealthTips(),
            ],
          ),
        ),
      ),
    );
  }

  // Diagnostic Services section
  Widget _buildDiagnosticServices() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diagnostic Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Blood Tests: Detect infections and other health issues.\n'
                  '• X-rays: Identify fractures or foreign objects.\n'
                  '• Urinalysis: Assess kidney function and hydration.\n'
                  '• Ultrasound: Visualize internal organs and tissues.\n',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Common Health Issues section
  Widget _buildCommonHealthIssues() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common Health Issues',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHealthIssue('Fleas and Ticks', 'Signs: Scratching, biting, hair loss.'),
                _buildHealthIssue('Ear Infections', 'Signs: Shaking head, odor, redness.'),
                _buildHealthIssue('Obesity', 'Signs: Excess weight, difficulty breathing.'),
                _buildHealthIssue('Dental Problems', 'Signs: Bad breath, difficulty eating.'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Health issue widget
  Widget _buildHealthIssue(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '• $title: $description',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Health Tips section
  Widget _buildHealthTips() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Health Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '• Regular vet check-ups are crucial for early detection.\n'
                  '• Keep your pet’s vaccinations up to date.\n'
                  '• Monitor your pet’s diet and exercise to maintain a healthy weight.\n'
                  '• Pay attention to any behavioral changes, as they can indicate health issues.\n',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
