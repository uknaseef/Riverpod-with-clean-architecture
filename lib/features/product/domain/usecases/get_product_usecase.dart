import 'package:either_dart/either.dart';
import '../../../../models/product_model.dart';
import '../../../../shared/remote/network_base_services.dart';
import '../repositories/product_repo.dart';

class GetProductUsecase {
  final ProductRepo productRepo;
  GetProductUsecase({required this.productRepo});

  Future<Either<ResponseError, ProductsModel?>> call() {
    return productRepo.getProducts();
  }
}
