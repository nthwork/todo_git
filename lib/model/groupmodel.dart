
class Group{

  static const String tbName = "groups";

  final int? id ;
  final String name;
  final String gColor;
  
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // 僅在 id 不為 null 時包含
      'name': name,
      'gColor': gColor,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
  return {
    'name': name,
    'gColor': gColor,
  };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as int?,
      name: map['name'] as String,
      gColor: map['gColor'] as String,
    );
  }
  Group({
    this.id,
    required this.name, 
    this.gColor = "#7C586B"});
}