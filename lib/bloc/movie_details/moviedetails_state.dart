import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  MovieDetailsState([List props = const <dynamic>[]]) : super(props);
}

class MovieDetailsViewModelState extends MovieDetailsState {
  final MovieDetailsViewModel viewModel;
  MovieDetailsViewModelState(this.viewModel) : super([viewModel]);
}

class MovieDetailsUninitializedState extends MovieDetailsViewModelState {
  MovieDetailsUninitializedState(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsErrorState extends MovieDetailsViewModelState {
  MovieDetailsErrorState(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsLoadingState extends MovieDetailsViewModelState {
  MovieDetailsLoadingState(MovieDetailsViewModel viewModel) : super(viewModel);
}

class MovieDetailsLoadedState extends MovieDetailsViewModelState {
  MovieDetailsLoadedState(MovieDetailsViewModel viewModel) : super(viewModel);
}
