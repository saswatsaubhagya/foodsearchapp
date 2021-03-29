import 'package:dartz/dartz.dart';
import 'package:food/src/core/services/api_service.dart';
import 'package:food/src/infrastructure/models/api_error.dart';
import 'package:food/src/infrastructure/models/food.dart';

abstract class FoodRepository {
  Future<Either<ApiError, FoodModel>> getFoodData();
}

class FoodImplementation implements FoodRepository {
  final ApiService _apiService = new ApiService();

  @override
  Future<Either<ApiError, FoodModel>> getFoodData() async {
    FoodModel _data = new FoodModel();
    try {
      var responce = await (await _apiService.getDioClient()).get(
        ApiService.foodData,
      );
      if (responce.statusCode == 200) {
        _data = FoodModel.fromJson(responce.data);
        return Right(_data);
      } else {
        return Left(ApiError(
            error: "Something went wrong", errorCode: responce.statusCode));
      }
    } catch (e) {
      print(e);
      return Left(ApiError(error: "Something went wrong", errorCode: 0));
    }
  }
}
