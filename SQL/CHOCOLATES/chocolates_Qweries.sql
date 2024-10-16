show tables;
desc sales;
SELECT * FROM sales;

select SaleDate, Amount, boxes, amount/boxes Per_Boxes from sales;

SELECT * FROM sales
where amount > 10000
order by amount desc;

SELECT * FROM sales
where geoid ='g1' 
order by PID, AMount desc;

SELECT * FROM sales
where amount > 10000 AND SaleDate >= '2022-01-01'
order by amount desc;

SELECT SaleDate, Amount FROM sales
where amount > 10000 AND YEAR(SaleDate) = 2022
order by amount desc;

SELECT * FROM sales
where boxes BETWEEN '0' AND '50';

SELECT SaleDate, Amount, boxes, weekday(saledate) 'Day of week'
FROM sales;

FROM sales
where weekday(saledate) = 4;


select * from people;

select salesperson 
from people
where team = 'delish' or team ='jucies';

select salesperson 
from people
where team in ('delish','jucies');

select * 
from people
where salesperson LIKE 'B%';

select * 
from people
where salesperson LIKE '%B%';

SELECT saledate, amount,
        case when amount < 1000 then 'under 1k'
             when amount < 5000 then 'under 5k'
             when amount < 10000 then 'under 10k'
        else '10k or more'
        end 'Amount Category'
 FROM sales;

SELECT s.saledate, s.amount, p.salesperson
FROM sales s
join people p on s.spid = p.spid;

SELECT s.spid pid, s.saledate, s.amount, p.spid, p.salesperson 
FROM sales s
join people p on s.spid = p.spid;

SELECT  s.saledate, s.amount, p.salesperson, g.region
FROM sales s
join people p on s.spid = p.spid
join geo g on s.geoid = g.geoid;

SELECT  s.saledate, s.amount,  pr.product, p.salesperson, g.region
FROM sales s
left join products pr on pr.pid = s.pid
join people p on p.spid = s.spid
join geo g on g.geoid = s.geoid;


SELECT  s.saledate, s.amount,  pr.product, p.salesperson, p.team
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid;


SELECT  s.saledate, s.amount,  pr.product, p.salesperson, p.team
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
where s.amount < 500
and p.team = 'delish';


SELECT  s.saledate, s.amount,  pr.product, p.salesperson, p.team
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
where s.amount < 500
and p.team = '';


SELECT  s.saledate, s.amount,  pr.product, p.salesperson, p.team, g.geo
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
join geo g on g.geoid = s.geoid
where s.amount < 500
and p.team = 'delish'
and g.geo in ('india','new zealand')
ORDER BY saledate;

SELECT sum(s.amount) Total_Amount, g.geo
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
join geo g on g.geoid = s.geoid
GROUP BY  g.geo;


select geoid, sum(amount), avg(amount), sum(boxes)
from sales
GROUP BY geoid;

select g.geo, sum(amount), avg(amount), sum(boxes)
from sales s
JOIN geo g on s.geoid = g.geoid
GROUP BY g.geoid;


SELECT pr.category, p.team, sum(boxes), sum(amount)
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
GROUP BY pr.category, p.team;



SELECT pr.category, p.team, sum(boxes), sum(amount)
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
where p.team <> ''
GROUP BY pr.category, p.team
order by pr.category, p.team;


SELECT pr.category, p.team, sum(boxes), sum(amount)
FROM sales s
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
where p.team <> ''
GROUP BY pr.category, p.team
HAVING pr.category = 'bars' and p.team = 'delish'
order by pr.category, p.team;


SELECT p.product, sum(s.amount)'Total_Amount'
FROM sales s
join products p on p.pid = s.pid
group  by p.product
order by 'Total_Amount' desc;

--BOTTOM 10 ---
SELECT p.product, sum(s.amount)'Total_Amount'
FROM sales s
join products p on p.pid = s.pid
group  by p.product
order by sum(s.amount) asc
limit 10;

--TOP 10--
SELECT p.product, sum(s.amount)'Total_Amount'
FROM sales s
join products p on p.pid = s.pid
group  by p.product
order by sum(s.amount) DESC
limit 10;

 ---PRACTICE QUESTIONS ---
     /* 1 */
 SELECT * 
 FROM sales
 where amount > 2000 
 and boxes < 100;

     /* 2 */
