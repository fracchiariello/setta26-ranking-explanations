% ============================================================
% random_forest.lp — RF facts for students+dropout
% 30 trees  |  36 features
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

% Feature 0 (﻿Marital status): 2 bins  (thresholds: [1.5])
{bin(I,0,B) : B = 0..1} = 1 :- item(I).

% Feature 1 (Application mode): 12 bins  (thresholds: [3.0, 4.0, 6.0, 15.5, 16.5, 17.5, 22.0, 28.5, 40.5, 42.5, 43.5])
{bin(I,1,B) : B = 0..11} = 1 :- item(I).

% Feature 2 (Application order): 4 bins  (thresholds: [1.5, 2.5, 3.5])
{bin(I,2,B) : B = 0..3} = 1 :- item(I).

% Feature 3 (Course): 17 bins  (thresholds: [4092.5, 4645.0, 8508.5, 9036.5, 9077.5, 9102.0, 9107.5, 9138.5, 9192.5, 9246.0, 9377.0, 9528.0, 9721.5, 9813.0, 9830.5, 9922.0])
{bin(I,3,B) : B = 0..16} = 1 :- item(I).

% Feature 4 ("Daytime/evening attendance	"): 2 bins  (thresholds: [0.5])
{bin(I,4,B) : B = 0..1} = 1 :- item(I).

% Feature 5 (Previous qualification): 7 bins  (thresholds: [1.5, 2.0, 2.5, 3.5, 7.5, 29.0])
{bin(I,5,B) : B = 0..6} = 1 :- item(I).

% Feature 6 (Previous qualification (grade)): 21 bins  (thresholds: [118.5, 120.5, 123.5, 126.0, 128.5, 129.5, 130.5, 131.0, 131.5, 131.5500030517578, 133.0500030517578, 134.5, 135.5, 136.5, 138.5, 140.5, 140.9000015258789, 141.0, 141.5, 149.4499969482422])
{bin(I,6,B) : B = 0..20} = 1 :- item(I).

