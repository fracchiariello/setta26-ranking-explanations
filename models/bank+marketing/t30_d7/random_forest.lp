% ============================================================
% random_forest.lp — RF facts for bank+marketing
% 30 trees  |  16 features
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

% Feature 0 ("age"): 23 bins  (thresholds: [22.5, 25.5, 26.5, 27.5, 28.5, 32.5, 34.5, 35.0, 35.5, 43.0, 45.5, 47.5, 48.5, 57.5, 58.5, 59.5, 60.5, 63.5, 65.0, 67.5, 70.0, 70.5])
{bin(I,0,B) : B = 0..22} = 1 :- item(I).

% Feature 1 ("job"): 10 bins  (thresholds: [1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5])
{bin(I,1,B) : B = 0..9} = 1 :- item(I).

% Feature 2 ("marital"): 3 bins  (thresholds: [0.5, 1.5])
{bin(I,2,B) : B = 0..2} = 1 :- item(I).

% Feature 3 ("education"): 4 bins  (thresholds: [0.5, 1.5, 2.5])
{bin(I,3,B) : B = 0..3} = 1 :- item(I).

% Feature 4 ("default"): 2 bins  (thresholds: [0.5])
{bin(I,4,B) : B = 0..1} = 1 :- item(I).

% Feature 5 ("balance"): 41 bins  (thresholds: [-690.0, -242.0, -236.0, -193.5, -8.5, 3.0, 145.5, 188.5, 194.5, 195.5, 197.5, 301.5, 310.5, 386.5, 397.0, 423.0, 477.5, 519.5, 659.5, 675.5, 721.0, 874.0, 894.0, 1019.0, 1185.5, 1207.5, 1214.0, 1343.5, 1546.0, 1612.5, 1762.0, 1876.0, 1894.5, 2094.5, 2306.5, 2447.0, 2775.0, 2798.5, 3620.5, 4428.0])
{bin(I,5,B) : B = 0..40} = 1 :- item(I).

% Feature 6 ("housing"): 2 bins  (thresholds: [0.5])
{bin(I,6,B) : B = 0..1} = 1 :- item(I).

% Feature 7 ("loan"): 2 bins  (thresholds: [0.5])
{bin(I,7,B) : B = 0..1} = 1 :- item(I).

% Feature 8 ("contact"): 2 bins  (thresholds: [0.5])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).

% Feature 9 ("day"): 17 bins  (thresholds: [6.5, 9.0, 9.5, 11.5, 13.5, 14.0, 14.5, 15.0, 15.5, 17.5, 20.5, 21.5, 23.5, 24.5, 25.5, 28.5])
{bin(I,9,B) : B = 0..16} = 1 :- item(I).

% Feature 10 ("month"): 12 bins  (thresholds: [2.5, 3.5, 4.5, 5.5, 6.5, 7.0, 7.5, 8.5, 9.5, 10.5, 11.5])
{bin(I,10,B) : B = 0..11} = 1 :- item(I).

% Feature 11 ("duration"): 108 bins  (thresholds: [154.0, 157.0, 158.0, 160.5, 161.5, 172.5, 176.0, 180.5, 204.5, 206.5, 208.5, 209.0, 210.5, 211.5, 212.0, 219.5, 221.5, 222.0, 222.5, 223.0, 243.5, 247.5, 248.5, 255.5, 256.5, 259.5, 266.5, 288.5, 297.5, 301.0, 321.5, 322.5, 324.5, 334.0, 334.5, 342.5, 349.5, 351.0, 351.5, 365.0, 375.5, 387.5, 390.0, 415.0, 433.5, 434.0, 434.5, 449.5, 465.5, 473.5, 474.5, 476.0, 478.0, 483.5, 505.5, 522.0, 541.0, 546.0, 557.5, 559.0, 561.0, 578.5, 586.5, 617.0, 617.5, 634.5, 637.0, 640.5, 641.0, 642.5, 644.5, 645.5, 646.0, 647.5, 649.0, 649.5, 650.5, 653.5, 656.5, 661.0, 667.0, 685.0, 685.5, 686.0, 696.5, 700.5, 704.0, 718.0, 754.5, 758.0, 758.5, 772.5, 773.5, 774.0, 775.0, 779.5, 786.5, 791.0, 795.5, 801.5, 804.5, 808.5, 868.5, 869.5, 986.0, 1013.0, 1059.0])
{bin(I,11,B) : B = 0..107} = 1 :- item(I).

% Feature 12 ("campaign"): 5 bins  (thresholds: [1.5, 2.5, 3.5, 4.5])
{bin(I,12,B) : B = 0..4} = 1 :- item(I).

% Feature 13 ("pdays"): 27 bins  (thresholds: [0.0, 20.0, 22.5, 31.5, 32.0, 80.5, 81.0, 89.0, 89.5, 96.0, 98.5, 99.5, 100.0, 102.0, 102.5, 105.5, 114.5, 129.0, 133.5, 145.5, 153.0, 189.5, 302.5, 356.5, 370.5, 401.5])
{bin(I,13,B) : B = 0..26} = 1 :- item(I).

% Feature 14 ("previous"): 5 bins  (thresholds: [0.5, 1.5, 3.5, 4.5])
{bin(I,14,B) : B = 0..4} = 1 :- item(I).

% Feature 15 ("poutcome"): 4 bins  (thresholds: [0.5, 1.5, 2.5])
{bin(I,15,B) : B = 0..3} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: "balance" <= 195.5  (F5, bin <= 9)  left -> 1, right -> 10
node(0,0,5,9).
left_node(0,0,1).
right_node(0,0,10).
% node 1: "previous" <= 3.5  (F14, bin <= 2)  left -> 2, right -> 9
node(0,1,14,2).
left_node(0,1,2).
right_node(0,1,9).
% node 2: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 3, right -> 8
node(0,2,15,1).
left_node(0,2,3).
right_node(0,2,8).
% node 3: "duration" <= 474.5  (F11, bin <= 50)  left -> 4, right -> 5
node(0,3,11,50).
left_node(0,3,4).
right_node(0,3,5).
% node 4 (leaf): class no (0)
leaf_class(0,4,0).
% node 5: "duration" <= 795.5  (F11, bin <= 98)  left -> 6, right -> 7
node(0,5,11,98).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class no (0)
leaf_class(0,6,0).
% node 7 (leaf): class yes (1)
leaf_class(0,7,1).
% node 8 (leaf): class no (0)
leaf_class(0,8,0).
% node 9 (leaf): class no (0)
leaf_class(0,9,0).
% node 10: "duration" <= 288.5  (F11, bin <= 27)  left -> 11, right -> 20
node(0,10,11,27).
left_node(0,10,11).
right_node(0,10,20).
% node 11: "duration" <= 221.5  (F11, bin <= 16)  left -> 12, right -> 15
node(0,11,11,16).
left_node(0,11,12).
right_node(0,11,15).
% node 12: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 13, right -> 14
node(0,12,15,2).
left_node(0,12,13).
right_node(0,12,14).
% node 13 (leaf): class no (0)
leaf_class(0,13,0).
% node 14 (leaf): class no (0)
leaf_class(0,14,0).
% node 15: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 16, right -> 19
node(0,15,15,2).
left_node(0,15,16).
right_node(0,15,19).
% node 16: "day" <= 25.5  (F9, bin <= 14)  left -> 17, right -> 18
node(0,16,9,14).
left_node(0,16,17).
right_node(0,16,18).
% node 17 (leaf): class no (0)
leaf_class(0,17,0).
% node 18 (leaf): class no (0)
leaf_class(0,18,0).
% node 19 (leaf): class yes (1)
leaf_class(0,19,1).
% node 20: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 21, right -> 32
node(0,20,15,1).
left_node(0,20,21).
right_node(0,20,32).
% node 21: "contact" <= 0.5  (F8, bin <= 0)  left -> 22, right -> 25
node(0,21,8,0).
left_node(0,21,22).
right_node(0,21,25).
% node 22: "duration" <= 667.0  (F11, bin <= 80)  left -> 23, right -> 24
node(0,22,11,80).
left_node(0,22,23).
right_node(0,22,24).
% node 23 (leaf): class no (0)
leaf_class(0,23,0).
% node 24 (leaf): class yes (1)
leaf_class(0,24,1).
% node 25: "housing" <= 0.5  (F6, bin <= 0)  left -> 26, right -> 27
node(0,25,6,0).
left_node(0,25,26).
right_node(0,25,27).
% node 26 (leaf): class no (0)
leaf_class(0,26,0).
% node 27: "balance" <= 1876.0  (F5, bin <= 31)  left -> 28, right -> 29
node(0,27,5,31).
left_node(0,27,28).
right_node(0,27,29).
% node 28 (leaf): class no (0)
leaf_class(0,28,0).
% node 29: "balance" <= 2775.0  (F5, bin <= 36)  left -> 30, right -> 31
node(0,29,5,36).
left_node(0,29,30).
right_node(0,29,31).
% node 30 (leaf): class yes (1)
leaf_class(0,30,1).
% node 31 (leaf): class no (0)
leaf_class(0,31,0).
% node 32: "housing" <= 0.5  (F6, bin <= 0)  left -> 33, right -> 34
node(0,32,6,0).
left_node(0,32,33).
right_node(0,32,34).
% node 33 (leaf): class yes (1)
leaf_class(0,33,1).
% node 34 (leaf): class yes (1)
leaf_class(0,34,1).

% Tree 1
tree(1).
% node 0: "month" <= 11.5  (F10, bin <= 10)  left -> 1, right -> 22
node(1,0,10,10).
left_node(1,0,1).
right_node(1,0,22).
% node 1: "duration" <= 375.5  (F11, bin <= 40)  left -> 2, right -> 11
node(1,1,11,40).
left_node(1,1,2).
right_node(1,1,11).
% node 2: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 3, right -> 6
node(1,2,15,2).
left_node(1,2,3).
right_node(1,2,6).
% node 3: "age" <= 60.5  (F0, bin <= 16)  left -> 4, right -> 5
node(1,3,0,16).
left_node(1,3,4).
right_node(1,3,5).
% node 4 (leaf): class no (0)
leaf_class(1,4,0).
% node 5 (leaf): class no (0)
leaf_class(1,5,0).
% node 6: "duration" <= 157.0  (F11, bin <= 1)  left -> 7, right -> 8
node(1,6,11,1).
left_node(1,6,7).
right_node(1,6,8).
% node 7 (leaf): class no (0)
leaf_class(1,7,0).
% node 8: "age" <= 35.0  (F0, bin <= 7)  left -> 9, right -> 10
node(1,8,0,7).
left_node(1,8,9).
right_node(1,8,10).
% node 9 (leaf): class no (0)
leaf_class(1,9,0).
% node 10 (leaf): class yes (1)
leaf_class(1,10,1).
% node 11: "housing" <= 0.5  (F6, bin <= 0)  left -> 12, right -> 21
node(1,11,6,0).
left_node(1,11,12).
right_node(1,11,21).
% node 12: "duration" <= 804.5  (F11, bin <= 100)  left -> 13, right -> 20
node(1,12,11,100).
left_node(1,12,13).
right_node(1,12,20).
% node 13: "month" <= 9.5  (F10, bin <= 8)  left -> 14, right -> 19
node(1,13,10,8).
left_node(1,13,14).
right_node(1,13,19).
% node 14: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 15, right -> 18
node(1,14,15,1).
left_node(1,14,15).
right_node(1,14,18).
% node 15: "age" <= 59.5  (F0, bin <= 15)  left -> 16, right -> 17
node(1,15,0,15).
left_node(1,15,16).
right_node(1,15,17).
% node 16 (leaf): class no (0)
leaf_class(1,16,0).
% node 17 (leaf): class yes (1)
leaf_class(1,17,1).
% node 18 (leaf): class yes (1)
leaf_class(1,18,1).
% node 19 (leaf): class yes (1)
leaf_class(1,19,1).
% node 20 (leaf): class yes (1)
leaf_class(1,20,1).
% node 21 (leaf): class no (0)
leaf_class(1,21,0).
% node 22 (leaf): class yes (1)
leaf_class(1,22,1).

% Tree 2
tree(2).
% node 0: "pdays" <= 22.5  (F13, bin <= 2)  left -> 1, right -> 16
node(2,0,13,2).
left_node(2,0,1).
right_node(2,0,16).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 3
node(2,1,8,0).
left_node(2,1,2).
right_node(2,1,3).
% node 2 (leaf): class no (0)
leaf_class(2,2,0).
% node 3: "duration" <= 644.5  (F11, bin <= 70)  left -> 4, right -> 11
node(2,3,11,70).
left_node(2,3,4).
right_node(2,3,11).
% node 4: "age" <= 60.5  (F0, bin <= 16)  left -> 5, right -> 10
node(2,4,0,16).
left_node(2,4,5).
right_node(2,4,10).
% node 5: "duration" <= 297.5  (F11, bin <= 28)  left -> 6, right -> 9
node(2,5,11,28).
left_node(2,5,6).
right_node(2,5,9).
% node 6: "month" <= 6.5  (F10, bin <= 4)  left -> 7, right -> 8
node(2,6,10,4).
left_node(2,6,7).
right_node(2,6,8).
% node 7 (leaf): class no (0)
leaf_class(2,7,0).
% node 8 (leaf): class no (0)
leaf_class(2,8,0).
% node 9 (leaf): class no (0)
leaf_class(2,9,0).
% node 10 (leaf): class no (0)
leaf_class(2,10,0).
% node 11: "job" <= 4.5  (F1, bin <= 3)  left -> 12, right -> 13
node(2,11,1,3).
left_node(2,11,12).
right_node(2,11,13).
% node 12 (leaf): class no (0)
leaf_class(2,12,0).
% node 13: "campaign" <= 3.5  (F12, bin <= 2)  left -> 14, right -> 15
node(2,13,12,2).
left_node(2,13,14).
right_node(2,13,15).
% node 14 (leaf): class yes (1)
leaf_class(2,14,1).
% node 15 (leaf): class yes (1)
leaf_class(2,15,1).
% node 16: "pdays" <= 98.5  (F13, bin <= 10)  left -> 17, right -> 20
node(2,16,13,10).
left_node(2,16,17).
right_node(2,16,20).
% node 17: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 18, right -> 19
node(2,17,15,1).
left_node(2,17,18).
right_node(2,17,19).
% node 18 (leaf): class no (0)
leaf_class(2,18,0).
% node 19 (leaf): class yes (1)
leaf_class(2,19,1).
% node 20: "pdays" <= 302.5  (F13, bin <= 22)  left -> 21, right -> 30
node(2,20,13,22).
left_node(2,20,21).
right_node(2,20,30).
% node 21: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 22, right -> 29
node(2,21,15,2).
left_node(2,21,22).
right_node(2,21,29).
% node 22: "day" <= 23.5  (F9, bin <= 12)  left -> 23, right -> 28
node(2,22,9,12).
left_node(2,22,23).
right_node(2,22,28).
% node 23: "balance" <= 4428.0  (F5, bin <= 39)  left -> 24, right -> 27
node(2,23,5,39).
left_node(2,23,24).
right_node(2,23,27).
% node 24: "duration" <= 321.5  (F11, bin <= 30)  left -> 25, right -> 26
node(2,24,11,30).
left_node(2,24,25).
right_node(2,24,26).
% node 25 (leaf): class no (0)
leaf_class(2,25,0).
% node 26 (leaf): class yes (1)
leaf_class(2,26,1).
% node 27 (leaf): class no (0)
leaf_class(2,27,0).
% node 28 (leaf): class no (0)
leaf_class(2,28,0).
% node 29 (leaf): class yes (1)
leaf_class(2,29,1).
% node 30 (leaf): class no (0)
leaf_class(2,30,0).

