% ============================================================
% random_forest.lp — RF facts for gamma+telescope
% 20 trees  |  10 features
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
% class_idx(C)       : C is a valid class index.
% ============================================================

% --- Feature bin domains ---
% bin(I,F,B): item I is assigned to bin B for feature F.

% Feature 0 (f0): 90 bins  (thresholds: [12.11709976196289, 12.160599708557129, 12.316049575805664, 12.345149993896484, 12.349100112915039, 17.48449993133545, 17.917250633239746, 17.931949615478516, 17.93340015411377, 17.952150344848633, 17.974599838256836, 18.551100730895996, 19.195199966430664, 26.187199592590332, 27.660449981689453, 27.705599784851074, 28.604899406433105, 28.991400718688965, 29.18875026702881, 29.871049880981445, 30.62814998626709, 30.691600799560547, 31.124850273132324, 31.693750381469727, 31.9864501953125, 32.02880001068115, 32.132901191711426, 32.6440486907959, 33.03285026550293, 33.417598724365234, 33.70314979553223, 33.83889961242676, 37.93550109863281, 38.65345001220703, 40.20734977722168, 40.940500259399414, 41.33015060424805, 41.41559982299805, 41.56105041503906, 45.918800354003906, 46.32680130004883, 46.367401123046875, 46.41670036315918, 46.62350082397461, 47.48640060424805, 47.7012996673584, 49.14580154418945, 54.91805076599121, 56.41510009765625, 57.17290115356445, 57.602149963378906, 61.58264923095703, 72.48014831542969, 90.24739837646484, 90.54150009155273, 90.55760192871094, 94.9666519165039, 95.41489791870117, 96.97700119018555, 99.23710250854492, 100.62425231933594, 100.67300033569336, 102.13199996948242, 103.45225143432617, 103.90049743652344, 105.89749908447266, 107.59354782104492, 107.60854721069336, 107.98800277709961, 108.05244827270508, 110.20650100708008, 113.80500030517578, 114.5989990234375, 114.6884994506836, 114.74349975585938, 115.04929733276367, 115.73925018310547, 116.18050003051758, 116.2983512878418, 116.58200073242188, 117.30350112915039, 117.83805084228516, 117.92749786376953, 117.99845123291016, 118.18999862670898, 118.34099960327148, 118.93104934692383, 125.83649826049805, 134.94429779052734])
{bin(I,0,B) : B = 0..89} = 1 :- item(I).

% Feature 1 (f1): 76 bins  (thresholds: [0.0350000006146729, 0.035100000677630305, 5.801249980926514, 6.08495020866394, 6.125999927520752, 6.554149866104126, 8.98544979095459, 9.59000015258789, 9.5912504196167, 9.604700088500977, 9.666999816894531, 9.702449798583984, 9.820599555969238, 9.821449756622314, 10.346099853515625, 10.460649967193604, 10.550399780273438, 10.551300048828125, 10.579700469970703, 10.597400188446045, 10.620699882507324, 10.75255012512207, 11.272000312805176, 11.350899696350098, 11.554250240325928, 11.724549770355225, 11.74275016784668, 11.852099895477295, 11.969749927520752, 12.117749691009521, 12.147300243377686, 12.511749744415283, 12.512249946594238, 12.519000053405762, 12.569699764251709, 12.653050422668457, 13.408149719238281, 13.524799823760986, 14.332849979400635, 16.822199821472168, 17.981450080871582, 21.04694938659668, 24.16854953765869, 24.24049949645996, 27.760700225830078, 27.789849281311035, 28.11964988708496, 28.819900512695312, 29.450650215148926, 31.968350410461426, 33.2505989074707, 33.792449951171875, 33.97879981994629, 35.74660110473633, 35.888750076293945, 37.83614921569824, 38.27530097961426, 39.79909896850586, 39.96834945678711, 40.080848693847656, 40.56394958496094, 41.54294967651367, 41.55590057373047, 42.34104919433594, 42.99434852600098, 43.28885078430176, 44.80994987487793, 45.54329872131348, 45.71355056762695, 46.03299903869629, 46.463951110839844, 47.09239959716797, 47.82794952392578, 48.23850059509277, 61.81760025024414])
{bin(I,1,B) : B = 0..75} = 1 :- item(I).

% Feature 2 (f2): 70 bins  (thresholds: [2.2233000993728638, 2.3035500049591064, 2.312299966812134, 2.313349962234497, 2.3150500059127808, 2.3152999877929688, 2.316499948501587, 2.319350004196167, 2.3389999866485596, 2.3465999364852905, 2.3793500661849976, 2.384250044822693, 2.3851500749588013, 2.3863000869750977, 2.386750102043152, 2.386949896812439, 2.4040499925613403, 2.409749984741211, 2.4113999605178833, 2.4191499948501587, 2.430999994277954, 2.4463499784469604, 2.4467999935150146, 2.448300004005432, 2.4529500007629395, 2.4536999464035034, 2.4541999101638794, 2.4549999237060547, 2.455199956893921, 2.4562000036239624, 2.4750499725341797, 2.4771499633789062, 2.4805999994277954, 2.489549994468689, 2.4945000410079956, 2.5161499977111816, 2.526300072669983, 2.5293999910354614, 2.5297499895095825, 2.534749984741211, 2.547100067138672, 2.5600000619888306, 2.578850030899048, 2.581049919128418, 2.583750009536743, 2.6018500328063965, 2.6172999143600464, 2.6190500259399414, 2.643149971961975, 2.6744000911712646, 2.6776000261306763, 2.6858500242233276, 2.760800004005432, 2.793500065803528, 2.9347000122070312, 3.020050048828125, 3.2635499238967896, 3.271250009536743, 3.2776999473571777, 3.318650007247925, 3.7474499940872192, 3.7676000595092773, 3.7786500453948975, 3.7792000770568848, 3.894800066947937, 3.944949984550476, 4.1052000522613525, 4.15910005569458, 4.1773998737335205])
{bin(I,2,B) : B = 0..69} = 1 :- item(I).

% Feature 3 (f3): 39 bins  (thresholds: [0.0885000005364418, 0.10215000063180923, 0.14799999445676804, 0.18084999918937683, 0.23514999449253082, 0.26989999413490295, 0.3002000004053116, 0.30265000462532043, 0.3249499946832657, 0.344200000166893, 0.36879999935626984, 0.40344999730587006, 0.4322500079870224, 0.4360000044107437, 0.45055000483989716, 0.4564000070095062, 0.4573500007390976, 0.4708999991416931, 0.4786499887704849, 0.48794999718666077, 0.4919999986886978, 0.5155999958515167, 0.5166500210762024, 0.5234500169754028, 0.5240499973297119, 0.5277500152587891, 0.5298999845981598, 0.5512999892234802, 0.5699000060558319, 0.5736500024795532, 0.5753999948501587, 0.6471499800682068, 0.6480999886989594, 0.6568500101566315, 0.6919499933719635, 0.6999000012874603, 0.722599983215332, 0.7793000042438507])
{bin(I,3,B) : B = 0..38} = 1 :- item(I).

% Feature 4 (f4): 27 bins  (thresholds: [0.04755000025033951, 0.1278500035405159, 0.1464500054717064, 0.15365000069141388, 0.19555000215768814, 0.20044999569654465, 0.20679999887943268, 0.20754999667406082, 0.21005000174045563, 0.21374999731779099, 0.22549999505281448, 0.23420000076293945, 0.23934999853372574, 0.24274999648332596, 0.2565999925136566, 0.30204999446868896, 0.31155000627040863, 0.3144499957561493, 0.31884999573230743, 0.31994999945163727, 0.3467000126838684, 0.40719999372959137, 0.42730000615119934, 0.431999996304512, 0.44769999384880066, 0.48864999413490295])
{bin(I,4,B) : B = 0..26} = 1 :- item(I).

% Feature 5 (f5): 21 bins  (thresholds: [-131.17749786376953, -117.2181510925293, -45.16964912414551, -31.119800567626953, -28.655500411987305, -26.936750411987305, -22.08894920349121, -19.46304988861084, -15.404200077056885, -15.40215015411377, 0.4040500074625015, 19.167150497436523, 24.984749794006348, 25.06209945678711, 26.101200103759766, 26.17484951019287, 28.081900596618652, 43.05570030212402, 57.468299865722656, 81.96850204467773])
{bin(I,5,B) : B = 0..20} = 1 :- item(I).

% Feature 6 (f6): 51 bins  (thresholds: [-89.13069915771484, -88.79045104980469, -83.82939910888672, -83.61005020141602, -67.64299774169922, -67.38694763183594, -55.88669967651367, -53.620248794555664, -53.51969909667969, -52.66024971008301, -52.38195037841797, -51.92580032348633, -50.325599670410156, -44.81170082092285, -38.922149658203125, -38.46419906616211, -37.41365051269531, -34.211050033569336, -34.0078010559082, -33.316349029541016, -30.196749687194824, -29.49275016784668, -27.386500358581543, -26.694950103759766, -20.989700317382812, -10.330299854278564, -6.6575000286102295, -2.0015000104904175, 9.235499858856201, 20.391650199890137, 20.639049530029297, 22.21619987487793, 22.611149787902832, 22.62345027923584, 23.036450386047363, 23.681699752807617, 24.551650047302246, 25.890199661254883, 26.567649841308594, 27.3075008392334, 28.607500076293945, 31.018199920654297, 31.05109977722168, 31.129249572753906, 36.86725044250488, 58.52750015258789, 70.98300170898438, 84.35150146484375, 89.62835311889648, 102.96440124511719])
{bin(I,6,B) : B = 0..50} = 1 :- item(I).

% Feature 7 (f7): 10 bins  (thresholds: [-29.55650043487549, -27.980899810791016, -27.902999877929688, -25.33174991607666, -22.617249488830566, -19.137450218200684, -17.937549591064453, -10.884750366210938, 34.342201232910156])
{bin(I,7,B) : B = 0..9} = 1 :- item(I).

% Feature 8 (f8): 101 bins  (thresholds: [1.8997000455856323, 4.365000009536743, 4.6927502155303955, 4.860550165176392, 5.587500095367432, 5.9079999923706055, 6.220400094985962, 6.837949991226196, 7.078999996185303, 7.081900119781494, 7.0924999713897705, 7.807999849319458, 7.833950042724609, 7.918749809265137, 8.255100011825562, 8.593599796295166, 8.693050384521484, 8.749850273132324, 8.785799980163574, 8.81155014038086, 9.010499954223633, 9.319499969482422, 9.477449893951416, 9.633249759674072, 9.660450458526611, 9.740799903869629, 9.791850090026855, 9.86305046081543, 10.04040002822876, 11.29580020904541, 11.415299892425537, 11.571599960327148, 11.689249992370605, 11.698249816894531, 11.770100116729736, 11.901100158691406, 11.941149711608887, 11.98449993133545, 12.025850296020508, 12.077499866485596, 12.110849857330322, 12.686299800872803, 13.735249996185303, 14.310850143432617, 14.321899890899658, 15.456900119781494, 15.593649864196777, 17.132200241088867, 19.563749313354492, 20.082300186157227, 20.12950038909912, 20.875500679016113, 21.064099311828613, 21.67574977874756, 21.677149772644043, 22.458849906921387, 23.987350463867188, 24.040550231933594, 24.10550022125244, 24.324999809265137, 24.40255069732666, 24.860549926757812, 25.089350700378418, 25.24250030517578, 26.109050750732422, 26.74250030517578, 27.14169979095459, 27.17940044403076, 27.44694995880127, 27.702500343322754, 28.5027494430542, 31.9195499420166, 31.91960048675537, 32.02935028076172, 32.04330062866211, 32.36364936828613, 33.674400329589844, 34.239999771118164, 35.27084922790527, 36.146751403808594, 36.46150016784668, 38.83440017700195, 41.48330116271973, 41.8435001373291, 41.88549995422363, 41.92880058288574, 42.17890167236328, 42.77655029296875, 42.990150451660156, 43.17449951171875, 45.22999954223633, 46.19154930114746, 48.05364990234375, 49.96860122680664, 50.062049865722656, 51.460248947143555, 52.755001068115234, 52.7851505279541, 54.66720008850098, 57.99989891052246])
{bin(I,8,B) : B = 0..100} = 1 :- item(I).

% Feature 9 (f9): 33 bins  (thresholds: [86.46260070800781, 98.20574951171875, 107.36000061035156, 134.51849365234375, 146.0294952392578, 146.11904907226562, 155.6240997314453, 162.54399871826172, 170.32424926757812, 173.2949981689453, 191.02449798583984, 192.67449951171875, 192.73149871826172, 198.5398941040039, 198.59764862060547, 201.33649444580078, 201.64490509033203, 208.38700103759766, 210.00749969482422, 212.55530548095703, 213.3365020751953, 217.14960479736328, 217.15960693359375, 217.16100311279297, 219.3969955444336, 225.93014526367188, 238.8665008544922, 239.02399444580078, 239.38300323486328, 257.564697265625, 283.68280029296875, 361.2515106201172])
{bin(I,9,B) : B = 0..32} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f1 <= 43.28885078430176  (F1, bin <= 65)  left -> 1, right -> 46
node(0,0,1,65).
left_node(0,0,1).
right_node(0,0,46).
% node 1: f8 <= 21.677149772644043  (F8, bin <= 54)  left -> 2, right -> 25
node(0,1,8,54).
left_node(0,1,2).
right_node(0,1,25).
% node 2: f1 <= 12.512249946594238  (F1, bin <= 32)  left -> 3, right -> 12
node(0,2,1,32).
left_node(0,2,3).
right_node(0,2,12).
% node 3: f2 <= 2.526300072669983  (F2, bin <= 36)  left -> 4, right -> 5
node(0,3,2,36).
left_node(0,3,4).
right_node(0,3,5).
% node 4 (leaf): class g (0)
leaf_class(0,4,0).
% node 5: f1 <= 9.702449798583984  (F1, bin <= 11)  left -> 6, right -> 7
node(0,5,1,11).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class h (1)
leaf_class(0,6,1).
% node 7: f3 <= 0.4708999991416931  (F3, bin <= 17)  left -> 8, right -> 11
node(0,7,3,17).
left_node(0,7,8).
right_node(0,7,11).
% node 8: f8 <= 7.078999996185303  (F8, bin <= 8)  left -> 9, right -> 10
node(0,8,8,8).
left_node(0,8,9).
right_node(0,8,10).
% node 9 (leaf): class g (0)
leaf_class(0,9,0).
% node 10 (leaf): class g (0)
leaf_class(0,10,0).
% node 11 (leaf): class h (1)
leaf_class(0,11,1).
% node 12: f0 <= 118.18999862670898  (F0, bin <= 84)  left -> 13, right -> 22
node(0,12,0,84).
left_node(0,12,13).
right_node(0,12,22).
% node 13: f8 <= 9.740799903869629  (F8, bin <= 25)  left -> 14, right -> 17
node(0,13,8,25).
left_node(0,13,14).
right_node(0,13,17).
% node 14: f3 <= 0.5298999845981598  (F3, bin <= 26)  left -> 15, right -> 16
node(0,14,3,26).
left_node(0,14,15).
right_node(0,14,16).
% node 15 (leaf): class g (0)
leaf_class(0,15,0).
% node 16 (leaf): class h (1)
leaf_class(0,16,1).
% node 17: f1 <= 28.11964988708496  (F1, bin <= 46)  left -> 18, right -> 21
node(0,17,1,46).
left_node(0,17,18).
right_node(0,17,21).
% node 18: f6 <= -30.196749687194824  (F6, bin <= 20)  left -> 19, right -> 20
node(0,18,6,20).
left_node(0,18,19).
right_node(0,18,20).
% node 19 (leaf): class g (0)
leaf_class(0,19,0).
% node 20 (leaf): class g (0)
leaf_class(0,20,0).
% node 21 (leaf): class g (0)
leaf_class(0,21,0).
% node 22: f6 <= 70.98300170898438  (F6, bin <= 46)  left -> 23, right -> 24
node(0,22,6,46).
left_node(0,22,23).
right_node(0,22,24).
% node 23 (leaf): class h (1)
leaf_class(0,23,1).
% node 24 (leaf): class g (0)
leaf_class(0,24,0).
% node 25: f9 <= 217.14960479736328  (F9, bin <= 21)  left -> 26, right -> 43
node(0,25,9,21).
left_node(0,25,26).
right_node(0,25,43).
% node 26: f6 <= 23.036450386047363  (F6, bin <= 34)  left -> 27, right -> 36
node(0,26,6,34).
left_node(0,26,27).
right_node(0,26,36).
% node 27: f5 <= -26.936750411987305  (F5, bin <= 5)  left -> 28, right -> 29
node(0,27,5,5).
left_node(0,27,28).
right_node(0,27,29).
% node 28 (leaf): class h (1)
leaf_class(0,28,1).
% node 29: f0 <= 31.124850273132324  (F0, bin <= 22)  left -> 30, right -> 33
node(0,29,0,22).
left_node(0,29,30).
right_node(0,29,33).
% node 30: f8 <= 48.05364990234375  (F8, bin <= 92)  left -> 31, right -> 32
node(0,30,8,92).
left_node(0,30,31).
right_node(0,30,32).
% node 31 (leaf): class g (0)
leaf_class(0,31,0).
% node 32 (leaf): class g (0)
leaf_class(0,32,0).
% node 33: f4 <= 0.20679999887943268  (F4, bin <= 6)  left -> 34, right -> 35
node(0,33,4,6).
left_node(0,33,34).
right_node(0,33,35).
% node 34 (leaf): class h (1)
leaf_class(0,34,1).
% node 35 (leaf): class h (1)
leaf_class(0,35,1).
% node 36: f0 <= 45.918800354003906  (F0, bin <= 39)  left -> 37, right -> 42
node(0,36,0,39).
left_node(0,36,37).
right_node(0,36,42).
% node 37: f9 <= 198.5398941040039  (F9, bin <= 13)  left -> 38, right -> 41
node(0,37,9,13).
left_node(0,37,38).
right_node(0,37,41).
% node 38: f8 <= 41.8435001373291  (F8, bin <= 83)  left -> 39, right -> 40
node(0,38,8,83).
left_node(0,38,39).
right_node(0,38,40).
% node 39 (leaf): class g (0)
leaf_class(0,39,0).
% node 40 (leaf): class h (1)
leaf_class(0,40,1).
% node 41 (leaf): class h (1)
leaf_class(0,41,1).
% node 42 (leaf): class h (1)
leaf_class(0,42,1).
% node 43: f2 <= 2.409749984741211  (F2, bin <= 17)  left -> 44, right -> 45
node(0,43,2,17).
left_node(0,43,44).
right_node(0,43,45).
% node 44 (leaf): class g (0)
leaf_class(0,44,0).
% node 45 (leaf): class h (1)
leaf_class(0,45,1).
% node 46: f2 <= 4.15910005569458  (F2, bin <= 67)  left -> 47, right -> 48
node(0,46,2,67).
left_node(0,46,47).
right_node(0,46,48).
% node 47 (leaf): class h (1)
leaf_class(0,47,1).
% node 48: f8 <= 6.220400094985962  (F8, bin <= 6)  left -> 49, right -> 50
node(0,48,8,6).
left_node(0,48,49).
right_node(0,48,50).
% node 49 (leaf): class g (0)
leaf_class(0,49,0).
% node 50 (leaf): class h (1)
leaf_class(0,50,1).

