extends Area2D

var mov = Vector2(300, 0)

onready var no_pai = get_parent().get_node(".")

func _ready():
	$Anima.play("shuriken")
	
func _delete():
	$Colli_shuriken.queue_free()
	$IMG_shuriken.queue_free()
	$Anima.queue_free()
	$Timer.start()
	
func _process(delta):
	translate(mov * delta)

# ___ se atingir o mundo ___
func _on_Area2D_body_entered(body):
	if(ScriptGlobal.status_som):
		$Som_acerta_mundo.play()
	_delete()


# Se atingir outro item
func _on_Shuriken_area_entered(area):
	if(area.name == "Identif_object"):
		pass
	else:
		if(ScriptGlobal.status_som):
			if(area.name == "Recebe_dano"):
				$Som_acerta_inimigo.play()
		_delete()
	
func _on_Timer_timeout():
	no_pai.queue_free()

