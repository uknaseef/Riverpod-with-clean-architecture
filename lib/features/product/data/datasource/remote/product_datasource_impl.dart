import 'package:either_dart/either.dart';
import '../../../../../app/app_constants.dart';
import '../../../../../models/product_model.dart';
import '../../../../../shared/remote/network_base_services.dart';
import 'product_datasource.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final NetWorkBaseServices netWorkBaseServices;
  ProductDatasourceImpl({required this.netWorkBaseServices});
  @override
  Future<Either<ResponseError, ProductsModel?>> getProducts() {
    return netWorkBaseServices
        .safe(netWorkBaseServices.getRequest(endPoint: AppConstants.products))
        .thenRight(netWorkBaseServices.checkHttpStatus)
        .thenRight(netWorkBaseServices.parseJson)
        .mapRight((right) => ProductsModel.fromJson(right));
  }
}
