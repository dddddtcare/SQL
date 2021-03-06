/*sql movie rating query exercies*/
/*q1 Find the titles of all movies directed by Steven Spielberg.*/
select title
from Movie
where director='Steven Spielberg';
/* Q2 
Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.*/
select distinct Movie.year
from Movie,Rating
where Movie.mID=Rating.mID
and (Rating.stars=4 or Rating.stars=5)
order by Movie.year asc
/* Q3  
Find the titles of all movies that have no ratings. */
select title from Movie
where mID not in
(select mID from Rating)
/* Q4  
Some reviewers didn't provide a date with their rating. 
Find the names of all reviewers who have ratings with a NULL value for the date. */
select name from Reviewer where rID in
(select rID from Rating where ratingDate is null)
/* Q5  
Write a query to return the ratings data in a more readable format:
 reviewer name, movie title, stars, and ratingDate. Also, sort the data,
 first by reviewer name, then by movie title, and lastly by number of stars. */
 select Reviewer.name,Movie.title,Rating.stars,Rating.ratingDate
 from Movie,Reviewer,Rating
 where Movie.mID=Rating.mID and Rating.rID=Reviewer.rID
 order by Reviewer.name,Movie.title,Rating.stars
 /* Q6 (1 point possible)
For all cases where the same reviewer rated the same movie twice 
and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
*/
select name, title from Reviewer, Movie, Rating, Rating r2
where Rating.mID=Movie.mID and Reviewer.rID=Rating.rID 
  and Rating.rID = r2.rID and r2.mID = Movie.mID
  and Rating.stars < r2.stars and Rating.ratingDate < r2.ratingDate;
 /* Q7 (1 point possible)
For each movie that has at least one rating, find the highest number 
of stars that movie received. Return the movie title and number of stars. Sort by movie title. */
select Movie.title,max(Rating.stars)
from Movie,Rating
where Movie.mID=Rating.mID 
group by Rating.mID
order by Movie.title
/* Q8 (1 point possible)
For each movie, return the title and the 'rating spread', 
that is, the difference between highest and lowest ratings 
given to that movie. Sort by rating spread from highest to lowest, then by movie title.
*/
select Movie.title, max(Rating.stars)-min(Rating.stars)  as 'o'
from Movie,Rating
where Movie.mID=Rating.mID 
group by Rating.mID
order by o desc,Movie.title
/* Q9 (1 point possible)
Find the difference between the average rating of movies released before 1980 
and the average rating of movies released after 1980. 
(Make sure to calculate the average rating for each movie, 
then the average of those averages for movies before 1980 
and movies after. Don't just calculate the overall average rating before and after 1980.) */
select (select sum(avg1)/count(avg1) from (select avg(stars) as avg1
from Rating,Movie
where Rating.mID=Movie.mID and Movie.year<1980
group by Rating.mID
))-
(select sum(avg1)/count(avg1) from (select avg(stars) as avg1
from Rating,Movie
where Rating.mID=Movie.mID and Movie.year>1980
group by Rating.mID
))









