import '../db/db.dart';
import '../service/taskService.dart';
import '../service/tagServive.dart';
import '../model/taskmodel.dart';
import '../model/task_tag_map.dart';
import '../model/tagmodel.dart';

class Task_tagService{

    Future<bool> insertTaskTag(Task task,Tag tag)async{
        final db = await Dbhelper.init.database;
        try{
            var result = await db.insert(
                TaskTagMap.tbName,
                TaskTagMap(
                    task_id: task.id!, 
                    tag_id: tag.id!).toMap()
            );
            print("insertTaskTag result: $result");
            return true;
        }catch(e){
            print("$e");
            return false;
        }
    }

    Future<bool> deleteTaskTag(TaskTagMap values)async{
        try{
            final db = await Dbhelper.init.database;
            var result = await db.delete(
                TaskTagMap.tbName,
                where: "task_id = ? AND tag_id = ?",
                whereArgs: [values.task_id ,values.tag_id]
            );
            print("deleteTaskTag result: $result");
            return true;
        }catch(e){
            print("$e");
            return false;
        }
    }

    Future<List<Tag>> queryTagByTaskTagMap(Task values) async{
        final db = await Dbhelper.init.database;
        try{
            //從task中找到對應的ID 再從ID找到對應TAG
            var tagIdList = await db.query(
                TaskTagMap.tbName,
                where: "task_id = ?",
                whereArgs: [values.id!]
            );
            print("queryTagId result:$tagIdList");
            final tagIds = tagIdList.map((e) => e['tag_id'] as int).toList();
            // 若沒有標籤就提早返回
            if (tagIds.isEmpty) return [];

            final taglist =await db.query(
                        Tag.tbName,
                        where: "id IN (${List.filled(tagIds.length, "?").join(",")})",
                        whereArgs: tagIds
                    );
            print("queryTagName result:$taglist");
            return taglist.map((e) => Tag.fromMap(e)).toList();
        }catch(e){
            print("$e");
            return [];
        }
    }
}