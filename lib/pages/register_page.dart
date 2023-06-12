import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'entry_page.dart';
import 'package:projetopdi/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _termsAndConditionsAccepted = false;

  String _email = '';
  String _password = '';

  void _signup() async {
  if (_formKey.currentState!.validate() && _termsAndConditionsAccepted) {
    _formKey.currentState!.save();

    AuthenticationService _authService = AuthenticationService();

    try {
      bool registerSuccessful = await _authService.register(_email, _password);

      if (registerSuccessful) {
        // Signup successful
        // You can navigate to the next screen or perform any desired action
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntryPage()));
      } else {
        print('SignUp error: registration not successful');
      }
    } catch (e) {
      // Signup failed
      // You can handle the error here, display a message, etc.
      print('SignUp error: $e');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Crie a sua conta',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome e apelido',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.01,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Insira o seu nome e apelido',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Núcleo',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.01,
                    ),
                    child: DropdownButtonFormField(
                      items: ['item1', 'item2'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {}, 
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Selecione o núcleo',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Secção',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.01,
                    ),
                    child: DropdownButtonFormField(
                      items: ['Lobitos', 'Exploradores','Pioneiros','Caminheiros','Chefes' ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {}, 
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'Selecione a secção',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.005,
                      left: screenWidth * 0.01,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration:const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Insira o seu email',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!.trim();
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.8,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.005,
                      left: screenWidth * 0.01,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration:const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Insira a sua password',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!.trim();
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.01), // change this value to move checkbox to the left
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _termsAndConditionsAccepted,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _termsAndConditionsAccepted = newValue ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text('Aceito os termos e condições'),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),
                // Create Account button
                Container(
                  width: screenWidth * 0.9, // Adjust this to make the button as wide as you want
                  height: screenHeight * 0.06, // Adjust this to make the button as tall as you want
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF323232)),
                    ),
                    onPressed: _signup,
                    child: Text(
                      'Cria a tua conta',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Login text
                SizedBox(height: screenHeight * 0.21),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.03,
                    bottom: screenHeight * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Já possui conta? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EntryPage()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Entrar',
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
