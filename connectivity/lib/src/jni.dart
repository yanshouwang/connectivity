import 'dart:typed_data';

import 'package:jni/jni.dart';

import 'jni/android/content/_package.dart';
import 'jni/android/os/_package.dart';
import 'jni/androidx/core/content/_package.dart';
import 'jni/java/util/concurrent/_package.dart';

export 'package:jni/jni.dart';

export 'jni/android/app/_package.dart';
export 'jni/android/content/_package.dart';
export 'jni/android/net/_package.dart';
export 'jni/android/net/wifi/_package.dart';
export 'jni/android/net/wifi/aware/_package.dart';
export 'jni/android/os/_package.dart';
export 'jni/androidx/core/content/_package.dart';
export 'jni/java/io/_package.dart';
export 'jni/java/net/_package.dart';
export 'jni/java/util/_package.dart';
export 'jni/java/util/concurrent/_package.dart';
export 'jni/javax/net/_package.dart';
export 'jni/dev/zeekr/connectivity/_package.dart';

Context get context => Jni.androidApplicationContext.as(Context.type);

extension ContextX on Context {
  Executor get mainExecutor => ContextCompat.getMainExecutor(this);
  Handler get mainHandler => getMainHandler();
  Looper get mainLooper => getMainLooper()!;

  Handler getMainHandler() => Handler.new$2(mainLooper);
}

extension Connectivity$StringX on String {
  JString get api => toJString();
}

extension JStringX on JString {
  String get impl => toDartString();
}

extension Connectivity$intX on int {
  JInteger get api => toJInteger();
}

extension JIntegerX on JInteger {
  int get impl => intValue();
}

extension Connectivity$Uint8ListX on Uint8List {
  JByteArray get api => toJByteBuffer().array;
}

extension JByteArrayX on JByteArray {
  Uint8List get impl => JByteBuffer.wrap(this).asUint8List();
}
