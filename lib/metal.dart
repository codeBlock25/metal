library metal;

import 'package:dio/dio.dart';
import 'package:flat/flat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

part 'src/enums.dart';
part 'src/error.dart';
part 'src/interface.dart';
part 'src/mine.dart';
part 'src/ore.dart';

/// [Metal] is a class to instantiate the a new [Mine]
/// call the [explore] method to start
abstract class Metal implements MetalInterface {
  /// This returns a [Mine] with the the [Ore] type
  /// The [explore] function creates
  ///
  static Mine<T, U> explore<T extends Ore, U extends Ore>({
    required MiningMethod miningMethod,
    required String url,
    required T ironModel,
    U? errorModel,
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
    int? ironPathDepth,
    String? errorPath,
    int? errorPathDepth,
  }) {
    assert(() {
      if (errorModel == null && U != DefaultErrorOre) {
        throw FlutterError(
            'If errorModel == null, Error Type [U] must be DefaultErrorOre');
      }
      return true;
    }());
    return Mine<T, U>(
      ironPath: ironPath,
      errorPath: errorPath,
      ironModel: ironModel,
      errorModel: errorModel ?? DefaultErrorOre() as U,
      ironPathDepth: ironPathDepth,
      errorPathDepth: errorPathDepth,
      miningMethod: miningMethod,
      uri: Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          queryParameters: queryParameters,
          extra: extra,
          headers: headers,
          responseType: responseType,
          contentType: contentType,
          validateStatus: validateStatus,
          receiveDataWhenStatusError: receiveDataWhenStatusError,
          followRedirects: followRedirects,
          maxRedirects: maxRedirects,
          requestEncoder: requestEncoder,
          responseDecoder: responseDecoder,
          listFormat: listFormat,
        ),
      ),
    );
  }
}
