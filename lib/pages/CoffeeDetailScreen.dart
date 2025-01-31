import 'dart:async';
import 'package:day_1_flutter_test/pages/MyCartScreen.dart';
import 'package:flutter/material.dart';

class CoffeeDetailScreen extends StatefulWidget {
  @override
  _CoffeeDetailScreenState createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _imagePaths = [
    'assets/coffee-shop/promomax.png',
    'assets/coffee-shop/promomax.png',
    'assets/coffee-shop/promomax.png'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), _autoSlide);
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _autoSlide(Timer timer) {
    if (_currentPage < _imagePaths.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Detail", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Caffe Mocha",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Ice/Hot", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text("4.8 (230)", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Sebuah kedai kopi yang menghadirkan harmoni sempurna antara cita rasa tradisional dan sentuhan modern, menciptakan pengalaman ngopi yang otentik, berkesan, dan penuh kenangan. Dengan aroma kopi yang kuat yang menyambut setiap pengunjung sejak pertama kali melangkah masuk, kedai ini menawarkan suasana yang hangat, nyaman, dan penuh keakraban.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(height: 16),

            // **Ukuran Produk**
            Text(
              "Size",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSizeOption("S"),
                SizedBox(width: 12),
                _buildSizeOption("M"),
                SizedBox(width: 12),
                _buildSizeOption("L"),
              ],
            ),
            SizedBox(height: 20),

            // **Tombol Cart dan Buy Now**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCartScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    label: Text("ADD TO CART", style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("BUY NOW", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        size,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
