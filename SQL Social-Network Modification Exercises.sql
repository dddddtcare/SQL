/*SQL Social-Network Modification Exercises*/
/*Q1  (1 point possible)
It's time for the seniors to graduate. Remove all 12th graders from Highschooler. */
delete from Highschooler 
where grade=10
/*Q2  (1 point possible)
If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. */
select l1.ID1
from Likes l1 , Likes l2,Friend f 
where l1.ID2=l2.ID1 and l2.ID2<>l1.ID1
and  (l1.ID1=f.ID1 and l2.ID1=f.ID2) or (l1.ID1=f.ID2 and l2.ID1=f.ID1)

delete from Likes
where ID2 in (select ID2 from Friend where Likes.ID1 = ID1) and
      ID2 not in (select L.ID1 from Likes L where Likes.ID1 = L.ID2);---- need to fix
	  
	  /*Q3  (1 point possible)
For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.) */
insert into friend
select f1.id1, f2.id2
from friend f1 join friend f2 on f1.id2 = f2.id1
where f1.id1 <> f2.id2
except
select * from friend