--create list of keyword assignments
INSERT INTO _KeyList (ImageID, KeyName)
VALUES
-- insert list of images and keywords here
;
--build keywords

INSERT INTO AgLibraryKeywordImage (image, tag, id_local)
SELECT
	ImageID
	,(SELECT id_local FROM AgLibraryKeyword WHERE lc_name=lower(KeyName)) 
	--,CAST((SELECT Val FROM _Variables WHERE Name='MaxKWI') AS INTEGER) + (row_number() OVER (ORDER BY ImageID)) AS ID
	,(SELECT IDList FROM _NewKWI WHERE IDSeq=(row number() over (ORDER BY ImageID,KeyName)))
FROM
	_KeyList
;
DELETE * FROM _NewKWI WHERE IDSeq<=(SELECT count(*) FROM _KeyList);

DROP TABLE IF EXISTS _Variables;
DROP TABLE IF EXISTS _KeyList;
DROP TABLE IF EXISTS _NewKeys;
*/