
CASE kolon_adi
    WHEN kosul_1 THEN sonuc_1
    WHEN kosul_2 THEN sonuc_2
    .......
    .......
    WHEN kosul_n THEN sonuc_n
    ELSE diger_sonuc
END;
-----------------------------------------------------------------------------
--
Select * from cd.members
Select * from cd.bookings
Select* from cd.facilities
-- Question-6
-- How can you produce a list of bookings on the day of 2012-09-14
-- which will cost the member (or guest) more than $30?
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'),
-- and the guest user is always ID 0. Include in your output the name of the facility,
-- the name of the member formatted as a single column, and the cost.
-- Order by descending cost, and do not use any subqueries.
select mems.firstname || ' ' || mems.surname as member,
	facs.name as facility,
	case
		when mems.memid = 0 then
			bks.slots*facs.guestcost
		else
			bks.slots*facs.membercost
	end as cost
	from cd.members mems
                inner join cd.bookings bks
                        on mems.memid = bks.memid
                inner join cd.facilities facs
                        on bks.facid = facs.facid
	where
		bks.starttime >= '2012-09-14' and
		bks.starttime < '2012-09-15' and (
			(mems.memid = 0 and bks.slots*facs.guestcost > 30) or
			(mems.memid != 0 and bks.slots*facs.membercost > 30)
			)
	
order by cost desc;

-- Question-8
-- The Produce a list of costly bookings exercise contained some messy logic:
-- we had to calculate the booking cost in both the WHERE clause and
-- the CASE statement. Try to simplify this calculation using subqueries.
-- For reference, the question was:
select member, facility, cost
	from
		
		(select
		 mems.firstname || ' ' || mems.surname as member,
		facs.name as facility,
		case
			when mems.memid = 0 then
				bks.slots*facs.guestcost
			else
				bks.slots*facs.membercost
				end as cost
		
		 		from
		 			cd.members mems
						inner join cd.bookings bks
							on mems.memid = bks.memid
						inner join cd.facilities facs
							on bks.facid = facs.facid
	
		 		where
		 				bks.starttime >= '2012-09-14' and
						bks.starttime < '2012-09-15'
						) as bookings
		
	where cost > 30
order by cost desc;
	
-- Question-7
-- How can you output a list of all members, including the individual
-- who recommended them (if any), without using any joins?
-- Ensure that there are no duplicates in the list, and
-- that each firstname + surname pairing is formatted as a column and ordered.
select distinct mems.firstname || ' ' ||  mems.surname as member,
	(select recs.firstname || ' ' || recs.surname as recommender
		from cd.members recs
		where recs.memid = mems.recommendedby
	)
	from cd.members mems
	
order by member;

question 1

---For our first foray into aggregates, we're going to stick to something simple. 
---We want to know how many facilities exist - simply produce a total count.
 select count(DISTINCT facid) from cd.facilities
 
--Produce a count of the number of facilities that have a cost to guests of 10 or more.
--10 veya daha fazla misafir için maliyeti olan tesislerin sayısını üretin.

select count(*) from cd.facilities where guestcost >= 10;  

----Produce a count of the number of recommendations each member has made. Order by member ID.
---Her üyenin yaptığı tavsiyelerin sayısını belirleyin. Üye kimliğine göre sırala.

select count(recommendedby) 
	from cd.members
	where recommendedby is not null
	group by recommendedby
order by recommendedby; 

 
----Produce a list of the total number of slots booked per facility. For now, just produce
--an output table consisting of facility id and slots, sorted by facility id.

---Tesis başına rezerve edilen toplam slot sayısının bir listesini oluşturun. Şimdilik, tesis kimliğine
--göre sıralanmış tesis kimliği ve yuvalardan oluşan bir çıktı tablosu oluşturmanız yeterlidir.

select sum(slots) as "total slots" from cd.bookings group by facid order by facid;

---Produce a list of the total number of slots booked per facility in the month of September 2012. 
--Produce an output table consisting of facility id and slots, sorted by the number of slots.

--Eylül 2012'de tesis başına ayrılan toplam yuva sayısının bir listesini oluşturun. Yuva sayısına göre 
--sıralanmış tesis kimliği ve yuvalardan oluşan bir çıktı tablosu oluşturun.

select facid, sum(slots) as "Total Slots"
	from cd.bookings
	where
		starttime >= '2012-09-01'
		and starttime < '2012-10-01'
	group by facid
order by sum(slots);

