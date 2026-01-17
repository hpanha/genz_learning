import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart';
import 'message_page.dart';
import 'media_page.dart';
import 'notification_page.dart';
import 'register_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _bottomNav(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              _searchBar(),
              _banner(),
              _sectionLabel('សូមស្វាគមន៍មកកាន់ការសិក្សាផ្នែកទំនាក់ទំនង'),
              _instructorSection(),
              _techIcons(),
              _courseGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(30, 15, 30, 50),
    decoration: const BoxDecoration(
      color: Colors.purple,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RegisterPage(),
              ),
            );
          },
          child: const CircleAvatar(
            radius: 22,
            backgroundImage:
                AssetImage('assets/images/profile/phorn.jpg'),
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horm Sophorn',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Good morning!',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        const Spacer(),
       IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NotificationPage(),
            ),
          );
        },
        icon: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,        
            shape: BoxShape.circle,      
          ),
          child: const Icon(
            Icons.notifications,
            color: Colors.purple,         
          ),
        ),
      ),

      ],
    ),
  );
}



  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Transform.translate(
        offset: const Offset(0, -45),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            border: Border.all(color: Colors.purple.shade300, width: 1.5),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'ស្វែងរកវគ្កសិក្សា',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none, 
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }

    Widget _banner() {
    final List<String> imageList = [
      'assets/images/courseContainer.png',
      'assets/images/1.jpg',
    ];

    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 370,  
          height: 210,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 210,                        
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              viewportFraction: 1.0,             
            ),
            items: imageList.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  Widget _sectionLabel(String text) {
    return Container(
      width: double.infinity, 
      color: Colors.purple, 
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        textAlign: TextAlign.center, 
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  final List<String> instructorImages = [
  'assets/images/profile/panha.jpg',
  'assets/images/profile/phorn.jpg',
  'assets/images/profile/sreypich.jpg',
  'assets/images/profile/long.jpg',
  'assets/images/profile/makara.jpg',
];

  Widget _instructorSection() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instructor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: instructorImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(3), // border thickness
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(instructorImages[index]),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'What on your mind?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}


Widget _techIcons() {
  final List<String> techImages = [
    'assets/images/courseLogo/cpp.png',
    'assets/images/courseLogo/css.png',
    'assets/images/courseLogo/html.png',
    'assets/images/courseLogo/js.png',
    'assets/images/courseLogo/flutter.png',
    'assets/images/courseLogo/laravel.png',
    'assets/images/courseLogo/mysql.png',
    'assets/images/courseLogo/react.png',
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, 
      child: Row(
        children: techImages.map((image) {
          return Container(
            margin: const EdgeInsets.only(right: 12), 
            width: 40, 
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6), 
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}


Widget _courseGrid() {
  final courses = [
    {'title': 'វគ្កសិក្សា C++ Programming', 'image': 'assets/images/coursesImg/cppCourse.png'},
    {'title': 'វគ្កសិក្សា Web Design', 'image': 'assets/images/coursesImg/html&cssCourse.png'},
    {'title': 'វគ្កសិក្សា Flutter Development', 'image': 'assets/images/coursesImg/flutter.png'},
    {'title': 'វគ្កសិក្សា Java Programming', 'image': 'assets/images/coursesImg/javaCourse.png'},
    {'title': 'វគ្កសិក្សា Python Programming', 'image': 'assets/images/coursesImg/pythonCourse.png'},
  ];

  return Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      height: 190,
      child: GridView.builder(
        scrollDirection: Axis.horizontal, 
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, 
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return _courseCard(
            courses[index]['title']!,
            courses[index]['image']!,
          );
        },
      ),
    ),
  );
}

Widget _courseCard(String title, String imagePath) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.purple.shade200, width: 1.5),
    ),
    child: Stack(
      children: [
       Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), 
            child: Image.asset(
              imagePath,
              width: 250,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),


        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(60, 0, 0, 0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget _bottomNav(BuildContext context) {
  return BottomNavigationBar(
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.grey,
    currentIndex: 0,
    onTap: (index) {
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MediaPage()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MessagePage()),
        );
      }
      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_circle),
        label: 'Courses',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

}
