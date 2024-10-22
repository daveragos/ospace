import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final editor.QuillController _controller = editor.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  ValueNotifier<String> selected = ValueNotifier('All');

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
          backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
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
                DropdownButton<String>(
                  value: selected.value,
                  onChanged: (String? newValue) {
                    setState(() {
                      selected.value = newValue!;
                    });
                  },
                  items: <String>['All', 'Published', 'Draft'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                editor.QuillToolbar.simple(
                  controller: _controller,
                  configurations: editor.QuillSimpleToolbarConfigurations(

                  multiRowsDisplay: false,
                  showIndent: true,
                  // showImageButton: false,
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
                  // showVideoButton: false,
                  )
                ),
                Expanded(
                  child: editor.QuillEditor(
                    controller: _controller,
                    configurations: editor.QuillEditorConfigurations(

                        ),
                      focusNode: FocusNode(),
                      // scrollable: true,
                      // autoFocus: false,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollController: ScrollController(),
                      // expands: true,
                      // controller: _controller,
                      // readOnly: false
                      ),
                ),

                ElevatedButton(
                  child: Text('Add Post'),
                  onPressed: () async {
                  String json =
                      jsonEncode(_controller.document.toDelta().toJson());
                  String plainText =
                      jsonEncode(_controller.document.toPlainText());
                  print(json);
                  print(plainText);
                }),
                            ],
                          ),
              ))
        ],
      ),
    ));
  }
}
