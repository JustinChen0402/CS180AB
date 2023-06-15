

import pandas
import csv



#储存每天的健康数据
class Day:
    def __init__(self):
        self.sleep = None
        #biometric.csv
        self.body_Fat = None
        self.heart_Rate = None
        self.weight = None
        self.nutrition = None
        





class Person:
    def __init__(self,age,gender,height):
        self.height = height
        self.age = age
        self.gender = gender
        self.Days = {}



def create_person(gender,age,height):

    Tom = Person(age,gender,height)

    folder_path = "noNull/"
    #sleep
    with open(folder_path +'sleep_noNull.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader) # skip the first row
        for row in reader:
            day = row[0]
            if day not in Tom.Days.keys():
                temp_day = Day()
                temp_day.sleep = row[1]
                Tom.Days[day] = temp_day

    #biometric
    with open(folder_path +'biometric_noNull.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader) # skip the first row
        for row in reader:
            day = row[0]
            if day not in Tom.Days.keys():
                temp_day = Day()
                temp_day.body_Fat = row[1]
                temp_day.sleep = row[2]
                temp_day.heart_Rate = row[3]
                temp_day.weight = row[4]
                Tom.Days[day] = temp_day
            else:
                Tom.Days[day].sleep = row[2] if Tom.Days[day].sleep == 'null' else 'null'
                Tom.Days[day].body_Fat = row[1] if Tom.Days[day].body_Fat == 'null' else 'null'
                Tom.Days[day].heart_Rate = row[3] if Tom.Days[day].heart_Rate == 'null' else 'null'
                Tom.Days[day].weight = row[4] if Tom.Days[day].weight == 'null' else 'null'
    #bodyfat
    with open(folder_path +'bodyfat_noNull.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader) # skip the first row
        for row in reader:
            day = row[0]
            if day not in Tom.Days.keys():
                temp_day = Day()
                temp_day.body_Fat = row[1]
                Tom.Days[day] = temp_day
            else:
                Tom.Days[day].body_Fat = row[1] if Tom.Days[day].body_Fat == 'null' else 'null'
    #heartrate
    with open(folder_path +'heartrate_noNull.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader) # skip the first row
        for row in reader:
            day = row[0]
            if day not in Tom.Days.keys():
                temp_day = Day()
                temp_day.heart_Rate = row[1]
                Tom.Days[day] = temp_day
            else:
                Tom.Days[day].heart_Rate = row[1] if Tom.Days[day].heart_Rate == 'null' else 'null'
    #clean_weight
    with open(folder_path +'weight_noNull.csv', 'r') as file:
        reader = csv.reader(file)
        next(reader) # skip the first row
        for row in reader:
            day = row[0]
            if day not in Tom.Days.keys():
                temp_day = Day()
                temp_day.weight = row[1]
                Tom.Days[day] = temp_day
            else:
                Tom.Days[day].weight = row[1] if Tom.Days[day].weight == 'null' else 'null'


    # 处理营养数据
    file_name = 'Nutrition Summary Jan 2019 thru July 2021 from Cronometer.csv'

    with open(file_name, 'r') as file:
        reader = csv.reader(file)
        header = next(reader)  # This reads the first line, which is usually the header

    header = header[1:-1]

    from datetime import datetime
    def time_convert(day):
        date_object = datetime.strptime(day, '%m/%d/%Y')
        return date_object.strftime('%Y-%m-%d')


    with open(file_name, 'r') as file:
        reader = csv.reader(file)
        next(reader)  # Skip the header

        for row in reader:
            day = time_convert(row[0])
            if day not in Tom.Days.keys():
                temp_day = Day()
                Tom.Days[day] = temp_day
            try:
                temp_N = {k:float(v) for k,v in zip(header,row[1:-1])}
                Tom.Days[day].nutrition = temp_N
            except:
                pass
    return Tom