% Tree 1
tree(1).
% node 0: f6 <= -50.325599670410156  (F6, bin <= 12)  left -> 1, right -> 6
node(1,0,6,12).
left_node(1,0,1).
right_node(1,0,6).
% node 1: f8 <= 4.365000009536743  (F8, bin <= 1)  left -> 2, right -> 5
node(1,1,8,1).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f4 <= 0.1278500035405159  (F4, bin <= 1)  left -> 3, right -> 4
node(1,2,4,1).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class h (1)
leaf_class(1,3,1).
% node 4 (leaf): class g (0)
leaf_class(1,4,0).
% node 5 (leaf): class h (1)
leaf_class(1,5,1).
% node 6: f1 <= 45.71355056762695  (F1, bin <= 68)  left -> 7, right -> 46
node(1,6,1,68).
left_node(1,6,7).
right_node(1,6,46).
% node 7: f8 <= 27.44694995880127  (F8, bin <= 68)  left -> 8, right -> 29
node(1,7,8,68).
left_node(1,7,8).
right_node(1,7,29).
% node 8: f8 <= 13.735249996185303  (F8, bin <= 42)  left -> 9, right -> 18
node(1,8,8,42).
left_node(1,8,9).
right_node(1,8,18).
% node 9: f3 <= 0.40344999730587006  (F3, bin <= 11)  left -> 10, right -> 13
node(1,9,3,11).
left_node(1,9,10).
right_node(1,9,13).
% node 10: f0 <= 117.92749786376953  (F0, bin <= 82)  left -> 11, right -> 12
node(1,10,0,82).
left_node(1,10,11).
right_node(1,10,12).
% node 11 (leaf): class g (0)
leaf_class(1,11,0).
% node 12 (leaf): class h (1)
leaf_class(1,12,1).
% node 13: f4 <= 0.31994999945163727  (F4, bin <= 19)  left -> 14, right -> 15
node(1,13,4,19).
left_node(1,13,14).
right_node(1,13,15).
% node 14 (leaf): class g (0)
leaf_class(1,14,0).
% node 15: f2 <= 2.583750009536743  (F2, bin <= 44)  left -> 16, right -> 17
node(1,15,2,44).
left_node(1,15,16).
right_node(1,15,17).
% node 16 (leaf): class g (0)
leaf_class(1,16,0).
% node 17 (leaf): class h (1)
leaf_class(1,17,1).
% node 18: f0 <= 46.367401123046875  (F0, bin <= 41)  left -> 19, right -> 24
node(1,18,0,41).
left_node(1,18,19).
right_node(1,18,24).
% node 19: f1 <= 10.551300048828125  (F1, bin <= 17)  left -> 20, right -> 23
node(1,19,1,17).
left_node(1,19,20).
right_node(1,19,23).
% node 20: f2 <= 2.4562000036239624  (F2, bin <= 29)  left -> 21, right -> 22
node(1,20,2,29).
left_node(1,20,21).
right_node(1,20,22).
% node 21 (leaf): class g (0)
leaf_class(1,21,0).
% node 22 (leaf): class h (1)
leaf_class(1,22,1).
% node 23 (leaf): class g (0)
leaf_class(1,23,0).
% node 24: f0 <= 99.23710250854492  (F0, bin <= 59)  left -> 25, right -> 28
node(1,24,0,59).
left_node(1,24,25).
right_node(1,24,28).
% node 25: f1 <= 12.569699764251709  (F1, bin <= 34)  left -> 26, right -> 27
node(1,25,1,34).
left_node(1,25,26).
right_node(1,25,27).
% node 26 (leaf): class h (1)
leaf_class(1,26,1).
% node 27 (leaf): class g (0)
leaf_class(1,27,0).
% node 28 (leaf): class h (1)
leaf_class(1,28,1).
% node 29: f0 <= 33.83889961242676  (F0, bin <= 31)  left -> 30, right -> 39
node(1,29,0,31).
left_node(1,29,30).
right_node(1,29,39).
% node 30: f9 <= 212.55530548095703  (F9, bin <= 19)  left -> 31, right -> 38
node(1,30,9,19).
left_node(1,30,31).
right_node(1,30,38).
% node 31: f2 <= 2.384250044822693  (F2, bin <= 11)  left -> 32, right -> 35
node(1,31,2,11).
left_node(1,31,32).
right_node(1,31,35).
% node 32: f0 <= 12.316049575805664  (F0, bin <= 2)  left -> 33, right -> 34
node(1,32,0,2).
left_node(1,32,33).
right_node(1,32,34).
% node 33 (leaf): class h (1)
leaf_class(1,33,1).
% node 34 (leaf): class g (0)
leaf_class(1,34,0).
% node 35: f8 <= 52.755001068115234  (F8, bin <= 96)  left -> 36, right -> 37
node(1,35,8,96).
left_node(1,35,36).
right_node(1,35,37).
% node 36 (leaf): class g (0)
leaf_class(1,36,0).
% node 37 (leaf): class h (1)
leaf_class(1,37,1).
% node 38 (leaf): class h (1)
leaf_class(1,38,1).
% node 39: f9 <= 134.51849365234375  (F9, bin <= 3)  left -> 40, right -> 45
node(1,39,9,3).
left_node(1,39,40).
right_node(1,39,45).
% node 40: f3 <= 0.3002000004053116  (F3, bin <= 6)  left -> 41, right -> 44
node(1,40,3,6).
left_node(1,40,41).
right_node(1,40,44).
% node 41: f0 <= 61.58264923095703  (F0, bin <= 51)  left -> 42, right -> 43
node(1,41,0,51).
left_node(1,41,42).
right_node(1,41,43).
% node 42 (leaf): class g (0)
leaf_class(1,42,0).
% node 43 (leaf): class h (1)
leaf_class(1,43,1).
% node 44 (leaf): class h (1)
leaf_class(1,44,1).
% node 45 (leaf): class h (1)
leaf_class(1,45,1).
% node 46: f4 <= 0.04755000025033951  (F4, bin <= 0)  left -> 47, right -> 48
node(1,46,4,0).
left_node(1,46,47).
right_node(1,46,48).
% node 47 (leaf): class h (1)
leaf_class(1,47,1).
% node 48 (leaf): class h (1)
leaf_class(1,48,1).

% Tree 2
tree(2).
% node 0: f8 <= 24.860549926757812  (F8, bin <= 61)  left -> 1, right -> 30
node(2,0,8,61).
left_node(2,0,1).
right_node(2,0,30).
% node 1: f1 <= 47.09239959716797  (F1, bin <= 71)  left -> 2, right -> 25
node(2,1,1,71).
left_node(2,1,2).
right_node(2,1,25).
% node 2: f0 <= 114.6884994506836  (F0, bin <= 73)  left -> 3, right -> 24
node(2,2,0,73).
left_node(2,2,3).
right_node(2,2,24).
% node 3: f1 <= 10.597400188446045  (F1, bin <= 19)  left -> 4, right -> 15
node(2,3,1,19).
left_node(2,3,4).
right_node(2,3,15).
% node 4: f8 <= 9.477449893951416  (F8, bin <= 22)  left -> 5, right -> 10
node(2,4,8,22).
left_node(2,4,5).
right_node(2,4,10).
% node 5: f6 <= -6.6575000286102295  (F6, bin <= 26)  left -> 6, right -> 7
node(2,5,6,26).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class g (0)
leaf_class(2,6,0).
% node 7: f2 <= 2.581049919128418  (F2, bin <= 43)  left -> 8, right -> 9
node(2,7,2,43).
left_node(2,7,8).
right_node(2,7,9).
% node 8 (leaf): class g (0)
leaf_class(2,8,0).
% node 9 (leaf): class h (1)
leaf_class(2,9,1).
% node 10: f3 <= 0.4360000044107437  (F3, bin <= 13)  left -> 11, right -> 12
node(2,10,3,13).
left_node(2,10,11).
right_node(2,10,12).
% node 11 (leaf): class h (1)
leaf_class(2,11,1).
% node 12: f2 <= 2.448300004005432  (F2, bin <= 23)  left -> 13, right -> 14
node(2,12,2,23).
left_node(2,12,13).
right_node(2,12,14).
% node 13 (leaf): class g (0)
leaf_class(2,13,0).
% node 14 (leaf): class h (1)
leaf_class(2,14,1).
% node 15: f6 <= -67.64299774169922  (F6, bin <= 4)  left -> 16, right -> 19
node(2,15,6,4).
left_node(2,15,16).
right_node(2,15,19).
% node 16: f8 <= 8.255100011825562  (F8, bin <= 14)  left -> 17, right -> 18
node(2,16,8,14).
left_node(2,16,17).
right_node(2,16,18).
% node 17 (leaf): class g (0)
leaf_class(2,17,0).
% node 18 (leaf): class h (1)
leaf_class(2,18,1).
% node 19: f3 <= 0.4573500007390976  (F3, bin <= 16)  left -> 20, right -> 21
node(2,19,3,16).
left_node(2,19,20).
right_node(2,19,21).
% node 20 (leaf): class g (0)
leaf_class(2,20,0).
% node 21: f2 <= 2.578850030899048  (F2, bin <= 42)  left -> 22, right -> 23
node(2,21,2,42).
left_node(2,21,22).
right_node(2,21,23).
% node 22 (leaf): class g (0)
leaf_class(2,22,0).
% node 23 (leaf): class h (1)
leaf_class(2,23,1).
% node 24 (leaf): class h (1)
leaf_class(2,24,1).
% node 25: f2 <= 4.1052000522613525  (F2, bin <= 66)  left -> 26, right -> 27
node(2,25,2,66).
left_node(2,25,26).
right_node(2,25,27).
% node 26 (leaf): class h (1)
leaf_class(2,26,1).
% node 27: f0 <= 134.94429779052734  (F0, bin <= 88)  left -> 28, right -> 29
node(2,27,0,88).
left_node(2,27,28).
right_node(2,27,29).
% node 28 (leaf): class g (0)
leaf_class(2,28,0).
% node 29 (leaf): class h (1)
leaf_class(2,29,1).
% node 30: f1 <= 28.819900512695312  (F1, bin <= 47)  left -> 31, right -> 58
node(2,30,1,47).
left_node(2,30,31).
right_node(2,30,58).
% node 31: f2 <= 2.4040499925613403  (F2, bin <= 16)  left -> 32, right -> 43
node(2,31,2,16).
left_node(2,31,32).
right_node(2,31,43).
% node 32: f2 <= 2.3150500059127808  (F2, bin <= 4)  left -> 33, right -> 36
node(2,32,2,4).
left_node(2,32,33).
right_node(2,32,36).
% node 33: f0 <= 12.345149993896484  (F0, bin <= 3)  left -> 34, right -> 35
node(2,33,0,3).
left_node(2,33,34).
right_node(2,33,35).
% node 34 (leaf): class h (1)
leaf_class(2,34,1).
% node 35 (leaf): class g (0)
leaf_class(2,35,0).
% node 36: f4 <= 0.44769999384880066  (F4, bin <= 24)  left -> 37, right -> 42
node(2,36,4,24).
left_node(2,36,37).
right_node(2,36,42).
% node 37: f8 <= 51.460248947143555  (F8, bin <= 95)  left -> 38, right -> 39
node(2,37,8,95).
left_node(2,37,38).
right_node(2,37,39).
% node 38 (leaf): class g (0)
leaf_class(2,38,0).
% node 39: f0 <= 28.604899406433105  (F0, bin <= 16)  left -> 40, right -> 41
node(2,39,0,16).
left_node(2,39,40).
right_node(2,39,41).
% node 40 (leaf): class g (0)
leaf_class(2,40,0).
% node 41 (leaf): class h (1)
leaf_class(2,41,1).
% node 42 (leaf): class h (1)
leaf_class(2,42,1).
% node 43: f9 <= 201.33649444580078  (F9, bin <= 15)  left -> 44, right -> 51
node(2,43,9,15).
left_node(2,43,44).
right_node(2,43,51).
% node 44: f0 <= 37.93550109863281  (F0, bin <= 32)  left -> 45, right -> 50
node(2,44,0,32).
left_node(2,44,45).
right_node(2,44,50).
% node 45: f1 <= 11.350899696350098  (F1, bin <= 23)  left -> 46, right -> 47
node(2,45,1,23).
left_node(2,45,46).
right_node(2,45,47).
% node 46 (leaf): class h (1)
leaf_class(2,46,1).
% node 47: f6 <= 31.05109977722168  (F6, bin <= 42)  left -> 48, right -> 49
node(2,47,6,42).
left_node(2,47,48).
right_node(2,47,49).
% node 48 (leaf): class g (0)
leaf_class(2,48,0).
% node 49 (leaf): class h (1)
leaf_class(2,49,1).
% node 50 (leaf): class h (1)
leaf_class(2,50,1).
% node 51: f0 <= 33.03285026550293  (F0, bin <= 28)  left -> 52, right -> 57
node(2,51,0,28).
left_node(2,51,52).
right_node(2,51,57).
% node 52: f2 <= 2.4113999605178833  (F2, bin <= 18)  left -> 53, right -> 54
node(2,52,2,18).
left_node(2,52,53).
right_node(2,52,54).
% node 53 (leaf): class g (0)
leaf_class(2,53,0).
% node 54: f1 <= 13.408149719238281  (F1, bin <= 36)  left -> 55, right -> 56
node(2,54,1,36).
left_node(2,54,55).
right_node(2,54,56).
% node 55 (leaf): class h (1)
leaf_class(2,55,1).
% node 56 (leaf): class h (1)
leaf_class(2,56,1).
% node 57 (leaf): class h (1)
leaf_class(2,57,1).
% node 58 (leaf): class h (1)
leaf_class(2,58,1).

% Tree 3
tree(3).
% node 0: f0 <= 114.5989990234375  (F0, bin <= 72)  left -> 1, right -> 48
node(3,0,0,72).
left_node(3,0,1).
right_node(3,0,48).
% node 1: f3 <= 0.344200000166893  (F3, bin <= 9)  left -> 2, right -> 23
node(3,1,3,9).
left_node(3,1,2).
right_node(3,1,23).
% node 2: f1 <= 40.56394958496094  (F1, bin <= 60)  left -> 3, right -> 16
node(3,2,1,60).
left_node(3,2,3).
right_node(3,2,16).
% node 3: f6 <= -34.0078010559082  (F6, bin <= 18)  left -> 4, right -> 7
node(3,3,6,18).
left_node(3,3,4).
right_node(3,3,7).
% node 4: f8 <= 9.791850090026855  (F8, bin <= 26)  left -> 5, right -> 6
node(3,4,8,26).
left_node(3,4,5).
right_node(3,4,6).
% node 5 (leaf): class g (0)
leaf_class(3,5,0).
% node 6 (leaf): class h (1)
leaf_class(3,6,1).
% node 7: f8 <= 24.10550022125244  (F8, bin <= 58)  left -> 8, right -> 9
node(3,7,8,58).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class g (0)
leaf_class(3,8,0).
% node 9: f8 <= 43.17449951171875  (F8, bin <= 89)  left -> 10, right -> 13
node(3,9,8,89).
left_node(3,9,10).
right_node(3,9,13).
% node 10: f0 <= 57.602149963378906  (F0, bin <= 50)  left -> 11, right -> 12
node(3,10,0,50).
left_node(3,10,11).
right_node(3,10,12).
% node 11 (leaf): class g (0)
leaf_class(3,11,0).
% node 12 (leaf): class h (1)
leaf_class(3,12,1).
% node 13: f9 <= 146.11904907226562  (F9, bin <= 5)  left -> 14, right -> 15
node(3,13,9,5).
left_node(3,13,14).
right_node(3,13,15).
% node 14 (leaf): class h (1)
leaf_class(3,14,1).
% node 15 (leaf): class h (1)
leaf_class(3,15,1).
% node 16: f3 <= 0.10215000063180923  (F3, bin <= 1)  left -> 17, right -> 20
node(3,16,3,1).
left_node(3,16,17).
right_node(3,16,20).
% node 17: f8 <= 9.319499969482422  (F8, bin <= 21)  left -> 18, right -> 19
node(3,17,8,21).
left_node(3,17,18).
right_node(3,17,19).
% node 18 (leaf): class g (0)
leaf_class(3,18,0).
% node 19 (leaf): class h (1)
leaf_class(3,19,1).
% node 20: f1 <= 47.82794952392578  (F1, bin <= 72)  left -> 21, right -> 22
node(3,20,1,72).
left_node(3,20,21).
right_node(3,20,22).
% node 21 (leaf): class h (1)
leaf_class(3,21,1).
% node 22 (leaf): class h (1)
leaf_class(3,22,1).
% node 23: f8 <= 33.674400329589844  (F8, bin <= 76)  left -> 24, right -> 37
node(3,23,8,76).
left_node(3,23,24).
right_node(3,23,37).
% node 24: f1 <= 24.16854953765869  (F1, bin <= 42)  left -> 25, right -> 36
node(3,24,1,42).
left_node(3,24,25).
right_node(3,24,36).
% node 25: f6 <= -2.0015000104904175  (F6, bin <= 27)  left -> 26, right -> 29
node(3,25,6,27).
left_node(3,25,26).
right_node(3,25,29).
% node 26: f2 <= 2.9347000122070312  (F2, bin <= 54)  left -> 27, right -> 28
node(3,26,2,54).
left_node(3,26,27).
right_node(3,26,28).
% node 27 (leaf): class g (0)
leaf_class(3,27,0).
% node 28 (leaf): class h (1)
leaf_class(3,28,1).
% node 29: f8 <= 11.770100116729736  (F8, bin <= 34)  left -> 30, right -> 33
node(3,29,8,34).
left_node(3,29,30).
right_node(3,29,33).
% node 30: f0 <= 17.952150344848633  (F0, bin <= 9)  left -> 31, right -> 32
node(3,30,0,9).
left_node(3,30,31).
right_node(3,30,32).
% node 31 (leaf): class g (0)
leaf_class(3,31,0).
% node 32 (leaf): class g (0)
leaf_class(3,32,0).
% node 33: f2 <= 2.5293999910354614  (F2, bin <= 37)  left -> 34, right -> 35
node(3,33,2,37).
left_node(3,33,34).
right_node(3,33,35).
% node 34 (leaf): class g (0)
leaf_class(3,34,0).
% node 35 (leaf): class g (0)
leaf_class(3,35,0).
% node 36 (leaf): class h (1)
leaf_class(3,36,1).
% node 37: f9 <= 217.16100311279297  (F9, bin <= 23)  left -> 38, right -> 45
node(3,37,9,23).
left_node(3,37,38).
right_node(3,37,45).
% node 38: f0 <= 28.991400718688965  (F0, bin <= 17)  left -> 39, right -> 44
node(3,38,0,17).
left_node(3,38,39).
right_node(3,38,44).
% node 39: f5 <= 26.17484951019287  (F5, bin <= 15)  left -> 40, right -> 43
node(3,39,5,15).
left_node(3,39,40).
right_node(3,39,43).
% node 40: f3 <= 0.6919499933719635  (F3, bin <= 34)  left -> 41, right -> 42
node(3,40,3,34).
left_node(3,40,41).
right_node(3,40,42).
% node 41 (leaf): class g (0)
leaf_class(3,41,0).
% node 42 (leaf): class g (0)
leaf_class(3,42,0).
% node 43 (leaf): class h (1)
leaf_class(3,43,1).
% node 44 (leaf): class h (1)
leaf_class(3,44,1).
% node 45: f2 <= 2.3863000869750977  (F2, bin <= 13)  left -> 46, right -> 47
node(3,45,2,13).
left_node(3,45,46).
right_node(3,45,47).
% node 46 (leaf): class g (0)
leaf_class(3,46,0).
% node 47 (leaf): class h (1)
leaf_class(3,47,1).
% node 48: f1 <= 33.2505989074707  (F1, bin <= 50)  left -> 49, right -> 50
node(3,48,1,50).
left_node(3,48,49).
right_node(3,48,50).
% node 49 (leaf): class h (1)
leaf_class(3,49,1).
% node 50 (leaf): class h (1)
leaf_class(3,50,1).

