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

  // Customization Variables
  int _quantity = 1;
  String _selectedSize = 'M';
  List<String> _selectedAddOns = [];

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
    double basePrice = 35000; // Base price for Caffe Mocha
    double totalPrice = basePrice * _quantity;

    // Add size price variation
    switch (_selectedSize) {
      case 'S':
        totalPrice *= 0.9;
        break;
      case 'L':
        totalPrice *= 1.2;
        break;
    }

    // Add add-on prices
    _selectedAddOns.forEach((addon) {
      totalPrice += _addonPrices[addon]! * _quantity;
    });

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildProductDetails(),
              _buildDescriptionSection(),
              _buildCustomizationSection(),
              _buildTotalPriceSection(),
              _buildActionButtons(),
            ]),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildImageSlider(),
      ),
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: Colors.black54,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.black54,
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _imagePaths.length,
      itemBuilder: (context, index) => Image.asset(
        _imagePaths[index],
        fit: BoxFit.cover,
      ),
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Caffe Mocha",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Hot / Ice Coffee",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 5),
              Text(
                "4.8 (230)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "A perfect harmony of traditional coffee taste with a modern touch. Experience an authentic coffee journey that creates lasting memories with every sip.",
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildCustomizationSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customize Your Coffee",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10),
          Text("Size", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: ['S', 'M', 'L'].map((size) =>
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSize = size;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _selectedSize == size ? Colors.green : Colors.grey
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedSize == size ? Colors.green.shade50 : null,
                    ),
                    child: Text(size),
                  ),
                )
            ).toList(),
          ),
          SizedBox(height: 15),
          Text("Add-ons", style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: _addonPrices.keys.map((addon) =>
                  FilterChip(
                    label: Text(addon),
                    selected: _selectedAddOns.contains(addon),
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: Colors.green.shade100,
                    checkmarkColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  )
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Price",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Rp ${_calculateTotalPrice().toStringAsFixed(0)}",
            style: GoogleFonts.poppins(
                fontSize: 18,
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
      padding: const EdgeInsets.all(16.0),
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
                side: BorderSide(color: Colors.green),
              ),
              child: Text("Add to Cart", style: TextStyle(color: Colors.green)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}