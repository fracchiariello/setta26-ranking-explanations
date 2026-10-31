% class_1=2 (Overweight_Level_I), class_2=3 (Overweight_Level_II)

item(1).
bin(1,0,0).       % Gender <= 0.5
bin(1,1,230).     % Age (21.173, 21.1983]
bin(1,2,62).      % Height (1.575, 1.5751]
bin(1,3,692).     % Weight (84.4988, 84.5]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,0).       % FAVC <= 0.5
bin(1,6,301).     % FCVC (2.8566, 2.8673]
bin(1,7,112).     % NCP (2.0387, 2.0432]
bin(1,8,0).       % CAEC <= 0.5
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,362).    % CH2O (2.252, 2.2521]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,117).    % FAF (0.4784, 0.4914]
bin(1,13,33).     % TUE (0.0243, 0.0256]
bin(1,14,0).      % CALC <= 0.5
bin(1,15,2).      % MTRANS (1.5, 2.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,526).     % Age (26.7183, 26.792]
bin(2,2,237).     % Height (1.65, 1.6502]
bin(2,3,570).     % Weight (79.0092, 79.018]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,276).     % FCVC (2.6959, 2.6969]
bin(2,7,67).      % NCP (1.4339, 1.4352]
bin(2,8,3).       % CAEC > 2.5
bin(2,9,0).       % SMOKE <= 0.5
bin(2,10,401).    % CH2O (2.4745, 2.4796]
bin(2,11,1).      % SCC > 0.5
bin(2,12,413).    % FAF (1.9442, 1.9477]
bin(2,13,207).    % TUE (0.6791, 0.6812]
bin(2,14,1).      % CALC (0.5, 1.5]
bin(2,15,0).      % MTRANS <= 0.5