% Tree 4
tree(4).
% node 0: f1 <= 41.54294967651367  (F1, bin <= 61)  left -> 1, right -> 40
node(4,0,1,61).
left_node(4,0,1).
right_node(4,0,40).
% node 1: f3 <= 0.3249499946832657  (F3, bin <= 8)  left -> 2, right -> 19
node(4,1,3,8).
left_node(4,1,2).
right_node(4,1,19).
% node 2: f5 <= -117.2181510925293  (F5, bin <= 1)  left -> 3, right -> 6
node(4,2,5,1).
left_node(4,2,3).
right_node(4,2,6).
% node 3: f8 <= 11.98449993133545  (F8, bin <= 37)  left -> 4, right -> 5
node(4,3,8,37).
left_node(4,3,4).
right_node(4,3,5).
% node 4 (leaf): class g (0)
leaf_class(4,4,0).
% node 5 (leaf): class h (1)
leaf_class(4,5,1).
% node 6: f0 <= 113.80500030517578  (F0, bin <= 71)  left -> 7, right -> 18
node(4,6,0,71).
left_node(4,6,7).
right_node(4,6,18).
% node 7: f1 <= 14.332849979400635  (F1, bin <= 38)  left -> 8, right -> 11
node(4,7,1,38).
left_node(4,7,8).
right_node(4,7,11).
% node 8: f4 <= 0.1464500054717064  (F4, bin <= 2)  left -> 9, right -> 10
node(4,8,4,2).
left_node(4,8,9).
right_node(4,8,10).
% node 9 (leaf): class h (1)
leaf_class(4,9,1).
% node 10 (leaf): class g (0)
leaf_class(4,10,0).
% node 11: f9 <= 98.20574951171875  (F9, bin <= 1)  left -> 12, right -> 15
node(4,11,9,1).
left_node(4,11,12).
right_node(4,11,15).
% node 12: f0 <= 49.14580154418945  (F0, bin <= 46)  left -> 13, right -> 14
node(4,12,0,46).
left_node(4,12,13).
right_node(4,12,14).
% node 13 (leaf): class g (0)
leaf_class(4,13,0).
% node 14 (leaf): class h (1)
leaf_class(4,14,1).
% node 15: f8 <= 24.324999809265137  (F8, bin <= 59)  left -> 16, right -> 17
node(4,15,8,59).
left_node(4,15,16).
right_node(4,15,17).
% node 16 (leaf): class g (0)
leaf_class(4,16,0).
% node 17 (leaf): class h (1)
leaf_class(4,17,1).
% node 18 (leaf): class h (1)
leaf_class(4,18,1).
% node 19: f0 <= 90.24739837646484  (F0, bin <= 53)  left -> 20, right -> 37
node(4,19,0,53).
left_node(4,19,20).
right_node(4,19,37).
% node 20: f0 <= 12.349100112915039  (F0, bin <= 4)  left -> 21, right -> 22
node(4,20,0,4).
left_node(4,20,21).
right_node(4,20,22).
% node 21 (leaf): class h (1)
leaf_class(4,21,1).
% node 22: f9 <= 213.3365020751953  (F9, bin <= 20)  left -> 23, right -> 30
node(4,22,9,20).
left_node(4,22,23).
right_node(4,22,30).
% node 23: f1 <= 9.820599555969238  (F1, bin <= 12)  left -> 24, right -> 27
node(4,23,1,12).
left_node(4,23,24).
right_node(4,23,27).
% node 24: f2 <= 2.386949896812439  (F2, bin <= 15)  left -> 25, right -> 26
node(4,24,2,15).
left_node(4,24,25).
right_node(4,24,26).
% node 25 (leaf): class g (0)
leaf_class(4,25,0).
% node 26 (leaf): class h (1)
leaf_class(4,26,1).
% node 27: f0 <= 41.33015060424805  (F0, bin <= 36)  left -> 28, right -> 29
node(4,27,0,36).
left_node(4,27,28).
right_node(4,27,29).
% node 28 (leaf): class g (0)
leaf_class(4,28,0).
% node 29 (leaf): class h (1)
leaf_class(4,29,1).
% node 30: f8 <= 34.239999771118164  (F8, bin <= 77)  left -> 31, right -> 34
node(4,30,8,77).
left_node(4,30,31).
right_node(4,30,34).
% node 31: f0 <= 17.974599838256836  (F0, bin <= 10)  left -> 32, right -> 33
node(4,31,0,10).
left_node(4,31,32).
right_node(4,31,33).
% node 32 (leaf): class h (1)
leaf_class(4,32,1).
% node 33 (leaf): class g (0)
leaf_class(4,33,0).
% node 34: f6 <= 23.681699752807617  (F6, bin <= 35)  left -> 35, right -> 36
node(4,34,6,35).
left_node(4,34,35).
right_node(4,34,36).
% node 35 (leaf): class h (1)
leaf_class(4,35,1).
% node 36 (leaf): class h (1)
leaf_class(4,36,1).
% node 37: f8 <= 7.0924999713897705  (F8, bin <= 10)  left -> 38, right -> 39
node(4,37,8,10).
left_node(4,37,38).
right_node(4,37,39).
% node 38 (leaf): class g (0)
leaf_class(4,38,0).
% node 39 (leaf): class h (1)
leaf_class(4,39,1).
% node 40: f0 <= 117.30350112915039  (F0, bin <= 80)  left -> 41, right -> 46
node(4,40,0,80).
left_node(4,40,41).
right_node(4,40,46).
% node 41: f8 <= 8.749850273132324  (F8, bin <= 17)  left -> 42, right -> 45
node(4,41,8,17).
left_node(4,41,42).
right_node(4,41,45).
% node 42: f2 <= 3.7676000595092773  (F2, bin <= 61)  left -> 43, right -> 44
node(4,42,2,61).
left_node(4,42,43).
right_node(4,42,44).
% node 43 (leaf): class h (1)
leaf_class(4,43,1).
% node 44 (leaf): class g (0)
leaf_class(4,44,0).
% node 45 (leaf): class h (1)
leaf_class(4,45,1).
% node 46 (leaf): class h (1)
leaf_class(4,46,1).

% Tree 5
tree(5).
% node 0: f8 <= 21.677149772644043  (F8, bin <= 54)  left -> 1, right -> 30
node(5,0,8,54).
left_node(5,0,1).
right_node(5,0,30).
% node 1: f1 <= 46.463951110839844  (F1, bin <= 70)  left -> 2, right -> 25
node(5,1,1,70).
left_node(5,1,2).
right_node(5,1,25).
% node 2: f6 <= -55.88669967651367  (F6, bin <= 6)  left -> 3, right -> 10
node(5,2,6,6).
left_node(5,2,3).
right_node(5,2,10).
% node 3: f2 <= 2.4945000410079956  (F2, bin <= 34)  left -> 4, right -> 5
node(5,3,2,34).
left_node(5,3,4).
right_node(5,3,5).
% node 4 (leaf): class g (0)
leaf_class(5,4,0).
% node 5: f6 <= -83.82939910888672  (F6, bin <= 2)  left -> 6, right -> 7
node(5,5,6,2).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class h (1)
leaf_class(5,6,1).
% node 7: f8 <= 7.918749809265137  (F8, bin <= 13)  left -> 8, right -> 9
node(5,7,8,13).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class g (0)
leaf_class(5,8,0).
% node 9 (leaf): class h (1)
leaf_class(5,9,1).
% node 10: f3 <= 0.4919999986886978  (F3, bin <= 20)  left -> 11, right -> 22
node(5,10,3,20).
left_node(5,10,11).
right_node(5,10,22).
% node 11: f2 <= 3.2776999473571777  (F2, bin <= 58)  left -> 12, right -> 19
node(5,11,2,58).
left_node(5,11,12).
right_node(5,11,19).
% node 12: f8 <= 11.698249816894531  (F8, bin <= 33)  left -> 13, right -> 16
node(5,12,8,33).
left_node(5,12,13).
right_node(5,12,16).
% node 13: f1 <= 35.888750076293945  (F1, bin <= 54)  left -> 14, right -> 15
node(5,13,1,54).
left_node(5,13,14).
right_node(5,13,15).
% node 14 (leaf): class g (0)
leaf_class(5,14,0).
% node 15 (leaf): class h (1)
leaf_class(5,15,1).
% node 16: f9 <= 238.8665008544922  (F9, bin <= 26)  left -> 17, right -> 18
node(5,16,9,26).
left_node(5,16,17).
right_node(5,16,18).
% node 17 (leaf): class g (0)
leaf_class(5,17,0).
% node 18 (leaf): class g (0)
leaf_class(5,18,0).
% node 19: f8 <= 15.593649864196777  (F8, bin <= 46)  left -> 20, right -> 21
node(5,19,8,46).
left_node(5,19,20).
right_node(5,19,21).
% node 20 (leaf): class g (0)
leaf_class(5,20,0).
% node 21 (leaf): class g (0)
leaf_class(5,21,0).
% node 22: f2 <= 2.5161499977111816  (F2, bin <= 35)  left -> 23, right -> 24
node(5,22,2,35).
left_node(5,22,23).
right_node(5,22,24).
% node 23 (leaf): class g (0)
leaf_class(5,23,0).
% node 24 (leaf): class h (1)
leaf_class(5,24,1).
% node 25: f3 <= 0.0885000005364418  (F3, bin <= 0)  left -> 26, right -> 29
node(5,25,3,0).
left_node(5,25,26).
right_node(5,25,29).
% node 26: f8 <= 5.587500095367432  (F8, bin <= 4)  left -> 27, right -> 28
node(5,26,8,4).
left_node(5,26,27).
right_node(5,26,28).
% node 27 (leaf): class g (0)
leaf_class(5,27,0).
% node 28 (leaf): class h (1)
leaf_class(5,28,1).
% node 29 (leaf): class h (1)
leaf_class(5,29,1).
% node 30: f9 <= 219.3969955444336  (F9, bin <= 24)  left -> 31, right -> 50
node(5,30,9,24).
left_node(5,30,31).
right_node(5,30,50).
% node 31: f2 <= 2.4549999237060547  (F2, bin <= 27)  left -> 32, right -> 39
node(5,31,2,27).
left_node(5,31,32).
right_node(5,31,39).
% node 32: f8 <= 54.66720008850098  (F8, bin <= 98)  left -> 33, right -> 34
node(5,32,8,98).
left_node(5,32,33).
right_node(5,32,34).
% node 33 (leaf): class g (0)
leaf_class(5,33,0).
% node 34: f2 <= 2.319350004196167  (F2, bin <= 7)  left -> 35, right -> 36
node(5,34,2,7).
left_node(5,34,35).
right_node(5,34,36).
% node 35 (leaf): class g (0)
leaf_class(5,35,0).
% node 36: f3 <= 0.5753999948501587  (F3, bin <= 30)  left -> 37, right -> 38
node(5,36,3,30).
left_node(5,36,37).
right_node(5,36,38).
% node 37 (leaf): class g (0)
leaf_class(5,37,0).
% node 38 (leaf): class h (1)
leaf_class(5,38,1).
% node 39: f6 <= -33.316349029541016  (F6, bin <= 19)  left -> 40, right -> 41
node(5,39,6,19).
left_node(5,39,40).
right_node(5,39,41).
% node 40 (leaf): class h (1)
leaf_class(5,40,1).
% node 41: f3 <= 0.5277500152587891  (F3, bin <= 25)  left -> 42, right -> 49
node(5,41,3,25).
left_node(5,41,42).
right_node(5,41,49).
% node 42: f0 <= 38.65345001220703  (F0, bin <= 33)  left -> 43, right -> 46
node(5,42,0,33).
left_node(5,42,43).
right_node(5,42,46).
% node 43: f3 <= 0.36879999935626984  (F3, bin <= 10)  left -> 44, right -> 45
node(5,43,3,10).
left_node(5,43,44).
right_node(5,43,45).
% node 44 (leaf): class g (0)
leaf_class(5,44,0).
% node 45 (leaf): class g (0)
leaf_class(5,45,0).
% node 46: f8 <= 42.17890167236328  (F8, bin <= 86)  left -> 47, right -> 48
node(5,46,8,86).
left_node(5,46,47).
right_node(5,46,48).
% node 47 (leaf): class h (1)
leaf_class(5,47,1).
% node 48 (leaf): class h (1)
leaf_class(5,48,1).
% node 49 (leaf): class h (1)
leaf_class(5,49,1).
% node 50: f1 <= 21.04694938659668  (F1, bin <= 41)  left -> 51, right -> 56
node(5,50,1,41).
left_node(5,50,51).
right_node(5,50,56).
% node 51: f4 <= 0.2565999925136566  (F4, bin <= 14)  left -> 52, right -> 55
node(5,51,4,14).
left_node(5,51,52).
right_node(5,51,55).
% node 52: f2 <= 2.643149971961975  (F2, bin <= 48)  left -> 53, right -> 54
node(5,52,2,48).
left_node(5,52,53).
right_node(5,52,54).
% node 53 (leaf): class h (1)
leaf_class(5,53,1).
% node 54 (leaf): class h (1)
leaf_class(5,54,1).
% node 55 (leaf): class h (1)
leaf_class(5,55,1).
% node 56 (leaf): class h (1)
leaf_class(5,56,1).

% Tree 6
tree(6).
% node 0: f7 <= -27.902999877929688  (F7, bin <= 2)  left -> 1, right -> 6
node(6,0,7,2).
left_node(6,0,1).
right_node(6,0,6).
% node 1: f0 <= 102.13199996948242  (F0, bin <= 62)  left -> 2, right -> 5
node(6,1,0,62).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f8 <= 11.29580020904541  (F8, bin <= 29)  left -> 3, right -> 4
node(6,2,8,29).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class g (0)
leaf_class(6,3,0).
% node 4 (leaf): class h (1)
leaf_class(6,4,1).
% node 5 (leaf): class h (1)
leaf_class(6,5,1).
% node 6: f6 <= -53.51969909667969  (F6, bin <= 8)  left -> 7, right -> 10
node(6,6,6,8).
left_node(6,6,7).
right_node(6,6,10).
% node 7: f1 <= 33.792449951171875  (F1, bin <= 51)  left -> 8, right -> 9
node(6,7,1,51).
left_node(6,7,8).
right_node(6,7,9).
% node 8 (leaf): class h (1)
leaf_class(6,8,1).
% node 9 (leaf): class h (1)
leaf_class(6,9,1).
% node 10: f8 <= 21.67574977874756  (F8, bin <= 53)  left -> 11, right -> 26
node(6,10,8,53).
left_node(6,10,11).
right_node(6,10,26).
% node 11: f7 <= 34.342201232910156  (F7, bin <= 8)  left -> 12, right -> 25
node(6,11,7,8).
left_node(6,11,12).
right_node(6,11,25).
% node 12: f3 <= 0.4564000070095062  (F3, bin <= 15)  left -> 13, right -> 20
node(6,12,3,15).
left_node(6,12,13).
right_node(6,12,20).
% node 13: f3 <= 0.30265000462532043  (F3, bin <= 7)  left -> 14, right -> 17
node(6,13,3,7).
left_node(6,13,14).
right_node(6,13,17).
% node 14: f0 <= 117.99845123291016  (F0, bin <= 83)  left -> 15, right -> 16
node(6,14,0,83).
left_node(6,14,15).
right_node(6,14,16).
% node 15 (leaf): class g (0)
leaf_class(6,15,0).
% node 16 (leaf): class g (0)
leaf_class(6,16,0).
% node 17: f0 <= 46.41670036315918  (F0, bin <= 42)  left -> 18, right -> 19
node(6,17,0,42).
left_node(6,17,18).
right_node(6,17,19).
% node 18 (leaf): class g (0)
leaf_class(6,18,0).
% node 19 (leaf): class g (0)
leaf_class(6,19,0).
% node 20: f2 <= 2.6172999143600464  (F2, bin <= 46)  left -> 21, right -> 24
node(6,20,2,46).
left_node(6,20,21).
right_node(6,20,24).
% node 21: f4 <= 0.40719999372959137  (F4, bin <= 21)  left -> 22, right -> 23
node(6,21,4,21).
left_node(6,21,22).
right_node(6,21,23).
% node 22 (leaf): class g (0)
leaf_class(6,22,0).
% node 23 (leaf): class g (0)
leaf_class(6,23,0).
% node 24 (leaf): class h (1)
leaf_class(6,24,1).
% node 25 (leaf): class h (1)
leaf_class(6,25,1).
% node 26: f0 <= 33.70314979553223  (F0, bin <= 30)  left -> 27, right -> 40
node(6,26,0,30).
left_node(6,26,27).
right_node(6,26,40).
% node 27: f2 <= 2.312299966812134  (F2, bin <= 2)  left -> 28, right -> 33
node(6,27,2,2).
left_node(6,27,28).
right_node(6,27,33).
% node 28: f1 <= 6.08495020866394  (F1, bin <= 3)  left -> 29, right -> 32
node(6,28,1,3).
left_node(6,28,29).
right_node(6,28,32).
% node 29: f0 <= 19.195199966430664  (F0, bin <= 12)  left -> 30, right -> 31
node(6,29,0,12).
left_node(6,29,30).
right_node(6,29,31).
% node 30 (leaf): class h (1)
leaf_class(6,30,1).
% node 31 (leaf): class g (0)
leaf_class(6,31,0).
% node 32 (leaf): class g (0)
leaf_class(6,32,0).
% node 33: f1 <= 11.969749927520752  (F1, bin <= 28)  left -> 34, right -> 37
node(6,33,1,28).
left_node(6,33,34).
right_node(6,33,37).
% node 34: f2 <= 2.4536999464035034  (F2, bin <= 25)  left -> 35, right -> 36
node(6,34,2,25).
left_node(6,34,35).
right_node(6,34,36).
% node 35 (leaf): class g (0)
leaf_class(6,35,0).
% node 36 (leaf): class h (1)
leaf_class(6,36,1).
% node 37: f8 <= 42.77655029296875  (F8, bin <= 87)  left -> 38, right -> 39
node(6,37,8,87).
left_node(6,37,38).
right_node(6,37,39).
% node 38 (leaf): class g (0)
leaf_class(6,38,0).
% node 39 (leaf): class g (0)
leaf_class(6,39,0).
% node 40: f8 <= 31.91960048675537  (F8, bin <= 72)  left -> 41, right -> 44
node(6,40,8,72).
left_node(6,40,41).
right_node(6,40,44).
% node 41: f9 <= 192.73149871826172  (F9, bin <= 12)  left -> 42, right -> 43
node(6,41,9,12).
left_node(6,41,42).
right_node(6,41,43).
% node 42 (leaf): class g (0)
leaf_class(6,42,0).
% node 43 (leaf): class h (1)
leaf_class(6,43,1).
% node 44: f9 <= 173.2949981689453  (F9, bin <= 9)  left -> 45, right -> 48
node(6,44,9,9).
left_node(6,44,45).
right_node(6,44,48).
% node 45: f1 <= 13.524799823760986  (F1, bin <= 37)  left -> 46, right -> 47
node(6,45,1,37).
left_node(6,45,46).
right_node(6,45,47).
% node 46 (leaf): class h (1)
leaf_class(6,46,1).
% node 47 (leaf): class h (1)
leaf_class(6,47,1).
% node 48 (leaf): class h (1)
leaf_class(6,48,1).

