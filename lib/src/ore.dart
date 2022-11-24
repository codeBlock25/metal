part of metal;

abstract class Ore {
  /// Returns a map from [Ore] class
  @protected
  Map<dynamic, dynamic> toJson();

  @protected
  Ore parse(dynamic data);
}

extension OreExtension<T extends Ore> on T {
  /// Convert map [data] to structure [Ore] Instance.
  /// calls the [parse] method to the [Ore] class
  T cast(dynamic data) {
    return parse(data) as T;
  }
}
