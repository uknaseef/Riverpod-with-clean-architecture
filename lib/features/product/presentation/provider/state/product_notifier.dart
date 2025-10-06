import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_clean/di/injector.dart';
import 'package:riverpod_clean/features/product/domain/usecases/get_product_usecase.dart';
import 'package:riverpod_clean/features/product/presentation/provider/state/product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final GetProductUsecase getProductUsecase = injector.get<GetProductUsecase>();
  ProductNotifier() : super(const ProductState.initial());
  Future<void> fetchProducts() async {
    state = state.copyWith(
      state: ProductConcreteState.loading,
      isLoading: true,
    );
    final result = await getProductUsecase();
    result.fold(
      (failure) {
        state = state.copyWith(
          state: ProductConcreteState.failure,
          message: failure.message,
          isLoading: false,
        );
      },
      (data) {
        if (data != null && (data.products?.isNotEmpty ?? false)) {
          state = state.copyWith(
            state: ProductConcreteState.loaded,
            products: data.products,
            searchListproducts: data.products,
            hasData: true,
            isLoading: false,
          );
        } else {
          state = state.copyWith(
            state: ProductConcreteState.loaded,
            message: 'No Data',
            hasData: false,
            isLoading: false,
          );
        }
      },
    );
  }

  void searchProducts(String query) {
    if (query.isNotEmpty) {
      final filteredProducts = (state.products).where((product) {
        final title = product.title?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery);
      }).toList();

      state = state.copyWith(searchListproducts: filteredProducts);
    } else {
      state = state.copyWith(
        products: state.products,
        searchListproducts: state.products,
        hasData: true,
      );
    }
  }
}
