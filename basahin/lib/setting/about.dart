import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About This App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'App Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Basahin App', // Ubah nama aplikasi sesuai kebutuhan
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Version:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1.2.1',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Aplikasi Luar Biasa yang membantu pengguna melakukan hal-hal dalam bidang pertanian.', // Ubah deskripsi aplikasi sesuai kebutuhan
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Tambahkan fungsi untuk membuka halaman Terms of Service di sini
            //   },
            //   child: Text('Terms of Service'),
            // ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: About(),
  ));
}
