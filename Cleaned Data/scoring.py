from data_template import Biometric,NutritionData
from nutrition import rdi
from biometric import body_metrics




def score_nutrition(N,gender,age):
    #pre-process
    n1 = []
    for n in dir(N):
        if not hasattr(NutritionData, n):
            # print("n",n)
            n1.append(n)
    # print(n1)
    n2 = []

    for n in rdi.keys():
        n2.append(n)
    n2.sort()

    mapping = {k: v for k, v in zip(n1, n2)}
    #
    score = []
    for n in dir(N):
        if not hasattr(NutritionData,n):
            take = getattr(N, n)
            #print(n)
            #print(mapping[n])
            #print(rdi[mapping[n]].keys())
            result = [item for item in rdi[mapping[n]].keys() if all(substring in item for substring in ["Adult","(male)"])]
            if result == []:
                result = [item for item in rdi[mapping[n]].keys() if "Adult" in item]
            need_take = rdi[mapping[n]][result[0]] + 0.000001
            score.append(take/need_take if take/need_take <= 1 else 1)
    return sum(score)/len(score)


#remove body type, fat_free_weight, muscle_storage_ability
def score_biometric(B,gender,age):
    # pre-process
    n1 = []
    for n in dir(B):
        if not hasattr(Biometric, n):
            # print("n",n)
            n1.append(n)
    # print(n1)
    n2 = []

    for n in body_metrics.keys():
        n2.append(n)
    n2.sort()
    score = []
    for a,b in zip(n1,n2):
        user_value = getattr(B,a)
        right_value = 0
        for age in body_metrics[b].keys():
            if "18" in age:
                if type(body_metrics[b][age]) == dict:
                    right_value = body_metrics[b][age]["men"]
                else:
                    right_value = body_metrics[b][age]
        if type(right_value) == tuple:
            temp = 1 if user_value in range(int(right_value[0]),int(right_value[1])) else 0.5
        else:
            temp = 1 - (user_value/right_value)
        score.append(temp)
    return sum(score)/len(score)



test = Biometric(*[i for i in range(12)])
print(score_biometric(test,1,1))
#print(score_nutrition(test,1,1))





