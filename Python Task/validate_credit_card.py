# importing module
import re

def validate_credit_card(n,card_number):
    for i in range(n):
        credit = card_number[i].replace('-','')

        # valid is true in the beggining
        valid = True

        print(credit)
        # using regual expressions
        length_16 = bool(re.match(r'^[4-6]\d{15}$',credit))
        consecutive = bool(re.findall(r'(?=(\d)\1\1\1)',credit))

        # checking if the above regural expressions are true
        if length_16 == True :
            if consecutive == True:
                valid=False
        else:
            valid = False       
        if valid == True:
            print( 'Valid')
        else:
            print('Invalid')
    


validate_credit_card(3,["5122-2368-7954-3214","5122-2368-7954 - 3214","4424444424442444"])
