import 'package:day_1_flutter_test/auth/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/app_main_screen.dart';
import 'Register.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerLogo;
  late AnimationController _controllerButton;
  late Animation<double> _fadeAnimationLogo;
  late Animation<double> _fadeAnimationButton;

  @override
  void initState() {
    super.initState();

    // Animation for the logo (fade-in)
    _controllerLogo = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimationLogo =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controllerLogo);

    // Animation for the button (fade-in)
    _controllerButton = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimationButton =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controllerButton);

    // Start the animations
    _controllerLogo.forward();
    _controllerButton.forward();
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    _controllerButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF464545),
          image: DecorationImage(
            image: AssetImage("assets/coffee-shop/bg.png"),
            // Ganti dengan gambar latar belakang
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo dengan tema kopi
              FadeTransition(
                opacity: _fadeAnimationLogo,
                child: Image.asset(
                  'assets/coffee-shop/minara.png', // Ganti dengan gambar kopi
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Coffee",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  hintText: 'Email or username',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      Text(
                        "Remember me",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Animated button with minimal fade-in effect
              FadeTransition(
                opacity: _fadeAnimationButton,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CoffeeAppMainScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Sign in"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("or sign up with", style: TextStyle(color: Colors.white)),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    icon:
                    Icon(Icons.g_translate, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    icon: Icon(Icons.apple, color: Colors.white, size: 40),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "REGISTER",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}