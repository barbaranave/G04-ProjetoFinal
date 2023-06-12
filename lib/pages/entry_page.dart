import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'home_page.dart'; // Import your HomePage here

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  void _trySignIn() async {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();

    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for this user.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Entrar',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.005,
                      left: screenWidth * 0.01,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Insira o seu email',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.005,
                      left: screenWidth * 0.01,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Insira a sua password',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                GestureDetector(
                  onTap: _trySignIn,
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await _auth.sendPasswordResetEmail(email: _email);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password reset email sent.')));
                      } catch (e) {
                        print('Failed to send password reset email: $e');
                      }
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 30, 43, 30),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.44),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    bottom: screenHeight * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não é membro? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: 'Crie a sua conta',
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
