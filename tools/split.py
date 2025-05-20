import os

with open('joker_list.txt', 'r') as bingus:
   names = bingus.read().split('\n')
   
with open('jokers.lua', 'r') as f:
   lines = f.read().split('SMODS.Joker {')

index = -1
for item in lines:
    index = index + 1
    print('joker: '+ names[index])
    file = open('jokers/' + str(f'{index:03}') + "_" + names[index]+'.lua','x')
    file.write('return {\n SMODS.Joker {' + item + '}')
    file.close()
    
os.remove("jokers/j_USELESS.lua") 
