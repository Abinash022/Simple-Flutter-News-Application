import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_application_flutter/Models/news_model.dart';

import '../Services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final newsProvider = FutureProvider<List<ArticleModel>>((ref) async {
  return ref.watch(apiServiceProvider).fetchArticle();
});
