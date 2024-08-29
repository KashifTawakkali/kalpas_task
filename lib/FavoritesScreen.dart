import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favoriteNews = [
    'Favorite News Title 1',
    'Favorite News Title 2',
    'Favorite News Title 3',
    'Favorite News Title 4',
    'Favorite News Title 5',
  ]; // Example list

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
        itemCount: favoriteNews.length,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemBuilder: (context, index) {
          return _buildFavoriteNewsCard(index);
        },
      ),
    );
  }

  Widget _buildFavoriteNewsCard(int index) {
    return Card(
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
                'https://via.placeholder.com/150',
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
                    favoriteNews[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Description of the favorite news goes here.',
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
                          'Mon, 21 Dec 2020 14:57 GMT',
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
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _removeFromFavorites(index);
                  },
                ),
                Text(
                  'Remove',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteNews.removeAt(index);
    });
  }
}
