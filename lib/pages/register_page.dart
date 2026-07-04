import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Laundry"),
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

                final user = await authService.register(
                  emailController.text,
                  passwordController.text,
                );

                if (user != null) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Register berhasil"),
                    ),
                  );

                  Navigator.pushReplacement(
                context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                    ),                
                  );

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Register gagal"),
                    ),
                  );

                }

              },
              child: const Text("REGISTER"),
            ),

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Sudah punya akun? Login"),
            )
          ],
        ),
      ),
    );
  }
}