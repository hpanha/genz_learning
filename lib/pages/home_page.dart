import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:genz_learning/pages/course_docx_detail_page.dart';
import 'notification_page.dart';
import 'register_page.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import '../models/about.dart';
import '../services/about_service.dart';
import '../models/slider_item.dart';
import '../services/slider_service.dart';
import '../services/tool_service.dart';
import '../models/tool.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Optional: store your data locally for refresh
  List<SliderItem>? sliders;
  List<About>? instructors;
  List<Tool>? tools;
  List<Course>? courses;

  @override
  void initState() {
    super.initState();
    _loadData(); // initial load
  }

  Future<void> _loadData() async {
    sliders = await SliderService.fetchSliders();
    instructors = await AboutService.fetchAbout();
    tools = await ToolService.fetchSliders();
    courses = await CourseService.fetchCourses();
    setState(() {});
  }

  Future<void> _refresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                MaterialPageRoute(builder: (_) => RegisterPage()),
              );
            },
            child: const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/images/profile/phorn.jpg'),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Horm Sophorn', style: TextStyle(color: Colors.white, fontSize: 16)),
              Text('Good morning!', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications, color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Transform.translate(
        offset: const Offset(0, -45),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.purple.shade300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
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
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 370,
          height: 210,
          child: sliders == null
              ? const Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  options: CarouselOptions(
                    height: 210,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                  ),
                  items: sliders!.map((slider) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(slider.image),
                          fit: BoxFit.cover,
                        ),
                      ),
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _instructorSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Instructor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: instructors == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: instructors!.length,
                    itemBuilder: (context, index) {
                      final instructor = instructors![index];
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.purple, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(instructor.image),
                          backgroundColor: Colors.grey[200],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          const Text('What on your mind?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _techIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: tools == null
          ? const SizedBox(height: 40, child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tools!.map((tool) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.network(
                        tool.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 18),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _courseGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 190,
        child: courses == null
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) => _courseCard(context, courses![index]),
              ),
      ),
    );
  }

  Widget _courseCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CourseDocxDetailPage(slug: course.slug)),
        );
      },
      child: Container(
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
                  child: Image.network(
                    course.imgUrl,
                    width: 250,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
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
                  course.titleKh,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
