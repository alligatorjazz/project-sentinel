extends CanvasLayer

onready var container = $TextboxContainer
onready var background = $TextboxContainer/Background
onready var prefix = $TextboxContainer/MarginContainer/Content/Asterisk
onready var message = $TextboxContainer/MarginContainer/Content/Message

# Called when the node enters the scene tree for the first time.
func _ready():
	clear()
	hide()

func clear():
	message.text = ""
	
func hide():
	container.hide()

func show():
	container.show()

func print_message(new_text, scroll_speed = 0.05):
	clear()
	message.text = new_text
	var duration = len(new_text) * scroll_speed
	$Tween.interpolate_property(message, "percent_visible", 0.0, 1.0, duration, Tween.TRANS_LINEAR,
	 Tween.EASE_IN_OUT)
	$Tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


var test_msgs = [
	"I am making an Deltarune fangame. It will run in Godot as opposed to Game Maker.",
	"This means I must port every piece of the game's systems to a new engine. Not a trival task.",
	"I am also new to developing in Godot, having used Python for game projects in the past.",
	"Learning how to make this textbox scroll was surprisingly difficult. Please recognize my efforts. It is 4:20am.",
	"Nice."
	]

#func delay(seconds):
#	print("timer started")
#	yield(get_tree().create_timer(seconds), "timeout")
#	print("timer ended")
var msg = 0
func _on_Button_pressed():
	print_message(test_msgs[msg])
	msg += 1
	
	


func _on_Button2_pressed():
	show()
