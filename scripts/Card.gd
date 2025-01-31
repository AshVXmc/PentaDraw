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


func set_card_texture(number : int, suit : int):
	var region_x : int = 12 * (number - 2)
	var region_y : int = 16 * suit
	texture.set_region(Rect2(region_x, region_y, 12, 16))
