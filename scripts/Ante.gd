class_name Ante extends Control


const INITIAL_DECK : Array = [
	# 52 initial standard playing cards 
	# 2-10, J (11) , Q (12) , K (13) , A (14)
	# H (hearts), S (spades), C (clubs), D (diamonds)
	[2, 'H'], [3, 'H'], [4, 'H'], [5, 'H'], [6, 'H'], [7, 'H'], [8, 'H'], [9, 'H'], [10, 'H'], [11, 'H'], [12, 'H'], [13, 'H'], [14, 'H'],
	[2, 'S'], [3, 'S'], [4, 'S'], [5, 'S'], [6, 'S'], [7, 'S'], [8, 'S'], [9, 'S'], [10, 'S'], [11, 'S'], [12, 'S'], [13, 'S'], [14, 'S'],
	[2, 'C'], [3, 'C'], [4, 'C'], [5, 'C'], [6, 'C'], [7, 'C'], [8, 'C'], [9, 'C'], [10, 'C'], [11, 'C'], [12, 'C'], [13, 'C'], [14, 'C'],
	[2, 'D'], [3, 'D'], [4, 'D'], [5, 'D'], [6, 'D'], [7, 'D'], [8, 'D'], [9, 'D'], [10, 'D'], [11, 'D'], [12, 'D'], [13, 'D'], [14, 'D']
]

var deck : Array = INITIAL_DECK


const MAX_CARDS_IN_HAND : int = 5
const MAX_DISCARDS : int = 6
var player1_hand : Array 
var player2_hand : Array 
var player1_discard_count : int 
var player2_discard_count : int 
var player1_money : int 
var player2_money : int
var current_turn = 1 # 1 or 2

# prevent player from checking during discard animations
var can_check : bool = true

class DeckSorter:
	static func sort_ascending(a, b):
		if a[0] < b[0]: 
			return true
		return false
		

func _ready():
	start_new_ante()
	

func start_new_ante():
	# TODO: use randomize as .shuffle produces the same result over and over.
	$TurnInterface.visible = false
	
	randomize()
	deck.shuffle()
	current_turn = 1
	player1_hand = []
	player2_hand = []
	player1_discard_count = MAX_DISCARDS
	player2_discard_count = MAX_DISCARDS
	player1_money = 6
	player2_money = 6
	for i in MAX_CARDS_IN_HAND:
		player1_hand.append(deck.pop_back())
		player2_hand.append(deck.pop_back())
	player1_hand.sort_custom(DeckSorter, "sort_ascending")
	player2_hand.sort_custom(DeckSorter, "sort_ascending")
	start_new_round()


func start_new_round():
#	print(player1_hand)
	var i1 : int = 1
	while i1 <= 5:
		get_node("Player1Hand/Card" + str(i1)).position = $DeckControl/DeckSprite.global_position
		get_node("Player1Hand/Card" + str(i1)).owner_of_hand = 1
		get_node("Player1Hand/Card" + str(i1)).index = i1
		get_node("Player1Hand/Card" + str(i1)).set_texture_to_face_down()
		i1 += 1
	yield(get_tree().create_timer(0.2),"timeout")
	$AnimationPlayer.play("Player1DistributeHand")
	


func flip_up_card_texture():
	var player_1_counter = 1
	for card in player1_hand:
		var number : int = card[0]
		var suit : int
		match card[1]:
			'H':
				suit = 0
			'S':
				suit = 1
			'C':
				suit = 2
			'D':
				suit = 3
		get_node("Player1Hand/Card" + str(player_1_counter)).set_card_texture(number, suit) 
		player_1_counter += 1
		yield(get_tree().create_timer(0.075), "timeout")
#		print(number, suit)
	
	$TurnInterface.visible = true

func sort_player1_hand_after_discard():
#	print(player1_hand)
	player1_hand.sort_custom(DeckSorter, "sort_ascending")
	flip_up_card_texture()
	


func _on_CheckButton_pressed():
	if can_check:
		if current_turn == 1:
			print("Player 1 hand: " + str(PokerHand.check_hand_to_string(player1_hand)))
		elif current_turn == 2:
			pass


