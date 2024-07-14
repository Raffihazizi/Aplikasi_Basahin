import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:basahin/drawer.dart';
import 'package:basahin/dashboard.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Future<List<Tanah>> _futureDataTanah;
  late Future<List<Suhu>> _futureDataSuhu;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureDataTanah = _fetchDataKondisiTanah();
      _futureDataSuhu = _fetchDataSuhu();
    });
  }

  Future<List<Tanah>> _fetchDataKondisiTanah() async {
    try {
      var response = await http.get(
        // Uri.parse('http://localhost:3000/api/tanah'),
        Uri.parse('http://100.29.163.134:3000/api/tanah'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Tanah> data =
            jsonData.map((item) => Tanah.fromJson(item)).toList();
        data.sort(
            (a, b) => b.id.compareTo(a.id)); // Urutkan data berdasarkan id
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  Future<List<Suhu>> _fetchDataSuhu() async {
    try {
      var response = await http.get(
        // Uri.parse('http://localhost:4000/api/suhu'),
        Uri.parse('http://100.29.163.134:4000/api/suhu'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Suhu> data = jsonData.map((item) => Suhu.fromJson(item)).toList();
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.teal,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: _refreshData,
              child: const Text(
                'Info',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30.0, // Adjust font size
                  fontWeight: FontWeight.normal, // Adjust font weight
                  fontFamily: 'arcivo',
                ),
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
                image: const DecorationImage(
                  image: AssetImage('assets/images/pbl.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      drawer: const AppDrawer(), // Tambahkan drawer di sini
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/land2.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 80.0,
            color: Colors.teal.withOpacity(0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(85.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/awansun.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Suhu',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: "arcivo"),
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder<List<Suhu>>(
                    future: _futureDataSuhu,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Suhu>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        Suhu latestSuhu =
                            snapshot.data!.last; // Mengambil data suhu terbaru
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (double.parse(latestSuhu.temperature) > 30) {
                            _showSnackBar(context, 'Suhu hari ini sangat panas',
                                Colors.red);
                          } else {
                            _showSnackBar(
                                context, 'Hari yang cerah', Colors.green);
                          }
                        });
                        return Text(
                          '${latestSuhu.temperature}°C', // Menampilkan nilai suhu terbaru
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(
                    height: 30.0,
                    thickness: 1.0,
                  ),
                  const Text(
                    'Kondisi Tanah',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: "arcivo",
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder<List<Tanah>>(
                    future: _futureDataTanah,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Tanah>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        Tanah latestData = snapshot.data!
                            .first; // Mengambil data kondisi tanah terbaru
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Future.delayed(const Duration(seconds: 1), () {
                            final status =
                                latestData.status.toLowerCase().trim();
                            if (status == "tanah kering") {
                              _showSnackBar(
                                  context, 'Kondisi Tanah Kering', Colors.red);

                            } else if (status == "tanah kelebihan air") {
                              _showSnackBar(
                                  context,
                                  'Tanah Kelebihan Air, tidak perlu disiram',
                                  Colors.blue);
                                  
                            } else if (status == "tanah basah") {
                              _showSnackBar(
                                  context,
                                  'Tanah Basah, siramlah beberapa jam lagi',
                                  Colors.green);
                            }
                          });
                        });
                        return Text(
                          latestData.status, // Menampilkan nilai kelembapan air dari data terbaru
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Suhu {
  final String id; 
  final String temperature; //status suhu
  final String datetime;

  Suhu({
    required this.id,
    required this.temperature,
    required this.datetime,
  });

  factory Suhu.fromJson(Map<String, dynamic> json) {
    return Suhu(
      id: json["id"].toString(), // Konversi nilai no menjadi String
      temperature:
          json["temperature"].toString(), // Konversi nilai menjadi String
      datetime: json["datetime"].toString(), // Konversi waktu menjadi String
    );
  }
}

class Tanah {
  final int id;
  final String status; //status tanah
  final String waktu;

  Tanah({
    required this.id,
    required this.status,
    required this.waktu,
  });

  factory Tanah.fromJson(Map<String, dynamic> json) {
    return Tanah(
      id: json["id"] ?? 0,
      status: json["status"] ?? '',
      waktu: json["waktu"] ?? '',
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: InfoScreen(),
  ));
}
