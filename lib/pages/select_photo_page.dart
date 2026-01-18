import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectPhotoPage extends StatefulWidget {
  const SelectPhotoPage({super.key});

  @override
  State<SelectPhotoPage> createState() => _SelectPhotoPageState();
}

class _SelectPhotoPageState extends State<SelectPhotoPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (!mounted) return; // ✅ safe check

    if (file != null) {
      Navigator.pop(context, FileImage(File(file.path)));
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (!mounted) return; // ✅ safe check

    if (file != null) {
      Navigator.pop(context, FileImage(File(file.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Photo'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: _pickFromGallery,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: _pickFromCamera,
            ),
          ],
        ),
      ),
    );
  }
}
