import 'package:flutter/material.dart';
import '../models/course_detail_model.dart';
import '../services/course_service.dart';

class CourseDocxDetailPage extends StatelessWidget {
  final String slug;

  const CourseDocxDetailPage({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: FutureBuilder<CourseDetail>(
        future: CourseService.fetchCourseBySlug(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final course = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// Course image
              Image.network(
                course.imgUrl ?? '',
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 12),

              /// Category
              Text(
                course.category.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              /// Sections
              ...course.sections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Section title
                    Text(
                      section.titleKh,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Items
                    ...section.items.map((item) {
                      return Card(
                        child: ListTile(
                          title: Text(item.titleKh),
                          subtitle: Text(item.description ?? ''),
                        ),
                      );
                    }),

                    const SizedBox(height: 16),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
