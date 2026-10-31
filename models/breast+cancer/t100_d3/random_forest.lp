% ============================================================
% random_forest.lp — RF facts for breast+cancer
% 100 trees  |  30 features
% RF-dependent: bin domains and tree structural facts.
% Load together with encoding.lp.
%
% --- Predicates ---
% tree(T)            : T is a tree index.
% node(T,X,F,B)      : internal node X in tree T tests feature F with split bin B.
% left_node(T,X,N2)  : left child of node X in tree T  (condition true:  bin <= B).
% right_node(T,X,N2) : right child of node X in tree T (condition false: bin > B).
% leaf_class(T,X,C)  : leaf X of tree T predicts class C.
%                      A node is a leaf iff it has a leaf_class fact.
% bin(I,F,B)         : item I is assigned to bin B for feature F. With sorted
%                      thresholds [t1<...<tk], bin 0 means v<=t1, bin j means
%                      tj<v<=tj+1, bin k means v>tk. A "bin <= B" test is "v <= t(B+1)".
% bin_max(F,K)       : the bins of feature F are 0..K.
% class_idx(C)       : C is a valid class index.
% ============================================================

% --- Feature bin domains ---
% bin(I,F,B): item I is assigned to bin B for feature F.

% Feature 0 (f0): 17 bins  (thresholds: [11.385000228881836, 12.765000343322754, 13.0, 14.524999618530273, 14.619999885559082, 14.90999984741211, 14.979999542236328, 15.019999504089355, 15.024999618530273, 15.029999732971191, 15.114999771118164, 15.220000267028809, 15.274999618530273, 15.28499984741211, 15.739999771118164, 17.094999313354492])
{bin(I,0,B) : B = 0..16} = 1 :- item(I).
bin_max(0,16).

% Feature 1 (f1): 29 bins  (thresholds: [14.095000267028809, 15.425000190734863, 15.53499984741211, 16.09000015258789, 16.189998626708984, 16.23499870300293, 16.39499855041504, 16.604999542236328, 16.610000610351562, 17.059999465942383, 17.76999855041504, 18.03999900817871, 18.084999084472656, 18.119998931884766, 18.434999465942383, 18.524999618530273, 18.690000534057617, 18.854999542236328, 18.899999618530273, 19.614999771118164, 20.25, 20.299999237060547, 20.78499984741211, 20.934999465942383, 21.045000076293945, 21.260000228881836, 21.57499885559082, 21.71500015258789])
{bin(I,1,B) : B = 0..28} = 1 :- item(I).
bin_max(1,28).

% Feature 2 (f2): 19 bins  (thresholds: [75.75499725341797, 85.76499938964844, 87.48500061035156, 88.24500274658203, 91.85499572753906, 92.7750015258789, 93.91500091552734, 96.57999420166016, 96.85499572753906, 98.23999786376953, 98.40499877929688, 98.43000030517578, 98.91999816894531, 99.79000091552734, 102.8499984741211, 105.25, 107.44999694824219, 108.5999984741211])
{bin(I,2,B) : B = 0..18} = 1 :- item(I).
bin_max(2,18).

% Feature 3 (f3): 18 bins  (thresholds: [370.3999938964844, 425.4499816894531, 562.1499633789062, 562.5499877929688, 577.0999755859375, 657.949951171875, 662.2000122070312, 664.5499877929688, 674.8999633789062, 686.6499633789062, 692.3499755859375, 694.1499633789062, 696.25, 696.9500122070312, 697.7999877929688, 847.8499755859375, 848.0999755859375])
{bin(I,3,B) : B = 0..17} = 1 :- item(I).
bin_max(3,17).

% Feature 4 (f4): 12 bins  (thresholds: [0.0812000036239624, 0.08137999475002289, 0.09047500044107437, 0.09136499464511871, 0.09227500110864639, 0.09241499751806259, 0.09320999681949615, 0.09559499472379684, 0.0976099967956543, 0.10064999759197235, 0.10369999706745148])
{bin(I,4,B) : B = 0..11} = 1 :- item(I).
bin_max(4,11).

% Feature 5 (f5): 13 bins  (thresholds: [0.060474999248981476, 0.06500999629497528, 0.0726349949836731, 0.08555500209331512, 0.08573000133037567, 0.08615999668836594, 0.09524999558925629, 0.10194999724626541, 0.11370999366044998, 0.11829999834299088, 0.1679999977350235, 0.16990000009536743])
{bin(I,5,B) : B = 0..12} = 1 :- item(I).
bin_max(5,12).

% Feature 6 (f6): 21 bins  (thresholds: [0.030779998749494553, 0.06420999765396118, 0.0659249946475029, 0.06800499558448792, 0.0692249983549118, 0.07214000076055527, 0.07437999546527863, 0.08175499737262726, 0.08240500092506409, 0.0861549973487854, 0.08941999822854996, 0.09329499304294586, 0.09649999439716339, 0.09727999567985535, 0.09815499931573868, 0.10319999605417252, 0.10329999774694443, 0.11134999990463257, 0.11919999867677689, 0.12324999272823334])
{bin(I,6,B) : B = 0..20} = 1 :- item(I).
bin_max(6,20).

% Feature 7 (f7): 38 bins  (thresholds: [0.025734998285770416, 0.026759998872876167, 0.026804998517036438, 0.028039999306201935, 0.04319499805569649, 0.043334998190402985, 0.044319998472929, 0.04439999908208847, 0.045464999973773956, 0.04778499901294708, 0.04976499825716019, 0.050005000084638596, 0.05035499855875969, 0.05048999935388565, 0.0506649985909462, 0.05101499706506729, 0.05104999989271164, 0.051124997437000275, 0.05127999931573868, 0.05255499854683876, 0.05261499807238579, 0.05370999872684479, 0.054269999265670776, 0.05489499866962433, 0.055799998342990875, 0.05591999739408493, 0.0559299997985363, 0.056359998881816864, 0.05808499827980995, 0.059379998594522476, 0.06218999996781349, 0.07844500243663788, 0.07938999682664871, 0.07983499765396118, 0.0867450013756752, 0.0880649983882904, 0.10460499674081802])
{bin(I,7,B) : B = 0..37} = 1 :- item(I).
bin_max(7,37).

% Feature 8 (f8): 4 bins  (thresholds: [0.13239999115467072, 0.17399999499320984, 0.2595999836921692])
{bin(I,8,B) : B = 0..3} = 1 :- item(I).
bin_max(8,3).

% Feature 9 (f9): 5 bins  (thresholds: [0.05511999875307083, 0.05590000003576279, 0.056029997766017914, 0.06127999722957611])
{bin(I,9,B) : B = 0..4} = 1 :- item(I).
bin_max(9,4).

% Feature 10 (f10): 13 bins  (thresholds: [0.18609999120235443, 0.1936499923467636, 0.20584999024868011, 0.2215999960899353, 0.2543500065803528, 0.2931499779224396, 0.38944998383522034, 0.4534499943256378, 0.527899980545044, 0.587149977684021, 0.5915499925613403, 0.6255499720573425])
{bin(I,10,B) : B = 0..12} = 1 :- item(I).
bin_max(10,12).

% Feature 11 (f11): 9 bins  (thresholds: [0.3624500036239624, 0.3842499852180481, 0.4192499816417694, 0.49229997396469116, 0.5262499451637268, 1.1124999523162842, 2.0859999656677246, 2.0920000076293945])
{bin(I,11,B) : B = 0..8} = 1 :- item(I).
bin_max(11,8).

% Feature 12 (f12): 5 bins  (thresholds: [1.2944999933242798, 1.9304999113082886, 3.4375, 3.6735000610351562])
{bin(I,12,B) : B = 0..4} = 1 :- item(I).
bin_max(12,4).

% Feature 13 (f13): 18 bins  (thresholds: [17.219999313354492, 20.85999870300293, 22.0049991607666, 24.875, 29.579999923706055, 29.875, 32.89999771118164, 32.93000030517578, 35.85499954223633, 35.935001373291016, 41.415000915527344, 42.94999694824219, 43.310001373291016, 45.17499923706055, 51.64500045776367, 52.56999969482422, 61.05500030517578])
{bin(I,13,B) : B = 0..17} = 1 :- item(I).
bin_max(13,17).

% Feature 14 (f14): 4 bins  (thresholds: [0.0034649998415261507, 0.007832999341189861, 0.009690999984741211])
{bin(I,14,B) : B = 0..3} = 1 :- item(I).
bin_max(14,3).

% Feature 15 (f15): 7 bins  (thresholds: [0.010199999436736107, 0.012029999867081642, 0.029684999957680702, 0.0401499979197979, 0.045934997498989105, 0.05268999934196472])
{bin(I,15,B) : B = 0..6} = 1 :- item(I).
bin_max(15,6).

% Feature 16 (f16): 9 bins  (thresholds: [0.015905000269412994, 0.016979999840259552, 0.018459999933838844, 0.01994999870657921, 0.024790000170469284, 0.08001499623060226, 0.1237500011920929, 0.2618999779224396])
{bin(I,16,B) : B = 0..8} = 1 :- item(I).
bin_max(16,8).

% Feature 17 (f17): 4 bins  (thresholds: [0.013969999738037586, 0.014274999499320984, 0.020874999463558197])
{bin(I,17,B) : B = 0..3} = 1 :- item(I).
bin_max(17,3).

% Feature 18 (f18): 9 bins  (thresholds: [0.009250999428331852, 0.009265999309718609, 0.011759999208152294, 0.012269999831914902, 0.01465499959886074, 0.015399999916553497, 0.020194999873638153, 0.025519998744130135])
{bin(I,18,B) : B = 0..8} = 1 :- item(I).
bin_max(18,8).

% Feature 19 (f19): 12 bins  (thresholds: [0.0013269999762997031, 0.0014894999330863357, 0.001548500033095479, 0.0016870000399649143, 0.0018869999330490828, 0.0024800000246614218, 0.0035609998740255833, 0.006055499892681837, 0.007326500024646521, 0.012910000048577785, 0.02133999951183796])
{bin(I,19,B) : B = 0..11} = 1 :- item(I).
bin_max(19,11).

% Feature 20 (f20): 28 bins  (thresholds: [12.130000114440918, 14.484999656677246, 14.644999504089355, 14.649999618530273, 14.880000114440918, 14.979999542236328, 15.174999237060547, 15.394999504089355, 15.484999656677246, 15.519999504089355, 15.589999198913574, 15.779999732971191, 15.925000190734863, 16.209999084472656, 16.744998931884766, 16.78999900817871, 16.795000076293945, 16.80500030517578, 16.829999923706055, 17.059999465942383, 17.34000015258789, 17.510000228881836, 17.53999900817871, 17.579999923706055, 17.739999771118164, 17.7549991607666, 19.834999084472656])
{bin(I,20,B) : B = 0..27} = 1 :- item(I).
bin_max(20,27).

% Feature 21 (f21): 26 bins  (thresholds: [16.295000076293945, 19.90999984741211, 20.28499984741211, 21.139999389648438, 21.674999237060547, 21.689998626708984, 22.314998626708984, 22.849998474121094, 23.299999237060547, 23.349998474121094, 23.739999771118164, 23.85999870300293, 25.599998474121094, 25.73499870300293, 26.154998779296875, 26.489999771118164, 26.674999237060547, 26.899999618530273, 27.315000534057617, 27.385000228881836, 27.65999984741211, 28.020000457763672, 28.564998626708984, 29.57499885559082, 29.674999237060547])
{bin(I,21,B) : B = 0..25} = 1 :- item(I).
bin_max(21,25).

% Feature 22 (f22): 36 bins  (thresholds: [90.37999725341797, 91.03499603271484, 95.51000213623047, 101.39999389648438, 101.44999694824219, 101.54999542236328, 101.79999542236328, 101.94999694824219, 102.4000015258789, 105.1500015258789, 105.25, 105.94999694824219, 106.14999389648438, 107.19999694824219, 108.3499984741211, 108.54999542236328, 109.44999694824219, 109.5999984741211, 109.94999694824219, 111.19999694824219, 112.5999984741211, 112.79999542236328, 112.9000015258789, 113.6500015258789, 114.44999694824219, 114.89999389648438, 115.3499984741211, 115.89999389648438, 116.04999542236328, 116.79999542236328, 117.29999542236328, 117.44999694824219, 120.3499984741211, 127.19999694824219, 127.64999389648438])
{bin(I,22,B) : B = 0..35} = 1 :- item(I).
bin_max(22,35).

% Feature 23 (f23): 43 bins  (thresholds: [418.1000061035156, 444.29998779296875, 552.7999877929688, 690.3499755859375, 693.3999633789062, 718.6499633789062, 719.75, 725.2999877929688, 727.0999755859375, 736.3999633789062, 737.0999755859375, 739.199951171875, 750.0, 754.0999755859375, 759.4500122070312, 768.9000244140625, 782.7000122070312, 785.75, 807.449951171875, 817.7999877929688, 818.0999755859375, 818.2000122070312, 830.7000122070312, 844.75, 861.7999877929688, 865.3999633789062, 865.699951171875, 868.199951171875, 871.7999877929688, 874.8499755859375, 875.199951171875, 880.75, 884.5499877929688, 893.6499633789062, 906.8999633789062, 923.949951171875, 929.7999877929688, 949.8499755859375, 953.7000122070312, 957.4500122070312, 1008.3499755859375, 1121.0])
{bin(I,23,B) : B = 0..42} = 1 :- item(I).
bin_max(23,42).

% Feature 24 (f24): 25 bins  (thresholds: [0.0879799947142601, 0.09431999921798706, 0.09491999447345734, 0.09659499675035477, 0.09975999593734741, 0.10035999864339828, 0.10564999282360077, 0.11504999548196793, 0.13030000030994415, 0.13050000369548798, 0.1359499990940094, 0.13734999299049377, 0.13774999976158142, 0.14024999737739563, 0.14159999787807465, 0.14184999465942383, 0.14254999160766602, 0.14429999887943268, 0.14579999446868896, 0.14585000276565552, 0.15654999017715454, 0.16459999978542328, 0.1707499921321869, 0.17764998972415924])
{bin(I,24,B) : B = 0..24} = 1 :- item(I).
bin_max(24,24).

% Feature 25 (f25): 15 bins  (thresholds: [0.1597999930381775, 0.1757499873638153, 0.1782499998807907, 0.1935499906539917, 0.19824999570846558, 0.2399500012397766, 0.2574999928474426, 0.2678999900817871, 0.288100004196167, 0.30504998564720154, 0.367249995470047, 0.3849000036716461, 0.39010000228881836, 0.5095499753952026])
{bin(I,25,B) : B = 0..14} = 1 :- item(I).
bin_max(25,14).

% Feature 26 (f26): 31 bins  (thresholds: [0.17820000648498535, 0.1906999945640564, 0.19294999539852142, 0.20819999277591705, 0.20980000495910645, 0.21334999799728394, 0.2150000035762787, 0.21619999408721924, 0.21815000474452972, 0.2199999988079071, 0.22325000166893005, 0.22345000505447388, 0.22709999978542328, 0.23160000145435333, 0.26010000705718994, 0.2604999840259552, 0.2609499990940094, 0.2624000012874603, 0.2635500133037567, 0.2659499943256378, 0.29794999957084656, 0.3160000145435333, 0.3693999946117401, 0.36949998140335083, 0.3730500042438507, 0.3888999819755554, 0.4382999837398529, 0.48924997448921204, 0.7297999858856201, 1.076949954032898])
{bin(I,26,B) : B = 0..30} = 1 :- item(I).
bin_max(26,30).

% Feature 27 (f27): 44 bins  (thresholds: [0.06561499834060669, 0.08501999825239182, 0.08540000021457672, 0.09297999739646912, 0.09322499483823776, 0.10041499882936478, 0.1088000014424324, 0.10954999923706055, 0.1103999987244606, 0.11084999889135361, 0.11534999310970306, 0.12434999644756317, 0.12714998424053192, 0.13164998590946198, 0.1318499892950058, 0.13490000367164612, 0.1350499987602234, 0.13580000400543213, 0.1359499990940094, 0.1395999938249588, 0.14159999787807465, 0.14169999957084656, 0.1419999897480011, 0.14204999804496765, 0.1423499882221222, 0.14239999651908875, 0.14305000007152557, 0.14559999108314514, 0.14589999616146088, 0.14594998955726624, 0.1465499997138977, 0.14704999327659607, 0.14785000681877136, 0.14904999732971191, 0.15049999952316284, 0.15074999630451202, 0.15129999816417694, 0.15629999339580536, 0.15889999270439148, 0.15925000607967377, 0.16124999523162842, 0.1656000018119812, 0.18074999749660492])
{bin(I,27,B) : B = 0..43} = 1 :- item(I).
bin_max(27,43).

% Feature 28 (f28): 15 bins  (thresholds: [0.16084998846054077, 0.16384999454021454, 0.27364999055862427, 0.2766000032424927, 0.2825999855995178, 0.311849981546402, 0.31689998507499695, 0.31709998846054077, 0.31735000014305115, 0.323199987411499, 0.3314499855041504, 0.3570999801158905, 0.3576499819755554, 0.41130000352859497])
{bin(I,28,B) : B = 0..14} = 1 :- item(I).
bin_max(28,14).

% Feature 29 (f29): 11 bins  (thresholds: [0.05512499809265137, 0.056734997779130936, 0.06068499758839607, 0.06481499969959259, 0.07300499826669693, 0.07479000091552734, 0.09047999978065491, 0.09307000041007996, 0.09692999720573425, 0.1383499950170517])
{bin(I,29,B) : B = 0..10} = 1 :- item(I).
bin_max(29,10).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f27 <= 0.10954999923706055  (F27, bin <= 7)  left -> 1, right -> 8
node(0,0,27,7).
left_node(0,0,1).
right_node(0,0,8).
% node 1: f10 <= 0.5871500074863434  (F10, bin <= 9)  left -> 2, right -> 5
node(0,1,10,9).
left_node(0,1,2).
right_node(0,1,5).
% node 2: f23 <= 1008.3500061035156  (F23, bin <= 40)  left -> 3, right -> 4
node(0,2,23,40).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class B (0)
leaf_class(0,3,0).
% node 4 (leaf): class B (0)
leaf_class(0,4,0).
% node 5: f6 <= 0.12324999645352364  (F6, bin <= 19)  left -> 6, right -> 7
node(0,5,6,19).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class M (1)
leaf_class(0,6,1).
% node 7 (leaf): class B (0)
leaf_class(0,7,0).
% node 8: f22 <= 116.04999923706055  (F22, bin <= 28)  left -> 9, right -> 12
node(0,8,22,28).
left_node(0,8,9).
right_node(0,8,12).
% node 9: f1 <= 20.78499984741211  (F1, bin <= 22)  left -> 10, right -> 11
node(0,9,1,22).
left_node(0,9,10).
right_node(0,9,11).
% node 10 (leaf): class B (0)
leaf_class(0,10,0).
% node 11 (leaf): class M (1)
leaf_class(0,11,1).
% node 12 (leaf): class M (1)
leaf_class(0,12,1).

% Tree 1
tree(1).
% node 0: f26 <= 0.2150000035762787  (F26, bin <= 6)  left -> 1, right -> 6
node(1,0,26,6).
left_node(1,0,1).
right_node(1,0,6).
% node 1: f24 <= 0.11504999920725822  (F24, bin <= 7)  left -> 2, right -> 5
node(1,1,24,7).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f13 <= 43.310001373291016  (F13, bin <= 12)  left -> 3, right -> 4
node(1,2,13,12).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class B (0)
leaf_class(1,3,0).
% node 4 (leaf): class M (1)
leaf_class(1,4,1).
% node 5 (leaf): class B (0)
leaf_class(1,5,0).
% node 6: f2 <= 98.40499877929688  (F2, bin <= 10)  left -> 7, right -> 10
node(1,6,2,10).
left_node(1,6,7).
right_node(1,6,10).
% node 7: f20 <= 15.484999656677246  (F20, bin <= 8)  left -> 8, right -> 9
node(1,7,20,8).
left_node(1,7,8).
right_node(1,7,9).
% node 8 (leaf): class B (0)
leaf_class(1,8,0).
% node 9 (leaf): class M (1)
leaf_class(1,9,1).
% node 10: f20 <= 17.7549991607666  (F20, bin <= 25)  left -> 11, right -> 12
node(1,10,20,25).
left_node(1,10,11).
right_node(1,10,12).
% node 11 (leaf): class M (1)
leaf_class(1,11,1).
% node 12 (leaf): class M (1)
leaf_class(1,12,1).

% Tree 2
tree(2).
% node 0: f27 <= 0.14594999700784683  (F27, bin <= 29)  left -> 1, right -> 8
node(2,0,27,29).
left_node(2,0,1).
right_node(2,0,8).
% node 1: f3 <= 694.1499938964844  (F3, bin <= 11)  left -> 2, right -> 5
node(2,1,3,11).
left_node(2,1,2).
right_node(2,1,5).
% node 2: f23 <= 719.75  (F23, bin <= 6)  left -> 3, right -> 4
node(2,2,23,6).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class B (0)
leaf_class(2,3,0).
% node 4 (leaf): class B (0)
leaf_class(2,4,0).
% node 5: f21 <= 21.6899995803833  (F21, bin <= 5)  left -> 6, right -> 7
node(2,5,21,5).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class B (0)
leaf_class(2,6,0).
% node 7 (leaf): class M (1)
leaf_class(2,7,1).
% node 8: f22 <= 105.25  (F22, bin <= 10)  left -> 9, right -> 12
node(2,8,22,10).
left_node(2,8,9).
right_node(2,8,12).
% node 9: f7 <= 0.05371000058948994  (F7, bin <= 21)  left -> 10, right -> 11
node(2,9,7,21).
left_node(2,9,10).
right_node(2,9,11).
% node 10 (leaf): class B (0)
leaf_class(2,10,0).
% node 11 (leaf): class M (1)
leaf_class(2,11,1).
% node 12 (leaf): class M (1)
leaf_class(2,12,1).