% Tree 7
tree(7).
% node 0: f0 <= 103.90049743652344  (F0, bin <= 64)  left -> 1, right -> 48
node(7,0,0,64).
left_node(7,0,1).
right_node(7,0,48).
% node 1: f4 <= 0.21374999731779099  (F4, bin <= 9)  left -> 2, right -> 23
node(7,1,4,9).
left_node(7,1,2).
right_node(7,1,23).
% node 2: f8 <= 24.40255069732666  (F8, bin <= 60)  left -> 3, right -> 6
node(7,2,8,60).
left_node(7,2,3).
right_node(7,2,6).
% node 3: f6 <= -53.51969909667969  (F6, bin <= 8)  left -> 4, right -> 5
node(7,3,6,8).
left_node(7,3,4).
right_node(7,3,5).
% node 4 (leaf): class h (1)
leaf_class(7,4,1).
% node 5 (leaf): class g (0)
leaf_class(7,5,0).
% node 6: f6 <= 26.567649841308594  (F6, bin <= 38)  left -> 7, right -> 16
node(7,6,6,38).
left_node(7,6,7).
right_node(7,6,16).
% node 7: f6 <= -29.49275016784668  (F6, bin <= 21)  left -> 8, right -> 9
node(7,7,6,21).
left_node(7,7,8).
right_node(7,7,9).
% node 8 (leaf): class h (1)
leaf_class(7,8,1).
% node 9: f8 <= 41.92880058288574  (F8, bin <= 85)  left -> 10, right -> 13
node(7,9,8,85).
left_node(7,9,10).
right_node(7,9,13).
% node 10: f1 <= 33.97879981994629  (F1, bin <= 52)  left -> 11, right -> 12
node(7,10,1,52).
left_node(7,10,11).
right_node(7,10,12).
% node 11 (leaf): class g (0)
leaf_class(7,11,0).
% node 12 (leaf): class h (1)
leaf_class(7,12,1).
% node 13: f0 <= 30.691600799560547  (F0, bin <= 21)  left -> 14, right -> 15
node(7,13,0,21).
left_node(7,13,14).
right_node(7,13,15).
% node 14 (leaf): class g (0)
leaf_class(7,14,0).
% node 15 (leaf): class h (1)
leaf_class(7,15,1).
% node 16: f9 <= 191.02449798583984  (F9, bin <= 10)  left -> 17, right -> 22
node(7,16,9,10).
left_node(7,16,17).
right_node(7,16,22).
% node 17: f7 <= -10.884750366210938  (F7, bin <= 7)  left -> 18, right -> 21
node(7,17,7,7).
left_node(7,17,18).
right_node(7,17,21).
% node 18: f8 <= 45.22999954223633  (F8, bin <= 90)  left -> 19, right -> 20
node(7,18,8,90).
left_node(7,18,19).
right_node(7,18,20).
% node 19 (leaf): class g (0)
leaf_class(7,19,0).
% node 20 (leaf): class h (1)
leaf_class(7,20,1).
% node 21 (leaf): class h (1)
leaf_class(7,21,1).
% node 22 (leaf): class h (1)
leaf_class(7,22,1).
% node 23: f8 <= 36.146751403808594  (F8, bin <= 79)  left -> 24, right -> 35
node(7,23,8,79).
left_node(7,23,24).
right_node(7,23,35).
% node 24: f2 <= 2.5161499977111816  (F2, bin <= 35)  left -> 25, right -> 28
node(7,24,2,35).
left_node(7,24,25).
right_node(7,24,28).
% node 25: f4 <= 0.431999996304512  (F4, bin <= 23)  left -> 26, right -> 27
node(7,25,4,23).
left_node(7,25,26).
right_node(7,25,27).
% node 26 (leaf): class g (0)
leaf_class(7,26,0).
% node 27 (leaf): class g (0)
leaf_class(7,27,0).
% node 28: f1 <= 10.620699882507324  (F1, bin <= 20)  left -> 29, right -> 30
node(7,28,1,20).
left_node(7,28,29).
right_node(7,28,30).
% node 29 (leaf): class h (1)
leaf_class(7,29,1).
% node 30: f7 <= -17.937549591064453  (F7, bin <= 6)  left -> 31, right -> 32
node(7,30,7,6).
left_node(7,30,31).
right_node(7,30,32).
% node 31 (leaf): class h (1)
leaf_class(7,31,1).
% node 32: f4 <= 0.3467000126838684  (F4, bin <= 20)  left -> 33, right -> 34
node(7,32,4,20).
left_node(7,32,33).
right_node(7,32,34).
% node 33 (leaf): class g (0)
leaf_class(7,33,0).
% node 34 (leaf): class h (1)
leaf_class(7,34,1).
% node 35: f6 <= 22.611149787902832  (F6, bin <= 32)  left -> 36, right -> 47
node(7,35,6,32).
left_node(7,35,36).
right_node(7,35,47).
% node 36: f2 <= 2.3851500749588013  (F2, bin <= 12)  left -> 37, right -> 42
node(7,36,2,12).
left_node(7,36,37).
right_node(7,36,42).
% node 37: f5 <= 24.984749794006348  (F5, bin <= 12)  left -> 38, right -> 41
node(7,37,5,12).
left_node(7,37,38).
right_node(7,37,41).
% node 38: f2 <= 2.313349962234497  (F2, bin <= 3)  left -> 39, right -> 40
node(7,38,2,3).
left_node(7,38,39).
right_node(7,38,40).
% node 39 (leaf): class g (0)
leaf_class(7,39,0).
% node 40 (leaf): class g (0)
leaf_class(7,40,0).
% node 41 (leaf): class g (0)
leaf_class(7,41,0).
% node 42: f0 <= 30.62814998626709  (F0, bin <= 20)  left -> 43, right -> 46
node(7,42,0,20).
left_node(7,42,43).
right_node(7,42,46).
% node 43: f1 <= 10.460649967193604  (F1, bin <= 15)  left -> 44, right -> 45
node(7,43,1,15).
left_node(7,43,44).
right_node(7,43,45).
% node 44 (leaf): class h (1)
leaf_class(7,44,1).
% node 45 (leaf): class h (1)
leaf_class(7,45,1).
% node 46 (leaf): class h (1)
leaf_class(7,46,1).
% node 47 (leaf): class h (1)
leaf_class(7,47,1).
% node 48: f2 <= 2.6776000261306763  (F2, bin <= 50)  left -> 49, right -> 50
node(7,48,2,50).
left_node(7,48,49).
right_node(7,48,50).
% node 49 (leaf): class g (0)
leaf_class(7,49,0).
% node 50: f8 <= 4.6927502155303955  (F8, bin <= 2)  left -> 51, right -> 56
node(7,50,8,2).
left_node(7,50,51).
right_node(7,50,56).
% node 51: f6 <= -89.13069915771484  (F6, bin <= 0)  left -> 52, right -> 53
node(7,51,6,0).
left_node(7,51,52).
right_node(7,51,53).
% node 52 (leaf): class h (1)
leaf_class(7,52,1).
% node 53: f0 <= 125.83649826049805  (F0, bin <= 87)  left -> 54, right -> 55
node(7,53,0,87).
left_node(7,53,54).
right_node(7,53,55).
% node 54 (leaf): class g (0)
leaf_class(7,54,0).
% node 55 (leaf): class h (1)
leaf_class(7,55,1).
% node 56 (leaf): class h (1)
leaf_class(7,56,1).

% Tree 8
tree(8).
% node 0: f8 <= 27.17940044403076  (F8, bin <= 67)  left -> 1, right -> 28
node(8,0,8,67).
left_node(8,0,1).
right_node(8,0,28).
% node 1: f0 <= 116.18050003051758  (F0, bin <= 77)  left -> 2, right -> 25
node(8,1,0,77).
left_node(8,1,2).
right_node(8,1,25).
% node 2: f8 <= 11.901100158691406  (F8, bin <= 35)  left -> 3, right -> 14
node(8,2,8,35).
left_node(8,2,3).
right_node(8,2,14).
% node 3: f0 <= 17.917250633239746  (F0, bin <= 6)  left -> 4, right -> 9
node(8,3,0,6).
left_node(8,3,4).
right_node(8,3,9).
% node 4: f1 <= 10.346099853515625  (F1, bin <= 14)  left -> 5, right -> 6
node(8,4,1,14).
left_node(8,4,5).
right_node(8,4,6).
% node 5 (leaf): class h (1)
leaf_class(8,5,1).
% node 6: f6 <= 9.235499858856201  (F6, bin <= 28)  left -> 7, right -> 8
node(8,6,6,28).
left_node(8,6,7).
right_node(8,6,8).
% node 7 (leaf): class g (0)
leaf_class(8,7,0).
% node 8 (leaf): class h (1)
leaf_class(8,8,1).
% node 9: f4 <= 0.19555000215768814  (F4, bin <= 4)  left -> 10, right -> 13
node(8,9,4,4).
left_node(8,9,10).
right_node(8,9,13).
% node 10: f6 <= -83.61005020141602  (F6, bin <= 3)  left -> 11, right -> 12
node(8,10,6,3).
left_node(8,10,11).
right_node(8,10,12).
% node 11 (leaf): class h (1)
leaf_class(8,11,1).
% node 12 (leaf): class g (0)
leaf_class(8,12,0).
% node 13 (leaf): class g (0)
leaf_class(8,13,0).
% node 14: f6 <= -34.211050033569336  (F6, bin <= 17)  left -> 15, right -> 16
node(8,14,6,17).
left_node(8,14,15).
right_node(8,14,16).
% node 15 (leaf): class h (1)
leaf_class(8,15,1).
% node 16: f9 <= 257.564697265625  (F9, bin <= 29)  left -> 17, right -> 24
node(8,16,9,29).
left_node(8,16,17).
right_node(8,16,24).
% node 17: f1 <= 10.551300048828125  (F1, bin <= 17)  left -> 18, right -> 21
node(8,17,1,17).
left_node(8,17,18).
right_node(8,17,21).
% node 18: f2 <= 2.4463499784469604  (F2, bin <= 21)  left -> 19, right -> 20
node(8,18,2,21).
left_node(8,18,19).
right_node(8,18,20).
% node 19 (leaf): class g (0)
leaf_class(8,19,0).
% node 20 (leaf): class h (1)
leaf_class(8,20,1).
% node 21: f5 <= 81.96850204467773  (F5, bin <= 19)  left -> 22, right -> 23
node(8,21,5,19).
left_node(8,21,22).
right_node(8,21,23).
% node 22 (leaf): class g (0)
leaf_class(8,22,0).
% node 23 (leaf): class h (1)
leaf_class(8,23,1).
% node 24 (leaf): class h (1)
leaf_class(8,24,1).
% node 25: f6 <= 84.35150146484375  (F6, bin <= 47)  left -> 26, right -> 27
node(8,25,6,47).
left_node(8,25,26).
right_node(8,25,27).
% node 26 (leaf): class h (1)
leaf_class(8,26,1).
% node 27 (leaf): class h (1)
leaf_class(8,27,1).
% node 28: f9 <= 201.64490509033203  (F9, bin <= 16)  left -> 29, right -> 48
node(8,28,9,16).
left_node(8,28,29).
right_node(8,28,48).
% node 29: f7 <= -22.617249488830566  (F7, bin <= 4)  left -> 30, right -> 31
node(8,29,7,4).
left_node(8,29,30).
right_node(8,29,31).
% node 30 (leaf): class h (1)
leaf_class(8,30,1).
% node 31: f3 <= 0.26989999413490295  (F3, bin <= 5)  left -> 32, right -> 39
node(8,31,3,5).
left_node(8,31,32).
right_node(8,31,39).
% node 32: f5 <= -19.46304988861084  (F5, bin <= 7)  left -> 33, right -> 34
node(8,32,5,7).
left_node(8,32,33).
right_node(8,32,34).
% node 33 (leaf): class h (1)
leaf_class(8,33,1).
% node 34: f5 <= 57.468299865722656  (F5, bin <= 18)  left -> 35, right -> 38
node(8,34,5,18).
left_node(8,34,35).
right_node(8,34,38).
% node 35: f0 <= 46.62350082397461  (F0, bin <= 43)  left -> 36, right -> 37
node(8,35,0,43).
left_node(8,35,36).
right_node(8,35,37).
% node 36 (leaf): class g (0)
leaf_class(8,36,0).
% node 37 (leaf): class h (1)
leaf_class(8,37,1).
% node 38 (leaf): class h (1)
leaf_class(8,38,1).
% node 39: f2 <= 2.4771499633789062  (F2, bin <= 31)  left -> 40, right -> 41
node(8,39,2,31).
left_node(8,39,40).
right_node(8,39,41).
% node 40 (leaf): class g (0)
leaf_class(8,40,0).
% node 41: f8 <= 46.19154930114746  (F8, bin <= 91)  left -> 42, right -> 45
node(8,41,8,91).
left_node(8,41,42).
right_node(8,41,45).
% node 42: f3 <= 0.5240499973297119  (F3, bin <= 24)  left -> 43, right -> 44
node(8,42,3,24).
left_node(8,42,43).
right_node(8,42,44).
% node 43 (leaf): class g (0)
leaf_class(8,43,0).
% node 44 (leaf): class h (1)
leaf_class(8,44,1).
% node 45: f0 <= 31.9864501953125  (F0, bin <= 24)  left -> 46, right -> 47
node(8,45,0,24).
left_node(8,45,46).
right_node(8,45,47).
% node 46 (leaf): class h (1)
leaf_class(8,46,1).
% node 47 (leaf): class h (1)
leaf_class(8,47,1).
% node 48: f4 <= 0.21005000174045563  (F4, bin <= 8)  left -> 49, right -> 52
node(8,48,4,8).
left_node(8,48,49).
right_node(8,48,52).
% node 49: f0 <= 31.693750381469727  (F0, bin <= 23)  left -> 50, right -> 51
node(8,49,0,23).
left_node(8,49,50).
right_node(8,49,51).
% node 50 (leaf): class g (0)
leaf_class(8,50,0).
% node 51 (leaf): class h (1)
leaf_class(8,51,1).
% node 52: f2 <= 2.386750102043152  (F2, bin <= 14)  left -> 53, right -> 54
node(8,52,2,14).
left_node(8,52,53).
right_node(8,52,54).
% node 53 (leaf): class g (0)
leaf_class(8,53,0).
% node 54: f8 <= 32.04330062866211  (F8, bin <= 74)  left -> 55, right -> 56
node(8,54,8,74).
left_node(8,54,55).
right_node(8,54,56).
% node 55 (leaf): class g (0)
leaf_class(8,55,0).
% node 56 (leaf): class h (1)
leaf_class(8,56,1).

