import 'package:flutter/material.dart';
import 'dart:async';

import 'package:block_screenshot/block_screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _blockScreenshotPlugin = BlockScreenshot();
  bool screenshotIsEnabled = false;
  @override
  void initState() {
    super.initState();
    disableScreenshot();
  }

  Future<void> disableScreenshot() async {
    await _blockScreenshotPlugin.disableScreenshot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (screenshotIsEnabled) {
              await _blockScreenshotPlugin.disableScreenshot();
            } else {
              await _blockScreenshotPlugin.enableScreenshot();
            }
            setState(() {
              screenshotIsEnabled = !screenshotIsEnabled;
            });
          },
          child: const Icon(Icons.screenshot),
        ),
        body: Center(
          child: Text(
              'Screenshot está ${screenshotIsEnabled ? "habilitado" : "desabilitado"}\n'),
        ),
      ),
    );
  }
}
