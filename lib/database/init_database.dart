import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class InitDb {
  static Future initialize() async {
    await _initSembast();
  }

  static Future _initSembast() async {
    // gets applicationDocumentDirectory
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);

    //creates a database path as ../art_manager.db
    final databasePath = join(appDir.path, "art_manager.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);

    //register instancer of Database for future use
    GetIt.I.registerSingleton<Database>(database);
  }
}
