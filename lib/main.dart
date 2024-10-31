import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'movie_search_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MovieSearchApp());
}