% Tree 3
tree(3).
% node 0: "previous" <= 1.5  (F14, bin <= 1)  left -> 1, right -> 28
node(3,0,14,1).
left_node(3,0,1).
right_node(3,0,28).
% node 1: "age" <= 60.5  (F0, bin <= 16)  left -> 2, right -> 23
node(3,1,0,16).
left_node(3,1,2).
right_node(3,1,23).
% node 2: "marital" <= 1.5  (F2, bin <= 1)  left -> 3, right -> 14
node(3,2,2,1).
left_node(3,2,3).
right_node(3,2,14).
% node 3: "default" <= 0.5  (F4, bin <= 0)  left -> 4, right -> 11
node(3,3,4,0).
left_node(3,3,4).
right_node(3,3,11).
% node 4: "job" <= 4.5  (F1, bin <= 3)  left -> 5, right -> 6
node(3,4,1,3).
left_node(3,4,5).
right_node(3,4,6).
% node 5 (leaf): class no (0)
leaf_class(3,5,0).
% node 6: "duration" <= 434.0  (F11, bin <= 45)  left -> 7, right -> 10
node(3,6,11,45).
left_node(3,6,7).
right_node(3,6,10).
% node 7: "previous" <= 0.5  (F14, bin <= 0)  left -> 8, right -> 9
node(3,7,14,0).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class no (0)
leaf_class(3,8,0).
% node 9 (leaf): class no (0)
leaf_class(3,9,0).
% node 10 (leaf): class no (0)
leaf_class(3,10,0).
% node 11: "duration" <= 176.0  (F11, bin <= 6)  left -> 12, right -> 13
node(3,11,11,6).
left_node(3,11,12).
right_node(3,11,13).
% node 12 (leaf): class no (0)
leaf_class(3,12,0).
% node 13 (leaf): class no (0)
leaf_class(3,13,0).
% node 14: "age" <= 22.5  (F0, bin <= 0)  left -> 15, right -> 16
node(3,14,0,0).
left_node(3,14,15).
right_node(3,14,16).
% node 15 (leaf): class no (0)
leaf_class(3,15,0).
% node 16: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 17, right -> 22
node(3,16,15,1).
left_node(3,16,17).
right_node(3,16,22).
% node 17: "poutcome" <= 0.5  (F15, bin <= 0)  left -> 18, right -> 21
node(3,17,15,0).
left_node(3,17,18).
right_node(3,17,21).
% node 18: "duration" <= 704.0  (F11, bin <= 86)  left -> 19, right -> 20
node(3,18,11,86).
left_node(3,18,19).
right_node(3,18,20).
% node 19 (leaf): class no (0)
leaf_class(3,19,0).
% node 20 (leaf): class yes (1)
leaf_class(3,20,1).
% node 21 (leaf): class no (0)
leaf_class(3,21,0).
% node 22 (leaf): class no (0)
leaf_class(3,22,0).
% node 23: "job" <= 5.5  (F1, bin <= 4)  left -> 24, right -> 25
node(3,23,1,4).
left_node(3,23,24).
right_node(3,23,25).
% node 24 (leaf): class no (0)
leaf_class(3,24,0).
% node 25: "day" <= 15.5  (F9, bin <= 8)  left -> 26, right -> 27
node(3,25,9,8).
left_node(3,25,26).
right_node(3,25,27).
% node 26 (leaf): class no (0)
leaf_class(3,26,0).
% node 27 (leaf): class yes (1)
leaf_class(3,27,1).
% node 28: "balance" <= 1894.5  (F5, bin <= 32)  left -> 29, right -> 40
node(3,28,5,32).
left_node(3,28,29).
right_node(3,28,40).
% node 29: "pdays" <= 189.5  (F13, bin <= 21)  left -> 30, right -> 35
node(3,29,13,21).
left_node(3,29,30).
right_node(3,29,35).
% node 30: "duration" <= 210.5  (F11, bin <= 12)  left -> 31, right -> 32
node(3,30,11,12).
left_node(3,30,31).
right_node(3,30,32).
% node 31 (leaf): class no (0)
leaf_class(3,31,0).
% node 32: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 33, right -> 34
node(3,32,15,2).
left_node(3,32,33).
right_node(3,32,34).
% node 33 (leaf): class no (0)
leaf_class(3,33,0).
% node 34 (leaf): class yes (1)
leaf_class(3,34,1).
% node 35: "month" <= 6.5  (F10, bin <= 4)  left -> 36, right -> 39
node(3,35,10,4).
left_node(3,35,36).
right_node(3,35,39).
% node 36: "duration" <= 449.5  (F11, bin <= 47)  left -> 37, right -> 38
node(3,36,11,47).
left_node(3,36,37).
right_node(3,36,38).
% node 37 (leaf): class no (0)
leaf_class(3,37,0).
% node 38 (leaf): class no (0)
leaf_class(3,38,0).
% node 39 (leaf): class no (0)
leaf_class(3,39,0).
% node 40: "housing" <= 0.5  (F6, bin <= 0)  left -> 41, right -> 44
node(3,40,6,0).
left_node(3,40,41).
right_node(3,40,44).
% node 41: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 42, right -> 43
node(3,41,15,2).
left_node(3,41,42).
right_node(3,41,43).
% node 42 (leaf): class no (0)
leaf_class(3,42,0).
% node 43 (leaf): class yes (1)
leaf_class(3,43,1).
% node 44: "balance" <= 4428.0  (F5, bin <= 39)  left -> 45, right -> 46
node(3,44,5,39).
left_node(3,44,45).
right_node(3,44,46).
% node 45 (leaf): class yes (1)
leaf_class(3,45,1).
% node 46 (leaf): class no (0)
leaf_class(3,46,0).

% Tree 4
tree(4).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 26
node(4,0,15,2).
left_node(4,0,1).
right_node(4,0,26).
% node 1: "duration" <= 645.5  (F11, bin <= 71)  left -> 2, right -> 19
node(4,1,11,71).
left_node(4,1,2).
right_node(4,1,19).
% node 2: "month" <= 4.5  (F10, bin <= 2)  left -> 3, right -> 8
node(4,2,10,2).
left_node(4,2,3).
right_node(4,2,8).
% node 3: "marital" <= 0.5  (F2, bin <= 0)  left -> 4, right -> 7
node(4,3,2,0).
left_node(4,3,4).
right_node(4,3,7).
% node 4: "age" <= 47.5  (F0, bin <= 11)  left -> 5, right -> 6
node(4,4,0,11).
left_node(4,4,5).
right_node(4,4,6).
% node 5 (leaf): class no (0)
leaf_class(4,5,0).
% node 6 (leaf): class yes (1)
leaf_class(4,6,1).
% node 7 (leaf): class no (0)
leaf_class(4,7,0).
% node 8: "age" <= 67.5  (F0, bin <= 19)  left -> 9, right -> 18
node(4,8,0,19).
left_node(4,8,9).
right_node(4,8,18).
% node 9: "previous" <= 0.5  (F14, bin <= 0)  left -> 10, right -> 15
node(4,9,14,0).
left_node(4,9,10).
right_node(4,9,15).
% node 10: "age" <= 28.5  (F0, bin <= 4)  left -> 11, right -> 12
node(4,10,0,4).
left_node(4,10,11).
right_node(4,10,12).
% node 11 (leaf): class no (0)
leaf_class(4,11,0).
% node 12: "duration" <= 351.0  (F11, bin <= 37)  left -> 13, right -> 14
node(4,12,11,37).
left_node(4,12,13).
right_node(4,12,14).
% node 13 (leaf): class no (0)
leaf_class(4,13,0).
% node 14 (leaf): class no (0)
leaf_class(4,14,0).
% node 15: "age" <= 27.5  (F0, bin <= 3)  left -> 16, right -> 17
node(4,15,0,3).
left_node(4,15,16).
right_node(4,15,17).
% node 16 (leaf): class no (0)
leaf_class(4,16,0).
% node 17 (leaf): class no (0)
leaf_class(4,17,0).
% node 18 (leaf): class no (0)
leaf_class(4,18,0).
% node 19: "job" <= 4.5  (F1, bin <= 3)  left -> 20, right -> 21
node(4,19,1,3).
left_node(4,19,20).
right_node(4,19,21).
% node 20 (leaf): class no (0)
leaf_class(4,20,0).
% node 21: "duration" <= 775.0  (F11, bin <= 94)  left -> 22, right -> 25
node(4,21,11,94).
left_node(4,21,22).
right_node(4,21,25).
% node 22: "duration" <= 718.0  (F11, bin <= 87)  left -> 23, right -> 24
node(4,22,11,87).
left_node(4,22,23).
right_node(4,22,24).
% node 23 (leaf): class yes (1)
leaf_class(4,23,1).
% node 24 (leaf): class no (0)
leaf_class(4,24,0).
% node 25 (leaf): class yes (1)
leaf_class(4,25,1).
% node 26 (leaf): class yes (1)
leaf_class(4,26,1).

% Tree 5
tree(5).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 26
node(5,0,15,2).
left_node(5,0,1).
right_node(5,0,26).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 9
node(5,1,8,0).
left_node(5,1,2).
right_node(5,1,9).
% node 2: "balance" <= 386.5  (F5, bin <= 13)  left -> 3, right -> 4
node(5,2,5,13).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class no (0)
leaf_class(5,3,0).
% node 4: "day" <= 11.5  (F9, bin <= 3)  left -> 5, right -> 8
node(5,4,9,3).
left_node(5,4,5).
right_node(5,4,8).
% node 5: "duration" <= 541.0  (F11, bin <= 56)  left -> 6, right -> 7
node(5,5,11,56).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class no (0)
leaf_class(5,6,0).
% node 7 (leaf): class yes (1)
leaf_class(5,7,1).
% node 8 (leaf): class no (0)
leaf_class(5,8,0).
% node 9: "pdays" <= 401.5  (F13, bin <= 25)  left -> 10, right -> 25
node(5,9,13,25).
left_node(5,9,10).
right_node(5,9,25).
% node 10: "age" <= 58.5  (F0, bin <= 14)  left -> 11, right -> 18
node(5,10,0,14).
left_node(5,10,11).
right_node(5,10,18).
% node 11: "housing" <= 0.5  (F6, bin <= 0)  left -> 12, right -> 17
node(5,11,6,0).
left_node(5,11,12).
right_node(5,11,17).
% node 12: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 13, right -> 16
node(5,12,15,1).
left_node(5,12,13).
right_node(5,12,16).
% node 13: "age" <= 25.5  (F0, bin <= 1)  left -> 14, right -> 15
node(5,13,0,1).
left_node(5,13,14).
right_node(5,13,15).
% node 14 (leaf): class no (0)
leaf_class(5,14,0).
% node 15 (leaf): class no (0)
leaf_class(5,15,0).
% node 16 (leaf): class no (0)
leaf_class(5,16,0).
% node 17 (leaf): class no (0)
leaf_class(5,17,0).
% node 18: "previous" <= 1.5  (F14, bin <= 1)  left -> 19, right -> 24
node(5,18,14,1).
left_node(5,18,19).
right_node(5,18,24).
% node 19: "job" <= 5.5  (F1, bin <= 4)  left -> 20, right -> 21
node(5,19,1,4).
left_node(5,19,20).
right_node(5,19,21).
% node 20 (leaf): class no (0)
leaf_class(5,20,0).
% node 21: "duration" <= 208.5  (F11, bin <= 10)  left -> 22, right -> 23
node(5,21,11,10).
left_node(5,21,22).
right_node(5,21,23).
% node 22 (leaf): class no (0)
leaf_class(5,22,0).
% node 23 (leaf): class yes (1)
leaf_class(5,23,1).
% node 24 (leaf): class no (0)
leaf_class(5,24,0).
% node 25 (leaf): class no (0)
leaf_class(5,25,0).
% node 26 (leaf): class yes (1)
leaf_class(5,26,1).

% Tree 6
tree(6).
% node 0: "age" <= 60.5  (F0, bin <= 16)  left -> 1, right -> 42
node(6,0,0,16).
left_node(6,0,1).
right_node(6,0,42).
% node 1: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 2, right -> 39
node(6,1,15,2).
left_node(6,1,2).
right_node(6,1,39).
% node 2: "marital" <= 1.5  (F2, bin <= 1)  left -> 3, right -> 18
node(6,2,2,1).
left_node(6,2,3).
right_node(6,2,18).
% node 3: "duration" <= 434.5  (F11, bin <= 46)  left -> 4, right -> 9
node(6,3,11,46).
left_node(6,3,4).
right_node(6,3,9).
% node 4: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 5, right -> 6
node(6,4,15,1).
left_node(6,4,5).
right_node(6,4,6).
% node 5 (leaf): class no (0)
leaf_class(6,5,0).
% node 6: "month" <= 7.0  (F10, bin <= 5)  left -> 7, right -> 8
node(6,6,10,5).
left_node(6,6,7).
right_node(6,6,8).
% node 7 (leaf): class no (0)
leaf_class(6,7,0).
% node 8 (leaf): class no (0)
leaf_class(6,8,0).
% node 9: "campaign" <= 3.5  (F12, bin <= 2)  left -> 10, right -> 15
node(6,9,12,2).
left_node(6,9,10).
right_node(6,9,15).
% node 10: "duration" <= 774.0  (F11, bin <= 93)  left -> 11, right -> 14
node(6,10,11,93).
left_node(6,10,11).
right_node(6,10,14).
% node 11: "job" <= 2.5  (F1, bin <= 1)  left -> 12, right -> 13
node(6,11,1,1).
left_node(6,11,12).
right_node(6,11,13).
% node 12 (leaf): class no (0)
leaf_class(6,12,0).
% node 13 (leaf): class no (0)
leaf_class(6,13,0).
% node 14 (leaf): class no (0)
leaf_class(6,14,0).
% node 15: "duration" <= 578.5  (F11, bin <= 61)  left -> 16, right -> 17
node(6,15,11,61).
left_node(6,15,16).
right_node(6,15,17).
% node 16 (leaf): class no (0)
leaf_class(6,16,0).
% node 17 (leaf): class yes (1)
leaf_class(6,17,1).
% node 18: "job" <= 6.5  (F1, bin <= 5)  left -> 19, right -> 26
node(6,18,1,5).
left_node(6,18,19).
right_node(6,18,26).
% node 19: "balance" <= 675.5  (F5, bin <= 19)  left -> 20, right -> 21
node(6,19,5,19).
left_node(6,19,20).
right_node(6,19,21).
% node 20 (leaf): class no (0)
leaf_class(6,20,0).
% node 21: "duration" <= 209.0  (F11, bin <= 11)  left -> 22, right -> 23
node(6,21,11,11).
left_node(6,21,22).
right_node(6,21,23).
% node 22 (leaf): class no (0)
leaf_class(6,22,0).
% node 23: "poutcome" <= 0.5  (F15, bin <= 0)  left -> 24, right -> 25
node(6,23,15,0).
left_node(6,23,24).
right_node(6,23,25).
% node 24 (leaf): class no (0)
leaf_class(6,24,0).
% node 25 (leaf): class yes (1)
leaf_class(6,25,1).
% node 26: "balance" <= 2306.5  (F5, bin <= 34)  left -> 27, right -> 34
node(6,26,5,34).
left_node(6,26,27).
right_node(6,26,34).
% node 27: "housing" <= 0.5  (F6, bin <= 0)  left -> 28, right -> 31
node(6,27,6,0).
left_node(6,27,28).
right_node(6,27,31).
% node 28: "duration" <= 522.0  (F11, bin <= 55)  left -> 29, right -> 30
node(6,28,11,55).
left_node(6,28,29).
right_node(6,28,30).
% node 29 (leaf): class no (0)
leaf_class(6,29,0).
% node 30 (leaf): class yes (1)
leaf_class(6,30,1).
% node 31: "duration" <= 415.0  (F11, bin <= 43)  left -> 32, right -> 33
node(6,31,11,43).
left_node(6,31,32).
right_node(6,31,33).
% node 32 (leaf): class no (0)
leaf_class(6,32,0).
% node 33 (leaf): class no (0)
leaf_class(6,33,0).
% node 34: "job" <= 8.5  (F1, bin <= 7)  left -> 35, right -> 36
node(6,34,1,7).
left_node(6,34,35).
right_node(6,34,36).
% node 35 (leaf): class yes (1)
leaf_class(6,35,1).
% node 36: "duration" <= 301.0  (F11, bin <= 29)  left -> 37, right -> 38
node(6,36,11,29).
left_node(6,36,37).
right_node(6,36,38).
% node 37 (leaf): class no (0)
leaf_class(6,37,0).
% node 38 (leaf): class no (0)
leaf_class(6,38,0).
% node 39: "duration" <= 248.5  (F11, bin <= 22)  left -> 40, right -> 41
node(6,39,11,22).
left_node(6,39,40).
right_node(6,39,41).
% node 40 (leaf): class no (0)
leaf_class(6,40,0).
% node 41 (leaf): class yes (1)
leaf_class(6,41,1).
% node 42: "age" <= 63.5  (F0, bin <= 17)  left -> 43, right -> 44
node(6,42,0,17).
left_node(6,42,43).
right_node(6,42,44).
% node 43 (leaf): class yes (1)
leaf_class(6,43,1).
% node 44 (leaf): class no (0)
leaf_class(6,44,0).

