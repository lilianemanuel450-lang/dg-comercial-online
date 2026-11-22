import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/product.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';
import '../product/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Product> _results = [];
  bool _searched = false;

  void _runSearch(String query) {
    setState(() {
      _searched = query.trim().isNotEmpty;
      _results = MockData.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Pesquisar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(controller: _controller, onSubmitted: _runSearch),
            const SizedBox(height: 16),
            if (_searched)
              Text('Resultados para "${_controller.text}"',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 12),
            Expanded(
              child: !_searched
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final term in ['fone', 'tênis', 'smartwatch', 'notebook', 'perfume'])
                          ActionChip(
                            label: Text(term),
                            backgroundColor: AppColors.surface,
                            onPressed: () {
                              _controller.text = term;
                              _runSearch(term);
                            },
                          ),
                      ],
                    )
                  : _results.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'Nenhum resultado encontrado',
                          message: 'Tente pesquisar por outro termo.',
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 258,
                          ),
                          itemCount: _results.length,
                          itemBuilder: (context, i) {
                            final p = _results[i];
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
      ),
    );
  }
}
