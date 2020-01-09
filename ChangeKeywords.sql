WITH KWUpdate as (
SELECT
	K1.id_local AS NewID
	,K1.lc_name AS KW1
	,K1.parent AS P1
	,K2.id_local AS OldID
	,K2.lc_name AS KW2
	,K2.parent AS P2
FROM
	AgLibraryKeyword K1
LEFT JOIN
	AgLibraryKeyword K2
	ON K2.lc_name = K1.lc_name
WHERE
	
	K1.parent=1840358
	--AND (K1.parent is null or K1.parent<>1840358)
)

SELECT
	FI.baseName
	,K.KW1
	,K.NewID
	,KW1.name AS PName1
	,K.KW2
	,K.OldID
	,KW2.name AS PName2
FROM
	AgLibraryKeywordImage KI
INNER JOIN
	KWUpdate K
	ON KI.tag=K.OldID
LEFT JOIN
	Adobe_images AI
	ON AI.id_local=KI.image
LEFT JOIN
	AgLibraryFile FI
	ON FI.id_local=AI.rootFile
LEFT JOIN
	AgLibraryKeyword KW1
	ON KW1.id_local=K.P1
LEFT JOIN
	AgLibraryKeyword KW2
	ON KW2.id_local=K.P1
