import 'package:flutter/material.dart';

import '../values/colors.dart';
import 'constant.dart';

class MySearchInputWidget extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final SearchBarLeadClickCallback? leadClickCallback;
  final SearchBarDismissClickCallback? dismissClickCallback;
  final dynamic leading;
  final SearchBarInputChangeCallback? searchBarInputChangeCallback;
  final SearchBarInputSubmitCallback? searchBarInputSubmitCallback;

  final bool readOnly;

  String? hint;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final TextStyle? dismissStyle;
  final bool showDivider;
  final bool autoFocus;
  final VoidCallback? clearTapCallback;

  MySearchInputWidget({
    this.focusNode,
    this.leading,
    this.leadClickCallback,
    this.dismissClickCallback,
    this.textEditingController,
    this.searchBarInputChangeCallback,
    this.searchBarInputSubmitCallback,
    this.hint,
    this.hintStyle,
    this.inputTextStyle,
    this.showDivider = true,
    this.autoFocus = true,
    this.dismissStyle,
    this.clearTapCallback,
    this.readOnly = false,
  });

  @override
  __MySearchInputWidgetState createState() => __MySearchInputWidgetState();
}

class __MySearchInputWidgetState extends State<MySearchInputWidget> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> valueNotifier;
  late TextEditingController _controller;
  late Color _defaultInputTextColor;
  late Color _defaultCancelTextColor;
  late Color _defaultDividerColor;
  late Color _defaultHintTextColor;
  late Color _defaultClearIconColor;

  late bool _readOnly;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.textEditingController ?? TextEditingController();

    _readOnly = widget.readOnly;

    _defaultDividerColor = AppTheme.dividerColorBase;
    _defaultHintTextColor = AppTheme.colorTextHint;
    _defaultInputTextColor = AppTheme.colorTextSecondary;
    _defaultCancelTextColor = AppTheme.colorTextBase;
    _defaultClearIconColor = AppTheme.colorTextHint;

    valueNotifier = ValueNotifier(false);
    _focusNode.addListener(_handleFocusChangeListenerTick);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_handleFocusChangeListenerTick);
  }

  void _handleFocusChangeListenerTick() {
    if (_focusNode.hasFocus) {
      valueNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: _readOnly ?? false,
      style: TextStyle(
        color: Color(0xff0B1526),
      ),
      autofocus: widget.autoFocus,
      focusNode: _focusNode,
      // 控制器属性，控制正在编辑的文本。
      controller: _controller,
      // 光标颜色属性，绘制光标时使用的颜色。
      // 光标宽度属性，光标的厚度，默认是2.0。
      cursorWidth: 2.0, // 装饰（`decoration`）属性，在文本字段周围显示的装饰。
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.search_input_boarder_color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.search_input_boarder_color,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        // 填充颜色属性，填充装饰容器的颜色。
        fillColor: AppColors.search_input_fill_color,
        // 是密集属性，输入子项是否是密集形式的一部分（即使用较少的垂直空间）。
        isDense: true,
        // 填充属性，如果为`true`，则装饰的容器将填充fillColor颜色。
        filled: true,
        // 提示样式属性，用于提示文本（`hintText`）的样式。
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 16,
              height: 1,
              textBaseline: TextBaseline.alphabetic,
              color: _defaultHintTextColor,
            ),
        // 提示文本属性，提示字段接受哪种输入的文本。
        hintText: widget.hint ?? '',
      ), // 在改变属性，当正在编辑的文本发生更改时调用。
      onChanged: (content) {
        valueNotifier.value = true;
        if (widget.searchBarInputChangeCallback != null) {
          widget.searchBarInputChangeCallback!(content);
        }
        setState(() {});
      },
      onSubmitted: (content) {
        valueNotifier.value = false;
        if (widget.searchBarInputSubmitCallback != null) {
          widget.searchBarInputSubmitCallback!(content);
        }
      },
    );
  }

  Widget _createLeading() {
    if (widget.leading is String) {
      return Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text(
          widget.leading,
          style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
        ),
      );
    }

    if (widget.leading is Widget) {
      return widget.leading;
    }

    return const SizedBox.shrink();
  }
}

/// 左侧leading的点击回调，
/// textEditingController 是搜索框的控制器，暴漏给使用者去处理 是否情况等操作
/// updateTextEdit 是暴漏给使用者的更新方法，该方法在组件的实现setState。
/// 比如想要刷新搜索框 就可以直接调用updateTextEdit()
typedef SearchBarLeadClickCallback = Function(
    TextEditingController textEditingController, VoidCallback updateTextEdit);

/// 右侧取消的点击回调，
/// textEditingController 是搜索框的控制器，暴漏给使用者去处理 是否情况等操作
/// updateTextEdit 是暴漏给使用者的更新方法，该方法在组件的实现setState。
/// 比如想要刷新搜索框 就可以直接调用updateTextEdit()
typedef SearchBarDismissClickCallback = Function(
    TextEditingController textEditingController, VoidCallback updateTextEdit);

/// 输入框输入变化的监听
typedef SearchBarInputChangeCallback = Function(String input);

/// 输入框提交的监听
typedef SearchBarInputSubmitCallback = Function(String input);
