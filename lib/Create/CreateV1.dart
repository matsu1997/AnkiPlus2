
import 'dart:math';

import 'package:anki/Create/CreateQA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../V4/V4V2.dart';
import 'CreateQAAdd.dart';

class CreateV1 extends StatefulWidget {
  CreateV1(this.ID);
  String ID;
  @override
  State<CreateV1> createState() => _CreateV1State();
}
class _CreateV1State extends State<CreateV1> {
  var map = {};var mapD = {};var id = "";
  var date = "";var name = "";
  var co = 0;
  late TextEditingController _bodyController;
  var item = [];
  void initState() {
    super.initState();first ();_bodyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("Create", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30), textAlign: TextAlign.center,),),
        iconTheme: IconThemeData(color: Colors.black), centerTitle: true,elevation: 0,
        actions: [],),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.orange, child: const Icon(Icons.create_new_folder),
        onPressed: () {AddView();},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(margin: EdgeInsets.all(10), alignment: Alignment.center, child: Text("問題を作成", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 10), textAlign: TextAlign.center,),),
          Container(margin: EdgeInsets.all(10),child: ListView.builder(shrinkWrap: true, physics:  NeverScrollableScrollPhysics(), itemCount: item.length, itemBuilder: (context, index) {
              return GestureDetector(onTap: () {co = index;StartView();},
                  child: Container(margin: EdgeInsets.all(5),color: Colors.grey[200],child:Column(children: [
                    Container(margin: EdgeInsets.all(20),width:double.infinity,child:Text(item[index]["name"],style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                    ],), )    );},),),
        ],),),);
  }

  void first () async {
    FirebaseFirestore.instance.collection('users').where("ID" ,isEqualTo: widget.ID).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {item = doc["問題集"];});;});});}

  void StartView() {

    showModalBottomSheet(isScrollControlled: true,context: context,backgroundColor: Colors.white,
      shape:  const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
      builder: (context) { return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(child:SingleChildScrollView(
                child: Column(children: <Widget>[
                Container(margin: EdgeInsets.all(10),child:GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateQA("自作",widget.ID,item[co]["ID"])));},
                    child: Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("解答",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20), textAlign: TextAlign.center),),),),
                Container(margin: EdgeInsets.all(10),child:GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateQAAdd(widget.ID,item[co]["ID"],item[co]["name"],co,item)));},
                    child: Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("編集",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20), textAlign: TextAlign.center),),),),
                // Container(margin: EdgeInsets.all(10),child:GestureDetector(onTap: () {open();},
                //     child: Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("問題集を公開する",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20), textAlign: TextAlign.center),),),),
                 Container(margin: EdgeInsets.all(10),child:GestureDetector(onTap: () {delete();},
                    child: Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("削除",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 20), textAlign: TextAlign.center),),),)
                ],)),);});}, );}

  void AddView() {
    showModalBottomSheet(isScrollControlled: true,context: context,backgroundColor: Colors.white,
      shape:  const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
      builder: (context) { return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(height: 400,child:SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(margin: EdgeInsets.all(20),width:double.infinity,child:Text("ファイル名",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                  Container(padding: EdgeInsets.symmetric(horizontal: 16.0,),margin:EdgeInsets.only(left: 10,right:10),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
                    child: TextField(controller: _bodyController,decoration: InputDecoration(border: InputBorder.none,),onChanged: (String value) {setState(() {name = value;});},),),
              Container(margin :EdgeInsets.only(top:20,bottom: 20),width:100,child: ElevatedButton(
                child: Text('登録'), style: ElevatedButton.styleFrom(primary: Colors.orangeAccent, onPrimary: Colors.white, shape: const StadiumBorder(),),
                onPressed: () {send();},)),],)),);});}, );}

  Future<void> delete() async {
    showDialog(context: context, builder: (context) =>  AlertDialog(title: Text('削除しますか？',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(margin :EdgeInsets.only(right:10),width:100,child: ElevatedButton(child: Text('はい'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID);;ref.collection("問題集").doc(item[co]["ID"]).delete();
            setState(() {item.removeAt(co);}); ref.update({"問題集" : item,});Navigator.pop(context);Navigator.pop(context);},)),
          Container(margin :EdgeInsets.only(left:10),width:100,child: ElevatedButton(child: Text('いいえ'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {Navigator.pop(context);},)),
        ],)
      ],));
  }

  Future<void> open() async {
    showDialog(context: context, builder: (context) =>  AlertDialog(title: Text('他のユーザーに公開しますか？',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(margin :EdgeInsets.only(right:10),width:100,child: ElevatedButton(child: Text('はい'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {FirebaseFirestore.instance.collection('users').doc(widget.ID).set({});Navigator.pop(context);Navigator.pop(context);},)),
          Container(margin :EdgeInsets.only(left:10),width:100,child: ElevatedButton(child: Text('いいえ'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {Navigator.pop(context);},)),
        ],)
      ],));
  }

  void send()  {
    if (name != ""){id = randomString(20);
      map = {"name":name,"ID":id};item.insert(0,map);
      DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID);
      ref.update({"問題集": FieldValue.arrayUnion([map]),});
      FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").doc(id).set({"問題":[],"ID":id});
    setState(() {_bodyController.clear();});
    }name = "";Navigator.pop(context);
  }
  String randomString(int length) {
    const _randomChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const _charsLength = _randomChars.length;
    final rand = new Random();
    final codeUnits = new List.generate(
      length, (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },);return new String.fromCharCodes(codeUnits);
  }
}


