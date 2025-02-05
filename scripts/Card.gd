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

# position of card in hand
enum INDEX {
	FIRST = 1, SECOND, THIRD, FOURTH, FIFTH
}

export (NUMBER) var number
export (SUITS) var suit
export (OWNER) var owner_of_hand
export (INDEX) var index 

onready var ante_animation_player : AnimationPlayer = get_parent().get_parent().get_node("AnimationPlayer")
onready var ante : Control = get_parent().get_parent()

func _ready():
	$MouseDetectorArea2D/CollisionShape2D.disabled = true


func set_texture_to_face_down():
	texture.set_region(Rect2(0, 64, 12, 16))
	
func set_card_texture(number : int, suit : int):
	var region_x : int = 12 * (number - 2)
	var region_y : int = 16 * suit
	texture.set_region(Rect2(region_x, region_y, 12, 16))
	$MouseDetectorArea2D/CollisionShape2D.disabled = false




func _on_MouseDetectorArea2D_mouse_entered():
	pass
func _on_MouseDetectorArea2D_mouse_exited():
	pass # Replace with function body.


func _on_MouseDetectorArea2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("left_mouse_click"):
#		print("card clicked")
		# for testing only (ace of hearts) 
		if !ante.deck.empty() and !ante_animation_player.is_playing():
			discard(ante.deck.pop_back())

func discard(new_card : Array):
	ante.can_check = false
	ante_animation_player.play("Player" + str(owner_of_hand) + "Card" + str(index) + "Discard")
	$MouseDetectorArea2D/CollisionShape2D.disabled = true
	yield(get_tree().create_timer(0.4), "timeout")
	var number : int = new_card[0]
	var suit : int
	match new_card[1]:
		'H':
			suit = 0
		'S':
			suit = 1
		'C':
			suit = 2
		'D':
			suit = 3
	ante.player1_hand[index - 1] = [number, new_card[1]]
	set_card_texture(number, suit)
	ante_animation_player.play("Player" + str(owner_of_hand) + "Card" + str(index) + "Redraw")
	
	if owner_of_hand == OWNER.PLAYER_1:
		ante.sort_player1_hand_after_discard()
	
	$MouseDetectorArea2D/CollisionShape2D.disabled = false
	ante.can_check = true

