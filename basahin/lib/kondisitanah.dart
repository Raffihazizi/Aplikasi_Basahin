import 'package:basahin/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KondisiTanahScreen extends StatefulWidget {
  const KondisiTanahScreen({super.key});

  @override
  _KondisiTanahState createState() => _KondisiTanahState();
}

class _KondisiTanahState extends State<KondisiTanahScreen> {
  late Future<List<Tanah>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDataKondisiTanah();
  }

  Future<List<Tanah>> _fetchDataKondisiTanah() async {
    try {
      var response = await http.get(
        Uri.parse('http://100.29.163.134:3000/api/tanah'),
        // Uri.parse('http://localhost:4000/api/suhu'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Tanah> data =
            jsonData.map((item) => Tanah.fromJson(item)).toList();

        // Sort the data by id in descending order
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
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(),
              ),
            );
          },
        ),
        title: const Text(
          'Kondisi Tanah Hari Ini',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'arcivo',
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Tanah>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<Tanah>> snapshot) {
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
                      leading: Icon(
                        Icons.terrain,
                        color: Colors.teal,
                        size: 40,
                      ),
                      title: Text(
                        'ID: ${data.id}',
                        style: TextStyle(
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
                              'Status: ${data.status}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Waktu: ${data.waktu}',
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

class Tanah {
  final int id;
  final String status;
  final String waktu;

  Tanah({
    required this.id,
    required this.status,
    required this.waktu,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "waktu": waktu,
      };

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
    home: KondisiTanahScreen(),
  ));
}
