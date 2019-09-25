import 'package:flutter_bloc_test/models/movie_result.dart';

class MoviesViewModel {
  final bool isBusy;
  final int pageIndex;
  final List<MovieResult> movies;

  MoviesViewModel({
    this.isBusy = false,
    this.pageIndex = 1,
    this.movies,
  });

  MoviesViewModel copyWith({
    bool isBusy,
    int pageIndex,
    List<MovieResult> movies,
  }) {
    return MoviesViewModel(
      isBusy: isBusy ?? this.isBusy,
      pageIndex: pageIndex ?? this.pageIndex,
      movies: movies ?? [],
    );
  }
}
