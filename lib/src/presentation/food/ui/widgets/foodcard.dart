import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FoodCard extends StatelessWidget {
  final List<String> items;
  final Color iconColor;
  final String titel;
  final String servingSize;
  final bool isExpand;
  const FoodCard({
    @required this.items,
    @required this.iconColor,
    @required this.titel,
    this.servingSize = "",
    this.isExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        key: ValueKey(titel),
        title: Row(
          children: [
            Icon(Icons.food_bank)
                .box
                .color(iconColor.withOpacity(0.5))
                .p4
                .make(),
            8.widthBox,
            "$titel".text.color(iconColor).make(),
            VxConditional(
                condition: !servingSize.isEmptyOrNull,
                builder: (context) => "($servingSize)".text.make()),
          ],
        ),
        childrenPadding: EdgeInsets.all(8),
        initiallyExpanded: isExpand,
        children: items
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e),
                    Divider(),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
