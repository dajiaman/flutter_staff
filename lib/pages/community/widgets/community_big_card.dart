import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/common/widgets/my_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunityBigCardWidget extends StatefulWidget {
  const CommunityBigCardWidget({super.key});

  @override
  State<CommunityBigCardWidget> createState() => _CommunityBigCardWidgetState();
}

class _CommunityBigCardWidgetState extends State<CommunityBigCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: VStack(
        [
          HStack(
            [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LoadAssetImage(
                  "community/cover1",
                  width: 48,
                  height: 48,
                ),
              ),
              Gaps.hGap10,
              Expanded(
                child: HStack(
                  [
                    VStack([
                      "乔治城大学交友群".text.maxLines(1).ellipsis.make(),
                      HStack([
                        "209人".text.maxLines(1).make(),
                        "乔治大学".text.make(),
                      ])
                    ]),
                    MyButton(
                      minHeight: 21,
                      minWidth: 48,
                      fontSize: 14,
                      onPressed: () {},
                      text: "+订阅",
                    )
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                  crossAlignment: CrossAxisAlignment.center,
                ),
              ),
            ],
            axisSize: MainAxisSize.min,
            crossAlignment: CrossAxisAlignment.center,
            alignment: MainAxisAlignment.start,
          ),
          Gaps.vGap16,
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffF6F8FA),
            ),
            child: VStack([
              HStack(
                [
                  HStack([
                    "热".text.make(),
                    "本科研究生如何通过规划时间斩…".text.make(),
                  ]),
                  "200评论".text.make(),
                ],
                axisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.spaceBetween,
                crossAlignment: CrossAxisAlignment.center,
              ),
              HStack(
                [
                  "求职准备-LinkedIn&简历完善准…".text.make(),
                  "200评论".text.make(),
                ],
                axisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.spaceBetween,
                crossAlignment: CrossAxisAlignment.center,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
