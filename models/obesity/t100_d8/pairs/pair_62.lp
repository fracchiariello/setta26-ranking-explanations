% class_1=4 (Obesity_Type_I), class_2=6 (Obesity_Type_III)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,407).     % Age (23.5326, 23.5511]
bin(1,2,721).     % Height (1.7966, 1.7966]
bin(1,3,980).     % Weight (101, 101.105]
bin(1,4,1).       % family_history_with_overweight > 0.5
bin(1,5,1).       % FAVC > 0.5
bin(1,6,294).     % FCVC (2.8143, 2.8263]
bin(1,7,37).      % NCP (1.1059, 1.1105]
bin(1,8,1).       % CAEC (0.5, 1.5]
bin(1,9,1).       % SMOKE > 0.5
bin(1,10,328).    % CH2O (2.1282, 2.1296]
bin(1,11,0).      % SCC <= 0.5
bin(1,12,230).    % FAF (0.9965, 0.9973]
bin(1,13,237).    % TUE (0.7707, 0.777]
bin(1,14,2).      % CALC (1.5, 2.5]
bin(1,15,1).      % MTRANS (0.5, 1.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,132).     % Age (19.589, 19.59]
bin(2,2,434).     % Height (1.7041, 1.7043]
bin(2,3,1029).    % Weight (106.393, 106.501]
bin(2,4,0).       % family_history_with_overweight <= 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,265).     % FCVC (2.6527, 2.6544]
bin(2,7,78).      % NCP (1.5662, 1.5707]
bin(2,8,2).       % CAEC (1.5, 2.5]
bin(2,9,0).       % SMOKE <= 0.5
bin(2,10,82).     % CH2O (1.3079, 1.3098]
bin(2,11,1).      % SCC > 0.5
bin(2,12,478).    % FAF (2.3205, 2.3233]
bin(2,13,362).    % TUE (1.1394, 1.1427]
bin(2,14,1).      % CALC (0.5, 1.5]
bin(2,15,2).      % MTRANS (1.5, 2.5]
