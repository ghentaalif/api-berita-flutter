import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> article;

  Detail({required this.article});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.blue, // Ubah warna latar belakang app bar di sini
        title: Text(
          'Detail',
          style: TextStyle(
            color: Colors.black, // Mengatur warna teks menjadi hitam
            fontWeight: FontWeight.bold, // Menambahkan efek tebal (bold)
            fontFamily: 'Arial',
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Arial',
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(fontFamily: 'Arial', fontSize: 16),
              ),
              onTap: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
            ),
            ListTile(
              title: Text(
                'About',
                style: TextStyle(fontFamily: 'Arial', fontSize: 16),
              ),
              onTap: () {
                // Navigate to about screen
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.indigo
            ], // Warna gradient baru untuk latar belakang
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              width: screenWidth * 0.75,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(article['urlToImage'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title'] ?? 'No Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Published At: ${article['publishedAt'] ?? 'No Date'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                            fontFamily: 'Arial',
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1.0,
                        ),
                        SizedBox(height: 20),
                        Text(
                          article['content'] ?? 'No Content',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Arial',
                          ),
                        ),
                        SizedBox(height: 30),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1.0,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Author: ${article['author'] ?? 'No Author'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Source: ${article['source']['name'] ?? 'No Source'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
