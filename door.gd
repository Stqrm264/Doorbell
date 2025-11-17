extends Control

@onready var close_button: Button = %Close
@onready var label: Label = %DoorLabel
@onready var color: ColorRect = label.get_node("Color")
func _ready() -> void:
	close_button.pressed.connect(close)

signal door_closed
func close() -> void:
	close_button.disabled = true
	door_closed.emit()
	label.text = "Closed"
	color.color = Color.RED

func open() -> void:
	close_button.disabled = false
	label.text = "Open"
	color.color = Color.GREEN