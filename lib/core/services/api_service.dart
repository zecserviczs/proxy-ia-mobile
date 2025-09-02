import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  static const String baseUrl = 'http://localhost:8080';

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Interceptor pour les logs
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;

  // Méthodes pour les produits
  Future<Response> getProducts() async {
    return await _dio.get('/api/products');
  }

  Future<Response> getProduct(int id) async {
    return await _dio.get('/api/products/$id');
  }

  Future<Response> createProduct(Map<String, dynamic> product) async {
    return await _dio.post('/api/products', data: product);
  }

  Future<Response> updateProduct(int id, Map<String, dynamic> product) async {
    return await _dio.put('/api/products/$id', data: product);
  }

  Future<Response> deleteProduct(int id) async {
    return await _dio.delete('/api/products/$id');
  }

  // Méthodes pour l'inventaire
  Future<Response> getInventory() async {
    return await _dio.get('/api/inventory');
  }

  Future<Response> updateInventory(int id, Map<String, dynamic> inventory) async {
    return await _dio.put('/api/inventory/$id', data: inventory);
  }

  // Méthodes pour les ventes
  Future<Response> getSales() async {
    return await _dio.get('/api/sales');
  }

  Future<Response> getSalesReport() async {
    return await _dio.get('/api/sales/report');
  }

  // Méthodes pour les commandes
  Future<Response> getOrders() async {
    return await _dio.get('/api/orders');
  }

  Future<Response> getOrder(int id) async {
    return await _dio.get('/api/orders/$id');
  }

  Future<Response> updateOrderStatus(int id, String status) async {
    return await _dio.put('/api/orders/$id/status', data: {'status': status});
  }

  // Méthodes pour la tarification
  Future<Response> getPricing() async {
    return await _dio.get('/api/pricing');
  }

  Future<Response> updatePricing(int id, Map<String, dynamic> pricing) async {
    return await _dio.put('/api/pricing/$id', data: pricing);
  }

  // Méthodes pour le dashboard
  Future<Response> getDashboardStats() async {
    return await _dio.get('/api/dashboard/stats');
  }

  Future<Response> getAnalytics() async {
    return await _dio.get('/api/analytics');
  }

  // Méthode de test de connexion
  Future<Response> testConnection() async {
    return await _dio.get('/api/health');
  }
}