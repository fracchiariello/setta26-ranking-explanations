% class_1=1 (Normal_Weight), class_2=4 (Obesity_Type_I)

item(1).
bin(1,0,1).       % Gender > 0.5
bin(1,1,183).     % Age (20.4966, 20.5]
bin(1,2,106).     % Height (1.6024, 1.6026]
bin(1,3,197).     % Weight (60.3248, 60.3437]
bin(1,4,0).       % family_history_with_overweight <= 0.5
bin(1,5,0).       % FAVC <= 0.5
bin(1,6,98).      % FCVC (2.0233, 2.0235]
bin(1,7,317).     % NCP (3.0478, 3.0492]
bin(1,8,2).       % CAEC (1.5, 2.5]
bin(1,9,1).       % SMOKE > 0.5
bin(1,10,136).    % CH2O (1.615, 1.619]
bin(1,11,1).      % SCC > 0.5
bin(1,12,40).     % FAF (0.0963, 0.0981]
bin(1,13,190).    % TUE (0.6179, 0.621]
bin(1,14,3).      % CALC > 2.5
bin(1,15,3).      % MTRANS (2.5, 3.5]

item(2).
bin(2,0,0).       % Gender <= 0.5
bin(2,1,632).     % Age (31.9172, 32]
bin(2,2,642).     % Height (1.7681, 1.7686]
bin(2,3,989).     % Weight (101.589, 101.631]
bin(2,4,1).       % family_history_with_overweight > 0.5
bin(2,5,0).       % FAVC <= 0.5
bin(2,6,3).       % FCVC (1.0393, 1.0669]
bin(2,7,272).     % NCP (2.9677, 2.969]
bin(2,8,3).       % CAEC > 2.5
bin(2,9,0).       % SMOKE <= 0.5
bin(2,10,8).      % CH2O (1.0042, 1.0073]
bin(2,11,1).      % SCC > 0.5
bin(2,12,274).    % FAF (1.1371, 1.1405]
bin(2,13,145).    % TUE (0.4206, 0.4218]
bin(2,14,0).      % CALC <= 0.5
bin(2,15,4).      % MTRANS > 3.5
