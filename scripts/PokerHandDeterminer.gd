class_name PokerHandDeterminer extends Node2D

enum  {
	# 0 - 8
	HIGH_CARD, 
	ONE_PAIR,
	TWO_PAIR,
	THREE_OF_A_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	FOUR_OF_A_KIND,
	STRAIGHT_FLUSH
}

class DeckSorter:
	static func sort_ascending(a, b):
		if a[0] < b[0]: 
			return true
		return false

static func determine_hand(hand : Array) -> int:
	hand.sort_custom(DeckSorter, "sort_ascending")
	if is_four_of_a_kind(hand):
		return FOUR_OF_A_KIND
	
	return -1

static func is_four_of_a_kind(hand : Array) -> bool:
	return hand[0][9] == hand[3][0] or hand[1][0] == hand[4][0]

