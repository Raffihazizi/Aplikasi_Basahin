import 'package:basahin/drawer.dart';
import 'package:flutter/material.dart';
import 'package:basahin/bottom/info.dart';
import 'package:basahin/bottom/news.dart';
import 'package:basahin/feedback.dart';
import 'package:basahin/kondisitanah.dart';
import 'package:basahin/setting.dart';
import 'package:basahin/suhu.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var height, width;
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const InfoScreen(), // Placeholder for Info Screen
    DashboardContent(),
    BasahinNewsScreen(), // Placeholder for BasahinNews Screen
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(), // Tambahkan drawer di sini
      body: _screens[_currentIndex],
    );
  }
}

class DashboardContent extends StatelessWidget {
  final List<String> imgData = [
    "assets/images/tanah.png",
    "assets/images/suhu.png",
    "assets/images/feedback2.png",
    "assets/images/news.png",
    // "assets/images/setting.png",
  ];

  final List<String> titles = [
    "Kondisi Tanah",
    "Suhu",
    "Feedback",
    "BasahinNews",
    // "Setting",
  ];

  DashboardContent({super.key});

  // Fungsi untuk mendapatkan tanggal saat ini dalam format yang diinginkan
  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        width: width,
        color: Colors.teal,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.30,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/pbl.jpg"),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Basahin App",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: "arcivo",
                            letterSpacing: 1,
                          ),
                        ),
                        const Text(
                          "Inventory",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            letterSpacing: 1,
                            fontFamily: 'arcivo',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                       
                        // Menambahkan tanggal saat ini
                        Text(
                          getCurrentDate(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              width: width,
              padding: const EdgeInsets.only(bottom: 200),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imgData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (titles[index] == "Kondisi Tanah") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KondisiTanahScreen(),
                          ),
                        );
                      }
                      if (titles[index] == "Suhu") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SuhuScreen(),
                          ),
                        );
                      }
                      if (titles[index] == "Feedback") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeedbackScreen(),
                          ),
                        );
                      }
                      // if (titles[index] == "Setting") {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SettingScreen(),
                      //     ),
                      //   );
                      // }
                      if (titles[index] == "BasahinNews") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BasahinNewsScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imgData[index],
                            width: 100,
                          ),
                          Text(
                            titles[index],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              fontFamily: "arcivo",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
