# Architecture Components

The following architecture components were built based on a three-tier layered architecture:

- The **Presentation Layer** displays application data on the screen to our users.
- The **Domain Layer** contains the all the business logic our the application.
- The **Data Layer** exposes application data.

## Principles

- These UI-based classes should only contain logic that handles UI and operating system interactions. 
  - By keeping these classes as lean as possible, you can avoid many problems related to the component lifecycle, and improve the testability of these classes.
- You should drive your UI from data models, preferably persistent models.
- If you base your app architecture on data model classes, you make your app more testable and robust.

## Overview

TODO: Add diagram
    
## Presentation Layer

Rules of Thumb:

- `Page` is defined as the association of a `Screen` to a `Route`.
- `Route` is the full path of the `Page`
- `Screen` is the collection of `View` components. Simple screens could contain only one view.
  - Note: For now, a `Screen` is the same as a `View`, but also a point of feature toggles injection to vary the UI.
- `View` is the glue for a `ViewTiemplate` with its `State Holder`.
  - The `View` is responsible to read attributes from the `StateHolder` to make the to `ViewTemplate` look smart.
  - The `View` requests business logic execution to its `StateHolder`.  
- `ViewTemplate` defines the `Screen` skeleton, it's a dump component exposing callbacks and customization attributes.  
- `StateHolder` 
  - A `StateHolder` is a state projection component which listens to Data Access Streams. 
  - A `StateHolder` could filter or transform the data in terms of `ViewData` information.
  - A `StateHolder` runs `UseCases` and updates local state if needed.  
- `ViewData` is the most atomic Data scope for a view. In other words, partial views of a `Data Model`


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

### State Holders

> State should be a projection of the data from a single source of truth.
> The Data Access Layer MUST be the source of truth.

## Domain Layer

### UseCases

> All UseCases MUST output Business Logic Events.

Blueprint:
```dart
abstract class IUseCase {

}
```

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

## Data Layer

- TODO: Add docs for Repositories adding a Stream
- TODO: Add docs for having different data providers, local, in-memory, remote, etc.
- TODO: Document ideas on how to have queues, schedulers and batched requests (Data sources example)


# Questions

- How can we take advantage of the state management libraries to have modular widgets that only listens to individual properties inside the state instead of the whole state?
- Should we enforce `ViewDataModels` asap?
-

# Brainstorming

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


  
----

**Notes:**
- BlocEvents are not necessary Ui Events.
- BlocEvents are more likely to be Commands?
- If we do not adopt UseCases broadly? Should we trigger events from Bloc for now.
- What happens with MerchantItemPressed where should live in?
- How we could add a route contract?
- Dialogs and SnackBars are not included on v1
