
import re

def validate_credit_card(n,card_number):
    for i in range(n):
        #removing - from the card_number
        credit = card_number[i].replace('-','')

        flag = True
        # writing regex to check if the flag is true or not
        length_16 = bool(re.match(r'^[4-6]\d{15}$',credit))
        consecutive = bool(re.findall(r'(?=(\d)\1\1\1)',credit))

        # updating flag 
        if length_16 == True :
            if consecutive == True:
                flag=False
        else:
            flag = False       
        if flag == True:
            print( 'Valid')
        else:
            print('Invalid')
    


validate_credit_card(3,["5122-2368-7954-3214","5122-2368-7954 - 3214","4424444424442444"])