% Tree 9
tree(9).
% node 0: f1 <= 39.96834945678711  (F1, bin <= 58)  left -> 1, right -> 42
node(9,0,1,58).
left_node(9,0,1).
right_node(9,0,42).
% node 1: f0 <= 118.34099960327148  (F0, bin <= 85)  left -> 2, right -> 39
node(9,1,0,85).
left_node(9,1,2).
right_node(9,1,39).
% node 2: f1 <= 10.579700469970703  (F1, bin <= 18)  left -> 3, right -> 18
node(9,2,1,18).
left_node(9,2,3).
right_node(9,2,18).
% node 3: f8 <= 50.062049865722656  (F8, bin <= 94)  left -> 4, right -> 13
node(9,3,8,94).
left_node(9,3,4).
right_node(9,3,13).
% node 4: f4 <= 0.22549999505281448  (F4, bin <= 10)  left -> 5, right -> 6
node(9,4,4,10).
left_node(9,4,5).
right_node(9,4,6).
% node 5 (leaf): class h (1)
leaf_class(9,5,1).
% node 6: f0 <= 17.93340015411377  (F0, bin <= 8)  left -> 7, right -> 10
node(9,6,0,8).
left_node(9,6,7).
right_node(9,6,10).
% node 7: f3 <= 0.7793000042438507  (F3, bin <= 37)  left -> 8, right -> 9
node(9,7,3,37).
left_node(9,7,8).
right_node(9,7,9).
% node 8 (leaf): class h (1)
leaf_class(9,8,1).
% node 9 (leaf): class g (0)
leaf_class(9,9,0).
% node 10: f5 <= 25.06209945678711  (F5, bin <= 13)  left -> 11, right -> 12
node(9,10,5,13).
left_node(9,10,11).
right_node(9,10,12).
% node 11 (leaf): class g (0)
leaf_class(9,11,0).
% node 12 (leaf): class g (0)
leaf_class(9,12,0).
% node 13: f3 <= 0.6999000012874603  (F3, bin <= 35)  left -> 14, right -> 15
node(9,13,3,35).
left_node(9,13,14).
right_node(9,13,15).
% node 14 (leaf): class h (1)
leaf_class(9,14,1).
% node 15: f2 <= 2.3465999364852905  (F2, bin <= 9)  left -> 16, right -> 17
node(9,15,2,9).
left_node(9,15,16).
right_node(9,15,17).
% node 16 (leaf): class g (0)
leaf_class(9,16,0).
% node 17 (leaf): class h (1)
leaf_class(9,17,1).
% node 18: f8 <= 27.702500343322754  (F8, bin <= 69)  left -> 19, right -> 30
node(9,18,8,69).
left_node(9,18,19).
right_node(9,18,30).
% node 19: f6 <= -52.66024971008301  (F6, bin <= 9)  left -> 20, right -> 23
node(9,19,6,9).
left_node(9,19,20).
right_node(9,19,23).
% node 20: f8 <= 7.833950042724609  (F8, bin <= 12)  left -> 21, right -> 22
node(9,20,8,12).
left_node(9,20,21).
right_node(9,20,22).
% node 21 (leaf): class g (0)
leaf_class(9,21,0).
% node 22 (leaf): class h (1)
leaf_class(9,22,1).
% node 23: f6 <= 36.86725044250488  (F6, bin <= 44)  left -> 24, right -> 27
node(9,23,6,44).
left_node(9,23,24).
right_node(9,23,27).
% node 24: f3 <= 0.45055000483989716  (F3, bin <= 14)  left -> 25, right -> 26
node(9,24,3,14).
left_node(9,24,25).
right_node(9,24,26).
% node 25 (leaf): class g (0)
leaf_class(9,25,0).
% node 26 (leaf): class g (0)
leaf_class(9,26,0).
% node 27: f8 <= 14.321899890899658  (F8, bin <= 44)  left -> 28, right -> 29
node(9,27,8,44).
left_node(9,27,28).
right_node(9,27,29).
% node 28 (leaf): class g (0)
leaf_class(9,28,0).
% node 29 (leaf): class g (0)
leaf_class(9,29,0).
% node 30: f2 <= 2.4529500007629395  (F2, bin <= 24)  left -> 31, right -> 34
node(9,30,2,24).
left_node(9,30,31).
right_node(9,30,34).
% node 31: f0 <= 27.660449981689453  (F0, bin <= 14)  left -> 32, right -> 33
node(9,31,0,14).
left_node(9,31,32).
right_node(9,31,33).
% node 32 (leaf): class g (0)
leaf_class(9,32,0).
% node 33 (leaf): class h (1)
leaf_class(9,33,1).
% node 34: f5 <= -31.119800567626953  (F5, bin <= 3)  left -> 35, right -> 36
node(9,34,5,3).
left_node(9,34,35).
right_node(9,34,36).
% node 35 (leaf): class h (1)
leaf_class(9,35,1).
% node 36: f9 <= 155.6240997314453  (F9, bin <= 6)  left -> 37, right -> 38
node(9,36,9,6).
left_node(9,36,37).
right_node(9,36,38).
% node 37 (leaf): class g (0)
leaf_class(9,37,0).
% node 38 (leaf): class h (1)
leaf_class(9,38,1).
% node 39: f8 <= 7.081900119781494  (F8, bin <= 9)  left -> 40, right -> 41
node(9,39,8,9).
left_node(9,39,40).
right_node(9,39,41).
% node 40 (leaf): class g (0)
leaf_class(9,40,0).
% node 41 (leaf): class h (1)
leaf_class(9,41,1).
% node 42: f2 <= 3.894800066947937  (F2, bin <= 64)  left -> 43, right -> 48
node(9,42,2,64).
left_node(9,42,43).
right_node(9,42,48).
% node 43: f1 <= 45.54329872131348  (F1, bin <= 67)  left -> 44, right -> 47
node(9,43,1,67).
left_node(9,43,44).
right_node(9,43,47).
% node 44: f8 <= 9.660450458526611  (F8, bin <= 24)  left -> 45, right -> 46
node(9,44,8,24).
left_node(9,44,45).
right_node(9,44,46).
% node 45 (leaf): class g (0)
leaf_class(9,45,0).
% node 46 (leaf): class h (1)
leaf_class(9,46,1).
% node 47 (leaf): class h (1)
leaf_class(9,47,1).
% node 48: f6 <= 25.890199661254883  (F6, bin <= 37)  left -> 49, right -> 50
node(9,48,6,37).
left_node(9,48,49).
right_node(9,48,50).
% node 49 (leaf): class h (1)
leaf_class(9,49,1).
% node 50: f6 <= 89.62835311889648  (F6, bin <= 48)  left -> 51, right -> 54
node(9,50,6,48).
left_node(9,50,51).
right_node(9,50,54).
% node 51: f0 <= 116.2983512878418  (F0, bin <= 78)  left -> 52, right -> 53
node(9,51,0,78).
left_node(9,51,52).
right_node(9,51,53).
% node 52 (leaf): class g (0)
leaf_class(9,52,0).
% node 53 (leaf): class h (1)
leaf_class(9,53,1).
% node 54 (leaf): class h (1)
leaf_class(9,54,1).

% Tree 10
tree(10).
% node 0: f0 <= 103.45225143432617  (F0, bin <= 63)  left -> 1, right -> 46
node(10,0,0,63).
left_node(10,0,1).
right_node(10,0,46).
% node 1: f6 <= -38.922149658203125  (F6, bin <= 14)  left -> 2, right -> 9
node(10,1,6,14).
left_node(10,1,2).
right_node(10,1,9).
% node 2: f1 <= 27.760700225830078  (F1, bin <= 44)  left -> 3, right -> 4
node(10,2,1,44).
left_node(10,2,3).
right_node(10,2,4).
% node 3 (leaf): class g (0)
leaf_class(10,3,0).
% node 4: f9 <= 283.68280029296875  (F9, bin <= 30)  left -> 5, right -> 6
node(10,4,9,30).
left_node(10,4,5).
right_node(10,4,6).
% node 5 (leaf): class h (1)
leaf_class(10,5,1).
% node 6: f8 <= 12.025850296020508  (F8, bin <= 38)  left -> 7, right -> 8
node(10,6,8,38).
left_node(10,6,7).
right_node(10,6,8).
% node 7 (leaf): class g (0)
leaf_class(10,7,0).
% node 8 (leaf): class h (1)
leaf_class(10,8,1).
% node 9: f4 <= 0.20044999569654465  (F4, bin <= 5)  left -> 10, right -> 27
node(10,9,4,5).
left_node(10,9,10).
right_node(10,9,27).
% node 10: f1 <= 12.653050422668457  (F1, bin <= 35)  left -> 11, right -> 14
node(10,10,1,35).
left_node(10,10,11).
right_node(10,10,14).
% node 11: f8 <= 11.571599960327148  (F8, bin <= 31)  left -> 12, right -> 13
node(10,11,8,31).
left_node(10,11,12).
right_node(10,11,13).
% node 12 (leaf): class g (0)
leaf_class(10,12,0).
% node 13 (leaf): class h (1)
leaf_class(10,13,1).
% node 14: f9 <= 107.36000061035156  (F9, bin <= 2)  left -> 15, right -> 20
node(10,14,9,2).
left_node(10,14,15).
right_node(10,14,20).
% node 15: f0 <= 41.41559982299805  (F0, bin <= 37)  left -> 16, right -> 17
node(10,15,0,37).
left_node(10,15,16).
right_node(10,15,17).
% node 16 (leaf): class g (0)
leaf_class(10,16,0).
% node 17: f8 <= 25.089350700378418  (F8, bin <= 62)  left -> 18, right -> 19
node(10,17,8,62).
left_node(10,17,18).
right_node(10,17,19).
% node 18 (leaf): class g (0)
leaf_class(10,18,0).
% node 19 (leaf): class h (1)
leaf_class(10,19,1).
% node 20: f1 <= 41.55590057373047  (F1, bin <= 62)  left -> 21, right -> 24
node(10,20,1,62).
left_node(10,20,21).
right_node(10,20,24).
% node 21: f7 <= -25.33174991607666  (F7, bin <= 3)  left -> 22, right -> 23
node(10,21,7,3).
left_node(10,21,22).
right_node(10,21,23).
% node 22 (leaf): class g (0)
leaf_class(10,22,0).
% node 23 (leaf): class g (0)
leaf_class(10,23,0).
% node 24: f3 <= 0.14799999445676804  (F3, bin <= 2)  left -> 25, right -> 26
node(10,24,3,2).
left_node(10,24,25).
right_node(10,24,26).
% node 25 (leaf): class g (0)
leaf_class(10,25,0).
% node 26 (leaf): class h (1)
leaf_class(10,26,1).
% node 27: f2 <= 2.5297499895095825  (F2, bin <= 38)  left -> 28, right -> 37
node(10,27,2,38).
left_node(10,27,28).
right_node(10,27,37).
% node 28: f8 <= 49.96860122680664  (F8, bin <= 93)  left -> 29, right -> 34
node(10,28,8,93).
left_node(10,28,29).
right_node(10,28,34).
% node 29: f0 <= 12.160599708557129  (F0, bin <= 1)  left -> 30, right -> 31
node(10,29,0,1).
left_node(10,29,30).
right_node(10,29,31).
% node 30 (leaf): class h (1)
leaf_class(10,30,1).
% node 31: f8 <= 26.74250030517578  (F8, bin <= 65)  left -> 32, right -> 33
node(10,31,8,65).
left_node(10,31,32).
right_node(10,31,33).
% node 32 (leaf): class g (0)
leaf_class(10,32,0).
% node 33 (leaf): class g (0)
leaf_class(10,33,0).
% node 34: f0 <= 27.705599784851074  (F0, bin <= 15)  left -> 35, right -> 36
node(10,34,0,15).
left_node(10,34,35).
right_node(10,34,36).
% node 35 (leaf): class g (0)
leaf_class(10,35,0).
% node 36 (leaf): class h (1)
leaf_class(10,36,1).
% node 37: f3 <= 0.5166500210762024  (F3, bin <= 22)  left -> 38, right -> 45
node(10,37,3,22).
left_node(10,37,38).
right_node(10,37,45).
% node 38: f8 <= 32.02935028076172  (F8, bin <= 73)  left -> 39, right -> 42
node(10,38,8,73).
left_node(10,38,39).
right_node(10,38,42).
% node 39: f8 <= 12.110849857330322  (F8, bin <= 40)  left -> 40, right -> 41
node(10,39,8,40).
left_node(10,39,40).
right_node(10,39,41).
% node 40 (leaf): class g (0)
leaf_class(10,40,0).
% node 41 (leaf): class g (0)
leaf_class(10,41,0).
% node 42: f0 <= 29.871049880981445  (F0, bin <= 19)  left -> 43, right -> 44
node(10,42,0,19).
left_node(10,42,43).
right_node(10,42,44).
% node 43 (leaf): class h (1)
leaf_class(10,43,1).
% node 44 (leaf): class h (1)
leaf_class(10,44,1).
% node 45 (leaf): class h (1)
leaf_class(10,45,1).
% node 46: f6 <= 27.3075008392334  (F6, bin <= 39)  left -> 47, right -> 50
node(10,46,6,39).
left_node(10,46,47).
right_node(10,46,50).
% node 47: f8 <= 1.8997000455856323  (F8, bin <= 0)  left -> 48, right -> 49
node(10,47,8,0).
left_node(10,47,48).
right_node(10,47,49).
% node 48 (leaf): class g (0)
leaf_class(10,48,0).
% node 49 (leaf): class h (1)
leaf_class(10,49,1).
% node 50: f9 <= 225.93014526367188  (F9, bin <= 25)  left -> 51, right -> 52
node(10,50,9,25).
left_node(10,50,51).
right_node(10,50,52).
% node 51 (leaf): class h (1)
leaf_class(10,51,1).
% node 52: f1 <= 61.81760025024414  (F1, bin <= 74)  left -> 53, right -> 58
node(10,52,1,74).
left_node(10,52,53).
right_node(10,52,58).
% node 53: f2 <= 3.7786500453948975  (F2, bin <= 62)  left -> 54, right -> 57
node(10,53,2,62).
left_node(10,53,54).
right_node(10,53,57).
% node 54: f8 <= 5.9079999923706055  (F8, bin <= 5)  left -> 55, right -> 56
node(10,54,8,5).
left_node(10,54,55).
right_node(10,54,56).
% node 55 (leaf): class g (0)
leaf_class(10,55,0).
% node 56 (leaf): class h (1)
leaf_class(10,56,1).
% node 57 (leaf): class g (0)
leaf_class(10,57,0).
% node 58 (leaf): class h (1)
leaf_class(10,58,1).

% Tree 11
tree(11).
% node 0: f7 <= -27.980899810791016  (F7, bin <= 1)  left -> 1, right -> 6
node(11,0,7,1).
left_node(11,0,1).
right_node(11,0,6).
% node 1: f8 <= 7.807999849319458  (F8, bin <= 11)  left -> 2, right -> 5
node(11,1,8,11).
left_node(11,1,2).
right_node(11,1,5).
% node 2: f2 <= 3.7474499940872192  (F2, bin <= 60)  left -> 3, right -> 4
node(11,2,2,60).
left_node(11,2,3).
right_node(11,2,4).
% node 3 (leaf): class h (1)
leaf_class(11,3,1).
% node 4 (leaf): class g (0)
leaf_class(11,4,0).
% node 5 (leaf): class h (1)
leaf_class(11,5,1).
% node 6: f6 <= -53.51969909667969  (F6, bin <= 8)  left -> 7, right -> 14
node(11,6,6,8).
left_node(11,6,7).
right_node(11,6,14).
% node 7: f8 <= 9.010499954223633  (F8, bin <= 20)  left -> 8, right -> 11
node(11,7,8,20).
left_node(11,7,8).
right_node(11,7,11).
% node 8: f1 <= 37.83614921569824  (F1, bin <= 55)  left -> 9, right -> 10
node(11,8,1,55).
left_node(11,8,9).
right_node(11,8,10).
% node 9 (leaf): class g (0)
leaf_class(11,9,0).
% node 10 (leaf): class h (1)
leaf_class(11,10,1).
% node 11: f2 <= 2.6744000911712646  (F2, bin <= 49)  left -> 12, right -> 13
node(11,11,2,49).
left_node(11,11,12).
right_node(11,11,13).
% node 12 (leaf): class h (1)
leaf_class(11,12,1).
% node 13 (leaf): class h (1)
leaf_class(11,13,1).
% node 14: f0 <= 107.59354782104492  (F0, bin <= 66)  left -> 15, right -> 30
node(11,14,0,66).
left_node(11,14,15).
right_node(11,14,30).
% node 15: f2 <= 3.2635499238967896  (F2, bin <= 56)  left -> 16, right -> 25
node(11,15,2,56).
left_node(11,15,16).
right_node(11,15,25).
% node 16: f2 <= 2.3389999866485596  (F2, bin <= 8)  left -> 17, right -> 18
node(11,16,2,8).
left_node(11,16,17).
right_node(11,16,18).
% node 17 (leaf): class g (0)
leaf_class(11,17,0).
% node 18: f8 <= 26.109050750732422  (F8, bin <= 64)  left -> 19, right -> 22
node(11,18,8,64).
left_node(11,18,19).
right_node(11,18,22).
% node 19: f3 <= 0.5736500024795532  (F3, bin <= 29)  left -> 20, right -> 21
node(11,19,3,29).
left_node(11,19,20).
right_node(11,19,21).
% node 20 (leaf): class g (0)
leaf_class(11,20,0).
% node 21 (leaf): class h (1)
leaf_class(11,21,1).
% node 22: f1 <= 11.272000312805176  (F1, bin <= 22)  left -> 23, right -> 24
node(11,22,1,22).
left_node(11,22,23).
right_node(11,22,24).
% node 23 (leaf): class h (1)
leaf_class(11,23,1).
% node 24 (leaf): class h (1)
leaf_class(11,24,1).
% node 25: f5 <= -22.08894920349121  (F5, bin <= 6)  left -> 26, right -> 29
node(11,25,5,6).
left_node(11,25,26).
right_node(11,25,29).
% node 26: f8 <= 10.04040002822876  (F8, bin <= 28)  left -> 27, right -> 28
node(11,26,8,28).
left_node(11,26,27).
right_node(11,26,28).
% node 27 (leaf): class g (0)
leaf_class(11,27,0).
% node 28 (leaf): class h (1)
leaf_class(11,28,1).
% node 29 (leaf): class g (0)
leaf_class(11,29,0).
% node 30: f0 <= 117.83805084228516  (F0, bin <= 81)  left -> 31, right -> 32
node(11,30,0,81).
left_node(11,30,31).
right_node(11,30,32).
% node 31 (leaf): class h (1)
leaf_class(11,31,1).
% node 32 (leaf): class h (1)
leaf_class(11,32,1).

