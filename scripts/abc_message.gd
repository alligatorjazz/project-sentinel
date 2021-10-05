extends Reference
class_name Message
# defines the data to be used by Textbox when writing messags to the screen

export var blocks: Array
export var portrait: String
export var font: String
export var speed: float
export var _length: int

func _init(new_blocks: Array = ["This is a dummy message. Something may have gone wrong."], new_portrait: String = "", new_font: String = "res://fonts/determination_mono.tres", new_speed: float = 0.05):

	# the intended text(s) in the message. every text will be displayed as a newline with an asterisk.
	blocks = new_blocks

	# the path to the portrait sprite
	portrait = new_portrait

	# the path to the message's font. defaults to determination mono
	font = new_font 

	# the speed at which the message scrolls across the text box.
	speed = new_speed
	
	# calculates the total length of the message, in characters. counts newlines as 
	var length: int = 0
	for block in self.blocks:
		length += len(block)
	
	self._length = length
	
