import 'package:flutter_riverpod/legacy.dart';
import 'state/product_notifier.dart';
import 'state/product_state.dart';

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      return ProductNotifier();
    });