% Tree 12
tree(12).
% node 0: f0 <= 107.98800277709961  (F0, bin <= 68)  left -> 1, right -> 50
node(12,0,0,68).
left_node(12,0,1).
right_node(12,0,50).
% node 1: f2 <= 3.271250009536743  (F2, bin <= 57)  left -> 2, right -> 37
node(12,1,2,57).
left_node(12,1,2).
right_node(12,1,37).
% node 2: f8 <= 27.14169979095459  (F8, bin <= 66)  left -> 3, right -> 18
node(12,2,8,66).
left_node(12,2,3).
right_node(12,2,18).
% node 3: f1 <= 31.968350410461426  (F1, bin <= 49)  left -> 4, right -> 17
node(12,3,1,49).
left_node(12,3,4).
right_node(12,3,17).
% node 4: f4 <= 0.24274999648332596  (F4, bin <= 13)  left -> 5, right -> 10
node(12,4,4,13).
left_node(12,4,5).
right_node(12,4,10).
% node 5: f1 <= 10.75255012512207  (F1, bin <= 21)  left -> 6, right -> 7
node(12,5,1,21).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class g (0)
leaf_class(12,6,0).
% node 7: f0 <= 72.48014831542969  (F0, bin <= 52)  left -> 8, right -> 9
node(12,7,0,52).
left_node(12,7,8).
right_node(12,7,9).
% node 8 (leaf): class g (0)
leaf_class(12,8,0).
% node 9 (leaf): class g (0)
leaf_class(12,9,0).
% node 10: f6 <= 20.639049530029297  (F6, bin <= 30)  left -> 11, right -> 14
node(12,10,6,30).
left_node(12,10,11).
right_node(12,10,14).
% node 11: f4 <= 0.48864999413490295  (F4, bin <= 25)  left -> 12, right -> 13
node(12,11,4,25).
left_node(12,11,12).
right_node(12,11,13).
% node 12 (leaf): class g (0)
leaf_class(12,12,0).
% node 13 (leaf): class h (1)
leaf_class(12,13,1).
% node 14: f3 <= 0.6568500101566315  (F3, bin <= 33)  left -> 15, right -> 16
node(12,14,3,33).
left_node(12,14,15).
right_node(12,14,16).
% node 15 (leaf): class g (0)
leaf_class(12,15,0).
% node 16 (leaf): class h (1)
leaf_class(12,16,1).
% node 17 (leaf): class h (1)
leaf_class(12,17,1).
% node 18: f6 <= 24.551650047302246  (F6, bin <= 36)  left -> 19, right -> 32
node(12,18,6,36).
left_node(12,18,19).
right_node(12,18,32).
% node 19: f2 <= 2.4467999935150146  (F2, bin <= 22)  left -> 20, right -> 27
node(12,19,2,22).
left_node(12,19,20).
right_node(12,19,27).
% node 20: f2 <= 2.3150500059127808  (F2, bin <= 4)  left -> 21, right -> 24
node(12,20,2,4).
left_node(12,20,21).
right_node(12,20,24).
% node 21: f0 <= 12.316049575805664  (F0, bin <= 2)  left -> 22, right -> 23
node(12,21,0,2).
left_node(12,21,22).
right_node(12,21,23).
% node 22 (leaf): class h (1)
leaf_class(12,22,1).
% node 23 (leaf): class g (0)
leaf_class(12,23,0).
% node 24: f1 <= 9.666999816894531  (F1, bin <= 10)  left -> 25, right -> 26
node(12,24,1,10).
left_node(12,24,25).
right_node(12,24,26).
% node 25 (leaf): class h (1)
leaf_class(12,25,1).
% node 26 (leaf): class g (0)
leaf_class(12,26,0).
% node 27: f8 <= 41.48330116271973  (F8, bin <= 82)  left -> 28, right -> 31
node(12,27,8,82).
left_node(12,27,28).
right_node(12,27,31).
% node 28: f3 <= 0.5234500169754028  (F3, bin <= 23)  left -> 29, right -> 30
node(12,28,3,23).
left_node(12,28,29).
right_node(12,28,30).
% node 29 (leaf): class g (0)
leaf_class(12,29,0).
% node 30 (leaf): class h (1)
leaf_class(12,30,1).
% node 31 (leaf): class h (1)
leaf_class(12,31,1).
% node 32: f2 <= 3.020050048828125  (F2, bin <= 55)  left -> 33, right -> 36
node(12,32,2,55).
left_node(12,32,33).
right_node(12,32,36).
% node 33: f9 <= 146.0294952392578  (F9, bin <= 4)  left -> 34, right -> 35
node(12,33,9,4).
left_node(12,33,34).
right_node(12,33,35).
% node 34 (leaf): class h (1)
leaf_class(12,34,1).
% node 35 (leaf): class h (1)
leaf_class(12,35,1).
% node 36 (leaf): class h (1)
leaf_class(12,36,1).
% node 37: f0 <= 95.41489791870117  (F0, bin <= 57)  left -> 38, right -> 43
node(12,37,0,57).
left_node(12,37,38).
right_node(12,37,43).
% node 38: f1 <= 46.03299903869629  (F1, bin <= 69)  left -> 39, right -> 42
node(12,38,1,69).
left_node(12,38,39).
right_node(12,38,42).
% node 39: f6 <= -51.92580032348633  (F6, bin <= 11)  left -> 40, right -> 41
node(12,39,6,11).
left_node(12,39,40).
right_node(12,39,41).
% node 40 (leaf): class h (1)
leaf_class(12,40,1).
% node 41 (leaf): class g (0)
leaf_class(12,41,0).
% node 42 (leaf): class h (1)
leaf_class(12,42,1).
% node 43: f1 <= 42.34104919433594  (F1, bin <= 63)  left -> 44, right -> 45
node(12,43,1,63).
left_node(12,43,44).
right_node(12,43,45).
% node 44 (leaf): class g (0)
leaf_class(12,44,0).
% node 45: f6 <= 58.52750015258789  (F6, bin <= 45)  left -> 46, right -> 47
node(12,45,6,45).
left_node(12,45,46).
right_node(12,45,47).
% node 46 (leaf): class h (1)
leaf_class(12,46,1).
% node 47: f2 <= 3.944949984550476  (F2, bin <= 65)  left -> 48, right -> 49
node(12,47,2,65).
left_node(12,47,48).
right_node(12,47,49).
% node 48 (leaf): class h (1)
leaf_class(12,48,1).
% node 49 (leaf): class g (0)
leaf_class(12,49,0).
% node 50: f8 <= 6.837949991226196  (F8, bin <= 7)  left -> 51, right -> 52
node(12,50,8,7).
left_node(12,50,51).
right_node(12,50,52).
% node 51 (leaf): class g (0)
leaf_class(12,51,0).
% node 52 (leaf): class h (1)
leaf_class(12,52,1).

% Tree 13
tree(13).
% node 0: f0 <= 115.04929733276367  (F0, bin <= 75)  left -> 1, right -> 52
node(13,0,0,75).
left_node(13,0,1).
right_node(13,0,52).
% node 1: f4 <= 0.23934999853372574  (F4, bin <= 12)  left -> 2, right -> 29
node(13,1,4,12).
left_node(13,1,2).
right_node(13,1,29).
% node 2: f8 <= 24.040550231933594  (F8, bin <= 57)  left -> 3, right -> 14
node(13,2,8,57).
left_node(13,2,3).
right_node(13,2,14).
% node 3: f0 <= 100.67300033569336  (F0, bin <= 61)  left -> 4, right -> 11
node(13,3,0,61).
left_node(13,3,4).
right_node(13,3,11).
% node 4: f8 <= 9.86305046081543  (F8, bin <= 27)  left -> 5, right -> 6
node(13,4,8,27).
left_node(13,4,5).
right_node(13,4,6).
% node 5 (leaf): class g (0)
leaf_class(13,5,0).
% node 6: f6 <= -34.211050033569336  (F6, bin <= 17)  left -> 7, right -> 8
node(13,6,6,17).
left_node(13,6,7).
right_node(13,6,8).
% node 7 (leaf): class h (1)
leaf_class(13,7,1).
% node 8: f0 <= 47.48640060424805  (F0, bin <= 44)  left -> 9, right -> 10
node(13,8,0,44).
left_node(13,8,9).
right_node(13,8,10).
% node 9 (leaf): class g (0)
leaf_class(13,9,0).
% node 10 (leaf): class g (0)
leaf_class(13,10,0).
% node 11: f9 <= 361.2515106201172  (F9, bin <= 31)  left -> 12, right -> 13
node(13,11,9,31).
left_node(13,11,12).
right_node(13,11,13).
% node 12 (leaf): class g (0)
leaf_class(13,12,0).
% node 13 (leaf): class h (1)
leaf_class(13,13,1).
% node 14: f2 <= 2.793500065803528  (F2, bin <= 53)  left -> 15, right -> 24
node(13,14,2,53).
left_node(13,14,15).
right_node(13,14,24).
% node 15: f1 <= 11.724549770355225  (F1, bin <= 25)  left -> 16, right -> 17
node(13,15,1,25).
left_node(13,15,16).
right_node(13,15,17).
% node 16 (leaf): class h (1)
leaf_class(13,16,1).
% node 17: f8 <= 41.88549995422363  (F8, bin <= 84)  left -> 18, right -> 21
node(13,17,8,84).
left_node(13,17,18).
right_node(13,17,21).
% node 18: f6 <= -27.386500358581543  (F6, bin <= 22)  left -> 19, right -> 20
node(13,18,6,22).
left_node(13,18,19).
right_node(13,18,20).
% node 19 (leaf): class h (1)
leaf_class(13,19,1).
% node 20 (leaf): class g (0)
leaf_class(13,20,0).
% node 21: f5 <= -28.655500411987305  (F5, bin <= 4)  left -> 22, right -> 23
node(13,21,5,4).
left_node(13,21,22).
right_node(13,21,23).
% node 22 (leaf): class h (1)
leaf_class(13,22,1).
% node 23 (leaf): class g (0)
leaf_class(13,23,0).
% node 24: f9 <= 192.67449951171875  (F9, bin <= 11)  left -> 25, right -> 28
node(13,24,9,11).
left_node(13,24,25).
right_node(13,24,28).
% node 25: f8 <= 35.27084922790527  (F8, bin <= 78)  left -> 26, right -> 27
node(13,25,8,78).
left_node(13,25,26).
right_node(13,25,27).
% node 26 (leaf): class g (0)
leaf_class(13,26,0).
% node 27 (leaf): class h (1)
leaf_class(13,27,1).
% node 28 (leaf): class h (1)
leaf_class(13,28,1).
% node 29: f1 <= 9.59000015258789  (F1, bin <= 7)  left -> 30, right -> 37
node(13,29,1,7).
left_node(13,29,30).
right_node(13,29,37).
% node 30: f0 <= 17.931949615478516  (F0, bin <= 7)  left -> 31, right -> 32
node(13,30,0,7).
left_node(13,30,31).
right_node(13,30,32).
% node 31 (leaf): class h (1)
leaf_class(13,31,1).
% node 32: f2 <= 2.4191499948501587  (F2, bin <= 19)  left -> 33, right -> 36
node(13,32,2,19).
left_node(13,32,33).
right_node(13,32,36).
% node 33: f8 <= 42.990150451660156  (F8, bin <= 88)  left -> 34, right -> 35
node(13,33,8,88).
left_node(13,33,34).
right_node(13,33,35).
% node 34 (leaf): class g (0)
leaf_class(13,34,0).
% node 35 (leaf): class g (0)
leaf_class(13,35,0).
% node 36 (leaf): class h (1)
leaf_class(13,36,1).
% node 37: f9 <= 208.38700103759766  (F9, bin <= 17)  left -> 38, right -> 45
node(13,37,9,17).
left_node(13,37,38).
right_node(13,37,45).
% node 38: f1 <= 16.822199821472168  (F1, bin <= 39)  left -> 39, right -> 44
node(13,38,1,39).
left_node(13,38,39).
right_node(13,38,44).
% node 39: f2 <= 2.5600000619888306  (F2, bin <= 41)  left -> 40, right -> 41
node(13,39,2,41).
left_node(13,39,40).
right_node(13,39,41).
% node 40 (leaf): class g (0)
leaf_class(13,40,0).
% node 41: f8 <= 32.36364936828613  (F8, bin <= 75)  left -> 42, right -> 43
node(13,41,8,75).
left_node(13,41,42).
right_node(13,41,43).
% node 42 (leaf): class g (0)
leaf_class(13,42,0).
% node 43 (leaf): class h (1)
leaf_class(13,43,1).
% node 44 (leaf): class g (0)
leaf_class(13,44,0).
% node 45: f0 <= 90.55760192871094  (F0, bin <= 55)  left -> 46, right -> 51
node(13,45,0,55).
left_node(13,45,46).
right_node(13,45,51).
% node 46: f2 <= 2.430999994277954  (F2, bin <= 20)  left -> 47, right -> 48
node(13,46,2,20).
left_node(13,46,47).
right_node(13,46,48).
% node 47 (leaf): class g (0)
leaf_class(13,47,0).
% node 48: f5 <= -45.16964912414551  (F5, bin <= 2)  left -> 49, right -> 50
node(13,48,5,2).
left_node(13,48,49).
right_node(13,48,50).
% node 49 (leaf): class g (0)
leaf_class(13,49,0).
% node 50 (leaf): class h (1)
leaf_class(13,50,1).
% node 51 (leaf): class h (1)
leaf_class(13,51,1).
% node 52: f6 <= -88.79045104980469  (F6, bin <= 1)  left -> 53, right -> 54
node(13,52,6,1).
left_node(13,52,53).
right_node(13,52,54).
% node 53 (leaf): class h (1)
leaf_class(13,53,1).
% node 54: f2 <= 2.760800004005432  (F2, bin <= 52)  left -> 55, right -> 56
node(13,54,2,52).
left_node(13,54,55).
right_node(13,54,56).
% node 55 (leaf): class g (0)
leaf_class(13,55,0).
% node 56: f8 <= 11.415299892425537  (F8, bin <= 30)  left -> 57, right -> 58
node(13,56,8,30).
left_node(13,56,57).
right_node(13,56,58).
% node 57 (leaf): class g (0)
leaf_class(13,57,0).
% node 58 (leaf): class h (1)
leaf_class(13,58,1).

% Tree 14
tree(14).
% node 0: f1 <= 39.79909896850586  (F1, bin <= 57)  left -> 1, right -> 44
node(14,0,1,57).
left_node(14,0,1).
right_node(14,0,44).
% node 1: f2 <= 3.318650007247925  (F2, bin <= 59)  left -> 2, right -> 41
node(14,1,2,59).
left_node(14,1,2).
right_node(14,1,41).
% node 2: f1 <= 9.821449756622314  (F1, bin <= 13)  left -> 3, right -> 18
node(14,2,1,13).
left_node(14,2,3).
right_node(14,2,18).
% node 3: f2 <= 2.4541999101638794  (F2, bin <= 26)  left -> 4, right -> 11
node(14,3,2,26).
left_node(14,3,4).
right_node(14,3,11).
% node 4: f0 <= 17.48449993133545  (F0, bin <= 5)  left -> 5, right -> 6
node(14,4,0,5).
left_node(14,4,5).
right_node(14,4,6).
% node 5 (leaf): class h (1)
leaf_class(14,5,1).
% node 6: f8 <= 52.7851505279541  (F8, bin <= 97)  left -> 7, right -> 8
node(14,6,8,97).
left_node(14,6,7).
right_node(14,6,8).
% node 7 (leaf): class g (0)
leaf_class(14,7,0).
% node 8: f2 <= 2.3035500049591064  (F2, bin <= 1)  left -> 9, right -> 10
node(14,8,2,1).
left_node(14,8,9).
right_node(14,8,10).
% node 9 (leaf): class g (0)
leaf_class(14,9,0).
% node 10 (leaf): class h (1)
leaf_class(14,10,1).
% node 11: f1 <= 9.5912504196167  (F1, bin <= 8)  left -> 12, right -> 15
node(14,11,1,8).
left_node(14,11,12).
right_node(14,11,15).
% node 12: f8 <= 4.860550165176392  (F8, bin <= 3)  left -> 13, right -> 14
node(14,12,8,3).
left_node(14,12,13).
right_node(14,12,14).
% node 13 (leaf): class h (1)
leaf_class(14,13,1).
% node 14 (leaf): class h (1)
leaf_class(14,14,1).
% node 15: f8 <= 20.082300186157227  (F8, bin <= 49)  left -> 16, right -> 17
node(14,15,8,49).
left_node(14,15,16).
right_node(14,15,17).
% node 16 (leaf): class g (0)
leaf_class(14,16,0).
% node 17 (leaf): class h (1)
leaf_class(14,17,1).
% node 18: f8 <= 25.24250030517578  (F8, bin <= 63)  left -> 19, right -> 30
node(14,18,8,63).
left_node(14,18,19).
right_node(14,18,30).
% node 19: f1 <= 29.450650215148926  (F1, bin <= 48)  left -> 20, right -> 27
node(14,19,1,48).
left_node(14,19,20).
right_node(14,19,27).
% node 20: f4 <= 0.31884999573230743  (F4, bin <= 18)  left -> 21, right -> 24
node(14,20,4,18).
left_node(14,20,21).
right_node(14,20,24).
% node 21: f0 <= 90.54150009155273  (F0, bin <= 54)  left -> 22, right -> 23
node(14,21,0,54).
left_node(14,21,22).
right_node(14,21,23).
% node 22 (leaf): class g (0)
leaf_class(14,22,0).
% node 23 (leaf): class g (0)
leaf_class(14,23,0).
% node 24: f2 <= 2.547100067138672  (F2, bin <= 40)  left -> 25, right -> 26
node(14,24,2,40).
left_node(14,24,25).
right_node(14,24,26).
% node 25 (leaf): class g (0)
leaf_class(14,25,0).
% node 26 (leaf): class h (1)
leaf_class(14,26,1).
% node 27: f4 <= 0.15365000069141388  (F4, bin <= 3)  left -> 28, right -> 29
node(14,27,4,3).
left_node(14,27,28).
right_node(14,27,29).
% node 28 (leaf): class g (0)
leaf_class(14,28,0).
% node 29 (leaf): class h (1)
leaf_class(14,29,1).
% node 30: f6 <= 22.21619987487793  (F6, bin <= 31)  left -> 31, right -> 36
node(14,30,6,31).
left_node(14,30,31).
right_node(14,30,36).
% node 31: f0 <= 32.02880001068115  (F0, bin <= 25)  left -> 32, right -> 35
node(14,31,0,25).
left_node(14,31,32).
right_node(14,31,35).
% node 32: f2 <= 2.489549994468689  (F2, bin <= 33)  left -> 33, right -> 34
node(14,32,2,33).
left_node(14,32,33).
right_node(14,32,34).
% node 33 (leaf): class g (0)
leaf_class(14,33,0).
% node 34 (leaf): class g (0)
leaf_class(14,34,0).
% node 35 (leaf): class h (1)
leaf_class(14,35,1).
% node 36: f0 <= 57.17290115356445  (F0, bin <= 49)  left -> 37, right -> 40
node(14,36,0,49).
left_node(14,36,37).
right_node(14,36,40).
% node 37: f1 <= 17.981450080871582  (F1, bin <= 40)  left -> 38, right -> 39
node(14,37,1,40).
left_node(14,37,38).
right_node(14,37,39).
% node 38 (leaf): class h (1)
leaf_class(14,38,1).
% node 39 (leaf): class h (1)
leaf_class(14,39,1).
% node 40 (leaf): class h (1)
leaf_class(14,40,1).
% node 41: f6 <= -52.38195037841797  (F6, bin <= 10)  left -> 42, right -> 43
node(14,41,6,10).
left_node(14,41,42).
right_node(14,41,43).
% node 42 (leaf): class h (1)
leaf_class(14,42,1).
% node 43 (leaf): class g (0)
leaf_class(14,43,0).
% node 44: f2 <= 3.894800066947937  (F2, bin <= 64)  left -> 45, right -> 52
node(14,44,2,64).
left_node(14,44,45).
right_node(14,44,52).
% node 45: f8 <= 17.132200241088867  (F8, bin <= 47)  left -> 46, right -> 51
node(14,45,8,47).
left_node(14,45,46).
right_node(14,45,51).
% node 46: f0 <= 100.62425231933594  (F0, bin <= 60)  left -> 47, right -> 50
node(14,46,0,60).
left_node(14,46,47).
right_node(14,46,50).
% node 47: f5 <= 19.167150497436523  (F5, bin <= 11)  left -> 48, right -> 49
node(14,47,5,11).
left_node(14,47,48).
right_node(14,47,49).
% node 48 (leaf): class h (1)
leaf_class(14,48,1).
% node 49 (leaf): class g (0)
leaf_class(14,49,0).
% node 50 (leaf): class h (1)
leaf_class(14,50,1).
% node 51 (leaf): class h (1)
leaf_class(14,51,1).
% node 52: f8 <= 8.81155014038086  (F8, bin <= 19)  left -> 53, right -> 54
node(14,52,8,19).
left_node(14,52,53).
right_node(14,52,54).
% node 53 (leaf): class g (0)
leaf_class(14,53,0).
% node 54 (leaf): class h (1)
leaf_class(14,54,1).