----Produce a list of the total number of slots booked per facility per month in the year of 2012. Produce an output
--table consisting of facility id and slots, sorted by the id and month.
---2012 yılında tesis başına aylık rezerve edilen toplam yuva sayısının bir listesini üretin. Kimliğe ve aya göre
---sıralanmış tesis kimliği ve yuvalardan oluşan bir çıktı tablosu oluşturun.

select facid, extract(month from starttime) as month, sum(slots) as "Total Slots"
	from cd.bookings
	where extract(year from starttime) = 2012
	group by facid, month
order by facid, month; 


select facid, extract(month from starttime) as month, sum(slots) as "Total Slots"
	from cd.bookings
	where
		starttime >= '2012-01-01'
		and starttime < '2013-01-01'
	group by facid, month
order by facid, month;

----Find the total number of members (including guests) who have made at least one booking.

---En az bir rezervasyon yapan toplam üye sayısını (misafirler dahil) bulun.

select count(distinct memid) from cd.bookings   

select count(*) from 
	(select distinct memid from cd.bookings) as mems
	
--Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting 
--of facility id and slots, sorted by facility id.	
--Rezerve edilmiş 1000'den fazla slotu olan tesislerin bir listesini oluşturun. Tesis kimliğine göre
--sıralanmış tesis kimliği ve yuvalarından oluşan bir çıktı tablosu üretin.

select facid, sum(slots) as "Total Slots"
        from cd.bookings
        group by facid
        having sum(slots) > 1000
        order by facid  

--Produce a list of facilities along with their total revenue. The output table should consist of facility 
--name and revenue, sorted by revenue. Remember that there's a different cost for guests and members!
--Toplam gelirleriyle birlikte tesislerin bir listesini oluşturun. Çıktı tablosu, gelire göre sıralanmış 
--tesis adı ve gelirden oluşmalıdır. Misafirler ve üyeler için farklı bir maliyetin olduğunu unutmayın!

select facs.name, sum(slots * case
			when memid = 0 then facs.guestcost
			else facs.membercost
		end) as revenue
	from cd.bookings bks
	inner join cd.facilities facs
		on bks.facid = facs.facid
	group by facs.name
order by revenue;  

---Produce a list of facilities with a total revenue less than 1000. Produce an output table consisting of 
--facility name and revenue, sorted by revenue. Remember that there's a different cost for guests and members!
--Toplam geliri 1000'den az olan tesislerin bir listesini üretin. Tesis adı ve gelirden oluşan, gelire göre 
--sıralanmış bir çıktı tablosu oluşturun. Misafirler ve üyeler için farklı bir maliyetin olduğunu unutmayın!


select name, revenue from (
	select facs.name, sum(case 
				when memid = 0 then slots * facs.guestcost
				else slots * membercost
			end) as revenue
		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		group by facs.name
	) as agg where revenue < 1000
order by revenue; 
-----
select facs.name, sum(case 
		when memid = 0 then slots * facs.guestcost
		else slots * membercost
	end) as revenue
	from cd.bookings bks
	inner join cd.facilities facs
		on bks.facid = facs.facid
	group by facs.name
	having sum(case 
		when memid = 0 then slots * facs.guestcost
		else slots * membercost
	end) < 1000
order by revenue;

---Output the facility id that has the highest number 
--of slots booked. For bonus points, try a version without a LIMIT clause. This version will probably look messy!

--Rezerve edilen en yüksek yuva sayısına sahip tesis kimliğinin çıktısını alın. Bonus puanlar için,
--LIMIT yan tümcesi olmayan bir sürümü deneyin. Bu sürüm muhtemelen dağınık görünecek!
select facid, sum(slots) as "Total Slots"
	from cd.bookings
	group by facid
order by sum(slots) desc
LIMIT 1;  

----
select facid, sum(slots) as totalslots
	from cd.bookings
	group by facid
	having sum(slots) = (select max(sum2.totalslots) from
		(select sum(slots) as totalslots
		from cd.bookings
		group by facid
		) as sum2);
		
---
	group by facid
	having sum(slots) = (select max(sum2.totalslots) from
		(select sum(slots) as totalslots
		from cd.bookings
		group by facid
		) as sum2);
---Produce a list of the total number of slots booked per facility per month in the year of 2012. In this version, include output rows containing totals for all months per facility, and a total for all months for all facilities. The output table should consist of facility id, month and slots, sorted by the id and month.
---When calculating the aggregated values for all months and all facids, return null values in the month and facid columns.

select facid, extract(month from starttime) as month, sum(slots) as slots
	from cd.bookings
	where
		starttime >= '2012-01-01'
		and starttime < '2013-01-01'
	group by rollup(facid, month)
