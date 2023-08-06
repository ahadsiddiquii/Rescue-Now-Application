class Job {
  Job({
    required this.id,
    required this.driverId,
    required this.onPickupLocation,
    required this.onTripToDropoff,
    required this.onDropoffLocation,
    required this.isDelivered,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'],
        driverId: json['driverId'],
        onPickupLocation: json['onPickupLocation'],
        onTripToDropoff: json['onTripToDropoff'],
        onDropoffLocation: json['onDropoffLocation'],
        isDelivered: json['isDelivered'],
      );
  String id;
  String driverId;
  bool onPickupLocation;
  bool onTripToDropoff;
  bool onDropoffLocation;
  bool isDelivered;

  Map<String, dynamic> toJson() => {
        'id': id,
        'driverId': driverId,
        'onPickupLocation': onPickupLocation,
        'onTripToDropoff': onTripToDropoff,
        'onDropoffLocation': onDropoffLocation,
        'isDelivered': isDelivered,
      };
}
