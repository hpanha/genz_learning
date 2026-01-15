import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';


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

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Blue background
          SizedBox.expand(
            child: Image.asset('assets/images/binaryBG.png', fit: BoxFit.fill),
          ),

          // White curved bottom section
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

          // Logo circle
          Positioned(
            top: screenHeight * 0.3,
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

           Positioned(
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  child: Marquee(
                    text: 'សូមស្វាគមន៍មកកាន់ ជេនហ្សី កូដដឺ',
                    style: GoogleFonts.moul(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    scrollAxis: Axis.horizontal,
                    textDirection: TextDirection.ltr,
                    blankSpace: 50.0,
                    velocity: 50.0,
                    pauseAfterRound: const Duration(seconds: 1),
                  ),
                ),
               
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Start Now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
    path.lineTo(0, 60); // start 60 px down from top-left
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
