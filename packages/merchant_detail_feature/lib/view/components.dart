import 'package:flutter/material.dart';
import 'package:kevent_tracker/kevent_tracker.dart';

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