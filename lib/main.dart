import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

void main() {
  FFIBridge.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text('capitalize flutter= ',
              style: TextStyle(fontSize: 40)),
          Text('1+2=${FFIBridge.add(1, 2)}', style: TextStyle(fontSize: 40)),
          const Text(
            'You have pushed the button this many times:',
          )
        ],
      ),
    );
  }
}
class FFIBridge {
  static bool initialize() {
    nativeApiLib =(DynamicLibrary.open('libapi.so')); // android and linux
    final _add = nativeApiLib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>('add');
    add = _add.asFunction<int Function(int, int)>();
    //final _cap = nativeApiLib.lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>('capitalize');
   // _capitalize = _cap.asFunction<Pointer<Utf8> Function(Pointer<Utf8>)>();
    return true;
  }
  static late DynamicLibrary nativeApiLib;
  static late Function add;
  static late Function _capitalize;
  // static String capitalize(String str) {
  //   final _str = str.toNativeUtf8();
  //   Pointer<Utf8> res = _capitalize(_str);
  //   calloc.free(_str);
  //   return res.toDartString();
  // }
}