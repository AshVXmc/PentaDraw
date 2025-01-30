class_name PokerHand extends Object

enum {
	# 0 - 8
	HIGH_CARD, # 0
	ONE_PAIR, # 1
	TWO_PAIR, # 2
	THREE_OF_A_KIND, # 3
	STRAIGHT, # 4
	FLUSH, # 5
	FULL_HOUSE, # 6
	FOUR_OF_A_KIND, # 7
	STRAIGHT_FLUSH, # 8
	ROYAL_FLUSH # 9
}


class DeckSorter:
	static func sort_ascending(a, b):
		if a[0] < b[0]: 
			return true
		return false

# returns two values inside an array, hand type and points
static func determine_hand(hand : Array) -> Array:
	hand.sort_custom(DeckSorter, "sort_ascending")
	var points : int = 0
	
	print(hand)
	
	if is_royal_flush(hand):
		for card in hand:
			points += card[0]
		return [ROYAL_FLUSH, points]

	if is_straight_flush(hand):
		for card in hand:
			points += card[0]
		return [STRAIGHT_FLUSH, points]
	
	if is_four_of_a_kind(hand):
		if hand[0][0] == hand[3][0]:
			points += hand[0][0] + hand[1][0] + hand[2][0] + hand[3][0]
		elif hand[1][0] == hand[4][0]:
			points += hand[1][0] + hand[2][0] + hand[3][0] + hand[4][0]
		return [FOUR_OF_A_KIND, points]
	
	if is_full_house(hand):
		for card in hand:
			points += card[0]
		return [FULL_HOUSE, points]
	
	if is_flush(hand):
		for card in hand:
			points += card[0]
		return [FLUSH, points]
	
	if is_straight(hand):
		for card in hand:
			points += card[0]
		return [STRAIGHT, points]
	
	if is_three_of_a_kind(hand):
#		if hand[0][0] == hand[1][0] == hand[2][0]:
#			points += hand[0][0] + hand[1][0] + hand[2][0]
#		elif hand[1][0] == hand[2][0] == hand[3][0]:
#			points += hand[1][0] + hand[2][0] + hand[3][0]
#		elif hand[2][0] == hand[3][0] == hand[4][0]:
#			points += hand[2][0] + hand[3][0] + hand[4][0]
		return [THREE_OF_A_KIND, points]
	
	if is_two_pair(hand):
		if (hand[1][0] == hand[2][0]) and (hand[3][0] == hand[4][0]):
			points += hand[1][0] + hand[2][0] + hand[3][0] + hand[4][0]
		elif (hand[0][0] == hand[1][0]) and (hand[3][0] == hand[4][0]):
			points += hand[0][0] + hand[1][0] + hand[3][0] + hand[4][0]
		elif (hand[0][0] == hand[1][0]) and (hand[2][0] == hand[3][0]):
			points += hand[0][0] + hand[1][0] + hand[2][0] + hand[3][0]
		return [TWO_PAIR, points]
	
	if is_one_pair(hand):
		if hand[0][0] == hand[1][0]:
			points += hand[0][0] + hand[1][0]
		elif hand[1][0] == hand[2][0]:
			points += hand[1][0] + hand[2][0]
		elif hand[2][0] == hand[3][0]:
			points += hand[2][0] + hand[3][0]
		elif hand[3][0] == hand[4][0]:
			points += hand[3][0] + hand[4][0]
		return [ONE_PAIR, points]
	
	points += hand[4][0]
	return [HIGH_CARD, points]


static func is_royal_flush(hand : Array) -> bool:
	return is_straight_flush(hand) and hand[4][0] == 14 # ACE
	
static func is_straight_flush(hand : Array) -> bool:
	return is_straight(hand) and is_flush(hand)
	
static func is_four_of_a_kind(hand : Array) -> bool:
	return (hand[0][0] == hand[3][0]) or (hand[1][0] == hand[4][0])

static func is_flush(hand : Array) -> bool:
	return (hand[0][1] == hand[1][1]) and (hand[1][1] == hand[2][1]) and (hand[2][1] == hand[3][1]) and (hand[3][1] == hand[4][1])

static func is_straight(hand : Array) -> bool:
	return (hand[1][0] - hand[0][0] == 1) and (hand[2][0] - hand[1][0] == 1) and (hand[3][0] - hand[2][0] == 1) and (hand[4][0] - hand[3][0] == 1)

static func is_one_pair(hand : Array) -> bool:
	return get_amount_of_duplicates(hand) == 1

static func is_two_pair(hand : Array) -> bool:
	return get_amount_of_duplicates(hand) == 2

static func is_three_of_a_kind(hand : Array) -> bool:
	return ((hand[0][0] == hand[1][0]) and (hand[1][0] == hand[2][0])) or ((hand[1][0] == hand[2][0]) and (hand[2][0] == hand[3][0])) or ((hand[2][0] == hand[3][0]) and (hand[3][0] == hand[4][0]))

static func is_full_house(hand : Array) -> bool:
	return is_three_of_a_kind(hand) and is_one_pair(hand)



static func get_amount_of_duplicates(hand : Array) -> int:
	# duplicates = elements that appear exactly twice in an array.
	var num_of_duplicates : int = 0
	var i : int = 0
	while i < hand.size():
		if i < hand.size() - 1 and hand[i][0] == hand[i + 1][0]:
			num_of_duplicates += 1
			i += 2
		else:
			i += 1
	return num_of_duplicates
