part of metal;

/// Error type when using metal.
///
/// This covers all error types including native dart error
class MetalError<T extends Ore> extends Error {
  /// hold error message from either api or code
  late String message;

  T? error;

  /// hold error from dio
  Object? rawError;

  /// api call status code
  int? statusCode;

  MetalError({
    required this.message,
    this.rawError,
    this.statusCode,
    this.error,
  });
}

class DefaultErrorOre extends Ore {
  dynamic error;

  DefaultErrorOre({this.error});

  DefaultErrorOre.fromJson(dynamic data) {
    error = data;
  }

  @override
  DefaultErrorOre parse(data) => DefaultErrorOre.fromJson(data);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = error! is Map ? {"error": error} : error;
    return map;
  }
}
