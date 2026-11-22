import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';

class MockData {
  MockData._();

  static const List<ProductCategory> categories = [
    ProductCategory(id: 'eletronicos', name: 'Eletrônicos', icon: Icons.devices_other, productsCount: 120),
    ProductCategory(id: 'celulares', name: 'Celulares', icon: Icons.smartphone, productsCount: 95),
    ProductCategory(id: 'informatica', name: 'Informática', icon: Icons.laptop_mac, productsCount: 78),
    ProductCategory(id: 'casa', name: 'Casa e Cozinha', icon: Icons.kitchen, productsCount: 60),
    ProductCategory(id: 'beleza', name: 'Beleza e Saúde', icon: Icons.spa, productsCount: 45),
    ProductCategory(id: 'moda', name: 'Moda', icon: Icons.checkroom, productsCount: 85),
    ProductCategory(id: 'esportes', name: 'Esportes', icon: Icons.sports_soccer, productsCount: 70),
    ProductCategory(id: 'brinquedos', name: 'Brinquedos', icon: Icons.toys, productsCount: 50),
  ];

  static const List<Product> products = [
    Product(
      id: 'p1',
      name: 'Fone Bluetooth Premium',
      description:
          'Som de alta qualidade, bateria de longa duração e conexão estável. Ideal para uso diário, chamadas e treino.',
      price: 49990.0,
      promotionalPrice: 44990.0,
      stock: 24,
      categoryId: 'eletronicos',
      icon: 'headphones',
      rating: 4.7,
      reviewsCount: 128,
      colors: ['Preto', 'Azul', 'Branco'],
    ),
    Product(
      id: 'p2',
      name: 'Tênis Esportivo',
      description: 'Leve, confortável e resistente. Perfeito para corrida e uso casual do dia a dia.',
      price: 74990.0,
      promotionalPrice: 64990.0,
      stock: 15,
      categoryId: 'esportes',
      icon: 'sneaker',
      rating: 4.5,
      reviewsCount: 87,
      colors: ['Branco', 'Preto'],
      sizes: ['38', '39', '40', '41', '42'],
    ),
    Product(
      id: 'p3',
      name: 'Smartwatch Fit',
      description: 'Monitor de saúde, notificações inteligentes e bateria de até 7 dias.',
      price: 109990.0,
      stock: 10,
      categoryId: 'eletronicos',
      icon: 'watch',
      rating: 4.6,
      reviewsCount: 54,
      colors: ['Preto', 'Rosa'],
    ),
    Product(
      id: 'p4',
      name: 'Caixa de Som Portátil',
      description: 'Som potente à prova d\'água, ideal para festas e passeios ao ar livre.',
      price: 64990.0,
      promotionalPrice: 49990.0,
      stock: 18,
      categoryId: 'eletronicos',
      icon: 'speaker',
      rating: 4.4,
      reviewsCount: 63,
    ),
    Product(
      id: 'p5',
      name: 'Smartphone Galaxy X',
      description: 'Tela grande, câmera de alta resolução e desempenho rápido para o seu dia a dia.',
      price: 449990.0,
      stock: 8,
      categoryId: 'celulares',
      icon: 'phone',
      rating: 4.8,
      reviewsCount: 210,
      colors: ['Preto', 'Prateado'],
    ),
    Product(
      id: 'p6',
      name: 'Notebook Slim 15"',
      description: 'Ideal para trabalho e estudo, leve e com ótima autonomia de bateria.',
      price: 799990.0,
      stock: 5,
      categoryId: 'informatica',
      icon: 'laptop',
      rating: 4.6,
      reviewsCount: 39,
    ),
    Product(
      id: 'p7',
      name: 'Bolsa Casual',
      description: 'Design moderno e resistente, com bastante espaço interno.',
      price: 39990.0,
      promotionalPrice: 29990.0,
      stock: 0,
      categoryId: 'moda',
      icon: 'bag',
      rating: 4.3,
      reviewsCount: 22,
      colors: ['Marrom', 'Preto'],
    ),
    Product(
      id: 'p8',
      name: 'Perfume Essence',
      description: 'Fragrância marcante e duradoura para o dia a dia.',
      price: 44990.0,
      stock: 30,
      categoryId: 'beleza',
      icon: 'perfume',
      rating: 4.5,
      reviewsCount: 41,
    ),
    Product(
      id: 'p9',
      name: 'Camiseta Básica',
      description: 'Algodão macio, corte confortável, disponível em várias cores.',
      price: 19990.0,
      stock: 50,
      categoryId: 'moda',
      icon: 'shirt',
      rating: 4.2,
      reviewsCount: 18,
      colors: ['Branco', 'Preto', 'Cinza'],
      sizes: ['P', 'M', 'G', 'GG'],
    ),
    Product(
      id: 'p10',
      name: 'Liquidificador Turbo',
      description: 'Motor potente com várias velocidades, ideal para o dia a dia da cozinha.',
      price: 59990.0,
      promotionalPrice: 49990.0,
      stock: 12,
      categoryId: 'casa',
      icon: 'blender',
      rating: 4.4,
      reviewsCount: 33,
    ),
  ];

  static List<Product> productsByCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();

  static List<Product> search(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return [];
    return products.where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q) ||
          categories.firstWhere((c) => c.id == p.categoryId).name.toLowerCase().contains(q);
    }).toList();
  }

  static List<Product> get featured => products.take(6).toList();
}
