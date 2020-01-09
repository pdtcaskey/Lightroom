drop table if exists UpdList;
create temp table UpdList (UID INTEGER, lc_name text,genealogy text, parent INTEGER);

insert into UpdList
	SELECT
		id_local AS UID
		,lc_name
		,replace(genealogy,'/221/',(SELECT genealogy FROM AgLibraryKeyword WHERE lc_name='general')||'/') AS NewGen
		,(SELECT id_local FROM AgLibraryKeyword WHERE lc_name='general') AS GenID
	FROM
		AgLibraryKeyword K
	WHERE
		(SELECT count(*) FROM AgLibraryKeyword K2 WHERE K2.parent=K.id_local)=0
		AND parent=21
		AND genealogy is not null
	
;
with UpdUnique AS (
SELECT
	U.UID
	,U.parent as NewParent
	,U.genealogy as NewGen

FROM
	UpdList U
left JOIN	
	AgLibraryKeyword K
	ON K.lc_name=U.lc_name
	and K.parent=U.parent
where k.id_local is null
)

UPDATE AgLibraryKeyword
SET	parent=(select NewParent from updunique where UID=id_local)
,genealogy=(select newGen from updunique where uid=id_local)
WHERE
id_local in (select uid from updunique)