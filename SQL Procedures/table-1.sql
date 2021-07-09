create table customer(

id varchar2(20) primary key,
pin varchar2(5) not null,
name varchar2(50) not null,
phone varchar2( 15),
email varchar2(50),
house varchar2(100),
city varchar2(50),
zipcode varchar2(10)
);
create table branch(
id varchar2(20) primary key,
name varchar2(50),
city varchar2(50),
zipcode varchar2(10)
);

create table account(
id varchar2(20) primary key,
customerid varchar2(20) not null ,
opendate varchar2(50),
balance number(10,2),
branchid varchar2(20) not null,
FOREIGN KEY (branchid) REFERENCES branch(id),
FOREIGN KEY (customerid) REFERENCES customer(id)
);

drop table transaction;
create table transaction(
id varchar2(20) primary key,
fromacc varchar2(20),
toacc varchar2(20),
frombranchid varchar2(20),
tobranchid varchar2(20),
action varchar2(50) not null,
amount number(10,2) not null,
FOREIGN KEY (fromacc) REFERENCES account(id),
FOREIGN KEY (toacc) REFERENCES account(id),
FOREIGN KEY (frombranchid) REFERENCES branch(id),
FOREIGN KEY (tobranchid) REFERENCES branch(id)
);
insert into transaction values('t001','a001','a002','b001','b002','transfer',30);
insert into transaction values('t002','a002','a003','b002','b002','transfer',30);
drop table employee;
create table employee(
id varchar2(20) primary key,
branchid varchar2(20) not null,
name varchar2(20) not null,
pin varchar2(5) not null,
FOREIGN KEY (branchid) REFERENCES branch(id)
);


insert into employee values('e001','b001','prabha','1234');
insert into employee values('e002','b002','addi','1234');
insert into employee values('e003','b002','manav','1234');

insert into customer values('c001','1234','ayush','8976543217','ayush@gmail.com','park street','jaipur','302020');
insert into customer values('c002','1234','aman','8976343217','aman@gmail.com','park street','jaipur','302020');
insert into customer values('c003','1234','ram','8974443217','ram@gmail.com','park street','patna','304020');
insert into customer values('c004','1234','rohit','8376543217','rohit@gmail.com','park street','delhi','304320');

insert into branch values('b001','jhalwa Branch','delhi','324567');
insert into branch values('b002','allahabad Branch','patna','323467');

insert into account values('a001','c001','21-03-2018',1050,'b001');
insert into account values('a002','c002','23-03-2018',1060,'b002');
insert into account values('a003','c003','24-03-2018',1040,'b002');

insert into transaction values('t001','a001','a002','b001','b002','transfer',30);
insert into transaction values('t002','a002','a003','b002','b002','transfer',30);

/* create or replace PROCEDURE credit(accid in VARCHAR2,amount in NUMBER,flag out NUMBER) 
AS
x number(10,2);
y varchar2(20);
z varchar2(20);
c number :=0;
BEGIN
	select balance into x from account where id=accid;
    x:=x+amount;
    select branchid into y from account where id=accid; 
    update account set balance=x where id=accid;
    select count(id) into c from transaction;
     if (c < 9) then
       z:=concat('t00',to_char(c+1));
      elsif c<99 then
           z:=concat('t0',to_char(c+1));
      else 
          z:=concat('t',to_char(c+1));
      end if;  
      DBMS_Output.put_Line(z);
  insert into transaction values (z,'',accid,'',y,'deposit',amount);
     EXCEPTION 
        When others then
            flag:=0;
END;
/
 */
/* create or replace PROCEDURE debit(accid in VARCHAR2,amount in NUMBER,flag out NUMBER) 
AS
x number(10,2);
y varchar2(20);
z varchar2(20);
c number :=0;
flag :=1;
BEGIN
	select balance into x from account where id=accid;
    x:=x-amount;
    select branchid into y from account where id=accid; 
    update account set balance=x where id=accid;
    select count(id) into c from transaction;
     if (c < 9) then
       z:=concat('t00',to_char(c+1));
      elsif c<99 then
           z:=concat('t0',to_char(c+1));
      else 
          z:=concat('t',to_char(c+1));
      end if;  
         
    DBMS_Output.put_Line(z);
    insert into transaction values (z,accid,'',y,'','withdraw',amount);
     EXCEPTION 
        When others then
            flag:=0;
END;
/ 
    */


select * from account;

