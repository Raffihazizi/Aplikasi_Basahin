import 'package:flutter/material.dart';
import 'editprofile.dart'; // Jangan lupa import halaman edit profil yang telah dibuat

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name = 'Pemuda Pembasmi Project'; // Inisialisasi dengan nama awal
  String email = 'pemuda@gmail.com'; // Inisialisasi dengan email awal
  String address = 'Jl.irigasi'; // Inisialisasi dengan email awal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          IconButton(
            onPressed: () async {
              // Navigasi ke halaman edit profil
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(
                    currentName: name,
                    currentEmail: email, 
                    currentAddress: address,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  name = result['name'];
                  email = result['email'];
                  address = result['address'];
                });
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/pbl.jpg'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              name, // Tampilkan nama yang telah diperbarui
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              email, // Tampilkan email yang telah diperbarui
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Text(
              address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
           
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi untuk logout di sini
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Account(),
  ));
}
