import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  String newsTitle = 'Detailed News Title Here';
  String newsDate = 'Mon, 21 Dec 2020 14:57 GMT';
  String newsContent =
      'Full content of the news article goes here. This section should provide all the detailed information about the news, including text, images, and possibly other media. The content should be scrollable if it exceeds the screen size.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 8),
              Text('News Details', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://via.placeholder.com/600',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              newsTitle,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              newsDate,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              newsContent,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 16),
            // Add more content or widgets as needed
          ],
        ),
      ),
    );
  }
}
