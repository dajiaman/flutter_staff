import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/constant.dart';

class MyAppBar extends PreferredSize {
  /// 导航栏左侧活动区域,在为null且
  /// [automaticallyImplyLeading]为true时默认赋值为[BrnBackLeading]
  final Widget? leading;

  /// AppBar标题,必须是String或者Widget类型
  /// 为String时,会使用[BrnAppBarTitle]来加载title
  final dynamic title;
  final bool centerTitle;

  /// 为了方便业务使用，可以设置为Widget或者List<Widget>
  /// 传入的Widget会自动添加边距并转化为List<Widget>
  /// 传入的List<Widget>会自动添加右边距和action之间的间距
  final dynamic actions;

  /// 是否自动添加Leading实现
  final bool automaticallyImplyLeading;

  /// 背景色
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Brightness? brightness;
  final double toolbarOpacity;
  final double bottomOpacity;
  final Alignment titleAlignment;
  final Widget? flexibleSpace;
  final double? leadingWidth;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;

  /// 默认处理了返回按钮，flutter的pop，如果是native打开的话，可能需要单独处理,否则会出现白屏
  /// backLeadCallback是默认的处理回调
  /// DefaultLeadingCallBack 也可以通过改方法参数 设置统一的返回处理，该参数是静态的
  final VoidCallback? backLeadCallback;

  /// 是否显示默认的eeeeee分割线，默认显示，可以设置为不显示
  final bool? showDefaultBottom;
  final bool showLeadingDivider;

  MyAppBar(
      {Key? key,
      this.leading,
      this.showLeadingDivider = false,
      this.title,
      this.centerTitle = true,
      this.actions,
      this.backgroundColor,
      this.bottom,
      this.automaticallyImplyLeading = true,
      this.elevation = 0,
      this.brightness,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0,
      this.titleAlignment = Alignment.center,
      this.flexibleSpace,
      this.backLeadCallback,
      this.showDefaultBottom,
      this.leadingWidth,
      this.shadowColor,
      this.shape,
      this.iconTheme,
      this.actionsIconTheme,
      this.excludeHeaderSemantics = false,
      this.primary = true,
      this.textTheme,
      this.titleSpacing})
      : assert(
            actions == null || actions is Widget || (actions is List<Widget>)),
        assert(title == null || title is String || title is Widget),
        super(key: key, child: Container(), preferredSize: const Size(0, 0));

  @override
  Size get preferredSize {
    return Size.fromHeight(
        AppTheme.appBarHeight + (bottom?.preferredSize.height ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget get child {
    Widget? flexibleSpace;
    if (this.flexibleSpace != null) {
      flexibleSpace = Container(child: this.flexibleSpace);
    }

    return AppBar(
      key: key,
      leading: _wrapLeading(),
      leadingWidth: leadingWidth ?? _culLeadingSize(),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: _buildAppBarTitle(),
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? Colors.white,
      actions: _wrapActions(),
      bottom: _buildBarBottom(),
      brightness: brightness ?? Brightness.light,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      flexibleSpace: flexibleSpace,
      shadowColor: shadowColor,
      shape: shape,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
    );
  }

  // 根据输入的leading 设置默认的leadingWidth
  double _culLeadingSize() {
    if (leadingWidth != null) {
      return leadingWidth!;
    }

    // doubleLeading
    if (leading is DoubleLeading) {
      return AppTheme.iconMargin + AppTheme.iconMargin + AppTheme.iconSize * 2;
    }

    if (leading == null && !automaticallyImplyLeading) {
      return 0;
    }

    return AppTheme.iconMargin + AppTheme.iconSize;
  }

  Widget? _wrapLeading() {
    Widget? realLeading = leading;

    if (leading == null && automaticallyImplyLeading) {
      realLeading = BackLeading(
        iconPressed: backLeadCallback,
      );
    }

    if (realLeading is BackLeading) {
      return Container(
        padding: EdgeInsets.only(left: AppTheme.iconMargin),
        child: realLeading,
      );
    }

    return realLeading;
  }

  // 详情请参考_ToolbarLayout的布局方法
  Widget? _buildAppBarTitle() {
    Widget? realTitle;
    if (title is Widget) {
      return title;
    }
    if (title is String) {
      realTitle = AppBarTitle(
        title,
      );
    }

    return realTitle;
  }

  List<Widget>? _wrapActions() {
    if (actions == null || !(actions is List<Widget> || actions is Widget)) {
      return null;
    }

    List<Widget> actionList = [];

    if (actions is List<Widget>) {
      if (actions.isEmpty) {
        return actionList;
      }
      List<Widget> tmp = (actions as List<Widget>).map((_) {
        return (_ is TextAction) ? _warpRealAction(_) : _;
      }).toList();

      for (int i = 0, n = tmp.length; i < n; i++) {
        actionList.add(tmp[i]);
        if (i != n - 1) actionList.add(SizedBox(width: AppTheme.iconMargin));
      }
    } else {
      Widget realAction =
          (actions is TextAction) ? _warpRealAction(actions) : actions;
      actionList.add(realAction);
    }

    return actionList..add(SizedBox(width: AppTheme.iconMargin));
  }

  TextAction _warpRealAction(TextAction textAction) {
    return TextAction(textAction.text,
        iconPressed: textAction.iconPressed, key: textAction.key);
  }

  PreferredSizeWidget? _buildBarBottom() {
    return bottom;
  }
}

class DoubleLeading {}

/// [BrnAppBar]中leading的默认实现
/// 宽度范围是40
class BackLeading extends StatelessWidget {
  final Widget? child;
  final VoidCallback? iconPressed;

  BackLeading({Key? key, this.iconPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: AppTheme.iconSize + 20.0,
        height: AppTheme.appBarHeight,
      ),
      child: IconButton(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.zero,
        onPressed: iconPressed ??
            () {
              /// 默认处理了返回按钮，flutter的pop，如果是native打开的话，可能需要单独处理,否则会出现白屏
              /// backLeadCallback是默认的处理回调
              /// DefaultLeadingCallBack 也可以通过改方法参数 设置统一的返回处理，该参数是静态的
              Navigator.maybePop(context);
            },
        icon: child ??
            Image.asset(
              'assets/images/icon-arrow-left.png',
              width: AppTheme.iconSize,
              height: AppTheme.iconSize,
              fit: BoxFit.fitHeight,
            ),
      ),
    );
  }
}

class TextAction extends StatelessWidget {
  final String text;
  final VoidCallback? iconPressed;

  TextAction(this.text, {Key? key, this.iconPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: AppTheme.appBarHeight,
        alignment: Alignment.center,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: iconPressed,
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title;

  AppBarTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.lightTextColor,
          fontSize: AppTheme.titleFontSize,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      constraints: BoxConstraints.loose(
        Size.fromWidth(
          18 * (AppTheme.maxLength + 1),
        ),
      ),
    );
  }
}
