import 'package:equatable/equatable.dart';

import 'movie_result.dart';

class SearchResult extends Equatable {
  List<MovieResult> _movies;
  String _totalResults;
  String _response;

  SearchResult({List<MovieResult> search, String totalResults, String response}) {
    this._movies = search;
    this._totalResults = totalResults;
    this._response = response;
  }

  List<MovieResult> get movies => _movies;
  set movies(List<MovieResult> search) => _movies = search;
  String get totalResults => _totalResults;
  set totalResults(String totalResults) => _totalResults = totalResults;
  String get response => _response;
  set response(String response) => _response = response;

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      _movies = new List<MovieResult>();
      json['Search'].forEach((v) {
        _movies.add(new MovieResult.fromJson(v));
      });
    }
    _totalResults = json['totalResults'];
    _response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._movies != null) {
      data['Search'] = this._movies.map((v) => v.toJson()).toList();
    }
    data['totalResults'] = this._totalResults;
    data['Response'] = this._response;
    return data;
  }
}
