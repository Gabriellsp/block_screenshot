import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'block_screenshot_method_channel.dart';

abstract class BlockScreenshotPlatform extends PlatformInterface {
  BlockScreenshotPlatform() : super(token: _token);

  static final Object _token = Object();

  static BlockScreenshotPlatform _instance = MethodChannelBlockScreenshot();

  static BlockScreenshotPlatform get instance => _instance;

  static set instance(BlockScreenshotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> disableScreenshot() {
    throw UnimplementedError('disableScreenshot() has not been implemented.');
  }

  Future<bool?> enableScreenshot() {
    throw UnimplementedError('enableScreenshot() has not been implemented.');
  }
}
