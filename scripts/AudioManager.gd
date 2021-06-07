extends Node

var song  = [
	preload("res://sounds/RetroSFXMurkje/Coin/Pickup_Coin3.wav"),
	preload("res://sounds/RetroSFXMurkje/Coin/Pickup_Coin4.wav"),
	preload("res://sounds/RetroSFXMurkje/Coin/Pickup_Coin5.wav")
]

var current_song = 0

func play():
	return song[current_song]

func next():
	current_song = (current_song + 1) % song.size()
	return song[current_song]
