// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

// class NewsDetailPage extends StatelessWidget {
//   final LocalNews news;

//   const NewsDetailPage({Key? key, required this.news}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Convert the JSON string to Quill document format
//     final quill.Document document = quill.Document.fromJson(news.content); // Ensure this matches your content format

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(news.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Image.network(news.coverImage), // Displaying the cover image
//             const SizedBox(height: 16),
//             Expanded(
//               child: quill.QuillEditor(
//                 controller: quill.QuillController(
//                   document: document,
//                   selection: const TextSelection.collapsed(offset: 0),
//                 ),
//                 readOnly: true, // Set to true for read-only mode
//                 autoFocus: false,
//                 expands: false,
//                 padding: EdgeInsets.zero,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
