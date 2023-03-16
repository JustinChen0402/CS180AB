







class Biometric:
    def __init__(self, weight, bmi, body_fat, subcutaneous_fat, visceral_fat, body_water, skeletal_muscle, muscle_mass, bone_mass, protein_percent, bmr, metabolic_age):

        self.weight = weight
        self.bmi = bmi
        self.body_fat = body_fat
        self.subcutaneous_fat = subcutaneous_fat
        self.visceral_fat = visceral_fat
        self.body_water = body_water
        self.skeletal_muscle = skeletal_muscle
        self.muscle_mass = muscle_mass
        self.bone_mass = bone_mass
        self.protein_percent = protein_percent
        self.bmr = bmr
        self.metabolic_age = metabolic_age
class NutritionData:
    def __init__(self, energy, alcohol, caffeine, water, b1, b2, b3, b5, b6, b12, folate, vitamin_a, vitamin_c, vitamin_d, vitamin_e, vitamin_k, calcium, copper, iron, magnesium, manganese, phosphorus, potassium, selenium, sodium, zinc, carbs, fiber, starch, sugars, net_carbs, fat, cholesterol, monounsaturated, polyunsaturated, saturated, trans_fats, omega_3, omega_6, cystine, histidine, isoleucine, leucine, lysine, methionine, phenylalanine, protein, threonine, tryptophan, tyrosine, valine):
        self.energy = energy
        self.alcohol = alcohol
        self.caffeine = caffeine
        self.water = water
        self.b1 = b1
        self.b2 = b2
        self.b3 = b3
        self.b5 = b5
        self.b6 = b6
        self.b12 = b12
        self.folate = folate
        self.vitamin_a = vitamin_a
        self.vitamin_c = vitamin_c
        self.vitamin_d = vitamin_d
        self.vitamin_e = vitamin_e
        self.vitamin_k = vitamin_k
        self.calcium = calcium
        self.copper = copper
        self.iron = iron
        self.magnesium = magnesium
        self.manganese = manganese
        self.phosphorus = phosphorus
        self.potassium = potassium
        self.selenium = selenium
        self.sodium = sodium
        self.zinc = zinc
        self.carbs = carbs
        self.fiber = fiber
        self.starch = starch
        self.sugars = sugars
        self.net_carbs = net_carbs
        self.fat = fat
        self.cholesterol = cholesterol
        self.monounsaturated = monounsaturated
        self.polyunsaturated = polyunsaturated
        self.saturated = saturated
        self.trans_fats = trans_fats
        self.omega_3 = omega_3
        self.omega_6 = omega_6
        self.cystine = cystine
        self.histidine = histidine
        self.isoleucine = isoleucine
        self.leucine = leucine
        self.lysine = lysine
        self.methionine = methionine
        self.phenylalanine = phenylalanine
        self.protein = protein
        self.threonine = threonine
        self.tryptophan = tryptophan
        self.tyrosine = tyrosine
        self.valine = valine


class person():
    def __init__(self,gender,age):
        self.gender = gender
        self.age = age
        self.Biometric =[]
        self.NutritionData = []

