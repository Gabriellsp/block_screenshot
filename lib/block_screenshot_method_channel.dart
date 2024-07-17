import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'block_screenshot_platform_interface.dart';

class MethodChannelBlockScreenshot extends BlockScreenshotPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('com.mobile.block_screenshot');

  @override
  Future<bool?> disableScreenshot() async {
    final version = await methodChannel.invokeMethod<bool>('disableScreenshot');
    return version;
  }

  @override
  Future<bool?> enableScreenshot() async {
    final version = await methodChannel.invokeMethod<bool>('enableScreenshot');
    return version;
  }
}
