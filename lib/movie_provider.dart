import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'movie.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = []; // Private list to hold fetched movies
  bool _isLoading = false; // Loading state indicator

  // Public getter to expose the list of movies
  List<Movie> get movies => _movies;

  // Public getter to expose the loading state
  bool get isLoading => _isLoading;

  // Constructor to fetch random movies on initialization
  MovieProvider() {
    fetchRandomMovies();
  }

  // Method to fetch random movies from the API
  Future<void> fetchRandomMovies() async {
    _isLoading = true; // Set loading state
    notifyListeners(); // Notify listeners of state change

    final apiKey = dotenv.env['API_KEY']; // API key for the movie database

    // List of random movie titles for selection
    final randomTitles = ['Inception', 'Interstellar', 'The Dark Knight', 'Avatar', 'Titanic'];
    final randomTitle = randomTitles[(randomTitles.length * (0.5 + 0.5 * Random().nextDouble())).toInt()];

    // Constructing the URL for the API call
    final url = Uri.parse('http://www.omdbapi.com/?s=$randomTitle&apikey=$apiKey');
    final response = await http.get(url); // Fetching data from the API

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decoding the JSON response
      if (data['Response'] == 'True') {
        // If response is successful, map the search results to Movie instances
        _movies = await Future.wait((data['Search'] as List).map((movieJson) async {
          final detailsUrl = Uri.parse('http://www.omdbapi.com/?i=${movieJson['imdbID']}&apikey=$apiKey');
          final detailsResponse = await http.get(detailsUrl); // Fetching movie details

          if (detailsResponse.statusCode == 200) {
            return Movie.fromJson(jsonDecode(detailsResponse.body)); // Creating Movie instance
          }
          return Movie(title: 'Unknown', genre: 'N/A', imdbRating: null, poster: ''); // Fallback for unknown movies
        }));
      } else {
        _movies = []; // Clear movies if the response indicates no results
      }
    }

    _isLoading = false; // Reset loading state
    notifyListeners(); // Notify listeners of state change
  }

  // Method to search for movies based on user query
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return; // Exit if query is empty

    _isLoading = true; // Set loading state
    notifyListeners(); // Notify listeners of state change

    const String apiKey = '98a8df8a'; // API key for the movie database
    final url = Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'); // Constructing the URL
    final response = await http.get(url); // Fetching data from the API

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Decoding the JSON response
      if (data['Response'] == 'True') {
        // If response is successful, map the search results to Movie instances
        _movies = await Future.wait((data['Search'] as List).map((movieJson) async {
          final detailsUrl = Uri.parse('http://www.omdbapi.com/?i=${movieJson['imdbID']}&apikey=$apiKey');
          final detailsResponse = await http.get(detailsUrl); // Fetching movie details

          if (detailsResponse.statusCode == 200) {
            return Movie.fromJson(jsonDecode(detailsResponse.body)); // Creating Movie instance
          }
          return Movie(title: 'Unknown', genre: 'N/A', imdbRating: null, poster: ''); // Fallback for unknown movies
        }));
      } else {
        _movies = []; // Clear movies if the response indicates no results
      }
    }

    _isLoading = false; // Reset loading state
    notifyListeners(); // Notify listeners of state change
  }
}
