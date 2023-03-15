import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../entity/feed_item.dart';

class FeedItemWidget extends StatefulWidget {
  FeedItemModel? feedItem;
  FeedItemWidget(
    this.feedItem, {
    super.key,
  });

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  FeedItemModel? _feedItem;

  @override
  void initState() {
    super.initState();

    _feedItem = widget.feedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_feedItem?.title ?? "").text.size(16).make(),
          Gaps.vGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (_feedItem?.author ?? "")
                  .text
                  .size(12)
                  .hexColor("#8D93A6")
                  .make(),
              HStack(
                [
                  (_feedItem?.likes.toString() ?? "")
                      .text
                      .size(12)
                      .hexColor("#8D93A6")
                      .make(),
                  "赞".text.hexColor("#8D93A6").make(),
                ],
                crossAlignment: CrossAxisAlignment.center,
              )
            ],
          )
        ],
      ),
    );
  }
}
