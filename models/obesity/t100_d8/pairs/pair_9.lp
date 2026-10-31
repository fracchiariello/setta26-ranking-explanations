% class_1=5 (Obesity_Type_II), class_2=6 (Obesity_Type_III)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,514).     % Age (26.1041, 26.1127]
bin(1,2,859).     % Height (1.874, 1.8748]
bin(1,3,1087).    % Weight (110.242, 110.297]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,0).       % FAVC <= 0.5
bin(1,6,260).     % FCVC (2.6075, 2.614]
bin(1,7,41).      % NCP (1.1335, 1.1382]
bin(1,8,1).       % CAEC (0.5, 1.5]
bin(1,9,0).       % SMOKE <= 0.5
bin(1,10,304).    % CH2O (2.0781, 2.0801]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,345).    % FAF (1.5362, 1.5418]
bin(1,13,440).    % TUE (1.7046, 1.7156]
bin(1,14,1).      % CALC (0.5, 1.5]
bin(1,15,3).      % MTRANS (2.5, 3.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,583).     % Age (29.6255, 29.6269]
bin(2,2,246).     % Height (1.6527, 1.6528]
bin(2,3,1185).    % Weight (131.673, 131.678]
bin(2,4,0).       % family_history_with_overweight <= 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,214).     % FCVC (2.4255, 2.4288]
bin(2,7,336).     % NCP (3.0855, 3.0858]
bin(2,8,2).       % CAEC (1.5, 2.5]
bin(2,9,1).       % SMOKE > 0.5
bin(2,10,104).    % CH2O (1.4556, 1.459]
bin(2,11,1).      % SCC > 0.5
bin(2,12,122).    % FAF (0.5132, 0.5234]
bin(2,13,134).    % TUE (0.3794, 0.3798]
bin(2,14,3).      % CALC > 2.5
bin(2,15,1).      % MTRANS (0.5, 1.5]
