# Addons

An "addon" is an external library we could use in different places of our architecture layers to get more out of our features. Shared libraries are addons by definition.

> 🚨 Some addons are currently living inside our main app repo as internal packages.
> We plan to move these packages to it's own external repo. 

Current available addons:
- [kevent_tracker](https://github.com/kueski-dev/kevent_tracker)
- [kapp_behavior](../packages/kapp_behavior/README.md)
- [kdevice_info_collector](https://github.com/kueski-dev/kdevice_info_collector)

Notes:
- You could decide to use none, one or more addons into your project.

## Addons Overview

Here is a brief description on what you can get out of the current available addons. 

### KEventTracker a.k.a LogBehavior

[More on KEventTracker](https://github.com/kueski-dev/kevent_tracker)

With this library you could track 3 main event sources:
- **Lifecycle**: App lifecycle events (started, resumed, paused, etc).
- **Navigation**: Routes push/pop events (pushed, popped).
- **Ui**: User interactions (clicked, swiped, scrolled, toggled, etc).


### KAppBehavior

[More on KAppBehavior](../packages/kapp_behavior/README.md)

With this library you could track 4 main event sources:
- **Navigation**: Screen/Pages presented to the user (opened, closed).
- **Ui**: User interactions over domain named components (merchant_item_clicked, user_profile_icon_clicked)
- **Business Logic Requests**: Requests to business logic components to run any logic related. These are similar to the Command pattern.
  - Note: `bloc` events are a similar concept to these events.
- **Business Logic Results**: Results from running business logic. Using UseCases is suggested (on_login_success, on_login_failed)


