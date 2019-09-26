import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/homepage/bloc.dart';
import 'package:flutter_bloc_test/core/widgets/loader_page.dart';
import 'package:flutter_bloc_test/modules/movie_cell/movie_cell.dart';
import 'package:flutter_bloc_test/networking/api.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomepageBloc>(
      builder: (context) => HomepageBloc(ApiClient())..dispatch(IncrementPageIndexEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(
            child: BlocBuilder<HomepageBloc, HomepagesState>(
              builder: (context, state) {
                if (state is HomepageUninitializedState) {
                  return Text("Uninitialized");
                }
                if (state is HomepageErrorState) {
                  return Text("Error");
                }
                if (state is HomepageLoadingState) {
                  return Text("Loading");
                }
                if (state is HomepageLoadedState) {
                  if (state?.viewModel?.movies?.isEmpty == true) {
                    return Text("No movies");
                  } else {
                    return Text("Next page to load : ${state.viewModel.pageIndex}");
                  }
                }
                return Text("-");
              },
            ),
          ),
        ),
        body: BlocListener<HomepageBloc, HomepagesState>(
          listener: (context, state) {},
          child: BlocBuilder<HomepageBloc, HomepagesState>(
            builder: (context, state) {
              if (state is HomepageUninitializedState) {
                return LoadingView();
              } else if (state is HomepageErrorState) {
                return Center(child: Text("Error"));
              } else {
                var data = state as HomepageViewModelState;
                if (data?.viewModel?.movies != null && data?.viewModel?.movies?.isEmpty == false) {
                  return buildPage(state, context);
                } else {
                  return LoadingView();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildPage(HomepageViewModelState state, BuildContext context) {
    return IncrementallyLoadingListView(
      padding: const EdgeInsets.all(8),
      hasMore: () => true,
      itemCount: () => state.viewModel.movies.length,
      loadMore: () async {
        if (!state.viewModel.isBusy) {
          BlocProvider.of<HomepageBloc>(context).dispatch(IncrementPageIndexEvent());
        }
      },
      itemBuilder: (BuildContext context, int index) {
        // Is this the last item ? Replace it with CircularProgressIndicator
        if (state.viewModel.movies?.length != null && index == state.viewModel.movies.length - 1) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: HomepageMovieCell(state.viewModel.movies[index]),
          );
        }
      },
    );
  }
}
