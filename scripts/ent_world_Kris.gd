extends Area2D

var moving = false
var velocity = Vector2()

var speed = 200

func move(direction):
	moving = true
	
	if direction == "up":
		velocity.y -= speed
		
		if velocity.x == 0:
			$AnimatedSprite.animation = "walk_up"
	elif direction == "down":
		velocity.y += speed
		if velocity.x == 0:
			$AnimatedSprite.animation = "walk_down"
		
	elif direction == "left":	
		velocity.x -= speed
		if velocity.y == 0:	
			$AnimatedSprite.animation = "walk_left"
		
	elif direction == "right":		
		velocity.x += speed
		if velocity.y == 0:	
			$AnimatedSprite.animation = "walk_right"
	
	$AnimatedSprite.play()
	
var control_map = {
	"left": {
		"input": "ui_left", 
		"action": funcref(self, "move"),
		"args": "left"
	}, 
	"right": {
		"input": "ui_right", 
		"action": funcref(self, "move"),
		"args": "right"
	},
	"up": {
		"input": "ui_up", 
		"action": funcref(self, "move"),
		"args": "up"
	}, 
	"down": {
		"input": "ui_down", 
		"action": funcref(self, "move"),
		"args": "down"
	} 
}


var screen_size = 0

func _ready():
	screen_size = get_viewport_rect().size

# warning-ignore:unused_argument
func _process(delta):
	moving = velocity.length() > 0
	velocity = Vector2()
	
	for key in control_map.keys():
		if Input.is_action_pressed(control_map[key]["input"]) == true:
			control_map[key]["action"].call_func(control_map[key]["args"])
			
	if moving == false:
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()
