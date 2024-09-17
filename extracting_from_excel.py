# -*- coding: utf-8 -*-
"""
Created on Thu Mar  5 10:56:11 2020

@author: Getachew
"""

#this script was written to automate data entry of ethio-chicken data from excel files

from openpyxl import load_workbook
#openpyxl.__version__
# 3.0.0

import pandas as pd
pd.__version__
#1.0.1

import numpy as np
np.__version__
#'1.16.5'

from os import listdir
from os.path import isfile, join

import pandas as pd
import re

data = \
'D:/projects/IFC/data/IFC Final- Bright/IFC Final- Bright/1. Assessment Result Final/4. Three regions combined/'


id_no = []

region = []
zone = []
woreda = []

contact_name = []
contact_des = []
contact_gender =[]
legal_form =[]

#2018
annual_turnover2018 =[]
cost_goods_sold2018 =[]
gross_profit2018 =[]

#2017
annual_turnover2017 =[]
cost_goods_sold2017 =[]
gross_profit2017 =[]

#2016
annual_turnover2016 =[]
cost_goods_sold2016 =[]
gross_profit2016 =[]

education_level = []


#####################################################3

files = [f for f in listdir(data) if isfile(join(data, f))]

for file in files:
    try:
        workbook = load_workbook(data+file, data_only=True)
        worksheet = workbook['BIETH1']
        print(f'Working on file: {file}')
    except Exception:
        #file_with_problem.append(file)
        pass
    
    match = re.search(r'\d*', file)
    id_no.append(match.group())

    #id_no_obj = worksheet['H9']
    region_obj = worksheet['C16']
    zone_obj = worksheet['C17']
    woreda_obj = worksheet['C18']
    
    contact_name_obj = worksheet['G14']
    contact_des_obj = worksheet['H14']
    contact_gender_obj =worksheet['G15']
    legal_form_obj=worksheet['C15']
    education_level_obj = worksheet['G16']

    
    #2018
    annual_turnover2018_obj =worksheet['C39']
    cost_goods_sold2018_obj =worksheet['C40']
    gross_profit2018_obj =worksheet['C41']
    
    #2017
    annual_turnover2017_obj =worksheet['D39']
    cost_goods_sold2017_obj =worksheet['D40']
    gross_profit2017_obj =worksheet['D41']
    
    #2016
    annual_turnover2016_obj =worksheet['E39']
    cost_goods_sold2016_obj =worksheet['E40']
    gross_profit2016_obj =worksheet['E41']
    
    #####################3
   #appending
    #id_no.append(id_no_obj.value)
    
    region.append(region_obj.value)
    zone.append(zone_obj.value)
    woreda.append(woreda_obj.value)
    
    contact_name.append(contact_name_obj.value)
    contact_des.append(contact_des_obj.value)
    contact_gender.append(contact_gender_obj.value)
    legal_form.append(legal_form_obj.value)
    education_level.append(education_level_obj.value)
    
   #2018
    annual_turnover2018.append(annual_turnover2018_obj.value)
    cost_goods_sold2018.append(cost_goods_sold2018_obj.value)
    gross_profit2018.append(gross_profit2018_obj.value)
           
   #2017
    annual_turnover2017.append(annual_turnover2017_obj.value)
    cost_goods_sold2017.append(cost_goods_sold2017_obj.value)
    gross_profit2017.append(gross_profit2017_obj.value)
    
    
    #2016
    annual_turnover2016.append(annual_turnover2016_obj.value)
    cost_goods_sold2016.append(cost_goods_sold2016_obj.value)
    gross_profit2016.append(gross_profit2016_obj.value)
    

data = {}

#identifiers
data['id_no']= id_no  
data['region'] = region
data['zone'] = zone
data['woreda'] = woreda

data['contact_name'] = contact_name
data['contact_des'] = contact_des
data['contact_gender'] = contact_gender
data['legal_form'] = legal_form
data['education_level']=education_level

#2018
data['annual_turnover2018'] = annual_turnover2018
data['cost_goods_sold2018'] = cost_goods_sold2018
data['gross_profit2018'] = gross_profit2018


#2017
data['annual_turnover2017'] = annual_turnover2017
data['cost_goods_sold2017'] = cost_goods_sold2017
data['gross_profit2017'] = gross_profit2017

#2016
data['annual_turnover2016'] = annual_turnover2016
data['cost_goods_sold2016'] = cost_goods_sold2016
data['gross_profit2016'] = gross_profit2016

df = pd.DataFrame.from_dict(data) 
  
for col in df.columns:
    df[col] = df[col].replace('N/A', np.NaN)
    
for col in df.columns:    
    df[col] = df[col].replace('NA', np.NaN)
 
df['contact_des'] = df['contact_des'].str.replace('(', '')
df['contact_des'] = df['contact_des'].str.replace(')', '')
  
df.sort_values(by=['id_no'], inplace=True)

#cleaning zone strings
df['zone'].value_counts()

df['zone'] = df['zone'].str.replace('North Sewa', 'North Shewa')
df['zone'] = df['zone'].str.replace('E/Wollega', 'E. Wollega')
df['zone'] = df['zone'].str.replace('E. Wollega', 'East Wollega')
df['zone'] = df['zone'].str.replace('East Shoa', 'East Shewa')
df['zone'] = df['zone'].str.replace('South Wes Shewa', 'South West Shewa')
df['zone'] = df['zone'].str.replace('South West Shoa', 'South West Shewa')
df['zone'] = df['zone'].str.replace('W. Shewa', 'West Shewa')
df['zone'] = df['zone'].str.replace('West Shoa', 'West Shewa')
df['zone'] = df['zone'].str.replace('Wolayita', 'Wolaita')
df['zone'] = df['zone'].str.replace('Sidamo', 'Sidama')
df['zone'] = df['zone'].str.replace('West Arisi', 'West Arsi')
df['zone'] = df['zone'].str.replace('DB', 'North Shewa')

df['zone'] = df['zone'].str.replace('Finfine Vicinity', 'West Shewa')
   
df['zone'] = df['zone'].str.rstrip()
df['education_level'] = df['education_level'].str.rstrip()

df.to_excel("D:/projects/IFC/output/main_extracted.xlsx") 
