import 'package:flutter/material.dart';
import 'dart:html' as html; // Import the 'dart:html' library for file input
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

class WordToHtmlConverter {
  Future<String> convertWordToHtml(String wordContent) async {
    // Replace this with your actual Word to HTML conversion logic
    // For simplicity, let's assume you already have the HTML content
    return await yourWordToHtmlConversionFunction(wordContent);
  }

  Future<String> yourWordToHtmlConversionFunction(String wordContent) async {
    // Your Word to HTML conversion logic here
    return wordContent;
  }
}

class WordToHtmlScreen extends StatefulWidget {
  @override
  _WordToHtmlScreenState createState() => _WordToHtmlScreenState();
}

class _WordToHtmlScreenState extends State<WordToHtmlScreen> {
  String htmlContent = '';

  Future<void> openWordFile() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input
      ..accept = '.docx' // Set the accepted file type (change as needed)
      ..click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);

      reader.onLoadEnd.listen((event) async {
        if (reader.result != null) {
          final wordContent = reader.result.toString();
          final converter = WordToHtmlConverter();
          final convertedHtml = await converter.convertWordToHtml(wordContent);

          setState(() {
            htmlContent = convertedHtml;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word to HTML Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: openWordFile,
              child: Text('Open Word File'),
            ),
            ElevatedButton(
              onPressed: () {
                print(htmlContent);
              },
              child: Text('Open Word File'),
            ),
            // SizedBox(height: 20),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: html.Element.html(htmlContent!),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
