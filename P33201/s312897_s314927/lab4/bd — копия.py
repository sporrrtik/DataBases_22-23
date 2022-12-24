import random
# -*- coding: utf-8 -*-
from datetime import timedelta, date

from russian_names import RussianNames


def get_random_date(start, end):
    delta = end - start
    return start + timedelta(random.randint(0, delta.days))



cafe_id = [i for i in range(20)]
address_street = ["Ленинградский проспект", "ул. Шоссе в Лаврики", "проспект Энтузиастов", "Петровское шоссе", "Западное авеню", "Пушкинская"]
address_num = [f'{i}' for i in range(100)]

dish_id = [i for i in range(100)] #Количество блюд
price = [random.randrange(100, 10000) for i in range(100)]

cheque_id = [i for i in range(5000)] #Количество чеков
client_id = [i for i in range(250)] #Количество клиентов
cost = [i for i in range(1000)]

# surname_male = ['Попов', 'Иванов', 'Логинов', 'Бондарь', 'Костюк', 'Кравченко', 'Петров', 'Грызунов', 'Шванский', '']
# surname_female = ['Сафонова', 'Пестова', 'Иванова', 'Петрова', 'Кокора', 'Стегачёва', 'Барышева' ]
surname = []
name = []
fathername = []
for _ in range(100): #Количество клиентов:
    temp_person = RussianNames().get_person().split()
    name.append(temp_person[0])
    fathername.append(temp_person[1])
    surname.append(temp_person[2])
birthdate = [get_random_date(date(2000, 1, 1), date(2004, 1, 1)) for _ in range(300)]

recipe_id = [i for i in range(100)]
# name_dish = ["Салат Цезарь с курицей и сухариками", "Торт Черепаха", "Бурито", "Салат Мимоза", "Салат Цезарь", "Пасхальный кулич", "Салат Хрустящий", "Пасха из творога", "Кексы с изюмом", " Мясо по-французски", "Мисо суп"]
name_dish = [f'Название {i}' for i in range(100)] #Количество блюд

ingredients = [f'набор ингредиентов {i}' for i in range(100)]
cooking = [f'Приготовить вот так - {i}' for i in range(100)]

stuff_id = [i for i in range(50)]
position = [f'Должность {i}'for i in range(60)]
hiredate = [get_random_date(date(2015, 1, 1), date.today()) for _ in range(300)]

reserve_id = [i for i in range(1000)]


consume_id = [i for i in range(10)]
balance = [i for i in range(150)]

name_consume = [f'Название расходника {i}' for i in range(10)]

provider_id = [i for i in range(20)]
name_provider = [f'Название поставщика {i}' for i in range(20)]
contacts = [f'Контакт {i}' for i in range(20)]

equip_id = [i for i in range(100)]
name_equip = [f'Название инвенторя {i}' for i in range(10)]

delivery_id = [f'{i}' for i in range(100)]
amount = [i for i in range(10, 500)]

# dickt = {
#     "cafe": {
#         "cafe_id": cafe_id,
#         "address_street": address_street,
#         "address_num": address_num
#     },
#     "menu": {
#         "cafe_id": cafe_id,
#         "dish_id": dish_id,
#         "price": price
#     },
#     "cheque": {
#         "cheque_id": cheque_id,
#         "cafe_id": cafe_id,
#         "client_id": client_id,
#         "cost": cost
#     },
#     "client": {
#         "client_id": client_id,
#         "surname": surname,
#         "name": name,
#         "fathername": fathername,
#         "birthdate": birthdate
#     },
#     "dish": {
#         "dish_id": dish_id,
#         "recipe_id": recipe_id,
#         "name": name_dish
#     },
#     "recipe": {
#         "recipe_id": recipe_id,
#         "ingredients": ingredients
#     },
#     "stuff": {
#         "stuff_id": stuff_id,
#         "cafe_id": cafe_id,
#         "surname": surname,
#         "name": name,
#         "fathername": name,
#         "birthdate": birthdate,
#         "position": position,
#         "hiredate": birthdate
#     }
# }
# print(dickt)
# print(random.choice(dickt["client"]["birthdate"]))



with open('bd.txt', 'w') as file:
### Cafe ###
    for num in cafe_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, '{} {}');".format('Cafe', num, random.choice(address_street), random.choice(address_num)))
        file.write("\n")
         # print("INSERT INTO {} VALUES ({}, '{} {}');".format('Cafe', num, random.choice(dickt['cafe']['address_street']), random.choice(dickt['cafe']['address_num'])))
    file.write("\n")

### Client ###
    for num in client_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, '{}', '{}', '{}', '{}');".format('Client', num, random.choice(surname), random.choice(name), random.choice(fathername), random.choice(birthdate)))
        file.write("\n")
    file.write('\n')

### Dish ###
    for num in dish_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, '{}');".format('Dish', num, recipe_id[num], name_dish[num]))
        file.write("\n")
    file.write('\n')

### Staff ###
    for num in stuff_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, '{}', '{}', '{}', '{}', '{}', '{}');".format('Staff', num, random.choice(cafe_id),
                            random.choice(surname), random.choice(name), random.choice(fathername), random.choice(birthdate),
                            random.choice(position), random.choice(hiredate)))
        file.write("\n")
    file.write('\n')

### Cheque ###
    for num in cheque_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, {}, {});".format('Cheque', num, random.choice(cafe_id), random.choice(client_id), random.choice(price)))
        file.write("\n")
    file.write('\n')

### Orders ###
    for _ in range(5000):
        file.write("INSERT INTO \"{}\" VALUES ({}, {}) ON CONFLICT DO NOTHING;".format('Orders', random.choice(dish_id), random.choice(cheque_id)))
        file.write("\n")
    file.write('\n')

### Recipe ###
    for num in recipe_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, '{}', '{}');".format('Recipe', num, ingredients[num], cooking[num]))
        file.write("\n")
    file.write('\n')

### Menu ###
    for num in cafe_id:
        for _ in range(20):
            file.write("INSERT INTO \"{}\" VALUES ({}, {}, {});".format('Menu', num, random.choice(dish_id), random.choice(price)))
            file.write("\n")
    file.write('\n')

### Provider ###
    for num in provider_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, '{}', '{}');".format('Provider', num, name_provider[num], contacts[num]))
        file.write("\n")
    file.write('\n')

### Equipment ###
    for num in equip_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, {}, '{}', '{}');".format('Equipment', num, random.choice(cafe_id),
                                                                       random.choice(provider_id),
                                                                       random.choice(name_equip),
                                                                       random.choice([True, False])))
        file.write("\n")
    file.write('\n')

### Consumables ###
    for num in consume_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, '{}');".format('Consumables', num, random.choice(provider_id), name_consume[num]))
        file.write("\n")
    file.write('\n')

### Reserves ###
    for num in reserve_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, {}, {});".format('Reserves', num, random.choice(cafe_id), random.choice(consume_id), random.choice(balance)))
        file.write("\n")
    file.write('\n')

### Delivery_consum ###
    for num in delivery_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, '{}', {}, {});".format('Delivery_consum', num, random.choice(reserve_id),
                                                                          random.choice(hiredate),
                                                                          random.choice(cost),
                                                                          random.choice(amount)))
        file.write("\n")

### Delivery Equipment ###
    for num in delivery_id:
        file.write("INSERT INTO \"{}\" VALUES ({}, {}, '{}', {});".format('Delivery_equip', num, random.choice(equip_id),
                                                                       random.choice(hiredate),
                                                                       random.choice(cost)))
        file.write("\n")
    file.write('\n')