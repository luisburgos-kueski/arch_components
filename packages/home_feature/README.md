# Home Feature Module

> 🚨 This module uses `KAppBehavior` and `KEventTracker`. 

Here are a few components and it's relation with `KAppBehavior`
- `HomeScreen` → `KAppBehavior.KScreenEvent`.
- `HomeBlocView` → `KAppBehavior.UiKAppBehaviorEvent`.
- `HomeBloc` → `KAppBehavior.BlocKAppBehaviorEvent`.
- `LoadMerchantsUseCase` → `KAppBehavior.UseCaseKAppBehaviorEvent`.

Here are a few components and it's relation with `KEventTracker`
- `HomeScreen` → `KEventTracker.NavigationNotifier`
- `LoadMerchantsTextButton` → `KEventTracker.UiEventNotifier`

For more information go to [addons](../../docs/ADDONS.md).

## Overview

TODO: Add diagram

## Presentation

### The Page

This could vary depending on the framework you are using to manage routing in your app. Here are some examples for `GetX` and `Flutter Modular`:

**GetX (example)**

```dart
final List<GetPage> pages = [
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
  //...more pages from other modules
];
```

**Flutter Modular (example)**

```dart
class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      HomeScreen.routeName, 
      child: (context, args) => HomeScreen(),
    ),
  ];
}
```

### The Route & The Screen

```dart
/// Extending from [KRouteAwareScreen] allows this `Screen` to notify about
/// [KScreenEvent].
class HomeScreen extends KRouteAwareScreen {
  static const routeName = '/home';
  static const screenName = 'HomeScreen';

  const HomeScreen({
    Key? key,
    required this.redirections,
  }) : super(
          key: key,
          route: routeName,
          name: screenName,
        );

  final HomeRedirections redirections;

  @override
  KRouteAwareState<KRouteAwareScreen> createState() => _HomeScreenState();
}

/// By using [NavigationNotifier] widget wrapper this `Screen` can notify about
/// [NavigationEvent]s.
class _HomeScreenState extends KRouteAwareState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationNotifier(
      key: const Key('home_screen'),
      child: HomeScreenLogBehaviorNotifier(
        redirections: widget.redirections,
      ),
    );
  }
}

class HomeScreenLogBehaviorNotifier extends StatelessWidget {
  const HomeScreenLogBehaviorNotifier({
    Key? key,
    required this.redirections,
  }) : super(key: key);

  final HomeRedirections redirections;

  @override
  Widget build(BuildContext context) {
    /// We could inject feature flags from this point of the
    /// widget tree, through a `ScreenController` if needed.
    ///
    /// Example:
    /// Use of feature toggles to perform view migrations.
    if (TempStaticFeatureToggles.useBloc) {
      return Scaffold(body: HomeBlocView(redirections));
    }

    return Scaffold(body: HomeControllerView(redirections));
  }
}
```

### The View & The View Template

Here is a `ViewTemplate` contract, we could easily describe an overview of what our view is expected to do:

```dart
class HomeViewTemplate extends StatelessWidget {
  const HomeViewTemplate({
    Key? key,
    required this.tag,
    this.isLoading = false,
    this.displayFailure = false,
    required this.failureViewBuilder,
    required this.merchantsList,
    this.onLoadMerchantsPressed,
    this.onClearMerchantsPressed,
    this.onSettingsPressed,
  }) : super(key: key);
}
```

Then we could use the `ViewTemplate` in our `View` component:

```dart
class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewTemplate(
      tag: 'myViewTag',
      isLoading: false,
      displayFailure: false,
      merchantsList: Container(), /*or MerchantsList(attributes)*/
      failureViewBuilder: () => {},
      onSettingsPressed: () => {},
      onLoadMerchantsPressed: () => {},
      onClearMerchantsPressed: () => {},
    );
  }
}
```

Ourt `ViewTemplate` can use `Components` defined for that `View`. For example:

```dart
/// By using [UiEventNotifier] our `Component` can log [OnClicked] events.
class LoadMerchantsTextButton extends StatelessWidget {
  const LoadMerchantsTextButton({
    Key? key,
    this.onLoad,
  }) : super(key: key);

  final Function()? onLoad;

  @override
  Widget build(BuildContext context) {
    return UiEventNotifier(
      key: const Key('load_merchants_text_button'),
      builder: (widgetId, publisher) {
        return TextButton(
          onPressed: () {
            publisher.publishUiEvent(OnClicked(widgetId: widgetId));
            if (onLoad != null) onLoad!();
          },
          child: const Text('Load merchants data'),
        );
      },
    );
  }
}
```

**BlocView (example):**

