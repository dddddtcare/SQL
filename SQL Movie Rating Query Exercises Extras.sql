/*SQL Movie Rating Query Exercises Extras*/
/* Q1 (1 point possible)
Find the names of all reviewers who rated Gone with the Wind. */
select distinct Reviewer.name
from Reviewer,Movie,Rating
where Reviewer.rID=Rating.rID and Rating.mID=Movie.mID
and Movie.title='Gone with the Wind'
/* Q2 (1 point possible)
For any rating where the reviewer is the same as the director of the movie, 
return the reviewer name, movie title, and number of stars. */
select Reviewer.name,Movie.title,Rating.stars
from Reviewer,Movie,Rating
where Reviewer.rID=Rating.rID and Rating.mID=Movie.mID
and Reviewer.name=Movie.director
/* Q3 (1 point possible)
Return all reviewer names and movie names together in a single list, alphabetized.
 (Sorting by the first name of the reviewer and first word in the title is fine; 
 no need for special processing on last names or removing "The".)
*/
select Reviewer.name
from Reviewer
union
select Movie.title
from Movie
order by Reviewer.name,Movie.title
/* Q4 (1 point possible)
Find the titles of all movies not reviewed by Chris Jackson.
*/
select Movie.title
from Movie
where mID not in (select mID from Rating where rID in (select rID
from Reviewer
where name='Chris Jackson'))
/* Q5 (1 point possible)
For all pairs of reviewers such that both reviewers gave a rating to the same movie,
 return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, 
 and include each pair only once. For each pair, return the names in the pair in alphabetical order. */
 
 select distinct re1.name,re2.name
 from Reviewer re1,Reviewer re2,Rating ra1,Rating ra2
 where re1.rID=ra1.rID and re2.rID=ra2.rID
 and   ra1.mID=ra2.mID and ra1.rID<>ra2.rID
 and re1.name<re2.name
 /* Q6 (1 point possible)
For each rating that is the lowest (fewest stars) currently in the database,
 return the reviewer name, movie title, and number of stars.
*/
select re.name,m.title,2 
from Rating ra,Movie m,Reviewer re
where ra.rId=re.rID and ra.mID=m.mID
and ra.stars=(select min(stars)from Rating)
/* Q7 (1 point possible)
List movie titles and average ratings, 
from highest-rated to lowest-rated. 
If two or more movies have the same average rating, list them in alphabetical order.
*/
select Movie.title,avg(stars)
from Rating,Movie
where Rating.mID=Movie.mID
group by Rating.mID
order by avg(stars)desc,Movie.title
/* Q8 (1 point possible)
Find the names of all reviewers who have contributed three or more ratings. 
(As an extra challenge, try writing the query without HAVING or without COUNT.) */
select Reviewer.name 
from Rating,Reviewer
where Rating.rID=Reviewer.rID
group by Rating.rID
having count(mID)>2
/* Q9 (1 point possible)
Some directors directed more than one movie. For all such directors, 
return the titles of all movies directed by them, along with the director name. 
Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)
*/
select title,director from Movie where director in(
select director 
from Movie
group by director
having count(mID)>1)
order by director,title
/* Q10 (1 point possible)
Find the movie(s) with the highest average rating.
 Return the movie title(s) and average rating. 
 (Hint: This query is more difficult to write in SQLite than other systems; 
 you might think of it as finding the highest average rating
 and then choosing the movie(s) with that average rating.)
*/
select Movie.title,avg(stars)
from Rating,Movie
where Rating.mID=Movie.mID
group by Rating.mID
order by avg(stars) desc
limit 1
/* Q11 (1 point possible)
Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)
*/
select Movie.title,avg(stars)
from Rating,Movie
where Rating.mID=Movie.mID
group by Rating.mID
order by avg(stars) asc
limit (
select count(avg1) from (select avg(stars) avg1
from Rating
group by mID
order by avg1 asc)
group by avg1
limit 1)
/* Q12 (1 point possible)
For each director, return the director's name together with the title(s)
 of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.
*/
select Movie.director,Movie.title,max(Rating.stars)
from Movie, Rating
where Movie.mID=Rating.mID and Movie.director is not null
group by Movie.director


















 
 
 
 
 
 
 