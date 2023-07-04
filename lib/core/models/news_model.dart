class NewsModel {
  List<Articles>? articles;

  NewsModel({this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }
}

class Articles {
  String? title;
  String? description;

  Articles({
    this.title,
    this.description,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
}
