import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  Future<void> _signup() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (password != confirmPassword) {
      setState(() {
        _error = "Passwords do not match.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse('http://10.0.2.2:8000/api/accounts/users/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully!")),
      );
      Navigator.pop(context); // Go back to login screen
    } else {
      final errorData = json.decode(response.body);
      setState(() {
        _error = errorData.toString();
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Color(0xFF3d4d6f),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Center(
                child: Icon(Icons.local_hospital,
                    size: 72, color: Colors.redAccent),
              ),
              SizedBox(height: 16),
              Center(
                child: Text('Register Account',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(height: 16),
              Center(
                  child: Text('Create an account for emergency use',
                      style: TextStyle(color: Colors.white70))),
              SizedBox(height: 32),
              _buildTextField(controller: usernameController, hint: 'Username'),
              SizedBox(height: 16),
              _buildTextField(controller: emailController, hint: 'Email'),
              SizedBox(height: 16),
              _buildTextField(
                  controller: firstNameController, hint: 'First Name'),
              SizedBox(height: 16),
              _buildTextField(
                  controller: lastNameController, hint: 'Last Name'),
              SizedBox(height: 16),
              _buildTextField(
                  controller: passwordController,
                  hint: 'Password',
                  obscure: true),
              SizedBox(height: 16),
              _buildTextField(
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
                  obscure: true),
              SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: TextStyle(color: Colors.redAccent)),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Create Account',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Already registered? Login',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                      )),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
