import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:metal/metal.dart';

import 'post_ore.dart';

void main() {
  test('Can make get requests', () async {
    final postMetal = Metal.explore(
      url: 'https://jsonplaceholder.typicode.com/posts/1',
      miningMethod: MiningMethod.get,
      ironModel: PostOre(),
    );
    await postMetal.mine().then((value) {}).catchError((err) {
      err as MetalError;
      return;
    });
    expect(postMetal.iron?.body.isBlank, false);
  });

  test('Can make catch errors', () async {
    final postMetal = Metal.explore(
        url: 'https://jsonplaceholder.typicode.com/posts/1g',
        miningMethod: MiningMethod.get,
        ironModel: PostOre());
    await postMetal.mine().then((value) {}).catchError((err) {
      err as MetalError;
      return;
    });
    expect(postMetal.metalError.runtimeType, MetalError);
  });
}
