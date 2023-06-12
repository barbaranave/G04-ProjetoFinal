import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String _apiKey = 'a964128e026d428cb6c14992c24f9670';
  static const String _url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

  static Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData['articles'] as List<dynamic>;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
