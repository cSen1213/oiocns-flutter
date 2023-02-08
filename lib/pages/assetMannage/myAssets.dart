// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyAssets extends StatelessWidget {
  const MyAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(4.0),
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        // 背景色
        color: Colors.grey,
        // 圆角
        borderRadius: BorderRadius.circular(5.0),
      ),

// 把文本放在 Container 的中间
      child: const Center(
        child: Text('我的资产测试页面'),
      ),
    );
  }
}
