extends Node2D

func cambiarFrame(frame: int) -> void:
	match frame:
		0:
			$Sprite2D.frame = 0
		1:
			$Sprite2D.frame = 1
		2:
			$Sprite2D.frame = 2
		3:
			$Sprite2D.frame = 3
		4:
			$Sprite2D.frame = 4
		5:
			$Sprite2D.frame = 5
