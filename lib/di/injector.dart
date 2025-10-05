import 'package:get_it/get_it.dart';
import '../features/product/data/datasource/remote/product_datasource.dart';
import '../features/product/data/datasource/remote/product_datasource_impl.dart';
import '../features/product/data/repositories/product_repo_impl.dart';
import '../features/product/domain/repositories/product_repo.dart';
import '../features/product/domain/usecases/get_product_usecase.dart';
import '../shared/remote/network_base_services.dart';
import '../shared/remote/network_services.dart';

final injector = GetIt.instance;

Future<void> initSingletons() async {
  //Services
  injector.registerLazySingleton<NetWorkBaseServices>(() => NetworkServices());
}

void provideDataSources() {
  //product
  injector.registerFactory<ProductDatasource>(
    () => ProductDatasourceImpl(
      netWorkBaseServices: injector.get<NetWorkBaseServices>(),
    ),
  );
}

void provideRepositories() {
  //product
  injector.registerFactory<ProductRepo>(
    () => ProductRepoImpl(productDatasource: injector.get<ProductDatasource>()),
  );
}

void provideUseCases() {
  //product
  injector.registerFactory<GetProductUsecase>(
    () => GetProductUsecase(productRepo: injector.get<ProductRepo>()),
  );
}
