select * from blinkit_data

update blinkit_data
set Item_Fat_Content =
case when Item_Fat_Content in ( 'low fat', 'LF') THEN 'Low Fat'
when Item_Fat_Content = 'reg' THEN 'Regular'
else Item_Fat_Content
end

select distinct (Item_Fat_Content) from blinkit_data

--Total Sales
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) as Total_Sale_Millions
from blinkit_data;

--B
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) as Total_Sale_Millions
from blinkit_data
where Item_Fat_Content= 'Low Fat'


--Avg Sales
SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) as AVG_Sales
from blinkit_data;


--Number of Items
SELECT COUNT(*) as No_Items from blinkit_data;

--AVG RATING
SELECT CAST(AVG(Rating) AS DECIMAL (10,2)) AS AVG_Rating from blinkit_data;

--Total Sales by Fat Content
SELECT Item_Fat_Content, 
CAST(SUM(Sales) AS DECIMAL(10,2)) as Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,1)) as AVG_Sales,
COUNT(*) as No_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS AVG_Rating from blinkit_data
WHERE Outlet_Establishment_Year= 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

--Sales by Item type
SELECT Top 5 Item_Type, 
CAST(SUM(Sales) AS DECIMAL(10,2)) as Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,1)) as AVG_Sales,
COUNT(*) as No_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS AVG_Rating from blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

--Fat content by Outlet Total sales

SELECT
    Outlet_Location_Type,
    SUM(CASE WHEN Item_Fat_Content = 'Low Fat'
             THEN Sales ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN Item_Fat_Content = 'Regular'
             THEN Sales ELSE 0 END) AS Regular
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;



-- Best Performing Outlet Type by Sales

SELECT Outlet_Type,
CAST(SUM(Sales) as DECIMAL(10,2)) as Total_Sales,
CAST(AVG(Sales) as DECIMAL(10,1)) as AVG_Sales,
CAST(AVG(Rating) as DECIMAL(10,2)) as AVG_Rating,
COUNT(*) AS No_Items from blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC


-- Sales Trend by Outlet Establishment Year

SELECT Outlet_Establishment_Year,
CAST(SUM(Sales) as DECIMAL(10,2)) as Total_Sales,
COUNT(*) as No_Items
from blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC