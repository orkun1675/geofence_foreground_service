import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geofence_foreground_service/models/zone.dart';

import 'geofence_foreground_service_platform_interface.dart';

/// An implementation of [GeofenceForegroundServicePlatform] that uses method channels.
class MethodChannelGeofenceForegroundService extends GeofenceForegroundServicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('geofence_foreground_service');

  /// This method is used to start the geofencing foreground service
  @override
  Future<bool> startGeofencingService({
    required String notificationChannelId,
    required String contentTitle,
    required String contentText,
    int? serviceId,
  }) async {
    final bool? didStart = await methodChannel.invokeMethod<bool>(
      'startGeofencingService',
      {
        'channel_id': notificationChannelId,
        'content_title': contentTitle,
        'content_text': contentText,
        'service_id': serviceId,
      },
    );
    return didStart ?? false;
  }

  /// This method is used to stop the geofencing foreground service
  @override
  Future<bool> stopGeofencingService() async {
    final bool? didStop = await methodChannel.invokeMethod<bool>('stopGeofencingService');
    return didStop ?? false;
  }

  /// This method is used to check if the geofencing foreground service is running
  @override
  Future<bool> isForegroundServiceRunning() async {
    final bool? isServiceRunning = await methodChannel.invokeMethod<bool>('isForegroundServiceRunning');
    return isServiceRunning ?? false;
  }

  /// This method is used to add a geofence area
  @override
  Future<bool> addGeofence({
    required Zone zone,
  }) async {
    final bool? isGeofenceAdded = await methodChannel.invokeMethod<bool>(
      'addGeofence',
      zone.toJson(),
    );
    return isGeofenceAdded ?? false;
  }

  /// This method is used to remove a geofence area
  @override
  Future<bool> removeGeofence({
    required String zoneId,
  }) async {
    final bool? isGeofenceRemoved = await methodChannel.invokeMethod<bool>(
      'removeGeofence',
      {
        'zoneId': zoneId,
      },
    );
    return isGeofenceRemoved ?? false;
  }

  /// This method is used to remove all geofence areas
  @override
  Future<bool> removeAllGeoFences() async {
    final bool? areAllAreasRemoved = await methodChannel.invokeMethod<bool>('removeAllGeoFences');
    return areAllAreasRemoved ?? false;
  }
}
