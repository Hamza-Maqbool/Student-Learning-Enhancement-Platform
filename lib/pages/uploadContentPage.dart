import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'coursePage.dart';

class UploadContent extends StatefulWidget {
  const UploadContent({Key? key}) : super(key: key);

  @override
  _NewCoursePageState createState() => _NewCoursePageState();
}

class _NewCoursePageState extends State<UploadContent> {


  @override
  TextEditingController contentNameController = TextEditingController();


  bool isCreateCourseButtonPressed = false;

  void createCourse() {
    // Implement your logic for creating a course
  }

  void showFeedbackPopup() {
    // Implement your logic for showing feedback popup
  }

  List<String> categories = [
    'Select Course Category',
    'Mathematics',
    'Communication',
    'Programming'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              Positioned(
                top: 10,
                left: 35,
                child: Row(
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
                    SizedBox(width: 210),
                    Flexible(
                      child: ElevatedButton(
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
                          'Post',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
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
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: contentNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Share with class',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: CupertinoColors.systemGrey),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showFeedbackPopup();
                    },
                    icon: const Icon(
                      Icons.attach_file,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),

                ],
              ),


            ],
          ),
        ],
      ),
    );
  }
}
