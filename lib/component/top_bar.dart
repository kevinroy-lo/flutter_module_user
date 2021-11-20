import 'package:flutter/material.dart';
import 'package:flutter_user_info/util/colors.dart';
import 'package:flutter_user_info/util/fonts.dart';

typedef BackPress = void Function();

// AppBar(
//           centerTitle: true,
//           title: Text(
//             widget.title,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
//           ),
//           leading: Container(
//             margin: const EdgeInsets.only(left: 10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/img_leading_back.png',
//                   width: 16.0,
//                   height: 16.0,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 2),
//                   child: const Text(
//                     "返回",
//                     style: TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           titleTextStyle: const TextStyle(color: Colors.white, fontSize: 17),
//         )

class TopAppBar extends StatelessWidget {
  final String? title;
  final bool closeIcon;
  final BackPress? backPress;
  final Color? backgroundColor;
  final Color? fontColor;
  final String? backIcon;
  final Widget? rightWidget;
  final GestureTapCallback? onRightTap;

  const TopAppBar({
    Key? key,
    this.title,
    this.closeIcon = false,
    this.backPress,
    this.backgroundColor,
    this.fontColor,
    this.backIcon,
    this.rightWidget,
    this.onRightTap,
  }) : super(key: key);

  Widget buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? mainOrg,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: lineColor, width: 0.5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                  margin: const EdgeInsets.only(left: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        backIcon ?? 'assets/img_leading_back.png',
                        width: 16.0,
                        height: 16.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text(
                          "返回",
                          style: TextStyle(
                              color: fontColor ?? Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  ))

              // child: SizedBox(
              //   width: 50,
              //   child: Image.asset(
              //     'assets/img_leading_back.png',
              //     height: 25,
              //   ),
              // )
              ,
              onTap: () {
                if (backPress != null) {
                  backPress!();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            if (closeIcon)
              GestureDetector(
                child: Image.asset('assets/images/close.png', width: 20),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                        fontSize: 17,
                        color: fontColor ?? backWhite,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              child: GestureDetector(
                onTap: () {
                  onRightTap?.call();
                },
                child: rightWidget,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      child: buildAppBar(context),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        50,
      ),
    );
  }
}
