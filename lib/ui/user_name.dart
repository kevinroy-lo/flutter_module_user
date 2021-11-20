import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_user_info/component/top_bar.dart';
import 'package:flutter_user_info/util/colors.dart';
import 'package:flutter_user_info/util/fonts.dart';

class UserSetNickPage extends StatefulWidget {
  final Map? params;
  const UserSetNickPage({Key? key, this.params}) : super(key: key);

  @override
  _UserSetNickState createState() => _UserSetNickState();
}

class _UserSetNickState extends State<UserSetNickPage> {
  final _textEditingController = TextEditingController();

  String _nickName = "";

  @override
  void initState() {
    super.initState();
    _nickName = widget.params!['name'];
    _textEditingController.text = _nickName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,
      appBar: TopAppBar(
        title: "修改昵称",
        fontColor: const Color(0xFF3B3939),
        backIcon: "assets/img_back_dark.png",
        backgroundColor: const Color(0xFFF1F1F1),
        rightWidget: const Text(
          "保存",
          style: t14Orange,
        ),
        onRightTap: () {
          Navigator.of(context).pop(_textEditingController.text);
        },
      ).build(context),
      body: Column(
        children: [
          Container(
            height: 50,
            color: backWhite,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
