import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001B5E), Color(0xFF0033A0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // 🔵 Logo
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    "GENZ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🇰🇭 Title
              const Text(
                "បង្កើតគណនី",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              // 📋 Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    inputField("Username", Icons.person),
                    inputField("Email", Icons.email),
                    inputField("Phone Number", Icons.phone),
                    inputField("Password", Icons.lock, isPassword: true),
                    inputField(
                      "Password Confirmation",
                      Icons.lock,
                      isPassword: true,
                    ),

                    const SizedBox(height: 10),

                    // ☑️ Checkbox
                    Row(
                      children: const [
                        Checkbox(value: true, onChanged: null),
                        Expanded(
                          child: Text(
                            "Accept our GenZ policy !",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // 🔘 Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Sign in"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Sign up"),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🌐 Social icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.facebook, color: Colors.blue),
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.g_mobiledata, color: Colors.red),
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.code),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // © Footer
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "© Copyright 2025",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable input
  static Widget inputField(
    String hint,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
