extends Control

@export var price = 10

func _ready():
	$Label.text = str(price)

func set_price(price: int):
	self.price = price
	$Label.text = str(price)
