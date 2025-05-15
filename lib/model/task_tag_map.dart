class TaskTagMap{

  static const tbName = "task_tag_map";

  final int task_id;
  final int tag_id;

  TaskTagMap({required this.task_id, required this.tag_id});

  Map<String, int> toMap() {
    return {
      'task_id' : task_id,
      'tag_id' : tag_id
    };
  }
  factory TaskTagMap.fromMap(Map<String, dynamic> map) {
    return TaskTagMap(
        task_id: map['task_id'] as int,
        tag_id: map['tag_id'] as int,
    );
  }

}