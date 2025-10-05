import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/product_notifier_provider.dart';
import '../provider/state/product_state.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
  const ProductListingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(productNotifierProvider.notifier).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkNotifier = ref.watch(productNotifierProvider);
    return Scaffold(
      body: bookmarkNotifier.state == ProductConcreteState.loaded
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: bookmarkNotifier.products.length,
              itemBuilder: (context, index) {
                return Text(
                  bookmarkNotifier.products[index].title ?? 'No Name',
                );
              },
            )
          : bookmarkNotifier.state == ProductConcreteState.loading
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: Text('No Bookmarks')),
    );
  }
}
