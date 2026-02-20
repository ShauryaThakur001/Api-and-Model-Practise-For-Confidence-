import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/NewsProvider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {

    final newsService = context.watch<NewsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("News Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: newsService.isLoading
            ? const Center(child: CircularProgressIndicator())

            : newsService.errorMessage != null
                ? Center(
                    child: Text(
                      newsService.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )

                : newsService.newsModel.isEmpty
                    ? const Center(child: Text("No News Available"))

                    : RefreshIndicator(
                        onRefresh: () async {
                          await context.read<NewsProvider>().fetchNews();
                        },
                        child: ListView.builder(
                          itemCount: newsService.newsModel.length,
                          itemBuilder: (context, index) {

                            final article =
                                newsService.newsModel[index];

                            return NewsContainer(
                              url: article.urlToImage,   
                              title: article.title,
                              description: article.description,
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}

class NewsContainer extends StatelessWidget {
  final String url;
  final String title;
  final String description;

  const NewsContainer({
    super.key,
    required this.url,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),

      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                url.isNotEmpty
                    ? url
                    : "https://via.placeholder.com/400x200.png?text=No+Image",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            /// Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 8),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                description,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
