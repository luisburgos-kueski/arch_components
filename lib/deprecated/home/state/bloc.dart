import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

import '../domain/clear_merchants_use_case.dart';
import '../domain/load_merchants_use_case.dart';
import '../shared/bloc_events.dart';
import '../shared/view_data_model.dart';

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

///TODO:
///Research if onEvent method could be override to intercept Navigation events.
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

  Future<void> _onClearHomeMerchants(
    ClearHomeMerchants event,
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
    NavigateToMerchantDetail event,
    Emitter<HomeState> emit,
  ) async {
    final MerchantViewData data = event.merchantData;
    final String merchantId = data.id;

    ///TODO: Validate if makes sense to have this non-emitter method
    ///TODO: Should we emit app behavior events here?
    ///TODO: Evaluate navigation command handler strategy
    Get.toNamed('/home/$merchantId');
  }

  Future<void> _onNavigateToSettings(
    NavigateToSettings event,
    Emitter<HomeState> emit,
  ) async {
    Get.toNamed(AppBehaviorScreen.routeName);
  }
}
