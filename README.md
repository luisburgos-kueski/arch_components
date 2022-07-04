# Architecture Components Test

Flutter project to test arch components ideas

## Project Structure

Features:
- `home` displays a list of merchants, allows load/clear the list and navigate to a merchant detail.
- `merchant_detail` displays single merchant detailed information.
- `splash` something to display on the first launch.

Internal Packages:
- `core` centralizes shared components across modules, like api clients or storage cache.
- `datasources_data` exposes `DataSources` data access layer.
- `merchants_data` exposes `Merchant` data access layer.
- `kapp_behavior` placeholder implementation faking app behavior.

External Packages:
- `kevent_tracker` to track UI events, Navigation events and Lifecycle events.

# Components

## Presentation Layer 

### ViewTemplate

### State Holders

> State should be a projection of the data from a single source of truth. 
> The Data Access Layer MUST be the source of truth.

## Domain Layer

## Data Layer

# Further Work

## Blueprints for...

### ViewTemplates

Blueprint:
```dart
abstract class IViewTemplate {
  
}
```

Initial Version:
```dart
class ViewTemplateA1 implements IViewTemplate {
  
}
```

New Version:
```dart
class ViewTemplateA2 implements IViewTemplate {
  
}
```

### UseCases

> All UseCases MUST output Business Logic Events.

Blueprint:
```dart
abstract class IUseCase {
  
}
```

# Questions

- How can we take advantage of the state management libraries to have modular widgets that only listens to individual properties inside the state instead of the whole state?
- Should we enforce `ViewDataModels` asap?
- 

Initial Version:
```dart
class UseCaseA1 implements IUseCase {
  
}
```

New Version:
```dart
class UseCaseA2 implements IUseCase {
  
}
```

## Brainstorming

- UiEvent -> View -> BlocEvent (UiEvent)
- BlocEvent -> Bloc + UseCase -> BLEvent

-------

- UiEvent -> View -> Cubit
- Cubit + UseCase -> BLEvent

- UiEvent -> View -> GetController
- GetController + UseCase -> BLEvent

-------

- User -> View -> UiEvent
- UiEvent -> GetController -> Command
- Command -> CommandHandler (UseCase) -> BLEvent

- User -> View -> UiEvent
- UiEvent -> Cubit + UseCase -> BLEvent

-------

- LogBehavior?
  - Sources:
    - Presentation Logic
    - Navigation: Routes 
- AppBehavior?
  - Sources:
    - Business Logic
    - Navigation: Screen/Pages
  
----

**Notes:**
- BlocEvents are not necessary Ui Events.
- BlocEvents are more likely to be Commands?
