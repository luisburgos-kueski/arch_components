import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchants_data/merchants_data.dart';

import '../../domain/clear_merchants_use_case.dart';
import '../../domain/load_merchants_use_case.dart';
import '../../redirections.dart';
import '../view_data_model.dart';
import 'bloc_events.dart';

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

class HomeBloc extends Bloc<HomeBlocEvent, HomeState> {
  HomeBloc(this.redirections) : super(const HomeState()) {
    ///TODO: Update outdated naming convention
    on<LoadHomeMerchants>(_onLoadHomeMerchants);
    on<ClearHomeMerchants>(_onClearHomeMerchants);
    on<NavigateToMerchantDetails>(_onNavigateToMerchantDetail);
    on<NavigateToAppBehavior>(_onNavigateToSettings);
    on<NavigateToLogBehavior>(_onNavigateToSecondSettings);
    on<ShowClearActionInstructions>(_onDisplayClearActionInstructions);
  }

  final HomeRedirections redirections;

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
    NavigateToMerchantDetails event,
    Emitter<HomeState> emit,
  ) async {
    final MerchantViewData data = event.merchantData;
    final String merchantId = data.id;

    ///TODO: Validate if makes sense to have this non-emitter method
    ///TODO: Should we emit app behavior events here?
    ///TODO: Evaluate navigation command handler strategy
    redirections.goToMerchantDetail(merchantId);
  }

  Future<void> _onNavigateToSettings(
    NavigateToAppBehavior event,
    Emitter<HomeState> emit,
  ) async {
    redirections.goToSettings();
  }

  Future<void> _onNavigateToSecondSettings(
    NavigateToLogBehavior event,
    Emitter<HomeState> emit,
  ) async {
    redirections.goToSecondSettings();
  }

  Future<void> _onDisplayClearActionInstructions(
    ShowClearActionInstructions event,
    Emitter<HomeState> emit,
  ) async {
    event.show();
  }
}
