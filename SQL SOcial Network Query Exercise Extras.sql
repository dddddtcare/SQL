/*SQL SOcial Network Query Exercise Extras*/
/* Q1  
For every situation where student A likes student B, 
but student B likes a different student C, return the names and grades of A, B, and C.
*/
 select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2, Highschooler H3
where L1.ID2 = L2.ID1 and L2.ID2 <> L1.ID1
and L1.ID1 = H1.ID and L1.ID2 = H2.ID and L2.ID2 = H3.ID
;
/* Q2  
Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades. */
select name, grade from Highschooler where ID not in (select ID1
from Friend f,Highschooler h1,Highschooler h2
where f.ID1=h1.ID and f.ID2=h2.ID
and h1.grade=h2.grade)
/* Q3  
What is the average number of friends per student? (Your result should be just one number.) */
select avg(c1) from (select count(ID2) c1
from Friend
group by ID1)
/* Q4  
Find the number of students who are either friends with Cassandra 
or are friends of friends of Cassandra. Do not count Cassandra, 
even though technically she is a friend of a friend. */
select count(*) from (
select ID2 from Friend where ID1 =(select ID from Highschooler where name='Cassandra')
union
select  f1.ID1 from Friend f1,Friend f2,Friend f3,Highschooler h1,Highschooler h2 
where f1.ID1=h1.ID and f1.ID2=f2.ID1 and f2.ID1=h2.ID and f2.ID2=(select ID from Highschooler where name='Cassandra') and 
f1.ID1<>(select ID from Highschooler where name='Cassandra'))t
/*Q5  (1 point possible)
Find the name and grade of the student(s) with the greatest number of friends. */
 select name,grade from Highschooler where ID in(select ID1 
from Friend
group by ID1
having count(ID2)=
(select count(ID2) from Friend
group by ID1
order by count(ID2) desc
limit 1))