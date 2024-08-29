abstract class CRUD {
  Future<bool> insert({
    required String tableName,
    required Map<String, Object?> values,
  });

  Future<bool> update({
    required String tableName,
    required String where,
    required Map<String, Object?> values,
  });

  Future<bool> delete({
    required String tableName,
    required String where,
  });

  Future<List<Map<String, Object?>>> select({
    required String tableName,
  });
}
