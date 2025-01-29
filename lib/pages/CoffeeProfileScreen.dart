import 'package:flutter/material.dart';
import '../auth/Login.dart';
import 'CoffeeDetailScreen.dart';
import 'app_main_screen.dart';

class CoffeeProfileScreen extends StatefulWidget {
  @override
  _CoffeeProfileScreenState createState() => _CoffeeProfileScreenState();
}

class _CoffeeProfileScreenState extends State<CoffeeProfileScreen> {
  int _selectedIndex = 2; // Default ke halaman Profile

  // Fungsi untuk navigasi antar halaman
  void _onTabSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      Widget nextScreen;
      if (index == 0) {
        nextScreen = CoffeeAppMainScreen();
      } else if (index == 1) {
        nextScreen = CoffeeDetailScreen();
      } else {
        return; // Jika di profile, tidak pindah
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
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
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn("250", "Coins", Icons.monetization_on),
                _buildStatColumn("180", "Discord", Icons.people_alt),
                _buildStatColumn("15", "Orders", Icons.coffee),
              ],
            ),
            const SizedBox(height: 20),
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
                  _buildListTile(
                    "Exit",
                    Icons.exit_to_app,
                    Colors.red,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
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

  Widget _buildListTile(String title, IconData icon, Color iconColor, {VoidCallback? onTap}) {
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
      onTap: onTap,
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
    debugShowCheckedModeBanner: false,
    home: CoffeeProfileScreen(),
  ));
}
