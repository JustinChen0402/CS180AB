import data_template
import dri
from collections import defaultdict

# avgMacro = defaultdict(int)


def bmi_score(height, weight, age, gender):

    bmi = weight / (height ** 2)

    # Age factor
    if age <= 18:
        age_factor = 1.0
    elif age <= 35:
        age_factor = 0.9
    elif age <= 55:
        age_factor = 0.8
    else:
        age_factor = 0.7

    # Gender factor
    if gender.lower() == 'male':
        gender_factor = 1.0
    else:
        gender_factor = 1.1

    # Scoring system
    score = 0
    if bmi < 16.0:
        score = 0.1
    elif bmi <= 16.9:
        score = 0.25
    elif bmi <= 18.4:
        score = 0.5
    elif bmi <= 23.9:
        score = 1.0
    elif bmi <= 27.9:
        score = 0.75
    elif bmi <= 31.9:
        score = 0.5
    elif bmi <= 34.9:
        score = 0.25
    else:
        score = 0.1

    # Apply age and gender factors
    #print(score)
    score *= age_factor * gender_factor
    #print(height, weight, bmi, age_factor, gender_factor, score)
    return score

def sleep_score(hours_of_sleep, ideal_hours_of_sleep=8, max_score= 1, consistency=1.0):
    # Check if the input is within the valid range (0-24 hours)
    if not (0 <= hours_of_sleep <= 24):
        raise ValueError("Invalid input: hours_of_sleep should be between 0 and 24.")

    # Calculate the sleep score based on the difference from the ideal hours of sleep
    difference = abs(hours_of_sleep - ideal_hours_of_sleep)
    base_score = max_score - (difference / ideal_hours_of_sleep) * max_score



    # Sleep consistency factor (0-1 scale, with 1 being the most consistent)
    if not (0 <= consistency <= 1):
        raise ValueError("Invalid input: consistency should be between 0 and 1.")
    final_score = base_score * consistency

    return final_score




def dri_score_Macronutrient(user,web):
    max_score = 0
    current_score = 0
    for k1 in user.keys():
        if k1 in web.keys() and web[k1]:
            max_score += 1
            subscore = 0
            if len(web[k1]) == 1:
                subscore = user[k1]/web[k1][0] if web[k1][0]>= user[k1] else max(0.3,2 - user[k1]/web[k1][0])
                # current_score = current_score + user[k1]/web[k1][0] if web[k1][0]>= user[k1] else current_score + max(0.3,2 - user[k1]/web[k1][0])
            if len(web[k1]) == 2:
                r1,r2 = min(web[k1]),max(web[k1])
                if user[k1] >= r1 and user[k1] <= r2:
                    subscore = 1
                    # current_score += 1
                elif user[k1] < r1:
                    subscore = user[k1]/r1
                    # current_score += user[k1]/r1
                else:
                    subscore = (1 - r2/user[k1])
                    # current_score += (1 - r2/user[k1])
            current_score += subscore
            # avgMacro[k1] += subscore
    return current_score/max_score

def dri_score_Vitamins_Minerals(user,web):
    max_score = 0
    current_score = 0
    for k1 in user.keys():
        if k1 in web.keys() and web[k1]:
            max_score += 1
            if len(web[k1]) == 1:
                current_score += user[k1]/web[k1][0] if web[k1][0]>= user[k1] else 1
            elif len(web[k1]) == 2:
                re = web[k1][0]
                ul = web[k1][1]
                if user[k1] > ul:
                    current_score -= 0.8
                elif user[k1] <= re :
                    current_score += user[k1]/re
                else:
                    current_score += 1
            """
            print(k1)
            print(user[k1])
            print(web[k1])
            print(current_score,max_score)
            print("*************************")
            """

    return current_score/max_score


def score(height, weight, age, gender,sleep_hour,nutrition,activity_level = "Active"):
    total_inches = height[0] * 12 + height[1]
    m = total_inches * 2.54/100

    bmi = bmi_score(m,weight*0.45359237,age,gender)
    sleep = sleep_score(sleep_hour)

    a, b, c = dri.pull(gender, age, height[0], height[1], weight, activity_level)
    Macronutrient, b, c = dri.process_data(a, b, c)
    vitamins_and_Minerals = {}
    vitamins_and_Minerals.update(b)
    vitamins_and_Minerals.update(c)
    n1 = dri_score_Macronutrient(nutrition,Macronutrient)
    n2 = dri_score_Vitamins_Minerals(nutrition,vitamins_and_Minerals)
    # print(bmi,sleep,n1,n2)
    # return 0.3*bmi + 0.3*sleep + 0.2*n1 + 0.2*n2, sleep, sleep_hour, n1, n2
    return 0.3*bmi + 0.3*sleep + 0.2*n1 + 0.2*n2, sleep, n1, n2





# Tom = data_template.create_person("male",30,[5,7])

# count = 0
# for i,v in Tom.Days.items():
#     if count >= 7:
#         break
    
#     if v.nutrition:
#         a, b, c = dri.pull("male", 30, 5, 7, 170)
#         Macronutrient, b, c = dri.process_data(a, b, c)
#         vitamins_and_Minerals = {}
#         vitamins_and_Minerals.update(b)
#         vitamins_and_Minerals.update(c)
#         n1 = dri_score_Macronutrient(v.nutrition, Macronutrient)
#         n2 = dri_score_Vitamins_Minerals(v.nutrition, vitamins_and_Minerals)

#         count += 1

# for m in avgMacro:
#     avgMacro[m] = avgMacro[m]/count

# print(avgMacro)
# print(Macronutrient.keys())








