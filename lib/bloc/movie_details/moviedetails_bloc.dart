import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/networking/api.dart';
import './bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final ApiClient apiClient;

  MovieDetailsBloc(this.apiClient);

  @override
  MovieDetailsState get initialState => MovieDetailsUninitializedState(MovieDetailsViewModel());

  @override
  Stream<MovieDetailsState> mapEventToState(
    MovieDetailsEvent event,
  ) async* {
    var state = (currentState as MovieDetailsViewModelState);

    if (event is LoadMovieDetailsEvent) {
      yield MovieDetailsLoadingState(state.viewModel.copyWith(isBusy: true));

      var movie = await this.apiClient.getMovie(event.movieId);
      await Future.delayed(Duration(seconds: 1));
      yield MovieDetailsLoadedState(
        state.viewModel.copyWith(isBusy: false, movie: movie),
      );
    }

    if (event is LoadFullDescriptionEvent) {
      var movie = await this.apiClient.getMovie(event.movieId, fullDescription: true);
      yield MovieDetailsLoadedState(
        state.viewModel.copyWith(fullDescription: movie.plot),
      );
      this.dispatch(ToggleFullDescriptionEvent());
    }

    if (event is ToggleFullDescriptionEvent) {
      yield MovieDetailsLoadedState(
        state.viewModel.copyWith(showFullDescription: !state.viewModel.showFullDescription),
      );
    }
  }
}
