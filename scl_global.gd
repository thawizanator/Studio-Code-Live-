extends Node
# Alternatively, you can just use 'class_name SclGlobal' if you don't need it as an Autoload node

# This variable will populate itself on application boot sequence
var dev_build_version: String = "0.0.0-Fallback"

# One config file for everything
const SAVE_PATH = "user://studio_settings.cfg"

# EXAMPLE USAGE REFERENCE:
# ------------------------------------------------------------------------------
#						MAKE SURE TI USE RICHTEXTLABEL AS THE TARGET LABEL
# @onready var my_log_label: RichTextLabel = $MyScrollContainer/RichTextLabel
#
# func _ready() -> void:
#     # Clear default text if needed
#     my_log_label.text = "" 
#
#     # Basic usage examples:
#     SclGlobal.log_to_ui(my_log_label, "System initialization started.") # Defaults to "info"
#     SclGlobal.log_to_ui(my_log_label, "VFS mounted successfully.", "success")
#     SclGlobal.log_to_ui(my_log_label, "Coffee levels critical!", "warning")
#     SclGlobal.log_to_ui(my_log_label, "Failed to connect to indexer.", "error")
#     SclGlobal.log_to_ui(my_log_label, "Workspace live.", "system")
# ==============================================================================
## Appends a formatted message to a target RichTextLabel
func log_to_ui(target_label: RichTextLabel, message: String, type: String = "info") -> void:
	if not is_instance_valid(target_label):
		push_warning("Logger: Target RichTextLabel is invalid or has been freed.")
		return
	
	var color: String = "gray"
	var prefix: String = "INFO"
	
	# Determine color and prefix based on the log type
	match type.to_lower():
		"success":
			color = "green"
			prefix = "SUCCESS"
		"warning":
			color = "yellow"
			prefix = "WARNING"
		"error":
			color = "red"
			prefix = "ERROR"
		"system":
			color = "cyan"
			prefix = "SYSTEM"
		_:
			color = "gray"
			prefix = "INFO"
			
	# Format using BBCode
	var formatted_message: String = "[color=%s]%s:[/color] %s\n" % [color, prefix, message]
	
	# Append the text to the target label
	target_label.append_text(formatted_message)

#========================ON READY FUNCTION========================
func _ready() -> void:
	# Read directly from Project Settings -> Config -> Version
	if ProjectSettings.has_setting("application/config/version"):
		dev_build_version = ProjectSettings.get_setting("application/config/version")
	else:
		dev_build_version = "v0.4-Alpha-Dev" # Safeguard fallback
		
	print("🚀 System Boot Successful. Operating Build Profile: ", dev_build_version)





#=======================Verify or Initialize Settings File========================
## Checks if the settings file exists. If not, it creates it with baseline defaults.
func verify_or_initialize_settings(target_label: RichTextLabel = null) -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var configExists = "Config System: Existing studio profile detected."
		print("📂 " + configExists)
		log_to_ui(target_label, configExists, "success")
		return
	
	var configExistsB = "Config System: No settings file found. Initializing default profile..."	
	print("✨ " + configExistsB)	
	log_to_ui(target_label, configExistsB, "error")
	
	var config = ConfigFile.new()
	
	# --- Define your baseline defaults here ---
	config.set_value("StudioCustom", "is_first_boot", true)
	config.set_value("StudioCustom", "theme_mode", "dark_ide")
	config.set_value("StudioCustom", "master_volume", 0.8)
	config.set_value("StudioCustom", "show_fps", false)
	config.set_value("StudioCustom", "disclaimer_accepted", false)
	# ------------------------------------------
	
	var error = config.save(SAVE_PATH)
	if error == OK:
		var fileCreated = "Default configuration profile initialized successfully"
		print("💾 "+fileCreated+" at: ", SAVE_PATH)
		log_to_ui(target_label, fileCreated, "success")
	else:
		var fileCreatedError = "Config System Error: Failed to write initial defaults."
		print("⚠️ "+fileCreatedError+" Code: ", error)
		log_to_ui(target_label, fileCreatedError, "error")

#=======================Custom Cofig Save Function========================
# Save new setting to CONFIG
func save_custom_setting(setting_key: String, setting_value: Variant) -> void:
	# 1. Initialize a temporary configuration processor object
	var config = ConfigFile.new()
	
	# 2. OPTIONAL but recommended: Load existing file settings so we preserve them
	if FileAccess.file_exists(SAVE_PATH):
		config.load(SAVE_PATH)
		
	# 3. Add or update your setting value inside a specific section block
	# Format: config.set_value("Section", "Key", Value)
	config.set_value("StudioCustom", setting_key, setting_value)
	
	# 4. Commit the modifications back into the local user folder storage directory
	var error = config.save(SAVE_PATH)
	
	# Verification validation logs
	if error == OK:
		print("💾 Saved custom property [", setting_key, ": ", setting_value, "] to configuration profile!")
	else:
		print("⚠️ Failed to write to config file. Error structure identifier code: ", error)

#=======================DISCLAIMER ACCEPTANCE CHECK========================
#=======================need to change this to a config file settings lookup
#=======================instead of be a single dedicated function for one item
## Helper to check if the disclaimer has been accepted yet
func is_disclaimer_accepted() -> bool:
	if FileAccess.file_exists(SAVE_PATH):
		var config = ConfigFile.new()
		config.load(SAVE_PATH)
		return config.get_value("StudioCustom", "disclaimer_accepted", false)
	return false

#========================Fail Safe Game Close Function========================

# ==============================================================================
# SclGlobal (scl_global.gd) - Emergency Input Infrastructure Management Profile
# ==============================================================================
# EXAMPLE USAGE & EXECUTION REFERENCE:
# ------------------------------------------------------------------------------
# Because this script is registered as a project Autoload (Singleton), Godot 
# initializes it instantly when the application runtime starts. 
#
# The built-in _process() function runs automatically on every single frame tick,
# regardless of which scene is currently loaded (Splash, Menu, or Workspace).
#
# TRIGGER COMBINATION: Hold down [ LEFT SHIFT ] + [ H ] + [ NUMPAD 5 ]
# ==============================================================================

# ======================== ENGINE CORE PROCESS LOOPS ===========================

## Automatically invoked by the engine core on every visible render frame pipeline tick.
func _process(_delta: float) -> void:
	# Keep checking the hardware keyboard buffer array state every single frame
	check_emergency_kill()


# ======================== FAIL-SAFE SYSTEM UTILITIES ==========================

## Explicitly checks physical hardware scan keys for our hard emergency termination sequence.
func check_emergency_kill() -> void:
	# Read the instantaneous hardware click state of all three keys simultaneously
	if Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_H) and Input.is_key_pressed(KEY_KP_5):
		print("☢️ GLOBAL OVERRIDE: Emergency system kill triggered via Singleton thread context.")
		
		# Command the engine execution tree branch to gracefully terminate immediately
		get_tree().quit()