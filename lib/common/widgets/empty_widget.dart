import 'package:flutter/material.dart';

// 空页面
class EmptyWidget extends StatelessWidget {
  // 图片
  Widget? image;
  // 标题
  String? title;

  // 内容
  String? content;

  // 背景色 默认Colors.white
  Color bgColor;

  EmptyWidget({
    this.image,
    this.title,
    this.content,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: bgColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageWidget(context),
            _buildTextWidget(),
            _buildContentWidget(),
          ],
        ),
      ),
    );
  }

  // 图片区域
  Widget _buildImageWidget(BuildContext context) {
    return image != null
        ? Container(
            child: image,
          )
        : const SizedBox.shrink();
  }

  // 文案区域：标题
  Widget _buildTextWidget() {
    return title != null
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(60, 24, 60, 0),
            child: Text(
              title!,
              textAlign: TextAlign.center,
            ),
          )
        : SizedBox.shrink();
  }

  ///文案区域：内容
  Widget _buildContentWidget() {
    return content != null
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(60, 24, 60, 0),
            child: Text(
              content!,
              textAlign: TextAlign.center,
            ),
          )
        : SizedBox.shrink();
  }
}
