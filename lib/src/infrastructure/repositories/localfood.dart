import 'package:food/src/infrastructure/models/category.dart';
import 'package:food/src/infrastructure/models/food.dart';
import 'package:food/src/infrastructure/models/item.dart';
import 'package:food/src/infrastructure/models/subcategory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  //start variables
  final String categoryTable = "TBL_Category";
  final String subCategoryTable = "TBL_Sub_Category";
  final String itemTable = "TBL_Item";
  //end variable
  static Database _db;
  //initialize db
  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'food.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  _onCreate(Database db, int version) async {
    //create category
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $categoryTable(
        catId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        colorCode TEXT,
        servingSize TEXT
      )
    ''').then((_) {}).catchError((onError) {
          print(onError);
        });
    //create sub category
    await db.execute('''
       CREATE TABLE IF NOT EXISTS $subCategoryTable(
        subCatId INTEGER PRIMARY KEY AUTOINCREMENT,
        subCategoryname TEXT,
        catId INTEGER
      )
      ''').catchError((onError) {});
    //create item
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $itemTable(
        itemId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        subCatId INTEGER
      )
    ''').catchError((onError) {
      print(onError);
    });
  }

  Future<void> syncData(FoodModel model) async {
    try {
      for (var food in model.categories) {
        var catId = await saveCategories(food.category);
        if (catId != 0) {
          for (var subCat in food.category.subcategories) {
            var subCatId = await saveSubCategories(subCat, catId);
            if (subCatId != 0) {
              for (var item in subCat.items) {
                await saveitems(item, subCatId);
              }
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int> saveCategories(CategoryCategory category) async {
    int result = 0;
    try {
      var dbClient = await db;
      var noOfInsert = await dbClient.insert(categoryTable, {
        "name": category.categoryName,
        "colorCode": category.colorCode,
        "servingSize": category.servingSize,
      });
      if (noOfInsert != 0) {
        List<Map<String, dynamic>> queryResult =
            await dbClient.rawQuery("SELECT last_insert_rowid() as last");
        result = queryResult.first["last"];
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<int> saveSubCategories(Subcategory subcategory, int catId) async {
    int result = 0;
    try {
      var dbClient = await db;
      var noOfInsert = await dbClient.insert(subCategoryTable, {
        "subCategoryname": subcategory.subCategoryname,
        "catId": catId,
      });
      if (noOfInsert != 0) {
        List<Map<String, dynamic>> queryResult =
            await dbClient.rawQuery("SELECT last_insert_rowid() as last");
        result = queryResult.first["last"];
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<int> saveitems(String name, int subCatId) async {
    int result = 0;
    try {
      var dbClient = await db;
      var noOfInsert = await dbClient.insert(itemTable, {
        "name": name,
        "subCatId": subCatId,
      });
      if (noOfInsert != 0) {
        List<Map<String, dynamic>> queryResult =
            await dbClient.rawQuery("SELECT last_insert_rowid() as last");
        result = queryResult.first["last"];
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<List<LocalCategory>> getCategories() async {
    List<LocalCategory> _categories = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> categoryMap =
          await dbClient.query(categoryTable);
      categoryMap.forEach((e) => _categories.add(LocalCategory.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _categories;
  }

  Future<List<LocalCategory>> getCategoriesById(List<int> catId) async {
    List<LocalCategory> _categories = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> categoryMap = await dbClient.query(
        categoryTable,
        where: 'catId',
        whereArgs: catId,
      );
      categoryMap.forEach((e) => _categories.add(LocalCategory.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _categories;
  }

  Future<List<LocalSubCategory>> getSubCategories(int catId) async {
    List<LocalSubCategory> _subCategories = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> subCategoryMap = await dbClient.query(
        subCategoryTable,
        where: 'catId',
        whereArgs: [catId],
      );
      subCategoryMap
          .forEach((e) => _subCategories.add(LocalSubCategory.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _subCategories;
  }

  Future<List<LocalSubCategory>> getSubCategoriesById(
      List<int> subCatId) async {
    List<LocalSubCategory> _subCategories = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> subCategoryMap = await dbClient.query(
        subCategoryTable,
        where: 'subCatId',
        whereArgs: subCatId,
      );
      subCategoryMap
          .forEach((e) => _subCategories.add(LocalSubCategory.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _subCategories;
  }

  Future<List<LocalSubCategory>> getAllSubCategories() async {
    List<LocalSubCategory> _subCategories = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> subCategoryMap = await dbClient.query(
        subCategoryTable,
      );
      subCategoryMap
          .forEach((e) => _subCategories.add(LocalSubCategory.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _subCategories;
  }

  Future<List<LocalItem>> getItems(int subCatId) async {
    List<LocalItem> _items = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> itemMap = await dbClient.query(
        itemTable,
        where: 'subCatId',
        whereArgs: [subCatId],
      );
      itemMap.forEach((e) => _items.add(LocalItem.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _items;
  }

  Future<List<LocalItem>> getAllItems() async {
    List<LocalItem> _items = [];
    try {
      var dbClient = await db;
      List<Map<String, dynamic>> itemMap = await dbClient.query(itemTable);
      itemMap.forEach((e) => _items.add(LocalItem.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _items;
  }

  Future<List<LocalItem>> searchItem(String text) async {
    List<LocalItem> _items = [];
    try {
      var dbClient = await db;
      String query = '''
          select * from TBL_Item WHERE name LIKE '%$text%'
      ''';
      List<Map<String, dynamic>> itemMap = await dbClient.rawQuery(query);
      itemMap.forEach((e) => _items.add(LocalItem.fromMap(e)));
    } catch (e) {
      print(e);
    }
    return _items;
  }
}
