class_name Card extends Sprite

enum NUMBER {
	TWO = 2, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE
}
enum SUITS {
	HEARTS = 0, SPADES, CLUBS, DIAMONDS
}

enum OWNER {
	PLAYER_1 = 1, PLAYER_2 = 2
}

export (NUMBER) var number
export (SUITS) var suit
export (OWNER) var owner_of_hand

const SPEED : int = 4000
var destination : Vector2
var is_being_discarded : bool = false
onready var deck_position : Vector2 = get_parent().get_parent().get_node("DeckControl/DeckSprite").global_position

func _ready():
	$MouseDetectorArea2D/CollisionShape2D.disabled = true

func set_texture_to_face_down():
	texture.set_region(Rect2(0, 64, 12, 16))
	
func set_card_texture(number : int, suit : int):
	var region_x : int = 12 * (number - 2)
	var region_y : int = 16 * suit
	texture.set_region(Rect2(region_x, region_y, 12, 16))
	$MouseDetectorArea2D/CollisionShape2D.disabled = false


func _process(delta):
	if is_being_discarded:
		position += position.direction_to(destination) * SPEED * delta
		
		# putting the card face down in the deck.
		if position == destination:
			is_being_discarded = false
			set_texture_to_face_down()
			position = deck_position


func _on_MouseDetectorArea2D_mouse_entered():
	pass
func _on_MouseDetectorArea2D_mouse_exited():
	pass # Replace with function body.


func _on_MouseDetectorArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left_mouse_click"):
			print("card clicked")
			# for testing only 
			discard()

func discard():
	if owner_of_hand == OWNER.PLAYER_1:
		destination = get_parent().get_parent().get_node("Player1DiscardPosition2D").global_position
	elif owner_of_hand == OWNER.PLAYER_2:
		destination = get_parent().get_parent().get_node("Player2DiscardPosition2D").global_position
	$MouseDetectorArea2D/CollisionShape2D.disabled = true
	is_being_discarded = true
	
