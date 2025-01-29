import 'dart:async'; // Import untuk Timer
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'CoffeeDetailScreen.dart';
import 'CoffeeProfileScreen.dart';

class CoffeeAppMainScreen extends StatefulWidget {
  const CoffeeAppMainScreen({super.key});

  @override
  State<CoffeeAppMainScreen> createState() => _CoffeeAppMainScreenState();
}

class _CoffeeAppMainScreenState extends State<CoffeeAppMainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _promoImages = [
    'assets/coffee-shop/promomax.png',
    'assets/coffee-shop/promo2.jpeg',
    'assets/coffee-shop/promo3.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startImageSlider();
  }

  // Fungsi untuk mengubah gambar secara otomatis setiap 3 detik
  void _startImageSlider() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _promoImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Pastikan untuk melepaskan controller saat selesai
    super.dispose();
  }

  // Fungsi untuk format harga menjadi Rupiah
  String formatCurrency(double amount) {
    final NumberFormat currencyFormatter =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return currencyFormatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background putih setengah bawah
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 2, // Kurangi bagian hitam
                  child: Container(color: Colors.black),
                ),
                Expanded(
                  flex: 3, // Tambah bagian putih
                  child: Container(color: Colors.white),
                ),
              ],
            ),
          ),
          // Konten utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Location',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            'Minara House, Kuningan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search coffee',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.filter_list, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Promo banner with PageView
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Promo',
                              style:
                              TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            'Buy one get one FREE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // PageView untuk gambar promo yang berganti-ganti
                        PageView.builder(
                          controller: _pageController,
                          itemCount: _promoImages.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                _promoImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryButton(title: 'All Coffee', isSelected: true),
                        const SizedBox(width: 13), // Jarak antar elemen
                        CategoryButton(title: 'Macchiato'),
                        const SizedBox(width: 13),
                        CategoryButton(title: 'Latte'),
                        const SizedBox(width: 13),
                        CategoryButton(title: 'Americano'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Coffee list
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final List<Map<String, dynamic>> coffeeData = [
                          {
                            'title': 'Caffe Mocha',
                            'subtitle': 'Deep Foam',
                            'price': 25000.0,
                            'imageUrl': 'assets/coffee-shop/caffe_mocha.png',
                          },
                          {
                            'title': 'Flat White',
                            'subtitle': 'Espresso',
                            'price': 22000.0,
                            'imageUrl': 'assets/coffee-shop/flat_white.jpg',
                          },
                          {
                            'title': 'Latte',
                            'subtitle': 'Creamy Milk',
                            'price': 20000.0,
                            'imageUrl': 'assets/coffee-shop/flat_white.jpg',
                          },
                          {
                            'title': 'Americano',
                            'subtitle': 'Black Coffee',
                            'price': 28000.0,
                            'imageUrl': 'assets/coffee-shop/caffe_mocha.png',
                          },
                        ];

                        final coffee = coffeeData[index % coffeeData.length];

                        return CoffeeCard(
                          title: coffee['title'] as String,
                          subtitle: coffee['subtitle'] as String,
                          price: coffee['price'] as double,
                          imageUrl: coffee['imageUrl'] as String,
                          formatCurrency: formatCurrency, // Kirim fungsi
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            // Kembali ke HomeScreen (Pastikan nama class benar)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CoffeeAppMainScreen()),
            );
          } else if (index == 1) {
            // Pindah ke CoffeeDetailScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoffeeDetailScreen()),
            );
          } else if (index == 2) {
            // Pindah ke Profile Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoffeeProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.brown),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.brown),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.brown),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryButton({required this.title, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown : Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[400],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String Function(double) formatCurrency; // Tambahkan fungsi formatCurrency

  const CoffeeCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.formatCurrency, // Terima fungsi
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatCurrency(price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
