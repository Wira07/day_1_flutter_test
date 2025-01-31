import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
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
              Image.asset('assets/coffee-shop/minara.png', height: 150),
              SizedBox(height: 20),
              Text(
                "Register",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              _buildTextField("Full Name"),
              SizedBox(height: 15),
              _buildTextField("Email"),
              SizedBox(height: 15),
              _buildTextField("Password", obscureText: true),
              SizedBox(height: 15),
              _buildTextField("Confirm Password", obscureText: true),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFF4CAF50), width: 2),
                    ),
                  ),
                  child: Text("Sign up", style: TextStyle(color: Color(0xFF4CAF50))),
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.white),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
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
}
