import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc_events.dart';


class MerchantDetailState {
  const MerchantDetailState();
}

class MerchantDetailBloc
    extends Bloc<MerchantDetailEvent, MerchantDetailState> {
  MerchantDetailBloc() : super(const MerchantDetailState()) {
    on<CloseMerchantDetail>(_onCloseMerchantDetail);
  }

  Future<void> _onCloseMerchantDetail(
    CloseMerchantDetail event,
    Emitter<MerchantDetailState> emit,
  ) async {
    Get.back();
  }
}
