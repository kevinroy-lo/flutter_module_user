import 'package:flutter/material.dart';
import 'package:flutter_user_info/ui/user_home.dart';
import 'package:flutter_user_info/ui/user_name.dart';

class Routers {
  static const userInfoMain = "/user_info_main";
  static const userInfoSetNick = "/user_info_nick";

  static Map<String, Function> routes = {
    userInfoMain: (context, {params}) => const UserHomePage(),
    userInfoSetNick: (context, {params}) => UserSetNickPage(params: params)
  };

  ///组件跳转
  static push(String routeName, BuildContext context,
      [Map? params, Function? callBack]) {
    if (params != null) {
      Navigator.pushNamed(context, routeName, arguments: params)
          .then((onValue) {
        if (callBack != null) {
          callBack(onValue);
        }
      });
    } else {
      Navigator.pushNamed(context, routeName).then((onValue) {
        if (callBack != null) {
          callBack(onValue);
        }
      });
    }
  }

  static run(RouteSettings routeSettings) {
    final Function? pageContentBuilder = Routers.routes[routeSettings.name!];
    if (pageContentBuilder != null) {
      if (routeSettings.arguments != null) {
        return MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, params: routeSettings.arguments));
      } else {
        // 无参数路由
        return MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
      }
    }
  }
}
