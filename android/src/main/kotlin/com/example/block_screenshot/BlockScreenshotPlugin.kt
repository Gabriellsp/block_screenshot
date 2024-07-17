package com.example.block_screenshot

import android.app.Activity
import android.view.WindowManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry

/** BlockScreenshotPlugin */
class BlockScreenshotPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private var activity: Activity? = null

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  @Suppress("unused")
  constructor()

  private constructor(activity: Activity?) {
    this.activity = activity
  }
  companion object {
    @JvmStatic
    @Deprecated("Use the new Flutter plugin APIs")
    fun registerWith(registrar: PluginRegistry.Registrar) {
      BlockScreenshotPlugin(registrar.activity()).registerWith(registrar.messenger())
    }
  }

  private fun registerWith(binaryMessenger: BinaryMessenger) {
     channel = MethodChannel(binaryMessenger, "com.mobile.block_screenshot")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    registerWith(flutterPluginBinding.binaryMessenger)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "disableScreenshot") {
      activity?.window?.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
      result.success(true)
    } else if (call.method == "enableScreenshot") {
      activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
      result.success(false)
    }else {
      result.notImplemented()
    }
  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(@NonNull activityPluginBinding: ActivityPluginBinding) {
    activity = activityPluginBinding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(@NonNull activityPluginBinding: ActivityPluginBinding) {
    onAttachedToActivity(activityPluginBinding)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
