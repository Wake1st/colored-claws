class_name Commands


static var commands: Array[Command]
static var index: int


static func add(nail: Nail, img: Image) -> void:
	# wipe all downstream data if upstream
	if index < commands.size() - 1:
		for i in range(index, commands.size()):
			commands.pop_back()
	
	# insert and shift index
	commands.insert(index, Command.new(nail, img))
	index += 1
	print("ind:\t%s" % index)

static func undo() -> Command:
	index -= 1
	return commands[index]

static func redo() -> Command:
	var img = commands[index]
	index += 1
	return img

static func clear() -> void:
	commands.clear()
	index = 0