% Tree 15
tree(15).
% node 0: f8 <= 20.875500679016113  (F8, bin <= 51)  left -> 1, right -> 20
node(15,0,8,51).
left_node(15,0,1).
right_node(15,0,20).
% node 1: f6 <= -67.38694763183594  (F6, bin <= 5)  left -> 2, right -> 3
node(15,1,6,5).
left_node(15,1,2).
right_node(15,1,3).
% node 2 (leaf): class h (1)
leaf_class(15,2,1).
% node 3: f8 <= 12.686299800872803  (F8, bin <= 41)  left -> 4, right -> 9
node(15,3,8,41).
left_node(15,3,4).
right_node(15,3,9).
% node 4: f3 <= 0.5155999958515167  (F3, bin <= 21)  left -> 5, right -> 8
node(15,4,3,21).
left_node(15,4,5).
right_node(15,4,8).
% node 5: f0 <= 116.58200073242188  (F0, bin <= 79)  left -> 6, right -> 7
node(15,5,0,79).
left_node(15,5,6).
right_node(15,5,7).
% node 6 (leaf): class g (0)
leaf_class(15,6,0).
% node 7 (leaf): class h (1)
leaf_class(15,7,1).
% node 8 (leaf): class g (0)
leaf_class(15,8,0).
% node 9: f9 <= 239.02399444580078  (F9, bin <= 27)  left -> 10, right -> 19
node(15,9,9,27).
left_node(15,9,10).
right_node(15,9,19).
% node 10: f1 <= 42.99434852600098  (F1, bin <= 64)  left -> 11, right -> 18
node(15,10,1,64).
left_node(15,10,11).
right_node(15,10,18).
% node 11: f0 <= 47.7012996673584  (F0, bin <= 45)  left -> 12, right -> 15
node(15,11,0,45).
left_node(15,11,12).
right_node(15,11,15).
% node 12: f3 <= 0.4786499887704849  (F3, bin <= 18)  left -> 13, right -> 14
node(15,12,3,18).
left_node(15,12,13).
right_node(15,12,14).
% node 13 (leaf): class g (0)
leaf_class(15,13,0).
% node 14 (leaf): class g (0)
leaf_class(15,14,0).
% node 15: f3 <= 0.23514999449253082  (F3, bin <= 4)  left -> 16, right -> 17
node(15,15,3,4).
left_node(15,15,16).
right_node(15,15,17).
% node 16 (leaf): class g (0)
leaf_class(15,16,0).
% node 17 (leaf): class h (1)
leaf_class(15,17,1).
% node 18 (leaf): class h (1)
leaf_class(15,18,1).
% node 19 (leaf): class h (1)
leaf_class(15,19,1).
% node 20: f2 <= 2.4805999994277954  (F2, bin <= 32)  left -> 21, right -> 38
node(15,20,2,32).
left_node(15,20,21).
right_node(15,20,38).
% node 21: f2 <= 2.3152999877929688  (F2, bin <= 5)  left -> 22, right -> 31
node(15,21,2,5).
left_node(15,21,22).
right_node(15,21,31).
% node 22: f5 <= 28.081900596618652  (F5, bin <= 16)  left -> 23, right -> 30
node(15,22,5,16).
left_node(15,22,23).
right_node(15,22,30).
% node 23: f0 <= 12.11709976196289  (F0, bin <= 0)  left -> 24, right -> 25
node(15,23,0,0).
left_node(15,23,24).
right_node(15,23,25).
% node 24 (leaf): class h (1)
leaf_class(15,24,1).
% node 25: f1 <= 6.125999927520752  (F1, bin <= 4)  left -> 26, right -> 29
node(15,25,1,4).
left_node(15,25,26).
right_node(15,25,29).
% node 26: f1 <= 0.035100000677630305  (F1, bin <= 1)  left -> 27, right -> 28
node(15,26,1,1).
left_node(15,26,27).
right_node(15,26,28).
% node 27 (leaf): class g (0)
leaf_class(15,27,0).
% node 28 (leaf): class h (1)
leaf_class(15,28,1).
% node 29 (leaf): class g (0)
leaf_class(15,29,0).
% node 30 (leaf): class h (1)
leaf_class(15,30,1).
% node 31: f3 <= 0.6471499800682068  (F3, bin <= 31)  left -> 32, right -> 37
node(15,31,3,31).
left_node(15,31,32).
right_node(15,31,37).
% node 32: f9 <= 210.00749969482422  (F9, bin <= 18)  left -> 33, right -> 36
node(15,32,9,18).
left_node(15,32,33).
right_node(15,32,36).
% node 33: f8 <= 57.99989891052246  (F8, bin <= 99)  left -> 34, right -> 35
node(15,33,8,99).
left_node(15,33,34).
right_node(15,33,35).
% node 34 (leaf): class g (0)
leaf_class(15,34,0).
% node 35 (leaf): class g (0)
leaf_class(15,35,0).
% node 36 (leaf): class h (1)
leaf_class(15,36,1).
% node 37 (leaf): class h (1)
leaf_class(15,37,1).
% node 38: f9 <= 198.59764862060547  (F9, bin <= 14)  left -> 39, right -> 50
node(15,38,9,14).
left_node(15,38,39).
right_node(15,38,50).
% node 39: f1 <= 11.852099895477295  (F1, bin <= 27)  left -> 40, right -> 41
node(15,39,1,27).
left_node(15,39,40).
right_node(15,39,41).
% node 40 (leaf): class h (1)
leaf_class(15,40,1).
% node 41: f1 <= 27.789849281311035  (F1, bin <= 45)  left -> 42, right -> 47
node(15,41,1,45).
left_node(15,41,42).
right_node(15,41,47).
% node 42: f0 <= 41.56105041503906  (F0, bin <= 38)  left -> 43, right -> 46
node(15,42,0,38).
left_node(15,42,43).
right_node(15,42,46).
% node 43: f4 <= 0.31155000627040863  (F4, bin <= 16)  left -> 44, right -> 45
node(15,43,4,16).
left_node(15,43,44).
right_node(15,43,45).
% node 44 (leaf): class g (0)
leaf_class(15,44,0).
% node 45 (leaf): class h (1)
leaf_class(15,45,1).
% node 46 (leaf): class h (1)
leaf_class(15,46,1).
% node 47: f0 <= 56.41510009765625  (F0, bin <= 48)  left -> 48, right -> 49
node(15,47,0,48).
left_node(15,47,48).
right_node(15,47,49).
% node 48 (leaf): class g (0)
leaf_class(15,48,0).
% node 49 (leaf): class h (1)
leaf_class(15,49,1).
% node 50: f0 <= 33.417598724365234  (F0, bin <= 29)  left -> 51, right -> 54
node(15,50,0,29).
left_node(15,50,51).
right_node(15,50,54).
% node 51: f4 <= 0.23420000076293945  (F4, bin <= 11)  left -> 52, right -> 53
node(15,51,4,11).
left_node(15,51,52).
right_node(15,51,53).
% node 52 (leaf): class g (0)
leaf_class(15,52,0).
% node 53 (leaf): class h (1)
leaf_class(15,53,1).
% node 54 (leaf): class h (1)
leaf_class(15,54,1).

% Tree 16
tree(16).
% node 0: f0 <= 107.60854721069336  (F0, bin <= 67)  left -> 1, right -> 66
node(16,0,0,67).
left_node(16,0,1).
right_node(16,0,66).
% node 1: f4 <= 0.20044999569654465  (F4, bin <= 5)  left -> 2, right -> 25
node(16,1,4,5).
left_node(16,1,2).
right_node(16,1,25).
% node 2: f7 <= -27.980899810791016  (F7, bin <= 1)  left -> 3, right -> 8
node(16,2,7,1).
left_node(16,2,3).
right_node(16,2,8).
% node 3: f1 <= 44.80994987487793  (F1, bin <= 66)  left -> 4, right -> 7
node(16,3,1,66).
left_node(16,3,4).
right_node(16,3,7).
% node 4: f8 <= 21.064099311828613  (F8, bin <= 52)  left -> 5, right -> 6
node(16,4,8,52).
left_node(16,4,5).
right_node(16,4,6).
% node 5 (leaf): class g (0)
leaf_class(16,5,0).
% node 6 (leaf): class h (1)
leaf_class(16,6,1).
% node 7 (leaf): class h (1)
leaf_class(16,7,1).
% node 8: f5 <= -15.404200077056885  (F5, bin <= 8)  left -> 9, right -> 20
node(16,8,5,8).
left_node(16,8,9).
right_node(16,8,20).
% node 9: f6 <= -20.989700317382812  (F6, bin <= 24)  left -> 10, right -> 15
node(16,9,6,24).
left_node(16,9,10).
right_node(16,9,15).
% node 10: f1 <= 38.27530097961426  (F1, bin <= 56)  left -> 11, right -> 14
node(16,10,1,56).
left_node(16,10,11).
right_node(16,10,14).
% node 11: f8 <= 19.563749313354492  (F8, bin <= 48)  left -> 12, right -> 13
node(16,11,8,48).
left_node(16,11,12).
right_node(16,11,13).
% node 12 (leaf): class g (0)
leaf_class(16,12,0).
% node 13 (leaf): class h (1)
leaf_class(16,13,1).
% node 14 (leaf): class h (1)
leaf_class(16,14,1).
% node 15: f8 <= 20.12950038909912  (F8, bin <= 50)  left -> 16, right -> 17
node(16,15,8,50).
left_node(16,15,16).
right_node(16,15,17).
% node 16 (leaf): class g (0)
leaf_class(16,16,0).
% node 17: f6 <= 20.391650199890137  (F6, bin <= 29)  left -> 18, right -> 19
node(16,17,6,29).
left_node(16,17,18).
right_node(16,17,19).
% node 18 (leaf): class g (0)
leaf_class(16,18,0).
% node 19 (leaf): class h (1)
leaf_class(16,19,1).
% node 20: f1 <= 12.117749691009521  (F1, bin <= 29)  left -> 21, right -> 22
node(16,20,1,29).
left_node(16,20,21).
right_node(16,20,22).
% node 21 (leaf): class h (1)
leaf_class(16,21,1).
% node 22: f6 <= -44.81170082092285  (F6, bin <= 13)  left -> 23, right -> 24
node(16,22,6,13).
left_node(16,22,23).
right_node(16,22,24).
% node 23 (leaf): class h (1)
leaf_class(16,23,1).
% node 24 (leaf): class g (0)
leaf_class(16,24,0).
% node 25: f2 <= 2.4750499725341797  (F2, bin <= 30)  left -> 26, right -> 45
node(16,25,2,30).
left_node(16,25,26).
right_node(16,25,45).
% node 26: f2 <= 2.316499948501587  (F2, bin <= 6)  left -> 27, right -> 34
node(16,26,2,6).
left_node(16,26,27).
right_node(16,26,34).
% node 27: f1 <= 6.554149866104126  (F1, bin <= 5)  left -> 28, right -> 33
node(16,27,1,5).
left_node(16,27,28).
right_node(16,27,33).
% node 28: f1 <= 0.0350000006146729  (F1, bin <= 0)  left -> 29, right -> 30
node(16,28,1,0).
left_node(16,28,29).
right_node(16,28,30).
% node 29 (leaf): class g (0)
leaf_class(16,29,0).
% node 30: f1 <= 5.801249980926514  (F1, bin <= 2)  left -> 31, right -> 32
node(16,30,1,2).
left_node(16,30,31).
right_node(16,30,32).
% node 31 (leaf): class h (1)
leaf_class(16,31,1).
% node 32 (leaf): class g (0)
leaf_class(16,32,0).
% node 33 (leaf): class g (0)
leaf_class(16,33,0).
% node 34: f8 <= 38.83440017700195  (F8, bin <= 81)  left -> 35, right -> 40
node(16,34,8,81).
left_node(16,34,35).
right_node(16,34,40).
% node 35: f6 <= -10.330299854278564  (F6, bin <= 25)  left -> 36, right -> 37
node(16,35,6,25).
left_node(16,35,36).
right_node(16,35,37).
% node 36 (leaf): class g (0)
leaf_class(16,36,0).
% node 37: f3 <= 0.6480999886989594  (F3, bin <= 32)  left -> 38, right -> 39
node(16,37,3,32).
left_node(16,37,38).
right_node(16,37,39).
% node 38 (leaf): class g (0)
leaf_class(16,38,0).
% node 39 (leaf): class h (1)
leaf_class(16,39,1).
% node 40: f5 <= 26.101200103759766  (F5, bin <= 14)  left -> 41, right -> 44
node(16,40,5,14).
left_node(16,40,41).
right_node(16,40,44).
% node 41: f3 <= 0.722599983215332  (F3, bin <= 36)  left -> 42, right -> 43
node(16,41,3,36).
left_node(16,41,42).
right_node(16,41,43).
% node 42 (leaf): class g (0)
leaf_class(16,42,0).
% node 43 (leaf): class h (1)
leaf_class(16,43,1).
% node 44 (leaf): class h (1)
leaf_class(16,44,1).
% node 45: f1 <= 11.74275016784668  (F1, bin <= 26)  left -> 46, right -> 55
node(16,45,1,26).
left_node(16,45,46).
right_node(16,45,55).
% node 46: f2 <= 2.534749984741211  (F2, bin <= 39)  left -> 47, right -> 50
node(16,46,2,39).
left_node(16,46,47).
right_node(16,46,50).
% node 47: f1 <= 9.604700088500977  (F1, bin <= 9)  left -> 48, right -> 49
node(16,47,1,9).
left_node(16,47,48).
right_node(16,47,49).
% node 48 (leaf): class h (1)
leaf_class(16,48,1).
% node 49 (leaf): class g (0)
leaf_class(16,49,0).
% node 50: f4 <= 0.30204999446868896  (F4, bin <= 15)  left -> 51, right -> 54
node(16,50,4,15).
left_node(16,50,51).
right_node(16,50,54).
% node 51: f8 <= 14.310850143432617  (F8, bin <= 43)  left -> 52, right -> 53
node(16,51,8,43).
left_node(16,51,52).
right_node(16,51,53).
% node 52 (leaf): class g (0)
leaf_class(16,52,0).
% node 53 (leaf): class h (1)
leaf_class(16,53,1).
% node 54 (leaf): class h (1)
leaf_class(16,54,1).
% node 55: f8 <= 28.5027494430542  (F8, bin <= 70)  left -> 56, right -> 61
node(16,55,8,70).
left_node(16,55,56).
right_node(16,55,61).
% node 56: f3 <= 0.5512999892234802  (F3, bin <= 27)  left -> 57, right -> 60
node(16,56,3,27).
left_node(16,56,57).
right_node(16,56,60).
% node 57: f0 <= 54.91805076599121  (F0, bin <= 47)  left -> 58, right -> 59
node(16,57,0,47).
left_node(16,57,58).
right_node(16,57,59).
% node 58 (leaf): class g (0)
leaf_class(16,58,0).
% node 59 (leaf): class g (0)
leaf_class(16,59,0).
% node 60 (leaf): class h (1)
leaf_class(16,60,1).
% node 61: f6 <= 31.018199920654297  (F6, bin <= 41)  left -> 62, right -> 65
node(16,61,6,41).
left_node(16,61,62).
right_node(16,61,65).
% node 62: f9 <= 86.46260070800781  (F9, bin <= 0)  left -> 63, right -> 64
node(16,62,9,0).
left_node(16,62,63).
right_node(16,62,64).
% node 63 (leaf): class g (0)
leaf_class(16,63,0).
% node 64 (leaf): class h (1)
leaf_class(16,64,1).
% node 65 (leaf): class h (1)
leaf_class(16,65,1).
% node 66: f8 <= 8.693050384521484  (F8, bin <= 16)  left -> 67, right -> 70
node(16,66,8,16).
left_node(16,66,67).
right_node(16,66,70).
% node 67: f1 <= 40.080848693847656  (F1, bin <= 59)  left -> 68, right -> 69
node(16,67,1,59).
left_node(16,67,68).
right_node(16,67,69).
% node 68 (leaf): class g (0)
leaf_class(16,68,0).
% node 69 (leaf): class h (1)
leaf_class(16,69,1).
% node 70 (leaf): class h (1)
leaf_class(16,70,1).

