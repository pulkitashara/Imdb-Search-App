class Movie {
  final String title; // Title of the movie
  final String genre; // Genre of the movie
  final double? imdbRating; // Optional IMDb rating of the movie
  final String poster; // URL of the movie poster

  // Constructor for creating a Movie instance
  Movie({
    required this.title,
    required this.genre,
    this.imdbRating, // Optional and nullable IMDb rating
    required this.poster,
  });

  // Factory constructor to create a Movie instance from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'No Title', // Default title if the JSON key is null
      genre: json['Genre'] ?? 'No Genre', // Default genre if the JSON key is null
      imdbRating: json['imdbRating'] != null
          ? double.tryParse(json['imdbRating'].toString()) // Safe parsing of IMDb rating
          : null, // Assign null if imdbRating is not present
      poster: json['Poster'] ?? '', // Default empty string if the poster is null
    );
  }
}