SELECT p.salesperson, count(*) `shippment count`
FROM sales s
join people p on s.spid = p.spid
where MONTH(SaleDate) = '01'
and year(saledate) = '2022'
group by p.salesperson,MONTH(SaleDate);

                OR

SELECT p.salesperson, count(*) shipment
FROM sales s
join people p on s.spid = p.spid
where saledate between '2022-1-1' and '2022-1-31'
group by p.salesperson;


     /* 3 */
SELECT p.product, sum(boxes) 
from sales s
join products p on s.pid = p.pid
where product in ('milk bars','eclairs')
group by p.product;

     /* 4 */
SELECT p.product, sum(boxes) 
from sales s
join products p on s.pid = p.pid
where product in ('milk bars','eclairs')
and saledate between '2022-2-1' and '2022-2-7'
group by p.product;


     /* 5 */
SELECT  s.spid
from sales s
join products p on s.pid = p.pid
join people pl on s.spid = pl.spid
where s.customers < 100
and s.boxes < 100;

SELECT *, case 
               when weekday(saledate) =  2 then 'wednessday shipment'
               when weekday(saledate) =  1 then 'Tuesday shipment'
               when weekday(saledate) =  0 then 'Monday shipment'
               when weekday(saledate) =  3 then 'Thursaday shipment'
               when weekday(saledate) =  4 then 'Friday shipment'
               when weekday(saledate) =  5 then 'Saturday shipment'
          else "Sunday"
end 'shipment Days'
from sales 
where customers < 100
and boxes < 100;


SELECT *, case 
          when weekday(saledate) =  2 then 'wednessday shipment'
          else ""
end 'Shipment Days'
from sales 
where customers < 100
and boxes < 100;



                /* HARD */
                /* 6 */
SELECT distinct(p.salesperson)
FROM sales s
join people p on p.spid = s.spid
where saledate between '2022-1-1' and '2022-1-7';


       /* 7 -- which salesperson did not make any shipment in the forst 7 days of january 2022*/
SELECT p.salesperson
FROM people p 
where p.spid not in 
(select distinct(s.pid)
from sales s 
where s.saledate between '2022-1-1' and '2022-1-7');


/* 8 -- How many times we shipped more than 1,000 boxes in each month ?*/
SELECT year(saledate) Year, month(saledate) month, count(*) 'Times over 1k shipped'
from sales 
where boxes > 1000
GROUP BY year(saledate), month(saledate)
ORDER BY year(saledate), month(saledate);


/* 9 -- Did we ship at least 1 box of After Nines to newzealand on all the months ? */
SELECT year(saledate) Year, month(saledate) Month, case when sum(boxes) > 1 
then 'yes' 
else 'No' 
end status
FROM sales s
join geo g on g.geoid = s.geoid
join products pr on pr.pid = s.pid
where geo = 'New zealand'
and product = 'After nines'
group by year(saledate), month(saledate)
order by year(saledate)ASC, month(saledate);
          -----OR----
set @product_name = 'after nines';
set @country_name = 'new zealand';
select year(saledate) year, month(saledate) month, if(sum(boxes) > 1, 'yes','No')'status'
from sales s     
join products pr on pr.pid = s.pid
join geo g on g.geoid = s.geoid
where pr.product = @product_name 
and g.geo = @country_name
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);



/* 10 -- India or Astralia ? who buys more chocolate boxes on a monthly basis ? */
SELECT Year(saledate) Year,sum(boxes) `Total boxes`, case 
                              when month(saledate) = '1' then 'January'
                              when month(saledate) = '2' then 'February'
                              when month(saledate) = '3' then 'March'
                              when month(saledate) = '4' then 'April'
                              when month(saledate) = '5' then 'May'
                              when month(saledate) = '6' then 'June'
                              when month(saledate) = '7' then 'July'
                              when month(saledate) = '8' then 'August'
                              when month(saledate) = '9' then 'September'
                              when month(saledate) = '10' then 'October'
                              when month(saledate) = '11' then 'November'
                              else 'December'
                              end MONTH,
sum(case when g.geo = 'india' then boxes else 0 end) `india boxes`, 
sum(case when g.geo = 'Australia' then boxes else 0 end) `Australia boxes`         
FROM sales s                 
join geo g on g.geoid = s.geoid
where geo in ('india','australia')
group by Year(saledate), month;

                    ------OR---

