import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_user_info/component/item_field.dart';
import 'package:flutter_user_info/component/top_bar.dart';
import 'package:flutter_user_info/router/router.dart';
import 'package:flutter_user_info/util/color_util.dart';
import 'package:flutter_user_info/util/colors.dart';
import 'package:flutter_user_info/util/fonts.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UserHomePage extends StatefulWidget {
  final String title = "个人资料";
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserHomePageState();
  }
}

class _UserHomePageState extends State<UserHomePage> {
  bool showPickSexDialog = true;
  String sex = "";
  String _nickName = "";
  AssetEntity? _userHeader;
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
        appBar: const TopAppBar(
          title: "用户",
        ).build(context),
        body: Column(
          children: [
            RowItemField(
              onTap: () {
                FocusScope.of(context).requestFocus(_foucsNode);
                // Routers.push(Routers.userPhotoPick, context);
                AssetPicker.permissionCheck().then((value) => {
                      if (value.isAuth)
                        {
                          AssetPicker.pickAssets(context,
                              maxAssets: 1,
                              pickerTheme: ThemeData(
                                brightness: Brightness.light,
                                primarySwatch: createMaterialColor(
                                    const Color(0xFFFF7A67)),
                              )).then((value) => {
                                setState(() {
                                  _userHeader = value!.first;
                                })
                              })
                        }
                    });
              },
              label: "头像",
              rightWidget: CircleAvatar(
                radius: 30,
                backgroundImage: _userHeader == null
                    ? null
                    : AssetEntityImageProvider(_userHeader!),
                foregroundColor: Colors.amber,
              ),
            ),
            RowItemField(
              onTap: () {
                FocusScope.of(context).requestFocus(_foucsNode);
                Routers.push(
                    Routers.userInfoSetNick, context, {"name": _nickName},
                    (value) {
                  setState(() {
                    _nickName = value;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(value);
                });
              },
              label: "昵称",
              rightWidget: Text(
                _nickName,
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
        ));
  }
}
