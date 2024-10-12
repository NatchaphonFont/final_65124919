import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Database',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    // Initialize the database
    _database = await openDatabase(
      join(await getDatabasesPath(), 'plant_database.db'),
      onCreate: (db, version) async {
        // Create tables
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

        // Insert initial data
        await _insertInitialData(db);
      },
      version: 1,
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Database'),
      ),
      body: Center(
        child: Text('Database initialized with sample data!'),
      ),
    );
  }
}
