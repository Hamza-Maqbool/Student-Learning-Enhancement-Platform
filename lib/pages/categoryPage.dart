import 'package:flutter/material.dart';
class CategoryDetailsPage extends StatelessWidget {
  final String categoryName;

  CategoryDetailsPage(this.categoryName);

  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying category details
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
      ),
      body: Center(
        child: Text('Details for Category: $categoryName'),
      ),
    );
  }
}