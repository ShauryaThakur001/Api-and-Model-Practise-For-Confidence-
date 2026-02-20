class NewsModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {

    final image = json['urlToImage'];

    return NewsModel(
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),

      /// Safe image handling
      urlToImage: image != null && image.toString().isNotEmpty
          ? image.toString()
          : '',
    );
  }
}