order by facid, month;
-------
select facid, extract(month from starttime) as month, sum(slots) as slots
    from cd.bookings
    where
        starttime >= '2012-01-01'
        and starttime < '2013-01-01'
    group by facid, month
union all
select facid, null, sum(slots) as slots
    from cd.bookings
    where
        starttime >= '2012-01-01'
        and starttime < '2013-01-01'
    group by facid
union all
select null, null, sum(slots) as slots
    from cd.bookings
    where
        starttime >= '2012-01-01'
        and starttime < '2013-01-01'
order by facid, month;
-------------------------------
with bookings as (
	select facid, extract(month from starttime) as month, slots
	from cd.bookings
	where
		starttime >= '2012-01-01'
		and starttime < '2013-01-01'
)
select facid, month, sum(slots) from bookings group by facid, month
union all
select facid, null, sum(slots) from bookings group by facid
union all
select null, null, sum(slots) from bookings
order by facid, month;
-----Produce a list of the total number of hours booked per facility, remembering that a slot lasts half an hour. The output
---table should consist of the facility id, name, and hours booked, sorted by facility id. Try formatting the hours to two decimal places.

---Bir slotun yarım saat sürdüğünü hatırlayarak tesis başına rezerve edilen toplam saat sayısının bir listesini yapın. Çıktı tablosu, tesis kimliğine 
--göre sıralanmış tesis kimliği, adı ve rezerve edilen saatlerden oluşmalıdır. Saatleri iki ondalık basamak olarak biçimlendirmeyi deneyin.
select facs.facid, facs.name,
	trim(to_char(sum(bks.slots)/2.0, '9999999999999999D99')) as "Total Hours"

	from cd.bookings bks
	inner join cd.facilities facs
		on facs.facid = bks.facid
	group by facs.facid, facs.name
order by facs.facid;

---Produce a list of each member name, id, and their first booking after September 1st 2012. Order by member ID.
--Her üyenin adının, kimliğinin ve 1 Eylül 2012'den sonraki ilk rezervasyonlarının bir listesini oluşturun. Üye kimliğine göre sıralayın.
select mems.surname, mems.firstname, mems.memid, min(bks.starttime) as starttime
	from cd.bookings bks
	inner join cd.members mems on
		mems.memid = bks.memid
	where starttime >= '2012-09-01'
	group by mems.surname, mems.firstname, mems.memid
order by mems.memid;  

---Produce a list of member names, with each row containing the total member count. Order by join date, and include guest members.
---Her satırı toplam üye sayısını içeren bir üye adları listesi oluşturun. Katılım tarihine göre sıralayın ve konuk üyeleri dahil edin.

select count(*) over(), firstname, surname
	from cd.members
order by joindate  
-----
select (select count(*) from cd.members) as count, firstname, surname
	from cd.members
order by joindate

---Produce a monotonically increasing numbered list of members (including guests), 
--ordered by their date of joining. Remember that member IDs are not guaranteed to be sequential.
--Üyelerin (misafirler dahil) katılma tarihlerine göre sıralanmış, monoton artan numaralı bir 
--listesini oluşturun. Üye kimliklerinin sıralı olduğunun garanti edilmediğini unutmayın.
select row_number() over(order by joindate), firstname, surname
	from cd.members
order by joindate 
---Output the facility id that has the highest number of slots booked. Ensure that in the event of a tie, all tieing results get output.
---Rezerve edilen en yüksek yuva sayısına sahip tesis kimliğinin çıktısını alın. Beraberlik durumunda,
--tüm bağlama sonuçlarının çıktı aldığından emin olun.

select facid, total from (
	select facid, sum(slots) total, rank() over (order by sum(slots) desc) rank
        	from cd.bookings
		group by facid
	) as ranked
	where rank = 1  
------
select facid, sum(slots) as totalslots
	from cd.bookings
	group by facid
	having sum(slots) = (select max(sum2.totalslots) from
		(select sum(slots) as totalslots
		from cd.bookings
		group by facid
		) as sum2);
----
select facid, total from (
	select facid, total, rank() over (order by total desc) rank from (
		select facid, sum(slots) total
			from cd.bookings
			group by facid
		) as sumslots
	) as ranked
