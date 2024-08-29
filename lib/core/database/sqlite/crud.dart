abstract class CRUD{
  Future<int> insert();
  Future<int> update();
  Future<int> delete();
  Future<int> select();
}