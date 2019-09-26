import 'package:flutter_bloc_test/models/movie.dart';
import 'package:flutter_bloc_test/models/movie_result.dart';

class MovieDetailsViewModel {
  bool isBusy;
  bool showFullDescription;
  MovieResult movieResult;
  Movie movie;
  String fullDescription;

  MovieDetailsViewModel({
    this.isBusy = false,
    this.showFullDescription = false,
    this.movieResult,
    this.movie,
    this.fullDescription = "",
  });

  MovieDetailsViewModel copyWith({
    bool isBusy,
    bool showFullDescription,
    MovieResult movieResult,
    Movie movie,
    String fullDescription,
  }) {
    return MovieDetailsViewModel(
      isBusy: isBusy ?? this.isBusy,
      showFullDescription: showFullDescription ?? this.showFullDescription,
      movieResult: movieResult ?? this.movieResult,
      movie: movie ?? this.movie,
      fullDescription: fullDescription ?? this.fullDescription,
    );
  }
}
