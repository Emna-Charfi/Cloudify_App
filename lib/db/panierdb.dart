import 'package:cloudify_application/model/panier.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PanierDatabase {
  static final PanierDatabase instance = PanierDatabase._init();

  static Database? _database;

  PanierDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('paniers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePaniers ( 
  ${PanierFields.id} $idType, 
  ${PanierFields.idGame} $textType,
  ${PanierFields.prix} $integerType
  )
''');
  }

  Future<Panier> create(Panier panier) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tablePaniers, panier.toJson());
    return panier.copy(id: id);
  }

  Future<Panier> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePaniers,
      columns: PanierFields.values,
      where: '${PanierFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Panier.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Panier>> readAllPaniers() async {
    final db = await instance.database;

    //final orderBy = '${PanierFields.} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablePaniers);

    return result.map((json) => Panier.fromJson(json)).toList();
  }

  Future<int> update(Panier panier) async {
    final db = await instance.database;

    return db.update(
      tablePaniers,
      panier.toJson(),
      where: '${PanierFields.id} = ?',
      whereArgs: [panier.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePaniers,
      where: '${PanierFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
