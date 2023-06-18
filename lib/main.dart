import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(DogApiApp());
}

class DogApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog API App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página inicial'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Ver uma imagem aleatória de um cachorro'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DogImagePage()),
            );
          },
        ),
      ),
    );
  }
}

class DogImagePage extends StatefulWidget {
  @override
  _DogImagePageState createState() => _DogImagePageState();
}

class _DogImagePageState extends State<DogImagePage> {
  String imageUrl = '';

  Future<void> fetchRandomDogImage() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    } else {
      print('Erro ao obter a imagem do cachorro: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagem de cachorro'),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? CircularProgressIndicator()
            : Image.network(imageUrl),
      ),
    );
  }
}
