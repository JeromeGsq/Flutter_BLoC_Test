import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/models/movie_result.dart';

class HomepageMovieCell extends StatelessWidget {
  final MovieResult movieResult;
  const HomepageMovieCell(this.movieResult, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 100,
      color: Colors.blueGrey[50],
      onPressed: () {
        Navigator.of(context).pushNamed(
          "/movie_details",
          arguments: movieResult,
        );
      },
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            width: 70,
            fit: BoxFit.cover,
            imageUrl: movieResult.poster,
            placeholder: (context, url) => SizedBox(
              width: 70,
              child: Icon(Icons.image),
            ),
            errorWidget: (context, url, error) => SizedBox(
              width: 70,
              child: Icon(Icons.error),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${movieResult.title}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${movieResult.year}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
