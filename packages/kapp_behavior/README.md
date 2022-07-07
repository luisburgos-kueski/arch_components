# KAppBehavior

Understamd user behavior on your app. Observe ui, navigation and business logic events.

## Features

With this library you could track 4 main event sources:
- **Navigation**: Screen/Pages presented to the user (opened, closed).
- **Ui**: User interactions over domain named components (merchant_item_clicked, user_profile_icon_clicked)
- **Business Logic Requests**: Requests to business logic components to run any logic related. These are similar to the Command pattern.
  - Note: `bloc` events are a similar concept to these events.
- **Business Logic Results**: Results from running business logic. Using UseCases is suggested (on_login_success, on_login_failed)

## Installation

For now this shared library is declared as an internal package:

```
dependencies:
  kapp_behavior:
    path: './kapp_behavior'
```

## Usage

### Initialization

```dart
final kAppRouteObserver = KAppRouteObserver();

void main() {
  KAppBehavior.init(
    const KDefaultAppObserver(),
    kAppRouteObserver,
  );
}

class KDefaultAppObserver implements KAppEventObserver {
  const KDefaultAppObserver();

  @override
  void onEvent(KAppBehaviorEvent event) {
    //log(event.toString(), '-----');
  }
}
```

### Notify Navigation events

```dart
/// Extending from [KRouteAwareScreen] allows this `Screen` to notify about
/// [KScreenEvent].
class MyScreen extends KRouteAwareScreen {
  static const routeName = '/my-screen-route';
  static const screenName = 'MyScreen';

  const MyScreen({
    Key? key,
  }) : super(
          key: key,
          route: routeName,
          name: screenName,
        );

  @override
  KRouteAwareState<KRouteAwareScreen> createState() => _MyScreenState();
}

class _MyScreenState extends KRouteAwareState<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return MyView();
  }
}
```

### Notify Ui events

```dart
/// By using [KAppBehaviorUiNotifier] class and calling the
/// [KAppBehaviorUiNotifier.notifyUi] our `View` can log [UiKAppBehaviorEvent]s.
class MyView extends StatelessWidget with KAppBehaviorUiNotifier {
  const MyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyViewTemplate(
      tag: 'myView',
      isLoading: false,
      someList: SomeListView(
        items: state.itemsNames,
        onSomeItemClicked: (data) {
          notifyUi(
            OnSomeItemPressed(params: {
              'item_name': data.name,
            }),
          );

          /// TODO: Add more logic.
          ///
          /// Example using bloc:
          /// context.read<MyFeatureBloc>().add(NavigateToItem(data));
          ///
          /// Example using bloc:
          /// controller.navigateToItem(data);
        },
      ),
      onSomeButtonPressed: () {
        notifyUi(OnSomeButtonPressed());

        /// TODO: Add more logic.
        ///
        /// Example using bloc:
        /// context.read<MyFeatureBloc>().add(LoadSomeData());
        ///
        /// Example using bloc:
        /// controller.loadSomeData();
      },
    );
  }
}
```

### Notify Business Logic Requests events

```dart
/// By using [KAppBehaviorBlocNotifier] class and calling the
/// [KAppBehaviorBlocNotifier.notifyBusinessLogicRequest] our `controller`
/// can log [BlocKAppBehaviorEvent]s.
class MyController extends GetxController with KAppBehaviorBlocNotifier {
  MyController();

  RxList<SomeViewData> data = RxList();
  Rx<MyFeatureStatus> status = MyFeatureStatus.initial.obs;

  Future<void> loadSomeData() async {
    notifyBusinessLogicRequest(LoadSomeData());

    status(MyFeatureStatus.loading);

    final result = await LoadSomeDataUseCase(
      repository: FakeSomeDataRepository(),
    ).run();

    status(MyFeatureStatus.success);
    data.clear();
    data.addAll(SomeViewData.listFrom(result));
  }

  Future<void> navigateToItem(SomeViewData data) async {
    notifyBusinessLogicRequest(NavigateToItem(data));

    final String dataId = data.id;
    /// Example using Get for navigation management.
    Get.toNamed('/items/$dataId');
  }
}
```

### Notify Business Logic Results events

```dart
/// By using the [KAppBehaviorUseCaseNotifier] class and calling the
/// [KAppBehaviorUseCaseNotifier.notifyUseCase] our `UseCase` can log
/// [UseCaseKAppBehaviorEvent]s.
class LoadSomeDataUseCase with KAppBehaviorUseCaseNotifier {
  LoadSomeDataUseCase({
    /// TODO: Dependency Injection
    required this.repository,
  });

  final FakeSomeDataRepositoryContract repository;

  Future<List<SomeDataModel>> run() async {
    /// Emulates network latency.
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        await repository.loadSomeDataList();
        final list = repository.currentSomeDataList ?? [];

        notifyUseCase(
          OnSomeDataListLoaded(listLength: list.length),
        );

        return list;
      },
    );
  }
}
```

### Default classes in detail and how to add custom instances

TODO: Add notes about `KAppRouteObserver` and `KAppEventObserver`.