SELECT year(saledate) Year, month(saledate) Month, 
sum(case when g.geo = 'india' then boxes else 0 end) `india boxes`, 
sum(case when g.geo = 'Australia' then boxes else 0 end) `Australia boxes`
from sales s     
join geo g on g.geoid = s.geoid 
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);


/* 11 -- WHAT IS THE TOTAL SALES REVENUE BY REGION ? */
SELECT  g.region, sum(amount) `Total Revenue` 
FROM SALES s     
join geo g on g.geoid = s.geoid
group by region;


/* 12 -- which salesperson has the highest total sales amount ? */
SELECT  p.salesperson, sum(amount) `Total Revenue` 
FROM SALES s     
join people p on s.spid = p.spid
group by p.salesperson
order by `Total Revenue` desc
limit 1;


/* 13 -- what are the top 5 best-selling products by category ? */
select  pr.product, pr.category,  sum(s.boxes) `Total Boxes Sold`
from sales s    
join products pr on s.pid = pr.pid
group by pr.product, pr.category
order by `Total Boxes Sold` desc
limit 5;


/* 14 -- which region has the highest average sales amount per customer? */
select  g.region,  avg(s.amount/s.customers) `Average Sales`
from sales s   
join geo g on s.geoid = g.geoid
group by  g.region
order by `Average Sales` desc;


/* 15 --what is the total sales amount for each sales team ? */
select  p.team, sum(s.amount) `Total Sales`
from sales s   
join people p on s.spid = p.spid 
group by p.team
ORDER BY `Total Sales` DESC;


/* 16 --Which product has the highest profit margin ? */
select pr.product, (pr.cost_per_box - s.amount / s.boxes) / pr.cost_per_box * 100 `Profit Margin`
from sales s   
join products pr on s.pid = pr.pid
ORDER BY  `Profit Margin` desc
limit 1;

/* 17 -- what is the sales trend by month for the last year ? */
select month(saledate), sum(amount) `Total Sales`  
from sales s   
where year(saledate) = '2021'
GROUP BY month(saledate);
----or----
select year(saledate) year, month(saledate), sum(amount) `Total Sales`  
from sales s   
where saledate >= dateadd(year,-1,getdate())
GROUP BY year(saledate), month(saledate)
order by year, month;

/* 18 --what salesperson has the most customers ? */
select   p.salesperson, sum(s.customers) `Customers`
from sales s   
join people p on s.spid = p.spid
GROUP BY p.salesperson
order by `Customers` desc
limit 1;


/* 19 -- what is the average order value by product category  ? */
select   pr.category, avg(amount) `Average Value`
from sales s   
join products pr on s.pid = pr.pid
group by pr.category;


/* 20 -- which region has the lowest sales amount ? */
select g.region, sum(s.amount)`Amount`
from  sales s    
join geo g on s.geoid = g.geoid
group by g.region
ORDER BY `Amount`
limit 1 ;


/* 21 -- What is the total sales amount for each salesperson by region ? */
select g.region, p.salesperson, sum(amount) `Total Sales`
from sales s    
join geo g on s.geoid = g.geoid
join people p on s.spid = p.spid
group by p.salesperson, g.region;



/* 22 -- Which product category has the highest sales amount in each region ? */
select g.region, pr.category, sum(amount) `Total Sales`
from sales s    
join products pr on s.pid = pr.pid
join geo g on s.geoid = g.geoid
group by pr.category, g.region
order by g.region,`Total Sales` DESC;


/* 23 -- what is the grpwth rate by region over the last quarter  ? */
select g.region, (sum(s.amount-lag(sum(s.amount))over (partition by g.region order by year(s.saledate),month(s.saledate)))/lag(sum(s.amount))over(partition by g.region order by year(s.saledate), month(s.saledate))) *100 `SalesGrowthRate`
from sales s   
join geo g on s.geoid = g.geoid  
where s.saledate >= dateadd(quarter, -1, getdate())
group by g.region, year(s.saledate),month(s.saledate);


/* 24 -- which salesperson has the highest sales amount in each product category ? */
select p.salesperson, pr.category, sum(amount) `Total Sales`
from sales s   
join people p on s.spid = p.spid
join products pr on s.pid = pr.pid
group by p.salesperson, pr.category
order by `Total Sales` desc;

select sum(amount) Total from sales;