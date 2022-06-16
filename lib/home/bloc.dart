import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'view_data_model.dart';

class HomeEvent {}

class LoadMerchantsEvent extends HomeEvent {}

class ClearMerchantsEvent extends HomeEvent {}

class NavigateToMerchantDetailEvent extends HomeEvent {
  NavigateToMerchantDetailEvent(this.merchantData);
  final MerchantViewData merchantData;
}

enum HomeStatus { initial, loading, success, failure }

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
    on<LoadMerchantsEvent>(_onLoadMerchantsEvent);
    on<ClearMerchantsEvent>(_onClearMerchantsEvent);
    on<NavigateToMerchantDetailEvent>(_onNavigateToMerchantDetailEvent);
  }

  Future<void> _onLoadMerchantsEvent(
    LoadMerchantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    /// TODO: Call repository or use case
    await Future.delayed(const Duration(milliseconds: 2100));

    emit(state.copyWith(
      status: () => HomeStatus.success,
      merchantNames: () => [
        const MerchantViewData(id: 'xiaomi', name: 'Xiaomi'),
        const MerchantViewData(id: 'doto', name: 'Tío Doto'),
        const MerchantViewData(id: 'meibi', name: 'Meibi'),
        const MerchantViewData(id: 'gaia', name: 'GAIA Design'),
      ],
    ));
  }

  Future<void> _onClearMerchantsEvent(
    ClearMerchantsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeStatus.loading));

    /// TODO: Call repository or use case
    await Future.delayed(const Duration(milliseconds: 1500));

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

    ///TODO: Validate if makes sense to have this non-emitter method.
    //emit(state.copyWith(status: () => HomeStatus.success));
  }
}
