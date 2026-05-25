extends Node

var score = 0
var bones = 0
var time = 0.00
var highscore = 0

var weapons_unlocked = {
	"ak_47": true,
	"deagle": false,
	"ump_45": false
}

func increase_score(amount):
	score += amount
