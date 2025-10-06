import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_clean/features/product/presentation/widgets/product_card.dart';
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
      appBar: AppBar(
        title: const Text('Product Listing'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => ref
                  .read(productNotifierProvider.notifier)
                  .searchProducts(query),
            ),
          ),
        ),
      ),
      body: bookmarkNotifier.state == ProductConcreteState.loaded
          ? RefreshIndicator(
            onRefresh: () => ref.read(productNotifierProvider.notifier).fetchProducts(),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.59,
              ),
              padding: const EdgeInsets.all(16.0),
                scrollDirection: Axis.vertical,
                itemCount: bookmarkNotifier.searchListproducts.length,
                itemBuilder: (context, index) {
                  final product = bookmarkNotifier.searchListproducts[index];
                  return ProductCard(
                    title: product.title ?? "",
                    description: product.description ?? "",
                    imageUrl: product.images?.first ?? "",
                    price: product.price?.toDouble() ?? 0.0,
                  );
                },
              ),
          )
          : bookmarkNotifier.state == ProductConcreteState.loading
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: Text('No Bookmarks')),
    );
  }
}
