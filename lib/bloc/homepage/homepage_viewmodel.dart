import 'package:flutter_bloc_test/models/movie_result.dart';

class HomepageViewModel {
  final bool isBusy;
  final int pageIndex;
  final List<MovieResult> movies;

  HomepageViewModel({
    this.isBusy = false,
    this.pageIndex = 1,
    this.movies,
  });

  HomepageViewModel copyWith({
    bool isBusy,
    int pageIndex,
    List<MovieResult> movies,
  }) {
    return HomepageViewModel(
      isBusy: isBusy ?? this.isBusy,
      pageIndex: pageIndex ?? this.pageIndex,
      movies: movies ?? [],
    );
  }
}
