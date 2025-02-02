class_name Card extends Sprite

enum NUMBER {
	TWO = 2, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE
}
enum SUITS {
	HEARTS = 0, SPADES, CLUBS, DIAMONDS
}

export (NUMBER) var number
export (SUITS) var suit

#func _ready():
#	set_card_texture(7, 3)


func set_texture_to_face_down():
	texture.set_region(Rect2(0, 64, 12, 16))
	
func set_card_texture(number : int, suit : int):
	var region_x : int = 12 * (number - 2)
	var region_y : int = 16 * suit
	texture.set_region(Rect2(region_x, region_y, 12, 16))


func _on_MouseDetectorArea2D_mouse_entered():
	pass
func _on_MouseDetectorArea2D_mouse_exited():
	pass # Replace with function body.


func _on_MouseDetectorArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_mouse_click"):
			print("card clicked")
