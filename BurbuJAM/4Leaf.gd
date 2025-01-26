extends State


# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	owner.alpha = 1.5
	owner.bullet_type = 1
	
func transition():
	if can_transition:
		get_parent().change_state("3Leaf")	
