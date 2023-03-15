import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../entity/feed_item.dart';

class WaterFeedItemWidget extends StatefulWidget {
  FeedItemModel? feedItem;
  WaterFeedItemWidget(
    this.feedItem, {
    super.key,
  });

  @override
  State<WaterFeedItemWidget> createState() => _WaterFeedItemWidgetState();
}

class _WaterFeedItemWidgetState extends State<WaterFeedItemWidget> {
  FeedItemModel? _feedItem;

  @override
  void initState() {
    super.initState();

    _feedItem = widget.feedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                LoadAssetImage(
                  'home/${_feedItem!.cover}',
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: HStack(
                    [
                      LoadAssetImage(
                        'home/like',
                        width: 12,
                        height: 12,
                      ),
                      Gaps.hGap4,
                      (_feedItem?.likes.toString() ?? "0")
                          .text
                          .color(Colors.white)
                          .size(10)
                          .make(),
                    ],
                    alignment: MainAxisAlignment.end,
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap10,
          (_feedItem?.title ?? "")
              .text
              .maxLines(2)
              .size(16)
              .lineHeight(1.2)
              .ellipsis
              .make(),
          Gaps.vGap10,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LoadAssetImage(
                  'avatar',
                  width: 24,
                  height: 24,
                ),
              ),
              Gaps.hGap12,
              (_feedItem?.author ?? "")
                  .text
                  .hexColor("#8D93A6")
                  .size(10)
                  .ellipsis
                  .make(),
            ],
          )
        ],
      ),
    );
  }
}
