import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/coursePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(width: 12),
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
          SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 366,
                    height: 245,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff8f86a8),
                    ),
                  ),
                ),
                Positioned(
                  top: 30, // Move the image down
                  right: 0,
                  child: Image.asset(
                    'assets/images/home1.png',
                    width: 200,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 535, // Move the button down
                  left: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Course()),
                      );
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
                SizedBox(height: 20),
                Positioned(
                  bottom: 490, // Move the text down
                  left: 30,
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
                  bottom: 230, // Adjust the bottom position
                  left: 30, // Adjust the left position
                  child: SizedBox(
                    width: 366,
                    height: 245,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryBox('Programming'),
                        CategoryBox('Mathematics'),
                        CategoryBox('Communication'),
                      //  CategoryBox('Category 4'),
                        // Add more CategoryBox widgets as needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
final String categoryName;

CategoryBox(this.categoryName);

@override
Widget build(BuildContext context) {
  return Container(
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xff8f86a8),
    ),
    margin: EdgeInsets.all(8),
    child: Stack(
      children: [
        Positioned(
          top: 16, // Adjust the top position
          left: 16, // Adjust the left position
          child: Text(
            categoryName,
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
      ],
    ),
  );
}
}

