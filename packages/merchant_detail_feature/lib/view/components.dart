import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';
import 'package:kueski_consumer_uitools/kueski_consumer_uitools.dart';

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
      builder: (widgetId, publisher) => KueskiPrimaryButton(
        onTap: () {
          publisher.publishUiEvent(
            OnClicked(
              widgetId: widgetId,
              data: {
                'buttonClassName': 'KueskiPrimaryButton',
              },
            ),
          );
          if (onBackClicked != null) onBackClicked!();
        },
        child: const Text('Back to home'),
      ),
    );
  }
}
