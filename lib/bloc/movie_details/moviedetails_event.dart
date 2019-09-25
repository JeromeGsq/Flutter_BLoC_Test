import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  MovieDetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadMovie extends MovieDetailsEvent {
  final String movieId;
  LoadMovie(this.movieId);
}

class LoadFullDescription extends LoadMovie {
  LoadFullDescription(String movieId) : super(movieId);
}

class ToggleFullDescription extends MovieDetailsEvent {}
