import 'package:flutter/material.dart';

import 'CoffeeDetailScreen.dart';
import 'app_main_screen.dart';

class CoffeeProfileScreen extends StatefulWidget {
  @override
  _CoffeeProfileScreenState createState() => _CoffeeProfileScreenState();
}

class _CoffeeProfileScreenState extends State<CoffeeProfileScreen> {
  int _selectedIndex = 2; // Default ke halaman Profile

  // Daftar halaman yang tersedia
  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    CoffeeProfileScreen(), // Halaman Profile
  ];

  // Fungsi untuk navigasi antar halaman
  void _onTabSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        // Back button tetap ada di kode, namun dihilangkan dari UI
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto Profil dan Nama
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/coffee-shop/me.jpg'),
            ),
            const SizedBox(height: 12),
            const Text(
              "Wira Sukma Saputra",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "wiralodrasaputra07@gmail.com",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Statistik (tanpa shadow, full width)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("250", "Coins", Icons.monetization_on),
                _buildStatColumn("180", "Discord", Icons.people_alt),
                _buildStatColumn("15", "Orders", Icons.coffee),
              ],
            ),
            const SizedBox(height: 20),
            // Daftar Pengaturan
            Expanded(
              child: ListView(
                children: [
                  _buildListTile("Personal", Icons.person, Colors.blue),
                  const Divider(),
                  _buildListTile("General", Icons.settings, Colors.orange),
                  const Divider(),
                  _buildListTile("Notification", Icons.notifications, Colors.green),
                  const Divider(),
                  _buildListTile("Dark", Icons.dark_mode, Colors.red),
                  const Divider(),
                  _buildListTile("Exit", Icons.exit_to_app, Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.brown[100],
          radius: 25,
          child: Icon(icon, size: 30, color: Colors.brown),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, IconData icon, Color iconColor) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Handle navigation atau aksi lainnya
      },
    );
  }
}

// Halaman Home
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Welcome to Home Screen!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// Halaman Cart
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Your Cart is Empty!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Hilangkan debug label
    home: CoffeeProfileScreen(),
  ));
}
