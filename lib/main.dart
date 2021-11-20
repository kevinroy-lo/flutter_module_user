import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_user_info/component/top_bar.dart';
import 'package:flutter_user_info/router/router.dart';
import 'package:flutter_user_info/ui/user_home.dart';
import 'package:flutter_user_info/util/color_util.dart';
import 'package:flutter_user_info/component/item_field.dart';
import 'package:flutter_user_info/util/colors.dart';

import 'util/fonts.dart';
import 'util/statusbar_style.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(statusBarDark);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFFFF7A67)),
      ),
      routes: {Routers.userInfoMain: (context) => const UserHomePage()},
      title: 'Navigation with Arguments',
      initialRoute: Routers.userInfoMain,
      onGenerateRoute: (RouteSettings settings) {
        return Routers.run(settings);
      },
      home: const UserHomePage(),
    );
  }
}
