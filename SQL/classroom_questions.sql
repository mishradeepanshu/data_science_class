use questions;
select * from bank_inventory_pricing;
#Q1. Print product, price, sum of quantity more than 5 sold during all three months.  
SELECT 
    product, price, SUM(quantity) AS total_quantity
FROM
    questions.bank_inventory_pricing
GROUP BY product , price
HAVING SUM(Quantity) > 5;
 
#Q2.Print product, quantity , month and count of records for which estimated_sale_price is less than purchase_cost.
SELECT 
    product, quantity, month, COUNT(*) AS record_count
FROM
    questions.bank_inventory_pricing
WHERE
    estimated_sale_price < purchase_cost
GROUP BY product , quantity , month;

#Q3. Extarct the 3rd highest value of column Estimated_sale_price from bank_inventory_pricing dataset
SELECT 
    Estimated_sale_price
FROM
    bank_inventory_pricing
ORDER BY Estimated_sale_price DESC
LIMIT 1 OFFSET 2;

#Q4. Count all duplicate values of column Product from table bank_inventory_pricing
SELECT 
    product, COUNT(product) AS duplicate_product
FROM
    questions.bank_inventory_pricing
GROUP BY product
HAVING COUNT(product) > 1;

#Q5. Create a view 'bank_details' for the product 'PayPoints' and Quantity is greater than 2 
 SELECT * FROM questions.bank_inventory_pricing;
 
CREATE VIEW bank_details AS
    SELECT 
        Product,Quantity,Price
    FROM
        questions.bank_inventory_pricing
    WHERE
        Product = 'PayPoints' AND Quantity > 2;
        
#Q6 Update view bank_details1 and add new record in bank_details1.
-- --example(Producct=PayPoints, Quantity=3, Price=410.67)

insert into bank_details1(product,Quantity,price) values(Product= 'PayPoints',Quantity=3,price=410.67);







