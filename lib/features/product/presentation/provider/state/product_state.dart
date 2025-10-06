import 'package:equatable/equatable.dart';
import 'package:riverpod_clean/models/product_model.dart';

enum ProductConcreteState { initial, loading, loaded, failure }

class ProductState extends Equatable {
  final List<Product> products;
  final List<Product> searchListproducts;
  final bool hasData;
  final String message;
  final ProductConcreteState state;
  final bool isLoading;

  const ProductState({
    this.products = const [],
    this.searchListproducts = const [],
    this.hasData = false,
    this.message = '',
    this.state = ProductConcreteState.initial,
    this.isLoading = false,
  });

  const ProductState.initial({
    this.products = const [],
    this.searchListproducts = const [],
    this.hasData = false,
    this.message = '',
    this.state = ProductConcreteState.initial,
    this.isLoading = false,
  });

  ProductState copyWith({
    List<Product>? products,
    List<Product>? searchListproducts,
    bool? hasData,
    String? message,
    ProductConcreteState? state,
    bool? isLoading,
  }) {
    return ProductState(
      products: products ?? this.products,
      searchListproducts: searchListproducts ?? this.searchListproducts,
      message: message ?? this.message,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    products,
    searchListproducts,
    hasData,
    message,
    state,
    isLoading,
  ];
}
