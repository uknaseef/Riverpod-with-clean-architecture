import 'package:either_dart/either.dart';
import '../../../../models/product_model.dart';
import '../../../../shared/remote/network_base_services.dart';
import '../../domain/repositories/product_repo.dart';
import '../datasource/remote/product_datasource.dart';

class ProductRepoImpl implements ProductRepo {
  ProductDatasource productDatasource;
  ProductRepoImpl({required this.productDatasource});

  @override
  Future<Either<ResponseError, ProductsModel?>> getProducts() {
    return productDatasource.getProducts();
  }
}
