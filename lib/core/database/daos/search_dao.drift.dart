// dart format width=80
// ignore_for_file: type=lint
part of 'search_dao.dart';

mixin _$SearchDaoMixin on DatabaseAccessor<LogoiDatabase> {
  SearchDaoManager get managers => SearchDaoManager(this);
}

class SearchDaoManager {
  final _$SearchDaoMixin _db;
  SearchDaoManager(this._db);
}
