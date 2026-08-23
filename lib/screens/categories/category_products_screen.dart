import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/product.dart';
import '../../theme/app_colors.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';
import '../product/product_details_screen.dart';

enum _SortOption { relevancia, menorPreco, maiorPreco, melhorAvaliacao }

class CategoryProductsScreen extends StatefulWidget {
  final String? categoryId;
  final String title;
  final List<Product>? productsOverride;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.title,
    this.productsOverride,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  _SortOption _sort = _SortOption.relevancia;
  double _minPrice = 0;
  double _maxPrice = 2000;
  double _minRating = 0;

  List<Product> get _baseList =>
      widget.productsOverride ?? MockData.productsByCategory(widget.categoryId ?? '');

  List<Product> get _filtered {
    var list = _baseList.where((p) {
      return p.finalPrice >= _minPrice &&
          p.finalPrice <= _maxPrice &&
          p.rating >= _minRating;
    }).toList();

    switch (_sort) {
      case _SortOption.menorPreco:
        list.sort((a, b) => a.finalPrice.compareTo(b.finalPrice));
        break;
      case _SortOption.maiorPreco:
        list.sort((a, b) => b.finalPrice.compareTo(a.finalPrice));
        break;
      case _SortOption.melhorAvaliacao:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case _SortOption.relevancia:
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final products = _filtered;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: _openFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('${products.length} produtos',
                    style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                const Spacer(),
                DropdownButton<_SortOption>(
                  value: _sort,
                  underline: const SizedBox(),
                  style: const TextStyle(color: AppColors.darkText, fontSize: 12),
                  items: const [
                    DropdownMenuItem(value: _SortOption.relevancia, child: Text('Relevância')),
                    DropdownMenuItem(value: _SortOption.menorPreco, child: Text('Menor preço')),
                    DropdownMenuItem(value: _SortOption.maiorPreco, child: Text('Maior preço')),
                    DropdownMenuItem(
                        value: _SortOption.melhorAvaliacao, child: Text('Melhor avaliação')),
                  ],
                  onChanged: (v) => setState(() => _sort = v ?? _SortOption.relevancia),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Nenhum produto encontrado',
                    message: 'Tente ajustar os filtros.',
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return ProductCard(
                        product: p,
                        width: double.infinity,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filtros', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 16),
                  Text('Preço: R\$ ${_minPrice.round()} - R\$ ${_maxPrice.round()}',
                      style: const TextStyle(fontSize: 13)),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 2000,
                    activeColor: AppColors.primary,
                    onChanged: (values) {
                      setModalState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text('Avaliação mínima: ${_minRating.toStringAsFixed(1)}',
                      style: const TextStyle(fontSize: 13)),
                  Slider(
                    value: _minRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    activeColor: AppColors.primary,
                    onChanged: (v) => setModalState(() => _minRating = v),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Aplicar filtros'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
