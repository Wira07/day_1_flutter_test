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

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF464545),
          image: DecorationImage(
            image: AssetImage("assets/coffee-shop/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/coffee-shop/minara.png',
                height: 150,
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
              _buildTextField("Email or username"),
              SizedBox(height: 15),
              _buildTextField("Password", obscureText: true),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text("Remember me", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text("Forgot Password?", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // White button with green border
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CoffeeAppMainScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFF4CAF50), width: 2),
                    ),
                  ),
                  child: Text("Sign in", style: TextStyle(color: Color(0xFF4CAF50))),
                ),
              ),
              SizedBox(height: 20),
              Text("or sign up with", style: TextStyle(color: Colors.white)),
              SizedBox(height: 15),
              _buildSocialIcons(),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
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

  Widget _buildTextField(String hintText, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.6), // Adjusted transparency
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.facebook, color: Colors.white, size: 40), onPressed: () {}),
        SizedBox(width: 15),
        IconButton(icon: Icon(Icons.g_translate, color: Colors.white, size: 40), onPressed: () {}),
        SizedBox(width: 15),
        IconButton(icon: Icon(Icons.apple, color: Colors.white, size: 40), onPressed: () {}),
      ],
    );
  }
}