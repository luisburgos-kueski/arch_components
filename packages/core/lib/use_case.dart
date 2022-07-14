abstract class IUseCase<Input, Output> {
  Future<Output> run(Input input);
}

abstract class IUseCaseNoInput<Output> {
  Future<Output> run();
}
