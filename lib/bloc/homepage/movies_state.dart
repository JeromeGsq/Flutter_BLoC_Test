import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

@immutable
abstract class MoviesState extends Equatable {
  MoviesState([List props = const <dynamic>[]]) : super(props);
}

class MoviesData extends MoviesState {
  final MoviesViewModel viewModel;
  MoviesData(this.viewModel) : super([viewModel]);
}

class MoviesUninitialized extends MoviesData {
  MoviesUninitialized(MoviesViewModel viewModel) : super(viewModel);
}

class MoviesError extends MoviesData {
  MoviesError(MoviesViewModel viewModel) : super(viewModel);
}

class MoviesLoading extends MoviesData {
  MoviesLoading(MoviesViewModel viewModel) : super(viewModel);
}

class MoviesLoaded extends MoviesData {
  MoviesLoaded(MoviesViewModel viewModel) : super(viewModel);
}
