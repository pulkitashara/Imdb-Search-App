# Movie Search App

## Description

The Movie Search App is a Flutter application that allows users to search for movies using the OMDb API. Users can enter a movie title in the search field, and the app will fetch and display relevant movie information, including the title, genre, IMDb rating, and poster.

## Features

- **Search Functionality**: Users can search for movies by entering a title in the search bar.
- **Loading Indicator**: The app shows a loading spinner while fetching data.
<<<<<<< HEAD
- **Movie Cards**: Display movie details in a visually appealing card format.
=======
- **Movie Cards**: Displays movie details in a visually appealing card format.
>>>>>>> c3a44c6d9dc636f00635832346f84326fbf75a23
- **IMDb Ratings**: Color-coded IMDb ratings based on the rating value.

## Technologies Used

- **Flutter**: A UI toolkit for building natively compiled applications for mobile from a single codebase.
- **Provider**: A state management library for Flutter applications.
- **HTTP Package**: Used for making HTTP requests to the OMDb API.
- **OMDb API**: A RESTful API for movie data.
<<<<<<< HEAD
=======

### Setup API Key

This app uses the OMDb API for movie data, and an API key is required for access. To securely manage the API key, the app uses a `.env` file for storing environment variables.

1. **Create a `.env` file** in the root directory of the project.
2. Add your OMDb API key to the `.env` file in the following format:
   ```plaintext
   API_KEY=your_api_key_here
>>>>>>> c3a44c6d9dc636f00635832346f84326fbf75a23
