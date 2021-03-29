import 'package:dartz/dartz.dart';
import 'package:food/src/core/constraints.dart';
import 'package:food/src/infrastructure/models/api_error.dart';
import 'package:food/src/infrastructure/models/food.dart';
import 'package:food/src/infrastructure/repositories/food.dart';
import 'package:food/src/infrastructure/repositories/localfood.dart';
import 'package:food/src/presentation/shared/controller/base.dart';

class HomeController extends BaseController {
  Future<void> getFoodData() async {
    try {
      setAppState(AppState.Busy);
      var categories = await LocalDB().getCategories();
      if (categories.isEmpty) {
        Either<ApiError, FoodModel> _foodResponse =
            await FoodImplementation().getFoodData();
        _foodResponse.fold(
          (error) => showToast(error.error),
          (data) async {
            await LocalDB().syncData(data);
          },
        );
      }
      setAppState(AppState.Idle);
    } catch (e) {
      print(e);
      setAppState(AppState.Idle);
    }
  }
}
