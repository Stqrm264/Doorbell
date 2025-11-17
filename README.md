# Doorbell with password

Just a small project because i got bored during a course about finite state machines.

The project is made up of 3 parts: the keypad, the door, and the house

The keypad accepts 4 digit PIN, with a "clear" and "ring" button. The correct PIN is 4321. When the user inputs the correct PIN, the door opens. Otherwise, the currently entered digits are cleared.<br>
The user can also press the "ring" button, which sends a signal to the "house"

The house has 2 buttons: Accept and Reject. As the name imlpies, the user can press them in order to open, or close, the door when the keypad sends the "ring" signal