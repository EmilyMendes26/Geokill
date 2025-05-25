extends CharacterBody2D
@onready var controlador: Node2D = get_tree().root.get_node('game')

const altura_mapa = 5
const limite_mapa = (16 * altura_mapa)/2
var posicao: Vector2
var velocidade = 16
var tempo_andar = 0.7
var tempo = 0
var forma

func _ready():
	forma = define_forma()
	posicao = position
	add_to_group("inimigo")
	
func _physics_process(delta):
	tempo += delta
	
	if tempo >= tempo_andar:
		position.y += velocidade
		tempo = 0.0
	
	if (position.y >= limite_mapa):
		controlador.perde_vida()
		queue_free()
		
func define_forma():
	var forma
	var arquivo = get_scene_file_path()
	var regex = RegEx.new()
	regex.compile('inimigo_(\\w+)')
	forma = regex.search(arquivo)
	
	return forma.get_string(1)
