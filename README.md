# Architecture Components Test

Flutter project to test arch components ideas

## Project Structure

Features:
- `home` displays a list of merchants, allows load/clear the list and navigate to a merchant detail.
- `merchant_detail` displays single merchant detailed information.
- `splash` something to display on the first launch.

Internal Packages:
- `core` centralizes shared components across modules, like api clients or storage cache.
- `kapp_data_sources` exposes `DataSources` data access layer.
- `merchants_data` exposes `Merchant` data access layer.
- `kapp_behavior` placeholder implementation faking app behavior.

External Packages:
- `kevent_tracker` to track UI events, Navigation events and Lifecycle events.

## Next Updates

- Make Home module load noy only merchants data but capabilities data (products, services) and
to be aware of authentication by including a "fake credit capacity feature widget".
- Add a second example without any addons on the code, just plain arch components.
