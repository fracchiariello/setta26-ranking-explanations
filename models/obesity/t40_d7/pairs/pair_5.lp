% class_1=3 (Overweight_Level_II), class_2=5 (Obesity_Type_II)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,102).     % Age (23.5, 23.59]
bin(1,2,166).     % Height > 1.86
bin(1,3,191).     % Weight (92.07, 93.14]
bin(1,4,1).       % family_history_with_overweight > 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,15).      % FCVC (2.02, 2.03]
bin(1,7,31).      % NCP (2.98, 2.98]
bin(1,8,1).       % CAEC (0.5, 1.5]
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,43).     % CH2O (2, 2]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,75).     % FAF (1.78, 1.8]
bin(1,13,70).     % TUE (0.96, 0.97]
bin(1,14,0).      % CALC <= 0.5
bin(1,15,4).      % MTRANS > 2.5

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,124).     % Age (26.02, 26.03]
bin(2,2,17).      % Height (1.6, 1.6]
bin(2,3,272).     % Weight (110.72, 110.75]
bin(2,4,0).       % family_history_with_overweight <= 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,60).      % FCVC (2.98, 2.99]
bin(2,7,70).      % NCP > 4
bin(2,8,1).       % CAEC (0.5, 1.5]
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,67).     % CH2O (2.08, 2.1]
bin(2,11,1).      % SCC > 0.5
bin(2,12,27).     % FAF (0.96, 0.97]
bin(2,13,69).     % TUE (0.96, 0.96]
bin(2,14,2).      % CALC > 1.5
bin(2,15,1).      % MTRANS (0.5, 1]
