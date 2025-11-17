class_name House
extends Control

enum State {
	CLOSED, RINGING, OPEN
}

var state: State = State.CLOSED
@onready var text: Label = %HouseLabel
@onready var accept: Button = %Accept
@onready var reject: Button = %Reject
func set_state(new_state: State) -> void:
	if new_state == State.RINGING:
		text.text = "Ringing..."
		accept.disabled = false
		reject.disabled = false
	elif new_state == State.OPEN:
		text.text = "Door is open"
		accept.disabled = true
		reject.disabled = true
	elif new_state == State.CLOSED:
		text.text = "Door is closed"
		accept.disabled = true
		reject.disabled = true
	state = new_state

signal accepted
func accept_pressed() -> void:
	if state != State.RINGING:
		printerr("House buttons should not be pressable when house state is not RINGING");
		return
	set_state(State.OPEN)
	accepted.emit()

signal rejected
func reject_pressed() -> void:
	if state != State.RINGING:
		printerr("House buttons should not be pressable when house state is not RINGING");
		return
	set_state(State.CLOSED)
	rejected.emit()

