import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/view/auth_screen.dart';
import 'package:movie_app/view/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];
  @override
  void initState() {
    getMovies();
    super.initState();
  }

  Future getMovies() async {
    const String url = 'https://hoblist.com/api/movieList';
    dynamic responseJson;
    final Map body = {
      "category": "movies",
      "language": "kannada",
      "genre": "all",
      "sort": "voting"
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );
      responseJson = returnResponse(context, response);
    } on SocketException {
      showSnackBar(context, message: 'No internet Connection');
    }

    final success = responseJson['message'] == 'success';
    if (success) {
      final List<dynamic> moviesData = responseJson['result'];
      final List<Movie> moviesList =
          moviesData.map((w) => Movie.fromJson(w)).toList();
      setState(() {
        movies = moviesList;
      });
    } else {
      showSnackBar(context, message: 'Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Time'),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text('Company Info'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                '\nGeeksynergy Technologies Pvt Ltd',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text('Sanjayanagar, Bengaluru-5'),
                              Text('XXXXXXXXX09'),
                              Text('XXXXXX@gmail.com'),
                            ],
                          ),
                        ));
              },
              icon: const Icon(Icons.info_outline)),
          IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [...movies.map((movie) => movieTile(movie)).toList()],
        ),
      ),
    );
  }

  Widget movieTile(Movie movie) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_drop_up_outlined, size: 50),
                      Text(
                        movie.voted.length.toString(),
                        style: const TextStyle(fontSize: 28),
                      ),
                      const Icon(Icons.arrow_drop_down_outlined, size: 50),
                    ],
                  ),
                  const Text(
                    'Votes',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.poster,
                fit: BoxFit.fill,
                width: screenSize.width * 0.25,
                height: screenSize.width * 0.4,
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: screenSize.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    "Genre: ${movie.genre}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Director: ${movie.director.toString().replaceAll("[", '').replaceAll("]", '')}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Starring: ${movie.stars.toString().replaceAll("[", '').replaceAll("]", '')}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Mins | ${movie.language}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${movie.pageViews} views | Voted by ${movie.voted.length.toString()} people",
                    style: const TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
