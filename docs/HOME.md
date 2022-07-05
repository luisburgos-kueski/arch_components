# Home Feature Module

## Data

### Repository

## Domain

### UseCases

- LoadMerchantsUseCase
- ClearMerchantsUseCase

**LoadMerchantsUseCase**
```dart
class LoadMerchantsUseCase with KAppBehaviorEventNotifier {
  Future<List<Merchant>> run() async {
    await repository.loadMerchantsList();
    final list = repository.currentMerchantList ?? [];

    notifyUseCase(
      OnMerchantListLoaded(
        params: {
          'list_length': list.length,
        },
      ),
    );
    return list;
  }
}
```

**ClearMerchantsUseCase**
```dart
class ClearMerchantsUseCase with KAppBehaviorEventNotifier {
  Future<void> run() async {
    //...calls to repositories or other use cases.
    
    notifyUseCase(OnMerchantListCleared());
  }
}
```

## Presentation

Rules of Thumb:

- `Page` is defined as the association of a `Screen` to a `Route`.
- `Route` is the full path of the `Page`
- For now, a `Screen` is the same as a `View`, but also a point of feature toggles injection to vary the UI.
- `View` is the glue for a `ViewTiemplate` with its `State Holder`.
  - The `View` is responsible to read attributes from the `StateHolder` to make the to `ViewTemplate` look smart.
  - The `View` requests business logic execution to its `StateHolder`.  
- `ViewTemplate` defines the `Screen` skeleton, it's a dump component exposing callbacks and customization attributes.  
- `StateHolder` 
  - A `StateHolder` is a state projection component which listens to Data Access Streams. 
  - A `StateHolder` could filter or transform the data in terms of `ViewData` information.
  - A `StateHolder` runs `UseCases` and updates local state if needed.  
- `ViewData` is the most atomic Data scope for a view. In other words, partial views of a `Data Model`

### ViewTemplate

```dart
class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewTemplate(
      tag: 'myView',
      isLoading: false,
      displayFailure: false,
      merchantsList: Contaier(), /*or MerchantsList(attributes)*/
      failureViewBuilder: () => {},
      onSettingsPressed: () => {},
      onLoadMerchantsPressed: () => {},
      onClearMerchantsPressed: () => {},
    );
  }
}
```

**BlocView (example):**

```dart
class HomeBlocView extends StatelessWidget {
  const HomeBlocView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return HomeViewTemplate(
          tag: 'bloc',
          isLoading: state.status == HomeStatus.loading,
          displayFailure: state.status == HomeStatus.failure,
          merchantsList: MerchantsList(
            items: state.merchantNames,
            onGoToMerchantDetail: (merchantData) {
              context.read<HomeBloc>().add(
                    NavigateToMerchantDetail(merchantData),
                  );
            },
          ),
          failureViewBuilder: () => const Center(
            child: Text('TODO: Handle error'),
          ),
          onSettingsPressed: () {
            context.read<HomeBloc>().add(NavigateToSettings());
          },
          onLoadMerchantsPressed: () {
            context.read<HomeBloc>().add(LoadHomeMerchants());
          },
          onClearMerchantsPressed: () {
            context.read<HomeBloc>().add(ClearHomeMerchants());
          },
        );
      },
    );
  }
}
```

### State Holders

**GetXController (example)**

```dart
class HomeController extends GetxController with KAppBehaviorEventNotifier {
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
 BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: BlocToAppBehaviorObserver(),
  );
}

class BlocToAppBehaviorObserver extends BlocObserver
    with KAppBehaviorEventNotifier {
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

### The Screen

**NOTES**: 
- Extend from `KRouteAwareScreen`.
- We might want to add feature flags injection from this point of the widget tree.

```dart
class HomeScreen extends KRouteAwareScreen {
  static const routeName = '/home';
  static const screenName = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(
    key: key,
    route: routeName,
    name: screenName,
  );

  @override
  KRouteAwareState<KRouteAwareScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends KRouteAwareState<KRouteAwareScreen> {
  @override
  Widget build(BuildContext context) {
    if (TempStaticFeatureToggles.useBloc) {
      return const Scaffold(body: HomeBlocView());
    }

    return const Scaffold(body: HomeControllerView());
  }
} 
```

### The Page

This could vary depending on the framework your are using to manage routing in your app.

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


**Modular (example)**

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