% Tree 7
tree(7).
% node 0: "duration" <= 473.5  (F11, bin <= 49)  left -> 1, right -> 14
node(7,0,11,49).
left_node(7,0,1).
right_node(7,0,14).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 3
node(7,1,8,0).
left_node(7,1,2).
right_node(7,1,3).
% node 2 (leaf): class no (0)
leaf_class(7,2,0).
% node 3: "campaign" <= 4.5  (F12, bin <= 3)  left -> 4, right -> 13
node(7,3,12,3).
left_node(7,3,4).
right_node(7,3,13).
% node 4: "duration" <= 211.5  (F11, bin <= 13)  left -> 5, right -> 6
node(7,4,11,13).
left_node(7,4,5).
right_node(7,4,6).
% node 5 (leaf): class no (0)
leaf_class(7,5,0).
% node 6: "loan" <= 0.5  (F7, bin <= 0)  left -> 7, right -> 12
node(7,6,7,0).
left_node(7,6,7).
right_node(7,6,12).
% node 7: "age" <= 60.5  (F0, bin <= 16)  left -> 8, right -> 11
node(7,7,0,16).
left_node(7,7,8).
right_node(7,7,11).
% node 8: "pdays" <= 81.0  (F13, bin <= 6)  left -> 9, right -> 10
node(7,8,13,6).
left_node(7,8,9).
right_node(7,8,10).
% node 9 (leaf): class no (0)
leaf_class(7,9,0).
% node 10 (leaf): class no (0)
leaf_class(7,10,0).
% node 11 (leaf): class yes (1)
leaf_class(7,11,1).
% node 12 (leaf): class no (0)
leaf_class(7,12,0).
% node 13 (leaf): class no (0)
leaf_class(7,13,0).
% node 14: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 15, right -> 26
node(7,14,15,1).
left_node(7,14,15).
right_node(7,14,26).
% node 15: "housing" <= 0.5  (F6, bin <= 0)  left -> 16, right -> 17
node(7,15,6,0).
left_node(7,15,16).
right_node(7,15,17).
% node 16 (leaf): class no (0)
leaf_class(7,16,0).
% node 17: "duration" <= 700.5  (F11, bin <= 85)  left -> 18, right -> 23
node(7,17,11,85).
left_node(7,17,18).
right_node(7,17,23).
% node 18: "job" <= 8.5  (F1, bin <= 7)  left -> 19, right -> 22
node(7,18,1,7).
left_node(7,18,19).
right_node(7,18,22).
% node 19: "education" <= 2.5  (F3, bin <= 2)  left -> 20, right -> 21
node(7,19,3,2).
left_node(7,19,20).
right_node(7,19,21).
% node 20 (leaf): class no (0)
leaf_class(7,20,0).
% node 21 (leaf): class yes (1)
leaf_class(7,21,1).
% node 22 (leaf): class no (0)
leaf_class(7,22,0).
% node 23: "campaign" <= 2.5  (F12, bin <= 1)  left -> 24, right -> 25
node(7,23,12,1).
left_node(7,23,24).
right_node(7,23,25).
% node 24 (leaf): class no (0)
leaf_class(7,24,0).
% node 25 (leaf): class yes (1)
leaf_class(7,25,1).
% node 26 (leaf): class yes (1)
leaf_class(7,26,1).

% Tree 8
tree(8).
% node 0: "previous" <= 1.5  (F14, bin <= 1)  left -> 1, right -> 22
node(8,0,14,1).
left_node(8,0,1).
right_node(8,0,22).
% node 1: "duration" <= 351.5  (F11, bin <= 38)  left -> 2, right -> 11
node(8,1,11,38).
left_node(8,1,2).
right_node(8,1,11).
% node 2: "housing" <= 0.5  (F6, bin <= 0)  left -> 3, right -> 10
node(8,2,6,0).
left_node(8,2,3).
right_node(8,2,10).
% node 3: "poutcome" <= 0.5  (F15, bin <= 0)  left -> 4, right -> 5
node(8,3,15,0).
left_node(8,3,4).
right_node(8,3,5).
% node 4 (leaf): class no (0)
leaf_class(8,4,0).
% node 5: "campaign" <= 1.5  (F12, bin <= 0)  left -> 6, right -> 9
node(8,5,12,0).
left_node(8,5,6).
right_node(8,5,9).
% node 6: "duration" <= 161.5  (F11, bin <= 4)  left -> 7, right -> 8
node(8,6,11,4).
left_node(8,6,7).
right_node(8,6,8).
% node 7 (leaf): class no (0)
leaf_class(8,7,0).
% node 8 (leaf): class yes (1)
leaf_class(8,8,1).
% node 9 (leaf): class no (0)
leaf_class(8,9,0).
% node 10 (leaf): class no (0)
leaf_class(8,10,0).
% node 11: "duration" <= 868.5  (F11, bin <= 102)  left -> 12, right -> 21
node(8,11,11,102).
left_node(8,11,12).
right_node(8,11,21).
% node 12: "campaign" <= 1.5  (F12, bin <= 0)  left -> 13, right -> 18
node(8,12,12,0).
left_node(8,12,13).
right_node(8,12,18).
% node 13: "duration" <= 433.5  (F11, bin <= 44)  left -> 14, right -> 15
node(8,13,11,44).
left_node(8,13,14).
right_node(8,13,15).
% node 14 (leaf): class no (0)
leaf_class(8,14,0).
% node 15: "balance" <= -8.5  (F5, bin <= 4)  left -> 16, right -> 17
node(8,15,5,4).
left_node(8,15,16).
right_node(8,15,17).
% node 16 (leaf): class yes (1)
leaf_class(8,16,1).
% node 17 (leaf): class no (0)
leaf_class(8,17,0).
% node 18: "month" <= 7.5  (F10, bin <= 6)  left -> 19, right -> 20
node(8,18,10,6).
left_node(8,18,19).
right_node(8,18,20).
% node 19 (leaf): class no (0)
leaf_class(8,19,0).
% node 20 (leaf): class no (0)
leaf_class(8,20,0).
% node 21 (leaf): class yes (1)
leaf_class(8,21,1).
% node 22: "duration" <= 247.5  (F11, bin <= 21)  left -> 23, right -> 28
node(8,22,11,21).
left_node(8,22,23).
right_node(8,22,28).
% node 23: "education" <= 1.5  (F3, bin <= 1)  left -> 24, right -> 25
node(8,23,3,1).
left_node(8,23,24).
right_node(8,23,25).
% node 24 (leaf): class no (0)
leaf_class(8,24,0).
% node 25: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 26, right -> 27
node(8,25,15,2).
left_node(8,25,26).
right_node(8,25,27).
% node 26 (leaf): class no (0)
leaf_class(8,26,0).
% node 27 (leaf): class yes (1)
leaf_class(8,27,1).
% node 28: "day" <= 14.5  (F9, bin <= 6)  left -> 29, right -> 34
node(8,28,9,6).
left_node(8,28,29).
right_node(8,28,34).
% node 29: "previous" <= 4.5  (F14, bin <= 3)  left -> 30, right -> 33
node(8,29,14,3).
left_node(8,29,30).
right_node(8,29,33).
% node 30: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 31, right -> 32
node(8,30,15,2).
left_node(8,30,31).
right_node(8,30,32).
% node 31 (leaf): class no (0)
leaf_class(8,31,0).
% node 32 (leaf): class yes (1)
leaf_class(8,32,1).
% node 33 (leaf): class yes (1)
leaf_class(8,33,1).
% node 34 (leaf): class yes (1)
leaf_class(8,34,1).

% Tree 9
tree(9).
% node 0: "pdays" <= 31.5  (F13, bin <= 3)  left -> 1, right -> 26
node(9,0,13,3).
left_node(9,0,1).
right_node(9,0,26).
% node 1: "balance" <= 197.5  (F5, bin <= 10)  left -> 2, right -> 11
node(9,1,5,10).
left_node(9,1,2).
right_node(9,1,11).
% node 2: "balance" <= 145.5  (F5, bin <= 6)  left -> 3, right -> 10
node(9,2,5,6).
left_node(9,2,3).
right_node(9,2,10).
% node 3: "duration" <= 986.0  (F11, bin <= 104)  left -> 4, right -> 9
node(9,3,11,104).
left_node(9,3,4).
right_node(9,3,9).
% node 4: "loan" <= 0.5  (F7, bin <= 0)  left -> 5, right -> 8
node(9,4,7,0).
left_node(9,4,5).
right_node(9,4,8).
% node 5: "duration" <= 478.0  (F11, bin <= 52)  left -> 6, right -> 7
node(9,5,11,52).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class no (0)
leaf_class(9,6,0).
% node 7 (leaf): class no (0)
leaf_class(9,7,0).
% node 8 (leaf): class no (0)
leaf_class(9,8,0).
% node 9 (leaf): class yes (1)
leaf_class(9,9,1).
% node 10 (leaf): class no (0)
leaf_class(9,10,0).
% node 11: "month" <= 7.5  (F10, bin <= 6)  left -> 12, right -> 19
node(9,11,10,6).
left_node(9,11,12).
right_node(9,11,19).
% node 12: "age" <= 67.5  (F0, bin <= 19)  left -> 13, right -> 18
node(9,12,0,19).
left_node(9,12,13).
right_node(9,12,18).
% node 13: "month" <= 4.5  (F10, bin <= 2)  left -> 14, right -> 17
node(9,13,10,2).
left_node(9,13,14).
right_node(9,13,17).
% node 14: "duration" <= 586.5  (F11, bin <= 62)  left -> 15, right -> 16
node(9,14,11,62).
left_node(9,14,15).
right_node(9,14,16).
% node 15 (leaf): class no (0)
leaf_class(9,15,0).
% node 16 (leaf): class yes (1)
leaf_class(9,16,1).
% node 17 (leaf): class no (0)
leaf_class(9,17,0).
% node 18 (leaf): class yes (1)
leaf_class(9,18,1).
% node 19: "duration" <= 483.5  (F11, bin <= 53)  left -> 20, right -> 25
node(9,19,11,53).
left_node(9,19,20).
right_node(9,19,25).
% node 20: "job" <= 5.5  (F1, bin <= 4)  left -> 21, right -> 22
node(9,20,1,4).
left_node(9,20,21).
right_node(9,20,22).
% node 21 (leaf): class no (0)
leaf_class(9,21,0).
% node 22: "duration" <= 212.0  (F11, bin <= 14)  left -> 23, right -> 24
node(9,22,11,14).
left_node(9,22,23).
right_node(9,22,24).
% node 23 (leaf): class no (0)
leaf_class(9,23,0).
% node 24 (leaf): class no (0)
leaf_class(9,24,0).
% node 25 (leaf): class yes (1)
leaf_class(9,25,1).
% node 26: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 27, right -> 38
node(9,26,15,2).
left_node(9,26,27).
right_node(9,26,38).
% node 27: "duration" <= 641.0  (F11, bin <= 68)  left -> 28, right -> 37
node(9,27,11,68).
left_node(9,27,28).
right_node(9,27,37).
% node 28: "pdays" <= 102.5  (F13, bin <= 14)  left -> 29, right -> 32
node(9,28,13,14).
left_node(9,28,29).
right_node(9,28,32).
% node 29: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 30, right -> 31
node(9,29,15,1).
left_node(9,29,30).
right_node(9,29,31).
% node 30 (leaf): class no (0)
leaf_class(9,30,0).
% node 31 (leaf): class yes (1)
leaf_class(9,31,1).
% node 32: "duration" <= 222.0  (F11, bin <= 17)  left -> 33, right -> 34
node(9,32,11,17).
left_node(9,32,33).
right_node(9,32,34).
% node 33 (leaf): class no (0)
leaf_class(9,33,0).
% node 34: "balance" <= 1612.5  (F5, bin <= 29)  left -> 35, right -> 36
node(9,34,5,29).
left_node(9,34,35).
right_node(9,34,36).
% node 35 (leaf): class no (0)
leaf_class(9,35,0).
% node 36 (leaf): class no (0)
leaf_class(9,36,0).
% node 37 (leaf): class yes (1)
leaf_class(9,37,1).
% node 38 (leaf): class yes (1)
leaf_class(9,38,1).

% Tree 10
tree(10).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 24
node(10,0,15,2).
left_node(10,0,1).
right_node(10,0,24).
% node 1: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 2, right -> 21
node(10,1,15,1).
left_node(10,1,2).
right_node(10,1,21).
% node 2: "duration" <= 634.5  (F11, bin <= 65)  left -> 3, right -> 10
node(10,2,11,65).
left_node(10,2,3).
right_node(10,2,10).
% node 3: "pdays" <= 370.5  (F13, bin <= 24)  left -> 4, right -> 9
node(10,3,13,24).
left_node(10,3,4).
right_node(10,3,9).
% node 4: "balance" <= 1185.5  (F5, bin <= 24)  left -> 5, right -> 6
node(10,4,5,24).
left_node(10,4,5).
right_node(10,4,6).
% node 5 (leaf): class no (0)
leaf_class(10,5,0).
% node 6: "age" <= 60.5  (F0, bin <= 16)  left -> 7, right -> 8
node(10,6,0,16).
left_node(10,6,7).
right_node(10,6,8).
% node 7 (leaf): class no (0)
leaf_class(10,7,0).
% node 8 (leaf): class no (0)
leaf_class(10,8,0).
% node 9 (leaf): class yes (1)
leaf_class(10,9,1).
% node 10: "campaign" <= 2.5  (F12, bin <= 1)  left -> 11, right -> 16
node(10,10,12,1).
left_node(10,10,11).
right_node(10,10,16).
% node 11: "age" <= 35.5  (F0, bin <= 8)  left -> 12, right -> 15
node(10,11,0,8).
left_node(10,11,12).
right_node(10,11,15).
% node 12: "contact" <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(10,12,8,0).
left_node(10,12,13).
right_node(10,12,14).
% node 13 (leaf): class no (0)
leaf_class(10,13,0).
% node 14 (leaf): class yes (1)
leaf_class(10,14,1).
% node 15 (leaf): class no (0)
leaf_class(10,15,0).
% node 16: "month" <= 7.5  (F10, bin <= 6)  left -> 17, right -> 20
node(10,16,10,6).
left_node(10,16,17).
right_node(10,16,20).
% node 17: "balance" <= 188.5  (F5, bin <= 7)  left -> 18, right -> 19
node(10,17,5,7).
left_node(10,17,18).
right_node(10,17,19).
% node 18 (leaf): class no (0)
leaf_class(10,18,0).
% node 19 (leaf): class yes (1)
leaf_class(10,19,1).
% node 20 (leaf): class yes (1)
leaf_class(10,20,1).
% node 21: "duration" <= 342.5  (F11, bin <= 35)  left -> 22, right -> 23
node(10,21,11,35).
left_node(10,21,22).
right_node(10,21,23).
% node 22 (leaf): class no (0)
leaf_class(10,22,0).
% node 23 (leaf): class yes (1)
leaf_class(10,23,1).
% node 24: "duration" <= 255.5  (F11, bin <= 23)  left -> 25, right -> 26
node(10,24,11,23).
left_node(10,24,25).
right_node(10,24,26).
% node 25 (leaf): class no (0)
leaf_class(10,25,0).
% node 26 (leaf): class yes (1)
leaf_class(10,26,1).

