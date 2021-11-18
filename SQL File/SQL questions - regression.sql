# First 3 questions are not applicable since we could not import tables into MySQL


# 4. Select all the data from table house_price_data to check if the data was imported correctly
select * from house_price_data;

# 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL.
# Select all the data from the table to verify if the command worked. Limit your returned results to 10.

alter table housing.house_price_data
drop column date_sold;

select * from house_price_data
limit 10;

# 6. Use sql query to find how many rows of data you have.

select count(*) as 'Number of Rows' from house_price_data;

# 7. Now we will try to find the unique values in some of the categorical columns:
#What are the unique values in the column bedrooms?
select distinct(bedrooms) as 'Unique Values in Bedroom Column' from house_price_data;

#What are the unique values in the column bathrooms?
select distinct(bathrooms) as 'Unique Values in Bathroom Column' from house_price_data;


#What are the unique values in the column floors?
select distinct(floors) as 'Unique Values in Floors Column' from house_price_data;


#What are the unique values in the column condition?

alter table house_price_data   #alter column name first 
change column 'condition' 'condition_' int null default null;
select distinct(condition_) as 'Unique Values in Condition Column' from house_price_data;

#What are the unique values in the column grade?
select distinct(grade) as 'Unique Values in Grade Column' from house_price_data;

 #8. Arrange the data in a decreasing order by the price of the house. 
 #Return only the IDs of the top 10 most expensive houses in your data.
 select id from house_price_data
 order by price desc
 limit 10 ;

# 9. What is the average price of all the properties in your data?

select format(round(avg(price),0),0) as 'Overall Price of All Houses'from house_price_data;

#In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
#What is the average price of the houses grouped by bedrooms? 
#The returned result should have only two columns, bedrooms and Average of the prices.
# Use an alias to change the name of the second columns.

select bedrooms, format(round(avg(price),2),0) as 'Avg Price' from house_price_data
group by bedrooms
order by bedrooms asc;


#What is the average sqft_living of the houses grouped by bedrooms? 
#The returned result should have only two columns, bedrooms and Average of the sqft_living. 
#Use an alias to change the name of the second column.

select bedrooms, format(round(avg(sqft_living),2),0) as 'Average of the sqft_living' from house_price_data
group by bedrooms
order by bedrooms asc;

#What is the average price of the houses with a waterfront and without a waterfront? 
#The returned result should have only two columns, waterfront and Average of the prices. 
#Use an alias to change the name of the second column.

select waterfront, format(round(avg(price),2),0) as 'Average of the prices' from house_price_data
group by waterfront;

# 10. Is there any correlation between the columns condition and grade? 
#You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column.
# Visually check if there is a positive correlation or negative correlation or no correlation between the variables

select avg(condition_) as 'Avg Condition', avg(grade) As 'Avg Grade', 
round(stddev_samp(condition_) * stddev_samp(grade),2) as 'Correlation Ratio Between Condition & Grade' 
from house_price_data; - #based on the result, you can see we have quite a strong correlation between condition and grade. 


# 11. One of the customers is only interested in the following houses:
#Number of bedrooms either 3 or 4
#Bathrooms more than 3
#One Floor
#No waterfront
#Condition should be 3 at least
#Grade should be 5 at least
#Price less than 300000
#For the rest of the things, they are not too concerned. 
#Write a simple query to find what are the options available for them?
select * from house_price_data
where (bedrooms = 3 or 4 ) and
(bathrooms > 3) and 
(floors = 1) and 
(waterfront = 0) and 
(condition_ >=3) and 
(grade >=5) and 
(price<300000);

# 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
# Write a query to show them the list of such properties. You might need to use a sub query for this problem.
select * from house_price_data
where price > 2 * (select avg(price) from house_price_data)
group by id
order by price asc;

# 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
create view houses_over_twice_avg_price as  
select * from house_price_data
where price > 2 * (select avg(price) from house_price_data)
group by id
order by price asc;


# 14. Most customers are interested in properties with three or four bedrooms. 
#What is the difference in average prices of the properties with three and four bedrooms?

select distinct
 format(round((select avg(price) from house_price_data where bedrooms = 4) -
(select avg(price) from house_price_data where bedrooms = 3),2),0) as 'Difference of Averages' 
from house_price_data;


# 15. What are the different locations where properties are available in your database? (distinct zip codes)
select distinct(zipcode), count(id) as 'No of Properties' from house_price_data
group by zipcode
order by count(id) Desc;

# 16. Show the list of all the properties that were renovated.
 select * from house_price_data
 where yr_renovated > 1;
 
 # 17. Provide the details of the property that is the 11th most expensive property in your database.
 select * from house_price_data
 order by price desc
limit 10,1








