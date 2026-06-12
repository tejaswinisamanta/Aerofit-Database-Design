.mode csv
.import --csv aerofit_treadmill_data.csv temp


INSERT INTO "customer" ("age", "gender", "education", "marital_status", "income")
SELECT "Age", "Gender", "Education", "MaritalStatus", "Income" FROM "temp";


INSERT INTO "weekly_goal" ("customer_id", "usage", "miles") SELECT "customer"."id", "Usage", "Miles" FROM "temp" JOIN "customer"
ON "temp"."Age" = "customer"."age"
AND "temp"."Gender" = "customer"."gender"
AND "temp"."Education" = "customer"."education"
AND "temp"."MaritalStatus" = "customer"."marital_status"
AND "temp"."Income" = "customer"."income";


INSERT INTO "fitness_profile" ("customer_id", "fitness_level")
SELECT "customer"."id", "Fitness" FROM "temp" JOIN "customer"
ON "temp"."Age" = "customer"."age"
AND "temp"."Gender" = "customer"."gender"
AND "temp"."Education" = "customer"."education"
AND "temp"."MaritalStatus" = "customer"."marital_status"
AND "temp"."Income" = "customer"."income";


INSERT INTO "product" VALUES (1, 'KP281', 'entry-level', 1500), (2, 'KP481', 'mid-level', 1750), (3, 'KP781', 'advanced', 2500);


INSERT INTO "purchase" ("customer_id", "product_id", "fitness_profile_id")
SELECT "customer"."id", "product"."id", "fitness_profile"."id" FROM "temp"

JOIN "customer"
ON "temp"."Age" = "customer"."age"
AND "temp"."Gender" = "customer"."gender"
AND "temp"."Education" = "customer"."education"
AND "temp"."MaritalStatus" = "customer"."marital_status"
AND "temp"."Income" = "customer"."income"

JOIN "product"
ON "temp"."Product" = "product"."name"

JOIN "fitness_profile"
ON "fitness_profile"."customer_id" = "customer"."id"
AND "temp"."Fitness" = "fitness_profile"."fitness_level";


-- Find fitness profiles of all customers given gender is Female and Partnered
SELECT "fitness_level" AS 'fitness_of_partnered_women'
FROM "fitness_profile"
WHERE "customer_id" IN (
    SELECT "id"
    FROM "customer"
    WHERE "gender" = 'Female'
    AND "marital_status" = 'Partnered'
);


-- Find weekly goals of all customers given gender is Male and income greater than or equal to 50,000
SELECT *
FROM "weekly_goal"
WHERE "customer_id" IN (
    SELECT "id"
    FROM "customer"
    WHERE "gender" = 'Male'
    AND "income" >= 50000
);


-- Find all customers for a given product_id = 3
SELECT *
FROM "customer"
WHERE "id" IN (
    SELECT "customer_id"
    FROM "purchase"
    WHERE "product_id" = 3
);

-- Add a new customer
INSERT INTO "customer" ("age", "gender", "education", "marital_status", "income")
VALUES (19, 'Female', 17, 'Single', 250000);

-- Add a new weekly_goal
INSERT INTO "weekly_goal" ("customer_id", "usage", "miles")
VALUES (181, 5, 40);

-- Add a new product
INSERT INTO "product" ("id", "name", "level", "cost")
VALUES (4, 'KP981', 'advanced', 3000);
