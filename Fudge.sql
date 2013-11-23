create table Student (
	studentId char(5) not null,
	firstName varchar(10) not null,
	lastName varchar(10) not null,
	age int ,
	wand int,
	houseName varchar(15),
	currYear smallint,
	preferredSpell varchar(50),
	pet varchar(5),
	DoB date,
	sex char,
	primary key(studentId),
	unique(wand)
);
	
create table School (
	schoolName varchar(15),
	headMaster char(5),
	headBoy char(5),
	headGirl char(5),
	primary key(schoolName),
	unique(headMaster),
	unique(headBoy),
	unique(headGirl)
);
	
create table Employee (
	wandID int,
	employeeID char(5) not null,
	firstName varchar(10),
	lastName varchar(10),
	deptId char(3),
	primary key(employeeID)
);

create table Professor (
	professorId char(5),
	professorName varchar(50),
	subject varchar(50),
	joinDate date,
	wand int,
	preferredSpell varchar(50),
	primary key(professorId)
);

create table SubTaken (
	student char(5) not null,
	subject varchar(15) not null
);

create table House (
	houseName varchar(15),
	headOfHouse char(5),
	prefectBoy char(5),
	prefectGirl char(5),
	quidditchCapt char(5),
	houseGhost varchar(25),
	primary key(houseName),
	unique(headOfHouse),
	unique(prefectBoy),
	unique(prefectGirl),
	unique(quidditchCapt),
	unique(houseGhost)
);
	
create table Wand (
	wandID int,
	core varchar(30),
	wood varchar(30),
	length decimal(3,1),
	primary key(wandID)
);

create table Subject (
	subName varchar(50),
	classRoom varchar(15),
	profId char(5),
	primary key(subName)
);
	
create table Dept (
	deptId char(3),
	deptName varchar(50),
	HOD char(5),
	level smallint,
	primary key(deptId)
);
	
create table QuidditchTeam (
	houseName varchar(15),
	captain char(5),
	keeper char(5),
	seeker char(5),
	primary key(houseName),
	unique(captain),
	unique(keeper),
	unique(seeker)
);

create table QuidditchMatch (
	matchId int,
	winner varchar(15),
	loser varchar(15),
	year int,
	primary key(matchId)
);

alter table Student

add constraint Student1
foreign key(wand) references Wand(wandID)
	on delete set null
	on update cascade,

add constraint Student2
foreign key(houseName) references House(houseName)
	on delete set null
	on update cascade;

alter table School

add constraint School1
foreign key(headMaster) references Professor(professorId)
	on delete set null
	on update cascade,

add constraint School2
foreign key(headBoy) references Student(studentId)
	on delete set null
	on update cascade,

add constraint School3
foreign key(headGirl) references Student(studentId)
	on delete set null
	on update cascade;

alter table Employee

add constraint Emp1
foreign key(wandID) references Wand(wandID)
	on delete set null
	on update cascade,

add constraint Emp2
foreign key(deptId) references Dept(deptId)
	on delete set null
	on update cascade;

alter table Professor

add constraint Prof1
foreign key(subject) references Subject(subName)
	on delete set null
	on update cascade,

add constraint Prof2
foreign key(wand) references Wand(wandID)
	on delete set null
	on update cascade;

alter table SubTaken

add constraint SubTaken1
foreign key(student) references Student(studentId)
	on delete cascade
	on update cascade,

add constraint SubTaken2
foreign key(subject) references Subject(subName)
	on delete cascade
	on update cascade;

alter table House

add constraint House1
foreign key(headOfHouse) references Professor(professorId)
	on delete set null
	on update cascade,

add constraint House2
foreign key(prefectBoy) references Student(studentId)
	on delete set null
	on update cascade,

add constraint House3
foreign key(prefectGirl) references Student(studentId)
	on delete set null
	on update cascade,

add constraint House4
foreign key(quidditchCapt) references Student(studentId)
	on delete set null
	on update cascade;

alter table Subject

add constraint Sub1
foreign key(profId) references Professor(professorId)
	on delete set null
	on update cascade;

alter table Dept

add constraint Dept1
foreign key(HOD) references Employee(employeeID)
	on delete set null
	on update cascade;


alter table QuidditchTeam

add constraint QT1
foreign key(captain) references Student(studentId)
	on delete set null
	on update cascade,

add constraint QT2
foreign key(keeper) references Student(studentId)
	on delete set null
	on update cascade,

add constraint QT3
foreign key(seeker) references Student(studentId)
	on delete set null
	on update cascade;

alter table QuidditchMatch

add constraint QM1
foreign key(winner) references House(houseName)
	on delete set null
	on update cascade,

add constraint QM2
foreign key(loser) references House(houseName)
	on delete set null
	on update cascade;
