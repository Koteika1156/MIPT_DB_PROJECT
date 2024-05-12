CREATE TABLE Employees (
    EmployeeID BIGSERIAL NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL CHECK(LENGTH(FirstName) >= 1),
    LastName VARCHAR(50) NOT NULL CHECK(LENGTH(LastName) >= 1),
    Position VARCHAR(50) NOT NULL CHECK(LENGTH(Position) >= 1),
    StartDate DATE NOT NULL,
    EndDate DATE
);

CREATE TABLE Materials_in_stock (
    MaterialID BIGSERIAL NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK(LENGTH(Name) >= 1),
    Weight FLOAT NOT NULL CHECK(Weight >= 0)
);

CREATE TABLE Parts (
    PartID BIGSERIAL NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK(LENGTH(Name) >= 1),
    Type VARCHAR(50) NOT NULL CHECK(LENGTH(Type) >= 1),
    MaterialID BIGINT NOT NULL CHECK(MaterialID >= 1),
    Weight FLOAT NOT NULL CHECK(Weight > 0)
);

CREATE TABLE Goods_in_stock (
    StockProductID BIGSERIAL NOT NULL PRIMARY KEY,
    PartID BIGINT NOT NULL CHECK(PartID >= 1),
    Quantity INT NOT NULL CHECK(Quantity >= 0)
);

CREATE TABLE Machines (
    MachineID BIGSERIAL NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK(LENGTH(Name) >= 1),
    Type VARCHAR(50) NOT NULL CHECK(LENGTH(Type) >= 1),
    CommissionDate DATE NOT NULL,
    DecommissionDate DATE
);

CREATE TABLE Production (
    ProductionID BIGSERIAL NOT NULL PRIMARY KEY,
    MachineID BIGINT NOT NULL CHECK(MachineID >= 0),
    PartID BIGINT NOT NULL CHECK(PartID >= 0),
    EmployeeID BIGINT NOT NULL CHECK(EmployeeID >= 0),
    Quantity INT NOT NULL CHECK(Quantity >= 0),
    Date DATE NOT NULL
);

CREATE TABLE Recipient  (
    RecipientID BIGSERIAL NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL CHECK(LENGTH(Name) >= 1),
    Address VARCHAR(100) NOT NULL CHECK(LENGTH(Address) >= 1),
    ContactPerson VARCHAR(50) NOT NULL CHECK(LENGTH(ContactPerson) >= 1),
    Phone VARCHAR(15) NOT NULL CHECK(LENGTH(Phone) >= 1)
);

CREATE TABLE Deliveries (
    DeliveryID BIGSERIAL NOT NULL PRIMARY KEY,
    RecipientID BIGINT NOT NULL CHECK(RecipientID >= 0),
    PartID BIGINT NOT NULL CHECK(PartID >= 0),
    Quantity BIGINT NOT NULL CHECK(Quantity >= 0),
    Date DATE NOT NULL
);

CREATE TABLE Materials_delivery (
    MDID BIGSERIAL NOT NULL PRIMARY KEY,
    MaterialID BIGINT NOT NULL CHECK(MaterialID >= 0),
    Weight FLOAT NOT NULL CHECK(Weight >= 0),
    Date DATE NOT NULL
);