% Tree 3
tree(3).
% node 0: f20 <= 16.789999961853027  (F20, bin <= 15)  left -> 1, right -> 8
node(3,0,20,15).
left_node(3,0,1).
right_node(3,0,8).
% node 1: f27 <= 0.1423499956727028  (F27, bin <= 24)  left -> 2, right -> 5
node(3,1,27,24).
left_node(3,1,2).
right_node(3,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(3,2,10,11).
left_node(3,2,3).
right_node(3,2,4).
% node 3 (leaf): class B (0)
leaf_class(3,3,0).
% node 4 (leaf): class B (0)
leaf_class(3,4,0).
% node 5: f15 <= 0.045934999361634254  (F15, bin <= 4)  left -> 6, right -> 7
node(3,5,15,4).
left_node(3,5,6).
right_node(3,5,7).
% node 6 (leaf): class M (1)
leaf_class(3,6,1).
% node 7 (leaf): class B (0)
leaf_class(3,7,0).
% node 8: f7 <= 0.059380000457167625  (F7, bin <= 29)  left -> 9, right -> 12
node(3,8,7,29).
left_node(3,8,9).
right_node(3,8,12).
% node 9: f27 <= 0.1396000012755394  (F27, bin <= 19)  left -> 10, right -> 11
node(3,9,27,19).
left_node(3,9,10).
right_node(3,9,11).
% node 10 (leaf): class M (1)
leaf_class(3,10,1).
% node 11 (leaf): class M (1)
leaf_class(3,11,1).
% node 12 (leaf): class M (1)
leaf_class(3,12,1).

% Tree 4
tree(4).
% node 0: f13 <= 42.94999885559082  (F13, bin <= 11)  left -> 1, right -> 8
node(4,0,13,11).
left_node(4,0,1).
right_node(4,0,8).
% node 1: f6 <= 0.07437999919056892  (F6, bin <= 6)  left -> 2, right -> 5
node(4,1,6,6).
left_node(4,1,2).
right_node(4,1,5).
% node 2: f28 <= 0.41130000352859497  (F28, bin <= 13)  left -> 3, right -> 4
node(4,2,28,13).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class B (0)
leaf_class(4,3,0).
% node 4 (leaf): class M (1)
leaf_class(4,4,1).
% node 5: f3 <= 577.1000061035156  (F3, bin <= 4)  left -> 6, right -> 7
node(4,5,3,4).
left_node(4,5,6).
right_node(4,5,7).
% node 6 (leaf): class B (0)
leaf_class(4,6,0).
% node 7 (leaf): class M (1)
leaf_class(4,7,1).
% node 8: f8 <= 0.1324000023305416  (F8, bin <= 0)  left -> 9, right -> 10
node(4,8,8,0).
left_node(4,8,9).
right_node(4,8,10).
% node 9 (leaf): class B (0)
leaf_class(4,9,0).
% node 10 (leaf): class M (1)
leaf_class(4,10,1).

% Tree 5
tree(5).
% node 0: f25 <= 0.1935499981045723  (F25, bin <= 3)  left -> 1, right -> 6
node(5,0,25,3).
left_node(5,0,1).
right_node(5,0,6).
% node 1: f2 <= 93.91500091552734  (F2, bin <= 6)  left -> 2, right -> 3
node(5,1,2,6).
left_node(5,1,2).
right_node(5,1,3).
% node 2 (leaf): class B (0)
leaf_class(5,2,0).
% node 3: f27 <= 0.13580000400543213  (F27, bin <= 17)  left -> 4, right -> 5
node(5,3,27,17).
left_node(5,3,4).
right_node(5,3,5).
% node 4 (leaf): class B (0)
leaf_class(5,4,0).
% node 5 (leaf): class M (1)
leaf_class(5,5,1).
% node 6: f6 <= 0.09329499676823616  (F6, bin <= 11)  left -> 7, right -> 10
node(5,6,6,11).
left_node(5,6,7).
right_node(5,6,10).
% node 7: f20 <= 17.539999961853027  (F20, bin <= 22)  left -> 8, right -> 9
node(5,7,20,22).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class B (0)
leaf_class(5,8,0).
% node 9 (leaf): class M (1)
leaf_class(5,9,1).
% node 10: f23 <= 817.8000183105469  (F23, bin <= 19)  left -> 11, right -> 12
node(5,10,23,19).
left_node(5,10,11).
right_node(5,10,12).
% node 11 (leaf): class B (0)
leaf_class(5,11,0).
% node 12 (leaf): class M (1)
leaf_class(5,12,1).

% Tree 6
tree(6).
% node 0: f7 <= 0.05591999925673008  (F7, bin <= 25)  left -> 1, right -> 8
node(6,0,7,25).
left_node(6,0,1).
right_node(6,0,8).
% node 1: f10 <= 0.453450009226799  (F10, bin <= 7)  left -> 2, right -> 5
node(6,1,10,7).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f27 <= 0.08540000021457672  (F27, bin <= 2)  left -> 3, right -> 4
node(6,2,27,2).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class B (0)
leaf_class(6,3,0).
% node 4 (leaf): class B (0)
leaf_class(6,4,0).
% node 5: f3 <= 425.4499969482422  (F3, bin <= 1)  left -> 6, right -> 7
node(6,5,3,1).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class B (0)
leaf_class(6,6,0).
% node 7 (leaf): class M (1)
leaf_class(6,7,1).
% node 8: f1 <= 15.425000190734863  (F1, bin <= 1)  left -> 9, right -> 12
node(6,8,1,1).
left_node(6,8,9).
right_node(6,8,12).
% node 9: f7 <= 0.0880650021135807  (F7, bin <= 35)  left -> 10, right -> 11
node(6,9,7,35).
left_node(6,9,10).
right_node(6,9,11).
% node 10 (leaf): class B (0)
leaf_class(6,10,0).
% node 11 (leaf): class M (1)
leaf_class(6,11,1).
% node 12: f23 <= 718.6499938964844  (F23, bin <= 5)  left -> 13, right -> 14
node(6,12,23,5).
left_node(6,12,13).
right_node(6,12,14).
% node 13 (leaf): class M (1)
leaf_class(6,13,1).
% node 14 (leaf): class M (1)
leaf_class(6,14,1).

% Tree 7
tree(7).
% node 0: f0 <= 15.03000020980835  (F0, bin <= 9)  left -> 1, right -> 8
node(7,0,0,9).
left_node(7,0,1).
right_node(7,0,8).
% node 1: f26 <= 0.3160000145435333  (F26, bin <= 21)  left -> 2, right -> 5
node(7,1,26,21).
left_node(7,1,2).
right_node(7,1,5).
% node 2: f15 <= 0.01203000033274293  (F15, bin <= 1)  left -> 3, right -> 4
node(7,2,15,1).
left_node(7,2,3).
right_node(7,2,4).
% node 3 (leaf): class B (0)
leaf_class(7,3,0).
% node 4 (leaf): class B (0)
leaf_class(7,4,0).
% node 5: f10 <= 0.1936499997973442  (F10, bin <= 1)  left -> 6, right -> 7
node(7,5,10,1).
left_node(7,5,6).
right_node(7,5,7).
% node 6 (leaf): class B (0)
leaf_class(7,6,0).
% node 7 (leaf): class M (1)
leaf_class(7,7,1).
% node 8: f25 <= 0.2574999928474426  (F25, bin <= 6)  left -> 9, right -> 12
node(7,8,25,6).
left_node(7,8,9).
right_node(7,8,12).
% node 9: f13 <= 22.005000114440918  (F13, bin <= 2)  left -> 10, right -> 11
node(7,9,13,2).
left_node(7,9,10).
right_node(7,9,11).
% node 10 (leaf): class B (0)
leaf_class(7,10,0).
% node 11 (leaf): class M (1)
leaf_class(7,11,1).
% node 12 (leaf): class M (1)
leaf_class(7,12,1).

% Tree 8
tree(8).
% node 0: f2 <= 98.43000030517578  (F2, bin <= 11)  left -> 1, right -> 8
node(8,0,2,11).
left_node(8,0,1).
right_node(8,0,8).
% node 1: f7 <= 0.04319499991834164  (F7, bin <= 4)  left -> 2, right -> 5
node(8,1,7,4).
left_node(8,1,2).
right_node(8,1,5).
% node 2: f20 <= 14.484999656677246  (F20, bin <= 1)  left -> 3, right -> 4
node(8,2,20,1).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class B (0)
leaf_class(8,3,0).
% node 4 (leaf): class B (0)
leaf_class(8,4,0).
% node 5: f27 <= 0.1490500047802925  (F27, bin <= 33)  left -> 6, right -> 7
node(8,5,27,33).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class B (0)
leaf_class(8,6,0).
% node 7 (leaf): class M (1)
leaf_class(8,7,1).
% node 8: f1 <= 16.234999656677246  (F1, bin <= 5)  left -> 9, right -> 12
node(8,8,1,5).
left_node(8,8,9).
right_node(8,8,12).
% node 9: f17 <= 0.014274999499320984  (F17, bin <= 1)  left -> 10, right -> 11
node(8,9,17,1).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class B (0)
leaf_class(8,10,0).
% node 11 (leaf): class M (1)
leaf_class(8,11,1).
% node 12: f9 <= 0.05602999962866306  (F9, bin <= 2)  left -> 13, right -> 14
node(8,12,9,2).
left_node(8,12,13).
right_node(8,12,14).
% node 13 (leaf): class M (1)
leaf_class(8,13,1).
% node 14 (leaf): class M (1)
leaf_class(8,14,1).

% Tree 9
tree(9).
% node 0: f23 <= 874.8500061035156  (F23, bin <= 29)  left -> 1, right -> 6
node(9,0,23,29).
left_node(9,0,1).
right_node(9,0,6).
% node 1: f27 <= 0.16125000268220901  (F27, bin <= 40)  left -> 2, right -> 5
node(9,1,27,40).
left_node(9,1,2).
right_node(9,1,5).
% node 2: f1 <= 21.260000228881836  (F1, bin <= 25)  left -> 3, right -> 4
node(9,2,1,25).
left_node(9,2,3).
right_node(9,2,4).
% node 3 (leaf): class B (0)
leaf_class(9,3,0).
% node 4 (leaf): class B (0)
leaf_class(9,4,0).
% node 5 (leaf): class M (1)
leaf_class(9,5,1).
% node 6: f5 <= 0.08555500209331512  (F5, bin <= 3)  left -> 7, right -> 10
node(9,6,5,3).
left_node(9,6,7).
right_node(9,6,10).
% node 7: f7 <= 0.051124999299645424  (F7, bin <= 17)  left -> 8, right -> 9
node(9,7,7,17).
left_node(9,7,8).
right_node(9,7,9).
% node 8 (leaf): class B (0)
leaf_class(9,8,0).
% node 9 (leaf): class M (1)
leaf_class(9,9,1).
% node 10 (leaf): class M (1)
leaf_class(9,10,1).

% Tree 10
tree(10).
% node 0: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 1, right -> 8
node(10,0,7,18).
left_node(10,0,1).
right_node(10,0,8).
% node 1: f22 <= 95.51000213623047  (F22, bin <= 2)  left -> 2, right -> 5
node(10,1,22,2).
left_node(10,1,2).
right_node(10,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(10,2,10,11).
left_node(10,2,3).
right_node(10,2,4).
% node 3 (leaf): class B (0)
leaf_class(10,3,0).
% node 4 (leaf): class M (1)
leaf_class(10,4,1).
% node 5: f1 <= 19.614999771118164  (F1, bin <= 19)  left -> 6, right -> 7
node(10,5,1,19).
left_node(10,5,6).
right_node(10,5,7).
% node 6 (leaf): class B (0)
leaf_class(10,6,0).
% node 7 (leaf): class B (0)
leaf_class(10,7,0).
% node 8: f2 <= 102.85000228881836  (F2, bin <= 14)  left -> 9, right -> 12
node(10,8,2,14).
left_node(10,8,9).
right_node(10,8,12).
% node 9: f28 <= 0.31735000014305115  (F28, bin <= 8)  left -> 10, right -> 11
node(10,9,28,8).
left_node(10,9,10).
right_node(10,9,11).
% node 10 (leaf): class B (0)
leaf_class(10,10,0).
% node 11 (leaf): class M (1)
leaf_class(10,11,1).
% node 12 (leaf): class M (1)
leaf_class(10,12,1).

% Tree 11
tree(11).
% node 0: f0 <= 15.115000247955322  (F0, bin <= 10)  left -> 1, right -> 8
node(11,0,0,10).
left_node(11,0,1).
right_node(11,0,8).
% node 1: f20 <= 16.795000076293945  (F20, bin <= 16)  left -> 2, right -> 5
node(11,1,20,16).
left_node(11,1,2).
right_node(11,1,5).
% node 2: f26 <= 0.3888999968767166  (F26, bin <= 25)  left -> 3, right -> 4
node(11,2,26,25).
left_node(11,2,3).
right_node(11,2,4).
% node 3 (leaf): class B (0)
leaf_class(11,3,0).
% node 4 (leaf): class B (0)
leaf_class(11,4,0).
% node 5: f14 <= 0.0034649999579414725  (F14, bin <= 0)  left -> 6, right -> 7
node(11,5,14,0).
left_node(11,5,6).
right_node(11,5,7).
% node 6 (leaf): class B (0)
leaf_class(11,6,0).
% node 7 (leaf): class M (1)
leaf_class(11,7,1).
% node 8: f26 <= 0.21620000153779984  (F26, bin <= 7)  left -> 9, right -> 12
node(11,8,26,7).
left_node(11,8,9).
right_node(11,8,12).
% node 9: f25 <= 0.1598000004887581  (F25, bin <= 0)  left -> 10, right -> 11
node(11,9,25,0).
left_node(11,9,10).
right_node(11,9,11).
% node 10 (leaf): class M (1)
leaf_class(11,10,1).
% node 11 (leaf): class B (0)
leaf_class(11,11,0).
% node 12 (leaf): class M (1)
leaf_class(11,12,1).

% Tree 12
tree(12).
% node 0: f7 <= 0.055800000205636024  (F7, bin <= 24)  left -> 1, right -> 8
node(12,0,7,24).
left_node(12,0,1).
right_node(12,0,8).
% node 1: f21 <= 28.020000457763672  (F21, bin <= 21)  left -> 2, right -> 5
node(12,1,21,21).
left_node(12,1,2).
right_node(12,1,5).
% node 2: f3 <= 692.3500061035156  (F3, bin <= 10)  left -> 3, right -> 4
node(12,2,3,10).
left_node(12,2,3).
right_node(12,2,4).
% node 3 (leaf): class B (0)
leaf_class(12,3,0).
% node 4 (leaf): class B (0)
leaf_class(12,4,0).
% node 5: f7 <= 0.02573499921709299  (F7, bin <= 0)  left -> 6, right -> 7
node(12,5,7,0).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class B (0)
leaf_class(12,6,0).
% node 7 (leaf): class M (1)
leaf_class(12,7,1).
% node 8: f22 <= 112.9000015258789  (F22, bin <= 22)  left -> 9, right -> 12
node(12,8,22,22).
left_node(12,8,9).
right_node(12,8,12).
% node 9: f25 <= 0.367249995470047  (F25, bin <= 10)  left -> 10, right -> 11
node(12,9,25,10).
left_node(12,9,10).
right_node(12,9,11).
% node 10 (leaf): class B (0)
leaf_class(12,10,0).
% node 11 (leaf): class M (1)
leaf_class(12,11,1).
% node 12 (leaf): class M (1)
leaf_class(12,12,1).

% Tree 13
tree(13).
% node 0: f22 <= 115.3499984741211  (F22, bin <= 26)  left -> 1, right -> 8
node(13,0,22,26).
left_node(13,0,1).
right_node(13,0,8).
% node 1: f7 <= 0.04440000094473362  (F7, bin <= 7)  left -> 2, right -> 5
node(13,1,7,7).
left_node(13,1,2).
right_node(13,1,5).
% node 2: f1 <= 21.574999809265137  (F1, bin <= 26)  left -> 3, right -> 4
node(13,2,1,26).
left_node(13,2,3).
right_node(13,2,4).
% node 3 (leaf): class B (0)
leaf_class(13,3,0).
% node 4 (leaf): class B (0)
leaf_class(13,4,0).
% node 5: f27 <= 0.15925000607967377  (F27, bin <= 39)  left -> 6, right -> 7
node(13,5,27,39).
left_node(13,5,6).
right_node(13,5,7).
% node 6 (leaf): class B (0)
leaf_class(13,6,0).
% node 7 (leaf): class M (1)
leaf_class(13,7,1).
% node 8: f29 <= 0.06481499969959259  (F29, bin <= 3)  left -> 9, right -> 12
node(13,8,29,3).
left_node(13,8,9).
right_node(13,8,12).
% node 9: f12 <= 3.6735000610351562  (F12, bin <= 3)  left -> 10, right -> 11
node(13,9,12,3).
left_node(13,9,10).
right_node(13,9,11).
% node 10 (leaf): class B (0)
leaf_class(13,10,0).
% node 11 (leaf): class M (1)
leaf_class(13,11,1).
% node 12 (leaf): class M (1)
leaf_class(13,12,1).

% Tree 14
tree(14).
% node 0: f5 <= 0.10195000097155571  (F5, bin <= 7)  left -> 1, right -> 8
node(14,0,5,7).
left_node(14,0,1).
right_node(14,0,8).
% node 1: f26 <= 0.19295000284910202  (F26, bin <= 2)  left -> 2, right -> 5
node(14,1,26,2).
left_node(14,1,2).
right_node(14,1,5).
% node 2: f18 <= 0.009265999775379896  (F18, bin <= 1)  left -> 3, right -> 4
node(14,2,18,1).
left_node(14,2,3).
right_node(14,2,4).
% node 3 (leaf): class M (1)
leaf_class(14,3,1).
% node 4 (leaf): class B (0)
leaf_class(14,4,0).
% node 5: f23 <= 893.6499938964844  (F23, bin <= 33)  left -> 6, right -> 7
node(14,5,23,33).
left_node(14,5,6).
right_node(14,5,7).
% node 6 (leaf): class B (0)
leaf_class(14,6,0).
% node 7 (leaf): class M (1)
leaf_class(14,7,1).
% node 8: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 9, right -> 12
node(14,8,23,27).
left_node(14,8,9).
right_node(14,8,12).
% node 9: f21 <= 25.734999656677246  (F21, bin <= 13)  left -> 10, right -> 11
node(14,9,21,13).
left_node(14,9,10).
right_node(14,9,11).
% node 10 (leaf): class B (0)
leaf_class(14,10,0).
% node 11 (leaf): class M (1)
leaf_class(14,11,1).
% node 12 (leaf): class M (1)
leaf_class(14,12,1).

% Tree 15
tree(15).
% node 0: f0 <= 15.025000095367432  (F0, bin <= 8)  left -> 1, right -> 8
node(15,0,0,8).
left_node(15,0,1).
right_node(15,0,8).
% node 1: f27 <= 0.1419999971985817  (F27, bin <= 22)  left -> 2, right -> 5
node(15,1,27,22).
left_node(15,1,2).
right_node(15,1,5).
% node 2: f0 <= 12.765000343322754  (F0, bin <= 1)  left -> 3, right -> 4
node(15,2,0,1).
left_node(15,2,3).
right_node(15,2,4).
% node 3 (leaf): class B (0)
leaf_class(15,3,0).
% node 4 (leaf): class B (0)
leaf_class(15,4,0).
% node 5: f7 <= 0.05489500053226948  (F7, bin <= 23)  left -> 6, right -> 7
node(15,5,7,23).
left_node(15,5,6).
right_node(15,5,7).
% node 6 (leaf): class B (0)
leaf_class(15,6,0).
% node 7 (leaf): class M (1)
leaf_class(15,7,1).
% node 8: f1 <= 16.394999504089355  (F1, bin <= 6)  left -> 9, right -> 12
node(15,8,1,6).
left_node(15,8,9).
right_node(15,8,12).
% node 9: f7 <= 0.06218999996781349  (F7, bin <= 30)  left -> 10, right -> 11
node(15,9,7,30).
left_node(15,9,10).
right_node(15,9,11).
% node 10 (leaf): class B (0)
leaf_class(15,10,0).
% node 11 (leaf): class M (1)
leaf_class(15,11,1).
% node 12 (leaf): class M (1)
leaf_class(15,12,1).

% Tree 16
tree(16).
% node 0: f3 <= 694.1499938964844  (F3, bin <= 11)  left -> 1, right -> 8
node(16,0,3,11).
left_node(16,0,1).
right_node(16,0,8).
% node 1: f22 <= 101.44999694824219  (F22, bin <= 4)  left -> 2, right -> 5
node(16,1,22,4).
left_node(16,1,2).
right_node(16,1,5).
% node 2: f29 <= 0.1383500024676323  (F29, bin <= 9)  left -> 3, right -> 4
node(16,2,29,9).
left_node(16,2,3).
right_node(16,2,4).
% node 3 (leaf): class B (0)
leaf_class(16,3,0).
% node 4 (leaf): class M (1)
leaf_class(16,4,1).
% node 5: f21 <= 26.675000190734863  (F21, bin <= 16)  left -> 6, right -> 7
node(16,5,21,16).
left_node(16,5,6).
right_node(16,5,7).
% node 6 (leaf): class B (0)
leaf_class(16,6,0).
% node 7 (leaf): class M (1)
leaf_class(16,7,1).
% node 8: f1 <= 14.095000267028809  (F1, bin <= 0)  left -> 9, right -> 12
node(16,8,1,0).
left_node(16,8,9).
right_node(16,8,12).
% node 9: f7 <= 0.10460500046610832  (F7, bin <= 36)  left -> 10, right -> 11
node(16,9,7,36).
left_node(16,9,10).
right_node(16,9,11).
% node 10 (leaf): class B (0)
leaf_class(16,10,0).
% node 11 (leaf): class M (1)
leaf_class(16,11,1).
% node 12: f26 <= 0.21815000474452972  (F26, bin <= 8)  left -> 13, right -> 14
node(16,12,26,8).
left_node(16,12,13).
right_node(16,12,14).
% node 13 (leaf): class M (1)
leaf_class(16,13,1).
% node 14 (leaf): class M (1)
leaf_class(16,14,1).

% Tree 17
tree(17).
% node 0: f13 <= 32.93000030517578  (F13, bin <= 7)  left -> 1, right -> 8
node(17,0,13,7).
left_node(17,0,1).
right_node(17,0,8).
% node 1: f25 <= 0.2679000049829483  (F25, bin <= 7)  left -> 2, right -> 5
node(17,1,25,7).
left_node(17,1,2).
right_node(17,1,5).
% node 2: f23 <= 785.75  (F23, bin <= 17)  left -> 3, right -> 4
node(17,2,23,17).
left_node(17,2,3).
right_node(17,2,4).
% node 3 (leaf): class B (0)
leaf_class(17,3,0).
% node 4 (leaf): class B (0)
leaf_class(17,4,0).
% node 5: f19 <= 0.006055500125512481  (F19, bin <= 7)  left -> 6, right -> 7
node(17,5,19,7).
left_node(17,5,6).
right_node(17,5,7).
% node 6 (leaf): class M (1)
leaf_class(17,6,1).
% node 7 (leaf): class B (0)
leaf_class(17,7,0).
% node 8: f26 <= 0.22709999978542328  (F26, bin <= 12)  left -> 9, right -> 12
node(17,8,26,12).
left_node(17,8,9).
right_node(17,8,12).
% node 9: f3 <= 686.6499938964844  (F3, bin <= 9)  left -> 10, right -> 11
node(17,9,3,9).
left_node(17,9,10).
right_node(17,9,11).
% node 10 (leaf): class B (0)
leaf_class(17,10,0).
% node 11 (leaf): class M (1)
leaf_class(17,11,1).
% node 12: f18 <= 0.02551999967545271  (F18, bin <= 7)  left -> 13, right -> 14
node(17,12,18,7).
left_node(17,12,13).
right_node(17,12,14).
% node 13 (leaf): class M (1)
leaf_class(17,13,1).
% node 14 (leaf): class M (1)
leaf_class(17,14,1).

% Tree 18
tree(18).
% node 0: f6 <= 0.0861550010740757  (F6, bin <= 9)  left -> 1, right -> 8
node(18,0,6,9).
left_node(18,0,1).
right_node(18,0,8).
% node 1: f9 <= 0.05511999875307083  (F9, bin <= 0)  left -> 2, right -> 5
node(18,1,9,0).
left_node(18,1,2).
right_node(18,1,5).
% node 2: f7 <= 0.02804000023752451  (F7, bin <= 3)  left -> 3, right -> 4
node(18,2,7,3).
left_node(18,2,3).
right_node(18,2,4).
% node 3 (leaf): class B (0)
leaf_class(18,3,0).
% node 4 (leaf): class M (1)
leaf_class(18,4,1).
% node 5: f11 <= 0.3842500001192093  (F11, bin <= 1)  left -> 6, right -> 7
node(18,5,11,1).
left_node(18,5,6).
right_node(18,5,7).
% node 6 (leaf): class M (1)
leaf_class(18,6,1).
% node 7 (leaf): class B (0)
leaf_class(18,7,0).
% node 8: f27 <= 0.1465499997138977  (F27, bin <= 30)  left -> 9, right -> 12
node(18,8,27,30).
left_node(18,8,9).
right_node(18,8,12).
% node 9: f23 <= 865.3999938964844  (F23, bin <= 25)  left -> 10, right -> 11
node(18,9,23,25).
left_node(18,9,10).
right_node(18,9,11).
% node 10 (leaf): class B (0)
leaf_class(18,10,0).
% node 11 (leaf): class M (1)
leaf_class(18,11,1).
% node 12: f20 <= 15.394999980926514  (F20, bin <= 7)  left -> 13, right -> 14
node(18,12,20,7).
left_node(18,12,13).
right_node(18,12,14).
% node 13 (leaf): class M (1)
leaf_class(18,13,1).
% node 14 (leaf): class M (1)
leaf_class(18,14,1).

% Tree 19
tree(19).
% node 0: f6 <= 0.10330000147223473  (F6, bin <= 16)  left -> 1, right -> 8
node(19,0,6,16).
left_node(19,0,1).
right_node(19,0,8).
% node 1: f22 <= 101.79999923706055  (F22, bin <= 6)  left -> 2, right -> 5
node(19,1,22,6).
left_node(19,1,2).
right_node(19,1,5).
% node 2: f28 <= 0.16084999591112137  (F28, bin <= 0)  left -> 3, right -> 4
node(19,2,28,0).
left_node(19,2,3).
right_node(19,2,4).
% node 3 (leaf): class M (1)
leaf_class(19,3,1).
% node 4 (leaf): class B (0)
leaf_class(19,4,0).
% node 5: f27 <= 0.11084999889135361  (F27, bin <= 9)  left -> 6, right -> 7
node(19,5,27,9).
left_node(19,5,6).
right_node(19,5,7).
% node 6 (leaf): class B (0)
leaf_class(19,6,0).
% node 7 (leaf): class M (1)
leaf_class(19,7,1).
% node 8: f22 <= 105.95000076293945  (F22, bin <= 11)  left -> 9, right -> 12
node(19,8,22,11).
left_node(19,8,9).
right_node(19,8,12).
% node 9: f24 <= 0.1707499995827675  (F24, bin <= 22)  left -> 10, right -> 11
node(19,9,24,22).
left_node(19,9,10).
right_node(19,9,11).
% node 10 (leaf): class B (0)
leaf_class(19,10,0).
% node 11 (leaf): class M (1)
leaf_class(19,11,1).
% node 12: f27 <= 0.12434999644756317  (F27, bin <= 11)  left -> 13, right -> 14
node(19,12,27,11).
left_node(19,12,13).
right_node(19,12,14).
% node 13 (leaf): class B (0)
leaf_class(19,13,0).
% node 14 (leaf): class M (1)
leaf_class(19,14,1).

% Tree 20
tree(20).
% node 0: f3 <= 696.25  (F3, bin <= 12)  left -> 1, right -> 8
node(20,0,3,12).
left_node(20,0,1).
right_node(20,0,8).
% node 1: f23 <= 727.1000061035156  (F23, bin <= 8)  left -> 2, right -> 5
node(20,1,23,8).
left_node(20,1,2).
right_node(20,1,5).
% node 2: f25 <= 0.5095500200986862  (F25, bin <= 13)  left -> 3, right -> 4
node(20,2,25,13).
left_node(20,2,3).
right_node(20,2,4).
% node 3 (leaf): class B (0)
leaf_class(20,3,0).
% node 4 (leaf): class M (1)
leaf_class(20,4,1).
% node 5: f24 <= 0.14025000482797623  (F24, bin <= 13)  left -> 6, right -> 7
node(20,5,24,13).
left_node(20,5,6).
right_node(20,5,7).
% node 6 (leaf): class B (0)
leaf_class(20,6,0).
% node 7 (leaf): class M (1)
leaf_class(20,7,1).
% node 8: f26 <= 0.23160000145435333  (F26, bin <= 13)  left -> 9, right -> 12
node(20,8,26,13).
left_node(20,8,9).
right_node(20,8,12).
% node 9: f21 <= 22.3149995803833  (F21, bin <= 6)  left -> 10, right -> 11
node(20,9,21,6).
left_node(20,9,10).
right_node(20,9,11).
% node 10 (leaf): class B (0)
leaf_class(20,10,0).
% node 11 (leaf): class M (1)
leaf_class(20,11,1).
% node 12: f27 <= 0.14589999616146088  (F27, bin <= 28)  left -> 13, right -> 14
node(20,12,27,28).
left_node(20,12,13).
right_node(20,12,14).
% node 13 (leaf): class M (1)
leaf_class(20,13,1).
% node 14 (leaf): class M (1)
leaf_class(20,14,1).

% Tree 21
tree(21).
% node 0: f23 <= 844.75  (F23, bin <= 23)  left -> 1, right -> 8
node(21,0,23,23).
left_node(21,0,1).
right_node(21,0,8).
% node 1: f27 <= 0.13580000400543213  (F27, bin <= 17)  left -> 2, right -> 5
node(21,1,27,17).
left_node(21,1,2).
right_node(21,1,5).
% node 2: f18 <= 0.00925099989399314  (F18, bin <= 0)  left -> 3, right -> 4
node(21,2,18,0).
left_node(21,2,3).
right_node(21,2,4).
% node 3 (leaf): class M (1)
leaf_class(21,3,1).
% node 4 (leaf): class B (0)
leaf_class(21,4,0).
% node 5: f21 <= 27.385000228881836  (F21, bin <= 19)  left -> 6, right -> 7
node(21,5,21,19).
left_node(21,5,6).
right_node(21,5,7).
% node 6 (leaf): class B (0)
leaf_class(21,6,0).
% node 7 (leaf): class M (1)
leaf_class(21,7,1).
% node 8: f25 <= 0.1935499981045723  (F25, bin <= 3)  left -> 9, right -> 12
node(21,8,25,3).
left_node(21,8,9).
right_node(21,8,12).
% node 9: f22 <= 109.95000076293945  (F22, bin <= 18)  left -> 10, right -> 11
node(21,9,22,18).
left_node(21,9,10).
right_node(21,9,11).
% node 10 (leaf): class B (0)
leaf_class(21,10,0).
% node 11 (leaf): class M (1)
leaf_class(21,11,1).
% node 12: f20 <= 16.744999885559082  (F20, bin <= 14)  left -> 13, right -> 14
node(21,12,20,14).
left_node(21,12,13).
right_node(21,12,14).
% node 13 (leaf): class B (0)
leaf_class(21,13,0).
% node 14 (leaf): class M (1)
leaf_class(21,14,1).

% Tree 22
tree(22).
% node 0: f6 <= 0.10330000147223473  (F6, bin <= 16)  left -> 1, right -> 8
node(22,0,6,16).
left_node(22,0,1).
right_node(22,0,8).
% node 1: f7 <= 0.05255500040948391  (F7, bin <= 19)  left -> 2, right -> 5
node(22,1,7,19).
left_node(22,1,2).
right_node(22,1,5).
% node 2: f3 <= 562.1499938964844  (F3, bin <= 2)  left -> 3, right -> 4
node(22,2,3,2).
left_node(22,2,3).
right_node(22,2,4).
% node 3 (leaf): class B (0)
leaf_class(22,3,0).
% node 4 (leaf): class B (0)
leaf_class(22,4,0).
% node 5: f12 <= 1.9304999709129333  (F12, bin <= 1)  left -> 6, right -> 7
node(22,5,12,1).
left_node(22,5,6).
right_node(22,5,7).
% node 6 (leaf): class B (0)
leaf_class(22,6,0).
% node 7 (leaf): class M (1)
leaf_class(22,7,1).
% node 8: f21 <= 22.84999942779541  (F21, bin <= 7)  left -> 9, right -> 12
node(22,8,21,7).
left_node(22,8,9).
right_node(22,8,12).
% node 9: f23 <= 818.2000122070312  (F23, bin <= 21)  left -> 10, right -> 11
node(22,9,23,21).
left_node(22,9,10).
right_node(22,9,11).
% node 10 (leaf): class B (0)
leaf_class(22,10,0).
% node 11 (leaf): class M (1)
leaf_class(22,11,1).
% node 12: f27 <= 0.12714999541640282  (F27, bin <= 12)  left -> 13, right -> 14
node(22,12,27,12).
left_node(22,12,13).
right_node(22,12,14).
% node 13 (leaf): class B (0)
leaf_class(22,13,0).
% node 14 (leaf): class M (1)
leaf_class(22,14,1).

% Tree 23
tree(23).
% node 0: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 1, right -> 8
node(23,0,7,18).
left_node(23,0,1).
right_node(23,0,8).
% node 1: f3 <= 696.25  (F3, bin <= 12)  left -> 2, right -> 5
node(23,1,3,12).
left_node(23,1,2).
right_node(23,1,5).
% node 2: f22 <= 108.54999923706055  (F22, bin <= 15)  left -> 3, right -> 4
node(23,2,22,15).
left_node(23,2,3).
right_node(23,2,4).
% node 3 (leaf): class B (0)
leaf_class(23,3,0).
% node 4 (leaf): class B (0)
leaf_class(23,4,0).
% node 5: f1 <= 16.19000005722046  (F1, bin <= 4)  left -> 6, right -> 7
node(23,5,1,4).
left_node(23,5,6).
right_node(23,5,7).
% node 6 (leaf): class B (0)
leaf_class(23,6,0).
% node 7 (leaf): class M (1)
leaf_class(23,7,1).
% node 8: f22 <= 114.89999771118164  (F22, bin <= 25)  left -> 9, right -> 12
node(23,8,22,25).
left_node(23,8,9).
right_node(23,8,12).
% node 9: f1 <= 20.25  (F1, bin <= 20)  left -> 10, right -> 11
node(23,9,1,20).
left_node(23,9,10).
right_node(23,9,11).
% node 10 (leaf): class B (0)
leaf_class(23,10,0).
% node 11 (leaf): class M (1)
leaf_class(23,11,1).
% node 12 (leaf): class M (1)
leaf_class(23,12,1).

% Tree 24
tree(24).
% node 0: f2 <= 92.7750015258789  (F2, bin <= 5)  left -> 1, right -> 8
node(24,0,2,5).
left_node(24,0,1).
right_node(24,0,8).
% node 1: f27 <= 0.14785000681877136  (F27, bin <= 32)  left -> 2, right -> 5
node(24,1,27,32).
left_node(24,1,2).
right_node(24,1,5).
% node 2: f22 <= 107.20000076293945  (F22, bin <= 13)  left -> 3, right -> 4
node(24,2,22,13).
left_node(24,2,3).
right_node(24,2,4).
% node 3 (leaf): class B (0)
leaf_class(24,3,0).
% node 4 (leaf): class M (1)
leaf_class(24,4,1).
% node 5: f26 <= 0.7298000156879425  (F26, bin <= 28)  left -> 6, right -> 7
node(24,5,26,28).
left_node(24,5,6).
right_node(24,5,7).
% node 6 (leaf): class M (1)
leaf_class(24,6,1).
% node 7 (leaf): class B (0)
leaf_class(24,7,0).
% node 8: f1 <= 17.769999504089355  (F1, bin <= 10)  left -> 9, right -> 12
node(24,8,1,10).
left_node(24,8,9).
right_node(24,8,12).
% node 9: f22 <= 116.79999923706055  (F22, bin <= 29)  left -> 10, right -> 11
node(24,9,22,29).
left_node(24,9,10).
right_node(24,9,11).
% node 10 (leaf): class B (0)
leaf_class(24,10,0).
% node 11 (leaf): class M (1)
leaf_class(24,11,1).
% node 12: f7 <= 0.05104999989271164  (F7, bin <= 16)  left -> 13, right -> 14
node(24,12,7,16).
left_node(24,12,13).
right_node(24,12,14).
% node 13 (leaf): class M (1)
leaf_class(24,13,1).
% node 14 (leaf): class M (1)
leaf_class(24,14,1).

% Tree 25
tree(25).
% node 0: f6 <= 0.08942000195384026  (F6, bin <= 10)  left -> 1, right -> 8
node(25,0,6,10).
left_node(25,0,1).
right_node(25,0,8).
% node 1: f2 <= 85.76499938964844  (F2, bin <= 1)  left -> 2, right -> 5
node(25,1,2,1).
left_node(25,1,2).
right_node(25,1,5).
% node 2: f13 <= 45.17500114440918  (F13, bin <= 13)  left -> 3, right -> 4
node(25,2,13,13).
left_node(25,2,3).
right_node(25,2,4).
% node 3 (leaf): class B (0)
leaf_class(25,3,0).
% node 4 (leaf): class M (1)
leaf_class(25,4,1).
% node 5: f21 <= 23.300000190734863  (F21, bin <= 8)  left -> 6, right -> 7
node(25,5,21,8).
left_node(25,5,6).
right_node(25,5,7).
% node 6 (leaf): class B (0)
leaf_class(25,6,0).
% node 7 (leaf): class B (0)
leaf_class(25,7,0).
% node 8: f27 <= 0.14169999957084656  (F27, bin <= 21)  left -> 9, right -> 12
node(25,8,27,21).
left_node(25,8,9).
right_node(25,8,12).
% node 9: f15 <= 0.029685000889003277  (F15, bin <= 2)  left -> 10, right -> 11
node(25,9,15,2).
left_node(25,9,10).
right_node(25,9,11).
% node 10 (leaf): class M (1)
leaf_class(25,10,1).
% node 11 (leaf): class B (0)
leaf_class(25,11,0).
% node 12: f23 <= 444.3000030517578  (F23, bin <= 1)  left -> 13, right -> 14
node(25,12,23,1).
left_node(25,12,13).
right_node(25,12,14).
% node 13 (leaf): class B (0)
leaf_class(25,13,0).
% node 14 (leaf): class M (1)
leaf_class(25,14,1).

% Tree 26
tree(26).
% node 0: f27 <= 0.14239999651908875  (F27, bin <= 25)  left -> 1, right -> 8
node(26,0,27,25).
left_node(26,0,1).
right_node(26,0,8).
% node 1: f3 <= 696.25  (F3, bin <= 12)  left -> 2, right -> 5
node(26,1,3,12).
left_node(26,1,2).
right_node(26,1,5).
% node 2: f27 <= 0.09322499856352806  (F27, bin <= 4)  left -> 3, right -> 4
node(26,2,27,4).
left_node(26,2,3).
right_node(26,2,4).
% node 3 (leaf): class B (0)
leaf_class(26,3,0).
% node 4 (leaf): class B (0)
leaf_class(26,4,0).
% node 5: f1 <= 17.059999465942383  (F1, bin <= 9)  left -> 6, right -> 7
node(26,5,1,9).
left_node(26,5,6).
right_node(26,5,7).
% node 6 (leaf): class B (0)
leaf_class(26,6,0).
% node 7 (leaf): class M (1)
leaf_class(26,7,1).
% node 8: f22 <= 91.03499984741211  (F22, bin <= 1)  left -> 9, right -> 10
node(26,8,22,1).
left_node(26,8,9).
right_node(26,8,10).
% node 9 (leaf): class B (0)
leaf_class(26,9,0).
% node 10: f24 <= 0.09659499675035477  (F24, bin <= 3)  left -> 11, right -> 12
node(26,10,24,3).
left_node(26,10,11).
right_node(26,10,12).
% node 11 (leaf): class B (0)
leaf_class(26,11,0).
% node 12 (leaf): class M (1)
leaf_class(26,12,1).

% Tree 27
tree(27).
% node 0: f10 <= 0.5279000103473663  (F10, bin <= 8)  left -> 1, right -> 8
node(27,0,10,8).
left_node(27,0,1).
right_node(27,0,8).
% node 1: f20 <= 15.174999713897705  (F20, bin <= 6)  left -> 2, right -> 5
node(27,1,20,6).
left_node(27,1,2).
right_node(27,1,5).
% node 2: f8 <= 0.2595999985933304  (F8, bin <= 2)  left -> 3, right -> 4
node(27,2,8,2).
left_node(27,2,3).
right_node(27,2,4).
% node 3 (leaf): class B (0)
leaf_class(27,3,0).
% node 4 (leaf): class M (1)
leaf_class(27,4,1).
% node 5: f21 <= 28.5649995803833  (F21, bin <= 22)  left -> 6, right -> 7
node(27,5,21,22).
left_node(27,5,6).
right_node(27,5,7).
% node 6 (leaf): class B (0)
leaf_class(27,6,0).
% node 7 (leaf): class M (1)
leaf_class(27,7,1).
% node 8: f3 <= 674.8999938964844  (F3, bin <= 8)  left -> 9, right -> 12
node(27,8,3,8).
left_node(27,8,9).
right_node(27,8,12).
% node 9: f22 <= 106.14999771118164  (F22, bin <= 12)  left -> 10, right -> 11
node(27,9,22,12).
left_node(27,9,10).
right_node(27,9,11).
% node 10 (leaf): class B (0)
leaf_class(27,10,0).
% node 11 (leaf): class M (1)
leaf_class(27,11,1).
% node 12 (leaf): class M (1)
leaf_class(27,12,1).

% Tree 28
tree(28).
% node 0: f23 <= 906.8999938964844  (F23, bin <= 34)  left -> 1, right -> 8
node(28,0,23,34).
left_node(28,0,1).
right_node(28,0,8).
% node 1: f24 <= 0.15654999762773514  (F24, bin <= 20)  left -> 2, right -> 5
node(28,1,24,20).
left_node(28,1,2).
right_node(28,1,5).
% node 2: f20 <= 14.980000019073486  (F20, bin <= 5)  left -> 3, right -> 4
node(28,2,20,5).
left_node(28,2,3).
right_node(28,2,4).
% node 3 (leaf): class B (0)
leaf_class(28,3,0).
% node 4 (leaf): class B (0)
leaf_class(28,4,0).
% node 5: f14 <= 0.009690999984741211  (F14, bin <= 2)  left -> 6, right -> 7
node(28,5,14,2).
left_node(28,5,6).
right_node(28,5,7).
% node 6 (leaf): class M (1)
leaf_class(28,6,1).
% node 7 (leaf): class B (0)
leaf_class(28,7,0).
% node 8: f29 <= 0.07479000091552734  (F29, bin <= 5)  left -> 9, right -> 12
node(28,8,29,5).
left_node(28,8,9).
right_node(28,8,12).
% node 9: f0 <= 17.09500026702881  (F0, bin <= 15)  left -> 10, right -> 11
node(28,9,0,15).
left_node(28,9,10).
right_node(28,9,11).
% node 10 (leaf): class B (0)
leaf_class(28,10,0).
% node 11 (leaf): class M (1)
leaf_class(28,11,1).
% node 12 (leaf): class M (1)
leaf_class(28,12,1).

% Tree 29
tree(29).
% node 0: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 1, right -> 8
node(29,0,7,18).
left_node(29,0,1).
right_node(29,0,8).
% node 1: f23 <= 929.8000183105469  (F23, bin <= 36)  left -> 2, right -> 5
node(29,1,23,36).
left_node(29,1,2).
right_node(29,1,5).
% node 2: f7 <= 0.026804999448359013  (F7, bin <= 2)  left -> 3, right -> 4
node(29,2,7,2).
left_node(29,2,3).
right_node(29,2,4).
% node 3 (leaf): class B (0)
leaf_class(29,3,0).
% node 4 (leaf): class B (0)
leaf_class(29,4,0).
% node 5: f21 <= 19.90999984741211  (F21, bin <= 1)  left -> 6, right -> 7
node(29,5,21,1).
left_node(29,5,6).
right_node(29,5,7).
% node 6 (leaf): class B (0)
leaf_class(29,6,0).
% node 7 (leaf): class M (1)
leaf_class(29,7,1).
% node 8: f26 <= 0.22345000505447388  (F26, bin <= 11)  left -> 9, right -> 10
node(29,8,26,11).
left_node(29,8,9).
right_node(29,8,10).
% node 9 (leaf): class B (0)
leaf_class(29,9,0).
% node 10: f22 <= 112.79999923706055  (F22, bin <= 21)  left -> 11, right -> 12
node(29,10,22,21).
left_node(29,10,11).
right_node(29,10,12).
% node 11 (leaf): class M (1)
leaf_class(29,11,1).
% node 12 (leaf): class M (1)
leaf_class(29,12,1).

% Tree 30
tree(30).
% node 0: f12 <= 3.4375  (F12, bin <= 2)  left -> 1, right -> 8
node(30,0,12,2).
left_node(30,0,1).
right_node(30,0,8).
% node 1: f22 <= 101.79999923706055  (F22, bin <= 6)  left -> 2, right -> 5
node(30,1,22,6).
left_node(30,1,2).
right_node(30,1,5).
% node 2: f26 <= 0.21335000544786453  (F26, bin <= 5)  left -> 3, right -> 4
node(30,2,26,5).
left_node(30,2,3).
right_node(30,2,4).
% node 3 (leaf): class B (0)
leaf_class(30,3,0).
% node 4 (leaf): class B (0)
leaf_class(30,4,0).
% node 5: f7 <= 0.05101499892771244  (F7, bin <= 15)  left -> 6, right -> 7
node(30,5,7,15).
left_node(30,5,6).
right_node(30,5,7).
% node 6 (leaf): class B (0)
leaf_class(30,6,0).
% node 7 (leaf): class M (1)
leaf_class(30,7,1).
% node 8: f3 <= 664.5499877929688  (F3, bin <= 7)  left -> 9, right -> 12
node(30,8,3,7).
left_node(30,8,9).
right_node(30,8,12).
% node 9: f24 <= 0.14585000276565552  (F24, bin <= 19)  left -> 10, right -> 11
node(30,9,24,19).
left_node(30,9,10).
right_node(30,9,11).
% node 10 (leaf): class B (0)
leaf_class(30,10,0).
% node 11 (leaf): class M (1)
leaf_class(30,11,1).
% node 12 (leaf): class M (1)
leaf_class(30,12,1).

% Tree 31
tree(31).
% node 0: f2 <= 91.85499954223633  (F2, bin <= 4)  left -> 1, right -> 8
node(31,0,2,4).
left_node(31,0,1).
right_node(31,0,8).
% node 1: f25 <= 0.288100004196167  (F25, bin <= 8)  left -> 2, right -> 5
node(31,1,25,8).
left_node(31,1,2).
right_node(31,1,5).
% node 2: f27 <= 0.09297999739646912  (F27, bin <= 3)  left -> 3, right -> 4
node(31,2,27,3).
left_node(31,2,3).
right_node(31,2,4).
% node 3 (leaf): class B (0)
leaf_class(31,3,0).
% node 4 (leaf): class B (0)
leaf_class(31,4,0).
% node 5: f23 <= 690.3500061035156  (F23, bin <= 3)  left -> 6, right -> 7
node(31,5,23,3).
left_node(31,5,6).
right_node(31,5,7).
% node 6 (leaf): class B (0)
leaf_class(31,6,0).
% node 7 (leaf): class M (1)
leaf_class(31,7,1).
% node 8: f27 <= 0.14589999616146088  (F27, bin <= 28)  left -> 9, right -> 12
node(31,8,27,28).
left_node(31,8,9).
right_node(31,8,12).
% node 9: f23 <= 949.8500061035156  (F23, bin <= 37)  left -> 10, right -> 11
node(31,9,23,37).
left_node(31,9,10).
right_node(31,9,11).
% node 10 (leaf): class B (0)
leaf_class(31,10,0).
% node 11 (leaf): class M (1)
leaf_class(31,11,1).
% node 12 (leaf): class M (1)
leaf_class(31,12,1).

% Tree 32
tree(32).
% node 0: f26 <= 0.2609500139951706  (F26, bin <= 16)  left -> 1, right -> 8
node(32,0,26,16).
left_node(32,0,1).
right_node(32,0,8).
% node 1: f22 <= 109.5999984741211  (F22, bin <= 17)  left -> 2, right -> 5
node(32,1,22,17).
left_node(32,1,2).
right_node(32,1,5).
% node 2: f28 <= 0.16385000199079514  (F28, bin <= 1)  left -> 3, right -> 4
node(32,2,28,1).
left_node(32,2,3).
right_node(32,2,4).
% node 3 (leaf): class M (1)
leaf_class(32,3,1).
% node 4 (leaf): class B (0)
leaf_class(32,4,0).
% node 5: f17 <= 0.013970000203698874  (F17, bin <= 0)  left -> 6, right -> 7
node(32,5,17,0).
left_node(32,5,6).
right_node(32,5,7).
% node 6 (leaf): class B (0)
leaf_class(32,6,0).
% node 7 (leaf): class M (1)
leaf_class(32,7,1).
% node 8: f23 <= 736.3999938964844  (F23, bin <= 9)  left -> 9, right -> 12
node(32,8,23,9).
left_node(32,8,9).
right_node(32,8,12).
% node 9: f1 <= 21.045000076293945  (F1, bin <= 24)  left -> 10, right -> 11
node(32,9,1,24).
left_node(32,9,10).
right_node(32,9,11).
% node 10 (leaf): class B (0)
leaf_class(32,10,0).
% node 11 (leaf): class B (0)
leaf_class(32,11,0).
% node 12: f1 <= 15.535000324249268  (F1, bin <= 2)  left -> 13, right -> 14
node(32,12,1,2).
left_node(32,12,13).
right_node(32,12,14).
% node 13 (leaf): class M (1)
leaf_class(32,13,1).
% node 14 (leaf): class M (1)
leaf_class(32,14,1).

% Tree 33
tree(33).
% node 0: f27 <= 0.14204999804496765  (F27, bin <= 23)  left -> 1, right -> 8
node(33,0,27,23).
left_node(33,0,1).
right_node(33,0,8).
% node 1: f23 <= 929.8000183105469  (F23, bin <= 36)  left -> 2, right -> 5
node(33,1,23,36).
left_node(33,1,2).
right_node(33,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(33,2,10,11).
left_node(33,2,3).
right_node(33,2,4).
% node 3 (leaf): class B (0)
leaf_class(33,3,0).
% node 4 (leaf): class M (1)
leaf_class(33,4,1).
% node 5: f13 <= 52.56999969482422  (F13, bin <= 15)  left -> 6, right -> 7
node(33,5,13,15).
left_node(33,5,6).
right_node(33,5,7).
% node 6 (leaf): class B (0)
leaf_class(33,6,0).
% node 7 (leaf): class M (1)
leaf_class(33,7,1).
% node 8: f10 <= 0.2058499976992607  (F10, bin <= 2)  left -> 9, right -> 12
node(33,8,10,2).
left_node(33,8,9).
right_node(33,8,12).
% node 9: f11 <= 0.5262499898672104  (F11, bin <= 4)  left -> 10, right -> 11
node(33,9,11,4).
left_node(33,9,10).
right_node(33,9,11).
% node 10 (leaf): class B (0)
leaf_class(33,10,0).
% node 11 (leaf): class M (1)
leaf_class(33,11,1).
% node 12: f7 <= 0.05489500053226948  (F7, bin <= 23)  left -> 13, right -> 14
node(33,12,7,23).
left_node(33,12,13).
right_node(33,12,14).
% node 13 (leaf): class M (1)
leaf_class(33,13,1).
% node 14 (leaf): class M (1)
leaf_class(33,14,1).

% Tree 34
tree(34).
% node 0: f20 <= 16.789999961853027  (F20, bin <= 15)  left -> 1, right -> 8
node(34,0,20,15).
left_node(34,0,1).
right_node(34,0,8).
% node 1: f26 <= 0.265950009226799  (F26, bin <= 19)  left -> 2, right -> 5
node(34,1,26,19).
left_node(34,1,2).
right_node(34,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(34,2,10,11).
left_node(34,2,3).
right_node(34,2,4).
% node 3 (leaf): class B (0)
leaf_class(34,3,0).
% node 4 (leaf): class B (0)
leaf_class(34,4,0).
% node 5: f24 <= 0.13050000369548798  (F24, bin <= 9)  left -> 6, right -> 7
node(34,5,24,9).
left_node(34,5,6).
right_node(34,5,7).
% node 6 (leaf): class B (0)
leaf_class(34,6,0).
% node 7 (leaf): class M (1)
leaf_class(34,7,1).
% node 8: f11 <= 0.49229998886585236  (F11, bin <= 3)  left -> 9, right -> 10
node(34,8,11,3).
left_node(34,8,9).
right_node(34,8,10).
% node 9 (leaf): class B (0)
leaf_class(34,9,0).
% node 10: f16 <= 0.018459999933838844  (F16, bin <= 2)  left -> 11, right -> 12
node(34,10,16,2).
left_node(34,10,11).
right_node(34,10,12).
% node 11 (leaf): class M (1)
leaf_class(34,11,1).
% node 12 (leaf): class M (1)
leaf_class(34,12,1).

% Tree 35
tree(35).
% node 0: f5 <= 0.11830000206828117  (F5, bin <= 9)  left -> 1, right -> 8
node(35,0,5,9).
left_node(35,0,1).
right_node(35,0,8).
% node 1: f3 <= 697.8000183105469  (F3, bin <= 14)  left -> 2, right -> 5
node(35,1,3,14).
left_node(35,1,2).
right_node(35,1,5).
% node 2: f3 <= 562.5499877929688  (F3, bin <= 3)  left -> 3, right -> 4
node(35,2,3,3).
left_node(35,2,3).
right_node(35,2,4).
% node 3 (leaf): class B (0)
leaf_class(35,3,0).
% node 4 (leaf): class B (0)
leaf_class(35,4,0).
% node 5: f11 <= 0.4192499965429306  (F11, bin <= 2)  left -> 6, right -> 7
node(35,5,11,2).
left_node(35,5,6).
right_node(35,5,7).
% node 6 (leaf): class B (0)
leaf_class(35,6,0).
% node 7 (leaf): class M (1)
leaf_class(35,7,1).
% node 8: f20 <= 17.0600004196167  (F20, bin <= 19)  left -> 9, right -> 12
node(35,8,20,19).
left_node(35,8,9).
right_node(35,8,12).
% node 9: f22 <= 90.38000106811523  (F22, bin <= 0)  left -> 10, right -> 11
node(35,9,22,0).
left_node(35,9,10).
right_node(35,9,11).
% node 10 (leaf): class B (0)
leaf_class(35,10,0).
% node 11 (leaf): class M (1)
leaf_class(35,11,1).
% node 12 (leaf): class M (1)
leaf_class(35,12,1).

% Tree 36
tree(36).
% node 0: f27 <= 0.14705000072717667  (F27, bin <= 31)  left -> 1, right -> 8
node(36,0,27,31).
left_node(36,0,1).
right_node(36,0,8).
% node 1: f13 <= 42.94999885559082  (F13, bin <= 11)  left -> 2, right -> 5
node(36,1,13,11).
left_node(36,1,2).
right_node(36,1,5).
% node 2: f22 <= 101.44999694824219  (F22, bin <= 4)  left -> 3, right -> 4
node(36,2,22,4).
left_node(36,2,3).
right_node(36,2,4).
% node 3 (leaf): class B (0)
leaf_class(36,3,0).
% node 4 (leaf): class B (0)
leaf_class(36,4,0).
% node 5: f26 <= 0.17820000648498535  (F26, bin <= 0)  left -> 6, right -> 7
node(36,5,26,0).
left_node(36,5,6).
right_node(36,5,7).
% node 6 (leaf): class M (1)
leaf_class(36,6,1).
% node 7 (leaf): class M (1)
leaf_class(36,7,1).
% node 8: f22 <= 105.1500015258789  (F22, bin <= 9)  left -> 9, right -> 12
node(36,8,22,9).
left_node(36,8,9).
right_node(36,8,12).
% node 9: f24 <= 0.1425499990582466  (F24, bin <= 16)  left -> 10, right -> 11
node(36,9,24,16).
left_node(36,9,10).
right_node(36,9,11).
% node 10 (leaf): class B (0)
leaf_class(36,10,0).
% node 11 (leaf): class M (1)
leaf_class(36,11,1).
% node 12 (leaf): class M (1)
leaf_class(36,12,1).

% Tree 37
tree(37).
% node 0: f7 <= 0.0506649985909462  (F7, bin <= 14)  left -> 1, right -> 8
node(37,0,7,14).
left_node(37,0,1).
right_node(37,0,8).
% node 1: f23 <= 844.75  (F23, bin <= 23)  left -> 2, right -> 5
node(37,1,23,23).
left_node(37,1,2).
right_node(37,1,5).
% node 2: f18 <= 0.00925099989399314  (F18, bin <= 0)  left -> 3, right -> 4
node(37,2,18,0).
left_node(37,2,3).
right_node(37,2,4).
% node 3 (leaf): class M (1)
leaf_class(37,3,1).
% node 4 (leaf): class B (0)
leaf_class(37,4,0).
% node 5: f28 <= 0.31184999644756317  (F28, bin <= 5)  left -> 6, right -> 7
node(37,5,28,5).
left_node(37,5,6).
right_node(37,5,7).
% node 6 (leaf): class B (0)
leaf_class(37,6,0).
% node 7 (leaf): class M (1)
leaf_class(37,7,1).
% node 8: f23 <= 923.9499816894531  (F23, bin <= 35)  left -> 9, right -> 12
node(37,8,23,35).
left_node(37,8,9).
right_node(37,8,12).
% node 9: f0 <= 14.62000036239624  (F0, bin <= 4)  left -> 10, right -> 11
node(37,9,0,4).
left_node(37,9,10).
right_node(37,9,11).
% node 10 (leaf): class M (1)
leaf_class(37,10,1).
% node 11 (leaf): class B (0)
leaf_class(37,11,0).
% node 12 (leaf): class M (1)
leaf_class(37,12,1).

% Tree 38
tree(38).
% node 0: f6 <= 0.07214000076055527  (F6, bin <= 5)  left -> 1, right -> 8
node(38,0,6,5).
left_node(38,0,1).
right_node(38,0,8).
% node 1: f27 <= 0.1103999987244606  (F27, bin <= 8)  left -> 2, right -> 5
node(38,1,27,8).
left_node(38,1,2).
right_node(38,1,5).
% node 2: f22 <= 127.20000076293945  (F22, bin <= 33)  left -> 3, right -> 4
node(38,2,22,33).
left_node(38,2,3).
right_node(38,2,4).
% node 3 (leaf): class B (0)
leaf_class(38,3,0).
% node 4 (leaf): class M (1)
leaf_class(38,4,1).
% node 5: f18 <= 0.015399999916553497  (F18, bin <= 5)  left -> 6, right -> 7
node(38,5,18,5).
left_node(38,5,6).
right_node(38,5,7).
% node 6 (leaf): class M (1)
leaf_class(38,6,1).
% node 7 (leaf): class B (0)
leaf_class(38,7,0).
% node 8: f22 <= 115.3499984741211  (F22, bin <= 26)  left -> 9, right -> 12
node(38,8,22,26).
left_node(38,8,9).
right_node(38,8,12).
% node 9: f27 <= 0.15630000084638596  (F27, bin <= 37)  left -> 10, right -> 11
node(38,9,27,37).
left_node(38,9,10).
right_node(38,9,11).
% node 10 (leaf): class B (0)
leaf_class(38,10,0).
% node 11 (leaf): class M (1)
leaf_class(38,11,1).
% node 12 (leaf): class M (1)
leaf_class(38,12,1).

% Tree 39
tree(39).
% node 0: f7 <= 0.05591999925673008  (F7, bin <= 25)  left -> 1, right -> 8
node(39,0,7,25).
left_node(39,0,1).
right_node(39,0,8).
% node 1: f1 <= 21.574999809265137  (F1, bin <= 26)  left -> 2, right -> 5
node(39,1,1,26).
left_node(39,1,2).
right_node(39,1,5).
% node 2: f11 <= 0.3624500036239624  (F11, bin <= 0)  left -> 3, right -> 4
node(39,2,11,0).
left_node(39,2,3).
right_node(39,2,4).
% node 3 (leaf): class B (0)
leaf_class(39,3,0).
% node 4 (leaf): class B (0)
leaf_class(39,4,0).
% node 5: f23 <= 737.1000061035156  (F23, bin <= 10)  left -> 6, right -> 7
node(39,5,23,10).
left_node(39,5,6).
right_node(39,5,7).
% node 6 (leaf): class B (0)
leaf_class(39,6,0).
% node 7 (leaf): class M (1)
leaf_class(39,7,1).
% node 8: f21 <= 23.859999656677246  (F21, bin <= 11)  left -> 9, right -> 12
node(39,8,21,11).
left_node(39,8,9).
right_node(39,8,12).
% node 9: f22 <= 117.29999923706055  (F22, bin <= 30)  left -> 10, right -> 11
node(39,9,22,30).
left_node(39,9,10).
right_node(39,9,11).
% node 10 (leaf): class B (0)
leaf_class(39,10,0).
% node 11 (leaf): class M (1)
leaf_class(39,11,1).
% node 12: f26 <= 0.22325000166893005  (F26, bin <= 10)  left -> 13, right -> 14
node(39,12,26,10).
left_node(39,12,13).
right_node(39,12,14).
% node 13 (leaf): class B (0)
leaf_class(39,13,0).
% node 14 (leaf): class M (1)
leaf_class(39,14,1).

% Tree 40
tree(40).
% node 0: f20 <= 16.795000076293945  (F20, bin <= 16)  left -> 1, right -> 8
node(40,0,20,16).
left_node(40,0,1).
right_node(40,0,8).
% node 1: f26 <= 0.4382999986410141  (F26, bin <= 26)  left -> 2, right -> 5
node(40,1,26,26).
left_node(40,1,2).
right_node(40,1,5).
% node 2: f1 <= 18.119999885559082  (F1, bin <= 13)  left -> 3, right -> 4
node(40,2,1,13).
left_node(40,2,3).
right_node(40,2,4).
% node 3 (leaf): class B (0)
leaf_class(40,3,0).
% node 4 (leaf): class B (0)
leaf_class(40,4,0).
% node 5: f23 <= 725.2999877929688  (F23, bin <= 7)  left -> 6, right -> 7
node(40,5,23,7).
left_node(40,5,6).
right_node(40,5,7).
% node 6 (leaf): class B (0)
leaf_class(40,6,0).
% node 7 (leaf): class M (1)
leaf_class(40,7,1).
% node 8: f26 <= 0.2200000062584877  (F26, bin <= 9)  left -> 9, right -> 12
node(40,8,26,9).
left_node(40,8,9).
right_node(40,8,12).
% node 9: f23 <= 1121.0  (F23, bin <= 41)  left -> 10, right -> 11
node(40,9,23,41).
left_node(40,9,10).
right_node(40,9,11).
% node 10 (leaf): class B (0)
leaf_class(40,10,0).
% node 11 (leaf): class M (1)
leaf_class(40,11,1).
% node 12: f13 <= 24.875  (F13, bin <= 3)  left -> 13, right -> 14
node(40,12,13,3).
left_node(40,12,13).
right_node(40,12,14).
% node 13 (leaf): class M (1)
leaf_class(40,13,1).
% node 14 (leaf): class M (1)
leaf_class(40,14,1).

% Tree 41
tree(41).
% node 0: f6 <= 0.0692249983549118  (F6, bin <= 4)  left -> 1, right -> 6
node(41,0,6,4).
left_node(41,0,1).
right_node(41,0,6).
% node 1: f27 <= 0.06561500206589699  (F27, bin <= 0)  left -> 2, right -> 3
node(41,1,27,0).
left_node(41,1,2).
right_node(41,1,3).
% node 2 (leaf): class B (0)
leaf_class(41,2,0).
% node 3: f1 <= 18.039999961853027  (F1, bin <= 11)  left -> 4, right -> 5
node(41,3,1,11).
left_node(41,3,4).
right_node(41,3,5).
% node 4 (leaf): class B (0)
leaf_class(41,4,0).
% node 5 (leaf): class B (0)
leaf_class(41,5,0).
% node 6: f0 <= 15.739999771118164  (F0, bin <= 14)  left -> 7, right -> 10
node(41,6,0,14).
left_node(41,6,7).
right_node(41,6,10).
% node 7: f22 <= 101.39999771118164  (F22, bin <= 3)  left -> 8, right -> 9
node(41,7,22,3).
left_node(41,7,8).
right_node(41,7,9).
% node 8 (leaf): class B (0)
leaf_class(41,8,0).
% node 9 (leaf): class M (1)
leaf_class(41,9,1).
% node 10 (leaf): class M (1)
leaf_class(41,10,1).

% Tree 42
tree(42).
% node 0: f3 <= 696.25  (F3, bin <= 12)  left -> 1, right -> 8
node(42,0,3,12).
left_node(42,0,1).
right_node(42,0,8).
% node 1: f7 <= 0.0559299997985363  (F7, bin <= 26)  left -> 2, right -> 5
node(42,1,7,26).
left_node(42,1,2).
right_node(42,1,5).
% node 2: f6 <= 0.030779999680817127  (F6, bin <= 0)  left -> 3, right -> 4
node(42,2,6,0).
left_node(42,2,3).
right_node(42,2,4).
% node 3 (leaf): class B (0)
leaf_class(42,3,0).
% node 4 (leaf): class B (0)
leaf_class(42,4,0).
% node 5: f26 <= 0.29794999957084656  (F26, bin <= 20)  left -> 6, right -> 7
node(42,5,26,20).
left_node(42,5,6).
right_node(42,5,7).
% node 6 (leaf): class B (0)
leaf_class(42,6,0).
% node 7 (leaf): class M (1)
leaf_class(42,7,1).
% node 8: f16 <= 0.019949999637901783  (F16, bin <= 3)  left -> 9, right -> 12
node(42,8,16,3).
left_node(42,8,9).
right_node(42,8,12).
% node 9: f1 <= 18.4350004196167  (F1, bin <= 14)  left -> 10, right -> 11
node(42,9,1,14).
left_node(42,9,10).
right_node(42,9,11).
% node 10 (leaf): class B (0)
leaf_class(42,10,0).
% node 11 (leaf): class M (1)
leaf_class(42,11,1).
% node 12 (leaf): class M (1)
leaf_class(42,12,1).

% Tree 43
tree(43).
% node 0: f22 <= 101.54999923706055  (F22, bin <= 5)  left -> 1, right -> 6
node(43,0,22,5).
left_node(43,0,1).
right_node(43,0,6).
% node 1: f27 <= 0.18074999749660492  (F27, bin <= 42)  left -> 2, right -> 5
node(43,1,27,42).
left_node(43,1,2).
right_node(43,1,5).
% node 2: f10 <= 0.5915499925613403  (F10, bin <= 10)  left -> 3, right -> 4
node(43,2,10,10).
left_node(43,2,3).
right_node(43,2,4).
% node 3 (leaf): class B (0)
leaf_class(43,3,0).
% node 4 (leaf): class B (0)
leaf_class(43,4,0).
% node 5 (leaf): class M (1)
leaf_class(43,5,1).
% node 6: f7 <= 0.0506649985909462  (F7, bin <= 14)  left -> 7, right -> 10
node(43,6,7,14).
left_node(43,6,7).
right_node(43,6,10).
% node 7: f21 <= 26.489999771118164  (F21, bin <= 15)  left -> 8, right -> 9
node(43,7,21,15).
left_node(43,7,8).
right_node(43,7,9).
% node 8 (leaf): class B (0)
leaf_class(43,8,0).
% node 9 (leaf): class M (1)
leaf_class(43,9,1).
% node 10: f21 <= 20.28499984741211  (F21, bin <= 2)  left -> 11, right -> 12
node(43,10,21,2).
left_node(43,10,11).
right_node(43,10,12).
% node 11 (leaf): class M (1)
leaf_class(43,11,1).
% node 12 (leaf): class M (1)
leaf_class(43,12,1).

% Tree 44
tree(44).
% node 0: f22 <= 105.95000076293945  (F22, bin <= 11)  left -> 1, right -> 8
node(44,0,22,11).
left_node(44,0,1).
right_node(44,0,8).
% node 1: f27 <= 0.13505000621080399  (F27, bin <= 16)  left -> 2, right -> 5
node(44,1,27,16).
left_node(44,1,2).
right_node(44,1,5).
% node 2: f11 <= 2.0859999656677246  (F11, bin <= 6)  left -> 3, right -> 4
node(44,2,11,6).
left_node(44,2,3).
right_node(44,2,4).
% node 3 (leaf): class B (0)
leaf_class(44,3,0).
% node 4 (leaf): class B (0)
leaf_class(44,4,0).
% node 5: f27 <= 0.16125000268220901  (F27, bin <= 40)  left -> 6, right -> 7
node(44,5,27,40).
left_node(44,5,6).
right_node(44,5,7).
% node 6 (leaf): class B (0)
leaf_class(44,6,0).
% node 7 (leaf): class M (1)
leaf_class(44,7,1).
% node 8: f13 <= 51.64500045776367  (F13, bin <= 14)  left -> 9, right -> 12
node(44,8,13,14).
left_node(44,8,9).
right_node(44,8,12).
% node 9: f27 <= 0.15049999952316284  (F27, bin <= 34)  left -> 10, right -> 11
node(44,9,27,34).
left_node(44,9,10).
right_node(44,9,11).
% node 10 (leaf): class B (0)
leaf_class(44,10,0).
% node 11 (leaf): class M (1)
leaf_class(44,11,1).
% node 12 (leaf): class M (1)
leaf_class(44,12,1).

% Tree 45
tree(45).
% node 0: f26 <= 0.26010000705718994  (F26, bin <= 14)  left -> 1, right -> 6
node(45,0,26,14).
left_node(45,0,1).
right_node(45,0,6).
% node 1: f13 <= 61.05500030517578  (F13, bin <= 16)  left -> 2, right -> 5
node(45,1,13,16).
left_node(45,1,2).
right_node(45,1,5).
% node 2: f9 <= 0.05590000003576279  (F9, bin <= 1)  left -> 3, right -> 4
node(45,2,9,1).
left_node(45,2,3).
right_node(45,2,4).
% node 3 (leaf): class B (0)
leaf_class(45,3,0).
% node 4 (leaf): class B (0)
leaf_class(45,4,0).
% node 5 (leaf): class M (1)
leaf_class(45,5,1).
% node 6: f3 <= 657.9499816894531  (F3, bin <= 5)  left -> 7, right -> 10
node(45,6,3,5).
left_node(45,6,7).
right_node(45,6,10).
% node 7: f25 <= 0.367249995470047  (F25, bin <= 10)  left -> 8, right -> 9
node(45,7,25,10).
left_node(45,7,8).
right_node(45,7,9).
% node 8 (leaf): class B (0)
leaf_class(45,8,0).
% node 9 (leaf): class M (1)
leaf_class(45,9,1).
% node 10 (leaf): class M (1)
leaf_class(45,10,1).

% Tree 46
tree(46).
% node 0: f10 <= 0.38944999873638153  (F10, bin <= 6)  left -> 1, right -> 8
node(46,0,10,6).
left_node(46,0,1).
right_node(46,0,8).
% node 1: f22 <= 101.95000076293945  (F22, bin <= 7)  left -> 2, right -> 5
node(46,1,22,7).
left_node(46,1,2).
right_node(46,1,5).
% node 2: f7 <= 0.05636000074446201  (F7, bin <= 27)  left -> 3, right -> 4
node(46,2,7,27).
left_node(46,2,3).
right_node(46,2,4).
% node 3 (leaf): class B (0)
leaf_class(46,3,0).
% node 4 (leaf): class B (0)
leaf_class(46,4,0).
% node 5: f4 <= 0.10065000131726265  (F4, bin <= 9)  left -> 6, right -> 7
node(46,5,4,9).
left_node(46,5,6).
right_node(46,5,7).
% node 6 (leaf): class B (0)
leaf_class(46,6,0).
% node 7 (leaf): class M (1)
leaf_class(46,7,1).
% node 8: f22 <= 111.20000076293945  (F22, bin <= 19)  left -> 9, right -> 12
node(46,8,22,19).
left_node(46,8,9).
right_node(46,8,12).
% node 9: f28 <= 0.3232000023126602  (F28, bin <= 9)  left -> 10, right -> 11
node(46,9,28,9).
left_node(46,9,10).
right_node(46,9,11).
% node 10 (leaf): class B (0)
leaf_class(46,10,0).
% node 11 (leaf): class M (1)
leaf_class(46,11,1).
% node 12: f19 <= 0.001548500033095479  (F19, bin <= 2)  left -> 13, right -> 14
node(46,12,19,2).
left_node(46,12,13).
right_node(46,12,14).
% node 13 (leaf): class B (0)
leaf_class(46,13,0).
% node 14 (leaf): class M (1)
leaf_class(46,14,1).

% Tree 47
tree(47).
% node 0: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 1, right -> 8
node(47,0,23,27).
left_node(47,0,1).
right_node(47,0,8).
% node 1: f26 <= 0.369499996304512  (F26, bin <= 23)  left -> 2, right -> 5
node(47,1,26,23).
left_node(47,1,2).
right_node(47,1,5).
% node 2: f7 <= 0.026804999448359013  (F7, bin <= 2)  left -> 3, right -> 4
node(47,2,7,2).
left_node(47,2,3).
right_node(47,2,4).
% node 3 (leaf): class B (0)
leaf_class(47,3,0).
% node 4 (leaf): class B (0)
leaf_class(47,4,0).
% node 5: f5 <= 0.1679999977350235  (F5, bin <= 10)  left -> 6, right -> 7
node(47,5,5,10).
left_node(47,5,6).
right_node(47,5,7).
% node 6 (leaf): class B (0)
leaf_class(47,6,0).
% node 7 (leaf): class M (1)
leaf_class(47,7,1).
% node 8: f28 <= 0.27365000545978546  (F28, bin <= 2)  left -> 9, right -> 12
node(47,8,28,2).
left_node(47,8,9).
right_node(47,8,12).
% node 9: f22 <= 127.64999771118164  (F22, bin <= 34)  left -> 10, right -> 11
node(47,9,22,34).
left_node(47,9,10).
right_node(47,9,11).
% node 10 (leaf): class B (0)
leaf_class(47,10,0).
% node 11 (leaf): class M (1)
leaf_class(47,11,1).
% node 12 (leaf): class M (1)
leaf_class(47,12,1).

% Tree 48
tree(48).
% node 0: f27 <= 0.14159999787807465  (F27, bin <= 20)  left -> 1, right -> 8
node(48,0,27,20).
left_node(48,0,1).
right_node(48,0,8).
% node 1: f27 <= 0.10954999923706055  (F27, bin <= 7)  left -> 2, right -> 5
node(48,1,27,7).
left_node(48,1,2).
right_node(48,1,5).
% node 2: f2 <= 98.91999816894531  (F2, bin <= 12)  left -> 3, right -> 4
node(48,2,2,12).
left_node(48,2,3).
right_node(48,2,4).
% node 3 (leaf): class B (0)
leaf_class(48,3,0).
% node 4 (leaf): class M (1)
leaf_class(48,4,1).
% node 5: f1 <= 16.610000610351562  (F1, bin <= 8)  left -> 6, right -> 7
node(48,5,1,8).
left_node(48,5,6).
right_node(48,5,7).
% node 6 (leaf): class B (0)
leaf_class(48,6,0).
% node 7 (leaf): class M (1)
leaf_class(48,7,1).
% node 8: f0 <= 15.220000267028809  (F0, bin <= 11)  left -> 9, right -> 12
node(48,8,0,11).
left_node(48,8,9).
right_node(48,8,12).
% node 9: f21 <= 23.739999771118164  (F21, bin <= 10)  left -> 10, right -> 11
node(48,9,21,10).
left_node(48,9,10).
right_node(48,9,11).
% node 10 (leaf): class B (0)
leaf_class(48,10,0).
% node 11 (leaf): class M (1)
leaf_class(48,11,1).
% node 12 (leaf): class M (1)
leaf_class(48,12,1).

% Tree 49
tree(49).
% node 0: f6 <= 0.09649999812245369  (F6, bin <= 12)  left -> 1, right -> 8
node(49,0,6,12).
left_node(49,0,1).
right_node(49,0,8).
% node 1: f21 <= 26.15499973297119  (F21, bin <= 14)  left -> 2, right -> 5
node(49,1,21,14).
left_node(49,1,2).
right_node(49,1,5).
% node 2: f20 <= 17.739999771118164  (F20, bin <= 24)  left -> 3, right -> 4
node(49,2,20,24).
left_node(49,2,3).
right_node(49,2,4).
% node 3 (leaf): class B (0)
leaf_class(49,3,0).
% node 4 (leaf): class B (0)
leaf_class(49,4,0).
% node 5: f11 <= 1.112500011920929  (F11, bin <= 5)  left -> 6, right -> 7
node(49,5,11,5).
left_node(49,5,6).
right_node(49,5,7).
% node 6 (leaf): class M (1)
leaf_class(49,6,1).
% node 7 (leaf): class B (0)
leaf_class(49,7,0).
% node 8: f7 <= 0.043335000053048134  (F7, bin <= 5)  left -> 9, right -> 10
node(49,8,7,5).
left_node(49,8,9).
right_node(49,8,10).
% node 9 (leaf): class B (0)
leaf_class(49,9,0).
% node 10: f23 <= 807.4499816894531  (F23, bin <= 18)  left -> 11, right -> 12
node(49,10,23,18).
left_node(49,10,11).
right_node(49,10,12).
% node 11 (leaf): class M (1)
leaf_class(49,11,1).
% node 12 (leaf): class M (1)
leaf_class(49,12,1).

% Tree 50
tree(50).
% node 0: f20 <= 16.795000076293945  (F20, bin <= 16)  left -> 1, right -> 8
node(50,0,20,16).
left_node(50,0,1).
right_node(50,0,8).
% node 1: f25 <= 0.39010000228881836  (F25, bin <= 12)  left -> 2, right -> 5
node(50,1,25,12).
left_node(50,1,2).
right_node(50,1,5).
% node 2: f0 <= 12.765000343322754  (F0, bin <= 1)  left -> 3, right -> 4
node(50,2,0,1).
left_node(50,2,3).
right_node(50,2,4).
% node 3 (leaf): class B (0)
leaf_class(50,3,0).
% node 4 (leaf): class B (0)
leaf_class(50,4,0).
% node 5: f4 <= 0.09559499844908714  (F4, bin <= 7)  left -> 6, right -> 7
node(50,5,4,7).
left_node(50,5,6).
right_node(50,5,7).
% node 6 (leaf): class B (0)
leaf_class(50,6,0).
% node 7 (leaf): class M (1)
leaf_class(50,7,1).
% node 8: f21 <= 19.90999984741211  (F21, bin <= 1)  left -> 9, right -> 12
node(50,8,21,1).
left_node(50,8,9).
right_node(50,8,12).
% node 9: f6 <= 0.11919999867677689  (F6, bin <= 18)  left -> 10, right -> 11
node(50,9,6,18).
left_node(50,9,10).
right_node(50,9,11).
% node 10 (leaf): class B (0)
leaf_class(50,10,0).
% node 11 (leaf): class M (1)
leaf_class(50,11,1).
% node 12 (leaf): class M (1)
leaf_class(50,12,1).

% Tree 51
tree(51).
% node 0: f22 <= 108.3499984741211  (F22, bin <= 14)  left -> 1, right -> 8
node(51,0,22,14).
left_node(51,0,1).
right_node(51,0,8).
% node 1: f6 <= 0.09815499931573868  (F6, bin <= 14)  left -> 2, right -> 5
node(51,1,6,14).
left_node(51,1,2).
right_node(51,1,5).
% node 2: f7 <= 0.05261499993503094  (F7, bin <= 20)  left -> 3, right -> 4
node(51,2,7,20).
left_node(51,2,3).
right_node(51,2,4).
% node 3 (leaf): class B (0)
leaf_class(51,3,0).
% node 4 (leaf): class B (0)
leaf_class(51,4,0).
% node 5: f4 <= 0.09136499837040901  (F4, bin <= 3)  left -> 6, right -> 7
node(51,5,4,3).
left_node(51,5,6).
right_node(51,5,7).
% node 6 (leaf): class B (0)
leaf_class(51,6,0).
% node 7 (leaf): class M (1)
leaf_class(51,7,1).
% node 8: f20 <= 19.835000038146973  (F20, bin <= 26)  left -> 9, right -> 12
node(51,8,20,26).
left_node(51,8,9).
right_node(51,8,12).
% node 9: f24 <= 0.1359499990940094  (F24, bin <= 10)  left -> 10, right -> 11
node(51,9,24,10).
left_node(51,9,10).
right_node(51,9,11).
% node 10 (leaf): class M (1)
leaf_class(51,10,1).
% node 11 (leaf): class M (1)
leaf_class(51,11,1).
% node 12 (leaf): class M (1)
leaf_class(51,12,1).

% Tree 52
tree(52).
% node 0: f27 <= 0.1465499997138977  (F27, bin <= 30)  left -> 1, right -> 8
node(52,0,27,30).
left_node(52,0,1).
right_node(52,0,8).
% node 1: f23 <= 754.1000061035156  (F23, bin <= 13)  left -> 2, right -> 5
node(52,1,23,13).
left_node(52,1,2).
right_node(52,1,5).
% node 2: f15 <= 0.010199999902397394  (F15, bin <= 0)  left -> 3, right -> 4
node(52,2,15,0).
left_node(52,2,3).
right_node(52,2,4).
% node 3 (leaf): class B (0)
leaf_class(52,3,0).
% node 4 (leaf): class B (0)
leaf_class(52,4,0).
% node 5: f2 <= 107.45000076293945  (F2, bin <= 16)  left -> 6, right -> 7
node(52,5,2,16).
left_node(52,5,6).
right_node(52,5,7).
% node 6 (leaf): class B (0)
leaf_class(52,6,0).
% node 7 (leaf): class M (1)
leaf_class(52,7,1).
% node 8: f19 <= 0.012910000048577785  (F19, bin <= 9)  left -> 9, right -> 12
node(52,8,19,9).
left_node(52,8,9).
right_node(52,8,12).
% node 9: f7 <= 0.050005000084638596  (F7, bin <= 11)  left -> 10, right -> 11
node(52,9,7,11).
left_node(52,9,10).
right_node(52,9,11).
% node 10 (leaf): class B (0)
leaf_class(52,10,0).
% node 11 (leaf): class M (1)
leaf_class(52,11,1).
% node 12 (leaf): class B (0)
leaf_class(52,12,0).

% Tree 53
tree(53).
% node 0: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 1, right -> 8
node(53,0,23,27).
left_node(53,0,1).
right_node(53,0,8).
% node 1: f6 <= 0.08240500092506409  (F6, bin <= 8)  left -> 2, right -> 5
node(53,1,6,8).
left_node(53,1,2).
right_node(53,1,5).
% node 2: f23 <= 782.7000122070312  (F23, bin <= 16)  left -> 3, right -> 4
node(53,2,23,16).
left_node(53,2,3).
right_node(53,2,4).
% node 3 (leaf): class B (0)
leaf_class(53,3,0).
% node 4 (leaf): class B (0)
leaf_class(53,4,0).
% node 5: f7 <= 0.05048999935388565  (F7, bin <= 13)  left -> 6, right -> 7
node(53,5,7,13).
left_node(53,5,6).
right_node(53,5,7).
% node 6 (leaf): class B (0)
leaf_class(53,6,0).
% node 7 (leaf): class M (1)
leaf_class(53,7,1).
% node 8: f6 <= 0.06420999951660633  (F6, bin <= 1)  left -> 9, right -> 12
node(53,8,6,1).
left_node(53,8,9).
right_node(53,8,12).
% node 9: f21 <= 27.660000801086426  (F21, bin <= 20)  left -> 10, right -> 11
node(53,9,21,20).
left_node(53,9,10).
right_node(53,9,11).
% node 10 (leaf): class B (0)
leaf_class(53,10,0).
% node 11 (leaf): class M (1)
leaf_class(53,11,1).
% node 12 (leaf): class M (1)
leaf_class(53,12,1).

% Tree 54
tree(54).
% node 0: f0 <= 14.980000019073486  (F0, bin <= 6)  left -> 1, right -> 8
node(54,0,0,6).
left_node(54,0,1).
right_node(54,0,8).
% node 1: f27 <= 0.13580000400543213  (F27, bin <= 17)  left -> 2, right -> 5
node(54,1,27,17).
left_node(54,1,2).
right_node(54,1,5).
% node 2: f20 <= 17.579999923706055  (F20, bin <= 23)  left -> 3, right -> 4
node(54,2,20,23).
left_node(54,2,3).
right_node(54,2,4).
% node 3 (leaf): class B (0)
leaf_class(54,3,0).
% node 4 (leaf): class M (1)
leaf_class(54,4,1).
% node 5: f24 <= 0.13030000030994415  (F24, bin <= 8)  left -> 6, right -> 7
node(54,5,24,8).
left_node(54,5,6).
right_node(54,5,7).
% node 6 (leaf): class B (0)
leaf_class(54,6,0).
% node 7 (leaf): class M (1)
leaf_class(54,7,1).
% node 8: f22 <= 127.20000076293945  (F22, bin <= 33)  left -> 9, right -> 12
node(54,8,22,33).
left_node(54,8,9).
right_node(54,8,12).
% node 9: f19 <= 0.0016870000399649143  (F19, bin <= 3)  left -> 10, right -> 11
node(54,9,19,3).
left_node(54,9,10).
right_node(54,9,11).
% node 10 (leaf): class B (0)
leaf_class(54,10,0).
% node 11 (leaf): class M (1)
leaf_class(54,11,1).
% node 12 (leaf): class M (1)
leaf_class(54,12,1).

% Tree 55
tree(55).
% node 0: f2 <= 98.23999786376953  (F2, bin <= 9)  left -> 1, right -> 8
node(55,0,2,9).
left_node(55,0,1).
right_node(55,0,8).
% node 1: f27 <= 0.14559999853372574  (F27, bin <= 27)  left -> 2, right -> 5
node(55,1,27,27).
left_node(55,1,2).
right_node(55,1,5).
% node 2: f18 <= 0.014655000064522028  (F18, bin <= 4)  left -> 3, right -> 4
node(55,2,18,4).
left_node(55,2,3).
right_node(55,2,4).
% node 3 (leaf): class B (0)
leaf_class(55,3,0).
% node 4 (leaf): class B (0)
leaf_class(55,4,0).
% node 5: f20 <= 14.650000095367432  (F20, bin <= 3)  left -> 6, right -> 7
node(55,5,20,3).
left_node(55,5,6).
right_node(55,5,7).
% node 6 (leaf): class B (0)
leaf_class(55,6,0).
% node 7 (leaf): class M (1)
leaf_class(55,7,1).
% node 8: f13 <= 17.22000026702881  (F13, bin <= 0)  left -> 9, right -> 10
node(55,8,13,0).
left_node(55,8,9).
right_node(55,8,10).
% node 9 (leaf): class B (0)
leaf_class(55,9,0).
% node 10: f24 <= 0.0879799984395504  (F24, bin <= 0)  left -> 11, right -> 12
node(55,10,24,0).
left_node(55,10,11).
right_node(55,10,12).
% node 11 (leaf): class B (0)
leaf_class(55,11,0).
% node 12 (leaf): class M (1)
leaf_class(55,12,1).

% Tree 56
tree(56).
% node 0: f27 <= 0.14239999651908875  (F27, bin <= 25)  left -> 1, right -> 8
node(56,0,27,25).
left_node(56,0,1).
right_node(56,0,8).
% node 1: f1 <= 18.690000534057617  (F1, bin <= 16)  left -> 2, right -> 5
node(56,1,1,16).
left_node(56,1,2).
right_node(56,1,5).
% node 2: f29 <= 0.09693000093102455  (F29, bin <= 8)  left -> 3, right -> 4
node(56,2,29,8).
left_node(56,2,3).
right_node(56,2,4).
% node 3 (leaf): class B (0)
leaf_class(56,3,0).
% node 4 (leaf): class B (0)
leaf_class(56,4,0).
% node 5: f27 <= 0.1088000014424324  (F27, bin <= 6)  left -> 6, right -> 7
node(56,5,27,6).
left_node(56,5,6).
right_node(56,5,7).
% node 6 (leaf): class B (0)
leaf_class(56,6,0).
% node 7 (leaf): class M (1)
leaf_class(56,7,1).
% node 8: f16 <= 0.26190000027418137  (F16, bin <= 7)  left -> 9, right -> 12
node(56,8,16,7).
left_node(56,8,9).
right_node(56,8,12).
% node 9: f10 <= 0.29314999282360077  (F10, bin <= 5)  left -> 10, right -> 11
node(56,9,10,5).
left_node(56,9,10).
right_node(56,9,11).
% node 10 (leaf): class M (1)
leaf_class(56,10,1).
% node 11 (leaf): class M (1)
leaf_class(56,11,1).
% node 12 (leaf): class B (0)
leaf_class(56,12,0).

% Tree 57
tree(57).
% node 0: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 1, right -> 8
node(57,0,7,18).
left_node(57,0,1).
right_node(57,0,8).
% node 1: f13 <= 29.875  (F13, bin <= 5)  left -> 2, right -> 5
node(57,1,13,5).
left_node(57,1,2).
right_node(57,1,5).
% node 2: f22 <= 113.6500015258789  (F22, bin <= 23)  left -> 3, right -> 4
node(57,2,22,23).
left_node(57,2,3).
right_node(57,2,4).
% node 3 (leaf): class B (0)
leaf_class(57,3,0).
% node 4 (leaf): class B (0)
leaf_class(57,4,0).
% node 5: f1 <= 21.71500015258789  (F1, bin <= 27)  left -> 6, right -> 7
node(57,5,1,27).
left_node(57,5,6).
right_node(57,5,7).
% node 6 (leaf): class B (0)
leaf_class(57,6,0).
% node 7 (leaf): class M (1)
leaf_class(57,7,1).
% node 8: f27 <= 0.15074999630451202  (F27, bin <= 35)  left -> 9, right -> 12
node(57,8,27,35).
left_node(57,8,9).
right_node(57,8,12).
% node 9: f25 <= 0.2399500012397766  (F25, bin <= 5)  left -> 10, right -> 11
node(57,9,25,5).
left_node(57,9,10).
right_node(57,9,11).
% node 10 (leaf): class M (1)
leaf_class(57,10,1).
% node 11 (leaf): class B (0)
leaf_class(57,11,0).
% node 12 (leaf): class M (1)
leaf_class(57,12,1).

% Tree 58
tree(58).
% node 0: f27 <= 0.13164999336004257  (F27, bin <= 13)  left -> 1, right -> 8
node(58,0,27,13).
left_node(58,0,1).
right_node(58,0,8).
% node 1: f1 <= 18.899999618530273  (F1, bin <= 18)  left -> 2, right -> 5
node(58,1,1,18).
left_node(58,1,2).
right_node(58,1,5).
% node 2: f20 <= 17.739999771118164  (F20, bin <= 24)  left -> 3, right -> 4
node(58,2,20,24).
left_node(58,2,3).
right_node(58,2,4).
% node 3 (leaf): class B (0)
leaf_class(58,3,0).
% node 4 (leaf): class B (0)
leaf_class(58,4,0).
% node 5: f3 <= 696.25  (F3, bin <= 12)  left -> 6, right -> 7
node(58,5,3,12).
left_node(58,5,6).
right_node(58,5,7).
% node 6 (leaf): class B (0)
leaf_class(58,6,0).
% node 7 (leaf): class M (1)
leaf_class(58,7,1).
% node 8: f2 <= 102.85000228881836  (F2, bin <= 14)  left -> 9, right -> 12
node(58,8,2,14).
left_node(58,8,9).
right_node(58,8,12).
% node 9: f15 <= 0.04014999978244305  (F15, bin <= 3)  left -> 10, right -> 11
node(58,9,15,3).
left_node(58,9,10).
right_node(58,9,11).
% node 10 (leaf): class M (1)
leaf_class(58,10,1).
% node 11 (leaf): class B (0)
leaf_class(58,11,0).
% node 12 (leaf): class M (1)
leaf_class(58,12,1).

% Tree 59
tree(59).
% node 0: f6 <= 0.09727999940514565  (F6, bin <= 13)  left -> 1, right -> 8
node(59,0,6,13).
left_node(59,0,1).
right_node(59,0,8).
% node 1: f13 <= 41.415000915527344  (F13, bin <= 10)  left -> 2, right -> 5
node(59,1,13,10).
left_node(59,1,2).
right_node(59,1,5).
% node 2: f22 <= 102.4000015258789  (F22, bin <= 8)  left -> 3, right -> 4
node(59,2,22,8).
left_node(59,2,3).
right_node(59,2,4).
% node 3 (leaf): class B (0)
leaf_class(59,3,0).
% node 4 (leaf): class B (0)
leaf_class(59,4,0).
% node 5: f29 <= 0.06068499945104122  (F29, bin <= 2)  left -> 6, right -> 7
node(59,5,29,2).
left_node(59,5,6).
right_node(59,5,7).
% node 6 (leaf): class B (0)
leaf_class(59,6,0).
% node 7 (leaf): class M (1)
leaf_class(59,7,1).
% node 8: f20 <= 16.210000038146973  (F20, bin <= 13)  left -> 9, right -> 12
node(59,8,20,13).
left_node(59,8,9).
right_node(59,8,12).
% node 9: f4 <= 0.0976099967956543  (F4, bin <= 8)  left -> 10, right -> 11
node(59,9,4,8).
left_node(59,9,10).
right_node(59,9,11).
% node 10 (leaf): class B (0)
leaf_class(59,10,0).
% node 11 (leaf): class M (1)
leaf_class(59,11,1).
% node 12 (leaf): class M (1)
leaf_class(59,12,1).

% Tree 60
tree(60).
% node 0: f0 <= 15.025000095367432  (F0, bin <= 8)  left -> 1, right -> 8
node(60,0,0,8).
left_node(60,0,1).
right_node(60,0,8).
% node 1: f26 <= 0.2624000012874603  (F26, bin <= 17)  left -> 2, right -> 5
node(60,1,26,17).
left_node(60,1,2).
right_node(60,1,5).
% node 2: f11 <= 2.0920000076293945  (F11, bin <= 7)  left -> 3, right -> 4
node(60,2,11,7).
left_node(60,2,3).
right_node(60,2,4).
% node 3 (leaf): class B (0)
leaf_class(60,3,0).
% node 4 (leaf): class B (0)
leaf_class(60,4,0).
% node 5: f27 <= 0.1419999971985817  (F27, bin <= 22)  left -> 6, right -> 7
node(60,5,27,22).
left_node(60,5,6).
right_node(60,5,7).
% node 6 (leaf): class B (0)
leaf_class(60,6,0).
% node 7 (leaf): class M (1)
leaf_class(60,7,1).
% node 8: f22 <= 120.35000228881836  (F22, bin <= 32)  left -> 9, right -> 12
node(60,8,22,32).
left_node(60,8,9).
right_node(60,8,12).
% node 9: f18 <= 0.020194999873638153  (F18, bin <= 6)  left -> 10, right -> 11
node(60,9,18,6).
left_node(60,9,10).
right_node(60,9,11).
% node 10 (leaf): class B (0)
leaf_class(60,10,0).
% node 11 (leaf): class M (1)
leaf_class(60,11,1).
% node 12: f24 <= 0.09975999966263771  (F24, bin <= 4)  left -> 13, right -> 14
node(60,12,24,4).
left_node(60,12,13).
right_node(60,12,14).
% node 13 (leaf): class B (0)
leaf_class(60,13,0).
% node 14 (leaf): class M (1)
leaf_class(60,14,1).

% Tree 61
tree(61).
% node 0: f3 <= 696.9500122070312  (F3, bin <= 13)  left -> 1, right -> 8
node(61,0,3,13).
left_node(61,0,1).
right_node(61,0,8).
% node 1: f27 <= 0.1423499956727028  (F27, bin <= 24)  left -> 2, right -> 5
node(61,1,27,24).
left_node(61,1,2).
right_node(61,1,5).
% node 2: f13 <= 42.94999885559082  (F13, bin <= 11)  left -> 3, right -> 4
node(61,2,13,11).
left_node(61,2,3).
right_node(61,2,4).
% node 3 (leaf): class B (0)
leaf_class(61,3,0).
% node 4 (leaf): class B (0)
leaf_class(61,4,0).
% node 5: f4 <= 0.09227500110864639  (F4, bin <= 4)  left -> 6, right -> 7
node(61,5,4,4).
left_node(61,5,6).
right_node(61,5,7).
% node 6 (leaf): class B (0)
leaf_class(61,6,0).
% node 7 (leaf): class M (1)
leaf_class(61,7,1).
% node 8: f6 <= 0.07214000076055527  (F6, bin <= 5)  left -> 9, right -> 12
node(61,8,6,5).
left_node(61,8,9).
right_node(61,8,12).
% node 9: f4 <= 0.09241499751806259  (F4, bin <= 5)  left -> 10, right -> 11
node(61,9,4,5).
left_node(61,9,10).
right_node(61,9,11).
% node 10 (leaf): class M (1)
leaf_class(61,10,1).
% node 11 (leaf): class B (0)
leaf_class(61,11,0).
% node 12: f18 <= 0.011759999673813581  (F18, bin <= 2)  left -> 13, right -> 14
node(61,12,18,2).
left_node(61,12,13).
right_node(61,12,14).
% node 13 (leaf): class M (1)
leaf_class(61,13,1).
% node 14 (leaf): class M (1)
leaf_class(61,14,1).

% Tree 62
tree(62).
% node 0: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 1, right -> 8
node(62,0,7,18).
left_node(62,0,1).
right_node(62,0,8).
% node 1: f19 <= 0.0018869999912567437  (F19, bin <= 4)  left -> 2, right -> 5
node(62,1,19,4).
left_node(62,1,2).
right_node(62,1,5).
% node 2: f25 <= 0.1782499998807907  (F25, bin <= 2)  left -> 3, right -> 4
node(62,2,25,2).
left_node(62,2,3).
right_node(62,2,4).
% node 3 (leaf): class B (0)
leaf_class(62,3,0).
% node 4 (leaf): class M (1)
leaf_class(62,4,1).
% node 5: f23 <= 893.6499938964844  (F23, bin <= 33)  left -> 6, right -> 7
node(62,5,23,33).
left_node(62,5,6).
right_node(62,5,7).
% node 6 (leaf): class B (0)
leaf_class(62,6,0).
% node 7 (leaf): class B (0)
leaf_class(62,7,0).
% node 8: f21 <= 25.59999942779541  (F21, bin <= 12)  left -> 9, right -> 12
node(62,8,21,12).
left_node(62,8,9).
right_node(62,8,12).
% node 9: f0 <= 15.739999771118164  (F0, bin <= 14)  left -> 10, right -> 11
node(62,9,0,14).
left_node(62,9,10).
right_node(62,9,11).
% node 10 (leaf): class B (0)
leaf_class(62,10,0).
% node 11 (leaf): class M (1)
leaf_class(62,11,1).
% node 12 (leaf): class M (1)
leaf_class(62,12,1).

% Tree 63
tree(63).
% node 0: f23 <= 830.7000122070312  (F23, bin <= 22)  left -> 1, right -> 8
node(63,0,23,22).
left_node(63,0,1).
right_node(63,0,8).
% node 1: f24 <= 0.16459999978542328  (F24, bin <= 21)  left -> 2, right -> 5
node(63,1,24,21).
left_node(63,1,2).
right_node(63,1,5).
% node 2: f1 <= 21.574999809265137  (F1, bin <= 26)  left -> 3, right -> 4
node(63,2,1,26).
left_node(63,2,3).
right_node(63,2,4).
% node 3 (leaf): class B (0)
leaf_class(63,3,0).
% node 4 (leaf): class B (0)
leaf_class(63,4,0).
% node 5: f14 <= 0.007832999806851149  (F14, bin <= 1)  left -> 6, right -> 7
node(63,5,14,1).
left_node(63,5,6).
right_node(63,5,7).
% node 6 (leaf): class M (1)
leaf_class(63,6,1).
% node 7 (leaf): class B (0)
leaf_class(63,7,0).
% node 8: f1 <= 16.605000495910645  (F1, bin <= 7)  left -> 9, right -> 12
node(63,8,1,7).
left_node(63,8,9).
right_node(63,8,12).
% node 9: f7 <= 0.07844500243663788  (F7, bin <= 31)  left -> 10, right -> 11
node(63,9,7,31).
left_node(63,9,10).
right_node(63,9,11).
% node 10 (leaf): class B (0)
leaf_class(63,10,0).
% node 11 (leaf): class M (1)
leaf_class(63,11,1).
% node 12: f24 <= 0.09431999921798706  (F24, bin <= 1)  left -> 13, right -> 14
node(63,12,24,1).
left_node(63,12,13).
right_node(63,12,14).
% node 13 (leaf): class B (0)
leaf_class(63,13,0).
% node 14 (leaf): class M (1)
leaf_class(63,14,1).

% Tree 64
tree(64).
% node 0: f6 <= 0.10330000147223473  (F6, bin <= 16)  left -> 1, right -> 6
node(64,0,6,16).
left_node(64,0,1).
right_node(64,0,6).
% node 1: f21 <= 23.34999942779541  (F21, bin <= 9)  left -> 2, right -> 3
node(64,1,21,9).
left_node(64,1,2).
right_node(64,1,3).
% node 2 (leaf): class B (0)
leaf_class(64,2,0).
% node 3: f0 <= 15.019999980926514  (F0, bin <= 7)  left -> 4, right -> 5
node(64,3,0,7).
left_node(64,3,4).
right_node(64,3,5).
% node 4 (leaf): class B (0)
leaf_class(64,4,0).
% node 5 (leaf): class M (1)
leaf_class(64,5,1).
% node 6: f16 <= 0.08001499995589256  (F16, bin <= 5)  left -> 7, right -> 10
node(64,6,16,5).
left_node(64,6,7).
right_node(64,6,10).
% node 7: f7 <= 0.043335000053048134  (F7, bin <= 5)  left -> 8, right -> 9
node(64,7,7,5).
left_node(64,7,8).
right_node(64,7,9).
% node 8 (leaf): class B (0)
leaf_class(64,8,0).
% node 9 (leaf): class M (1)
leaf_class(64,9,1).
% node 10: f20 <= 15.519999980926514  (F20, bin <= 9)  left -> 11, right -> 12
node(64,10,20,9).
left_node(64,10,11).
right_node(64,10,12).
% node 11 (leaf): class B (0)
leaf_class(64,11,0).
% node 12 (leaf): class M (1)
leaf_class(64,12,1).

% Tree 65
tree(65).
% node 0: f3 <= 694.1499938964844  (F3, bin <= 11)  left -> 1, right -> 8
node(65,0,3,11).
left_node(65,0,1).
right_node(65,0,8).
% node 1: f6 <= 0.08175500109791756  (F6, bin <= 7)  left -> 2, right -> 5
node(65,1,6,7).
left_node(65,1,2).
right_node(65,1,5).
% node 2: f19 <= 0.0014894999912939966  (F19, bin <= 1)  left -> 3, right -> 4
node(65,2,19,1).
left_node(65,2,3).
right_node(65,2,4).
% node 3 (leaf): class B (0)
leaf_class(65,3,0).
% node 4 (leaf): class B (0)
leaf_class(65,4,0).
% node 5: f28 <= 0.3314500004053116  (F28, bin <= 10)  left -> 6, right -> 7
node(65,5,28,10).
left_node(65,5,6).
right_node(65,5,7).
% node 6 (leaf): class B (0)
leaf_class(65,6,0).
% node 7 (leaf): class M (1)
leaf_class(65,7,1).
% node 8: f13 <= 22.005000114440918  (F13, bin <= 2)  left -> 9, right -> 10
node(65,8,13,2).
left_node(65,8,9).
right_node(65,8,10).
% node 9 (leaf): class B (0)
leaf_class(65,9,0).
% node 10: f22 <= 117.44999694824219  (F22, bin <= 31)  left -> 11, right -> 12
node(65,10,22,31).
left_node(65,10,11).
right_node(65,10,12).
% node 11 (leaf): class M (1)
leaf_class(65,11,1).
% node 12 (leaf): class M (1)
leaf_class(65,12,1).

% Tree 66
tree(66).
% node 0: f23 <= 874.8500061035156  (F23, bin <= 29)  left -> 1, right -> 6
node(66,0,23,29).
left_node(66,0,1).
right_node(66,0,6).
% node 1: f27 <= 0.1656000018119812  (F27, bin <= 41)  left -> 2, right -> 5
node(66,1,27,41).
left_node(66,1,2).
right_node(66,1,5).
% node 2: f2 <= 91.85499954223633  (F2, bin <= 4)  left -> 3, right -> 4
node(66,2,2,4).
left_node(66,2,3).
right_node(66,2,4).
% node 3 (leaf): class B (0)
leaf_class(66,3,0).
% node 4 (leaf): class B (0)
leaf_class(66,4,0).
% node 5 (leaf): class M (1)
leaf_class(66,5,1).
% node 6: f26 <= 0.20980000495910645  (F26, bin <= 4)  left -> 7, right -> 10
node(66,6,26,4).
left_node(66,6,7).
right_node(66,6,10).
% node 7: f5 <= 0.06501000002026558  (F5, bin <= 1)  left -> 8, right -> 9
node(66,7,5,1).
left_node(66,7,8).
right_node(66,7,9).
% node 8 (leaf): class M (1)
leaf_class(66,8,1).
% node 9 (leaf): class B (0)
leaf_class(66,9,0).
% node 10: f21 <= 16.295000076293945  (F21, bin <= 0)  left -> 11, right -> 12
node(66,10,21,0).
left_node(66,10,11).
right_node(66,10,12).
% node 11 (leaf): class B (0)
leaf_class(66,11,0).
% node 12 (leaf): class M (1)
leaf_class(66,12,1).

% Tree 67
tree(67).
% node 0: f27 <= 0.1465499997138977  (F27, bin <= 30)  left -> 1, right -> 8
node(67,0,27,30).
left_node(67,0,1).
right_node(67,0,8).
% node 1: f22 <= 101.44999694824219  (F22, bin <= 4)  left -> 2, right -> 5
node(67,1,22,4).
left_node(67,1,2).
right_node(67,1,5).
% node 2: f29 <= 0.056734999641776085  (F29, bin <= 1)  left -> 3, right -> 4
node(67,2,29,1).
left_node(67,2,3).
right_node(67,2,4).
% node 3 (leaf): class M (1)
leaf_class(67,3,1).
% node 4 (leaf): class B (0)
leaf_class(67,4,0).
% node 5: f22 <= 120.35000228881836  (F22, bin <= 32)  left -> 6, right -> 7
node(67,5,22,32).
left_node(67,5,6).
right_node(67,5,7).
% node 6 (leaf): class B (0)
leaf_class(67,6,0).
% node 7 (leaf): class M (1)
leaf_class(67,7,1).
% node 8: f4 <= 0.08137999847531319  (F4, bin <= 1)  left -> 9, right -> 10
node(67,8,4,1).
left_node(67,8,9).
right_node(67,8,10).
% node 9 (leaf): class B (0)
leaf_class(67,9,0).
% node 10: f3 <= 370.40000915527344  (F3, bin <= 0)  left -> 11, right -> 12
node(67,10,3,0).
left_node(67,10,11).
right_node(67,10,12).
% node 11 (leaf): class B (0)
leaf_class(67,11,0).
% node 12 (leaf): class M (1)
leaf_class(67,12,1).

% Tree 68
tree(68).
% node 0: f20 <= 16.80500030517578  (F20, bin <= 17)  left -> 1, right -> 8
node(68,0,20,17).
left_node(68,0,1).
right_node(68,0,8).
% node 1: f26 <= 0.3693999946117401  (F26, bin <= 22)  left -> 2, right -> 5
node(68,1,26,22).
left_node(68,1,2).
right_node(68,1,5).
% node 2: f7 <= 0.0580850001424551  (F7, bin <= 28)  left -> 3, right -> 4
node(68,2,7,28).
left_node(68,2,3).
right_node(68,2,4).
% node 3 (leaf): class B (0)
leaf_class(68,3,0).
% node 4 (leaf): class B (0)
leaf_class(68,4,0).
% node 5: f15 <= 0.05268999934196472  (F15, bin <= 5)  left -> 6, right -> 7
node(68,5,15,5).
left_node(68,5,6).
right_node(68,5,7).
% node 6 (leaf): class M (1)
leaf_class(68,6,1).
% node 7 (leaf): class B (0)
leaf_class(68,7,0).
% node 8: f6 <= 0.06800499930977821  (F6, bin <= 3)  left -> 9, right -> 12
node(68,8,6,3).
left_node(68,8,9).
right_node(68,8,12).
% node 9: f24 <= 0.13774999976158142  (F24, bin <= 12)  left -> 10, right -> 11
node(68,9,24,12).
left_node(68,9,10).
right_node(68,9,11).
% node 10 (leaf): class B (0)
leaf_class(68,10,0).
% node 11 (leaf): class M (1)
leaf_class(68,11,1).
% node 12: f10 <= 0.18609999865293503  (F10, bin <= 0)  left -> 13, right -> 14
node(68,12,10,0).
left_node(68,12,13).
right_node(68,12,14).
% node 13 (leaf): class B (0)
leaf_class(68,13,0).
% node 14 (leaf): class M (1)
leaf_class(68,14,1).

% Tree 69
tree(69).
% node 0: f25 <= 0.30505000054836273  (F25, bin <= 9)  left -> 1, right -> 8
node(69,0,25,9).
left_node(69,0,1).
right_node(69,0,8).
% node 1: f0 <= 14.90999984741211  (F0, bin <= 5)  left -> 2, right -> 5
node(69,1,0,5).
left_node(69,1,2).
right_node(69,1,5).
% node 2: f26 <= 0.20820000022649765  (F26, bin <= 3)  left -> 3, right -> 4
node(69,2,26,3).
left_node(69,2,3).
right_node(69,2,4).
% node 3 (leaf): class B (0)
leaf_class(69,3,0).
% node 4 (leaf): class B (0)
leaf_class(69,4,0).
% node 5: f23 <= 949.8500061035156  (F23, bin <= 37)  left -> 6, right -> 7
node(69,5,23,37).
left_node(69,5,6).
right_node(69,5,7).
% node 6 (leaf): class B (0)
leaf_class(69,6,0).
% node 7 (leaf): class M (1)
leaf_class(69,7,1).
% node 8: f23 <= 865.6999816894531  (F23, bin <= 26)  left -> 9, right -> 12
node(69,8,23,26).
left_node(69,8,9).
right_node(69,8,12).
% node 9: f7 <= 0.054269999265670776  (F7, bin <= 22)  left -> 10, right -> 11
node(69,9,7,22).
left_node(69,9,10).
right_node(69,9,11).
% node 10 (leaf): class B (0)
leaf_class(69,10,0).
% node 11 (leaf): class M (1)
leaf_class(69,11,1).
% node 12 (leaf): class M (1)
leaf_class(69,12,1).

% Tree 70
tree(70).
% node 0: f7 <= 0.0506649985909462  (F7, bin <= 14)  left -> 1, right -> 8
node(70,0,7,14).
left_node(70,0,1).
right_node(70,0,8).
% node 1: f2 <= 96.57999801635742  (F2, bin <= 7)  left -> 2, right -> 5
node(70,1,2,7).
left_node(70,1,2).
right_node(70,1,5).
% node 2: f24 <= 0.17764999717473984  (F24, bin <= 23)  left -> 3, right -> 4
node(70,2,24,23).
left_node(70,2,3).
right_node(70,2,4).
% node 3 (leaf): class B (0)
leaf_class(70,3,0).
% node 4 (leaf): class M (1)
leaf_class(70,4,1).
% node 5: f18 <= 0.014655000064522028  (F18, bin <= 4)  left -> 6, right -> 7
node(70,5,18,4).
left_node(70,5,6).
right_node(70,5,7).
% node 6 (leaf): class M (1)
leaf_class(70,6,1).
% node 7 (leaf): class B (0)
leaf_class(70,7,0).
% node 8: f22 <= 114.45000076293945  (F22, bin <= 24)  left -> 9, right -> 12
node(70,8,22,24).
left_node(70,8,9).
right_node(70,8,12).
% node 9: f27 <= 0.15890000015497208  (F27, bin <= 38)  left -> 10, right -> 11
node(70,9,27,38).
left_node(70,9,10).
right_node(70,9,11).
% node 10 (leaf): class B (0)
leaf_class(70,10,0).
% node 11 (leaf): class M (1)
leaf_class(70,11,1).
% node 12 (leaf): class M (1)
leaf_class(70,12,1).

% Tree 71
tree(71).
% node 0: f23 <= 727.1000061035156  (F23, bin <= 8)  left -> 1, right -> 8
node(71,0,23,8).
left_node(71,0,1).
right_node(71,0,8).
% node 1: f5 <= 0.16990000009536743  (F5, bin <= 11)  left -> 2, right -> 5
node(71,1,5,11).
left_node(71,1,2).
right_node(71,1,5).
% node 2: f24 <= 0.14159999787807465  (F24, bin <= 14)  left -> 3, right -> 4
node(71,2,24,14).
left_node(71,2,3).
right_node(71,2,4).
% node 3 (leaf): class B (0)
leaf_class(71,3,0).
% node 4 (leaf): class B (0)
leaf_class(71,4,0).
% node 5: f23 <= 418.1000061035156  (F23, bin <= 0)  left -> 6, right -> 7
node(71,5,23,0).
left_node(71,5,6).
right_node(71,5,7).
% node 6 (leaf): class B (0)
leaf_class(71,6,0).
% node 7 (leaf): class M (1)
leaf_class(71,7,1).
% node 8: f23 <= 957.4500122070312  (F23, bin <= 39)  left -> 9, right -> 12
node(71,8,23,39).
left_node(71,8,9).
right_node(71,8,12).
% node 9: f28 <= 0.31710000336170197  (F28, bin <= 7)  left -> 10, right -> 11
node(71,9,28,7).
left_node(71,9,10).
right_node(71,9,11).
% node 10 (leaf): class B (0)
leaf_class(71,10,0).
% node 11 (leaf): class M (1)
leaf_class(71,11,1).
% node 12: f5 <= 0.0726349987089634  (F5, bin <= 2)  left -> 13, right -> 14
node(71,12,5,2).
left_node(71,12,13).
right_node(71,12,14).
% node 13 (leaf): class M (1)
leaf_class(71,13,1).
% node 14 (leaf): class M (1)
leaf_class(71,14,1).

% Tree 72
tree(72).
% node 0: f22 <= 117.44999694824219  (F22, bin <= 31)  left -> 1, right -> 8
node(72,0,22,31).
left_node(72,0,1).
right_node(72,0,8).
% node 1: f22 <= 101.54999923706055  (F22, bin <= 5)  left -> 2, right -> 5
node(72,1,22,5).
left_node(72,1,2).
right_node(72,1,5).
% node 2: f6 <= 0.10319999977946281  (F6, bin <= 15)  left -> 3, right -> 4
node(72,2,6,15).
left_node(72,2,3).
right_node(72,2,4).
% node 3 (leaf): class B (0)
leaf_class(72,3,0).
% node 4 (leaf): class B (0)
leaf_class(72,4,0).
% node 5: f27 <= 0.15129999816417694  (F27, bin <= 36)  left -> 6, right -> 7
node(72,5,27,36).
left_node(72,5,6).
right_node(72,5,7).
% node 6 (leaf): class B (0)
leaf_class(72,6,0).
% node 7 (leaf): class M (1)
leaf_class(72,7,1).
% node 8 (leaf): class M (1)
leaf_class(72,8,1).

% Tree 73
tree(73).
% node 0: f27 <= 0.1423499956727028  (F27, bin <= 24)  left -> 1, right -> 8
node(73,0,27,24).
left_node(73,0,1).
right_node(73,0,8).
% node 1: f2 <= 96.85499954223633  (F2, bin <= 8)  left -> 2, right -> 5
node(73,1,2,8).
left_node(73,1,2).
right_node(73,1,5).
% node 2: f27 <= 0.11534999683499336  (F27, bin <= 10)  left -> 3, right -> 4
node(73,2,27,10).
left_node(73,2,3).
right_node(73,2,4).
% node 3 (leaf): class B (0)
leaf_class(73,3,0).
% node 4 (leaf): class B (0)
leaf_class(73,4,0).
% node 5: f23 <= 871.7999877929688  (F23, bin <= 28)  left -> 6, right -> 7
node(73,5,23,28).
left_node(73,5,6).
right_node(73,5,7).
% node 6 (leaf): class B (0)
leaf_class(73,6,0).
% node 7 (leaf): class M (1)
leaf_class(73,7,1).
% node 8: f16 <= 0.1237500011920929  (F16, bin <= 6)  left -> 9, right -> 12
node(73,8,16,6).
left_node(73,8,9).
right_node(73,8,12).
% node 9: f23 <= 818.1000061035156  (F23, bin <= 20)  left -> 10, right -> 11
node(73,9,23,20).
left_node(73,9,10).
right_node(73,9,11).
% node 10 (leaf): class M (1)
leaf_class(73,10,1).
% node 11 (leaf): class M (1)
leaf_class(73,11,1).
% node 12 (leaf): class B (0)
leaf_class(73,12,0).

% Tree 74
tree(74).
% node 0: f0 <= 15.285000324249268  (F0, bin <= 13)  left -> 1, right -> 8
node(74,0,0,13).
left_node(74,0,1).
right_node(74,0,8).
% node 1: f23 <= 750.0  (F23, bin <= 12)  left -> 2, right -> 5
node(74,1,23,12).
left_node(74,1,2).
right_node(74,1,5).
% node 2: f25 <= 0.2679000049829483  (F25, bin <= 7)  left -> 3, right -> 4
node(74,2,25,7).
left_node(74,2,3).
right_node(74,2,4).
% node 3 (leaf): class B (0)
leaf_class(74,3,0).
% node 4 (leaf): class B (0)
leaf_class(74,4,0).
% node 5: f21 <= 27.315000534057617  (F21, bin <= 18)  left -> 6, right -> 7
node(74,5,21,18).
left_node(74,5,6).
right_node(74,5,7).
% node 6 (leaf): class B (0)
leaf_class(74,6,0).
% node 7 (leaf): class M (1)
leaf_class(74,7,1).
% node 8: f21 <= 20.28499984741211  (F21, bin <= 2)  left -> 9, right -> 12
node(74,8,21,2).
left_node(74,8,9).
right_node(74,8,12).
% node 9: f7 <= 0.07939000055193901  (F7, bin <= 32)  left -> 10, right -> 11
node(74,9,7,32).
left_node(74,9,10).
right_node(74,9,11).
% node 10 (leaf): class B (0)
leaf_class(74,10,0).
% node 11 (leaf): class M (1)
leaf_class(74,11,1).
% node 12 (leaf): class M (1)
leaf_class(74,12,1).

% Tree 75
tree(75).
% node 0: f2 <= 99.79000091552734  (F2, bin <= 13)  left -> 1, right -> 8
node(75,0,2,13).
left_node(75,0,1).
right_node(75,0,8).
% node 1: f22 <= 102.4000015258789  (F22, bin <= 8)  left -> 2, right -> 5
node(75,1,22,8).
left_node(75,1,2).
right_node(75,1,5).
% node 2: f27 <= 0.1419999971985817  (F27, bin <= 22)  left -> 3, right -> 4
node(75,2,27,22).
left_node(75,2,3).
right_node(75,2,4).
% node 3 (leaf): class B (0)
leaf_class(75,3,0).
% node 4 (leaf): class M (1)
leaf_class(75,4,1).
% node 5: f28 <= 0.31689999997615814  (F28, bin <= 6)  left -> 6, right -> 7
node(75,5,28,6).
left_node(75,5,6).
right_node(75,5,7).
% node 6 (leaf): class B (0)
leaf_class(75,6,0).
% node 7 (leaf): class M (1)
leaf_class(75,7,1).
% node 8: f25 <= 0.1757499948143959  (F25, bin <= 1)  left -> 9, right -> 12
node(75,8,25,1).
left_node(75,8,9).
right_node(75,8,12).
% node 9: f4 <= 0.0812000036239624  (F4, bin <= 0)  left -> 10, right -> 11
node(75,9,4,0).
left_node(75,9,10).
right_node(75,9,11).
% node 10 (leaf): class B (0)
leaf_class(75,10,0).
% node 11 (leaf): class M (1)
leaf_class(75,11,1).
% node 12 (leaf): class M (1)
leaf_class(75,12,1).

% Tree 76
tree(76).
% node 0: f3 <= 694.1499938964844  (F3, bin <= 11)  left -> 1, right -> 8
node(76,0,3,11).
left_node(76,0,1).
right_node(76,0,8).
% node 1: f7 <= 0.04432000033557415  (F7, bin <= 6)  left -> 2, right -> 5
node(76,1,7,6).
left_node(76,1,2).
right_node(76,1,5).
% node 2: f7 <= 0.026759999804198742  (F7, bin <= 1)  left -> 3, right -> 4
node(76,2,7,1).
left_node(76,2,3).
right_node(76,2,4).
% node 3 (leaf): class B (0)
leaf_class(76,3,0).
% node 4 (leaf): class B (0)
leaf_class(76,4,0).
% node 5: f24 <= 0.13735000044107437  (F24, bin <= 11)  left -> 6, right -> 7
node(76,5,24,11).
left_node(76,5,6).
right_node(76,5,7).
% node 6 (leaf): class B (0)
leaf_class(76,6,0).
% node 7 (leaf): class M (1)
leaf_class(76,7,1).
% node 8: f22 <= 127.64999771118164  (F22, bin <= 34)  left -> 9, right -> 12
node(76,8,22,34).
left_node(76,8,9).
right_node(76,8,12).
% node 9: f29 <= 0.09047999978065491  (F29, bin <= 6)  left -> 10, right -> 11
node(76,9,29,6).
left_node(76,9,10).
right_node(76,9,11).
% node 10 (leaf): class B (0)
leaf_class(76,10,0).
% node 11 (leaf): class M (1)
leaf_class(76,11,1).
% node 12 (leaf): class M (1)
leaf_class(76,12,1).

% Tree 77
tree(77).
% node 0: f28 <= 0.3570999950170517  (F28, bin <= 11)  left -> 1, right -> 8
node(77,0,28,11).
left_node(77,0,1).
right_node(77,0,8).
% node 1: f3 <= 662.2000122070312  (F3, bin <= 6)  left -> 2, right -> 5
node(77,1,3,6).
left_node(77,1,2).
right_node(77,1,5).
% node 2: f23 <= 768.9000244140625  (F23, bin <= 15)  left -> 3, right -> 4
node(77,2,23,15).
left_node(77,2,3).
right_node(77,2,4).
% node 3 (leaf): class B (0)
leaf_class(77,3,0).
% node 4 (leaf): class M (1)
leaf_class(77,4,1).
% node 5: f3 <= 848.0999755859375  (F3, bin <= 16)  left -> 6, right -> 7
node(77,5,3,16).
left_node(77,5,6).
right_node(77,5,7).
% node 6 (leaf): class M (1)
leaf_class(77,6,1).
% node 7 (leaf): class M (1)
leaf_class(77,7,1).
% node 8: f7 <= 0.04778499901294708  (F7, bin <= 9)  left -> 9, right -> 12
node(77,8,7,9).
left_node(77,8,9).
right_node(77,8,12).
% node 9: f16 <= 0.015905000269412994  (F16, bin <= 0)  left -> 10, right -> 11
node(77,9,16,0).
left_node(77,9,10).
right_node(77,9,11).
% node 10 (leaf): class M (1)
leaf_class(77,10,1).
% node 11 (leaf): class B (0)
leaf_class(77,11,0).
% node 12 (leaf): class M (1)
leaf_class(77,12,1).

% Tree 78
tree(78).
% node 0: f27 <= 0.14705000072717667  (F27, bin <= 31)  left -> 1, right -> 8
node(78,0,27,31).
left_node(78,0,1).
right_node(78,0,8).
% node 1: f20 <= 16.829999923706055  (F20, bin <= 18)  left -> 2, right -> 5
node(78,1,20,18).
left_node(78,1,2).
right_node(78,1,5).
% node 2: f29 <= 0.055124999955296516  (F29, bin <= 0)  left -> 3, right -> 4
node(78,2,29,0).
left_node(78,2,3).
right_node(78,2,4).
% node 3 (leaf): class M (1)
leaf_class(78,3,1).
% node 4 (leaf): class B (0)
leaf_class(78,4,0).
% node 5: f13 <= 32.90000057220459  (F13, bin <= 6)  left -> 6, right -> 7
node(78,5,13,6).
left_node(78,5,6).
right_node(78,5,7).
% node 6 (leaf): class B (0)
leaf_class(78,6,0).
% node 7 (leaf): class M (1)
leaf_class(78,7,1).
% node 8: f0 <= 11.385000228881836  (F0, bin <= 0)  left -> 9, right -> 10
node(78,8,0,0).
left_node(78,8,9).
right_node(78,8,10).
% node 9 (leaf): class B (0)
leaf_class(78,9,0).
% node 10: f16 <= 0.016979999840259552  (F16, bin <= 1)  left -> 11, right -> 12
node(78,10,16,1).
left_node(78,10,11).
right_node(78,10,12).
% node 11 (leaf): class B (0)
leaf_class(78,11,0).
% node 12 (leaf): class M (1)
leaf_class(78,12,1).

% Tree 79
tree(79).
% node 0: f22 <= 109.45000076293945  (F22, bin <= 16)  left -> 1, right -> 8
node(79,0,22,16).
left_node(79,0,1).
right_node(79,0,8).
% node 1: f28 <= 0.3576499968767166  (F28, bin <= 12)  left -> 2, right -> 5
node(79,1,28,12).
left_node(79,1,2).
right_node(79,1,5).
% node 2: f29 <= 0.055124999955296516  (F29, bin <= 0)  left -> 3, right -> 4
node(79,2,29,0).
left_node(79,2,3).
right_node(79,2,4).
% node 3 (leaf): class M (1)
leaf_class(79,3,1).
% node 4 (leaf): class B (0)
leaf_class(79,4,0).
% node 5: f19 <= 0.003560999990440905  (F19, bin <= 6)  left -> 6, right -> 7
node(79,5,19,6).
left_node(79,5,6).
right_node(79,5,7).
% node 6 (leaf): class B (0)
leaf_class(79,6,0).
% node 7 (leaf): class M (1)
leaf_class(79,7,1).
% node 8: f21 <= 21.675000190734863  (F21, bin <= 4)  left -> 9, right -> 12
node(79,8,21,4).
left_node(79,8,9).
right_node(79,8,12).
% node 9: f7 <= 0.07983500137925148  (F7, bin <= 33)  left -> 10, right -> 11
node(79,9,7,33).
left_node(79,9,10).
right_node(79,9,11).
% node 10 (leaf): class B (0)
leaf_class(79,10,0).
% node 11 (leaf): class M (1)
leaf_class(79,11,1).
% node 12: f0 <= 14.525000095367432  (F0, bin <= 3)  left -> 13, right -> 14
node(79,12,0,3).
left_node(79,12,13).
right_node(79,12,14).
% node 13 (leaf): class M (1)
leaf_class(79,13,1).
% node 14 (leaf): class M (1)
leaf_class(79,14,1).

% Tree 80
tree(80).
% node 0: f23 <= 880.75  (F23, bin <= 31)  left -> 1, right -> 8
node(80,0,23,31).
left_node(80,0,1).
right_node(80,0,8).
% node 1: f6 <= 0.11134999990463257  (F6, bin <= 17)  left -> 2, right -> 5
node(80,1,6,17).
left_node(80,1,2).
right_node(80,1,5).
% node 2: f1 <= 18.085000038146973  (F1, bin <= 12)  left -> 3, right -> 4
node(80,2,1,12).
left_node(80,2,3).
right_node(80,2,4).
% node 3 (leaf): class B (0)
leaf_class(80,3,0).
% node 4 (leaf): class B (0)
leaf_class(80,4,0).
% node 5: f17 <= 0.020874999463558197  (F17, bin <= 2)  left -> 6, right -> 7
node(80,5,17,2).
left_node(80,5,6).
right_node(80,5,7).
% node 6 (leaf): class M (1)
leaf_class(80,6,1).
% node 7 (leaf): class B (0)
leaf_class(80,7,0).
% node 8: f26 <= 0.20980000495910645  (F26, bin <= 4)  left -> 9, right -> 10
node(80,8,26,4).
left_node(80,8,9).
right_node(80,8,10).
% node 9 (leaf): class B (0)
leaf_class(80,9,0).
% node 10: f10 <= 0.2216000035405159  (F10, bin <= 3)  left -> 11, right -> 12
node(80,10,10,3).
left_node(80,10,11).
right_node(80,10,12).
% node 11 (leaf): class B (0)
leaf_class(80,11,0).
% node 12 (leaf): class M (1)
leaf_class(80,12,1).

% Tree 81
tree(81).
% node 0: f23 <= 861.7999877929688  (F23, bin <= 24)  left -> 1, right -> 6
node(81,0,23,24).
left_node(81,0,1).
right_node(81,0,6).
% node 1: f4 <= 0.09047500044107437  (F4, bin <= 2)  left -> 2, right -> 3
node(81,1,4,2).
left_node(81,1,2).
right_node(81,1,3).
% node 2 (leaf): class B (0)
leaf_class(81,2,0).
% node 3: f7 <= 0.045465001836419106  (F7, bin <= 8)  left -> 4, right -> 5
node(81,3,7,8).
left_node(81,3,4).
right_node(81,3,5).
% node 4 (leaf): class B (0)
leaf_class(81,4,0).
% node 5 (leaf): class B (0)
leaf_class(81,5,0).
% node 6: f21 <= 19.90999984741211  (F21, bin <= 1)  left -> 7, right -> 10
node(81,6,21,1).
left_node(81,6,7).
right_node(81,6,10).
% node 7: f5 <= 0.11370999738574028  (F5, bin <= 8)  left -> 8, right -> 9
node(81,7,5,8).
left_node(81,7,8).
right_node(81,7,9).
% node 8 (leaf): class B (0)
leaf_class(81,8,0).
% node 9 (leaf): class M (1)
leaf_class(81,9,1).
% node 10: f27 <= 0.10041499882936478  (F27, bin <= 5)  left -> 11, right -> 12
node(81,10,27,5).
left_node(81,10,11).
right_node(81,10,12).
% node 11 (leaf): class M (1)
leaf_class(81,11,1).
% node 12 (leaf): class M (1)
leaf_class(81,12,1).

% Tree 82
tree(82).
% node 0: f23 <= 739.1999816894531  (F23, bin <= 11)  left -> 1, right -> 6
node(82,0,23,11).
left_node(82,0,1).
right_node(82,0,6).
% node 1: f27 <= 0.18074999749660492  (F27, bin <= 42)  left -> 2, right -> 5
node(82,1,27,42).
left_node(82,1,2).
right_node(82,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(82,2,10,11).
left_node(82,2,3).
right_node(82,2,4).
% node 3 (leaf): class B (0)
leaf_class(82,3,0).
% node 4 (leaf): class B (0)
leaf_class(82,4,0).
% node 5 (leaf): class M (1)
leaf_class(82,5,1).
% node 6: f26 <= 0.2604999989271164  (F26, bin <= 15)  left -> 7, right -> 10
node(82,6,26,15).
left_node(82,6,7).
right_node(82,6,10).
% node 7: f8 <= 0.17399999499320984  (F8, bin <= 1)  left -> 8, right -> 9
node(82,7,8,1).
left_node(82,7,8).
right_node(82,7,9).
% node 8 (leaf): class B (0)
leaf_class(82,8,0).
% node 9 (leaf): class M (1)
leaf_class(82,9,1).
% node 10: f10 <= 0.2543500065803528  (F10, bin <= 4)  left -> 11, right -> 12
node(82,10,10,4).
left_node(82,10,11).
right_node(82,10,12).
% node 11 (leaf): class B (0)
leaf_class(82,11,0).
% node 12 (leaf): class M (1)
leaf_class(82,12,1).

% Tree 83
tree(83).
% node 0: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 1, right -> 8
node(83,0,23,27).
left_node(83,0,1).
right_node(83,0,8).
% node 1: f26 <= 0.48924998939037323  (F26, bin <= 27)  left -> 2, right -> 5
node(83,1,26,27).
left_node(83,1,2).
right_node(83,1,5).
% node 2: f21 <= 29.674999237060547  (F21, bin <= 24)  left -> 3, right -> 4
node(83,2,21,24).
left_node(83,2,3).
right_node(83,2,4).
% node 3 (leaf): class B (0)
leaf_class(83,3,0).
% node 4 (leaf): class B (0)
leaf_class(83,4,0).
% node 5: f19 <= 0.007326500024646521  (F19, bin <= 8)  left -> 6, right -> 7
node(83,5,19,8).
left_node(83,5,6).
right_node(83,5,7).
% node 6 (leaf): class M (1)
leaf_class(83,6,1).
% node 7 (leaf): class B (0)
leaf_class(83,7,0).
% node 8: f25 <= 0.19825000315904617  (F25, bin <= 4)  left -> 9, right -> 12
node(83,8,25,4).
left_node(83,8,9).
right_node(83,8,12).
% node 9: f21 <= 21.140000343322754  (F21, bin <= 3)  left -> 10, right -> 11
node(83,9,21,3).
left_node(83,9,10).
right_node(83,9,11).
% node 10 (leaf): class B (0)
leaf_class(83,10,0).
% node 11 (leaf): class M (1)
leaf_class(83,11,1).
% node 12 (leaf): class M (1)
leaf_class(83,12,1).

% Tree 84
tree(84).
% node 0: f0 <= 15.275000095367432  (F0, bin <= 12)  left -> 1, right -> 8
node(84,0,0,12).
left_node(84,0,1).
right_node(84,0,8).
% node 1: f23 <= 693.3999938964844  (F23, bin <= 4)  left -> 2, right -> 5
node(84,1,23,4).
left_node(84,1,2).
right_node(84,1,5).
% node 2: f23 <= 552.7999877929688  (F23, bin <= 2)  left -> 3, right -> 4
node(84,2,23,2).
left_node(84,2,3).
right_node(84,2,4).
% node 3 (leaf): class B (0)
leaf_class(84,3,0).
% node 4 (leaf): class B (0)
leaf_class(84,4,0).
% node 5: f24 <= 0.14429999887943268  (F24, bin <= 17)  left -> 6, right -> 7
node(84,5,24,17).
left_node(84,5,6).
right_node(84,5,7).
% node 6 (leaf): class B (0)
leaf_class(84,6,0).
% node 7 (leaf): class M (1)
leaf_class(84,7,1).
% node 8: f22 <= 120.35000228881836  (F22, bin <= 32)  left -> 9, right -> 12
node(84,8,22,32).
left_node(84,8,9).
right_node(84,8,12).
% node 9: f28 <= 0.2766000032424927  (F28, bin <= 3)  left -> 10, right -> 11
node(84,9,28,3).
left_node(84,9,10).
right_node(84,9,11).
% node 10 (leaf): class B (0)
leaf_class(84,10,0).
% node 11 (leaf): class M (1)
leaf_class(84,11,1).
% node 12 (leaf): class M (1)
leaf_class(84,12,1).

% Tree 85
tree(85).
% node 0: f2 <= 105.25  (F2, bin <= 15)  left -> 1, right -> 8
node(85,0,2,15).
left_node(85,0,1).
right_node(85,0,8).
% node 1: f7 <= 0.05127999931573868  (F7, bin <= 18)  left -> 2, right -> 5
node(85,1,7,18).
left_node(85,1,2).
right_node(85,1,5).
% node 2: f23 <= 759.4500122070312  (F23, bin <= 14)  left -> 3, right -> 4
node(85,2,23,14).
left_node(85,2,3).
right_node(85,2,4).
% node 3 (leaf): class B (0)
leaf_class(85,3,0).
% node 4 (leaf): class B (0)
leaf_class(85,4,0).
% node 5: f24 <= 0.14580000191926956  (F24, bin <= 18)  left -> 6, right -> 7
node(85,5,24,18).
left_node(85,5,6).
right_node(85,5,7).
% node 6 (leaf): class B (0)
leaf_class(85,6,0).
% node 7 (leaf): class M (1)
leaf_class(85,7,1).
% node 8: f26 <= 0.190700002014637  (F26, bin <= 1)  left -> 9, right -> 10
node(85,8,26,1).
left_node(85,8,9).
right_node(85,8,10).
% node 9 (leaf): class B (0)
leaf_class(85,9,0).
% node 10 (leaf): class M (1)
leaf_class(85,10,1).

% Tree 86
tree(86).
% node 0: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 1, right -> 8
node(86,0,23,27).
left_node(86,0,1).
right_node(86,0,8).
% node 1: f4 <= 0.10370000079274178  (F4, bin <= 10)  left -> 2, right -> 5
node(86,1,4,10).
left_node(86,1,2).
right_node(86,1,5).
% node 2: f0 <= 12.765000343322754  (F0, bin <= 1)  left -> 3, right -> 4
node(86,2,0,1).
left_node(86,2,3).
right_node(86,2,4).
% node 3 (leaf): class B (0)
leaf_class(86,3,0).
% node 4 (leaf): class B (0)
leaf_class(86,4,0).
% node 5: f7 <= 0.05636000074446201  (F7, bin <= 27)  left -> 6, right -> 7
node(86,5,7,27).
left_node(86,5,6).
right_node(86,5,7).
% node 6 (leaf): class B (0)
leaf_class(86,6,0).
% node 7 (leaf): class M (1)
leaf_class(86,7,1).
% node 8: f16 <= 0.024790000170469284  (F16, bin <= 4)  left -> 9, right -> 12
node(86,8,16,4).
left_node(86,8,9).
right_node(86,8,12).
% node 9: f1 <= 16.19000005722046  (F1, bin <= 4)  left -> 10, right -> 11
node(86,9,1,4).
left_node(86,9,10).
right_node(86,9,11).
% node 10 (leaf): class B (0)
leaf_class(86,10,0).
% node 11 (leaf): class M (1)
leaf_class(86,11,1).
% node 12: f24 <= 0.09491999819874763  (F24, bin <= 2)  left -> 13, right -> 14
node(86,12,24,2).
left_node(86,12,13).
right_node(86,12,14).
% node 13 (leaf): class B (0)
leaf_class(86,13,0).
% node 14 (leaf): class M (1)
leaf_class(86,14,1).

% Tree 87
tree(87).
% node 0: f23 <= 875.1999816894531  (F23, bin <= 30)  left -> 1, right -> 8
node(87,0,23,30).
left_node(87,0,1).
right_node(87,0,8).
% node 1: f27 <= 0.16125000268220901  (F27, bin <= 40)  left -> 2, right -> 5
node(87,1,27,40).
left_node(87,1,2).
right_node(87,1,5).
% node 2: f7 <= 0.045465001836419106  (F7, bin <= 8)  left -> 3, right -> 4
node(87,2,7,8).
left_node(87,2,3).
right_node(87,2,4).
% node 3 (leaf): class B (0)
leaf_class(87,3,0).
% node 4 (leaf): class B (0)
leaf_class(87,4,0).
% node 5: f26 <= 1.0769499838352203  (F26, bin <= 29)  left -> 6, right -> 7
node(87,5,26,29).
left_node(87,5,6).
right_node(87,5,7).
% node 6 (leaf): class M (1)
leaf_class(87,6,1).
% node 7 (leaf): class B (0)
leaf_class(87,7,0).
% node 8: f29 <= 0.07300500199198723  (F29, bin <= 4)  left -> 9, right -> 12
node(87,8,29,4).
left_node(87,8,9).
right_node(87,8,12).
% node 9: f7 <= 0.049765000119805336  (F7, bin <= 10)  left -> 10, right -> 11
node(87,9,7,10).
left_node(87,9,10).
right_node(87,9,11).
% node 10 (leaf): class B (0)
leaf_class(87,10,0).
% node 11 (leaf): class M (1)
leaf_class(87,11,1).
% node 12 (leaf): class M (1)
leaf_class(87,12,1).

% Tree 88
tree(88).
% node 0: f20 <= 17.510000228881836  (F20, bin <= 21)  left -> 1, right -> 8
node(88,0,20,21).
left_node(88,0,1).
right_node(88,0,8).
% node 1: f6 <= 0.09329499676823616  (F6, bin <= 11)  left -> 2, right -> 5
node(88,1,6,11).
left_node(88,1,2).
right_node(88,1,5).
% node 2: f21 <= 29.574999809265137  (F21, bin <= 23)  left -> 3, right -> 4
node(88,2,21,23).
left_node(88,2,3).
right_node(88,2,4).
% node 3 (leaf): class B (0)
leaf_class(88,3,0).
% node 4 (leaf): class B (0)
leaf_class(88,4,0).
% node 5: f27 <= 0.1359499990940094  (F27, bin <= 18)  left -> 6, right -> 7
node(88,5,27,18).
left_node(88,5,6).
right_node(88,5,7).
% node 6 (leaf): class B (0)
leaf_class(88,6,0).
% node 7 (leaf): class M (1)
leaf_class(88,7,1).
% node 8: f19 <= 0.0013269999762997031  (F19, bin <= 0)  left -> 9, right -> 10
node(88,8,19,0).
left_node(88,8,9).
right_node(88,8,10).
% node 9 (leaf): class B (0)
leaf_class(88,9,0).
% node 10 (leaf): class M (1)
leaf_class(88,10,1).

% Tree 89
tree(89).
% node 0: f2 <= 98.40499877929688  (F2, bin <= 10)  left -> 1, right -> 8
node(89,0,2,10).
left_node(89,0,1).
right_node(89,0,8).
% node 1: f29 <= 0.09307000041007996  (F29, bin <= 7)  left -> 2, right -> 5
node(89,1,29,7).
left_node(89,1,2).
right_node(89,1,5).
% node 2: f23 <= 844.75  (F23, bin <= 23)  left -> 3, right -> 4
node(89,2,23,23).
left_node(89,2,3).
right_node(89,2,4).
% node 3 (leaf): class B (0)
leaf_class(89,3,0).
% node 4 (leaf): class M (1)
leaf_class(89,4,1).
% node 5: f20 <= 14.644999980926514  (F20, bin <= 2)  left -> 6, right -> 7
node(89,5,20,2).
left_node(89,5,6).
right_node(89,5,7).
% node 6 (leaf): class B (0)
leaf_class(89,6,0).
% node 7 (leaf): class M (1)
leaf_class(89,7,1).
% node 8: f2 <= 108.60000228881836  (F2, bin <= 17)  left -> 9, right -> 12
node(89,8,2,17).
left_node(89,8,9).
right_node(89,8,12).
% node 9: f7 <= 0.0867450013756752  (F7, bin <= 34)  left -> 10, right -> 11
node(89,9,7,34).
left_node(89,9,10).
right_node(89,9,11).
% node 10 (leaf): class M (1)
leaf_class(89,10,1).
% node 11 (leaf): class M (1)
leaf_class(89,11,1).
% node 12 (leaf): class M (1)
leaf_class(89,12,1).

% Tree 90
tree(90).
% node 0: f23 <= 953.7000122070312  (F23, bin <= 38)  left -> 1, right -> 8
node(90,0,23,38).
left_node(90,0,1).
right_node(90,0,8).
% node 1: f26 <= 0.369499996304512  (F26, bin <= 23)  left -> 2, right -> 5
node(90,1,26,23).
left_node(90,1,2).
right_node(90,1,5).
% node 2: f20 <= 15.78000020980835  (F20, bin <= 11)  left -> 3, right -> 4
node(90,2,20,11).
left_node(90,2,3).
right_node(90,2,4).
% node 3 (leaf): class B (0)
leaf_class(90,3,0).
% node 4 (leaf): class B (0)
leaf_class(90,4,0).
% node 5: f27 <= 0.14305000007152557  (F27, bin <= 26)  left -> 6, right -> 7
node(90,5,27,26).
left_node(90,5,6).
right_node(90,5,7).
% node 6 (leaf): class B (0)
leaf_class(90,6,0).
% node 7 (leaf): class M (1)
leaf_class(90,7,1).
% node 8: f24 <= 0.09975999966263771  (F24, bin <= 4)  left -> 9, right -> 10
node(90,8,24,4).
left_node(90,8,9).
right_node(90,8,10).
% node 9 (leaf): class B (0)
leaf_class(90,9,0).
% node 10 (leaf): class M (1)
leaf_class(90,10,1).

% Tree 91
tree(91).
% node 0: f6 <= 0.0861550010740757  (F6, bin <= 9)  left -> 1, right -> 6
node(91,0,6,9).
left_node(91,0,1).
right_node(91,0,6).
% node 1: f3 <= 847.8499755859375  (F3, bin <= 15)  left -> 2, right -> 5
node(91,1,3,15).
left_node(91,1,2).
right_node(91,1,5).
% node 2: f23 <= 957.4500122070312  (F23, bin <= 39)  left -> 3, right -> 4
node(91,2,23,39).
left_node(91,2,3).
right_node(91,2,4).
% node 3 (leaf): class B (0)
leaf_class(91,3,0).
% node 4 (leaf): class M (1)
leaf_class(91,4,1).
% node 5 (leaf): class M (1)
leaf_class(91,5,1).
% node 6: f22 <= 115.89999771118164  (F22, bin <= 27)  left -> 7, right -> 10
node(91,6,22,27).
left_node(91,6,7).
right_node(91,6,10).
% node 7: f21 <= 26.90000057220459  (F21, bin <= 17)  left -> 8, right -> 9
node(91,7,21,17).
left_node(91,7,8).
right_node(91,7,9).
% node 8 (leaf): class B (0)
leaf_class(91,8,0).
% node 9 (leaf): class M (1)
leaf_class(91,9,1).
% node 10 (leaf): class M (1)
leaf_class(91,10,1).

% Tree 92
tree(92).
% node 0: f27 <= 0.14169999957084656  (F27, bin <= 21)  left -> 1, right -> 8
node(92,0,27,21).
left_node(92,0,1).
right_node(92,0,8).
% node 1: f13 <= 35.935001373291016  (F13, bin <= 9)  left -> 2, right -> 5
node(92,1,13,9).
left_node(92,1,2).
right_node(92,1,5).
% node 2: f23 <= 844.75  (F23, bin <= 23)  left -> 3, right -> 4
node(92,2,23,23).
left_node(92,2,3).
right_node(92,2,4).
% node 3 (leaf): class B (0)
leaf_class(92,3,0).
% node 4 (leaf): class B (0)
leaf_class(92,4,0).
% node 5: f18 <= 0.012270000297576189  (F18, bin <= 3)  left -> 6, right -> 7
node(92,5,18,3).
left_node(92,5,6).
right_node(92,5,7).
% node 6 (leaf): class M (1)
leaf_class(92,6,1).
% node 7 (leaf): class B (0)
leaf_class(92,7,0).
% node 8: f0 <= 13.0  (F0, bin <= 2)  left -> 9, right -> 12
node(92,8,0,2).
left_node(92,8,9).
right_node(92,8,12).
% node 9: f1 <= 18.854999542236328  (F1, bin <= 17)  left -> 10, right -> 11
node(92,9,1,17).
left_node(92,9,10).
right_node(92,9,11).
% node 10 (leaf): class B (0)
leaf_class(92,10,0).
% node 11 (leaf): class M (1)
leaf_class(92,11,1).
% node 12: f7 <= 0.05035500042140484  (F7, bin <= 12)  left -> 13, right -> 14
node(92,12,7,12).
left_node(92,12,13).
right_node(92,12,14).
% node 13 (leaf): class B (0)
leaf_class(92,13,0).
% node 14 (leaf): class M (1)
leaf_class(92,14,1).

% Tree 93
tree(93).
% node 0: f23 <= 868.1999816894531  (F23, bin <= 27)  left -> 1, right -> 8
node(93,0,23,27).
left_node(93,0,1).
right_node(93,0,8).
% node 1: f27 <= 0.13490000367164612  (F27, bin <= 15)  left -> 2, right -> 5
node(93,1,27,15).
left_node(93,1,2).
right_node(93,1,5).
% node 2: f10 <= 0.6255500018596649  (F10, bin <= 11)  left -> 3, right -> 4
node(93,2,10,11).
left_node(93,2,3).
right_node(93,2,4).
% node 3 (leaf): class B (0)
leaf_class(93,3,0).
% node 4 (leaf): class B (0)
leaf_class(93,4,0).
% node 5: f1 <= 20.299999237060547  (F1, bin <= 21)  left -> 6, right -> 7
node(93,5,1,21).
left_node(93,5,6).
right_node(93,5,7).
% node 6 (leaf): class B (0)
leaf_class(93,6,0).
% node 7 (leaf): class M (1)
leaf_class(93,7,1).
% node 8: f5 <= 0.09524999931454659  (F5, bin <= 6)  left -> 9, right -> 12
node(93,8,5,6).
left_node(93,8,9).
right_node(93,8,12).
% node 9: f4 <= 0.09321000054478645  (F4, bin <= 6)  left -> 10, right -> 11
node(93,9,4,6).
left_node(93,9,10).
right_node(93,9,11).
% node 10 (leaf): class M (1)
leaf_class(93,10,1).
% node 11 (leaf): class B (0)
leaf_class(93,11,0).
% node 12 (leaf): class M (1)
leaf_class(93,12,1).

% Tree 94
tree(94).
% node 0: f27 <= 0.14169999957084656  (F27, bin <= 21)  left -> 1, right -> 8
node(94,0,27,21).
left_node(94,0,1).
right_node(94,0,8).
% node 1: f13 <= 35.85500144958496  (F13, bin <= 8)  left -> 2, right -> 5
node(94,1,13,8).
left_node(94,1,2).
right_node(94,1,5).
% node 2: f22 <= 112.5999984741211  (F22, bin <= 20)  left -> 3, right -> 4
node(94,2,22,20).
left_node(94,2,3).
right_node(94,2,4).
% node 3 (leaf): class B (0)
leaf_class(94,3,0).
% node 4 (leaf): class M (1)
leaf_class(94,4,1).
% node 5: f24 <= 0.10564999654889107  (F24, bin <= 6)  left -> 6, right -> 7
node(94,5,24,6).
left_node(94,5,6).
right_node(94,5,7).
% node 6 (leaf): class B (0)
leaf_class(94,6,0).
% node 7 (leaf): class M (1)
leaf_class(94,7,1).
% node 8: f13 <= 29.579999923706055  (F13, bin <= 4)  left -> 9, right -> 12
node(94,8,13,4).
left_node(94,8,9).
right_node(94,8,12).
% node 9: f9 <= 0.06127999909222126  (F9, bin <= 3)  left -> 10, right -> 11
node(94,9,9,3).
left_node(94,9,10).
right_node(94,9,11).
% node 10 (leaf): class B (0)
leaf_class(94,10,0).
% node 11 (leaf): class M (1)
leaf_class(94,11,1).
% node 12: f19 <= 0.021339999977499247  (F19, bin <= 10)  left -> 13, right -> 14
node(94,12,19,10).
left_node(94,12,13).
right_node(94,12,14).
% node 13 (leaf): class M (1)
leaf_class(94,13,1).
% node 14 (leaf): class B (0)
leaf_class(94,14,0).

% Tree 95
tree(95).
% node 0: f20 <= 17.34000015258789  (F20, bin <= 20)  left -> 1, right -> 8
node(95,0,20,20).
left_node(95,0,1).
right_node(95,0,8).
% node 1: f26 <= 0.2635500133037567  (F26, bin <= 18)  left -> 2, right -> 5
node(95,1,26,18).
left_node(95,1,2).
right_node(95,1,5).
% node 2: f28 <= 0.282600000500679  (F28, bin <= 4)  left -> 3, right -> 4
node(95,2,28,4).
left_node(95,2,3).
right_node(95,2,4).
% node 3 (leaf): class B (0)
leaf_class(95,3,0).
% node 4 (leaf): class B (0)
leaf_class(95,4,0).
% node 5: f1 <= 18.52500057220459  (F1, bin <= 15)  left -> 6, right -> 7
node(95,5,1,15).
left_node(95,5,6).
right_node(95,5,7).
% node 6 (leaf): class B (0)
leaf_class(95,6,0).
% node 7 (leaf): class M (1)
leaf_class(95,7,1).
% node 8: f6 <= 0.06592500023543835  (F6, bin <= 2)  left -> 9, right -> 12
node(95,8,6,2).
left_node(95,8,9).
right_node(95,8,12).
% node 9: f1 <= 20.934999465942383  (F1, bin <= 23)  left -> 10, right -> 11
node(95,9,1,23).
left_node(95,9,10).
right_node(95,9,11).
% node 10 (leaf): class B (0)
leaf_class(95,10,0).
% node 11 (leaf): class M (1)
leaf_class(95,11,1).
% node 12 (leaf): class M (1)
leaf_class(95,12,1).

% Tree 96
tree(96).
% node 0: f23 <= 884.5499877929688  (F23, bin <= 32)  left -> 1, right -> 8
node(96,0,23,32).
left_node(96,0,1).
right_node(96,0,8).
% node 1: f25 <= 0.3849000036716461  (F25, bin <= 11)  left -> 2, right -> 5
node(96,1,25,11).
left_node(96,1,2).
right_node(96,1,5).
% node 2: f2 <= 87.48500061035156  (F2, bin <= 2)  left -> 3, right -> 4
node(96,2,2,2).
left_node(96,2,3).
right_node(96,2,4).
% node 3 (leaf): class B (0)
leaf_class(96,3,0).
% node 4 (leaf): class B (0)
leaf_class(96,4,0).
% node 5: f2 <= 75.75500106811523  (F2, bin <= 0)  left -> 6, right -> 7
node(96,5,2,0).
left_node(96,5,6).
right_node(96,5,7).
% node 6 (leaf): class B (0)
leaf_class(96,6,0).
% node 7 (leaf): class M (1)
leaf_class(96,7,1).
% node 8: f5 <= 0.08573000133037567  (F5, bin <= 4)  left -> 9, right -> 12
node(96,8,5,4).
left_node(96,8,9).
right_node(96,8,12).
% node 9: f24 <= 0.10035999864339828  (F24, bin <= 5)  left -> 10, right -> 11
node(96,9,24,5).
left_node(96,9,10).
right_node(96,9,11).
% node 10 (leaf): class B (0)
leaf_class(96,10,0).
% node 11 (leaf): class M (1)
leaf_class(96,11,1).
% node 12 (leaf): class M (1)
leaf_class(96,12,1).

% Tree 97
tree(97).
% node 0: f20 <= 16.795000076293945  (F20, bin <= 16)  left -> 1, right -> 8
node(97,0,20,16).
left_node(97,0,1).
right_node(97,0,8).
% node 1: f20 <= 14.880000114440918  (F20, bin <= 4)  left -> 2, right -> 5
node(97,1,20,4).
left_node(97,1,2).
right_node(97,1,5).
% node 2: f13 <= 45.17500114440918  (F13, bin <= 13)  left -> 3, right -> 4
node(97,2,13,13).
left_node(97,2,3).
right_node(97,2,4).
% node 3 (leaf): class B (0)
leaf_class(97,3,0).
% node 4 (leaf): class B (0)
leaf_class(97,4,0).
% node 5: f27 <= 0.15129999816417694  (F27, bin <= 36)  left -> 6, right -> 7
node(97,5,27,36).
left_node(97,5,6).
right_node(97,5,7).
% node 6 (leaf): class B (0)
leaf_class(97,6,0).
% node 7 (leaf): class M (1)
leaf_class(97,7,1).
% node 8: f19 <= 0.0024800000246614218  (F19, bin <= 5)  left -> 9, right -> 12
node(97,8,19,5).
left_node(97,8,9).
right_node(97,8,12).
% node 9: f1 <= 16.09000015258789  (F1, bin <= 3)  left -> 10, right -> 11
node(97,9,1,3).
left_node(97,9,10).
right_node(97,9,11).
% node 10 (leaf): class B (0)
leaf_class(97,10,0).
% node 11 (leaf): class M (1)
leaf_class(97,11,1).
% node 12 (leaf): class M (1)
leaf_class(97,12,1).

% Tree 98
tree(98).
% node 0: f23 <= 884.5499877929688  (F23, bin <= 32)  left -> 1, right -> 8
node(98,0,23,32).
left_node(98,0,1).
right_node(98,0,8).
% node 1: f27 <= 0.1318499967455864  (F27, bin <= 14)  left -> 2, right -> 5
node(98,1,27,14).
left_node(98,1,2).
right_node(98,1,5).
% node 2: f5 <= 0.060474999248981476  (F5, bin <= 0)  left -> 3, right -> 4
node(98,2,5,0).
left_node(98,2,3).
right_node(98,2,4).
% node 3 (leaf): class B (0)
leaf_class(98,3,0).
% node 4 (leaf): class B (0)
leaf_class(98,4,0).
% node 5: f20 <= 12.130000114440918  (F20, bin <= 0)  left -> 6, right -> 7
node(98,5,20,0).
left_node(98,5,6).
right_node(98,5,7).
% node 6 (leaf): class B (0)
leaf_class(98,6,0).
% node 7 (leaf): class M (1)
leaf_class(98,7,1).
% node 8: f13 <= 20.859999656677246  (F13, bin <= 1)  left -> 9, right -> 12
node(98,8,13,1).
left_node(98,8,9).
right_node(98,8,12).
% node 9: f5 <= 0.08616000041365623  (F5, bin <= 5)  left -> 10, right -> 11
node(98,9,5,5).
left_node(98,9,10).
right_node(98,9,11).
% node 10 (leaf): class B (0)
leaf_class(98,10,0).
% node 11 (leaf): class M (1)
leaf_class(98,11,1).
% node 12: f27 <= 0.08502000197768211  (F27, bin <= 1)  left -> 13, right -> 14
node(98,12,27,1).
left_node(98,12,13).
right_node(98,12,14).
% node 13 (leaf): class M (1)
leaf_class(98,13,1).
% node 14 (leaf): class M (1)
leaf_class(98,14,1).

% Tree 99
tree(99).
% node 0: f7 <= 0.0506649985909462  (F7, bin <= 14)  left -> 1, right -> 8
node(99,0,7,14).
left_node(99,0,1).
right_node(99,0,8).
% node 1: f20 <= 15.589999675750732  (F20, bin <= 10)  left -> 2, right -> 5
node(99,1,20,10).
left_node(99,1,2).
right_node(99,1,5).
% node 2: f24 <= 0.14185000211000443  (F24, bin <= 15)  left -> 3, right -> 4
node(99,2,24,15).
left_node(99,2,3).
right_node(99,2,4).
% node 3 (leaf): class B (0)
leaf_class(99,3,0).
% node 4 (leaf): class B (0)
leaf_class(99,4,0).
% node 5: f2 <= 88.24500274658203  (F2, bin <= 3)  left -> 6, right -> 7
node(99,5,2,3).
left_node(99,5,6).
right_node(99,5,7).
% node 6 (leaf): class M (1)
leaf_class(99,6,1).
% node 7 (leaf): class B (0)
leaf_class(99,7,0).
% node 8: f20 <= 15.925000190734863  (F20, bin <= 12)  left -> 9, right -> 12
node(99,8,20,12).
left_node(99,8,9).
right_node(99,8,12).
% node 9: f26 <= 0.3730500042438507  (F26, bin <= 24)  left -> 10, right -> 11
node(99,9,26,24).
left_node(99,9,10).
right_node(99,9,11).
% node 10 (leaf): class B (0)
leaf_class(99,10,0).
% node 11 (leaf): class M (1)
leaf_class(99,11,1).
% node 12: f12 <= 1.2944999933242798  (F12, bin <= 0)  left -> 13, right -> 14
node(99,12,12,0).
left_node(99,12,13).
right_node(99,12,14).
% node 13 (leaf): class B (0)
leaf_class(99,13,0).
% node 14 (leaf): class M (1)
leaf_class(99,14,1).

% --- Class domain ---
class_idx(0).  % B
class_idx(1).  % M
