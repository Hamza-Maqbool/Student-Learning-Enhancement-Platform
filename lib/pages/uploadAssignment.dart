import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'coursePage.dart';

class UploadAssignment extends StatefulWidget {
  final String courseName;

  const UploadAssignment({Key? key,required this.courseName}) : super(key: key);

  @override
  _UploadAssignmentState createState() => _UploadAssignmentState();
}

class _UploadAssignmentState extends State<UploadAssignment> {
  TextEditingController assignmentTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? deadline;
  PlatformFile? pickedFile;


  void showFeedbackPopup() {
    // Implement your logic for showing feedback popup
  }

  void handleAttachFileClick() {
    // Implement your logic for when the "Attach File" row is clicked
  }
  Future<void> _uploadAssignment() async {
    try {
      String assignmentTitle = assignmentTitleController.text;
      String assignmentDescription = descriptionController.text;

      // FormData object to send data as multipart/form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3006/createAssignment'), // Assuming your backend endpoint is for creating a lesson
      );

      // Add assignment details as fields
      request.fields['title'] = assignmentTitle;
      request.fields['description'] = assignmentDescription;
      request.fields['courseName'] = widget.courseName;

      // Add deadline if available
      if (deadline != null) {
        request.fields['deadline'] = DateFormat('yyyy-MM-dd HH:mm').format(deadline!);
      }
      if (pickedFile != null) {
        // Use 'file' as the field name
        request.files.add(http.MultipartFile.fromBytes(
          'file',  // <-- Ensure that this field name matches the one expected by the server
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
        print('Assignment uploaded successfully!');
        print('Response: $jsonResponse');
      } else {
        // Handle failed response
        print('Failed to upload assignment. Status code: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
      }
    } catch (e) {
      // Handle errors
      print('Error uploading assignment: $e');
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != deadline) {
      setState(() {
        deadline = picked;
      });
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        _uploadAssignment();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
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
                        'Assign',
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
                        controller: assignmentTitleController,
                        style: TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Assignment Title',
                          hintStyle: TextStyle(color: CupertinoColors.systemGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                        controller: descriptionController,
                        style: TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Assignment Description',
                          hintStyle: TextStyle(color: CupertinoColors.systemGrey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _selectDate(context);
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
                            Icons.calendar_today,
                            color: CupertinoColors.systemGrey,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          deadline != null
                              ? 'Deadline: ${DateFormat('yyyy-MM-dd HH:mm').format(deadline!)}'
                              : 'Select Deadline',
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 16,
                          ),
                        ),

                      ],
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
