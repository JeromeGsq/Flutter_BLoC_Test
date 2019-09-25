import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  MoviesEvent([List props = const <dynamic>[]]) : super(props);
}

class IncrementPageIndex extends MoviesEvent {}

class LoadMovies extends MoviesEvent {}
