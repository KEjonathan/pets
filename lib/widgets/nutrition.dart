import 'package:flutter/material.dart';

class NutritionDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Nutrition Dashboard'),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildNutritionalGuidelines(),
            const SizedBox(height: 20),
            _buildFoodRecommendations(),
            const SizedBox(height: 20),
            _buildNutritionTips(),
          ],
        ),
      ),
    );
  }

  // Header section
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Pet\'s Nutrition Needs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Icon(Icons.pets, size: 32, color: Colors.green.shade700),
      ],
    );
  }

  // Nutritional Guidelines section
  Widget _buildNutritionalGuidelines() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutritional Guidelines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildGuidelineItem(Icons.fitness_center, 'Protein', 'Essential for muscle growth and maintenance.'),
            _buildGuidelineItem(Icons.energy_savings_leaf, 'Carbohydrates', 'Important for energy.'),
            _buildGuidelineItem(Icons.water_drop, 'Fats', 'Provide energy and support cell growth.'),
            _buildGuidelineItem(Icons.health_and_safety, 'Vitamins & Minerals', 'Vital for overall health and immunity.'),
          ],
        ),
      ),
    );
  }

  // Guideline item widget
  Widget _buildGuidelineItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Food Recommendations section
  Widget _buildFoodRecommendations() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended Foods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFoodItem(Icons.pets, 'Dog Food - Chicken & Brown Rice', 'High-quality protein for muscle support.'),
            _buildFoodItem(Icons.pets, 'Cat Food - Salmon & Sweet Potato', 'Rich in Omega-3 fatty acids.'),
            _buildFoodItem(Icons.pets, 'Dog Food - Lamb & Oats', 'Great for dogs with sensitive stomachs.'),
            _buildFoodItem(Icons.pets, 'Cat Food - Turkey & Quinoa', 'Ideal for weight management.'),
          ],
        ),
      ),
    );
  }

  // Food item widget
  Widget _buildFoodItem(IconData icon, String name, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.green.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Nutrition Tips section
  Widget _buildNutritionTips() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutrition Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTipItem('Always consult your vet for the best dietary plan.'),
            _buildTipItem('Monitor your pet\'s weight and adjust food portions accordingly.'),
            _buildTipItem('Provide fresh water daily.'),
            _buildTipItem('Introduce new foods gradually to avoid digestive upset.'),
          ],
        ),
      ),
    );
  }

  // Tip item widget
  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: Text(tip, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