select * from transaction;


/* create or replace PROCEDURE transfer(accid1 in VARCHAR2,accid2 in varchar2,amount in NUMBER,flag out NUMBER) 
AS
x1 number(10,2);
x2 number(10,2);
y1 varchar2(20);
y2 varchar2(20);
z varchar2(20);
c number :=0;
BEGIN
	select balance into x1 from account where id=accid1;
   select balance into x2 from account where id=accid2;
    x1:=x1-amount;
    x2:=x2+amount;
    select branchid into y1 from account where id=accid1;
    select branchid into y2 from account where id=accid2;
    
    update account set balance=x1 where id=accid1;
    update account set balance=x2 where id=accid2;
    select count(id) into c from transaction;
      if (c < 9) then
       z:=concat('t00',to_char(c+1));
      elsif c<99 then
           z:=concat('t0',to_char(c+1));
      else 
          z:=concat('t',to_char(c+1));
      end if;  
         
    DBMS_Output.put_Line(z);
    insert into transaction values (z,accid1,accid2,y1,y2,'transfer',amount);
     EXCEPTION 
        When others then
            flag:=0;
END;
/
  */


create or replace procedure userlogin(custid in varchar2,pin in varchar2,flag out number) as
    CURSOR chklogin is Select id,pin from customer;
               custdata   chklogin%ROWTYPE;
   Begin
    open chklogin;
    flag:=0;
    Loop 
    fetch chklogin into custdata;
    exit when chklogin%NOTFOUND;
    if (custid = custdata.id) then
       if(pin = custdata.pin) then
         flag:=1;
         dbms_output.put_line(custdata.id);
         dbms_output.put_line(custdata.pin);
       end if;
    end if;
   end Loop;
  close chklogin;
  if (flag=0) then 
    dbms_output.put_line('Record not found');
  end if;
   EXCEPTION 
        When others then
            flag:=0;
 end;
 /        
Set serveroutput on;
var flag number;
execute userLogin('c001','1234',:flag);

select * from customer;

create or replace procedure empLogin(eid in varchar2,pin in varchar2,flag out number) as
    CURSOR chklogin is Select id,pin from employee;
               empdata   chklogin%ROWTYPE;
   Begin
    open chklogin;
    flag:=0;
    Loop 
    fetch chklogin into empdata;
    exit when chklogin%NOTFOUND;
    if (eid = empdata.id) then
       if(pin = empdata.pin) then
         flag:=1;
         dbms_output.put_line(empdata.id);
         dbms_output.put_line(empdata.pin);
       end if;
    end if;
   end Loop;
  close chklogin;
  if (flag=0) then 
    dbms_output.put_line('Record not found');
  end if;
   EXCEPTION 
        When others then
            flag:=0;
 end;
 /        
Set serveroutput on;
var flag number;
execute empLogin('e001','1234',:flag);

select * from employee;

create or replace procedure checkFund(bid in varchar2,flag out number) as
    CURSOR chkfund is Select branchid as b,sum(balance)as totalbalance from account group by branchid;
               funds   chkfund%ROWTYPE;
   Begin
    open chkfund;
    flag:=0;
    Loop 
    fetch chkfund into funds;
    exit when chkfund%NOTFOUND;
    if (bid = funds.b) then
         flag:=1;
         dbms_output.put_line(funds.b);
         dbms_output.put_line(funds.totalbalance);
    end if;
   end Loop;
  close chkfund;
  if (flag=0) then 
    dbms_output.put_line('error');
  end if;
   EXCEPTION 
        When others then
            flag:=0;
 end;
 /   
 Set serveroutput on;
var flag number;
execute checkFund('b002',:flag);

select * from account;

create or replace procedure custRegister(pin in varchar2,name in varchar2,phone in varchar2,email in varchar2,house in varchar2,city in varchar2,zip in varchar2,flag out number)
  AS
  cid varchar2(20);
  x number(10,2);
  Begin
  Select count(id) into x from customer;
  x:=x+1;
  cid:='';
  if(x < 9) 
  then
    cid:=concat('c00',to_char(x));
  elsif (x < 99)
  then
    cid:=concat('c0',to_char(x));
  else
    cid:=concat('c',to_char(x));
  end if;
  dbms_output.put_line(cid);
  insert into customer values (cid,pin,name,phone,email,house,city,zip);
   EXCEPTION 
        When others then
            flag:=0;
end;
/




