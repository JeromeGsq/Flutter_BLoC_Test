import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/networking/api.dart';
import './bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final ApiClient apiClient;

  MovieDetailsBloc(this.apiClient);

  @override
  MovieDetailsState get initialState => MovieDetailsUninitialized(MovieDetailsViewModel());

  @override
  Stream<MovieDetailsState> mapEventToState(
    MovieDetailsEvent event,
  ) async* {
    var state = (currentState as MovieDetailsData);

    if (event is LoadMovie) {
      yield MovieDetailsLoading(state.viewModel.copyWith(isBusy: true));

      var movie = await this.apiClient.getMovie(event.movieId);
      await Future.delayed(Duration(seconds: 1));
      yield MovieDetailsLoaded(
        state.viewModel.copyWith(isBusy: false, movie: movie),
      );
    }

    if (event is LoadFullDescription) {
      var movie = await this.apiClient.getMovie(event.movieId, fullDescription: true);
      yield MovieDetailsLoaded(
        state.viewModel.copyWith(fullDescription: movie.plot),
      );
      this.dispatch(ToggleFullDescription());
    }

    if (event is ToggleFullDescription) {
      yield MovieDetailsLoaded(
        state.viewModel.copyWith(showFullDescription: !state.viewModel.showFullDescription),
      );
    }
  }
}
