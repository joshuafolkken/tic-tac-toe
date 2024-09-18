class_name ExportCustomManifest
extends EditorExportPlugin

const MANIFEST_FILENAME := "manifest.json"
const MANIFEST_PATH = "res://web/" + MANIFEST_FILENAME

var _features: PackedStringArray
var _export_dir: String


func _get_name() -> String:
	return "ExportCustomManifest"


func copy_manifest(dest_path: String) -> void:
	var error := DirAccess.copy_absolute(MANIFEST_PATH, dest_path)

	if error != OK:
		push_error(
			(
				"Failed to copy manifest. Error code: %d\nSource: %s\nDestination: %s"
				% [error, MANIFEST_PATH, dest_path]
			)
		)
	else:
		print("Custom manifest.json copied successfully to: %s" % dest_path)


func _export_begin(features: PackedStringArray, _is_debug: bool, path: String, _flags: int) -> void:
	_features = features
	_export_dir = path.get_base_dir()


func _export_end() -> void:
	if "web" not in _features:
		return

	var dest_manifest_path := _export_dir.path_join("index." + MANIFEST_FILENAME)

	copy_manifest(dest_manifest_path)
