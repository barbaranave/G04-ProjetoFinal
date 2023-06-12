import 'package:flutter/material.dart';
import 'package:projetopdi/pages/home_page.dart';
import 'register_page.dart';
import 'entry_page.dart';
import 'package:projetopdi/services/auth.dart'; // Make sure to use your correct path

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService authService =
      AuthenticationService(); // Use your AuthenticationService here
  String _email = '';
  String _password = '';

  void _trySignIn() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      await authService.login(_email,
          _password); // Use the login method from your AuthenticationService
      // Success! Navigate to EntryPage
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // Handle exception by showing a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e
              .toString()))); // Catch any exception and display the error message
    }
  }

  void _handleGoogleSignIn() async {
    try {
      bool success = await authService
          .signInWithGoogle(); // Call the signInWithGoogle method from your AuthenticationService
      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in with Google.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _handleFacebookSignIn() {
    print('Facebook button pressed');
    // Add the actions you want to perform when Facebook button is clicked
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/images/ea22b48af50725aac57cff4f97c045fe.1000x1000x1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // "Bem-vindo ao Escutismo." text
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.59,
            left: MediaQuery.of(context).size.width * 0.05,
            child: const Text(
              'Bem-vindo ao Escutismo.',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          // "Regista-te para fazeres parte." text
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.55,
            left: MediaQuery.of(context).size.width * 0.05,
            child: const Text(
              'Regista-te para fazeres parte.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          // Google login button
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.45,
            left: MediaQuery.of(context).size.width * 0.10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.01),
              ),
              child: InkWell(
                onTap:
                    _handleGoogleSignIn, // Call the _handleGoogleSignIn method
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/google.png',
                      height: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    const Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Facebook login button
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.45,
            right: MediaQuery.of(context).size.width * 0.10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.01),
              ),
              child: InkWell(
                onTap:
                    _handleFacebookSignIn, // Call the _handleFacebookSignIn method
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/facebook.png',
                      height: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    const Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Transparent "Registar" button with white border below the Google button
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.36,
            left: MediaQuery.of(context).size.width * 0.10,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.01),
                border: Border.all(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Registar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // The clickable "Entrar" text with underline below the Facebook button
          Positioned(
            bottom:
                MediaQuery.of(context).size.height * 0.36, // Adjust as needed
            right: MediaQuery.of(context).size.width * 0.22, // Adjust as needed
            child: GestureDetector(
              onTap: () {
                // Navigate to EntryPage when "Entrar" is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntryPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(
                    bottom:
                        8.0), // This will add space between the underline and the text
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Text "Ao registar-se está a aceitar os nossos termos de uso e políticas de privacidade."
          Positioned(
            bottom:
                MediaQuery.of(context).size.height * 0.28, // Adjust as needed
            left: MediaQuery.of(context).size.width * 0.05, // Adjust as needed
            child: const Text(
              'Ao registar-se está a aceitar os nossos termos de uso\ne políticas de privacidade.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          // Text "Para mais informações acerca do escutismo aceda ao nosso website: http://escutismo.pt/"
          Positioned(
            bottom:
                MediaQuery.of(context).size.height * 0.03, // Adjust as needed
            left: MediaQuery.of(context).size.width * 0.05, // Adjust as needed
            child: RichText(
              text: const TextSpan(
                text:
                    'Para mais informações acerca do escutismo aceda ao\nnosso website: ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'http://escutismo.pt/',
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
