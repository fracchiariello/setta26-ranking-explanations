% class_1=0 (Insufficient_Weight), class_2=4 (Obesity_Type_I)

item(1).
bin(1,0,0).       % Gender <= 0.5
bin(1,1,40).      % Age (20, 20.01]
bin(1,2,108).     % Height (1.73, 1.74]
bin(1,3,32).      % Weight (55.5, 55.51]
bin(1,4,1).       % family_history_with_overweight > 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,59).      % FCVC (2.98, 2.98]
bin(1,7,67).      % NCP (3.79, 3.99]
bin(1,8,2).       % CAEC (1.5, 2.5]
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,87).     % CH2O (2.56, 2.57]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,87).     % FAF (1.99, 1.99]
bin(1,13,68).     % TUE (0.95, 0.96]
bin(1,14,1).      % CALC (0.5, 1.5]
bin(1,15,2).      % MTRANS (1, 1.5]

item(2).
bin(2,0,1).       % Gender > 0.5
bin(2,1,35).      % Age (19.81, 19.92]
bin(2,2,63).      % Height (1.67, 1.67]
bin(2,3,287).     % Weight (124.25, 125.06]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,1).       % FAVC > 0.5
bin(2,6,51).      % FCVC (2.84, 2.9]
bin(2,7,46).      % NCP (3.02, 3.03]
bin(2,8,1).       % CAEC (0.5, 1.5]
bin(2,9,0).       % SMOKE <= 0.5
bin(2,10,65).     % CH2O (2.07, 2.07]
bin(2,11,1).      % SCC > 0.5
bin(2,12,11).     % FAF (0.16, 0.17]
bin(2,13,96).     % TUE (1.32, 1.44]
bin(2,14,0).      % CALC <= 0.5
bin(2,15,0).      % MTRANS <= 0.5
