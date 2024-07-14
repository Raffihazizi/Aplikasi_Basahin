import 'package:flutter/material.dart';

class Themee extends StatelessWidget {
  const Themee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('theme'),
      ),
    );
}

void main() {
  runApp(MaterialApp(
    home: Themee(),
    theme: ThemeData(
      primaryColor: Colors.teal, // Ubah warna primer sesuai kebutuhan
      hintColor: Colors.orange, // Ubah warna aksen sesuai kebutuhan
      // Tambahkan konfigurasi tema lainnya di sini
    ),
  ));
}
}