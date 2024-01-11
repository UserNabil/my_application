class DeviceConfiguration {
  String androidId;
  int apiLevel;
  double batteryLevel;
  String deviceId;
  String deviceName;
  int firstInstallTime;
  double fontScale;
  int freeDiskStorage;
  String hardware;
  String ipAddress;
  String macAddress;
  String manufacturer;
  String model;
  PowerState powerState;
  String readableVersion;
  String systemName;
  String systemVersion;
  int totalDiskCapacity;
  int totalMemory;
  String uniqueId;
  int usedMemory;
  String userAgent;
  String version;
  bool notch;
  bool emulator;
  bool tablet;

  DeviceConfiguration({
    required this.androidId,
    required this.apiLevel,
    required this.batteryLevel,
    required this.deviceId,
    required this.deviceName,
    required this.firstInstallTime,
    required this.fontScale,
    required this.freeDiskStorage,
    required this.hardware,
    required this.ipAddress,
    required this.macAddress,
    required this.manufacturer,
    required this.model,
    required this.powerState,
    required this.readableVersion,
    required this.systemName,
    required this.systemVersion,
    required this.totalDiskCapacity,
    required this.totalMemory,
    required this.uniqueId,
    required this.usedMemory,
    required this.userAgent,
    required this.version,
    required this.notch,
    required this.emulator,
    required this.tablet,
  });

  factory DeviceConfiguration.fromJson(Map<String, dynamic> json) {
    return DeviceConfiguration(
      androidId: json['androidId'] ?? '',
      apiLevel: json['apiLevel'] ?? 0,
      batteryLevel: json['batteryLevel'] ?? 0.0,
      deviceId: json['deviceId'] ?? '',
      deviceName: json['DeviceName'] ?? '',
      firstInstallTime: json['FirstInstallTime'] ?? 0,
      fontScale: json['FontScale'] ?? 0.0,
      freeDiskStorage: json['FreeDiskStorage'] ?? 0,
      hardware: json['Hardware'] ?? '',
      ipAddress: json['IpAddress'] ?? '',
      macAddress: json['MacAddress'] ?? '',
      manufacturer: json['Manufacturer'] ?? '',
      model: json['Model'] ?? '',
      powerState: PowerState.fromJson(json['PowerState'] ?? {}),
      readableVersion: json['ReadableVersion'] ?? '',
      systemName: json['SystemName'] ?? '',
      systemVersion: json['SystemVersion'] ?? '',
      totalDiskCapacity: json['TotalDiskCapacity'] ?? 0,
      totalMemory: json['TotalMemory'] ?? 0,
      uniqueId: json['UniqueId'] ?? '',
      usedMemory: json['UsedMemory'] ?? 0,
      userAgent: json['UserAgent'] ?? '',
      version: json['Version'] ?? '',
      notch: json['Notch'] ?? false,
      emulator: json['Emulator'] ?? false,
      tablet: json['Tablet'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'androidId': androidId,
      'apiLevel': apiLevel,
      'batteryLevel': batteryLevel,
      'deviceId': deviceId,
      'DeviceName': deviceName,
      'FirstInstallTime': firstInstallTime,
      'FontScale': fontScale,
      'FreeDiskStorage': freeDiskStorage,
      'Hardware': hardware,
      'IpAddress': ipAddress,
      'MacAddress': macAddress,
      'Manufacturer': manufacturer,
      'Model': model,
      'PowerState': powerState.toJson(),
      'ReadableVersion': readableVersion,
      'SystemName': systemName,
      'SystemVersion': systemVersion,
      'TotalDiskCapacity': totalDiskCapacity,
      'TotalMemory': totalMemory,
      'UniqueId': uniqueId,
      'UsedMemory': usedMemory,
      'UserAgent': userAgent,
      'Version': version,
      'Notch': notch,
      'Emulator': emulator,
      'Tablet': tablet,
    };
  }
}

class PowerState {
  bool lowPowerMode;
  double batteryLevel;
  String batteryState;

  PowerState({
    required this.lowPowerMode,
    required this.batteryLevel,
    required this.batteryState,
  });

  factory PowerState.fromJson(Map<String, dynamic> json) {
    return PowerState(
      lowPowerMode: json['lowPowerMode'] ?? false,
      batteryLevel: json['batteryLevel'] ?? 0.0,
      batteryState: json['batteryState'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lowPowerMode': lowPowerMode,
      'batteryLevel': batteryLevel,
      'batteryState': batteryState,
    };
  }
}