where rank = 1
----Produce a list of members (including guests), along with the number of hours they've booked in facilities, rounded to the nearest ten hours. 
--Rank them by this rounded figure, producing output of first name, surname, rounded hours, rank. Sort by rank, surname, and first name.
---Üyelerin (misafirler dahil) bir listesini, tesislerde rezervasyon yaptırdıkları saat sayısıyla birlikte, en yakın on saate yuvarlanmış olarak oluşturun.
--Onları bu yuvarlak rakama göre sıralayın, ad, soyad, yuvarlatılmış saatler, sıralama çıktısı üretin. Rütbe, soyadı ve ada göre sıralayın.
		
select firstname, surname,
	((sum(bks.slots)+10)/20)*10 as hours,
	rank() over (order by ((sum(bks.slots)+10)/20)*10 desc) as rank

	from cd.bookings bks
	inner join cd.members mems
		on bks.memid = mems.memid
	group by mems.memid
order by rank, surname, firstname;  
-----

select firstname, surname, hours, rank() over (order by hours desc) from
	(select firstname, surname,
		((sum(bks.slots)+10)/20)*10 as hours

		from cd.bookings bks
		inner join cd.members mems
			on bks.memid = mems.memid
		group by mems.memid
	) as subq
order by rank, surname, firstname;
-----
--Produce a list of the top three revenue generating facilities (including ties). 
--Output facility name and rank, sorted by rank and facility name.
--İlk üç gelir getirici tesisin bir listesini oluşturun (bağlar dahil). Çıktı tesisi adı ve rütbesi, rütbe ve tesis adına göre sıralanır.

select name, rank from (
	select facs.name as name, rank() over (order by sum(case
				when memid = 0 then slots * facs.guestcost
				else slots * membercost
			end) desc) as rank
		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		group by facs.name
	) as subq
	where rank <= 3
order by rank;    

--Classify facilities into equally sized groups of high, average,
--and low based on their revenue. Order by classification and facility name.
--Tesisleri, gelirlerine göre eşit büyüklükte yüksek, ortalama ve düşük gruplar
--halinde sınıflandırın. Sınıflandırmaya ve tesis adına göre sıralayın.

select name, case when class=1 then 'high'
		when class=2 then 'average'
		else 'low'
		end revenue
	from (
		select facs.name as name, ntile(3) over (order by sum(case
				when memid = 0 then slots * facs.guestcost
				else slots * membercost
			end) desc) as class
		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		group by facs.name
	) as subq
order by class, name;  

---Based on the 3 complete months of data so far, calculate the amount of time each facility will take to repay its cost of ownership. Remember to take into account ongoing monthly maintenance. Output facility name and payback time in months, order by facility name. 
--Don't worry about differences in month lengths, we're only looking for a rough value here!
--Ağustos 2012'deki her gün için, önceki 15 gün içindeki toplam gelirin yuvarlanan ortalamasını hesaplayın. Çıktı, tarihe göre sıralanmış tarih ve gelir sütunları içermelidir. Bir günün sıfır gelire sahip olma olasılığını hesaba katmayı unutmayın. Bu biraz zor, 
--bu yüzden ipucunu kontrol etmekten korkmayın!
select 	dategen.date,
	(
		-- correlated subquery that, for each day fed into it,
		-- finds the average revenue for the last 15 days
		select sum(case
			when memid = 0 then slots * facs.guestcost
			else slots * membercost
		end) as rev

		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		where bks.starttime > dategen.date - interval '14 days'
			and bks.starttime < dategen.date + interval '1 day'
	)/15 as revenue
	from
	(
		-- generates a list of days in august
		select 	cast(generate_series(timestamp '2012-08-01',
			'2012-08-31','1 day') as date) as date
	)  as dategen
order by dategen.date;   
-----
select date, avgrev from (
	-- AVG over this row and the 14 rows before it.
	select 	dategen.date as date,
		avg(revdata.rev) over(order by dategen.date rows 14 preceding) as avgrev
	from
	    -- generate a list of days.  This ensures that a row gets generated
		-- even if the day has 0 revenue.  Note that we generate days before
		-- the start of october - this is because our window function needs
		-- to know the revenue for those days for its calculations.
		(select
			cast(generate_series(timestamp '2012-07-10', '2012-08-31','1 day') as date) as date
		)  as dategen
		left outer join
			-- left join to a table of per-day revenue
			(select cast(bks.starttime as date) as date,
				sum(case
					when memid = 0 then slots * facs.guestcost
					else slots * membercost
				end) as rev

				from cd.bookings bks
				inner join cd.facilities facs
					on bks.facid = facs.facid
				group by cast(bks.starttime as date)
			) as revdata
			on dategen.date = revdata.date
	) as subq
	where date >= '2012-08-01'
order by date;
----
























