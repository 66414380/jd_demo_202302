import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class CustomRefreshFooter extends ClassicFooter {
  @override
  final String noMoreText;

  @override
  final String? processingText;

  @override
  final bool showMessage;
  @override
  final IconThemeData? iconTheme;

  CustomRefreshFooter(
      {this.noMoreText = '没有更多',
      this.processingText = '加载中',
      this.showMessage = false,
      this.iconTheme})
      : super(
            noMoreText: noMoreText,
            processingText: processingText,
            showMessage: showMessage,
            iconTheme: iconTheme);
}
