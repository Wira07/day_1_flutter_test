import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyCartScreen(),
  ));
}

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Keranjang Saya",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCartItem(
                    imagePath: 'assets/coffee-shop/caffe_mocha.png',
                    title: "Caffe Mocha",
                    size: "250 ml",
                    price: "Rp 35.000",
                  ),
                  SizedBox(height: 12),
                  _buildCartItem(
                    imagePath: 'assets/coffee-shop/cappuccino.jpeg',
                    title: "Cappuccino",
                    size: "250 ml",
                    price: "Rp 30.000",
                  ),
                  SizedBox(height: 12),
                  _buildCartItem(
                    imagePath: 'assets/coffee-shop/latte.jpeg',
                    title: "Caffe Latte",
                    size: "250 ml",
                    price: "Rp 32.000",
                  ),
                  SizedBox(height: 12),
                  _buildCartItem(
                    imagePath: 'assets/coffee-shop/espresso.jpeg',
                    title: "Espresso",
                    size: "100 ml",
                    price: "Rp 25.000",
                  ),
                  SizedBox(height: 12),
                  _buildCartItem(
                    imagePath: 'assets/coffee-shop/mocha.jpeg',
                    title: "Espresso",
                    size: "100 ml",
                    price: "Rp 25.000",
                  ),
                ],
              ),
            ),
            Divider(),
            _buildPromoCodeSection(),
            SizedBox(height: 12),
            _buildPriceSummary(),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildCheckoutButton(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem({required String imagePath, required String title, required String size, required String price}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(size, style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kode Promo atau Voucher Mahasiswa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
      ],
    );
  }

  Widget _buildPriceSummary() {
    return Column(
      children: [
        _priceRow("Subtotal", "Rp 2.869.700"),
        SizedBox(height: 8),
        _priceRow("Ongkos Kirim", "Rp 10.000"),
        SizedBox(height: 8),
        Divider(),
        _priceRow("Total", "Rp 2.879.700", isBold: true),
      ],
    );
  }

  Widget _priceRow(String label, String price, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        Text(price, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text("Checkout", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