class CreateV1A extends StatefulWidget {
  @override
  State<CreateV1A> createState() => _CreateV1AState();
}
class _CreateV1AState extends State<CreateV1A> {
  var ID = "";
  var map = {};var mapD = {};
  var date = "";var name = "";
  var co = 0;
  late TextEditingController _bodyController;
  var item = [];
  void initState() {
    super.initState();_bodyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("Create", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30), textAlign: TextAlign.center,),),
        iconTheme: IconThemeData(color: Colors.black), centerTitle: true,elevation: 0,
        actions: [],),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.pink, child: const Icon(Icons.create_new_folder),
        onPressed: () {AddView();},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("問題集",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Container(margin: EdgeInsets.all(10),child: ListView.builder(shrinkWrap: true, physics:  NeverScrollableScrollPhysics(), itemCount: item.length, itemBuilder: (context, index) {
            return GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => V4V2(item[index]["勉強"],item[index]["休憩"],"",ID)));},
                child: Container(margin: EdgeInsets.all(5),color: Colors.grey[200],child:Column(children: [
                  Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("勉強時間:　　" + '${(item[index]["勉強"] / (60 * 60)).floor()}:${((item[index]["勉強"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["勉強"] % (60 * 60) % 60).toString().padLeft(2, '0')}',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                  Container(margin: EdgeInsets.all(5),width:double.infinity,child:Text("休憩時間:　　" +'${(item[index]["休憩"] / (60 * 60)).floor()}:${((item[index]["休憩"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["休憩"] % (60 * 60) % 60).toString().padLeft(2, '0')}',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),)
                ],), )    );},),),
        ],),),);
  }

  void AddView() {
    showModalBottomSheet(isScrollControlled: true,context: context,backgroundColor: Colors.white,
      shape:  const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
      builder: (context) { return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(child:SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("問題集",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                  Container(padding: EdgeInsets.symmetric(horizontal: 16.0,),margin:EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
                    child: TextField(controller: _bodyController,decoration: InputDecoration(border: InputBorder.none,),onChanged: (String value) {setState(() {name = value;});},),),
                Container(margin: EdgeInsets.all(10),child:IconButton(onPressed: () {send();FocusScope.of(context).requestFocus(new FocusNode());},
                    icon: Icon(Icons.create_new_folder_outlined), iconSize: 28, color: Colors.green,
                )),],)),);});}, );}
  Future<void> send() async {
    if (name != ""){
      map = {"name":name};item.insert(0,map);
      DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(ID);
      ref.update({"問題集": FieldValue.arrayUnion([map]),});setState(() {_bodyController.clear();});
    }name = "";
  }

}



class CreateV1B extends StatefulWidget {
  @override
  State<CreateV1B> createState() => _CreateV1BState();
}
class _CreateV1BState extends State<CreateV1B> {
  var ID = "";
  var map = {};var mapD = {};
  var date = "";var name = "";
  var co = 0;
  late TextEditingController _bodyController;
  var item = [];
  void initState() {
    super.initState();_bodyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("Create", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30), textAlign: TextAlign.center,),),
        iconTheme: IconThemeData(color: Colors.black), centerTitle: true,elevation: 0,
        actions: [],),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.pink, child: const Icon(Icons.search),
        onPressed: () {;},
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("問題集",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Container(margin: EdgeInsets.all(10),child: ListView.builder(shrinkWrap: true, physics:  NeverScrollableScrollPhysics(), itemCount: item.length, itemBuilder: (context, index) {
            return GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => V4V2(item[index]["勉強"],item[index]["休憩"],"",ID)));},
                child: Container(margin: EdgeInsets.all(5),color: Colors.grey[200],child:Column(children: [
                  Container(margin: EdgeInsets.all(10),width:double.infinity,child:Text("勉強時間:　　" + '${(item[index]["勉強"] / (60 * 60)).floor()}:${((item[index]["勉強"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["勉強"] % (60 * 60) % 60).toString().padLeft(2, '0')}',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                  Container(margin: EdgeInsets.all(5),width:double.infinity,child:Text("休憩時間:　　" +'${(item[index]["休憩"] / (60 * 60)).floor()}:${((item[index]["休憩"] % (60 * 60) / 60).floor()).toString().padLeft(2, '0')}:${(item[index]["休憩"] % (60 * 60) % 60).toString().padLeft(2, '0')}',style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),)
                ],), )    );},),),
        ],),),);
  }


}

