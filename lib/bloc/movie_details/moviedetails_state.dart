import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  MovieDetailsState([List props = const <dynamic>[]]) : super(props);
}

class MovieDetailsData extends MovieDetailsState {
  final MovieDetailsViewModel viewModel;
  MovieDetailsData(this.viewModel) : super([viewModel]);
}

class MovieDetailsUninitialized extends MovieDetailsData {
  MovieDetailsUninitialized(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsError extends MovieDetailsData {
  MovieDetailsError(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsLoading extends MovieDetailsData {
  MovieDetailsLoading(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsLoaded extends MovieDetailsData {
  MovieDetailsLoaded(MovieDetailsViewModel viewModel) : super(viewModel);
}
