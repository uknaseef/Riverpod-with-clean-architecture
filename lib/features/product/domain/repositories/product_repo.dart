import 'package:either_dart/either.dart';
import '../../../../models/product_model.dart';
import '../../../../shared/remote/network_base_services.dart';

abstract class ProductRepo {
  Future<Either<ResponseError, ProductsModel?>> getProducts();
}