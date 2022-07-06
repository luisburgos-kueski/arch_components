# Addons

Let's define an "addon" as an external library we could use in different places of our
architecture layers to get more out of our features. Shared libraries are addons by definition.

> 🚨 Some addons are currently living inside our main app repo as internal packages.
> We plan to move these packages to it's own external repo. 

Current available addons:
- `kevent_tracker`
- `kapp_behavior`
- `kdevice_info_collector`


Arch Components -> Addons

- LogBehavior
  - Sources:
    - Presentation Logic: Pure Widgets
    - Lifecycle    
    - Navigation: Routes
- AppBehavior
  - Sources:
     - Widgets + Domain Context (TODO missing docs)
     - Business Logic Requests (BlocEvents, Commands) from StateHolders
     - Business Logic Results from UseCases (OnLoginSuccess, OnLoginFailed)
     - Navigation: Screen/Pages from...

# KEventTracker a.k.a LogBehavior


# KAppBehavior


# KDeviceInfoCollector
