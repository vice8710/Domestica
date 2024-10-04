import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.kitchen, 'name': 'Kitchen'},
    {'icon': Icons.window, 'name': 'Window'},
    {'icon': Icons.living, 'name': 'Living Room'},
    {'icon': Icons.ac_unit, 'name': 'AC Service'},
  ];

  final List<Map<String, String?>> services = [
    {
      'image': 'assets/assets/kitchen.jpg',
      'name': 'Kitchen Service',
      'rating': '4.5',
      'reviews': '150',
      'price': '\$50',
      'oldPrice': '\$70',
      'provider': 'Provider A',
    },
    {
      'image': 'assets/assets/window.jpg',
      'name': 'Window Cleaning',
      'rating': '4.8',
      'reviews': '85',
      'price': '\$30',
      'oldPrice': '\$40',
      'provider': 'Provider B',
    },
    // Add more services as necessary
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Section
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  icon: categories[index]['icon'] as IconData,
                  name: categories[index]['name'] as String,
                );
              },
            ),
            // Services Section
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(
                  image: services[index]['image'] ?? '',
                  name: services[index]['name'] ?? 'Unknown',
                  rating: services[index]['rating'] ?? 'N/A',
                  reviews: services[index]['reviews'] ?? '0',
                  price: services[index]['price'] ?? 'N/A',
                  oldPrice: services[index]['oldPrice'] ?? 'N/A',
                  provider: services[index]['provider'] ?? 'Unknown',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String name;

  CategoryCard({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          Text(name),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String reviews;
  final String price;
  final String oldPrice;
  final String provider;

  ServiceCard({
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.oldPrice,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(image, errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error); // Fallback if image is not found
          }),
          Text(name),
          Text('Rating: $rating'),
          Text('Reviews: $reviews'),
          Text('Price: $price'),
          Text('Old Price: $oldPrice'),
          Text('Provider: $provider'),
        ],
      ),
    );
  }
}
