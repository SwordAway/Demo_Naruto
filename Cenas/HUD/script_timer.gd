extends Label

var timer = 0
var timer_on = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_on = ScriptGlobal.ctrl_timer_ranking
	if(timer_on):
		timer += delta
		
	var mils = fmod(timer,1)*1000
	var secs = fmod(timer,60)
	var mins = fmod(timer, 60*60) / 60
	
	var tempo_corrido = "%02d   :   %02d  :  %03d" % [mins,secs,mils]
	text = tempo_corrido # + " : " + var2str(timer)
	ScriptGlobal.timer_ranking = tempo_corrido

	pass
