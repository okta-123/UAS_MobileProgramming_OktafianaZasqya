import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Laundry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {

                final user = await authService.login(
                  emailController.text,
                  passwordController.text,
                );

                if(user != null){

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );

                }else{

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login gagal"),
                    ),
                  );

                }

              },
              child: const Text("LOGIN"),
            ),

            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                  ),
                );
              },
              child: const Text("Belum punya akun? Register"),
            )

          ],
        ),
      ),
    );
  }
}