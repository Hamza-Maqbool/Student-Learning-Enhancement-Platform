import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryDetailsPage extends StatelessWidget {
  final String categoryName;
  final Color boxColor;
  final String imagePath;

  CategoryDetailsPage(this.categoryName, this.boxColor, this.imagePath);

  Future<List<String>> fetchCourseNames(String category) async {
    final response = await http.get(
      Uri.parse('http://localhost:3006/getCourseNames/$category'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['courseNames'];
      return List<String>.from(data);
    } else {
      throw Exception('Failed to load course names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder<List<String>>(
            future: fetchCourseNames(categoryName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final courseNames = snapshot.data ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    courseNames.length,
                        (index) => Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: boxColor,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Text(
                              courseNames[index],
                              style: TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.03,
                            right: MediaQuery.of(context).size.width * 0.03,
                            child: Image.asset(
                              imagePath,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.02,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your navigation logic here
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
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
