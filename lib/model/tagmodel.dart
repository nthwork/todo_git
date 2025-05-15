class Tag{

  static const tbName = "tags"; 

  final int? id ;
  final String name;
  final String? color;

  Tag({this.id,required this.name,this.color});
  
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // 僅在 id 不為 null 時包含
      'name': name,
      'color': color ?? "#000000"
    };
  }

  Map<String, dynamic> toMapForUpdate() {
  return {
    'name': name,
    'color': color ?? "#000000"
  };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as int?,
      name: map['name'] as String,
      color: map["color"] as String
    );
  }
  
}