import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/common/widgets/my_button.dart';
import 'package:velocity_x/velocity_x.dart';

class FollowCard extends StatelessWidget {
  const FollowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: VStack(
        [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LoadAssetImage(
              'avatar',
              width: 48,
              height: 48,
            ),
          ),
          "王子轩".text.size(14).make(),
          "美国帝国理工大学".text.size(14).ellipsis.make(),
          MyButton(
            minHeight: 21,
            minWidth: 48,
            fontSize: 14,
            onPressed: () {},
            text: "+订阅",
          )
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ),
    )
        .color(Colors.white)
        .width(114)
        .height(151)
        .px16
        .margin(EdgeInsets.only(right: 16))
        .make();
  }
}
