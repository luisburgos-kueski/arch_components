import 'package:arch_components/home/domain/clear_merchants_use_case.dart';
import 'package:arch_components/home/domain/load_merchants_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

import '../shared/view_data_model.dart';

//TODO: Verify overrides. Could this be optional to override?
abstract class HomeEvent extends Equatable implements KDefaultAppBehaviorEvent {
  HomeEvent()
      : timestamp = DateTime.now(),
        super();

  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic>? get params => null;

  @override
  List<Object?> get props => [];
}

class LoadMerchantsPressed extends HomeEvent {
  @override
  String get name => 'load_merchants_pressed';
}

class NavigateToSettingsPressed extends HomeEvent {
  @override
  String get name => 'navigate_to_settings';
}

class ClearMerchantsPressed extends HomeEvent {
  @override
  String get name => 'clear_merchants_pressed';
}

class NavigateToMerchantDetailPressed extends HomeEvent {
  NavigateToMerchantDetailPressed(this.merchantData);

  final MerchantViewData merchantData;

  @override
  String get name => 'navigate_to_merchant_detail';

  @override
  Map<String, dynamic>? get params => {
        'merchant_name': merchantData.name,
        'merchant_id': merchantData.id,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [merchantData];
}

enum F { a, b }

class HomeState {
  const HomeState({
    this.merchantNames = const [],
    this.status = HomeStatus.initial,
  });

  final List<MerchantViewData> merchantNames;
  final HomeStatus status;

  HomeState copyWith({
    HomeStatus Function()? status,
    List<MerchantViewData> Function()? merchantNames,
  }) {
    return HomeState(
      status: status != null ? status() : this.status,
      merchantNames:
          merchantNames != null ? merchantNames() : this.merchantNames,
    );
  }
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    ///TODO: Update outdated naming convention
    on<LoadMerchantsPressed>(_onLoadMerchants);
    on<ClearMerchantsPressed>(_onClearMerchants);
    on<NavigateToMerchantDetailPressed>(_onNavigateToMerchantDetail);
    on<NavigateToSettingsPressed>(_onNavigateToSettings);
  }

  Future<void> _onLoadMerchants(
    LoadMerchantsPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    final result = await LoadMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    emit(state.copyWith(
      status: () => HomeStatus.success,
      merchantNames: () => MerchantViewData.listFrom(result),
    ));
    // bloc.add(Event())
  }

  Future<void> _onClearMerchants(
    ClearMerchantsPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    await ClearMerchantsUseCase(
      repository: FakeMerchantsRepository(),
    ).run();

    emit(state.copyWith(
      status: () => HomeStatus.success,
      merchantNames: () => const [],
    ));
  }

  Future<void> _onNavigateToMerchantDetail(
    NavigateToMerchantDetailPressed event,
    Emitter<HomeState> emit,
  ) async {
    final MerchantViewData data = event.merchantData;
    final String merchantId = data.id;

    Get.toNamed('/home/$merchantId');

    ///TODO: Validate if makes sense to have this non-emitter method
    ///TODO: Should we emit app behavior events here?
    ///TODO: Evaluate navigation command handler strategy
  }

  Future<void> _onNavigateToSettings(
    NavigateToSettingsPressed event,
    Emitter<HomeState> emit,
  ) async {
    Get.toNamed(AppBehaviorScreen.routeName);
  }
}
