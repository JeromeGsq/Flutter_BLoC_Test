Flutter Bloc
===============

**Bloc package**: https://felangel.github.io/bloc

**Bloc VSCode extension**: https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc

**Equatable**: https://pub.dev/packages/equatable

_______________

> This ReadMe does not reflect the classes and screens used in this repository.
> You will find a simplified example of how I use Bloc in this ReadMe.

_______________

• **files and folders**
```
Project
+-- lib
    +-- bloc
        +-- exemple
            |-- bloc.dart
            |-- example_bloc.dart
            |-- example_event.dart
            |-- example_state.dart
            +-- example_viewmodel.dart
```
• **bloc.dart**

Useful to `import` each file in this folder:
```dart
export 'example_bloc.dart';
export 'example_event.dart';
export 'example_state.dart';
export 'example_viewmodel.dart';
```

• **example_event.dart**

Events are the input to a Bloc. They are commonly dispatched in response to user interactions such as button presses or lifecycle events like page loads.
You can add parameter to the event (ex: login & password from UI)
```dart
@immutable
abstract class ExampleEvent extends Equatable {
  exampleEvent([List props = const <dynamic>[]]) : super(props);
}

class EventA extends ExampleEvent {}

class EventB extends ExampleEvent {
  final String url;
  EventB(this.url);
}

class EventC extends ExampleEvent{}
```

• **example_state.dart**

States are the output of a Bloc and represent a part of your application's state. UI components can be notified of states and redraw portions of themselves based on the current state.
```dart
// Main state
@immutable
abstract class ExempleState extends Equatable {
  ExempleState([List props = const <dynamic>[]]) : super(props);
}

// State with ViewModel
class ExempleViewModelState extends ExempleState {
  final ExempleViewModel viewModel;
  ExempleViewModel(this.viewModel) : super([viewModel]);
}

// First state when Bloc is created
class ExempleUninitializedState extends ExempleViewModelState {
  ExempleUninitializedState(ExempleViewModel viewModel) : super(viewModel);
}

class StateA extends ExempleViewModelState {
  StateA(ExempleViewModel viewModel) : super(viewModel);
}

class StateB extends ExempleViewModelState {
  StateB(ExempleViewModel viewModel) : super(viewModel);
}

class StateC extends ExempleViewModelState {
  StateB(ExempleViewModel viewModel) : super(viewModel);
}
```

• **example_viewmodel.dart**

This class will help you to keep data between two `States`.
Use `copyWith` to update the new datas and keep the others, then `copyWith` will return the new instance `ExempleViewModel`.
```dart
class ExempleViewModel {
  bool isBusy;
  String name;
  Data data;

  ExempleViewModel({
    this.isBusy = false,
    this.name,
    this.data,
  });

  ExempleViewModel copyWith({
    bool isBusy,
    String name,
    Data data,
  }) {
    return ExempleViewModel(
      isBusy: isBusy ?? this.isBusy,
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }
}
```

• **example_bloc.dart**

A Bloc (Business Logic Component) is a component which converts a Stream of incoming Events into a Stream of outgoing States. Think of a Bloc as being the "brains" described above.

Every Bloc must extend the base Bloc class which is part of the core bloc package.

When an `Event` is dispatched, `mapEventToState` will be called with the event as a parameter.
You have to filter the event type then `yield` a new `State`. You can perform an asynchronous proccess here.
```dart
  @override
  ExempleState get initialState => ExempleUninitializedState(ExempleViewModel());

  @override
  Stream<ExempleState> mapEventToState(ExampleEvent event) async* {
    // You can access to "state.viewModel"
    var state = (currentState as ExempleViewModelState);
    
    // ex: Yield a new state to show loader in the UI and block user interactions
    if (event is EventA) {
      yield StateA(state.viewModel.copyWith(isBusy: true, name: "Start loading"));
    }

    // ex: Yield a new state with new datas
    if (event is EventB) {
      var result = await Api.GetData(event.url);
      yield StateB(state.viewModel.copyWith(isBusy: false, name: "Finish loading", data: result.data));
    }

    // ex: Yield a new state to clear current datas 
    if (event is EventC) {
      yield StateC(state.viewModel.copyWith(data: Data()));
      // you can dispatch event here if you want.
      this.dispatch(EventA());
    }
  }
```


Widgets
===============

• **BlocProvider** 

BlocProvider is a Flutter widget which provides a bloc to its children via `BlocProvider.of<T>(context)`. 
It is used as a dependency injection (DI) widget so that a single instance of a bloc can be provided to multiple widgets within a subtree.

