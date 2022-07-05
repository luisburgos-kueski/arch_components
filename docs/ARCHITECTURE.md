# Architecture Components

## Overview

Three-tier layered architecture:
- Presentation
    - ViewTemplate
    - StateHolders
- Domain
    - UseCases
- Data
    - Repositories
    
## Presentation Layer

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
