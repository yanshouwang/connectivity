import 'jni.dart' as jni;

abstract interface class FileDescriptor {}

final class FileDescriptorImpl implements FileDescriptor {
  final jni.FileDescriptor api;

  FileDescriptorImpl.jni(this.api);
}

extension FileDescriptorX on FileDescriptor {
  jni.FileDescriptor get api {
    final impl = this;
    if (impl is! FileDescriptorImpl) throw TypeError();
    return impl.api;
  }
}
