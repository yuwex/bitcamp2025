extends Node2D

@onready var label_description: Label = $Description
@onready var label_award: Label = $Award
@onready var label_award_meta: Label = $AwardMeta

@onready var shader_secret: ShaderMaterial = preload("res://shader/pinkhydro.tres")
@onready var shader_rare: ShaderMaterial = preload("res://shader/bluehydro.tres")
@onready var shader_legendary: ShaderMaterial = preload("res://shader/greenhydro.tres")
@onready var shader_truecoder: ShaderMaterial = preload("res://shader/goldhydrodark.tres")

enum Endings {
	BEST,
	RIZZLEDIZZLE,
	PEOPLESCHOICE,
	MOONSHOT,
	UIUX,
	APPDEV,
	ML,
	SOCIALGOOD,
	SUSTAINABILITY,
	CYBERSECURITY,
	QUANTUM,
	HARDWARE,
	GAMIFICATION,
	PUBLICHEALTH,
	FINANCIAL,
	FORENSICS,
	GENAI,
	REACT,
	LIT,
	PRETTY,
	SMILE,
	TECH,
	CLOUDFLARE,
	MONGODB,
	GEMINI,
	
	HUNGER,
	ENERGY,
	MORALE,
	KNOWLEDGE,
	COMMUNICATION,
	LEECH,
	AWFUL,
	TRY,
}

enum Rarities {
	TRUECODER,
	LEGENDARY,
	RARE,
	COMMON,
	SECRET
}

var data = [
  {
	"award": "Death",
	"desc": "You died of starvation.",
	"enum": Endings.HUNGER,
	"rarity": Rarities.SECRET
  },
  {
	"award": "No Energy",
	"desc": "You fell asleep and missed your presentation time.",
	"enum": Endings.ENERGY,
	"rarity": Rarities.SECRET
  },
  {
	"award": "No More(ale) Bytecamp",
	"desc": "You went home played games.",
	"enum": Endings.MORALE,
	"rarity": Rarities.SECRET
  },
  {
	"award": "Un-intelligent",
	"desc": "You showed up to the wrong building and missed your presentation time.",
	"enum": Endings.KNOWLEDGE,
	"rarity": Rarities.SECRET
  },
  {
	"award": "Non-communicator",
	"desc": "You were unable to communicate with the judges. Maybe failing COMM100 was a sign.",
	"enum": Endings.COMMUNICATION,
	"rarity": Rarities.SECRET
  },
  {
	"award": "Leech",
	"desc": "You did NOTHING FOR YOUR TEAM. You ARE that group member.",
	"enum": Endings.LEECH,
	"rarity": Rarities.SECRET
  },
  {
	"award": "Awful",
	"desc": "You won the award for Awful because it was the worst project we have ever seen. Quit.",
	"enum": Endings.AWFUL,
	"rarity": Rarities.SECRET
  },
  {
	"award": "Try",
	"desc": "You won the award for Trying because showing up is half the battle!",
	"enum": Endings.TRY,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Best",
	"desc": "You won the award for being the best because of your outstanding performance!",
	"enum": Endings.BEST,
	"rarity": Rarities.TRUECODER
  },
  {
	"award": "Moonshot",
	"desc": "You won the award for Moonshot because of your ambitious vision!",
	"enum": Endings.MOONSHOT,
	"rarity": Rarities.LEGENDARY
  },
  {
	"award": "GenAI",
	"desc": "You won the award for Generative AI because your AI was super smart!",
	"enum": Endings.GENAI,
	"rarity": Rarities.LEGENDARY
  },
  {
	"award": "Quantum",
	"desc": "You won the award for Quantum because you went beyond classical limits!",
	"enum": Endings.QUANTUM,
	"rarity": Rarities.LEGENDARY
  },
  {
	"award": "People's Choice",
	"desc": "You won the award for being the fan favorite because everyone loved your project!",
	"enum": Endings.PEOPLESCHOICE,
	"rarity": Rarities.LEGENDARY
  },
  {
	"award": "Machine Learning",
	"desc": "You won the award for ML because your model was genius!",
	"enum": Endings.ML,
	"rarity": Rarities.RARE
  },
  {
	"award": "Cybersecurity",
	"desc": "You won the award for Cybersecurity because your defenses were bulletproof!",
	"enum": Endings.CYBERSECURITY,
	"rarity": Rarities.RARE
  },
  {
	"award": "Social Good",
	"desc": "You won the award for Social Good because your impact was incredible!",
	"enum": Endings.SOCIALGOOD,
	"rarity": Rarities.RARE
  },
  {
	"award": "Public Health",
	"desc": "You won the award for Public Health because your project could save lives!",
	"enum": Endings.PUBLICHEALTH,
	"rarity": Rarities.RARE
  },
  {
	"award": "Forensics",
	"desc": "You won the award for Forensics because you uncovered the truth!",
	"enum": Endings.FORENSICS,
	"rarity": Rarities.RARE
  },
  {
	"award": "Sustainability",
	"desc": "You won the award for Sustainability because you helped the planet!",
	"enum": Endings.SUSTAINABILITY,
	"rarity": Rarities.RARE
  },
  {
	"award": "Cloudflare",
	"desc": "You won the award for Cloudflare integration because your infra was slick!",
	"enum": Endings.CLOUDFLARE,
	"rarity": Rarities.RARE
  },
  {
	"award": "UI/UX",
	"desc": "You won the award for UI/UX because your design was flawless!",
	"enum": Endings.UIUX,
	"rarity": Rarities.COMMON
  },
  {
	"award": "App Dev",
	"desc": "You won the award for App Development because your app was top-tier!",
	"enum": Endings.APPDEV,
	"rarity": Rarities.COMMON
  },
  {
	"award": "React",
	"desc": "You won the award for React because your frontend was 🔥!",
	"enum": Endings.REACT,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Hardware",
	"desc": "You won the award for Hardware because you built something real!",
	"enum": Endings.HARDWARE,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Gamification",
	"desc": "You won the award for Gamification because your game was addictive!",
	"enum": Endings.GAMIFICATION,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Tech",
	"desc": "You won the award for Tech because you brought the future closer!",
	"enum": Endings.TECH,
	"rarity": Rarities.COMMON
  },
  {
	"award": "MongoDB",
	"desc": "You won the award for MongoDB mastery because your data game was tight!",
	"enum": Endings.MONGODB,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Financial Tech",
	"desc": "You won the award for FinTech because your math was 💯!",
	"enum": Endings.FINANCIAL,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Smile",
	"desc": "You won the award for Smile because your joy was contagious!",
	"enum": Endings.SMILE,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Rizzle Dizzle",
	"desc": "You won the award for Rizzle Dizzle because of your unbeatable vibe!",
	"enum": Endings.RIZZLEDIZZLE,
	"rarity": Rarities.LEGENDARY
  },
  {
	"award": "Lit",
	"desc": "You won the award for being absolutely lit because you slayed!",
	"enum": Endings.LIT,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Pretty",
	"desc": "You won the award for Pretty because aesthetics matter!",
	"enum": Endings.PRETTY,
	"rarity": Rarities.COMMON
  },
  {
	"award": "Gemini",
	"desc": "You won the award for Gemini because you explored the stars!",
	"enum": Endings.GEMINI,
	"rarity": Rarities.COMMON
  }
]

