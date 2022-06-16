import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

//TODO: Divide into classes, files and components
class MerchantDetailPage extends StatelessWidget {
  static String routeName = '/home/:id';

  const MerchantDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: Inject from above
    final merchantName = Get.parameters['id'] as String;

    return Scaffold(
      body: SafeArea(
        child: NavigationNotifier(
          key: const Key('merchant_detail_screen'),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(merchantName),
                BackToHomeTextButton(
                  onBackClicked: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackToHomeTextButton extends StatelessWidget {
  const BackToHomeTextButton({
    Key? key,
    this.onBackClicked,
  }) : super(key: key);

  final Function()? onBackClicked;

  @override
  Widget build(BuildContext context) {
    return UiEventNotifier(
      key: const Key('back_to_home_text_button'),
      builder: (widgetId, publisher) => TextButton(
        onPressed: () {
          publisher.publishUiEvent(
            OnClicked(widgetId: widgetId),
          );
          if (onBackClicked != null) onBackClicked!();
        },
        child: const Text('Back to home'),
      ),
    );
  }
}
