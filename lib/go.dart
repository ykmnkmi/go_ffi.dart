import 'dart:ffi';

typedef InitializeNative = Void Function(Pointer<Void>);

typedef Initialize = void Function(Pointer<Void>);

typedef StartWorkNative = Void Function(Int64 port);

typedef StartWork = void Function(int port);

class GoDart {
  factory GoDart.open(String path) {
    var library = DynamicLibrary.open(path);
    library.initializeBinding(NativeApi.initializeApiDLData);
    return GoDart(startWorkBinding: library.startWorkBinding);
  }

  GoDart({required StartWork startWorkBinding})
      : _startWorkBinding = startWorkBinding;

  final StartWork _startWorkBinding;

  void startWork(int nativePort) {
    _startWorkBinding(nativePort);
  }
}

extension on DynamicLibrary {
  Initialize get initializeBinding {
    return lookupFunction<InitializeNative, Initialize>('Initialize');
  }

  StartWork get startWorkBinding {
    return lookupFunction<StartWorkNative, StartWork>('StartWork');
  }
}
