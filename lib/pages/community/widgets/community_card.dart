import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/pages/community/detail.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunityCardWidget extends StatefulWidget {
  const CommunityCardWidget({super.key});

  @override
  State<CommunityCardWidget> createState() => _CommunityCardWidgetState();
}

class _CommunityCardWidgetState extends State<CommunityCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CommunityDetailPage();
        }));
      },
      child: Container(
        width: 80,
        height: 135,
        margin: EdgeInsets.only(left: 16),
        child: VStack(
          [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LoadAssetImage(
                "community/cover1",
                width: 80,
                height: 80,
              ),
            ).pOnly(bottom: 4),
            "乔治城大学交友群".text.maxLines(2).ellipsis.make(),
          ],
          alignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