func apply(dict: Dictionary) -> void:
	var award: String = dict['award']
	var desc: String = dict['desc']
	var ending: Endings = dict['enum']
	var rarity: Rarities = dict['rarity']

	label_award.text = award
	label_description.text = desc

	var ending_index = Endings.keys().find(Endings.keys()[ending]) + 1
	var max = len(Endings.keys())
	
	label_award_meta.text = str('Award ', ending_index, '/', max, ', ', Rarities.keys()[rarity])
	
	if rarity == Rarities.SECRET:
		label_award.material = shader_secret
	elif rarity == Rarities.RARE:
		label_award.material = shader_rare
	elif rarity == Rarities.LEGENDARY:
		label_award.material = shader_legendary
	elif rarity == Rarities.TRUECODER:
		label_award.material = shader_truecoder
	
	print(rarity)
	
func find_ending() -> Endings:
	var ending = null
	
	if Stats.stats[Stats.StatType.HUNGER] >= 100:
		ending = Endings.HUNGER
	elif Stats.stats[Stats.StatType.ENERGY] <= 0:
		ending = Endings.ENERGY
	elif Stats.stats[Stats.StatType.MORALE] <= 0:
		ending = Endings.MORALE
	elif Stats.stats[Stats.StatType.COMMUNICATION] <= 3:
		ending = Endings.COMMUNICATION
	elif Stats.stats[Stats.StatType.KNOWLEDGE] <= 3:
		ending = Endings.KNOWLEDGE
	
	if ending:
		if (Stats.stats[Stats.StatType.PROJ_TECHNICAL] > 130
			and Stats.stats[Stats.StatType.PROJ_ORIGINALITY] > 130
			and Stats.stats[Stats.StatType.PROJ_USER_EXPERIENCE] > 130
		):
			return Endings.LEECH
		return ending
	
	var avg = Stats.proj_avg()
	
	if avg < 1:
		return Endings.AWFUL
	if avg < 20:
		return Endings.TRY
		
	var endings = [
		Endings.RIZZLEDIZZLE,
		Endings.PEOPLESCHOICE,
		Endings.MOONSHOT,
		Endings.UIUX,
		Endings.APPDEV,
		Endings.ML,
		Endings.SOCIALGOOD,
		Endings.SUSTAINABILITY,
		Endings.CYBERSECURITY,
		Endings.QUANTUM,
		Endings.HARDWARE,
		Endings.GAMIFICATION,
		Endings.PUBLICHEALTH,
		Endings.FINANCIAL,
		Endings.FORENSICS,
		Endings.GENAI,
		Endings.REACT,
		Endings.LIT,
		Endings.PRETTY,
		Endings.SMILE,
		Endings.TECH,
		Endings.CLOUDFLARE,
		Endings.MONGODB,
		Endings.GEMINI,
	]
	
	var acc = 20.0
	for i in range(len(endings)):
		acc += 100 / len(endings)
		if avg < acc:
			return endings[i]
	
	if (Stats.stats[Stats.StatType.PROJ_TECHNICAL] > 130
		and Stats.stats[Stats.StatType.PROJ_ORIGINALITY] > 130
		and Stats.stats[Stats.StatType.PROJ_USER_EXPERIENCE] > 130):
			return Endings.BEST
	
	return Endings.RIZZLEDIZZLE
	
func present_ending(end: Endings):
	print(str("Ending acquired: ", Endings.keys()[end]))
	for j in data:
		if j['enum'] == end:
			apply(j)
			return

func all():
	present_ending(find_ending())	
