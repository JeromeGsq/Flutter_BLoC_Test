import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/networking/api.dart';
import './bloc.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepagesState> {
  final ApiClient apiClient;

  HomepageBloc(this.apiClient);

  @override
  get initialState => HomepageUninitializedState(HomepageViewModel());

  @override
  Stream<HomepagesState> mapEventToState(HomepageEvent event) async* {
    var state = (currentState as HomepageViewModelState);

    if (event is IncrementPageIndexEvent) {
      yield HomepageLoadingState(state.viewModel.copyWith(isBusy: true, movies: state.viewModel.movies));
      this.dispatch(LoadMoviesEvent());
    }

    if (event is LoadMoviesEvent) {
      var movies = await this.apiClient.getHomePageMovies(state.viewModel.pageIndex);
      yield HomepageLoadedState(
        state.viewModel.copyWith(
          isBusy: false,
          pageIndex: state.viewModel.pageIndex + 1,
          movies: state?.viewModel?.movies != null ? (state.viewModel.movies..addAll(movies)) : movies,
        ),
      );
    }
  }
}
