import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:marquee/marquee.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FirstPage());
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔵 Fullscreen background image
          SizedBox.expand(
            child: Image.asset('assets/images/binaryBG.png', fit: BoxFit.cover),
          ),

          // ⚪ White curved bottom section
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: screenHeight * 0.55,
                color: Colors.white,
              ),
            ),
          ),

          // 🌟 Logo circle
          Positioned(
            top: screenHeight * 0.25,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/genz_logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 🏃 Scrolling marquee text
          Positioned(
            top: screenHeight * 0.65,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: Marquee(
                text: "សូមស្វាគមន៍មកកាន់ Genz Coder",
                style: GoogleFonts.moul(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 114, 17, 131),
                  fontWeight: FontWeight.w600,
                ),
                scrollAxis: Axis.horizontal,
                blankSpace: 20,
                velocity: 50,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 10,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(seconds: 1),
                decelerationCurve: Curves.easeOut,
              ),
            ),
          ),

          // 🎯 Start Now button
          Positioned(
            bottom: screenHeight * 0.15,
            child: SizedBox(
              width: screenWidth * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 5, 38, 87),
                        Color(0xFF1976D2),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Start Now",
                      style: GoogleFonts.moul(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ⚪ Bottom copyright
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Text(
              "© Copyright 2025",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for top curve
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 60);
    path.quadraticBezierTo(
      size.width / 2,
      180,
      size.width,
      60,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
