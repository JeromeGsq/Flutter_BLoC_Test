import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/networking/api.dart';
import './bloc.dart';
import './movies_viewmodel.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final ApiClient apiClient;

  MoviesBloc(this.apiClient);

  @override
  get initialState => MoviesUninitialized(MoviesViewModel());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    var state = (currentState as MoviesData);

    if (event is IncrementPageIndex) {
      yield MoviesLoading(state.viewModel.copyWith(isBusy: true, movies: state.viewModel.movies));
      this.dispatch(LoadMovies());
    }

    if (event is LoadMovies) {
      var movies = await this.apiClient.getHomePageMovies(state.viewModel.pageIndex);
      yield MoviesLoaded(
        state.viewModel.copyWith(
          isBusy: false,
          pageIndex: state.viewModel.pageIndex + 1,
          movies: state?.viewModel?.movies != null ? (state.viewModel.movies..addAll(movies)) : movies,
        ),
      );
    }
  }
}
