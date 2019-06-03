extends "res://addons/gut/test.gd"

func test_dupa():
	assert_eq(1, 1)

class TestBot:
	extends "res://addons/gut/test.gd"
	var _bot = load("res://Bot/Bot.tscn")
	var _board = load("res://Board/Board.tscn")
	var _ScorePair = load("res://Highscore/ScorePair.gd")
	var bot
	var score
	var board

	var INITIAL_NUMBER_OF_BOMBS = 1
	var INITIAL_NAME = "nickname"
	var INITIAL_HP = 3
	var INITIAL_IMMORTALITY = false
	var INITIAL_BOMB_DMG = 1
	var INITIAL_COLOR = Color(0, 0, 0)
	var INITIAL_PLAYER_ID = "P5"
	var INITIAL_DANGER_LIST = Array()
	var INITIAL_SPEED = 200
	var INITIAL_VELOCITY = Vector2()

	var SPEED_CHANGE = 70
	var BOMB_DELAY = 3
	var LIMIT = 10    

	func test_setNickname():
		bot = _bot.instance()
		assert_eq(bot.name, INITIAL_NAME)
		var names = ['A', 1, 'bbbxcb', '23123', 'ASkdj123][FFFFFFF;/aFSDsd']
		for name in names:
			bot.set_nickname(name)
			assert_eq(bot.name, name)

	func test_addBomb():
		bot = _bot.instance()
		assert_eq(bot.can_plant, INITIAL_NUMBER_OF_BOMBS)
		for i in range(LIMIT):
			bot = _bot.instance()
			for j in range(i):
				bot.add_bomb()
			assert_eq(bot.can_plant, INITIAL_NUMBER_OF_BOMBS + i)

	func test_speedUP():
		bot = _bot.instance()
		assert_eq(bot.speed, INITIAL_SPEED)
		for i in range(LIMIT):
			bot = _bot.instance()
			for j in range(i):
				bot.speed_up()
			assert_eq(bot.speed, INITIAL_SPEED + i * SPEED_CHANGE)

	func test_increaseDMG():
		bot = _bot.instance()
		assert_eq(bot.bomb_dmg, INITIAL_BOMB_DMG)
		for i in range(LIMIT):
			bot = _bot.instance()
			for j in range(i):
				bot.increase_dmg()
			assert_eq(bot.bomb_dmg, INITIAL_BOMB_DMG + i)

	func test_notImmortal():
		bot = _bot.instance()
		assert_eq(bot.is_immortal, INITIAL_IMMORTALITY)
		bot.not_immortal()
		assert_false(bot.is_immortal)

	func test_check_colour():
		bot = _bot.instance()
		bot.color = Color(0, 0, 0, 1)
		bot._check_colour()
		assert_ne(bot.modulate, Color(0, 0, 0, 1))
		bot.color = Color(0, 0, 1, 0)
		bot._check_colour()
		assert_eq(bot.modulate, Color(0, 0, 1, 0))

	func test_winner():
		pending()
		bot = _bot.instance()
		bot.dead = false
		bot.score = 100000000
		Highscore.reset()
		bot.winner()
		var scorepairs = Highscore.GetList()
		var scores = []
		for sp in scorepairs:
			scores.append(sp.score)
		assert_has(scores, bot.score)
		Highscore.reset()