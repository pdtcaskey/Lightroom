DROP TABLE IF EXISTS DupList;
DROP TABLE IF EXISTS EmpDups;
DROP TABLE IF EXISTS ChangeList;

CREATE TEMP TABLE DupList (lc_name TEXT);
CREATE TEMP TABLE EmpDups (lc_name TEXT, NewKW INTEGER, NewGen TEXT, PName TEXT);
CREATE TEMP TABLE ChangeList (OldKW INTEGER, name text, parent INTEGER, OldPName text, NewKW INTEGER, PName text );

insert into DupList (lc_name)
		SELECT
			lc_name
		FROM
			AgLibraryKeyword
		GROUP BY lc_name
		having count(*)>1
;
INSERT INTO EmpDups (lc_name, NewKW, NewGen, PName)
	SELECT
		D.lc_name
		,K.id_local AS NewKW
		,K2.genealogy||'/7'||K.id_local AS NewGen
		,k2.name AS PName
	FROM
		DupList D
	INNER JOIN
		AgLibraryKeyword K
		ON K.lc_name=D.lc_name
		AND K.parent=(SELECT id_local FROM AgLibraryKeyword WHERE (name='Trustee' or name='Employee') AND parent=(SELECT id_local FROM  AgLibraryKeyword WHERE name='Consolidated'))
	LEFT JOIN
		AgLibraryKeyword K2
		ON K2.id_local = K.parent
;
INSERT INTO ChangeList (OldKW, name, parent, OldPName, NewKW, PName)
	SELECT
		K.id_local AS OldKW
		,K.name AS OldName
		,K.parent AS OldParent
		,K2.name OldPName
		,E.NewKW
		,e.PName
	FROM
		EmpDups E
	INNER JOIN
		AgLibraryKeyword K
		ON K.lc_name=E.lc_name
		AND K.parent!=(SELECT id_local FROM AgLibraryKeyword WHERE (name='Trustee' or name='Employee') AND parent=(SELECT id_local FROM  AgLibraryKeyword WHERE name='Consolidated'))
	left JOIN
		AgLibraryKeyword K2
		ON K2.id_local=k.parent
;


UPDATE AgLibraryKeywordImage
SET tag=(select NewKW FROM changelist WHERE OldKW=tag)
WHERE tag in (select OldKW from changelist)
;
UPDATE AgLibraryKeywordFace
SET tag=(select NewKW FROM changelist WHERE OldKW=tag)
WHERE tag in (select OldKW from changelist)
;
DROP TABLE IF EXISTS DupList;
DROP TABLE IF EXISTS EmpDups;
DROP TABLE IF EXISTS ChangeList;
