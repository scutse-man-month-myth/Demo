import 'package:flutter/material.dart';
import 'package:frontend_dev/pages/state_page.dart';
import 'package:frontend_dev/pages/drawer_page.dart';
import 'package:frontend_dev/pages/weather_page.dart';
import 'package:frontend_dev/tools/TopReminder.dart';
import 'package:frontend_dev/tools/Toast.dart';
import 'package:frontend_dev/constants/ThemeColors.dart';
import 'package:frontend_dev/constants/IconStyle.dart';
import 'package:frontend_dev/constants/StringStyle.dart';
import 'package:frontend_dev/datas/Location.dart'; // TODO:降低这个类的耦合
import 'package:frontend_dev/tools/Card.dart'; //导入Card

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 全局主题配置
      theme: ThemeData(
        primaryColor: ThemeColors.primaryColor,
        backgroundColor: ThemeColors.backgroundColor,
        accentColor: ThemeColors.accentColor,
        primaryIconTheme: IconStyle.primaryIconStyle,
        primaryTextTheme: StringStyle.primaryTextStyle,
        // primaryTextTheme: ,
      ),
      // 入口界面控件
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 用户参数
  // TODO:封装成User类
  String _avatar = 'imgs/profile.jpeg'; // 头像
  String _nickname = 'nickname'; // 昵称
  String _email = 'nickname@xxx.xxx'; // 邮箱

  // 日期参数
  // TODO:用内置Date类
  String _month = "Jan";
  int _day = 1;
  String _date = "Jan 1";
  String _week = "MONDAY";

  // 页面参数
  // TODO:在initState里初始化
  List<Widget> _bodys;
  int _tabIndex = 2;

  // 得到页面
  // TODO:临时填充将被替换
  Widget _getBody(int index) {
    return Center(
      child: Text("body $index"),
    );
  }

  @override
  void initState() {
    super.initState();
    // TODO:写成生成器模式
    _bodys = [
      _getBody(0),
      //改卡片页面demo，还没写类
      new Stack(
        children: <Widget>[
          new Positioned(
            top: 50,
            left: 40,
            child: new MainCard(
              cardSize: 110,
              color: Colors.white,
              child: new Center(
                  child: new Text("Hello")
              ),
            ),
          )
        ],
      ),
      DailyRecord(),
    ];
  }

  void _openTopReminder(context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        // 当前的路由不会遮盖之前的路由
        opaque: false,
        // 构建路由的主要内容
        pageBuilder: (BuildContext context, _, __) => TopReminder(child:WeatherPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        image: DecorationImage(
          image: AssetImage("imgs/background2.jpg"),
          fit: BoxFit.fitWidth,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) =>
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Theme.of(context).backgroundColor,
                      backgroundImage: AssetImage("imgs/timg.jpg"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    }
                  ),
                ]
              ),
          ),
          title: Text(
            _nickname,
            style: TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            /// 显示日期
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    _date,
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(7, 0, 0, 0)),
                  Text(
                    _week,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            /// 显示天气
            IconButton(
              // TODO:动态变化天气图标
                icon: Icon(
                  Icons.cloud,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  if(county == "") { // 未选择地址
                    Toast.toast(context, "请先选择地址");
                  }
                  else { // 已选择地址
                    _openTopReminder(context);
                  }
                }
            ),
            /// 显示搜索
            IconButton(
              icon: Icon(Icons.search),
              color: Theme.of(context).accentColor,
              onPressed: () {
                // TODO:实现搜索功能
              },
            ),
          ],
          elevation: 0.0,
        ),
        body: _bodys[_tabIndex],
        bottomNavigationBar: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.assignment,
                size: 35,
                color: _tabIndex == 0 ? Colors.blueAccent : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _tabIndex = 0;
                });
              },
            ),
            new IconButton(
              icon: new Icon(
                Icons.border_color,
                size: 35,
                color: _tabIndex == 1 ? Colors.blueAccent : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _tabIndex = 1;
                });
              },
            ),
            new IconButton(
              icon: new Icon(
                Icons.accessibility,
                size: 35,
                color: _tabIndex == 2 ? Colors.blueAccent : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _tabIndex = 2;
                });
              },
            ),
          ],
        ),
        drawer: DrawerPage(
          oriAvatar: _avatar,
          oriNickname: _nickname,
          oriEmail: _email,
        ),
        floatingActionButton: IconButton(
            icon: new Icon(
              Icons.add_circle,
              size: 40,
            ),
            onPressed: null
        ),
      )
    );
  }
}
