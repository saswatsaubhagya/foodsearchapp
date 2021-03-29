import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:food/src/core/constraints.dart';
import 'package:food/src/presentation/food/ui/food.dart';
import 'package:food/src/presentation/home/controller/home.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget navigatorCard() {
    return OpenContainer(
      closedBuilder: (context, openContainer) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            "View Food List".text.make(),
            10.heightBox,
            Icon(Icons.arrow_forward_ios)
          ],
        ).box.roundedFull.p12.make();
      },
      openColor: Colors.white,
      closedElevation: 10.0,
      transitionDuration: Duration(milliseconds: 500),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      closedColor: Colors.white,
      openShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      openBuilder: (_, closeContainer) {
        return FoodListScreen(
          back: closeContainer,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<HomeController>().getFoodData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Consumer<HomeController>(
            builder: (context, value, _) => value.appState == AppState.Busy
                ? CircularProgressIndicator()
                : navigatorCard(),
          ),
        ),
      ),
    );
  }
}