% Tree 11
tree(11).
% node 0: "balance" <= 477.5  (F5, bin <= 16)  left -> 1, right -> 8
node(11,0,5,16).
left_node(11,0,1).
right_node(11,0,8).
% node 1: "duration" <= 476.0  (F11, bin <= 51)  left -> 2, right -> 5
node(11,1,11,51).
left_node(11,1,2).
right_node(11,1,5).
% node 2: "month" <= 4.5  (F10, bin <= 2)  left -> 3, right -> 4
node(11,2,10,2).
left_node(11,2,3).
right_node(11,2,4).
% node 3 (leaf): class no (0)
leaf_class(11,3,0).
% node 4 (leaf): class no (0)
leaf_class(11,4,0).
% node 5: "loan" <= 0.5  (F7, bin <= 0)  left -> 6, right -> 7
node(11,5,7,0).
left_node(11,5,6).
right_node(11,5,7).
% node 6 (leaf): class no (0)
leaf_class(11,6,0).
% node 7 (leaf): class no (0)
leaf_class(11,7,0).
% node 8: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 9, right -> 24
node(11,8,15,2).
left_node(11,8,9).
right_node(11,8,24).
% node 9: "housing" <= 0.5  (F6, bin <= 0)  left -> 10, right -> 17
node(11,9,6,0).
left_node(11,9,10).
right_node(11,9,17).
% node 10: "balance" <= 519.5  (F5, bin <= 17)  left -> 11, right -> 12
node(11,10,5,17).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class yes (1)
leaf_class(11,11,1).
% node 12: "age" <= 59.5  (F0, bin <= 15)  left -> 13, right -> 16
node(11,12,0,15).
left_node(11,12,13).
right_node(11,12,16).
% node 13: "duration" <= 617.0  (F11, bin <= 63)  left -> 14, right -> 15
node(11,13,11,63).
left_node(11,13,14).
right_node(11,13,15).
% node 14 (leaf): class no (0)
leaf_class(11,14,0).
% node 15 (leaf): class yes (1)
leaf_class(11,15,1).
% node 16 (leaf): class no (0)
leaf_class(11,16,0).
% node 17: "duration" <= 685.5  (F11, bin <= 82)  left -> 18, right -> 23
node(11,17,11,82).
left_node(11,17,18).
right_node(11,17,23).
% node 18: "pdays" <= 356.5  (F13, bin <= 23)  left -> 19, right -> 22
node(11,18,13,23).
left_node(11,18,19).
right_node(11,18,22).
% node 19: "duration" <= 223.0  (F11, bin <= 19)  left -> 20, right -> 21
node(11,19,11,19).
left_node(11,19,20).
right_node(11,19,21).
% node 20 (leaf): class no (0)
leaf_class(11,20,0).
% node 21 (leaf): class no (0)
leaf_class(11,21,0).
% node 22 (leaf): class no (0)
leaf_class(11,22,0).
% node 23 (leaf): class yes (1)
leaf_class(11,23,1).
% node 24 (leaf): class yes (1)
leaf_class(11,24,1).

% Tree 12
tree(12).
% node 0: "pdays" <= 32.0  (F13, bin <= 4)  left -> 1, right -> 22
node(12,0,13,4).
left_node(12,0,1).
right_node(12,0,22).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 3
node(12,1,8,0).
left_node(12,1,2).
right_node(12,1,3).
% node 2 (leaf): class no (0)
leaf_class(12,2,0).
% node 3: "balance" <= -236.0  (F5, bin <= 2)  left -> 4, right -> 5
node(12,3,5,2).
left_node(12,3,4).
right_node(12,3,5).
% node 4 (leaf): class no (0)
leaf_class(12,4,0).
% node 5: "balance" <= 659.5  (F5, bin <= 18)  left -> 6, right -> 11
node(12,5,5,18).
left_node(12,5,6).
right_node(12,5,11).
% node 6: "duration" <= 791.0  (F11, bin <= 97)  left -> 7, right -> 10
node(12,6,11,97).
left_node(12,6,7).
right_node(12,6,10).
% node 7: "duration" <= 546.0  (F11, bin <= 57)  left -> 8, right -> 9
node(12,7,11,57).
left_node(12,7,8).
right_node(12,7,9).
% node 8 (leaf): class no (0)
leaf_class(12,8,0).
% node 9 (leaf): class no (0)
leaf_class(12,9,0).
% node 10 (leaf): class yes (1)
leaf_class(12,10,1).
% node 11: "campaign" <= 1.5  (F12, bin <= 0)  left -> 12, right -> 17
node(12,11,12,0).
left_node(12,11,12).
right_node(12,11,17).
% node 12: "balance" <= 721.0  (F5, bin <= 20)  left -> 13, right -> 14
node(12,12,5,20).
left_node(12,12,13).
right_node(12,12,14).
% node 13 (leaf): class no (0)
leaf_class(12,13,0).
% node 14: "duration" <= 206.5  (F11, bin <= 9)  left -> 15, right -> 16
node(12,14,11,9).
left_node(12,14,15).
right_node(12,14,16).
% node 15 (leaf): class no (0)
leaf_class(12,15,0).
% node 16 (leaf): class no (0)
leaf_class(12,16,0).
% node 17: "age" <= 60.5  (F0, bin <= 16)  left -> 18, right -> 21
node(12,17,0,16).
left_node(12,17,18).
right_node(12,17,21).
% node 18: "duration" <= 617.5  (F11, bin <= 64)  left -> 19, right -> 20
node(12,18,11,64).
left_node(12,18,19).
right_node(12,18,20).
% node 19 (leaf): class no (0)
leaf_class(12,19,0).
% node 20 (leaf): class yes (1)
leaf_class(12,20,1).
% node 21 (leaf): class no (0)
leaf_class(12,21,0).
% node 22: "balance" <= 1019.0  (F5, bin <= 23)  left -> 23, right -> 36
node(12,22,5,23).
left_node(12,22,23).
right_node(12,22,36).
% node 23: "pdays" <= 102.0  (F13, bin <= 13)  left -> 24, right -> 27
node(12,23,13,13).
left_node(12,23,24).
right_node(12,23,27).
% node 24: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 25, right -> 26
node(12,24,15,2).
left_node(12,24,25).
right_node(12,24,26).
% node 25 (leaf): class no (0)
leaf_class(12,25,0).
% node 26 (leaf): class yes (1)
leaf_class(12,26,1).
% node 27: "month" <= 5.5  (F10, bin <= 3)  left -> 28, right -> 33
node(12,27,10,3).
left_node(12,27,28).
right_node(12,27,33).
% node 28: "job" <= 1.5  (F1, bin <= 0)  left -> 29, right -> 30
node(12,28,1,0).
left_node(12,28,29).
right_node(12,28,30).
% node 29 (leaf): class no (0)
leaf_class(12,29,0).
% node 30: "duration" <= 559.0  (F11, bin <= 59)  left -> 31, right -> 32
node(12,30,11,59).
left_node(12,30,31).
right_node(12,30,32).
% node 31 (leaf): class no (0)
leaf_class(12,31,0).
% node 32 (leaf): class no (0)
leaf_class(12,32,0).
% node 33: "day" <= 20.5  (F9, bin <= 10)  left -> 34, right -> 35
node(12,33,9,10).
left_node(12,33,34).
right_node(12,33,35).
% node 34 (leaf): class no (0)
leaf_class(12,34,0).
% node 35 (leaf): class yes (1)
leaf_class(12,35,1).
% node 36: "balance" <= 1343.5  (F5, bin <= 27)  left -> 37, right -> 38
node(12,36,5,27).
left_node(12,36,37).
right_node(12,36,38).
% node 37 (leaf): class yes (1)
leaf_class(12,37,1).
% node 38: "pdays" <= 99.5  (F13, bin <= 11)  left -> 39, right -> 42
node(12,38,13,11).
left_node(12,38,39).
right_node(12,38,42).
% node 39: "pdays" <= 89.0  (F13, bin <= 7)  left -> 40, right -> 41
node(12,39,13,7).
left_node(12,39,40).
right_node(12,39,41).
% node 40 (leaf): class no (0)
leaf_class(12,40,0).
% node 41 (leaf): class yes (1)
leaf_class(12,41,1).
% node 42: "duration" <= 256.5  (F11, bin <= 24)  left -> 43, right -> 44
node(12,42,11,24).
left_node(12,42,43).
right_node(12,42,44).
% node 43 (leaf): class no (0)
leaf_class(12,43,0).
% node 44: "duration" <= 656.5  (F11, bin <= 78)  left -> 45, right -> 46
node(12,44,11,78).
left_node(12,44,45).
right_node(12,44,46).
% node 45 (leaf): class no (0)
leaf_class(12,45,0).
% node 46 (leaf): class yes (1)
leaf_class(12,46,1).

% Tree 13
tree(13).
% node 0: "contact" <= 0.5  (F8, bin <= 0)  left -> 1, right -> 2
node(13,0,8,0).
left_node(13,0,1).
right_node(13,0,2).
% node 1 (leaf): class no (0)
leaf_class(13,1,0).
% node 2: "campaign" <= 4.5  (F12, bin <= 3)  left -> 3, right -> 34
node(13,2,12,3).
left_node(13,2,3).
right_node(13,2,34).
% node 3: "previous" <= 1.5  (F14, bin <= 1)  left -> 4, right -> 19
node(13,3,14,1).
left_node(13,3,4).
right_node(13,3,19).
% node 4: "job" <= 4.5  (F1, bin <= 3)  left -> 5, right -> 10
node(13,4,1,3).
left_node(13,4,5).
right_node(13,4,10).
% node 5: "balance" <= -242.0  (F5, bin <= 1)  left -> 6, right -> 7
node(13,5,5,1).
left_node(13,5,6).
right_node(13,5,7).
% node 6 (leaf): class no (0)
leaf_class(13,6,0).
% node 7: "duration" <= 387.5  (F11, bin <= 41)  left -> 8, right -> 9
node(13,7,11,41).
left_node(13,7,8).
right_node(13,7,9).
% node 8 (leaf): class no (0)
leaf_class(13,8,0).
% node 9 (leaf): class no (0)
leaf_class(13,9,0).
% node 10: "month" <= 6.5  (F10, bin <= 4)  left -> 11, right -> 14
node(13,10,10,4).
left_node(13,10,11).
right_node(13,10,14).
% node 11: "marital" <= 0.5  (F2, bin <= 0)  left -> 12, right -> 13
node(13,11,2,0).
left_node(13,11,12).
right_node(13,11,13).
% node 12 (leaf): class no (0)
leaf_class(13,12,0).
% node 13 (leaf): class no (0)
leaf_class(13,13,0).
% node 14: "duration" <= 334.5  (F11, bin <= 34)  left -> 15, right -> 16
node(13,14,11,34).
left_node(13,14,15).
right_node(13,14,16).
% node 15 (leaf): class no (0)
leaf_class(13,15,0).
% node 16: "duration" <= 808.5  (F11, bin <= 101)  left -> 17, right -> 18
node(13,16,11,101).
left_node(13,16,17).
right_node(13,16,18).
% node 17 (leaf): class no (0)
leaf_class(13,17,0).
% node 18 (leaf): class yes (1)
leaf_class(13,18,1).
% node 19: "pdays" <= 98.5  (F13, bin <= 10)  left -> 20, right -> 25
node(13,19,13,10).
left_node(13,19,20).
right_node(13,19,25).
% node 20: "education" <= 2.5  (F3, bin <= 2)  left -> 21, right -> 22
node(13,20,3,2).
left_node(13,20,21).
right_node(13,20,22).
% node 21 (leaf): class yes (1)
leaf_class(13,21,1).
% node 22: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 23, right -> 24
node(13,22,15,1).
left_node(13,22,23).
right_node(13,22,24).
% node 23 (leaf): class no (0)
leaf_class(13,23,0).
% node 24 (leaf): class yes (1)
leaf_class(13,24,1).
% node 25: "age" <= 45.5  (F0, bin <= 10)  left -> 26, right -> 31
node(13,25,0,10).
left_node(13,25,26).
right_node(13,25,31).
% node 26: "pdays" <= 133.5  (F13, bin <= 18)  left -> 27, right -> 28
node(13,26,13,18).
left_node(13,26,27).
right_node(13,26,28).
% node 27 (leaf): class no (0)
leaf_class(13,27,0).
% node 28: "duration" <= 322.5  (F11, bin <= 31)  left -> 29, right -> 30
node(13,28,11,31).
left_node(13,28,29).
right_node(13,28,30).
% node 29 (leaf): class no (0)
leaf_class(13,29,0).
% node 30 (leaf): class no (0)
leaf_class(13,30,0).
% node 31: "duration" <= 266.5  (F11, bin <= 26)  left -> 32, right -> 33
node(13,31,11,26).
left_node(13,31,32).
right_node(13,31,33).
% node 32 (leaf): class no (0)
leaf_class(13,32,0).
% node 33 (leaf): class yes (1)
leaf_class(13,33,1).
% node 34: "duration" <= 640.5  (F11, bin <= 67)  left -> 35, right -> 36
node(13,34,11,67).
left_node(13,34,35).
right_node(13,34,36).
% node 35 (leaf): class no (0)
leaf_class(13,35,0).
% node 36 (leaf): class yes (1)
leaf_class(13,36,1).

