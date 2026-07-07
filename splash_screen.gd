extends Control

const WARNING_TEXT = (
	"⚠️ SYSTEM WARNING & LIABILITY WAIVER ⚠️\n\n" +
	"This is an unstable educational test build. The engine is heavily broken as we are learning " +
	"the development ropes. By clicking ACKNOWLEDGE, you agree that you are running this software " +
	"entirely AT YOUR OWN RISK. Not all buttons, layouts, options, or server handshakes are functional. " +
	"Once the game has finished loading, you'll see a message letting you know it's safe to press the SPACEBAR in the output window at the bottom of the screen.\n\n"+
	"💥 FAIL-SAFE ESCAPE BLOCK:\n" +
	"If you get permanently soft-locked or trapped in a broken menu compartment, force kill the game " +
	"instantly by: holding down [Numpad 5] then holding [Left Shift] and pressing [H]\n\n" +
	"🛠️ TICKETING & DEVELOPER ACCESS:\n" +
	"Have questions, concepts, bugs, or feedback? Head over to Twitch or type !discord in the chat " +
	"to join our server. Open a ticket in the help section to unlock access to the game-dev channel. " +
	"Yes, it's a complicated maze, but if you can follow these rules, you're ready for the studio booth!"
)

# ============================ NODE REFERENCES =================================
@onready var ls_output_logger: RichTextLabel = $LogWindow/LogPadding/LogScroller/ConsoleLog 
@onready var current_version_label: Label = $VersionNumber 

# --- Disclaimer System Nodes ---
@onready var disclaimer_popup: Window = $DisclaimerPopup
@onready var disclaimer_text: RichTextLabel = $DisclaimerPopup/PanelContainer/MarginContainer/VBoxContainer/DisclaimerText
@onready var acknowledge_btn: Button = $DisclaimerPopup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/AcknowledgeBtn
@onready var close_btn: Button = $DisclaimerPopup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/CloseBtn

# ======================== CORE SEQUENCE TRACKERS ==============================
var boot_sequence: Array[Dictionary] = [ 
	{"msg": "Initializing Studio Code Live core...", "type": "info"},
	{"msg": "Loading VFS (Virtual File System)...", "type": "info"},
	{"msg": "Checking custom configuration profiles...", "type": "system"},
	{"msg": "Evaluating legal and safety agreements...", "type": "system"}, # <-- New step added here
	{"msg": "Godot Engine bridge established.", "type": "success"},
	{"msg": "Indexing player scripts...", "type": "info"},
	{"msg": "Coffee levels low, attempting auto-brew...", "type": "warning"},
	{"msg": "Database connection ready.", "type": "success"},
	{"msg": "Launching main workspace...", "type": "system"}
]

## Direct list pointer determining which line context index is actively firing.
var current_line: int = 0
const SCREEN_PERCENTAGE = 0.8 


# ========================== ENGINE CORE METHODS ===============================
func _ready() -> void: 
	# --------------------------------------------------------------------------
	# SECTION 1: FLUID APPLICATION MONITOR WINDOW SCALING
	# Calculates hardware bounds and scales app dimensions proportionally.
	# --------------------------------------------------------------------------
	var monitor_size = DisplayServer.screen_get_size() 
	var target_width = int(monitor_size.x * SCREEN_PERCENTAGE) 
	var target_height = int(monitor_size.y * SCREEN_PERCENTAGE) 
	
	# Commit target bounds back to engine display thread
	DisplayServer.window_set_size(Vector2i(target_width, target_height)) 

	# Calculate hardware midpoint offsets to properly center our scaled viewport rectangle
	var screen_idx = DisplayServer.window_get_current_screen() 
	var screen_center := DisplayServer.screen_get_position(screen_idx) + (DisplayServer.screen_get_size(screen_idx) / 2) 
	var window_pos = screen_center - (Vector2i(target_width, target_height) / 2) 
	DisplayServer.window_set_position(window_pos) 

	# --------------------------------------------------------------------------
	# SECTION 2: UI DATA COMPONENT INITIALIZATION
	# Prepares text buffers and binds signal connections before layout render ticks.
	# --------------------------------------------------------------------------
	ls_output_logger.text = "" 
	disclaimer_text.text = WARNING_TEXT
	current_version_label.text = SclGlobal.dev_build_version
	
	# Bind event signals manually to decouple layout triggers from strict engine configurations
	acknowledge_btn.pressed.connect(_on_acknowledge_pressed)
	close_btn.pressed.connect(_on_close_pressed)
	disclaimer_popup.close_requested.connect(_on_close_pressed) # Handles window top right 'X' button
	
	# Push execution down one engine pipeline frame so layout nodes finish scaling inside parent bounds
	await get_tree().process_frame 
	run_boot_log() 

