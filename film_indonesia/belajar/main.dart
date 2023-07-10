import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilmList(),
    );
  }
}

class FilmList extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  List films = [];

  @override
  void initState() {
    super.initState();
    fetchFilms();
  }

  Future fetchFilms() async {
    final response = await http.get(Uri.parse('https://api.example.com/films')); // Ganti dengan URL API yang sesuai
    
    if (response.statusCode == 200) {
      setState(() {
        films = jsonDecode(response.body);
      });
    } else {
      print('Failed to fetch films');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Indonesia'),
      ),
      body: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(films[index]['title']),
            subtitle: Text(films[index]['description']),
          );
        },
      ),
    );
  }
}
