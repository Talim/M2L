-- Mission 1

--Tache 1 

Alter table Vacation (
	Add (
		constraint chk_RegistrationDate check (HEUREFIN>HEUREDEBUT)
		)
);
