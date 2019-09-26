import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/bloc/simple_bloc_delegate.dart';
import 'package:flutter_bloc_test/modules/homepage/home_page.dart';
import 'package:flutter_bloc_test/modules/movie_details/movie_details_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    FlutterBLoCApp(title: "Flutter Bloc App"),
  );
}

class FlutterBLoCApp extends StatefulWidget {
  final String title;

  FlutterBLoCApp({Key key, this.title}) : super(key: key);

  @override
  _FlutterBLoCAppState createState() => _FlutterBLoCAppState();
}

class _FlutterBLoCAppState extends State<FlutterBLoCApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: widget.title,
      onGenerateRoute: _getRoute,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }

  /// Navigation
  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/movie_details':
        return _buildRoute(settings, MovieDetailsPage(settings.arguments));
      default:
        return _buildRoute(settings, HomePage());
    }
  }

  // Build route
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
