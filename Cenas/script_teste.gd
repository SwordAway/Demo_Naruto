extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	ScriptGlobal.personagem = 1
	get_tree().change_scene("res://Cenas/Vitoria/cena_vitoria.tscn")
	pass # Replace with function body.

func _on_Button2_pressed():
	get_tree().change_scene("res://Cenas/Game_over/cena_game_over.tscn")
	pass # Replace with function body.

func _on_Button4_pressed():
	ScriptGlobal.personagem = 2
	get_tree().change_scene("res://Cenas/Vitoria/cena_vitoria.tscn")
	pass # Replace with function body.
