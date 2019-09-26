import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

@immutable
abstract class HomepagesState extends Equatable {
  HomepagesState([List props = const <dynamic>[]]) : super(props);
}

class HomepageViewModelState extends HomepagesState {
  final HomepageViewModel viewModel;
  HomepageViewModelState(this.viewModel) : super([viewModel]);
}

class HomepageUninitializedState extends HomepageViewModelState {
  HomepageUninitializedState(HomepageViewModel viewModel) : super(viewModel);
}

class HomepageErrorState extends HomepageViewModelState {
  HomepageErrorState(HomepageViewModel viewModel) : super(viewModel);
}

class HomepageLoadingState extends HomepageViewModelState {
  HomepageLoadingState(HomepageViewModel viewModel) : super(viewModel);
}

class HomepageLoadedState extends HomepageViewModelState {
  HomepageLoadedState(HomepageViewModel viewModel) : super(viewModel);
}
