import 'package:basahin/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({super.key});

  @override
  _SuhuScreenState createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  late Future<List<Suhu>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataSuhu();
  }

  Future<List<Suhu>> _fetchDataSuhu() async {
    try {
      var response = await http.get(
        Uri.parse('http://100.29.163.134:4000/api/suhu'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Suhu> data = jsonData.map((item) => Suhu.fromJson(item)).toList();
         data.sort((a, b) => b.id.compareTo(a.id));
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
            );
          },
        ),
        title: const Text(
          'Suhu Hari Ini',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'arcivo',
              fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Suhu>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<Suhu>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.thermostat,
                        color: Colors.teal,
                        size: 40,
                      ),
                      title: Text(
                        'ID: ${data.id}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Temperature: ${data.temperature}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Datetime: ${data.datetime}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Suhu {
  final String id; // Ubah tipe data id menjadi String
  final String temperature;
  final String datetime;

  Suhu({
    required this.id,
    required this.temperature,
    required this.datetime,
  });

  factory Suhu.fromJson(Map<String, dynamic> json) {
    return Suhu(
      id: json["id"].toString(), // Konversi id menjadi String
      temperature:
          json["temperature"].toString(), // Konversi temperature menjadi String
      datetime: json["datetime"].toString(), // Konversi datetime menjadi String
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SuhuScreen(),
  ));
}
