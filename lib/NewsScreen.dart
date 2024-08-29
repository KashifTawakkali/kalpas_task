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
  List<Map<String, dynamic>> _favorites = []; 
  bool _isSnackBarVisible = false; 

  @override
  void initState() {
    super.initState();
    _newsData = _newsApiController.fetchNews();
  }

  void _toggleFavorite(Map<String, dynamic> article) {
    setState(() {
      if (_favorites.contains(article)) {
        _favorites.remove(article); 
        _showSnackBar('Removed from Favorites!', Colors.red);
      } else {
        _favorites.add(article);
        _showSnackBar('Added to Favorites!', Colors.green);
      }
    });
  }

  void _showSnackBar(String message, Color color) {
    if (_isSnackBarVisible) return; 

    _isSnackBarVisible = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    ).closed.then((_) {
      _isSnackBarVisible = false; 
    });
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
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesScreen(favoriteNews: _favorites),
                    ),
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
    bool isFavorite = _favorites.contains(article); 

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
              imageUrl:
                  article['urlToImage'] ?? 'https://via.placeholder.com/600',
            ),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) {
          if (isFavorite) {
            setState(() {});
          }
        },
        onExit: (_) {
          if (isFavorite) {
            setState(() {});
          }
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10, // shadow effect
          child: Container(
            color: isFavorite
                ? Color.fromARGB(255, 255, 255, 255) 
                : Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: article['urlToImage'] != null &&
                          article['urlToImage']!.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          placeholder:
                              'assets/images/news.jpg', 
                          image: article['urlToImage']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
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
                        article['description'] ?? 'No description Available',
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
                GestureDetector(
                  onTap: () {
                    _toggleFavorite(article); 
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: isFavorite ? Colors.pink[100] : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