% Feature 8 (Mother's qualification): 12 bins  (thresholds: [1.5, 2.5, 3.5, 4.5, 7.5, 26.5, 28.0, 31.5, 33.0, 34.5, 35.5])
{bin(I,8,B) : B = 0..11} = 1 :- item(I).

% Feature 9 (Father's qualification): 9 bins  (thresholds: [1.5, 3.5, 4.5, 7.0, 26.5, 29.5, 35.5, 37.5])
{bin(I,9,B) : B = 0..8} = 1 :- item(I).

% Feature 10 (Mother's occupation): 14 bins  (thresholds: [0.5, 1.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 49.5, 94.5, 111.0, 116.5, 127.0])
{bin(I,10,B) : B = 0..13} = 1 :- item(I).

% Feature 11 (Father's occupation): 8 bins  (thresholds: [0.5, 3.5, 4.5, 5.5, 8.0, 8.5, 106.5])
{bin(I,11,B) : B = 0..7} = 1 :- item(I).

% Feature 12 (Admission grade): 32 bins  (thresholds: [104.5, 108.29999923706055, 108.3499984741211, 114.3499984741211, 118.1500015258789, 122.14999771118164, 122.4000015258789, 123.14999771118164, 123.45000076293945, 124.1500015258789, 126.35000228881836, 126.64999771118164, 127.70000076293945, 128.29999542236328, 129.1999969482422, 129.5500030517578, 129.9000015258789, 130.6999969482422, 132.0500030517578, 132.70000457763672, 133.0500030517578, 133.0999984741211, 133.4499969482422, 136.20000457763672, 136.45000457763672, 138.5500030517578, 140.5999984741211, 141.1999969482422, 145.6500015258789, 146.4000015258789, 147.5999984741211])
{bin(I,12,B) : B = 0..31} = 1 :- item(I).

% Feature 13 (Displaced): 2 bins  (thresholds: [0.5])
{bin(I,13,B) : B = 0..1} = 1 :- item(I).

% Feature 15 (Debtor): 2 bins  (thresholds: [0.5])
{bin(I,15,B) : B = 0..1} = 1 :- item(I).

% Feature 16 (Tuition fees up to date): 2 bins  (thresholds: [0.5])
{bin(I,16,B) : B = 0..1} = 1 :- item(I).

% Feature 17 (Gender): 2 bins  (thresholds: [0.5])
{bin(I,17,B) : B = 0..1} = 1 :- item(I).

% Feature 18 (Scholarship holder): 2 bins  (thresholds: [0.5])
{bin(I,18,B) : B = 0..1} = 1 :- item(I).

% Feature 19 (Age at enrollment): 11 bins  (thresholds: [18.5, 19.5, 20.5, 21.5, 22.5, 23.5, 24.5, 25.0, 25.5, 30.5])
{bin(I,19,B) : B = 0..10} = 1 :- item(I).

% Feature 21 (Curricular units 1st sem (credited)): 5 bins  (thresholds: [0.5, 1.5, 3.5, 5.5])
{bin(I,21,B) : B = 0..4} = 1 :- item(I).

% Feature 22 (Curricular units 1st sem (enrolled)): 12 bins  (thresholds: [0.5, 1.0, 2.0, 2.5, 3.5, 5.5, 6.5, 7.5, 8.5, 9.5, 12.5])
{bin(I,22,B) : B = 0..11} = 1 :- item(I).

% Feature 23 (Curricular units 1st sem (evaluations)): 12 bins  (thresholds: [0.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 12.5, 13.5, 18.5])
{bin(I,23,B) : B = 0..11} = 1 :- item(I).

% Feature 24 (Curricular units 1st sem (approved)): 11 bins  (thresholds: [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 10.0, 11.5, 15.5])
{bin(I,24,B) : B = 0..10} = 1 :- item(I).

% Feature 25 (Curricular units 1st sem (grade)): 49 bins  (thresholds: [5.0, 5.5, 10.083333492279053, 10.099999904632568, 10.291666507720947, 10.375, 10.416666507720947, 10.535714149475098, 10.550000190734863, 10.583333492279053, 10.775000095367432, 10.875, 11.083333492279053, 11.154762268066406, 11.183333396911621, 11.387499809265137, 11.449999809265137, 11.5, 11.580277442932129, 11.585714340209961, 11.611111164093018, 11.645833492279053, 11.654762268066406, 11.730303287506104, 11.816666603088379, 11.835416316986084, 11.845237731933594, 11.883116722106934, 11.916666507720947, 11.928571224212646, 11.98722219467163, 11.989999771118164, 12.017857074737549, 12.040714263916016, 12.083333492279053, 12.131249904632568, 12.175000190734863, 12.226190567016602, 12.267857074737549, 12.29285717010498, 12.60991096496582, 12.804166793823242, 12.96999979019165, 13.063000202178955, 13.25374984741211, 13.288690567016602, 13.55988073348999, 13.759643077850342])
{bin(I,25,B) : B = 0..48} = 1 :- item(I).

% Feature 26 (Curricular units 1st sem (without evaluations)): 3 bins  (thresholds: [0.5, 1.5])
{bin(I,26,B) : B = 0..2} = 1 :- item(I).

% Feature 27 (Curricular units 2nd sem (credited)): 6 bins  (thresholds: [0.5, 1.5, 3.5, 5.5, 9.5])
{bin(I,27,B) : B = 0..5} = 1 :- item(I).

% Feature 28 (Curricular units 2nd sem (enrolled)): 11 bins  (thresholds: [0.5, 2.0, 2.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 12.5])
{bin(I,28,B) : B = 0..10} = 1 :- item(I).

% Feature 29 (Curricular units 2nd sem (evaluations)): 11 bins  (thresholds: [2.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5])
{bin(I,29,B) : B = 0..10} = 1 :- item(I).

% Feature 30 (Curricular units 2nd sem (approved)): 9 bins  (thresholds: [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 10.5])
{bin(I,30,B) : B = 0..8} = 1 :- item(I).

% Feature 31 (Curricular units 2nd sem (grade)): 56 bins  (thresholds: [5.0, 5.199999809265137, 10.083333492279053, 10.099999904632568, 10.166666507720947, 10.224999904632568, 10.25, 10.291666507720947, 10.354166507720947, 10.366666316986084, 10.416666507720947, 10.449999809265137, 10.472222328186035, 10.690476417541504, 10.699999809265137, 10.708333492279053, 11.038461685180664, 11.05555534362793, 11.105555534362793, 11.125, 11.154762268066406, 11.166666507720947, 11.171428680419922, 11.237500190734863, 11.291666507720947, 11.330952167510986, 11.343571662902832, 11.348484516143799, 11.348571300506592, 11.366666316986084, 11.416666507720947, 11.422222137451172, 11.449999809265137, 11.550000190734863, 11.651515483856201, 11.700000286102295, 11.774602890014648, 11.775000095367432, 11.820833206176758, 11.952381134033203, 11.954545497894287, 12.099999904632568, 12.224999904632568, 12.236363410949707, 12.50374984741211, 12.550000190734863, 12.633333683013916, 12.65500020980835, 12.739285945892334, 12.775000095367432, 12.845237731933594, 13.174242496490479, 13.49833345413208, 13.60769271850586, 13.625])
{bin(I,31,B) : B = 0..55} = 1 :- item(I).

% Feature 32 (Curricular units 2nd sem (without evaluations)): 3 bins  (thresholds: [0.5, 2.5])
{bin(I,32,B) : B = 0..2} = 1 :- item(I).

% Feature 33 (Unemployment rate): 12 bins  (thresholds: [8.249999761581421, 9.149999618530273, 10.099999904632568, 10.950000286102295, 11.75, 12.549999713897705, 13.149999618530273, 13.150000095367432, 13.299999713897705, 14.099999904632568, 14.699999809265137])
{bin(I,33,B) : B = 0..11} = 1 :- item(I).

% Feature 34 (Inflation rate): 9 bins  (thresholds: [-0.550000011920929, 0.0, 0.4000000059604645, 0.550000011920929, 1.0, 1.699999988079071, 1.9999999403953552, 2.6999999284744263])
{bin(I,34,B) : B = 0..8} = 1 :- item(I).

% Feature 35 (GDP): 10 bins  (thresholds: [-3.5899999141693115, -1.3100000321865082, -0.30000001192092896, 0.5550000071525574, 1.2650000154972076, 1.2899999916553497, 1.7649999856948853, 1.9049999713897705, 2.7649999856948853])
{bin(I,35,B) : B = 0..9} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 1, right -> 22
node(0,0,30,3).
left_node(0,0,1).
right_node(0,0,22).
% node 1: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 2, right -> 9
node(0,1,29,4).
left_node(0,1,2).
right_node(0,1,9).
% node 2: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 3, right -> 4
node(0,2,22,0).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class Graduate (2)
leaf_class(0,3,2).
% node 4: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 5, right -> 6
node(0,4,29,2).
left_node(0,4,5).
right_node(0,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(0,5,0).
% node 6: Course <= 9192.5  (F3, bin <= 8)  left -> 7, right -> 8
node(0,6,3,8).
left_node(0,6,7).
right_node(0,6,8).
% node 7 (leaf): class Dropout (0)
leaf_class(0,7,0).
% node 8 (leaf): class Dropout (0)
leaf_class(0,8,0).
% node 9: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 10, right -> 11
node(0,9,16,0).
left_node(0,9,10).
right_node(0,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(0,10,0).
% node 11: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 12, right -> 13
node(0,11,4,0).
left_node(0,11,12).
right_node(0,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(0,12,0).
% node 13: Application order <= 1.5  (F2, bin <= 0)  left -> 14, right -> 17
node(0,13,2,0).
left_node(0,13,14).
right_node(0,13,17).
% node 14: GDP <= 0.5550000071525574  (F35, bin <= 3)  left -> 15, right -> 16
node(0,14,35,3).
left_node(0,14,15).
right_node(0,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(0,15,0).
% node 16 (leaf): class Enrolled (1)
leaf_class(0,16,1).
% node 17: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 18, right -> 21
node(0,17,18,0).
left_node(0,17,18).
right_node(0,17,21).
% node 18: Unemployment rate <= 10.099999904632568  (F33, bin <= 2)  left -> 19, right -> 20
node(0,18,33,2).
left_node(0,18,19).
right_node(0,18,20).
% node 19 (leaf): class Enrolled (1)
leaf_class(0,19,1).
% node 20 (leaf): class Dropout (0)
leaf_class(0,20,0).
% node 21 (leaf): class Enrolled (1)
leaf_class(0,21,1).
% node 22: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 23, right -> 56
node(0,22,28,5).
left_node(0,22,23).
right_node(0,22,56).
% node 23: Curricular units 1st sem (grade) <= 11.845237731933594  (F25, bin <= 26)  left -> 24, right -> 41
node(0,23,25,26).
left_node(0,23,24).
right_node(0,23,41).
% node 24: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 25, right -> 34
node(0,24,30,4).
left_node(0,24,25).
right_node(0,24,34).
% node 25: Previous qualification (grade) <= 149.4499969482422  (F6, bin <= 19)  left -> 26, right -> 33
node(0,25,6,19).
left_node(0,25,26).
right_node(0,25,33).
% node 26: Father's occupation <= 4.5  (F11, bin <= 2)  left -> 27, right -> 30
node(0,26,11,2).
left_node(0,26,27).
right_node(0,26,30).
% node 27: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 28, right -> 29
node(0,27,19,4).
left_node(0,27,28).
right_node(0,27,29).
% node 28 (leaf): class Graduate (2)
leaf_class(0,28,2).
% node 29 (leaf): class Enrolled (1)
leaf_class(0,29,1).
% node 30: Application mode <= 28.5  (F1, bin <= 7)  left -> 31, right -> 32
node(0,30,1,7).
left_node(0,30,31).
right_node(0,30,32).
% node 31 (leaf): class Enrolled (1)
leaf_class(0,31,1).
% node 32 (leaf): class Enrolled (1)
leaf_class(0,32,1).
% node 33 (leaf): class Enrolled (1)
leaf_class(0,33,1).
% node 34: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 35, right -> 40
node(0,34,28,4).
left_node(0,34,35).
right_node(0,34,40).
% node 35: Previous qualification (grade) <= 128.5  (F6, bin <= 4)  left -> 36, right -> 37
node(0,35,6,4).
left_node(0,35,36).
right_node(0,35,37).
% node 36 (leaf): class Graduate (2)
leaf_class(0,36,2).
% node 37: Unemployment rate <= 9.149999618530273  (F33, bin <= 1)  left -> 38, right -> 39
node(0,37,33,1).
left_node(0,37,38).
right_node(0,37,39).
% node 38 (leaf): class Graduate (2)
leaf_class(0,38,2).
% node 39 (leaf): class Graduate (2)
leaf_class(0,39,2).
% node 40 (leaf): class Enrolled (1)
leaf_class(0,40,1).
% node 41: Unemployment rate <= 9.149999618530273  (F33, bin <= 1)  left -> 42, right -> 45
node(0,41,33,1).
left_node(0,41,42).
right_node(0,41,45).
% node 42: Age at enrollment <= 30.5  (F19, bin <= 9)  left -> 43, right -> 44
node(0,42,19,9).
left_node(0,42,43).
right_node(0,42,44).
% node 43 (leaf): class Graduate (2)
leaf_class(0,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(0,44,2).
% node 45: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 46, right -> 53
node(0,45,30,4).
left_node(0,45,46).
right_node(0,45,53).
% node 46: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 47, right -> 50
node(0,46,24,4).
left_node(0,46,47).
right_node(0,46,50).
% node 47: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 48, right -> 49
node(0,47,22,5).
left_node(0,47,48).
right_node(0,47,49).
% node 48 (leaf): class Graduate (2)
leaf_class(0,48,2).
% node 49 (leaf): class Enrolled (1)
leaf_class(0,49,1).
% node 50: Inflation rate <= 0.4000000059604645  (F34, bin <= 2)  left -> 51, right -> 52
node(0,50,34,2).
left_node(0,50,51).
right_node(0,50,52).
% node 51 (leaf): class Graduate (2)
leaf_class(0,51,2).
% node 52 (leaf): class Enrolled (1)
leaf_class(0,52,1).
% node 53: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 54, right -> 55
node(0,53,30,5).
left_node(0,53,54).
right_node(0,53,55).
% node 54 (leaf): class Graduate (2)
leaf_class(0,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(0,55,2).
% node 56: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 57, right -> 58
node(0,56,16,0).
left_node(0,56,57).
right_node(0,56,58).
% node 57 (leaf): class Dropout (0)
leaf_class(0,57,0).
% node 58: Previous qualification <= 1.5  (F5, bin <= 0)  left -> 59, right -> 66
node(0,58,5,0).
left_node(0,58,59).
right_node(0,58,66).
% node 59: GDP <= 2.7649999856948853  (F35, bin <= 8)  left -> 60, right -> 65
node(0,59,35,8).
left_node(0,59,60).
right_node(0,59,65).
% node 60: Admission grade <= 108.29999923706055  (F12, bin <= 1)  left -> 61, right -> 62
node(0,60,12,1).
left_node(0,60,61).
right_node(0,60,62).
% node 61 (leaf): class Graduate (2)
leaf_class(0,61,2).
% node 62: Curricular units 1st sem (grade) <= 11.654762268066406  (F25, bin <= 22)  left -> 63, right -> 64
node(0,62,25,22).
left_node(0,62,63).
right_node(0,62,64).
% node 63 (leaf): class Graduate (2)
leaf_class(0,63,2).
% node 64 (leaf): class Graduate (2)
leaf_class(0,64,2).
% node 65 (leaf): class Graduate (2)
leaf_class(0,65,2).
% node 66: Gender <= 0.5  (F17, bin <= 0)  left -> 67, right -> 70
node(0,66,17,0).
left_node(0,66,67).
right_node(0,66,70).
% node 67: Father's occupation <= 4.5  (F11, bin <= 2)  left -> 68, right -> 69
node(0,67,11,2).
left_node(0,67,68).
right_node(0,67,69).
% node 68 (leaf): class Graduate (2)
leaf_class(0,68,2).
% node 69 (leaf): class Graduate (2)
leaf_class(0,69,2).
% node 70: Unemployment rate <= 13.149999618530273  (F33, bin <= 6)  left -> 71, right -> 72
node(0,70,33,6).
left_node(0,70,71).
right_node(0,70,72).
% node 71 (leaf): class Dropout (0)
leaf_class(0,71,0).
% node 72 (leaf): class Graduate (2)
leaf_class(0,72,2).

% Tree 1
tree(1).
% node 0: Gender <= 0.5  (F17, bin <= 0)  left -> 1, right -> 50
node(1,0,17,0).
left_node(1,0,1).
right_node(1,0,50).
% node 1: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 2, right -> 21
node(1,1,24,4).
left_node(1,1,2).
right_node(1,1,21).
% node 2: Previous qualification (grade) <= 140.5  (F6, bin <= 15)  left -> 3, right -> 16
node(1,2,6,15).
left_node(1,2,3).
right_node(1,2,16).
% node 3: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 4, right -> 7
node(1,3,31,0).
left_node(1,3,4).
right_node(1,3,7).
% node 4: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 5, right -> 6
node(1,4,28,0).
left_node(1,4,5).
right_node(1,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(1,5,0).
% node 6 (leaf): class Dropout (0)
leaf_class(1,6,0).
% node 7: Debtor <= 0.5  (F15, bin <= 0)  left -> 8, right -> 15
node(1,7,15,0).
left_node(1,7,8).
right_node(1,7,15).
% node 8: Application mode <= 28.5  (F1, bin <= 7)  left -> 9, right -> 12
node(1,8,1,7).
left_node(1,8,9).
right_node(1,8,12).
% node 9: Curricular units 2nd sem (grade) <= 11.237500190734863  (F31, bin <= 23)  left -> 10, right -> 11
node(1,9,31,23).
left_node(1,9,10).
right_node(1,9,11).
% node 10 (leaf): class Enrolled (1)
leaf_class(1,10,1).
% node 11 (leaf): class Graduate (2)
leaf_class(1,11,2).
% node 12: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 13, right -> 14
node(1,12,30,3).
left_node(1,12,13).
right_node(1,12,14).
% node 13 (leaf): class Dropout (0)
leaf_class(1,13,0).
% node 14 (leaf): class Enrolled (1)
leaf_class(1,14,1).
% node 15 (leaf): class Dropout (0)
leaf_class(1,15,0).
% node 16: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 17, right -> 20
node(1,16,30,3).
left_node(1,16,17).
right_node(1,16,20).
% node 17: Course <= 4092.5  (F3, bin <= 0)  left -> 18, right -> 19
node(1,17,3,0).
left_node(1,17,18).
right_node(1,17,19).
% node 18 (leaf): class Graduate (2)
leaf_class(1,18,2).
% node 19 (leaf): class Dropout (0)
leaf_class(1,19,0).
% node 20 (leaf): class Enrolled (1)
leaf_class(1,20,1).
% node 21: Curricular units 1st sem (grade) <= 13.288690567016602  (F25, bin <= 45)  left -> 22, right -> 39
node(1,21,25,45).
left_node(1,21,22).
right_node(1,21,39).
% node 22: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 23, right -> 30
node(1,22,24,5).
left_node(1,22,23).
right_node(1,22,30).
% node 23: Debtor <= 0.5  (F15, bin <= 0)  left -> 24, right -> 29
node(1,23,15,0).
left_node(1,23,24).
right_node(1,23,29).
% node 24: Admission grade <= 114.3499984741211  (F12, bin <= 3)  left -> 25, right -> 26
node(1,24,12,3).
left_node(1,24,25).
right_node(1,24,26).
% node 25 (leaf): class Enrolled (1)
leaf_class(1,25,1).
% node 26: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 27, right -> 28
node(1,26,23,5).
left_node(1,26,27).
right_node(1,26,28).
% node 27 (leaf): class Graduate (2)
leaf_class(1,27,2).
% node 28 (leaf): class Enrolled (1)
leaf_class(1,28,1).
% node 29 (leaf): class Dropout (0)
leaf_class(1,29,0).
% node 30: Curricular units 2nd sem (grade) <= 11.154762268066406  (F31, bin <= 20)  left -> 31, right -> 32
node(1,30,31,20).
left_node(1,30,31).
right_node(1,30,32).
% node 31 (leaf): class Dropout (0)
leaf_class(1,31,0).
% node 32: Previous qualification <= 1.5  (F5, bin <= 0)  left -> 33, right -> 36
node(1,32,5,0).
left_node(1,32,33).
right_node(1,32,36).
% node 33: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 34, right -> 35
node(1,33,16,0).
left_node(1,33,34).
right_node(1,33,35).
% node 34 (leaf): class Graduate (2)
leaf_class(1,34,2).
% node 35 (leaf): class Graduate (2)
leaf_class(1,35,2).
% node 36: Curricular units 2nd sem (evaluations) <= 11.5  (F29, bin <= 8)  left -> 37, right -> 38
node(1,36,29,8).
left_node(1,36,37).
right_node(1,36,38).
% node 37 (leaf): class Graduate (2)
leaf_class(1,37,2).
% node 38 (leaf): class Graduate (2)
leaf_class(1,38,2).
% node 39: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 40, right -> 45
node(1,39,23,5).
left_node(1,39,40).
right_node(1,39,45).
% node 40: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 41, right -> 44
node(1,40,30,5).
left_node(1,40,41).
right_node(1,40,44).
% node 41: Father's occupation <= 3.5  (F11, bin <= 1)  left -> 42, right -> 43
node(1,41,11,1).
left_node(1,41,42).
right_node(1,41,43).
% node 42 (leaf): class Dropout (0)
leaf_class(1,42,0).
% node 43 (leaf): class Graduate (2)
leaf_class(1,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(1,44,2).
% node 45: GDP <= 1.2899999916553497  (F35, bin <= 5)  left -> 46, right -> 47
node(1,45,35,5).
left_node(1,45,46).
right_node(1,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(1,46,2).
% node 47: Curricular units 1st sem (approved) <= 6.5  (F24, bin <= 6)  left -> 48, right -> 49
node(1,47,24,6).
left_node(1,47,48).
right_node(1,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(1,48,1).
% node 49 (leaf): class Graduate (2)
leaf_class(1,49,2).
% node 50: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 51, right -> 76
node(1,50,18,0).
left_node(1,50,51).
right_node(1,50,76).
% node 51: Curricular units 2nd sem (grade) <= 10.291666507720947  (F31, bin <= 7)  left -> 52, right -> 59
node(1,51,31,7).
left_node(1,51,52).
right_node(1,51,59).
% node 52: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 53, right -> 54
node(1,52,22,0).
left_node(1,52,53).
right_node(1,52,54).
% node 53 (leaf): class Dropout (0)
leaf_class(1,53,0).
% node 54: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 55, right -> 58
node(1,54,31,0).
left_node(1,54,55).
right_node(1,54,58).
% node 55: Application mode <= 42.5  (F1, bin <= 9)  left -> 56, right -> 57
node(1,55,1,9).
left_node(1,55,56).
right_node(1,55,57).
% node 56 (leaf): class Dropout (0)
leaf_class(1,56,0).
% node 57 (leaf): class Dropout (0)
leaf_class(1,57,0).
% node 58 (leaf): class Enrolled (1)
leaf_class(1,58,1).
% node 59: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 60, right -> 65
node(1,59,29,4).
left_node(1,59,60).
right_node(1,59,65).
% node 60: Curricular units 1st sem (grade) <= 11.449999809265137  (F25, bin <= 16)  left -> 61, right -> 62
node(1,60,25,16).
left_node(1,60,61).
right_node(1,60,62).
% node 61 (leaf): class Dropout (0)
leaf_class(1,61,0).
% node 62: Curricular units 1st sem (credited) <= 0.5  (F21, bin <= 0)  left -> 63, right -> 64
node(1,62,21,0).
left_node(1,62,63).
right_node(1,62,64).
% node 63 (leaf): class Graduate (2)
leaf_class(1,63,2).
% node 64 (leaf): class Dropout (0)
leaf_class(1,64,0).
% node 65: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 66, right -> 69
node(1,65,24,4).
left_node(1,65,66).
right_node(1,65,69).
% node 66: Application order <= 1.5  (F2, bin <= 0)  left -> 67, right -> 68
node(1,66,2,0).
left_node(1,66,67).
right_node(1,66,68).
% node 67 (leaf): class Dropout (0)
leaf_class(1,67,0).
% node 68 (leaf): class Enrolled (1)
leaf_class(1,68,1).
% node 69: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 70, right -> 73
node(1,69,27,0).
left_node(1,69,70).
right_node(1,69,73).
% node 70: Curricular units 2nd sem (grade) <= 12.50374984741211  (F31, bin <= 44)  left -> 71, right -> 72
node(1,70,31,44).
left_node(1,70,71).
right_node(1,70,72).
% node 71 (leaf): class Enrolled (1)
leaf_class(1,71,1).
% node 72 (leaf): class Graduate (2)
leaf_class(1,72,2).
% node 73: Curricular units 2nd sem (approved) <= 6.5  (F30, bin <= 6)  left -> 74, right -> 75
node(1,73,30,6).
left_node(1,73,74).
right_node(1,73,75).
% node 74 (leaf): class Dropout (0)
leaf_class(1,74,0).
% node 75 (leaf): class Graduate (2)
leaf_class(1,75,2).
% node 76 (leaf): class Graduate (2)
leaf_class(1,76,2).

% Tree 2
tree(2).
% node 0: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 1, right -> 10
node(2,0,16,0).
left_node(2,0,1).
right_node(2,0,10).
% node 1: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 2, right -> 9
node(2,1,19,4).
left_node(2,1,2).
right_node(2,1,9).
% node 2: GDP <= 2.7649999856948853  (F35, bin <= 8)  left -> 3, right -> 8
node(2,2,35,8).
left_node(2,2,3).
right_node(2,2,8).
% node 3: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 4, right -> 5
node(2,3,30,3).
left_node(2,3,4).
right_node(2,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(2,4,0).
% node 5: Inflation rate <= 1.0  (F34, bin <= 4)  left -> 6, right -> 7
node(2,5,34,4).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class Enrolled (1)
leaf_class(2,6,1).
% node 7 (leaf): class Dropout (0)
leaf_class(2,7,0).
% node 8 (leaf): class Dropout (0)
leaf_class(2,8,0).
% node 9 (leaf): class Dropout (0)
leaf_class(2,9,0).
% node 10: Curricular units 2nd sem (evaluations) <= 4.5  (F29, bin <= 1)  left -> 11, right -> 14
node(2,10,29,1).
left_node(2,10,11).
right_node(2,10,14).
% node 11: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 12, right -> 13
node(2,11,28,0).
left_node(2,11,12).
right_node(2,11,13).
% node 12 (leaf): class Graduate (2)
leaf_class(2,12,2).
% node 13 (leaf): class Dropout (0)
leaf_class(2,13,0).
% node 14: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 15, right -> 36
node(2,14,23,5).
left_node(2,14,15).
right_node(2,14,36).
% node 15: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 16, right -> 25
node(2,15,30,3).
left_node(2,15,16).
right_node(2,15,25).
% node 16: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 17, right -> 18
node(2,16,29,3).
left_node(2,16,17).
right_node(2,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(2,17,0).
% node 18: Curricular units 1st sem (grade) <= 10.583333492279053  (F25, bin <= 9)  left -> 19, right -> 22
node(2,18,25,9).
left_node(2,18,19).
right_node(2,18,22).
% node 19: Admission grade <= 129.9000015258789  (F12, bin <= 16)  left -> 20, right -> 21
node(2,19,12,16).
left_node(2,19,20).
right_node(2,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(2,20,0).
% node 21 (leaf): class Enrolled (1)
leaf_class(2,21,1).
% node 22: GDP <= -0.30000001192092896  (F35, bin <= 2)  left -> 23, right -> 24
node(2,22,35,2).
left_node(2,22,23).
right_node(2,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(2,23,0).
% node 24 (leaf): class Enrolled (1)
leaf_class(2,24,1).
% node 25: Previous qualification (grade) <= 129.5  (F6, bin <= 5)  left -> 26, right -> 33
node(2,25,6,5).
left_node(2,25,26).
right_node(2,25,33).
% node 26: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 27, right -> 30
node(2,26,29,5).
left_node(2,26,27).
right_node(2,26,30).
% node 27: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 28, right -> 29
node(2,27,30,5).
left_node(2,27,28).
right_node(2,27,29).
% node 28 (leaf): class Graduate (2)
leaf_class(2,28,2).
% node 29 (leaf): class Graduate (2)
leaf_class(2,29,2).
% node 30: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 31, right -> 32
node(2,30,23,4).
left_node(2,30,31).
right_node(2,30,32).
% node 31 (leaf): class Graduate (2)
leaf_class(2,31,2).
% node 32 (leaf): class Graduate (2)
leaf_class(2,32,2).
% node 33: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 34, right -> 35
node(2,33,30,4).
left_node(2,33,34).
right_node(2,33,35).
% node 34 (leaf): class Graduate (2)
leaf_class(2,34,2).
% node 35 (leaf): class Graduate (2)
leaf_class(2,35,2).
% node 36: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 37, right -> 50
node(2,36,24,5).
left_node(2,36,37).
right_node(2,36,50).
% node 37: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 38, right -> 43
node(2,37,30,2).
left_node(2,37,38).
right_node(2,37,43).
% node 38: Course <= 9246.0  (F3, bin <= 9)  left -> 39, right -> 42
node(2,38,3,9).
left_node(2,38,39).
right_node(2,38,42).
% node 39: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 40, right -> 41
node(2,39,24,3).
left_node(2,39,40).
right_node(2,39,41).
% node 40 (leaf): class Dropout (0)
leaf_class(2,40,0).
% node 41 (leaf): class Enrolled (1)
leaf_class(2,41,1).
% node 42 (leaf): class Dropout (0)
leaf_class(2,42,0).
% node 43: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 44, right -> 47
node(2,43,28,4).
left_node(2,43,44).
right_node(2,43,47).
% node 44: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 45, right -> 46
node(2,44,18,0).
left_node(2,44,45).
right_node(2,44,46).
% node 45 (leaf): class Enrolled (1)
leaf_class(2,45,1).
% node 46 (leaf): class Graduate (2)
leaf_class(2,46,2).
% node 47: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 48, right -> 49
node(2,47,29,6).
left_node(2,47,48).
right_node(2,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(2,48,1).
% node 49 (leaf): class Dropout (0)
leaf_class(2,49,0).
% node 50: Curricular units 2nd sem (grade) <= 13.49833345413208  (F31, bin <= 52)  left -> 51, right -> 56
node(2,50,31,52).
left_node(2,50,51).
right_node(2,50,56).
% node 51: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 52, right -> 55
node(2,51,18,0).
left_node(2,51,52).
right_node(2,51,55).
% node 52: Father's qualification <= 37.5  (F9, bin <= 7)  left -> 53, right -> 54
node(2,52,9,7).
left_node(2,52,53).
right_node(2,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(2,53,2).
% node 54 (leaf): class Enrolled (1)
leaf_class(2,54,1).
% node 55 (leaf): class Graduate (2)
leaf_class(2,55,2).
% node 56 (leaf): class Graduate (2)
leaf_class(2,56,2).

% Tree 3
tree(3).
% node 0: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 1, right -> 50
node(3,0,18,0).
left_node(3,0,1).
right_node(3,0,50).
% node 1: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 2, right -> 35
node(3,1,19,3).
left_node(3,1,2).
right_node(3,1,35).
% node 2: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 3, right -> 10
node(3,2,16,0).
left_node(3,2,3).
right_node(3,2,10).
% node 3: Debtor <= 0.5  (F15, bin <= 0)  left -> 4, right -> 9
node(3,3,15,0).
left_node(3,3,4).
right_node(3,3,9).
% node 4: GDP <= 1.7649999856948853  (F35, bin <= 6)  left -> 5, right -> 8
node(3,4,35,6).
left_node(3,4,5).
right_node(3,4,8).
% node 5: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 6, right -> 7
node(3,5,30,3).
left_node(3,5,6).
right_node(3,5,7).
% node 6 (leaf): class Dropout (0)
leaf_class(3,6,0).
% node 7 (leaf): class Dropout (0)
leaf_class(3,7,0).
% node 8 (leaf): class Enrolled (1)
leaf_class(3,8,1).
% node 9 (leaf): class Dropout (0)
leaf_class(3,9,0).
% node 10: Curricular units 1st sem (evaluations) <= 4.5  (F23, bin <= 1)  left -> 11, right -> 20
node(3,10,23,1).
left_node(3,10,11).
right_node(3,10,20).
% node 11: Application mode <= 16.5  (F1, bin <= 4)  left -> 12, right -> 17
node(3,11,1,4).
left_node(3,11,12).
right_node(3,11,17).
% node 12: Curricular units 1st sem (enrolled) <= 1.0  (F22, bin <= 1)  left -> 13, right -> 16
node(3,12,22,1).
left_node(3,12,13).
right_node(3,12,16).
% node 13: Previous qualification (grade) <= 136.5  (F6, bin <= 13)  left -> 14, right -> 15
node(3,13,6,13).
left_node(3,13,14).
right_node(3,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(3,14,0).
% node 15 (leaf): class Graduate (2)
leaf_class(3,15,2).
% node 16 (leaf): class Dropout (0)
leaf_class(3,16,0).
% node 17: Curricular units 2nd sem (enrolled) <= 2.5  (F28, bin <= 2)  left -> 18, right -> 19
node(3,17,28,2).
left_node(3,17,18).
right_node(3,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(3,18,0).
% node 19 (leaf): class Dropout (0)
leaf_class(3,19,0).
% node 20: Gender <= 0.5  (F17, bin <= 0)  left -> 21, right -> 28
node(3,20,17,0).
left_node(3,20,21).
right_node(3,20,28).
% node 21: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 22, right -> 25
node(3,21,28,5).
left_node(3,21,22).
right_node(3,21,25).
% node 22: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 23, right -> 24
node(3,22,29,4).
left_node(3,22,23).
right_node(3,22,24).
% node 23 (leaf): class Graduate (2)
leaf_class(3,23,2).
% node 24 (leaf): class Graduate (2)
leaf_class(3,24,2).
% node 25: Curricular units 2nd sem (grade) <= 11.952381134033203  (F31, bin <= 39)  left -> 26, right -> 27
node(3,25,31,39).
left_node(3,25,26).
right_node(3,25,27).
% node 26 (leaf): class Graduate (2)
leaf_class(3,26,2).
% node 27 (leaf): class Graduate (2)
leaf_class(3,27,2).
% node 28: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 29, right -> 32
node(3,28,29,5).
left_node(3,28,29).
right_node(3,28,32).
% node 29: Curricular units 2nd sem (grade) <= 11.366666316986084  (F31, bin <= 29)  left -> 30, right -> 31
node(3,29,31,29).
left_node(3,29,30).
right_node(3,29,31).
% node 30 (leaf): class Dropout (0)
leaf_class(3,30,0).
% node 31 (leaf): class Graduate (2)
leaf_class(3,31,2).
% node 32: Father's occupation <= 3.5  (F11, bin <= 1)  left -> 33, right -> 34
node(3,32,11,1).
left_node(3,32,33).
right_node(3,32,34).
% node 33 (leaf): class Graduate (2)
leaf_class(3,33,2).
% node 34 (leaf): class Enrolled (1)
leaf_class(3,34,1).
% node 35: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 36, right -> 39
node(3,35,30,3).
left_node(3,35,36).
right_node(3,35,39).
% node 36: Application mode <= 43.5  (F1, bin <= 10)  left -> 37, right -> 38
node(3,36,1,10).
left_node(3,36,37).
right_node(3,36,38).
% node 37 (leaf): class Dropout (0)
leaf_class(3,37,0).
% node 38 (leaf): class Dropout (0)
leaf_class(3,38,0).
% node 39: Admission grade <= 145.6500015258789  (F12, bin <= 28)  left -> 40, right -> 47
node(3,39,12,28).
left_node(3,39,40).
right_node(3,39,47).
% node 40: Curricular units 2nd sem (grade) <= 13.174242496490479  (F31, bin <= 51)  left -> 41, right -> 46
node(3,40,31,51).
left_node(3,40,41).
right_node(3,40,46).
% node 41: Curricular units 2nd sem (grade) <= 11.154762268066406  (F31, bin <= 20)  left -> 42, right -> 43
node(3,41,31,20).
left_node(3,41,42).
right_node(3,41,43).
% node 42 (leaf): class Dropout (0)
leaf_class(3,42,0).
% node 43: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 44, right -> 45
node(3,43,30,4).
left_node(3,43,44).
right_node(3,43,45).
% node 44 (leaf): class Enrolled (1)
leaf_class(3,44,1).
% node 45 (leaf): class Graduate (2)
leaf_class(3,45,2).
% node 46 (leaf): class Graduate (2)
leaf_class(3,46,2).
% node 47: Curricular units 1st sem (grade) <= 11.928571224212646  (F25, bin <= 29)  left -> 48, right -> 49
node(3,47,25,29).
left_node(3,47,48).
right_node(3,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(3,48,1).
% node 49 (leaf): class Graduate (2)
leaf_class(3,49,2).
% node 50: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 51, right -> 66
node(3,50,28,5).
left_node(3,50,51).
right_node(3,50,66).
% node 51: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 52, right -> 57
node(3,51,23,5).
left_node(3,51,52).
right_node(3,51,57).
% node 52: Curricular units 2nd sem (evaluations) <= 2.5  (F29, bin <= 0)  left -> 53, right -> 54
node(3,52,29,0).
left_node(3,52,53).
right_node(3,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(3,53,2).
% node 54: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 55, right -> 56
node(3,54,30,1).
left_node(3,54,55).
right_node(3,54,56).
% node 55 (leaf): class Dropout (0)
leaf_class(3,55,0).
% node 56 (leaf): class Graduate (2)
leaf_class(3,56,2).
% node 57: Curricular units 2nd sem (grade) <= 10.690476417541504  (F31, bin <= 13)  left -> 58, right -> 59
node(3,57,31,13).
left_node(3,57,58).
right_node(3,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(3,58,0).
% node 59: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 60, right -> 61
node(3,59,30,3).
left_node(3,59,60).
right_node(3,59,61).
% node 60 (leaf): class Dropout (0)
leaf_class(3,60,0).
% node 61: Course <= 9377.0  (F3, bin <= 10)  left -> 62, right -> 65
node(3,61,3,10).
left_node(3,61,62).
right_node(3,61,65).
% node 62: Gender <= 0.5  (F17, bin <= 0)  left -> 63, right -> 64
node(3,62,17,0).
left_node(3,62,63).
right_node(3,62,64).
% node 63 (leaf): class Graduate (2)
leaf_class(3,63,2).
% node 64 (leaf): class Enrolled (1)
leaf_class(3,64,1).
% node 65 (leaf): class Enrolled (1)
leaf_class(3,65,1).
% node 66 (leaf): class Graduate (2)
leaf_class(3,66,2).

% Tree 4
tree(4).
% node 0: Mother's occupation <= 0.5  (F10, bin <= 0)  left -> 1, right -> 10
node(4,0,10,0).
left_node(4,0,1).
right_node(4,0,10).
% node 1: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 2, right -> 5
node(4,1,4,0).
left_node(4,1,2).
right_node(4,1,5).
% node 2: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 3, right -> 4
node(4,2,30,4).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class Dropout (0)
leaf_class(4,3,0).
% node 4 (leaf): class Graduate (2)
leaf_class(4,4,2).
% node 5: Previous qualification (grade) <= 130.5  (F6, bin <= 6)  left -> 6, right -> 9
node(4,5,6,6).
left_node(4,5,6).
right_node(4,5,9).
% node 6: Gender <= 0.5  (F17, bin <= 0)  left -> 7, right -> 8
node(4,6,17,0).
left_node(4,6,7).
right_node(4,6,8).
% node 7 (leaf): class Graduate (2)
leaf_class(4,7,2).
% node 8 (leaf): class Dropout (0)
leaf_class(4,8,0).
% node 9 (leaf): class Dropout (0)
leaf_class(4,9,0).
% node 10: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 11, right -> 44
node(4,10,22,5).
left_node(4,10,11).
right_node(4,10,44).
% node 11: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 12, right -> 31
node(4,11,19,4).
left_node(4,11,12).
right_node(4,11,31).
% node 12: Curricular units 2nd sem (grade) <= 11.125  (F31, bin <= 19)  left -> 13, right -> 22
node(4,12,31,19).
left_node(4,12,13).
right_node(4,12,22).
% node 13: Course <= 9102.0  (F3, bin <= 5)  left -> 14, right -> 17
node(4,13,3,5).
left_node(4,13,14).
right_node(4,13,17).
% node 14: Admission grade <= 146.4000015258789  (F12, bin <= 29)  left -> 15, right -> 16
node(4,14,12,29).
left_node(4,14,15).
right_node(4,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(4,15,0).
% node 16 (leaf): class Dropout (0)
leaf_class(4,16,0).
% node 17: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 18, right -> 19
node(4,17,29,2).
left_node(4,17,18).
right_node(4,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(4,18,0).
% node 19: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 20, right -> 21
node(4,19,24,3).
left_node(4,19,20).
right_node(4,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(4,20,0).
% node 21 (leaf): class Enrolled (1)
leaf_class(4,21,1).
% node 22: Admission grade <= 132.0500030517578  (F12, bin <= 18)  left -> 23, right -> 30
node(4,22,12,18).
left_node(4,22,23).
right_node(4,22,30).
% node 23: Mother's occupation <= 7.5  (F10, bin <= 6)  left -> 24, right -> 27
node(4,23,10,6).
left_node(4,23,24).
right_node(4,23,27).
% node 24: Inflation rate <= 2.6999999284744263  (F34, bin <= 7)  left -> 25, right -> 26
node(4,24,34,7).
left_node(4,24,25).
right_node(4,24,26).
% node 25 (leaf): class Graduate (2)
leaf_class(4,25,2).
% node 26 (leaf): class Dropout (0)
leaf_class(4,26,0).
% node 27: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 28, right -> 29
node(4,27,29,5).
left_node(4,27,28).
right_node(4,27,29).
% node 28 (leaf): class Graduate (2)
leaf_class(4,28,2).
% node 29 (leaf): class Enrolled (1)
leaf_class(4,29,1).
% node 30 (leaf): class Graduate (2)
leaf_class(4,30,2).
% node 31: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 32, right -> 33
node(4,31,16,0).
left_node(4,31,32).
right_node(4,31,33).
% node 32 (leaf): class Dropout (0)
leaf_class(4,32,0).
% node 33: Mother's occupation <= 5.5  (F10, bin <= 4)  left -> 34, right -> 39
node(4,33,10,4).
left_node(4,33,34).
right_node(4,33,39).
% node 34: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 35, right -> 36
node(4,34,29,2).
left_node(4,34,35).
right_node(4,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(4,35,0).
% node 36: Curricular units 1st sem (approved) <= 2.5  (F24, bin <= 2)  left -> 37, right -> 38
node(4,36,24,2).
left_node(4,36,37).
right_node(4,36,38).
% node 37 (leaf): class Dropout (0)
leaf_class(4,37,0).
% node 38 (leaf): class Graduate (2)
leaf_class(4,38,2).
% node 39: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 40, right -> 41
node(4,39,30,1).
left_node(4,39,40).
right_node(4,39,41).
% node 40 (leaf): class Dropout (0)
leaf_class(4,40,0).
% node 41: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 42, right -> 43
node(4,41,29,3).
left_node(4,41,42).
right_node(4,41,43).
% node 42 (leaf): class Graduate (2)
leaf_class(4,42,2).
% node 43 (leaf): class Enrolled (1)
leaf_class(4,43,1).
% node 44: Application mode <= 6.0  (F1, bin <= 2)  left -> 45, right -> 58
node(4,44,1,2).
left_node(4,44,45).
right_node(4,44,58).
% node 45: Curricular units 2nd sem (grade) <= 10.690476417541504  (F31, bin <= 13)  left -> 46, right -> 49
node(4,45,31,13).
left_node(4,45,46).
right_node(4,45,49).
% node 46: Curricular units 1st sem (grade) <= 5.0  (F25, bin <= 0)  left -> 47, right -> 48
node(4,46,25,0).
left_node(4,46,47).
right_node(4,46,48).
% node 47 (leaf): class Dropout (0)
leaf_class(4,47,0).
% node 48 (leaf): class Dropout (0)
leaf_class(4,48,0).
% node 49: Curricular units 2nd sem (without evaluations) <= 0.5  (F32, bin <= 0)  left -> 50, right -> 57
node(4,49,32,0).
left_node(4,49,50).
right_node(4,49,57).
% node 50: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 51, right -> 54
node(4,50,24,5).
left_node(4,50,51).
right_node(4,50,54).
% node 51: Curricular units 2nd sem (evaluations) <= 10.5  (F29, bin <= 7)  left -> 52, right -> 53
node(4,51,29,7).
left_node(4,51,52).
right_node(4,51,53).
% node 52 (leaf): class Graduate (2)
leaf_class(4,52,2).
% node 53 (leaf): class Enrolled (1)
leaf_class(4,53,1).
% node 54: Course <= 9138.5  (F3, bin <= 7)  left -> 55, right -> 56
node(4,54,3,7).
left_node(4,54,55).
right_node(4,54,56).
% node 55 (leaf): class Graduate (2)
leaf_class(4,55,2).
% node 56 (leaf): class Graduate (2)
leaf_class(4,56,2).
% node 57 (leaf): class Enrolled (1)
leaf_class(4,57,1).
% node 58: Curricular units 2nd sem (evaluations) <= 4.5  (F29, bin <= 1)  left -> 59, right -> 60
node(4,58,29,1).
left_node(4,58,59).
right_node(4,58,60).
% node 59 (leaf): class Dropout (0)
leaf_class(4,59,0).
% node 60: Debtor <= 0.5  (F15, bin <= 0)  left -> 61, right -> 68
node(4,60,15,0).
left_node(4,60,61).
right_node(4,60,68).
% node 61: Curricular units 2nd sem (grade) <= 11.154762268066406  (F31, bin <= 20)  left -> 62, right -> 65
node(4,61,31,20).
left_node(4,61,62).
right_node(4,61,65).
% node 62: Mother's qualification <= 34.5  (F8, bin <= 9)  left -> 63, right -> 64
node(4,62,8,9).
left_node(4,62,63).
right_node(4,62,64).
% node 63 (leaf): class Dropout (0)
leaf_class(4,63,0).
% node 64 (leaf): class Dropout (0)
leaf_class(4,64,0).
% node 65: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 66, right -> 67
node(4,65,16,0).
left_node(4,65,66).
right_node(4,65,67).
% node 66 (leaf): class Dropout (0)
leaf_class(4,66,0).
% node 67 (leaf): class Graduate (2)
leaf_class(4,67,2).
% node 68: Mother's occupation <= 49.5  (F10, bin <= 8)  left -> 69, right -> 72
node(4,68,10,8).
left_node(4,68,69).
right_node(4,68,72).
% node 69: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 70, right -> 71
node(4,69,24,5).
left_node(4,69,70).
right_node(4,69,71).
% node 70 (leaf): class Dropout (0)
leaf_class(4,70,0).
% node 71 (leaf): class Graduate (2)
leaf_class(4,71,2).
% node 72 (leaf): class Graduate (2)
leaf_class(4,72,2).

% Tree 5
tree(5).
% node 0: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 1, right -> 16
node(5,0,23,2).
left_node(5,0,1).
right_node(5,0,16).
% node 1: Curricular units 2nd sem (grade) <= 11.291666507720947  (F31, bin <= 24)  left -> 2, right -> 15
node(5,1,31,24).
left_node(5,1,2).
right_node(5,1,15).
% node 2: Age at enrollment <= 24.5  (F19, bin <= 6)  left -> 3, right -> 14
node(5,2,19,6).
left_node(5,2,3).
right_node(5,2,14).
% node 3: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 4, right -> 13
node(5,3,18,0).
left_node(5,3,4).
right_node(5,3,13).
% node 4: Age at enrollment <= 18.5  (F19, bin <= 0)  left -> 5, right -> 8
node(5,4,19,0).
left_node(5,4,5).
right_node(5,4,8).
% node 5: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 6, right -> 7
node(5,5,22,5).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class Enrolled (1)
leaf_class(5,6,1).
% node 7 (leaf): class Dropout (0)
leaf_class(5,7,0).
% node 8: Admission grade <= 138.5500030517578  (F12, bin <= 25)  left -> 9, right -> 12
node(5,8,12,25).
left_node(5,8,9).
right_node(5,8,12).
% node 9: Curricular units 2nd sem (enrolled) <= 2.0  (F28, bin <= 1)  left -> 10, right -> 11
node(5,9,28,1).
left_node(5,9,10).
right_node(5,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(5,10,0).
% node 11 (leaf): class Dropout (0)
leaf_class(5,11,0).
% node 12 (leaf): class Graduate (2)
leaf_class(5,12,2).
% node 13 (leaf): class Graduate (2)
leaf_class(5,13,2).
% node 14 (leaf): class Dropout (0)
leaf_class(5,14,0).
% node 15 (leaf): class Graduate (2)
leaf_class(5,15,2).
% node 16: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 17, right -> 40
node(5,16,24,4).
left_node(5,16,17).
right_node(5,16,40).
% node 17: Previous qualification <= 29.0  (F5, bin <= 5)  left -> 18, right -> 39
node(5,17,5,5).
left_node(5,17,18).
right_node(5,17,39).
% node 18: Curricular units 1st sem (grade) <= 10.291666507720947  (F25, bin <= 4)  left -> 19, right -> 26
node(5,18,25,4).
left_node(5,18,19).
right_node(5,18,26).
% node 19: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 20, right -> 21
node(5,19,16,0).
left_node(5,19,20).
right_node(5,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(5,20,0).
% node 21: Curricular units 1st sem (approved) <= 1.5  (F24, bin <= 1)  left -> 22, right -> 25
node(5,21,24,1).
left_node(5,21,22).
right_node(5,21,25).
% node 22: Unemployment rate <= 11.75  (F33, bin <= 4)  left -> 23, right -> 24
node(5,22,33,4).
left_node(5,22,23).
right_node(5,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(5,23,0).
% node 24 (leaf): class Dropout (0)
leaf_class(5,24,0).
% node 25 (leaf): class Enrolled (1)
leaf_class(5,25,1).
% node 26: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 27, right -> 34
node(5,26,28,3).
left_node(5,26,27).
right_node(5,26,34).
% node 27: Age at enrollment <= 20.5  (F19, bin <= 2)  left -> 28, right -> 31
node(5,27,19,2).
left_node(5,27,28).
right_node(5,27,31).
% node 28: Previous qualification (grade) <= 141.5  (F6, bin <= 18)  left -> 29, right -> 30
node(5,28,6,18).
left_node(5,28,29).
right_node(5,28,30).
% node 29 (leaf): class Enrolled (1)
leaf_class(5,29,1).
% node 30 (leaf): class Graduate (2)
leaf_class(5,30,2).
% node 31: Previous qualification <= 2.0  (F5, bin <= 1)  left -> 32, right -> 33
node(5,31,5,1).
left_node(5,31,32).
right_node(5,31,33).
% node 32 (leaf): class Enrolled (1)
leaf_class(5,32,1).
% node 33 (leaf): class Dropout (0)
leaf_class(5,33,0).
% node 34: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 35, right -> 36
node(5,34,16,0).
left_node(5,34,35).
right_node(5,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(5,35,0).
% node 36: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 37, right -> 38
node(5,36,29,3).
left_node(5,36,37).
right_node(5,36,38).
% node 37 (leaf): class Dropout (0)
leaf_class(5,37,0).
% node 38 (leaf): class Dropout (0)
leaf_class(5,38,0).
% node 39 (leaf): class Enrolled (1)
leaf_class(5,39,1).
% node 40: Debtor <= 0.5  (F15, bin <= 0)  left -> 41, right -> 56
node(5,40,15,0).
left_node(5,40,41).
right_node(5,40,56).
% node 41: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 42, right -> 55
node(5,41,18,0).
left_node(5,41,42).
right_node(5,41,55).
% node 42: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 43, right -> 50
node(5,42,30,5).
left_node(5,42,43).
right_node(5,42,50).
% node 43: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 44, right -> 47
node(5,43,22,6).
left_node(5,43,44).
right_node(5,43,47).
% node 44: Admission grade <= 122.4000015258789  (F12, bin <= 6)  left -> 45, right -> 46
node(5,44,12,6).
left_node(5,44,45).
right_node(5,44,46).
% node 45 (leaf): class Graduate (2)
leaf_class(5,45,2).
% node 46 (leaf): class Graduate (2)
leaf_class(5,46,2).
% node 47: Curricular units 1st sem (credited) <= 0.5  (F21, bin <= 0)  left -> 48, right -> 49
node(5,47,21,0).
left_node(5,47,48).
right_node(5,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(5,48,1).
% node 49 (leaf): class Dropout (0)
leaf_class(5,49,0).
% node 50: Previous qualification (grade) <= 138.5  (F6, bin <= 14)  left -> 51, right -> 52
node(5,50,6,14).
left_node(5,50,51).
right_node(5,50,52).
% node 51 (leaf): class Graduate (2)
leaf_class(5,51,2).
% node 52: Curricular units 2nd sem (grade) <= 12.739285945892334  (F31, bin <= 48)  left -> 53, right -> 54
node(5,52,31,48).
left_node(5,52,53).
right_node(5,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(5,53,2).
% node 54 (leaf): class Graduate (2)
leaf_class(5,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(5,55,2).
% node 56: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 57, right -> 60
node(5,56,29,4).
left_node(5,56,57).
right_node(5,56,60).
% node 57: Father's occupation <= 8.0  (F11, bin <= 4)  left -> 58, right -> 59
node(5,57,11,4).
left_node(5,57,58).
right_node(5,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(5,58,0).
% node 59 (leaf): class Graduate (2)
leaf_class(5,59,2).
% node 60: Curricular units 1st sem (grade) <= 11.816666603088379  (F25, bin <= 24)  left -> 61, right -> 62
node(5,60,25,24).
left_node(5,60,61).
right_node(5,60,62).
% node 61 (leaf): class Dropout (0)
leaf_class(5,61,0).
% node 62: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 63, right -> 64
node(5,62,16,0).
left_node(5,62,63).
right_node(5,62,64).
% node 63 (leaf): class Dropout (0)
leaf_class(5,63,0).
% node 64 (leaf): class Graduate (2)
leaf_class(5,64,2).

% Tree 6
tree(6).
% node 0: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 1, right -> 10
node(6,0,16,0).
left_node(6,0,1).
right_node(6,0,10).
% node 1: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 2, right -> 3
node(6,1,29,2).
left_node(6,1,2).
right_node(6,1,3).
% node 2 (leaf): class Dropout (0)
leaf_class(6,2,0).
% node 3: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 4, right -> 9
node(6,3,29,5).
left_node(6,3,4).
right_node(6,3,9).
% node 4: Curricular units 2nd sem (grade) <= 11.775000095367432  (F31, bin <= 37)  left -> 5, right -> 6
node(6,4,31,37).
left_node(6,4,5).
right_node(6,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(6,5,0).
% node 6: Previous qualification (grade) <= 135.5  (F6, bin <= 12)  left -> 7, right -> 8
node(6,6,6,12).
left_node(6,6,7).
right_node(6,6,8).
% node 7 (leaf): class Dropout (0)
leaf_class(6,7,0).
% node 8 (leaf): class Graduate (2)
leaf_class(6,8,2).
% node 9 (leaf): class Dropout (0)
leaf_class(6,9,0).
% node 10: Debtor <= 0.5  (F15, bin <= 0)  left -> 11, right -> 36
node(6,10,15,0).
left_node(6,10,11).
right_node(6,10,36).
% node 11: Curricular units 2nd sem (without evaluations) <= 2.5  (F32, bin <= 1)  left -> 12, right -> 33
node(6,11,32,1).
left_node(6,11,12).
right_node(6,11,33).
% node 12: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 13, right -> 20
node(6,12,30,3).
left_node(6,12,13).
right_node(6,12,20).
% node 13: Father's occupation <= 0.5  (F11, bin <= 0)  left -> 14, right -> 15
node(6,13,11,0).
left_node(6,13,14).
right_node(6,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(6,14,0).
% node 15: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 16, right -> 17
node(6,15,22,0).
left_node(6,15,16).
right_node(6,15,17).
% node 16 (leaf): class Graduate (2)
leaf_class(6,16,2).
% node 17: Curricular units 1st sem (grade) <= 10.099999904632568  (F25, bin <= 3)  left -> 18, right -> 19
node(6,17,25,3).
left_node(6,17,18).
right_node(6,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(6,18,0).
% node 19 (leaf): class Dropout (0)
leaf_class(6,19,0).
% node 20: Displaced <= 0.5  (F13, bin <= 0)  left -> 21, right -> 28
node(6,20,13,0).
left_node(6,20,21).
right_node(6,20,28).
% node 21: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 22, right -> 25
node(6,21,24,4).
left_node(6,21,22).
right_node(6,21,25).
% node 22: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 23, right -> 24
node(6,22,29,3).
left_node(6,22,23).
right_node(6,22,24).
% node 23 (leaf): class Graduate (2)
leaf_class(6,23,2).
% node 24 (leaf): class Enrolled (1)
leaf_class(6,24,1).
% node 25: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 26, right -> 27
node(6,25,23,4).
left_node(6,25,26).
right_node(6,25,27).
% node 26 (leaf): class Graduate (2)
leaf_class(6,26,2).
% node 27 (leaf): class Graduate (2)
leaf_class(6,27,2).
% node 28: Curricular units 1st sem (grade) <= 13.288690567016602  (F25, bin <= 45)  left -> 29, right -> 32
node(6,28,25,45).
left_node(6,28,29).
right_node(6,28,32).
% node 29: Curricular units 1st sem (grade) <= 11.98722219467163  (F25, bin <= 30)  left -> 30, right -> 31
node(6,29,25,30).
left_node(6,29,30).
right_node(6,29,31).
% node 30 (leaf): class Graduate (2)
leaf_class(6,30,2).
% node 31 (leaf): class Graduate (2)
leaf_class(6,31,2).
% node 32 (leaf): class Graduate (2)
leaf_class(6,32,2).
% node 33: Unemployment rate <= 13.150000095367432  (F33, bin <= 7)  left -> 34, right -> 35
node(6,33,33,7).
left_node(6,33,34).
right_node(6,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(6,34,1).
% node 35 (leaf): class Dropout (0)
leaf_class(6,35,0).
% node 36: Inflation rate <= 1.9999999403953552  (F34, bin <= 6)  left -> 37, right -> 46
node(6,36,34,6).
left_node(6,36,37).
right_node(6,36,46).
% node 37: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 38, right -> 39
node(6,37,23,2).
left_node(6,37,38).
right_node(6,37,39).
% node 38 (leaf): class Dropout (0)
leaf_class(6,38,0).
% node 39: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 40, right -> 45
node(6,39,29,6).
left_node(6,39,40).
right_node(6,39,45).
% node 40: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 41, right -> 42
node(6,40,24,4).
left_node(6,40,41).
right_node(6,40,42).
% node 41 (leaf): class Dropout (0)
leaf_class(6,41,0).
% node 42: Displaced <= 0.5  (F13, bin <= 0)  left -> 43, right -> 44
node(6,42,13,0).
left_node(6,42,43).
right_node(6,42,44).
% node 43 (leaf): class Graduate (2)
leaf_class(6,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(6,44,2).
% node 45 (leaf): class Enrolled (1)
leaf_class(6,45,1).
% node 46 (leaf): class Dropout (0)
leaf_class(6,46,0).

% Tree 7
tree(7).
% node 0: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 1, right -> 56
node(7,0,18,0).
left_node(7,0,1).
right_node(7,0,56).
% node 1: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 2, right -> 33
node(7,1,30,4).
left_node(7,1,2).
right_node(7,1,33).
% node 2: Curricular units 1st sem (approved) <= 2.5  (F24, bin <= 2)  left -> 3, right -> 16
node(7,2,24,2).
left_node(7,2,3).
right_node(7,2,16).
% node 3: Course <= 4092.5  (F3, bin <= 0)  left -> 4, right -> 7
node(7,3,3,0).
left_node(7,3,4).
right_node(7,3,7).
% node 4: Age at enrollment <= 24.5  (F19, bin <= 6)  left -> 5, right -> 6
node(7,4,19,6).
left_node(7,4,5).
right_node(7,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(7,5,0).
% node 6 (leaf): class Dropout (0)
leaf_class(7,6,0).
% node 7: Inflation rate <= -0.550000011920929  (F34, bin <= 0)  left -> 8, right -> 11
node(7,7,34,0).
left_node(7,7,8).
right_node(7,7,11).
% node 8: Curricular units 2nd sem (grade) <= 11.125  (F31, bin <= 19)  left -> 9, right -> 10
node(7,8,31,19).
left_node(7,8,9).
right_node(7,8,10).
% node 9 (leaf): class Dropout (0)
leaf_class(7,9,0).
% node 10 (leaf): class Enrolled (1)
leaf_class(7,10,1).
% node 11: Course <= 9192.5  (F3, bin <= 8)  left -> 12, right -> 15
node(7,11,3,8).
left_node(7,11,12).
right_node(7,11,15).
% node 12: Curricular units 1st sem (evaluations) <= 4.5  (F23, bin <= 1)  left -> 13, right -> 14
node(7,12,23,1).
left_node(7,12,13).
right_node(7,12,14).
% node 13 (leaf): class Dropout (0)
leaf_class(7,13,0).
% node 14 (leaf): class Dropout (0)
leaf_class(7,14,0).
% node 15 (leaf): class Dropout (0)
leaf_class(7,15,0).
% node 16: Curricular units 1st sem (credited) <= 3.5  (F21, bin <= 2)  left -> 17, right -> 32
node(7,16,21,2).
left_node(7,16,17).
right_node(7,16,32).
% node 17: Application order <= 1.5  (F2, bin <= 0)  left -> 18, right -> 25
node(7,17,2,0).
left_node(7,17,18).
right_node(7,17,25).
% node 18: Course <= 9377.0  (F3, bin <= 10)  left -> 19, right -> 22
node(7,18,3,10).
left_node(7,18,19).
right_node(7,18,22).
% node 19: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 20, right -> 21
node(7,19,30,3).
left_node(7,19,20).
right_node(7,19,21).
% node 20 (leaf): class Enrolled (1)
leaf_class(7,20,1).
% node 21 (leaf): class Enrolled (1)
leaf_class(7,21,1).
% node 22: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 23, right -> 24
node(7,22,16,0).
left_node(7,22,23).
right_node(7,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(7,23,0).
% node 24 (leaf): class Dropout (0)
leaf_class(7,24,0).
% node 25: Mother's qualification <= 4.5  (F8, bin <= 3)  left -> 26, right -> 29
node(7,25,8,3).
left_node(7,25,26).
right_node(7,25,29).
% node 26: Inflation rate <= 1.9999999403953552  (F34, bin <= 6)  left -> 27, right -> 28
node(7,26,34,6).
left_node(7,26,27).
right_node(7,26,28).
% node 27 (leaf): class Enrolled (1)
leaf_class(7,27,1).
% node 28 (leaf): class Graduate (2)
leaf_class(7,28,2).
% node 29: Course <= 9721.5  (F3, bin <= 12)  left -> 30, right -> 31
node(7,29,3,12).
left_node(7,29,30).
right_node(7,29,31).
% node 30 (leaf): class Enrolled (1)
leaf_class(7,30,1).
% node 31 (leaf): class Dropout (0)
leaf_class(7,31,0).
% node 32 (leaf): class Dropout (0)
leaf_class(7,32,0).
% node 33: Admission grade <= 108.3499984741211  (F12, bin <= 2)  left -> 34, right -> 37
node(7,33,12,2).
left_node(7,33,34).
right_node(7,33,37).
% node 34: Debtor <= 0.5  (F15, bin <= 0)  left -> 35, right -> 36
node(7,34,15,0).
left_node(7,34,35).
right_node(7,34,36).
% node 35 (leaf): class Graduate (2)
leaf_class(7,35,2).
% node 36 (leaf): class Enrolled (1)
leaf_class(7,36,1).
% node 37: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 38, right -> 45
node(7,37,30,5).
left_node(7,37,38).
right_node(7,37,45).
% node 38: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 39, right -> 44
node(7,38,28,4).
left_node(7,38,39).
right_node(7,38,44).
% node 39: Debtor <= 0.5  (F15, bin <= 0)  left -> 40, right -> 43
node(7,39,15,0).
left_node(7,39,40).
right_node(7,39,43).
% node 40: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 41, right -> 42
node(7,40,23,4).
left_node(7,40,41).
right_node(7,40,42).
% node 41 (leaf): class Graduate (2)
leaf_class(7,41,2).
% node 42 (leaf): class Graduate (2)
leaf_class(7,42,2).
% node 43 (leaf): class Dropout (0)
leaf_class(7,43,0).
% node 44 (leaf): class Dropout (0)
leaf_class(7,44,0).
% node 45: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 46, right -> 51
node(7,45,19,4).
left_node(7,45,46).
right_node(7,45,51).
% node 46: Curricular units 2nd sem (enrolled) <= 9.5  (F28, bin <= 7)  left -> 47, right -> 50
node(7,46,28,7).
left_node(7,46,47).
right_node(7,46,50).
% node 47: Curricular units 2nd sem (grade) <= 13.49833345413208  (F31, bin <= 52)  left -> 48, right -> 49
node(7,47,31,52).
left_node(7,47,48).
right_node(7,47,49).
% node 48 (leaf): class Graduate (2)
leaf_class(7,48,2).
% node 49 (leaf): class Graduate (2)
leaf_class(7,49,2).
% node 50 (leaf): class Graduate (2)
leaf_class(7,50,2).
% node 51: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 52, right -> 53
node(7,51,16,0).
left_node(7,51,52).
right_node(7,51,53).
% node 52 (leaf): class Dropout (0)
leaf_class(7,52,0).
% node 53: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 54, right -> 55
node(7,53,28,4).
left_node(7,53,54).
right_node(7,53,55).
% node 54 (leaf): class Graduate (2)
leaf_class(7,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(7,55,2).
% node 56: Gender <= 0.5  (F17, bin <= 0)  left -> 57, right -> 68
node(7,56,17,0).
left_node(7,56,57).
right_node(7,56,68).
% node 57: Curricular units 1st sem (grade) <= 10.535714149475098  (F25, bin <= 7)  left -> 58, right -> 59
node(7,57,25,7).
left_node(7,57,58).
right_node(7,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(7,58,0).
% node 59: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 60, right -> 61
node(7,59,16,0).
left_node(7,59,60).
right_node(7,59,61).
% node 60 (leaf): class Dropout (0)
leaf_class(7,60,0).
% node 61: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 62, right -> 67
node(7,61,24,5).
left_node(7,61,62).
right_node(7,61,67).
% node 62: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 63, right -> 64
node(7,62,30,3).
left_node(7,62,63).
right_node(7,62,64).
% node 63 (leaf): class Enrolled (1)
leaf_class(7,63,1).
% node 64: Course <= 9377.0  (F3, bin <= 10)  left -> 65, right -> 66
node(7,64,3,10).
left_node(7,64,65).
right_node(7,64,66).
% node 65 (leaf): class Graduate (2)
leaf_class(7,65,2).
% node 66 (leaf): class Graduate (2)
leaf_class(7,66,2).
% node 67 (leaf): class Graduate (2)
leaf_class(7,67,2).
% node 68: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 69, right -> 72
node(7,68,30,5).
left_node(7,68,69).
right_node(7,68,72).
% node 69: Displaced <= 0.5  (F13, bin <= 0)  left -> 70, right -> 71
node(7,69,13,0).
left_node(7,69,70).
right_node(7,69,71).
% node 70 (leaf): class Enrolled (1)
leaf_class(7,70,1).
% node 71 (leaf): class Graduate (2)
leaf_class(7,71,2).
% node 72 (leaf): class Graduate (2)
leaf_class(7,72,2).

% Tree 8
tree(8).
% node 0: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 1, right -> 8
node(8,0,16,0).
left_node(8,0,1).
right_node(8,0,8).
% node 1: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 2, right -> 3
node(8,1,30,3).
left_node(8,1,2).
right_node(8,1,3).
% node 2 (leaf): class Dropout (0)
leaf_class(8,2,0).
% node 3: Curricular units 2nd sem (grade) <= 12.633333683013916  (F31, bin <= 46)  left -> 4, right -> 5
node(8,3,31,46).
left_node(8,3,4).
right_node(8,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(8,4,0).
% node 5: Curricular units 1st sem (evaluations) <= 6.5  (F23, bin <= 3)  left -> 6, right -> 7
node(8,5,23,3).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class Graduate (2)
leaf_class(8,6,2).
% node 7 (leaf): class Dropout (0)
leaf_class(8,7,0).
% node 8: Mother's occupation <= 0.5  (F10, bin <= 0)  left -> 9, right -> 14
node(8,8,10,0).
left_node(8,8,9).
right_node(8,8,14).
% node 9: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 10, right -> 11
node(8,9,30,3).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(8,10,0).
% node 11: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 12, right -> 13
node(8,11,28,5).
left_node(8,11,12).
right_node(8,11,13).
% node 12 (leaf): class Graduate (2)
leaf_class(8,12,2).
% node 13 (leaf): class Graduate (2)
leaf_class(8,13,2).
% node 14: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 15, right -> 36
node(8,14,24,4).
left_node(8,14,15).
right_node(8,14,36).
% node 15: Curricular units 2nd sem (grade) <= 10.366666316986084  (F31, bin <= 9)  left -> 16, right -> 25
node(8,15,31,9).
left_node(8,15,16).
right_node(8,15,25).
% node 16: Curricular units 1st sem (evaluations) <= 0.5  (F23, bin <= 0)  left -> 17, right -> 22
node(8,16,23,0).
left_node(8,16,17).
right_node(8,16,22).
% node 17: Course <= 4092.5  (F3, bin <= 0)  left -> 18, right -> 21
node(8,17,3,0).
left_node(8,17,18).
right_node(8,17,21).
% node 18: Previous qualification (grade) <= 140.5  (F6, bin <= 15)  left -> 19, right -> 20
node(8,18,6,15).
left_node(8,18,19).
right_node(8,18,20).
% node 19 (leaf): class Dropout (0)
leaf_class(8,19,0).
% node 20 (leaf): class Graduate (2)
leaf_class(8,20,2).
% node 21 (leaf): class Dropout (0)
leaf_class(8,21,0).
% node 22: Father's qualification <= 1.5  (F9, bin <= 0)  left -> 23, right -> 24
node(8,22,9,0).
left_node(8,22,23).
right_node(8,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(8,23,0).
% node 24 (leaf): class Dropout (0)
leaf_class(8,24,0).
% node 25: Curricular units 1st sem (grade) <= 10.291666507720947  (F25, bin <= 4)  left -> 26, right -> 29
node(8,25,25,4).
left_node(8,25,26).
right_node(8,25,29).
% node 26: Mother's qualification <= 28.0  (F8, bin <= 6)  left -> 27, right -> 28
node(8,26,8,6).
left_node(8,26,27).
right_node(8,26,28).
% node 27 (leaf): class Enrolled (1)
leaf_class(8,27,1).
% node 28 (leaf): class Dropout (0)
leaf_class(8,28,0).
% node 29: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 30, right -> 33
node(8,29,24,3).
left_node(8,29,30).
right_node(8,29,33).
% node 30: Previous qualification (grade) <= 130.5  (F6, bin <= 6)  left -> 31, right -> 32
node(8,30,6,6).
left_node(8,30,31).
right_node(8,30,32).
% node 31 (leaf): class Enrolled (1)
leaf_class(8,31,1).
% node 32 (leaf): class Dropout (0)
leaf_class(8,32,0).
% node 33: GDP <= -3.5899999141693115  (F35, bin <= 0)  left -> 34, right -> 35
node(8,33,35,0).
left_node(8,33,34).
right_node(8,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(8,34,1).
% node 35 (leaf): class Graduate (2)
leaf_class(8,35,2).
% node 36: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 37, right -> 44
node(8,36,29,6).
left_node(8,36,37).
right_node(8,36,44).
% node 37: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 38, right -> 43
node(8,37,28,5).
left_node(8,37,38).
right_node(8,37,43).
% node 38: Curricular units 2nd sem (grade) <= 10.449999809265137  (F31, bin <= 11)  left -> 39, right -> 40
node(8,38,31,11).
left_node(8,38,39).
right_node(8,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(8,39,0).
% node 40: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 41, right -> 42
node(8,40,29,4).
left_node(8,40,41).
right_node(8,40,42).
% node 41 (leaf): class Graduate (2)
leaf_class(8,41,2).
% node 42 (leaf): class Graduate (2)
leaf_class(8,42,2).
% node 43 (leaf): class Graduate (2)
leaf_class(8,43,2).
% node 44: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 45, right -> 52
node(8,44,18,0).
left_node(8,44,45).
right_node(8,44,52).
% node 45: Inflation rate <= 0.0  (F34, bin <= 1)  left -> 46, right -> 49
node(8,45,34,1).
left_node(8,45,46).
right_node(8,45,49).
% node 46: Curricular units 1st sem (evaluations) <= 13.5  (F23, bin <= 9)  left -> 47, right -> 48
node(8,46,23,9).
left_node(8,46,47).
right_node(8,46,48).
% node 47 (leaf): class Enrolled (1)
leaf_class(8,47,1).
% node 48 (leaf): class Graduate (2)
leaf_class(8,48,2).
% node 49: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 50, right -> 51
node(8,49,22,6).
left_node(8,49,50).
right_node(8,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(8,50,2).
% node 51 (leaf): class Graduate (2)
leaf_class(8,51,2).
% node 52 (leaf): class Graduate (2)
leaf_class(8,52,2).

% Tree 9
tree(9).
% node 0: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 1, right -> 48
node(9,0,18,0).
left_node(9,0,1).
right_node(9,0,48).
% node 1: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 2, right -> 25
node(9,1,19,3).
left_node(9,1,2).
right_node(9,1,25).
% node 2: Curricular units 2nd sem (evaluations) <= 2.5  (F29, bin <= 0)  left -> 3, right -> 12
node(9,2,29,0).
left_node(9,2,3).
right_node(9,2,12).
% node 3: Previous qualification (grade) <= 136.5  (F6, bin <= 13)  left -> 4, right -> 7
node(9,3,6,13).
left_node(9,3,4).
right_node(9,3,7).
% node 4: Unemployment rate <= 8.249999761581421  (F33, bin <= 0)  left -> 5, right -> 6
node(9,4,33,0).
left_node(9,4,5).
right_node(9,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(9,5,0).
% node 6 (leaf): class Dropout (0)
leaf_class(9,6,0).
% node 7: Unemployment rate <= 10.950000286102295  (F33, bin <= 3)  left -> 8, right -> 9
node(9,7,33,3).
left_node(9,7,8).
right_node(9,7,9).
% node 8 (leaf): class Dropout (0)
leaf_class(9,8,0).
% node 9: Inflation rate <= 1.699999988079071  (F34, bin <= 5)  left -> 10, right -> 11
node(9,9,34,5).
left_node(9,9,10).
right_node(9,9,11).
% node 10 (leaf): class Graduate (2)
leaf_class(9,10,2).
% node 11 (leaf): class Dropout (0)
leaf_class(9,11,0).
% node 12: Curricular units 2nd sem (grade) <= 11.05555534362793  (F31, bin <= 17)  left -> 13, right -> 18
node(9,12,31,17).
left_node(9,12,13).
right_node(9,12,18).
% node 13: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 14, right -> 15
node(9,13,30,2).
left_node(9,13,14).
right_node(9,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(9,14,0).
% node 15: Curricular units 1st sem (grade) <= 11.083333492279053  (F25, bin <= 12)  left -> 16, right -> 17
node(9,15,25,12).
left_node(9,15,16).
right_node(9,15,17).
% node 16 (leaf): class Enrolled (1)
leaf_class(9,16,1).
% node 17 (leaf): class Enrolled (1)
leaf_class(9,17,1).
% node 18: Curricular units 2nd sem (grade) <= 11.820833206176758  (F31, bin <= 38)  left -> 19, right -> 20
node(9,18,31,38).
left_node(9,18,19).
right_node(9,18,20).
% node 19 (leaf): class Graduate (2)
leaf_class(9,19,2).
% node 20: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 21, right -> 22
node(9,20,23,5).
left_node(9,20,21).
right_node(9,20,22).
% node 21 (leaf): class Graduate (2)
leaf_class(9,21,2).
% node 22: Curricular units 2nd sem (credited) <= 1.5  (F27, bin <= 1)  left -> 23, right -> 24
node(9,22,27,1).
left_node(9,22,23).
right_node(9,22,24).
% node 23 (leaf): class Graduate (2)
leaf_class(9,23,2).
% node 24 (leaf): class Graduate (2)
leaf_class(9,24,2).
% node 25: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 26, right -> 37
node(9,25,27,0).
left_node(9,25,26).
right_node(9,25,37).
% node 26: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 27, right -> 28
node(9,26,16,0).
left_node(9,26,27).
right_node(9,26,28).
% node 27 (leaf): class Dropout (0)
leaf_class(9,27,0).
% node 28: Mother's occupation <= 116.5  (F10, bin <= 11)  left -> 29, right -> 36
node(9,28,10,11).
left_node(9,28,29).
right_node(9,28,36).
% node 29: Curricular units 1st sem (grade) <= 10.416666507720947  (F25, bin <= 6)  left -> 30, right -> 33
node(9,29,25,6).
left_node(9,29,30).
right_node(9,29,33).
% node 30: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 31, right -> 32
node(9,30,29,4).
left_node(9,30,31).
right_node(9,30,32).
% node 31 (leaf): class Dropout (0)
leaf_class(9,31,0).
% node 32 (leaf): class Dropout (0)
leaf_class(9,32,0).
% node 33: Father's qualification <= 4.5  (F9, bin <= 2)  left -> 34, right -> 35
node(9,33,9,2).
left_node(9,33,34).
right_node(9,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(9,34,1).
% node 35 (leaf): class Graduate (2)
leaf_class(9,35,2).
% node 36 (leaf): class Enrolled (1)
leaf_class(9,36,1).
% node 37: Curricular units 1st sem (evaluations) <= 18.5  (F23, bin <= 10)  left -> 38, right -> 45
node(9,37,23,10).
left_node(9,37,38).
right_node(9,37,45).
% node 38: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 39, right -> 40
node(9,38,16,0).
left_node(9,38,39).
right_node(9,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(9,39,0).
% node 40: Course <= 8508.5  (F3, bin <= 2)  left -> 41, right -> 42
node(9,40,3,2).
left_node(9,40,41).
right_node(9,40,42).
% node 41 (leaf): class Graduate (2)
leaf_class(9,41,2).
% node 42: Curricular units 2nd sem (approved) <= 6.5  (F30, bin <= 6)  left -> 43, right -> 44
node(9,42,30,6).
left_node(9,42,43).
right_node(9,42,44).
% node 43 (leaf): class Dropout (0)
leaf_class(9,43,0).
% node 44 (leaf): class Graduate (2)
leaf_class(9,44,2).
% node 45: Curricular units 1st sem (approved) <= 11.5  (F24, bin <= 8)  left -> 46, right -> 47
node(9,45,24,8).
left_node(9,45,46).
right_node(9,45,47).
% node 46 (leaf): class Dropout (0)
leaf_class(9,46,0).
% node 47 (leaf): class Graduate (2)
leaf_class(9,47,2).
% node 48: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 49, right -> 54
node(9,48,30,3).
left_node(9,48,49).
right_node(9,48,54).
% node 49: Curricular units 2nd sem (evaluations) <= 2.5  (F29, bin <= 0)  left -> 50, right -> 51
node(9,49,29,0).
left_node(9,49,50).
right_node(9,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(9,50,2).
% node 51: Curricular units 2nd sem (grade) <= 11.166666507720947  (F31, bin <= 21)  left -> 52, right -> 53
node(9,51,31,21).
left_node(9,51,52).
right_node(9,51,53).
% node 52 (leaf): class Dropout (0)
leaf_class(9,52,0).
% node 53 (leaf): class Dropout (0)
leaf_class(9,53,0).
% node 54: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 55, right -> 56
node(9,54,16,0).
left_node(9,54,55).
right_node(9,54,56).
% node 55 (leaf): class Dropout (0)
leaf_class(9,55,0).
% node 56: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 57, right -> 64
node(9,56,30,5).
left_node(9,56,57).
right_node(9,56,64).
% node 57: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 58, right -> 59
node(9,57,23,4).
left_node(9,57,58).
right_node(9,57,59).
% node 58 (leaf): class Graduate (2)
leaf_class(9,58,2).
% node 59: GDP <= 0.5550000071525574  (F35, bin <= 3)  left -> 60, right -> 63
node(9,59,35,3).
left_node(9,59,60).
right_node(9,59,63).
% node 60: Curricular units 1st sem (grade) <= 11.989999771118164  (F25, bin <= 31)  left -> 61, right -> 62
node(9,60,25,31).
left_node(9,60,61).
right_node(9,60,62).
% node 61 (leaf): class Enrolled (1)
leaf_class(9,61,1).
% node 62 (leaf): class Graduate (2)
leaf_class(9,62,2).
% node 63 (leaf): class Graduate (2)
leaf_class(9,63,2).
% node 64 (leaf): class Graduate (2)
leaf_class(9,64,2).

% Tree 10
tree(10).
% node 0: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 1, right -> 26
node(10,0,30,4).
left_node(10,0,1).
right_node(10,0,26).
% node 1: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 2, right -> 5
node(10,1,31,0).
left_node(10,1,2).
right_node(10,1,5).
% node 2: Course <= 4092.5  (F3, bin <= 0)  left -> 3, right -> 4
node(10,2,3,0).
left_node(10,2,3).
right_node(10,2,4).
% node 3 (leaf): class Dropout (0)
leaf_class(10,3,0).
% node 4 (leaf): class Dropout (0)
leaf_class(10,4,0).
% node 5: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 6, right -> 23
node(10,5,22,6).
left_node(10,5,6).
right_node(10,5,23).
% node 6: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 7, right -> 8
node(10,6,16,0).
left_node(10,6,7).
right_node(10,6,8).
% node 7 (leaf): class Dropout (0)
leaf_class(10,7,0).
% node 8: Application mode <= 17.5  (F1, bin <= 5)  left -> 9, right -> 16
node(10,8,1,5).
left_node(10,8,9).
right_node(10,8,16).
% node 9: Curricular units 2nd sem (grade) <= 11.366666316986084  (F31, bin <= 29)  left -> 10, right -> 13
node(10,9,31,29).
left_node(10,9,10).
right_node(10,9,13).
% node 10: GDP <= 1.7649999856948853  (F35, bin <= 6)  left -> 11, right -> 12
node(10,10,35,6).
left_node(10,10,11).
right_node(10,10,12).
% node 11 (leaf): class Enrolled (1)
leaf_class(10,11,1).
% node 12 (leaf): class Graduate (2)
leaf_class(10,12,2).
% node 13: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 14, right -> 15
node(10,13,29,6).
left_node(10,13,14).
right_node(10,13,15).
% node 14 (leaf): class Graduate (2)
leaf_class(10,14,2).
% node 15 (leaf): class Enrolled (1)
leaf_class(10,15,1).
% node 16: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 17, right -> 20
node(10,16,4,0).
left_node(10,16,17).
right_node(10,16,20).
% node 17: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 18, right -> 19
node(10,17,30,3).
left_node(10,17,18).
right_node(10,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(10,18,0).
% node 19 (leaf): class Enrolled (1)
leaf_class(10,19,1).
% node 20: Age at enrollment <= 25.5  (F19, bin <= 8)  left -> 21, right -> 22
node(10,20,19,8).
left_node(10,20,21).
right_node(10,20,22).
% node 21 (leaf): class Enrolled (1)
leaf_class(10,21,1).
% node 22 (leaf): class Dropout (0)
leaf_class(10,22,0).
% node 23: Mother's occupation <= 3.5  (F10, bin <= 2)  left -> 24, right -> 25
node(10,23,10,2).
left_node(10,23,24).
right_node(10,23,25).
% node 24 (leaf): class Enrolled (1)
leaf_class(10,24,1).
% node 25 (leaf): class Dropout (0)
leaf_class(10,25,0).
% node 26: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 27, right -> 46
node(10,26,29,6).
left_node(10,26,27).
right_node(10,26,46).
% node 27: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 28, right -> 37
node(10,27,24,5).
left_node(10,27,28).
right_node(10,27,37).
% node 28: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 29, right -> 30
node(10,28,16,0).
left_node(10,28,29).
right_node(10,28,30).
% node 29 (leaf): class Dropout (0)
leaf_class(10,29,0).
% node 30: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 31, right -> 34
node(10,30,29,4).
left_node(10,30,31).
right_node(10,30,34).
% node 31: Application order <= 2.5  (F2, bin <= 1)  left -> 32, right -> 33
node(10,31,2,1).
left_node(10,31,32).
right_node(10,31,33).
% node 32 (leaf): class Graduate (2)
leaf_class(10,32,2).
% node 33 (leaf): class Enrolled (1)
leaf_class(10,33,1).
% node 34: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 35, right -> 36
node(10,34,28,4).
left_node(10,34,35).
right_node(10,34,36).
% node 35 (leaf): class Graduate (2)
leaf_class(10,35,2).
% node 36 (leaf): class Enrolled (1)
leaf_class(10,36,1).
% node 37: Curricular units 1st sem (grade) <= 13.25374984741211  (F25, bin <= 44)  left -> 38, right -> 45
node(10,37,25,44).
left_node(10,37,38).
right_node(10,37,45).
% node 38: Previous qualification (grade) <= 118.5  (F6, bin <= 0)  left -> 39, right -> 40
node(10,38,6,0).
left_node(10,38,39).
right_node(10,38,40).
% node 39 (leaf): class Graduate (2)
leaf_class(10,39,2).
% node 40: Mother's occupation <= 4.5  (F10, bin <= 3)  left -> 41, right -> 44
node(10,40,10,3).
left_node(10,40,41).
right_node(10,40,44).
% node 41: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 42, right -> 43
node(10,41,30,5).
left_node(10,41,42).
right_node(10,41,43).
% node 42 (leaf): class Dropout (0)
leaf_class(10,42,0).
% node 43 (leaf): class Graduate (2)
leaf_class(10,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(10,44,2).
% node 45 (leaf): class Graduate (2)
leaf_class(10,45,2).
% node 46: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 47, right -> 52
node(10,46,24,5).
left_node(10,46,47).
right_node(10,46,52).
% node 47: Unemployment rate <= 14.699999809265137  (F33, bin <= 10)  left -> 48, right -> 51
node(10,47,33,10).
left_node(10,47,48).
right_node(10,47,51).
% node 48: Curricular units 1st sem (grade) <= 13.063000202178955  (F25, bin <= 43)  left -> 49, right -> 50
node(10,48,25,43).
left_node(10,48,49).
right_node(10,48,50).
% node 49 (leaf): class Dropout (0)
leaf_class(10,49,0).
% node 50 (leaf): class Enrolled (1)
leaf_class(10,50,1).
% node 51 (leaf): class Graduate (2)
leaf_class(10,51,2).
% node 52: Curricular units 1st sem (grade) <= 11.645833492279053  (F25, bin <= 21)  left -> 53, right -> 54
node(10,52,25,21).
left_node(10,52,53).
right_node(10,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(10,53,2).
% node 54: Debtor <= 0.5  (F15, bin <= 0)  left -> 55, right -> 60
node(10,54,15,0).
left_node(10,54,55).
right_node(10,54,60).
% node 55: Age at enrollment <= 18.5  (F19, bin <= 0)  left -> 56, right -> 59
node(10,55,19,0).
left_node(10,55,56).
right_node(10,55,59).
% node 56: Curricular units 1st sem (grade) <= 12.60991096496582  (F25, bin <= 40)  left -> 57, right -> 58
node(10,56,25,40).
left_node(10,56,57).
right_node(10,56,58).
% node 57 (leaf): class Enrolled (1)
leaf_class(10,57,1).
% node 58 (leaf): class Graduate (2)
leaf_class(10,58,2).
% node 59 (leaf): class Graduate (2)
leaf_class(10,59,2).
% node 60: Previous qualification (grade) <= 131.5  (F6, bin <= 8)  left -> 61, right -> 62
node(10,60,6,8).
left_node(10,60,61).
right_node(10,60,62).
% node 61 (leaf): class Dropout (0)
leaf_class(10,61,0).
% node 62 (leaf): class Enrolled (1)
leaf_class(10,62,1).

% Tree 11
tree(11).
% node 0: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 1, right -> 16
node(11,0,29,2).
left_node(11,0,1).
right_node(11,0,16).
% node 1: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 2, right -> 15
node(11,1,28,3).
left_node(11,1,2).
right_node(11,1,15).
% node 2: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 3, right -> 14
node(11,2,24,3).
left_node(11,2,3).
right_node(11,2,14).
% node 3: Admission grade <= 140.5999984741211  (F12, bin <= 26)  left -> 4, right -> 11
node(11,3,12,26).
left_node(11,3,4).
right_node(11,3,11).
% node 4: Age at enrollment <= 18.5  (F19, bin <= 0)  left -> 5, right -> 6
node(11,4,19,0).
left_node(11,4,5).
right_node(11,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(11,5,0).
% node 6: Previous qualification <= 2.0  (F5, bin <= 1)  left -> 7, right -> 10
node(11,6,5,1).
left_node(11,6,7).
right_node(11,6,10).
% node 7: Curricular units 1st sem (enrolled) <= 3.5  (F22, bin <= 4)  left -> 8, right -> 9
node(11,7,22,4).
left_node(11,7,8).
right_node(11,7,9).
% node 8 (leaf): class Dropout (0)
leaf_class(11,8,0).
% node 9 (leaf): class Dropout (0)
leaf_class(11,9,0).
% node 10 (leaf): class Dropout (0)
leaf_class(11,10,0).
% node 11: Displaced <= 0.5  (F13, bin <= 0)  left -> 12, right -> 13
node(11,11,13,0).
left_node(11,11,12).
right_node(11,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(11,12,0).
% node 13 (leaf): class Graduate (2)
leaf_class(11,13,2).
% node 14 (leaf): class Graduate (2)
leaf_class(11,14,2).
% node 15 (leaf): class Dropout (0)
leaf_class(11,15,0).
% node 16: Curricular units 1st sem (grade) <= 12.040714263916016  (F25, bin <= 33)  left -> 17, right -> 48
node(11,16,25,33).
left_node(11,16,17).
right_node(11,16,48).
% node 17: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 18, right -> 33
node(11,17,19,3).
left_node(11,17,18).
right_node(11,17,33).
% node 18: Curricular units 2nd sem (grade) <= 10.166666507720947  (F31, bin <= 4)  left -> 19, right -> 20
node(11,18,31,4).
left_node(11,18,19).
right_node(11,18,20).
% node 19 (leaf): class Dropout (0)
leaf_class(11,19,0).
% node 20: Unemployment rate <= 10.950000286102295  (F33, bin <= 3)  left -> 21, right -> 28
node(11,20,33,3).
left_node(11,20,21).
right_node(11,20,28).
% node 21: Curricular units 1st sem (grade) <= 11.989999771118164  (F25, bin <= 31)  left -> 22, right -> 25
node(11,21,25,31).
left_node(11,21,22).
right_node(11,21,25).
% node 22: Course <= 9192.5  (F3, bin <= 8)  left -> 23, right -> 24
node(11,22,3,8).
left_node(11,22,23).
right_node(11,22,24).
% node 23 (leaf): class Enrolled (1)
leaf_class(11,23,1).
% node 24 (leaf): class Graduate (2)
leaf_class(11,24,2).
% node 25: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 26, right -> 27
node(11,25,29,6).
left_node(11,25,26).
right_node(11,25,27).
% node 26 (leaf): class Dropout (0)
leaf_class(11,26,0).
% node 27 (leaf): class Dropout (0)
leaf_class(11,27,0).
% node 28: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 29, right -> 30
node(11,28,29,5).
left_node(11,28,29).
right_node(11,28,30).
% node 29 (leaf): class Graduate (2)
leaf_class(11,29,2).
% node 30: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 31, right -> 32
node(11,30,30,4).
left_node(11,30,31).
right_node(11,30,32).
% node 31 (leaf): class Enrolled (1)
leaf_class(11,31,1).
% node 32 (leaf): class Graduate (2)
leaf_class(11,32,2).
% node 33: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 34, right -> 35
node(11,33,30,3).
left_node(11,33,34).
right_node(11,33,35).
% node 34 (leaf): class Dropout (0)
leaf_class(11,34,0).
% node 35: Previous qualification (grade) <= 131.0  (F6, bin <= 7)  left -> 36, right -> 41
node(11,35,6,7).
left_node(11,35,36).
right_node(11,35,41).
% node 36: Course <= 8508.5  (F3, bin <= 2)  left -> 37, right -> 38
node(11,36,3,2).
left_node(11,36,37).
right_node(11,36,38).
% node 37 (leaf): class Graduate (2)
leaf_class(11,37,2).
% node 38: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 39, right -> 40
node(11,38,16,0).
left_node(11,38,39).
right_node(11,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(11,39,0).
% node 40 (leaf): class Dropout (0)
leaf_class(11,40,0).
% node 41: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 42, right -> 45
node(11,41,29,6).
left_node(11,41,42).
right_node(11,41,45).
% node 42: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 43, right -> 44
node(11,42,24,4).
left_node(11,42,43).
right_node(11,42,44).
% node 43 (leaf): class Graduate (2)
leaf_class(11,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(11,44,2).
% node 45: Curricular units 1st sem (credited) <= 5.5  (F21, bin <= 3)  left -> 46, right -> 47
node(11,45,21,3).
left_node(11,45,46).
right_node(11,45,47).
% node 46 (leaf): class Enrolled (1)
leaf_class(11,46,1).
% node 47 (leaf): class Graduate (2)
leaf_class(11,47,2).
% node 48: Previous qualification <= 2.5  (F5, bin <= 2)  left -> 49, right -> 70
node(11,48,5,2).
left_node(11,48,49).
right_node(11,48,70).
% node 49: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 50, right -> 57
node(11,49,30,4).
left_node(11,49,50).
right_node(11,49,57).
% node 50: Age at enrollment <= 24.5  (F19, bin <= 6)  left -> 51, right -> 56
node(11,50,19,6).
left_node(11,50,51).
right_node(11,50,56).
% node 51: Admission grade <= 128.29999542236328  (F12, bin <= 13)  left -> 52, right -> 55
node(11,51,12,13).
left_node(11,51,52).
right_node(11,51,55).
% node 52: Debtor <= 0.5  (F15, bin <= 0)  left -> 53, right -> 54
node(11,52,15,0).
left_node(11,52,53).
right_node(11,52,54).
% node 53 (leaf): class Enrolled (1)
leaf_class(11,53,1).
% node 54 (leaf): class Dropout (0)
leaf_class(11,54,0).
% node 55 (leaf): class Graduate (2)
leaf_class(11,55,2).
% node 56 (leaf): class Dropout (0)
leaf_class(11,56,0).
% node 57: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 58, right -> 63
node(11,57,30,5).
left_node(11,57,58).
right_node(11,57,63).
% node 58: Curricular units 1st sem (credited) <= 1.5  (F21, bin <= 1)  left -> 59, right -> 62
node(11,58,21,1).
left_node(11,58,59).
right_node(11,58,62).
% node 59: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 60, right -> 61
node(11,59,16,0).
left_node(11,59,60).
right_node(11,59,61).
% node 60 (leaf): class Enrolled (1)
leaf_class(11,60,1).
% node 61 (leaf): class Graduate (2)
leaf_class(11,61,2).
% node 62 (leaf): class Dropout (0)
leaf_class(11,62,0).
% node 63: Curricular units 1st sem (credited) <= 0.5  (F21, bin <= 0)  left -> 64, right -> 67
node(11,63,21,0).
left_node(11,63,64).
right_node(11,63,67).
% node 64: Father's occupation <= 106.5  (F11, bin <= 6)  left -> 65, right -> 66
node(11,64,11,6).
left_node(11,64,65).
right_node(11,64,66).
% node 65 (leaf): class Graduate (2)
leaf_class(11,65,2).
% node 66 (leaf): class Graduate (2)
leaf_class(11,66,2).
% node 67: GDP <= 1.7649999856948853  (F35, bin <= 6)  left -> 68, right -> 69
node(11,67,35,6).
left_node(11,67,68).
right_node(11,67,69).
% node 68 (leaf): class Graduate (2)
leaf_class(11,68,2).
% node 69 (leaf): class Graduate (2)
leaf_class(11,69,2).
% node 70: Debtor <= 0.5  (F15, bin <= 0)  left -> 71, right -> 76
node(11,70,15,0).
left_node(11,70,71).
right_node(11,70,76).
% node 71: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 72, right -> 73
node(11,71,24,5).
left_node(11,71,72).
right_node(11,71,73).
% node 72 (leaf): class Dropout (0)
leaf_class(11,72,0).
% node 73: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 74, right -> 75
node(11,73,30,5).
left_node(11,73,74).
right_node(11,73,75).
% node 74 (leaf): class Dropout (0)
leaf_class(11,74,0).
% node 75 (leaf): class Graduate (2)
leaf_class(11,75,2).
% node 76: Course <= 9102.0  (F3, bin <= 5)  left -> 77, right -> 78
node(11,76,3,5).
left_node(11,76,77).
right_node(11,76,78).
% node 77 (leaf): class Graduate (2)
leaf_class(11,77,2).
% node 78 (leaf): class Dropout (0)
leaf_class(11,78,0).

% Tree 12
tree(12).
% node 0: Curricular units 1st sem (grade) <= 10.083333492279053  (F25, bin <= 2)  left -> 1, right -> 16
node(12,0,25,2).
left_node(12,0,1).
right_node(12,0,16).
% node 1: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 2, right -> 11
node(12,1,28,0).
left_node(12,1,2).
right_node(12,1,11).
% node 2: Mother's qualification <= 33.0  (F8, bin <= 8)  left -> 3, right -> 10
node(12,2,8,8).
left_node(12,2,3).
right_node(12,2,10).
% node 3: Unemployment rate <= 14.699999809265137  (F33, bin <= 10)  left -> 4, right -> 9
node(12,3,33,10).
left_node(12,3,4).
right_node(12,3,9).
% node 4: Mother's occupation <= 6.5  (F10, bin <= 5)  left -> 5, right -> 8
node(12,4,10,5).
left_node(12,4,5).
right_node(12,4,8).
% node 5: Admission grade <= 133.0500030517578  (F12, bin <= 20)  left -> 6, right -> 7
node(12,5,12,20).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class Dropout (0)
leaf_class(12,6,0).
% node 7 (leaf): class Graduate (2)
leaf_class(12,7,2).
% node 8 (leaf): class Dropout (0)
leaf_class(12,8,0).
% node 9 (leaf): class Enrolled (1)
leaf_class(12,9,1).
% node 10 (leaf): class Dropout (0)
leaf_class(12,10,0).
% node 11: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 12, right -> 15
node(12,11,30,2).
left_node(12,11,12).
right_node(12,11,15).
% node 12: Application mode <= 43.5  (F1, bin <= 10)  left -> 13, right -> 14
node(12,12,1,10).
left_node(12,12,13).
right_node(12,12,14).
% node 13 (leaf): class Dropout (0)
leaf_class(12,13,0).
% node 14 (leaf): class Dropout (0)
leaf_class(12,14,0).
% node 15 (leaf): class Enrolled (1)
leaf_class(12,15,1).
% node 16: Curricular units 2nd sem (grade) <= 11.343571662902832  (F31, bin <= 26)  left -> 17, right -> 38
node(12,16,31,26).
left_node(12,16,17).
right_node(12,16,38).
% node 17: ﻿Marital status <= 1.5  (F0, bin <= 0)  left -> 18, right -> 37
node(12,17,0,0).
left_node(12,17,18).
right_node(12,17,37).
% node 18: Course <= 9377.0  (F3, bin <= 10)  left -> 19, right -> 28
node(12,18,3,10).
left_node(12,18,19).
right_node(12,18,28).
% node 19: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 20, right -> 21
node(12,19,16,0).
left_node(12,19,20).
right_node(12,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(12,20,0).
% node 21: Course <= 9192.5  (F3, bin <= 8)  left -> 22, right -> 25
node(12,21,3,8).
left_node(12,21,22).
right_node(12,21,25).
% node 22: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 23, right -> 24
node(12,22,31,0).
left_node(12,22,23).
right_node(12,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(12,23,0).
% node 24 (leaf): class Enrolled (1)
leaf_class(12,24,1).
% node 25: Gender <= 0.5  (F17, bin <= 0)  left -> 26, right -> 27
node(12,25,17,0).
left_node(12,25,26).
right_node(12,25,27).
% node 26 (leaf): class Graduate (2)
leaf_class(12,26,2).
% node 27 (leaf): class Enrolled (1)
leaf_class(12,27,1).
% node 28: Application mode <= 4.0  (F1, bin <= 1)  left -> 29, right -> 32
node(12,28,1,1).
left_node(12,28,29).
right_node(12,28,32).
% node 29: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 30, right -> 31
node(12,29,31,0).
left_node(12,29,30).
right_node(12,29,31).
% node 30 (leaf): class Dropout (0)
leaf_class(12,30,0).
% node 31 (leaf): class Enrolled (1)
leaf_class(12,31,1).
% node 32: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 33, right -> 34
node(12,32,16,0).
left_node(12,32,33).
right_node(12,32,34).
% node 33 (leaf): class Dropout (0)
leaf_class(12,33,0).
% node 34: Curricular units 2nd sem (grade) <= 10.472222328186035  (F31, bin <= 12)  left -> 35, right -> 36
node(12,34,31,12).
left_node(12,34,35).
right_node(12,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(12,35,0).
% node 36 (leaf): class Dropout (0)
leaf_class(12,36,0).
% node 37 (leaf): class Dropout (0)
leaf_class(12,37,0).
% node 38: Curricular units 1st sem (grade) <= 12.804166793823242  (F25, bin <= 41)  left -> 39, right -> 52
node(12,38,25,41).
left_node(12,38,39).
right_node(12,38,52).
% node 39: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 40, right -> 47
node(12,39,18,0).
left_node(12,39,40).
right_node(12,39,47).
% node 40: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 41, right -> 42
node(12,40,29,4).
left_node(12,40,41).
right_node(12,40,42).
% node 41 (leaf): class Graduate (2)
leaf_class(12,41,2).
% node 42: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 43, right -> 46
node(12,42,24,5).
left_node(12,42,43).
right_node(12,42,46).
% node 43: Curricular units 1st sem (credited) <= 1.5  (F21, bin <= 1)  left -> 44, right -> 45
node(12,43,21,1).
left_node(12,43,44).
right_node(12,43,45).
% node 44 (leaf): class Enrolled (1)
leaf_class(12,44,1).
% node 45 (leaf): class Dropout (0)
leaf_class(12,45,0).
% node 46 (leaf): class Graduate (2)
leaf_class(12,46,2).
% node 47: Gender <= 0.5  (F17, bin <= 0)  left -> 48, right -> 51
node(12,47,17,0).
left_node(12,47,48).
right_node(12,47,51).
% node 48: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 49, right -> 50
node(12,48,30,4).
left_node(12,48,49).
right_node(12,48,50).
% node 49 (leaf): class Dropout (0)
leaf_class(12,49,0).
% node 50 (leaf): class Graduate (2)
leaf_class(12,50,2).
% node 51 (leaf): class Graduate (2)
leaf_class(12,51,2).
% node 52: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 53, right -> 54
node(12,52,16,0).
left_node(12,52,53).
right_node(12,52,54).
% node 53 (leaf): class Dropout (0)
leaf_class(12,53,0).
% node 54: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 55, right -> 62
node(12,54,27,0).
left_node(12,54,55).
right_node(12,54,62).
% node 55: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 56, right -> 59
node(12,55,24,4).
left_node(12,55,56).
right_node(12,55,59).
% node 56: Unemployment rate <= 8.249999761581421  (F33, bin <= 0)  left -> 57, right -> 58
node(12,56,33,0).
left_node(12,56,57).
right_node(12,56,58).
% node 57 (leaf): class Graduate (2)
leaf_class(12,57,2).
% node 58 (leaf): class Enrolled (1)
leaf_class(12,58,1).
% node 59: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 60, right -> 61
node(12,59,18,0).
left_node(12,59,60).
right_node(12,59,61).
% node 60 (leaf): class Graduate (2)
leaf_class(12,60,2).
% node 61 (leaf): class Graduate (2)
leaf_class(12,61,2).
% node 62: Curricular units 2nd sem (grade) <= 12.236363410949707  (F31, bin <= 43)  left -> 63, right -> 64
node(12,62,31,43).
left_node(12,62,63).
right_node(12,62,64).
% node 63 (leaf): class Enrolled (1)
leaf_class(12,63,1).
% node 64: Unemployment rate <= 10.099999904632568  (F33, bin <= 2)  left -> 65, right -> 66
node(12,64,33,2).
left_node(12,64,65).
right_node(12,64,66).
% node 65 (leaf): class Graduate (2)
leaf_class(12,65,2).
% node 66 (leaf): class Graduate (2)
leaf_class(12,66,2).

% Tree 13
tree(13).
% node 0: Curricular units 2nd sem (grade) <= 11.038461685180664  (F31, bin <= 16)  left -> 1, right -> 22
node(13,0,31,16).
left_node(13,0,1).
right_node(13,0,22).
% node 1: Curricular units 1st sem (approved) <= 2.5  (F24, bin <= 2)  left -> 2, right -> 9
node(13,1,24,2).
left_node(13,1,2).
right_node(13,1,9).
% node 2: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 3, right -> 6
node(13,2,22,0).
left_node(13,2,3).
right_node(13,2,6).
% node 3: Admission grade <= 136.45000457763672  (F12, bin <= 24)  left -> 4, right -> 5
node(13,3,12,24).
left_node(13,3,4).
right_node(13,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(13,4,0).
% node 5 (leaf): class Graduate (2)
leaf_class(13,5,2).
% node 6: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 7, right -> 8
node(13,6,29,4).
left_node(13,6,7).
right_node(13,6,8).
% node 7 (leaf): class Dropout (0)
leaf_class(13,7,0).
% node 8 (leaf): class Dropout (0)
leaf_class(13,8,0).
% node 9: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 10, right -> 13
node(13,9,30,2).
left_node(13,9,10).
right_node(13,9,13).
% node 10: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 11, right -> 12
node(13,10,31,0).
left_node(13,10,11).
right_node(13,10,12).
% node 11 (leaf): class Dropout (0)
leaf_class(13,11,0).
% node 12 (leaf): class Dropout (0)
leaf_class(13,12,0).
% node 13: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 14, right -> 21
node(13,13,22,6).
left_node(13,13,14).
right_node(13,13,21).
% node 14: Previous qualification <= 2.0  (F5, bin <= 1)  left -> 15, right -> 20
node(13,14,5,1).
left_node(13,14,15).
right_node(13,14,20).
% node 15: Application mode <= 28.5  (F1, bin <= 7)  left -> 16, right -> 19
node(13,15,1,7).
left_node(13,15,16).
right_node(13,15,19).
% node 16: Course <= 9246.0  (F3, bin <= 9)  left -> 17, right -> 18
node(13,16,3,9).
left_node(13,16,17).
right_node(13,16,18).
% node 17 (leaf): class Graduate (2)
leaf_class(13,17,2).
% node 18 (leaf): class Enrolled (1)
leaf_class(13,18,1).
% node 19 (leaf): class Dropout (0)
leaf_class(13,19,0).
% node 20 (leaf): class Graduate (2)
leaf_class(13,20,2).
% node 21 (leaf): class Dropout (0)
leaf_class(13,21,0).
% node 22: Curricular units 1st sem (without evaluations) <= 0.5  (F26, bin <= 0)  left -> 23, right -> 60
node(13,22,26,0).
left_node(13,22,23).
right_node(13,22,60).
% node 23: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 24, right -> 43
node(13,23,24,5).
left_node(13,23,24).
right_node(13,23,43).
% node 24: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 25, right -> 30
node(13,24,30,3).
left_node(13,24,25).
right_node(13,24,30).
% node 25: Unemployment rate <= 13.299999713897705  (F33, bin <= 8)  left -> 26, right -> 29
node(13,25,33,8).
left_node(13,25,26).
right_node(13,25,29).
% node 26: Admission grade <= 133.4499969482422  (F12, bin <= 22)  left -> 27, right -> 28
node(13,26,12,22).
left_node(13,26,27).
right_node(13,26,28).
% node 27 (leaf): class Enrolled (1)
leaf_class(13,27,1).
% node 28 (leaf): class Dropout (0)
leaf_class(13,28,0).
% node 29 (leaf): class Dropout (0)
leaf_class(13,29,0).
% node 30: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 31, right -> 36
node(13,30,29,4).
left_node(13,30,31).
right_node(13,30,36).
% node 31: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 32, right -> 33
node(13,31,29,3).
left_node(13,31,32).
right_node(13,31,33).
% node 32 (leaf): class Graduate (2)
leaf_class(13,32,2).
% node 33: Course <= 9922.0  (F3, bin <= 15)  left -> 34, right -> 35
node(13,33,3,15).
left_node(13,33,34).
right_node(13,33,35).
% node 34 (leaf): class Graduate (2)
leaf_class(13,34,2).
% node 35 (leaf): class Enrolled (1)
leaf_class(13,35,1).
% node 36: Course <= 9377.0  (F3, bin <= 10)  left -> 37, right -> 40
node(13,36,3,10).
left_node(13,36,37).
right_node(13,36,40).
% node 37: Previous qualification <= 7.5  (F5, bin <= 4)  left -> 38, right -> 39
node(13,37,5,4).
left_node(13,37,38).
right_node(13,37,39).
% node 38 (leaf): class Graduate (2)
leaf_class(13,38,2).
% node 39 (leaf): class Enrolled (1)
leaf_class(13,39,1).
% node 40: Admission grade <= 141.1999969482422  (F12, bin <= 27)  left -> 41, right -> 42
node(13,40,12,27).
left_node(13,40,41).
right_node(13,40,42).
% node 41 (leaf): class Enrolled (1)
leaf_class(13,41,1).
% node 42 (leaf): class Enrolled (1)
leaf_class(13,42,1).
% node 43: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 44, right -> 57
node(13,43,18,0).
left_node(13,43,44).
right_node(13,43,57).
% node 44: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 45, right -> 50
node(13,44,30,5).
left_node(13,44,45).
right_node(13,44,50).
% node 45: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 46, right -> 49
node(13,45,19,3).
left_node(13,45,46).
right_node(13,45,49).
% node 46: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 47, right -> 48
node(13,46,30,4).
left_node(13,46,47).
right_node(13,46,48).
% node 47 (leaf): class Graduate (2)
leaf_class(13,47,2).
% node 48 (leaf): class Graduate (2)
leaf_class(13,48,2).
% node 49 (leaf): class Enrolled (1)
leaf_class(13,49,1).
% node 50: Curricular units 2nd sem (enrolled) <= 12.5  (F28, bin <= 9)  left -> 51, right -> 54
node(13,50,28,9).
left_node(13,50,51).
right_node(13,50,54).
% node 51: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 52, right -> 53
node(13,51,23,5).
left_node(13,51,52).
right_node(13,51,53).
% node 52 (leaf): class Graduate (2)
leaf_class(13,52,2).
% node 53 (leaf): class Graduate (2)
leaf_class(13,53,2).
% node 54: Unemployment rate <= 14.099999904632568  (F33, bin <= 9)  left -> 55, right -> 56
node(13,54,33,9).
left_node(13,54,55).
right_node(13,54,56).
% node 55 (leaf): class Dropout (0)
leaf_class(13,55,0).
% node 56 (leaf): class Graduate (2)
leaf_class(13,56,2).
% node 57: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 58, right -> 59
node(13,57,30,5).
left_node(13,57,58).
right_node(13,57,59).
% node 58 (leaf): class Graduate (2)
leaf_class(13,58,2).
% node 59 (leaf): class Graduate (2)
leaf_class(13,59,2).
% node 60: Curricular units 1st sem (grade) <= 11.611111164093018  (F25, bin <= 20)  left -> 61, right -> 62
node(13,60,25,20).
left_node(13,60,61).
right_node(13,60,62).
% node 61 (leaf): class Enrolled (1)
leaf_class(13,61,1).
% node 62: Curricular units 2nd sem (credited) <= 5.5  (F27, bin <= 3)  left -> 63, right -> 68
node(13,62,27,3).
left_node(13,62,63).
right_node(13,62,68).
% node 63: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 64, right -> 67
node(13,63,19,4).
left_node(13,63,64).
right_node(13,63,67).
% node 64: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 65, right -> 66
node(13,64,30,4).
left_node(13,64,65).
right_node(13,64,66).
% node 65 (leaf): class Enrolled (1)
leaf_class(13,65,1).
% node 66 (leaf): class Graduate (2)
leaf_class(13,66,2).
% node 67 (leaf): class Dropout (0)
leaf_class(13,67,0).
% node 68 (leaf): class Graduate (2)
leaf_class(13,68,2).

% Tree 14
tree(14).
% node 0: Curricular units 2nd sem (grade) <= 11.105555534362793  (F31, bin <= 18)  left -> 1, right -> 30
node(14,0,31,18).
left_node(14,0,1).
right_node(14,0,30).
% node 1: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 2, right -> 9
node(14,1,28,0).
left_node(14,1,2).
right_node(14,1,9).
% node 2: Mother's qualification <= 31.5  (F8, bin <= 7)  left -> 3, right -> 8
node(14,2,8,7).
left_node(14,2,3).
right_node(14,2,8).
% node 3: Inflation rate <= 1.9999999403953552  (F34, bin <= 6)  left -> 4, right -> 7
node(14,3,34,6).
left_node(14,3,4).
right_node(14,3,7).
% node 4: Admission grade <= 136.20000457763672  (F12, bin <= 23)  left -> 5, right -> 6
node(14,4,12,23).
left_node(14,4,5).
right_node(14,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(14,5,0).
% node 6 (leaf): class Graduate (2)
leaf_class(14,6,2).
% node 7 (leaf): class Enrolled (1)
leaf_class(14,7,1).
% node 8 (leaf): class Dropout (0)
leaf_class(14,8,0).
% node 9: Curricular units 1st sem (approved) <= 2.5  (F24, bin <= 2)  left -> 10, right -> 17
node(14,9,24,2).
left_node(14,9,10).
right_node(14,9,17).
% node 10: Curricular units 2nd sem (grade) <= 10.416666507720947  (F31, bin <= 10)  left -> 11, right -> 14
node(14,10,31,10).
left_node(14,10,11).
right_node(14,10,14).
% node 11: Application mode <= 42.5  (F1, bin <= 9)  left -> 12, right -> 13
node(14,11,1,9).
left_node(14,11,12).
right_node(14,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(14,12,0).
% node 13 (leaf): class Dropout (0)
leaf_class(14,13,0).
% node 14: Previous qualification (grade) <= 135.5  (F6, bin <= 12)  left -> 15, right -> 16
node(14,14,6,12).
left_node(14,14,15).
right_node(14,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(14,15,0).
% node 16 (leaf): class Enrolled (1)
leaf_class(14,16,1).
% node 17: Application mode <= 17.5  (F1, bin <= 5)  left -> 18, right -> 27
node(14,17,1,5).
left_node(14,17,18).
right_node(14,17,27).
% node 18: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 19, right -> 22
node(14,18,29,4).
left_node(14,18,19).
right_node(14,18,22).
% node 19: Course <= 9192.5  (F3, bin <= 8)  left -> 20, right -> 21
node(14,19,3,8).
left_node(14,19,20).
right_node(14,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(14,20,0).
% node 21 (leaf): class Dropout (0)
leaf_class(14,21,0).
% node 22: Curricular units 2nd sem (evaluations) <= 12.5  (F29, bin <= 9)  left -> 23, right -> 26
node(14,22,29,9).
left_node(14,22,23).
right_node(14,22,26).
% node 23: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 24, right -> 25
node(14,23,30,2).
left_node(14,23,24).
right_node(14,23,25).
% node 24 (leaf): class Enrolled (1)
leaf_class(14,24,1).
% node 25 (leaf): class Graduate (2)
leaf_class(14,25,2).
% node 26 (leaf): class Dropout (0)
leaf_class(14,26,0).
% node 27: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 28, right -> 29
node(14,27,19,3).
left_node(14,27,28).
right_node(14,27,29).
% node 28 (leaf): class Dropout (0)
leaf_class(14,28,0).
% node 29 (leaf): class Dropout (0)
leaf_class(14,29,0).
% node 30: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 31, right -> 48
node(14,30,30,4).
left_node(14,30,31).
right_node(14,30,48).
% node 31: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 32, right -> 37
node(14,31,30,3).
left_node(14,31,32).
right_node(14,31,37).
% node 32: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 33, right -> 34
node(14,32,19,4).
left_node(14,32,33).
right_node(14,32,34).
% node 33 (leaf): class Enrolled (1)
leaf_class(14,33,1).
% node 34: Previous qualification (grade) <= 131.5  (F6, bin <= 8)  left -> 35, right -> 36
node(14,34,6,8).
left_node(14,34,35).
right_node(14,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(14,35,0).
% node 36 (leaf): class Dropout (0)
leaf_class(14,36,0).
% node 37: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 38, right -> 39
node(14,37,16,0).
left_node(14,37,38).
right_node(14,37,39).
% node 38 (leaf): class Dropout (0)
leaf_class(14,38,0).
% node 39: Course <= 9077.5  (F3, bin <= 4)  left -> 40, right -> 41
node(14,39,3,4).
left_node(14,39,40).
right_node(14,39,41).
% node 40 (leaf): class Enrolled (1)
leaf_class(14,40,1).
% node 41: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 42, right -> 45
node(14,41,24,3).
left_node(14,41,42).
right_node(14,41,45).
% node 42: Application mode <= 15.5  (F1, bin <= 3)  left -> 43, right -> 44
node(14,42,1,3).
left_node(14,42,43).
right_node(14,42,44).
% node 43 (leaf): class Graduate (2)
leaf_class(14,43,2).
% node 44 (leaf): class Enrolled (1)
leaf_class(14,44,1).
% node 45: Course <= 9813.0  (F3, bin <= 13)  left -> 46, right -> 47
node(14,45,3,13).
left_node(14,45,46).
right_node(14,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(14,46,2).
% node 47 (leaf): class Enrolled (1)
leaf_class(14,47,1).
% node 48: Mother's occupation <= 1.5  (F10, bin <= 1)  left -> 49, right -> 50
node(14,48,10,1).
left_node(14,48,49).
right_node(14,48,50).
% node 49 (leaf): class Graduate (2)
leaf_class(14,49,2).
% node 50: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 51, right -> 58
node(14,50,30,5).
left_node(14,50,51).
right_node(14,50,58).
% node 51: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 52, right -> 57
node(14,51,28,4).
left_node(14,51,52).
right_node(14,51,57).
% node 52: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 53, right -> 54
node(14,52,22,5).
left_node(14,52,53).
right_node(14,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(14,53,2).
% node 54: Application order <= 1.5  (F2, bin <= 0)  left -> 55, right -> 56
node(14,54,2,0).
left_node(14,54,55).
right_node(14,54,56).
% node 55 (leaf): class Graduate (2)
leaf_class(14,55,2).
% node 56 (leaf): class Graduate (2)
leaf_class(14,56,2).
% node 57 (leaf): class Enrolled (1)
leaf_class(14,57,1).
% node 58: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 59, right -> 64
node(14,58,18,0).
left_node(14,58,59).
right_node(14,58,64).
% node 59: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 60, right -> 61
node(14,59,29,6).
left_node(14,59,60).
right_node(14,59,61).
% node 60 (leaf): class Graduate (2)
leaf_class(14,60,2).
% node 61: Course <= 9528.0  (F3, bin <= 11)  left -> 62, right -> 63
node(14,61,3,11).
left_node(14,61,62).
right_node(14,61,63).
% node 62 (leaf): class Graduate (2)
leaf_class(14,62,2).
% node 63 (leaf): class Enrolled (1)
leaf_class(14,63,1).
% node 64 (leaf): class Graduate (2)
leaf_class(14,64,2).

% Tree 15
tree(15).
% node 0: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 1, right -> 54
node(15,0,18,0).
left_node(15,0,1).
right_node(15,0,54).
% node 1: Curricular units 2nd sem (grade) <= 10.354166507720947  (F31, bin <= 8)  left -> 2, right -> 19
node(15,1,31,8).
left_node(15,1,2).
right_node(15,1,19).
% node 2: Age at enrollment <= 18.5  (F19, bin <= 0)  left -> 3, right -> 6
node(15,2,19,0).
left_node(15,2,3).
right_node(15,2,6).
% node 3: Curricular units 2nd sem (enrolled) <= 2.5  (F28, bin <= 2)  left -> 4, right -> 5
node(15,3,28,2).
left_node(15,3,4).
right_node(15,3,5).
% node 4 (leaf): class Graduate (2)
leaf_class(15,4,2).
% node 5 (leaf): class Dropout (0)
leaf_class(15,5,0).
% node 6: Application mode <= 43.5  (F1, bin <= 10)  left -> 7, right -> 18
node(15,6,1,10).
left_node(15,6,7).
right_node(15,6,18).
% node 7: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 8, right -> 13
node(15,7,22,0).
left_node(15,7,8).
right_node(15,7,13).
% node 8: Mother's qualification <= 26.5  (F8, bin <= 5)  left -> 9, right -> 12
node(15,8,8,5).
left_node(15,8,9).
right_node(15,8,12).
% node 9: Admission grade <= 130.6999969482422  (F12, bin <= 17)  left -> 10, right -> 11
node(15,9,12,17).
left_node(15,9,10).
right_node(15,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(15,10,0).
% node 11 (leaf): class Graduate (2)
leaf_class(15,11,2).
% node 12 (leaf): class Dropout (0)
leaf_class(15,12,0).
% node 13: Curricular units 2nd sem (approved) <= 0.5  (F30, bin <= 0)  left -> 14, right -> 15
node(15,13,30,0).
left_node(15,13,14).
right_node(15,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(15,14,0).
% node 15: Course <= 9138.5  (F3, bin <= 7)  left -> 16, right -> 17
node(15,15,3,7).
left_node(15,15,16).
right_node(15,15,17).
% node 16 (leaf): class Enrolled (1)
leaf_class(15,16,1).
% node 17 (leaf): class Dropout (0)
leaf_class(15,17,0).
% node 18 (leaf): class Dropout (0)
leaf_class(15,18,0).
% node 19: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 20, right -> 33
node(15,19,30,4).
left_node(15,19,20).
right_node(15,19,33).
% node 20: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 21, right -> 22
node(15,20,16,0).
left_node(15,20,21).
right_node(15,20,22).
% node 21 (leaf): class Dropout (0)
leaf_class(15,21,0).
% node 22: Application order <= 1.5  (F2, bin <= 0)  left -> 23, right -> 30
node(15,22,2,0).
left_node(15,22,23).
right_node(15,22,30).
% node 23: GDP <= 1.2650000154972076  (F35, bin <= 4)  left -> 24, right -> 27
node(15,23,35,4).
left_node(15,23,24).
right_node(15,23,27).
% node 24: Debtor <= 0.5  (F15, bin <= 0)  left -> 25, right -> 26
node(15,24,15,0).
left_node(15,24,25).
right_node(15,24,26).
% node 25 (leaf): class Enrolled (1)
leaf_class(15,25,1).
% node 26 (leaf): class Dropout (0)
leaf_class(15,26,0).
% node 27: Curricular units 1st sem (evaluations) <= 12.5  (F23, bin <= 8)  left -> 28, right -> 29
node(15,27,23,8).
left_node(15,27,28).
right_node(15,27,29).
% node 28 (leaf): class Enrolled (1)
leaf_class(15,28,1).
% node 29 (leaf): class Dropout (0)
leaf_class(15,29,0).
% node 30: Course <= 9813.0  (F3, bin <= 13)  left -> 31, right -> 32
node(15,30,3,13).
left_node(15,30,31).
right_node(15,30,32).
% node 31 (leaf): class Graduate (2)
leaf_class(15,31,2).
% node 32 (leaf): class Dropout (0)
leaf_class(15,32,0).
% node 33: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 34, right -> 41
node(15,33,23,5).
left_node(15,33,34).
right_node(15,33,41).
% node 34: Application mode <= 16.5  (F1, bin <= 4)  left -> 35, right -> 36
node(15,34,1,4).
left_node(15,34,35).
right_node(15,34,36).
% node 35 (leaf): class Graduate (2)
leaf_class(15,35,2).
% node 36: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 37, right -> 40
node(15,36,28,5).
left_node(15,36,37).
right_node(15,36,40).
% node 37: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 38, right -> 39
node(15,37,24,5).
left_node(15,37,38).
right_node(15,37,39).
% node 38 (leaf): class Graduate (2)
leaf_class(15,38,2).
% node 39 (leaf): class Graduate (2)
leaf_class(15,39,2).
% node 40 (leaf): class Graduate (2)
leaf_class(15,40,2).
% node 41: Curricular units 1st sem (enrolled) <= 7.5  (F22, bin <= 7)  left -> 42, right -> 49
node(15,41,22,7).
left_node(15,41,42).
right_node(15,41,49).
% node 42: Curricular units 1st sem (evaluations) <= 10.5  (F23, bin <= 7)  left -> 43, right -> 46
node(15,42,23,7).
left_node(15,42,43).
right_node(15,42,46).
% node 43: Curricular units 1st sem (grade) <= 12.017857074737549  (F25, bin <= 32)  left -> 44, right -> 45
node(15,43,25,32).
left_node(15,43,44).
right_node(15,43,45).
% node 44 (leaf): class Graduate (2)
leaf_class(15,44,2).
% node 45 (leaf): class Graduate (2)
leaf_class(15,45,2).
% node 46: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 47, right -> 48
node(15,46,22,6).
left_node(15,46,47).
right_node(15,46,48).
% node 47 (leaf): class Graduate (2)
leaf_class(15,47,2).
% node 48 (leaf): class Enrolled (1)
leaf_class(15,48,1).
% node 49: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 50, right -> 51
node(15,49,16,0).
left_node(15,49,50).
right_node(15,49,51).
% node 50 (leaf): class Dropout (0)
leaf_class(15,50,0).
% node 51: Course <= 9721.5  (F3, bin <= 12)  left -> 52, right -> 53
node(15,51,3,12).
left_node(15,51,52).
right_node(15,51,53).
% node 52 (leaf): class Graduate (2)
leaf_class(15,52,2).
% node 53 (leaf): class Graduate (2)
leaf_class(15,53,2).
% node 54: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 55, right -> 62
node(15,54,30,3).
left_node(15,54,55).
right_node(15,54,62).
% node 55: Curricular units 1st sem (enrolled) <= 2.5  (F22, bin <= 3)  left -> 56, right -> 57
node(15,55,22,3).
left_node(15,55,56).
right_node(15,55,57).
% node 56 (leaf): class Graduate (2)
leaf_class(15,56,2).
% node 57: Father's occupation <= 8.5  (F11, bin <= 5)  left -> 58, right -> 59
node(15,57,11,5).
left_node(15,57,58).
right_node(15,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(15,58,0).
% node 59: Mother's qualification <= 28.0  (F8, bin <= 6)  left -> 60, right -> 61
node(15,59,8,6).
left_node(15,59,60).
right_node(15,59,61).
% node 60 (leaf): class Enrolled (1)
leaf_class(15,60,1).
% node 61 (leaf): class Dropout (0)
leaf_class(15,61,0).
% node 62: Father's qualification <= 35.5  (F9, bin <= 6)  left -> 63, right -> 72
node(15,62,9,6).
left_node(15,62,63).
right_node(15,62,72).
% node 63: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 64, right -> 65
node(15,63,24,4).
left_node(15,63,64).
right_node(15,63,65).
% node 64 (leaf): class Enrolled (1)
leaf_class(15,64,1).
% node 65: Inflation rate <= 0.4000000059604645  (F34, bin <= 2)  left -> 66, right -> 67
node(15,65,34,2).
left_node(15,65,66).
right_node(15,65,67).
% node 66 (leaf): class Graduate (2)
leaf_class(15,66,2).
% node 67: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 68, right -> 69
node(15,67,23,5).
left_node(15,67,68).
right_node(15,67,69).
% node 68 (leaf): class Graduate (2)
leaf_class(15,68,2).
% node 69: Application order <= 1.5  (F2, bin <= 0)  left -> 70, right -> 71
node(15,69,2,0).
left_node(15,69,70).
right_node(15,69,71).
% node 70 (leaf): class Graduate (2)
leaf_class(15,70,2).
% node 71 (leaf): class Enrolled (1)
leaf_class(15,71,1).
% node 72: Curricular units 2nd sem (grade) <= 12.845237731933594  (F31, bin <= 50)  left -> 73, right -> 76
node(15,72,31,50).
left_node(15,72,73).
right_node(15,72,76).
% node 73: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 74, right -> 75
node(15,73,30,4).
left_node(15,73,74).
right_node(15,73,75).
% node 74 (leaf): class Enrolled (1)
leaf_class(15,74,1).
% node 75 (leaf): class Graduate (2)
leaf_class(15,75,2).
% node 76 (leaf): class Graduate (2)
leaf_class(15,76,2).

% Tree 16
tree(16).
% node 0: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 1, right -> 40
node(16,0,28,3).
left_node(16,0,1).
right_node(16,0,40).
% node 1: Curricular units 1st sem (grade) <= 11.183333396911621  (F25, bin <= 14)  left -> 2, right -> 25
node(16,1,25,14).
left_node(16,1,2).
right_node(16,1,25).
% node 2: Application mode <= 6.0  (F1, bin <= 2)  left -> 3, right -> 12
node(16,2,1,2).
left_node(16,2,3).
right_node(16,2,12).
% node 3: Curricular units 1st sem (enrolled) <= 2.0  (F22, bin <= 2)  left -> 4, right -> 7
node(16,3,22,2).
left_node(16,3,4).
right_node(16,3,7).
% node 4: Father's qualification <= 37.5  (F9, bin <= 7)  left -> 5, right -> 6
node(16,4,9,7).
left_node(16,4,5).
right_node(16,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(16,5,0).
% node 6 (leaf): class Graduate (2)
leaf_class(16,6,2).
% node 7: Mother's qualification <= 1.5  (F8, bin <= 0)  left -> 8, right -> 9
node(16,7,8,0).
left_node(16,7,8).
right_node(16,7,9).
% node 8 (leaf): class Enrolled (1)
leaf_class(16,8,1).
% node 9: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 10, right -> 11
node(16,9,29,2).
left_node(16,9,10).
right_node(16,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(16,10,0).
% node 11 (leaf): class Enrolled (1)
leaf_class(16,11,1).
% node 12: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 13, right -> 16
node(16,12,22,0).
left_node(16,12,13).
right_node(16,12,16).
% node 13: Previous qualification (grade) <= 141.0  (F6, bin <= 17)  left -> 14, right -> 15
node(16,13,6,17).
left_node(16,13,14).
right_node(16,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(16,14,0).
% node 15 (leaf): class Graduate (2)
leaf_class(16,15,2).
% node 16: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 17, right -> 22
node(16,16,30,3).
left_node(16,16,17).
right_node(16,16,22).
% node 17: Curricular units 2nd sem (approved) <= 0.5  (F30, bin <= 0)  left -> 18, right -> 19
node(16,17,30,0).
left_node(16,17,18).
right_node(16,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(16,18,0).
% node 19: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 20, right -> 21
node(16,19,4,0).
left_node(16,19,20).
right_node(16,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(16,20,0).
% node 21 (leaf): class Dropout (0)
leaf_class(16,21,0).
% node 22: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 23, right -> 24
node(16,22,30,4).
left_node(16,22,23).
right_node(16,22,24).
% node 23 (leaf): class Enrolled (1)
leaf_class(16,23,1).
% node 24 (leaf): class Graduate (2)
leaf_class(16,24,2).
% node 25: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 26, right -> 31
node(16,25,29,3).
left_node(16,25,26).
right_node(16,25,31).
% node 26: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 27, right -> 28
node(16,26,19,3).
left_node(16,26,27).
right_node(16,26,28).
% node 27 (leaf): class Graduate (2)
leaf_class(16,27,2).
% node 28: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 29, right -> 30
node(16,28,30,4).
left_node(16,28,29).
right_node(16,28,30).
% node 29 (leaf): class Dropout (0)
leaf_class(16,29,0).
% node 30 (leaf): class Graduate (2)
leaf_class(16,30,2).
% node 31: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 32, right -> 33
node(16,31,16,0).
left_node(16,31,32).
right_node(16,31,33).
% node 32 (leaf): class Dropout (0)
leaf_class(16,32,0).
% node 33: Curricular units 2nd sem (grade) <= 11.125  (F31, bin <= 19)  left -> 34, right -> 35
node(16,33,31,19).
left_node(16,33,34).
right_node(16,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(16,34,1).
% node 35: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 36, right -> 39
node(16,35,18,0).
left_node(16,35,36).
right_node(16,35,39).
% node 36: Curricular units 2nd sem (grade) <= 12.775000095367432  (F31, bin <= 49)  left -> 37, right -> 38
node(16,36,31,49).
left_node(16,36,37).
right_node(16,36,38).
% node 37 (leaf): class Enrolled (1)
leaf_class(16,37,1).
% node 38 (leaf): class Graduate (2)
leaf_class(16,38,2).
% node 39 (leaf): class Graduate (2)
leaf_class(16,39,2).
% node 40: Application mode <= 6.0  (F1, bin <= 2)  left -> 41, right -> 62
node(16,40,1,2).
left_node(16,40,41).
right_node(16,40,62).
% node 41: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 42, right -> 53
node(16,41,24,5).
left_node(16,41,42).
right_node(16,41,53).
% node 42: Curricular units 2nd sem (grade) <= 10.690476417541504  (F31, bin <= 13)  left -> 43, right -> 48
node(16,42,31,13).
left_node(16,42,43).
right_node(16,42,48).
% node 43: Curricular units 1st sem (grade) <= 10.550000190734863  (F25, bin <= 8)  left -> 44, right -> 45
node(16,43,25,8).
left_node(16,43,44).
right_node(16,43,45).
% node 44 (leaf): class Dropout (0)
leaf_class(16,44,0).
% node 45: Admission grade <= 122.14999771118164  (F12, bin <= 5)  left -> 46, right -> 47
node(16,45,12,5).
left_node(16,45,46).
right_node(16,45,47).
% node 46 (leaf): class Enrolled (1)
leaf_class(16,46,1).
% node 47 (leaf): class Dropout (0)
leaf_class(16,47,0).
% node 48: Mother's occupation <= 8.5  (F10, bin <= 7)  left -> 49, right -> 52
node(16,48,10,7).
left_node(16,48,49).
right_node(16,48,52).
% node 49: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 50, right -> 51
node(16,49,29,5).
left_node(16,49,50).
right_node(16,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(16,50,2).
% node 51 (leaf): class Enrolled (1)
leaf_class(16,51,1).
% node 52 (leaf): class Graduate (2)
leaf_class(16,52,2).
% node 53: Curricular units 1st sem (approved) <= 10.0  (F24, bin <= 7)  left -> 54, right -> 61
node(16,53,24,7).
left_node(16,53,54).
right_node(16,53,61).
% node 54: Debtor <= 0.5  (F15, bin <= 0)  left -> 55, right -> 60
node(16,54,15,0).
left_node(16,54,55).
right_node(16,54,60).
% node 55: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 56, right -> 57
node(16,55,29,6).
left_node(16,55,56).
right_node(16,55,57).
% node 56 (leaf): class Graduate (2)
leaf_class(16,56,2).
% node 57: Curricular units 1st sem (enrolled) <= 6.5  (F22, bin <= 6)  left -> 58, right -> 59
node(16,57,22,6).
left_node(16,57,58).
right_node(16,57,59).
% node 58 (leaf): class Enrolled (1)
leaf_class(16,58,1).
% node 59 (leaf): class Graduate (2)
leaf_class(16,59,2).
% node 60 (leaf): class Graduate (2)
leaf_class(16,60,2).
% node 61 (leaf): class Dropout (0)
leaf_class(16,61,0).
% node 62: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 63, right -> 70
node(16,62,24,4).
left_node(16,62,63).
right_node(16,62,70).
% node 63: Curricular units 2nd sem (grade) <= 10.224999904632568  (F31, bin <= 5)  left -> 64, right -> 65
node(16,63,31,5).
left_node(16,63,64).
right_node(16,63,65).
% node 64 (leaf): class Dropout (0)
leaf_class(16,64,0).
% node 65: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 66, right -> 67
node(16,65,30,3).
left_node(16,65,66).
right_node(16,65,67).
% node 66 (leaf): class Dropout (0)
leaf_class(16,66,0).
% node 67: GDP <= -3.5899999141693115  (F35, bin <= 0)  left -> 68, right -> 69
node(16,67,35,0).
left_node(16,67,68).
right_node(16,67,69).
% node 68 (leaf): class Dropout (0)
leaf_class(16,68,0).
% node 69 (leaf): class Enrolled (1)
leaf_class(16,69,1).
% node 70: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 71, right -> 80
node(16,70,29,6).
left_node(16,70,71).
right_node(16,70,80).
% node 71: Curricular units 1st sem (grade) <= 12.267857074737549  (F25, bin <= 38)  left -> 72, right -> 77
node(16,71,25,38).
left_node(16,71,72).
right_node(16,71,77).
% node 72: Admission grade <= 132.70000457763672  (F12, bin <= 19)  left -> 73, right -> 76
node(16,72,12,19).
left_node(16,72,73).
right_node(16,72,76).
% node 73: Curricular units 1st sem (grade) <= 11.387499809265137  (F25, bin <= 15)  left -> 74, right -> 75
node(16,73,25,15).
left_node(16,73,74).
right_node(16,73,75).
% node 74 (leaf): class Graduate (2)
leaf_class(16,74,2).
% node 75 (leaf): class Graduate (2)
leaf_class(16,75,2).
% node 76 (leaf): class Dropout (0)
leaf_class(16,76,0).
% node 77: Father's qualification <= 3.5  (F9, bin <= 1)  left -> 78, right -> 79
node(16,77,9,1).
left_node(16,77,78).
right_node(16,77,79).
% node 78 (leaf): class Graduate (2)
leaf_class(16,78,2).
% node 79 (leaf): class Graduate (2)
leaf_class(16,79,2).
% node 80: Curricular units 1st sem (grade) <= 11.585714340209961  (F25, bin <= 19)  left -> 81, right -> 82
node(16,80,25,19).
left_node(16,80,81).
right_node(16,80,82).
% node 81 (leaf): class Enrolled (1)
leaf_class(16,81,1).
% node 82: Course <= 9721.5  (F3, bin <= 12)  left -> 83, right -> 86
node(16,82,3,12).
left_node(16,82,83).
right_node(16,82,86).
% node 83: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 84, right -> 85
node(16,83,30,4).
left_node(16,83,84).
right_node(16,83,85).
% node 84 (leaf): class Enrolled (1)
leaf_class(16,84,1).
% node 85 (leaf): class Graduate (2)
leaf_class(16,85,2).
% node 86 (leaf): class Dropout (0)
leaf_class(16,86,0).

% Tree 17
tree(17).
% node 0: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 1, right -> 40
node(17,0,24,4).
left_node(17,0,1).
right_node(17,0,40).
% node 1: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 2, right -> 17
node(17,1,30,2).
left_node(17,1,2).
right_node(17,1,17).
% node 2: Previous qualification (grade) <= 140.9000015258789  (F6, bin <= 16)  left -> 3, right -> 12
node(17,2,6,16).
left_node(17,2,3).
right_node(17,2,12).
% node 3: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 4, right -> 5
node(17,3,28,0).
left_node(17,3,4).
right_node(17,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(17,4,0).
% node 5: Curricular units 1st sem (approved) <= 0.5  (F24, bin <= 0)  left -> 6, right -> 7
node(17,5,24,0).
left_node(17,5,6).
right_node(17,5,7).
% node 6 (leaf): class Dropout (0)
leaf_class(17,6,0).
% node 7: Displaced <= 0.5  (F13, bin <= 0)  left -> 8, right -> 9
node(17,7,13,0).
left_node(17,7,8).
right_node(17,7,9).
% node 8 (leaf): class Dropout (0)
leaf_class(17,8,0).
% node 9: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 10, right -> 11
node(17,9,16,0).
left_node(17,9,10).
right_node(17,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(17,10,0).
% node 11 (leaf): class Dropout (0)
leaf_class(17,11,0).
% node 12: Course <= 4092.5  (F3, bin <= 0)  left -> 13, right -> 14
node(17,12,3,0).
left_node(17,12,13).
right_node(17,12,14).
% node 13 (leaf): class Graduate (2)
leaf_class(17,13,2).
% node 14: Curricular units 2nd sem (grade) <= 10.25  (F31, bin <= 6)  left -> 15, right -> 16
node(17,14,31,6).
left_node(17,14,15).
right_node(17,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(17,15,0).
% node 16 (leaf): class Enrolled (1)
leaf_class(17,16,1).
% node 17: Curricular units 2nd sem (evaluations) <= 10.5  (F29, bin <= 7)  left -> 18, right -> 33
node(17,17,29,7).
left_node(17,17,18).
right_node(17,17,33).
% node 18: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 19, right -> 26
node(17,18,30,4).
left_node(17,18,19).
right_node(17,18,26).
% node 19: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 20, right -> 21
node(17,19,16,0).
left_node(17,19,20).
right_node(17,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(17,20,0).
% node 21: Age at enrollment <= 19.5  (F19, bin <= 1)  left -> 22, right -> 23
node(17,21,19,1).
left_node(17,21,22).
right_node(17,21,23).
% node 22 (leaf): class Enrolled (1)
leaf_class(17,22,1).
% node 23: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 24, right -> 25
node(17,23,28,3).
left_node(17,23,24).
right_node(17,23,25).
% node 24 (leaf): class Enrolled (1)
leaf_class(17,24,1).
% node 25 (leaf): class Dropout (0)
leaf_class(17,25,0).
% node 26: Inflation rate <= 0.0  (F34, bin <= 1)  left -> 27, right -> 28
node(17,26,34,1).
left_node(17,26,27).
right_node(17,26,28).
% node 27 (leaf): class Enrolled (1)
leaf_class(17,27,1).
% node 28: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 29, right -> 32
node(17,28,19,3).
left_node(17,28,29).
right_node(17,28,32).
% node 29: Curricular units 2nd sem (grade) <= 11.700000286102295  (F31, bin <= 35)  left -> 30, right -> 31
node(17,29,31,35).
left_node(17,29,30).
right_node(17,29,31).
% node 30 (leaf): class Enrolled (1)
leaf_class(17,30,1).
% node 31 (leaf): class Graduate (2)
leaf_class(17,31,2).
% node 32 (leaf): class Dropout (0)
leaf_class(17,32,0).
% node 33: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 34, right -> 39
node(17,33,27,0).
left_node(17,33,34).
right_node(17,33,39).
% node 34: Curricular units 2nd sem (grade) <= 12.099999904632568  (F31, bin <= 41)  left -> 35, right -> 38
node(17,34,31,41).
left_node(17,34,35).
right_node(17,34,38).
% node 35: Course <= 9246.0  (F3, bin <= 9)  left -> 36, right -> 37
node(17,35,3,9).
left_node(17,35,36).
right_node(17,35,37).
% node 36 (leaf): class Enrolled (1)
leaf_class(17,36,1).
% node 37 (leaf): class Dropout (0)
leaf_class(17,37,0).
% node 38 (leaf): class Enrolled (1)
leaf_class(17,38,1).
% node 39 (leaf): class Dropout (0)
leaf_class(17,39,0).
% node 40: Gender <= 0.5  (F17, bin <= 0)  left -> 41, right -> 70
node(17,40,17,0).
left_node(17,40,41).
right_node(17,40,70).
% node 41: Curricular units 2nd sem (grade) <= 11.774602890014648  (F31, bin <= 36)  left -> 42, right -> 53
node(17,41,31,36).
left_node(17,41,42).
right_node(17,41,53).
% node 42: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 43, right -> 44
node(17,42,30,3).
left_node(17,42,43).
right_node(17,42,44).
% node 43 (leaf): class Dropout (0)
leaf_class(17,43,0).
% node 44: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 45, right -> 46
node(17,44,16,0).
left_node(17,44,45).
right_node(17,44,46).
% node 45 (leaf): class Dropout (0)
leaf_class(17,45,0).
% node 46: Mother's qualification <= 26.5  (F8, bin <= 5)  left -> 47, right -> 50
node(17,46,8,5).
left_node(17,46,47).
right_node(17,46,50).
% node 47: Curricular units 1st sem (grade) <= 11.154762268066406  (F25, bin <= 13)  left -> 48, right -> 49
node(17,47,25,13).
left_node(17,47,48).
right_node(17,47,49).
% node 48 (leaf): class Graduate (2)
leaf_class(17,48,2).
% node 49 (leaf): class Enrolled (1)
leaf_class(17,49,1).
% node 50: Curricular units 1st sem (grade) <= 11.916666507720947  (F25, bin <= 28)  left -> 51, right -> 52
node(17,50,25,28).
left_node(17,50,51).
right_node(17,50,52).
% node 51 (leaf): class Graduate (2)
leaf_class(17,51,2).
% node 52 (leaf): class Dropout (0)
leaf_class(17,52,0).
% node 53: Age at enrollment <= 23.5  (F19, bin <= 5)  left -> 54, right -> 63
node(17,53,19,5).
left_node(17,53,54).
right_node(17,53,63).
% node 54: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 55, right -> 58
node(17,54,23,5).
left_node(17,54,55).
right_node(17,54,58).
% node 55: Course <= 9528.0  (F3, bin <= 11)  left -> 56, right -> 57
node(17,55,3,11).
left_node(17,55,56).
right_node(17,55,57).
% node 56 (leaf): class Graduate (2)
leaf_class(17,56,2).
% node 57 (leaf): class Graduate (2)
leaf_class(17,57,2).
% node 58: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 59, right -> 62
node(17,58,24,5).
left_node(17,58,59).
right_node(17,58,62).
% node 59: Mother's qualification <= 7.5  (F8, bin <= 4)  left -> 60, right -> 61
node(17,59,8,4).
left_node(17,59,60).
right_node(17,59,61).
% node 60 (leaf): class Enrolled (1)
leaf_class(17,60,1).
% node 61 (leaf): class Graduate (2)
leaf_class(17,61,2).
% node 62 (leaf): class Graduate (2)
leaf_class(17,62,2).
% node 63: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 64, right -> 67
node(17,63,30,5).
left_node(17,63,64).
right_node(17,63,67).
% node 64: Course <= 9922.0  (F3, bin <= 15)  left -> 65, right -> 66
node(17,64,3,15).
left_node(17,64,65).
right_node(17,64,66).
% node 65 (leaf): class Dropout (0)
leaf_class(17,65,0).
% node 66 (leaf): class Graduate (2)
leaf_class(17,66,2).
% node 67: Curricular units 2nd sem (enrolled) <= 8.5  (F28, bin <= 6)  left -> 68, right -> 69
node(17,67,28,6).
left_node(17,67,68).
right_node(17,67,69).
% node 68 (leaf): class Graduate (2)
leaf_class(17,68,2).
% node 69 (leaf): class Graduate (2)
leaf_class(17,69,2).
% node 70: Debtor <= 0.5  (F15, bin <= 0)  left -> 71, right -> 84
node(17,70,15,0).
left_node(17,70,71).
right_node(17,70,84).
% node 71: Curricular units 1st sem (grade) <= 11.835416316986084  (F25, bin <= 25)  left -> 72, right -> 75
node(17,71,25,25).
left_node(17,71,72).
right_node(17,71,75).
% node 72: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 73, right -> 74
node(17,72,30,4).
left_node(17,72,73).
right_node(17,72,74).
% node 73 (leaf): class Enrolled (1)
leaf_class(17,73,1).
% node 74 (leaf): class Graduate (2)
leaf_class(17,74,2).
% node 75: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 76, right -> 81
node(17,75,24,5).
left_node(17,75,76).
right_node(17,75,81).
% node 76: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 77, right -> 80
node(17,76,28,4).
left_node(17,76,77).
right_node(17,76,80).
% node 77: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 78, right -> 79
node(17,77,23,2).
left_node(17,77,78).
right_node(17,77,79).
% node 78 (leaf): class Graduate (2)
leaf_class(17,78,2).
% node 79 (leaf): class Graduate (2)
leaf_class(17,79,2).
% node 80 (leaf): class Dropout (0)
leaf_class(17,80,0).
% node 81: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 82, right -> 83
node(17,81,29,6).
left_node(17,81,82).
right_node(17,81,83).
% node 82 (leaf): class Graduate (2)
leaf_class(17,82,2).
% node 83 (leaf): class Graduate (2)
leaf_class(17,83,2).
% node 84 (leaf): class Dropout (0)
leaf_class(17,84,0).

% Tree 18
tree(18).
% node 0: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 1, right -> 34
node(18,0,28,3).
left_node(18,0,1).
right_node(18,0,34).
% node 1: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 2, right -> 15
node(18,1,29,2).
left_node(18,1,2).
right_node(18,1,15).
% node 2: Application mode <= 17.5  (F1, bin <= 5)  left -> 3, right -> 10
node(18,2,1,5).
left_node(18,2,3).
right_node(18,2,10).
% node 3: Curricular units 1st sem (grade) <= 10.375  (F25, bin <= 5)  left -> 4, right -> 9
node(18,3,25,5).
left_node(18,3,4).
right_node(18,3,9).
% node 4: Course <= 4645.0  (F3, bin <= 1)  left -> 5, right -> 8
node(18,4,3,1).
left_node(18,4,5).
right_node(18,4,8).
% node 5: Previous qualification (grade) <= 134.5  (F6, bin <= 11)  left -> 6, right -> 7
node(18,5,6,11).
left_node(18,5,6).
right_node(18,5,7).
% node 6 (leaf): class Dropout (0)
leaf_class(18,6,0).
% node 7 (leaf): class Graduate (2)
leaf_class(18,7,2).
% node 8 (leaf): class Dropout (0)
leaf_class(18,8,0).
% node 9 (leaf): class Graduate (2)
leaf_class(18,9,2).
% node 10: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 11, right -> 12
node(18,10,16,0).
left_node(18,10,11).
right_node(18,10,12).
% node 11 (leaf): class Dropout (0)
leaf_class(18,11,0).
% node 12: Curricular units 2nd sem (grade) <= 10.699999809265137  (F31, bin <= 14)  left -> 13, right -> 14
node(18,12,31,14).
left_node(18,12,13).
right_node(18,12,14).
% node 13 (leaf): class Dropout (0)
leaf_class(18,13,0).
% node 14 (leaf): class Graduate (2)
leaf_class(18,14,2).
% node 15: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 16, right -> 25
node(18,15,29,5).
left_node(18,15,16).
right_node(18,15,25).
% node 16: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 17, right -> 18
node(18,16,31,0).
left_node(18,16,17).
right_node(18,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(18,17,0).
% node 18: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 19, right -> 22
node(18,18,30,3).
left_node(18,18,19).
right_node(18,18,22).
% node 19: Age at enrollment <= 20.5  (F19, bin <= 2)  left -> 20, right -> 21
node(18,19,19,2).
left_node(18,19,20).
right_node(18,19,21).
% node 20 (leaf): class Enrolled (1)
leaf_class(18,20,1).
% node 21 (leaf): class Dropout (0)
leaf_class(18,21,0).
% node 22: Curricular units 1st sem (evaluations) <= 6.5  (F23, bin <= 3)  left -> 23, right -> 24
node(18,22,23,3).
left_node(18,22,23).
right_node(18,22,24).
% node 23 (leaf): class Graduate (2)
leaf_class(18,23,2).
% node 24 (leaf): class Graduate (2)
leaf_class(18,24,2).
% node 25: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 26, right -> 27
node(18,25,31,0).
left_node(18,25,26).
right_node(18,25,27).
% node 26 (leaf): class Dropout (0)
leaf_class(18,26,0).
% node 27: Curricular units 1st sem (evaluations) <= 6.5  (F23, bin <= 3)  left -> 28, right -> 29
node(18,27,23,3).
left_node(18,27,28).
right_node(18,27,29).
% node 28 (leaf): class Enrolled (1)
leaf_class(18,28,1).
% node 29: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 30, right -> 33
node(18,29,30,3).
left_node(18,29,30).
right_node(18,29,33).
% node 30: Unemployment rate <= 8.249999761581421  (F33, bin <= 0)  left -> 31, right -> 32
node(18,30,33,0).
left_node(18,30,31).
right_node(18,30,32).
% node 31 (leaf): class Enrolled (1)
leaf_class(18,31,1).
% node 32 (leaf): class Dropout (0)
leaf_class(18,32,0).
% node 33 (leaf): class Graduate (2)
leaf_class(18,33,2).
% node 34: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 35, right -> 46
node(18,34,30,4).
left_node(18,34,35).
right_node(18,34,46).
% node 35: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 36, right -> 37
node(18,35,30,1).
left_node(18,35,36).
right_node(18,35,37).
% node 36 (leaf): class Dropout (0)
leaf_class(18,36,0).
% node 37: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 38, right -> 41
node(18,37,16,0).
left_node(18,37,38).
right_node(18,37,41).
% node 38: Inflation rate <= 0.0  (F34, bin <= 1)  left -> 39, right -> 40
node(18,38,34,1).
left_node(18,38,39).
right_node(18,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(18,39,0).
% node 40 (leaf): class Dropout (0)
leaf_class(18,40,0).
% node 41: Course <= 9813.0  (F3, bin <= 13)  left -> 42, right -> 45
node(18,41,3,13).
left_node(18,41,42).
right_node(18,41,45).
% node 42: Age at enrollment <= 23.5  (F19, bin <= 5)  left -> 43, right -> 44
node(18,42,19,5).
left_node(18,42,43).
right_node(18,42,44).
% node 43 (leaf): class Enrolled (1)
leaf_class(18,43,1).
% node 44 (leaf): class Dropout (0)
leaf_class(18,44,0).
% node 45 (leaf): class Dropout (0)
leaf_class(18,45,0).
% node 46: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 47, right -> 62
node(18,46,27,0).
left_node(18,46,47).
right_node(18,46,62).
% node 47: Curricular units 2nd sem (evaluations) <= 8.5  (F29, bin <= 5)  left -> 48, right -> 55
node(18,47,29,5).
left_node(18,47,48).
right_node(18,47,55).
% node 48: Application mode <= 42.5  (F1, bin <= 9)  left -> 49, right -> 52
node(18,48,1,9).
left_node(18,48,49).
right_node(18,48,52).
% node 49: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 50, right -> 51
node(18,49,30,5).
left_node(18,49,50).
right_node(18,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(18,50,2).
% node 51 (leaf): class Graduate (2)
leaf_class(18,51,2).
% node 52: Previous qualification <= 3.5  (F5, bin <= 3)  left -> 53, right -> 54
node(18,52,5,3).
left_node(18,52,53).
right_node(18,52,54).
% node 53 (leaf): class Enrolled (1)
leaf_class(18,53,1).
% node 54 (leaf): class Graduate (2)
leaf_class(18,54,2).
% node 55: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 56, right -> 61
node(18,55,24,5).
left_node(18,55,56).
right_node(18,55,61).
% node 56: Father's qualification <= 37.5  (F9, bin <= 7)  left -> 57, right -> 60
node(18,56,9,7).
left_node(18,56,57).
right_node(18,56,60).
% node 57: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 58, right -> 59
node(18,57,23,5).
left_node(18,57,58).
right_node(18,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(18,58,0).
% node 59 (leaf): class Enrolled (1)
leaf_class(18,59,1).
% node 60 (leaf): class Graduate (2)
leaf_class(18,60,2).
% node 61 (leaf): class Graduate (2)
leaf_class(18,61,2).
% node 62: Gender <= 0.5  (F17, bin <= 0)  left -> 63, right -> 68
node(18,62,17,0).
left_node(18,62,63).
right_node(18,62,68).
% node 63: Admission grade <= 118.1500015258789  (F12, bin <= 4)  left -> 64, right -> 67
node(18,63,12,4).
left_node(18,63,64).
right_node(18,63,67).
% node 64: Curricular units 2nd sem (evaluations) <= 11.5  (F29, bin <= 8)  left -> 65, right -> 66
node(18,64,29,8).
left_node(18,64,65).
right_node(18,64,66).
% node 65 (leaf): class Graduate (2)
leaf_class(18,65,2).
% node 66 (leaf): class Enrolled (1)
leaf_class(18,66,1).
% node 67 (leaf): class Graduate (2)
leaf_class(18,67,2).
% node 68: Curricular units 2nd sem (approved) <= 6.5  (F30, bin <= 6)  left -> 69, right -> 70
node(18,68,30,6).
left_node(18,68,69).
right_node(18,68,70).
% node 69 (leaf): class Dropout (0)
leaf_class(18,69,0).
% node 70: Mother's qualification <= 35.5  (F8, bin <= 10)  left -> 71, right -> 72
node(18,70,8,10).
left_node(18,70,71).
right_node(18,70,72).
% node 71 (leaf): class Graduate (2)
leaf_class(18,71,2).
% node 72 (leaf): class Dropout (0)
leaf_class(18,72,0).

% Tree 19
tree(19).
% node 0: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 1, right -> 24
node(19,0,30,3).
left_node(19,0,1).
right_node(19,0,24).
% node 1: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 2, right -> 5
node(19,1,22,0).
left_node(19,1,2).
right_node(19,1,5).
% node 2: Mother's qualification <= 28.0  (F8, bin <= 6)  left -> 3, right -> 4
node(19,2,8,6).
left_node(19,2,3).
right_node(19,2,4).
% node 3 (leaf): class Dropout (0)
leaf_class(19,3,0).
% node 4 (leaf): class Dropout (0)
leaf_class(19,4,0).
% node 5: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 6, right -> 21
node(19,5,19,4).
left_node(19,5,6).
right_node(19,5,21).
% node 6: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 7, right -> 14
node(19,6,28,3).
left_node(19,6,7).
right_node(19,6,14).
% node 7: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 8, right -> 9
node(19,7,30,1).
left_node(19,7,8).
right_node(19,7,9).
% node 8 (leaf): class Dropout (0)
leaf_class(19,8,0).
% node 9: Father's qualification <= 26.5  (F9, bin <= 4)  left -> 10, right -> 13
node(19,9,9,4).
left_node(19,9,10).
right_node(19,9,13).
% node 10: Application order <= 1.5  (F2, bin <= 0)  left -> 11, right -> 12
node(19,10,2,0).
left_node(19,10,11).
right_node(19,10,12).
% node 11 (leaf): class Enrolled (1)
leaf_class(19,11,1).
% node 12 (leaf): class Dropout (0)
leaf_class(19,12,0).
% node 13 (leaf): class Enrolled (1)
leaf_class(19,13,1).
% node 14: Curricular units 1st sem (grade) <= 5.0  (F25, bin <= 0)  left -> 15, right -> 16
node(19,14,25,0).
left_node(19,14,15).
right_node(19,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(19,15,0).
% node 16: Previous qualification (grade) <= 120.5  (F6, bin <= 1)  left -> 17, right -> 18
node(19,16,6,1).
left_node(19,16,17).
right_node(19,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(19,17,0).
% node 18: Admission grade <= 141.1999969482422  (F12, bin <= 27)  left -> 19, right -> 20
node(19,18,12,27).
left_node(19,18,19).
right_node(19,18,20).
% node 19 (leaf): class Dropout (0)
leaf_class(19,19,0).
% node 20 (leaf): class Dropout (0)
leaf_class(19,20,0).
% node 21: Mother's occupation <= 94.5  (F10, bin <= 9)  left -> 22, right -> 23
node(19,21,10,9).
left_node(19,21,22).
right_node(19,21,23).
% node 22 (leaf): class Dropout (0)
leaf_class(19,22,0).
% node 23 (leaf): class Enrolled (1)
leaf_class(19,23,1).
% node 24: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 25, right -> 56
node(19,24,18,0).
left_node(19,24,25).
right_node(19,24,56).
% node 25: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 26, right -> 45
node(19,25,24,5).
left_node(19,25,26).
right_node(19,25,45).
% node 26: Debtor <= 0.5  (F15, bin <= 0)  left -> 27, right -> 40
node(19,26,15,0).
left_node(19,26,27).
right_node(19,26,40).
% node 27: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 28, right -> 35
node(19,27,22,5).
left_node(19,27,28).
right_node(19,27,35).
% node 28: Curricular units 1st sem (grade) <= 11.183333396911621  (F25, bin <= 14)  left -> 29, right -> 32
node(19,28,25,14).
left_node(19,28,29).
right_node(19,28,32).
% node 29: Curricular units 2nd sem (grade) <= 11.550000190734863  (F31, bin <= 33)  left -> 30, right -> 31
node(19,29,31,33).
left_node(19,29,30).
right_node(19,29,31).
% node 30 (leaf): class Enrolled (1)
leaf_class(19,30,1).
% node 31 (leaf): class Graduate (2)
leaf_class(19,31,2).
% node 32: Curricular units 1st sem (evaluations) <= 10.5  (F23, bin <= 7)  left -> 33, right -> 34
node(19,32,23,7).
left_node(19,32,33).
right_node(19,32,34).
% node 33 (leaf): class Graduate (2)
leaf_class(19,33,2).
% node 34 (leaf): class Graduate (2)
leaf_class(19,34,2).
% node 35: Curricular units 1st sem (evaluations) <= 10.5  (F23, bin <= 7)  left -> 36, right -> 39
node(19,35,23,7).
left_node(19,35,36).
right_node(19,35,39).
% node 36: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 37, right -> 38
node(19,36,28,4).
left_node(19,36,37).
right_node(19,36,38).
% node 37 (leaf): class Graduate (2)
leaf_class(19,37,2).
% node 38 (leaf): class Enrolled (1)
leaf_class(19,38,1).
% node 39 (leaf): class Enrolled (1)
leaf_class(19,39,1).
% node 40: Curricular units 2nd sem (grade) <= 12.65500020980835  (F31, bin <= 47)  left -> 41, right -> 44
node(19,40,31,47).
left_node(19,40,41).
right_node(19,40,44).
% node 41: Admission grade <= 129.1999969482422  (F12, bin <= 14)  left -> 42, right -> 43
node(19,41,12,14).
left_node(19,41,42).
right_node(19,41,43).
% node 42 (leaf): class Dropout (0)
leaf_class(19,42,0).
% node 43 (leaf): class Dropout (0)
leaf_class(19,43,0).
% node 44 (leaf): class Enrolled (1)
leaf_class(19,44,1).
% node 45: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 46, right -> 47
node(19,45,23,5).
left_node(19,45,46).
right_node(19,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(19,46,2).
% node 47: Admission grade <= 104.5  (F12, bin <= 0)  left -> 48, right -> 51
node(19,47,12,0).
left_node(19,47,48).
right_node(19,47,51).
% node 48: Curricular units 2nd sem (evaluations) <= 11.5  (F29, bin <= 8)  left -> 49, right -> 50
node(19,48,29,8).
left_node(19,48,49).
right_node(19,48,50).
% node 49 (leaf): class Graduate (2)
leaf_class(19,49,2).
% node 50 (leaf): class Enrolled (1)
leaf_class(19,50,1).
% node 51: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 52, right -> 53
node(19,51,29,6).
left_node(19,51,52).
right_node(19,51,53).
% node 52 (leaf): class Graduate (2)
leaf_class(19,52,2).
% node 53: Curricular units 1st sem (grade) <= 11.883116722106934  (F25, bin <= 27)  left -> 54, right -> 55
node(19,53,25,27).
left_node(19,53,54).
right_node(19,53,55).
% node 54 (leaf): class Graduate (2)
leaf_class(19,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(19,55,2).
% node 56: Curricular units 2nd sem (grade) <= 11.449999809265137  (F31, bin <= 32)  left -> 57, right -> 60
node(19,56,31,32).
left_node(19,56,57).
right_node(19,56,60).
% node 57: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 58, right -> 59
node(19,57,23,4).
left_node(19,57,58).
right_node(19,57,59).
% node 58 (leaf): class Graduate (2)
leaf_class(19,58,2).
% node 59 (leaf): class Graduate (2)
leaf_class(19,59,2).
% node 60: Mother's occupation <= 111.0  (F10, bin <= 10)  left -> 61, right -> 64
node(19,60,10,10).
left_node(19,60,61).
right_node(19,60,64).
% node 61: Course <= 9813.0  (F3, bin <= 13)  left -> 62, right -> 63
node(19,61,3,13).
left_node(19,61,62).
right_node(19,61,63).
% node 62 (leaf): class Graduate (2)
leaf_class(19,62,2).
% node 63 (leaf): class Graduate (2)
leaf_class(19,63,2).
% node 64 (leaf): class Graduate (2)
leaf_class(19,64,2).

% Tree 20
tree(20).
% node 0: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 1, right -> 26
node(20,0,24,4).
left_node(20,0,1).
right_node(20,0,26).
% node 1: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 2, right -> 9
node(20,1,29,2).
left_node(20,1,2).
right_node(20,1,9).
% node 2: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 3, right -> 8
node(20,2,30,3).
left_node(20,2,3).
right_node(20,2,8).
% node 3: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 4, right -> 7
node(20,3,22,0).
left_node(20,3,4).
right_node(20,3,7).
% node 4: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 5, right -> 6
node(20,4,18,0).
left_node(20,4,5).
right_node(20,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(20,5,0).
% node 6 (leaf): class Graduate (2)
leaf_class(20,6,2).
% node 7 (leaf): class Dropout (0)
leaf_class(20,7,0).
% node 8 (leaf): class Graduate (2)
leaf_class(20,8,2).
% node 9: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 10, right -> 11
node(20,9,16,0).
left_node(20,9,10).
right_node(20,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(20,10,0).
% node 11: Application mode <= 6.0  (F1, bin <= 2)  left -> 12, right -> 19
node(20,11,1,2).
left_node(20,11,12).
right_node(20,11,19).
% node 12: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 13, right -> 16
node(20,12,23,5).
left_node(20,12,13).
right_node(20,12,16).
% node 13: Curricular units 1st sem (grade) <= 10.875  (F25, bin <= 11)  left -> 14, right -> 15
node(20,13,25,11).
left_node(20,13,14).
right_node(20,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(20,14,0).
% node 15 (leaf): class Graduate (2)
leaf_class(20,15,2).
% node 16: Curricular units 2nd sem (grade) <= 10.25  (F31, bin <= 6)  left -> 17, right -> 18
node(20,16,31,6).
left_node(20,16,17).
right_node(20,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(20,17,0).
% node 18 (leaf): class Enrolled (1)
leaf_class(20,18,1).
% node 19: Curricular units 1st sem (grade) <= 10.291666507720947  (F25, bin <= 4)  left -> 20, right -> 21
node(20,19,25,4).
left_node(20,19,20).
right_node(20,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(20,20,0).
% node 21: Curricular units 2nd sem (grade) <= 11.171428680419922  (F31, bin <= 22)  left -> 22, right -> 25
node(20,21,31,22).
left_node(20,21,22).
right_node(20,21,25).
% node 22: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 23, right -> 24
node(20,22,30,2).
left_node(20,22,23).
right_node(20,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(20,23,0).
% node 24 (leaf): class Enrolled (1)
leaf_class(20,24,1).
% node 25 (leaf): class Enrolled (1)
leaf_class(20,25,1).
% node 26: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 27, right -> 40
node(20,26,30,4).
left_node(20,26,27).
right_node(20,26,40).
% node 27: Application order <= 1.5  (F2, bin <= 0)  left -> 28, right -> 33
node(20,27,2,0).
left_node(20,27,28).
right_node(20,27,33).
% node 28: Curricular units 2nd sem (credited) <= 1.5  (F27, bin <= 1)  left -> 29, right -> 32
node(20,28,27,1).
left_node(20,28,29).
right_node(20,28,32).
% node 29: Course <= 9721.5  (F3, bin <= 12)  left -> 30, right -> 31
node(20,29,3,12).
left_node(20,29,30).
right_node(20,29,31).
% node 30 (leaf): class Enrolled (1)
leaf_class(20,30,1).
% node 31 (leaf): class Dropout (0)
leaf_class(20,31,0).
% node 32 (leaf): class Dropout (0)
leaf_class(20,32,0).
% node 33: Course <= 9377.0  (F3, bin <= 10)  left -> 34, right -> 39
node(20,33,3,10).
left_node(20,33,34).
right_node(20,33,39).
% node 34: Previous qualification (grade) <= 123.5  (F6, bin <= 2)  left -> 35, right -> 36
node(20,34,6,2).
left_node(20,34,35).
right_node(20,34,36).
% node 35 (leaf): class Graduate (2)
leaf_class(20,35,2).
% node 36: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 37, right -> 38
node(20,36,30,3).
left_node(20,36,37).
right_node(20,36,38).
% node 37 (leaf): class Enrolled (1)
leaf_class(20,37,1).
% node 38 (leaf): class Graduate (2)
leaf_class(20,38,2).
% node 39 (leaf): class Dropout (0)
leaf_class(20,39,0).
% node 40: Curricular units 1st sem (grade) <= 12.175000190734863  (F25, bin <= 36)  left -> 41, right -> 50
node(20,40,25,36).
left_node(20,40,41).
right_node(20,40,50).
% node 41: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 42, right -> 43
node(20,41,23,5).
left_node(20,41,42).
right_node(20,41,43).
% node 42 (leaf): class Graduate (2)
leaf_class(20,42,2).
% node 43: Curricular units 1st sem (grade) <= 12.131249904632568  (F25, bin <= 35)  left -> 44, right -> 49
node(20,43,25,35).
left_node(20,43,44).
right_node(20,43,49).
% node 44: Curricular units 2nd sem (without evaluations) <= 0.5  (F32, bin <= 0)  left -> 45, right -> 48
node(20,44,32,0).
left_node(20,44,45).
right_node(20,44,48).
% node 45: Curricular units 2nd sem (grade) <= 11.330952167510986  (F31, bin <= 25)  left -> 46, right -> 47
node(20,45,31,25).
left_node(20,45,46).
right_node(20,45,47).
% node 46 (leaf): class Dropout (0)
leaf_class(20,46,0).
% node 47 (leaf): class Graduate (2)
leaf_class(20,47,2).
% node 48 (leaf): class Dropout (0)
leaf_class(20,48,0).
% node 49 (leaf): class Dropout (0)
leaf_class(20,49,0).
% node 50: GDP <= 1.7649999856948853  (F35, bin <= 6)  left -> 51, right -> 60
node(20,50,35,6).
left_node(20,50,51).
right_node(20,50,60).
% node 51: Curricular units 2nd sem (credited) <= 3.5  (F27, bin <= 2)  left -> 52, right -> 57
node(20,51,27,2).
left_node(20,51,52).
right_node(20,51,57).
% node 52: Curricular units 2nd sem (grade) <= 11.422222137451172  (F31, bin <= 31)  left -> 53, right -> 54
node(20,52,31,31).
left_node(20,52,53).
right_node(20,52,54).
% node 53 (leaf): class Enrolled (1)
leaf_class(20,53,1).
% node 54: Curricular units 1st sem (without evaluations) <= 0.5  (F26, bin <= 0)  left -> 55, right -> 56
node(20,54,26,0).
left_node(20,54,55).
right_node(20,54,56).
% node 55 (leaf): class Graduate (2)
leaf_class(20,55,2).
% node 56 (leaf): class Graduate (2)
leaf_class(20,56,2).
% node 57: Curricular units 2nd sem (approved) <= 10.5  (F30, bin <= 7)  left -> 58, right -> 59
node(20,57,30,7).
left_node(20,57,58).
right_node(20,57,59).
% node 58 (leaf): class Graduate (2)
leaf_class(20,58,2).
% node 59 (leaf): class Graduate (2)
leaf_class(20,59,2).
% node 60: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 61, right -> 62
node(20,60,23,4).
left_node(20,60,61).
right_node(20,60,62).
% node 61 (leaf): class Graduate (2)
leaf_class(20,61,2).
% node 62: Gender <= 0.5  (F17, bin <= 0)  left -> 63, right -> 66
node(20,62,17,0).
left_node(20,62,63).
right_node(20,62,66).
% node 63: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 64, right -> 65
node(20,63,24,5).
left_node(20,63,64).
right_node(20,63,65).
% node 64 (leaf): class Enrolled (1)
leaf_class(20,64,1).
% node 65 (leaf): class Graduate (2)
leaf_class(20,65,2).
% node 66: Mother's qualification <= 1.5  (F8, bin <= 0)  left -> 67, right -> 68
node(20,66,8,0).
left_node(20,66,67).
right_node(20,66,68).
% node 67 (leaf): class Graduate (2)
leaf_class(20,67,2).
% node 68 (leaf): class Dropout (0)
leaf_class(20,68,0).

% Tree 21
tree(21).
% node 0: Curricular units 2nd sem (grade) <= 11.154762268066406  (F31, bin <= 20)  left -> 1, right -> 28
node(21,0,31,20).
left_node(21,0,1).
right_node(21,0,28).
% node 1: Curricular units 1st sem (grade) <= 10.083333492279053  (F25, bin <= 2)  left -> 2, right -> 17
node(21,1,25,2).
left_node(21,1,2).
right_node(21,1,17).
% node 2: Previous qualification (grade) <= 135.5  (F6, bin <= 12)  left -> 3, right -> 6
node(21,2,6,12).
left_node(21,2,3).
right_node(21,2,6).
% node 3: Course <= 4092.5  (F3, bin <= 0)  left -> 4, right -> 5
node(21,3,3,0).
left_node(21,3,4).
right_node(21,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(21,4,0).
% node 5 (leaf): class Dropout (0)
leaf_class(21,5,0).
% node 6: Application mode <= 6.0  (F1, bin <= 2)  left -> 7, right -> 12
node(21,6,1,2).
left_node(21,6,7).
right_node(21,6,12).
% node 7: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 8, right -> 11
node(21,7,18,0).
left_node(21,7,8).
right_node(21,7,11).
% node 8: Admission grade <= 140.5999984741211  (F12, bin <= 26)  left -> 9, right -> 10
node(21,8,12,26).
left_node(21,8,9).
right_node(21,8,10).
% node 9 (leaf): class Dropout (0)
leaf_class(21,9,0).
% node 10 (leaf): class Graduate (2)
leaf_class(21,10,2).
% node 11 (leaf): class Graduate (2)
leaf_class(21,11,2).
% node 12: Father's occupation <= 8.5  (F11, bin <= 5)  left -> 13, right -> 16
node(21,12,11,5).
left_node(21,12,13).
right_node(21,12,16).
% node 13: Course <= 8508.5  (F3, bin <= 2)  left -> 14, right -> 15
node(21,13,3,2).
left_node(21,13,14).
right_node(21,13,15).
% node 14 (leaf): class Enrolled (1)
leaf_class(21,14,1).
% node 15 (leaf): class Dropout (0)
leaf_class(21,15,0).
% node 16 (leaf): class Dropout (0)
leaf_class(21,16,0).
% node 17: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 18, right -> 19
node(21,17,30,1).
left_node(21,17,18).
right_node(21,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(21,18,0).
% node 19: ﻿Marital status <= 1.5  (F0, bin <= 0)  left -> 20, right -> 25
node(21,19,0,0).
left_node(21,19,20).
right_node(21,19,25).
% node 20: Age at enrollment <= 19.5  (F19, bin <= 1)  left -> 21, right -> 24
node(21,20,19,1).
left_node(21,20,21).
right_node(21,20,24).
% node 21: Inflation rate <= 1.9999999403953552  (F34, bin <= 6)  left -> 22, right -> 23
node(21,21,34,6).
left_node(21,21,22).
right_node(21,21,23).
% node 22 (leaf): class Dropout (0)
leaf_class(21,22,0).
% node 23 (leaf): class Enrolled (1)
leaf_class(21,23,1).
% node 24 (leaf): class Dropout (0)
leaf_class(21,24,0).
% node 25: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 26, right -> 27
node(21,25,4,0).
left_node(21,25,26).
right_node(21,25,27).
% node 26 (leaf): class Dropout (0)
leaf_class(21,26,0).
% node 27 (leaf): class Dropout (0)
leaf_class(21,27,0).
% node 28: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 29, right -> 40
node(21,28,30,4).
left_node(21,28,29).
right_node(21,28,40).
% node 29: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 30, right -> 31
node(21,29,16,0).
left_node(21,29,30).
right_node(21,29,31).
% node 30 (leaf): class Dropout (0)
leaf_class(21,30,0).
% node 31: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 32, right -> 39
node(21,31,28,4).
left_node(21,31,32).
right_node(21,31,39).
% node 32: Mother's occupation <= 1.5  (F10, bin <= 1)  left -> 33, right -> 34
node(21,32,10,1).
left_node(21,32,33).
right_node(21,32,34).
% node 33 (leaf): class Dropout (0)
leaf_class(21,33,0).
% node 34: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 35, right -> 36
node(21,34,4,0).
left_node(21,34,35).
right_node(21,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(21,35,0).
% node 36: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 37, right -> 38
node(21,36,18,0).
left_node(21,36,37).
right_node(21,36,38).
% node 37 (leaf): class Enrolled (1)
leaf_class(21,37,1).
% node 38 (leaf): class Graduate (2)
leaf_class(21,38,2).
% node 39 (leaf): class Dropout (0)
leaf_class(21,39,0).
% node 40: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 41, right -> 52
node(21,40,23,5).
left_node(21,40,41).
right_node(21,40,52).
% node 41: Age at enrollment <= 23.5  (F19, bin <= 5)  left -> 42, right -> 49
node(21,41,19,5).
left_node(21,41,42).
right_node(21,41,49).
% node 42: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 43, right -> 48
node(21,42,30,5).
left_node(21,42,43).
right_node(21,42,48).
% node 43: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 44, right -> 45
node(21,43,28,3).
left_node(21,43,44).
right_node(21,43,45).
% node 44 (leaf): class Graduate (2)
leaf_class(21,44,2).
% node 45: Course <= 9107.5  (F3, bin <= 6)  left -> 46, right -> 47
node(21,45,3,6).
left_node(21,45,46).
right_node(21,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(21,46,2).
% node 47 (leaf): class Graduate (2)
leaf_class(21,47,2).
% node 48 (leaf): class Graduate (2)
leaf_class(21,48,2).
% node 49: Debtor <= 0.5  (F15, bin <= 0)  left -> 50, right -> 51
node(21,49,15,0).
left_node(21,49,50).
right_node(21,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(21,50,2).
% node 51 (leaf): class Dropout (0)
leaf_class(21,51,0).
% node 52: Course <= 9377.0  (F3, bin <= 10)  left -> 53, right -> 62
node(21,52,3,10).
left_node(21,52,53).
right_node(21,52,62).
% node 53: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 54, right -> 55
node(21,53,16,0).
left_node(21,53,54).
right_node(21,53,55).
% node 54 (leaf): class Dropout (0)
leaf_class(21,54,0).
% node 55: Application mode <= 22.0  (F1, bin <= 6)  left -> 56, right -> 59
node(21,55,1,6).
left_node(21,55,56).
right_node(21,55,59).
% node 56: Curricular units 1st sem (without evaluations) <= 1.5  (F26, bin <= 1)  left -> 57, right -> 58
node(21,56,26,1).
left_node(21,56,57).
right_node(21,56,58).
% node 57 (leaf): class Graduate (2)
leaf_class(21,57,2).
% node 58 (leaf): class Enrolled (1)
leaf_class(21,58,1).
% node 59: Previous qualification (grade) <= 131.5500030517578  (F6, bin <= 9)  left -> 60, right -> 61
node(21,59,6,9).
left_node(21,59,60).
right_node(21,59,61).
% node 60 (leaf): class Graduate (2)
leaf_class(21,60,2).
% node 61 (leaf): class Graduate (2)
leaf_class(21,61,2).
% node 62: Curricular units 1st sem (approved) <= 6.5  (F24, bin <= 6)  left -> 63, right -> 68
node(21,62,24,6).
left_node(21,62,63).
right_node(21,62,68).
% node 63: Father's qualification <= 37.5  (F9, bin <= 7)  left -> 64, right -> 67
node(21,63,9,7).
left_node(21,63,64).
right_node(21,63,67).
% node 64: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 65, right -> 66
node(21,64,28,5).
left_node(21,64,65).
right_node(21,64,66).
% node 65 (leaf): class Enrolled (1)
leaf_class(21,65,1).
% node 66 (leaf): class Graduate (2)
leaf_class(21,66,2).
% node 67 (leaf): class Graduate (2)
leaf_class(21,67,2).
% node 68: Curricular units 1st sem (grade) <= 12.29285717010498  (F25, bin <= 39)  left -> 69, right -> 70
node(21,68,25,39).
left_node(21,68,69).
right_node(21,68,70).
% node 69 (leaf): class Graduate (2)
leaf_class(21,69,2).
% node 70 (leaf): class Graduate (2)
leaf_class(21,70,2).

% Tree 22
tree(22).
% node 0: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 1, right -> 44
node(22,0,30,4).
left_node(22,0,1).
right_node(22,0,44).
% node 1: Curricular units 1st sem (grade) <= 10.099999904632568  (F25, bin <= 3)  left -> 2, right -> 17
node(22,1,25,3).
left_node(22,1,2).
right_node(22,1,17).
% node 2: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 3, right -> 12
node(22,2,28,0).
left_node(22,2,3).
right_node(22,2,12).
% node 3: Age at enrollment <= 24.5  (F19, bin <= 6)  left -> 4, right -> 11
node(22,3,19,6).
left_node(22,3,4).
right_node(22,3,11).
% node 4: Father's qualification <= 1.5  (F9, bin <= 0)  left -> 5, right -> 6
node(22,4,9,0).
left_node(22,4,5).
right_node(22,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(22,5,0).
% node 6: Father's occupation <= 8.5  (F11, bin <= 5)  left -> 7, right -> 10
node(22,6,11,5).
left_node(22,6,7).
right_node(22,6,10).
% node 7: Admission grade <= 147.5999984741211  (F12, bin <= 30)  left -> 8, right -> 9
node(22,7,12,30).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class Enrolled (1)
leaf_class(22,8,1).
% node 9 (leaf): class Graduate (2)
leaf_class(22,9,2).
% node 10 (leaf): class Dropout (0)
leaf_class(22,10,0).
% node 11 (leaf): class Dropout (0)
leaf_class(22,11,0).
% node 12: Curricular units 2nd sem (without evaluations) <= 0.5  (F32, bin <= 0)  left -> 13, right -> 16
node(22,12,32,0).
left_node(22,12,13).
right_node(22,12,16).
% node 13: Curricular units 2nd sem (approved) <= 0.5  (F30, bin <= 0)  left -> 14, right -> 15
node(22,13,30,0).
left_node(22,13,14).
right_node(22,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(22,14,0).
% node 15 (leaf): class Dropout (0)
leaf_class(22,15,0).
% node 16 (leaf): class Dropout (0)
leaf_class(22,16,0).
% node 17: GDP <= -0.30000001192092896  (F35, bin <= 2)  left -> 18, right -> 29
node(22,17,35,2).
left_node(22,17,18).
right_node(22,17,29).
% node 18: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 19, right -> 28
node(22,18,18,0).
left_node(22,18,19).
right_node(22,18,28).
% node 19: Gender <= 0.5  (F17, bin <= 0)  left -> 20, right -> 25
node(22,19,17,0).
left_node(22,19,20).
right_node(22,19,25).
% node 20: ﻿Marital status <= 1.5  (F0, bin <= 0)  left -> 21, right -> 24
node(22,20,0,0).
left_node(22,20,21).
right_node(22,20,24).
% node 21: Admission grade <= 123.14999771118164  (F12, bin <= 7)  left -> 22, right -> 23
node(22,21,12,7).
left_node(22,21,22).
right_node(22,21,23).
% node 22 (leaf): class Dropout (0)
leaf_class(22,22,0).
% node 23 (leaf): class Enrolled (1)
leaf_class(22,23,1).
% node 24 (leaf): class Dropout (0)
leaf_class(22,24,0).
% node 25: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 26, right -> 27
node(22,25,30,3).
left_node(22,25,26).
right_node(22,25,27).
% node 26 (leaf): class Dropout (0)
leaf_class(22,26,0).
% node 27 (leaf): class Dropout (0)
leaf_class(22,27,0).
% node 28 (leaf): class Graduate (2)
leaf_class(22,28,2).
% node 29: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 30, right -> 37
node(22,29,24,3).
left_node(22,29,30).
right_node(22,29,37).
% node 30: Mother's occupation <= 1.5  (F10, bin <= 1)  left -> 31, right -> 32
node(22,30,10,1).
left_node(22,30,31).
right_node(22,30,32).
% node 31 (leaf): class Dropout (0)
leaf_class(22,31,0).
% node 32: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 33, right -> 34
node(22,32,23,4).
left_node(22,32,33).
right_node(22,32,34).
% node 33 (leaf): class Dropout (0)
leaf_class(22,33,0).
% node 34: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 35, right -> 36
node(22,34,16,0).
left_node(22,34,35).
right_node(22,34,36).
% node 35 (leaf): class Dropout (0)
leaf_class(22,35,0).
% node 36 (leaf): class Dropout (0)
leaf_class(22,36,0).
% node 37: Debtor <= 0.5  (F15, bin <= 0)  left -> 38, right -> 43
node(22,37,15,0).
left_node(22,37,38).
right_node(22,37,43).
% node 38: Curricular units 2nd sem (approved) <= 0.5  (F30, bin <= 0)  left -> 39, right -> 40
node(22,38,30,0).
left_node(22,38,39).
right_node(22,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(22,39,0).
% node 40: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 41, right -> 42
node(22,40,24,5).
left_node(22,40,41).
right_node(22,40,42).
% node 41 (leaf): class Enrolled (1)
leaf_class(22,41,1).
% node 42 (leaf): class Graduate (2)
leaf_class(22,42,2).
% node 43 (leaf): class Dropout (0)
leaf_class(22,43,0).
% node 44: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 45, right -> 56
node(22,44,24,5).
left_node(22,44,45).
right_node(22,44,56).
% node 45: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 46, right -> 47
node(22,45,23,4).
left_node(22,45,46).
right_node(22,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(22,46,2).
% node 47: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 48, right -> 49
node(22,47,29,3).
left_node(22,47,48).
right_node(22,47,49).
% node 48 (leaf): class Graduate (2)
leaf_class(22,48,2).
% node 49: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 50, right -> 51
node(22,49,28,4).
left_node(22,49,50).
right_node(22,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(22,50,2).
% node 51: Course <= 9377.0  (F3, bin <= 10)  left -> 52, right -> 53
node(22,51,3,10).
left_node(22,51,52).
right_node(22,51,53).
% node 52 (leaf): class Dropout (0)
leaf_class(22,52,0).
% node 53: Admission grade <= 127.70000076293945  (F12, bin <= 12)  left -> 54, right -> 55
node(22,53,12,12).
left_node(22,53,54).
right_node(22,53,55).
% node 54 (leaf): class Enrolled (1)
leaf_class(22,54,1).
% node 55 (leaf): class Enrolled (1)
leaf_class(22,55,1).
% node 56: Curricular units 1st sem (enrolled) <= 8.5  (F22, bin <= 8)  left -> 57, right -> 62
node(22,56,22,8).
left_node(22,56,57).
right_node(22,56,62).
% node 57: Curricular units 2nd sem (evaluations) <= 12.5  (F29, bin <= 9)  left -> 58, right -> 61
node(22,57,29,9).
left_node(22,57,58).
right_node(22,57,61).
% node 58: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 59, right -> 60
node(22,58,16,0).
left_node(22,58,59).
right_node(22,58,60).
% node 59 (leaf): class Dropout (0)
leaf_class(22,59,0).
% node 60 (leaf): class Graduate (2)
leaf_class(22,60,2).
% node 61 (leaf): class Graduate (2)
leaf_class(22,61,2).
% node 62: Curricular units 1st sem (grade) <= 11.730303287506104  (F25, bin <= 23)  left -> 63, right -> 66
node(22,62,25,23).
left_node(22,62,63).
right_node(22,62,66).
% node 63: Curricular units 1st sem (enrolled) <= 12.5  (F22, bin <= 10)  left -> 64, right -> 65
node(22,63,22,10).
left_node(22,63,64).
right_node(22,63,65).
% node 64 (leaf): class Enrolled (1)
leaf_class(22,64,1).
% node 65 (leaf): class Dropout (0)
leaf_class(22,65,0).
% node 66: Father's occupation <= 8.5  (F11, bin <= 5)  left -> 67, right -> 72
node(22,66,11,5).
left_node(22,66,67).
right_node(22,66,72).
% node 67: Curricular units 2nd sem (approved) <= 10.5  (F30, bin <= 7)  left -> 68, right -> 71
node(22,67,30,7).
left_node(22,67,68).
right_node(22,67,71).
% node 68: Father's qualification <= 29.5  (F9, bin <= 5)  left -> 69, right -> 70
node(22,68,9,5).
left_node(22,68,69).
right_node(22,68,70).
% node 69 (leaf): class Graduate (2)
leaf_class(22,69,2).
% node 70 (leaf): class Graduate (2)
leaf_class(22,70,2).
% node 71 (leaf): class Graduate (2)
leaf_class(22,71,2).
% node 72 (leaf): class Graduate (2)
leaf_class(22,72,2).

% Tree 23
tree(23).
% node 0: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 1, right -> 14
node(23,0,23,2).
left_node(23,0,1).
right_node(23,0,14).
% node 1: Curricular units 1st sem (grade) <= 11.5  (F25, bin <= 17)  left -> 2, right -> 9
node(23,1,25,17).
left_node(23,1,2).
right_node(23,1,9).
% node 2: Application mode <= 6.0  (F1, bin <= 2)  left -> 3, right -> 8
node(23,2,1,2).
left_node(23,2,3).
right_node(23,2,8).
% node 3: Debtor <= 0.5  (F15, bin <= 0)  left -> 4, right -> 7
node(23,3,15,0).
left_node(23,3,4).
right_node(23,3,7).
% node 4: Inflation rate <= 0.550000011920929  (F34, bin <= 3)  left -> 5, right -> 6
node(23,4,34,3).
left_node(23,4,5).
right_node(23,4,6).
% node 5 (leaf): class Graduate (2)
leaf_class(23,5,2).
% node 6 (leaf): class Dropout (0)
leaf_class(23,6,0).
% node 7 (leaf): class Dropout (0)
leaf_class(23,7,0).
% node 8 (leaf): class Dropout (0)
leaf_class(23,8,0).
% node 9: Admission grade <= 133.0999984741211  (F12, bin <= 21)  left -> 10, right -> 13
node(23,9,12,21).
left_node(23,9,10).
right_node(23,9,13).
% node 10: GDP <= 0.5550000071525574  (F35, bin <= 3)  left -> 11, right -> 12
node(23,10,35,3).
left_node(23,10,11).
right_node(23,10,12).
% node 11 (leaf): class Graduate (2)
leaf_class(23,11,2).
% node 12 (leaf): class Graduate (2)
leaf_class(23,12,2).
% node 13 (leaf): class Graduate (2)
leaf_class(23,13,2).
% node 14: Curricular units 1st sem (grade) <= 10.775000095367432  (F25, bin <= 10)  left -> 15, right -> 30
node(23,14,25,10).
left_node(23,14,15).
right_node(23,14,30).
% node 15: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 16, right -> 17
node(23,15,29,2).
left_node(23,15,16).
right_node(23,15,17).
% node 16 (leaf): class Dropout (0)
leaf_class(23,16,0).
% node 17: Curricular units 2nd sem (grade) <= 10.099999904632568  (F31, bin <= 3)  left -> 18, right -> 21
node(23,17,31,3).
left_node(23,17,18).
right_node(23,17,21).
% node 18: Age at enrollment <= 23.5  (F19, bin <= 5)  left -> 19, right -> 20
node(23,18,19,5).
left_node(23,18,19).
right_node(23,18,20).
% node 19 (leaf): class Dropout (0)
leaf_class(23,19,0).
% node 20 (leaf): class Dropout (0)
leaf_class(23,20,0).
% node 21: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 22, right -> 27
node(23,21,30,3).
left_node(23,21,22).
right_node(23,21,27).
% node 22: Curricular units 2nd sem (approved) <= 1.5  (F30, bin <= 1)  left -> 23, right -> 24
node(23,22,30,1).
left_node(23,22,23).
right_node(23,22,24).
% node 23 (leaf): class Dropout (0)
leaf_class(23,23,0).
% node 24: Previous qualification (grade) <= 130.5  (F6, bin <= 6)  left -> 25, right -> 26
node(23,24,6,6).
left_node(23,24,25).
right_node(23,24,26).
% node 25 (leaf): class Enrolled (1)
leaf_class(23,25,1).
% node 26 (leaf): class Dropout (0)
leaf_class(23,26,0).
% node 27: Unemployment rate <= 12.549999713897705  (F33, bin <= 5)  left -> 28, right -> 29
node(23,27,33,5).
left_node(23,27,28).
right_node(23,27,29).
% node 28 (leaf): class Graduate (2)
leaf_class(23,28,2).
% node 29 (leaf): class Enrolled (1)
leaf_class(23,29,1).
% node 30: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 31, right -> 42
node(23,30,22,5).
left_node(23,30,31).
right_node(23,30,42).
% node 31: Curricular units 2nd sem (evaluations) <= 6.5  (F29, bin <= 3)  left -> 32, right -> 35
node(23,31,29,3).
left_node(23,31,32).
right_node(23,31,35).
% node 32: Curricular units 2nd sem (grade) <= 10.708333492279053  (F31, bin <= 15)  left -> 33, right -> 34
node(23,32,31,15).
left_node(23,32,33).
right_node(23,32,34).
% node 33 (leaf): class Dropout (0)
leaf_class(23,33,0).
% node 34 (leaf): class Graduate (2)
leaf_class(23,34,2).
% node 35: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 36, right -> 37
node(23,35,16,0).
left_node(23,35,36).
right_node(23,35,37).
% node 36 (leaf): class Dropout (0)
leaf_class(23,36,0).
% node 37: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 38, right -> 41
node(23,37,30,4).
left_node(23,37,38).
right_node(23,37,41).
% node 38: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 39, right -> 40
node(23,38,30,2).
left_node(23,38,39).
right_node(23,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(23,39,0).
% node 40 (leaf): class Enrolled (1)
leaf_class(23,40,1).
% node 41 (leaf): class Graduate (2)
leaf_class(23,41,2).
% node 42: Age at enrollment <= 20.5  (F19, bin <= 2)  left -> 43, right -> 52
node(23,42,19,2).
left_node(23,42,43).
right_node(23,42,52).
% node 43: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 44, right -> 51
node(23,43,28,5).
left_node(23,43,44).
right_node(23,43,51).
% node 44: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 45, right -> 48
node(23,44,18,0).
left_node(23,44,45).
right_node(23,44,48).
% node 45: Curricular units 2nd sem (grade) <= 11.774602890014648  (F31, bin <= 36)  left -> 46, right -> 47
node(23,45,31,36).
left_node(23,45,46).
right_node(23,45,47).
% node 46 (leaf): class Dropout (0)
leaf_class(23,46,0).
% node 47 (leaf): class Graduate (2)
leaf_class(23,47,2).
% node 48: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 49, right -> 50
node(23,48,30,5).
left_node(23,48,49).
right_node(23,48,50).
% node 49 (leaf): class Graduate (2)
leaf_class(23,49,2).
% node 50 (leaf): class Graduate (2)
leaf_class(23,50,2).
% node 51 (leaf): class Graduate (2)
leaf_class(23,51,2).
% node 52: Curricular units 2nd sem (grade) <= 11.348571300506592  (F31, bin <= 28)  left -> 53, right -> 58
node(23,52,31,28).
left_node(23,52,53).
right_node(23,52,58).
% node 53: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 54, right -> 55
node(23,53,16,0).
left_node(23,53,54).
right_node(23,53,55).
% node 54 (leaf): class Dropout (0)
leaf_class(23,54,0).
% node 55: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 56, right -> 57
node(23,55,30,5).
left_node(23,55,56).
right_node(23,55,57).
% node 56 (leaf): class Dropout (0)
leaf_class(23,56,0).
% node 57 (leaf): class Graduate (2)
leaf_class(23,57,2).
% node 58: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 59, right -> 62
node(23,58,30,5).
left_node(23,58,59).
right_node(23,58,62).
% node 59: Curricular units 2nd sem (evaluations) <= 10.5  (F29, bin <= 7)  left -> 60, right -> 61
node(23,59,29,7).
left_node(23,59,60).
right_node(23,59,61).
% node 60 (leaf): class Graduate (2)
leaf_class(23,60,2).
% node 61 (leaf): class Enrolled (1)
leaf_class(23,61,1).
% node 62: Debtor <= 0.5  (F15, bin <= 0)  left -> 63, right -> 64
node(23,62,15,0).
left_node(23,62,63).
right_node(23,62,64).
% node 63 (leaf): class Graduate (2)
leaf_class(23,63,2).
% node 64 (leaf): class Enrolled (1)
leaf_class(23,64,1).

% Tree 24
tree(24).
% node 0: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 1, right -> 16
node(24,0,23,2).
left_node(24,0,1).
right_node(24,0,16).
% node 1: Age at enrollment <= 24.5  (F19, bin <= 6)  left -> 2, right -> 9
node(24,1,19,6).
left_node(24,1,2).
right_node(24,1,9).
% node 2: Debtor <= 0.5  (F15, bin <= 0)  left -> 3, right -> 8
node(24,2,15,0).
left_node(24,2,3).
right_node(24,2,8).
% node 3: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 4, right -> 7
node(24,3,28,3).
left_node(24,3,4).
right_node(24,3,7).
% node 4: Curricular units 1st sem (grade) <= 10.775000095367432  (F25, bin <= 10)  left -> 5, right -> 6
node(24,4,25,10).
left_node(24,4,5).
right_node(24,4,6).
% node 5 (leaf): class Graduate (2)
leaf_class(24,5,2).
% node 6 (leaf): class Graduate (2)
leaf_class(24,6,2).
% node 7 (leaf): class Dropout (0)
leaf_class(24,7,0).
% node 8 (leaf): class Dropout (0)
leaf_class(24,8,0).
% node 9: Course <= 9813.0  (F3, bin <= 13)  left -> 10, right -> 11
node(24,9,3,13).
left_node(24,9,10).
right_node(24,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(24,10,0).
% node 11: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 12, right -> 13
node(24,11,16,0).
left_node(24,11,12).
right_node(24,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(24,12,0).
% node 13: Curricular units 1st sem (grade) <= 5.5  (F25, bin <= 1)  left -> 14, right -> 15
node(24,13,25,1).
left_node(24,13,14).
right_node(24,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(24,14,0).
% node 15 (leaf): class Graduate (2)
leaf_class(24,15,2).
% node 16: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 17, right -> 36
node(24,16,22,5).
left_node(24,16,17).
right_node(24,16,36).
% node 17: Curricular units 2nd sem (grade) <= 10.099999904632568  (F31, bin <= 3)  left -> 18, right -> 19
node(24,17,31,3).
left_node(24,17,18).
right_node(24,17,19).
% node 18 (leaf): class Dropout (0)
leaf_class(24,18,0).
% node 19: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 20, right -> 27
node(24,19,30,3).
left_node(24,19,20).
right_node(24,19,27).
% node 20: Course <= 9830.5  (F3, bin <= 14)  left -> 21, right -> 26
node(24,20,3,14).
left_node(24,20,21).
right_node(24,20,26).
% node 21: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 22, right -> 23
node(24,21,16,0).
left_node(24,21,22).
right_node(24,21,23).
% node 22 (leaf): class Dropout (0)
leaf_class(24,22,0).
% node 23: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 24, right -> 25
node(24,23,24,3).
left_node(24,23,24).
right_node(24,23,25).
% node 24 (leaf): class Dropout (0)
leaf_class(24,24,0).
% node 25 (leaf): class Enrolled (1)
leaf_class(24,25,1).
% node 26 (leaf): class Dropout (0)
leaf_class(24,26,0).
% node 27: Application mode <= 28.5  (F1, bin <= 7)  left -> 28, right -> 33
node(24,27,1,7).
left_node(24,27,28).
right_node(24,27,33).
% node 28: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 29, right -> 32
node(24,28,24,3).
left_node(24,28,29).
right_node(24,28,32).
% node 29: Father's occupation <= 4.5  (F11, bin <= 2)  left -> 30, right -> 31
node(24,29,11,2).
left_node(24,29,30).
right_node(24,29,31).
% node 30 (leaf): class Graduate (2)
leaf_class(24,30,2).
% node 31 (leaf): class Enrolled (1)
leaf_class(24,31,1).
% node 32 (leaf): class Graduate (2)
leaf_class(24,32,2).
% node 33: Curricular units 2nd sem (grade) <= 12.224999904632568  (F31, bin <= 42)  left -> 34, right -> 35
node(24,33,31,42).
left_node(24,33,34).
right_node(24,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(24,34,1).
% node 35 (leaf): class Graduate (2)
leaf_class(24,35,2).
% node 36: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 37, right -> 44
node(24,36,16,0).
left_node(24,36,37).
right_node(24,36,44).
% node 37: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 38, right -> 43
node(24,37,18,0).
left_node(24,37,38).
right_node(24,37,43).
% node 38: Curricular units 1st sem (grade) <= 12.96999979019165  (F25, bin <= 42)  left -> 39, right -> 40
node(24,38,25,42).
left_node(24,38,39).
right_node(24,38,40).
% node 39 (leaf): class Dropout (0)
leaf_class(24,39,0).
% node 40: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 41, right -> 42
node(24,40,30,5).
left_node(24,40,41).
right_node(24,40,42).
% node 41 (leaf): class Dropout (0)
leaf_class(24,41,0).
% node 42 (leaf): class Graduate (2)
leaf_class(24,42,2).
% node 43 (leaf): class Graduate (2)
leaf_class(24,43,2).
% node 44: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 45, right -> 56
node(24,44,29,6).
left_node(24,44,45).
right_node(24,44,56).
% node 45: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 46, right -> 51
node(24,45,24,4).
left_node(24,45,46).
right_node(24,45,51).
% node 46: Unemployment rate <= 12.549999713897705  (F33, bin <= 5)  left -> 47, right -> 50
node(24,46,33,5).
left_node(24,46,47).
right_node(24,46,50).
% node 47: Curricular units 2nd sem (grade) <= 5.199999809265137  (F31, bin <= 1)  left -> 48, right -> 49
node(24,47,31,1).
left_node(24,47,48).
right_node(24,47,49).
% node 48 (leaf): class Dropout (0)
leaf_class(24,48,0).
% node 49 (leaf): class Enrolled (1)
leaf_class(24,49,1).
% node 50 (leaf): class Dropout (0)
leaf_class(24,50,0).
% node 51: Curricular units 2nd sem (grade) <= 10.083333492279053  (F31, bin <= 2)  left -> 52, right -> 53
node(24,51,31,2).
left_node(24,51,52).
right_node(24,51,53).
% node 52 (leaf): class Dropout (0)
leaf_class(24,52,0).
% node 53: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 54, right -> 55
node(24,53,30,5).
left_node(24,53,54).
right_node(24,53,55).
% node 54 (leaf): class Graduate (2)
leaf_class(24,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(24,55,2).
% node 56: Previous qualification (grade) <= 134.5  (F6, bin <= 11)  left -> 57, right -> 64
node(24,56,6,11).
left_node(24,56,57).
right_node(24,56,64).
% node 57: Curricular units 1st sem (enrolled) <= 9.5  (F22, bin <= 9)  left -> 58, right -> 61
node(24,57,22,9).
left_node(24,57,58).
right_node(24,57,61).
% node 58: Curricular units 2nd sem (evaluations) <= 12.5  (F29, bin <= 9)  left -> 59, right -> 60
node(24,58,29,9).
left_node(24,58,59).
right_node(24,58,60).
% node 59 (leaf): class Graduate (2)
leaf_class(24,59,2).
% node 60 (leaf): class Dropout (0)
leaf_class(24,60,0).
% node 61: Curricular units 2nd sem (grade) <= 11.954545497894287  (F31, bin <= 40)  left -> 62, right -> 63
node(24,61,31,40).
left_node(24,61,62).
right_node(24,61,63).
% node 62 (leaf): class Dropout (0)
leaf_class(24,62,0).
% node 63 (leaf): class Graduate (2)
leaf_class(24,63,2).
% node 64: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 65, right -> 66
node(24,64,28,5).
left_node(24,64,65).
right_node(24,64,66).
% node 65 (leaf): class Enrolled (1)
leaf_class(24,65,1).
% node 66: Mother's qualification <= 3.5  (F8, bin <= 2)  left -> 67, right -> 68
node(24,66,8,2).
left_node(24,66,67).
right_node(24,66,68).
% node 67 (leaf): class Graduate (2)
leaf_class(24,67,2).
% node 68 (leaf): class Graduate (2)
leaf_class(24,68,2).

% Tree 25
tree(25).
% node 0: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 1, right -> 22
node(25,0,24,3).
left_node(25,0,1).
right_node(25,0,22).
% node 1: Curricular units 2nd sem (approved) <= 2.5  (F30, bin <= 2)  left -> 2, right -> 17
node(25,1,30,2).
left_node(25,1,2).
right_node(25,1,17).
% node 2: Mother's qualification <= 31.5  (F8, bin <= 7)  left -> 3, right -> 14
node(25,2,8,7).
left_node(25,2,3).
right_node(25,2,14).
% node 3: Previous qualification (grade) <= 135.5  (F6, bin <= 12)  left -> 4, right -> 7
node(25,3,6,12).
left_node(25,3,4).
right_node(25,3,7).
% node 4: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 5, right -> 6
node(25,4,28,0).
left_node(25,4,5).
right_node(25,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(25,5,0).
% node 6 (leaf): class Dropout (0)
leaf_class(25,6,0).
% node 7: Unemployment rate <= 14.699999809265137  (F33, bin <= 10)  left -> 8, right -> 13
node(25,7,33,10).
left_node(25,7,8).
right_node(25,7,13).
% node 8: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 9, right -> 12
node(25,8,18,0).
left_node(25,8,9).
right_node(25,8,12).
% node 9: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 10, right -> 11
node(25,9,16,0).
left_node(25,9,10).
right_node(25,9,11).
% node 10 (leaf): class Dropout (0)
leaf_class(25,10,0).
% node 11 (leaf): class Dropout (0)
leaf_class(25,11,0).
% node 12 (leaf): class Graduate (2)
leaf_class(25,12,2).
% node 13 (leaf): class Dropout (0)
leaf_class(25,13,0).
% node 14: Age at enrollment <= 18.5  (F19, bin <= 0)  left -> 15, right -> 16
node(25,14,19,0).
left_node(25,14,15).
right_node(25,14,16).
% node 15 (leaf): class Dropout (0)
leaf_class(25,15,0).
% node 16 (leaf): class Dropout (0)
leaf_class(25,16,0).
% node 17: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 18, right -> 21
node(25,17,30,3).
left_node(25,17,18).
right_node(25,17,21).
% node 18: Mother's qualification <= 2.5  (F8, bin <= 1)  left -> 19, right -> 20
node(25,18,8,1).
left_node(25,18,19).
right_node(25,18,20).
% node 19 (leaf): class Enrolled (1)
leaf_class(25,19,1).
% node 20 (leaf): class Dropout (0)
leaf_class(25,20,0).
% node 21 (leaf): class Enrolled (1)
leaf_class(25,21,1).
% node 22: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 23, right -> 60
node(25,22,18,0).
left_node(25,22,23).
right_node(25,22,60).
% node 23: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 24, right -> 41
node(25,23,30,4).
left_node(25,23,24).
right_node(25,23,41).
% node 24: Course <= 9528.0  (F3, bin <= 11)  left -> 25, right -> 36
node(25,24,3,11).
left_node(25,24,25).
right_node(25,24,36).
% node 25: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 26, right -> 31
node(25,25,29,6).
left_node(25,25,26).
right_node(25,25,31).
% node 26: Unemployment rate <= 11.75  (F33, bin <= 4)  left -> 27, right -> 30
node(25,26,33,4).
left_node(25,26,27).
right_node(25,26,30).
% node 27: Application mode <= 17.5  (F1, bin <= 5)  left -> 28, right -> 29
node(25,27,1,5).
left_node(25,27,28).
right_node(25,27,29).
% node 28 (leaf): class Graduate (2)
leaf_class(25,28,2).
% node 29 (leaf): class Enrolled (1)
leaf_class(25,29,1).
% node 30 (leaf): class Dropout (0)
leaf_class(25,30,0).
% node 31: Course <= 9036.5  (F3, bin <= 3)  left -> 32, right -> 33
node(25,31,3,3).
left_node(25,31,32).
right_node(25,31,33).
% node 32 (leaf): class Dropout (0)
leaf_class(25,32,0).
% node 33: Admission grade <= 124.1500015258789  (F12, bin <= 9)  left -> 34, right -> 35
node(25,33,12,9).
left_node(25,33,34).
right_node(25,33,35).
% node 34 (leaf): class Enrolled (1)
leaf_class(25,34,1).
% node 35 (leaf): class Enrolled (1)
leaf_class(25,35,1).
% node 36: Curricular units 2nd sem (grade) <= 11.416666507720947  (F31, bin <= 30)  left -> 37, right -> 38
node(25,36,31,30).
left_node(25,36,37).
right_node(25,36,38).
% node 37 (leaf): class Dropout (0)
leaf_class(25,37,0).
% node 38: Unemployment rate <= 10.099999904632568  (F33, bin <= 2)  left -> 39, right -> 40
node(25,38,33,2).
left_node(25,38,39).
right_node(25,38,40).
% node 39 (leaf): class Graduate (2)
leaf_class(25,39,2).
% node 40 (leaf): class Dropout (0)
leaf_class(25,40,0).
% node 41: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 42, right -> 55
node(25,41,19,4).
left_node(25,41,42).
right_node(25,41,55).
% node 42: GDP <= 0.5550000071525574  (F35, bin <= 3)  left -> 43, right -> 48
node(25,42,35,3).
left_node(25,42,43).
right_node(25,42,48).
% node 43: Course <= 9528.0  (F3, bin <= 11)  left -> 44, right -> 45
node(25,43,3,11).
left_node(25,43,44).
right_node(25,43,45).
% node 44 (leaf): class Graduate (2)
leaf_class(25,44,2).
% node 45: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 46, right -> 47
node(25,45,23,5).
left_node(25,45,46).
right_node(25,45,47).
% node 46 (leaf): class Graduate (2)
leaf_class(25,46,2).
% node 47 (leaf): class Enrolled (1)
leaf_class(25,47,1).
% node 48: Admission grade <= 126.35000228881836  (F12, bin <= 10)  left -> 49, right -> 52
node(25,48,12,10).
left_node(25,48,49).
right_node(25,48,52).
% node 49: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 50, right -> 51
node(25,49,29,4).
left_node(25,49,50).
right_node(25,49,51).
% node 50 (leaf): class Graduate (2)
leaf_class(25,50,2).
% node 51 (leaf): class Graduate (2)
leaf_class(25,51,2).
% node 52: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 53, right -> 54
node(25,52,29,6).
left_node(25,52,53).
right_node(25,52,54).
% node 53 (leaf): class Graduate (2)
leaf_class(25,53,2).
% node 54 (leaf): class Graduate (2)
leaf_class(25,54,2).
% node 55: Curricular units 2nd sem (grade) <= 13.60769271850586  (F31, bin <= 53)  left -> 56, right -> 59
node(25,55,31,53).
left_node(25,55,56).
right_node(25,55,59).
% node 56: Application mode <= 17.5  (F1, bin <= 5)  left -> 57, right -> 58
node(25,56,1,5).
left_node(25,56,57).
right_node(25,56,58).
% node 57 (leaf): class Dropout (0)
leaf_class(25,57,0).
% node 58 (leaf): class Graduate (2)
leaf_class(25,58,2).
% node 59 (leaf): class Graduate (2)
leaf_class(25,59,2).
% node 60: Curricular units 1st sem (grade) <= 12.267857074737549  (F25, bin <= 38)  left -> 61, right -> 66
node(25,60,25,38).
left_node(25,60,61).
right_node(25,60,66).
% node 61: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 62, right -> 63
node(25,61,30,4).
left_node(25,61,62).
right_node(25,61,63).
% node 62 (leaf): class Enrolled (1)
leaf_class(25,62,1).
% node 63: Unemployment rate <= 9.149999618530273  (F33, bin <= 1)  left -> 64, right -> 65
node(25,63,33,1).
left_node(25,63,64).
right_node(25,63,65).
% node 64 (leaf): class Graduate (2)
leaf_class(25,64,2).
% node 65 (leaf): class Graduate (2)
leaf_class(25,65,2).
% node 66: GDP <= 1.7649999856948853  (F35, bin <= 6)  left -> 67, right -> 74
node(25,66,35,6).
left_node(25,66,67).
right_node(25,66,74).
% node 67: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 68, right -> 73
node(25,67,30,5).
left_node(25,67,68).
right_node(25,67,73).
% node 68: Curricular units 2nd sem (evaluations) <= 7.5  (F29, bin <= 4)  left -> 69, right -> 72
node(25,68,29,4).
left_node(25,68,69).
right_node(25,68,72).
% node 69: Father's occupation <= 5.5  (F11, bin <= 3)  left -> 70, right -> 71
node(25,69,11,3).
left_node(25,69,70).
right_node(25,69,71).
% node 70 (leaf): class Dropout (0)
leaf_class(25,70,0).
% node 71 (leaf): class Graduate (2)
leaf_class(25,71,2).
% node 72 (leaf): class Graduate (2)
leaf_class(25,72,2).
% node 73 (leaf): class Graduate (2)
leaf_class(25,73,2).
% node 74 (leaf): class Graduate (2)
leaf_class(25,74,2).

% Tree 26
tree(26).
% node 0: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 1, right -> 54
node(26,0,18,0).
left_node(26,0,1).
right_node(26,0,54).
% node 1: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 2, right -> 25
node(26,1,24,4).
left_node(26,1,2).
right_node(26,1,25).
% node 2: Mother's occupation <= 127.0  (F10, bin <= 12)  left -> 3, right -> 24
node(26,2,10,12).
left_node(26,2,3).
right_node(26,2,24).
% node 3: Curricular units 1st sem (approved) <= 2.5  (F24, bin <= 2)  left -> 4, right -> 11
node(26,3,24,2).
left_node(26,3,4).
right_node(26,3,11).
% node 4: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 5, right -> 6
node(26,4,29,2).
left_node(26,4,5).
right_node(26,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(26,5,0).
% node 6: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 7, right -> 8
node(26,6,16,0).
left_node(26,6,7).
right_node(26,6,8).
% node 7 (leaf): class Dropout (0)
leaf_class(26,7,0).
% node 8: Previous qualification (grade) <= 133.0500030517578  (F6, bin <= 10)  left -> 9, right -> 10
node(26,8,6,10).
left_node(26,8,9).
right_node(26,8,10).
% node 9 (leaf): class Dropout (0)
leaf_class(26,9,0).
% node 10 (leaf): class Dropout (0)
leaf_class(26,10,0).
% node 11: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 12, right -> 19
node(26,11,22,5).
left_node(26,11,12).
right_node(26,11,19).
% node 12: "Daytime/evening attendance	" <= 0.5  (F4, bin <= 0)  left -> 13, right -> 16
node(26,12,4,0).
left_node(26,12,13).
right_node(26,12,16).
% node 13: Mother's occupation <= 5.5  (F10, bin <= 4)  left -> 14, right -> 15
node(26,13,10,4).
left_node(26,13,14).
right_node(26,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(26,14,0).
% node 15 (leaf): class Enrolled (1)
leaf_class(26,15,1).
% node 16: Curricular units 2nd sem (grade) <= 12.550000190734863  (F31, bin <= 45)  left -> 17, right -> 18
node(26,16,31,45).
left_node(26,16,17).
right_node(26,16,18).
% node 17 (leaf): class Enrolled (1)
leaf_class(26,17,1).
% node 18 (leaf): class Graduate (2)
leaf_class(26,18,2).
% node 19: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 20, right -> 21
node(26,19,16,0).
left_node(26,19,20).
right_node(26,19,21).
% node 20 (leaf): class Dropout (0)
leaf_class(26,20,0).
% node 21: Father's qualification <= 3.5  (F9, bin <= 1)  left -> 22, right -> 23
node(26,21,9,1).
left_node(26,21,22).
right_node(26,21,23).
% node 22 (leaf): class Enrolled (1)
leaf_class(26,22,1).
% node 23 (leaf): class Dropout (0)
leaf_class(26,23,0).
% node 24 (leaf): class Enrolled (1)
leaf_class(26,24,1).
% node 25: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 26, right -> 37
node(26,25,30,4).
left_node(26,25,26).
right_node(26,25,37).
% node 26: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 27, right -> 28
node(26,26,16,0).
left_node(26,26,27).
right_node(26,26,28).
% node 27 (leaf): class Dropout (0)
leaf_class(26,27,0).
% node 28: Curricular units 2nd sem (approved) <= 0.5  (F30, bin <= 0)  left -> 29, right -> 30
node(26,28,30,0).
left_node(26,28,29).
right_node(26,28,30).
% node 29 (leaf): class Dropout (0)
leaf_class(26,29,0).
% node 30: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 31, right -> 34
node(26,30,24,5).
left_node(26,30,31).
right_node(26,30,34).
% node 31: Admission grade <= 126.64999771118164  (F12, bin <= 11)  left -> 32, right -> 33
node(26,31,12,11).
left_node(26,31,32).
right_node(26,31,33).
% node 32 (leaf): class Enrolled (1)
leaf_class(26,32,1).
% node 33 (leaf): class Dropout (0)
leaf_class(26,33,0).
% node 34: GDP <= 0.5550000071525574  (F35, bin <= 3)  left -> 35, right -> 36
node(26,34,35,3).
left_node(26,34,35).
right_node(26,34,36).
% node 35 (leaf): class Graduate (2)
leaf_class(26,35,2).
% node 36 (leaf): class Enrolled (1)
leaf_class(26,36,1).
% node 37: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 38, right -> 47
node(26,37,29,6).
left_node(26,37,38).
right_node(26,37,47).
% node 38: GDP <= -3.5899999141693115  (F35, bin <= 0)  left -> 39, right -> 42
node(26,38,35,0).
left_node(26,38,39).
right_node(26,38,42).
% node 39: Curricular units 1st sem (grade) <= 13.759643077850342  (F25, bin <= 47)  left -> 40, right -> 41
node(26,39,25,47).
left_node(26,39,40).
right_node(26,39,41).
% node 40 (leaf): class Graduate (2)
leaf_class(26,40,2).
% node 41 (leaf): class Graduate (2)
leaf_class(26,41,2).
% node 42: Curricular units 1st sem (evaluations) <= 9.5  (F23, bin <= 6)  left -> 43, right -> 46
node(26,42,23,6).
left_node(26,42,43).
right_node(26,42,46).
% node 43: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 44, right -> 45
node(26,43,16,0).
left_node(26,43,44).
right_node(26,43,45).
% node 44 (leaf): class Dropout (0)
leaf_class(26,44,0).
% node 45 (leaf): class Graduate (2)
leaf_class(26,45,2).
% node 46 (leaf): class Graduate (2)
leaf_class(26,46,2).
% node 47: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 48, right -> 49
node(26,47,16,0).
left_node(26,47,48).
right_node(26,47,49).
% node 48 (leaf): class Dropout (0)
leaf_class(26,48,0).
% node 49: Curricular units 2nd sem (grade) <= 13.625  (F31, bin <= 54)  left -> 50, right -> 53
node(26,49,31,54).
left_node(26,49,50).
right_node(26,49,53).
% node 50: Curricular units 2nd sem (enrolled) <= 10.5  (F28, bin <= 8)  left -> 51, right -> 52
node(26,50,28,8).
left_node(26,50,51).
right_node(26,50,52).
% node 51 (leaf): class Graduate (2)
leaf_class(26,51,2).
% node 52 (leaf): class Graduate (2)
leaf_class(26,52,2).
% node 53 (leaf): class Graduate (2)
leaf_class(26,53,2).
% node 54: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 55, right -> 58
node(26,54,16,0).
left_node(26,54,55).
right_node(26,54,58).
% node 55: GDP <= 1.9049999713897705  (F35, bin <= 7)  left -> 56, right -> 57
node(26,55,35,7).
left_node(26,55,56).
right_node(26,55,57).
% node 56 (leaf): class Dropout (0)
leaf_class(26,56,0).
% node 57 (leaf): class Enrolled (1)
leaf_class(26,57,1).
% node 58: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 59, right -> 68
node(26,58,28,5).
left_node(26,58,59).
right_node(26,58,68).
% node 59: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 60, right -> 67
node(26,59,30,3).
left_node(26,59,60).
right_node(26,59,67).
% node 60: Previous qualification (grade) <= 138.5  (F6, bin <= 14)  left -> 61, right -> 66
node(26,60,6,14).
left_node(26,60,61).
right_node(26,60,66).
% node 61: Inflation rate <= 0.550000011920929  (F34, bin <= 3)  left -> 62, right -> 63
node(26,61,34,3).
left_node(26,61,62).
right_node(26,61,63).
% node 62 (leaf): class Graduate (2)
leaf_class(26,62,2).
% node 63: Previous qualification (grade) <= 126.0  (F6, bin <= 3)  left -> 64, right -> 65
node(26,63,6,3).
left_node(26,63,64).
right_node(26,63,65).
% node 64 (leaf): class Graduate (2)
leaf_class(26,64,2).
% node 65 (leaf): class Dropout (0)
leaf_class(26,65,0).
% node 66 (leaf): class Graduate (2)
leaf_class(26,66,2).
% node 67 (leaf): class Graduate (2)
leaf_class(26,67,2).
% node 68 (leaf): class Graduate (2)
leaf_class(26,68,2).

% Tree 27
tree(27).
% node 0: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 1, right -> 24
node(27,0,30,3).
left_node(27,0,1).
right_node(27,0,24).
% node 1: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 2, right -> 7
node(27,1,31,0).
left_node(27,1,2).
right_node(27,1,7).
% node 2: Mother's occupation <= 0.5  (F10, bin <= 0)  left -> 3, right -> 4
node(27,2,10,0).
left_node(27,2,3).
right_node(27,2,4).
% node 3 (leaf): class Dropout (0)
leaf_class(27,3,0).
% node 4: Curricular units 1st sem (enrolled) <= 0.5  (F22, bin <= 0)  left -> 5, right -> 6
node(27,4,22,0).
left_node(27,4,5).
right_node(27,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(27,5,0).
% node 6 (leaf): class Dropout (0)
leaf_class(27,6,0).
% node 7: Age at enrollment <= 25.5  (F19, bin <= 8)  left -> 8, right -> 23
node(27,7,19,8).
left_node(27,7,8).
right_node(27,7,23).
% node 8: Course <= 9246.0  (F3, bin <= 9)  left -> 9, right -> 16
node(27,8,3,9).
left_node(27,8,9).
right_node(27,8,16).
% node 9: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 10, right -> 13
node(27,9,19,3).
left_node(27,9,10).
right_node(27,9,13).
% node 10: Unemployment rate <= 14.699999809265137  (F33, bin <= 10)  left -> 11, right -> 12
node(27,10,33,10).
left_node(27,10,11).
right_node(27,10,12).
% node 11 (leaf): class Enrolled (1)
leaf_class(27,11,1).
% node 12 (leaf): class Dropout (0)
leaf_class(27,12,0).
% node 13: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 14, right -> 15
node(27,13,24,3).
left_node(27,13,14).
right_node(27,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(27,14,0).
% node 15 (leaf): class Enrolled (1)
leaf_class(27,15,1).
% node 16: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 17, right -> 18
node(27,16,16,0).
left_node(27,16,17).
right_node(27,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(27,17,0).
% node 18: Inflation rate <= 0.0  (F34, bin <= 1)  left -> 19, right -> 20
node(27,18,34,1).
left_node(27,18,19).
right_node(27,18,20).
% node 19 (leaf): class Enrolled (1)
leaf_class(27,19,1).
% node 20: Father's qualification <= 26.5  (F9, bin <= 4)  left -> 21, right -> 22
node(27,20,9,4).
left_node(27,20,21).
right_node(27,20,22).
% node 21 (leaf): class Dropout (0)
leaf_class(27,21,0).
% node 22 (leaf): class Dropout (0)
leaf_class(27,22,0).
% node 23 (leaf): class Dropout (0)
leaf_class(27,23,0).
% node 24: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 25, right -> 28
node(27,24,16,0).
left_node(27,24,25).
right_node(27,24,28).
% node 25: Curricular units 2nd sem (credited) <= 0.5  (F27, bin <= 0)  left -> 26, right -> 27
node(27,25,27,0).
left_node(27,25,26).
right_node(27,25,27).
% node 26 (leaf): class Dropout (0)
leaf_class(27,26,0).
% node 27 (leaf): class Dropout (0)
leaf_class(27,27,0).
% node 28: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 29, right -> 44
node(27,28,23,5).
left_node(27,28,29).
right_node(27,28,44).
% node 29: Application mode <= 3.0  (F1, bin <= 0)  left -> 30, right -> 33
node(27,29,1,0).
left_node(27,29,30).
right_node(27,29,33).
% node 30: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 31, right -> 32
node(27,30,30,5).
left_node(27,30,31).
right_node(27,30,32).
% node 31 (leaf): class Graduate (2)
leaf_class(27,31,2).
% node 32 (leaf): class Graduate (2)
leaf_class(27,32,2).
% node 33: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 34, right -> 41
node(27,33,29,6).
left_node(27,33,34).
right_node(27,33,41).
% node 34: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 35, right -> 38
node(27,34,30,4).
left_node(27,34,35).
right_node(27,34,38).
% node 35: Curricular units 1st sem (grade) <= 12.083333492279053  (F25, bin <= 34)  left -> 36, right -> 37
node(27,35,25,34).
left_node(27,35,36).
right_node(27,35,37).
% node 36 (leaf): class Enrolled (1)
leaf_class(27,36,1).
% node 37 (leaf): class Graduate (2)
leaf_class(27,37,2).
% node 38: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 39, right -> 40
node(27,38,30,5).
left_node(27,38,39).
right_node(27,38,40).
% node 39 (leaf): class Graduate (2)
leaf_class(27,39,2).
% node 40 (leaf): class Graduate (2)
leaf_class(27,40,2).
% node 41: Curricular units 1st sem (grade) <= 13.55988073348999  (F25, bin <= 46)  left -> 42, right -> 43
node(27,41,25,46).
left_node(27,41,42).
right_node(27,41,43).
% node 42 (leaf): class Graduate (2)
leaf_class(27,42,2).
% node 43 (leaf): class Graduate (2)
leaf_class(27,43,2).
% node 44: Age at enrollment <= 20.5  (F19, bin <= 2)  left -> 45, right -> 54
node(27,44,19,2).
left_node(27,44,45).
right_node(27,44,54).
% node 45: Curricular units 2nd sem (enrolled) <= 7.5  (F28, bin <= 5)  left -> 46, right -> 49
node(27,45,28,5).
left_node(27,45,46).
right_node(27,45,49).
% node 46: Father's qualification <= 7.0  (F9, bin <= 3)  left -> 47, right -> 48
node(27,46,9,3).
left_node(27,46,47).
right_node(27,46,48).
% node 47 (leaf): class Enrolled (1)
leaf_class(27,47,1).
% node 48 (leaf): class Graduate (2)
leaf_class(27,48,2).
% node 49: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 50, right -> 53
node(27,49,18,0).
left_node(27,49,50).
right_node(27,49,53).
% node 50: Admission grade <= 129.5500030517578  (F12, bin <= 15)  left -> 51, right -> 52
node(27,50,12,15).
left_node(27,50,51).
right_node(27,50,52).
% node 51 (leaf): class Graduate (2)
leaf_class(27,51,2).
% node 52 (leaf): class Enrolled (1)
leaf_class(27,52,1).
% node 53 (leaf): class Graduate (2)
leaf_class(27,53,2).
% node 54: Curricular units 1st sem (grade) <= 11.816666603088379  (F25, bin <= 24)  left -> 55, right -> 60
node(27,54,25,24).
left_node(27,54,55).
right_node(27,54,60).
% node 55: Curricular units 2nd sem (credited) <= 9.5  (F27, bin <= 4)  left -> 56, right -> 59
node(27,55,27,4).
left_node(27,55,56).
right_node(27,55,59).
% node 56: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 57, right -> 58
node(27,56,30,4).
left_node(27,56,57).
right_node(27,56,58).
% node 57 (leaf): class Enrolled (1)
leaf_class(27,57,1).
% node 58 (leaf): class Graduate (2)
leaf_class(27,58,2).
% node 59 (leaf): class Dropout (0)
leaf_class(27,59,0).
% node 60: Curricular units 1st sem (credited) <= 1.5  (F21, bin <= 1)  left -> 61, right -> 64
node(27,60,21,1).
left_node(27,60,61).
right_node(27,60,64).
% node 61: GDP <= -1.3100000321865082  (F35, bin <= 1)  left -> 62, right -> 63
node(27,61,35,1).
left_node(27,61,62).
right_node(27,61,63).
% node 62 (leaf): class Enrolled (1)
leaf_class(27,62,1).
% node 63 (leaf): class Graduate (2)
leaf_class(27,63,2).
% node 64 (leaf): class Graduate (2)
leaf_class(27,64,2).

% Tree 28
tree(28).
% node 0: Debtor <= 0.5  (F15, bin <= 0)  left -> 1, right -> 52
node(28,0,15,0).
left_node(28,0,1).
right_node(28,0,52).
% node 1: Age at enrollment <= 22.5  (F19, bin <= 4)  left -> 2, right -> 35
node(28,1,19,4).
left_node(28,1,2).
right_node(28,1,35).
% node 2: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 3, right -> 8
node(28,2,16,0).
left_node(28,2,3).
right_node(28,2,8).
% node 3: Curricular units 1st sem (grade) <= 12.226190567016602  (F25, bin <= 37)  left -> 4, right -> 5
node(28,3,25,37).
left_node(28,3,4).
right_node(28,3,5).
% node 4 (leaf): class Dropout (0)
leaf_class(28,4,0).
% node 5: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 6, right -> 7
node(28,5,30,5).
left_node(28,5,6).
right_node(28,5,7).
% node 6 (leaf): class Dropout (0)
leaf_class(28,6,0).
% node 7 (leaf): class Graduate (2)
leaf_class(28,7,2).
% node 8: Curricular units 2nd sem (grade) <= 11.154762268066406  (F31, bin <= 20)  left -> 9, right -> 20
node(28,8,31,20).
left_node(28,8,9).
right_node(28,8,20).
% node 9: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 10, right -> 15
node(28,9,28,0).
left_node(28,9,10).
right_node(28,9,15).
% node 10: Application order <= 1.5  (F2, bin <= 0)  left -> 11, right -> 14
node(28,10,2,0).
left_node(28,10,11).
right_node(28,10,14).
% node 11: GDP <= -0.30000001192092896  (F35, bin <= 2)  left -> 12, right -> 13
node(28,11,35,2).
left_node(28,11,12).
right_node(28,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(28,12,0).
% node 13 (leaf): class Graduate (2)
leaf_class(28,13,2).
% node 14 (leaf): class Graduate (2)
leaf_class(28,14,2).
% node 15: Application order <= 3.5  (F2, bin <= 2)  left -> 16, right -> 19
node(28,15,2,2).
left_node(28,15,16).
right_node(28,15,19).
% node 16: Curricular units 2nd sem (evaluations) <= 5.5  (F29, bin <= 2)  left -> 17, right -> 18
node(28,16,29,2).
left_node(28,16,17).
right_node(28,16,18).
% node 17 (leaf): class Dropout (0)
leaf_class(28,17,0).
% node 18 (leaf): class Dropout (0)
leaf_class(28,18,0).
% node 19 (leaf): class Dropout (0)
leaf_class(28,19,0).
% node 20: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 21, right -> 28
node(28,20,22,5).
left_node(28,20,21).
right_node(28,20,28).
% node 21: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 22, right -> 25
node(28,21,18,0).
left_node(28,21,22).
right_node(28,21,25).
% node 22: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 23, right -> 24
node(28,22,24,3).
left_node(28,22,23).
right_node(28,22,24).
% node 23 (leaf): class Enrolled (1)
leaf_class(28,23,1).
% node 24 (leaf): class Graduate (2)
leaf_class(28,24,2).
% node 25: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 26, right -> 27
node(28,25,30,4).
left_node(28,25,26).
right_node(28,25,27).
% node 26 (leaf): class Graduate (2)
leaf_class(28,26,2).
% node 27 (leaf): class Graduate (2)
leaf_class(28,27,2).
% node 28: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 29, right -> 32
node(28,28,30,4).
left_node(28,28,29).
right_node(28,28,32).
% node 29: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 30, right -> 31
node(28,29,30,3).
left_node(28,29,30).
right_node(28,29,31).
% node 30 (leaf): class Enrolled (1)
leaf_class(28,30,1).
% node 31 (leaf): class Graduate (2)
leaf_class(28,31,2).
% node 32: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 33, right -> 34
node(28,32,30,5).
left_node(28,32,33).
right_node(28,32,34).
% node 33 (leaf): class Graduate (2)
leaf_class(28,33,2).
% node 34 (leaf): class Graduate (2)
leaf_class(28,34,2).
% node 35: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 36, right -> 41
node(28,35,30,3).
left_node(28,35,36).
right_node(28,35,41).
% node 36: Previous qualification (grade) <= 130.5  (F6, bin <= 6)  left -> 37, right -> 40
node(28,36,6,6).
left_node(28,36,37).
right_node(28,36,40).
% node 37: Curricular units 1st sem (approved) <= 1.5  (F24, bin <= 1)  left -> 38, right -> 39
node(28,37,24,1).
left_node(28,37,38).
right_node(28,37,39).
% node 38 (leaf): class Dropout (0)
leaf_class(28,38,0).
% node 39 (leaf): class Dropout (0)
leaf_class(28,39,0).
% node 40 (leaf): class Dropout (0)
leaf_class(28,40,0).
% node 41: Curricular units 1st sem (evaluations) <= 8.5  (F23, bin <= 5)  left -> 42, right -> 45
node(28,41,23,5).
left_node(28,41,42).
right_node(28,41,45).
% node 42: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 43, right -> 44
node(28,42,24,4).
left_node(28,42,43).
right_node(28,42,44).
% node 43 (leaf): class Graduate (2)
leaf_class(28,43,2).
% node 44 (leaf): class Graduate (2)
leaf_class(28,44,2).
% node 45: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 46, right -> 47
node(28,45,16,0).
left_node(28,45,46).
right_node(28,45,47).
% node 46 (leaf): class Dropout (0)
leaf_class(28,46,0).
% node 47: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 48, right -> 49
node(28,47,28,3).
left_node(28,47,48).
right_node(28,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(28,48,1).
% node 49: Curricular units 2nd sem (grade) <= 11.348484516143799  (F31, bin <= 27)  left -> 50, right -> 51
node(28,49,31,27).
left_node(28,49,50).
right_node(28,49,51).
% node 50 (leaf): class Dropout (0)
leaf_class(28,50,0).
% node 51 (leaf): class Graduate (2)
leaf_class(28,51,2).
% node 52: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 53, right -> 56
node(28,52,16,0).
left_node(28,52,53).
right_node(28,52,56).
% node 53: Curricular units 2nd sem (grade) <= 12.633333683013916  (F31, bin <= 46)  left -> 54, right -> 55
node(28,53,31,46).
left_node(28,53,54).
right_node(28,53,55).
% node 54 (leaf): class Dropout (0)
leaf_class(28,54,0).
% node 55 (leaf): class Dropout (0)
leaf_class(28,55,0).
% node 56: Mother's occupation <= 111.0  (F10, bin <= 10)  left -> 57, right -> 68
node(28,56,10,10).
left_node(28,56,57).
right_node(28,56,68).
% node 57: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 58, right -> 59
node(28,57,31,0).
left_node(28,57,58).
right_node(28,57,59).
% node 58 (leaf): class Dropout (0)
leaf_class(28,58,0).
% node 59: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 60, right -> 65
node(28,59,30,4).
left_node(28,59,60).
right_node(28,59,65).
% node 60: Inflation rate <= 0.550000011920929  (F34, bin <= 3)  left -> 61, right -> 62
node(28,60,34,3).
left_node(28,60,61).
right_node(28,60,62).
% node 61 (leaf): class Dropout (0)
leaf_class(28,61,0).
% node 62: Displaced <= 0.5  (F13, bin <= 0)  left -> 63, right -> 64
node(28,62,13,0).
left_node(28,62,63).
right_node(28,62,64).
% node 63 (leaf): class Enrolled (1)
leaf_class(28,63,1).
% node 64 (leaf): class Dropout (0)
leaf_class(28,64,0).
% node 65: Curricular units 2nd sem (enrolled) <= 6.5  (F28, bin <= 4)  left -> 66, right -> 67
node(28,65,28,4).
left_node(28,65,66).
right_node(28,65,67).
% node 66 (leaf): class Graduate (2)
leaf_class(28,66,2).
% node 67 (leaf): class Enrolled (1)
leaf_class(28,67,1).
% node 68 (leaf): class Enrolled (1)
leaf_class(28,68,1).

% Tree 29
tree(29).
% node 0: Curricular units 2nd sem (grade) <= 11.038461685180664  (F31, bin <= 16)  left -> 1, right -> 32
node(29,0,31,16).
left_node(29,0,1).
right_node(29,0,32).
% node 1: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 2, right -> 21
node(29,1,24,4).
left_node(29,1,2).
right_node(29,1,21).
% node 2: Curricular units 2nd sem (enrolled) <= 0.5  (F28, bin <= 0)  left -> 3, right -> 10
node(29,2,28,0).
left_node(29,2,3).
right_node(29,2,10).
% node 3: Application order <= 1.5  (F2, bin <= 0)  left -> 4, right -> 7
node(29,3,2,0).
left_node(29,3,4).
right_node(29,3,7).
% node 4: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 5, right -> 6
node(29,4,18,0).
left_node(29,4,5).
right_node(29,4,6).
% node 5 (leaf): class Dropout (0)
leaf_class(29,5,0).
% node 6 (leaf): class Graduate (2)
leaf_class(29,6,2).
% node 7: Gender <= 0.5  (F17, bin <= 0)  left -> 8, right -> 9
node(29,7,17,0).
left_node(29,7,8).
right_node(29,7,9).
% node 8 (leaf): class Enrolled (1)
leaf_class(29,8,1).
% node 9 (leaf): class Graduate (2)
leaf_class(29,9,2).
% node 10: Course <= 9246.0  (F3, bin <= 9)  left -> 11, right -> 18
node(29,10,3,9).
left_node(29,10,11).
right_node(29,10,18).
% node 11: Curricular units 1st sem (evaluations) <= 5.5  (F23, bin <= 2)  left -> 12, right -> 13
node(29,11,23,2).
left_node(29,11,12).
right_node(29,11,13).
% node 12 (leaf): class Dropout (0)
leaf_class(29,12,0).
% node 13: Curricular units 2nd sem (grade) <= 5.0  (F31, bin <= 0)  left -> 14, right -> 15
node(29,13,31,0).
left_node(29,13,14).
right_node(29,13,15).
% node 14 (leaf): class Dropout (0)
leaf_class(29,14,0).
% node 15: Age at enrollment <= 25.0  (F19, bin <= 7)  left -> 16, right -> 17
node(29,15,19,7).
left_node(29,15,16).
right_node(29,15,17).
% node 16 (leaf): class Enrolled (1)
leaf_class(29,16,1).
% node 17 (leaf): class Dropout (0)
leaf_class(29,17,0).
% node 18: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 19, right -> 20
node(29,18,30,3).
left_node(29,18,19).
right_node(29,18,20).
% node 19 (leaf): class Dropout (0)
leaf_class(29,19,0).
% node 20 (leaf): class Dropout (0)
leaf_class(29,20,0).
% node 21: Curricular units 1st sem (enrolled) <= 7.5  (F22, bin <= 7)  left -> 22, right -> 31
node(29,21,22,7).
left_node(29,21,22).
right_node(29,21,31).
% node 22: Curricular units 2nd sem (enrolled) <= 5.5  (F28, bin <= 3)  left -> 23, right -> 24
node(29,22,28,3).
left_node(29,22,23).
right_node(29,22,24).
% node 23 (leaf): class Enrolled (1)
leaf_class(29,23,1).
% node 24: Curricular units 1st sem (evaluations) <= 6.5  (F23, bin <= 3)  left -> 25, right -> 26
node(29,24,23,3).
left_node(29,24,25).
right_node(29,24,26).
% node 25 (leaf): class Dropout (0)
leaf_class(29,25,0).
% node 26: Course <= 9246.0  (F3, bin <= 9)  left -> 27, right -> 30
node(29,26,3,9).
left_node(29,26,27).
right_node(29,26,30).
% node 27: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 28, right -> 29
node(29,27,30,4).
left_node(29,27,28).
right_node(29,27,29).
% node 28 (leaf): class Enrolled (1)
leaf_class(29,28,1).
% node 29 (leaf): class Graduate (2)
leaf_class(29,29,2).
% node 30 (leaf): class Dropout (0)
leaf_class(29,30,0).
% node 31 (leaf): class Enrolled (1)
leaf_class(29,31,1).
% node 32: Curricular units 1st sem (approved) <= 4.5  (F24, bin <= 4)  left -> 33, right -> 50
node(29,32,24,4).
left_node(29,32,33).
right_node(29,32,50).
% node 33: Curricular units 1st sem (approved) <= 3.5  (F24, bin <= 3)  left -> 34, right -> 39
node(29,33,24,3).
left_node(29,33,34).
right_node(29,33,39).
% node 34: Age at enrollment <= 21.5  (F19, bin <= 3)  left -> 35, right -> 38
node(29,34,19,3).
left_node(29,34,35).
right_node(29,34,38).
% node 35: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 36, right -> 37
node(29,35,30,3).
left_node(29,35,36).
right_node(29,35,37).
% node 36 (leaf): class Dropout (0)
leaf_class(29,36,0).
% node 37 (leaf): class Enrolled (1)
leaf_class(29,37,1).
% node 38 (leaf): class Dropout (0)
leaf_class(29,38,0).
% node 39: Unemployment rate <= 10.950000286102295  (F33, bin <= 3)  left -> 40, right -> 45
node(29,39,33,3).
left_node(29,39,40).
right_node(29,39,45).
% node 40: Curricular units 1st sem (evaluations) <= 7.5  (F23, bin <= 4)  left -> 41, right -> 42
node(29,40,23,4).
left_node(29,40,41).
right_node(29,40,42).
% node 41 (leaf): class Graduate (2)
leaf_class(29,41,2).
% node 42: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 43, right -> 44
node(29,42,30,3).
left_node(29,42,43).
right_node(29,42,44).
% node 43 (leaf): class Enrolled (1)
leaf_class(29,43,1).
% node 44 (leaf): class Graduate (2)
leaf_class(29,44,2).
% node 45: Curricular units 2nd sem (approved) <= 3.5  (F30, bin <= 3)  left -> 46, right -> 47
node(29,45,30,3).
left_node(29,45,46).
right_node(29,45,47).
% node 46 (leaf): class Dropout (0)
leaf_class(29,46,0).
% node 47: Age at enrollment <= 19.5  (F19, bin <= 1)  left -> 48, right -> 49
node(29,47,19,1).
left_node(29,47,48).
right_node(29,47,49).
% node 48 (leaf): class Enrolled (1)
leaf_class(29,48,1).
% node 49 (leaf): class Graduate (2)
leaf_class(29,49,2).
% node 50: Curricular units 2nd sem (evaluations) <= 9.5  (F29, bin <= 6)  left -> 51, right -> 62
node(29,50,29,6).
left_node(29,50,51).
right_node(29,50,62).
% node 51: Curricular units 1st sem (evaluations) <= 9.5  (F23, bin <= 6)  left -> 52, right -> 57
node(29,51,23,6).
left_node(29,51,52).
right_node(29,51,57).
% node 52: Curricular units 2nd sem (approved) <= 5.5  (F30, bin <= 5)  left -> 53, right -> 56
node(29,52,30,5).
left_node(29,52,53).
right_node(29,52,56).
% node 53: Curricular units 1st sem (enrolled) <= 5.5  (F22, bin <= 5)  left -> 54, right -> 55
node(29,53,22,5).
left_node(29,53,54).
right_node(29,53,55).
% node 54 (leaf): class Graduate (2)
leaf_class(29,54,2).
% node 55 (leaf): class Graduate (2)
leaf_class(29,55,2).
% node 56 (leaf): class Graduate (2)
leaf_class(29,56,2).
% node 57: Previous qualification (grade) <= 130.5  (F6, bin <= 6)  left -> 58, right -> 59
node(29,57,6,6).
left_node(29,57,58).
right_node(29,57,59).
% node 58 (leaf): class Graduate (2)
leaf_class(29,58,2).
% node 59: Application mode <= 40.5  (F1, bin <= 8)  left -> 60, right -> 61
node(29,59,1,8).
left_node(29,59,60).
right_node(29,59,61).
% node 60 (leaf): class Graduate (2)
leaf_class(29,60,2).
% node 61 (leaf): class Dropout (0)
leaf_class(29,61,0).
% node 62: Curricular units 1st sem (approved) <= 5.5  (F24, bin <= 5)  left -> 63, right -> 70
node(29,62,24,5).
left_node(29,62,63).
right_node(29,62,70).
% node 63: Tuition fees up to date <= 0.5  (F16, bin <= 0)  left -> 64, right -> 65
node(29,63,16,0).
left_node(29,63,64).
right_node(29,63,65).
% node 64 (leaf): class Dropout (0)
leaf_class(29,64,0).
% node 65: Curricular units 2nd sem (approved) <= 4.5  (F30, bin <= 4)  left -> 66, right -> 67
node(29,65,30,4).
left_node(29,65,66).
right_node(29,65,67).
% node 66 (leaf): class Enrolled (1)
leaf_class(29,66,1).
% node 67: Admission grade <= 123.45000076293945  (F12, bin <= 8)  left -> 68, right -> 69
node(29,67,12,8).
left_node(29,67,68).
right_node(29,67,69).
% node 68 (leaf): class Graduate (2)
leaf_class(29,68,2).
% node 69 (leaf): class Dropout (0)
leaf_class(29,69,0).
% node 70: Curricular units 1st sem (grade) <= 11.580277442932129  (F25, bin <= 18)  left -> 71, right -> 74
node(29,70,25,18).
left_node(29,70,71).
right_node(29,70,74).
% node 71: Curricular units 2nd sem (grade) <= 11.651515483856201  (F31, bin <= 34)  left -> 72, right -> 73
node(29,71,31,34).
left_node(29,71,72).
right_node(29,71,73).
% node 72 (leaf): class Dropout (0)
leaf_class(29,72,0).
% node 73 (leaf): class Enrolled (1)
leaf_class(29,73,1).
% node 74: Curricular units 1st sem (approved) <= 15.5  (F24, bin <= 9)  left -> 75, right -> 78
node(29,74,24,9).
left_node(29,74,75).
right_node(29,74,78).
% node 75: Scholarship holder <= 0.5  (F18, bin <= 0)  left -> 76, right -> 77
node(29,75,18,0).
left_node(29,75,76).
right_node(29,75,77).
% node 76 (leaf): class Graduate (2)
leaf_class(29,76,2).
% node 77 (leaf): class Graduate (2)
leaf_class(29,77,2).
% node 78 (leaf): class Graduate (2)
leaf_class(29,78,2).

% --- Class domain ---
class_idx(0).  % Dropout
class_idx(1).  % Enrolled
class_idx(2).  % Graduate
