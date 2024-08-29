import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NewsDetails extends StatefulWidget {
  final String title;
  final String date;
  final String content;
  final String imageUrl;
  final String description;

  NewsDetails({
    required this.title,
    required this.date,
    required this.content,
    required this.imageUrl,
    required this.description,
  });

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
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
              Text('Back', style: TextStyle(color: Colors.black)),
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
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/news.jpg', 
                image: widget.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                imageErrorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Image.asset(
                      'assets/images/news.jpg', 
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.date,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: Html(
                data: widget.description,
                style: {
                  "body": Style(
                    fontSize: FontSize(16.0),
                    color: Colors.black87,
                    lineHeight: LineHeight(1.5),
                  ),
                },
                onLinkTap: (String? url, Map<String, String> attributes, dom.Element? element) {
                  if (url != null) {
                    print("Opening URL: $url");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
