import 'package:flutter/material.dart';

class CartItem {
  String imagePath;
  String title;
  String size;
  double price;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.title,
    required this.size,
    required this.price,
    this.quantity = 1
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyCartScreen(),
    );
  }
}

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      imagePath: 'assets/coffee-shop/caffe_mocha.png',
      title: "Caffe Mocha",
      size: "250 ml",
      price: 35000,
    ),
    CartItem(
      imagePath: 'assets/coffee-shop/cappuccino.jpeg',
      title: "Cappuccino",
      size: "250 ml",
      price: 30000,
    ),
    CartItem(
      imagePath: 'assets/coffee-shop/latte.jpeg',
      title: "Caffe Latte",
      size: "250 ml",
      price: 32000,
    ),
    CartItem(
      imagePath: 'assets/coffee-shop/espresso.jpeg',
      title: "Espresso",
      size: "100 ml",
      price: 25000,
    ),
    CartItem(
      imagePath: 'assets/coffee-shop/mocha.jpeg',
      title: "Dark Mocha",
      size: "100 ml",
      price: 25000,
    ),
  ];

  bool isPromoApplied = false;
  double discountPercentage = 10.0;

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _togglePromo() {
    setState(() {
      isPromoApplied = !isPromoApplied;
    });
  }

  double calculateSubtotal() {
    return cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  double calculateTotal() {
    double subtotal = calculateSubtotal();
    double ongkosKirim = 10000;
    double discount = isPromoApplied ? subtotal * (discountPercentage / 100) : 0;
    return subtotal + ongkosKirim - discount;
  }

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
            },
          ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: cartItems.isNotEmpty ? _buildCheckoutBar() : null,
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            "Keranjang Anda Kosong",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Silakan tambahkan beberapa item",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildCartItem(cartItems[index], index);
            },
          ),
        ),
        _buildPromoSection(),
        _buildPriceSummary(),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Dismissible(
      key: Key(item.title + index.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _removeItem(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(item.imagePath, width: 80, height: 80, fit: BoxFit.cover),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(item.size, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 8),
                  Text(
                    "Rp ${(item.price * item.quantity).toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 16),
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        "${item.quantity}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 16),
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Kode Promo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                isPromoApplied ? "Promo Aktif ($discountPercentage%)" : "Tambah Promo",
                style: TextStyle(
                  color: isPromoApplied ? Colors.green : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: isPromoApplied,
                onChanged: (value) => _togglePromo(),
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    double subtotal = calculateSubtotal();
    double ongkosKirim = 10000;
    double discount = isPromoApplied ? subtotal * (discountPercentage / 100) : 0;
    double total = subtotal + ongkosKirim - discount;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _priceRow("Subtotal", "Rp ${subtotal.toStringAsFixed(0)}"),
          SizedBox(height: 8),
          _priceRow("Ongkos Kirim", "Rp ${ongkosKirim.toStringAsFixed(0)}"),
          if (isPromoApplied) ...[
            SizedBox(height: 8),
            _priceRow("Diskon ($discountPercentage%)", "- Rp ${discount.toStringAsFixed(0)}", isDiscount: true),
          ],
          SizedBox(height: 8),
          Divider(),
          _priceRow("Total", "Rp ${total.toStringAsFixed(0)}", isBold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String price, {bool isBold = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isDiscount ? Colors.green : Colors.black,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isDiscount ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Rp ${calculateTotal().toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Checkout berhasil!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}