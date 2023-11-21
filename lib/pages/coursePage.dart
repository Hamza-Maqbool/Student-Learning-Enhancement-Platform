import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studentlearningenhancement/pages/uploadAssignment.dart';
import 'package:studentlearningenhancement/pages/uploadContentPage.dart';

class CourseDetailsPage extends StatefulWidget {
  final String courseName;
  final Color boxxColor;
  final String imageRoute;

  CourseDetailsPage(this.courseName, this.boxxColor, this.imageRoute);

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  int numberOfPeople = 0;
  int numberOfLearningContent = 0;
  List<String> learningContentTitles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchNumberOfLearningContent();
    await fetchLearningContentTitles();
  }

  Future<void> fetchNumberOfLearningContent() async {
    try {
      final Uri url = Uri.parse('http://localhost:3006/lessonsCount?courseName=${widget.courseName}');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          numberOfLearningContent = data['count'];
        });
      } else {
        throw Exception('Failed to load the number of learning content');
      }
    } catch (error) {
      print('Error fetching the number of learning content: $error');
    }
  }
  Future<void> fetchLearningContentTitles() async {
    try {
      final Uri url = Uri.parse('http://localhost:3006/getLessons?courseName=${widget.courseName}');
      final response = await http.get(url);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['titles'] != null) {
          setState(() {
            learningContentTitles = List<String>.from(data['titles']);
          });
        } else {
          print('Data or titles is null');
        }
      } else {
        throw Exception('Failed to load learning content titles');
      }
    } catch (error) {
      print('Error fetching learning content titles: $error');
    }
  }


  void _showAddLessonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: FractionallySizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadContent(courseName: widget.courseName),
                        ),
                      );
                    },
                    child: const Text(
                      "Upload Learning Content",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadAssignment(),
                        ),
                      );
                    },
                    child: const Text(
                      "Upload Assignment",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(child: Container()), // Expanded space to center the image
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        widget.imageRoute,
                        width: constraints.maxWidth * 0.37,
                        height: constraints.maxHeight * 0.17,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.3,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: widget.boxxColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.courseName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: constraints.maxWidth * 0.4),
                              IconButton(
                                icon: Icon(
                                  Icons.collections,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {
                                  // Add save functionality
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'by teachername',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 70),
                          Row(
                            children: [
                              Text(
                                ' $numberOfLearningContent learning contents',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: constraints.maxWidth,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Lessons',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.6),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            _showAddLessonDialog();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: constraints.maxHeight * 0.38,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: learningContentTitles.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Handle the tap event for the item at index
                              print('Tapped on item at index $index');
                              // Add your logic to navigate or perform any action
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: widget.boxxColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.04),
                                  Text(
                                    learningContentTitles[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
