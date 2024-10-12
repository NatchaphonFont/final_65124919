CREATE TABLE plant (
  plantID INTEGER PRIMARY KEY,
  plantName TEXT,
  plantScientific TEXT,
  plantImage TEXT
);

CREATE TABLE plantComponent (
  componentID INTEGER PRIMARY KEY,
  componentName TEXT,
  componentIcon TEXT
);

CREATE TABLE LandUseType (
  LandUseTypeID INTEGER PRIMARY KEY,
  LandUseTypeName TEXT,
  LandUseTypeDescription TEXT
);

CREATE TABLE LandUse (
  LandUseID INTEGER PRIMARY KEY,
  plantID INTEGER,
  componentID INTEGER,
  LandUseTypeID INTEGER,
  LandUseDescription TEXT,
  FOREIGN KEY (plantID) REFERENCES plant(plantID),
  FOREIGN KEY (componentID) REFERENCES plantComponent(componentID),
  FOREIGN KEY (LandUseTypeID) REFERENCES LandUseType(LandUseTypeID)
);
