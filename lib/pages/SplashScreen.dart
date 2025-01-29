import 'package:day_1_flutter_test/auth/Login.dart';
import 'package:flutter/material.dart';
import 'app_main_screen.dart'; // Pastikan file CoffeeAppMainScreen ada di folder pages
import '../widgets/common_button.dart'; // Pastikan file ini ada dan berisi widget CommonButton

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  // Untuk animasi opacity
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Animasi dengan durasi 2 detik
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Gambar background full layar
            Positioned.fill(
              child: Image.asset(
                "assets/coffee-shop/bg.png",
                fit: BoxFit.cover,
              ),
            ),
            // Konten teks di atas gambar
            Positioned(
              bottom: size.height * 0.1, // Menggunakan persentase dari tinggi layar
              right: 0,
              left: 0,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: opacity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Fall In Love with Coffee in Blissful Delight!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10), // Jarak antar elemen
                      Text(
                        "Coffe Mimih Fadhi adalah sebuah tempat kedai kopi yang menawarkan suasana hangat dan nyaman bagi para pengunjung.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        title: "Get Started",
                        onTab: () {
                          // Navigasi ke CoffeeAppMainScreen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
