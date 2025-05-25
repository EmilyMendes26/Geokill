extends Area2D

@onready var controlador: Node2D = get_tree().root.get_node('game')

const altura_mapa = 6
const limite_mapa = (16 * altura_mapa)/2
var velocidade = 16
var tempo_tiro = 0.2
var tempo = 0
var player_forma

func _physics_process(delta):
	tempo += delta
	
	if tempo >= tempo_tiro:
		position.y -= velocidade
		tempo = 0.0
	
	if (position.y <= -limite_mapa):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigo"):
		var inimigo_forma
		inimigo_forma = body.forma
		
		if inimigo_forma == player_forma:
			body.queue_free()
			controlador.adiciona_ponto()
	
	if body.is_in_group("player"):
		return
		
	queue_free()
