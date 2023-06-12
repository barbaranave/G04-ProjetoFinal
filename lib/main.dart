import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetopdi/pages/login_page.dart';
import 'package:projetopdi/pages/entry_page.dart';
import 'package:projetopdi/pages/register_page.dart';
import 'package:projetopdi/pages/home_page.dart';
import 'package:projetopdi/pages/article_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAuth auth = FirebaseAuth.instance;

  runApp(MyApp(
    initialRoute: auth.currentUser != null ? '/home' : '/',
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == '/article') {
          final ArticleArguments args = settings.arguments as ArticleArguments;

          return MaterialPageRoute(
            builder: (context) {
              return ArticlePage(
                url: args.url,
                journalName: args.journalName,
              );
            },
          );
        }

        // Handle other routes
        if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }

        // Added routes
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const EntryPage());
        }

        if (settings.name == '/register') {
          return MaterialPageRoute(builder: (context) => const RegisterPage());
        }

        // default route
        return MaterialPageRoute(builder: (context) => const LoginPage());
      },
    );
  }
}
