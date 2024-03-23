
import 'package:anki/V1/V1Result.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart' as ja;

import 'CreateReslut.dart';


class CreateQA extends StatefulWidget {
  CreateQA(this.name,this.ID,this.ID2);
  String name;String ID;String ID2;
  @override
  State<CreateQA> createState() => _CreateQAState();
}

class _CreateQAState extends State<CreateQA>with TickerProviderStateMixin , WidgetsBindingObserver {
  final scheduleId = 0;
  final scheduleAddSec = 3;
  var item = [];var item1 = [];var item2 = [];var item3 = [];var item4 = [];var itemAll = [];
  var text = "";var text2 = "";var ID = "";var date = "";
  var map = {};
  var count = 0;var itemco = 0;var time = 1;var startTime = "3";var co = 0;var CountTime = 0.0;var CountTime2 = 0.0;
  var OK = false;var _visible = true;
  Color color  = Colors.red;
  late TextEditingController _bodyController;
  FlutterTts flutterTts = FlutterTts();
  final _player = ja.AudioPlayer(handleInterruptions: false, androidApplyAudioAttributes: false, handleAudioSessionActivation: false,);


  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();first ();main();
    Future.delayed(Duration(seconds: 3), () {setState(() {startTime = "";_visible = false;OK = true;set();});});
    Future.delayed(Duration(seconds: 2), () {setState(() {startTime = "1";});});
    Future.delayed(Duration(seconds: 1), () {setState(() {startTime = "2";});});
    super.initState();_bodyController = TextEditingController();
   // initAudioService();
    AudioSession.instance.then((audioSession) async {
      await audioSession.configure(AudioSessionConfiguration.speech());
      _handleInterruptions(audioSession);
    });print(co);
  }

  @override
  void dispose() {
    flutterTts.stop;_player.dispose();initAudioService11();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          leading: Container(alignment: Alignment.center,child:Text(startTime.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30), textAlign: TextAlign.center,),),
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(time.toString() + "周目", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),),
          automaticallyImplyLeading: false, centerTitle: true,elevation: 0,
          actions: [IconButton(icon: const Icon(Icons.highlight_off,color: Colors.blueGrey,size: 30,), onPressed: () {Navigator.pop(context);},)],
        ),
        body: Container(child: item.length  != 0 ?SingleChildScrollView(
            child: Column(children: <Widget>[
              // Container(child: Visibility(visible: _visible, child: Column(children: <Widget>[
              //   Container(width: double.infinity,margin:EdgeInsets.only(top: 100),child:Text(startTime.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 50), textAlign: TextAlign.center,),)
              // ]))),
              Container(child: Column(children: <Widget>[
                // Container(child: Visibility(visible: _visible, child: Column(children: <Widget>[
                //   Container(width: double.infinity,margin:EdgeInsets.only(top: 20),child:Text(startTime.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 50), textAlign: TextAlign.center,),)
                // ]))),
                Container(margin: EdgeInsets.only(top: 30,bottom: 5, left: 20, right: 20), child:Text('問題',style: TextStyle(fontWeight: FontWeight.bold),),),
                Container(margin: EdgeInsets.only(top: 3, left: 20, right: 20), width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5, offset: Offset(1, 1),),], color: Colors.white,),
                    child: Column(children: <Widget>[
                      Container(margin: EdgeInsets.only(top: 30, left: 10, right: 10,bottom:30),width:double.infinity,alignment: Alignment.center, child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,fontSize: 20), textAlign: TextAlign.center,),),
                    ])),
                Container(margin: EdgeInsets.only(top:20,bottom: 5, left: 20, right: 20), child:Text('答え',style: TextStyle(fontWeight: FontWeight.bold),),),
                Container(margin: EdgeInsets.only(top: 3, left: 20, right: 20), width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 5, blurRadius: 5, offset: Offset(1, 1),),], color: color,),
                    child: Column(children: <Widget>[
                      Container(margin: EdgeInsets.only(top: 30, left: 10, right: 10,bottom:30),width:double.infinity,alignment: Alignment.center, child: Text(text2,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red,fontSize: 20), textAlign: TextAlign.center,),),
                    ])),
                TextButton(child: RichText(text: TextSpan(style: Theme.of(context).textTheme.bodyText2,
                    children:  [
                      TextSpan(text: CountTime.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
                      TextSpan(text: " 秒後に答えが出ます", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ]),), onPressed: () {Edite();},
                ),
                Container(margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(height: 90, width: 90,
                            child: Visibility(visible: OK,
                              child: ElevatedButton(
                                child: const Text('覚えた',style: TextStyle(fontWeight: FontWeight.bold),),
                                style: ElevatedButton.styleFrom(primary: Colors.green,
                                  shape: const CircleBorder(side: BorderSide(color: Colors.green, width: 1, style: BorderStyle.solid,),),),
                                onPressed: () {add();item.removeAt(itemco);set();},
                              ),),)),
                      Container(width: 10,),
                      Expanded(child: Container(height: 90, width: 90, child: Visibility(visible: OK,
                        child: ElevatedButton(
                          child: const Text('まだ',style: TextStyle(fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(primary: Colors.red,
                            shape: const CircleBorder(side: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid,),),),
                          onPressed: () {itemco = itemco + 1;set();},
                        ),),))])),
                Container(margin:EdgeInsets.only(top:20,bottom: 20,left: 50,right: 50),child:
                ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)), child: LinearProgressIndicator(
                  value: item.length / co, valueColor: AlwaysStoppedAnimation(getCurrentHpColor(10)),
                  backgroundColor: Colors.grey, minHeight: 20,),),),
                Container(width:double.infinity,child:Text('${item.length.toString().padLeft(0, '  ')}/${co.toString()}',textAlign: TextAlign.center,),),
              ],)),])
                 ):
          Center(child:Text('問題が存在しません',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
    );}
  Future<void> Edite() async {
    showDialog(context: context, builder: (context) =>  AlertDialog(title: Text('時間の変更',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),
      actions: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(child:Text('長文問題以外はなるべく短い時間でお願いします\n(アプリのコンセプト『即答できなきゃ覚えてない』の範囲内)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.grey,), textAlign: TextAlign.center,),),
          Container(width: double.infinity,margin:EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
            child: TextField(keyboardType: TextInputType.number, maxLines: null,controller: _bodyController,decoration: InputDecoration(border: InputBorder.none, ),onChanged: (String value) {CountTime2 = double.parse(value);},),),
          Container(margin :EdgeInsets.all(10),width:100,child: ElevatedButton(child: Text('今回のみ'), style: ElevatedButton.styleFrom(primary: Colors.orange, onPrimary: Colors.white, shape: const StadiumBorder(),),
              onPressed: () {setState(() {CountTime = CountTime2;Navigator.pop(context);});})),
          Container(margin :EdgeInsets.all(10),child: ElevatedButton(child: Text(widget.name + 'はこの時間'), style: ElevatedButton.styleFrom(primary: Colors.orange, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () async {SharedPreferences prefs = await SharedPreferences.getInstance();prefs.setDouble("CountTime" + widget.name,CountTime2);setState(() {CountTime = CountTime2;Navigator.pop(context);});
            },)),
        ],)],));
  }
  Color getCurrentHpColor(int hp) {
    if (hp > co / 2) {return const Color(0xFF00D308);}
    if (hp > co / 5) {return const Color(0xFFFFC107);}
    return const Color(0xFFFF0707);
  }
  void set (){setState(() {
    if (item.length != 0){
      if (itemco < item.length){
        color = Colors.red;text = item[itemco]["問題"];text2 = item[itemco]["答え"];
        //_speak();
        Future.delayed(Duration(seconds:CountTime.toInt()), () {setState(() {color = Colors.white;});});
      }else{itemco = 0;time = time + 1;
      color = Colors.red;text = item[itemco]["問題"];text2 = item[itemco]["答え"];
      //_speak();
      Future.delayed(Duration(seconds: CountTime.toInt()), () {setState(() {color = Colors.white;});});
      }
    }else{Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateResult(item1,item2,item3,item4,itemAll)),);}
  });}

  void add (){
    switch (time){
      case 1 :item1.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":0,"date":date,"科目":widget.name});break;
      case 2 :item2.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":1,"date":date,"科目":widget.name});itemAll.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":1,"date":date,"dateC":0,"科目":"自作"});break;
      case 3 :item3.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":2,"date":date,"科目":widget.name});itemAll.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":2,"date":date,"dateC":0,"科目":"自作"});break;
      default:item4.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":3,"date":date,"科目":widget.name});itemAll.add({"Q":item[itemco]["問題"],"A":item[itemco]["答え"],"レベル":3,"date":date,"dateC":0,"科目":"自作"});break;
    }
  }

   Future<void> main() async {SharedPreferences prefs = await SharedPreferences.getInstance();CountTime = prefs.getDouble("time") ?? 1.5;DateTime now = DateTime.now();DateFormat outputFormat = DateFormat('yyyy年MM月dd日');date = outputFormat.format(now);}

  void first () async {
    FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").where("ID" ,isEqualTo: widget.ID2).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {item = doc["問題"];co = item.length;});;});});}





  Future<void> _handleInterruptions(AudioSession audioSession) async {
    bool playInterrupted = false;
    audioSession.becomingNoisyEventStream.listen((_) {
    });
    _player.playingStream.listen((playing) {
      playInterrupted = false;
      if (playing) {
        audioSession.setActive(true);
      }
    });
    audioSession.interruptionEventStream.listen((event) async {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes!.usage ==
                AndroidAudioUsage.game) {
              _player.setVolume(_player.volume / 1.5);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
           // initAudioService();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(min(1.0, _player.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) _player.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
  }
  Future<void> initializeService1() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart1,
        autoStart: false,
        isForegroundMode: false,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart1,
      ),);
    service.startService();
  }
  @pragma('vm:entry-point')
  void onStart1(ServiceInstance service) async {
    service.stopSelf();
  }

  Future<void> _handleInterruptions1(AudioSession audioSession) async {
    audioSession.setActive(false);
  }
  Future initAudioService11() async {
    final session = await AudioSession.instance;
    session.setActive(false);
    AudioSession.instance.then((audioSession) async {await audioSession.configure(AudioSessionConfiguration.speech());_handleInterruptions1(audioSession);});
    _player.dispose();_player.stop();
  }

}