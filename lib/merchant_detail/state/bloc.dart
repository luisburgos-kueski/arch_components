import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class MerchantDetailEvent {}

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class CloseMerchantDetail extends MerchantDetailEvent {}

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class MerchantDetailState {
  const MerchantDetailState();
}

@Deprecated('Use MerchantDetailScreen from merchant_detail_feature')
class MerchantDetailBloc
    extends Bloc<MerchantDetailEvent, MerchantDetailState> {
  MerchantDetailBloc() : super(const MerchantDetailState()) {
    on<CloseMerchantDetail>(_onCloseMerchantDetail);
  }

  Future<void> _onCloseMerchantDetail(
    CloseMerchantDetail event,
    Emitter<MerchantDetailState> emit,
  ) async {
    ///TODO: Log any events?
    Get.back();
  }
}
