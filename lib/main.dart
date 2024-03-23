
import 'package:anki/%E3%81%9D%E3%81%AE%E4%BB%96/Support.dart';
import 'package:anki/%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'V1/V1.dart';
import 'V2/V2.dart';
import 'V3/V3.dart';
import 'V4/V4.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'V5/V5.dart';
import 'V6/V6.dart';
import 'V7/V7.dart';
import 'V7/V7First.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); //ここ！
    await Firebase.initializeApp(); setup();//ここ！

  runApp(MyApp());
}
Future<void> setup() async {
  tz.initializeTimeZones();
  var tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomNav',
      theme: ThemeData.light(),
      darkTheme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}
// @override



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // ページインデックス保存用
  int _screen = 0;

  // 表示する Widget の一覧
  static List<Widget> _pageList = [
    V1(),V5(),//V7(),//V4(),
    Support()
  ];

  // ページ下部に並べるナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {

    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'ホーム',
      ),

      // BottomNavigationBarItem(
      //   icon: Icon(Icons.comment_outlined),
      //   label: 'スレッド',
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.timeline_sharp),
        label: 'short',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.school),
      //   label: '学校',
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.mail),
        label: '開発者',
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBody: true,
      // Appbar
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[900],
      //   title: Text(
      //     '国試plus',
      //     style: TextStyle(fontSize: 16),
      //   ),
      // ),
      // ページビュー
      body: _pageList[_screen],
      // ページ下部のナビゲーションメニュー
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _screen,
        type: BottomNavigationBarType.fixed,
        // onTapでナビゲーションメニューがタップされた時の処理を定義
        onTap: (index) {
          setState(() {
            // ページインデックスを更新
            _screen = index;
          });
        },
        // 定義済のナビゲーションメニューのアイテムリスト
        items: myBottomNavBarItems(),
      ),

    );

  }
}


