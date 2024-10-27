import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:image_picker/image_picker.dart';
import 'package:ospace/publisher/models/post.dart';
import 'package:ospace/publisher/screens/post/preview_post.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final editor.QuillController _controller = editor.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  ValueNotifier<String> selected = ValueNotifier('All');

  File? _selectedImage;

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              String json = jsonEncode(_controller.document.toDelta().toJson());
              String plainText = jsonEncode(_controller.document.toPlainText());
              print(json);
              print(plainText);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewPost(
                  post: Post(
                title: _titleController.text,
                content: _controller.document.toDelta(),
                coverImage: _selectedImage!.path,
              )),
            ),
          );
        },
        child: const Icon(Icons.remove_red_eye),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: editor.QuillEditor(
                  focusNode: FocusNode(),
                  configurations: editor.QuillEditorConfigurations(
                    dialogTheme: editor.QuillDialogTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      dialogBackgroundColor: Colors.blueGrey,
                    ),
                    scrollable: true,
                    autoFocus: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    expands:
                        true, // This will let it expand within the available height
                    checkBoxReadOnly: false,
                  ),
                  controller: _controller,
                  scrollController: ScrollController(),
                ),
              ),
            ),

            editor.QuillToolbar.simple(
              configurations: editor.QuillSimpleToolbarConfigurations(
                multiRowsDisplay: false,
                showIndent: true,
                dialogTheme: editor.QuillDialogTheme(
                    inputTextStyle: TextStyle(color: Colors.white),
                    labelTextStyle: TextStyle(color: Colors.white)),
                showLink: true,
                showDirection: false,
                showBackgroundColorButton: false,
                showRedo: true,
                showSearchButton: true,
                showFontSize: false,
                showAlignmentButtons: true,
                showCodeBlock: true,
                showFontFamily: false,
                showInlineCode: false,
              ),
              controller: _controller,
            ),
            //image picker and previewer
            Row(
              children: [
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),
              ],
            ),
          ],
        ),
      )),
    ));
  }
}
