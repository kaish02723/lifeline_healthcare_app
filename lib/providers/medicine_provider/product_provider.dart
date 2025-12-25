import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/medicine_models/medicine_product_model.dart';

class ProductProvider with ChangeNotifier {
  final String _baseUrl = "https://phone-auth-with-jwt-4.onrender.com";

  List<ProductModel> _products = [];
  Category? _selectedCategory;
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;

  Category? get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchAllMedicines() async {
    try {
      _isLoading = true;
      notifyListeners();

      final res = await http.get(
        Uri.parse('$_baseUrl/medicine/getAllMedicine'),
      );

      print(res.body);
      print(res.request?.headers);

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        _products = data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        _error = "Failed to load medicines";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProductModel> get filteredProducts {
    List<ProductModel> list = _products;

    if (_selectedCategory != null) {
      list = list.where((p) => p.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list =
          list.where((p) {
            return (p.medName ?? '').toLowerCase().contains(q) ||
                (p.medBrandName ?? '').toLowerCase().contains(q);
          }).toList();
    }
    return list;
  }

  void selectCategory(Category category) {
    _selectedCategory = category;
    _searchQuery = '';
    notifyListeners();
  }

  void clearCategory() {
    _selectedCategory = null;
    notifyListeners();
  }

  void searchMedicine(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  ProductModel? getProductById(int id) {
    try {
      return _products.firstWhere((p) => p.medId == id);
    } catch (_) {
      return null;
    }
  }

  List<Category> get availableCategories {
    return _products
        .where((p) => p.category != null)
        .map((p) => p.category!)
        .toSet()
        .toList();
  }

  String? getCategoryImage(Category category) {
    try {
      return _products.firstWhere((p) => p.category == category).medImage;
    } catch (_) {
      return null;
    }
  }

  List<String> get searchHintSuggestions {
    final List<String> hints = [];

    for (final cat in Category.values) {
      hints.add(categoryValues.reverse[cat]!);
    }

    for (final p in _products.take(8)) {
      if (p.medName != null && p.medName!.isNotEmpty) {
        hints.add(p.medName!);
      }
    }

    return hints;
  }

  void resetFilters() {
    _selectedCategory = null;
    _searchQuery = '';
    notifyListeners();
  }

  double price(ProductModel p) {
    return double.tryParse(p.medPrice.toString()) ?? 0.0;
  }

  double rating(ProductModel p) {
    return double.tryParse(p.medRating.toString()) ?? 0.0;
  }

  double discount(ProductModel p) {
    return double.tryParse(p.medDiscountPercentage.toString()) ?? 0.0;
  }

  //viewed product
  static const String _viewedProductsKey = "viewed_products";
  static const int _maxViewedProducts = 10;

  List<int> _viewedProductIds = [];

  List<int> get viewedProductIds => _viewedProductIds;

  List<ProductModel> get viewedProducts {
    return _viewedProductIds
        .map((id) => getProductById(id))
        .where((p) => p != null)
        .cast<ProductModel>()
        .toList();
  }

  //load recent product
  Future<void> loadViewedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    _viewedProductIds =
        prefs.getStringList(_viewedProductsKey)?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  Future<void> addViewedProduct(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    _viewedProductIds.remove(productId);
    _viewedProductIds.insert(0, productId);

    if (_viewedProductIds.length > _maxViewedProducts) {
      _viewedProductIds = _viewedProductIds.take(_maxViewedProducts).toList();
    }

    await prefs.setStringList(
      _viewedProductsKey,
      _viewedProductIds.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }
}
