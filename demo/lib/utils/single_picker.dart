
import 'package:demo/common/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/* 单列选择器 */
class SinglePicker {

  BuildContext context;

  SinglePicker({@required this.context, this.list, this.itemChanged});

  List<String> list;

  final ValueChanged<int> itemChanged;

  var selectedIndex = 0;

  void show() {
    showCupertinoModalPopup(context: context, builder: (context) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: UIColor.hexEEE))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 70,

                      child: Center(child: Text("取消", style: TextStyle(fontSize: 16, color: UIColor.hex333, fontWeight: FontWeight.normal, decoration: TextDecoration.none),)),
                    ),
                    onTapUp: (tap) {
                      Navigator.of(context).pop();
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: 70,
                      child: Center(child: Text("确定", style: TextStyle(fontSize: 16, color: UIColor.mainColor,  fontWeight: FontWeight.normal, decoration: TextDecoration.none))),
                    ),
                    onTapUp: (tap) {
                      if (this.list.length > 0) {
                        this.itemChanged(this.selectedIndex);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
            ,
            Expanded(child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (index){
                this.selectedIndex = index;
              },
              children: list?.map((title){
                return Center(child: Text(title),);
              })?.toList() ?? []
            ))
          ],
        )
      ) ;
    });
  }
}

