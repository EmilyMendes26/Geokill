extends CharacterBody2D

const altura_mapa = 3
const limite_mapa = (16 * altura_mapa)/2
var posicao: Vector2
var velocidade = 16
var tempo_tiro = 1
var tempo = 0

func _ready():
	posicao = position
	add_to_group("inimigo")
	
func _physics_process(delta):
	tempo += delta
	
	if tempo >= tempo_tiro:
		position.y += velocidade
		tempo = 0.0
	
	if (position.y >= limite_mapa):
		queue_free()
