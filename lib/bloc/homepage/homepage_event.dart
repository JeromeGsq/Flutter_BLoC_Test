import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  HomepageEvent([List props = const <dynamic>[]]) : super(props);
}

class IncrementPageIndexEvent extends HomepageEvent {}

class LoadMoviesEvent extends HomepageEvent {}
