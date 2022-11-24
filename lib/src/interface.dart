part of metal;

abstract class MineInterface<T extends Ore, U extends Ore> {
  late ProductionProcess status;

  /// true when a request is on going
  bool mining = false;

  /// true when a request is on going, use [mining] instead
  bool loading = false;

  /// hold the error state of the called method
  MetalError<U>? metalError;

  /// hold the error state of the called method, use metalError instead
  dynamic? error;

  @protected
  late T _ironModel;
  @protected
  late U _errorModel;

  /// holds data gotten from a successful mine(http request) as the Provided Ore type
  T? iron;

  /// holds data gotten from a successful mine(http request) as the Provided Ore type, use iron instead
  T? classData;

  /// holds data gotten from a successful mine(http request) as plain generic type
  dynamic rawOre;

  /// holds data gotten from a successful mine(http request) as plain generic type, use rawOre instead
  dynamic data;

  @protected
  @factory

  /// called everytime mining status changes carrying the current [T] iron class i.e [iron] property
  onMine(void Function(T? iron) mineListener);

  @protected
  @factory

  /// called everytime an error occurs carrying [MetalError] as a param
  onError(void Function(MetalError? error) errorListener);

  @protected
  @factory

  /// called to reset the mining state and clear on going http request
  reset();

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
  String? ironPath;
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
  String? errorPath;
  int? errorPathDepth;

  @protected
  @factory
  Future<ProductionProcess> mine(
      Map<String, dynamic>? data, Map<String, dynamic>? query);
}

/// A Metal class interface
abstract class MetalInterface {
  /// Http method.
  String? method;

  /// Http request headers. The keys of initial headers will be converted to lowercase,
  /// for example 'Content-Type' will be converted to 'content-type'.
  ///
  /// The key of Header Map is case-insensitive, eg: content-type and Content-Type are
  /// regard as the same key.
  Map<String, dynamic>? headers;

  /// Timeout in milliseconds for sending data.
  /// [Dio] will throw the [DioError] with [DioErrorType.sendTimeout] type
  ///  when time out.
  int? sendTimeout;

  ///  Timeout in milliseconds for receiving data.
  ///
  ///  Note: [receiveTimeout]  represents a timeout during data transfer! That is to say the
  ///  client has connected to the server, and the server starts to send data to the client.
  ///
  /// [0] meanings no timeout limit.
  int? receiveTimeout;

  /// The request Content-Type. The default value is [ContentType.json].
  /// If you want to encode request body with 'application/x-www-form-urlencoded',
  /// you can set `ContentType.parse('application/x-www-form-urlencoded')`, and [Dio]
  /// will automatically encode the request body.
  String? contentType;

  /// [responseType] indicates the type of data that the server will respond with
  /// options which defined in [ResponseType] are `json`, `stream`, `plain`.
  ///
  /// The default value is `json`, dio will parse response string to json object automatically
  /// when the content-type of response is 'application/json'.
  ///
  /// If you want to receive response data with binary bytes, for example,
  /// downloading a image, use `stream`.
  ///
  /// If you want to receive the response data with String, use `plain`.
  ///
  /// If you want to receive the response data with original bytes,
  /// that's to say the type of [Response.data] will be List<int>, use `bytes`
  ResponseType? responseType;

  /// `validateStatus` defines whether the request is successful for a given
  /// HTTP response status code. If `validateStatus` returns `true` ,
  /// the request will be perceived as successful; otherwise, considered as failed.
  ValidateStatus? validateStatus;

  /// Whether receiving response data when http status code is not successful.
  /// The default value is true
  bool? receiveDataWhenStatusError;

  /// Custom field that you can retrieve it later in [Interceptor]、[Transformer] and the [Response] object.
  Map<String, dynamic>? extra;

  /// see [HttpClientRequest.followRedirects],
  /// The default value is true
  bool? followRedirects;

  /// Set this property to the maximum number of redirects to follow
  /// when [followRedirects] is `true`. If this number is exceeded
  /// an error event will be added with a [RedirectException].
  ///
  /// The default value is 5.
  int? maxRedirects;

  /// The default request encoder is utf8encoder, you can set custom
  /// encoder by this option.
  RequestEncoder? requestEncoder;

  /// The default response decoder is utf8decoder, you can set custom
  /// decoder by this option, it will be used in [Transformer].
  ResponseDecoder? responseDecoder;

  /// The [listFormat] indicates the format of collection data in request
  /// query parameters and `x-www-url-encoded` body data.
  /// Possible values defined in [ListFormat] are `csv`, `ssv`, `tsv`, `pipes`, `multi`, `multiCompatible`.
  /// The default value is `multi`.
  ListFormat? listFormat;

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
  String? ironPath;
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
  String? errorPath;
  int? errorPathDepth;

  @protected

  /// Returns a [Mine] instance carrying T = Return Ore and U the error Ore
  ///
  /// - LoginResponseOre is response returned from api call on a successful request
  /// - LoginErrorResponseOre is the response returned from a api call with a status code between [400 - 500].
  ///
  /// ### Example
  /// ```dart
  /// final authOre = Metal.explore<LoginResponseOre, LoginErrorResponseOre>(uri: "https:.../api/auth", mineMethod: MineMethod.POST);
  /// ```
  static Mine<T, U> explore<T extends Ore, U extends Ore>({
    required MiningMethod mineMethod,
    required String url,
    String? method,
    int? connectTimeout,
    int? receiveTimeout,
    int? sendTimeout,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
    ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
    String? ironPath,
    String? errorPath,
    int? ironPathDepth,
    int? errorPathDepth,
  }) {
    throw UnimplementedError('Method not implemented.');
  }
}
