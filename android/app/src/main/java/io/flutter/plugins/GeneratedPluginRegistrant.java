package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import infozenplus.com.flutter_open_whatsapp.FlutterOpenWhatsappPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterOpenWhatsappPlugin.registerWith(registry.registrarFor("infozenplus.com.flutter_open_whatsapp.FlutterOpenWhatsappPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
