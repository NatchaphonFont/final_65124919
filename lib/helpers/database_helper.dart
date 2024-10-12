import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plant_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plant (
        plantID INTEGER PRIMARY KEY,
        plantName TEXT,
        plantScientific TEXT,
        plantImage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE plantComponent (
        componentID INTEGER PRIMARY KEY,
        componentName TEXT,
        componentIcon TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE LandUseType (
        LandUseTypeID INTEGER PRIMARY KEY,
        LandUseTypeName TEXT,
        LandUseTypeDescription TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE LandUse (
        LandUseID INTEGER PRIMARY KEY,
        plantID INTEGER,
        componentID INTEGER,
        LandUseTypeID INTEGER,
        LandUseDescription TEXT,
        FOREIGN KEY (plantID) REFERENCES plant(plantID),
        FOREIGN KEY (componentID) REFERENCES plantComponent(componentID),
        FOREIGN KEY (LandUseTypeID) REFERENCES LandUseType(LandUseTypeID)
      )
    ''');

    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Insert data into plant table
    await db.insert('plant', {
      'plantID': 1001,
      'plantName': 'Mango',
      'plantScientific': 'Mangifera indica',
      'plantImage': 'mango.jpg',
    });

    await db.insert('plant', {
      'plantID': 1002,
      'plantName': 'Neem',
      'plantScientific': 'Azadirachta indica',
      'plantImage': 'neem.jpg',
    });

    await db.insert('plant', {
      'plantID': 1003,
      'plantName': 'Bamboo',
      'plantScientific': 'Bambusa vulgaris',
      'plantImage': 'bamboo.jpg',
    });

    await db.insert('plant', {
      'plantID': 1004,
      'plantName': 'Ginger',
      'plantScientific': 'Zingiber officinale',
      'plantImage': 'ginger.jpg',
    });

    // Insert data into plantComponent table
    await db.insert('plantComponent', {
      'componentID': 1101,
      'componentName': 'Leaf',
      'componentIcon': 'leaf_icon.png',
    });

    await db.insert('plantComponent', {
      'componentID': 1102,
      'componentName': 'Flower',
      'componentIcon': 'flower_icon.png',
    });

    await db.insert('plantComponent', {
      'componentID': 1103,
      'componentName': 'Fruit',
      'componentIcon': 'fruit_icon.png',
    });

    await db.insert('plantComponent', {
      'componentID': 1104,
      'componentName': 'Stem',
      'componentIcon': 'stem_icon.png',
    });

    await db.insert('plantComponent', {
      'componentID': 1105,
      'componentName': 'Root',
      'componentIcon': 'root_icon.png',
    });

    // Insert data into LandUseType table
    await db.insert('LandUseType', {
      'LandUseTypeID': 1301,
      'LandUseTypeName': 'Food',
      'LandUseTypeDescription': 'Used as food or ingredients',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 1302,
      'LandUseTypeName': 'Medicine',
      'LandUseTypeDescription': 'Used for medicinal purposes',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 1303,
      'LandUseTypeName': 'Insecticide',
      'LandUseTypeDescription': 'Used to repel insects',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 1304,
      'LandUseTypeName': 'Construction',
      'LandUseTypeDescription': 'Used in building materials',
    });

    await db.insert('LandUseType', {
      'LandUseTypeID': 1305,
      'LandUseTypeName': 'Culture',
      'LandUseTypeDescription': 'Used in traditional practices',
    });

    // Insert data into LandUse table
    await db.insert('LandUse', {
      'LandUseID': 2001,
      'plantID': 1001,
      'componentID': 1103,
      'LandUseTypeID': 1301,
      'LandUseDescription': 'Mango fruit is eaten fresh or dried',
    });

    await db.insert('LandUse', {
      'LandUseID': 2002,
      'plantID': 1002,
      'componentID': 1101,
      'LandUseTypeID': 1302,
      'LandUseDescription': 'Neem leaves are used to treat skin infections',
    });

    await db.insert('LandUse', {
      'LandUseID': 2003,
      'plantID': 1003,
      'componentID': 1104,
      'LandUseTypeID': 1304,
      'LandUseDescription': 'Bamboo stems are used in building houses',
    });

    await db.insert('LandUse', {
      'LandUseID': 2004,
      'plantID': 1004,
      'componentID': 1105,
      'LandUseTypeID': 1302,
      'LandUseDescription': 'Ginger roots are used for digestive issues',
    });
  }

  Future<void> insertPlant(Map<String, dynamic> plantData) async {
    final db = await instance.database;
    await db.insert('plant', plantData);
  }

  // Add other helper methods for CRUD operations
}
