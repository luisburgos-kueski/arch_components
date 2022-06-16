import 'package:arch_components/home/page.dart';
import 'package:arch_components/merchant_detail/page.dart';
import 'package:get/get.dart';

final List<GetPage> pages = [
  GetPage(
    name: HomePage.routeName,
    page: () => const HomePage(),
  ),
  GetPage(
    name: MerchantDetailPage.routeName,
    page: () => const MerchantDetailPage(),
  ),
];
