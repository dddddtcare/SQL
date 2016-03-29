/*SQL MOVIE-RATING MODIFICATION EXERCIESES*/
/*Q1  (1 point possible)
Add the reviewer Roger Ebert to your database, with an rID of 209. */
insert into Reviewer values(209,'Roger Ebert')
/*Q2  (1 point possible)
Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. */
insert into Rating(rID,mID,stars,ratingDate)
select Reviewer.rID,Movie.mID,5,null  
from Movie,Reviewer
where Reviewer.name='James Cameron'
/*Q3  (1 point possible)
For all movies that have an average rating of 4 stars or higher, 
add 25 to the release year. (Update the existing tuples; don't insert new tuples.) */
update Movie
set year=year+25
where mID in(
select mID
from Rating 
group by mID
having avg(stars)>=4)
/*Q4  (1 point possible)
Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. */
delete from rating
where mID in (select mID from movie where year <1970 or year > 2000)
and stars < 4
