import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
//import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
//import 'package:flutter_pptx/flutter_pptx.dart';
//import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

import 'package:path/path.dart';

class ContentDetailsPage extends StatelessWidget {
  final String courseName;
  final String contentTitle;

  ContentDetailsPage({required this.courseName, required this.contentTitle});

  Future<String?> getFileUrl() async {
    //print('here');
    //print(contentTitle);
    // try {
     final response = await http.get(
        Uri.parse('http://localhost:3006/getFileContentByContentTitle?contentTitle=$contentTitle'),
      );
     // print(response.body);
      if (response.statusCode == 200) {
        print('hello');

        //print(response.body);
        return response.body;
      } else {
        throw Exception('Failed to load file content. Server responded with status ${response.statusCode}');
      // }
    // } catch (error) {
    //   throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contentTitle),
      ),
      body: FutureBuilder<String?>(
        future: getFileUrl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final fileUrl = snapshot.data!;
            print(fileUrl);
            if (fileUrl.endsWith('.mp4')) {
              return VideoPlayerWidget(videoUrl: fileUrl);
            } else if (fileUrl.endsWith('.pptx')) {
              return PptxViewerWidget(pptxUrl: fileUrl);
            } else {

              return Center(child: Text('Unsupported file type: ${fileUrl.split('.').last}'));
            }
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_initializeVideoPlayer(videoUrl)),
    );
  }

  VideoPlayerController _initializeVideoPlayer(String videoUrl) {
    final headers = {'Cross-Origin': 'anonymous'};

    return VideoPlayerController.network(videoUrl, httpHeaders: headers)
      ..initialize().then((_) {
        // Initialization successful
      }).onError((error, stackTrace) {
        print('Error initializing video player: $error');
      });
  }
}


class PptxViewerWidget extends StatelessWidget {
  final String pptxUrl;

  PptxViewerWidget({required this.pptxUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // Handle opening PPTX file, e.g., launching another screen or a third-party library
          // You can use the pptxUrl to load the file.
        },
        child: Text('Open PPTX'),
      ),
    );
  }
}