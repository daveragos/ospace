import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:ospace/model/news.dart';
import 'package:ospace/model/report.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:ospace/publisher/controllers/post/post.dart';

class NewsDetailPage extends StatelessWidget {
  final LocalNews news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final quill.Document document = quill.Document.fromJson(json.decode(news.content!));

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title!),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () => _showReportDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              news.coverImage!.replaceFirst('localhost', '192.168.43.131'),
            ),
            const SizedBox(height: 16),
            quill.QuillEditor(
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              controller: quill.QuillController(
                readOnly: true,
                document: document,
                selection: const TextSelection.collapsed(offset: 0),
              ),
              // scrollable: false,
              // padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  // Function to show report dialog
  void _showReportDialog(BuildContext context) {
    String? selectedReason;
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Content'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                hint: const Text('Select a reason'),
                items: [
                  'Inappropriate Content',
                  'Misinformation',
                  'Spam',
                  'Other',
                ].map((String reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedReason = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Additional details (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedReason != null) {
                  Report report = Report(
                    newsId: news.id,  // assuming news.id uniquely identifies the news
                    reason: selectedReason,
                    description: descriptionController.text,
                  );

                  try {
                    await NewsService().reportNews(report);
                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Report submitted successfully.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a reason.')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
