% class_1=2 (Overweight_Level_I), class_2=5 (Obesity_Type_II)

item(1).
bin(1,0,0).       % Gender <= 0.5
bin(1,1,110).     % Age (19.3108, 19.3169]
bin(1,2,432).     % Height (1.7035, 1.7039]
bin(1,3,274).     % Weight (63.5, 63.537]
bin(1,4,1).       % family_history_with_overweight > 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,206).     % FCVC (2.3963, 2.3986]
bin(1,7,187).     % NCP (2.6476, 2.6579]
bin(1,8,0).       % CAEC <= 0.5
bin(1,9,1).       % SMOKE > 0.5
bin(1,10,26).     % CH2O (1.0651, 1.0656]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,185).    % FAF (0.8703, 0.8769]
bin(1,13,282).    % TUE (0.9175, 0.9254]
bin(1,14,2).      % CALC (1.5, 2.5]
bin(1,15,0).      % MTRANS <= 0.5

item(2).
bin(2,0,1).       % Gender > 0.5
bin(2,1,516).     % Age (26.1159, 26.3493]
bin(2,2,452).     % Height (1.7081, 1.7087]
bin(2,3,1126).    % Weight (113.011, 113.021]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,65).      % FCVC (1.9973, 1.9983]
bin(2,7,49).      % NCP (1.2569, 1.2658]
bin(2,8,3).       % CAEC > 2.5
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,406).    % CH2O (2.4974, 2.5]
bin(2,11,1).      % SCC > 0.5
bin(2,12,285).    % FAF (1.2053, 1.208]
bin(2,13,186).    % TUE (0.5989, 0.6004]
bin(2,14,1).      % CALC (0.5, 1.5]
bin(2,15,1).      % MTRANS (0.5, 1.5]
