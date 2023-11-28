import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'package:intl/intl.dart';

import 'coursePage.dart';

class UploadAssignment extends StatefulWidget {
  const UploadAssignment({Key? key}) : super(key: key);

  @override
  _UploadAssignmentState createState() => _UploadAssignmentState();
}

class _UploadAssignmentState extends State<UploadAssignment> {
  TextEditingController contentNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? deadline;


  void showFeedbackPopup() {
    // Implement your logic for showing feedback popup
  }

  void handleAttachFileClick() {
    // Implement your logic for when the "Attach File" row is clicked
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
                        controller: contentNameController,
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
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
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.attach_file,
                            color: CupertinoColors.systemGrey,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        const Text(
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
