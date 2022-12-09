part of metal;

/// type model for passed [Ore]
typedef OreType<T extends Ore> = T Function();

/// type model for passed [Ore] as error
typedef ErrorOreType<U extends Ore> = U Function();

/// class contain handy method to make http calls and properties to monitor them
class Mine<T extends Ore, U extends Ore> implements MineInterface<T, U> {
  Mine({
    required T ironModel,
    required U errorModel,
    required Dio uri,
    required MiningMethod miningMethod,
    String? ironPath,
    String? errorPath,
    int? ironPathDepth,
    int? errorPathDepth,
  }) {
    _ironModel = ironModel;
    _errorModel = errorModel;
    _uri = uri;
    classData = null;
    data = null;
    metalError = null;
    error = null;
    loading = false;
    mining = false;
    rawOre = null;
    _status = ProductionProcess.stale.obs;
    _miningMethod = miningMethod;
    _status.listen((p0) {
      change(() {});
      if (error == null) {
        onMine((iron) {});
      } else {
        onError((error) {});
      }
    });
  }

  @override
  late T _ironModel;
  @override
  late U _errorModel;

  late Dio _uri;

  late MiningMethod _miningMethod;

  late Rx<ProductionProcess> _status;

  @override
  ProductionProcess get status => _status.value;

  @override

  /// true when a request is on going
  bool mining = false;

  /// This is a [String] that points to the path the required [Ore] or data is located.
  ///
  /// @example
  /// ```json
  /// {
  ///   "account": {
  ///     "user": {
  ///       ...
  ///     }
  ///   }
  /// }
  /// ```
  /// user is the [Ore] or data in this example
  /// ```dart
  /// String? ironPath = "account.user";
  /// ```
  ///
  @override
  String? ironPath;

  @override
  int? ironPathDepth;

  /// This is a [String] that points to the path the error message is within the http response
  ///
  /// @example
  /// ```json
  /// {
  ///   "error": {
  ///     "message": "..."
  ///   }
  /// }
  /// ```
  /// user is the [Ore] or data in this example
  /// ```dart
  /// String? errorPath = "error.message";
  /// ```
  ///
  @override
  String? errorPath;
  @override
  int? errorPathDepth;

  @override

  /// true when a request is on going, use [mining] instead
  bool loading = false;

  @override

  /// hold the error state of the called method
  MetalError<U>? metalError;

  @override

  /// hold the error state of the called method, use metalError instead
  dynamic error;

  @override

  /// holds data gotten from a successful mine(http request) as the Provided Ore type
  T? iron;

  @override

  /// holds data gotten from a successful mine(http request) as the Provided Ore type, use iron instead
  T? classData;

  @override

  /// holds data gotten from a successful mine(http request) as plain generic type
  dynamic rawOre;

  @override

  /// holds data gotten from a successful mine(http request) as plain generic type, use rawOre instead
  dynamic data;

  @override

  /// call [mine] to start any http request
  ///
  /// This function takes in an optional [data] and [query] for every request.
  Future<ProductionProcess> mine(
      {Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String? miningPath = ''}) async {
    reset();
    loading = true;
    mining = true;
    final Response<dynamic> value;
    try {
      _status.value = ProductionProcess.mining;
      switch (_miningMethod) {
        case MiningMethod.get:
          value = await _uri.get(
            '/${miningPath ?? ''}',
            queryParameters: query,
          );
          break;
        case MiningMethod.post:
          value = await _uri.post(
            '/${miningPath ?? ''}',
            data: data,
            queryParameters: query,
          );
          break;
        case MiningMethod.delete:
          value = await _uri.delete(
            '/${miningPath ?? ''}',
            data: data,
            queryParameters: query,
          );
          break;
        case MiningMethod.patch:
          value = await _uri.patch(
            '/${miningPath ?? ''}',
            data: data,
            queryParameters: query,
          );
          break;
        case MiningMethod.put:
          value = await _uri.put(
            '/${miningPath ?? ''}',
            data: data,
            queryParameters: query,
          );
          break;
        default:
          value = await _uri.get(
            '/${miningPath ?? ''}',
            queryParameters: query,
          );
          break;
      }
      loading = false;
      mining = false;
      if (ironPath != null || (ironPath?.isNotEmpty ?? false)) {
        final dataFromPath = flatten(value.data ?? <String, dynamic>{},
            maxDepth: ironPathDepth ?? 0, safe: true);
        iron = _ironModel.cast(dataFromPath[ironPath]);
        classData = iron;
      } else {
        iron = _ironModel.cast(value.data);
        classData = iron;
      }
      data = value.data;
      rawOre = data;
      _status.value = ProductionProcess.mined;
      return ProductionProcess.mined;
    } on DioError catch (error) {
      reset();
      _status.value = ProductionProcess.error;
      try {
        final dataError = errorPath == null
            ? error.response?.data ?? <String, dynamic>{}
            : flatten(error.response?.data ?? <String, dynamic>{},
                maxDepth: errorPathDepth ?? 0, safe: true);
        metalError = MetalError<U>(
          message: error.message,
          rawError: error,
          error: _errorModel
              .cast(errorPath == null ? dataError : dataError[errorPath ?? '']),
          statusCode: error.response?.statusCode ?? 500,
        );
      } catch (e) {
        metalError = MetalError<U>(
          message: error.message,
          rawError: error,
          error: null,
          statusCode: error.response?.statusCode ?? 500,
        );
      }
      throw MetalError<U>(
        message: error.message,
        rawError: error,
        error: null,
        statusCode: error.response?.statusCode ?? 500,
      );
    } catch (error) {
      _status.value = ProductionProcess.error;
      metalError = MetalError<U>(
        message: error.toString(),
        rawError: error,
        statusCode: 500,
      );
      throw MetalError<U>(
        message: error.toString(),
        rawError: error,
        statusCode: 500,
      );
    }
  }

  @override

  /// called everytime an error occurs carrying [MetalError] as a param
  void onError(void Function(MetalError? error)? listener) {
    listener?.call(metalError);
  }

  @override

  /// called everytime mining status changes carrying the current [T] iron class i.e [iron] property
  void onMine(void Function(T? iron)? listener) {
    listener?.call(iron);
  }

  change(void Function()? listener) {
    listener?.call();
  }

  @override

  /// called to reset the mining state and clear on going http request
  void reset() {
    classData = null;
    data = null;
    metalError = null;
    error = null;
    loading = false;
    mining = false;
    rawOre = null;
    _status.value = ProductionProcess.stale;
    status = ProductionProcess.stale;
  }

  @override
  set status(ProductionProcess stat) {
    _status.value = stat;
  }
}
