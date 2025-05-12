import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kargotakip/main.dart' show HomePage;
import 'package:kargotakip/services/auth.dart';




class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLogin = true;
  String? errorMessage;

  Future<void> createUser() async {
    try {
      await Auth().createUser(
        email: emailController.text,
        password: passwordController.text,
      );
     
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text("Kayıt Başarılı"),
          backgroundColor: Colors.green, 
          duration:Duration(seconds:3 ) ) );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text("Kayıt Başarısız"),
          backgroundColor: Colors.red, 
          duration:Duration(seconds:3 ) ) );



    }
  }












  Future<void> signIn() async {
    try {
      await Auth().signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      print(Auth().currentUser!.uid);

Navigator.push(
        context,
         MaterialPageRoute(
          builder: (context) {
            return HomePage();
          }
         )
      );



    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage =e.message;
      });

  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            errorMessage != null
                ? Text(errorMessage!)
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: () {
                if (isLogin) {
                  signIn();
                } else {}
                  createUser();
              },
              child: isLogin ? const Text("Login") : const Text("Register"),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child:const Text("Henüz hesabın yok mu? tıkla"),
            ),
          ],
        ),
      ),
    );
  }
}
