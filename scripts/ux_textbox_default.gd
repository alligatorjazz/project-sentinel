extends CanvasLayer

class_name Textbox

# TODO: dynamically calculate text limits
var character_limit: int = 163
var block_limit: int = 4

onready var container: = $TextboxContainer
onready var background: = $TextboxContainer/Background
onready var content: = $TextboxContainer/MarginContainer/Content
onready var text_container: = $TextboxContainer/MarginContainer/Content/TextBlocks

# container control
func _ready() -> void:
	hide()
	

func clear() -> void:
	
	for child in text_container.get_children():
		child.queue_free()
		
func hide() -> void:
	container.hide()

func show() -> void:
	container.show()

func _new_message_block(text, font) -> HBoxContainer:
	var message_block := HBoxContainer.new()
	message_block.set_name("MessageBlock")
	message_block.rect_clip_content = true
	
	var prefix: = Label.new()
	prefix.text = "*"
	prefix.set_name("Prefix")
	prefix.add_font_override("font", load(font))
	prefix.set_h_size_flags(1)
	prefix.set_v_size_flags(1)
	
	
	var text_label: = Label.new()
	text_label.text = text
	text_label.set_name("TextLabel")
	text_label.add_font_override("font", load(font))
	text_label.autowrap = true
	text_label.set_h_size_flags(3)
	text_label.set_v_size_flags(3)
	
	message_block.add_child(prefix)
	message_block.add_child(text_label)
	
	return message_block
	
# adding nodes
#var node = Spatial.new()
## the parent can be get_tree().get_root() or some other node
#parent.add_child(node)
## ownership is different, I think it's not the same root as the root node
#node.set_owner(get_tree().get_edited_scene_root())

func print_message(message) -> void:
	print(container.rect_clip_content)
	clear()
	print(container.rect_clip_content)
	if len(message.blocks) > block_limit:
		push_warning("{textbox} is printing message {message} which will clip off-screen due to exceeding block limit".format({"textbox": self, "message": message}))
	
	if message._length > character_limit:
		push_warning("{textbox} is printing message {message} which will clip off-screen due to exceeding character limit".format({"textbox": self, "message": message}))
	
	for block in message.blocks:
		# adds a new block (asterisk + message text) to the text_container
		
		var duration: float = len(block) * message.speed
		var text_block: = _new_message_block(block, message.font)
		text_container.add_child(text_block)
		
		text_block.get_node("TextLabel").percent_visible = 0.0
		
		# activates the scrolling effect
		$Tween.interpolate_property(text_block.get_node("TextLabel"), "percent_visible", 0.0, 1.0, duration, Tween.TRANS_LINEAR,
		 Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_all_completed")


var test_msgs: = [
	Message.new(["This is a message with one block."]),
	Message.new(["This is a message with...", "two blocks."])
]

# debug for testing
var msg = 0
func _on_Button_pressed():
	show()
	print_message(test_msgs[msg])
	if msg == len(test_msgs) - 1:
		msg = 0
	else:
		msg += 1
