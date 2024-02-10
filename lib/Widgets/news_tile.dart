import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
                // launchUrl(
                //   Uri.parse(article.url ?? ''),
                // );
              },
              title: Text(
                article.title ?? '',
              ),
              // subtitle: Text(article.description ?? ''),
              leading: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      // Adjust the fit as needed
                    )
                  : const Placeholder(
                      // Use a Placeholder widget as a placeholder image
                      child: Text('Sorry'),
                    ),
            );
          },
        );
      },
    );
  }
}
