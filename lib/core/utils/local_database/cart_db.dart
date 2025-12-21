import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'cart.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            name TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  /// INSERT
  static Future<void> insert(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(
      'cart',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// GET ALL
  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await database;
    return await db.query('cart');
  }

  /// UPDATE QTY
  static Future<void> updateQty(int productId, int qty) async {
    final db = await database;
    await db.update(
      'cart',
      {'quantity': qty},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  /// DELETE
  static Future<void> delete(int productId) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  /// CLEAR
  static Future<void> clear() async {
    final db = await database;
    await db.delete('cart');
  }
}
