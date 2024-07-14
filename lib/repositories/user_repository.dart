import 'package:dartz/dartz.dart';
import '../apiModels/ProductModel.dart';
import '../core/api/api_consumer.dart';
import '../core/api/end_ponits.dart';
import '../core/errors/exceptions.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});

  Future<Either<String, List<Products>>> getProducts() async {
    try {
      final response = await api.get(EndPoint.products);
      if (response is Map<String, dynamic>) {
        List<dynamic> parsedList = response['products'] as List<dynamic>;
        List<Products> productsList =
            parsedList.map((json) => Products.fromJson(json)).toList();
        return Right(productsList);
      } else {
        return Left('Unexpected response type');
      }
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
