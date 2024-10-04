import 'package:flutter/material.dart';

class VaccinationDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Vaccinations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildVaccinationTable(upcomingVaccinations),

            const SizedBox(height: 20),

            const Text(
              'Completed Vaccinations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildVaccinationTable(completedVaccinations),
          ],
        ),
      ),
    );
  }

  // Sample data for upcoming and completed vaccinations
  final List<Vaccination> upcomingVaccinations = [
    Vaccination('Rabies Vaccine', 'Mon, Jan 10, 2024, 09:00 AM'),
    Vaccination('Distemper Vaccine', 'Wed, Jan 15, 2024, 10:30 AM'),
    Vaccination('Parvo Vaccine', 'Fri, Jan 20, 2024, 11:00 AM'),
  ];

  final List<Vaccination> completedVaccinations = [
    Vaccination('Bordetella Vaccine', 'Sun, Dec 10, 2023, 09:00 AM'),
    Vaccination('Leptospirosis Vaccine', 'Tue, Dec 15, 2023, 01:00 PM'),
  ];

  // Vaccination data model
  Widget _buildVaccinationTable(List<Vaccination> vaccinations) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Vaccination')),
            DataColumn(label: Text('Date & Time')),
          ],
          rows: vaccinations
              .map(
                (vac) => DataRow(cells: [
              DataCell(Text(vac.name)),
              DataCell(Text(vac.dateTime)),
            ]),
          )
              .toList(),
        ),
      ),
    );
  }
}

// Vaccination model class
class Vaccination {
  final String name;
  final String dateTime;

  Vaccination(this.name, this.dateTime);
}
