import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ospace/model/news.dart';
import 'package:ospace/publisher/controllers/post/post.dart';

class EditPost extends StatefulWidget {
  final LocalNews news;

  const EditPost({super.key, required this.news});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _coverImage;
  File? _selectedImage; // Store the selected image file

  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.news.title);
    _contentController = TextEditingController(text: widget.news.content);
    _coverImage = widget.news.coverImage!;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Store the selected image
      });
    }
  }

  Future<void> _updatePost() async {
    LocalNews updatedNews = LocalNews(
      id: widget.news.id,
      title: _titleController.text,
      content: json.encode(_contentController.text),
      coverImage: _selectedImage != null
          ? _selectedImage!.path // Store the path of the selected image
          : _coverImage,
      status: widget.news.status,
      reports: widget.news.reports,
    );

    try {
      await NewsService().updateNews(updatedNews, _selectedImage); // Pass the selected image file
      Navigator.of(context).pop(true); // Go back to previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updatePost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : (widget.news.coverImage != null && widget.news.coverImage!.isNotEmpty)
                        ? Image.network(
                            widget.news.coverImage!.replaceAll('localhost', '192.168.43.131'),
                            fit: BoxFit.cover,
                          )
                        : const Center(child: Text('Select Cover Image')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
