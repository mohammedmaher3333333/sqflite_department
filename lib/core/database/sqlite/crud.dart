abstract class CRUD{
  Future<bool> insert();
  Future<bool> update();
  Future<bool> delete();
  Future<bool> select();
}