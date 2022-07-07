# Architecture Components Test

Flutter project to test arch components ideas

## Project Structure

Features:
- `home` displays a list of merchants, allows load/clear the list and navigate to a merchant detail.
- `merchant_detail` displays single merchant detailed information.
- `splash` something to display on the first launch. (**IMPORTANT**: To be removed when Web is supported).

Internal Packages:
- `core` centralizes shared components across modules, like api clients or storage cache.
- `merchants_data` exposes `Merchant` data access layer.
- `kapp_behavior` placeholder implementation faking app behavior.
- `kapp_data_sources` exposes `DataSources` data access layer.

External Packages:
- `kevent_tracker` to track UI events, Navigation events and Lifecycle events.

## Next Updates

- Add `feature toggles` reading and propagation through the views (Remove core static file).
- Make Home module load noy only merchants data but capabilities data (products, services) and
to be aware of authentication by including a "fake credit capacity feature widget".
- Add a second example without any addons on the code, just plain arch components.
- Add SDUi library integration. [Must read docs here](https://kueski.atlassian.net/wiki/spaces/DOC/pages/2505670661/WIP+Putting+the+SDUI+mindset+into+practice+with+MiCuenta+feature)
