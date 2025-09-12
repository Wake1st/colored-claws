class_name Commands


static var commands: Array[Command]
static var index: int = 0


static func add(nail: Nail, before: Image, after: Image) -> void:
	# wipe all downstream data if upstream
	if index < commands.size():
		for i in range(index, commands.size()):
			commands.pop_back()
	
	# shift index and insert
	commands.insert(index, Command.new(nail, before, after))
	index += 1

static func undo() -> Command:
	if index == 0:
		return null
	else:
		index -= 1
		return commands[index]

static func redo() -> Command:
	if index == commands.size():
		return null
	else:
		var cmd = commands[index]
		index += 1
		return cmd

static func clear() -> void:
	commands.clear()
	index = 0
