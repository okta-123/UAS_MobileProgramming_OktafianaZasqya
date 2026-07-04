import 'package:flutter/material.dart';
import 'booking_page.dart';
import 'profile_page.dart';
import 'maps_page.dart';
import 'media_player_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const BookingPage(),
    const MapsPage(),
    const MediaPlayerPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laundry Taarooms"),
        backgroundColor: Colors.blue,
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_laundry_service),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Maps",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Media",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.local_laundry_service,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              "Selamat Datang",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Di Aplikasi Booking Laundry",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}