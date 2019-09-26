import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  MovieDetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadMovieDetailsEvent extends MovieDetailsEvent {
  final String movieId;
  LoadMovieDetailsEvent(this.movieId);
}

class LoadFullDescriptionEvent extends LoadMovieDetailsEvent {
  LoadFullDescriptionEvent(String movieId) : super(movieId);
}

class ToggleFullDescriptionEvent extends MovieDetailsEvent {}
