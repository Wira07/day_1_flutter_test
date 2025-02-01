import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/MyCartScreen.dart';

class CoffeeDetailScreen extends StatefulWidget {
  const CoffeeDetailScreen({Key? key}) : super(key: key);

  @override
  _CoffeeDetailScreenState createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  int _quantity = 1;
  String _selectedSize = 'M';
  List<String> _selectedAddOns = [];
  String _selectedPromo = '';

  final List<String> _imagePaths = [
    'assets/coffee-shop/espresso.jpeg',
    'assets/coffee-shop/caffe_mocha.png',
    'assets/coffee-shop/latte.jpeg'
  ];

  final Map<String, double> _addonPrices = {
    'Extra Shot': 5000,
    'Whipped Cream': 3000,
    'Caramel Syrup': 4000,
    'Chocolate Drizzle': 4000,
  };

  final Map<String, int> _promos = {
    'PERTAMA20': 20,
    'KOPI15': 15,
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(const Duration(seconds: 3), _autoSlide);
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _autoSlide(Timer timer) {
    if (!mounted) return;
    setState(() {
      _currentPage = (_currentPage + 1) % _imagePaths.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  double _calculateTotalPrice() {
    double basePrice = 35000;
    double totalPrice = basePrice * _quantity;

    switch (_selectedSize) {
      case 'S': totalPrice *= 0.9; break;
      case 'L': totalPrice *= 1.2; break;
    }

    for (var addon in _selectedAddOns) {
      totalPrice += _addonPrices[addon]! * _quantity;
    }

    if (_selectedPromo.isNotEmpty && _promos.containsKey(_selectedPromo)) {
      double discount = totalPrice * (_promos[_selectedPromo]! / 100);
      totalPrice -= discount;
    }

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildImageSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildProductDetails(),
                  _buildDescriptionSection(),
                  _buildCustomizationSection(),
                  _buildPromotionsSection(),
                  _buildTotalPriceSection(),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) => Image.asset(
              _imagePaths[index],
              fit: BoxFit.cover,
            ),
            onPageChanged: (index) => setState(() => _currentPage = index),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kopi Mocha",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Kopi Panas / Dingin",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                "4.8 (230)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        "Perpaduan sempurna antara cita rasa kopi tradisional dengan sentuhan modern. Nikmati pengalaman kopi autentik yang menciptakan kenangan tak terlupakan dalam setiap tegukan.",
        style: TextStyle(color: Colors.grey[600], fontSize: 13),
      ),
    );
  }

  Widget _buildCustomizationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sesuaikan Pesanan",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text("Ukuran", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Row(
            children: ['S', 'M', 'L'].map((size) => Padding(
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedSize = size),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _selectedSize == size ? Colors.green : Colors.grey
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: _selectedSize == size ? Colors.green.shade50 : null,
                  ),
                  child: Text(size, style: TextStyle(fontSize: 13)),
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 12),
          Text("Tambahan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _addonPrices.keys.map((addon) => FilterChip(
              label: Text(addon, style: TextStyle(fontSize: 13)),
              selected: _selectedAddOns.contains(addon),
              backgroundColor: Colors.grey.shade100,
              selectedColor: Colors.green.shade100,
              checkmarkColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              labelStyle: TextStyle(
                color: _selectedAddOns.contains(addon) ? Colors.green.shade800 : Colors.black,
              ),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selectedAddOns.add(addon);
                  } else {
                    _selectedAddOns.remove(addon);
                  }
                });
              },
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Tersedia",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: _promos.entries.map((promo) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedPromo = _selectedPromo == promo.key ? '' : promo.key;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    color: _selectedPromo == promo.key ? Colors.green.shade50 : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promo.key,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Diskon ${promo.value}% untuk pesanan ini',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (_selectedPromo == promo.key)
                        Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Harga",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Rp ${_calculateTotalPrice().toStringAsFixed(0)}",
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCartScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Tambah ke Keranjang",
                  style: TextStyle(color: Colors.green)
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Beli Sekarang"),
            ),
          ),
        ],
      ),
    );
  }
}