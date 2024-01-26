class Address {
  final String id;
  final String longitude;
  final String latitude;
  final String address;
  final String createdAt;
  final String updatedAt;

  Address({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
      address: json['address'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
