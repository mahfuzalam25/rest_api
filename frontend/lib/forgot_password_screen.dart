import 'package:flutter/material.dart';
import 'verify_code_screen.dart'; // We'll create this next

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3a59),
      appBar: AppBar(
        backgroundColor: Color(0xFF2e3a59),
        elevation: 0,
        title: Text(
          'Forgot Password',
          style: TextStyle(color: const Color.fromARGB(255, 234, 232, 232)),
        ),
      ), // <-- Added this missing closing parenthesis
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Spacer(),
              Text(
                'Enter your email to reset password',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Color(0xFF3d4d6f),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      // show error dialog
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Please enter your email'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                      );
                      return;
                    }
                    // Navigate to code verification page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyCodeScreen(email: email),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Send Verification Code',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
