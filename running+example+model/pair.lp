% class_1=0 (low), class_2=1 (medium)

item(1).
bin(1,0,0).       % age <= 61.5
bin(1,1,0).       % bmi <= 38
bin(1,2,0).       % glucose <= 125.5
bin(1,3,0).       % previous_stroke <= 0.5

item(2).
bin(2,0,2).       % age > 65
bin(2,1,2).       % bmi > 38.85
bin(2,2,0).       % glucose <= 125.5
bin(2,3,1).       % previous_stroke > 0.5
