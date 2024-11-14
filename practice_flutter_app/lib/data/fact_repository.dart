import 'package:practice_flutter_app/data/http_api.dart';
import 'package:practice_flutter_app/data/model.dart';

abstract class FactRepository {
  Future<Fact> getRandomFact();
  Future<Fact> getRandomFactByCategory(String category);
  Future<Fact> newFact(Fact fact);
  Future<Fact> like(int id);
  Future<Fact> dislike(int id);
}

class HttpFactRepository implements FactRepository {
  final HttpApi _api;

  HttpFactRepository(this._api);

  @override
  Future<Fact> getRandomFact() async {
    return await _api.getRandomFact();
  }

  @override
  Future<Fact> getRandomFactByCategory(String category) async {
    return await _api.getRandomFactByCategory(category);
  }

  @override
  Future<Fact> newFact(Fact fact) async {
    return await _api.newFact(fact);
  }

  @override
  Future<Fact> like(int id) async {
    return await _api.like(id);
  }

  @override
  Future<Fact> dislike(int id) async {
    return await _api.dislike(id);
  }
}

class FactRepositoryProvider {
  static HttpFactRepository? _instance;

  static HttpFactRepository get instance {
    _instance ??= HttpFactRepository(HttpApi());
    return _instance!;
  }

  static void dispose() {
    _instance = null;
  }
}