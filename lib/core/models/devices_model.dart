class AllDevicesModel {
  String image;
  String title;
  bool isOpened;
  String id;

  AllDevicesModel(
      {required this.id,
      required this.image,
      required this.title,
      required this.isOpened});

  factory AllDevicesModel.fromMap(Map<dynamic, dynamic> map) {
    return AllDevicesModel(
      id: map['id'],
      image: map['imageDevice'],
      title: map['nameDevice'],
      isOpened: map['isOpened'],
    );
  }
}
