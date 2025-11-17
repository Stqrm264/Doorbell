class_name Dials
extends Control

enum State {
	NORMAL, RINGING, WAITING
}

var state: State = State.NORMAL
func set_state(new_state: State) -> void:
	if new_state == State.NORMAL:
		enable_buttons()
		clear()
	elif new_state == State.RINGING:
		disable_buttons()
		display.text = "Ringing..."
	elif new_state == State.WAITING:
		disable_buttons()
		display.text = "Waiting..."
	state = new_state

func enable_buttons() -> void:
	for row: HBoxContainer in input_rows.get_children():
		for button: Button in row.get_children():
			button.disabled = false

func disable_buttons() -> void:
	for row: HBoxContainer in input_rows.get_children():
		for button: Button in row.get_children():
			button.disabled = true

@onready var input_rows: VBoxContainer = %InputRows;
func _ready() -> void:
	for row_number: int in range(0, 3):
		var row: HBoxContainer = input_rows.get_node("Row" + str(row_number))
		for j: int in range(row_number * 3, row_number * 3 + 3):
			var button: Button = row.get_node(str(j + 1))
			button.pressed.connect(digit_pressed.bind(j + 1))
	# Separate case for row 3
	var row3: HBoxContainer = input_rows.get_node("Row3")
	(row3.get_node("clear") as Button).pressed.connect(clear);
	(row3.get_node("0") as Button).pressed.connect(digit_pressed.bind(0));
	(row3.get_node("ring") as Button).pressed.connect(ring);

@onready var display: Label = %Display
var digits: Array[int] = []
func enter_digit(x: int) -> void:
	digits.append(x)
	var text: String = ""
	for a: int in digits:
		text += str(a)
	display.text = text

signal open_door
func digit_pressed(x: int) -> void:
	enter_digit(x)
	if digits.size() == 4:
		if is_correct():
			set_state(State.WAITING)
			open_door.emit()
		clear()

var correct_digits: Array[int] = [4, 3, 2, 1]
func is_correct() -> bool:
	var ok: bool = true
	for i in range(0, 4):
		if digits[i] != correct_digits[i]:
			ok = false
			break
	return ok

func clear() -> void:
	digits = []
	display.text = ""

signal ringing
func ring() -> void:
	set_state(State.RINGING)
	ringing.emit()
