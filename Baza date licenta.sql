create table angajati (
id number not null,
nume varchar(20) not null,
prenume varchar(20) not null,
id_functie number not null,
id_cv number not null,
constraint "angajati_PK" PRIMARY KEY ("ID")
);

create table consultatii_medicale (
id number not null,
data date not null,
id_angajati number not null,
constraint "consultatii_medicale_PK" PRIMARY KEY ("ID")
);

create table cv (
id number not null,
adresa varchar(20) not null,
telefon number not null,
email varchar(20) not null,
nationalitate varchar(20) not null,
data_nastere date not null,
sex varchar(20) not null,
oras varchar(20) not null,
tara varchar(20) not null,
constraint "cv_PK" PRIMARY KEY ("ID")
);

create table experienta (
id number not null,
descriere varchar(20) not null,
id_cv number not null,
constraint "experienta_PK" PRIMARY KEY ("ID")
);

create table educatie (
id number not null,
descriere varchar(20) not null,
id_cv number not null,
constraint "educatie_PK" PRIMARY KEY ("ID")
);

create table functii (
id number not null,
nume_functie varchar(20) not null,
id_posturi number not null,
constraint "functii_PK" PRIMARY KEY ("ID")
);

create table posturi_disponibile (
id number not null,
nume_post varchar(20) not null,
numar_posturi varchar(20) not null,
salariu number not null,
id_departament number not null,
constraint "posturi_disponibile_PK" PRIMARY KEY ("ID")
);

create table departamente (
id number not null,
nume varchar(20) not null,
constraint "departamente_PK" PRIMARY KEY ("ID")
);

create table planificare_concedii (
id number not null,
tip_concediu varchar(20) not null,
data date not null,
id_angajati number not null,
constraint "planificare_concedii_PK" PRIMARY KEY ("ID")
);

create table login (
id number not null,
nume_utilizator varchar(20) not null,
parola varchar(20) not null,
id_angajati number not null,
constraint "login_PK" PRIMARY KEY ("ID")
);

create table cursanti (
id number not null,
id_angajat number not null,
constraint "cursanti_PK" PRIMARY KEY ("ID")
);

create table programare_cursuri (
id number not null,
data date not null,
id_cursanti number not null,
constraint "programare_cursusri_PK" PRIMARY KEY ("ID")
);

create table cursuri (
id number not null,
nume_curs varchar(20) not null,
id_programare_cursuri number not null,
constraint "cursuri_PK" PRIMARY KEY ("ID")
);


alter table ANGAJATI
add constraint angajati_functii_FK FOREIGN KEY(id_functie) references FUNCTII(id);

alter table ANGAJATI
add constraint angajati_cv_FK FOREIGN KEY(id_cv) references CV(id);

alter table EDUCATIE
add constraint educatie_cv_FK FOREIGN KEY(id_cv) references CV(id);

alter table Experienta
add constraint experienta_cv_FK FOREIGN KEY(id_cv) references CV(id);

alter table FUNCTII
add constraint functii_posturi_FK FOREIGN KEY(id_posturi) references POSTURI_DISPONIBILE(id);

alter table POSTURI_DISPONIBILE
add constraint posturi_departamente_FK FOREIGN KEY(id_departament) references DEPARTAMENTE(id);

alter table PLANIFICARE_CONCEDII 
add constraint concedii_angajati_FK FOREIGN KEY(id_angajati) references ANGAJATI(id);

alter table LOGIN
add constraint login_angajati_FK FOREIGN KEY(id_angajati) references ANGAJATI(id);

alter table CURSANTI 
add constraint cursanti_angajati_FK FOREIGN KEY(id_angajat) references ANGAJATI(id);

alter table PROGRAMARE_CURSURI
add constraint programare_cursuri_FK FOREIGN KEY(id_cursanti) references CURSANTI(id);

alter table CURSURI
add constraint cursuri_programare_FK FOREIGN KEY(id_programare_cursuri) references PROGRAMARE_CURSURI(id);

