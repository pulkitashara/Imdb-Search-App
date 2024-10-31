import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie.dart';
import 'movie_provider.dart';

class MovieSearchApp extends StatelessWidget {
  const MovieSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Providing the MovieProvider to the widget tree
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MaterialApp(
        home: MovieSearchScreen(),
      ),
    );
  }
}

class MovieSearchScreen extends StatelessWidget {
  const MovieSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the MovieProvider
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFEFEFEF), // Light gray background
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFEFEFEF), // Extremely light gray background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search TextField
            TextField(
              cursorColor: const Color(0xFF212121),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1C7EEB)),
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF212121),
                ),
                filled: true,
                fillColor: const Color(0xFFFFFFFF), // White background for input
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1C7EEB)), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1C7EEB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1C7EEB)),
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFF212121),
              ),
              onSubmitted: (query) {
                // Trigger search when the user submits the query
                movieProvider.searchMovies(query);
              },
            ),
            const SizedBox(height: 16),
            // Conditional loading indicator, movie list, or error message
            if (movieProvider.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1C7EEB)), // Loading indicator color
                ),
              )
            else if (movieProvider.errorMessage != null)
              Center(
                child: Text(
                  movieProvider.errorMessage!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red, // Error message color
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: movieProvider.movies.length,
                  itemBuilder: (context, index) {
                    // Create a card for each movie in the list
                    final movie = movieProvider.movies[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16), // Space between cards
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xFFFFFFFF), // White card background
            elevation: 5, // Card elevation for shadow effect
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 100), // Space for the poster
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF212121), // Title color
                          ),
                          maxLines: 2, // Limit lines for title
                          overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.genre,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500, // Medium style for genre
                            fontFamily: 'Montserrat',
                            color: Color(0xFF262E2E), // Genre color
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (movie.imdbRating != null && movie.imdbRating! >= 7)
                                ? const Color(0xFF5EC570) // Green for good ratings
                                : const Color(0xFF1C7EEB), // Blue for lower ratings
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${movie.imdbRating?.toString() ?? 'N/A'} IMDb', // Display IMDb rating
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -20, // Adjust for poster overlap
            left: 30,
            bottom: 14, // Align poster with the bottom of the card
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.poster,
                width: 100,
                height: 160, // Poster height
                fit: BoxFit.cover, // Cover to fill space
              ),
            ),
          ),
        ],
      ),
    );
  }
}
