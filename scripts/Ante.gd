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
var current_turn = 1 # 1 or 2


func _ready():
	start_new_ante()
	

func start_new_ante():
	deck.shuffle()
	current_turn = 1
	player1_hand = []
	player2_hand = []
	player1_discard_count = MAX_DISCARDS
	player2_discard_count = MAX_DISCARDS
	for i in MAX_CARDS_IN_HAND:
		player1_hand.append(deck.pop_back())
		player2_hand.append(deck.pop_back())
	

func start_new_round():
	pass
	

#	print(PokerHand.determine_hand([[2, 'D'], [2, 'H'], [5, 'S'], [4, 'C'], [12, 'H']]))
