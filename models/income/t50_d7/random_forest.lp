% ============================================================
% random_forest.lp — RF facts for income
% 50 trees  |  14 features
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

% Feature 0 (f0): 18 bins  (thresholds: [24.5, 25.5, 26.5, 27.5, 28.5, 29.5, 30.5, 31.5, 32.5, 33.5, 35.5, 36.5, 37.5, 41.5, 59.5, 60.5, 62.5])
{bin(I,0,B) : B = 0..17} = 1 :- item(I).

% Feature 1 (f1): 4 bins  (thresholds: [0.5, 2.0, 4.5])
{bin(I,1,B) : B = 0..3} = 1 :- item(I).

% Feature 2 (f2): 7 bins  (thresholds: [25660.5, 88720.0, 116950.5, 118611.0, 125689.5, 211394.5])
{bin(I,2,B) : B = 0..6} = 1 :- item(I).

% Feature 3 (f3): 9 bins  (thresholds: [6.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5])
{bin(I,3,B) : B = 0..8} = 1 :- item(I).

% Feature 4 (f4): 10 bins  (thresholds: [4.5, 7.5, 8.5, 9.5, 10.5, 11.5, 12.5, 13.5, 14.5])
{bin(I,4,B) : B = 0..9} = 1 :- item(I).

% Feature 5 (f5): 7 bins  (thresholds: [0.5, 1.0, 1.5, 2.5, 3.0, 3.5])
{bin(I,5,B) : B = 0..6} = 1 :- item(I).

% Feature 6 (f6): 7 bins  (thresholds: [2.5, 3.5, 8.0, 8.5, 9.5, 12.5])
{bin(I,6,B) : B = 0..6} = 1 :- item(I).

% Feature 7 (f7): 5 bins  (thresholds: [0.5, 1.5, 4.0, 4.5])
{bin(I,7,B) : B = 0..4} = 1 :- item(I).

% Feature 8 (f8): 3 bins  (thresholds: [0.5, 3.5])
{bin(I,8,B) : B = 0..2} = 1 :- item(I).

% Feature 9 (f9): 2 bins  (thresholds: [0.5])
{bin(I,9,B) : B = 0..1} = 1 :- item(I).

% Feature 10 (f10): 26 bins  (thresholds: [1101.0, 3120.0, 3283.5, 4030.0, 4056.0, 4164.0, 4225.0, 4243.5, 4718.5, 4782.0, 5095.5, 5119.0, 5316.5, 5715.5, 6897.5, 6963.5, 7032.5, 7073.5, 7139.5, 7268.5, 7372.5, 7669.5, 7731.5, 8028.5, 8296.0])
{bin(I,10,B) : B = 0..25} = 1 :- item(I).

% Feature 11 (f11): 18 bins  (thresholds: [1512.0, 1532.0, 1725.0, 1782.5, 1783.0, 1793.5, 1794.0, 1805.0, 1811.0, 1820.5, 1846.0, 1881.5, 1978.5, 1989.5, 2218.5, 2365.5, 2377.0])
{bin(I,11,B) : B = 0..17} = 1 :- item(I).

% Feature 12 (f12): 16 bins  (thresholds: [31.0, 32.5, 33.5, 34.0, 34.5, 35.5, 37.5, 40.5, 41.5, 42.5, 43.5, 44.5, 45.5, 47.0, 49.5])
{bin(I,12,B) : B = 0..15} = 1 :- item(I).

