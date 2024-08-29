import 'package:flutter/material.dart';
import 'package:flutter_application_1/FavoritesScreen.dart';
import 'package:flutter_application_1/NewsDetails.dart';
import 'package:flutter_application_1/API/controllers/newsController.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<Map<String, dynamic>> _newsData;
  final NewsApiController _newsApiController = NewsApiController();

  @override
  void initState() {
    super.initState();
    _newsData = _newsApiController.fetchNews();
  }

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
              Icon(Icons.menu, color: Colors.black),
              SizedBox(width: 8),
              Text('News', style: TextStyle(color: Colors.black)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 4),
                    Text('Favs', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _newsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['articles'] == null) {
            return Center(child: Text('No news available'));
          }

          var articles = snapshot.data?['articles'] ?? [];

          return ListView.builder(
            itemCount: articles.length,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              var article = articles[index];
              return _buildNewsCard(context, article);
            },
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, Map<String, dynamic> article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsDetails()),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: article['urlToImage'] != null &&
                        article['urlToImage']!.isNotEmpty
                    ? Image.network(
                        article['urlToImage']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback image in case of error loading the network image
                          return Image.asset(
                            'assets/images/news.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/news.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'] ?? 'No title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      article['description'] ?? 'No description',
                      style: TextStyle(color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            article['publishedAt'] ?? 'No date',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        // Update UI to reflect changes
                      });
                    },
                  ),
                  Text(
                    'Add to\nFavorite',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
