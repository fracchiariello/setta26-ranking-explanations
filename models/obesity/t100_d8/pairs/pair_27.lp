% class_1=0 (Insufficient_Weight), class_2=5 (Obesity_Type_II)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,312).     % Age (22.42, 22.4286]
bin(1,2,573).     % Height (1.7484, 1.7488]
bin(1,3,123).     % Weight (54.9178, 54.9386]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,0).       % FAVC <= 0.5
bin(1,6,320).     % FCVC (2.919, 2.9211]
bin(1,7,108).     % NCP (2.007, 2.0102]
bin(1,8,2).       % CAEC (1.5, 2.5]
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,80).     % CH2O (1.3056, 1.3069]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,88).     % FAF (0.3251, 0.3319]
bin(1,13,281).    % TUE (0.9169, 0.9175]
bin(1,14,0).      % CALC <= 0.5
bin(1,15,1).      % MTRANS (0.5, 1.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,418).     % Age (23.7341, 23.7348]
bin(2,2,452).     % Height (1.7081, 1.7087]
bin(2,3,962).     % Weight (99.9337, 100.002]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,118).     % FCVC (2.0892, 2.093]
bin(2,7,147).     % NCP (2.3943, 2.4062]
bin(2,8,2).       % CAEC (1.5, 2.5]
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,36).     % CH2O (1.0925, 1.097]
bin(2,11,0).      % SCC <= 0.5
bin(2,12,473).    % FAF (2.2774, 2.2861]
bin(2,13,134).    % TUE (0.3794, 0.3798]
bin(2,14,1).      % CALC (0.5, 1.5]
bin(2,15,3).      % MTRANS (2.5, 3.5]