create SEQUENCE Departamente_seq start with 1 increment by 1;
create SEQUENCE PosturiDisponibile_seq start with 1 increment by 1;
create SEQUENCE Functii_seq start with 1 increment by 1;
create SEQUENCE Educatie_seq start with 1 increment by 1;
create SEQUENCE Experienta_seq start with 1 increment by 1;
create SEQUENCE Cv_seq start with 1 increment by 1;
create SEQUENCE ConsultatiiMedicale_seq start with 1 increment by 1;
create SEQUENCE Cursuri_seq start with 1 increment by 1;
create SEQUENCE ProgramareCursuri_seq start with 1 increment by 1;
create SEQUENCE Cursanti_seq start with 1 increment by 1;
create SEQUENCE Login_seq start with 1 increment by 1;
create SEQUENCE PlanificareConcedii_seq start with 1 increment by 1;
create SEQUENCE Angajati_seq start with 1 increment by 1;

create or replace trigger Departamente_autoincrement
before insert
  on DEPARTAMENTE
  for each row
begin
  select Departamente_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger PosturiDisp_autoincrement
before insert
  on Posturi_Disponibile
  for each row
begin
  select PosturiDisponibile_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Functii_autoincrement
before insert
  on Functii
  for each row
begin
  select Functii_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Educatie_autoincrement
before insert
  on Educatie
  for each row
begin
  select Educatie_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Experienta_autoincrement
before insert
  on Experienta
  for each row
begin
  select Experienta_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Cv_autoincrement
before insert
  on CV
  for each row
begin
  select Cv_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger ConsultatiiMed_autoincrement
before insert
  on Consultatii_Medicale
  for each row
begin
  select ConsultatiiMedicale_seq.NEXTVAL
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

create or replace trigger ProgramareCurs_autoincrement
before insert
  on Programare_Cursuri
  for each row
begin
  select ProgramareCursuri_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Cursanti_autoincrement
before insert
  on Cursanti
  for each row
begin
  select Cursanti_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Login_autoincrement
before insert
  on Login
  for each row
begin
  select Login_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger PlanifConcedii_autoincrement
before insert
  on Planificare_Concedii
  for each row
begin
  select PlanificareConcedii_seq.NEXTVAL
  into: new.id
  from dual;
end;

create or replace trigger Angajati_autoincrement
before insert
  on Angajati
  for each row
begin
  select Angajati_seq.NEXTVAL
  into: new.id
  from dual;
end;

insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();
insert into ANGAJATI (nume, prenume,id_functie, id_cv) values ();

insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();
insert into CONSULTATII_MEDICALE (data, id_angajati) values ();

insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();
insert into CV (adresa, telefon, email, nationalitate, data_nastere, sex, oras, tara) values ();

insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();
insert into EXPERIENTA (descriere, id_cv) values ();

insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();
insert into EDUCATIE (descriere, id_cv) values ();

insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();
insert into FUNCTII (nume_functie, id_posturi) values ();

insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Junior Programator Web Java', 2, 2000, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Senior Programator Web Java', 4, 4000, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Junior Baze de date', 3, 2000, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Senior Baze de date', 2, 3500, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Tester', 3, 3000, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('C++ Programator', 4, 4400, 1);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Asistent logistica', 1, 1900, 2);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Sef proiect logistica', 1, 3000, 2);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Business intern', 2, 2800, 3);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Junior Market Analysis', 1, 2000, 3);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Consultant Resurse Umane', 2, 2000, 4);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Specialist Resurse Umane', 1, 3000, 4);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Junior Recruiter', 1, 2000, 4);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Consilier Clienti', 1, 2000, 5);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Analist Raportare', 1, 3000, 5);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Helpdesk Suport', 1, 2000, 6);
insert into POSTURI_DISPONIBILE (nume_post, numar_posturi, salariu, id_departament) values ('Tehnician echipamente de calcul si retele', 1, 2000, 6);


insert into DEPARTAMENTE (nume) values ('IT');
insert into DEPARTAMENTE (nume) values ('Logistica');
insert into DEPARTAMENTE (nume) values ('Business');
insert into DEPARTAMENTE (nume) values ('Resurse Umane');
insert into DEPARTAMENTE (nume) values ('HR');
insert into DEPARTAMENTE (nume) values ('Economic');

insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();
insert into PLANIFICARE_CONCEDII (tip_concediu, data, id_angajati) values ();

insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();
insert into LOGIN (nume_utilizator, parola, id_angajati) values ();

insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();
insert into CURSANTI (id_angajat) values ();

insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();
insert into PROGRAMARE_CURSURI (data, id_cursanti) values ();

insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
insert into CURSURI (nume_curs, id_programare_cursuri) values ();
