import 'package:easy_refresh/easy_refresh.dart';
// import 'package:nursery_school_gardener/view/util/ColorUtils.dart';

class CustomRefreshHeader extends ClassicHeader {
  /// 提示刷新文字
  late String dragTextOverride;

  /// 准备刷新文字
  final String armedTextOverride;

  /// 正在刷新文字
  final String readyTextOverride;

  /// 刷新完成文字
  final String processingTextOverride;

  final String processedTextOverride;

  /// 刷新失败文字
  @override
  final String failedText;

  /// 没有更多文字
  @override
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showMessageOverride;

  /// 更多信息
  @override
  final String messageText;

  CustomRefreshHeader({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.dragTextOverride = "下拉刷新",
    this.armedTextOverride = "释放刷新",
    this.readyTextOverride = "刷新中...",
    this.processingTextOverride = "刷新完成",
    this.processedTextOverride = "刷新完成",
    this.failedText = "刷新失败",
    this.noMoreText = "没有更多",
    this.showMessageOverride = false,
    this.messageText = "更新时间 %T",
  }) : super(
      dragText: dragTextOverride,
      armedText: armedTextOverride,
      readyText: readyTextOverride,
      processingText: processingTextOverride,
      processedText: processedTextOverride,
      showMessage: showMessageOverride);
}