Set serveroutput on;
var flag number;
execute custRegister('1234','prabhak','1234565432','p@gmail.com','park street','patna','801503',:flag);

show errors;
select * from customer;

create or replace procedure empRegister(bid in varchar2,name in varchar2,pin in Varchar2,flag out number) as
  eid varchar2(20);
  x number(10,2);
  Begin
  Select count(id) into x from employee;
  x:=x+1;
  eid:='';
  if(x < 9) 
  then
    eid:=concat('c00',to_char(x));
  elsif (x < 99)
  then
    eid:=concat('c0',to_char(x));
  else
    eid:=concat('c',to_char(x));
  end if;
  dbms_output.put_line(eid);
  insert into employee values (eid,bid,name,pin);
   EXCEPTION 
        When others then
            flag:=0;
end;
/

Set serveroutput on;
var flag number;
execute empRegister('b001','Nayan','1234',:flag);

show errors;
select * from employee;

create or replace procedure seeaccount(accid in varchar2, name1 out varchar2,phone1 out varchar2,email1 out varchar2,house1 out varchar2,city1 out varchar2,zipcode1 out varchar2,bal out number,bname out Varchar2,flag out number) as
cid varchar2(20);  
bid varchar2(20);
begin
    flag:=0;
  select customerid,balance,branchid into cid,bal,bid  from account where id = accid;
  select  customer.name ,phone ,email ,house,city,zipcode into name1 ,phone1 ,email1 ,house1,city1,zipcode1 from customer where id = cid;
  select branch.name into bname from branch where id = bid;
 dbms_output.put_line(name1);  
 Exception 
    When others then
      flag:=0;
end;
/

Set serveroutput on;
var flag number;
var phone1 Varchar2;
var name1 Varchar2;
var email1 Varchar2;
var house1 Varchar2;
var city1 Varchar2;
var zipcode1 Varchar2;
var bal number;
var bname varchar2;
execute seeaccount('a001',:name1,:phone1,:email1,:house1,:city1,:zipcode1,:bal,:bname,:flag);
-- print(name1);



create or replace procedure miniStatement(accid in varchar2,result out varchar2 ,flag out number)
  as
   cursor cur is select * from transaction  where (fromacc=accid or toacc=accid);
      begin
          flag:=0;
          for i in cur
           loop 
           result:= result||i.id||','||i.fromacc||','||i.toacc||','||i.frombranchid||','||i.tobranchid ||','||i.action||','||to_char(i.amount)||';';
           dbms_output.put_line(i.id);
          end loop;
          flag := 1;
          dbms_output.put_line(result);
          Exception
            When others then
               flag:=0;
        end;
         /
set serveroutput on;
var c varchar2;
var flag number;
execute seetop5account('a001',:c,:flag);  

select * from transaction;

create or replace procedure seeTopTransactionsofBranch(bid in varchar2,result out varchar2 ,flag out number)
  as
   cursor cur is select * from transaction  where (frombranchid=bid or tobranchid=bid);
      begin
          flag:=0;
          for i in cur
           loop 
           result:= result||i.id||','||i.fromacc||','||i.toacc||','||i.frombranchid||','||i.tobranchid ||','||i.action||','||to_char(i.amount)||';';
           dbms_output.put_line(i.id);
          end loop;
          flag := 1;
          dbms_output.put_line(result);
          Exception 
           When others then
              flag:=0;
        end;
         /
set serveroutput on;
var c varchar2;
var flag number;
execute seeTopTransactionsofBranch('b002',:c,:flag);  

select * from transaction;

create or replace procedure chkparticularTransact(tid in varchar2,accid in varchar2,result out varchar2 ,flag out number)
  as
   cursor cur is select * from transaction  where (id=tid and (fromacc=accid or toacc=accid));
      begin
          flag:=0;
          for i in cur
           loop 
           result:= result||i.id||','||i.fromacc||','||i.toacc||','||i.frombranchid||','||i.tobranchid ||','||i.action||','||to_char(i.amount)||';';
           dbms_output.put_line(i.id);
          end loop;
          flag := 1;
          dbms_output.put_line(result);
          Exception
           When others then
              flag:=0;
        end;
         /
set serveroutput on;
var c varchar2;
var flag number;
execute chkparticularTransact('t001','a001',:c,:flag);  
 print c;


select * from transaction;

