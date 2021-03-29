import 'package:flutter/material.dart';
import 'package:food/src/presentation/food/controller/food.dart';
import 'package:food/src/presentation/home/controller/home.dart';
import 'package:food/src/presentation/home/ui/home.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => FoodController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}
