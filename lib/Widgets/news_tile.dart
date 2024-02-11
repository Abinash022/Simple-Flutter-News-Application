import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Riverpod/news_controller.dart';

class NewsTile extends ConsumerWidget {
  const NewsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getNews = ref.watch(newsProvider);
    return getNews.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text('There is an internal error'),
      ),
      data: (articles) {
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              onTap: () {
                final urlLauncher = ref.read(apiServiceProvider);
                urlLauncher.launchURL(
                  Uri.parse(article.url ?? ''),
                );
              },
              title: Text(
                article.title ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              leading: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      height: 250.0,
                      width: 100.0,
                    )
                  : Container(
                      height: 250.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
