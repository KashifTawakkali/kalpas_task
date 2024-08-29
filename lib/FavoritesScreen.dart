import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewsDetails.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteNews;

  FavoritesScreen({required this.favoriteNews});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
              Text('Favorites', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteNews.length,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemBuilder: (context, index) {
          return _buildFavoriteNewsCard(index);
        },
      ),
    );
  }

  Widget _buildFavoriteNewsCard(int index) {
    var article = widget.favoriteNews[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetails(
              title: article['title'] ?? 'No title available',
              date: article['publishedAt'] ?? 'No date available',
              content: article['content'] ?? 'No content available',
              description: article['description'] ?? 'No description available',
              imageUrl: article['urlToImage'] ?? 'https://via.placeholder.com/600',
            ),
          ),
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
                child: Image.network(
                  article['urlToImage'] ?? 'https://via.placeholder.com/150',
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
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey),
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
            ],
          ),
        ),
      ),
    );
  }

  void _removeFromFavorites(int index) {
    setState(() {
      widget.favoriteNews.removeAt(index);
    });
  }
}
