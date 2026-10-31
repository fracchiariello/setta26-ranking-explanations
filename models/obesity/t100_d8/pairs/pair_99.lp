% class_1=1 (Normal_Weight), class_2=2 (Overweight_Level_I)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,351).     % Age (22.8794, 22.894]
bin(1,2,687).     % Height (1.785, 1.7852]
bin(1,3,99).      % Weight (53.2763, 53.3103]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,0).       % FAVC <= 0.5
bin(1,6,320).     % FCVC (2.919, 2.9211]
bin(1,7,235).     % NCP (2.8581, 2.8618]
bin(1,8,0).       % CAEC <= 0.5
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,475).    % CH2O (2.9657, 2.9697]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,225).    % FAF (0.9899, 0.9929]
bin(1,13,232).    % TUE (0.758, 0.7597]
bin(1,14,0).      % CALC <= 0.5
bin(1,15,3).      % MTRANS (2.5, 3.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,705).     % Age (38.6982, 38.895]
bin(2,2,132).     % Height (1.6142, 1.615]
bin(2,3,618).     % Weight (80.5543, 80.5563]
bin(2,4,0).       % family_history_with_overweight <= 0.5
bin(2,5,1).       % FAVC > 0.5
bin(2,6,47).      % FCVC (1.9531, 1.9551]
bin(2,7,335).     % NCP (3.0847, 3.0855]
bin(2,8,2).       % CAEC (1.5, 2.5]
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,42).     % CH2O (1.1134, 1.115]
bin(2,11,1).      % SCC > 0.5
bin(2,12,340).    % FAF (1.5077, 1.5149]
bin(2,13,461).    % TUE (1.9471, 1.9477]
bin(2,14,1).      % CALC (0.5, 1.5]
bin(2,15,0).      % MTRANS <= 0.5
