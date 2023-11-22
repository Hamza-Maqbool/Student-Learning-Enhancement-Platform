import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'categoryPage.dart';
import 'coursePage.dart';
import 'createCoursePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> courseNames;

  @override
  void initState() {
    super.initState();
    courseNames = fetchCourseNames();
  }

  Future<List<String>> fetchCourseNames() async {
    final response = await http.get(Uri.parse('http://localhost:3006/getCourseNames'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> courseNamesList = data['courseNames'];
      return courseNamesList.map((courseName) => courseName.toString()).toList();
    } else {
      throw Exception('Failed to load course names');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.search,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff8f86a8),
                        ),
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.09,
                      right: constraints.maxWidth * 0.05,
                      child: Image.asset(
                        'assets/images/home1.png',
                        width: constraints.maxWidth * 0.4,
                        height: constraints.maxHeight * 0.2,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.71,
                      left: constraints.maxWidth * 0.08,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //  // MaterialPageRoute(builder: (context) => CourseDetailsPage()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Start Learning',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Positioned(
                      bottom: constraints.maxHeight * 0.66,
                      left: constraints.maxWidth * 0.08,
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.36,
                      left: constraints.maxWidth * 0.08,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.3,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryBox(
                                'Programming', Color(0xff7F8D58), 'assets/images/programming.png'),
                            CategoryBox(
                                'Mathematics',Color(0xffb49295) , 'assets/images/mathematics.png'),
                            CategoryBox(
                                'Communication', Color(0xff5a6ea0), 'assets/images/communication.png'),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.31,
                      left: constraints.maxWidth * 0.08,
                      child: Row(
                        children: [
                          Text(
                            'Courses',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.63),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewCoursePage()),
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.01,
                      left: constraints.maxWidth * 0.08,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.32,
                        child: FutureBuilder<List<String>>(
                          future: courseNames,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<String> courseNames = (snapshot.data as List<dynamic>).cast<String>();

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: courseNames.length,
                                itemBuilder: (context, index) {
                                  return CourseCard(
                                    courseNames[index],
                                    Color(0xff5a6ea0),
                                    'assets/images/mathematics.png',
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String categoryName;
  final Color boxColor;
  final String imagePath;

  CategoryBox(this.categoryName, this.boxColor, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsPage(categoryName),
          ),
        );
      },
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: boxColor,
        ),
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 30,
              child: Image.asset(
                imagePath,
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 175,
              left: 16,
              child: Text(
                ' courses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String courseName;
  final Color boxxColor;
  final String imageRoute;

  CourseCard(this.courseName, this.boxxColor, this.imageRoute);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(courseName, boxxColor, imageRoute),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: boxxColor,
        ),
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                courseName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                ' courses',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 30,
              child: Image.asset(
                imageRoute,
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
