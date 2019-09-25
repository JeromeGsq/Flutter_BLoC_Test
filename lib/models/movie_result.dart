import 'package:equatable/equatable.dart';

class MovieResult extends Equatable {
  String _title;
  String _year;
  String _imdbID;
  String _type;
  String _poster;

  MovieResult({String title, String year, String imdbID, String type, String poster}) {
    this._title = title;
    this._year = year;
    this._imdbID = imdbID;
    this._type = type;
    this._poster = poster;
  }

  String get title => _title;
  set title(String title) => _title = title;
  String get year => _year;
  set year(String year) => _year = year;
  String get imdbID => _imdbID;
  set imdbID(String imdbID) => _imdbID = imdbID;
  String get type => _type;
  set type(String type) => _type = type;
  String get poster => _poster;
  set poster(String poster) => _poster = poster;

  MovieResult.fromJson(Map<String, dynamic> json) {
    _title = json['Title'];
    _year = json['Year'];
    _imdbID = json['imdbID'];
    _type = json['Type'];
    _poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this._title;
    data['Year'] = this._year;
    data['imdbID'] = this._imdbID;
    data['Type'] = this._type;
    data['Poster'] = this._poster;
    return data;
  }
}
