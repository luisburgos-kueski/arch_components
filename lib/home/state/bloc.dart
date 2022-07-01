import 'package:arch_components/home/domain/clear_merchants_use_case.dart';
import 'package:arch_components/home/domain/load_merchants_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kapp_behavior/kapp_behavior.dart';
import 'package:merchants_data/merchants_data.dart';

import '../shared/view_data_model.dart';

abstract class HomeEvent {}

class LoadMerchantsPressed extends HomeEvent implements KAppBehaviorEvent {
  LoadMerchantsPressed() : timestamp = DateTime.now();

  @override
  String get name => "load_merchants";

  @override
  Map<String, dynamic>? get params => null;

  @override
  final DateTime timestamp;
}

class ClearMerchantsPressed extends HomeEvent {}

class NavigateToMerchantDetailEvent extends HomeEvent {
  NavigateToMerchantDetailEvent(this.merchantData);

  final MerchantViewData merchantData;
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
    on<LoadMerchantsPressed>(_onLoadMerchantsEvent);
    on<ClearMerchantsPressed>(_onClearMerchantsEvent);
    on<NavigateToMerchantDetailEvent>(_onNavigateToMerchantDetailEvent);
  }

  Future<void> _onLoadMerchantsEvent(
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

  Future<void> _onClearMerchantsEvent(
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

  Future<void> _onNavigateToMerchantDetailEvent(
    NavigateToMerchantDetailEvent event,
    Emitter<HomeState> emit,
  ) async {
    final MerchantViewData data = event.merchantData;
    final String merchantId = data.id;

    Get.toNamed('/home/$merchantId');

    ///TODO: Validate if makes sense to have this non-emitter method
    ///TODO: Should we emit app behavior events here?
    ///TODO: Evaluate navigation command handler strategy
  }
}
