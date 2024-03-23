

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CreateQAAdd extends StatefulWidget {
  CreateQAAdd(this.ID,this.ID2,this.name,this.Int,this.item);
  String ID;String ID2;String name;int Int;List item;
  @override
  State<CreateQAAdd> createState() => _CreateQAAddState();
}

class _CreateQAAddState extends State<CreateQAAdd> {
  var ID  = "";  var date = "";var Q = "";var A= "";var name = "";
  var map = {};var mapD = {};var mapE = {};var mapN = {};
  var co = 0;
  var item = [];
  late TextEditingController _bodyController;late TextEditingController _bodyController2;late TextEditingController _bodyController3;

  void initState() {first();
     super.initState();_bodyController = TextEditingController();_bodyController2 = TextEditingController();_bodyController3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title:  Text(widget.name, style: TextStyle(color: Colors.blueGrey[900], fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        centerTitle: true,elevation: 0,leading: IconButton(icon:  Icon(Icons.arrow_back_ios,color: Colors.blueGrey,), onPressed: () {Navigator.pop(context);},),
        actions: <Widget>[IconButton(onPressed: () {Edite();}, icon: Icon(Icons.edit_rounded,color: Colors.black87,))],

      ),
      body: GestureDetector( onTap: () => FocusScope.of(context).unfocus(),
        child:Container(color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(height: 20,),
              Expanded(child: ListView.builder(itemCount: item.length, itemBuilder: (context, index) {
                  return GestureDetector(onTap: () {co = index;Q = item[index]["問題"];A = item[index]["答え"];delete();},
                      child: Card(elevation:0,color:Colors.grey[200],child: Container(margin: EdgeInsets.all(15),color: Colors.transparent,
                          child:Column(children: [
                            Container(alignment: Alignment.centerRight,child:Icon(Icons.edit_rounded,color: Colors.blueGrey,size: 15,)),
                            Row(children: [Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15,right:15),child:Text("問題",style: TextStyle(color: Colors.blueGrey[500],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                              Expanded(child: Text(item[index]["問題"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blueGrey[900]),),),],),
                            Divider(color: Colors.blueGrey,thickness: 1,indent: 20,endIndent: 20,),
                            Row(children: [Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15,right:15),child:Text("答え",style: TextStyle(color: Colors.blueGrey[500],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                              Expanded(child: Text(item[index]["答え"],style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blueGrey[900]),),),])
                          ]))));},),),
              Container(decoration: BoxDecoration(color: Colors.white,  borderRadius: BorderRadius.vertical(top: Radius.circular(30.0),), boxShadow: [new BoxShadow(color: Colors.grey, offset: new Offset(1.0, 1.0), blurRadius: 3.0, spreadRadius: 1)],),
                  //decoration: BoxDecoration( borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),),),
                  child:SingleChildScrollView(child:Column(children: <Widget>[Container(height: 20,),
                    Container(width: double.infinity,child:Text("追加",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                    Divider(color: Colors.blueGrey,thickness: 3,indent: 170,endIndent: 170,),
                    Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15),child:Text("問題",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                    Container(width: double.infinity,margin:EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
                          child: TextField(style: TextStyle(color: Colors.black,),keyboardType: TextInputType.multiline, maxLines: null,controller: _bodyController,decoration: InputDecoration(border: InputBorder.none,),onChanged: (String value) {setState(() {Q = value;});},),),
                    Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15),child:Text("答え",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
                    Container(width: double.infinity,margin:EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
                      child: TextField(style: TextStyle(color: Colors.black,),keyboardType: TextInputType.multiline, maxLines: null,controller: _bodyController2,decoration: InputDecoration(border: InputBorder.none,),onChanged: (String value) {setState(() {A = value;});},),),
                    IconButton(onPressed: () {send();FocusScope.of(context).requestFocus(new FocusNode());}, icon: Icon(Icons.add_circle_outline), iconSize: 28, color: Colors.green,),
                  ],)))
            ],),),));}
  void first () async {
    FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").where("ID" ,isEqualTo: widget.ID2).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {setState(() {item = doc["問題"];});;});});}

  Future<void> send() async {
    if (Q != "" && A != ""){
      map = {"問題":Q,"答え":A};item.insert(0,map);
      DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").doc(widget.ID2);
      ref.update({"問題" : FieldValue.arrayUnion([map]),});setState(() {Q= "";A= "";_bodyController.clear();_bodyController2.clear();});
    }}
  Future<void> delete() async {
    showDialog(context: context, builder: (context) => WillPopScope(
      child:  AlertDialog(
        content: Container(child:
        SingleChildScrollView(child:Column(children: [
          Container(width: double.infinity,child:Text("編集",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Divider(color: Colors.blueGrey,thickness: 3,indent: 170,endIndent: 170,),
          Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15),child:Text("問題",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Container(width: double.infinity,margin:EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
            child: TextField(keyboardType: TextInputType.multiline, maxLines: null,controller: _bodyController,decoration: InputDecoration(border: InputBorder.none, hintText: Q,),onChanged: (String value) {setState(() {Q = value;});},),),
          Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15),child:Text("答え",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Container(width: double.infinity,margin:EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
            child: TextField(keyboardType: TextInputType.multiline, maxLines: null,controller: _bodyController2,decoration: InputDecoration(border: InputBorder.none, hintText: A,),onChanged: (String value) {setState(() {A = value;});},),),
          Container(margin :EdgeInsets.all(10),width:100,child: ElevatedButton(child: Text('変更'), style: ElevatedButton.styleFrom(primary: Colors.orange, onPrimary: Colors.white, shape: const StadiumBorder(),),
            onPressed: () {DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").doc(widget.ID2);
            setState(() {mapE = {"問題":Q,"答え":A};item[co] = mapE;Q= "";A= "";_bodyController.clear();_bodyController2.clear();}); ref.update({"問題" : item,});Navigator.pop(context);},)),

          Divider(color: Colors.blueGrey,thickness: 1,),
          Container(margin:EdgeInsets.all(15),width: double.infinity,child:Text("削除しますか?",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Container(margin :EdgeInsets.only(right:10),width:100,child: ElevatedButton(child: Text('はい'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
              onPressed: () {DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID).collection("問題集").doc(widget.ID2);
              setState(() {item.removeAt(co);}); ref.update({"問題" : item,});Navigator.pop(context);},)),
            Container(margin :EdgeInsets.only(left:10),width:100,child: ElevatedButton(child: Text('いいえ'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
              onPressed: () {Navigator.pop(context);},)),
          ],)
        ],)),),
    ),onWillPop: () async {setState(() {Q= "";A= "";_bodyController.clear();_bodyController2.clear();});return true;
    }),);
  }

  Future<void> Edite() async {
    showDialog(context: context, builder: (context) => WillPopScope(
        child:  AlertDialog(
          content: Container(child:
          SingleChildScrollView(child:Column(children: [
            Container(width: double.infinity,child:Text("ファイル名の編集",style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
            Divider(color: Colors.blueGrey,thickness: 3,indent: 170,endIndent: 170,),
            Container(alignment: Alignment.centerLeft,margin:EdgeInsets.only(left:15),child:Text(widget.name,style: TextStyle(color: Colors.blueGrey[900],fontWeight: FontWeight.bold,fontSize: 15), textAlign: TextAlign.center),),
            Container(width: double.infinity,margin:EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5),),
              child: TextField(keyboardType: TextInputType.multiline, maxLines: null,controller: _bodyController3,decoration: InputDecoration(border: InputBorder.none, hintText: "",),onChanged: (String value) {setState(() {name = value;});},),),
            Container(margin :EdgeInsets.only(right:10),width:100,child: ElevatedButton(child: Text('変更'), style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.white, shape: const StadiumBorder(),),
              onPressed: () {widget.item[widget.Int] = {"ID":widget.ID2,"name":name,};DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(widget.ID);
              setState(() {}); ref.update({"問題集" : widget.item,});Navigator.pop(context);widget.name = name;},)),
          ],)),),
        ),onWillPop: () async {setState(() {});return true;
    }),);
  }
}