% Tree 14
tree(14).
% node 0: "age" <= 58.5  (F0, bin <= 14)  left -> 1, right -> 36
node(14,0,0,14).
left_node(14,0,1).
right_node(14,0,36).
% node 1: "duration" <= 645.5  (F11, bin <= 71)  left -> 2, right -> 23
node(14,1,11,71).
left_node(14,1,2).
right_node(14,1,23).
% node 2: "pdays" <= 31.5  (F13, bin <= 3)  left -> 3, right -> 14
node(14,2,13,3).
left_node(14,2,3).
right_node(14,2,14).
% node 3: "duration" <= 334.0  (F11, bin <= 33)  left -> 4, right -> 11
node(14,3,11,33).
left_node(14,3,4).
right_node(14,3,11).
% node 4: "contact" <= 0.5  (F8, bin <= 0)  left -> 5, right -> 6
node(14,4,8,0).
left_node(14,4,5).
right_node(14,4,6).
% node 5 (leaf): class no (0)
leaf_class(14,5,0).
% node 6: "month" <= 4.5  (F10, bin <= 2)  left -> 7, right -> 10
node(14,6,10,2).
left_node(14,6,7).
right_node(14,6,10).
% node 7: "balance" <= 2094.5  (F5, bin <= 33)  left -> 8, right -> 9
node(14,7,5,33).
left_node(14,7,8).
right_node(14,7,9).
% node 8 (leaf): class no (0)
leaf_class(14,8,0).
% node 9 (leaf): class no (0)
leaf_class(14,9,0).
% node 10 (leaf): class no (0)
leaf_class(14,10,0).
% node 11: "marital" <= 1.5  (F2, bin <= 1)  left -> 12, right -> 13
node(14,11,2,1).
left_node(14,11,12).
right_node(14,11,13).
% node 12 (leaf): class no (0)
leaf_class(14,12,0).
% node 13 (leaf): class no (0)
leaf_class(14,13,0).
% node 14: "day" <= 20.5  (F9, bin <= 10)  left -> 15, right -> 20
node(14,14,9,10).
left_node(14,14,15).
right_node(14,14,20).
% node 15: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 16, right -> 19
node(14,15,15,2).
left_node(14,15,16).
right_node(14,15,19).
% node 16: "age" <= 26.5  (F0, bin <= 2)  left -> 17, right -> 18
node(14,16,0,2).
left_node(14,16,17).
right_node(14,16,18).
% node 17 (leaf): class no (0)
leaf_class(14,17,0).
% node 18 (leaf): class no (0)
leaf_class(14,18,0).
% node 19 (leaf): class yes (1)
leaf_class(14,19,1).
% node 20: "housing" <= 0.5  (F6, bin <= 0)  left -> 21, right -> 22
node(14,20,6,0).
left_node(14,20,21).
right_node(14,20,22).
% node 21 (leaf): class no (0)
leaf_class(14,21,0).
% node 22 (leaf): class no (0)
leaf_class(14,22,0).
% node 23: "campaign" <= 1.5  (F12, bin <= 0)  left -> 24, right -> 25
node(14,23,12,0).
left_node(14,23,24).
right_node(14,23,25).
% node 24 (leaf): class no (0)
leaf_class(14,24,0).
% node 25: "housing" <= 0.5  (F6, bin <= 0)  left -> 26, right -> 29
node(14,25,6,0).
left_node(14,25,26).
right_node(14,25,29).
% node 26: "balance" <= 310.5  (F5, bin <= 12)  left -> 27, right -> 28
node(14,26,5,12).
left_node(14,26,27).
right_node(14,26,28).
% node 27 (leaf): class no (0)
leaf_class(14,27,0).
% node 28 (leaf): class yes (1)
leaf_class(14,28,1).
% node 29: "poutcome" <= 0.5  (F15, bin <= 0)  left -> 30, right -> 35
node(14,29,15,0).
left_node(14,29,30).
right_node(14,29,35).
% node 30: "education" <= 2.5  (F3, bin <= 2)  left -> 31, right -> 34
node(14,30,3,2).
left_node(14,30,31).
right_node(14,30,34).
% node 31: "balance" <= 1546.0  (F5, bin <= 28)  left -> 32, right -> 33
node(14,31,5,28).
left_node(14,31,32).
right_node(14,31,33).
% node 32 (leaf): class no (0)
leaf_class(14,32,0).
% node 33 (leaf): class yes (1)
leaf_class(14,33,1).
% node 34 (leaf): class yes (1)
leaf_class(14,34,1).
% node 35 (leaf): class yes (1)
leaf_class(14,35,1).
% node 36: "duration" <= 180.5  (F11, bin <= 7)  left -> 37, right -> 38
node(14,36,11,7).
left_node(14,36,37).
right_node(14,36,38).
% node 37 (leaf): class no (0)
leaf_class(14,37,0).
% node 38: "month" <= 2.5  (F10, bin <= 0)  left -> 39, right -> 40
node(14,38,10,0).
left_node(14,38,39).
right_node(14,38,40).
% node 39 (leaf): class yes (1)
leaf_class(14,39,1).
% node 40: "duration" <= 696.5  (F11, bin <= 84)  left -> 41, right -> 42
node(14,40,11,84).
left_node(14,40,41).
right_node(14,40,42).
% node 41 (leaf): class no (0)
leaf_class(14,41,0).
% node 42 (leaf): class yes (1)
leaf_class(14,42,1).

% Tree 15
tree(15).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 28
node(15,0,15,2).
left_node(15,0,1).
right_node(15,0,28).
% node 1: "duration" <= 634.5  (F11, bin <= 65)  left -> 2, right -> 17
node(15,1,11,65).
left_node(15,1,2).
right_node(15,1,17).
% node 2: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 3, right -> 14
node(15,2,15,1).
left_node(15,2,3).
right_node(15,2,14).
% node 3: "duration" <= 211.5  (F11, bin <= 13)  left -> 4, right -> 7
node(15,3,11,13).
left_node(15,3,4).
right_node(15,3,7).
% node 4: "age" <= 70.5  (F0, bin <= 21)  left -> 5, right -> 6
node(15,4,0,21).
left_node(15,4,5).
right_node(15,4,6).
% node 5 (leaf): class no (0)
leaf_class(15,5,0).
% node 6 (leaf): class no (0)
leaf_class(15,6,0).
% node 7: "contact" <= 0.5  (F8, bin <= 0)  left -> 8, right -> 9
node(15,7,8,0).
left_node(15,7,8).
right_node(15,7,9).
% node 8 (leaf): class no (0)
leaf_class(15,8,0).
% node 9: "age" <= 60.5  (F0, bin <= 16)  left -> 10, right -> 13
node(15,9,0,16).
left_node(15,9,10).
right_node(15,9,13).
% node 10: "campaign" <= 1.5  (F12, bin <= 0)  left -> 11, right -> 12
node(15,10,12,0).
left_node(15,10,11).
right_node(15,10,12).
% node 11 (leaf): class no (0)
leaf_class(15,11,0).
% node 12 (leaf): class no (0)
leaf_class(15,12,0).
% node 13 (leaf): class no (0)
leaf_class(15,13,0).
% node 14: "pdays" <= 102.5  (F13, bin <= 14)  left -> 15, right -> 16
node(15,14,13,14).
left_node(15,14,15).
right_node(15,14,16).
% node 15 (leaf): class no (0)
leaf_class(15,15,0).
% node 16 (leaf): class no (0)
leaf_class(15,16,0).
% node 17: "month" <= 10.5  (F10, bin <= 9)  left -> 18, right -> 27
node(15,17,10,9).
left_node(15,17,18).
right_node(15,17,27).
% node 18: "duration" <= 758.5  (F11, bin <= 90)  left -> 19, right -> 20
node(15,18,11,90).
left_node(15,18,19).
right_node(15,18,20).
% node 19 (leaf): class no (0)
leaf_class(15,19,0).
% node 20: "marital" <= 1.5  (F2, bin <= 1)  left -> 21, right -> 26
node(15,20,2,1).
left_node(15,20,21).
right_node(15,20,26).
% node 21: "day" <= 6.5  (F9, bin <= 0)  left -> 22, right -> 23
node(15,21,9,0).
left_node(15,21,22).
right_node(15,21,23).
% node 22 (leaf): class yes (1)
leaf_class(15,22,1).
% node 23: "month" <= 5.5  (F10, bin <= 3)  left -> 24, right -> 25
node(15,23,10,3).
left_node(15,23,24).
right_node(15,23,25).
% node 24 (leaf): class no (0)
leaf_class(15,24,0).
% node 25 (leaf): class yes (1)
leaf_class(15,25,1).
% node 26 (leaf): class yes (1)
leaf_class(15,26,1).
% node 27 (leaf): class no (0)
leaf_class(15,27,0).
% node 28 (leaf): class yes (1)
leaf_class(15,28,1).

% Tree 16
tree(16).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 30
node(16,0,15,2).
left_node(16,0,1).
right_node(16,0,30).
% node 1: "duration" <= 433.5  (F11, bin <= 44)  left -> 2, right -> 9
node(16,1,11,44).
left_node(16,1,2).
right_node(16,1,9).
% node 2: "housing" <= 0.5  (F6, bin <= 0)  left -> 3, right -> 8
node(16,2,6,0).
left_node(16,2,3).
right_node(16,2,8).
% node 3: "age" <= 70.5  (F0, bin <= 21)  left -> 4, right -> 7
node(16,3,0,21).
left_node(16,3,4).
right_node(16,3,7).
% node 4: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 5, right -> 6
node(16,4,15,1).
left_node(16,4,5).
right_node(16,4,6).
% node 5 (leaf): class no (0)
leaf_class(16,5,0).
% node 6 (leaf): class no (0)
leaf_class(16,6,0).
% node 7 (leaf): class no (0)
leaf_class(16,7,0).
% node 8 (leaf): class no (0)
leaf_class(16,8,0).
% node 9: "month" <= 5.5  (F10, bin <= 3)  left -> 10, right -> 19
node(16,9,10,3).
left_node(16,9,10).
right_node(16,9,19).
% node 10: "age" <= 58.5  (F0, bin <= 14)  left -> 11, right -> 18
node(16,10,0,14).
left_node(16,10,11).
right_node(16,10,18).
% node 11: "contact" <= 0.5  (F8, bin <= 0)  left -> 12, right -> 13
node(16,11,8,0).
left_node(16,11,12).
right_node(16,11,13).
% node 12 (leaf): class no (0)
leaf_class(16,12,0).
% node 13: "day" <= 17.5  (F9, bin <= 9)  left -> 14, right -> 17
node(16,13,9,9).
left_node(16,13,14).
right_node(16,13,17).
% node 14: "previous" <= 1.5  (F14, bin <= 1)  left -> 15, right -> 16
node(16,14,14,1).
left_node(16,14,15).
right_node(16,14,16).
% node 15 (leaf): class no (0)
leaf_class(16,15,0).
% node 16 (leaf): class no (0)
leaf_class(16,16,0).
% node 17 (leaf): class yes (1)
leaf_class(16,17,1).
% node 18 (leaf): class yes (1)
leaf_class(16,18,1).
% node 19: "housing" <= 0.5  (F6, bin <= 0)  left -> 20, right -> 23
node(16,19,6,0).
left_node(16,19,20).
right_node(16,19,23).
% node 20: "loan" <= 0.5  (F7, bin <= 0)  left -> 21, right -> 22
node(16,20,7,0).
left_node(16,20,21).
right_node(16,20,22).
% node 21 (leaf): class yes (1)
leaf_class(16,21,1).
% node 22 (leaf): class no (0)
leaf_class(16,22,0).
% node 23: "balance" <= 2447.0  (F5, bin <= 35)  left -> 24, right -> 29
node(16,23,5,35).
left_node(16,23,24).
right_node(16,23,29).
% node 24: "job" <= 7.5  (F1, bin <= 6)  left -> 25, right -> 28
node(16,24,1,6).
left_node(16,24,25).
right_node(16,24,28).
% node 25: "duration" <= 1013.0  (F11, bin <= 105)  left -> 26, right -> 27
node(16,25,11,105).
left_node(16,25,26).
right_node(16,25,27).
% node 26 (leaf): class no (0)
leaf_class(16,26,0).
% node 27 (leaf): class yes (1)
leaf_class(16,27,1).
% node 28 (leaf): class yes (1)
leaf_class(16,28,1).
% node 29 (leaf): class no (0)
leaf_class(16,29,0).
% node 30 (leaf): class yes (1)
leaf_class(16,30,1).

% Tree 17
tree(17).
% node 0: "duration" <= 650.5  (F11, bin <= 76)  left -> 1, right -> 30
node(17,0,11,76).
left_node(17,0,1).
right_node(17,0,30).
% node 1: "pdays" <= 22.5  (F13, bin <= 2)  left -> 2, right -> 7
node(17,1,13,2).
left_node(17,1,2).
right_node(17,1,7).
% node 2: "duration" <= 349.5  (F11, bin <= 36)  left -> 3, right -> 4
node(17,2,11,36).
left_node(17,2,3).
right_node(17,2,4).
% node 3 (leaf): class no (0)
leaf_class(17,3,0).
% node 4: "age" <= 27.5  (F0, bin <= 3)  left -> 5, right -> 6
node(17,4,0,3).
left_node(17,4,5).
right_node(17,4,6).
% node 5 (leaf): class yes (1)
leaf_class(17,5,1).
% node 6 (leaf): class no (0)
leaf_class(17,6,0).
% node 7: "pdays" <= 100.0  (F13, bin <= 12)  left -> 8, right -> 15
node(17,7,13,12).
left_node(17,7,8).
right_node(17,7,15).
% node 8: "pdays" <= 80.5  (F13, bin <= 5)  left -> 9, right -> 10
node(17,8,13,5).
left_node(17,8,9).
right_node(17,8,10).
% node 9 (leaf): class yes (1)
leaf_class(17,9,1).
% node 10: "pdays" <= 89.5  (F13, bin <= 8)  left -> 11, right -> 12
node(17,10,13,8).
left_node(17,10,11).
right_node(17,10,12).
% node 11 (leaf): class no (0)
leaf_class(17,11,0).
% node 12: "day" <= 15.0  (F9, bin <= 7)  left -> 13, right -> 14
node(17,12,9,7).
left_node(17,12,13).
right_node(17,12,14).
% node 13 (leaf): class yes (1)
leaf_class(17,13,1).
% node 14 (leaf): class no (0)
leaf_class(17,14,0).
% node 15: "housing" <= 0.5  (F6, bin <= 0)  left -> 16, right -> 25
node(17,15,6,0).
left_node(17,15,16).
right_node(17,15,25).
% node 16: "month" <= 5.5  (F10, bin <= 3)  left -> 17, right -> 22
node(17,16,10,3).
left_node(17,16,17).
right_node(17,16,22).
% node 17: "day" <= 9.0  (F9, bin <= 1)  left -> 18, right -> 19
node(17,17,9,1).
left_node(17,17,18).
right_node(17,17,19).
% node 18 (leaf): class no (0)
leaf_class(17,18,0).
% node 19: "duration" <= 154.0  (F11, bin <= 0)  left -> 20, right -> 21
node(17,19,11,0).
left_node(17,19,20).
right_node(17,19,21).
% node 20 (leaf): class no (0)
leaf_class(17,20,0).
% node 21 (leaf): class no (0)
leaf_class(17,21,0).
% node 22: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 23, right -> 24
node(17,22,15,2).
left_node(17,22,23).
right_node(17,22,24).
% node 23 (leaf): class no (0)
leaf_class(17,23,0).
% node 24 (leaf): class yes (1)
leaf_class(17,24,1).
% node 25: "month" <= 5.5  (F10, bin <= 3)  left -> 26, right -> 27
node(17,25,10,3).
left_node(17,25,26).
right_node(17,25,27).
% node 26 (leaf): class no (0)
leaf_class(17,26,0).
% node 27: "month" <= 10.5  (F10, bin <= 9)  left -> 28, right -> 29
node(17,27,10,9).
left_node(17,27,28).
right_node(17,27,29).
% node 28 (leaf): class yes (1)
leaf_class(17,28,1).
% node 29 (leaf): class no (0)
leaf_class(17,29,0).
% node 30: "campaign" <= 4.5  (F12, bin <= 3)  left -> 31, right -> 38
node(17,30,12,3).
left_node(17,30,31).
right_node(17,30,38).
% node 31: "pdays" <= 129.0  (F13, bin <= 17)  left -> 32, right -> 37
node(17,31,13,17).
left_node(17,31,32).
right_node(17,31,37).
% node 32: "housing" <= 0.5  (F6, bin <= 0)  left -> 33, right -> 34
node(17,32,6,0).
left_node(17,32,33).
right_node(17,32,34).
% node 33 (leaf): class yes (1)
leaf_class(17,33,1).
% node 34: "duration" <= 772.5  (F11, bin <= 91)  left -> 35, right -> 36
node(17,34,11,91).
left_node(17,34,35).
right_node(17,34,36).
% node 35 (leaf): class no (0)
leaf_class(17,35,0).
% node 36 (leaf): class no (0)
leaf_class(17,36,0).
% node 37 (leaf): class yes (1)
leaf_class(17,37,1).
% node 38 (leaf): class yes (1)
leaf_class(17,38,1).

