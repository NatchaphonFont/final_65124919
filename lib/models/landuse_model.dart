class LandUse {
  final int landUseID;
  final int plantID;
  final int componentID;
  final int landUseTypeID;
  final String landUseDescription;

  LandUse({
    required this.landUseID,
    required this.plantID,
    required this.componentID,
    required this.landUseTypeID,
    required this.landUseDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'landUseID': landUseID,
      'plantID': plantID,
      'componentID': componentID,
      'landUseTypeID': landUseTypeID,
      'landUseDescription': landUseDescription,
    };
  }

  factory LandUse.fromMap(Map<String, dynamic> map) {
    return LandUse(
      landUseID: map['landUseID'],
      plantID: map['plantID'],
      componentID: map['componentID'],
      landUseTypeID: map['landUseTypeID'],
      landUseDescription: map['landUseDescription'],
    );
  }
}
