#!/usr/bin/env python
# coding: utf-8

# In[1]:


import requests
from bs4 import BeautifulSoup
import re



"""
提取网站的返回的 Macronutrients数据
Process the returned Macronutrients data from the table
"""
def process_dict(input_dict):
    result = {}
    for key in input_dict:
        value_list = input_dict[key]
        for string in value_list:
            cleaned_string_list = re.findall(r'\d+(?:\.\d+)?', string)
            float_values = [float(num) for num in cleaned_string_list if num]
            result[key] = float_values
    return result




"""
提取网站的返回的 Vitamins和Minerals数据
Extract the returned Vitamins and Minerals data from the table
"""
def process_dict_b(input_dict):

    result = {}
    for key in input_dict:
        value_list = input_dict[key]
        float_values = []
        for string in value_list:
            cleaned_string_list = re.sub(r'[^0-9.]+', '', string)
            if cleaned_string_list:
                float_values.append(float(cleaned_string_list))
            else:
                float_values.append(None)
        result[key] = float_values
    return result



"""
从网站返回的html 中提取 3个table
Extract the Macronutrients,Vitamins and Minerals table from the website
"""
def extra_table(soup,id,number):


    # Find the table with id 'macronutrients-table'
    table = soup.find('table', {'id': id})
    temp = {}
    # Find the table rows in the table body
    rows = table.tbody.find_all('tr')

    # Iterate over the rows and extract the macronutrient data
    # Iterate over the rows and extract the macronutrient data
    for row in rows:
        cells = row.find_all('td')
        if len(cells) == number:
            temp[cells[0].text.strip()] = [cells[i].text.strip() for i in range(1,number)]
    return temp


"""
Send data to the website to get Daily nutrient recommendations
"""
def pull(sex,age,feet,inches,pounds,activity_level = 'Active'):
    url = "https://www.nal.usda.gov/human-nutrition-and-food-safety/dri-calculator"

    # 构造POST请求参数
    payload = {
        "measurement_units": "std",
        "sex": sex,
        "age_value": age,
        "age_type": "yrs",
        "feet": feet,
        "inches": inches,
        "cm": None,
        "pounds": pounds,
        "kilos": None,
        "activity_level": activity_level,
        "op": "Submit",
        "form_build_id": None,
        "form_id": "dri_calculator_form"
    }


    # 发送POST请求
    response = requests.post(url, data=payload)

    html_content = response.content
    soup = BeautifulSoup(html_content, 'html.parser')

    return extra_table(soup,"macronutrients-table",2),extra_table(soup, "vitamins-table", 3),extra_table(soup, "minerals-table", 3)



"""
change the table date to fit the excel  label in order to do the comparsion
Also do the unit change
"""
def process_data(a,b,c):
    a['Carbs (g)'] = a.pop('Carbohydrate')
    a['Fiber (g)'] = a.pop('Total Fiber')
    a['Protein (g)'] = a.pop('Protein')
    a['Fat (g)'] = a.pop('Fat')
    a['Trans-Fats (g)'] = a.pop('Trans fatty acids')
    a['Cholesterol (mg)'] = a.pop('Dietary Cholesterol')
    a['water'] = a.pop('Total Water')
    
    b['Vitamin A (IU)'] = b.pop('Vitamin A')
    b['Vitamin C (mg)'] = b.pop('Vitamin C')
    b['Vitamin D (IU)'] = b.pop('Vitamin D')
    b['B6 (Pyridoxine) (mg)'] = b.pop('Vitamin B6')
    b['Vitamin E (mg)'] = b.pop('Vitamin E')
    b['Vitamin K (µg)'] = b.pop('Vitamin K')
    b['B1 (Thiamine) (mg)'] = b.pop('Thiamin')
    b['B12 (Cobalamin) (µg)'] = b.pop('Vitamin B12')
    b['B2 (Riboflavin) (mg)'] = b.pop('Riboflavin')
    b['Folate (µg)'] = b.pop('Folate')
    b['B3 (Niacin) (mg)'] = b.pop('Niacin')
    b['B5 (Pantothenic Acid) (mg)'] = b.pop('Pantothenic Acid')
    
    c['Calcium (mg)'] = c.pop('Calcium')
    c['Iron (mg)'] = c.pop('Iron')
    c['Magnesium (mg)'] = c.pop('Magnesium')
    c['Manganese (mg)'] = c.pop('Manganese')
    c['Phosphorus (mg)'] = c.pop('Phosphorus')
    c['Potassium (mg)'] = c.pop('Potassium')
    c['Selenium (µg)'] = c.pop('Selenium')
    c['Sodium (mg)'] = c.pop('Sodium')
    c['Zinc (mg)'] = c.pop('Zinc')
    #extra numeric data
    a =  process_dict(a)
    b =  process_dict_b(b)
    c =  process_dict_b(c)
    #change unit
    a['water'] = a['water'][0]*1000
    b['Vitamin A (IU)'] = [i*20 for i in b['Vitamin A (IU)']]
    b['Vitamin D (IU)'] = [i * 40 for i in b['Vitamin D (IU)']]
    c['Phosphorus (mg)'] = [i * 1000 for i in c['Phosphorus (mg)']]
    #remove 0 UL value
    for k,v in b.items():
        if len(v) == 2 and v[1] == 0:
            b[k] = [v[0]]
    for k,v in c.items():
        if len(v) == 2 and v[1] == 0:
            c[k] = [v[0]]
    return a,b,c

    


# In[ ]:




