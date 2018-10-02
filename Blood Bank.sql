
-------------------------DATABASE PROJECT--------------------------------
--------------------------Name: BLOOD BANK-------------------------------
-------------------By: KAZI SAEED ALAM (1407011)-------------------------

-------------------------------------------------------------------------

----------------------- DROP ALL THE TABLE ------------------------------

drop table Transfer_Details cascade constraints;
drop table Donor cascade constraints;
drop table Taker cascade constraints;
drop table Blood_Bank cascade constraints;
drop table Account cascade constraints;

--------------------------------------------------------------------------

------------------------ CREATE ALL THE TABLE ----------------------------

create table Donor
(
	donor_id number(10),
	donor_name varchar(50),
	donor_blood_group varchar(20) not null,
	donor_phone_number varchar(20),
	donor_sex varchar(1),
	last_donation_date date,
	donor_status varchar(20),
	primary key(donor_id)
);

create table Taker
(
	taker_id number(10),
	taker_name varchar(50),
	taker_blood_group varchar(20) not null,
	taker_address varchar(10),
	taker_phone_number varchar(20),
	primary key (taker_id)
);

create table Blood_Bank
(
	bloodbank_id varchar(10),
	bloodbank_name varchar(50),
	blood_group varchar(20),
	blood_amount float,
	blood_status varchar(20),
	transfer_date date,
	primary key(bloodbank_id)
);

create table Transfer_Details
(
	bloodbank_id varchar(10),
	donor_id number(10),
	taker_id number(10),
	blood_group varchar(20),
	blood_amount float,
	transfer_date date,
	foreign key (bloodbank_id) references Blood_Bank on delete cascade,
	foreign key (donor_id) references Donor on delete cascade,
	foreign key (taker_id) references Taker on delete cascade	
);

create table Account
(
	userid varchar(20),
	password number(20)
);

--------------------------------------------------------------------------

------------------------ DESCRIBE ALL TABLE ------------------------------

describe Donor;
describe Taker;
describe Transfer_Details;
describe Blood_Bank;

--------------------------------------------------------------------------

------------------------ ALTER TABLE INFORMATION -------------------------

alter table Donor
	add donor_address varchar(50);
	
alter table Taker
	modify taker_address varchar(50);
	
alter table Donor
	drop column donor_sex;
	
alter table Blood_Bank
	rename column transfer_date to checking_date;
			
	
describe Donor;
describe Taker;
describe Transfer_Details;
describe Blood_Bank;


--------------------------------------------------------------------------

------------------------------- LOG IN -----------------------------------


insert into Account values('Utsha',11);
insert into Account values('Sopto',08);
insert into Account values('Tusher',02);
insert into Account values('Tonmoy',22);
PROMPT You need to login first..
PROMPT Enter your userid and password..


SET SERVEROUTPUT ON
DECLARE
   row_no NUMBER(2);
   u1 Account.userid%TYPE;
   p1 Account.password%TYPE;
BEGIN
    u1 := '&userid';
    p1 := &password;

    select count(*) into row_no from Account
    where Account.userid=u1 and Account.password=p1;

    if row_no = 1 then
      dbms_output.put_line ('Log in successful');
    else
      dbms_output.put_line ('Id or password did not match');
    end if;  
END;
/

--------------------------------------------------------------------------

------------------------- TRIGGER for Donor Table ------------------------

PAUSE Press ENTER to continue 1 ...

DROP TRIGGER TR_Donor; 
CREATE or REPLACE TRIGGER TR_Donor 
BEFORE UPDATE OR INSERT ON Donor
FOR EACH ROW 
BEGIN
      IF EXTRACT(DAY FROM(systimestamp - :new.last_donation_date)) < 90  THEN
        :new.donor_status := 'Not Available';
      else
		:new.donor_status := 'Available';
    END IF;
END TR_Donor;
/
SHOW ERRORS;

	

--------------------------------------------------------------------------

------------------- INSERT DATA INTO Donor & Taker Table -----------------


insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (1,'Mr Prosun','O+','Khulna','01768186003','22-DEC-2016',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (2,'Mr Tusher','A+','Rangpur','01745001539','12-JAN-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (3,'Mr Billah','B+','Dhaka','01674304054','02-AUG-2016',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (4,'Mr Shorol','AB+','Dhaka','01720356489','21-FEB-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (5,'Mr Arnab','O+','Jessore','01912564578','31-MAY-2016',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (6,'Mr Mehedi','AB+','Rangpur','01895626489','22-SEP-2016',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (7,'Mr Bahadur','B+','Chittagang','01556456449','22-JAN-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (8,'Mr Dibbo','AB+','Dhaka','01854787895','02-MAY-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (9,'Mr Amit','O-','Dhaka','01996797754','12-JUN-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (10,'Mr Fahim','B+','Dhaka','01956489312','01-MAY-2017',null);
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (11,'Mr Naeem','AB+','Dhaka','01956489312','01-MAY-2017',null);



insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (1,'Mr Shishir','A+','Dhaka','01785642980');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (2,'Mr Shovon','B+','Comilla','01676892449');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (3,'Mr Shopto','O+','Jenaidah','01941391259');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (4,'Mr Ashik','B+','Dhaka','01758514578');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (5,'Mr Prem','AB+','Rajshahi','01854785647');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (6,'Mr Bikash','O-','Khulna','01987451971');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (7,'Mr Mubin','A+','Dhaka','01777125472');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (8,'Mr Pranto','AB+','Dhaka','01833264851');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (9,'Mr Tawhid','O+','Khulna','01658784125');
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (10,'Mr Wahid','O+','Khulna','01554786932');	
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (11,'Mr Tanjim','O+','Khulna','01554786932');	
		
--------------------------------------------------------------------------

----------------------- TRIGGERS for Blood_Bank Table ---------------------	
	
PAUSE Press ENTER to continue 2 ...	

DROP TRIGGER TR_Bank; 
CREATE or REPLACE TRIGGER TR_Bank 
BEFORE UPDATE OR INSERT ON Blood_Bank
FOR EACH ROW 
BEGIN
	
	if :new.blood_amount < 1 then
		:new.blood_status := 'Not Available';
	elsif :new.blood_amount >1 and 	:new.blood_amount <20 then
		:new.blood_status := 'Only For Emergency';
	elsif :new.blood_amount >20 and 	:new.blood_amount <100 then
		:new.blood_status := 'Good Collection';
	elsif :new.blood_amount >100 then
		:new.blood_status := 'Adequate';
			
    END IF;
END TR_Bank;
/
SHOW ERRORS;	
	
PAUSE Press ENTER to continue 3 ...	

DROP TRIGGER TR_Bank2; 
CREATE or REPLACE TRIGGER TR_Bank2 
BEFORE UPDATE OR INSERT ON Blood_Bank
FOR EACH ROW 
BEGIN
	
	if :new.blood_group = 'A+' or :new.blood_group = 'A-' or :new.blood_group = 'B+' or :new.blood_group = 'B-' or :new.blood_group = 'AB+' or :new.blood_group = 'AB-' or :new.blood_group = 'O+' or :new.blood_group = 'O-' then
		dbms_output.put_line('Blood group insertion is Okay');
	else
		RAISE_APPLICATION_ERROR(-20000,'Incorrect Blood Group Insertion');
    END IF;
END TR_Bank2;
/
SHOW ERRORS;	
	
	
------------------------------------------------------------------------------

-------------- INSERT DATA INTO Blood_Bank & Transfer_Details Table ----------

PAUSE Press ENTER to continue 4 ...	

insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D01','DREAM','A+',80.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D02','DREAM','A-',25.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D03','DREAM','B+',90.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D04','DREAM','B-',15.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D05','DREAM','AB+',60.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D06','DREAM','AB-',34.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D07','DREAM','O+',200.00,null,'15-MAR-2017');
insert into Blood_Bank (bloodbank_id,bloodbank_name,blood_group,blood_amount,blood_status,checking_date) values ('D08','DREAM','O-',55.00,null,'15-MAR-2017');

	
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D07',1,3,'O+',3.00,'18-JAN-2017');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D01',2,1,'A+',4.00,'17-FEB-2017');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D03',3,4,'B+',6.00,'19-MAR-2017');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D05',4,5,'AB+',2.00,'21-DEC-2016');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D07',5,10,'O+',4.00,'18-NOV-2016');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D05',6,8,'AB+',2.00,'18-JUL-2017');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D08',9,6,'O-',6.00,'13-MAR-2017');
insert into Transfer_Details (bloodbank_id,donor_id,taker_id,blood_group,blood_amount,transfer_date) values ('D07',10,9,'O+',3.00,'17-AUG-2016');	
	
	
-----------------------------------------------------------

------------------SELECT, UPDATE & DELETE------------------

PAUSE Press ENTER to continue 5 ...	

select * from Donor;
select * from Taker;
select * from Transfer_Details;
select * from Blood_Bank;

update Blood_Bank set blood_amount=220.00 where blood_group='O+';
update Blood_Bank set blood_amount=20.00 where blood_group='O-';

delete from Donor where donor_id=11;
delete from Taker where taker_id=11;

select * from Donor;
select * from Taker;
select * from Transfer_Details;
select * from Blood_Bank;
	
-----------------------------------------------------------

------------------SOME IMPORTANT QUERIES-------------------


PAUSE Press ENTER to continue 6 ...	

select donor_name,donor_blood_group from Donor;

select taker_name,taker_blood_group from Taker;

select donor_name,donor_address from Donor;

select distinct(donor_address) from Donor;

select distinct(taker_address) from Taker;

select donor_id,donor_name,donor_address,donor_phone_number from Donor where donor_blood_group='O+';

select taker_id,taker_name,taker_address,taker_phone_number from Taker where taker_blood_group='O+';

select blood_group,blood_amount from Blood_Bank where blood_amount between 1.00 and 100.00;

select blood_group from Blood_Bank where blood_amount in (50.00,200.00);

select blood_group,blood_amount from Blood_Bank where blood_amount not between 1.00 and 100.00;

select blood_group from Blood_Bank where blood_amount not in (50.00,200.00);

select donor_name,donor_blood_group from Donor where donor_blood_group like '%A%';

select taker_name,taker_blood_group from Taker where taker_blood_group like '%A%';

select blood_group,blood_amount from Blood order by transfer_date;

select max(blood_amount) as max_blood from Blood_Bank;

select count(distinct donor_blood_group) from Donor;

select count(distinct taker_blood_group) from Taker;

select donor_blood_group,count(donor_blood_group) from Donor group by donor_blood_group;


---------------------------------------------------------------

------------------SOME IMPORTANT SUB-QUERIES-------------------

PAUSE Press ENTER to continue 7 ...

select donor_id,taker_id,blood_group
from Transfer_Details
where blood_group in ( select blood_group
from Blood_Bank
where blood_amount > 200.00				
);

select donor_name,donor_address,donor_phone_number
from Donor
where donor_id in ( select donor_id
from Transfer_Details
where blood_group='O+'
);

select taker_name,taker_address,taker_phone_number
from Taker
where taker_id in ( select taker_id
from Transfer_Details
where blood_group='O+'
);


----------------------------------------------------------

------------------UNION,INTERSECT,MINUS-------------------

PAUSE Press ENTER to continue 8 ...

select donor_name,donor_address,donor_phone_number
from Donor
where donor_blood_group in ( select blood_group
from Blood_Bank
where bloodbank_id = 'D05'
)
UNION
select taker_name,taker_address,taker_phone_number
from Taker
where taker_blood_group in ( select blood_group
from Blood_Bank
where bloodbank_id = 'D05'
);

select donor_blood_group,donor_address
from Donor
INTERSECT
select taker_blood_group,taker_address
from Taker;

select donor_blood_group,donor_address
from Donor
where donor_address='Dhaka' or donor_address='Khulna'
MINUS
select taker_blood_group,taker_address
from Taker

----------------------------------------------------------

------------------SOME JOIN OPERATION---------------------

PAUSE Press ENTER to continue 9 ...

select donor_name,donor_address,taker_name,taker_address
from Donor d JOIN Taker t
on d.donor_blood_group=t.taker_blood_group and d.donor_address=t.taker_address;

select donor_name,donor_blood_group,taker_name,taker_blood_group
from Donor NATURAL JOIN Taker;

select donor_name,donor_address,taker_name,taker_address
from Donor d LEFT OUTER JOIN Taker t
on d.donor_blood_group=t.taker_blood_group;

select donor_name,donor_address,taker_name,taker_address
from Donor d RIGHT OUTER JOIN Taker t
on d.donor_blood_group=t.taker_blood_group;

select donor_name,donor_address,taker_name,taker_address
from Donor d FULL OUTER JOIN Taker t
on d.donor_blood_group=t.taker_blood_group;


----------------------------------------------------------

------------------CURSOR OPERATION------------------------

PAUSE Press ENTER to continue 10 ...

SET SERVEROUTPUT ON;
DECLARE
      CURSOR donor_cur IS
        select donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,donor_status from Donor;
        donor_record  donor_cur%ROWTYPE;
        no_of_donor NUMBER;
BEGIN
	select count(donor_id) into no_of_donor from Donor;
	dbms_output.put_line('Registered Donor list : ');
	open donor_cur;
		LOOP
			FETCH donor_cur into donor_record;
			dbms_output.put_line('Donor ID : ' || donor_record.donor_id || ' Donor Name : ' || donor_record.donor_name || ' Donor Blood Group : ' || donor_record.donor_blood_group || ' Donor Address : ' || donor_record.donor_address || ' Donor Contact NO : ' || donor_record.donor_phone_number || ' Donor Status : ' || donor_record.donor_status);
			EXIT WHEN donor_cur%ROWCOUNT >no_of_donor-1;
		END LOOP;
	close donor_cur;
END;
/


SET SERVEROUTPUT ON;
DECLARE
      CURSOR Taker_cur IS
        select taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number from Taker;
        taker_record  taker_cur%ROWTYPE;
        no_of_taker NUMBER;
BEGIN
	select count(taker_id) into no_of_taker from Taker;
	dbms_output.put_line('Registered Taker list : ');
	open taker_cur;
		LOOP
			FETCH taker_cur into taker_record;
			dbms_output.put_line('Taker ID : ' || taker_record.taker_id || ' Taker Name : ' || taker_record.taker_name || ' Taker Blood Group : ' || taker_record.taker_blood_group || ' Taker Address : ' || taker_record.taker_address || ' Taker Contact NO : ' || taker_record.taker_phone_number);
			EXIT WHEN taker_cur%ROWCOUNT >no_of_taker-1;
		END LOOP;
	close taker_cur;
END;
/

----------------------------------------------------------

------------------PROCEDURES OPERATION---------------------

PAUSE Press ENTER to continue 11 ...

PROMPT Enter Blood_Bank Table information to update..

CREATE OR REPLACE PROCEDURE update_blood_bank(
	id Blood_Bank.bloodbank_id%TYPE,
	bgroup Blood_Bank.blood_group%TYPE,
	amount Blood_Bank.blood_amount%TYPE
) IS
BEGIN
	UPDATE Blood_Bank set blood_amount=amount,checking_date=current_date where bloodbank_id=id and blood_group=bgroup;
EXCEPTION
  WHEN no_data_found THEN 
    RAISE_APPLICATION_ERROR(-20203, 'No Data found.');
END update_blood_bank;
/
SHOW ERRORS
BEGIN
	update_blood_bank('&bloodbank_id','&blood_group','&blood_amount');
END;
/
SHOW ERRORS;
select * from Blood_Bank;	

PAUSE Press ENTER to continue 12 ...
PROMPT Enter Data to insert in Donor Table..

CREATE OR REPLACE PROCEDURE ADD_NEW_DONOR(
  did Donor.donor_id%TYPE,
  dname Donor.donor_name%TYPE,
  dblood Donor.donor_blood_group%TYPE,
  daddress Donor.donor_address%TYPE,
  dcontact Donor.donor_phone_number%TYPE,
  dldd Donor.last_donation_date%TYPE
  ) IS
BEGIN
  insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (did,dname,dblood,daddress,dcontact,dldd,null);
END ADD_NEW_DONOR;
/
SHOW ERRORS
BEGIN
  ADD_NEW_DONOR(&donor_id,'&donor_name','&donor_blood_group','&donor_address','&donor_phone_number','&last_donation_date');
END;
/
select * from Donor;

PAUSE Press ENTER to continue 13 ...
PROMPT Enter Data to insert in Taker Table..

CREATE OR REPLACE PROCEDURE ADD_NEW_TAKER(
  tid Taker.taker_id%TYPE,
  tname Taker.taker_name%TYPE,
  tblood Taker.taker_blood_group%TYPE,
  taddress Taker.taker_address%TYPE,
  tcontact Taker.taker_phone_number%TYPE
  ) IS
BEGIN
  insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (tid,tname,tblood,taddress,tcontact);
END ADD_NEW_TAKER;
/
SHOW ERRORS
BEGIN
   ADD_NEW_TAKER(&taker_id,'&taker_name','&taker_blood_group','&taker_address','&taker_phone_number');
END;
/
select * from Taker;

----------------------------------------------------------

------------------FUNCTIONS OPERATION---------------------

---- Using Function to show the amount of blood transfer for a particular blood group -----

PAUSE Press ENTER to continue 14 ...
PROMPT Enter the Blood Group Name..

CREATE OR REPLACE FUNCTION total_blood_transfer RETURN NUMBER is
	total_t NUMBER(4);
BEGIN
    SELECT sum(blood_amount) into total_t from Blood_Bank where blood_group='&blood_group';
    RETURN total_t;
END total_blood_transfer;
/
SHOW ERRORS
SET SERVEROUTPUT ON
BEGIN
   dbms_output.put_line('Total Amount Blood Transfer is : ' || total_blood_transfer || ' L');
END;
/

---- Using Function to show the number of blood transfer for a particular date -----

PAUSE Press ENTER to continue 15 ...
PROMPT Enter the Required Date in DD-MM-YYYY form..

CREATE OR REPLACE FUNCTION total_no RETURN NUMBER is
	cnt NUMBER(4);
BEGIN
    SELECT count(bloodbank_id) into cnt from Transfer_Details where transfer_date='&transfer_date';
    RETURN cnt;
END total_no;
/
SHOW ERRORS
SET SERVEROUTPUT ON
BEGIN
   dbms_output.put_line('Total No of Blood Transfer is : ' || total_no);
END;
/

----------------------------------------------------------

------------------TRANSACTION MANAGEMENT------------------

PAUSE Press ENTER to continue 16 ...

----ROLLBACK-----

DELETE from Transfer_Details;
SELECT * FROM Transfer_Details;
ROLLBACK;
SELECT * FROM Transfer_Details;

DELETE from Donor;
SELECT * FROM Donor;
ROLLBACK;
SELECT * FROM Donor;

DELETE from Taker;
SELECT * FROM Taker;
ROLLBACK;
SELECT * FROM Taker;

-----SAVEPOINT-----

insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (21,'Mr Amir','O-','Khulna','01768186003','21-JUL-2016',null);
SAVEPOINT P1;
SELECT * FROM Donor;
insert into Donor(donor_id,donor_name,donor_blood_group,donor_address,donor_phone_number,last_donation_date,donor_status) values (22,'Mr Karim','AB-','Kurigram','01745001539','12-APR-2017',null);
ROLLBACK TO P1;
SELECT * FROM Donor;

insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (21,'Mr Aslam','A+','Chittagang','01785642980');
SAVEPOINT P2;
SELECT * FROM Taker;
insert into Taker(taker_id,taker_name,taker_blood_group,taker_address,taker_phone_number) values (22,'Mr Zabbar','B+','Comilla','01676892449');
ROLLBACK TO P2;
SELECT * FROM Taker;

----------------------------------------------------------

----------------------- END ------------------------------
