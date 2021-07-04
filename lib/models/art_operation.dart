import 'package:art_manager/database/db_operation.dart';
import 'package:art_manager/models/art.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

class ArtOperation extends DbOperation {
  final Database _db = GetIt.I.get();
  StoreRef _store = intMapStoreFactory.store('art_store');

  //get art data to the db
  @override
  Future add(Art art) async {
    var result = await _store.add(_db, art.toMap());
    return result;
  }

  //get all arts data from db
  @override
  Future<List> getAll() async {
    final snapshots = await _store.find(_db);
    return snapshots
        .map((snapshot) => Art.fromMap(snapshot.key, snapshot.value))
        .toList();
  }
}
