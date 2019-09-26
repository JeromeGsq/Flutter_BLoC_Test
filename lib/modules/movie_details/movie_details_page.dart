import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/movie_details/bloc.dart';
import 'package:flutter_bloc_test/core/widgets/loader_page.dart';
import 'package:flutter_bloc_test/models/movie_result.dart';
import 'package:flutter_bloc_test/networking/api.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieResult movieResult;

  const MovieDetailsPage(
    this.movieResult, {
    Key key,
  }) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
      builder: (context) =>
          MovieDetailsBloc(ApiClient())..dispatch(LoadMovieDetailsEvent(this.widget.movieResult.imdbID)),
      child: BlocListener<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              widget.movieResult?.title.toString(),
            ),
          ),
          body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsUninitializedState) {
                return LoadingView();
              }
              if (state is MovieDetailsErrorState) {
                return Center(child: Text("Error"));
              }
              if (state is MovieDetailsLoadingState && state.viewModel.movie == null) {
                return LoadingView();
              }
              return buildPage(state, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildPage(MovieDetailsViewModelState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              imageUrl: state?.viewModel?.movie?.poster ?? "",
              placeholder: (context, url) => SizedBox(
                child: Icon(Icons.image),
              ),
              errorWidget: (context, url, error) => SizedBox(
                child: Icon(Icons.error),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      state.viewModel.showFullDescription
                          ? state.viewModel?.fullDescription.toString()
                          : state.viewModel?.movie?.plot.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    MaterialButton(
                      child: state.viewModel.isBusy
                          ? CircularProgressIndicator()
                          : Icon(state.viewModel.showFullDescription
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                      onPressed: () {
                        var bloc = BlocProvider.of<MovieDetailsBloc>(context);
                        if (state.viewModel?.fullDescription?.isEmpty ?? true) {
                          bloc.dispatch(LoadFullDescriptionEvent(this.widget.movieResult.imdbID));
                        } else {
                          bloc.dispatch(ToggleFullDescriptionEvent());
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
