import 'package:flutter/material.dart';

Widget profileIcon(){
  return const Stack(alignment: Alignment.center,children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Stack(alignment: Alignment.center,children: [
            Icon(Icons.circle, size: 100,color: Colors.grey,),Icon(Icons.person, size: 50,color: Colors.white,),
          ],)],),
          
        ],);
}