import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_user_info/util/color_util.dart';
import 'package:flutter_user_info/component/item_field.dart';
import 'package:flutter_user_info/util/colors.dart';

import 'util/fonts.dart';

void main() => runApp(const UserMainWidget());

class UserMainWidget extends StatelessWidget {
  const UserMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFFFF7A67))),
      routes: {"user_main": (context) => const UserHomeWidget()},
      title: 'Navigation with Arguments',
      initialRoute: "user_main",
      home: const UserHomeWidget(),
    );
  }
}

class UserHomeWidget extends StatefulWidget {
  final String title = "个人资料";
  const UserHomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserHomeWidgetState();
  }
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  bool showPickSexDialog = true;
  String sex = "";
  String _bYear = "", _bMonth = "", _bDay = "";
  final TextEditingController _phoneTextEditController =
      TextEditingController();

  final _foucsNode = FocusNode();

  void _showPickerSex(context) {
    showModalBottomSheet(
        isScrollControlled: false,
        constraints:
            const BoxConstraints(maxHeight: 150, minWidth: double.infinity),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Column(
            children: [
              _pickerItem("男", () {
                setState(() {
                  sex = "男";
                  Navigator.pop(context);
                });
              }),
              _pickerItem("女", () {
                setState(() {
                  sex = "女";
                  Navigator.pop(context);
                });
              }),
              _pickerItem("取消", () {
                setState(() {
                  Navigator.pop(context);
                });
              }),
            ],
          );
        });
  }

  Widget _pickerItem(
    String tag,
    Function click,
  ) {
    return GestureDetector(
        onTap: () {
          click.call();
        },
        child: Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: bgColor, width: 0.5))),
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(tag),
          ),
        ));
  }

  void _pickBirthday() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2001, 1, 31),
        maxTime: DateTime(2030, 1, 31),
        theme: const DatePickerTheme(
            headerColor: backWhite,
            backgroundColor: backWhite,
            itemStyle: t14black,
            doneStyle: t14black,
            cancelStyle: t14grey),
        onChanged: (date) {}, onConfirm: (DateTime date) {
      setState(() {
        _bYear = date.year.toString();
        _bMonth = date.month.toString();
        _bDay = date.day.toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F1F1),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img_leading_back.png',
                  width: 16.0,
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: const Text(
                    "返回",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                RowItemField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_foucsNode);
                    _phoneTextEditController.clear();
                  },
                  label: "头像1",
                  rightWidget: const CircleAvatar(
                    radius: 30,
                    foregroundColor: Colors.amber,
                  ),
                ),
                RowItemField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_foucsNode);
                  },
                  label: "昵称",
                  rightWidget: const Text(
                    "昵称",
                    style: t14black,
                  ),
                ),
                RowItemField(
                    needRigthArrow: false,
                    label: "手机号码",
                    rightWidget: SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          style: t14black,
                          controller: _phoneTextEditController,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.end,
                        ))),
                RowItemField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_foucsNode);
                    _showPickerSex(context);
                  },
                  label: "性别",
                  rightWidget: Text(
                    sex,
                    style: t14black,
                  ),
                ),
                RowItemField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_foucsNode);
                    _pickBirthday();
                  },
                  label: "出生日期",
                  rightWidget: Text(_bYear + '-' + _bMonth + '-' + _bDay),
                ),
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                RowItemField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_foucsNode);
                  },
                  label: "登录密码",
                ),
              ],
            );
          },
        ));
  }
}
