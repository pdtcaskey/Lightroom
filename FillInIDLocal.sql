--BEGIN;
DROP TABLE IF EXISTS _Seq;
CREATE TEMP TABLE _Seq (IDList INTEGER PRIMARY KEY);
DROP TABLE IF EXISTS _NewKW;
CREATE TEMP TABLE _NewKW (IDSeq INTEGER PRIMARY KEY, IDList INTEGER);
DROP TABLE IF EXISTS _NewKWI;
CREATE TEMP TABLE _NewKWI (IDSeq INTEGER PRIMARY KEY, IDList INTEGER);
DROP TABLE IF EXISTS _NewKWF;
CREATE TEMP TABLE _NewKWF (IDSeq INTEGER PRIMARY KEY, IDList INTEGER);
--END;
----------------------------------
--BEGIN;
WITH Seq AS (
	SELECT 100000 AS IDList
	UNION ALL
	SELECT IDList+1
	FROM Seq
	WHERE IDList<(SELECT MAX(id_local) FROM AgLibraryKeyword)
	)
INSERT INTO _Seq 
	select * from Seq S
;
WITH KWTemp AS (
	SELECT IDList
	FROM _Seq S
	LEFT JOIN AgLibraryKeyword KW
		ON S.IDList=KW.id_local
	WHERE KW.id_local is NULL
	)
, KWID AS (
	SELECT
		(row_number() OVER (ORDER BY IDList)) AS ListOrder
		,IDList
	FROM
		KWTemp
	)

INSERT INTO _NewKW
	SELECT * from KWID
;
--END;
--------------------
--BEGIN;
DROP TABLE IF EXISTS _Seq;
CREATE TEMP TABLE _Seq (IDList INTEGER PRIMARY KEY);
WITH Seq AS (
	SELECT 100000 AS IDList
	UNION ALL
	SELECT IDList+1
	FROM Seq
	WHERE IDList<(SELECT MAX(id_local) FROM AgLibraryKeywordImage)
	)
INSERT INTO _Seq 
	select * from Seq S
;
WITH KWTemp AS (
	SELECT IDList
	FROM _Seq S
	LEFT JOIN AgLibraryKeywordImage KW
		ON S.IDList=KW.id_local
	WHERE KW.id_local is NULL
	)
, KWID AS (
	SELECT
		(row_number() OVER (ORDER BY IDList)) AS ListOrder
		,IDList
	FROM
		KWTemp
	)

INSERT INTO _NewKWI
	SELECT * from KWID
;
--END;
--------------------
--BEGIN;
DROP TABLE IF EXISTS _Seq;
CREATE TEMP TABLE _Seq (IDList INTEGER PRIMARY KEY);
WITH Seq AS (
	SELECT 100000 AS IDList
	UNION ALL
	SELECT IDList+1
	FROM Seq
	WHERE IDList<(SELECT MAX(id_local) FROM AgLibraryKeywordFace)
	)
INSERT INTO _Seq 
	select * from Seq S
;
WITH KWTemp AS (
	SELECT IDList
	FROM _Seq S
	LEFT JOIN AgLibraryKeywordFace KW
		ON S.IDList=KW.id_local
	WHERE KW.id_local is NULL
	)
, KWID AS (
	SELECT
		(row_number() OVER (ORDER BY IDList)) AS ListOrder
		,IDList
	FROM
		KWTemp
	)

INSERT INTO _NewKWF
	SELECT * FROM KWID
;
--END;