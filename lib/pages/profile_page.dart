import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Foto Profil
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Profil Pengguna",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                title: const Text("Email"),
                subtitle: Text(user?.email ?? "-"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Colors.green,
                ),
                title: Text("Nama"),
                subtitle: Text("Oktafiana Zasqya Ramadhania"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.badge,
                  color: Colors.orange,
                ),
                title: Text("NIM"),
                subtitle: Text("241011700479"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.local_laundry_service,
                  color: Colors.purple,
                ),
                title: Text("Aplikasi"),
                subtitle: Text("Laundry Booking"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.red,
                ),
                title: Text("Versi"),
                subtitle: Text("1.0.0"),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: const Text(
                  "LOGOUT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                    (route) => false,
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