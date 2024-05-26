import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  List _posts = [];
  String _selectedCategory = 'general';

  final List<String> _categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Berita Utama',
          style: TextStyle(
            color: Colors.black, // Mengatur warna teks menjadi hitam
            fontWeight: FontWeight.bold, // Menambahkan efek tebal (bold)
            fontFamily: 'Arial', // Mengatur font menjadi Arial
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
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Jelajahi pilihan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              title: Text('Tentang'),
              onTap: () {
                // Navigasi ke layar tentang
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16.0),
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.9,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[
                  400], // Ubah warna latar belakang container menjadi abu-abu gelap
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
            // Atur lebar maksimal menjadi 90% dari lebar layar
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categories[index];
                            _getData(); // Dapatkan data berdasarkan kategori baru
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selectedCategory == _categories[index]
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2.0, // Ketebalan garis bawah
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _categories[index],
                              style: TextStyle(
                                color: Colors
                                    .black, // Ubah warna teks menjadi hitam
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  article: _posts[index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120, // Lebar ditingkatkan
                                  height: 120, // Tinggi ditingkatkan
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Sudut melengkung
                                    border: Border.all(
                                        color: Colors.grey), // Warna bingkai
                                  ),
                                  clipBehavior: Clip
                                      .hardEdge, // Memastikan gambar terpotong sesuai radius bingkai
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeholder_image.png',
                                    image: _posts[index]['urlToImage'] ?? '',
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _posts[index]['title'] ?? 'Tanpa Judul',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        _posts[index]['description'] ??
                                            'Tanpa Deskripsi',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        _posts[index]['publishedAt'] ??
                                            'Tanpa Tanggal',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=$_selectedCategory&apiKey=24315da6cb8b4906b67c39165793f6da'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
