import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'package:http/http.dart' as http;
import 'coursePage.dart';

class UploadContent extends StatefulWidget {
  final String courseName;

  const UploadContent({Key? key, required this.courseName}) : super(key: key);

  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  TextEditingController contentNameController = TextEditingController();
  PlatformFile? pickedFile;

  void showFeedbackPopup() {
    // Implement your logic for showing feedback popup
  }
  Future<void> _uploadLesson() async {
    try {
      String lessonName = contentNameController.text;

      if (lessonName.isEmpty) {
        // Handle case where lesson name is empty
        return;
      }

      // Create a FormData object to send data as multipart/form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3006/createLesson'),
      );

      // Add lesson name and course name as fields
      request.fields['title'] = lessonName;
      request.fields['courseName'] = widget.courseName;

      // Add file if pickedFile is not null
      if (pickedFile != null) {
        // Use 'content' as the field name
        request.files.add(http.MultipartFile.fromBytes(
          'content',
          pickedFile!.bytes!,
          filename: pickedFile!.name,
        ));
      }

      // Log details
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files.map((file) => file.filename)}');

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Parse the response JSON if needed
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        // Handle successful response
        print('Lesson created successfully!');
        print('Response: $jsonResponse');
      } else {
        // Handle failed response
        print('Failed to create lesson. Status code: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
      }
    } catch (e) {
      // Handle errors
      print('Error creating lesson: $e');
    }
  }

  Future<void> _uploadFile(String filePath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://10.5.104.143:3006/uploadFile'));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully!');
      } else {
        print('File upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }

  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          pickedFile = result.files.single;
        });
        print('Picked file name: ${pickedFile!.name}');
      } else {
        print('User canceled file picking');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.04),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.59),
                    ElevatedButton(
                      onPressed: () {
                        _uploadLesson();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailsPage(widget.courseName, Color(0xff5a6ea0),
                              'assets/images/mathematics.png',),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showFeedbackPopup();
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                  child: GestureDetector(
                    onTap: () {
                      // Implement your logic for when the text field is clicked
                    },
                    child: Container(
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxHeight * 0.1,
                      padding: EdgeInsets.all(constraints.maxWidth * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.systemGrey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: contentNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Title of Learning Content',
                          hintStyle: TextStyle(color: CupertinoColors.systemGrey),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickFile();
                  },
                  child: Container(
                    width: constraints.maxWidth * 0.9,
                    height: constraints.maxHeight * 0.09,
                    padding: EdgeInsets.all(constraints.maxWidth * 0.01),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            color: CupertinoColors.systemGrey,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Attach File',
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
