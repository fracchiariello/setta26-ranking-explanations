% class_1=1 (Normal_Weight), class_2=2 (Overweight_Level_I)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,693).     % Age (37.2623, 37.3702]
bin(1,2,550).     % Height (1.7423, 1.7427]
bin(1,3,323).     % Weight (66.4007, 66.5]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,176).     % FCVC (2.2957, 2.2973]
bin(1,7,300).     % NCP (2.9956, 2.9963]
bin(1,8,2).       % CAEC (1.5, 2.5]
bin(1,9,1).       % SMOKE > 0.5
bin(1,10,353).    % CH2O (2.2058, 2.2059]
bin(1,11,1).      % SCC > 0.5
bin(1,12,233).    % FAF (0.9979, 0.999]
bin(1,13,431).    % TUE (1.6434, 1.6605]
bin(1,14,2).      % CALC (1.5, 2.5]
bin(1,15,1).      % MTRANS (0.5, 1.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,80).      % Age (18.6486, 18.6904]
bin(2,2,615).     % Height (1.7569, 1.7571]
bin(2,3,783).     % Weight (89.9877, 89.988]
bin(2,4,0).       % family_history_with_overweight <= 0.5
bin(2,5,1).       % FAVC > 0.5
bin(2,6,298).     % FCVC (2.8545, 2.8555]
bin(2,7,73).      % NCP (1.4858, 1.5194]
bin(2,8,1).       % CAEC (0.5, 1.5]
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,326).    % CH2O (2.1275, 2.128]
bin(2,11,1).      % SCC > 0.5
bin(2,12,235).    % FAF (0.9992, 0.9999]
bin(2,13,129).    % TUE (0.3478, 0.3503]
bin(2,14,0).      % CALC <= 0.5
bin(2,15,3).      % MTRANS (2.5, 3.5]