In most cases, BlocProvider should be used to build new blocs which will be made available to the rest of the subtree. 
In this case, since BlocProvider is responsible for creating the bloc, it will automatically handle disposing the bloc with `child:`.
```dart

// Statefull widget ...
class _ExemplePageState extends State<ExemplePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExempleBloc>(  
      // Provide bloc here and dispatch an event directly if you want
      builder: (context) => ExempleBloc()..dispatch(EventA()),
      child: ...
  }
}
```

• **BlocBuilder** 

`BlocBuilder` is a Flutter widget which requires a Bloc and a builder function. 
`BlocBuilder` handles building the widget in response to new states. `BlocBuilder` is very similar to `StreamBuilder` but has a more simple API to reduce the amount of boilerplate code needed.
The builder function will potentially be called many times and should be a pure function that returns a widget in response to the state.

```dart
 AppBar(
   backgroundColor: Colors.orange,
   title: Center(
      child: BlocBuilder<ExempleBloc, ExempleState>(
      builder: (context, state) {
         if (state is ExempleUninitializedState) {
            return Text("Uninitialized");
         }
         if (state is StateA) {
           return Text("Loading");
         }
         if (state is StateB) {
            if (state?.viewModel?.data?.isEmpty == true) {
               return Text("No data");
            }else{
               return Text("Data : ${state.viewModel.data}");
            }
         }
         // Always return a default widget
         return Text("-");
         },
      ),
   ),
),
```

• **BlocListener** 

See `BlocListener` if you want to "do" anything in response to state changes such as navigation, showing a dialog, etc...

`BlocListener` is a Flutter widget which takes a `BlocWidgetListener` and an optional `Bloc` and invokes the `listener` in response to state changes in the bloc. 
It should be used for functionality that needs to occur once per state change such as navigation, showing a `SnackBar`, showing a `Dialog`, etc...

`listener` is only called once for each state change (NOT including initialState) unlike builder in BlocBuilder and is a void function.

If the bloc parameter is omitted, `BlocListener` will automatically perform a lookup using `BlocProvider` and the current BuildContext.

```dart
body: BlocListener<ExempleBloc, ExempleState>(
   // You can provide bloc here if you want
   // bloc: exempleBloc,
   listener: (context, state) {},
   child: ...
}
```
• **Dispatch events** 

```dart
FloatingActionButton(
   child: Icon(Icons.clear),
   onPressed: () {
       var bloc = BlocProvider.of<ExempleBloc>(context);
       bloc.dispatch(EventC());
   },
),
```

• **Navigation**

You can use the `Navigator`:
```dart
MaterialButton(
   height: 100,
   color: Colors.blueGrey[50],
   onPressed: () {
      Navigator.of(context).pushNamed(
         "/next_page",
         arguments: "exempleArgument",
      );
   },
)
```

If you need to navigate from the `Bloc`:
```dart
SchedulerBinding.instance.addPostFrameCallback((_) {
   Navigator.of(context).push(...);
});
```

source: https://dev.to/pedromassango/flutter-bloc-a-better-way-to-handle-navigation-4fig

Here are some rules:
===============

1. Every screen has its own Bloc.
2. Every Bloc must have a dispose() method.
3. Don’t use StatelessWidget with Bloc.
4. Override didChangeDependencies() to initialise Bloc, not initState().
5. Override dispose() method to dispose Bloc.

More infos here : https://medium.com/flutterpub/effective-bloc-pattern-45c36d76d5fe

_______________

> You will notice that I don't `dispose()` my Blocs. 
> The `BlocProvider` does it itself:
```dart
/// Automatically handles disposing the block when used with a `builder`.
class BlocProvider<T extends Bloc<dynamic, dynamic>> extends Provider<T> {}
```
_______________


Pro/Cons
===============
**Cons:** 

• Multiple `if`/`else if` inside the UI part to filter states

• Lot of files for only one Bloc (4~5)

• Lot of `Events` like `Redux`

• Very difficult to use without a `viewModel` class passed through each states

• No one seems to do the same thing on Internet tutorials

• Hard to learn or understand ...

**Pros:**

• You can't break the design pattern easily

• You can't edit the states outside the Bloc

• You have access to the currentState easily

• You can do asynchronous call without difficulty before returning a new state

• No "visible" Streams, Sinks, Controllers, etc. thanks to the Bloc package

• ... but easy to implement
