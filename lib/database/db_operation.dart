import 'package:art_manager/models/art.dart';

abstract class DbOperation {
  Future add(Art art);
  Future<List<dynamic>> getAll();
}