% Tree 18
tree(18).
% node 0: "campaign" <= 1.5  (F12, bin <= 0)  left -> 1, right -> 18
node(18,0,12,0).
left_node(18,0,1).
right_node(18,0,18).
% node 1: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 2, right -> 17
node(18,1,15,2).
left_node(18,1,2).
right_node(18,1,17).
% node 2: "duration" <= 387.5  (F11, bin <= 41)  left -> 3, right -> 10
node(18,2,11,41).
left_node(18,2,3).
right_node(18,2,10).
% node 3: "housing" <= 0.5  (F6, bin <= 0)  left -> 4, right -> 9
node(18,3,6,0).
left_node(18,3,4).
right_node(18,3,9).
% node 4: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 5, right -> 8
node(18,4,15,1).
left_node(18,4,5).
right_node(18,4,8).
% node 5: "age" <= 60.5  (F0, bin <= 16)  left -> 6, right -> 7
node(18,5,0,16).
left_node(18,5,6).
right_node(18,5,7).
% node 6 (leaf): class no (0)
leaf_class(18,6,0).
% node 7 (leaf): class no (0)
leaf_class(18,7,0).
% node 8 (leaf): class no (0)
leaf_class(18,8,0).
% node 9 (leaf): class no (0)
leaf_class(18,9,0).
% node 10: "duration" <= 646.0  (F11, bin <= 72)  left -> 11, right -> 12
node(18,10,11,72).
left_node(18,10,11).
right_node(18,10,12).
% node 11 (leaf): class no (0)
leaf_class(18,11,0).
% node 12: "housing" <= 0.5  (F6, bin <= 0)  left -> 13, right -> 14
node(18,12,6,0).
left_node(18,12,13).
right_node(18,12,14).
% node 13 (leaf): class yes (1)
leaf_class(18,13,1).
% node 14: "contact" <= 0.5  (F8, bin <= 0)  left -> 15, right -> 16
node(18,14,8,0).
left_node(18,14,15).
right_node(18,14,16).
% node 15 (leaf): class no (0)
leaf_class(18,15,0).
% node 16 (leaf): class yes (1)
leaf_class(18,16,1).
% node 17 (leaf): class yes (1)
leaf_class(18,17,1).
% node 18: "previous" <= 1.5  (F14, bin <= 1)  left -> 19, right -> 30
node(18,18,14,1).
left_node(18,18,19).
right_node(18,18,30).
% node 19: "age" <= 59.5  (F0, bin <= 15)  left -> 20, right -> 29
node(18,19,0,15).
left_node(18,19,20).
right_node(18,19,29).
% node 20: "day" <= 28.5  (F9, bin <= 15)  left -> 21, right -> 28
node(18,20,9,15).
left_node(18,20,21).
right_node(18,20,28).
% node 21: "month" <= 4.5  (F10, bin <= 2)  left -> 22, right -> 23
node(18,21,10,2).
left_node(18,21,22).
right_node(18,21,23).
% node 22 (leaf): class no (0)
leaf_class(18,22,0).
% node 23: "duration" <= 634.5  (F11, bin <= 65)  left -> 24, right -> 25
node(18,23,11,65).
left_node(18,23,24).
right_node(18,23,25).
% node 24 (leaf): class no (0)
leaf_class(18,24,0).
% node 25: "campaign" <= 3.5  (F12, bin <= 2)  left -> 26, right -> 27
node(18,25,12,2).
left_node(18,25,26).
right_node(18,25,27).
% node 26 (leaf): class no (0)
leaf_class(18,26,0).
% node 27 (leaf): class yes (1)
leaf_class(18,27,1).
% node 28 (leaf): class no (0)
leaf_class(18,28,0).
% node 29 (leaf): class no (0)
leaf_class(18,29,0).
% node 30: "duration" <= 259.5  (F11, bin <= 25)  left -> 31, right -> 32
node(18,30,11,25).
left_node(18,30,31).
right_node(18,30,32).
% node 31 (leaf): class no (0)
leaf_class(18,31,0).
% node 32 (leaf): class yes (1)
leaf_class(18,32,1).

% Tree 19
tree(19).
% node 0: "previous" <= 0.5  (F14, bin <= 0)  left -> 1, right -> 22
node(19,0,14,0).
left_node(19,0,1).
right_node(19,0,22).
% node 1: "balance" <= 1762.0  (F5, bin <= 30)  left -> 2, right -> 17
node(19,1,5,30).
left_node(19,1,2).
right_node(19,1,17).
% node 2: "job" <= 9.5  (F1, bin <= 8)  left -> 3, right -> 12
node(19,2,1,8).
left_node(19,2,3).
right_node(19,2,12).
% node 3: "duration" <= 557.5  (F11, bin <= 58)  left -> 4, right -> 9
node(19,3,11,58).
left_node(19,3,4).
right_node(19,3,9).
% node 4: "age" <= 60.5  (F0, bin <= 16)  left -> 5, right -> 8
node(19,4,0,16).
left_node(19,4,5).
right_node(19,4,8).
% node 5: "duration" <= 324.5  (F11, bin <= 32)  left -> 6, right -> 7
node(19,5,11,32).
left_node(19,5,6).
right_node(19,5,7).
% node 6 (leaf): class no (0)
leaf_class(19,6,0).
% node 7 (leaf): class no (0)
leaf_class(19,7,0).
% node 8 (leaf): class no (0)
leaf_class(19,8,0).
% node 9: "marital" <= 0.5  (F2, bin <= 0)  left -> 10, right -> 11
node(19,9,2,0).
left_node(19,9,10).
right_node(19,9,11).
% node 10 (leaf): class yes (1)
leaf_class(19,10,1).
% node 11 (leaf): class no (0)
leaf_class(19,11,0).
% node 12: "contact" <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(19,12,8,0).
left_node(19,12,13).
right_node(19,12,14).
% node 13 (leaf): class no (0)
leaf_class(19,13,0).
% node 14: "duration" <= 686.0  (F11, bin <= 83)  left -> 15, right -> 16
node(19,14,11,83).
left_node(19,14,15).
right_node(19,14,16).
% node 15 (leaf): class no (0)
leaf_class(19,15,0).
% node 16 (leaf): class yes (1)
leaf_class(19,16,1).
% node 17: "duration" <= 505.5  (F11, bin <= 54)  left -> 18, right -> 21
node(19,17,11,54).
left_node(19,17,18).
right_node(19,17,21).
% node 18: "month" <= 4.5  (F10, bin <= 2)  left -> 19, right -> 20
node(19,18,10,2).
left_node(19,18,19).
right_node(19,18,20).
% node 19 (leaf): class no (0)
leaf_class(19,19,0).
% node 20 (leaf): class no (0)
leaf_class(19,20,0).
% node 21 (leaf): class no (0)
leaf_class(19,21,0).
% node 22: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 23, right -> 36
node(19,22,15,2).
left_node(19,22,23).
right_node(19,22,36).
% node 23: "age" <= 26.5  (F0, bin <= 2)  left -> 24, right -> 25
node(19,23,0,2).
left_node(19,23,24).
right_node(19,23,25).
% node 24 (leaf): class no (0)
leaf_class(19,24,0).
% node 25: "month" <= 5.5  (F10, bin <= 3)  left -> 26, right -> 29
node(19,25,10,3).
left_node(19,25,26).
right_node(19,25,29).
% node 26: "duration" <= 661.0  (F11, bin <= 79)  left -> 27, right -> 28
node(19,26,11,79).
left_node(19,26,27).
right_node(19,26,28).
% node 27 (leaf): class no (0)
leaf_class(19,27,0).
% node 28 (leaf): class yes (1)
leaf_class(19,28,1).
% node 29: "balance" <= 874.0  (F5, bin <= 21)  left -> 30, right -> 31
node(19,29,5,21).
left_node(19,29,30).
right_node(19,29,31).
% node 30 (leaf): class no (0)
leaf_class(19,30,0).
% node 31: "age" <= 34.5  (F0, bin <= 6)  left -> 32, right -> 33
node(19,31,0,6).
left_node(19,31,32).
right_node(19,31,33).
% node 32 (leaf): class yes (1)
leaf_class(19,32,1).
% node 33: "duration" <= 243.5  (F11, bin <= 20)  left -> 34, right -> 35
node(19,33,11,20).
left_node(19,33,34).
right_node(19,33,35).
% node 34 (leaf): class no (0)
leaf_class(19,34,0).
% node 35 (leaf): class no (0)
leaf_class(19,35,0).
% node 36 (leaf): class yes (1)
leaf_class(19,36,1).

% Tree 20
tree(20).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 24
node(20,0,15,2).
left_node(20,0,1).
right_node(20,0,24).
% node 1: "duration" <= 653.5  (F11, bin <= 77)  left -> 2, right -> 13
node(20,1,11,77).
left_node(20,1,2).
right_node(20,1,13).
% node 2: "duration" <= 222.5  (F11, bin <= 18)  left -> 3, right -> 4
node(20,2,11,18).
left_node(20,2,3).
right_node(20,2,4).
% node 3 (leaf): class no (0)
leaf_class(20,3,0).
% node 4: "duration" <= 433.5  (F11, bin <= 44)  left -> 5, right -> 10
node(20,4,11,44).
left_node(20,4,5).
right_node(20,4,10).
% node 5: "balance" <= 194.5  (F5, bin <= 8)  left -> 6, right -> 7
node(20,5,5,8).
left_node(20,5,6).
right_node(20,5,7).
% node 6 (leaf): class no (0)
leaf_class(20,6,0).
% node 7: "contact" <= 0.5  (F8, bin <= 0)  left -> 8, right -> 9
node(20,7,8,0).
left_node(20,7,8).
right_node(20,7,9).
% node 8 (leaf): class no (0)
leaf_class(20,8,0).
% node 9 (leaf): class no (0)
leaf_class(20,9,0).
% node 10: "balance" <= -193.5  (F5, bin <= 3)  left -> 11, right -> 12
node(20,10,5,3).
left_node(20,10,11).
right_node(20,10,12).
% node 11 (leaf): class yes (1)
leaf_class(20,11,1).
% node 12 (leaf): class no (0)
leaf_class(20,12,0).
% node 13: "balance" <= 1214.0  (F5, bin <= 26)  left -> 14, right -> 23
node(20,13,5,26).
left_node(20,13,14).
right_node(20,13,23).
% node 14: "age" <= 57.5  (F0, bin <= 13)  left -> 15, right -> 22
node(20,14,0,13).
left_node(20,14,15).
right_node(20,14,22).
% node 15: "duration" <= 773.5  (F11, bin <= 92)  left -> 16, right -> 17
node(20,15,11,92).
left_node(20,15,16).
right_node(20,15,17).
% node 16 (leaf): class no (0)
leaf_class(20,16,0).
% node 17: "month" <= 6.5  (F10, bin <= 4)  left -> 18, right -> 21
node(20,17,10,4).
left_node(20,17,18).
right_node(20,17,21).
% node 18: "month" <= 4.5  (F10, bin <= 2)  left -> 19, right -> 20
node(20,18,10,2).
left_node(20,18,19).
right_node(20,18,20).
% node 19 (leaf): class yes (1)
leaf_class(20,19,1).
% node 20 (leaf): class no (0)
leaf_class(20,20,0).
% node 21 (leaf): class yes (1)
leaf_class(20,21,1).
% node 22 (leaf): class yes (1)
leaf_class(20,22,1).
% node 23 (leaf): class yes (1)
leaf_class(20,23,1).
% node 24 (leaf): class yes (1)
leaf_class(20,24,1).

% Tree 21
tree(21).
% node 0: "duration" <= 645.5  (F11, bin <= 71)  left -> 1, right -> 20
node(21,0,11,71).
left_node(21,0,1).
right_node(21,0,20).
% node 1: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 2, right -> 19
node(21,1,15,2).
left_node(21,1,2).
right_node(21,1,19).
% node 2: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 3, right -> 16
node(21,2,15,1).
left_node(21,2,3).
right_node(21,2,16).
% node 3: "month" <= 4.5  (F10, bin <= 2)  left -> 4, right -> 11
node(21,3,10,2).
left_node(21,3,4).
right_node(21,3,11).
% node 4: "age" <= 47.5  (F0, bin <= 11)  left -> 5, right -> 6
node(21,4,0,11).
left_node(21,4,5).
right_node(21,4,6).
% node 5 (leaf): class no (0)
leaf_class(21,5,0).
% node 6: "duration" <= 158.0  (F11, bin <= 2)  left -> 7, right -> 8
node(21,6,11,2).
left_node(21,6,7).
right_node(21,6,8).
% node 7 (leaf): class no (0)
leaf_class(21,7,0).
% node 8: "balance" <= 894.0  (F5, bin <= 22)  left -> 9, right -> 10
node(21,8,5,22).
left_node(21,8,9).
right_node(21,8,10).
% node 9 (leaf): class no (0)
leaf_class(21,9,0).
% node 10 (leaf): class yes (1)
leaf_class(21,10,1).
% node 11: "contact" <= 0.5  (F8, bin <= 0)  left -> 12, right -> 13
node(21,11,8,0).
left_node(21,11,12).
right_node(21,11,13).
% node 12 (leaf): class no (0)
leaf_class(21,12,0).
% node 13: "age" <= 70.0  (F0, bin <= 20)  left -> 14, right -> 15
node(21,13,0,20).
left_node(21,13,14).
right_node(21,13,15).
% node 14 (leaf): class no (0)
leaf_class(21,14,0).
% node 15 (leaf): class no (0)
leaf_class(21,15,0).
% node 16: "pdays" <= 114.5  (F13, bin <= 16)  left -> 17, right -> 18
node(21,16,13,16).
left_node(21,16,17).
right_node(21,16,18).
% node 17 (leaf): class yes (1)
leaf_class(21,17,1).
% node 18 (leaf): class no (0)
leaf_class(21,18,0).
% node 19 (leaf): class yes (1)
leaf_class(21,19,1).
% node 20: "contact" <= 0.5  (F8, bin <= 0)  left -> 21, right -> 24
node(21,20,8,0).
left_node(21,20,21).
right_node(21,20,24).
% node 21: "duration" <= 754.5  (F11, bin <= 88)  left -> 22, right -> 23
node(21,21,11,88).
left_node(21,21,22).
right_node(21,21,23).
% node 22 (leaf): class no (0)
leaf_class(21,22,0).
% node 23 (leaf): class no (0)
leaf_class(21,23,0).
% node 24: "month" <= 10.5  (F10, bin <= 9)  left -> 25, right -> 30
node(21,24,10,9).
left_node(21,24,25).
right_node(21,24,30).
% node 25: "age" <= 48.5  (F0, bin <= 12)  left -> 26, right -> 29
node(21,25,0,12).
left_node(21,25,26).
right_node(21,25,29).
% node 26: "campaign" <= 1.5  (F12, bin <= 0)  left -> 27, right -> 28
node(21,26,12,0).
left_node(21,26,27).
right_node(21,26,28).
% node 27 (leaf): class no (0)
leaf_class(21,27,0).
% node 28 (leaf): class yes (1)
leaf_class(21,28,1).
% node 29 (leaf): class yes (1)
leaf_class(21,29,1).
% node 30 (leaf): class no (0)
leaf_class(21,30,0).

