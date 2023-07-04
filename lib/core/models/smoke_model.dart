class IsSomkeModel {
  bool isSmoke;
  var bedroomTemp;
  var livingRoomTemp;
  IsSomkeModel({
    required this.isSmoke,
    required this.bedroomTemp,
    required this.livingRoomTemp,
  });

  factory IsSomkeModel.fromMap(Map<dynamic, dynamic> map) {
    return IsSomkeModel(
      isSmoke: map['isSmoke'],
      bedroomTemp: map['bedroomTemp'],
      livingRoomTemp: map['livingRoomTemp'],
    );
  }
}
