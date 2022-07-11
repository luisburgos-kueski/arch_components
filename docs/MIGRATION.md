# Migration Notes

These Architecture Components are just a new iteration of our current architecture. Remember our goal is to solidify our rules of communication in between architecture layers.

Here you will find general notes on adopting the guidelines established by this repo.

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
  

**Notes:**
- BlocEvents are not necessary Ui Events.
- BlocEvents are more likely to be Commands?
- If we do not adopt UseCases broadly? Should we trigger events from Bloc for now.
- What happens with MerchantItemPressed where should live in?
- How we could add a route contract?
- Dialogs and SnackBars are not included on v1