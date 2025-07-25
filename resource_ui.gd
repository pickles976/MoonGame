extends MarginContainer

@onready var kw_consumed: RichTextLabel = %KilowattsConsumed
@onready var kw_produced: RichTextLabel = %KilowattsProduced
@onready var regolith_counter: RichTextLabel = %RegolithCounter

func _ready():
	set_process_priority(9999) 
	
func _process(delta):
	regolith_counter.text = "%.2f" % Resources.total_mined_regolith
