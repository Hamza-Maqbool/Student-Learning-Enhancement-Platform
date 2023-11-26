import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import 'coursePage.dart';
import 'package:http/http.dart' as http;


class NewCoursePage extends StatefulWidget {
  const NewCoursePage({Key? key}) : super(key: key);

  @override
  _NewCoursePageState createState() => _NewCoursePageState();
}

class _NewCoursePageState extends State<NewCoursePage> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = categories.first;
  }

  bool areTextFieldsEmpty(
      String courseName, String courseDescription) {
    return courseName.isEmpty || courseDescription.isEmpty ;
  }

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  bool isCreateCourseButtonPressed = false;

  void createCourse() async {
    try {
      // Validate fields and show error messages if necessary

      // Make an HTTP POST request to your API
      var response = await http.post(
        Uri.parse('http://localhost:3006/addCourse'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': courseNameController.text,
          'description': courseDescriptionController.text,
          'category': selectedCategory,
        }),
      );

      // Check the response status and handle accordingly
      if (response.statusCode == 200) {
        // Successful response, handle as needed
        print('Course created successfully');
      } else {
        // Handle error, show error message or log
        print('Failed to create course: ${response.body}');
      }
    } catch (error) {
      // Handle general error, show error message or log
      print('Error creating course: $error');
    }
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
                    SizedBox(width: 150),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          isCreateCourseButtonPressed = true;

                          // Check if a category is selected
                          if (selectedCategory == 'Select Course Category') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select a course category.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            );
                          } else if (areTextFieldsEmpty(
                              courseNameController.text,
                              courseDescriptionController.text)) {
                            if (isCreateCourseButtonPressed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please fill in all the fields.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                          } else {
                            createCourse();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Create Course',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    IconButton(
                      onPressed: () {

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
                  controller: courseNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Course Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Color(0xff235D60),
                    errorText: isCreateCourseButtonPressed &&
                        areTextFieldsEmpty(
                            courseNameController.text,
                            courseDescriptionController.text)
                        ? 'Field cannot be empty'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: courseDescriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Course Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Color(0xff235D60),
                    errorText: isCreateCourseButtonPressed &&
                        areTextFieldsEmpty(
                            courseNameController.text,
                            courseDescriptionController.text)
                        ? 'Field cannot be empty'
                        : null,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff235D60),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? value) {
                      if (value != null &&
                          value != 'Select Course Category') {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            backgroundColor: Color(0xff235D60),
                          ),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: Colors.white),
                    icon: Icon(Icons.arrow_downward, color: Color(0xff235D60)),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      width: 6,
                      color: Color(0xff235D60),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