% Tree 22
tree(22).
% node 0: "housing" <= 0.5  (F6, bin <= 0)  left -> 1, right -> 22
node(22,0,6,0).
left_node(22,0,1).
right_node(22,0,22).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 3
node(22,1,8,0).
left_node(22,1,2).
right_node(22,1,3).
% node 2 (leaf): class no (0)
leaf_class(22,2,0).
% node 3: "pdays" <= 0.0  (F13, bin <= 0)  left -> 4, right -> 13
node(22,3,13,0).
left_node(22,3,4).
right_node(22,3,13).
% node 4: "balance" <= 423.0  (F5, bin <= 15)  left -> 5, right -> 6
node(22,4,5,15).
left_node(22,4,5).
right_node(22,4,6).
% node 5 (leaf): class no (0)
leaf_class(22,5,0).
% node 6: "age" <= 58.5  (F0, bin <= 14)  left -> 7, right -> 12
node(22,6,0,14).
left_node(22,6,7).
right_node(22,6,12).
% node 7: "duration" <= 297.5  (F11, bin <= 28)  left -> 8, right -> 9
node(22,7,11,28).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class no (0)
leaf_class(22,8,0).
% node 9: "duration" <= 758.0  (F11, bin <= 89)  left -> 10, right -> 11
node(22,9,11,89).
left_node(22,9,10).
right_node(22,9,11).
% node 10 (leaf): class no (0)
leaf_class(22,10,0).
% node 11 (leaf): class yes (1)
leaf_class(22,11,1).
% node 12 (leaf): class no (0)
leaf_class(22,12,0).
% node 13: "balance" <= 3.0  (F5, bin <= 5)  left -> 14, right -> 15
node(22,13,5,5).
left_node(22,13,14).
right_node(22,13,15).
% node 14 (leaf): class no (0)
leaf_class(22,14,0).
% node 15: "job" <= 7.5  (F1, bin <= 6)  left -> 16, right -> 21
node(22,15,1,6).
left_node(22,15,16).
right_node(22,15,21).
% node 16: "pdays" <= 153.0  (F13, bin <= 20)  left -> 17, right -> 20
node(22,16,13,20).
left_node(22,16,17).
right_node(22,16,20).
% node 17: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 18, right -> 19
node(22,17,15,2).
left_node(22,17,18).
right_node(22,17,19).
% node 18 (leaf): class no (0)
leaf_class(22,18,0).
% node 19 (leaf): class yes (1)
leaf_class(22,19,1).
% node 20 (leaf): class no (0)
leaf_class(22,20,0).
% node 21 (leaf): class yes (1)
leaf_class(22,21,1).
% node 22: "pdays" <= 31.5  (F13, bin <= 3)  left -> 23, right -> 24
node(22,22,13,3).
left_node(22,22,23).
right_node(22,22,24).
% node 23 (leaf): class no (0)
leaf_class(22,23,0).
% node 24: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 25, right -> 30
node(22,24,15,2).
left_node(22,24,25).
right_node(22,24,30).
% node 25: "campaign" <= 2.5  (F12, bin <= 1)  left -> 26, right -> 29
node(22,25,12,1).
left_node(22,25,26).
right_node(22,25,29).
% node 26: "duration" <= 661.0  (F11, bin <= 79)  left -> 27, right -> 28
node(22,26,11,79).
left_node(22,26,27).
right_node(22,26,28).
% node 27 (leaf): class no (0)
leaf_class(22,27,0).
% node 28 (leaf): class yes (1)
leaf_class(22,28,1).
% node 29 (leaf): class no (0)
leaf_class(22,29,0).
% node 30 (leaf): class no (0)
leaf_class(22,30,0).

% Tree 23
tree(23).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 28
node(23,0,15,2).
left_node(23,0,1).
right_node(23,0,28).
% node 1: "housing" <= 0.5  (F6, bin <= 0)  left -> 2, right -> 19
node(23,1,6,0).
left_node(23,1,2).
right_node(23,1,19).
% node 2: "balance" <= 301.5  (F5, bin <= 11)  left -> 3, right -> 8
node(23,2,5,11).
left_node(23,2,3).
right_node(23,2,8).
% node 3: "default" <= 0.5  (F4, bin <= 0)  left -> 4, right -> 7
node(23,3,4,0).
left_node(23,3,4).
right_node(23,3,7).
% node 4: "duration" <= 685.0  (F11, bin <= 81)  left -> 5, right -> 6
node(23,4,11,81).
left_node(23,4,5).
right_node(23,4,6).
% node 5 (leaf): class no (0)
leaf_class(23,5,0).
% node 6 (leaf): class no (0)
leaf_class(23,6,0).
% node 7 (leaf): class no (0)
leaf_class(23,7,0).
% node 8: "pdays" <= 20.0  (F13, bin <= 1)  left -> 9, right -> 18
node(23,8,13,1).
left_node(23,8,9).
right_node(23,8,18).
% node 9: "duration" <= 647.5  (F11, bin <= 73)  left -> 10, right -> 17
node(23,9,11,73).
left_node(23,9,10).
right_node(23,9,17).
% node 10: "month" <= 4.5  (F10, bin <= 2)  left -> 11, right -> 14
node(23,10,10,2).
left_node(23,10,11).
right_node(23,10,14).
% node 11: "age" <= 43.0  (F0, bin <= 9)  left -> 12, right -> 13
node(23,11,0,9).
left_node(23,11,12).
right_node(23,11,13).
% node 12 (leaf): class no (0)
leaf_class(23,12,0).
% node 13 (leaf): class yes (1)
leaf_class(23,13,1).
% node 14: "duration" <= 204.5  (F11, bin <= 8)  left -> 15, right -> 16
node(23,14,11,8).
left_node(23,14,15).
right_node(23,14,16).
% node 15 (leaf): class no (0)
leaf_class(23,15,0).
% node 16 (leaf): class no (0)
leaf_class(23,16,0).
% node 17 (leaf): class yes (1)
leaf_class(23,17,1).
% node 18 (leaf): class no (0)
leaf_class(23,18,0).
% node 19: "contact" <= 0.5  (F8, bin <= 0)  left -> 20, right -> 21
node(23,19,8,0).
left_node(23,19,20).
right_node(23,19,21).
% node 20 (leaf): class no (0)
leaf_class(23,20,0).
% node 21: "job" <= 6.5  (F1, bin <= 5)  left -> 22, right -> 25
node(23,21,1,5).
left_node(23,21,22).
right_node(23,21,25).
% node 22: "balance" <= -690.0  (F5, bin <= 0)  left -> 23, right -> 24
node(23,22,5,0).
left_node(23,22,23).
right_node(23,22,24).
% node 23 (leaf): class no (0)
leaf_class(23,23,0).
% node 24 (leaf): class no (0)
leaf_class(23,24,0).
% node 25: "duration" <= 649.0  (F11, bin <= 74)  left -> 26, right -> 27
node(23,25,11,74).
left_node(23,25,26).
right_node(23,25,27).
% node 26 (leaf): class no (0)
leaf_class(23,26,0).
% node 27 (leaf): class yes (1)
leaf_class(23,27,1).
% node 28 (leaf): class yes (1)
leaf_class(23,28,1).

% Tree 24
tree(24).
% node 0: "duration" <= 561.0  (F11, bin <= 60)  left -> 1, right -> 18
node(24,0,11,60).
left_node(24,0,1).
right_node(24,0,18).
% node 1: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 2, right -> 15
node(24,1,15,2).
left_node(24,1,2).
right_node(24,1,15).
% node 2: "contact" <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(24,2,8,0).
left_node(24,2,3).
right_node(24,2,4).
% node 3 (leaf): class no (0)
leaf_class(24,3,0).
% node 4: "campaign" <= 1.5  (F12, bin <= 0)  left -> 5, right -> 10
node(24,4,12,0).
left_node(24,4,5).
right_node(24,4,10).
% node 5: "duration" <= 210.5  (F11, bin <= 12)  left -> 6, right -> 9
node(24,5,11,12).
left_node(24,5,6).
right_node(24,5,9).
% node 6: "age" <= 65.0  (F0, bin <= 18)  left -> 7, right -> 8
node(24,6,0,18).
left_node(24,6,7).
right_node(24,6,8).
% node 7 (leaf): class no (0)
leaf_class(24,7,0).
% node 8 (leaf): class no (0)
leaf_class(24,8,0).
% node 9 (leaf): class no (0)
leaf_class(24,9,0).
% node 10: "duration" <= 351.5  (F11, bin <= 38)  left -> 11, right -> 12
node(24,10,11,38).
left_node(24,10,11).
right_node(24,10,12).
% node 11 (leaf): class no (0)
leaf_class(24,11,0).
% node 12: "duration" <= 365.0  (F11, bin <= 39)  left -> 13, right -> 14
node(24,12,11,39).
left_node(24,12,13).
right_node(24,12,14).
% node 13 (leaf): class yes (1)
leaf_class(24,13,1).
% node 14 (leaf): class no (0)
leaf_class(24,14,0).
% node 15: "duration" <= 172.5  (F11, bin <= 5)  left -> 16, right -> 17
node(24,15,11,5).
left_node(24,15,16).
right_node(24,15,17).
% node 16 (leaf): class no (0)
leaf_class(24,16,0).
% node 17 (leaf): class yes (1)
leaf_class(24,17,1).
% node 18: "job" <= 3.5  (F1, bin <= 2)  left -> 19, right -> 28
node(24,18,1,2).
left_node(24,18,19).
right_node(24,18,28).
% node 19: "campaign" <= 1.5  (F12, bin <= 0)  left -> 20, right -> 25
node(24,19,12,0).
left_node(24,19,20).
right_node(24,19,25).
% node 20: "marital" <= 1.5  (F2, bin <= 1)  left -> 21, right -> 24
node(24,20,2,1).
left_node(24,20,21).
right_node(24,20,24).
% node 21: "day" <= 14.0  (F9, bin <= 5)  left -> 22, right -> 23
node(24,21,9,5).
left_node(24,21,22).
right_node(24,21,23).
% node 22 (leaf): class no (0)
leaf_class(24,22,0).
% node 23 (leaf): class yes (1)
leaf_class(24,23,1).
% node 24 (leaf): class yes (1)
leaf_class(24,24,1).
% node 25: "duration" <= 1059.0  (F11, bin <= 106)  left -> 26, right -> 27
node(24,25,11,106).
left_node(24,25,26).
right_node(24,25,27).
% node 26 (leaf): class no (0)
leaf_class(24,26,0).
% node 27 (leaf): class yes (1)
leaf_class(24,27,1).
% node 28: "duration" <= 801.5  (F11, bin <= 99)  left -> 29, right -> 32
node(24,28,11,99).
left_node(24,28,29).
right_node(24,28,32).
% node 29: "pdays" <= 96.0  (F13, bin <= 9)  left -> 30, right -> 31
node(24,29,13,9).
left_node(24,29,30).
right_node(24,29,31).
% node 30 (leaf): class no (0)
leaf_class(24,30,0).
% node 31 (leaf): class yes (1)
leaf_class(24,31,1).
% node 32 (leaf): class yes (1)
leaf_class(24,32,1).

% Tree 25
tree(25).
% node 0: "pdays" <= 32.0  (F13, bin <= 4)  left -> 1, right -> 26
node(25,0,13,4).
left_node(25,0,1).
right_node(25,0,26).
% node 1: "contact" <= 0.5  (F8, bin <= 0)  left -> 2, right -> 11
node(25,1,8,0).
left_node(25,1,2).
right_node(25,1,11).
% node 2: "marital" <= 1.5  (F2, bin <= 1)  left -> 3, right -> 8
node(25,2,2,1).
left_node(25,2,3).
right_node(25,2,8).
% node 3: "age" <= 35.5  (F0, bin <= 8)  left -> 4, right -> 5
node(25,3,0,8).
left_node(25,3,4).
right_node(25,3,5).
% node 4 (leaf): class no (0)
leaf_class(25,4,0).
% node 5: "duration" <= 754.5  (F11, bin <= 88)  left -> 6, right -> 7
node(25,5,11,88).
left_node(25,5,6).
right_node(25,5,7).
% node 6 (leaf): class no (0)
leaf_class(25,6,0).
% node 7 (leaf): class yes (1)
leaf_class(25,7,1).
% node 8: "duration" <= 465.5  (F11, bin <= 48)  left -> 9, right -> 10
node(25,8,11,48).
left_node(25,8,9).
right_node(25,8,10).
% node 9 (leaf): class no (0)
leaf_class(25,9,0).
% node 10 (leaf): class no (0)
leaf_class(25,10,0).
% node 11: "housing" <= 0.5  (F6, bin <= 0)  left -> 12, right -> 21
node(25,11,6,0).
left_node(25,11,12).
right_node(25,11,21).
% node 12: "month" <= 6.5  (F10, bin <= 4)  left -> 13, right -> 20
node(25,12,10,4).
left_node(25,12,13).
right_node(25,12,20).
% node 13: "day" <= 24.5  (F9, bin <= 13)  left -> 14, right -> 19
node(25,13,9,13).
left_node(25,13,14).
right_node(25,13,19).
% node 14: "age" <= 58.5  (F0, bin <= 14)  left -> 15, right -> 18
node(25,14,0,14).
left_node(25,14,15).
right_node(25,14,18).
% node 15: "duration" <= 390.0  (F11, bin <= 42)  left -> 16, right -> 17
node(25,15,11,42).
left_node(25,15,16).
right_node(25,15,17).
% node 16 (leaf): class no (0)
leaf_class(25,16,0).
% node 17 (leaf): class yes (1)
leaf_class(25,17,1).
% node 18 (leaf): class yes (1)
leaf_class(25,18,1).
% node 19 (leaf): class no (0)
leaf_class(25,19,0).
% node 20 (leaf): class no (0)
leaf_class(25,20,0).
% node 21: "age" <= 32.5  (F0, bin <= 5)  left -> 22, right -> 23
node(25,21,0,5).
left_node(25,21,22).
right_node(25,21,23).
% node 22 (leaf): class no (0)
leaf_class(25,22,0).
% node 23: "duration" <= 557.5  (F11, bin <= 58)  left -> 24, right -> 25
node(25,23,11,58).
left_node(25,23,24).
right_node(25,23,25).
% node 24 (leaf): class no (0)
leaf_class(25,24,0).
% node 25 (leaf): class no (0)
leaf_class(25,25,0).
% node 26: "duration" <= 221.5  (F11, bin <= 16)  left -> 27, right -> 30
node(25,26,11,16).
left_node(25,26,27).
right_node(25,26,30).
% node 27: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 28, right -> 29
node(25,27,15,2).
left_node(25,27,28).
right_node(25,27,29).
% node 28 (leaf): class no (0)
leaf_class(25,28,0).
% node 29 (leaf): class no (0)
leaf_class(25,29,0).
% node 30: "duration" <= 649.5  (F11, bin <= 75)  left -> 31, right -> 36
node(25,30,11,75).
left_node(25,30,31).
right_node(25,30,36).
% node 31: "housing" <= 0.5  (F6, bin <= 0)  left -> 32, right -> 33
node(25,31,6,0).
left_node(25,31,32).
right_node(25,31,33).
% node 32 (leaf): class no (0)
leaf_class(25,32,0).
% node 33: "balance" <= 1207.5  (F5, bin <= 25)  left -> 34, right -> 35
node(25,33,5,25).
left_node(25,33,34).
right_node(25,33,35).
% node 34 (leaf): class no (0)
leaf_class(25,34,0).
% node 35 (leaf): class no (0)
leaf_class(25,35,0).
% node 36 (leaf): class yes (1)
leaf_class(25,36,1).

