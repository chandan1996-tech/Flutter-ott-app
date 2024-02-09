class Movie {
  Movie({
    required this.id,
    required this.description,
    required this.director,
    required this.writers,
    required this.stars,
    required this.productionCompany,
    required this.pageViews,
    required this.title,
    required this.language,
    required this.releasedDate,
    required this.genre,
    required this.voted,
    required this.poster,
    required this.totalVoted,
    required this.voting,
  });
  late final String id;
  late final String description;
  late final List<String> director;
  late final List<String> writers;
  late final List<String> stars;
  late final List<String> productionCompany;
  late final int pageViews;
  late final String title;
  late final String language;

  late final int releasedDate;
  late final String genre;
  late final List<Voted> voted;
  late final String poster;
  late final int totalVoted;
  late final int voting;

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    director = List.castFrom<dynamic, String>(json['director']);
    writers = List.castFrom<dynamic, String>(json['writers']);
    stars = List.castFrom<dynamic, String>(json['stars']);
    productionCompany =
        List.castFrom<dynamic, String>(json['productionCompany']);
    pageViews = json['pageViews'];
    title = json['title'];
    language = json['language'];

    releasedDate = json['releasedDate'];
    genre = json['genre'];
    voted = List.from(json['voted']).map((e) => Voted.fromJson(e)).toList();
    poster = json['poster'];
    totalVoted = json['totalVoted'];
    voting = json['voting'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['description'] = description;
    data['director'] = director;
    data['writers'] = writers;
    data['stars'] = stars;
    data['productionCompany'] = productionCompany;
    data['pageViews'] = pageViews;
    data['title'] = title;
    data['language'] = language;

    data['releasedDate'] = releasedDate;
    data['genre'] = genre;
    data['voted'] = voted.map((e) => e.toJson()).toList();
    data['poster'] = poster;
    data['totalVoted'] = totalVoted;
    data['voting'] = voting;
    return data;
  }
}

class Voted {
  Voted({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.updatedAt,
    required this.genre,
  });
  late final List<dynamic> upVoted;
  late final List<dynamic> downVoted;
  late final String id;
  late final int updatedAt;
  late final String genre;

  Voted.fromJson(Map<String, dynamic> json) {
    upVoted = List.castFrom<dynamic, dynamic>(json['upVoted']);
    downVoted = List.castFrom<dynamic, dynamic>(json['downVoted']);
    id = json['_id'];
    updatedAt = json['updatedAt'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['upVoted'] = upVoted;
    data['downVoted'] = downVoted;
    data['_id'] = id;
    data['updatedAt'] = updatedAt;
    data['genre'] = genre;
    return data;
  }
}
