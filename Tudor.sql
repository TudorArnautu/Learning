create table Angajati1 (
  Id number not null,
  Nume varchar2(20) not null,
  Prenume varchar2(20) not null,
  Varsta number not null,
  Salariu number not null,
  CONSTRAINT "Angajati1_PK" PRIMARY KEY ("ID")
);

create table Departamente1 (
  Id number not null,
  Nume_dep varchar2(20) not null,
  Numar_ang number not null,
  Locuri_disp number not null,
  CONSTRAINT "Departamente1_PK" PRIMARY KEY ("ID")
);

create table Cursuri (
  Id number not null,
  Nume_curs varchar2(20) not null,
  Nivel varchar2(20) not null,
  Data_start date not null,
  Durata_curs number not null,
  CONSTRAINT "Cursuri_PK" PRIMARY KEY ("ID")
);


alter table Angajati1
add (id_dep number not null,
     id_curs number not null);

--legatura Angajati-Departamente
alter table Angajati1
add constraint Angajati_Departamente_FK foreign key(id_dep) references Departamente1(Id);

--legatura Angajati-Cursuri
alter table Angajati1
add constraint Angajati_Cursuri_FK foreign key(id_curs) references Cursuri(Id);


--increment
create SEQUENCE Angajati1_seq start with 1 increment by 1;
create SEQUENCE Departamente1_seq start with 1 increment by 1;
create SEQUENCE Cursuri_seq start with 1 increment by 1;

create or replace trigger Angajati1_autoincrement
before insert
  on Angajati1
  for each row
begin
  select Angajati1_seq.NEXTVAL
  into: new.id
  from dual;
end;  

create or replace trigger Departamente1_autoincrement
before insert
  on Departamente1
  for each row
begin
  select Departamente1_seq.NEXTVAL
  into: new.id
  from dual;
end;  

create or replace trigger Cursuri_autoincrement
before insert
  on Cursuri
  for each row
begin
  select Cursuri_seq.NEXTVAL
  into: new.id
  from dual;
end;  


--populare (insert) 
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('HR', 21, 4);
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('IT', 10, 2);
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('LOGISTICA', 4, 1);
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('DEZVOLTARE', 50, 10);
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('PR', 20, 3);
insert into DEPARTAMENTE1(Nume_dep, Numar_ang, Locuri_disp) values ('ECONOMIC', 15, 2);

insert into CURSURI(Nume_curs, Nivel, Data_start, Durata_curs) values ('Java', 'Intermediar', '22-07-2016', 22); 
insert into CURSURI(Nume_curs, Nivel, Data_start, Durata_curs) values ('SQL', 'Avansat', '21-07-2016', 10); 
insert into CURSURI(Nume_curs, Nivel, Data_start, Durata_curs) values ('Management', 'Mediu', '1-08-2016', 20); 
insert into CURSURI(Nume_curs, Nivel, Data_start, Durata_curs) values ('Cloud Programming', 'Mediu', '1-09-2016', 30); 

insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Buffet', 'Jimmy', 32, 3200, 1, 1);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Bush', 'George', 33, 4300, 1, 1);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Cartman', 'Eric', 25, 2100, 2, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Crockett', 'David', 41, 4400, 2, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Doe', 'Jane', 28, 2300, 2, 3);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Gates', 'Bill', 44, 5500, 3, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Jefferson', 'George', 38, 2800, 4, 3);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Kong', 'King', 30, 4400, 5, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Rockne', 'Knut', 29, 2900, 6, 3);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Simpson', 'Homer', 38, 4000, 2, 3);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Atkinson', 'James', 34, 3000, 5, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Kalifa', 'Julie', 31, 4200, 3, 2);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Munir', 'Jonathan', 29, 2320, 3, 1);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Rose', 'Jorge', 33, 4330, 2, 1);
insert into ANGAJATI1(Nume, Prenume, Varsta, Salariu, Id_dep, Id_curs) values ('Milton', 'Pablo', 39, 5000, 2, 2);

select * from Angajati1;
select * from Departamente1;
select * from Cursuri;

select Nume, Prenume from Angajati1
where Salariu < 3500;

select Nume, Prenume from Angajati1
where Salariu < 3500 or Varsta <30;

select Nume, Prenume from Angajati1
where Salariu < 3500 and Id_dep = 4;

update Angajati1
set salariu = 6000
where id = 4;

select * from Angajati1
where id = 4;

--restrictie de salarii >1000 - <6000
--nu merge
alter table Angajati1
add constraint ck_salariu check(Salariu >1000 and Salariu <5000);

alter table Cursuri rename to Cursuri1;
alter table Cursuri1 rename to Cursuri;

update Angajati1 set Nume = 'Popescu' where id=10;
select Nume from Angajati1 where id=10;

--inner join
select Departamente1.Nume_dep, Angajati1.Nume, Angajati1.Prenume, Angajati1.Salariu
from Angajati1
inner join Departamente1
on Angajati1.id_dep = Departamente1.id;

--left join
select a.nume, a.prenume, c.nume_curs
from Angajati1 a
left join Cursuri c
on a.id = c.id
order by nume;

--full outer join
select a.nume, a.prenume, d.nume_dep, c.nume_curs
from Angajati1 a
full outer join Departamente1 d
on a.id = d.id
full outer join Cursuri c
on a.id = c.id
order by nume;

select nume from Angajati1
UNION
select nume_dep from Departamente1
UNION
select nume_curs from Cursuri;

--case
select Angajati1.nume,
  case salariu  
    when 3500
    then 'salariu mediu'
    when 3000
    then 'salariu mic'
    when 4000
    then'salariu mare'
    else 'normal'
    end as categorii_salariu
    from Angajati1;

--view
create view angajati_view as
select id, nume, prenume, varsta from Angajati1
where nume is not null;

select * from angajati_view;
--nu merge din cauza triggerului
insert into angajati_view(nume, prenume, varsta) values ('Pop', 'Mihai', 33);


