extends Control
# ==============================================================================
# title_screen.gd - Core Menu Controller for Studio Code Live!
# ==============================================================================
# 
# SCENE NODE STRUCTURAL HIERARCHY:
# ------------------------------------------------------------------------------
# TitleScreen (Control - Root)
#   ├── TextureRect (Background Cyberpunk Art Asset)
#   ├── ButtonBox (HBoxContainer - Interactive Option Group)
#   │     ├── StreamerHostBtn (Button - Pink Neon)
#   │     ├── PlayerBtn (Button - Blue Neon)
#   │     ├── GameSettingsBtn (Button - Yellow Neon)
#   │     └── ExitBtn (Button - Red Neon)
#   ├── OutPutLogLbl (Label - Top-Left Diagnostics Status)
#   └── TitleMusicPlayer (AudioStreamPlayer - Looping Background Music) <-- Added
# ==============================================================================

# ============================ NODE REFERENCES =================================

@onready var streamer_host_btn: Button = $ButtonBox/StreamerHostBtn
@onready var player_btn: Button = $ButtonBox/PlayerBtn
@onready var game_settings_btn: Button = $ButtonBox/GameSettingsBtn
@onready var exit_btn: Button = $ButtonBox/ExitBtn

@onready var output_log_lbl: Label = $OutPutLogLbl
@onready var title_music_player: AudioStreamPlayer = $TitleMusicPlayer


# ========================== ENGINE CORE METHODS ===============================

## Fired automatically when the node enters the running scene viewport tree array.
func _ready() -> void:
	# --------------------------------------------------------------------------
	# SECTION 1: INITIAL VISUAL INITIALIZATION
	# Sets baseline text strings when transitioning into the title window loop.
	# --------------------------------------------------------------------------
	print("🖥️ Scene Manager: Title Screen fully active.")
	output_log_lbl.text = "System Online // Build Profile: " + SclGlobal.dev_build_version
	
	# --------------------------------------------------------------------------
	# SECTION 2: SIGNAL SUBSCRIPTION CONNECTORS
	# Safely wires up button interactions to keep script functions isolated.
	# --------------------------------------------------------------------------
	streamer_host_btn.pressed.connect(_on_streamer_host_pressed)
	player_btn.pressed.connect(_on_player_pressed)
	game_settings_btn.pressed.connect(_on_game_settings_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

	# --------------------------------------------------------------------------
	# SECTION 3: BACKGROUND MUSIC PLAYER INITIALIZATION
	# Starts the looping background music track for the title screen.
	# --------------------------------------------------------------------------

	# TODO: REACTIVATE AUDOIO LATER 
	if is_instance_valid(title_music_player) and title_music_player.stream != null:
		#title_music_player.play()
		print("🎵 Audio System: Looping title screen background music initiated.")
	else:
		push_warning("Audio System Warning: TitleMusicPlayer missing or has no sound file assigned!")

# ============================= SIGNAL CALLBACKS ===============================

## Fired when the player selects the Streamer / Host booth button.
func _on_streamer_host_pressed() -> void:
	print("🎮 Menu Navigation: Initializing Streamer / Host workspace environment loop...")
	output_log_lbl.text = "Status: Connecting to stream host controller framework..."
	
	# EXAMPLE USAGE REFERENCE: HOW TO CHANGE SCENES IN THE GAME ROUTINE
	# --------------------------------------------------------------------------
	# get_tree().change_scene_to_file("res://scenes/streamer_workspace.tscn")
	# ==========================================================================


## Fired when selecting the Player button.
func _on_player_pressed() -> void:
	print("🎮 Menu Navigation: Loading player profile and terminal bays...")
	output_log_lbl.text = "Status: Mounting user script environment..."
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://player_screen.tscn")


## Fired when clicking the Settings icon button.
func _on_game_settings_pressed() -> void:
	print("🎮 Menu Navigation: Loading global application settings overlay panel...")
	output_log_lbl.text = "Status: Accessing configuration profile: " + SclGlobal.SAVE_PATH


## Fired when selecting the Exit Game option.
func _on_exit_pressed() -> void:
	print("🚪 System Shutdown: Gracefully disconnecting from Studio Code Live framework.")
	output_log_lbl.text = "Status: Killing active application engine layers..."
	
	# Pause execution momentarily so the user can read the text visual status update before closing
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()