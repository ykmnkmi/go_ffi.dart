import 'dart:ffi';
import 'dart:isolate';

import 'package:go_dart_ffi/go.dart';

void onMessage(Object? data) {
  print('Received: $data from Go');
}

Future<void> main() async {
  var goDart = GoDart.open('./shared/godart.so');

  var receivePort = ReceivePort();
  receivePort.listen(onMessage);

  var nativePort = receivePort.sendPort.nativePort;
  goDart.startWork(nativePort);

  while (true) {
    await Future<void>.delayed(const Duration(seconds: 2));
    print('Dart: 2 seconds passed');
  }
}