```dart
/// By using [KAppBehaviorUiNotifier] class and calling the
/// [KAppBehaviorUiNotifier.notifyUi] our `View` can log [UiKAppBehaviorEvent]s.
class HomeViewBloc extends StatelessWidget with KAppBehaviorUiNotifier {
  const HomeViewBloc(
    this.redirections, {
    Key? key,
  }) : super(key: key);

  final HomeRedirections redirections;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(redirections),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return HomeViewTemplate(
            tag: 'bloc',
            isLoading: state.status == HomeStatus.loading,
            displayFailure: state.status == HomeStatus.failure,
            merchantsList: MerchantsList(
              items: state.merchantNames,
              onMerchantItemClicked: (merchantData) {
                notifyUi(
                  OnMerchantItemPressed(params: {
                    'merchant_name': merchantData.name,
                  }),
                );
                context.read<HomeBloc>().add(
                      NavigateToMerchantDetail(merchantData),
                    );
              },
            ),
            failureViewBuilder: () => const Center(
              child: Text('TODO: Handle error'),
            ),
            onSettingsPressed: () {
              notifyUi(OnSettingsButtonPressed());
              context.read<HomeBloc>().add(NavigateToSettings());
            },
            onLoadMerchantsPressed: () {
              notifyUi(OnLoadMerchantsButtonPressed());
              context.read<HomeBloc>().add(LoadHomeMerchants());
            },
            onClearMerchantsPressed: () {
              notifyUi(OnClearMerchantsButtonPressed());
              context.read<HomeBloc>().add(ClearHomeMerchants());
            },
          );
        },
      ),
    );
  }
}
```

### State Holders

This could vary depending on the framework you are using to manage state in your app. Here are some examples for `GetX` and `Bloc`:

**GetXController (example)**

```dart
/// By using the `KAppBehaviorBlocNotifier` class and calling the 
/// `notifyBusinessLogicRequest` our state holder can log 
/// `KAppBehavior.BlocKAppBehaviorEvent` events.`
class HomeController extends GetxController with KAppBehaviorBlocNotifier {
  RxList<MerchantViewData> merchantData = RxList();
  Rx<HomeStatus> status = HomeStatus.initial.obs;

  Future<void> onLoadMerchantsEvent() async {
    notifyBusinessLogicRequest(LoadHomeMerchants());
    //TODO: Implement logic
  }

  Future<void> onClearMerchantsEvent() async {
    notifyBusinessLogicRequest(ClearHomeMerchants());
    //TODO: Implement logic
  }

  Future<void> onNavigateToMerchantDetail(MerchantViewData data) async {
    notifyBusinessLogicRequest(NavigateToMerchantDetail(data));
    //TODO: Implement logic
  }

  Future<void> onNavigateToSettings() async {
    notifyBusinessLogicRequest(NavigateToSettings());
    //TODO: Implement logic
  }
}
```

**Bloc (example)**

For using this approach, you will need to add the following observer to the Bloc library:

```dart
main() {
  /// bloc v7.x
  Bloc.observer = BlocToAppBehaviorObserver();

  /// bloc v8.x
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: BlocToAppBehaviorObserver(),
  );
}

````

The `BlocToAppBehaviorObserver` class:

```dart
/// By using the [KAppBehaviorBlocNotifier] class and calling the
/// [KAppBehaviorBlocNotifier.notifyBusinessLogicRequest] our `bloc` are
/// interpreted as [BlocKAppBehaviorEvent] when using the contract.
class BlocToAppBehaviorObserver extends BlocObserver
    with KAppBehaviorBlocNotifier {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is BlocKAppBehaviorEvent) {
      notifyBusinessLogicRequest(event);
    }
  }
}
```

Then you can work with Bloc as normally with no more code:

```dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    ///TODO: Update outdated naming convention
    on<LoadHomeMerchants>(_onLoadHomeMerchants);
    on<ClearHomeMerchants>(_onClearHomeMerchants);
    on<NavigateToMerchantDetail>(_onNavigateToMerchantDetail);
    on<NavigateToSettings>(_onNavigateToSettings);
  }

  Future<void> _onLoadHomeMerchants(
    LoadHomeMerchants event,
    Emitter<HomeState> emit,
  ) async {
    //TODO: Implement logic
  }

  Future<void> _onClearHomeMerchants(
    ClearHomeMerchants event,
    Emitter<HomeState> emit,
  ) async {
    //TODO: Implement logic
  }

  Future<void> _onNavigateToMerchantDetail(
    NavigateToMerchantDetail event,
    Emitter<HomeState> emit,
  ) async {
    //TODO: Implement logic
  }

  Future<void> _onNavigateToSettings(
    NavigateToSettings event,
    Emitter<HomeState> emit,
  ) async {
    //TODO: Implement logic
  }
}
```

## Data

### Repository

## Domain

### UseCases

The supported use cases for this module are:
- LoadMerchantsUseCase.
- ClearMerchantsUseCase.

**LoadMerchantsUseCase (example)**
```dart
/// By using the [KAppBehaviorUseCaseNotifier] class and calling the
/// [KAppBehaviorUseCaseNotifier.notifyUseCase] our `UseCase` can log
/// [UseCaseKAppBehaviorEvent]s.
class LoadMerchantsUseCase with KAppBehaviorUseCaseNotifier {
  LoadMerchantsUseCase({
    required this.repository,
  });

  final FakeMerchantsRepository repository;

  Future<List<Merchant>> run() async {
    return Future.delayed(const Duration(milliseconds: 2900), () async {
      await repository.loadMerchantsList();
      final list = repository.currentMerchantList ?? [];

      notifyUseCase(
        OnMerchantListLoaded(listLength: list.length),
      );

      return list;
    });
  }
}
```
