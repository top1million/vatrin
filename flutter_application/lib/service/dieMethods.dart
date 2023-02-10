import 'package:dio/dio.dart';
import '../constants/api.dart';
import '../models/credits.dart';
import '../models/movie_detail.dart';
import '../models/movies.dart';

class MovieDatas {
  Dio dio = Dio();

  Future<List<Movies>> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        "$movieBaseUrl/movie/popular?api_key=$apiKey&page=$page",
      );
      final List data = response.data["results"];
      return data.map((e) => Movies.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Movies>> getTopRatedMovies(int page) async {
    try {
      final response = await dio.get(
        "$movieBaseUrl/movie/top_rated?api_key=$apiKey&page=$page",
      );
      final List data = response.data["results"];
      return data.map((e) => Movies.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieDetails> getMovieDetails(int movieid) async {
    try {
      final response =
          await dio.get("$movieBaseUrl/movie/$movieid?api_key=$apiKey");
      return MovieDetails.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<List<Cast>> getCharacters(int id) async {
    try {
      final response = await dio.get(
        "$movieBaseUrl/movie/$id/credits?api_key=$apiKey",
      );

      final List data = response.data["cast"];
      return data.map((e) => Cast.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }




}
