import 'package:flutter/material.dart';
import 'package:orginone/components/unified.dart';

class GyScaffold extends StatefulWidget {
  final Widget? body;

  final bool supportSafeArea;

  final Color? backgroundColor;

  final Color? appBarColor;

  final String? titleName;

  final TextStyle? titleStyle;

  final bool centerTitle;

  final Widget? titleWidget;

  final List<Widget>? actions;

  final  Widget? leading;

  final double elevation;
  const GyScaffold(
      {Key? key,
      this.body,
      this.supportSafeArea = true,
      this.backgroundColor,
      this.appBarColor,
      this.titleName,
      this.titleWidget, this.titleStyle,  this.centerTitle = true, this.actions, this.leading, this.elevation = 0})
      : super(key: key);

  @override
  State<GyScaffold> createState() => _GyScaffoldState();
}

class _GyScaffoldState extends State<GyScaffold> {
  late Widget body;

  late bool supportSafeArea;

  late Color backgroundColor;

  late Color appBarColor;

  Widget? titleWidget;

  late String titleName;

  TextStyle? titleStyle;

  late bool centerTitle;

  List<Widget>? actions;

  Widget? leading;

  late double elevation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    body = widget.body ?? Container();
    supportSafeArea = widget.supportSafeArea;
    backgroundColor = widget.backgroundColor ?? Colors.grey.shade200;
    appBarColor = widget.appBarColor ?? XColors.themeColor;
    titleName = widget.titleName ?? "";
    titleWidget = widget.titleWidget;
    titleStyle = widget.titleStyle;
    centerTitle = widget.centerTitle;
    actions = widget.actions;
    leading = widget.leading;
    elevation = widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    if (supportSafeArea) {
      body = SafeArea(
        child: body,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: titleWidget ?? Text(titleName,style: titleStyle,),
          centerTitle: centerTitle,
          elevation: elevation,
          backgroundColor: appBarColor,
          actions: actions,
          leading: leading,
        ),
        backgroundColor: backgroundColor,
        body: body);
  }
}
