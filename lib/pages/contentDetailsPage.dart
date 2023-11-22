import 'package:flutter/material.dart';

class ContentDetailsPage extends StatelessWidget {
  final String courseName;
  final String contentTitle;

  ContentDetailsPage({required this.courseName, required this.contentTitle});

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
                      icon: Icon(Icons.arrow_back, color: Colors.black),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentDetailsPage(
                                    courseName: widget.courseName,
                                    contentTitle: learningContentTitles[index],
                                  ),
                                ),
                              );
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
