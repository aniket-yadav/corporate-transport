class VehicleModel {
  String? vehicleid;
  String? name;
  String? model;
  String? platno;
  String? color;
  String? type;
  String? capacity;
  String? driverid;
  String? longitude;
  String? latitude;

  VehicleModel({
    this.capacity,
    this.color,
    this.driverid,
    this.latitude,
    this.longitude,
    this.model,
    this.name,
    this.platno,
    this.type,
    this.vehicleid,
  });

  factory VehicleModel.fromJson(Map<String, dynamic>? json) {
    return VehicleModel(
      capacity: json?['capacity'],
      color: json?['color'],
      driverid: json?['driverid'],
      latitude: json?['latitude'],
      longitude: json?['longitude'],
      model: json?['model'],
      name: json?['name'],
      platno: json?['platno'],
      type: json?['type'],
      vehicleid: json?['vehicleid'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'capacity': capacity,
      'color': color,
      'driverid': driverid,
      'latitude': latitude,
      'longitude': longitude,
      'model': model,
      'name': name,
      'platno': platno,
      'type': type,
      'vehicleid': vehicleid,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
