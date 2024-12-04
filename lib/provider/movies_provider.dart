import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class MoviesProvider with ChangeNotifier {
  final List<dynamic> _moviesList = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _limit = 10;

  List<dynamic> get moviesList => _moviesList;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  String get errorMessage => _errorMessage;

  Future<void> fetchMoviesData() async {
    if (_isLoading) return;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _errorMessage = 'No internet connection';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final url =
        'https://api.jikan.moe/v4/anime?page=$_currentPage&limit=$_limit';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString(), name: "response");
        final newAnimeList = data['data'];

        if (newAnimeList.isEmpty) {
          _hasMoreData = false;
        } else {
          _moviesList.addAll(newAnimeList);
          _currentPage++;
        }
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
