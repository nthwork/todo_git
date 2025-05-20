import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static final Dbhelper init = Dbhelper._init();
  static Database? _database;

  Dbhelper._init();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDb("todoDB");
    return _database!;
  }
  Future<Database> _initDb(String fileName) async{
    String path = join(await getDatabasesPath(),fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute("""
          CREATE TABLE IF NOT EXISTS "groups" (
            "id" INTEGER NOT NULL UNIQUE,
            "title" TEXT NOT NULL UNIQUE,
            "gColor" TEXT DEFAULT '#7C586B',
            PRIMARY KEY("id" AUTOINCREMENT)
          );

          CREATE TABLE IF NOT EXISTS "tasks" (
            "id" INTEGER NOT NULL UNIQUE ,
            "group_ID" INTEGER,
            "title" TEXT NOT NULL,
            "info" TEXT,
            "isDone" INTEGER NOT NULL DEFAULT 0,
            "doneAt" INTEGER,
            "enddateAt" INTEGER,
            "updateAt" INTEGER NOT NULL,
            PRIMARY KEY("id" AUTOINCREMENT),
            FOREIGN KEY ("group_ID") REFERENCES "groups"("id")
            ON UPDATE NO ACTION ON DELETE NO ACTION
          );



          CREATE TABLE IF NOT EXISTS "tags" (
            "id" INTEGER NOT NULL UNIQUE AUTOINCREMENT,
            "name" TEXT,
            "color" TEXT,
            PRIMARY KEY("id" AUTOINCREMENT)
          );

          CREATE TABLE IF NOT EXISTS "tasks_tags_foregin" (
            "task_id" INTEGER,
            "tag_id" INTEGER,
            PRIMARY KEY("task_id" , "tag_id"),
            FOREIGN KEY ("tag_id") REFERENCES "tags"("id")
            FOREIGN KEY ("task_id") REFERENCES "tasks"("id")
            ON UPDATE NO ACTION ON DELETE NO ACTION
          );
        """);
        await db.rawInsert('''
          INSERT INTO groups(title) VALUES("預設群組")
          ''');
      }
    );

  }

}