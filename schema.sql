-- Represent customers purchasing the products
CREATE TABLE "customer" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "age" INTEGER,
    "gender" TEXT CHECK ("gender" IN ('Male', 'Female')),
    "education" TEXT NOT NULL,
    "marital_status" TEXT CHECK("marital_status" IN ('Single', 'Partnered')),
    "income" INTEGER NOT NULL
);

-- Represent weekly goals customers planned
CREATE TABLE "weekly_goal" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "customer_id" INTEGER,
    "weekly_usage" INTEGER NOT NULL,
    "miles" INTEGER NOT NULL,
    FOREIGN KEY("customer_id") REFERENCES "customer"("id")
);

-- Represent products at Aerofit
CREATE TABLE "product" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    "cost" INTEGER NOT NULL
);

-- Represent individual fitness profiles left of customers
CREATE TABLE "fitness_profile" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "customer_id" INTEGER NOT NULL,
    "fitness_level" INTEGER NOT NULL,
    FOREIGN KEY("customer_id") REFERENCES "customer"("id")
);

-- Represent purchases of products by customers
CREATE TABLE "purchase" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "customer_id" INTEGER,
    "product_id" INTEGER,
    FOREIGN KEY("customer_id") REFERENCES "customer"("id"),
    FOREIGN KEY("product_id") REFERENCES "product"("id")
);

CREATE INDEX "weekly_goal_index" ON "weekly_goal" ("customer_id");
CREATE INDEX "fitness_profile_index" ON "fitness_profile" ("customer_id");
CREATE INDEX "purchase_index" ON "purchase" ("id");

CREATE VIEW "revenue" AS
SELECT "purchase"."customer_id", "product"."cost" FROM "customer" JOIN "purchase"
ON "customer"."id" = "purchase"."customer_id"
JOIN "product"
ON "product"."id" = "purchase"."product_id";