% Tree 26
tree(26).
% node 0: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 1, right -> 28
node(26,0,15,2).
left_node(26,0,1).
right_node(26,0,28).
% node 1: "duration" <= 637.0  (F11, bin <= 66)  left -> 2, right -> 21
node(26,1,11,66).
left_node(26,1,2).
right_node(26,1,21).
% node 2: "pdays" <= 401.5  (F13, bin <= 25)  left -> 3, right -> 20
node(26,2,13,25).
left_node(26,2,3).
right_node(26,2,20).
% node 3: "month" <= 4.5  (F10, bin <= 2)  left -> 4, right -> 13
node(26,3,10,2).
left_node(26,3,4).
right_node(26,3,13).
% node 4: "month" <= 2.5  (F10, bin <= 0)  left -> 5, right -> 6
node(26,4,10,0).
left_node(26,4,5).
right_node(26,4,6).
% node 5 (leaf): class no (0)
leaf_class(26,5,0).
% node 6: "day" <= 20.5  (F9, bin <= 10)  left -> 7, right -> 10
node(26,6,9,10).
left_node(26,6,7).
right_node(26,6,10).
% node 7: "day" <= 15.5  (F9, bin <= 8)  left -> 8, right -> 9
node(26,7,9,8).
left_node(26,7,8).
right_node(26,7,9).
% node 8 (leaf): class no (0)
leaf_class(26,8,0).
% node 9 (leaf): class no (0)
leaf_class(26,9,0).
% node 10: "duration" <= 160.5  (F11, bin <= 3)  left -> 11, right -> 12
node(26,10,11,3).
left_node(26,10,11).
right_node(26,10,12).
% node 11 (leaf): class no (0)
leaf_class(26,11,0).
% node 12 (leaf): class yes (1)
leaf_class(26,12,1).
% node 13: "duration" <= 351.5  (F11, bin <= 38)  left -> 14, right -> 15
node(26,13,11,38).
left_node(26,13,14).
right_node(26,13,15).
% node 14 (leaf): class no (0)
leaf_class(26,14,0).
% node 15: "month" <= 8.5  (F10, bin <= 7)  left -> 16, right -> 17
node(26,15,10,7).
left_node(26,15,16).
right_node(26,15,17).
% node 16 (leaf): class no (0)
leaf_class(26,16,0).
% node 17: "balance" <= 3620.5  (F5, bin <= 38)  left -> 18, right -> 19
node(26,17,5,38).
left_node(26,17,18).
right_node(26,17,19).
% node 18 (leaf): class no (0)
leaf_class(26,18,0).
% node 19 (leaf): class no (0)
leaf_class(26,19,0).
% node 20 (leaf): class yes (1)
leaf_class(26,20,1).
% node 21: "duration" <= 869.5  (F11, bin <= 103)  left -> 22, right -> 25
node(26,21,11,103).
left_node(26,21,22).
right_node(26,21,25).
% node 22: "poutcome" <= 0.5  (F15, bin <= 0)  left -> 23, right -> 24
node(26,22,15,0).
left_node(26,22,23).
right_node(26,22,24).
% node 23 (leaf): class no (0)
leaf_class(26,23,0).
% node 24 (leaf): class yes (1)
leaf_class(26,24,1).
% node 25: "pdays" <= 145.5  (F13, bin <= 19)  left -> 26, right -> 27
node(26,25,13,19).
left_node(26,25,26).
right_node(26,25,27).
% node 26 (leaf): class yes (1)
leaf_class(26,26,1).
% node 27 (leaf): class no (0)
leaf_class(26,27,0).
% node 28: "housing" <= 0.5  (F6, bin <= 0)  left -> 29, right -> 30
node(26,28,6,0).
left_node(26,28,29).
right_node(26,28,30).
% node 29 (leaf): class yes (1)
leaf_class(26,29,1).
% node 30: "day" <= 13.5  (F9, bin <= 4)  left -> 31, right -> 32
node(26,30,9,4).
left_node(26,30,31).
right_node(26,30,32).
% node 31 (leaf): class yes (1)
leaf_class(26,31,1).
% node 32 (leaf): class no (0)
leaf_class(26,32,0).

% Tree 27
tree(27).
% node 0: "contact" <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(27,0,8,0).
left_node(27,0,1).
right_node(27,0,8).
% node 1: "month" <= 7.5  (F10, bin <= 6)  left -> 2, right -> 7
node(27,1,10,6).
left_node(27,1,2).
right_node(27,1,7).
% node 2: "duration" <= 758.0  (F11, bin <= 89)  left -> 3, right -> 4
node(27,2,11,89).
left_node(27,2,3).
right_node(27,2,4).
% node 3 (leaf): class no (0)
leaf_class(27,3,0).
% node 4: "age" <= 35.0  (F0, bin <= 7)  left -> 5, right -> 6
node(27,4,0,7).
left_node(27,4,5).
right_node(27,4,6).
% node 5 (leaf): class no (0)
leaf_class(27,5,0).
% node 6 (leaf): class yes (1)
leaf_class(27,6,1).
% node 7 (leaf): class no (0)
leaf_class(27,7,0).
% node 8: "duration" <= 219.5  (F11, bin <= 15)  left -> 9, right -> 12
node(27,8,11,15).
left_node(27,8,9).
right_node(27,8,12).
% node 9: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 10, right -> 11
node(27,9,15,2).
left_node(27,9,10).
right_node(27,9,11).
% node 10 (leaf): class no (0)
leaf_class(27,10,0).
% node 11 (leaf): class no (0)
leaf_class(27,11,0).
% node 12: "pdays" <= 22.5  (F13, bin <= 2)  left -> 13, right -> 26
node(27,12,13,2).
left_node(27,12,13).
right_node(27,12,26).
% node 13: "marital" <= 1.5  (F2, bin <= 1)  left -> 14, right -> 25
node(27,13,2,1).
left_node(27,13,14).
right_node(27,13,25).
% node 14: "day" <= 21.5  (F9, bin <= 11)  left -> 15, right -> 20
node(27,14,9,11).
left_node(27,14,15).
right_node(27,14,20).
% node 15: "job" <= 9.5  (F1, bin <= 8)  left -> 16, right -> 19
node(27,15,1,8).
left_node(27,15,16).
right_node(27,15,19).
% node 16: "duration" <= 779.5  (F11, bin <= 95)  left -> 17, right -> 18
node(27,16,11,95).
left_node(27,16,17).
right_node(27,16,18).
% node 17 (leaf): class no (0)
leaf_class(27,17,0).
% node 18 (leaf): class yes (1)
leaf_class(27,18,1).
% node 19 (leaf): class no (0)
leaf_class(27,19,0).
% node 20: "month" <= 4.5  (F10, bin <= 2)  left -> 21, right -> 22
node(27,20,10,2).
left_node(27,20,21).
right_node(27,20,22).
% node 21 (leaf): class yes (1)
leaf_class(27,21,1).
% node 22: "duration" <= 642.5  (F11, bin <= 69)  left -> 23, right -> 24
node(27,22,11,69).
left_node(27,22,23).
right_node(27,22,24).
% node 23 (leaf): class no (0)
leaf_class(27,23,0).
% node 24 (leaf): class yes (1)
leaf_class(27,24,1).
% node 25 (leaf): class no (0)
leaf_class(27,25,0).
% node 26: "poutcome" <= 2.5  (F15, bin <= 2)  left -> 27, right -> 36
node(27,26,15,2).
left_node(27,26,27).
right_node(27,26,36).
% node 27: "duration" <= 661.0  (F11, bin <= 79)  left -> 28, right -> 35
node(27,27,11,79).
left_node(27,27,28).
right_node(27,27,35).
% node 28: "month" <= 5.5  (F10, bin <= 3)  left -> 29, right -> 32
node(27,28,10,3).
left_node(27,28,29).
right_node(27,28,32).
% node 29: "day" <= 17.5  (F9, bin <= 9)  left -> 30, right -> 31
node(27,29,9,9).
left_node(27,29,30).
right_node(27,29,31).
% node 30 (leaf): class no (0)
leaf_class(27,30,0).
% node 31 (leaf): class yes (1)
leaf_class(27,31,1).
% node 32: "month" <= 10.5  (F10, bin <= 9)  left -> 33, right -> 34
node(27,32,10,9).
left_node(27,32,33).
right_node(27,32,34).
% node 33 (leaf): class yes (1)
leaf_class(27,33,1).
% node 34 (leaf): class no (0)
leaf_class(27,34,0).
% node 35 (leaf): class yes (1)
leaf_class(27,35,1).
% node 36 (leaf): class yes (1)
leaf_class(27,36,1).

% Tree 28
tree(28).
% node 0: "duration" <= 557.5  (F11, bin <= 58)  left -> 1, right -> 22
node(28,0,11,58).
left_node(28,0,1).
right_node(28,0,22).
% node 1: "pdays" <= 32.0  (F13, bin <= 4)  left -> 2, right -> 9
node(28,1,13,4).
left_node(28,1,2).
right_node(28,1,9).
% node 2: "housing" <= 0.5  (F6, bin <= 0)  left -> 3, right -> 8
node(28,2,6,0).
left_node(28,2,3).
right_node(28,2,8).
% node 3: "age" <= 60.5  (F0, bin <= 16)  left -> 4, right -> 7
node(28,3,0,16).
left_node(28,3,4).
right_node(28,3,7).
% node 4: "duration" <= 334.0  (F11, bin <= 33)  left -> 5, right -> 6
node(28,4,11,33).
left_node(28,4,5).
right_node(28,4,6).
% node 5 (leaf): class no (0)
leaf_class(28,5,0).
% node 6 (leaf): class no (0)
leaf_class(28,6,0).
% node 7 (leaf): class no (0)
leaf_class(28,7,0).
% node 8 (leaf): class no (0)
leaf_class(28,8,0).
% node 9: "loan" <= 0.5  (F7, bin <= 0)  left -> 10, right -> 21
node(28,9,7,0).
left_node(28,9,10).
right_node(28,9,21).
% node 10: "housing" <= 0.5  (F6, bin <= 0)  left -> 11, right -> 18
node(28,10,6,0).
left_node(28,10,11).
right_node(28,10,18).
% node 11: "pdays" <= 189.5  (F13, bin <= 21)  left -> 12, right -> 17
node(28,11,13,21).
left_node(28,11,12).
right_node(28,11,17).
% node 12: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 13, right -> 14
node(28,12,15,1).
left_node(28,12,13).
right_node(28,12,14).
% node 13 (leaf): class no (0)
leaf_class(28,13,0).
% node 14: "day" <= 9.5  (F9, bin <= 2)  left -> 15, right -> 16
node(28,14,9,2).
left_node(28,14,15).
right_node(28,14,16).
% node 15 (leaf): class no (0)
leaf_class(28,15,0).
% node 16 (leaf): class yes (1)
leaf_class(28,16,1).
% node 17 (leaf): class no (0)
leaf_class(28,17,0).
% node 18: "pdays" <= 105.5  (F13, bin <= 15)  left -> 19, right -> 20
node(28,18,13,15).
left_node(28,18,19).
right_node(28,18,20).
% node 19 (leaf): class yes (1)
leaf_class(28,19,1).
% node 20 (leaf): class no (0)
leaf_class(28,20,0).
% node 21 (leaf): class no (0)
leaf_class(28,21,0).
% node 22: "education" <= 0.5  (F3, bin <= 0)  left -> 23, right -> 24
node(28,22,3,0).
left_node(28,22,23).
right_node(28,22,24).
% node 23 (leaf): class no (0)
leaf_class(28,23,0).
% node 24: "previous" <= 1.5  (F14, bin <= 1)  left -> 25, right -> 30
node(28,24,14,1).
left_node(28,24,25).
right_node(28,24,30).
% node 25: "duration" <= 786.5  (F11, bin <= 96)  left -> 26, right -> 27
node(28,25,11,96).
left_node(28,25,26).
right_node(28,25,27).
% node 26 (leaf): class no (0)
leaf_class(28,26,0).
% node 27: "day" <= 11.5  (F9, bin <= 3)  left -> 28, right -> 29
node(28,27,9,3).
left_node(28,27,28).
right_node(28,27,29).
% node 28 (leaf): class no (0)
leaf_class(28,28,0).
% node 29 (leaf): class yes (1)
leaf_class(28,29,1).
% node 30 (leaf): class yes (1)
leaf_class(28,30,1).

% Tree 29
tree(29).
% node 0: "duration" <= 640.5  (F11, bin <= 67)  left -> 1, right -> 18
node(29,0,11,67).
left_node(29,0,1).
right_node(29,0,18).
% node 1: "age" <= 60.5  (F0, bin <= 16)  left -> 2, right -> 15
node(29,1,0,16).
left_node(29,1,2).
right_node(29,1,15).
% node 2: "duration" <= 221.5  (F11, bin <= 16)  left -> 3, right -> 4
node(29,2,11,16).
left_node(29,2,3).
right_node(29,2,4).
% node 3 (leaf): class no (0)
leaf_class(29,3,0).
% node 4: "housing" <= 0.5  (F6, bin <= 0)  left -> 5, right -> 12
node(29,4,6,0).
left_node(29,4,5).
right_node(29,4,12).
% node 5: "poutcome" <= 1.5  (F15, bin <= 1)  left -> 6, right -> 11
node(29,5,15,1).
left_node(29,5,6).
right_node(29,5,11).
% node 6: "campaign" <= 2.5  (F12, bin <= 1)  left -> 7, right -> 10
node(29,6,12,1).
left_node(29,6,7).
right_node(29,6,10).
% node 7: "balance" <= 194.5  (F5, bin <= 8)  left -> 8, right -> 9
node(29,7,5,8).
left_node(29,7,8).
right_node(29,7,9).
% node 8 (leaf): class no (0)
leaf_class(29,8,0).
% node 9 (leaf): class no (0)
leaf_class(29,9,0).
% node 10 (leaf): class no (0)
leaf_class(29,10,0).
% node 11 (leaf): class yes (1)
leaf_class(29,11,1).
% node 12: "month" <= 3.5  (F10, bin <= 1)  left -> 13, right -> 14
node(29,12,10,1).
left_node(29,12,13).
right_node(29,12,14).
% node 13 (leaf): class no (0)
leaf_class(29,13,0).
% node 14 (leaf): class no (0)
leaf_class(29,14,0).
% node 15: "balance" <= 2798.5  (F5, bin <= 37)  left -> 16, right -> 17
node(29,15,5,37).
left_node(29,15,16).
right_node(29,15,17).
% node 16 (leaf): class no (0)
leaf_class(29,16,0).
% node 17 (leaf): class yes (1)
leaf_class(29,17,1).
% node 18: "campaign" <= 4.5  (F12, bin <= 3)  left -> 19, right -> 26
node(29,18,12,3).
left_node(29,18,19).
right_node(29,18,26).
% node 19: "duration" <= 774.0  (F11, bin <= 93)  left -> 20, right -> 23
node(29,19,11,93).
left_node(29,19,20).
right_node(29,19,23).
% node 20: "balance" <= 397.0  (F5, bin <= 14)  left -> 21, right -> 22
node(29,20,5,14).
left_node(29,20,21).
right_node(29,20,22).
% node 21 (leaf): class no (0)
leaf_class(29,21,0).
% node 22 (leaf): class yes (1)
leaf_class(29,22,1).
% node 23: "contact" <= 0.5  (F8, bin <= 0)  left -> 24, right -> 25
node(29,23,8,0).
left_node(29,23,24).
right_node(29,23,25).
% node 24 (leaf): class no (0)
leaf_class(29,24,0).
% node 25 (leaf): class yes (1)
leaf_class(29,25,1).
% node 26 (leaf): class yes (1)
leaf_class(29,26,1).

% --- Class domain ---
class_idx(0).  % no
class_idx(1).  % yes
