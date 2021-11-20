import 'package:flutter/material.dart';
import 'package:flutter_user_info/util/colors.dart';

typedef OnTap = void Function();

class RowItemField extends StatelessWidget {
  final String? label;
  final bool needRigthArrow;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final EdgeInsets? defaultInsets;
  final GestureTapCallback? onTap;

  const RowItemField({
    Key? key,
    this.label,
    this.defaultInsets,
    this.needRigthArrow = true,
    this.rightWidget,
    this.leftWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
              color: backWhite,
              border: Border(bottom: BorderSide(color: bgColor, width: 0.5))),
          padding: defaultInsets ??
              const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          child: Row(
            children: [
              Container(
                child: leftWidget ??
                    Text(
                      label ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: needRigthArrow ? 10.0 : 0.0),
                    child: rightWidget,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: needRigthArrow
                        ? Image.asset(
                            'assets/ic_arrow_right.png',
                            width: 6,
                            height: 12,
                          )
                        : null,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
