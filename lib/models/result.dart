sealed class Result<T> {
  const Result();

  const factory Result.initial() = Initial;
  const factory Result.loading() = Loading;
  const factory Result.empty() = Empty;
  const factory Result.success(T value) = Success;
  const factory Result.failed(String message) = Failed;

  bool get isInitial => this is Initial<T>;
  bool get isLoading => this is Loading<T>;
  bool get isEmpty => this is Empty<T>;
  bool get isSuccess => this is Success<T>;
  bool get isFailed => this is Failed<T>;

  T? get resultValue => isSuccess ? (this as Success<T>).value : null;
  String? get errorMessage => isFailed ? (this as Failed<T>).message : null;
}

class Initial<T> extends Result<T> {
  const Initial();
}

class Loading<T> extends Result<T> {
  const Loading();
}

class Empty<T> extends Result<T> {
  const Empty();
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Failed<T> extends Result<T> {
  final String message;

  const Failed(this.message);
}