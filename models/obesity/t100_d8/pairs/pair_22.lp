% class_1=2 (Overweight_Level_I), class_2=3 (Overweight_Level_II)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,650).     % Age (33.0871, 33.1262]
bin(1,2,834).     % Height (1.845, 1.8456]
bin(1,3,941).     % Weight (99, 99.1032]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,90).      % FCVC (2.0143, 2.0148]
bin(1,7,375).     % NCP (3.4933, 3.5]
bin(1,8,2).       % CAEC (1.5, 2.5]
bin(1,9,1).       % SMOKE > 0.5
bin(1,10,238).    % CH2O (1.986, 1.9899]
bin(1,11,1).      % SCC > 0.5
bin(1,12,422).    % FAF (1.9662, 1.9719]
bin(1,13,373).    % TUE (1.2078, 1.2223]
bin(1,14,2).      % CALC (1.5, 2.5]
bin(1,15,2).      % MTRANS (1.5, 2.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,355).     % Age (22.9295, 22.9339]
bin(2,2,536).     % Height (1.7362, 1.7365]
bin(2,3,877).     % Weight (95.4921, 95.4994]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,259).     % FCVC (2.5986, 2.6075]
bin(2,7,331).     % NCP (3.0816, 3.083]
bin(2,8,2).       % CAEC (1.5, 2.5]
bin(2,9,0).       % SMOKE <= 0.5
bin(2,10,434).    % CH2O (2.7364, 2.7365]
bin(2,11,1).      % SCC > 0.5
bin(2,12,421).    % FAF (1.9659, 1.9662]
bin(2,13,249).    % TUE (0.8145, 0.8184]
bin(2,14,0).      % CALC <= 0.5
bin(2,15,3).      % MTRANS (2.5, 3.5]
