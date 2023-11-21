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

  // Dummy data for lessons, replace it with your actual data
  List<String> lessons = ["Learning Content 1", "Learning Content 2", "Learning Content 3", "Learning Content 4"];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchNumberOfPeople();
    //await fetchNumberOfLearningContent();
  }

  Future<void> fetchNumberOfPeople() async {
    try {
      final Uri url = Uri.parse('http://localhost:3006/usersCount');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          numberOfPeople = data['count'];
        });
      } else {
        throw Exception('Failed to load the number of people');
      }
    } catch (error) {
      print('Error fetching the number of people: $error');
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
                      height: constraints.maxHeight * 0.23,
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
                              SizedBox(width: constraints.maxWidth * 0.5),
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
                          SizedBox(height: 80),
                          Row(
                            children: [
                              Text(
                                ' $numberOfPeople people learning',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: constraints.maxWidth * 0.1),
                              Text(
                                'learning content',
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
                            // Show the add lesson dialog for each lesson
                            _showAddLessonDialog();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),

                    // Horizontal list of lessons
                    Container(
                      height: constraints.maxHeight * 0.38,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                  lessons[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
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
