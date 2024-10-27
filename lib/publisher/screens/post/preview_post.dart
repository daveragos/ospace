import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ospace/publisher/models/post.dart';

class PreviewPost extends StatefulWidget {
  const PreviewPost({super.key, required this.post});

  final Post post;

  @override
  State<PreviewPost> createState() => _PreviewPostState();
}

class _PreviewPostState extends State<PreviewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Post'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Image.file(
                File(widget.post.coverImage),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Text(
                widget.post.title,
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.post.content,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}