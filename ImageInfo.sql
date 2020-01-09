WITH ImageDetails AS (
SELECT
	ai.id_local AS ai_id_local
	,rf.absolutePath
	,replace(rf.absolutePath||fo.pathFromRoot,'//','') as PathSpec
	,fi.baseName
	,fi.extension
	,ai.id_global AS ai_id_global
	,ai.aspectRatioCache AS ai_aspectRatioCache
	,ai.bitDepth AS ai_bitDepth
	,ai.captureTime AS ai_captureTime
	,ai.colorChannels AS ai_colorChannels
	,ai.colorLabels AS ai_colorLabels
	,ai.colorMode AS ai_colorMode
	,ai.copyCreationTime AS ai_copyCreationTime
	,ai.copyName AS ai_copyName
	,ai.copyReason AS ai_copyReason
	,ai.developSettingsIDCache AS ai_developSettingsIDCache
	,ai.fileFormat AS ai_fileFormat
	,ai.fileHeight AS ai_fileHeight
	,ai.fileWidth AS ai_fileWidth
	,ai.hasMissingSidecars AS ai_hasMissingSidecars
	,ai.masterImage AS ai_masterImage
	,ai.orientation AS ai_orientation
	,ai.originalCaptureTime AS ai_originalCaptureTime
	,ai.originalRootEntity AS ai_originalRootEntity
	,ai.panningDistanceH AS ai_panningDistanceH
	,ai.panningDistanceV AS ai_panningDistanceV
	,ai.pick AS ai_pick
	,ai.positionInFolder AS ai_positionInFolder
	,ai.propertiesCache AS ai_propertiesCache
	,ai.pyramidIDCache AS ai_pyramidIDCache
	,ai.rating AS ai_rating
	,ai.rootFile AS ai_rootFile
	,ai.sidecarStatus AS ai_sidecarStatus
	,ai.touchCount AS ai_touchCount
	,ai.touchTime AS ai_touchTime
	,ds.id_local AS ds_id_local
	,ds.allowFastRender AS ds_allowFastRender
	,ds.beforeSettingsIDCache AS ds_beforeSettingsIDCache
	,ds.croppedHeight AS ds_croppedHeight
	,ds.croppedWidth AS ds_croppedWidth
	,ds.digest AS ds_digest
	,ds.fileHeight AS ds_fileHeight
	,ds.fileWidth AS ds_fileWidth
	,ds.grayscale AS ds_grayscale
	,ds.hasDevelopAdjustments AS ds_hasDevelopAdjustments
	,ds.hasDevelopAdjustmentsEx AS ds_hasDevelopAdjustmentsEx
	,ds.historySettingsID AS ds_historySettingsID
	,ds.image AS ds_image
	,ds.processVersion AS ds_processVersion
	,ds.profileCorrections AS ds_profileCorrections
	,ds.removeChromaticAberration AS ds_removeChromaticAberration
	,ds.settingsID AS ds_settingsID
	,ds.snapshotID AS ds_snapshotID
	,replace(ds.text,char(10),'') AS ds_text
	,ds.validatedForVersion AS ds_validatedForVersion
	,ds.whiteBalance AS ds_whiteBalance
	,fi.id_local AS fi_id_local
	,fi.id_global AS fi_id_global
	,fi.baseName AS fi_baseName
	,fi.errorMessage AS fi_errorMessage
	,fi.errorTime AS fi_errorTime
	,fi.extension AS fi_extension
	,fi.externalModTime AS fi_externalModTime
	,fi.folder AS fi_folder
	,fi.idx_filename AS fi_idx_filename
	,fi.importHash AS fi_importHash
	,fi.lc_idx_filename AS fi_lc_idx_filename
	,fi.lc_idx_filenameExtension AS fi_lc_idx_filenameExtension
	,fi.md5 AS fi_md5
	,fi.modTime AS fi_modTime
	,fi.originalFilename AS fi_originalFilename
	,fi.sidecarExtensions AS fi_sidecarExtensions
	,rf.id_local AS rf_id_local
	,rf.id_global AS rf_id_global
	,rf.absolutePath AS rf_absolutePath
	,rf.name AS rf_name
	,rf.relativePathFromCatalog AS rf_relativePathFromCatalog
FROM
	Adobe_images ai
LEFT JOIN
	Adobe_imageDevelopSettings ds
	ON ai.id_local = ds.image
LEFT JOIN
	AgLibraryFolderStackImage fsi
	ON ai.id_local = fsi.image

LEFT JOIN
	AgLibraryFile fi on ai.rootFile = fi.id_local
LEFT JOIN
	AgLibraryFolder fo on fi.folder = fo.id_local 
LEFT JOIN
	AgLibraryRootFolder rf on fo.rootFolder = rf.id_local
)
SELECT
	*
FROM
	ImageDetails