create or replace procedure getEmpName(custId in varchar2,name out varchar2) as
  Begin
  Select employee.name into name from employee where employee.id=custId;
  dbms_output.put_line(name);
  Exception 
    When others then
       flag:=0;
end;
/

create or replace procedure showEmpName(eid in Varchar2,res out Varchar2,flag out Number) as
  Begin 
    select name into res from employee where id = eid;
    dbms_output.put_line(res);
  Exception
    When others then
      flag:=0;
  end;
  /
set serveroutput on;
var res Varchar2;
var flag number;
execute showEmpName('e001',:res,:flag); 



create or replace PROCEDURE credit(accid in VARCHAR2,cid in Varchar2,pin in Varchar2,amount in NUMBER,flag out NUMBER) 
AS
x number(10,2);
y varchar2(20);
z varchar2(20);
pass Varchar2(5);
c number :=0;
BEGIN
    select customer.pin into pass from customer where customer.id = cid;
    if pin <> pass then
       dbms_output.put_line('Invalid Pin');
       flag:=0;
    else
        select balance into x from account where id= accid;
        x:=x+amount;
        select branchid into y from account where id= accid; 
        update account set balance=x where id=accid;
        select count(id) into c from transaction;
         if (c < 9) then
           z:=concat('t00',to_char(c+1));
          elsif c<99 then
               z:=concat('t0',to_char(c+1));
          else 
              z:=concat('t',to_char(c+1));
          end if; 
          
      DBMS_Output.put_Line(z);
      insert into transaction values (z,'',accid,'',y,'deposit',amount);
      flag:=1;
     end if;  
Exception
	when no_data_found then
		flag:=0;
	when others then
		flag:=0;
END;
/

Set serveroutput on;
var flag number;
execute credit('a001','c001','1334',100,:flag); 


create or replace PROCEDURE debit(accid in VARCHAR2,cid in Varchar2,pin in Varchar2,amount in NUMBER,flag out NUMBER) 
AS
x number(10,2);
y varchar2(20);
z varchar2(20);
c number :=0;
pass varchar2(5);
BEGIN
    select customer.pin into pass from customer where customer.id = cid;
    if pin <> pass then
       dbms_output.put_line('Invalid Pin');
       flag:=0;
    else
            select balance into x from account where id=accid;
            x:=x-amount;
            select branchid into y from account where id=accid; 
            update account set balance=x where id=accid;
            select count(id) into c from transaction;
             if (c < 9) then
               z:=concat('t00',to_char(c+1));
              elsif c<99 then
                   z:=concat('t0',to_char(c+1));
              else 
                  z:=concat('t',to_char(c+1));
              end if;  
            DBMS_Output.put_Line(z);
            insert into transaction values (z,accid,'',y,'','withdraw',amount);
            flag:=1;
          end if;  
   Exception
	when no_data_found then
		flag:=0;
	when others then
		flag:=0;
END;
/

Set serveroutput on;
var flag number;
execute debit('a001','c001','1334',100,:flag); 


create or replace PROCEDURE transfer(accid1 in VARCHAR2,accid2 in varchar2,cid in Varchar2,pin in Varchar2,amount in NUMBER,flag out NUMBER) 
AS
x1 number(10,2);
x2 number(10,2);
y1 varchar2(20);
y2 varchar2(20);
pass varchar2(5);
z varchar2(20);
c number :=0;
BEGIN
     select customer.pin into pass from customer where customer.id = cid;
     if pin <> pass then
       dbms_output.put_line('Invalid Pin');
       flag:=0;
    else
        select balance into x1 from account where id=accid1;
           select balance into x2 from account where id=accid2;
            x1:=x1-amount;
            x2:=x2+amount;
            select branchid into y1 from account where id=accid1;
            select branchid into y2 from account where id=accid2;
            
            update account set balance=x1 where id=accid1;
            update account set balance=x2 where id=accid2;
            select count(id) into c from transaction;
              if (c < 9) then
               z:=concat('t00',to_char(c+1));
              elsif c<99 then
                   z:=concat('t0',to_char(c+1));
              else 
                  z:=concat('t',to_char(c+1));
              end if;  
                 
            DBMS_Output.put_Line(z);
            insert into transaction values (z,accid1,accid2,y1,y2,'transfer',amount);
            flag:=1;
         end if;   
    EXCEPTION 
       When others then
            flag:=0;
END;
/

Set serveroutput on;
var flag number;
execute transfer('a001','a002','c001','1223',200,:flag);

show errors;


