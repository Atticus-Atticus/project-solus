extends Node

const BASE_DIR := "user://ProjectSolus"
const USER_FILE := BASE_DIR + "/User.txt"
const DEFAULT_USER := "USER"

var current_username: String = DEFAULT_USER
var user_status: String = "default"  # "default", "new", "returning", "secret"

var secret_users := {
	"Calihan": "Welcome Employee. Remember: Light Speed. Right Speed.",
	"Naomi": "Redirected Signal detected... Welcome back, Agent Niobe.",
	"Polaris": "ERROR",
	"Atticus": "bruh"
}

func _ready() -> void:
	print("[UserManager] Ready. user_data_dir:", OS.get_user_data_dir())
	_ensure_storage()
	current_username = _load_username()
	print("[UserManager] Loaded username:", current_username)


func _ensure_storage() -> void:
	# Ensure folder exists under user://
	var dir := DirAccess.open("user://")
	if dir == null:
		print("[UserManager] ERROR: Could not open user://")
		return

	# Create ProjectSolus folder (relative to user://)
	if not dir.dir_exists("ProjectSolus"):
		var mk := dir.make_dir_recursive("ProjectSolus")
		if mk != OK:
			print("[UserManager] Failed to create ProjectSolus folder. error:", mk)
		else:
			print("[UserManager] Created ProjectSolus folder.")
	else:
		print("[UserManager] ProjectSolus folder exists.")

	# Create user file if missing
	if not FileAccess.file_exists(USER_FILE):
		print("[UserManager] User file missing -> creating:", USER_FILE)
		_write_username(DEFAULT_USER)
	else:
		print("[UserManager] User file exists:", USER_FILE)


func _write_username(username: String) -> void:
	var f := FileAccess.open(USER_FILE, FileAccess.WRITE)
	if f == null:
		print("[UserManager] FAILED to open for write:", USER_FILE)
		return
	f.store_line(username)
	print("[UserManager] Wrote username:", username)


func _load_username() -> String:
	if not FileAccess.file_exists(USER_FILE):
		return DEFAULT_USER

	var f := FileAccess.open(USER_FILE, FileAccess.READ)
	if f == null:
		return DEFAULT_USER

	var saved_username := f.get_line().strip_edges()
	return DEFAULT_USER if saved_username.is_empty() else saved_username


func process_entered_username(input_name: String) -> void:
	var clean := input_name.strip_edges()
	if clean.is_empty():
		clean = DEFAULT_USER

	var saved := _load_username()

	print("[UserManager] Entered:", clean, " Saved:", saved)

	if secret_users.has(clean):
		user_status = "secret"
		current_username = clean
		if clean != saved:
			_write_username(clean)
		return

	if clean == saved:
		user_status = "returning"
		current_username = clean
		return

	user_status = "new"
	current_username = clean
	_write_username(clean)


func get_welcome_message() -> String:
	match user_status:
		"secret":
			return secret_users[current_username]
		"returning":
			return "Welcome back, %s" % current_username
		"new":
			return "New User detected. Welcome %s" % current_username
		_:
			return "Welcome %s to..." % current_username
