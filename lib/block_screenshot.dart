import 'block_screenshot_platform_interface.dart';

class BlockScreenshot {
  Future<bool?> disableScreenshot() {
    return BlockScreenshotPlatform.instance.disableScreenshot();
  }

  Future<bool?> enableScreenshot() {
    return BlockScreenshotPlatform.instance.enableScreenshot();
  }
}
