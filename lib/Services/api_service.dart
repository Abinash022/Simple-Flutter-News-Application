import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application_flutter/Models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constant/api_key.dart';

class ApiService {
  Future<List<ArticleModel>> fetchArticle() async {
    final response = await http.get(
      Uri.parse(apiEndpoint),
    );

    if (response.statusCode == 200) {
      List article = jsonDecode(response.body)['articles'];
      return article
          .map(
            (e) => ArticleModel.fromJson(e),
          )
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  // URl Launcher for the web view of the news

  Future<void> launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Cannot Launch the $url');
    }
  }
}
