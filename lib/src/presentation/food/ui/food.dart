import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:food/src/presentation/food/controller/food.dart';
import 'package:food/src/presentation/food/ui/widgets/foodcard.dart';

class FoodListScreen extends StatefulWidget {
  final void Function() back;
  const FoodListScreen({
    this.back,
  });
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  var _searchControl = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<FoodController>().resetFilter();
      context.read<FoodController>().getInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: AnimationLimiter(
          child: Consumer<FoodController>(
            builder: (context, controller, _) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: widget.back,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                  child: "Approved Foods List".text.bold.size(20).make(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TextField(
                    controller: _searchControl,
                    decoration: InputDecoration(
                      hintText: "Try searching fat,sauces names...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      border: InputBorder.none,
                    ),
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        controller.resetFilter();
                      } else {
                        await controller.searchItems(value);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var category = controller.filtercategories.isEmpty
                            ? controller.categories[index]
                            : controller.filtercategories[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            verticalOffset: -250,
                            child: ScaleAnimation(
                              duration: Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: VxConditional(
                                condition: controller
                                    .getCategoryItems(category.catId)
                                    .isNotEmpty,
                                builder: (context) => FoodCard(
                                  iconColor: Vx.hexToColor(category.colorCode),
                                  titel: category.name,
                                  servingSize: category.servingSize ?? "",
                                  items: controller
                                      .getCategoryItems(category.catId),
                                  isExpand: _searchControl.text.isNotEmpty,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: controller.filtercategories.isEmpty
                          ? controller.categories.length
                          : controller.filtercategories.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