% Tree 17
tree(17).
% node 0: f1 <= 41.54294967651367  (F1, bin <= 61)  left -> 1, right -> 46
node(17,0,1,61).
left_node(17,0,1).
right_node(17,0,46).
% node 1: f6 <= -53.620248794555664  (F6, bin <= 7)  left -> 2, right -> 9
node(17,1,6,7).
left_node(17,1,2).
right_node(17,1,9).
% node 2: f0 <= 105.89749908447266  (F0, bin <= 65)  left -> 3, right -> 8
node(17,2,0,65).
left_node(17,2,3).
right_node(17,2,8).
% node 3: f5 <= -15.40215015411377  (F5, bin <= 9)  left -> 4, right -> 7
node(17,3,5,9).
left_node(17,3,4).
right_node(17,3,7).
% node 4: f8 <= 9.633249759674072  (F8, bin <= 23)  left -> 5, right -> 6
node(17,4,8,23).
left_node(17,4,5).
right_node(17,4,6).
% node 5 (leaf): class g (0)
leaf_class(17,5,0).
% node 6 (leaf): class h (1)
leaf_class(17,6,1).
% node 7 (leaf): class g (0)
leaf_class(17,7,0).
% node 8 (leaf): class h (1)
leaf_class(17,8,1).
% node 9: f1 <= 12.519000053405762  (F1, bin <= 33)  left -> 10, right -> 27
node(17,9,1,33).
left_node(17,9,10).
right_node(17,9,27).
% node 10: f6 <= 22.62345027923584  (F6, bin <= 33)  left -> 11, right -> 22
node(17,10,6,33).
left_node(17,10,11).
right_node(17,10,22).
% node 11: f3 <= 0.4322500079870224  (F3, bin <= 12)  left -> 12, right -> 17
node(17,11,3,12).
left_node(17,11,12).
right_node(17,11,17).
% node 12: f0 <= 32.6440486907959  (F0, bin <= 27)  left -> 13, right -> 14
node(17,12,0,27).
left_node(17,12,13).
right_node(17,12,14).
% node 13 (leaf): class g (0)
leaf_class(17,13,0).
% node 14: f2 <= 2.6190500259399414  (F2, bin <= 47)  left -> 15, right -> 16
node(17,14,2,47).
left_node(17,14,15).
right_node(17,14,16).
% node 15 (leaf): class g (0)
leaf_class(17,15,0).
% node 16 (leaf): class h (1)
leaf_class(17,16,1).
% node 17: f2 <= 2.455199956893921  (F2, bin <= 28)  left -> 18, right -> 21
node(17,17,2,28).
left_node(17,17,18).
right_node(17,17,21).
% node 18: f4 <= 0.42730000615119934  (F4, bin <= 22)  left -> 19, right -> 20
node(17,18,4,22).
left_node(17,18,19).
right_node(17,18,20).
% node 19 (leaf): class g (0)
leaf_class(17,19,0).
% node 20 (leaf): class g (0)
leaf_class(17,20,0).
% node 21 (leaf): class h (1)
leaf_class(17,21,1).
% node 22: f8 <= 11.941149711608887  (F8, bin <= 36)  left -> 23, right -> 24
node(17,22,8,36).
left_node(17,22,23).
right_node(17,22,24).
% node 23 (leaf): class g (0)
leaf_class(17,23,0).
% node 24: f2 <= 2.6018500328063965  (F2, bin <= 45)  left -> 25, right -> 26
node(17,24,2,45).
left_node(17,24,25).
right_node(17,24,26).
% node 25 (leaf): class h (1)
leaf_class(17,25,1).
% node 26 (leaf): class h (1)
leaf_class(17,26,1).
% node 27: f8 <= 22.458849906921387  (F8, bin <= 55)  left -> 28, right -> 35
node(17,27,8,55).
left_node(17,27,28).
right_node(17,27,35).
% node 28: f3 <= 0.5699000060558319  (F3, bin <= 28)  left -> 29, right -> 34
node(17,28,3,28).
left_node(17,28,29).
right_node(17,28,34).
% node 29: f0 <= 108.05244827270508  (F0, bin <= 69)  left -> 30, right -> 33
node(17,29,0,69).
left_node(17,29,30).
right_node(17,29,33).
% node 30: f8 <= 11.689249992370605  (F8, bin <= 32)  left -> 31, right -> 32
node(17,30,8,32).
left_node(17,30,31).
right_node(17,30,32).
% node 31 (leaf): class g (0)
leaf_class(17,31,0).
% node 32 (leaf): class g (0)
leaf_class(17,32,0).
% node 33 (leaf): class g (0)
leaf_class(17,33,0).
% node 34 (leaf): class g (0)
leaf_class(17,34,0).
% node 35: f9 <= 217.15960693359375  (F9, bin <= 22)  left -> 36, right -> 43
node(17,35,9,22).
left_node(17,35,36).
right_node(17,35,43).
% node 36: f6 <= 31.129249572753906  (F6, bin <= 43)  left -> 37, right -> 40
node(17,36,6,43).
left_node(17,36,37).
right_node(17,36,40).
% node 37: f0 <= 40.20734977722168  (F0, bin <= 34)  left -> 38, right -> 39
node(17,37,0,34).
left_node(17,37,38).
right_node(17,37,39).
% node 38 (leaf): class g (0)
leaf_class(17,38,0).
% node 39 (leaf): class h (1)
leaf_class(17,39,1).
% node 40: f8 <= 42.17890167236328  (F8, bin <= 86)  left -> 41, right -> 42
node(17,40,8,86).
left_node(17,40,41).
right_node(17,40,42).
% node 41 (leaf): class g (0)
leaf_class(17,41,0).
% node 42 (leaf): class h (1)
leaf_class(17,42,1).
% node 43: f2 <= 2.6858500242233276  (F2, bin <= 51)  left -> 44, right -> 45
node(17,43,2,51).
left_node(17,43,44).
right_node(17,43,45).
% node 44 (leaf): class h (1)
leaf_class(17,44,1).
% node 45 (leaf): class h (1)
leaf_class(17,45,1).
% node 46: f0 <= 115.73925018310547  (F0, bin <= 76)  left -> 47, right -> 56
node(17,46,0,76).
left_node(17,46,47).
right_node(17,46,56).
% node 47: f5 <= 0.4040500074625015  (F5, bin <= 10)  left -> 48, right -> 51
node(17,47,5,10).
left_node(17,47,48).
right_node(17,47,51).
% node 48: f2 <= 4.1773998737335205  (F2, bin <= 68)  left -> 49, right -> 50
node(17,48,2,68).
left_node(17,48,49).
right_node(17,48,50).
% node 49 (leaf): class h (1)
leaf_class(17,49,1).
% node 50 (leaf): class g (0)
leaf_class(17,50,0).
% node 51: f9 <= 170.32424926757812  (F9, bin <= 8)  left -> 52, right -> 53
node(17,51,9,8).
left_node(17,51,52).
right_node(17,51,53).
% node 52 (leaf): class h (1)
leaf_class(17,52,1).
% node 53: f2 <= 3.7792000770568848  (F2, bin <= 63)  left -> 54, right -> 55
node(17,53,2,63).
left_node(17,53,54).
right_node(17,53,55).
% node 54 (leaf): class h (1)
leaf_class(17,54,1).
% node 55 (leaf): class g (0)
leaf_class(17,55,0).
% node 56 (leaf): class h (1)
leaf_class(17,56,1).

% Tree 18
tree(18).
% node 0: f6 <= -38.46419906616211  (F6, bin <= 15)  left -> 1, right -> 12
node(18,0,6,15).
left_node(18,0,1).
right_node(18,0,12).
% node 1: f1 <= 35.74660110473633  (F1, bin <= 53)  left -> 2, right -> 11
node(18,1,1,53).
left_node(18,1,2).
right_node(18,1,11).
% node 2: f0 <= 110.20650100708008  (F0, bin <= 70)  left -> 3, right -> 10
node(18,2,0,70).
left_node(18,2,3).
right_node(18,2,10).
% node 3: f7 <= -19.137450218200684  (F7, bin <= 5)  left -> 4, right -> 5
node(18,3,7,5).
left_node(18,3,4).
right_node(18,3,5).
% node 4 (leaf): class h (1)
leaf_class(18,4,1).
% node 5: f3 <= 0.18084999918937683  (F3, bin <= 3)  left -> 6, right -> 7
node(18,5,3,3).
left_node(18,5,6).
right_node(18,5,7).
% node 6 (leaf): class h (1)
leaf_class(18,6,1).
% node 7: f8 <= 8.593599796295166  (F8, bin <= 15)  left -> 8, right -> 9
node(18,7,8,15).
left_node(18,7,8).
right_node(18,7,9).
% node 8 (leaf): class g (0)
leaf_class(18,8,0).
% node 9 (leaf): class h (1)
leaf_class(18,9,1).
% node 10 (leaf): class h (1)
leaf_class(18,10,1).
% node 11 (leaf): class h (1)
leaf_class(18,11,1).
% node 12: f5 <= -131.17749786376953  (F5, bin <= 0)  left -> 13, right -> 16
node(18,12,5,0).
left_node(18,12,13).
right_node(18,12,16).
% node 13: f8 <= 8.785799980163574  (F8, bin <= 18)  left -> 14, right -> 15
node(18,13,8,18).
left_node(18,13,14).
right_node(18,13,15).
% node 14 (leaf): class g (0)
leaf_class(18,14,0).
% node 15 (leaf): class h (1)
leaf_class(18,15,1).
% node 16: f0 <= 114.74349975585938  (F0, bin <= 74)  left -> 17, right -> 44
node(18,16,0,74).
left_node(18,16,17).
right_node(18,16,44).
% node 17: f4 <= 0.20754999667406082  (F4, bin <= 7)  left -> 18, right -> 29
node(18,17,4,7).
left_node(18,17,18).
right_node(18,17,29).
% node 18: f0 <= 94.9666519165039  (F0, bin <= 56)  left -> 19, right -> 26
node(18,18,0,56).
left_node(18,18,19).
right_node(18,18,26).
% node 19: f8 <= 23.987350463867188  (F8, bin <= 56)  left -> 20, right -> 23
node(18,19,8,56).
left_node(18,19,20).
right_node(18,19,23).
% node 20: f1 <= 48.23850059509277  (F1, bin <= 73)  left -> 21, right -> 22
node(18,20,1,73).
left_node(18,20,21).
right_node(18,20,22).
% node 21 (leaf): class g (0)
leaf_class(18,21,0).
% node 22 (leaf): class h (1)
leaf_class(18,22,1).
% node 23: f6 <= 28.607500076293945  (F6, bin <= 40)  left -> 24, right -> 25
node(18,23,6,40).
left_node(18,23,24).
right_node(18,23,25).
% node 24 (leaf): class g (0)
leaf_class(18,24,0).
% node 25 (leaf): class h (1)
leaf_class(18,25,1).
% node 26: f8 <= 15.456900119781494  (F8, bin <= 45)  left -> 27, right -> 28
node(18,26,8,45).
left_node(18,26,27).
right_node(18,26,28).
% node 27 (leaf): class g (0)
leaf_class(18,27,0).
% node 28 (leaf): class h (1)
leaf_class(18,28,1).
% node 29: f8 <= 36.46150016784668  (F8, bin <= 80)  left -> 30, right -> 37
node(18,29,8,80).
left_node(18,29,30).
right_node(18,29,37).
% node 30: f1 <= 10.550399780273438  (F1, bin <= 16)  left -> 31, right -> 34
node(18,30,1,16).
left_node(18,30,31).
right_node(18,30,34).
% node 31: f0 <= 18.551100730895996  (F0, bin <= 11)  left -> 32, right -> 33
node(18,31,0,11).
left_node(18,31,32).
right_node(18,31,33).
% node 32 (leaf): class h (1)
leaf_class(18,32,1).
% node 33 (leaf): class g (0)
leaf_class(18,33,0).
% node 34: f5 <= 43.05570030212402  (F5, bin <= 17)  left -> 35, right -> 36
node(18,34,5,17).
left_node(18,34,35).
right_node(18,34,36).
% node 35 (leaf): class g (0)
leaf_class(18,35,0).
% node 36 (leaf): class g (0)
leaf_class(18,36,0).
% node 37: f0 <= 26.187199592590332  (F0, bin <= 13)  left -> 38, right -> 41
node(18,37,0,13).
left_node(18,37,38).
right_node(18,37,41).
% node 38: f5 <= 26.101200103759766  (F5, bin <= 14)  left -> 39, right -> 40
node(18,38,5,14).
left_node(18,38,39).
right_node(18,38,40).
% node 39 (leaf): class g (0)
leaf_class(18,39,0).
% node 40 (leaf): class h (1)
leaf_class(18,40,1).
% node 41: f2 <= 2.3793500661849976  (F2, bin <= 10)  left -> 42, right -> 43
node(18,41,2,10).
left_node(18,41,42).
right_node(18,41,43).
% node 42 (leaf): class g (0)
leaf_class(18,42,0).
% node 43 (leaf): class h (1)
leaf_class(18,43,1).
% node 44 (leaf): class h (1)
leaf_class(18,44,1).

% Tree 19
tree(19).
% node 0: f8 <= 21.67574977874756  (F8, bin <= 53)  left -> 1, right -> 26
node(19,0,8,53).
left_node(19,0,1).
right_node(19,0,26).
% node 1: f6 <= -67.64299774169922  (F6, bin <= 4)  left -> 2, right -> 5
node(19,1,6,4).
left_node(19,1,2).
right_node(19,1,5).
% node 2: f1 <= 24.24049949645996  (F1, bin <= 43)  left -> 3, right -> 4
node(19,2,1,43).
left_node(19,2,3).
right_node(19,2,4).
% node 3 (leaf): class g (0)
leaf_class(19,3,0).
% node 4 (leaf): class h (1)
leaf_class(19,4,1).
% node 5: f8 <= 12.077499866485596  (F8, bin <= 39)  left -> 6, right -> 15
node(19,5,8,39).
left_node(19,5,6).
right_node(19,5,15).
% node 6: f7 <= -29.55650043487549  (F7, bin <= 0)  left -> 7, right -> 8
node(19,6,7,0).
left_node(19,6,7).
right_node(19,6,8).
% node 7 (leaf): class h (1)
leaf_class(19,7,1).
% node 8: f1 <= 12.147300243377686  (F1, bin <= 30)  left -> 9, right -> 10
node(19,8,1,30).
left_node(19,8,9).
right_node(19,8,10).
% node 9 (leaf): class g (0)
leaf_class(19,9,0).
% node 10: f0 <= 118.93104934692383  (F0, bin <= 86)  left -> 11, right -> 14
node(19,10,0,86).
left_node(19,10,11).
right_node(19,10,14).
% node 11: f6 <= -37.41365051269531  (F6, bin <= 16)  left -> 12, right -> 13
node(19,11,6,16).
left_node(19,11,12).
right_node(19,11,13).
% node 12 (leaf): class g (0)
leaf_class(19,12,0).
% node 13 (leaf): class g (0)
leaf_class(19,13,0).
% node 14 (leaf): class g (0)
leaf_class(19,14,0).
% node 15: f9 <= 239.38300323486328  (F9, bin <= 28)  left -> 16, right -> 23
node(19,15,9,28).
left_node(19,15,16).
right_node(19,15,23).
% node 16: f6 <= 102.96440124511719  (F6, bin <= 49)  left -> 17, right -> 22
node(19,16,6,49).
left_node(19,16,17).
right_node(19,16,22).
% node 17: f1 <= 12.511749744415283  (F1, bin <= 31)  left -> 18, right -> 21
node(19,17,1,31).
left_node(19,17,18).
right_node(19,17,21).
% node 18: f0 <= 40.940500259399414  (F0, bin <= 35)  left -> 19, right -> 20
node(19,18,0,35).
left_node(19,18,19).
right_node(19,18,20).
% node 19 (leaf): class g (0)
leaf_class(19,19,0).
% node 20 (leaf): class h (1)
leaf_class(19,20,1).
% node 21 (leaf): class g (0)
leaf_class(19,21,0).
% node 22 (leaf): class h (1)
leaf_class(19,22,1).
% node 23: f0 <= 96.97700119018555  (F0, bin <= 58)  left -> 24, right -> 25
node(19,23,0,58).
left_node(19,23,24).
right_node(19,23,25).
% node 24 (leaf): class g (0)
leaf_class(19,24,0).
% node 25 (leaf): class h (1)
leaf_class(19,25,1).
% node 26: f6 <= -26.694950103759766  (F6, bin <= 23)  left -> 27, right -> 28
node(19,26,6,23).
left_node(19,26,27).
right_node(19,26,28).
% node 27 (leaf): class h (1)
leaf_class(19,27,1).
% node 28: f2 <= 2.4541999101638794  (F2, bin <= 26)  left -> 29, right -> 38
node(19,28,2,26).
left_node(19,28,29).
right_node(19,28,38).
% node 29: f2 <= 2.2233000993728638  (F2, bin <= 0)  left -> 30, right -> 31
node(19,29,2,0).
left_node(19,29,30).
right_node(19,29,31).
% node 30 (leaf): class g (0)
leaf_class(19,30,0).
% node 31: f1 <= 8.98544979095459  (F1, bin <= 6)  left -> 32, right -> 33
node(19,31,1,6).
left_node(19,31,32).
right_node(19,31,33).
% node 32 (leaf): class h (1)
leaf_class(19,32,1).
% node 33: f0 <= 32.132901191711426  (F0, bin <= 26)  left -> 34, right -> 37
node(19,33,0,26).
left_node(19,33,34).
right_node(19,33,37).
% node 34: f4 <= 0.3144499957561493  (F4, bin <= 17)  left -> 35, right -> 36
node(19,34,4,17).
left_node(19,34,35).
right_node(19,34,36).
% node 35 (leaf): class g (0)
leaf_class(19,35,0).
% node 36 (leaf): class g (0)
leaf_class(19,36,0).
% node 37 (leaf): class h (1)
leaf_class(19,37,1).
% node 38: f9 <= 162.54399871826172  (F9, bin <= 7)  left -> 39, right -> 44
node(19,38,9,7).
left_node(19,38,39).
right_node(19,38,44).
% node 39: f1 <= 11.554250240325928  (F1, bin <= 24)  left -> 40, right -> 41
node(19,39,1,24).
left_node(19,39,40).
right_node(19,39,41).
% node 40 (leaf): class h (1)
leaf_class(19,40,1).
% node 41: f0 <= 46.32680130004883  (F0, bin <= 40)  left -> 42, right -> 43
node(19,41,0,40).
left_node(19,41,42).
right_node(19,41,43).
% node 42 (leaf): class g (0)
leaf_class(19,42,0).
% node 43 (leaf): class h (1)
leaf_class(19,43,1).
% node 44: f0 <= 29.18875026702881  (F0, bin <= 18)  left -> 45, right -> 48
node(19,44,0,18).
left_node(19,44,45).
right_node(19,44,48).
% node 45: f3 <= 0.48794999718666077  (F3, bin <= 19)  left -> 46, right -> 47
node(19,45,3,19).
left_node(19,45,46).
right_node(19,45,47).
% node 46 (leaf): class g (0)
leaf_class(19,46,0).
% node 47 (leaf): class h (1)
leaf_class(19,47,1).
% node 48: f8 <= 31.9195499420166  (F8, bin <= 71)  left -> 49, right -> 50
node(19,48,8,71).
left_node(19,48,49).
right_node(19,48,50).
% node 49 (leaf): class h (1)
leaf_class(19,49,1).
% node 50 (leaf): class h (1)
leaf_class(19,50,1).

% --- Class domain ---
class_idx(0).  % g
class_idx(1).  % h
