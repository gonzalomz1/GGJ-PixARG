extends AnimatableBody2D

@export var fullSwing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if fullSwing:
		$AnimationPlayer.play("fullSwing")