# ======================== CUSTOM UTILITY CONTROLLERS ==========================

## Track if the boot logger sequence has fully executed to unlock player transitions.
var boot_completed: bool = false

## Loops through the loading array data pairing steps with specialized background execution loops.
func run_boot_log() -> void: 
	if current_line < boot_sequence.size():
		var step = boot_sequence[current_line] 
		
		# ----------------------------------------------------------------------
		# INTERCEPT INDEX 2: Configuration Validation Check
		# Evaluates hardware system access and builds file profiles.
		# ----------------------------------------------------------------------
		if current_line == 2:
			SclGlobal.verify_or_initialize_settings() 
			
		# ----------------------------------------------------------------------
		# INTERCEPT INDEX 3: Legal Disclaimer Guard Clause
		# Suspends loading if profile contains unconfirmed compliance state.
		# ----------------------------------------------------------------------
		if current_line == 3:
			if not SclGlobal.is_disclaimer_accepted(): 
				SclGlobal.log_to_ui(ls_output_logger, "Action Required: User disclaimer prompt active.", "warning") 
				disclaimer_popup.popup_centered() 
				return # HALT execution path loop context here. 

		# Safe deployment of text line context back into global UI display module
		SclGlobal.log_to_ui(ls_output_logger, step["msg"], step["type"])
		
		# Advance index and loop back with dynamic pacing delays
		current_line += 1 
		var delay = randf_range(0.2, 0.5) 
		get_tree().create_timer(delay).timeout.connect(run_boot_log) 
	else:
		# Finalize loading process visual changes
		SclGlobal.log_to_ui(ls_output_logger, "Boot sequence completed successfully.", "success") 
		SclGlobal.log_to_ui(ls_output_logger, "[color=cyan][ PRESS SPACEBAR TO ENTER BOOTH ][/color]", "info")
		
		# Flip the guard lock switch to open keyboard listener checks
		boot_completed = true


# ======================== ENGINE INPUT EVENT ROUTINES =========================

## Listens to general device interrupts natively outside structural scene tick frames.
func _unhandled_input(event: InputEvent) -> void:
	# 1. Guard Clause: Block key processing if the compiler script loop is still active
	if not boot_completed:
		return
		
	# 2. Check if the input event is an explicit single keyboard button click downward match
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		# Filter to ensure the exact keycode context is KEY_SPACE
		if event.keycode == KEY_SPACE:
			print("🎬 UI Navigation: Spacebar acknowledged. Redirecting to core application...")
			SclGlobal.log_to_ui(ls_output_logger, "Spacebar pressed. Transitioning to main workspace...", "system")
			trigger_workspace_transition()


## Handles scene cleanup operations and passes controller focus over to your main level array.
func trigger_workspace_transition() -> void: 
	# Small logging visual feedback confirmation line
	SclGlobal.log_to_ui(ls_output_logger, "Launching Main Workspace Frame...", "system")
	
	# Short buffer frame block so the user can see the confirmation text render
	await get_tree().create_timer(2).timeout
	SclGlobal.log_to_ui(ls_output_logger, "Workspace launch complete. Enjoy your session!", "success")
	
	# --- ROADMAP SCENE TRANSITION CHANGE ---
	# Replace the path below with your actual main workspace level layout scene (.tscn) path when built!
	get_tree().change_scene_to_file("res://title_screen.tscn")
	
	# ----------------------------------------

# ============================= SIGNAL CALLBACKS ===============================


## Fired when player confirms application testing bounds and liability release data profile.
func _on_acknowledge_pressed() -> void:
	disclaimer_popup.hide()
	SclGlobal.save_custom_setting("disclaimer_accepted", true) 
	SclGlobal.log_to_ui(ls_output_logger, "Disclaimer accepted successfully by user.", "success")
	
	# Step index past intercept and manually resume loop process
	current_line += 1
	run_boot_log()

## Fired when user selects close option or triggers top-right corner closure window button elements.
func _on_close_pressed() -> void:
	# Close popup window out of structural viewport area
	disclaimer_popup.hide()
	# Log and save negative response flag back down into system file storage arrays
	SclGlobal.save_custom_setting("disclaimer_accepted", false) 
	SclGlobal.log_to_ui(ls_output_logger, "System Shutdown: User declined terms assignment profile.", "error")
	
	# RESUME STREAM LOGIC: Application keeps processing loading loop sequences safely instead of quitting!
	##	await get_tree().create_timer(1.0).timeout	#<- old logic to delay quit, now removed for smoother exit
	##	get_tree().quit()	#<- old logic to quit, now removed for smoother exit
	current_line += 1
	run_boot_log()