% Feature 13 (f13): 8 bins  (thresholds: [22.5, 26.5, 28.5, 32.5, 33.5, 35.5, 37.0])
{bin(I,13,B) : B = 0..7} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 12
node(0,0,7,0).
left_node(0,0,1).
right_node(0,0,12).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 11
node(0,1,10,10).
left_node(0,1,2).
right_node(0,1,11).
% node 2: f4 <= 12.5  (F4, bin <= 6)  left -> 3, right -> 6
node(0,2,4,6).
left_node(0,2,3).
right_node(0,2,6).
% node 3: f0 <= 35.5  (F0, bin <= 10)  left -> 4, right -> 5
node(0,3,0,10).
left_node(0,3,4).
right_node(0,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(0,4,0).
% node 5 (leaf): class <=50K (0)
leaf_class(0,5,0).
% node 6: f0 <= 26.5  (F0, bin <= 2)  left -> 7, right -> 8
node(0,6,0,2).
left_node(0,6,7).
right_node(0,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(0,7,0).
% node 8: f11 <= 1782.5  (F11, bin <= 3)  left -> 9, right -> 10
node(0,8,11,3).
left_node(0,8,9).
right_node(0,8,10).
% node 9 (leaf): class >50K (1)
leaf_class(0,9,1).
% node 10 (leaf): class >50K (1)
leaf_class(0,10,1).
% node 11 (leaf): class >50K (1)
leaf_class(0,11,1).
% node 12: f11 <= 1881.5  (F11, bin <= 11)  left -> 13, right -> 38
node(0,12,11,11).
left_node(0,12,13).
right_node(0,12,38).
% node 13: f3 <= 11.5  (F3, bin <= 5)  left -> 14, right -> 23
node(0,13,3,5).
left_node(0,13,14).
right_node(0,13,23).
% node 14: f10 <= 7073.5  (F10, bin <= 17)  left -> 15, right -> 22
node(0,14,10,17).
left_node(0,14,15).
right_node(0,14,22).
% node 15: f5 <= 2.5  (F5, bin <= 3)  left -> 16, right -> 21
node(0,15,5,3).
left_node(0,15,16).
right_node(0,15,21).
% node 16: f10 <= 4243.5  (F10, bin <= 7)  left -> 17, right -> 20
node(0,16,10,7).
left_node(0,16,17).
right_node(0,16,20).
% node 17: f7 <= 4.5  (F7, bin <= 3)  left -> 18, right -> 19
node(0,17,7,3).
left_node(0,17,18).
right_node(0,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(0,18,0).
% node 19 (leaf): class <=50K (0)
leaf_class(0,19,0).
% node 20 (leaf): class <=50K (0)
leaf_class(0,20,0).
% node 21 (leaf): class <=50K (0)
leaf_class(0,21,0).
% node 22 (leaf): class >50K (1)
leaf_class(0,22,1).
% node 23: f4 <= 13.5  (F4, bin <= 7)  left -> 24, right -> 29
node(0,23,4,7).
left_node(0,23,24).
right_node(0,23,29).
% node 24: f5 <= 2.5  (F5, bin <= 3)  left -> 25, right -> 28
node(0,24,5,3).
left_node(0,24,25).
right_node(0,24,28).
% node 25: f5 <= 1.0  (F5, bin <= 1)  left -> 26, right -> 27
node(0,25,5,1).
left_node(0,25,26).
right_node(0,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(0,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(0,27,1).
% node 28 (leaf): class <=50K (0)
leaf_class(0,28,0).
% node 29: f4 <= 14.5  (F4, bin <= 8)  left -> 30, right -> 35
node(0,29,4,8).
left_node(0,29,30).
right_node(0,29,35).
% node 30: f9 <= 0.5  (F9, bin <= 0)  left -> 31, right -> 34
node(0,30,9,0).
left_node(0,30,31).
right_node(0,30,34).
% node 31: f7 <= 4.5  (F7, bin <= 3)  left -> 32, right -> 33
node(0,31,7,3).
left_node(0,31,32).
right_node(0,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(0,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(0,33,1).
% node 34 (leaf): class <=50K (0)
leaf_class(0,34,0).
% node 35: f10 <= 4030.0  (F10, bin <= 3)  left -> 36, right -> 37
node(0,35,10,3).
left_node(0,35,36).
right_node(0,35,37).
% node 36 (leaf): class <=50K (0)
leaf_class(0,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(0,37,1).
% node 38 (leaf): class >50K (1)
leaf_class(0,38,1).

% Tree 1
tree(1).
% node 0: f10 <= 5119.0  (F10, bin <= 11)  left -> 1, right -> 36
node(1,0,10,11).
left_node(1,0,1).
right_node(1,0,36).
% node 1: f11 <= 1820.5  (F11, bin <= 9)  left -> 2, right -> 29
node(1,1,11,9).
left_node(1,1,2).
right_node(1,1,29).
% node 2: f9 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(1,2,9,0).
left_node(1,2,3).
right_node(1,2,10).
% node 3: f5 <= 2.5  (F5, bin <= 3)  left -> 4, right -> 9
node(1,3,5,3).
left_node(1,3,4).
right_node(1,3,9).
% node 4: f3 <= 11.5  (F3, bin <= 5)  left -> 5, right -> 8
node(1,4,3,5).
left_node(1,4,5).
right_node(1,4,8).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(1,5,5,0).
left_node(1,5,6).
right_node(1,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(1,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(1,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(1,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(1,9,0).
% node 10: f0 <= 31.5  (F0, bin <= 7)  left -> 11, right -> 16
node(1,10,0,7).
left_node(1,10,11).
right_node(1,10,16).
% node 11: f5 <= 2.5  (F5, bin <= 3)  left -> 12, right -> 15
node(1,11,5,3).
left_node(1,11,12).
right_node(1,11,15).
% node 12: f4 <= 12.5  (F4, bin <= 6)  left -> 13, right -> 14
node(1,12,4,6).
left_node(1,12,13).
right_node(1,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(1,13,0).
% node 14 (leaf): class <=50K (0)
leaf_class(1,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(1,15,0).
% node 16: f12 <= 41.5  (F12, bin <= 8)  left -> 17, right -> 24
node(1,16,12,8).
left_node(1,16,17).
right_node(1,16,24).
% node 17: f3 <= 11.5  (F3, bin <= 5)  left -> 18, right -> 21
node(1,17,3,5).
left_node(1,17,18).
right_node(1,17,21).
% node 18: f7 <= 0.5  (F7, bin <= 0)  left -> 19, right -> 20
node(1,18,7,0).
left_node(1,18,19).
right_node(1,18,20).
% node 19 (leaf): class <=50K (0)
leaf_class(1,19,0).
% node 20 (leaf): class <=50K (0)
leaf_class(1,20,0).
% node 21: f5 <= 2.5  (F5, bin <= 3)  left -> 22, right -> 23
node(1,21,5,3).
left_node(1,21,22).
right_node(1,21,23).
% node 22 (leaf): class >50K (1)
leaf_class(1,22,1).
% node 23 (leaf): class <=50K (0)
leaf_class(1,23,0).
% node 24: f2 <= 88720.0  (F2, bin <= 1)  left -> 25, right -> 26
node(1,24,2,1).
left_node(1,24,25).
right_node(1,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(1,25,0).
% node 26: f3 <= 11.5  (F3, bin <= 5)  left -> 27, right -> 28
node(1,26,3,5).
left_node(1,26,27).
right_node(1,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(1,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(1,28,1).
% node 29: f5 <= 3.0  (F5, bin <= 4)  left -> 30, right -> 35
node(1,29,5,4).
left_node(1,29,30).
right_node(1,29,35).
% node 30: f3 <= 10.5  (F3, bin <= 4)  left -> 31, right -> 34
node(1,30,3,4).
left_node(1,30,31).
right_node(1,30,34).
% node 31: f11 <= 1978.5  (F11, bin <= 12)  left -> 32, right -> 33
node(1,31,11,12).
left_node(1,31,32).
right_node(1,31,33).
% node 32 (leaf): class >50K (1)
leaf_class(1,32,1).
% node 33 (leaf): class <=50K (0)
leaf_class(1,33,0).
% node 34 (leaf): class >50K (1)
leaf_class(1,34,1).
% node 35 (leaf): class <=50K (0)
leaf_class(1,35,0).
% node 36 (leaf): class >50K (1)
leaf_class(1,36,1).

% Tree 2
tree(2).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 28
node(2,0,5,3).
left_node(2,0,1).
right_node(2,0,28).
% node 1: f9 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 11
node(2,1,9,0).
left_node(2,1,2).
right_node(2,1,11).
% node 2: f5 <= 0.5  (F5, bin <= 0)  left -> 3, right -> 4
node(2,2,5,0).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(2,3,0).
% node 4: f7 <= 4.0  (F7, bin <= 2)  left -> 5, right -> 6
node(2,4,7,2).
left_node(2,4,5).
right_node(2,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(2,5,0).
% node 6: f10 <= 5095.5  (F10, bin <= 10)  left -> 7, right -> 10
node(2,6,10,10).
left_node(2,6,7).
right_node(2,6,10).
% node 7: f6 <= 8.5  (F6, bin <= 3)  left -> 8, right -> 9
node(2,7,6,3).
left_node(2,7,8).
right_node(2,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(2,8,0).
% node 9 (leaf): class >50K (1)
leaf_class(2,9,1).
% node 10 (leaf): class >50K (1)
leaf_class(2,10,1).
% node 11: f5 <= 1.5  (F5, bin <= 2)  left -> 12, right -> 13
node(2,11,5,2).
left_node(2,11,12).
right_node(2,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(2,12,0).
% node 13: f12 <= 41.5  (F12, bin <= 8)  left -> 14, right -> 21
node(2,13,12,8).
left_node(2,13,14).
right_node(2,13,21).
% node 14: f10 <= 5095.5  (F10, bin <= 10)  left -> 15, right -> 20
node(2,14,10,10).
left_node(2,14,15).
right_node(2,14,20).
% node 15: f11 <= 1782.5  (F11, bin <= 3)  left -> 16, right -> 19
node(2,15,11,3).
left_node(2,15,16).
right_node(2,15,19).
% node 16: f6 <= 8.0  (F6, bin <= 2)  left -> 17, right -> 18
node(2,16,6,2).
left_node(2,16,17).
right_node(2,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(2,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(2,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(2,19,1).
% node 20 (leaf): class >50K (1)
leaf_class(2,20,1).
% node 21: f11 <= 1846.0  (F11, bin <= 10)  left -> 22, right -> 27
node(2,21,11,10).
left_node(2,21,22).
right_node(2,21,27).
% node 22: f3 <= 11.5  (F3, bin <= 5)  left -> 23, right -> 24
node(2,22,3,5).
left_node(2,22,23).
right_node(2,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(2,23,0).
% node 24: f10 <= 5095.5  (F10, bin <= 10)  left -> 25, right -> 26
node(2,24,10,10).
left_node(2,24,25).
right_node(2,24,26).
% node 25 (leaf): class >50K (1)
leaf_class(2,25,1).
% node 26 (leaf): class >50K (1)
leaf_class(2,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(2,27,1).
% node 28: f10 <= 7669.5  (F10, bin <= 21)  left -> 29, right -> 32
node(2,28,10,21).
left_node(2,28,29).
right_node(2,28,32).
% node 29: f11 <= 2365.5  (F11, bin <= 15)  left -> 30, right -> 31
node(2,29,11,15).
left_node(2,29,30).
right_node(2,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(2,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(2,31,1).
% node 32 (leaf): class >50K (1)
leaf_class(2,32,1).

% Tree 3
tree(3).
% node 0: f0 <= 31.5  (F0, bin <= 7)  left -> 1, right -> 22
node(3,0,0,7).
left_node(3,0,1).
right_node(3,0,22).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 17
node(3,1,5,3).
left_node(3,1,2).
right_node(3,1,17).
% node 2: f11 <= 1805.0  (F11, bin <= 7)  left -> 3, right -> 16
node(3,2,11,7).
left_node(3,2,3).
right_node(3,2,16).
% node 3: f12 <= 41.5  (F12, bin <= 8)  left -> 4, right -> 9
node(3,3,12,8).
left_node(3,3,4).
right_node(3,3,9).
% node 4: f10 <= 5095.5  (F10, bin <= 10)  left -> 5, right -> 8
node(3,4,10,10).
left_node(3,4,5).
right_node(3,4,8).
% node 5: f3 <= 11.5  (F3, bin <= 5)  left -> 6, right -> 7
node(3,5,3,5).
left_node(3,5,6).
right_node(3,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(3,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(3,7,0).
% node 8 (leaf): class >50K (1)
leaf_class(3,8,1).
% node 9: f0 <= 29.5  (F0, bin <= 5)  left -> 10, right -> 13
node(3,9,0,5).
left_node(3,9,10).
right_node(3,9,13).
% node 10: f4 <= 11.5  (F4, bin <= 5)  left -> 11, right -> 12
node(3,10,4,5).
left_node(3,10,11).
right_node(3,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(3,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(3,12,1).
% node 13: f3 <= 11.5  (F3, bin <= 5)  left -> 14, right -> 15
node(3,13,3,5).
left_node(3,13,14).
right_node(3,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(3,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(3,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(3,16,1).
% node 17: f3 <= 9.5  (F3, bin <= 3)  left -> 18, right -> 19
node(3,17,3,3).
left_node(3,17,18).
right_node(3,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(3,18,0).
% node 19: f10 <= 7731.5  (F10, bin <= 22)  left -> 20, right -> 21
node(3,19,10,22).
left_node(3,19,20).
right_node(3,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(3,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(3,21,1).
% node 22: f10 <= 5095.5  (F10, bin <= 10)  left -> 23, right -> 46
node(3,22,10,10).
left_node(3,22,23).
right_node(3,22,46).
% node 23: f7 <= 0.5  (F7, bin <= 0)  left -> 24, right -> 35
node(3,23,7,0).
left_node(3,23,24).
right_node(3,23,35).
% node 24: f11 <= 1794.0  (F11, bin <= 6)  left -> 25, right -> 34
node(3,24,11,6).
left_node(3,24,25).
right_node(3,24,34).
% node 25: f4 <= 12.5  (F4, bin <= 6)  left -> 26, right -> 31
node(3,25,4,6).
left_node(3,25,26).
right_node(3,25,31).
% node 26: f12 <= 41.5  (F12, bin <= 8)  left -> 27, right -> 30
node(3,26,12,8).
left_node(3,26,27).
right_node(3,26,30).
% node 27: f1 <= 0.5  (F1, bin <= 0)  left -> 28, right -> 29
node(3,27,1,0).
left_node(3,27,28).
right_node(3,27,29).
% node 28 (leaf): class >50K (1)
leaf_class(3,28,1).
% node 29 (leaf): class <=50K (0)
leaf_class(3,29,0).
% node 30 (leaf): class <=50K (0)
leaf_class(3,30,0).
% node 31: f12 <= 31.0  (F12, bin <= 0)  left -> 32, right -> 33
node(3,31,12,0).
left_node(3,31,32).
right_node(3,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(3,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(3,33,1).
% node 34 (leaf): class >50K (1)
leaf_class(3,34,1).
% node 35: f11 <= 1881.5  (F11, bin <= 11)  left -> 36, right -> 45
node(3,35,11,11).
left_node(3,35,36).
right_node(3,35,45).
% node 36: f5 <= 2.5  (F5, bin <= 3)  left -> 37, right -> 42
node(3,36,5,3).
left_node(3,36,37).
right_node(3,36,42).
% node 37: f7 <= 4.5  (F7, bin <= 3)  left -> 38, right -> 39
node(3,37,7,3).
left_node(3,37,38).
right_node(3,37,39).
% node 38 (leaf): class <=50K (0)
leaf_class(3,38,0).
% node 39: f3 <= 8.5  (F3, bin <= 2)  left -> 40, right -> 41
node(3,39,3,2).
left_node(3,39,40).
right_node(3,39,41).
% node 40 (leaf): class <=50K (0)
leaf_class(3,40,0).
% node 41 (leaf): class >50K (1)
leaf_class(3,41,1).
% node 42: f10 <= 4718.5  (F10, bin <= 8)  left -> 43, right -> 44
node(3,42,10,8).
left_node(3,42,43).
right_node(3,42,44).
% node 43 (leaf): class <=50K (0)
leaf_class(3,43,0).
% node 44 (leaf): class >50K (1)
leaf_class(3,44,1).
% node 45 (leaf): class >50K (1)
leaf_class(3,45,1).
% node 46 (leaf): class >50K (1)
leaf_class(3,46,1).

% Tree 4
tree(4).
% node 0: f10 <= 7073.5  (F10, bin <= 17)  left -> 1, right -> 34
node(4,0,10,17).
left_node(4,0,1).
right_node(4,0,34).
% node 1: f12 <= 41.5  (F12, bin <= 8)  left -> 2, right -> 19
node(4,1,12,8).
left_node(4,1,2).
right_node(4,1,19).
% node 2: f12 <= 34.5  (F12, bin <= 4)  left -> 3, right -> 8
node(4,2,12,4).
left_node(4,2,3).
right_node(4,2,8).
% node 3: f5 <= 2.5  (F5, bin <= 3)  left -> 4, right -> 7
node(4,3,5,3).
left_node(4,3,4).
right_node(4,3,7).
% node 4: f3 <= 11.5  (F3, bin <= 5)  left -> 5, right -> 6
node(4,4,3,5).
left_node(4,4,5).
right_node(4,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(4,5,0).
% node 6 (leaf): class <=50K (0)
leaf_class(4,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(4,7,0).
% node 8: f7 <= 0.5  (F7, bin <= 0)  left -> 9, right -> 14
node(4,8,7,0).
left_node(4,8,9).
right_node(4,8,14).
% node 9: f13 <= 28.5  (F13, bin <= 2)  left -> 10, right -> 11
node(4,9,13,2).
left_node(4,9,10).
right_node(4,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(4,10,0).
% node 11: f11 <= 1794.0  (F11, bin <= 6)  left -> 12, right -> 13
node(4,11,11,6).
left_node(4,11,12).
right_node(4,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(4,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(4,13,1).
% node 14: f6 <= 8.5  (F6, bin <= 3)  left -> 15, right -> 16
node(4,14,6,3).
left_node(4,14,15).
right_node(4,14,16).
% node 15 (leaf): class <=50K (0)
leaf_class(4,15,0).
% node 16: f7 <= 4.5  (F7, bin <= 3)  left -> 17, right -> 18
node(4,16,7,3).
left_node(4,16,17).
right_node(4,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(4,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(4,18,1).
% node 19: f0 <= 31.5  (F0, bin <= 7)  left -> 20, right -> 25
node(4,19,0,7).
left_node(4,19,20).
right_node(4,19,25).
% node 20: f5 <= 2.5  (F5, bin <= 3)  left -> 21, right -> 24
node(4,20,5,3).
left_node(4,20,21).
right_node(4,20,24).
% node 21: f4 <= 12.5  (F4, bin <= 6)  left -> 22, right -> 23
node(4,21,4,6).
left_node(4,21,22).
right_node(4,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(4,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(4,23,1).
% node 24 (leaf): class <=50K (0)
leaf_class(4,24,0).
% node 25: f11 <= 1881.5  (F11, bin <= 11)  left -> 26, right -> 33
node(4,25,11,11).
left_node(4,25,26).
right_node(4,25,33).
% node 26: f7 <= 0.5  (F7, bin <= 0)  left -> 27, right -> 30
node(4,26,7,0).
left_node(4,26,27).
right_node(4,26,30).
% node 27: f3 <= 11.5  (F3, bin <= 5)  left -> 28, right -> 29
node(4,27,3,5).
left_node(4,27,28).
right_node(4,27,29).
% node 28 (leaf): class <=50K (0)
leaf_class(4,28,0).
% node 29 (leaf): class >50K (1)
leaf_class(4,29,1).
% node 30: f3 <= 11.5  (F3, bin <= 5)  left -> 31, right -> 32
node(4,30,3,5).
left_node(4,30,31).
right_node(4,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(4,31,0).
% node 32 (leaf): class <=50K (0)
leaf_class(4,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(4,33,1).
% node 34 (leaf): class >50K (1)
leaf_class(4,34,1).

% Tree 5
tree(5).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 20
node(5,0,7,0).
left_node(5,0,1).
right_node(5,0,20).
% node 1: f12 <= 40.5  (F12, bin <= 7)  left -> 2, right -> 13
node(5,1,12,7).
left_node(5,1,2).
right_node(5,1,13).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 12
node(5,2,10,10).
left_node(5,2,3).
right_node(5,2,12).
% node 3: f3 <= 10.5  (F3, bin <= 4)  left -> 4, right -> 11
node(5,3,3,4).
left_node(5,3,4).
right_node(5,3,11).
% node 4: f4 <= 9.5  (F4, bin <= 3)  left -> 5, right -> 10
node(5,4,4,3).
left_node(5,4,5).
right_node(5,4,10).
% node 5: f4 <= 7.5  (F4, bin <= 1)  left -> 6, right -> 7
node(5,5,4,1).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(5,6,0).
% node 7: f0 <= 37.5  (F0, bin <= 12)  left -> 8, right -> 9
node(5,7,0,12).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(5,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(5,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(5,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(5,11,1).
% node 12 (leaf): class >50K (1)
leaf_class(5,12,1).
% node 13: f4 <= 12.5  (F4, bin <= 6)  left -> 14, right -> 19
node(5,13,4,6).
left_node(5,13,14).
right_node(5,13,19).
% node 14: f2 <= 118611.0  (F2, bin <= 3)  left -> 15, right -> 16
node(5,14,2,3).
left_node(5,14,15).
right_node(5,14,16).
% node 15 (leaf): class <=50K (0)
leaf_class(5,15,0).
% node 16: f3 <= 8.5  (F3, bin <= 2)  left -> 17, right -> 18
node(5,16,3,2).
left_node(5,16,17).
right_node(5,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(5,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(5,18,1).
% node 19 (leaf): class >50K (1)
leaf_class(5,19,1).
% node 20: f4 <= 13.5  (F4, bin <= 7)  left -> 21, right -> 32
node(5,20,4,7).
left_node(5,20,21).
right_node(5,20,32).
% node 21: f5 <= 2.5  (F5, bin <= 3)  left -> 22, right -> 29
node(5,21,5,3).
left_node(5,21,22).
right_node(5,21,29).
% node 22: f11 <= 1881.5  (F11, bin <= 11)  left -> 23, right -> 28
node(5,22,11,11).
left_node(5,22,23).
right_node(5,22,28).
% node 23: f7 <= 4.5  (F7, bin <= 3)  left -> 24, right -> 25
node(5,23,7,3).
left_node(5,23,24).
right_node(5,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(5,24,0).
% node 25: f10 <= 5095.5  (F10, bin <= 10)  left -> 26, right -> 27
node(5,25,10,10).
left_node(5,25,26).
right_node(5,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(5,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(5,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(5,28,1).
% node 29: f10 <= 8028.5  (F10, bin <= 23)  left -> 30, right -> 31
node(5,29,10,23).
left_node(5,29,30).
right_node(5,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(5,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(5,31,1).
% node 32: f3 <= 13.5  (F3, bin <= 7)  left -> 33, right -> 36
node(5,32,3,7).
left_node(5,32,33).
right_node(5,32,36).
% node 33: f10 <= 7073.5  (F10, bin <= 17)  left -> 34, right -> 35
node(5,33,10,17).
left_node(5,33,34).
right_node(5,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(5,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(5,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(5,36,1).

% Tree 6
tree(6).
% node 0: f0 <= 29.5  (F0, bin <= 5)  left -> 1, right -> 6
node(6,0,0,5).
left_node(6,0,1).
right_node(6,0,6).
% node 1: f7 <= 0.5  (F7, bin <= 0)  left -> 2, right -> 5
node(6,1,7,0).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 4
node(6,2,10,10).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(6,3,0).
% node 4 (leaf): class >50K (1)
leaf_class(6,4,1).
% node 5 (leaf): class <=50K (0)
leaf_class(6,5,0).
% node 6: f3 <= 11.5  (F3, bin <= 5)  left -> 7, right -> 20
node(6,6,3,5).
left_node(6,6,7).
right_node(6,6,20).
% node 7: f10 <= 5095.5  (F10, bin <= 10)  left -> 8, right -> 19
node(6,7,10,10).
left_node(6,7,8).
right_node(6,7,19).
% node 8: f9 <= 0.5  (F9, bin <= 0)  left -> 9, right -> 10
node(6,8,9,0).
left_node(6,8,9).
right_node(6,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(6,9,0).
% node 10: f3 <= 7.5  (F3, bin <= 1)  left -> 11, right -> 12
node(6,10,3,1).
left_node(6,10,11).
right_node(6,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(6,11,0).
% node 12: f0 <= 35.5  (F0, bin <= 10)  left -> 13, right -> 16
node(6,12,0,10).
left_node(6,12,13).
right_node(6,12,16).
% node 13: f5 <= 2.5  (F5, bin <= 3)  left -> 14, right -> 15
node(6,13,5,3).
left_node(6,13,14).
right_node(6,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(6,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(6,15,0).
% node 16: f12 <= 35.5  (F12, bin <= 5)  left -> 17, right -> 18
node(6,16,12,5).
left_node(6,16,17).
right_node(6,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(6,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(6,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(6,19,1).
% node 20: f3 <= 13.5  (F3, bin <= 7)  left -> 21, right -> 32
node(6,20,3,7).
left_node(6,20,21).
right_node(6,20,32).
% node 21: f10 <= 7073.5  (F10, bin <= 17)  left -> 22, right -> 31
node(6,21,10,17).
left_node(6,21,22).
right_node(6,21,31).
% node 22: f12 <= 42.5  (F12, bin <= 9)  left -> 23, right -> 26
node(6,22,12,9).
left_node(6,22,23).
right_node(6,22,26).
% node 23: f7 <= 0.5  (F7, bin <= 0)  left -> 24, right -> 25
node(6,23,7,0).
left_node(6,23,24).
right_node(6,23,25).
% node 24 (leaf): class >50K (1)
leaf_class(6,24,1).
% node 25 (leaf): class <=50K (0)
leaf_class(6,25,0).
% node 26: f9 <= 0.5  (F9, bin <= 0)  left -> 27, right -> 28
node(6,26,9,0).
left_node(6,26,27).
right_node(6,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(6,27,0).
% node 28: f7 <= 0.5  (F7, bin <= 0)  left -> 29, right -> 30
node(6,28,7,0).
left_node(6,28,29).
right_node(6,28,30).
% node 29 (leaf): class >50K (1)
leaf_class(6,29,1).
% node 30 (leaf): class <=50K (0)
leaf_class(6,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(6,31,1).
% node 32 (leaf): class >50K (1)
leaf_class(6,32,1).

% Tree 7
tree(7).
% node 0: f0 <= 28.5  (F0, bin <= 4)  left -> 1, right -> 10
node(7,0,0,4).
left_node(7,0,1).
right_node(7,0,10).
% node 1: f6 <= 8.5  (F6, bin <= 3)  left -> 2, right -> 5
node(7,1,6,3).
left_node(7,1,2).
right_node(7,1,5).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 4
node(7,2,10,10).
left_node(7,2,3).
right_node(7,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(7,3,0).
% node 4 (leaf): class >50K (1)
leaf_class(7,4,1).
% node 5: f10 <= 7073.5  (F10, bin <= 17)  left -> 6, right -> 9
node(7,5,10,17).
left_node(7,5,6).
right_node(7,5,9).
% node 6: f5 <= 2.5  (F5, bin <= 3)  left -> 7, right -> 8
node(7,6,5,3).
left_node(7,6,7).
right_node(7,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(7,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(7,8,0).
% node 9 (leaf): class >50K (1)
leaf_class(7,9,1).
% node 10: f6 <= 8.5  (F6, bin <= 3)  left -> 11, right -> 28
node(7,10,6,3).
left_node(7,10,11).
right_node(7,10,28).
% node 11: f6 <= 3.5  (F6, bin <= 1)  left -> 12, right -> 25
node(7,11,6,1).
left_node(7,11,12).
right_node(7,11,25).
% node 12: f9 <= 0.5  (F9, bin <= 0)  left -> 13, right -> 16
node(7,12,9,0).
left_node(7,12,13).
right_node(7,12,16).
% node 13: f7 <= 4.5  (F7, bin <= 3)  left -> 14, right -> 15
node(7,13,7,3).
left_node(7,13,14).
right_node(7,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(7,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(7,15,1).
% node 16: f5 <= 2.5  (F5, bin <= 3)  left -> 17, right -> 22
node(7,16,5,3).
left_node(7,16,17).
right_node(7,16,22).
% node 17: f12 <= 40.5  (F12, bin <= 7)  left -> 18, right -> 21
node(7,17,12,7).
left_node(7,17,18).
right_node(7,17,21).
% node 18: f11 <= 1783.0  (F11, bin <= 4)  left -> 19, right -> 20
node(7,18,11,4).
left_node(7,18,19).
right_node(7,18,20).
% node 19 (leaf): class <=50K (0)
leaf_class(7,19,0).
% node 20 (leaf): class >50K (1)
leaf_class(7,20,1).
% node 21 (leaf): class >50K (1)
leaf_class(7,21,1).
% node 22: f3 <= 12.5  (F3, bin <= 6)  left -> 23, right -> 24
node(7,22,3,6).
left_node(7,22,23).
right_node(7,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(7,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(7,24,1).
% node 25: f11 <= 1805.0  (F11, bin <= 7)  left -> 26, right -> 27
node(7,25,11,7).
left_node(7,25,26).
right_node(7,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(7,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(7,27,1).
% node 28: f7 <= 0.5  (F7, bin <= 0)  left -> 29, right -> 40
node(7,28,7,0).
left_node(7,28,29).
right_node(7,28,40).
% node 29: f0 <= 59.5  (F0, bin <= 14)  left -> 30, right -> 37
node(7,29,0,14).
left_node(7,29,30).
right_node(7,29,37).
% node 30: f3 <= 11.5  (F3, bin <= 5)  left -> 31, right -> 32
node(7,30,3,5).
left_node(7,30,31).
right_node(7,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(7,31,0).
% node 32: f11 <= 1794.0  (F11, bin <= 6)  left -> 33, right -> 36
node(7,32,11,6).
left_node(7,32,33).
right_node(7,32,36).
% node 33: f10 <= 5095.5  (F10, bin <= 10)  left -> 34, right -> 35
node(7,33,10,10).
left_node(7,33,34).
right_node(7,33,35).
% node 34 (leaf): class >50K (1)
leaf_class(7,34,1).
% node 35 (leaf): class >50K (1)
leaf_class(7,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(7,36,1).
% node 37: f3 <= 11.5  (F3, bin <= 5)  left -> 38, right -> 39
node(7,37,3,5).
left_node(7,37,38).
right_node(7,37,39).
% node 38 (leaf): class <=50K (0)
leaf_class(7,38,0).
% node 39 (leaf): class >50K (1)
leaf_class(7,39,1).
% node 40: f10 <= 7073.5  (F10, bin <= 17)  left -> 41, right -> 46
node(7,40,10,17).
left_node(7,40,41).
right_node(7,40,46).
% node 41: f3 <= 11.5  (F3, bin <= 5)  left -> 42, right -> 43
node(7,41,3,5).
left_node(7,41,42).
right_node(7,41,43).
% node 42 (leaf): class <=50K (0)
leaf_class(7,42,0).
% node 43: f7 <= 4.5  (F7, bin <= 3)  left -> 44, right -> 45
node(7,43,7,3).
left_node(7,43,44).
right_node(7,43,45).
% node 44 (leaf): class <=50K (0)
leaf_class(7,44,0).
% node 45 (leaf): class >50K (1)
leaf_class(7,45,1).
% node 46 (leaf): class >50K (1)
leaf_class(7,46,1).

% Tree 8
tree(8).
% node 0: f4 <= 12.5  (F4, bin <= 6)  left -> 1, right -> 20
node(8,0,4,6).
left_node(8,0,1).
right_node(8,0,20).
% node 1: f0 <= 32.5  (F0, bin <= 8)  left -> 2, right -> 9
node(8,1,0,8).
left_node(8,1,2).
right_node(8,1,9).
% node 2: f12 <= 40.5  (F12, bin <= 7)  left -> 3, right -> 8
node(8,2,12,7).
left_node(8,2,3).
right_node(8,2,8).
% node 3: f7 <= 4.5  (F7, bin <= 3)  left -> 4, right -> 7
node(8,3,7,3).
left_node(8,3,4).
right_node(8,3,7).
% node 4: f10 <= 7073.5  (F10, bin <= 17)  left -> 5, right -> 6
node(8,4,10,17).
left_node(8,4,5).
right_node(8,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(8,5,0).
% node 6 (leaf): class >50K (1)
leaf_class(8,6,1).
% node 7 (leaf): class <=50K (0)
leaf_class(8,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(8,8,0).
% node 9: f10 <= 5095.5  (F10, bin <= 10)  left -> 10, right -> 19
node(8,9,10,10).
left_node(8,9,10).
right_node(8,9,19).
% node 10: f11 <= 1793.5  (F11, bin <= 5)  left -> 11, right -> 18
node(8,10,11,5).
left_node(8,10,11).
right_node(8,10,18).
% node 11: f8 <= 3.5  (F8, bin <= 1)  left -> 12, right -> 13
node(8,11,8,1).
left_node(8,11,12).
right_node(8,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(8,12,0).
% node 13: f9 <= 0.5  (F9, bin <= 0)  left -> 14, right -> 15
node(8,13,9,0).
left_node(8,13,14).
right_node(8,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(8,14,0).
% node 15: f7 <= 0.5  (F7, bin <= 0)  left -> 16, right -> 17
node(8,15,7,0).
left_node(8,15,16).
right_node(8,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(8,16,0).
% node 17 (leaf): class <=50K (0)
leaf_class(8,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(8,18,1).
% node 19 (leaf): class >50K (1)
leaf_class(8,19,1).
% node 20: f0 <= 28.5  (F0, bin <= 4)  left -> 21, right -> 24
node(8,20,0,4).
left_node(8,20,21).
right_node(8,20,24).
% node 21: f5 <= 2.5  (F5, bin <= 3)  left -> 22, right -> 23
node(8,21,5,3).
left_node(8,21,22).
right_node(8,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(8,22,0).
% node 23 (leaf): class <=50K (0)
leaf_class(8,23,0).
% node 24: f4 <= 14.5  (F4, bin <= 8)  left -> 25, right -> 34
node(8,24,4,8).
left_node(8,24,25).
right_node(8,24,34).
% node 25: f7 <= 0.5  (F7, bin <= 0)  left -> 26, right -> 29
node(8,25,7,0).
left_node(8,25,26).
right_node(8,25,29).
% node 26: f10 <= 5095.5  (F10, bin <= 10)  left -> 27, right -> 28
node(8,26,10,10).
left_node(8,26,27).
right_node(8,26,28).
% node 27 (leaf): class >50K (1)
leaf_class(8,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(8,28,1).
% node 29: f7 <= 4.5  (F7, bin <= 3)  left -> 30, right -> 33
node(8,29,7,3).
left_node(8,29,30).
right_node(8,29,33).
% node 30: f12 <= 44.5  (F12, bin <= 11)  left -> 31, right -> 32
node(8,30,12,11).
left_node(8,30,31).
right_node(8,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(8,31,0).
% node 32 (leaf): class <=50K (0)
leaf_class(8,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(8,33,1).
% node 34 (leaf): class >50K (1)
leaf_class(8,34,1).

% Tree 9
tree(9).
% node 0: f10 <= 5095.5  (F10, bin <= 10)  left -> 1, right -> 36
node(9,0,10,10).
left_node(9,0,1).
right_node(9,0,36).
% node 1: f0 <= 31.5  (F0, bin <= 7)  left -> 2, right -> 9
node(9,1,0,7).
left_node(9,1,2).
right_node(9,1,9).
% node 2: f0 <= 27.5  (F0, bin <= 3)  left -> 3, right -> 4
node(9,2,0,3).
left_node(9,2,3).
right_node(9,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(9,3,0).
% node 4: f5 <= 2.5  (F5, bin <= 3)  left -> 5, right -> 8
node(9,4,5,3).
left_node(9,4,5).
right_node(9,4,8).
% node 5: f4 <= 11.5  (F4, bin <= 5)  left -> 6, right -> 7
node(9,5,4,5).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(9,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(9,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(9,8,0).
% node 9: f7 <= 0.5  (F7, bin <= 0)  left -> 10, right -> 23
node(9,9,7,0).
left_node(9,9,10).
right_node(9,9,23).
% node 10: f11 <= 1782.5  (F11, bin <= 3)  left -> 11, right -> 18
node(9,10,11,3).
left_node(9,10,11).
right_node(9,10,18).
% node 11: f3 <= 11.5  (F3, bin <= 5)  left -> 12, right -> 17
node(9,11,3,5).
left_node(9,11,12).
right_node(9,11,17).
% node 12: f11 <= 1512.0  (F11, bin <= 0)  left -> 13, right -> 16
node(9,12,11,0).
left_node(9,12,13).
right_node(9,12,16).
% node 13: f12 <= 34.5  (F12, bin <= 4)  left -> 14, right -> 15
node(9,13,12,4).
left_node(9,13,14).
right_node(9,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(9,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(9,15,0).
% node 16 (leaf): class <=50K (0)
leaf_class(9,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(9,17,1).
% node 18: f3 <= 11.5  (F3, bin <= 5)  left -> 19, right -> 22
node(9,18,3,5).
left_node(9,18,19).
right_node(9,18,22).
% node 19: f11 <= 1989.5  (F11, bin <= 13)  left -> 20, right -> 21
node(9,19,11,13).
left_node(9,19,20).
right_node(9,19,21).
% node 20 (leaf): class >50K (1)
leaf_class(9,20,1).
% node 21 (leaf): class <=50K (0)
leaf_class(9,21,0).
% node 22 (leaf): class >50K (1)
leaf_class(9,22,1).
% node 23: f0 <= 60.5  (F0, bin <= 15)  left -> 24, right -> 35
node(9,23,0,15).
left_node(9,23,24).
right_node(9,23,35).
% node 24: f6 <= 8.5  (F6, bin <= 3)  left -> 25, right -> 30
node(9,24,6,3).
left_node(9,24,25).
right_node(9,24,30).
% node 25: f2 <= 25660.5  (F2, bin <= 0)  left -> 26, right -> 27
node(9,25,2,0).
left_node(9,25,26).
right_node(9,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(9,26,0).
% node 27: f4 <= 12.5  (F4, bin <= 6)  left -> 28, right -> 29
node(9,27,4,6).
left_node(9,27,28).
right_node(9,27,29).
% node 28 (leaf): class <=50K (0)
leaf_class(9,28,0).
% node 29 (leaf): class <=50K (0)
leaf_class(9,29,0).
% node 30: f11 <= 1881.5  (F11, bin <= 11)  left -> 31, right -> 34
node(9,30,11,11).
left_node(9,30,31).
right_node(9,30,34).
% node 31: f7 <= 4.5  (F7, bin <= 3)  left -> 32, right -> 33
node(9,31,7,3).
left_node(9,31,32).
right_node(9,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(9,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(9,33,1).
% node 34 (leaf): class >50K (1)
leaf_class(9,34,1).
% node 35 (leaf): class <=50K (0)
leaf_class(9,35,0).
% node 36 (leaf): class >50K (1)
leaf_class(9,36,1).

% Tree 10
tree(10).
% node 0: f10 <= 5119.0  (F10, bin <= 11)  left -> 1, right -> 28
node(10,0,10,11).
left_node(10,0,1).
right_node(10,0,28).
% node 1: f11 <= 1820.5  (F11, bin <= 9)  left -> 2, right -> 21
node(10,1,11,9).
left_node(10,1,2).
right_node(10,1,21).
% node 2: f9 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(10,2,9,0).
left_node(10,2,3).
right_node(10,2,10).
% node 3: f3 <= 11.5  (F3, bin <= 5)  left -> 4, right -> 7
node(10,3,3,5).
left_node(10,3,4).
right_node(10,3,7).
% node 4: f7 <= 4.5  (F7, bin <= 3)  left -> 5, right -> 6
node(10,4,7,3).
left_node(10,4,5).
right_node(10,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(10,5,0).
% node 6 (leaf): class <=50K (0)
leaf_class(10,6,0).
% node 7: f7 <= 4.5  (F7, bin <= 3)  left -> 8, right -> 9
node(10,7,7,3).
left_node(10,7,8).
right_node(10,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(10,8,0).
% node 9 (leaf): class >50K (1)
leaf_class(10,9,1).
% node 10: f5 <= 2.5  (F5, bin <= 3)  left -> 11, right -> 20
node(10,10,5,3).
left_node(10,10,11).
right_node(10,10,20).
% node 11: f6 <= 8.0  (F6, bin <= 2)  left -> 12, right -> 15
node(10,11,6,2).
left_node(10,11,12).
right_node(10,11,15).
% node 12: f0 <= 32.5  (F0, bin <= 8)  left -> 13, right -> 14
node(10,12,0,8).
left_node(10,12,13).
right_node(10,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(10,13,0).
% node 14 (leaf): class <=50K (0)
leaf_class(10,14,0).
% node 15: f3 <= 11.5  (F3, bin <= 5)  left -> 16, right -> 19
node(10,15,3,5).
left_node(10,15,16).
right_node(10,15,19).
% node 16: f5 <= 1.5  (F5, bin <= 2)  left -> 17, right -> 18
node(10,16,5,2).
left_node(10,16,17).
right_node(10,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(10,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(10,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(10,19,1).
% node 20 (leaf): class <=50K (0)
leaf_class(10,20,0).
% node 21: f7 <= 0.5  (F7, bin <= 0)  left -> 22, right -> 27
node(10,21,7,0).
left_node(10,21,22).
right_node(10,21,27).
% node 22: f13 <= 33.5  (F13, bin <= 4)  left -> 23, right -> 24
node(10,22,13,4).
left_node(10,22,23).
right_node(10,22,24).
% node 23 (leaf): class >50K (1)
leaf_class(10,23,1).
% node 24: f11 <= 1989.5  (F11, bin <= 13)  left -> 25, right -> 26
node(10,24,11,13).
left_node(10,24,25).
right_node(10,24,26).
% node 25 (leaf): class >50K (1)
leaf_class(10,25,1).
% node 26 (leaf): class <=50K (0)
leaf_class(10,26,0).
% node 27 (leaf): class <=50K (0)
leaf_class(10,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(10,28,1).

% Tree 11
tree(11).
% node 0: f9 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 16
node(11,0,9,0).
left_node(11,0,1).
right_node(11,0,16).
% node 1: f0 <= 27.5  (F0, bin <= 3)  left -> 2, right -> 3
node(11,1,0,3).
left_node(11,1,2).
right_node(11,1,3).
% node 2 (leaf): class <=50K (0)
leaf_class(11,2,0).
% node 3: f3 <= 11.5  (F3, bin <= 5)  left -> 4, right -> 9
node(11,3,3,5).
left_node(11,3,4).
right_node(11,3,9).
% node 4: f10 <= 7073.5  (F10, bin <= 17)  left -> 5, right -> 8
node(11,4,10,17).
left_node(11,4,5).
right_node(11,4,8).
% node 5: f5 <= 2.5  (F5, bin <= 3)  left -> 6, right -> 7
node(11,5,5,3).
left_node(11,5,6).
right_node(11,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(11,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(11,7,0).
% node 8 (leaf): class >50K (1)
leaf_class(11,8,1).
% node 9: f7 <= 4.5  (F7, bin <= 3)  left -> 10, right -> 15
node(11,9,7,3).
left_node(11,9,10).
right_node(11,9,15).
% node 10: f12 <= 42.5  (F12, bin <= 9)  left -> 11, right -> 12
node(11,10,12,9).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(11,11,0).
% node 12: f10 <= 4718.5  (F10, bin <= 8)  left -> 13, right -> 14
node(11,12,10,8).
left_node(11,12,13).
right_node(11,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(11,13,0).
% node 14 (leaf): class >50K (1)
leaf_class(11,14,1).
% node 15 (leaf): class >50K (1)
leaf_class(11,15,1).
% node 16: f12 <= 41.5  (F12, bin <= 8)  left -> 17, right -> 40
node(11,16,12,8).
left_node(11,16,17).
right_node(11,16,40).
% node 17: f6 <= 8.5  (F6, bin <= 3)  left -> 18, right -> 27
node(11,17,6,3).
left_node(11,17,18).
right_node(11,17,27).
% node 18: f5 <= 2.5  (F5, bin <= 3)  left -> 19, right -> 26
node(11,18,5,3).
left_node(11,18,19).
right_node(11,18,26).
% node 19: f3 <= 11.5  (F3, bin <= 5)  left -> 20, right -> 25
node(11,19,3,5).
left_node(11,19,20).
right_node(11,19,25).
% node 20: f0 <= 33.5  (F0, bin <= 9)  left -> 21, right -> 22
node(11,20,0,9).
left_node(11,20,21).
right_node(11,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(11,21,0).
% node 22: f7 <= 0.5  (F7, bin <= 0)  left -> 23, right -> 24
node(11,22,7,0).
left_node(11,22,23).
right_node(11,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(11,23,0).
% node 24 (leaf): class <=50K (0)
leaf_class(11,24,0).
% node 25 (leaf): class >50K (1)
leaf_class(11,25,1).
% node 26 (leaf): class <=50K (0)
leaf_class(11,26,0).
% node 27: f3 <= 11.5  (F3, bin <= 5)  left -> 28, right -> 33
node(11,27,3,5).
left_node(11,27,28).
right_node(11,27,33).
% node 28: f5 <= 2.5  (F5, bin <= 3)  left -> 29, right -> 32
node(11,28,5,3).
left_node(11,28,29).
right_node(11,28,32).
% node 29: f4 <= 9.5  (F4, bin <= 3)  left -> 30, right -> 31
node(11,29,4,3).
left_node(11,29,30).
right_node(11,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(11,30,0).
% node 31 (leaf): class <=50K (0)
leaf_class(11,31,0).
% node 32 (leaf): class <=50K (0)
leaf_class(11,32,0).
% node 33: f4 <= 14.5  (F4, bin <= 8)  left -> 34, right -> 39
node(11,33,4,8).
left_node(11,33,34).
right_node(11,33,39).
% node 34: f11 <= 1725.0  (F11, bin <= 2)  left -> 35, right -> 38
node(11,34,11,2).
left_node(11,34,35).
right_node(11,34,38).
% node 35: f7 <= 0.5  (F7, bin <= 0)  left -> 36, right -> 37
node(11,35,7,0).
left_node(11,35,36).
right_node(11,35,37).
% node 36 (leaf): class >50K (1)
leaf_class(11,36,1).
% node 37 (leaf): class <=50K (0)
leaf_class(11,37,0).
% node 38 (leaf): class >50K (1)
leaf_class(11,38,1).
% node 39 (leaf): class >50K (1)
leaf_class(11,39,1).
% node 40: f6 <= 3.5  (F6, bin <= 1)  left -> 41, right -> 46
node(11,40,6,1).
left_node(11,40,41).
right_node(11,40,46).
% node 41: f7 <= 0.5  (F7, bin <= 0)  left -> 42, right -> 45
node(11,41,7,0).
left_node(11,41,42).
right_node(11,41,45).
% node 42: f3 <= 11.5  (F3, bin <= 5)  left -> 43, right -> 44
node(11,42,3,5).
left_node(11,42,43).
right_node(11,42,44).
% node 43 (leaf): class <=50K (0)
leaf_class(11,43,0).
% node 44 (leaf): class >50K (1)
leaf_class(11,44,1).
% node 45 (leaf): class <=50K (0)
leaf_class(11,45,0).
% node 46: f4 <= 12.5  (F4, bin <= 6)  left -> 47, right -> 54
node(11,46,4,6).
left_node(11,46,47).
right_node(11,46,54).
% node 47: f5 <= 2.5  (F5, bin <= 3)  left -> 48, right -> 53
node(11,47,5,3).
left_node(11,47,48).
right_node(11,47,53).
% node 48: f5 <= 1.5  (F5, bin <= 2)  left -> 49, right -> 50
node(11,48,5,2).
left_node(11,48,49).
right_node(11,48,50).
% node 49 (leaf): class <=50K (0)
leaf_class(11,49,0).
% node 50: f10 <= 5095.5  (F10, bin <= 10)  left -> 51, right -> 52
node(11,50,10,10).
left_node(11,50,51).
right_node(11,50,52).
% node 51 (leaf): class <=50K (0)
leaf_class(11,51,0).
% node 52 (leaf): class >50K (1)
leaf_class(11,52,1).
% node 53 (leaf): class <=50K (0)
leaf_class(11,53,0).
% node 54: f7 <= 0.5  (F7, bin <= 0)  left -> 55, right -> 56
node(11,54,7,0).
left_node(11,54,55).
right_node(11,54,56).
% node 55 (leaf): class >50K (1)
leaf_class(11,55,1).
% node 56 (leaf): class <=50K (0)
leaf_class(11,56,0).

% Tree 12
tree(12).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 18
node(12,0,7,0).
left_node(12,0,1).
right_node(12,0,18).
% node 1: f3 <= 11.5  (F3, bin <= 5)  left -> 2, right -> 11
node(12,1,3,5).
left_node(12,1,2).
right_node(12,1,11).
% node 2: f4 <= 7.5  (F4, bin <= 1)  left -> 3, right -> 4
node(12,2,4,1).
left_node(12,2,3).
right_node(12,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(12,3,0).
% node 4: f10 <= 5095.5  (F10, bin <= 10)  left -> 5, right -> 10
node(12,4,10,10).
left_node(12,4,5).
right_node(12,4,10).
% node 5: f12 <= 34.5  (F12, bin <= 4)  left -> 6, right -> 7
node(12,5,12,4).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(12,6,0).
% node 7: f4 <= 9.5  (F4, bin <= 3)  left -> 8, right -> 9
node(12,7,4,3).
left_node(12,7,8).
right_node(12,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(12,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(12,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(12,10,1).
% node 11: f11 <= 1782.5  (F11, bin <= 3)  left -> 12, right -> 17
node(12,11,11,3).
left_node(12,11,12).
right_node(12,11,17).
% node 12: f12 <= 31.0  (F12, bin <= 0)  left -> 13, right -> 14
node(12,12,12,0).
left_node(12,12,13).
right_node(12,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(12,13,0).
% node 14: f10 <= 5095.5  (F10, bin <= 10)  left -> 15, right -> 16
node(12,14,10,10).
left_node(12,14,15).
right_node(12,14,16).
% node 15 (leaf): class >50K (1)
leaf_class(12,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(12,16,1).
% node 17 (leaf): class >50K (1)
leaf_class(12,17,1).
% node 18: f0 <= 31.5  (F0, bin <= 7)  left -> 19, right -> 24
node(12,18,0,7).
left_node(12,18,19).
right_node(12,18,24).
% node 19: f3 <= 9.5  (F3, bin <= 3)  left -> 20, right -> 21
node(12,19,3,3).
left_node(12,19,20).
right_node(12,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(12,20,0).
% node 21: f10 <= 7073.5  (F10, bin <= 17)  left -> 22, right -> 23
node(12,21,10,17).
left_node(12,21,22).
right_node(12,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(12,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(12,23,1).
% node 24: f6 <= 8.5  (F6, bin <= 3)  left -> 25, right -> 32
node(12,24,6,3).
left_node(12,24,25).
right_node(12,24,32).
% node 25: f7 <= 4.5  (F7, bin <= 3)  left -> 26, right -> 31
node(12,25,7,3).
left_node(12,25,26).
right_node(12,25,31).
% node 26: f4 <= 12.5  (F4, bin <= 6)  left -> 27, right -> 28
node(12,26,4,6).
left_node(12,26,27).
right_node(12,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(12,27,0).
% node 28: f10 <= 7139.5  (F10, bin <= 18)  left -> 29, right -> 30
node(12,28,10,18).
left_node(12,28,29).
right_node(12,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(12,29,0).
% node 30 (leaf): class >50K (1)
leaf_class(12,30,1).
% node 31 (leaf): class <=50K (0)
leaf_class(12,31,0).
% node 32: f1 <= 2.0  (F1, bin <= 1)  left -> 33, right -> 34
node(12,32,1,1).
left_node(12,32,33).
right_node(12,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(12,33,0).
% node 34: f10 <= 7073.5  (F10, bin <= 17)  left -> 35, right -> 38
node(12,34,10,17).
left_node(12,34,35).
right_node(12,34,38).
% node 35: f7 <= 4.5  (F7, bin <= 3)  left -> 36, right -> 37
node(12,35,7,3).
left_node(12,35,36).
right_node(12,35,37).
% node 36 (leaf): class <=50K (0)
leaf_class(12,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(12,37,1).
% node 38 (leaf): class >50K (1)
leaf_class(12,38,1).

% Tree 13
tree(13).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 28
node(13,0,7,0).
left_node(13,0,1).
right_node(13,0,28).
% node 1: f4 <= 12.5  (F4, bin <= 6)  left -> 2, right -> 17
node(13,1,4,6).
left_node(13,1,2).
right_node(13,1,17).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 16
node(13,2,10,10).
left_node(13,2,3).
right_node(13,2,16).
% node 3: f11 <= 1782.5  (F11, bin <= 3)  left -> 4, right -> 15
node(13,3,11,3).
left_node(13,3,4).
right_node(13,3,15).
% node 4: f6 <= 3.5  (F6, bin <= 1)  left -> 5, right -> 10
node(13,4,6,1).
left_node(13,4,5).
right_node(13,4,10).
% node 5: f1 <= 4.5  (F1, bin <= 2)  left -> 6, right -> 9
node(13,5,1,2).
left_node(13,5,6).
right_node(13,5,9).
% node 6: f0 <= 30.5  (F0, bin <= 6)  left -> 7, right -> 8
node(13,6,0,6).
left_node(13,6,7).
right_node(13,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(13,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(13,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(13,9,0).
% node 10: f12 <= 34.0  (F12, bin <= 3)  left -> 11, right -> 12
node(13,10,12,3).
left_node(13,10,11).
right_node(13,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(13,11,0).
% node 12: f6 <= 8.0  (F6, bin <= 2)  left -> 13, right -> 14
node(13,12,6,2).
left_node(13,12,13).
right_node(13,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(13,13,0).
% node 14 (leaf): class <=50K (0)
leaf_class(13,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(13,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(13,16,1).
% node 17: f12 <= 31.0  (F12, bin <= 0)  left -> 18, right -> 19
node(13,17,12,0).
left_node(13,17,18).
right_node(13,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(13,18,0).
% node 19: f13 <= 22.5  (F13, bin <= 0)  left -> 20, right -> 21
node(13,19,13,0).
left_node(13,19,20).
right_node(13,19,21).
% node 20 (leaf): class >50K (1)
leaf_class(13,20,1).
% node 21: f10 <= 5095.5  (F10, bin <= 10)  left -> 22, right -> 27
node(13,21,10,10).
left_node(13,21,22).
right_node(13,21,27).
% node 22: f10 <= 3283.5  (F10, bin <= 2)  left -> 23, right -> 26
node(13,22,10,2).
left_node(13,22,23).
right_node(13,22,26).
% node 23: f0 <= 28.5  (F0, bin <= 4)  left -> 24, right -> 25
node(13,23,0,4).
left_node(13,23,24).
right_node(13,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(13,24,0).
% node 25 (leaf): class >50K (1)
leaf_class(13,25,1).
% node 26 (leaf): class <=50K (0)
leaf_class(13,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(13,27,1).
% node 28: f10 <= 7073.5  (F10, bin <= 17)  left -> 29, right -> 42
node(13,28,10,17).
left_node(13,28,29).
right_node(13,28,42).
% node 29: f4 <= 12.5  (F4, bin <= 6)  left -> 30, right -> 35
node(13,29,4,6).
left_node(13,29,30).
right_node(13,29,35).
% node 30: f6 <= 3.5  (F6, bin <= 1)  left -> 31, right -> 34
node(13,30,6,1).
left_node(13,30,31).
right_node(13,30,34).
% node 31: f7 <= 4.5  (F7, bin <= 3)  left -> 32, right -> 33
node(13,31,7,3).
left_node(13,31,32).
right_node(13,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(13,32,0).
% node 33 (leaf): class <=50K (0)
leaf_class(13,33,0).
% node 34 (leaf): class <=50K (0)
leaf_class(13,34,0).
% node 35: f0 <= 27.5  (F0, bin <= 3)  left -> 36, right -> 37
node(13,35,0,3).
left_node(13,35,36).
right_node(13,35,37).
% node 36 (leaf): class <=50K (0)
leaf_class(13,36,0).
% node 37: f4 <= 14.5  (F4, bin <= 8)  left -> 38, right -> 41
node(13,37,4,8).
left_node(13,37,38).
right_node(13,37,41).
% node 38: f11 <= 1881.5  (F11, bin <= 11)  left -> 39, right -> 40
node(13,38,11,11).
left_node(13,38,39).
right_node(13,38,40).
% node 39 (leaf): class <=50K (0)
leaf_class(13,39,0).
% node 40 (leaf): class >50K (1)
leaf_class(13,40,1).
% node 41 (leaf): class >50K (1)
leaf_class(13,41,1).
% node 42 (leaf): class >50K (1)
leaf_class(13,42,1).

% Tree 14
tree(14).
% node 0: f9 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 18
node(14,0,9,0).
left_node(14,0,1).
right_node(14,0,18).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 17
node(14,1,5,3).
left_node(14,1,2).
right_node(14,1,17).
% node 2: f1 <= 2.0  (F1, bin <= 1)  left -> 3, right -> 6
node(14,2,1,1).
left_node(14,2,3).
right_node(14,2,6).
% node 3: f5 <= 1.5  (F5, bin <= 2)  left -> 4, right -> 5
node(14,3,5,2).
left_node(14,3,4).
right_node(14,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(14,4,0).
% node 5 (leaf): class >50K (1)
leaf_class(14,5,1).
% node 6: f4 <= 12.5  (F4, bin <= 6)  left -> 7, right -> 12
node(14,6,4,6).
left_node(14,6,7).
right_node(14,6,12).
% node 7: f7 <= 4.5  (F7, bin <= 3)  left -> 8, right -> 11
node(14,7,7,3).
left_node(14,7,8).
right_node(14,7,11).
% node 8: f10 <= 7073.5  (F10, bin <= 17)  left -> 9, right -> 10
node(14,8,10,17).
left_node(14,8,9).
right_node(14,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(14,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(14,10,1).
% node 11 (leaf): class <=50K (0)
leaf_class(14,11,0).
% node 12: f10 <= 6963.5  (F10, bin <= 15)  left -> 13, right -> 16
node(14,12,10,15).
left_node(14,12,13).
right_node(14,12,16).
% node 13: f5 <= 0.5  (F5, bin <= 0)  left -> 14, right -> 15
node(14,13,5,0).
left_node(14,13,14).
right_node(14,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(14,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(14,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(14,16,1).
% node 17 (leaf): class <=50K (0)
leaf_class(14,17,0).
% node 18: f10 <= 5095.5  (F10, bin <= 10)  left -> 19, right -> 42
node(14,18,10,10).
left_node(14,18,19).
right_node(14,18,42).
% node 19: f11 <= 1793.5  (F11, bin <= 5)  left -> 20, right -> 39
node(14,19,11,5).
left_node(14,19,20).
right_node(14,19,39).
% node 20: f6 <= 8.5  (F6, bin <= 3)  left -> 21, right -> 30
node(14,20,6,3).
left_node(14,20,21).
right_node(14,20,30).
% node 21: f8 <= 3.5  (F8, bin <= 1)  left -> 22, right -> 23
node(14,21,8,1).
left_node(14,21,22).
right_node(14,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(14,22,0).
% node 23: f3 <= 11.5  (F3, bin <= 5)  left -> 24, right -> 27
node(14,23,3,5).
left_node(14,23,24).
right_node(14,23,27).
% node 24: f7 <= 0.5  (F7, bin <= 0)  left -> 25, right -> 26
node(14,24,7,0).
left_node(14,24,25).
right_node(14,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(14,25,0).
% node 26 (leaf): class <=50K (0)
leaf_class(14,26,0).
% node 27: f0 <= 30.5  (F0, bin <= 6)  left -> 28, right -> 29
node(14,27,0,6).
left_node(14,27,28).
right_node(14,27,29).
% node 28 (leaf): class <=50K (0)
leaf_class(14,28,0).
% node 29 (leaf): class >50K (1)
leaf_class(14,29,1).
% node 30: f4 <= 12.5  (F4, bin <= 6)  left -> 31, right -> 36
node(14,30,4,6).
left_node(14,30,31).
right_node(14,30,36).
% node 31: f3 <= 7.5  (F3, bin <= 1)  left -> 32, right -> 33
node(14,31,3,1).
left_node(14,31,32).
right_node(14,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(14,32,0).
% node 33: f7 <= 0.5  (F7, bin <= 0)  left -> 34, right -> 35
node(14,33,7,0).
left_node(14,33,34).
right_node(14,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(14,34,0).
% node 35 (leaf): class <=50K (0)
leaf_class(14,35,0).
% node 36: f5 <= 2.5  (F5, bin <= 3)  left -> 37, right -> 38
node(14,36,5,3).
left_node(14,36,37).
right_node(14,36,38).
% node 37 (leaf): class >50K (1)
leaf_class(14,37,1).
% node 38 (leaf): class <=50K (0)
leaf_class(14,38,0).
% node 39: f7 <= 0.5  (F7, bin <= 0)  left -> 40, right -> 41
node(14,39,7,0).
left_node(14,39,40).
right_node(14,39,41).
% node 40 (leaf): class >50K (1)
leaf_class(14,40,1).
% node 41 (leaf): class <=50K (0)
leaf_class(14,41,0).
% node 42 (leaf): class >50K (1)
leaf_class(14,42,1).

% Tree 15
tree(15).
% node 0: f0 <= 30.5  (F0, bin <= 6)  left -> 1, right -> 14
node(15,0,0,6).
left_node(15,0,1).
right_node(15,0,14).
% node 1: f6 <= 8.5  (F6, bin <= 3)  left -> 2, right -> 5
node(15,1,6,3).
left_node(15,1,2).
right_node(15,1,5).
% node 2: f10 <= 7073.5  (F10, bin <= 17)  left -> 3, right -> 4
node(15,2,10,17).
left_node(15,2,3).
right_node(15,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(15,3,0).
% node 4 (leaf): class >50K (1)
leaf_class(15,4,1).
% node 5: f11 <= 1805.0  (F11, bin <= 7)  left -> 6, right -> 13
node(15,5,11,7).
left_node(15,5,6).
right_node(15,5,13).
% node 6: f12 <= 43.5  (F12, bin <= 10)  left -> 7, right -> 10
node(15,6,12,10).
left_node(15,6,7).
right_node(15,6,10).
% node 7: f10 <= 5095.5  (F10, bin <= 10)  left -> 8, right -> 9
node(15,7,10,10).
left_node(15,7,8).
right_node(15,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(15,8,0).
% node 9 (leaf): class >50K (1)
leaf_class(15,9,1).
% node 10: f10 <= 7073.5  (F10, bin <= 17)  left -> 11, right -> 12
node(15,10,10,17).
left_node(15,10,11).
right_node(15,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(15,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(15,12,1).
% node 13 (leaf): class <=50K (0)
leaf_class(15,13,0).
% node 14: f9 <= 0.5  (F9, bin <= 0)  left -> 15, right -> 28
node(15,14,9,0).
left_node(15,14,15).
right_node(15,14,28).
% node 15: f12 <= 49.5  (F12, bin <= 14)  left -> 16, right -> 25
node(15,15,12,14).
left_node(15,15,16).
right_node(15,15,25).
% node 16: f7 <= 4.5  (F7, bin <= 3)  left -> 17, right -> 20
node(15,16,7,3).
left_node(15,16,17).
right_node(15,16,20).
% node 17: f10 <= 7073.5  (F10, bin <= 17)  left -> 18, right -> 19
node(15,17,10,17).
left_node(15,17,18).
right_node(15,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(15,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(15,19,1).
% node 20: f8 <= 3.5  (F8, bin <= 1)  left -> 21, right -> 22
node(15,20,8,1).
left_node(15,20,21).
right_node(15,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(15,21,0).
% node 22: f3 <= 8.5  (F3, bin <= 2)  left -> 23, right -> 24
node(15,22,3,2).
left_node(15,22,23).
right_node(15,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(15,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(15,24,1).
% node 25: f10 <= 7268.5  (F10, bin <= 19)  left -> 26, right -> 27
node(15,25,10,19).
left_node(15,25,26).
right_node(15,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(15,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(15,27,1).
% node 28: f12 <= 42.5  (F12, bin <= 9)  left -> 29, right -> 44
node(15,28,12,9).
left_node(15,28,29).
right_node(15,28,44).
% node 29: f7 <= 0.5  (F7, bin <= 0)  left -> 30, right -> 37
node(15,29,7,0).
left_node(15,29,30).
right_node(15,29,37).
% node 30: f10 <= 5095.5  (F10, bin <= 10)  left -> 31, right -> 36
node(15,30,10,10).
left_node(15,30,31).
right_node(15,30,36).
% node 31: f12 <= 33.5  (F12, bin <= 2)  left -> 32, right -> 33
node(15,31,12,2).
left_node(15,31,32).
right_node(15,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(15,32,0).
% node 33: f11 <= 1782.5  (F11, bin <= 3)  left -> 34, right -> 35
node(15,33,11,3).
left_node(15,33,34).
right_node(15,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(15,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(15,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(15,36,1).
% node 37: f8 <= 3.5  (F8, bin <= 1)  left -> 38, right -> 39
node(15,37,8,1).
left_node(15,37,38).
right_node(15,37,39).
% node 38 (leaf): class <=50K (0)
leaf_class(15,38,0).
% node 39: f10 <= 8296.0  (F10, bin <= 24)  left -> 40, right -> 43
node(15,39,10,24).
left_node(15,39,40).
right_node(15,39,43).
% node 40: f3 <= 11.5  (F3, bin <= 5)  left -> 41, right -> 42
node(15,40,3,5).
left_node(15,40,41).
right_node(15,40,42).
% node 41 (leaf): class <=50K (0)
leaf_class(15,41,0).
% node 42 (leaf): class <=50K (0)
leaf_class(15,42,0).
% node 43 (leaf): class >50K (1)
leaf_class(15,43,1).
% node 44: f10 <= 7073.5  (F10, bin <= 17)  left -> 45, right -> 56
node(15,44,10,17).
left_node(15,44,45).
right_node(15,44,56).
% node 45: f3 <= 11.5  (F3, bin <= 5)  left -> 46, right -> 51
node(15,45,3,5).
left_node(15,45,46).
right_node(15,45,51).
% node 46: f3 <= 8.5  (F3, bin <= 2)  left -> 47, right -> 48
node(15,46,3,2).
left_node(15,46,47).
right_node(15,46,48).
% node 47 (leaf): class <=50K (0)
leaf_class(15,47,0).
% node 48: f7 <= 0.5  (F7, bin <= 0)  left -> 49, right -> 50
node(15,48,7,0).
left_node(15,48,49).
right_node(15,48,50).
% node 49 (leaf): class >50K (1)
leaf_class(15,49,1).
% node 50 (leaf): class <=50K (0)
leaf_class(15,50,0).
% node 51: f10 <= 1101.0  (F10, bin <= 0)  left -> 52, right -> 55
node(15,51,10,0).
left_node(15,51,52).
right_node(15,51,55).
% node 52: f7 <= 0.5  (F7, bin <= 0)  left -> 53, right -> 54
node(15,52,7,0).
left_node(15,52,53).
right_node(15,52,54).
% node 53 (leaf): class >50K (1)
leaf_class(15,53,1).
% node 54 (leaf): class <=50K (0)
leaf_class(15,54,0).
% node 55 (leaf): class <=50K (0)
leaf_class(15,55,0).
% node 56 (leaf): class >50K (1)
leaf_class(15,56,1).

% Tree 16
tree(16).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 20
node(16,0,5,3).
left_node(16,0,1).
right_node(16,0,20).
% node 1: f4 <= 12.5  (F4, bin <= 6)  left -> 2, right -> 13
node(16,1,4,6).
left_node(16,1,2).
right_node(16,1,13).
% node 2: f4 <= 8.5  (F4, bin <= 2)  left -> 3, right -> 4
node(16,2,4,2).
left_node(16,2,3).
right_node(16,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(16,3,0).
% node 4: f10 <= 5095.5  (F10, bin <= 10)  left -> 5, right -> 12
node(16,4,10,10).
left_node(16,4,5).
right_node(16,4,12).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(16,5,5,0).
left_node(16,5,6).
right_node(16,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(16,6,0).
% node 7: f0 <= 35.5  (F0, bin <= 10)  left -> 8, right -> 9
node(16,7,0,10).
left_node(16,7,8).
right_node(16,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(16,8,0).
% node 9: f4 <= 9.5  (F4, bin <= 3)  left -> 10, right -> 11
node(16,9,4,3).
left_node(16,9,10).
right_node(16,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(16,10,0).
% node 11 (leaf): class <=50K (0)
leaf_class(16,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(16,12,1).
% node 13: f7 <= 0.5  (F7, bin <= 0)  left -> 14, right -> 17
node(16,13,7,0).
left_node(16,13,14).
right_node(16,13,17).
% node 14: f10 <= 5095.5  (F10, bin <= 10)  left -> 15, right -> 16
node(16,14,10,10).
left_node(16,14,15).
right_node(16,14,16).
% node 15 (leaf): class >50K (1)
leaf_class(16,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(16,16,1).
% node 17: f10 <= 7139.5  (F10, bin <= 18)  left -> 18, right -> 19
node(16,17,10,18).
left_node(16,17,18).
right_node(16,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(16,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(16,19,1).
% node 20: f4 <= 13.5  (F4, bin <= 7)  left -> 21, right -> 28
node(16,20,4,7).
left_node(16,20,21).
right_node(16,20,28).
% node 21: f11 <= 2218.5  (F11, bin <= 14)  left -> 22, right -> 27
node(16,21,11,14).
left_node(16,21,22).
right_node(16,21,27).
% node 22: f4 <= 12.5  (F4, bin <= 6)  left -> 23, right -> 24
node(16,22,4,6).
left_node(16,22,23).
right_node(16,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(16,23,0).
% node 24: f10 <= 7731.5  (F10, bin <= 22)  left -> 25, right -> 26
node(16,24,10,22).
left_node(16,24,25).
right_node(16,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(16,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(16,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(16,27,1).
% node 28: f3 <= 13.5  (F3, bin <= 7)  left -> 29, right -> 32
node(16,28,3,7).
left_node(16,28,29).
right_node(16,28,32).
% node 29: f10 <= 4718.5  (F10, bin <= 8)  left -> 30, right -> 31
node(16,29,10,8).
left_node(16,29,30).
right_node(16,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(16,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(16,31,1).
% node 32 (leaf): class <=50K (0)
leaf_class(16,32,0).

% Tree 17
tree(17).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 22
node(17,0,5,3).
left_node(17,0,1).
right_node(17,0,22).
% node 1: f4 <= 12.5  (F4, bin <= 6)  left -> 2, right -> 15
node(17,1,4,6).
left_node(17,1,2).
right_node(17,1,15).
% node 2: f5 <= 0.5  (F5, bin <= 0)  left -> 3, right -> 6
node(17,2,5,0).
left_node(17,2,3).
right_node(17,2,6).
% node 3: f10 <= 8296.0  (F10, bin <= 24)  left -> 4, right -> 5
node(17,3,10,24).
left_node(17,3,4).
right_node(17,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(17,4,0).
% node 5 (leaf): class >50K (1)
leaf_class(17,5,1).
% node 6: f10 <= 5095.5  (F10, bin <= 10)  left -> 7, right -> 14
node(17,6,10,10).
left_node(17,6,7).
right_node(17,6,14).
% node 7: f3 <= 8.5  (F3, bin <= 2)  left -> 8, right -> 13
node(17,7,3,2).
left_node(17,7,8).
right_node(17,7,13).
% node 8: f4 <= 7.5  (F4, bin <= 1)  left -> 9, right -> 10
node(17,8,4,1).
left_node(17,8,9).
right_node(17,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(17,9,0).
% node 10: f11 <= 1782.5  (F11, bin <= 3)  left -> 11, right -> 12
node(17,10,11,3).
left_node(17,10,11).
right_node(17,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(17,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(17,12,1).
% node 13 (leaf): class <=50K (0)
leaf_class(17,13,0).
% node 14 (leaf): class >50K (1)
leaf_class(17,14,1).
% node 15: f5 <= 0.5  (F5, bin <= 0)  left -> 16, right -> 17
node(17,15,5,0).
left_node(17,15,16).
right_node(17,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(17,16,0).
% node 17: f10 <= 5095.5  (F10, bin <= 10)  left -> 18, right -> 21
node(17,17,10,10).
left_node(17,17,18).
right_node(17,17,21).
% node 18: f0 <= 30.5  (F0, bin <= 6)  left -> 19, right -> 20
node(17,18,0,6).
left_node(17,18,19).
right_node(17,18,20).
% node 19 (leaf): class <=50K (0)
leaf_class(17,19,0).
% node 20 (leaf): class >50K (1)
leaf_class(17,20,1).
% node 21 (leaf): class >50K (1)
leaf_class(17,21,1).
% node 22: f7 <= 1.5  (F7, bin <= 1)  left -> 23, right -> 30
node(17,22,7,1).
left_node(17,22,23).
right_node(17,22,30).
% node 23: f11 <= 2218.5  (F11, bin <= 14)  left -> 24, right -> 29
node(17,23,11,14).
left_node(17,23,24).
right_node(17,23,29).
% node 24: f10 <= 7731.5  (F10, bin <= 22)  left -> 25, right -> 28
node(17,24,10,22).
left_node(17,24,25).
right_node(17,24,28).
% node 25: f3 <= 12.5  (F3, bin <= 6)  left -> 26, right -> 27
node(17,25,3,6).
left_node(17,25,26).
right_node(17,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(17,26,0).
% node 27 (leaf): class <=50K (0)
leaf_class(17,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(17,28,1).
% node 29 (leaf): class >50K (1)
leaf_class(17,29,1).
% node 30 (leaf): class <=50K (0)
leaf_class(17,30,0).

% Tree 18
tree(18).
% node 0: f0 <= 31.5  (F0, bin <= 7)  left -> 1, right -> 6
node(18,0,0,7).
left_node(18,0,1).
right_node(18,0,6).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 5
node(18,1,5,3).
left_node(18,1,2).
right_node(18,1,5).
% node 2: f3 <= 10.5  (F3, bin <= 4)  left -> 3, right -> 4
node(18,2,3,4).
left_node(18,2,3).
right_node(18,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(18,3,0).
% node 4 (leaf): class <=50K (0)
leaf_class(18,4,0).
% node 5 (leaf): class <=50K (0)
leaf_class(18,5,0).
% node 6: f7 <= 0.5  (F7, bin <= 0)  left -> 7, right -> 26
node(18,6,7,0).
left_node(18,6,7).
right_node(18,6,26).
% node 7: f12 <= 41.5  (F12, bin <= 8)  left -> 8, right -> 17
node(18,7,12,8).
left_node(18,7,8).
right_node(18,7,17).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 10
node(18,8,1,0).
left_node(18,8,9).
right_node(18,8,10).
% node 9 (leaf): class >50K (1)
leaf_class(18,9,1).
% node 10: f4 <= 12.5  (F4, bin <= 6)  left -> 11, right -> 16
node(18,10,4,6).
left_node(18,10,11).
right_node(18,10,16).
% node 11: f10 <= 5095.5  (F10, bin <= 10)  left -> 12, right -> 15
node(18,11,10,10).
left_node(18,11,12).
right_node(18,11,15).
% node 12: f12 <= 34.5  (F12, bin <= 4)  left -> 13, right -> 14
node(18,12,12,4).
left_node(18,12,13).
right_node(18,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(18,13,0).
% node 14 (leaf): class <=50K (0)
leaf_class(18,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(18,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(18,16,1).
% node 17: f10 <= 5095.5  (F10, bin <= 10)  left -> 18, right -> 25
node(18,17,10,10).
left_node(18,17,18).
right_node(18,17,25).
% node 18: f8 <= 0.5  (F8, bin <= 0)  left -> 19, right -> 20
node(18,18,8,0).
left_node(18,18,19).
right_node(18,18,20).
% node 19 (leaf): class <=50K (0)
leaf_class(18,19,0).
% node 20: f0 <= 36.5  (F0, bin <= 11)  left -> 21, right -> 22
node(18,20,0,11).
left_node(18,20,21).
right_node(18,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(18,21,0).
% node 22: f4 <= 12.5  (F4, bin <= 6)  left -> 23, right -> 24
node(18,22,4,6).
left_node(18,22,23).
right_node(18,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(18,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(18,24,1).
% node 25 (leaf): class >50K (1)
leaf_class(18,25,1).
% node 26: f7 <= 4.5  (F7, bin <= 3)  left -> 27, right -> 38
node(18,26,7,3).
left_node(18,26,27).
right_node(18,26,38).
% node 27: f12 <= 42.5  (F12, bin <= 9)  left -> 28, right -> 33
node(18,27,12,9).
left_node(18,27,28).
right_node(18,27,33).
% node 28: f11 <= 2218.5  (F11, bin <= 14)  left -> 29, right -> 32
node(18,28,11,14).
left_node(18,28,29).
right_node(18,28,32).
% node 29: f10 <= 7073.5  (F10, bin <= 17)  left -> 30, right -> 31
node(18,29,10,17).
left_node(18,29,30).
right_node(18,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(18,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(18,31,1).
% node 32 (leaf): class >50K (1)
leaf_class(18,32,1).
% node 33: f10 <= 4718.5  (F10, bin <= 8)  left -> 34, right -> 37
node(18,33,10,8).
left_node(18,33,34).
right_node(18,33,37).
% node 34: f3 <= 11.5  (F3, bin <= 5)  left -> 35, right -> 36
node(18,34,3,5).
left_node(18,34,35).
right_node(18,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(18,35,0).
% node 36 (leaf): class <=50K (0)
leaf_class(18,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(18,37,1).
% node 38: f10 <= 5095.5  (F10, bin <= 10)  left -> 39, right -> 40
node(18,38,10,10).
left_node(18,38,39).
right_node(18,38,40).
% node 39 (leaf): class <=50K (0)
leaf_class(18,39,0).
% node 40 (leaf): class >50K (1)
leaf_class(18,40,1).

% Tree 19
tree(19).
% node 0: f4 <= 12.5  (F4, bin <= 6)  left -> 1, right -> 18
node(19,0,4,6).
left_node(19,0,1).
right_node(19,0,18).
% node 1: f10 <= 5119.0  (F10, bin <= 11)  left -> 2, right -> 17
node(19,1,10,11).
left_node(19,1,2).
right_node(19,1,17).
% node 2: f12 <= 40.5  (F12, bin <= 7)  left -> 3, right -> 12
node(19,2,12,7).
left_node(19,2,3).
right_node(19,2,12).
% node 3: f5 <= 2.5  (F5, bin <= 3)  left -> 4, right -> 11
node(19,3,5,3).
left_node(19,3,4).
right_node(19,3,11).
% node 4: f12 <= 34.5  (F12, bin <= 4)  left -> 5, right -> 6
node(19,4,12,4).
left_node(19,4,5).
right_node(19,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(19,5,0).
% node 6: f11 <= 1793.5  (F11, bin <= 5)  left -> 7, right -> 10
node(19,6,11,5).
left_node(19,6,7).
right_node(19,6,10).
% node 7: f4 <= 7.5  (F4, bin <= 1)  left -> 8, right -> 9
node(19,7,4,1).
left_node(19,7,8).
right_node(19,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(19,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(19,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(19,10,1).
% node 11 (leaf): class <=50K (0)
leaf_class(19,11,0).
% node 12: f11 <= 1846.0  (F11, bin <= 10)  left -> 13, right -> 16
node(19,12,11,10).
left_node(19,12,13).
right_node(19,12,16).
% node 13: f0 <= 31.5  (F0, bin <= 7)  left -> 14, right -> 15
node(19,13,0,7).
left_node(19,13,14).
right_node(19,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(19,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(19,15,0).
% node 16 (leaf): class >50K (1)
leaf_class(19,16,1).
% node 17 (leaf): class >50K (1)
leaf_class(19,17,1).
% node 18: f3 <= 12.5  (F3, bin <= 6)  left -> 19, right -> 28
node(19,18,3,6).
left_node(19,18,19).
right_node(19,18,28).
% node 19: f12 <= 41.5  (F12, bin <= 8)  left -> 20, right -> 25
node(19,19,12,8).
left_node(19,19,20).
right_node(19,19,25).
% node 20: f10 <= 5095.5  (F10, bin <= 10)  left -> 21, right -> 24
node(19,20,10,10).
left_node(19,20,21).
right_node(19,20,24).
% node 21: f9 <= 0.5  (F9, bin <= 0)  left -> 22, right -> 23
node(19,21,9,0).
left_node(19,21,22).
right_node(19,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(19,22,0).
% node 23 (leaf): class <=50K (0)
leaf_class(19,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(19,24,1).
% node 25: f5 <= 2.5  (F5, bin <= 3)  left -> 26, right -> 27
node(19,25,5,3).
left_node(19,25,26).
right_node(19,25,27).
% node 26 (leaf): class >50K (1)
leaf_class(19,26,1).
% node 27 (leaf): class <=50K (0)
leaf_class(19,27,0).
% node 28: f3 <= 13.5  (F3, bin <= 7)  left -> 29, right -> 40
node(19,28,3,7).
left_node(19,28,29).
right_node(19,28,40).
% node 29: f9 <= 0.5  (F9, bin <= 0)  left -> 30, right -> 37
node(19,29,9,0).
left_node(19,29,30).
right_node(19,29,37).
% node 30: f10 <= 4718.5  (F10, bin <= 8)  left -> 31, right -> 36
node(19,30,10,8).
left_node(19,30,31).
right_node(19,30,36).
% node 31: f0 <= 33.5  (F0, bin <= 9)  left -> 32, right -> 33
node(19,31,0,9).
left_node(19,31,32).
right_node(19,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(19,32,0).
% node 33: f7 <= 4.5  (F7, bin <= 3)  left -> 34, right -> 35
node(19,33,7,3).
left_node(19,33,34).
right_node(19,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(19,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(19,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(19,36,1).
% node 37: f7 <= 0.5  (F7, bin <= 0)  left -> 38, right -> 39
node(19,37,7,0).
left_node(19,37,38).
right_node(19,37,39).
% node 38 (leaf): class >50K (1)
leaf_class(19,38,1).
% node 39 (leaf): class <=50K (0)
leaf_class(19,39,0).
% node 40: f0 <= 30.5  (F0, bin <= 6)  left -> 41, right -> 42
node(19,40,0,6).
left_node(19,40,41).
right_node(19,40,42).
% node 41 (leaf): class <=50K (0)
leaf_class(19,41,0).
% node 42 (leaf): class >50K (1)
leaf_class(19,42,1).

% Tree 20
tree(20).
% node 0: f10 <= 5095.5  (F10, bin <= 10)  left -> 1, right -> 22
node(20,0,10,10).
left_node(20,0,1).
right_node(20,0,22).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 19
node(20,1,5,3).
left_node(20,1,2).
right_node(20,1,19).
% node 2: f3 <= 11.5  (F3, bin <= 5)  left -> 3, right -> 12
node(20,2,3,5).
left_node(20,2,3).
right_node(20,2,12).
% node 3: f11 <= 1846.0  (F11, bin <= 10)  left -> 4, right -> 11
node(20,3,11,10).
left_node(20,3,4).
right_node(20,3,11).
% node 4: f3 <= 7.5  (F3, bin <= 1)  left -> 5, right -> 6
node(20,4,3,1).
left_node(20,4,5).
right_node(20,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(20,5,0).
% node 6: f7 <= 0.5  (F7, bin <= 0)  left -> 7, right -> 10
node(20,6,7,0).
left_node(20,6,7).
right_node(20,6,10).
% node 7: f12 <= 34.0  (F12, bin <= 3)  left -> 8, right -> 9
node(20,7,12,3).
left_node(20,7,8).
right_node(20,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(20,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(20,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(20,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(20,11,1).
% node 12: f5 <= 0.5  (F5, bin <= 0)  left -> 13, right -> 14
node(20,12,5,0).
left_node(20,12,13).
right_node(20,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(20,13,0).
% node 14: f11 <= 1782.5  (F11, bin <= 3)  left -> 15, right -> 18
node(20,14,11,3).
left_node(20,14,15).
right_node(20,14,18).
% node 15: f0 <= 28.5  (F0, bin <= 4)  left -> 16, right -> 17
node(20,15,0,4).
left_node(20,15,16).
right_node(20,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(20,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(20,17,1).
% node 18 (leaf): class >50K (1)
leaf_class(20,18,1).
% node 19: f4 <= 14.5  (F4, bin <= 8)  left -> 20, right -> 21
node(20,19,4,8).
left_node(20,19,20).
right_node(20,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(20,20,0).
% node 21 (leaf): class <=50K (0)
leaf_class(20,21,0).
% node 22 (leaf): class >50K (1)
leaf_class(20,22,1).

% Tree 21
tree(21).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 18
node(21,0,7,0).
left_node(21,0,1).
right_node(21,0,18).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 17
node(21,1,10,10).
left_node(21,1,2).
right_node(21,1,17).
% node 2: f10 <= 3120.0  (F10, bin <= 1)  left -> 3, right -> 16
node(21,2,10,1).
left_node(21,2,3).
right_node(21,2,16).
% node 3: f11 <= 1782.5  (F11, bin <= 3)  left -> 4, right -> 13
node(21,3,11,3).
left_node(21,3,4).
right_node(21,3,13).
% node 4: f3 <= 11.5  (F3, bin <= 5)  left -> 5, right -> 10
node(21,4,3,5).
left_node(21,4,5).
right_node(21,4,10).
% node 5: f6 <= 8.0  (F6, bin <= 2)  left -> 6, right -> 9
node(21,5,6,2).
left_node(21,5,6).
right_node(21,5,9).
% node 6: f12 <= 31.0  (F12, bin <= 0)  left -> 7, right -> 8
node(21,6,12,0).
left_node(21,6,7).
right_node(21,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(21,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(21,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(21,9,0).
% node 10: f12 <= 35.5  (F12, bin <= 5)  left -> 11, right -> 12
node(21,10,12,5).
left_node(21,10,11).
right_node(21,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(21,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(21,12,1).
% node 13: f11 <= 1989.5  (F11, bin <= 13)  left -> 14, right -> 15
node(21,13,11,13).
left_node(21,13,14).
right_node(21,13,15).
% node 14 (leaf): class >50K (1)
leaf_class(21,14,1).
% node 15 (leaf): class <=50K (0)
leaf_class(21,15,0).
% node 16 (leaf): class <=50K (0)
leaf_class(21,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(21,17,1).
% node 18: f10 <= 7073.5  (F10, bin <= 17)  left -> 19, right -> 26
node(21,18,10,17).
left_node(21,18,19).
right_node(21,18,26).
% node 19: f12 <= 41.5  (F12, bin <= 8)  left -> 20, right -> 23
node(21,19,12,8).
left_node(21,19,20).
right_node(21,19,23).
% node 20: f7 <= 4.5  (F7, bin <= 3)  left -> 21, right -> 22
node(21,20,7,3).
left_node(21,20,21).
right_node(21,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(21,21,0).
% node 22 (leaf): class <=50K (0)
leaf_class(21,22,0).
% node 23: f4 <= 12.5  (F4, bin <= 6)  left -> 24, right -> 25
node(21,23,4,6).
left_node(21,23,24).
right_node(21,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(21,24,0).
% node 25 (leaf): class <=50K (0)
leaf_class(21,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(21,26,1).

% Tree 22
tree(22).
% node 0: f6 <= 8.5  (F6, bin <= 3)  left -> 1, right -> 20
node(22,0,6,3).
left_node(22,0,1).
right_node(22,0,20).
% node 1: f10 <= 7073.5  (F10, bin <= 17)  left -> 2, right -> 19
node(22,1,10,17).
left_node(22,1,2).
right_node(22,1,19).
% node 2: f3 <= 11.5  (F3, bin <= 5)  left -> 3, right -> 12
node(22,2,3,5).
left_node(22,2,3).
right_node(22,2,12).
% node 3: f11 <= 1793.5  (F11, bin <= 5)  left -> 4, right -> 11
node(22,3,11,5).
left_node(22,3,4).
right_node(22,3,11).
% node 4: f6 <= 3.5  (F6, bin <= 1)  left -> 5, right -> 10
node(22,4,6,1).
left_node(22,4,5).
right_node(22,4,10).
% node 5: f9 <= 0.5  (F9, bin <= 0)  left -> 6, right -> 7
node(22,5,9,0).
left_node(22,5,6).
right_node(22,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(22,6,0).
% node 7: f12 <= 45.5  (F12, bin <= 12)  left -> 8, right -> 9
node(22,7,12,12).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(22,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(22,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(22,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(22,11,1).
% node 12: f7 <= 0.5  (F7, bin <= 0)  left -> 13, right -> 16
node(22,12,7,0).
left_node(22,12,13).
right_node(22,12,16).
% node 13: f6 <= 3.5  (F6, bin <= 1)  left -> 14, right -> 15
node(22,13,6,1).
left_node(22,13,14).
right_node(22,13,15).
% node 14 (leaf): class >50K (1)
leaf_class(22,14,1).
% node 15 (leaf): class <=50K (0)
leaf_class(22,15,0).
% node 16: f0 <= 35.5  (F0, bin <= 10)  left -> 17, right -> 18
node(22,16,0,10).
left_node(22,16,17).
right_node(22,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(22,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(22,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(22,19,1).
% node 20: f5 <= 2.5  (F5, bin <= 3)  left -> 21, right -> 32
node(22,20,5,3).
left_node(22,20,21).
right_node(22,20,32).
% node 21: f7 <= 0.5  (F7, bin <= 0)  left -> 22, right -> 29
node(22,21,7,0).
left_node(22,21,22).
right_node(22,21,29).
% node 22: f0 <= 32.5  (F0, bin <= 8)  left -> 23, right -> 24
node(22,22,0,8).
left_node(22,22,23).
right_node(22,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(22,23,0).
% node 24: f6 <= 12.5  (F6, bin <= 5)  left -> 25, right -> 28
node(22,24,6,5).
left_node(22,24,25).
right_node(22,24,28).
% node 25: f3 <= 10.5  (F3, bin <= 4)  left -> 26, right -> 27
node(22,25,3,4).
left_node(22,25,26).
right_node(22,25,27).
% node 26 (leaf): class >50K (1)
leaf_class(22,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(22,27,1).
% node 28 (leaf): class <=50K (0)
leaf_class(22,28,0).
% node 29: f7 <= 4.5  (F7, bin <= 3)  left -> 30, right -> 31
node(22,29,7,3).
left_node(22,29,30).
right_node(22,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(22,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(22,31,1).
% node 32: f4 <= 14.5  (F4, bin <= 8)  left -> 33, right -> 36
node(22,32,4,8).
left_node(22,32,33).
right_node(22,32,36).
% node 33: f10 <= 7372.5  (F10, bin <= 20)  left -> 34, right -> 35
node(22,33,10,20).
left_node(22,33,34).
right_node(22,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(22,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(22,35,1).
% node 36 (leaf): class <=50K (0)
leaf_class(22,36,0).

% Tree 23
tree(23).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 28
node(23,0,5,3).
left_node(23,0,1).
right_node(23,0,28).
% node 1: f3 <= 11.5  (F3, bin <= 5)  left -> 2, right -> 13
node(23,1,3,5).
left_node(23,1,2).
right_node(23,1,13).
% node 2: f7 <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(23,2,7,0).
left_node(23,2,3).
right_node(23,2,10).
% node 3: f3 <= 6.5  (F3, bin <= 0)  left -> 4, right -> 5
node(23,3,3,0).
left_node(23,3,4).
right_node(23,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(23,4,0).
% node 5: f0 <= 35.5  (F0, bin <= 10)  left -> 6, right -> 7
node(23,5,0,10).
left_node(23,5,6).
right_node(23,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(23,6,0).
% node 7: f3 <= 8.5  (F3, bin <= 2)  left -> 8, right -> 9
node(23,7,3,2).
left_node(23,7,8).
right_node(23,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(23,8,0).
% node 9 (leaf): class >50K (1)
leaf_class(23,9,1).
% node 10: f5 <= 0.5  (F5, bin <= 0)  left -> 11, right -> 12
node(23,10,5,0).
left_node(23,10,11).
right_node(23,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(23,11,0).
% node 12 (leaf): class <=50K (0)
leaf_class(23,12,0).
% node 13: f12 <= 41.5  (F12, bin <= 8)  left -> 14, right -> 25
node(23,13,12,8).
left_node(23,13,14).
right_node(23,13,25).
% node 14: f9 <= 0.5  (F9, bin <= 0)  left -> 15, right -> 18
node(23,14,9,0).
left_node(23,14,15).
right_node(23,14,18).
% node 15: f10 <= 4030.0  (F10, bin <= 3)  left -> 16, right -> 17
node(23,15,10,3).
left_node(23,15,16).
right_node(23,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(23,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(23,17,1).
% node 18: f10 <= 5095.5  (F10, bin <= 10)  left -> 19, right -> 24
node(23,18,10,10).
left_node(23,18,19).
right_node(23,18,24).
% node 19: f5 <= 1.0  (F5, bin <= 1)  left -> 20, right -> 21
node(23,19,5,1).
left_node(23,19,20).
right_node(23,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(23,20,0).
% node 21: f12 <= 34.5  (F12, bin <= 4)  left -> 22, right -> 23
node(23,21,12,4).
left_node(23,21,22).
right_node(23,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(23,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(23,23,1).
% node 24 (leaf): class >50K (1)
leaf_class(23,24,1).
% node 25: f7 <= 0.5  (F7, bin <= 0)  left -> 26, right -> 27
node(23,25,7,0).
left_node(23,25,26).
right_node(23,25,27).
% node 26 (leaf): class >50K (1)
leaf_class(23,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(23,27,1).
% node 28: f12 <= 42.5  (F12, bin <= 9)  left -> 29, right -> 34
node(23,28,12,9).
left_node(23,28,29).
right_node(23,28,34).
% node 29: f7 <= 1.5  (F7, bin <= 1)  left -> 30, right -> 33
node(23,29,7,1).
left_node(23,29,30).
right_node(23,29,33).
% node 30: f10 <= 7731.5  (F10, bin <= 22)  left -> 31, right -> 32
node(23,30,10,22).
left_node(23,30,31).
right_node(23,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(23,31,0).
% node 32 (leaf): class >50K (1)
leaf_class(23,32,1).
% node 33 (leaf): class <=50K (0)
leaf_class(23,33,0).
% node 34: f4 <= 12.5  (F4, bin <= 6)  left -> 35, right -> 36
node(23,34,4,6).
left_node(23,34,35).
right_node(23,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(23,35,0).
% node 36: f10 <= 4056.0  (F10, bin <= 4)  left -> 37, right -> 38
node(23,36,10,4).
left_node(23,36,37).
right_node(23,36,38).
% node 37 (leaf): class <=50K (0)
leaf_class(23,37,0).
% node 38 (leaf): class >50K (1)
leaf_class(23,38,1).

% Tree 24
tree(24).
% node 0: f3 <= 11.5  (F3, bin <= 5)  left -> 1, right -> 24
node(24,0,3,5).
left_node(24,0,1).
right_node(24,0,24).
% node 1: f7 <= 0.5  (F7, bin <= 0)  left -> 2, right -> 15
node(24,1,7,0).
left_node(24,1,2).
right_node(24,1,15).
% node 2: f4 <= 8.5  (F4, bin <= 2)  left -> 3, right -> 4
node(24,2,4,2).
left_node(24,2,3).
right_node(24,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(24,3,0).
% node 4: f0 <= 35.5  (F0, bin <= 10)  left -> 5, right -> 6
node(24,4,0,10).
left_node(24,4,5).
right_node(24,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(24,5,0).
% node 6: f3 <= 8.5  (F3, bin <= 2)  left -> 7, right -> 10
node(24,6,3,2).
left_node(24,6,7).
right_node(24,6,10).
% node 7: f12 <= 34.0  (F12, bin <= 3)  left -> 8, right -> 9
node(24,7,12,3).
left_node(24,7,8).
right_node(24,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(24,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(24,9,0).
% node 10: f2 <= 125689.5  (F2, bin <= 4)  left -> 11, right -> 14
node(24,10,2,4).
left_node(24,10,11).
right_node(24,10,14).
% node 11: f10 <= 5095.5  (F10, bin <= 10)  left -> 12, right -> 13
node(24,11,10,10).
left_node(24,11,12).
right_node(24,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(24,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(24,13,1).
% node 14 (leaf): class >50K (1)
leaf_class(24,14,1).
% node 15: f10 <= 7073.5  (F10, bin <= 17)  left -> 16, right -> 23
node(24,15,10,17).
left_node(24,15,16).
right_node(24,15,23).
% node 16: f0 <= 26.5  (F0, bin <= 2)  left -> 17, right -> 18
node(24,16,0,2).
left_node(24,16,17).
right_node(24,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(24,17,0).
% node 18: f10 <= 4718.5  (F10, bin <= 8)  left -> 19, right -> 22
node(24,18,10,8).
left_node(24,18,19).
right_node(24,18,22).
% node 19: f7 <= 4.5  (F7, bin <= 3)  left -> 20, right -> 21
node(24,19,7,3).
left_node(24,19,20).
right_node(24,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(24,20,0).
% node 21 (leaf): class <=50K (0)
leaf_class(24,21,0).
% node 22 (leaf): class <=50K (0)
leaf_class(24,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(24,23,1).
% node 24: f10 <= 7073.5  (F10, bin <= 17)  left -> 25, right -> 38
node(24,24,10,17).
left_node(24,24,25).
right_node(24,24,38).
% node 25: f12 <= 43.5  (F12, bin <= 10)  left -> 26, right -> 29
node(24,25,12,10).
left_node(24,25,26).
right_node(24,25,29).
% node 26: f7 <= 0.5  (F7, bin <= 0)  left -> 27, right -> 28
node(24,26,7,0).
left_node(24,26,27).
right_node(24,26,28).
% node 27 (leaf): class >50K (1)
leaf_class(24,27,1).
% node 28 (leaf): class <=50K (0)
leaf_class(24,28,0).
% node 29: f3 <= 12.5  (F3, bin <= 6)  left -> 30, right -> 37
node(24,29,3,6).
left_node(24,29,30).
right_node(24,29,37).
% node 30: f13 <= 37.0  (F13, bin <= 6)  left -> 31, right -> 32
node(24,30,13,6).
left_node(24,30,31).
right_node(24,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(24,31,0).
% node 32: f0 <= 27.5  (F0, bin <= 3)  left -> 33, right -> 34
node(24,32,0,3).
left_node(24,32,33).
right_node(24,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(24,33,0).
% node 34: f7 <= 0.5  (F7, bin <= 0)  left -> 35, right -> 36
node(24,34,7,0).
left_node(24,34,35).
right_node(24,34,36).
% node 35 (leaf): class >50K (1)
leaf_class(24,35,1).
% node 36 (leaf): class <=50K (0)
leaf_class(24,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(24,37,1).
% node 38 (leaf): class >50K (1)
leaf_class(24,38,1).

% Tree 25
tree(25).
% node 0: f3 <= 11.5  (F3, bin <= 5)  left -> 1, right -> 26
node(25,0,3,5).
left_node(25,0,1).
right_node(25,0,26).
% node 1: f9 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 9
node(25,1,9,0).
left_node(25,1,2).
right_node(25,1,9).
% node 2: f0 <= 28.5  (F0, bin <= 4)  left -> 3, right -> 4
node(25,2,0,4).
left_node(25,2,3).
right_node(25,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(25,3,0).
% node 4: f6 <= 3.5  (F6, bin <= 1)  left -> 5, right -> 8
node(25,4,6,1).
left_node(25,4,5).
right_node(25,4,8).
% node 5: f7 <= 4.5  (F7, bin <= 3)  left -> 6, right -> 7
node(25,5,7,3).
left_node(25,5,6).
right_node(25,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(25,6,0).
% node 7 (leaf): class >50K (1)
leaf_class(25,7,1).
% node 8 (leaf): class <=50K (0)
leaf_class(25,8,0).
% node 9: f8 <= 3.5  (F8, bin <= 1)  left -> 10, right -> 15
node(25,9,8,1).
left_node(25,9,10).
right_node(25,9,15).
% node 10: f7 <= 0.5  (F7, bin <= 0)  left -> 11, right -> 14
node(25,10,7,0).
left_node(25,10,11).
right_node(25,10,14).
% node 11: f10 <= 4782.0  (F10, bin <= 9)  left -> 12, right -> 13
node(25,11,10,9).
left_node(25,11,12).
right_node(25,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(25,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(25,13,1).
% node 14 (leaf): class <=50K (0)
leaf_class(25,14,0).
% node 15: f7 <= 0.5  (F7, bin <= 0)  left -> 16, right -> 25
node(25,15,7,0).
left_node(25,15,16).
right_node(25,15,25).
% node 16: f12 <= 37.5  (F12, bin <= 6)  left -> 17, right -> 20
node(25,16,12,6).
left_node(25,16,17).
right_node(25,16,20).
% node 17: f10 <= 7032.5  (F10, bin <= 16)  left -> 18, right -> 19
node(25,17,10,16).
left_node(25,17,18).
right_node(25,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(25,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(25,19,1).
% node 20: f13 <= 35.5  (F13, bin <= 5)  left -> 21, right -> 22
node(25,20,13,5).
left_node(25,20,21).
right_node(25,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(25,21,0).
% node 22: f6 <= 3.5  (F6, bin <= 1)  left -> 23, right -> 24
node(25,22,6,1).
left_node(25,22,23).
right_node(25,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(25,23,0).
% node 24 (leaf): class <=50K (0)
leaf_class(25,24,0).
% node 25 (leaf): class <=50K (0)
leaf_class(25,25,0).
% node 26: f9 <= 0.5  (F9, bin <= 0)  left -> 27, right -> 34
node(25,26,9,0).
left_node(25,26,27).
right_node(25,26,34).
% node 27: f7 <= 4.5  (F7, bin <= 3)  left -> 28, right -> 33
node(25,27,7,3).
left_node(25,27,28).
right_node(25,27,33).
% node 28: f3 <= 12.5  (F3, bin <= 6)  left -> 29, right -> 30
node(25,28,3,6).
left_node(25,28,29).
right_node(25,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(25,29,0).
% node 30: f10 <= 4718.5  (F10, bin <= 8)  left -> 31, right -> 32
node(25,30,10,8).
left_node(25,30,31).
right_node(25,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(25,31,0).
% node 32 (leaf): class >50K (1)
leaf_class(25,32,1).
% node 33 (leaf): class >50K (1)
leaf_class(25,33,1).
% node 34: f6 <= 2.5  (F6, bin <= 0)  left -> 35, right -> 36
node(25,34,6,0).
left_node(25,34,35).
right_node(25,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(25,35,0).
% node 36: f11 <= 1881.5  (F11, bin <= 11)  left -> 37, right -> 48
node(25,36,11,11).
left_node(25,36,37).
right_node(25,36,48).
% node 37: f5 <= 2.5  (F5, bin <= 3)  left -> 38, right -> 43
node(25,37,5,3).
left_node(25,37,38).
right_node(25,37,43).
% node 38: f10 <= 5095.5  (F10, bin <= 10)  left -> 39, right -> 42
node(25,38,10,10).
left_node(25,38,39).
right_node(25,38,42).
% node 39: f7 <= 0.5  (F7, bin <= 0)  left -> 40, right -> 41
node(25,39,7,0).
left_node(25,39,40).
right_node(25,39,41).
% node 40 (leaf): class >50K (1)
leaf_class(25,40,1).
% node 41 (leaf): class <=50K (0)
leaf_class(25,41,0).
% node 42 (leaf): class >50K (1)
leaf_class(25,42,1).
% node 43: f3 <= 12.5  (F3, bin <= 6)  left -> 44, right -> 47
node(25,43,3,6).
left_node(25,43,44).
right_node(25,43,47).
% node 44: f10 <= 4718.5  (F10, bin <= 8)  left -> 45, right -> 46
node(25,44,10,8).
left_node(25,44,45).
right_node(25,44,46).
% node 45 (leaf): class <=50K (0)
leaf_class(25,45,0).
% node 46 (leaf): class >50K (1)
leaf_class(25,46,1).
% node 47 (leaf): class <=50K (0)
leaf_class(25,47,0).
% node 48 (leaf): class >50K (1)
leaf_class(25,48,1).

% Tree 26
tree(26).
% node 0: f6 <= 8.5  (F6, bin <= 3)  left -> 1, right -> 24
node(26,0,6,3).
left_node(26,0,1).
right_node(26,0,24).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 23
node(26,1,10,10).
left_node(26,1,2).
right_node(26,1,23).
% node 2: f7 <= 0.5  (F7, bin <= 0)  left -> 3, right -> 12
node(26,2,7,0).
left_node(26,2,3).
right_node(26,2,12).
% node 3: f3 <= 11.5  (F3, bin <= 5)  left -> 4, right -> 11
node(26,3,3,5).
left_node(26,3,4).
right_node(26,3,11).
% node 4: f3 <= 6.5  (F3, bin <= 0)  left -> 5, right -> 6
node(26,4,3,0).
left_node(26,4,5).
right_node(26,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(26,5,0).
% node 6: f2 <= 116950.5  (F2, bin <= 2)  left -> 7, right -> 8
node(26,6,2,2).
left_node(26,6,7).
right_node(26,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(26,7,0).
% node 8: f11 <= 1782.5  (F11, bin <= 3)  left -> 9, right -> 10
node(26,8,11,3).
left_node(26,8,9).
right_node(26,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(26,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(26,10,1).
% node 11 (leaf): class >50K (1)
leaf_class(26,11,1).
% node 12: f4 <= 12.5  (F4, bin <= 6)  left -> 13, right -> 18
node(26,12,4,6).
left_node(26,12,13).
right_node(26,12,18).
% node 13: f7 <= 4.5  (F7, bin <= 3)  left -> 14, right -> 15
node(26,13,7,3).
left_node(26,13,14).
right_node(26,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(26,14,0).
% node 15: f6 <= 3.5  (F6, bin <= 1)  left -> 16, right -> 17
node(26,15,6,1).
left_node(26,15,16).
right_node(26,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(26,16,0).
% node 17 (leaf): class <=50K (0)
leaf_class(26,17,0).
% node 18: f12 <= 44.5  (F12, bin <= 11)  left -> 19, right -> 22
node(26,18,12,11).
left_node(26,18,19).
right_node(26,18,22).
% node 19: f7 <= 4.5  (F7, bin <= 3)  left -> 20, right -> 21
node(26,19,7,3).
left_node(26,19,20).
right_node(26,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(26,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(26,21,1).
% node 22 (leaf): class <=50K (0)
leaf_class(26,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(26,23,1).
% node 24: f11 <= 1881.5  (F11, bin <= 11)  left -> 25, right -> 48
node(26,24,11,11).
left_node(26,24,25).
right_node(26,24,48).
% node 25: f12 <= 40.5  (F12, bin <= 7)  left -> 26, right -> 37
node(26,25,12,7).
left_node(26,25,26).
right_node(26,25,37).
% node 26: f0 <= 28.5  (F0, bin <= 4)  left -> 27, right -> 30
node(26,26,0,4).
left_node(26,26,27).
right_node(26,26,30).
% node 27: f10 <= 5119.0  (F10, bin <= 11)  left -> 28, right -> 29
node(26,27,10,11).
left_node(26,27,28).
right_node(26,27,29).
% node 28 (leaf): class <=50K (0)
leaf_class(26,28,0).
% node 29 (leaf): class >50K (1)
leaf_class(26,29,1).
% node 30: f9 <= 0.5  (F9, bin <= 0)  left -> 31, right -> 32
node(26,30,9,0).
left_node(26,30,31).
right_node(26,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(26,31,0).
% node 32: f4 <= 9.5  (F4, bin <= 3)  left -> 33, right -> 34
node(26,32,4,3).
left_node(26,32,33).
right_node(26,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(26,33,0).
% node 34: f0 <= 35.5  (F0, bin <= 10)  left -> 35, right -> 36
node(26,34,0,10).
left_node(26,34,35).
right_node(26,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(26,35,0).
% node 36 (leaf): class >50K (1)
leaf_class(26,36,1).
% node 37: f3 <= 11.5  (F3, bin <= 5)  left -> 38, right -> 43
node(26,37,3,5).
left_node(26,37,38).
right_node(26,37,43).
% node 38: f5 <= 2.5  (F5, bin <= 3)  left -> 39, right -> 42
node(26,38,5,3).
left_node(26,38,39).
right_node(26,38,42).
% node 39: f10 <= 4225.0  (F10, bin <= 6)  left -> 40, right -> 41
node(26,39,10,6).
left_node(26,39,40).
right_node(26,39,41).
% node 40 (leaf): class <=50K (0)
leaf_class(26,40,0).
% node 41 (leaf): class >50K (1)
leaf_class(26,41,1).
% node 42 (leaf): class <=50K (0)
leaf_class(26,42,0).
% node 43: f7 <= 0.5  (F7, bin <= 0)  left -> 44, right -> 45
node(26,43,7,0).
left_node(26,43,44).
right_node(26,43,45).
% node 44 (leaf): class >50K (1)
leaf_class(26,44,1).
% node 45: f10 <= 7139.5  (F10, bin <= 18)  left -> 46, right -> 47
node(26,45,10,18).
left_node(26,45,46).
right_node(26,45,47).
% node 46 (leaf): class <=50K (0)
leaf_class(26,46,0).
% node 47 (leaf): class >50K (1)
leaf_class(26,47,1).
% node 48 (leaf): class >50K (1)
leaf_class(26,48,1).

% Tree 27
tree(27).
% node 0: f0 <= 28.5  (F0, bin <= 4)  left -> 1, right -> 6
node(27,0,0,4).
left_node(27,0,1).
right_node(27,0,6).
% node 1: f10 <= 7073.5  (F10, bin <= 17)  left -> 2, right -> 5
node(27,1,10,17).
left_node(27,1,2).
right_node(27,1,5).
% node 2: f7 <= 4.5  (F7, bin <= 3)  left -> 3, right -> 4
node(27,2,7,3).
left_node(27,2,3).
right_node(27,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(27,3,0).
% node 4 (leaf): class <=50K (0)
leaf_class(27,4,0).
% node 5 (leaf): class >50K (1)
leaf_class(27,5,1).
% node 6: f4 <= 12.5  (F4, bin <= 6)  left -> 7, right -> 28
node(27,6,4,6).
left_node(27,6,7).
right_node(27,6,28).
% node 7: f12 <= 40.5  (F12, bin <= 7)  left -> 8, right -> 19
node(27,7,12,7).
left_node(27,7,8).
right_node(27,7,19).
% node 8: f10 <= 5095.5  (F10, bin <= 10)  left -> 9, right -> 18
node(27,8,10,10).
left_node(27,8,9).
right_node(27,8,18).
% node 9: f9 <= 0.5  (F9, bin <= 0)  left -> 10, right -> 13
node(27,9,9,0).
left_node(27,9,10).
right_node(27,9,13).
% node 10: f7 <= 4.5  (F7, bin <= 3)  left -> 11, right -> 12
node(27,10,7,3).
left_node(27,10,11).
right_node(27,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(27,11,0).
% node 12 (leaf): class <=50K (0)
leaf_class(27,12,0).
% node 13: f4 <= 8.5  (F4, bin <= 2)  left -> 14, right -> 15
node(27,13,4,2).
left_node(27,13,14).
right_node(27,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(27,14,0).
% node 15: f5 <= 2.5  (F5, bin <= 3)  left -> 16, right -> 17
node(27,15,5,3).
left_node(27,15,16).
right_node(27,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(27,16,0).
% node 17 (leaf): class <=50K (0)
leaf_class(27,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(27,18,1).
% node 19: f5 <= 2.5  (F5, bin <= 3)  left -> 20, right -> 27
node(27,19,5,3).
left_node(27,19,20).
right_node(27,19,27).
% node 20: f3 <= 7.5  (F3, bin <= 1)  left -> 21, right -> 22
node(27,20,3,1).
left_node(27,20,21).
right_node(27,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(27,21,0).
% node 22: f10 <= 5095.5  (F10, bin <= 10)  left -> 23, right -> 26
node(27,22,10,10).
left_node(27,22,23).
right_node(27,22,26).
% node 23: f7 <= 0.5  (F7, bin <= 0)  left -> 24, right -> 25
node(27,23,7,0).
left_node(27,23,24).
right_node(27,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(27,24,0).
% node 25 (leaf): class <=50K (0)
leaf_class(27,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(27,26,1).
% node 27 (leaf): class <=50K (0)
leaf_class(27,27,0).
% node 28: f9 <= 0.5  (F9, bin <= 0)  left -> 29, right -> 36
node(27,28,9,0).
left_node(27,28,29).
right_node(27,28,36).
% node 29: f5 <= 2.5  (F5, bin <= 3)  left -> 30, right -> 35
node(27,29,5,3).
left_node(27,29,30).
right_node(27,29,35).
% node 30: f6 <= 2.5  (F6, bin <= 0)  left -> 31, right -> 32
node(27,30,6,0).
left_node(27,30,31).
right_node(27,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(27,31,0).
% node 32: f5 <= 1.0  (F5, bin <= 1)  left -> 33, right -> 34
node(27,32,5,1).
left_node(27,32,33).
right_node(27,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(27,33,0).
% node 34 (leaf): class >50K (1)
leaf_class(27,34,1).
% node 35 (leaf): class <=50K (0)
leaf_class(27,35,0).
% node 36: f10 <= 7073.5  (F10, bin <= 17)  left -> 37, right -> 42
node(27,36,10,17).
left_node(27,36,37).
right_node(27,36,42).
% node 37: f7 <= 0.5  (F7, bin <= 0)  left -> 38, right -> 41
node(27,37,7,0).
left_node(27,37,38).
right_node(27,37,41).
% node 38: f11 <= 1782.5  (F11, bin <= 3)  left -> 39, right -> 40
node(27,38,11,3).
left_node(27,38,39).
right_node(27,38,40).
% node 39 (leaf): class >50K (1)
leaf_class(27,39,1).
% node 40 (leaf): class >50K (1)
leaf_class(27,40,1).
% node 41 (leaf): class <=50K (0)
leaf_class(27,41,0).
% node 42 (leaf): class >50K (1)
leaf_class(27,42,1).

% Tree 28
tree(28).
% node 0: f3 <= 11.5  (F3, bin <= 5)  left -> 1, right -> 22
node(28,0,3,5).
left_node(28,0,1).
right_node(28,0,22).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 17
node(28,1,10,10).
left_node(28,1,2).
right_node(28,1,17).
% node 2: f7 <= 0.5  (F7, bin <= 0)  left -> 3, right -> 12
node(28,2,7,0).
left_node(28,2,3).
right_node(28,2,12).
% node 3: f0 <= 33.5  (F0, bin <= 9)  left -> 4, right -> 5
node(28,3,0,9).
left_node(28,3,4).
right_node(28,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(28,4,0).
% node 5: f0 <= 62.5  (F0, bin <= 16)  left -> 6, right -> 11
node(28,5,0,16).
left_node(28,5,6).
right_node(28,5,11).
% node 6: f12 <= 41.5  (F12, bin <= 8)  left -> 7, right -> 8
node(28,6,12,8).
left_node(28,6,7).
right_node(28,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(28,7,0).
% node 8: f11 <= 1794.0  (F11, bin <= 6)  left -> 9, right -> 10
node(28,8,11,6).
left_node(28,8,9).
right_node(28,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(28,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(28,10,1).
% node 11 (leaf): class <=50K (0)
leaf_class(28,11,0).
% node 12: f11 <= 2218.5  (F11, bin <= 14)  left -> 13, right -> 16
node(28,12,11,14).
left_node(28,12,13).
right_node(28,12,16).
% node 13: f5 <= 2.5  (F5, bin <= 3)  left -> 14, right -> 15
node(28,13,5,3).
left_node(28,13,14).
right_node(28,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(28,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(28,15,0).
% node 16 (leaf): class >50K (1)
leaf_class(28,16,1).
% node 17: f10 <= 7073.5  (F10, bin <= 17)  left -> 18, right -> 21
node(28,17,10,17).
left_node(28,17,18).
right_node(28,17,21).
% node 18: f7 <= 0.5  (F7, bin <= 0)  left -> 19, right -> 20
node(28,18,7,0).
left_node(28,18,19).
right_node(28,18,20).
% node 19 (leaf): class >50K (1)
leaf_class(28,19,1).
% node 20 (leaf): class <=50K (0)
leaf_class(28,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(28,21,1).
% node 22: f0 <= 28.5  (F0, bin <= 4)  left -> 23, right -> 28
node(28,22,0,4).
left_node(28,22,23).
right_node(28,22,28).
% node 23: f7 <= 0.5  (F7, bin <= 0)  left -> 24, right -> 25
node(28,23,7,0).
left_node(28,23,24).
right_node(28,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(28,24,0).
% node 25: f7 <= 4.5  (F7, bin <= 3)  left -> 26, right -> 27
node(28,25,7,3).
left_node(28,25,26).
right_node(28,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(28,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(28,27,1).
% node 28: f7 <= 0.5  (F7, bin <= 0)  left -> 29, right -> 38
node(28,28,7,0).
left_node(28,28,29).
right_node(28,28,38).
% node 29: f10 <= 5095.5  (F10, bin <= 10)  left -> 30, right -> 37
node(28,29,10,10).
left_node(28,29,30).
right_node(28,29,37).
% node 30: f6 <= 2.5  (F6, bin <= 0)  left -> 31, right -> 32
node(28,30,6,0).
left_node(28,30,31).
right_node(28,30,32).
% node 31 (leaf): class >50K (1)
leaf_class(28,31,1).
% node 32: f11 <= 1794.0  (F11, bin <= 6)  left -> 33, right -> 36
node(28,32,11,6).
left_node(28,32,33).
right_node(28,32,36).
% node 33: f12 <= 31.0  (F12, bin <= 0)  left -> 34, right -> 35
node(28,33,12,0).
left_node(28,33,34).
right_node(28,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(28,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(28,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(28,36,1).
% node 37 (leaf): class >50K (1)
leaf_class(28,37,1).
% node 38: f10 <= 7073.5  (F10, bin <= 17)  left -> 39, right -> 42
node(28,38,10,17).
left_node(28,38,39).
right_node(28,38,42).
% node 39: f7 <= 4.5  (F7, bin <= 3)  left -> 40, right -> 41
node(28,39,7,3).
left_node(28,39,40).
right_node(28,39,41).
% node 40 (leaf): class <=50K (0)
leaf_class(28,40,0).
% node 41 (leaf): class >50K (1)
leaf_class(28,41,1).
% node 42 (leaf): class >50K (1)
leaf_class(28,42,1).

% Tree 29
tree(29).
% node 0: f0 <= 29.5  (F0, bin <= 5)  left -> 1, right -> 8
node(29,0,0,5).
left_node(29,0,1).
right_node(29,0,8).
% node 1: f10 <= 7073.5  (F10, bin <= 17)  left -> 2, right -> 7
node(29,1,10,17).
left_node(29,1,2).
right_node(29,1,7).
% node 2: f5 <= 2.5  (F5, bin <= 3)  left -> 3, right -> 6
node(29,2,5,3).
left_node(29,2,3).
right_node(29,2,6).
% node 3: f3 <= 10.5  (F3, bin <= 4)  left -> 4, right -> 5
node(29,3,3,4).
left_node(29,3,4).
right_node(29,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(29,4,0).
% node 5 (leaf): class <=50K (0)
leaf_class(29,5,0).
% node 6 (leaf): class <=50K (0)
leaf_class(29,6,0).
% node 7 (leaf): class >50K (1)
leaf_class(29,7,1).
% node 8: f3 <= 11.5  (F3, bin <= 5)  left -> 9, right -> 20
node(29,8,3,5).
left_node(29,8,9).
right_node(29,8,20).
% node 9: f10 <= 5095.5  (F10, bin <= 10)  left -> 10, right -> 19
node(29,9,10,10).
left_node(29,9,10).
right_node(29,9,19).
% node 10: f12 <= 41.5  (F12, bin <= 8)  left -> 11, right -> 18
node(29,10,12,8).
left_node(29,10,11).
right_node(29,10,18).
% node 11: f4 <= 8.5  (F4, bin <= 2)  left -> 12, right -> 13
node(29,11,4,2).
left_node(29,11,12).
right_node(29,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(29,12,0).
% node 13: f5 <= 2.5  (F5, bin <= 3)  left -> 14, right -> 17
node(29,13,5,3).
left_node(29,13,14).
right_node(29,13,17).
% node 14: f9 <= 0.5  (F9, bin <= 0)  left -> 15, right -> 16
node(29,14,9,0).
left_node(29,14,15).
right_node(29,14,16).
% node 15 (leaf): class <=50K (0)
leaf_class(29,15,0).
% node 16 (leaf): class <=50K (0)
leaf_class(29,16,0).
% node 17 (leaf): class <=50K (0)
leaf_class(29,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(29,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(29,19,1).
% node 20: f12 <= 43.5  (F12, bin <= 10)  left -> 21, right -> 24
node(29,20,12,10).
left_node(29,20,21).
right_node(29,20,24).
% node 21: f5 <= 2.5  (F5, bin <= 3)  left -> 22, right -> 23
node(29,21,5,3).
left_node(29,21,22).
right_node(29,21,23).
% node 22 (leaf): class >50K (1)
leaf_class(29,22,1).
% node 23 (leaf): class <=50K (0)
leaf_class(29,23,0).
% node 24: f7 <= 0.5  (F7, bin <= 0)  left -> 25, right -> 26
node(29,24,7,0).
left_node(29,24,25).
right_node(29,24,26).
% node 25 (leaf): class >50K (1)
leaf_class(29,25,1).
% node 26: f10 <= 7139.5  (F10, bin <= 18)  left -> 27, right -> 28
node(29,26,10,18).
left_node(29,26,27).
right_node(29,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(29,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(29,28,1).

% Tree 30
tree(30).
% node 0: f4 <= 12.5  (F4, bin <= 6)  left -> 1, right -> 20
node(30,0,4,6).
left_node(30,0,1).
right_node(30,0,20).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 15
node(30,1,5,3).
left_node(30,1,2).
right_node(30,1,15).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 14
node(30,2,10,10).
left_node(30,2,3).
right_node(30,2,14).
% node 3: f5 <= 0.5  (F5, bin <= 0)  left -> 4, right -> 5
node(30,3,5,0).
left_node(30,3,4).
right_node(30,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(30,4,0).
% node 5: f6 <= 8.5  (F6, bin <= 3)  left -> 6, right -> 11
node(30,5,6,3).
left_node(30,5,6).
right_node(30,5,11).
% node 6: f0 <= 35.5  (F0, bin <= 10)  left -> 7, right -> 8
node(30,6,0,10).
left_node(30,6,7).
right_node(30,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(30,7,0).
% node 8: f6 <= 3.5  (F6, bin <= 1)  left -> 9, right -> 10
node(30,8,6,1).
left_node(30,8,9).
right_node(30,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(30,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(30,10,0).
% node 11: f3 <= 8.5  (F3, bin <= 2)  left -> 12, right -> 13
node(30,11,3,2).
left_node(30,11,12).
right_node(30,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(30,12,0).
% node 13 (leaf): class <=50K (0)
leaf_class(30,13,0).
% node 14 (leaf): class >50K (1)
leaf_class(30,14,1).
% node 15: f12 <= 41.5  (F12, bin <= 8)  left -> 16, right -> 19
node(30,15,12,8).
left_node(30,15,16).
right_node(30,15,19).
% node 16: f10 <= 8028.5  (F10, bin <= 23)  left -> 17, right -> 18
node(30,16,10,23).
left_node(30,16,17).
right_node(30,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(30,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(30,18,1).
% node 19 (leaf): class <=50K (0)
leaf_class(30,19,0).
% node 20: f5 <= 2.5  (F5, bin <= 3)  left -> 21, right -> 36
node(30,20,5,3).
left_node(30,20,21).
right_node(30,20,36).
% node 21: f9 <= 0.5  (F9, bin <= 0)  left -> 22, right -> 29
node(30,21,9,0).
left_node(30,21,22).
right_node(30,21,29).
% node 22: f10 <= 7139.5  (F10, bin <= 18)  left -> 23, right -> 28
node(30,22,10,18).
left_node(30,22,23).
right_node(30,22,28).
% node 23: f12 <= 47.0  (F12, bin <= 13)  left -> 24, right -> 27
node(30,23,12,13).
left_node(30,23,24).
right_node(30,23,27).
% node 24: f7 <= 4.5  (F7, bin <= 3)  left -> 25, right -> 26
node(30,24,7,3).
left_node(30,24,25).
right_node(30,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(30,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(30,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(30,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(30,28,1).
% node 29: f11 <= 1805.0  (F11, bin <= 7)  left -> 30, right -> 35
node(30,29,11,7).
left_node(30,29,30).
right_node(30,29,35).
% node 30: f7 <= 0.5  (F7, bin <= 0)  left -> 31, right -> 34
node(30,30,7,0).
left_node(30,30,31).
right_node(30,30,34).
% node 31: f12 <= 34.5  (F12, bin <= 4)  left -> 32, right -> 33
node(30,31,12,4).
left_node(30,31,32).
right_node(30,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(30,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(30,33,1).
% node 34 (leaf): class <=50K (0)
leaf_class(30,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(30,35,1).
% node 36: f0 <= 30.5  (F0, bin <= 6)  left -> 37, right -> 40
node(30,36,0,6).
left_node(30,36,37).
right_node(30,36,40).
% node 37: f10 <= 7731.5  (F10, bin <= 22)  left -> 38, right -> 39
node(30,37,10,22).
left_node(30,37,38).
right_node(30,37,39).
% node 38 (leaf): class <=50K (0)
leaf_class(30,38,0).
% node 39 (leaf): class >50K (1)
leaf_class(30,39,1).
% node 40: f12 <= 42.5  (F12, bin <= 9)  left -> 41, right -> 42
node(30,40,12,9).
left_node(30,40,41).
right_node(30,40,42).
% node 41 (leaf): class <=50K (0)
leaf_class(30,41,0).
% node 42 (leaf): class <=50K (0)
leaf_class(30,42,0).

% Tree 31
tree(31).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 18
node(31,0,7,0).
left_node(31,0,1).
right_node(31,0,18).
% node 1: f4 <= 12.5  (F4, bin <= 6)  left -> 2, right -> 13
node(31,1,4,6).
left_node(31,1,2).
right_node(31,1,13).
% node 2: f6 <= 3.5  (F6, bin <= 1)  left -> 3, right -> 8
node(31,2,6,1).
left_node(31,2,3).
right_node(31,2,8).
% node 3: f10 <= 5095.5  (F10, bin <= 10)  left -> 4, right -> 7
node(31,3,10,10).
left_node(31,3,4).
right_node(31,3,7).
% node 4: f4 <= 9.5  (F4, bin <= 3)  left -> 5, right -> 6
node(31,4,4,3).
left_node(31,4,5).
right_node(31,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(31,5,0).
% node 6 (leaf): class <=50K (0)
leaf_class(31,6,0).
% node 7 (leaf): class >50K (1)
leaf_class(31,7,1).
% node 8: f10 <= 5095.5  (F10, bin <= 10)  left -> 9, right -> 12
node(31,8,10,10).
left_node(31,8,9).
right_node(31,8,12).
% node 9: f6 <= 8.0  (F6, bin <= 2)  left -> 10, right -> 11
node(31,9,6,2).
left_node(31,9,10).
right_node(31,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(31,10,0).
% node 11 (leaf): class <=50K (0)
leaf_class(31,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(31,12,1).
% node 13: f12 <= 31.0  (F12, bin <= 0)  left -> 14, right -> 15
node(31,13,12,0).
left_node(31,13,14).
right_node(31,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(31,14,0).
% node 15: f3 <= 12.5  (F3, bin <= 6)  left -> 16, right -> 17
node(31,15,3,6).
left_node(31,15,16).
right_node(31,15,17).
% node 16 (leaf): class >50K (1)
leaf_class(31,16,1).
% node 17 (leaf): class >50K (1)
leaf_class(31,17,1).
% node 18: f10 <= 7073.5  (F10, bin <= 17)  left -> 19, right -> 38
node(31,18,10,17).
left_node(31,18,19).
right_node(31,18,38).
% node 19: f0 <= 31.5  (F0, bin <= 7)  left -> 20, right -> 23
node(31,19,0,7).
left_node(31,19,20).
right_node(31,19,23).
% node 20: f7 <= 4.5  (F7, bin <= 3)  left -> 21, right -> 22
node(31,20,7,3).
left_node(31,20,21).
right_node(31,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(31,21,0).
% node 22 (leaf): class <=50K (0)
leaf_class(31,22,0).
% node 23: f6 <= 8.5  (F6, bin <= 3)  left -> 24, right -> 31
node(31,23,6,3).
left_node(31,23,24).
right_node(31,23,31).
% node 24: f7 <= 4.5  (F7, bin <= 3)  left -> 25, right -> 28
node(31,24,7,3).
left_node(31,24,25).
right_node(31,24,28).
% node 25: f11 <= 2218.5  (F11, bin <= 14)  left -> 26, right -> 27
node(31,25,11,14).
left_node(31,25,26).
right_node(31,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(31,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(31,27,1).
% node 28: f6 <= 3.5  (F6, bin <= 1)  left -> 29, right -> 30
node(31,28,6,1).
left_node(31,28,29).
right_node(31,28,30).
% node 29 (leaf): class >50K (1)
leaf_class(31,29,1).
% node 30 (leaf): class <=50K (0)
leaf_class(31,30,0).
% node 31: f12 <= 45.5  (F12, bin <= 12)  left -> 32, right -> 37
node(31,31,12,12).
left_node(31,31,32).
right_node(31,31,37).
% node 32: f11 <= 1881.5  (F11, bin <= 11)  left -> 33, right -> 36
node(31,32,11,11).
left_node(31,32,33).
right_node(31,32,36).
% node 33: f7 <= 4.5  (F7, bin <= 3)  left -> 34, right -> 35
node(31,33,7,3).
left_node(31,33,34).
right_node(31,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(31,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(31,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(31,36,1).
% node 37 (leaf): class <=50K (0)
leaf_class(31,37,0).
% node 38 (leaf): class >50K (1)
leaf_class(31,38,1).

% Tree 32
tree(32).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 14
node(32,0,7,0).
left_node(32,0,1).
right_node(32,0,14).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 13
node(32,1,10,10).
left_node(32,1,2).
right_node(32,1,13).
% node 2: f3 <= 11.5  (F3, bin <= 5)  left -> 3, right -> 12
node(32,2,3,5).
left_node(32,2,3).
right_node(32,2,12).
% node 3: f4 <= 7.5  (F4, bin <= 1)  left -> 4, right -> 5
node(32,3,4,1).
left_node(32,3,4).
right_node(32,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(32,4,0).
% node 5: f3 <= 8.5  (F3, bin <= 2)  left -> 6, right -> 7
node(32,5,3,2).
left_node(32,5,6).
right_node(32,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(32,6,0).
% node 7: f1 <= 4.5  (F1, bin <= 2)  left -> 8, right -> 11
node(32,7,1,2).
left_node(32,7,8).
right_node(32,7,11).
% node 8: f0 <= 32.5  (F0, bin <= 8)  left -> 9, right -> 10
node(32,8,0,8).
left_node(32,8,9).
right_node(32,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(32,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(32,10,0).
% node 11 (leaf): class <=50K (0)
leaf_class(32,11,0).
% node 12 (leaf): class >50K (1)
leaf_class(32,12,1).
% node 13 (leaf): class >50K (1)
leaf_class(32,13,1).
% node 14: f10 <= 7073.5  (F10, bin <= 17)  left -> 15, right -> 28
node(32,14,10,17).
left_node(32,14,15).
right_node(32,14,28).
% node 15: f4 <= 13.5  (F4, bin <= 7)  left -> 16, right -> 23
node(32,15,4,7).
left_node(32,15,16).
right_node(32,15,23).
% node 16: f7 <= 4.5  (F7, bin <= 3)  left -> 17, right -> 20
node(32,16,7,3).
left_node(32,16,17).
right_node(32,16,20).
% node 17: f11 <= 2218.5  (F11, bin <= 14)  left -> 18, right -> 19
node(32,17,11,14).
left_node(32,17,18).
right_node(32,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(32,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(32,19,1).
% node 20: f4 <= 10.5  (F4, bin <= 4)  left -> 21, right -> 22
node(32,20,4,4).
left_node(32,20,21).
right_node(32,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(32,21,0).
% node 22 (leaf): class >50K (1)
leaf_class(32,22,1).
% node 23: f7 <= 4.5  (F7, bin <= 3)  left -> 24, right -> 27
node(32,23,7,3).
left_node(32,23,24).
right_node(32,23,27).
% node 24: f12 <= 43.5  (F12, bin <= 10)  left -> 25, right -> 26
node(32,24,12,10).
left_node(32,24,25).
right_node(32,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(32,25,0).
% node 26 (leaf): class <=50K (0)
leaf_class(32,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(32,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(32,28,1).

% Tree 33
tree(33).
% node 0: f12 <= 40.5  (F12, bin <= 7)  left -> 1, right -> 16
node(33,0,12,7).
left_node(33,0,1).
right_node(33,0,16).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 13
node(33,1,5,3).
left_node(33,1,2).
right_node(33,1,13).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 12
node(33,2,10,10).
left_node(33,2,3).
right_node(33,2,12).
% node 3: f5 <= 0.5  (F5, bin <= 0)  left -> 4, right -> 5
node(33,3,5,0).
left_node(33,3,4).
right_node(33,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(33,4,0).
% node 5: f0 <= 35.5  (F0, bin <= 10)  left -> 6, right -> 7
node(33,5,0,10).
left_node(33,5,6).
right_node(33,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(33,6,0).
% node 7: f11 <= 1782.5  (F11, bin <= 3)  left -> 8, right -> 11
node(33,7,11,3).
left_node(33,7,8).
right_node(33,7,11).
% node 8: f0 <= 59.5  (F0, bin <= 14)  left -> 9, right -> 10
node(33,8,0,14).
left_node(33,8,9).
right_node(33,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(33,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(33,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(33,11,1).
% node 12 (leaf): class >50K (1)
leaf_class(33,12,1).
% node 13: f4 <= 13.5  (F4, bin <= 7)  left -> 14, right -> 15
node(33,13,4,7).
left_node(33,13,14).
right_node(33,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(33,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(33,15,0).
% node 16: f5 <= 2.5  (F5, bin <= 3)  left -> 17, right -> 28
node(33,16,5,3).
left_node(33,16,17).
right_node(33,16,28).
% node 17: f11 <= 1846.0  (F11, bin <= 10)  left -> 18, right -> 27
node(33,17,11,10).
left_node(33,17,18).
right_node(33,17,27).
% node 18: f5 <= 0.5  (F5, bin <= 0)  left -> 19, right -> 22
node(33,18,5,0).
left_node(33,18,19).
right_node(33,18,22).
% node 19: f3 <= 11.5  (F3, bin <= 5)  left -> 20, right -> 21
node(33,19,3,5).
left_node(33,19,20).
right_node(33,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(33,20,0).
% node 21 (leaf): class <=50K (0)
leaf_class(33,21,0).
% node 22: f3 <= 11.5  (F3, bin <= 5)  left -> 23, right -> 26
node(33,22,3,5).
left_node(33,22,23).
right_node(33,22,26).
% node 23: f10 <= 5095.5  (F10, bin <= 10)  left -> 24, right -> 25
node(33,23,10,10).
left_node(33,23,24).
right_node(33,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(33,24,0).
% node 25 (leaf): class >50K (1)
leaf_class(33,25,1).
% node 26 (leaf): class >50K (1)
leaf_class(33,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(33,27,1).
% node 28: f10 <= 7372.5  (F10, bin <= 20)  left -> 29, right -> 30
node(33,28,10,20).
left_node(33,28,29).
right_node(33,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(33,29,0).
% node 30 (leaf): class >50K (1)
leaf_class(33,30,1).

% Tree 34
tree(34).
% node 0: f0 <= 30.5  (F0, bin <= 6)  left -> 1, right -> 8
node(34,0,0,6).
left_node(34,0,1).
right_node(34,0,8).
% node 1: f4 <= 10.5  (F4, bin <= 4)  left -> 2, right -> 5
node(34,1,4,4).
left_node(34,1,2).
right_node(34,1,5).
% node 2: f5 <= 2.5  (F5, bin <= 3)  left -> 3, right -> 4
node(34,2,5,3).
left_node(34,2,3).
right_node(34,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(34,3,0).
% node 4 (leaf): class <=50K (0)
leaf_class(34,4,0).
% node 5: f7 <= 0.5  (F7, bin <= 0)  left -> 6, right -> 7
node(34,5,7,0).
left_node(34,5,6).
right_node(34,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(34,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(34,7,0).
% node 8: f7 <= 0.5  (F7, bin <= 0)  left -> 9, right -> 24
node(34,8,7,0).
left_node(34,8,9).
right_node(34,8,24).
% node 9: f8 <= 3.5  (F8, bin <= 1)  left -> 10, right -> 15
node(34,9,8,1).
left_node(34,9,10).
right_node(34,9,15).
% node 10: f11 <= 1811.0  (F11, bin <= 8)  left -> 11, right -> 14
node(34,10,11,8).
left_node(34,10,11).
right_node(34,10,14).
% node 11: f4 <= 9.5  (F4, bin <= 3)  left -> 12, right -> 13
node(34,11,4,3).
left_node(34,11,12).
right_node(34,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(34,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(34,13,1).
% node 14 (leaf): class >50K (1)
leaf_class(34,14,1).
% node 15: f3 <= 11.5  (F3, bin <= 5)  left -> 16, right -> 23
node(34,15,3,5).
left_node(34,15,16).
right_node(34,15,23).
% node 16: f2 <= 211394.5  (F2, bin <= 5)  left -> 17, right -> 20
node(34,16,2,5).
left_node(34,16,17).
right_node(34,16,20).
% node 17: f3 <= 7.5  (F3, bin <= 1)  left -> 18, right -> 19
node(34,17,3,1).
left_node(34,17,18).
right_node(34,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(34,18,0).
% node 19 (leaf): class <=50K (0)
leaf_class(34,19,0).
% node 20: f4 <= 8.5  (F4, bin <= 2)  left -> 21, right -> 22
node(34,20,4,2).
left_node(34,20,21).
right_node(34,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(34,21,0).
% node 22 (leaf): class <=50K (0)
leaf_class(34,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(34,23,1).
% node 24: f7 <= 4.5  (F7, bin <= 3)  left -> 25, right -> 32
node(34,24,7,3).
left_node(34,24,25).
right_node(34,24,32).
% node 25: f4 <= 12.5  (F4, bin <= 6)  left -> 26, right -> 27
node(34,25,4,6).
left_node(34,25,26).
right_node(34,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(34,26,0).
% node 27: f10 <= 7073.5  (F10, bin <= 17)  left -> 28, right -> 31
node(34,27,10,17).
left_node(34,27,28).
right_node(34,27,31).
% node 28: f12 <= 42.5  (F12, bin <= 9)  left -> 29, right -> 30
node(34,28,12,9).
left_node(34,28,29).
right_node(34,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(34,29,0).
% node 30 (leaf): class <=50K (0)
leaf_class(34,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(34,31,1).
% node 32 (leaf): class >50K (1)
leaf_class(34,32,1).

% Tree 35
tree(35).
% node 0: f10 <= 5095.5  (F10, bin <= 10)  left -> 1, right -> 24
node(35,0,10,10).
left_node(35,0,1).
right_node(35,0,24).
% node 1: f11 <= 1820.5  (F11, bin <= 9)  left -> 2, right -> 19
node(35,1,11,9).
left_node(35,1,2).
right_node(35,1,19).
% node 2: f9 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 6
node(35,2,9,0).
left_node(35,2,3).
right_node(35,2,6).
% node 3: f0 <= 27.5  (F0, bin <= 3)  left -> 4, right -> 5
node(35,3,0,3).
left_node(35,3,4).
right_node(35,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(35,4,0).
% node 5 (leaf): class <=50K (0)
leaf_class(35,5,0).
% node 6: f7 <= 0.5  (F7, bin <= 0)  left -> 7, right -> 16
node(35,6,7,0).
left_node(35,6,7).
right_node(35,6,16).
% node 7: f1 <= 0.5  (F1, bin <= 0)  left -> 8, right -> 9
node(35,7,1,0).
left_node(35,7,8).
right_node(35,7,9).
% node 8 (leaf): class >50K (1)
leaf_class(35,8,1).
% node 9: f6 <= 8.0  (F6, bin <= 2)  left -> 10, right -> 13
node(35,9,6,2).
left_node(35,9,10).
right_node(35,9,13).
% node 10: f12 <= 41.5  (F12, bin <= 8)  left -> 11, right -> 12
node(35,10,12,8).
left_node(35,10,11).
right_node(35,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(35,11,0).
% node 12 (leaf): class <=50K (0)
leaf_class(35,12,0).
% node 13: f0 <= 35.5  (F0, bin <= 10)  left -> 14, right -> 15
node(35,13,0,10).
left_node(35,13,14).
right_node(35,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(35,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(35,15,0).
% node 16: f12 <= 42.5  (F12, bin <= 9)  left -> 17, right -> 18
node(35,16,12,9).
left_node(35,16,17).
right_node(35,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(35,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(35,18,0).
% node 19: f7 <= 0.5  (F7, bin <= 0)  left -> 20, right -> 23
node(35,19,7,0).
left_node(35,19,20).
right_node(35,19,23).
% node 20: f11 <= 1989.5  (F11, bin <= 13)  left -> 21, right -> 22
node(35,20,11,13).
left_node(35,20,21).
right_node(35,20,22).
% node 21 (leaf): class >50K (1)
leaf_class(35,21,1).
% node 22 (leaf): class <=50K (0)
leaf_class(35,22,0).
% node 23 (leaf): class <=50K (0)
leaf_class(35,23,0).
% node 24: f10 <= 7073.5  (F10, bin <= 17)  left -> 25, right -> 28
node(35,24,10,17).
left_node(35,24,25).
right_node(35,24,28).
% node 25: f10 <= 5316.5  (F10, bin <= 12)  left -> 26, right -> 27
node(35,25,10,12).
left_node(35,25,26).
right_node(35,25,27).
% node 26 (leaf): class >50K (1)
leaf_class(35,26,1).
% node 27 (leaf): class <=50K (0)
leaf_class(35,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(35,28,1).

% Tree 36
tree(36).
% node 0: f10 <= 5119.0  (F10, bin <= 11)  left -> 1, right -> 30
node(36,0,10,11).
left_node(36,0,1).
right_node(36,0,30).
% node 1: f5 <= 2.5  (F5, bin <= 3)  left -> 2, right -> 29
node(36,1,5,3).
left_node(36,1,2).
right_node(36,1,29).
% node 2: f6 <= 8.5  (F6, bin <= 3)  left -> 3, right -> 16
node(36,2,6,3).
left_node(36,2,3).
right_node(36,2,16).
% node 3: f6 <= 3.5  (F6, bin <= 1)  left -> 4, right -> 15
node(36,3,6,1).
left_node(36,3,4).
right_node(36,3,15).
% node 4: f3 <= 11.5  (F3, bin <= 5)  left -> 5, right -> 10
node(36,4,3,5).
left_node(36,4,5).
right_node(36,4,10).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(36,5,5,0).
left_node(36,5,6).
right_node(36,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(36,6,0).
% node 7: f4 <= 8.5  (F4, bin <= 2)  left -> 8, right -> 9
node(36,7,4,2).
left_node(36,7,8).
right_node(36,7,9).
% node 8 (leaf): class <=50K (0)
leaf_class(36,8,0).
% node 9 (leaf): class <=50K (0)
leaf_class(36,9,0).
% node 10: f4 <= 13.5  (F4, bin <= 7)  left -> 11, right -> 14
node(36,10,4,7).
left_node(36,10,11).
right_node(36,10,14).
% node 11: f5 <= 1.0  (F5, bin <= 1)  left -> 12, right -> 13
node(36,11,5,1).
left_node(36,11,12).
right_node(36,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(36,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(36,13,1).
% node 14 (leaf): class >50K (1)
leaf_class(36,14,1).
% node 15 (leaf): class <=50K (0)
leaf_class(36,15,0).
% node 16: f6 <= 9.5  (F6, bin <= 4)  left -> 17, right -> 24
node(36,16,6,4).
left_node(36,16,17).
right_node(36,16,24).
% node 17: f4 <= 13.5  (F4, bin <= 7)  left -> 18, right -> 19
node(36,17,4,7).
left_node(36,17,18).
right_node(36,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(36,18,0).
% node 19: f7 <= 0.5  (F7, bin <= 0)  left -> 20, right -> 21
node(36,19,7,0).
left_node(36,19,20).
right_node(36,19,21).
% node 20 (leaf): class >50K (1)
leaf_class(36,20,1).
% node 21: f7 <= 4.5  (F7, bin <= 3)  left -> 22, right -> 23
node(36,21,7,3).
left_node(36,21,22).
right_node(36,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(36,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(36,23,1).
% node 24: f6 <= 12.5  (F6, bin <= 5)  left -> 25, right -> 28
node(36,24,6,5).
left_node(36,24,25).
right_node(36,24,28).
% node 25: f4 <= 12.5  (F4, bin <= 6)  left -> 26, right -> 27
node(36,25,4,6).
left_node(36,25,26).
right_node(36,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(36,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(36,27,1).
% node 28 (leaf): class <=50K (0)
leaf_class(36,28,0).
% node 29 (leaf): class <=50K (0)
leaf_class(36,29,0).
% node 30 (leaf): class >50K (1)
leaf_class(36,30,1).

% Tree 37
tree(37).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 14
node(37,0,7,0).
left_node(37,0,1).
right_node(37,0,14).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 13
node(37,1,10,10).
left_node(37,1,2).
right_node(37,1,13).
% node 2: f4 <= 12.5  (F4, bin <= 6)  left -> 3, right -> 12
node(37,2,4,6).
left_node(37,2,3).
right_node(37,2,12).
% node 3: f13 <= 32.5  (F13, bin <= 3)  left -> 4, right -> 5
node(37,3,13,3).
left_node(37,3,4).
right_node(37,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(37,4,0).
% node 5: f11 <= 1782.5  (F11, bin <= 3)  left -> 6, right -> 11
node(37,5,11,3).
left_node(37,5,6).
right_node(37,5,11).
% node 6: f4 <= 8.5  (F4, bin <= 2)  left -> 7, right -> 8
node(37,6,4,2).
left_node(37,6,7).
right_node(37,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(37,7,0).
% node 8: f12 <= 37.5  (F12, bin <= 6)  left -> 9, right -> 10
node(37,8,12,6).
left_node(37,8,9).
right_node(37,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(37,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(37,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(37,11,1).
% node 12 (leaf): class >50K (1)
leaf_class(37,12,1).
% node 13 (leaf): class >50K (1)
leaf_class(37,13,1).
% node 14: f3 <= 12.5  (F3, bin <= 6)  left -> 15, right -> 26
node(37,14,3,6).
left_node(37,14,15).
right_node(37,14,26).
% node 15: f10 <= 7073.5  (F10, bin <= 17)  left -> 16, right -> 25
node(37,15,10,17).
left_node(37,15,16).
right_node(37,15,25).
% node 16: f11 <= 2218.5  (F11, bin <= 14)  left -> 17, right -> 24
node(37,16,11,14).
left_node(37,16,17).
right_node(37,16,24).
% node 17: f4 <= 10.5  (F4, bin <= 4)  left -> 18, right -> 19
node(37,17,4,4).
left_node(37,17,18).
right_node(37,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(37,18,0).
% node 19: f0 <= 27.5  (F0, bin <= 3)  left -> 20, right -> 21
node(37,19,0,3).
left_node(37,19,20).
right_node(37,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(37,20,0).
% node 21: f7 <= 4.5  (F7, bin <= 3)  left -> 22, right -> 23
node(37,21,7,3).
left_node(37,21,22).
right_node(37,21,23).
% node 22 (leaf): class <=50K (0)
leaf_class(37,22,0).
% node 23 (leaf): class >50K (1)
leaf_class(37,23,1).
% node 24 (leaf): class >50K (1)
leaf_class(37,24,1).
% node 25 (leaf): class >50K (1)
leaf_class(37,25,1).
% node 26 (leaf): class <=50K (0)
leaf_class(37,26,0).

% Tree 38
tree(38).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 24
node(38,0,7,0).
left_node(38,0,1).
right_node(38,0,24).
% node 1: f4 <= 12.5  (F4, bin <= 6)  left -> 2, right -> 19
node(38,1,4,6).
left_node(38,1,2).
right_node(38,1,19).
% node 2: f4 <= 7.5  (F4, bin <= 1)  left -> 3, right -> 6
node(38,2,4,1).
left_node(38,2,3).
right_node(38,2,6).
% node 3: f10 <= 4164.0  (F10, bin <= 5)  left -> 4, right -> 5
node(38,3,10,5).
left_node(38,3,4).
right_node(38,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(38,4,0).
% node 5 (leaf): class >50K (1)
leaf_class(38,5,1).
% node 6: f0 <= 35.5  (F0, bin <= 10)  left -> 7, right -> 12
node(38,6,0,10).
left_node(38,6,7).
right_node(38,6,12).
% node 7: f12 <= 49.5  (F12, bin <= 14)  left -> 8, right -> 11
node(38,7,12,14).
left_node(38,7,8).
right_node(38,7,11).
% node 8: f10 <= 5095.5  (F10, bin <= 10)  left -> 9, right -> 10
node(38,8,10,10).
left_node(38,8,9).
right_node(38,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(38,9,0).
% node 10 (leaf): class >50K (1)
leaf_class(38,10,1).
% node 11 (leaf): class <=50K (0)
leaf_class(38,11,0).
% node 12: f10 <= 5095.5  (F10, bin <= 10)  left -> 13, right -> 18
node(38,12,10,10).
left_node(38,12,13).
right_node(38,12,18).
% node 13: f12 <= 34.5  (F12, bin <= 4)  left -> 14, right -> 15
node(38,13,12,4).
left_node(38,13,14).
right_node(38,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(38,14,0).
% node 15: f1 <= 4.5  (F1, bin <= 2)  left -> 16, right -> 17
node(38,15,1,2).
left_node(38,15,16).
right_node(38,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(38,16,0).
% node 17 (leaf): class <=50K (0)
leaf_class(38,17,0).
% node 18 (leaf): class >50K (1)
leaf_class(38,18,1).
% node 19: f3 <= 12.5  (F3, bin <= 6)  left -> 20, right -> 23
node(38,19,3,6).
left_node(38,19,20).
right_node(38,19,23).
% node 20: f12 <= 37.5  (F12, bin <= 6)  left -> 21, right -> 22
node(38,20,12,6).
left_node(38,20,21).
right_node(38,20,22).
% node 21 (leaf): class <=50K (0)
leaf_class(38,21,0).
% node 22 (leaf): class >50K (1)
leaf_class(38,22,1).
% node 23 (leaf): class >50K (1)
leaf_class(38,23,1).
% node 24: f6 <= 8.5  (F6, bin <= 3)  left -> 25, right -> 30
node(38,24,6,3).
left_node(38,24,25).
right_node(38,24,30).
% node 25: f7 <= 4.5  (F7, bin <= 3)  left -> 26, right -> 29
node(38,25,7,3).
left_node(38,25,26).
right_node(38,25,29).
% node 26: f4 <= 13.5  (F4, bin <= 7)  left -> 27, right -> 28
node(38,26,4,7).
left_node(38,26,27).
right_node(38,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(38,27,0).
% node 28 (leaf): class <=50K (0)
leaf_class(38,28,0).
% node 29 (leaf): class <=50K (0)
leaf_class(38,29,0).
% node 30: f0 <= 28.5  (F0, bin <= 4)  left -> 31, right -> 32
node(38,30,0,4).
left_node(38,30,31).
right_node(38,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(38,31,0).
% node 32: f10 <= 7073.5  (F10, bin <= 17)  left -> 33, right -> 36
node(38,32,10,17).
left_node(38,32,33).
right_node(38,32,36).
% node 33: f7 <= 4.5  (F7, bin <= 3)  left -> 34, right -> 35
node(38,33,7,3).
left_node(38,33,34).
right_node(38,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(38,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(38,35,1).
% node 36 (leaf): class >50K (1)
leaf_class(38,36,1).

% Tree 39
tree(39).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 24
node(39,0,7,0).
left_node(39,0,1).
right_node(39,0,24).
% node 1: f12 <= 41.5  (F12, bin <= 8)  left -> 2, right -> 15
node(39,1,12,8).
left_node(39,1,2).
right_node(39,1,15).
% node 2: f12 <= 34.5  (F12, bin <= 4)  left -> 3, right -> 4
node(39,2,12,4).
left_node(39,2,3).
right_node(39,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(39,3,0).
% node 4: f0 <= 33.5  (F0, bin <= 9)  left -> 5, right -> 8
node(39,4,0,9).
left_node(39,4,5).
right_node(39,4,8).
% node 5: f3 <= 10.5  (F3, bin <= 4)  left -> 6, right -> 7
node(39,5,3,4).
left_node(39,5,6).
right_node(39,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(39,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(39,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 10
node(39,8,1,0).
left_node(39,8,9).
right_node(39,8,10).
% node 9 (leaf): class >50K (1)
leaf_class(39,9,1).
% node 10: f10 <= 5095.5  (F10, bin <= 10)  left -> 11, right -> 14
node(39,10,10,10).
left_node(39,10,11).
right_node(39,10,14).
% node 11: f4 <= 12.5  (F4, bin <= 6)  left -> 12, right -> 13
node(39,11,4,6).
left_node(39,11,12).
right_node(39,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(39,12,0).
% node 13 (leaf): class >50K (1)
leaf_class(39,13,1).
% node 14 (leaf): class >50K (1)
leaf_class(39,14,1).
% node 15: f4 <= 12.5  (F4, bin <= 6)  left -> 16, right -> 23
node(39,15,4,6).
left_node(39,15,16).
right_node(39,15,23).
% node 16: f0 <= 35.5  (F0, bin <= 10)  left -> 17, right -> 18
node(39,16,0,10).
left_node(39,16,17).
right_node(39,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(39,17,0).
% node 18: f3 <= 8.5  (F3, bin <= 2)  left -> 19, right -> 22
node(39,18,3,2).
left_node(39,18,19).
right_node(39,18,22).
% node 19: f10 <= 5095.5  (F10, bin <= 10)  left -> 20, right -> 21
node(39,19,10,10).
left_node(39,19,20).
right_node(39,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(39,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(39,21,1).
% node 22 (leaf): class >50K (1)
leaf_class(39,22,1).
% node 23 (leaf): class >50K (1)
leaf_class(39,23,1).
% node 24: f10 <= 7073.5  (F10, bin <= 17)  left -> 25, right -> 42
node(39,24,10,17).
left_node(39,24,25).
right_node(39,24,42).
% node 25: f12 <= 41.5  (F12, bin <= 8)  left -> 26, right -> 37
node(39,25,12,8).
left_node(39,25,26).
right_node(39,25,37).
% node 26: f6 <= 8.5  (F6, bin <= 3)  left -> 27, right -> 28
node(39,26,6,3).
left_node(39,26,27).
right_node(39,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(39,27,0).
% node 28: f5 <= 2.5  (F5, bin <= 3)  left -> 29, right -> 36
node(39,28,5,3).
left_node(39,28,29).
right_node(39,28,36).
% node 29: f3 <= 12.5  (F3, bin <= 6)  left -> 30, right -> 33
node(39,29,3,6).
left_node(39,29,30).
right_node(39,29,33).
% node 30: f7 <= 4.5  (F7, bin <= 3)  left -> 31, right -> 32
node(39,30,7,3).
left_node(39,30,31).
right_node(39,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(39,31,0).
% node 32 (leaf): class <=50K (0)
leaf_class(39,32,0).
% node 33: f5 <= 1.0  (F5, bin <= 1)  left -> 34, right -> 35
node(39,33,5,1).
left_node(39,33,34).
right_node(39,33,35).
% node 34 (leaf): class <=50K (0)
leaf_class(39,34,0).
% node 35 (leaf): class >50K (1)
leaf_class(39,35,1).
% node 36 (leaf): class <=50K (0)
leaf_class(39,36,0).
% node 37: f10 <= 4718.5  (F10, bin <= 8)  left -> 38, right -> 41
node(39,37,10,8).
left_node(39,37,38).
right_node(39,37,41).
% node 38: f7 <= 4.5  (F7, bin <= 3)  left -> 39, right -> 40
node(39,38,7,3).
left_node(39,38,39).
right_node(39,38,40).
% node 39 (leaf): class <=50K (0)
leaf_class(39,39,0).
% node 40 (leaf): class >50K (1)
leaf_class(39,40,1).
% node 41 (leaf): class >50K (1)
leaf_class(39,41,1).
% node 42 (leaf): class >50K (1)
leaf_class(39,42,1).

% Tree 40
tree(40).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 18
node(40,0,7,0).
left_node(40,0,1).
right_node(40,0,18).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 17
node(40,1,10,10).
left_node(40,1,2).
right_node(40,1,17).
% node 2: f12 <= 40.5  (F12, bin <= 7)  left -> 3, right -> 12
node(40,2,12,7).
left_node(40,2,3).
right_node(40,2,12).
% node 3: f6 <= 8.0  (F6, bin <= 2)  left -> 4, right -> 9
node(40,3,6,2).
left_node(40,3,4).
right_node(40,3,9).
% node 4: f4 <= 9.5  (F4, bin <= 3)  left -> 5, right -> 6
node(40,4,4,3).
left_node(40,4,5).
right_node(40,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(40,5,0).
% node 6: f0 <= 32.5  (F0, bin <= 8)  left -> 7, right -> 8
node(40,6,0,8).
left_node(40,6,7).
right_node(40,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(40,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(40,8,0).
% node 9: f4 <= 11.5  (F4, bin <= 5)  left -> 10, right -> 11
node(40,9,4,5).
left_node(40,9,10).
right_node(40,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(40,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(40,11,1).
% node 12: f4 <= 12.5  (F4, bin <= 6)  left -> 13, right -> 16
node(40,12,4,6).
left_node(40,12,13).
right_node(40,12,16).
% node 13: f11 <= 1846.0  (F11, bin <= 10)  left -> 14, right -> 15
node(40,13,11,10).
left_node(40,13,14).
right_node(40,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(40,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(40,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(40,16,1).
% node 17 (leaf): class >50K (1)
leaf_class(40,17,1).
% node 18: f7 <= 4.5  (F7, bin <= 3)  left -> 19, right -> 32
node(40,18,7,3).
left_node(40,18,19).
right_node(40,18,32).
% node 19: f3 <= 12.5  (F3, bin <= 6)  left -> 20, right -> 27
node(40,19,3,6).
left_node(40,19,20).
right_node(40,19,27).
% node 20: f3 <= 11.5  (F3, bin <= 5)  left -> 21, right -> 26
node(40,20,3,5).
left_node(40,20,21).
right_node(40,20,26).
% node 21: f10 <= 7139.5  (F10, bin <= 18)  left -> 22, right -> 25
node(40,21,10,18).
left_node(40,21,22).
right_node(40,21,25).
% node 22: f11 <= 2218.5  (F11, bin <= 14)  left -> 23, right -> 24
node(40,22,11,14).
left_node(40,22,23).
right_node(40,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(40,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(40,24,1).
% node 25 (leaf): class >50K (1)
leaf_class(40,25,1).
% node 26 (leaf): class <=50K (0)
leaf_class(40,26,0).
% node 27: f10 <= 7139.5  (F10, bin <= 18)  left -> 28, right -> 31
node(40,27,10,18).
left_node(40,27,28).
right_node(40,27,31).
% node 28: f12 <= 43.5  (F12, bin <= 10)  left -> 29, right -> 30
node(40,28,12,10).
left_node(40,28,29).
right_node(40,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(40,29,0).
% node 30 (leaf): class <=50K (0)
leaf_class(40,30,0).
% node 31 (leaf): class >50K (1)
leaf_class(40,31,1).
% node 32 (leaf): class <=50K (0)
leaf_class(40,32,0).

% Tree 41
tree(41).
% node 0: f9 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 8
node(41,0,9,0).
left_node(41,0,1).
right_node(41,0,8).
% node 1: f7 <= 4.5  (F7, bin <= 3)  left -> 2, right -> 3
node(41,1,7,3).
left_node(41,1,2).
right_node(41,1,3).
% node 2 (leaf): class <=50K (0)
leaf_class(41,2,0).
% node 3: f10 <= 5095.5  (F10, bin <= 10)  left -> 4, right -> 7
node(41,3,10,10).
left_node(41,3,4).
right_node(41,3,7).
% node 4: f3 <= 9.5  (F3, bin <= 3)  left -> 5, right -> 6
node(41,4,3,3).
left_node(41,4,5).
right_node(41,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(41,5,0).
% node 6 (leaf): class >50K (1)
leaf_class(41,6,1).
% node 7 (leaf): class >50K (1)
leaf_class(41,7,1).
% node 8: f3 <= 11.5  (F3, bin <= 5)  left -> 9, right -> 32
node(41,8,3,5).
left_node(41,8,9).
right_node(41,8,32).
% node 9: f3 <= 7.5  (F3, bin <= 1)  left -> 10, right -> 11
node(41,9,3,1).
left_node(41,9,10).
right_node(41,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(41,10,0).
% node 11: f4 <= 9.5  (F4, bin <= 3)  left -> 12, right -> 21
node(41,11,4,3).
left_node(41,11,12).
right_node(41,11,21).
% node 12: f5 <= 2.5  (F5, bin <= 3)  left -> 13, right -> 20
node(41,12,5,3).
left_node(41,12,13).
right_node(41,12,20).
% node 13: f12 <= 40.5  (F12, bin <= 7)  left -> 14, right -> 17
node(41,13,12,7).
left_node(41,13,14).
right_node(41,13,17).
% node 14: f10 <= 5095.5  (F10, bin <= 10)  left -> 15, right -> 16
node(41,14,10,10).
left_node(41,14,15).
right_node(41,14,16).
% node 15 (leaf): class <=50K (0)
leaf_class(41,15,0).
% node 16 (leaf): class >50K (1)
leaf_class(41,16,1).
% node 17: f7 <= 0.5  (F7, bin <= 0)  left -> 18, right -> 19
node(41,17,7,0).
left_node(41,17,18).
right_node(41,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(41,18,0).
% node 19 (leaf): class <=50K (0)
leaf_class(41,19,0).
% node 20 (leaf): class <=50K (0)
leaf_class(41,20,0).
% node 21: f0 <= 35.5  (F0, bin <= 10)  left -> 22, right -> 27
node(41,21,0,10).
left_node(41,21,22).
right_node(41,21,27).
% node 22: f0 <= 25.5  (F0, bin <= 1)  left -> 23, right -> 24
node(41,22,0,1).
left_node(41,22,23).
right_node(41,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(41,23,0).
% node 24: f10 <= 5095.5  (F10, bin <= 10)  left -> 25, right -> 26
node(41,24,10,10).
left_node(41,24,25).
right_node(41,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(41,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(41,26,1).
% node 27: f5 <= 2.5  (F5, bin <= 3)  left -> 28, right -> 31
node(41,27,5,3).
left_node(41,27,28).
right_node(41,27,31).
% node 28: f11 <= 1881.5  (F11, bin <= 11)  left -> 29, right -> 30
node(41,28,11,11).
left_node(41,28,29).
right_node(41,28,30).
% node 29 (leaf): class <=50K (0)
leaf_class(41,29,0).
% node 30 (leaf): class >50K (1)
leaf_class(41,30,1).
% node 31 (leaf): class <=50K (0)
leaf_class(41,31,0).
% node 32: f4 <= 13.5  (F4, bin <= 7)  left -> 33, right -> 40
node(41,32,4,7).
left_node(41,32,33).
right_node(41,32,40).
% node 33: f11 <= 1881.5  (F11, bin <= 11)  left -> 34, right -> 39
node(41,33,11,11).
left_node(41,33,34).
right_node(41,33,39).
% node 34: f0 <= 29.5  (F0, bin <= 5)  left -> 35, right -> 36
node(41,34,0,5).
left_node(41,34,35).
right_node(41,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(41,35,0).
% node 36: f5 <= 2.5  (F5, bin <= 3)  left -> 37, right -> 38
node(41,36,5,3).
left_node(41,36,37).
right_node(41,36,38).
% node 37 (leaf): class >50K (1)
leaf_class(41,37,1).
% node 38 (leaf): class <=50K (0)
leaf_class(41,38,0).
% node 39 (leaf): class >50K (1)
leaf_class(41,39,1).
% node 40: f7 <= 0.5  (F7, bin <= 0)  left -> 41, right -> 42
node(41,40,7,0).
left_node(41,40,41).
right_node(41,40,42).
% node 41 (leaf): class >50K (1)
leaf_class(41,41,1).
% node 42 (leaf): class <=50K (0)
leaf_class(41,42,0).

% Tree 42
tree(42).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 30
node(42,0,5,3).
left_node(42,0,1).
right_node(42,0,30).
% node 1: f3 <= 11.5  (F3, bin <= 5)  left -> 2, right -> 21
node(42,1,3,5).
left_node(42,1,2).
right_node(42,1,21).
% node 2: f0 <= 35.5  (F0, bin <= 10)  left -> 3, right -> 8
node(42,2,0,10).
left_node(42,2,3).
right_node(42,2,8).
% node 3: f0 <= 24.5  (F0, bin <= 0)  left -> 4, right -> 5
node(42,3,0,0).
left_node(42,3,4).
right_node(42,3,5).
% node 4 (leaf): class <=50K (0)
leaf_class(42,4,0).
% node 5: f10 <= 5095.5  (F10, bin <= 10)  left -> 6, right -> 7
node(42,5,10,10).
left_node(42,5,6).
right_node(42,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(42,6,0).
% node 7 (leaf): class >50K (1)
leaf_class(42,7,1).
% node 8: f5 <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(42,8,5,0).
left_node(42,8,9).
right_node(42,8,12).
% node 9: f10 <= 8296.0  (F10, bin <= 24)  left -> 10, right -> 11
node(42,9,10,24).
left_node(42,9,10).
right_node(42,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(42,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(42,11,1).
% node 12: f4 <= 8.5  (F4, bin <= 2)  left -> 13, right -> 14
node(42,12,4,2).
left_node(42,12,13).
right_node(42,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(42,13,0).
% node 14: f1 <= 4.5  (F1, bin <= 2)  left -> 15, right -> 18
node(42,14,1,2).
left_node(42,14,15).
right_node(42,14,18).
% node 15: f11 <= 1782.5  (F11, bin <= 3)  left -> 16, right -> 17
node(42,15,11,3).
left_node(42,15,16).
right_node(42,15,17).
% node 16 (leaf): class <=50K (0)
leaf_class(42,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(42,17,1).
% node 18: f10 <= 5715.5  (F10, bin <= 13)  left -> 19, right -> 20
node(42,18,10,13).
left_node(42,18,19).
right_node(42,18,20).
% node 19 (leaf): class <=50K (0)
leaf_class(42,19,0).
% node 20 (leaf): class >50K (1)
leaf_class(42,20,1).
% node 21: f3 <= 13.5  (F3, bin <= 7)  left -> 22, right -> 29
node(42,21,3,7).
left_node(42,21,22).
right_node(42,21,29).
% node 22: f10 <= 7073.5  (F10, bin <= 17)  left -> 23, right -> 28
node(42,22,10,17).
left_node(42,22,23).
right_node(42,22,28).
% node 23: f9 <= 0.5  (F9, bin <= 0)  left -> 24, right -> 25
node(42,23,9,0).
left_node(42,23,24).
right_node(42,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(42,24,0).
% node 25: f5 <= 1.0  (F5, bin <= 1)  left -> 26, right -> 27
node(42,25,5,1).
left_node(42,25,26).
right_node(42,25,27).
% node 26 (leaf): class <=50K (0)
leaf_class(42,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(42,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(42,28,1).
% node 29 (leaf): class >50K (1)
leaf_class(42,29,1).
% node 30: f3 <= 12.5  (F3, bin <= 6)  left -> 31, right -> 34
node(42,30,3,6).
left_node(42,30,31).
right_node(42,30,34).
% node 31: f10 <= 8028.5  (F10, bin <= 23)  left -> 32, right -> 33
node(42,31,10,23).
left_node(42,31,32).
right_node(42,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(42,32,0).
% node 33 (leaf): class >50K (1)
leaf_class(42,33,1).
% node 34: f10 <= 7731.5  (F10, bin <= 22)  left -> 35, right -> 36
node(42,34,10,22).
left_node(42,34,35).
right_node(42,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(42,35,0).
% node 36 (leaf): class >50K (1)
leaf_class(42,36,1).

% Tree 43
tree(43).
% node 0: f7 <= 0.5  (F7, bin <= 0)  left -> 1, right -> 28
node(43,0,7,0).
left_node(43,0,1).
right_node(43,0,28).
% node 1: f11 <= 1782.5  (F11, bin <= 3)  left -> 2, right -> 21
node(43,1,11,3).
left_node(43,1,2).
right_node(43,1,21).
% node 2: f10 <= 5095.5  (F10, bin <= 10)  left -> 3, right -> 20
node(43,2,10,10).
left_node(43,2,3).
right_node(43,2,20).
% node 3: f12 <= 40.5  (F12, bin <= 7)  left -> 4, right -> 11
node(43,3,12,7).
left_node(43,3,4).
right_node(43,3,11).
% node 4: f11 <= 1532.0  (F11, bin <= 1)  left -> 5, right -> 10
node(43,4,11,1).
left_node(43,4,5).
right_node(43,4,10).
% node 5: f10 <= 3120.0  (F10, bin <= 1)  left -> 6, right -> 9
node(43,5,10,1).
left_node(43,5,6).
right_node(43,5,9).
% node 6: f4 <= 12.5  (F4, bin <= 6)  left -> 7, right -> 8
node(43,6,4,6).
left_node(43,6,7).
right_node(43,6,8).
% node 7 (leaf): class <=50K (0)
leaf_class(43,7,0).
% node 8 (leaf): class >50K (1)
leaf_class(43,8,1).
% node 9 (leaf): class <=50K (0)
leaf_class(43,9,0).
% node 10 (leaf): class <=50K (0)
leaf_class(43,10,0).
% node 11: f1 <= 4.5  (F1, bin <= 2)  left -> 12, right -> 17
node(43,11,1,2).
left_node(43,11,12).
right_node(43,11,17).
% node 12: f3 <= 11.5  (F3, bin <= 5)  left -> 13, right -> 16
node(43,12,3,5).
left_node(43,12,13).
right_node(43,12,16).
% node 13: f4 <= 8.5  (F4, bin <= 2)  left -> 14, right -> 15
node(43,13,4,2).
left_node(43,13,14).
right_node(43,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(43,14,0).
% node 15 (leaf): class <=50K (0)
leaf_class(43,15,0).
% node 16 (leaf): class >50K (1)
leaf_class(43,16,1).
% node 17: f3 <= 11.5  (F3, bin <= 5)  left -> 18, right -> 19
node(43,17,3,5).
left_node(43,17,18).
right_node(43,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(43,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(43,19,1).
% node 20 (leaf): class >50K (1)
leaf_class(43,20,1).
% node 21: f6 <= 12.5  (F6, bin <= 5)  left -> 22, right -> 27
node(43,21,6,5).
left_node(43,21,22).
right_node(43,21,27).
% node 22: f11 <= 1989.5  (F11, bin <= 13)  left -> 23, right -> 24
node(43,22,11,13).
left_node(43,22,23).
right_node(43,22,24).
% node 23 (leaf): class >50K (1)
leaf_class(43,23,1).
% node 24: f3 <= 11.5  (F3, bin <= 5)  left -> 25, right -> 26
node(43,24,3,5).
left_node(43,24,25).
right_node(43,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(43,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(43,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(43,27,1).
% node 28: f4 <= 12.5  (F4, bin <= 6)  left -> 29, right -> 42
node(43,28,4,6).
left_node(43,28,29).
right_node(43,28,42).
% node 29: f3 <= 9.5  (F3, bin <= 3)  left -> 30, right -> 39
node(43,29,3,3).
left_node(43,29,30).
right_node(43,29,39).
% node 30: f0 <= 32.5  (F0, bin <= 8)  left -> 31, right -> 32
node(43,30,0,8).
left_node(43,30,31).
right_node(43,30,32).
% node 31 (leaf): class <=50K (0)
leaf_class(43,31,0).
% node 32: f4 <= 4.5  (F4, bin <= 0)  left -> 33, right -> 34
node(43,32,4,0).
left_node(43,32,33).
right_node(43,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(43,33,0).
% node 34: f10 <= 7073.5  (F10, bin <= 17)  left -> 35, right -> 38
node(43,34,10,17).
left_node(43,34,35).
right_node(43,34,38).
% node 35: f7 <= 4.5  (F7, bin <= 3)  left -> 36, right -> 37
node(43,35,7,3).
left_node(43,35,36).
right_node(43,35,37).
% node 36 (leaf): class <=50K (0)
leaf_class(43,36,0).
% node 37 (leaf): class <=50K (0)
leaf_class(43,37,0).
% node 38 (leaf): class >50K (1)
leaf_class(43,38,1).
% node 39: f7 <= 4.5  (F7, bin <= 3)  left -> 40, right -> 41
node(43,39,7,3).
left_node(43,39,40).
right_node(43,39,41).
% node 40 (leaf): class <=50K (0)
leaf_class(43,40,0).
% node 41 (leaf): class >50K (1)
leaf_class(43,41,1).
% node 42: f7 <= 4.5  (F7, bin <= 3)  left -> 43, right -> 50
node(43,42,7,3).
left_node(43,42,43).
right_node(43,42,50).
% node 43: f4 <= 14.5  (F4, bin <= 8)  left -> 44, right -> 49
node(43,43,4,8).
left_node(43,43,44).
right_node(43,43,49).
% node 44: f10 <= 7073.5  (F10, bin <= 17)  left -> 45, right -> 48
node(43,44,10,17).
left_node(43,44,45).
right_node(43,44,48).
% node 45: f0 <= 27.5  (F0, bin <= 3)  left -> 46, right -> 47
node(43,45,0,3).
left_node(43,45,46).
right_node(43,45,47).
% node 46 (leaf): class <=50K (0)
leaf_class(43,46,0).
% node 47 (leaf): class <=50K (0)
leaf_class(43,47,0).
% node 48 (leaf): class >50K (1)
leaf_class(43,48,1).
% node 49 (leaf): class <=50K (0)
leaf_class(43,49,0).
% node 50 (leaf): class >50K (1)
leaf_class(43,50,1).

% Tree 44
tree(44).
% node 0: f10 <= 5119.0  (F10, bin <= 11)  left -> 1, right -> 30
node(44,0,10,11).
left_node(44,0,1).
right_node(44,0,30).
% node 1: f0 <= 29.5  (F0, bin <= 5)  left -> 2, right -> 5
node(44,1,0,5).
left_node(44,1,2).
right_node(44,1,5).
% node 2: f5 <= 2.5  (F5, bin <= 3)  left -> 3, right -> 4
node(44,2,5,3).
left_node(44,2,3).
right_node(44,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(44,3,0).
% node 4 (leaf): class <=50K (0)
leaf_class(44,4,0).
% node 5: f5 <= 2.5  (F5, bin <= 3)  left -> 6, right -> 27
node(44,5,5,3).
left_node(44,5,6).
right_node(44,5,27).
% node 6: f0 <= 59.5  (F0, bin <= 14)  left -> 7, right -> 22
node(44,6,0,14).
left_node(44,6,7).
right_node(44,6,22).
% node 7: f7 <= 0.5  (F7, bin <= 0)  left -> 8, right -> 15
node(44,7,7,0).
left_node(44,7,8).
right_node(44,7,15).
% node 8: f0 <= 36.5  (F0, bin <= 11)  left -> 9, right -> 12
node(44,8,0,11).
left_node(44,8,9).
right_node(44,8,12).
% node 9: f4 <= 12.5  (F4, bin <= 6)  left -> 10, right -> 11
node(44,9,4,6).
left_node(44,9,10).
right_node(44,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(44,10,0).
% node 11 (leaf): class >50K (1)
leaf_class(44,11,1).
% node 12: f11 <= 1794.0  (F11, bin <= 6)  left -> 13, right -> 14
node(44,12,11,6).
left_node(44,12,13).
right_node(44,12,14).
% node 13 (leaf): class <=50K (0)
leaf_class(44,13,0).
% node 14 (leaf): class >50K (1)
leaf_class(44,14,1).
% node 15: f7 <= 4.5  (F7, bin <= 3)  left -> 16, right -> 19
node(44,15,7,3).
left_node(44,15,16).
right_node(44,15,19).
% node 16: f3 <= 11.5  (F3, bin <= 5)  left -> 17, right -> 18
node(44,16,3,5).
left_node(44,16,17).
right_node(44,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(44,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(44,18,0).
% node 19: f3 <= 9.5  (F3, bin <= 3)  left -> 20, right -> 21
node(44,19,3,3).
left_node(44,19,20).
right_node(44,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(44,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(44,21,1).
% node 22: f11 <= 1782.5  (F11, bin <= 3)  left -> 23, right -> 26
node(44,22,11,3).
left_node(44,22,23).
right_node(44,22,26).
% node 23: f4 <= 10.5  (F4, bin <= 4)  left -> 24, right -> 25
node(44,23,4,4).
left_node(44,23,24).
right_node(44,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(44,24,0).
% node 25 (leaf): class <=50K (0)
leaf_class(44,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(44,26,1).
% node 27: f12 <= 41.5  (F12, bin <= 8)  left -> 28, right -> 29
node(44,27,12,8).
left_node(44,27,28).
right_node(44,27,29).
% node 28 (leaf): class <=50K (0)
leaf_class(44,28,0).
% node 29 (leaf): class <=50K (0)
leaf_class(44,29,0).
% node 30 (leaf): class >50K (1)
leaf_class(44,30,1).

% Tree 45
tree(45).
% node 0: f4 <= 12.5  (F4, bin <= 6)  left -> 1, right -> 22
node(45,0,4,6).
left_node(45,0,1).
right_node(45,0,22).
% node 1: f10 <= 5119.0  (F10, bin <= 11)  left -> 2, right -> 21
node(45,1,10,11).
left_node(45,1,2).
right_node(45,1,21).
% node 2: f5 <= 2.5  (F5, bin <= 3)  left -> 3, right -> 20
node(45,2,5,3).
left_node(45,2,3).
right_node(45,2,20).
% node 3: f9 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 13
node(45,3,9,0).
left_node(45,3,4).
right_node(45,3,13).
% node 4: f4 <= 9.5  (F4, bin <= 3)  left -> 5, right -> 8
node(45,4,4,3).
left_node(45,4,5).
right_node(45,4,8).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(45,5,5,0).
left_node(45,5,6).
right_node(45,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(45,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(45,7,0).
% node 8: f13 <= 26.5  (F13, bin <= 1)  left -> 9, right -> 10
node(45,8,13,1).
left_node(45,8,9).
right_node(45,8,10).
% node 9 (leaf): class <=50K (0)
leaf_class(45,9,0).
% node 10: f5 <= 0.5  (F5, bin <= 0)  left -> 11, right -> 12
node(45,10,5,0).
left_node(45,10,11).
right_node(45,10,12).
% node 11 (leaf): class <=50K (0)
leaf_class(45,11,0).
% node 12 (leaf): class <=50K (0)
leaf_class(45,12,0).
% node 13: f0 <= 35.5  (F0, bin <= 10)  left -> 14, right -> 15
node(45,13,0,10).
left_node(45,13,14).
right_node(45,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(45,14,0).
% node 15: f7 <= 0.5  (F7, bin <= 0)  left -> 16, right -> 19
node(45,15,7,0).
left_node(45,15,16).
right_node(45,15,19).
% node 16: f4 <= 8.5  (F4, bin <= 2)  left -> 17, right -> 18
node(45,16,4,2).
left_node(45,16,17).
right_node(45,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(45,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(45,18,0).
% node 19 (leaf): class <=50K (0)
leaf_class(45,19,0).
% node 20 (leaf): class <=50K (0)
leaf_class(45,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(45,21,1).
% node 22: f12 <= 41.5  (F12, bin <= 8)  left -> 23, right -> 30
node(45,22,12,8).
left_node(45,22,23).
right_node(45,22,30).
% node 23: f11 <= 1881.5  (F11, bin <= 11)  left -> 24, right -> 29
node(45,23,11,11).
left_node(45,23,24).
right_node(45,23,29).
% node 24: f7 <= 0.5  (F7, bin <= 0)  left -> 25, right -> 26
node(45,24,7,0).
left_node(45,24,25).
right_node(45,24,26).
% node 25 (leaf): class >50K (1)
leaf_class(45,25,1).
% node 26: f0 <= 31.5  (F0, bin <= 7)  left -> 27, right -> 28
node(45,26,0,7).
left_node(45,26,27).
right_node(45,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(45,27,0).
% node 28 (leaf): class <=50K (0)
leaf_class(45,28,0).
% node 29 (leaf): class >50K (1)
leaf_class(45,29,1).
% node 30: f9 <= 0.5  (F9, bin <= 0)  left -> 31, right -> 34
node(45,30,9,0).
left_node(45,30,31).
right_node(45,30,34).
% node 31: f5 <= 3.5  (F5, bin <= 5)  left -> 32, right -> 33
node(45,31,5,5).
left_node(45,31,32).
right_node(45,31,33).
% node 32 (leaf): class >50K (1)
leaf_class(45,32,1).
% node 33 (leaf): class <=50K (0)
leaf_class(45,33,0).
% node 34: f5 <= 2.5  (F5, bin <= 3)  left -> 35, right -> 40
node(45,34,5,3).
left_node(45,34,35).
right_node(45,34,40).
% node 35: f3 <= 13.5  (F3, bin <= 7)  left -> 36, right -> 39
node(45,35,3,7).
left_node(45,35,36).
right_node(45,35,39).
% node 36: f10 <= 6897.5  (F10, bin <= 14)  left -> 37, right -> 38
node(45,36,10,14).
left_node(45,36,37).
right_node(45,36,38).
% node 37 (leaf): class >50K (1)
leaf_class(45,37,1).
% node 38 (leaf): class >50K (1)
leaf_class(45,38,1).
% node 39 (leaf): class >50K (1)
leaf_class(45,39,1).
% node 40 (leaf): class <=50K (0)
leaf_class(45,40,0).

% Tree 46
tree(46).
% node 0: f9 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 8
node(46,0,9,0).
left_node(46,0,1).
right_node(46,0,8).
% node 1: f7 <= 4.5  (F7, bin <= 3)  left -> 2, right -> 5
node(46,1,7,3).
left_node(46,1,2).
right_node(46,1,5).
% node 2: f4 <= 13.5  (F4, bin <= 7)  left -> 3, right -> 4
node(46,2,4,7).
left_node(46,2,3).
right_node(46,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(46,3,0).
% node 4 (leaf): class <=50K (0)
leaf_class(46,4,0).
% node 5: f4 <= 10.5  (F4, bin <= 4)  left -> 6, right -> 7
node(46,5,4,4).
left_node(46,5,6).
right_node(46,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(46,6,0).
% node 7 (leaf): class >50K (1)
leaf_class(46,7,1).
% node 8: f12 <= 41.5  (F12, bin <= 8)  left -> 9, right -> 26
node(46,8,12,8).
left_node(46,8,9).
right_node(46,8,26).
% node 9: f7 <= 0.5  (F7, bin <= 0)  left -> 10, right -> 23
node(46,9,7,0).
left_node(46,9,10).
right_node(46,9,23).
% node 10: f3 <= 11.5  (F3, bin <= 5)  left -> 11, right -> 18
node(46,10,3,5).
left_node(46,10,11).
right_node(46,10,18).
% node 11: f3 <= 6.5  (F3, bin <= 0)  left -> 12, right -> 13
node(46,11,3,0).
left_node(46,11,12).
right_node(46,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(46,12,0).
% node 13: f11 <= 1782.5  (F11, bin <= 3)  left -> 14, right -> 17
node(46,13,11,3).
left_node(46,13,14).
right_node(46,13,17).
% node 14: f0 <= 35.5  (F0, bin <= 10)  left -> 15, right -> 16
node(46,14,0,10).
left_node(46,14,15).
right_node(46,14,16).
% node 15 (leaf): class <=50K (0)
leaf_class(46,15,0).
% node 16 (leaf): class <=50K (0)
leaf_class(46,16,0).
% node 17 (leaf): class >50K (1)
leaf_class(46,17,1).
% node 18: f3 <= 12.5  (F3, bin <= 6)  left -> 19, right -> 22
node(46,18,3,6).
left_node(46,18,19).
right_node(46,18,22).
% node 19: f12 <= 34.5  (F12, bin <= 4)  left -> 20, right -> 21
node(46,19,12,4).
left_node(46,19,20).
right_node(46,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(46,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(46,21,1).
% node 22 (leaf): class >50K (1)
leaf_class(46,22,1).
% node 23: f10 <= 7073.5  (F10, bin <= 17)  left -> 24, right -> 25
node(46,23,10,17).
left_node(46,23,24).
right_node(46,23,25).
% node 24 (leaf): class <=50K (0)
leaf_class(46,24,0).
% node 25 (leaf): class >50K (1)
leaf_class(46,25,1).
% node 26: f7 <= 0.5  (F7, bin <= 0)  left -> 27, right -> 38
node(46,26,7,0).
left_node(46,26,27).
right_node(46,26,38).
% node 27: f4 <= 12.5  (F4, bin <= 6)  left -> 28, right -> 37
node(46,27,4,6).
left_node(46,27,28).
right_node(46,27,37).
% node 28: f11 <= 1794.0  (F11, bin <= 6)  left -> 29, right -> 34
node(46,28,11,6).
left_node(46,28,29).
right_node(46,28,34).
% node 29: f0 <= 31.5  (F0, bin <= 7)  left -> 30, right -> 31
node(46,29,0,7).
left_node(46,29,30).
right_node(46,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(46,30,0).
% node 31: f4 <= 8.5  (F4, bin <= 2)  left -> 32, right -> 33
node(46,31,4,2).
left_node(46,31,32).
right_node(46,31,33).
% node 32 (leaf): class <=50K (0)
leaf_class(46,32,0).
% node 33 (leaf): class <=50K (0)
leaf_class(46,33,0).
% node 34: f11 <= 1989.5  (F11, bin <= 13)  left -> 35, right -> 36
node(46,34,11,13).
left_node(46,34,35).
right_node(46,34,36).
% node 35 (leaf): class >50K (1)
leaf_class(46,35,1).
% node 36 (leaf): class <=50K (0)
leaf_class(46,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(46,37,1).
% node 38: f10 <= 7139.5  (F10, bin <= 18)  left -> 39, right -> 40
node(46,38,10,18).
left_node(46,38,39).
right_node(46,38,40).
% node 39 (leaf): class <=50K (0)
leaf_class(46,39,0).
% node 40 (leaf): class >50K (1)
leaf_class(46,40,1).

% Tree 47
tree(47).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 22
node(47,0,5,3).
left_node(47,0,1).
right_node(47,0,22).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 21
node(47,1,10,10).
left_node(47,1,2).
right_node(47,1,21).
% node 2: f3 <= 11.5  (F3, bin <= 5)  left -> 3, right -> 14
node(47,2,3,5).
left_node(47,2,3).
right_node(47,2,14).
% node 3: f9 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(47,3,9,0).
left_node(47,3,4).
right_node(47,3,7).
% node 4: f5 <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(47,4,5,0).
left_node(47,4,5).
right_node(47,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(47,5,0).
% node 6 (leaf): class <=50K (0)
leaf_class(47,6,0).
% node 7: f7 <= 0.5  (F7, bin <= 0)  left -> 8, right -> 13
node(47,7,7,0).
left_node(47,7,8).
right_node(47,7,13).
% node 8: f6 <= 8.0  (F6, bin <= 2)  left -> 9, right -> 12
node(47,8,6,2).
left_node(47,8,9).
right_node(47,8,12).
% node 9: f0 <= 36.5  (F0, bin <= 11)  left -> 10, right -> 11
node(47,9,0,11).
left_node(47,9,10).
right_node(47,9,11).
% node 10 (leaf): class <=50K (0)
leaf_class(47,10,0).
% node 11 (leaf): class <=50K (0)
leaf_class(47,11,0).
% node 12 (leaf): class <=50K (0)
leaf_class(47,12,0).
% node 13 (leaf): class <=50K (0)
leaf_class(47,13,0).
% node 14: f4 <= 14.5  (F4, bin <= 8)  left -> 15, right -> 20
node(47,14,4,8).
left_node(47,14,15).
right_node(47,14,20).
% node 15: f7 <= 0.5  (F7, bin <= 0)  left -> 16, right -> 17
node(47,15,7,0).
left_node(47,15,16).
right_node(47,15,17).
% node 16 (leaf): class >50K (1)
leaf_class(47,16,1).
% node 17: f7 <= 4.5  (F7, bin <= 3)  left -> 18, right -> 19
node(47,17,7,3).
left_node(47,17,18).
right_node(47,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(47,18,0).
% node 19 (leaf): class >50K (1)
leaf_class(47,19,1).
% node 20 (leaf): class >50K (1)
leaf_class(47,20,1).
% node 21 (leaf): class >50K (1)
leaf_class(47,21,1).
% node 22: f11 <= 2365.5  (F11, bin <= 15)  left -> 23, right -> 28
node(47,22,11,15).
left_node(47,22,23).
right_node(47,22,28).
% node 23: f10 <= 7669.5  (F10, bin <= 21)  left -> 24, right -> 27
node(47,23,10,21).
left_node(47,23,24).
right_node(47,23,27).
% node 24: f3 <= 12.5  (F3, bin <= 6)  left -> 25, right -> 26
node(47,24,3,6).
left_node(47,24,25).
right_node(47,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(47,25,0).
% node 26 (leaf): class <=50K (0)
leaf_class(47,26,0).
% node 27 (leaf): class >50K (1)
leaf_class(47,27,1).
% node 28 (leaf): class >50K (1)
leaf_class(47,28,1).

% Tree 48
tree(48).
% node 0: f5 <= 2.5  (F5, bin <= 3)  left -> 1, right -> 26
node(48,0,5,3).
left_node(48,0,1).
right_node(48,0,26).
% node 1: f10 <= 5095.5  (F10, bin <= 10)  left -> 2, right -> 25
node(48,1,10,10).
left_node(48,1,2).
right_node(48,1,25).
% node 2: f11 <= 1793.5  (F11, bin <= 5)  left -> 3, right -> 22
node(48,2,11,5).
left_node(48,2,3).
right_node(48,2,22).
% node 3: f0 <= 31.5  (F0, bin <= 7)  left -> 4, right -> 9
node(48,3,0,7).
left_node(48,3,4).
right_node(48,3,9).
% node 4: f6 <= 8.5  (F6, bin <= 3)  left -> 5, right -> 8
node(48,4,6,3).
left_node(48,4,5).
right_node(48,4,8).
% node 5: f4 <= 12.5  (F4, bin <= 6)  left -> 6, right -> 7
node(48,5,4,6).
left_node(48,5,6).
right_node(48,5,7).
% node 6 (leaf): class <=50K (0)
leaf_class(48,6,0).
% node 7 (leaf): class <=50K (0)
leaf_class(48,7,0).
% node 8 (leaf): class <=50K (0)
leaf_class(48,8,0).
% node 9: f9 <= 0.5  (F9, bin <= 0)  left -> 10, right -> 15
node(48,9,9,0).
left_node(48,9,10).
right_node(48,9,15).
% node 10: f6 <= 8.5  (F6, bin <= 3)  left -> 11, right -> 14
node(48,10,6,3).
left_node(48,10,11).
right_node(48,10,14).
% node 11: f5 <= 0.5  (F5, bin <= 0)  left -> 12, right -> 13
node(48,11,5,0).
left_node(48,11,12).
right_node(48,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(48,12,0).
% node 13 (leaf): class <=50K (0)
leaf_class(48,13,0).
% node 14 (leaf): class <=50K (0)
leaf_class(48,14,0).
% node 15: f4 <= 12.5  (F4, bin <= 6)  left -> 16, right -> 19
node(48,15,4,6).
left_node(48,15,16).
right_node(48,15,19).
% node 16: f5 <= 1.0  (F5, bin <= 1)  left -> 17, right -> 18
node(48,16,5,1).
left_node(48,16,17).
right_node(48,16,18).
% node 17 (leaf): class <=50K (0)
leaf_class(48,17,0).
% node 18 (leaf): class <=50K (0)
leaf_class(48,18,0).
% node 19: f5 <= 1.0  (F5, bin <= 1)  left -> 20, right -> 21
node(48,19,5,1).
left_node(48,19,20).
right_node(48,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(48,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(48,21,1).
% node 22: f5 <= 1.0  (F5, bin <= 1)  left -> 23, right -> 24
node(48,22,5,1).
left_node(48,22,23).
right_node(48,22,24).
% node 23 (leaf): class <=50K (0)
leaf_class(48,23,0).
% node 24 (leaf): class >50K (1)
leaf_class(48,24,1).
% node 25 (leaf): class >50K (1)
leaf_class(48,25,1).
% node 26: f10 <= 7372.5  (F10, bin <= 20)  left -> 27, right -> 28
node(48,26,10,20).
left_node(48,26,27).
right_node(48,26,28).
% node 27 (leaf): class <=50K (0)
leaf_class(48,27,0).
% node 28 (leaf): class >50K (1)
leaf_class(48,28,1).

% Tree 49
tree(49).
% node 0: f12 <= 41.5  (F12, bin <= 8)  left -> 1, right -> 22
node(49,0,12,8).
left_node(49,0,1).
right_node(49,0,22).
% node 1: f12 <= 32.5  (F12, bin <= 1)  left -> 2, right -> 7
node(49,1,12,1).
left_node(49,1,2).
right_node(49,1,7).
% node 2: f4 <= 12.5  (F4, bin <= 6)  left -> 3, right -> 4
node(49,2,4,6).
left_node(49,2,3).
right_node(49,2,4).
% node 3 (leaf): class <=50K (0)
leaf_class(49,3,0).
% node 4: f7 <= 4.5  (F7, bin <= 3)  left -> 5, right -> 6
node(49,4,7,3).
left_node(49,4,5).
right_node(49,4,6).
% node 5 (leaf): class <=50K (0)
leaf_class(49,5,0).
% node 6 (leaf): class >50K (1)
leaf_class(49,6,1).
% node 7: f7 <= 0.5  (F7, bin <= 0)  left -> 8, right -> 17
node(49,7,7,0).
left_node(49,7,8).
right_node(49,7,17).
% node 8: f10 <= 5095.5  (F10, bin <= 10)  left -> 9, right -> 16
node(49,8,10,10).
left_node(49,8,9).
right_node(49,8,16).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(49,9,1,0).
left_node(49,9,10).
right_node(49,9,11).
% node 10 (leaf): class >50K (1)
leaf_class(49,10,1).
% node 11: f6 <= 8.0  (F6, bin <= 2)  left -> 12, right -> 13
node(49,11,6,2).
left_node(49,11,12).
right_node(49,11,13).
% node 12 (leaf): class <=50K (0)
leaf_class(49,12,0).
% node 13: f3 <= 10.5  (F3, bin <= 4)  left -> 14, right -> 15
node(49,13,3,4).
left_node(49,13,14).
right_node(49,13,15).
% node 14 (leaf): class <=50K (0)
leaf_class(49,14,0).
% node 15 (leaf): class >50K (1)
leaf_class(49,15,1).
% node 16 (leaf): class >50K (1)
leaf_class(49,16,1).
% node 17: f0 <= 28.5  (F0, bin <= 4)  left -> 18, right -> 19
node(49,17,0,4).
left_node(49,17,18).
right_node(49,17,19).
% node 18 (leaf): class <=50K (0)
leaf_class(49,18,0).
% node 19: f10 <= 7073.5  (F10, bin <= 17)  left -> 20, right -> 21
node(49,19,10,17).
left_node(49,19,20).
right_node(49,19,21).
% node 20 (leaf): class <=50K (0)
leaf_class(49,20,0).
% node 21 (leaf): class >50K (1)
leaf_class(49,21,1).
% node 22: f7 <= 0.5  (F7, bin <= 0)  left -> 23, right -> 28
node(49,22,7,0).
left_node(49,22,23).
right_node(49,22,28).
% node 23: f10 <= 5095.5  (F10, bin <= 10)  left -> 24, right -> 27
node(49,23,10,10).
left_node(49,23,24).
right_node(49,23,27).
% node 24: f4 <= 12.5  (F4, bin <= 6)  left -> 25, right -> 26
node(49,24,4,6).
left_node(49,24,25).
right_node(49,24,26).
% node 25 (leaf): class <=50K (0)
leaf_class(49,25,0).
% node 26 (leaf): class >50K (1)
leaf_class(49,26,1).
% node 27 (leaf): class >50K (1)
leaf_class(49,27,1).
% node 28: f10 <= 7073.5  (F10, bin <= 17)  left -> 29, right -> 38
node(49,28,10,17).
left_node(49,28,29).
right_node(49,28,38).
% node 29: f0 <= 27.5  (F0, bin <= 3)  left -> 30, right -> 31
node(49,29,0,3).
left_node(49,29,30).
right_node(49,29,31).
% node 30 (leaf): class <=50K (0)
leaf_class(49,30,0).
% node 31: f11 <= 2377.0  (F11, bin <= 16)  left -> 32, right -> 37
node(49,31,11,16).
left_node(49,31,32).
right_node(49,31,37).
% node 32: f0 <= 41.5  (F0, bin <= 13)  left -> 33, right -> 34
node(49,32,0,13).
left_node(49,32,33).
right_node(49,32,34).
% node 33 (leaf): class <=50K (0)
leaf_class(49,33,0).
% node 34: f3 <= 11.5  (F3, bin <= 5)  left -> 35, right -> 36
node(49,34,3,5).
left_node(49,34,35).
right_node(49,34,36).
% node 35 (leaf): class <=50K (0)
leaf_class(49,35,0).
% node 36 (leaf): class <=50K (0)
leaf_class(49,36,0).
% node 37 (leaf): class >50K (1)
leaf_class(49,37,1).
% node 38 (leaf): class >50K (1)
leaf_class(49,38,1).

% --- Class domain ---
class_idx(0).  % <=50K
class_idx(1).  % >50K
