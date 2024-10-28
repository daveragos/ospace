import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:ospace/publisher/models/post.dart';

class PreviewPost extends StatefulWidget {
  const PreviewPost({super.key, required this.post});

  final Post post;

  @override
  State<PreviewPost> createState() => _PreviewPostState();
}

class _PreviewPostState extends State<PreviewPost> {
  late final editor.QuillController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the QuillController with the content from the post
    _controller = editor.QuillController(
      document: editor.Document.fromDelta(widget.post.content),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(widget.post.coverImage),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                widget.post.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ShaderMask(
                shaderCallback: ((bounds) {
                  return const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(189, 218, 218, 252),
                        Color.fromARGB(189, 218, 218, 252),
                        Colors.transparent
                      ]).createShader(bounds);
                }),
                child: editor.QuillEditor(
                  controller: _controller,
                  scrollController: ScrollController(),
                  focusNode: FocusNode(
                    canRequestFocus: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
