import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../VM/UIVM.dart';
import '../view/funtionalwidget.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UIVM>(create: (context) => UIVM())
        ],
        child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomePage(),
        routes:{
          "/Home": (context) => HomePage(),
          "/clander": (context)=> ClanderPage(),
          "/tasklist" : (context) => TaskListPage(),
        },
        onGenerateRoute:(setting){
          if(setting.name == "/group"){
            final args = setting.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (_) => GroupPage(groupName: args['groupName']),);
          }
        }
      ),
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
  void openEndDrawer() {
    print("正在打開 endDrawer");
    _globalKey.currentState!.openEndDrawer();
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
          ButtonList(isOpen: context.watch<UIVM>().isButtonListopen,openEndDrawer: openEndDrawer,)
        ],
      ),
      endDrawer: DrawerWidget(),
      floatingActionButton: FAB(nowPage: 0),
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
