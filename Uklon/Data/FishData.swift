
import Foundation

struct FishData {
    static let allFish: [Fish] = freshwaterFish + saltwaterFish + tropicalFish + arcticFish + brackishFish

    // MARK: - Recipe Helpers
    private static func grilledRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "Grilled \(fish)",
            description: "Perfectly grilled \(fish) with herbs and lemon, bringing out the natural flavors of this delicious fish.",
            ingredients: [
                "1 lb fresh \(fish) fillet",
                "2 tbsp olive oil",
                "2 cloves garlic, minced",
                "1 lemon, juiced",
                "Fresh herbs (thyme, rosemary)",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Preheat grill to medium-high heat",
                "Pat fish dry and brush with olive oil",
                "Season with salt, pepper, and minced garlic",
                "Place fish on grill, skin side down",
                "Grill for 4-5 minutes per side",
                "Squeeze lemon juice and add fresh herbs before serving"
            ],
            preparationTime: 10,
            cookingTime: 15,
            difficulty: .easy,
            servings: 2,
            fishName: fish
        )
    }

    private static func bakedRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "Baked \(fish) with Vegetables",
            description: "Oven-baked \(fish) with seasonal vegetables, a healthy and delicious one-pan meal.",
            ingredients: [
                "1.5 lb \(fish) fillet",
                "1 cup cherry tomatoes",
                "1 zucchini, sliced",
                "1 bell pepper, diced",
                "3 tbsp olive oil",
                "2 tsp Italian seasoning",
                "Salt and pepper to taste",
                "Fresh parsley for garnish"
            ],
            instructions: [
                "Preheat oven to 400°F (200°C)",
                "Arrange vegetables in a baking dish",
                "Place fish on top of vegetables",
                "Drizzle with olive oil and season",
                "Bake for 20-25 minutes until fish flakes easily",
                "Garnish with fresh parsley and serve"
            ],
            preparationTime: 15,
            cookingTime: 25,
            difficulty: .easy,
            servings: 4,
            fishName: fish
        )
    }

    private static func friedRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "Pan-Fried \(fish)",
            description: "Crispy pan-fried \(fish) with a golden crust, served with tartar sauce.",
            ingredients: [
                "1 lb \(fish) fillet",
                "1 cup all-purpose flour",
                "2 eggs, beaten",
                "1 cup breadcrumbs",
                "Vegetable oil for frying",
                "Salt and pepper",
                "Lemon wedges for serving"
            ],
            instructions: [
                "Cut fish into portions",
                "Season flour with salt and pepper",
                "Dredge fish in flour, then egg, then breadcrumbs",
                "Heat oil in a large skillet over medium-high",
                "Fry fish 3-4 minutes per side until golden",
                "Drain on paper towels and serve with lemon"
            ],
            preparationTime: 15,
            cookingTime: 10,
            difficulty: .medium,
            servings: 3,
            fishName: fish
        )
    }

    private static func smokedRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "Smoked \(fish)",
            description: "Home-smoked \(fish) with a rich, smoky flavor that melts in your mouth.",
            ingredients: [
                "2 lb \(fish) fillet",
                "1/4 cup brown sugar",
                "2 tbsp salt",
                "1 tsp black pepper",
                "1 tsp garlic powder",
                "Wood chips (hickory or apple)",
                "Fresh dill"
            ],
            instructions: [
                "Mix brown sugar, salt, pepper, and garlic powder",
                "Coat fish with the cure and refrigerate for 4-8 hours",
                "Rinse fish and pat dry",
                "Prepare smoker to 225°F (107°C)",
                "Smoke fish for 2-3 hours until internal temp reaches 145°F",
                "Let rest 10 minutes before serving"
            ],
            preparationTime: 20,
            cookingTime: 180,
            difficulty: .hard,
            servings: 6,
            fishName: fish
        )
    }

    private static func soupRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "\(fish) Chowder",
            description: "Creamy and hearty \(fish) chowder, perfect for cold days.",
            ingredients: [
                "1 lb \(fish), cubed",
                "4 slices bacon, diced",
                "1 onion, diced",
                "2 potatoes, cubed",
                "2 cups fish stock",
                "1 cup heavy cream",
                "Fresh thyme",
                "Salt and pepper"
            ],
            instructions: [
                "Cook bacon until crispy, remove and set aside",
                "Sauté onion in bacon fat until soft",
                "Add potatoes and fish stock, simmer 15 minutes",
                "Add fish and cook for 5 minutes",
                "Stir in cream and thyme, heat through",
                "Top with bacon and serve"
            ],
            preparationTime: 20,
            cookingTime: 30,
            difficulty: .medium,
            servings: 4,
            fishName: fish
        )
    }

    private static func sashimiRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "\(fish) Sashimi",
            description: "Fresh, thinly sliced raw \(fish) served Japanese style with soy sauce and wasabi.",
            ingredients: [
                "8 oz sashimi-grade \(fish)",
                "Soy sauce",
                "Fresh wasabi",
                "Pickled ginger",
                "Daikon radish, shredded",
                "Shiso leaves"
            ],
            instructions: [
                "Ensure fish is sashimi-grade quality",
                "Freeze fish at -4°F for 7 days to eliminate parasites",
                "Slice fish against the grain into 1/4 inch pieces",
                "Arrange on plate with shredded daikon",
                "Serve with soy sauce, wasabi, and ginger"
            ],
            preparationTime: 20,
            cookingTime: 0,
            difficulty: .hard,
            servings: 2,
            fishName: fish
        )
    }

    private static func cevicheRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "\(fish) Ceviche",
            description: "Fresh \(fish) cured in citrus juice with onions, peppers, and cilantro.",
            ingredients: [
                "1 lb fresh \(fish), diced",
                "1 cup fresh lime juice",
                "1 red onion, thinly sliced",
                "1 jalapeño, minced",
                "1 cup cherry tomatoes, halved",
                "Fresh cilantro",
                "Salt to taste",
                "Tortilla chips for serving"
            ],
            instructions: [
                "Dice fish into 1/2 inch cubes",
                "Place in bowl and cover with lime juice",
                "Refrigerate for 2-3 hours until fish is opaque",
                "Drain excess lime juice",
                "Add onion, jalapeño, tomatoes, and cilantro",
                "Season and serve cold with chips"
            ],
            preparationTime: 25,
            cookingTime: 0,
            difficulty: .medium,
            servings: 4,
            fishName: fish
        )
    }

    private static func curryRecipe(for fish: String) -> Recipe {
        Recipe(
            name: "\(fish) Curry",
            description: "Rich and aromatic \(fish) curry with coconut milk and spices.",
            ingredients: [
                "1.5 lb \(fish), cubed",
                "1 can coconut milk",
                "2 tbsp curry paste",
                "1 onion, diced",
                "2 cloves garlic",
                "1 inch ginger, minced",
                "Fresh basil leaves",
                "Rice for serving"
            ],
            instructions: [
                "Sauté onion, garlic, and ginger until fragrant",
                "Add curry paste and cook 1 minute",
                "Pour in coconut milk and bring to simmer",
                "Add fish cubes and cook 8-10 minutes",
                "Stir in basil leaves",
                "Serve hot over steamed rice"
            ],
            preparationTime: 15,
            cookingTime: 20,
            difficulty: .medium,
            servings: 4,
            fishName: fish
        )
    }

    // MARK: - Freshwater Fish (20)
    static let freshwaterFish: [Fish] = [
        Fish(
            name: "Largemouth Bass",
            scientificName: "Micropterus salmoides",
            description: "America's most popular game fish, known for its aggressive strikes and fighting spirit. Found in lakes, ponds, and slow-moving rivers.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 40,
            rarity: .common,
            habitat: "Lakes, ponds, rivers with vegetation",
            bestSeason: "Spring and Fall",
            recipes: [grilledRecipe(for: "Bass"), bakedRecipe(for: "Bass"), friedRecipe(for: "Bass")]
        ),
        Fish(
            name: "Rainbow Trout",
            scientificName: "Oncorhynchus mykiss",
            description: "Beautiful fish with distinctive pink stripe, prized for both sport and table. Native to cold-water tributaries of the Pacific Ocean.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 35,
            rarity: .common,
            habitat: "Cold streams, rivers, and lakes",
            bestSeason: "Spring and Early Summer",
            recipes: [grilledRecipe(for: "Trout"), smokedRecipe(for: "Trout"), bakedRecipe(for: "Trout")]
        ),
        Fish(
            name: "Northern Pike",
            scientificName: "Esox lucius",
            description: "Aggressive predator with razor-sharp teeth, known as the 'water wolf'. Excellent fighter on light tackle.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .uncommon,
            habitat: "Weedy lakes and slow rivers",
            bestSeason: "Fall and Early Spring",
            recipes: [bakedRecipe(for: "Pike"), friedRecipe(for: "Pike")]
        ),
        Fish(
            name: "Channel Catfish",
            scientificName: "Ictalurus punctatus",
            description: "Most numerous catfish species in North America. Excellent eating with firm, white flesh.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Rivers, lakes, and reservoirs",
            bestSeason: "Summer",
            recipes: [friedRecipe(for: "Catfish"), bakedRecipe(for: "Catfish"), soupRecipe(for: "Catfish")]
        ),
        Fish(
            name: "Common Carp",
            scientificName: "Cyprinus carpio",
            description: "Large, powerful fish that provides great sport. Introduced from Asia, now widespread globally.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 60,
            rarity: .common,
            habitat: "Warm lakes and slow rivers",
            bestSeason: "Summer and Early Fall",
            recipes: [bakedRecipe(for: "Carp"), smokedRecipe(for: "Carp")]
        ),
        Fish(
            name: "Yellow Perch",
            scientificName: "Perca flavescens",
            description: "Popular panfish known for its delicious, sweet flesh. Forms large schools in lakes.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 0.3,
            averageLength: 20,
            rarity: .common,
            habitat: "Lakes and clear rivers",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Perch"), bakedRecipe(for: "Perch")]
        ),
        Fish(
            name: "Walleye",
            scientificName: "Sander vitreus",
            description: "Highly prized for its excellent eating quality. Named for its reflective eyes that help it see in murky water.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 2.5,
            averageLength: 45,
            rarity: .uncommon,
            habitat: "Large lakes and rivers",
            bestSeason: "Spring and Fall",
            recipes: [friedRecipe(for: "Walleye"), bakedRecipe(for: "Walleye"), grilledRecipe(for: "Walleye")]
        ),
        Fish(
            name: "Bluegill",
            scientificName: "Lepomis macrochirus",
            description: "Classic American panfish, perfect for beginners. Aggressive biters with sweet, flaky meat.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 0.2,
            averageLength: 18,
            rarity: .common,
            habitat: "Ponds, lakes, streams",
            bestSeason: "Late Spring and Summer",
            recipes: [friedRecipe(for: "Bluegill"), bakedRecipe(for: "Bluegill")]
        ),
        Fish(
            name: "Black Crappie",
            scientificName: "Pomoxis nigromaculatus",
            description: "Popular panfish often found in schools. Excellent table fare with mild, white flesh.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 0.4,
            averageLength: 25,
            rarity: .common,
            habitat: "Lakes with submerged structure",
            bestSeason: "Spring",
            recipes: [friedRecipe(for: "Crappie"), bakedRecipe(for: "Crappie")]
        ),
        Fish(
            name: "Lake Sturgeon",
            scientificName: "Acipenser fulvescens",
            description: "Ancient, prehistoric fish that can live over 100 years. The largest freshwater fish in North America.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 30.0,
            averageLength: 150,
            rarity: .legendary,
            habitat: "Large rivers and lakes",
            bestSeason: "Spring",
            recipes: [smokedRecipe(for: "Sturgeon"), grilledRecipe(for: "Sturgeon")]
        ),
        Fish(
            name: "Longnose Gar",
            scientificName: "Lepisosteus osseus",
            description: "Primitive fish with armor-like scales and elongated snout. Challenging to catch and clean.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 80,
            rarity: .rare,
            habitat: "Slow rivers and backwaters",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Gar"), smokedRecipe(for: "Gar")]
        ),
        Fish(
            name: "Bowfin",
            scientificName: "Amia calva",
            description: "Living fossil, sole surviving member of its family. Aggressive fighter with strong jaws.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 3.5,
            averageLength: 55,
            rarity: .rare,
            habitat: "Swamps and vegetated waters",
            bestSeason: "Spring and Summer",
            recipes: [friedRecipe(for: "Bowfin"), soupRecipe(for: "Bowfin")]
        ),
        Fish(
            name: "Muskellunge",
            scientificName: "Esox masquinongy",
            description: "The 'fish of ten thousand casts'. North America's largest pike family member, legendary among anglers.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 100,
            rarity: .legendary,
            habitat: "Clear lakes with vegetation",
            bestSeason: "Fall",
            recipes: [bakedRecipe(for: "Muskie"), grilledRecipe(for: "Muskie")]
        ),
        Fish(
            name: "Smallmouth Bass",
            scientificName: "Micropterus dolomieu",
            description: "Pound for pound, one of the hardest fighting freshwater fish. Known for acrobatic jumps.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 35,
            rarity: .common,
            habitat: "Clear, rocky lakes and streams",
            bestSeason: "Summer and Fall",
            recipes: [grilledRecipe(for: "Smallmouth Bass"), friedRecipe(for: "Smallmouth Bass")]
        ),
        Fish(
            name: "Brown Trout",
            scientificName: "Salmo trutta",
            description: "European native now found worldwide. Wary and challenging to catch, with excellent flavor.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 40,
            rarity: .uncommon,
            habitat: "Cold streams and rivers",
            bestSeason: "Fall",
            recipes: [smokedRecipe(for: "Brown Trout"), bakedRecipe(for: "Brown Trout"), grilledRecipe(for: "Brown Trout")]
        ),
        Fish(
            name: "Lake Trout",
            scientificName: "Salvelinus namaycush",
            description: "Deep-water char found in cold northern lakes. Slow-growing but can reach impressive sizes.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 60,
            rarity: .rare,
            habitat: "Deep, cold lakes",
            bestSeason: "Early Spring and Late Fall",
            recipes: [smokedRecipe(for: "Lake Trout"), bakedRecipe(for: "Lake Trout")]
        ),
        Fish(
            name: "Pumpkinseed",
            scientificName: "Lepomis gibbosus",
            description: "Colorful sunfish with distinctive orange spots. Popular with young anglers.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 0.15,
            averageLength: 15,
            rarity: .common,
            habitat: "Ponds and lake shallows",
            bestSeason: "Summer",
            recipes: [friedRecipe(for: "Pumpkinseed")]
        ),
        Fish(
            name: "White Bass",
            scientificName: "Morone chrysops",
            description: "Schooling fish that provides fast action when located. Excellent eating quality.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 0.8,
            averageLength: 30,
            rarity: .common,
            habitat: "Large lakes and reservoirs",
            bestSeason: "Spring",
            recipes: [friedRecipe(for: "White Bass"), grilledRecipe(for: "White Bass")]
        ),
        Fish(
            name: "Freshwater Drum",
            scientificName: "Aplodinotus grunniens",
            description: "Only freshwater member of the drum family. Named for the drumming sound it makes.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 40,
            rarity: .common,
            habitat: "Rivers and large lakes",
            bestSeason: "Summer",
            recipes: [friedRecipe(for: "Drum"), bakedRecipe(for: "Drum")]
        ),
        Fish(
            name: "Sauger",
            scientificName: "Sander canadensis",
            description: "Close relative of walleye, often found in rivers. Excellent eating with firm flesh.",
            category: .freshwater,
            imageName: "fish.fill",
            averageWeight: 1.0,
            averageLength: 35,
            rarity: .uncommon,
            habitat: "Rivers and large lakes",
            bestSeason: "Fall and Winter",
            recipes: [friedRecipe(for: "Sauger"), bakedRecipe(for: "Sauger")]
        )
    ]

    // MARK: - Saltwater Fish (20)
    static let saltwaterFish: [Fish] = [
        Fish(
            name: "Bluefin Tuna",
            scientificName: "Thunnus thynnus",
            description: "The king of sushi fish. Can reach enormous sizes and is highly prized worldwide. Incredible speed and power.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 200.0,
            averageLength: 250,
            rarity: .legendary,
            habitat: "Open ocean, temperate waters",
            bestSeason: "Summer and Fall",
            recipes: [sashimiRecipe(for: "Tuna"), grilledRecipe(for: "Tuna"), soupRecipe(for: "Tuna")]
        ),
        Fish(
            name: "Atlantic Salmon",
            scientificName: "Salmo salar",
            description: "The king of fish, prized for both sport and cuisine. Anadromous fish that returns to freshwater to spawn.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 75,
            rarity: .rare,
            habitat: "Atlantic Ocean and rivers",
            bestSeason: "Summer",
            recipes: [smokedRecipe(for: "Salmon"), grilledRecipe(for: "Salmon"), bakedRecipe(for: "Salmon")]
        ),
        Fish(
            name: "Atlantic Mackerel",
            scientificName: "Scomber scombrus",
            description: "Fast-swimming, schooling fish. Rich, oily flesh packed with omega-3 fatty acids.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 0.5,
            averageLength: 35,
            rarity: .common,
            habitat: "Coastal Atlantic waters",
            bestSeason: "Late Summer",
            recipes: [grilledRecipe(for: "Mackerel"), smokedRecipe(for: "Mackerel"), bakedRecipe(for: "Mackerel")]
        ),
        Fish(
            name: "European Sea Bass",
            scientificName: "Dicentrarchus labrax",
            description: "Premier sport fish of European waters. Excellent fighter and superb eating.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 55,
            rarity: .uncommon,
            habitat: "Coastal waters, estuaries",
            bestSeason: "Spring and Fall",
            recipes: [grilledRecipe(for: "Sea Bass"), bakedRecipe(for: "Sea Bass"), cevicheRecipe(for: "Sea Bass")]
        ),
        Fish(
            name: "Pacific Halibut",
            scientificName: "Hippoglossus stenolepis",
            description: "Largest flatfish in the world. Highly prized for its firm, white meat.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 25.0,
            averageLength: 120,
            rarity: .rare,
            habitat: "Pacific Ocean bottom",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Halibut"), bakedRecipe(for: "Halibut"), friedRecipe(for: "Halibut")]
        ),
        Fish(
            name: "Swordfish",
            scientificName: "Xiphias gladius",
            description: "Majestic billfish with sword-like bill. Powerful fighter and excellent table fare.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 90.0,
            averageLength: 200,
            rarity: .legendary,
            habitat: "Open ocean, warm waters",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Swordfish"), bakedRecipe(for: "Swordfish")]
        ),
        Fish(
            name: "Blue Marlin",
            scientificName: "Makaira nigricans",
            description: "Ultimate big game fish. Known for spectacular jumps and incredible endurance. Trophy of a lifetime.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 150.0,
            averageLength: 350,
            rarity: .legendary,
            habitat: "Open tropical ocean",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Marlin"), smokedRecipe(for: "Marlin")]
        ),
        Fish(
            name: "Mahi-Mahi",
            scientificName: "Coryphaena hippurus",
            description: "Stunningly beautiful fish with vibrant colors. Fast-growing and delicious.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 100,
            rarity: .uncommon,
            habitat: "Tropical and subtropical oceans",
            bestSeason: "Spring and Summer",
            recipes: [grilledRecipe(for: "Mahi-Mahi"), bakedRecipe(for: "Mahi-Mahi"), cevicheRecipe(for: "Mahi-Mahi")]
        ),
        Fish(
            name: "Wahoo",
            scientificName: "Acanthocybium solandri",
            description: "One of the fastest fish in the sea. Excellent meat quality and thrilling to catch.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 20.0,
            averageLength: 150,
            rarity: .rare,
            habitat: "Tropical oceans",
            bestSeason: "Winter",
            recipes: [grilledRecipe(for: "Wahoo"), sashimiRecipe(for: "Wahoo"), cevicheRecipe(for: "Wahoo")]
        ),
        Fish(
            name: "Greater Amberjack",
            scientificName: "Seriola dumerili",
            description: "Powerful reef fish known for brutal fights. Pull you down into the structure if given the chance.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 15.0,
            averageLength: 100,
            rarity: .uncommon,
            habitat: "Reefs and wrecks",
            bestSeason: "Spring",
            recipes: [grilledRecipe(for: "Amberjack"), sashimiRecipe(for: "Amberjack")]
        ),
        Fish(
            name: "Yellowtail",
            scientificName: "Seriola lalandi",
            description: "Highly prized in Japanese cuisine. Strong fighter found around kelp beds and islands.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 90,
            rarity: .uncommon,
            habitat: "Coastal waters, kelp beds",
            bestSeason: "Summer and Fall",
            recipes: [sashimiRecipe(for: "Yellowtail"), grilledRecipe(for: "Yellowtail"), cevicheRecipe(for: "Yellowtail")]
        ),
        Fish(
            name: "King Mackerel",
            scientificName: "Scomberomorus cavalla",
            description: "Fast, aggressive predator popular with sport fishermen. Rich, oily meat.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 90,
            rarity: .common,
            habitat: "Coastal Atlantic and Gulf",
            bestSeason: "Spring and Fall",
            recipes: [grilledRecipe(for: "King Mackerel"), smokedRecipe(for: "King Mackerel")]
        ),
        Fish(
            name: "Cobia",
            scientificName: "Rachycentron canadum",
            description: "Curious fish that often follows large marine animals. Excellent fighter and superb eating.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 15.0,
            averageLength: 120,
            rarity: .uncommon,
            habitat: "Coastal waters, near structures",
            bestSeason: "Spring",
            recipes: [grilledRecipe(for: "Cobia"), bakedRecipe(for: "Cobia"), cevicheRecipe(for: "Cobia")]
        ),
        Fish(
            name: "Red Drum",
            scientificName: "Sciaenops ocellatus",
            description: "Iconic fish with distinctive black spot on tail. Excellent inshore game fish.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .common,
            habitat: "Estuaries and coastal waters",
            bestSeason: "Fall",
            recipes: [grilledRecipe(for: "Red Drum"), bakedRecipe(for: "Red Drum"), friedRecipe(for: "Red Drum")]
        ),
        Fish(
            name: "Black Drum",
            scientificName: "Pogonias cromis",
            description: "Large, bottom-dwelling fish. Makes drumming sound with swim bladder.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 80,
            rarity: .common,
            habitat: "Estuaries and bays",
            bestSeason: "Spring",
            recipes: [friedRecipe(for: "Black Drum"), bakedRecipe(for: "Black Drum")]
        ),
        Fish(
            name: "Summer Flounder",
            scientificName: "Paralichthys dentatus",
            description: "Popular flatfish also known as fluke. Lie camouflaged on sandy bottoms.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Sandy coastal bottoms",
            bestSeason: "Summer",
            recipes: [friedRecipe(for: "Flounder"), bakedRecipe(for: "Flounder"), grilledRecipe(for: "Flounder")]
        ),
        Fish(
            name: "Florida Pompano",
            scientificName: "Trachinotus carolinus",
            description: "Prized for its delicate, sweet flesh. One of the most valuable food fish.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 40,
            rarity: .rare,
            habitat: "Sandy beaches and inlets",
            bestSeason: "Fall and Spring",
            recipes: [grilledRecipe(for: "Pompano"), bakedRecipe(for: "Pompano")]
        ),
        Fish(
            name: "Permit",
            scientificName: "Trachinotus falcatus",
            description: "Holy grail of flats fishing. Extremely wary and challenging on fly tackle.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 70,
            rarity: .rare,
            habitat: "Tropical flats and reefs",
            bestSeason: "Spring and Summer",
            recipes: [grilledRecipe(for: "Permit"), cevicheRecipe(for: "Permit")]
        ),
        Fish(
            name: "Bluefish",
            scientificName: "Pomatomus saltatrix",
            description: "Voracious predator known as 'the chopper'. Aggressive feeders that provide exciting fishing.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Coastal waters worldwide",
            bestSeason: "Summer and Fall",
            recipes: [grilledRecipe(for: "Bluefish"), smokedRecipe(for: "Bluefish"), bakedRecipe(for: "Bluefish")]
        ),
        Fish(
            name: "Striped Bass",
            scientificName: "Morone saxatilis",
            description: "Premier game fish of the Atlantic coast. Anadromous fish with excellent flavor.",
            category: .saltwater,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 80,
            rarity: .uncommon,
            habitat: "Coastal waters and estuaries",
            bestSeason: "Spring and Fall",
            recipes: [grilledRecipe(for: "Striped Bass"), bakedRecipe(for: "Striped Bass"), friedRecipe(for: "Striped Bass")]
        )
    ]

    // MARK: - Tropical Fish (20)
    static let tropicalFish: [Fish] = [
        Fish(
            name: "Red Grouper",
            scientificName: "Epinephelus morio",
            description: "Popular reef fish with mild, sweet flesh. Changes color based on mood and surroundings.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 60,
            rarity: .common,
            habitat: "Rocky reefs and ledges",
            bestSeason: "Spring and Summer",
            recipes: [friedRecipe(for: "Grouper"), grilledRecipe(for: "Grouper"), bakedRecipe(for: "Grouper")]
        ),
        Fish(
            name: "Red Snapper",
            scientificName: "Lutjanus campechanus",
            description: "One of the most popular food fish in the world. Beautiful red color and excellent flavor.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 4.0,
            averageLength: 55,
            rarity: .uncommon,
            habitat: "Reefs and structure",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Red Snapper"), bakedRecipe(for: "Red Snapper"), friedRecipe(for: "Red Snapper")]
        ),
        Fish(
            name: "Great Barracuda",
            scientificName: "Sphyraena barracuda",
            description: "Fearsome predator with razor-sharp teeth. Explosive strikes and powerful runs.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 12.0,
            averageLength: 130,
            rarity: .uncommon,
            habitat: "Reefs and open water",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Barracuda"), smokedRecipe(for: "Barracuda")]
        ),
        Fish(
            name: "Queen Parrotfish",
            scientificName: "Scarus vetula",
            description: "Colorful reef fish that bites coral with beak-like teeth. Creates white sand beaches.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 45,
            rarity: .common,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Parrotfish"), bakedRecipe(for: "Parrotfish")]
        ),
        Fish(
            name: "Queen Triggerfish",
            scientificName: "Balistes vetula",
            description: "Aggressive reef fish with powerful jaws. Beautiful blue and yellow coloration.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 40,
            rarity: .uncommon,
            habitat: "Coral and rocky reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Triggerfish"), friedRecipe(for: "Triggerfish")]
        ),
        Fish(
            name: "Red Lionfish",
            scientificName: "Pterois volitans",
            description: "Invasive species with venomous spines. Actually delicious when properly prepared.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.5,
            averageLength: 30,
            rarity: .common,
            habitat: "Reefs and structure",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Lionfish"), cevicheRecipe(for: "Lionfish")]
        ),
        Fish(
            name: "Emperor Angelfish",
            scientificName: "Pomacanthus imperator",
            description: "Stunning reef fish with distinctive blue and yellow stripes. Popular in aquariums.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 1.2,
            averageLength: 35,
            rarity: .rare,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Angelfish")]
        ),
        Fish(
            name: "Blue Tang",
            scientificName: "Paracanthurus hepatus",
            description: "Iconic blue fish famous from animated films. Sharp spines near tail.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.6,
            averageLength: 25,
            rarity: .uncommon,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Blue Tang")]
        ),
        Fish(
            name: "Longnose Butterflyfish",
            scientificName: "Forcipiger flavissimus",
            description: "Delicate fish with elongated snout for picking food from coral crevices.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.2,
            averageLength: 18,
            rarity: .uncommon,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Butterflyfish")]
        ),
        Fish(
            name: "Napoleon Wrasse",
            scientificName: "Cheilinus undulatus",
            description: "One of the largest reef fish. Distinctive hump on forehead. Endangered species.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 50.0,
            averageLength: 180,
            rarity: .legendary,
            habitat: "Coral reefs and lagoons",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Wrasse"), bakedRecipe(for: "Wrasse")]
        ),
        Fish(
            name: "Sergeant Major",
            scientificName: "Abudefduf saxatilis",
            description: "Common damselfish with bold stripes. Guards eggs aggressively.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.15,
            averageLength: 15,
            rarity: .common,
            habitat: "Coral and rocky reefs",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Damselfish")]
        ),
        Fish(
            name: "Neon Goby",
            scientificName: "Elacatinus oceanops",
            description: "Tiny fish that cleans parasites from larger fish. Brilliant blue stripes.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.002,
            averageLength: 5,
            rarity: .common,
            habitat: "Coral heads",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Bicolor Blenny",
            scientificName: "Ecsenius bicolor",
            description: "Small, curious fish that peers out from holes in the reef.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.01,
            averageLength: 8,
            rarity: .common,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Scrawled Filefish",
            scientificName: "Aluterus scriptus",
            description: "Oddly shaped fish with sandpaper-like skin. Slow swimmer.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 60,
            rarity: .uncommon,
            habitat: "Reefs and open water",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Filefish")]
        ),
        Fish(
            name: "Porcupinefish",
            scientificName: "Diodon hystrix",
            description: "Can inflate body and erect spines when threatened. Related to pufferfish.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 2.5,
            averageLength: 50,
            rarity: .uncommon,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Spotted Boxfish",
            scientificName: "Ostracion meleagris",
            description: "Boxy-shaped fish with spotted pattern. Releases toxins when stressed.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.3,
            averageLength: 20,
            rarity: .uncommon,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Yellowhead Jawfish",
            scientificName: "Opistognathus aurifrons",
            description: "Burrow-dwelling fish that mouth-broods eggs. Pops head out of holes.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.03,
            averageLength: 10,
            rarity: .rare,
            habitat: "Sandy bottoms near reefs",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Flame Cardinalfish",
            scientificName: "Apogon maculatus",
            description: "Nocturnal fish that hides in caves during the day.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.02,
            averageLength: 8,
            rarity: .common,
            habitat: "Reef caves and crevices",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Longnose Hawkfish",
            scientificName: "Oxycirrhites typus",
            description: "Perches on coral branches watching for prey. Long snout for picking small prey.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 0.04,
            averageLength: 12,
            rarity: .rare,
            habitat: "Deep coral reefs",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Nassau Grouper",
            scientificName: "Epinephelus striatus",
            description: "Once abundant, now critically endangered. Forms spawning aggregations.",
            category: .tropical,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 80,
            rarity: .legendary,
            habitat: "Coral reefs",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Nassau Grouper"), bakedRecipe(for: "Nassau Grouper")]
        )
    ]

    // MARK: - Arctic Fish (20)
    static let arcticFish: [Fish] = [
        Fish(
            name: "Atlantic Cod",
            scientificName: "Gadus morhua",
            description: "Historic fish that fed nations. Mild, flaky white flesh ideal for many preparations.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 80,
            rarity: .common,
            habitat: "Cold Atlantic waters",
            bestSeason: "Winter",
            recipes: [friedRecipe(for: "Cod"), bakedRecipe(for: "Cod"), soupRecipe(for: "Cod")]
        ),
        Fish(
            name: "Alaska Pollock",
            scientificName: "Gadus chalcogrammus",
            description: "Most heavily fished species in the world. Used for surimi and fish sticks.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 50,
            rarity: .common,
            habitat: "North Pacific",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Pollock"), bakedRecipe(for: "Pollock")]
        ),
        Fish(
            name: "Arctic Char",
            scientificName: "Salvelinus alpinus",
            description: "Northernmost freshwater fish. Beautiful pink flesh with delicate flavor.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 55,
            rarity: .rare,
            habitat: "Arctic lakes and coastal waters",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Arctic Char"), smokedRecipe(for: "Arctic Char"), bakedRecipe(for: "Arctic Char")]
        ),
        Fish(
            name: "Greenland Halibut",
            scientificName: "Reinhardtius hippoglossoides",
            description: "Deep-water flatfish with high oil content. Excellent for smoking.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 90,
            rarity: .uncommon,
            habitat: "Deep Arctic waters",
            bestSeason: "Winter",
            recipes: [smokedRecipe(for: "Greenland Halibut"), grilledRecipe(for: "Greenland Halibut")]
        ),
        Fish(
            name: "Capelin",
            scientificName: "Mallotus villosus",
            description: "Small, important forage fish. Prized for its roe in Japanese cuisine.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 0.04,
            averageLength: 15,
            rarity: .common,
            habitat: "Arctic and subarctic seas",
            bestSeason: "Spring",
            recipes: [friedRecipe(for: "Capelin"), smokedRecipe(for: "Capelin")]
        ),
        Fish(
            name: "Arctic Grayling",
            scientificName: "Thymallus arcticus",
            description: "Beautiful fish with large, colorful dorsal fin. Excellent on light tackle.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 1.0,
            averageLength: 40,
            rarity: .uncommon,
            habitat: "Cold, clear streams and lakes",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Grayling"), friedRecipe(for: "Grayling")]
        ),
        Fish(
            name: "Lake Whitefish",
            scientificName: "Coregonus clupeaformis",
            description: "Important commercial species with mild flavor. Often smoked.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Northern lakes",
            bestSeason: "Fall and Winter",
            recipes: [smokedRecipe(for: "Whitefish"), friedRecipe(for: "Whitefish"), bakedRecipe(for: "Whitefish")]
        ),
        Fish(
            name: "Inconnu",
            scientificName: "Stenodus leucichthys",
            description: "Large whitefish also called sheefish. Excellent sport fish of the north.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 90,
            rarity: .rare,
            habitat: "Arctic rivers and lakes",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Inconnu"), smokedRecipe(for: "Inconnu")]
        ),
        Fish(
            name: "Burbot",
            scientificName: "Lota lota",
            description: "Only freshwater member of the cod family. Looks like a cross between eel and catfish.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 3.0,
            averageLength: 60,
            rarity: .uncommon,
            habitat: "Deep, cold lakes and rivers",
            bestSeason: "Winter",
            recipes: [friedRecipe(for: "Burbot"), soupRecipe(for: "Burbot")]
        ),
        Fish(
            name: "Arctic Cisco",
            scientificName: "Coregonus autumnalis",
            description: "Silvery fish important to indigenous peoples. Runs up rivers in fall.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 0.5,
            averageLength: 35,
            rarity: .common,
            habitat: "Arctic coastal waters and rivers",
            bestSeason: "Fall",
            recipes: [smokedRecipe(for: "Cisco"), friedRecipe(for: "Cisco")]
        ),
        Fish(
            name: "Broad Whitefish",
            scientificName: "Coregonus nasus",
            description: "Large whitefish of Arctic rivers. Important subsistence fish.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 4.0,
            averageLength: 60,
            rarity: .uncommon,
            habitat: "Arctic rivers and lakes",
            bestSeason: "Summer",
            recipes: [smokedRecipe(for: "Broad Whitefish"), bakedRecipe(for: "Broad Whitefish")]
        ),
        Fish(
            name: "Round Whitefish",
            scientificName: "Prosopium cylindraceum",
            description: "Smaller whitefish with cylindrical body. Good eating when properly prepared.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 0.8,
            averageLength: 35,
            rarity: .common,
            habitat: "Northern lakes and streams",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Round Whitefish"), smokedRecipe(for: "Round Whitefish")]
        ),
        Fish(
            name: "Dolly Varden",
            scientificName: "Salvelinus malma",
            description: "Beautiful char with spotted pattern. Sea-run forms can reach good size.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 45,
            rarity: .uncommon,
            habitat: "Coastal streams and lakes",
            bestSeason: "Summer and Fall",
            recipes: [grilledRecipe(for: "Dolly Varden"), smokedRecipe(for: "Dolly Varden"), bakedRecipe(for: "Dolly Varden")]
        ),
        Fish(
            name: "Bull Trout",
            scientificName: "Salvelinus confluentus",
            description: "Native char of the Pacific Northwest. Aggressive predator of other fish.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 4.0,
            averageLength: 60,
            rarity: .rare,
            habitat: "Cold mountain streams",
            bestSeason: "Fall",
            recipes: [grilledRecipe(for: "Bull Trout"), bakedRecipe(for: "Bull Trout")]
        ),
        Fish(
            name: "Saffron Cod",
            scientificName: "Eleginus gracilis",
            description: "Small cod found in Arctic Pacific waters. Important prey for marine mammals.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 0.3,
            averageLength: 25,
            rarity: .common,
            habitat: "Arctic and subarctic Pacific",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Saffron Cod")]
        ),
        Fish(
            name: "Pacific Cod",
            scientificName: "Gadus macrocephalus",
            description: "Pacific relative of Atlantic cod. Important commercial species.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .common,
            habitat: "North Pacific",
            bestSeason: "Winter",
            recipes: [friedRecipe(for: "Pacific Cod"), bakedRecipe(for: "Pacific Cod"), soupRecipe(for: "Pacific Cod")]
        ),
        Fish(
            name: "Lingcod",
            scientificName: "Ophiodon elongatus",
            description: "Not a true cod. Aggressive predator with sometimes blue-green flesh.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 90,
            rarity: .uncommon,
            habitat: "Rocky Pacific coast",
            bestSeason: "Winter",
            recipes: [grilledRecipe(for: "Lingcod"), friedRecipe(for: "Lingcod"), bakedRecipe(for: "Lingcod")]
        ),
        Fish(
            name: "Sablefish",
            scientificName: "Anoplopoma fimbria",
            description: "Also called black cod. Rich, buttery flesh prized in fine dining.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .rare,
            habitat: "Deep North Pacific",
            bestSeason: "Year-round",
            recipes: [smokedRecipe(for: "Sablefish"), grilledRecipe(for: "Sablefish"), bakedRecipe(for: "Sablefish")]
        ),
        Fish(
            name: "Yelloweye Rockfish",
            scientificName: "Sebastes ruberrimus",
            description: "Long-lived rockfish that can reach 120 years old. Bright orange-red color.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 60,
            rarity: .rare,
            habitat: "Deep rocky reefs",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Rockfish"), bakedRecipe(for: "Rockfish"), friedRecipe(for: "Rockfish")]
        ),
        Fish(
            name: "Pacific Staghorn Sculpin",
            scientificName: "Leptocottus armatus",
            description: "Unusual looking fish with spiny head. Common in Pacific tide pools.",
            category: .arctic,
            imageName: "fish.fill",
            averageWeight: 0.2,
            averageLength: 20,
            rarity: .common,
            habitat: "Coastal Pacific waters",
            bestSeason: "Year-round",
            recipes: [friedRecipe(for: "Sculpin")]
        )
    ]

    // MARK: - Brackish Fish (20)
    static let brackishFish: [Fish] = [
        Fish(
            name: "Atlantic Tarpon",
            scientificName: "Megalops atlanticus",
            description: "The silver king. Incredible jumper and one of the most exciting fish to catch.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 40.0,
            averageLength: 180,
            rarity: .legendary,
            habitat: "Coastal waters and estuaries",
            bestSeason: "Spring and Summer",
            recipes: []
        ),
        Fish(
            name: "Common Snook",
            scientificName: "Centropomus undecimalis",
            description: "Prized game fish of Florida. Excellent eating with firm, white flesh.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .uncommon,
            habitat: "Mangroves and inlets",
            bestSeason: "Summer",
            recipes: [grilledRecipe(for: "Snook"), bakedRecipe(for: "Snook"), cevicheRecipe(for: "Snook")]
        ),
        Fish(
            name: "Redfish",
            scientificName: "Sciaenops ocellatus",
            description: "Popular game and food fish with distinctive black spot. Also called red drum.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 70,
            rarity: .common,
            habitat: "Estuaries and coastal flats",
            bestSeason: "Fall",
            recipes: [grilledRecipe(for: "Redfish"), bakedRecipe(for: "Redfish"), friedRecipe(for: "Redfish")]
        ),
        Fish(
            name: "Southern Flounder",
            scientificName: "Paralichthys lethostigma",
            description: "Popular flatfish that ambushes prey from sandy bottoms.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Estuaries and bays",
            bestSeason: "Fall",
            recipes: [friedRecipe(for: "Southern Flounder"), grilledRecipe(for: "Southern Flounder"), bakedRecipe(for: "Southern Flounder")]
        ),
        Fish(
            name: "Sheepshead",
            scientificName: "Archosargus probatocephalus",
            description: "Has human-like teeth for crushing shellfish. Tricky to hook but excellent eating.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 40,
            rarity: .common,
            habitat: "Pilings and structure",
            bestSeason: "Winter and Spring",
            recipes: [friedRecipe(for: "Sheepshead"), grilledRecipe(for: "Sheepshead"), bakedRecipe(for: "Sheepshead")]
        ),
        Fish(
            name: "Black Drum",
            scientificName: "Pogonias cromis",
            description: "Large fish that makes drumming sounds. Can live over 60 years.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 10.0,
            averageLength: 80,
            rarity: .common,
            habitat: "Bays and estuaries",
            bestSeason: "Spring",
            recipes: [friedRecipe(for: "Black Drum"), bakedRecipe(for: "Black Drum")]
        ),
        Fish(
            name: "Spotted Seatrout",
            scientificName: "Cynoscion nebulosus",
            description: "Popular Gulf Coast game fish. Beautiful spotted pattern and excellent flavor.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Grass flats and estuaries",
            bestSeason: "Fall",
            recipes: [grilledRecipe(for: "Seatrout"), friedRecipe(for: "Seatrout"), bakedRecipe(for: "Seatrout")]
        ),
        Fish(
            name: "Ladyfish",
            scientificName: "Elops saurus",
            description: "Acrobatic fighter also known as skipjack. Leaps repeatedly when hooked.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 1.0,
            averageLength: 50,
            rarity: .common,
            habitat: "Coastal and estuarine waters",
            bestSeason: "Summer",
            recipes: [smokedRecipe(for: "Ladyfish")]
        ),
        Fish(
            name: "Jack Crevalle",
            scientificName: "Caranx hippos",
            description: "Powerful fighter that never gives up. Travels in schools hunting baitfish.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 6.0,
            averageLength: 70,
            rarity: .common,
            habitat: "Coastal waters and inlets",
            bestSeason: "Summer and Fall",
            recipes: [smokedRecipe(for: "Jack Crevalle"), grilledRecipe(for: "Jack Crevalle")]
        ),
        Fish(
            name: "Mangrove Snapper",
            scientificName: "Lutjanus griseus",
            description: "Wary fish found around structure. Excellent table fare.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 1.5,
            averageLength: 35,
            rarity: .common,
            habitat: "Mangroves and docks",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Mangrove Snapper"), friedRecipe(for: "Mangrove Snapper"), cevicheRecipe(for: "Mangrove Snapper")]
        ),
        Fish(
            name: "Striped Mullet",
            scientificName: "Mugil cephalus",
            description: "Important baitfish that also makes good eating. Famous for spectacular leaps.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 1.0,
            averageLength: 40,
            rarity: .common,
            habitat: "Coastal waters worldwide",
            bestSeason: "Fall",
            recipes: [smokedRecipe(for: "Mullet"), friedRecipe(for: "Mullet")]
        ),
        Fish(
            name: "Mozambique Tilapia",
            scientificName: "Oreochromis mossambicus",
            description: "Hardy fish that tolerates various conditions. Important aquaculture species.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 1.0,
            averageLength: 30,
            rarity: .common,
            habitat: "Brackish and fresh waters",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Tilapia"), friedRecipe(for: "Tilapia"), bakedRecipe(for: "Tilapia")]
        ),
        Fish(
            name: "Barramundi",
            scientificName: "Lates calcarifer",
            description: "Prized Australian sport fish. Can grow to impressive sizes in tropical waters.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 8.0,
            averageLength: 90,
            rarity: .rare,
            habitat: "Estuaries and rivers",
            bestSeason: "Wet season",
            recipes: [grilledRecipe(for: "Barramundi"), bakedRecipe(for: "Barramundi"), curryRecipe(for: "Barramundi")]
        ),
        Fish(
            name: "Asian Sea Bass",
            scientificName: "Lates calcarifer",
            description: "Same species as barramundi. Important food fish throughout Asia.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 6.0,
            averageLength: 80,
            rarity: .uncommon,
            habitat: "Estuaries and coastal waters",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Sea Bass"), bakedRecipe(for: "Sea Bass"), curryRecipe(for: "Sea Bass")]
        ),
        Fish(
            name: "Milkfish",
            scientificName: "Chanos chanos",
            description: "Important food fish in Southeast Asia. Very bony but flavorful.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 5.0,
            averageLength: 100,
            rarity: .uncommon,
            habitat: "Coastal and brackish waters",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Milkfish"), friedRecipe(for: "Milkfish")]
        ),
        Fish(
            name: "Banded Archerfish",
            scientificName: "Toxotes jaculatrix",
            description: "Famous for shooting water jets to knock insects into the water.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 0.15,
            averageLength: 20,
            rarity: .rare,
            habitat: "Mangroves and estuaries",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Atlantic Mudskipper",
            scientificName: "Periophthalmus barbarus",
            description: "Amazing fish that can walk on land and climb trees. Breathes through skin.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 0.05,
            averageLength: 15,
            rarity: .uncommon,
            habitat: "Mudflats and mangroves",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Four-eyed Fish",
            scientificName: "Anableps anableps",
            description: "Unique fish with divided eyes to see above and below water simultaneously.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 0.1,
            averageLength: 25,
            rarity: .rare,
            habitat: "Surface of brackish waters",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Gulf Pipefish",
            scientificName: "Syngnathus scovelli",
            description: "Relative of seahorses. Males carry eggs in pouch. Lives in seagrass.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 0.01,
            averageLength: 15,
            rarity: .common,
            habitat: "Seagrass beds",
            bestSeason: "Year-round",
            recipes: []
        ),
        Fish(
            name: "Bermuda Sea Chub",
            scientificName: "Kyphosus sectatrix",
            description: "Schooling fish that feeds on algae. Often follows boats looking for scraps.",
            category: .brackish,
            imageName: "fish.fill",
            averageWeight: 2.0,
            averageLength: 45,
            rarity: .common,
            habitat: "Reefs and rocky shores",
            bestSeason: "Year-round",
            recipes: [grilledRecipe(for: "Sea Chub"), friedRecipe(for: "Sea Chub")]
        )
    ]
}
