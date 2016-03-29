/*SQL Social Network Query Exercises*/
/* Q1 (1 point possible)
Find the names of all students who are friends with someone named Gabriel.
*/
select Highschooler.name from Highschooler where ID in(select ID1 from Friend where ID2 in (
select ID from Highschooler where name='Gabriel'))
/* Q2 (1 point possible)
For every student who likes someone 2 or more grades younger than themselves,
 return that student's name and grade, and the name and grade of the student they like.
*/
select h1.name,h1.grade,h2.name,h2.grade
from Likes l,Highschooler h1,Highschooler h2
where h1.ID=l.ID1 and h2.ID=l.ID2
and h1.grade-h2.grade>1
/* Q3 (1 point possible)
For every pair of students who both like each other, 
return the name and grade of both students. 
Include each pair only once, with the two names in alphabetical order. */
select distinct h1.name,h1.grade,h2.name,h2.grade
from Likes l1,Likes l2,Highschooler h1,Highschooler h2
where h1.ID=l1.ID1 and h2.ID=l2.ID1
and l1.ID2=l2.ID1 and l2.ID2=l1.ID1
and h1.name<h2.name
/* Q4 (1 point possible)
Find all students who do not appear in the Likes table 
(as a student who likes or is liked) and return their names and grades.
 Sort by grade, then by name within each grade. */
select name,grade from Highschooler where ID not in( 
select ID1 from Likes
union
select ID2 from Likes)
order by grade,name
/* Q5 (1 point possible)
For every situation where student A likes student B, 
but we have no information about whom B likes (that is, 
B does not appear as an ID1 in the Likes table), return A and B's names and grades. */

select h1.name,h1.grade,h2.name,h2.grade from Likes,
Highschooler h1,Highschooler h2
 where h1.ID=ID1 and h2.ID=ID2 and  
 ID2 in(
select ID2 from Likes where ID2 not in(select ID1 from Likes))

/* Q6 (1 point possible)
Find names and grades of students who only have friends
 in the same grade. Return the result sorted by grade, 
 then by name within each grade. */
select name,grade from Highschooler where ID not in(select ID1
 from Friend l,Highschooler h1,Highschooler h2
 where l.ID1=h1.ID and l.ID2=h2.ID
 and h1.grade<>h2.grade)
 order by grade ,name
 
 /* Q7 (1 point possible)
For each student A who likes a student B where the two are not friends, 
find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
*/
 select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Likes, Highschooler H2, Highschooler H3, Friend F1, Friend F2
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and
  H2.ID not in (select ID2 from Friend where ID1 = H1.ID) and  --they are not friends
  H1.ID = F1.ID1 and F1.ID2 = H3.ID and --  they have common friend
  H3.ID = F2.ID1 and F2.ID2 = H2.ID;

/* Q8 (1 point possible)
Find the difference between the number of students in the school and the number of different first names. */
select  
((select count(*) from Highschooler)-(select count(distinct name) from Highschooler))

/* Q9 (1 point possible)
Find the name and grade of all students who are liked by more than one other student. */
select  Highschooler.name,Highschooler.grade
from Likes,Highschooler
where Likes.ID2=Highschooler.ID
group by ID2
having count(ID1)>1










