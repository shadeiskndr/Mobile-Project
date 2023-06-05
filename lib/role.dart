class Role {
  int id;
  String roleName;

  Role.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        roleName = map['roleName'];

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['roleName'] = roleName;

    return map;
  }
}
