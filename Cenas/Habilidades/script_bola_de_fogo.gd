extends Area2D

var mov = Vector2(300, 0)


func _sumir_bola_fogo():
	mov.x = 0
	$Anima.play("bola_fogo_sumindo")
	$Colli_bola_fogo.queue_free()
	$Timer.queue_free()
	if(ScriptGlobal.status_som):
		$Som_fogo_sumindo.play()


func _ready():
	$Anima.play("bola_fogo")


func _process(delta):
	translate(mov * delta)


func _on_Timer_timeout():
	 _sumir_bola_fogo()

# Atingir e não fazer nada
func _on_Bola_fogo_area_entered(area):
	if(area.name == "Identif_object" || area.name == "Foice"):
		pass
	else:
		_sumir_bola_fogo()


# Atingir mundo, e etc
func _on_Bola_fogo_body_entered(body):
	if(body):
		_sumir_bola_fogo()
	pass

func _on_Anima_animation_finished(anim_name):
	if (anim_name == "bola_fogo_sumindo"):
		get_parent().get_node(".").queue_free()
