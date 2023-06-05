class Area {
  int id;
  String areaName;

  Area.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        areaName = map['areaName'];

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['areaName'] = areaName;

    return map;
  }
}
