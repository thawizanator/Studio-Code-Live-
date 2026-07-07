extends Control

#=========================== NODE REFERENCES =================================
@onready var host_button: Button = $TitleScreen/ButtonBox/StreamerHostBtn
@onready var player_button: Button = $TitleScreen/ButtonBox/PlayerBtn
@onready var settings_button: Button = $TitleScreen/ButtonBox/GameSettingsBtn
@onready var exit_button: Button = $TitleScreen/ButtonBox/ExitBtn
@onready var log_output: Label = $TitleScreen/OutPutLogLbl


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
