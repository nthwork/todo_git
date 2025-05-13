import 'package:flutter/material.dart';


enum routeName{
  Home,
  Clander,
  TaskList,
  Group,
  }
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
      routes:{
        routeName.Home.name: (context) => HomePage(),
        routeName.Clander.name: (context) => ClanderPage(),
        routeName.TaskList.name: (context) => TaskListPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool _isButtonListopen = false;
  void openEndDrawer() {
    print("正在打開 endDrawer");
    _globalKey.currentState!.openEndDrawer();
  }
  //未來將這個改用provider讓所有頁面共用
  void toggleButtonList(){
    setState(() {
      _isButtonListopen = !_isButtonListopen; // 切換清單顯示狀態
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onDoubleTap: () {
              openEndDrawer();
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("這裡放即將到期任務"),
                  Text('這裡放最近任務'),
                ],
              ),
            ),
          ),
          ButtonList(isOpen: _isButtonListopen,openEndDrawer: openEndDrawer,)
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "群組清單",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle),
                    title: Text("群組一"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.change_circle_outlined),
                        Icon(Icons.delete),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(groupName: "群組一")));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.circle),
                    title: Text("群組二"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.change_circle_outlined),
                        Icon(Icons.delete),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(groupName: "群組二")));
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) => AddGroupDiolog(),
                  );
              }, 
              child: Text("新增群組"))
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context, 
            builder: (context) => AddTaskDiolog(),
          );
        },
        onLongPress: () {
          toggleButtonList();
        },
        child: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
        ),
      ),
      
    );
  }
}

class ClanderPage extends StatefulWidget{
  const ClanderPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ClanderPageState();
  }
}
class _ClanderPageState extends State<ClanderPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("日曆"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("這裡放置table_calendar"),
            Text("這裡放置日曆選擇後，所顯示的任務條")
          ],
        ),
      ),
    );
  }
}

class TaskListPage extends StatefulWidget{
  const TaskListPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TaskListState();
  }
}
class _TaskListState extends State<TaskListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("任務列表"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("這裡放置搜尋欄"),
            Text('這裡放置所有任務')
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GroupPage extends StatefulWidget{
  String groupName;
  GroupPage({super.key,required this.groupName });

  @override
  State<StatefulWidget> createState() {
    return _GroupPageState();
  }
}
class _GroupPageState extends State<GroupPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("放所有相同群組的任務"),
          ],
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class ButtonList extends StatelessWidget{
  VoidCallback openEndDrawer ;
  ButtonList({super.key,required this.isOpen,required this.openEndDrawer});

  bool isOpen ;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height*0.125,
      right: MediaQuery.of(context).size.width*0.025,
      child: AnimatedOpacity(
        opacity: isOpen ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.pushNamed(context, routeName.Clander.name);
              },
              mini: true,
              child: Icon(Icons.task),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                Navigator.pushNamed(context, routeName.TaskList.name);
              },
              mini: true,
              child: Icon(Icons.note),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                openEndDrawer();
              },
              mini: true,
              child: Icon(Icons.event),
            ),
          ],
        ),
      )
    );
  }
}

class AddTaskDiolog extends StatefulWidget{
  AddTaskDiolog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddTaskDialogState();
  }
}
class _AddTaskDialogState extends State<AddTaskDiolog>{
    
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("新增任務"),
      content: Text("這裡放置任務列表"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("取消")
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("確認輸入")
        )
      ],
    );
  }
}


class AddGroupDiolog extends StatefulWidget{
  AddGroupDiolog({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddGroupDialogState();
  }
}
class _AddGroupDialogState extends State<AddGroupDiolog>{
    
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("新增群組"),
      content: Text("這裡放置任務列表"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("取消")
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("確認輸入")
        )
      ],
    );
  }
}

