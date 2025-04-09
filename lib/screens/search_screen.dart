import 'package:flutter/material.dart';
import 'medicine_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF353F54),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: Colors.white54),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic_none_rounded, color: Colors.white54),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Search Results or History
              Text(
                _searchQuery.isEmpty ? 'Search History' : 'Alternative for "$_searchQuery"',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Medicine List
              Expanded(
                child: ListView(
                  children: [
                    _buildMedicineCard(
                      name: 'Motrin',
                      activeIngredient: 'Ibuprofen 200mg',
                      manufacturer: 'Pfizer',
                      pharmacy: 'AA Pharmacy',
                      price: 'RM 5',
                      isBestDeal: true,
                    ),
                    const SizedBox(height: 8),
                    _buildMedicineCard(
                      name: 'Advil',
                      activeIngredient: 'Ibuprofen 200mg',
                      manufacturer: 'Pfizer',
                      pharmacy: 'AA Pharmacy',
                      price: 'RM 10',
                    ),
                    const SizedBox(height: 8),
                    _buildMedicineCard(
                      name: 'Ibuprofen',
                      activeIngredient: 'Ibuprofen 200mg',
                      manufacturer: 'Pfizer',
                      pharmacy: 'AA Pharmacy',
                      price: 'RM 3',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineCard({
    required String name,
    required String activeIngredient,
    required String manufacturer,
    required String pharmacy,
    required String price,
    bool isBestDeal = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicineDetailScreen(
              name: name,
              manufacturer: manufacturer,
              activeIngredient: activeIngredient,
              price: price,
              isBestDeal: isBestDeal,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF353F54),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Active Ingredient: $activeIngredient',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'Manufacturer: $manufacturer',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        'Available at: $pharmacy',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B3446),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (isBestDeal) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Best Deals',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 