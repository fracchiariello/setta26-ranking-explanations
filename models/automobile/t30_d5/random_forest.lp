% ============================================================
% random_forest.lp — RF facts for automobile
% 30 trees  |  25 features
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

% Feature 0 (f0): 11 bins  (thresholds: [92.0, 98.5, 102.5, 111.5, 112.5, 116.5, 118.5, 125.0, 138.0, 139.5])
{bin(I,0,B) : B = 0..10} = 1 :- item(I).

% Feature 1 (f1): 12 bins  (thresholds: [8.0, 12.5, 13.0, 13.5, 14.5, 15.0, 15.5, 16.0, 16.5, 18.5, 19.5])
{bin(I,1,B) : B = 0..11} = 1 :- item(I).

% Feature 2 (f2): 2 bins  (thresholds: [0.5])
{bin(I,2,B) : B = 0..1} = 1 :- item(I).

% Feature 4 (f4): 2 bins  (thresholds: [3.0])
{bin(I,4,B) : B = 0..1} = 1 :- item(I).

% Feature 5 (f5): 2 bins  (thresholds: [2.5])
{bin(I,5,B) : B = 0..1} = 1 :- item(I).

% Feature 8 (f8): 16 bins  (thresholds: [94.9000015258789, 95.5, 96.1500015258789, 96.25, 96.4000015258789, 97.25, 99.9000015258789, 100.10000228881836, 100.75, 100.79999923706055, 101.79999923706055, 102.20000076293945, 104.10000228881836, 106.4000015258789, 106.85000228881836])
{bin(I,8,B) : B = 0..15} = 1 :- item(I).

% Feature 9 (f9): 15 bins  (thresholds: [158.75, 162.0, 164.3499984741211, 167.4000015258789, 168.75, 171.9000015258789, 173.29999542236328, 174.4499969482422, 174.60000610351562, 174.6999969482422, 176.70000457763672, 185.60000610351562, 186.6500015258789, 187.25])
{bin(I,9,B) : B = 0..14} = 1 :- item(I).

% Feature 10 (f10): 6 bins  (thresholds: [64.04999923706055, 64.29999923706055, 65.45000076293945, 65.64999771118164, 66.70000076293945])
{bin(I,10,B) : B = 0..5} = 1 :- item(I).

% Feature 11 (f11): 11 bins  (thresholds: [50.35000038146973, 50.39999961853027, 51.79999923706055, 52.45000076293945, 52.69999885559082, 53.79999923706055, 54.0, 54.80000114440918, 55.85000038146973, 56.25])
{bin(I,11,B) : B = 0..10} = 1 :- item(I).

% Feature 12 (f12): 14 bins  (thresholds: [1994.5, 1996.5, 1999.5, 2012.5, 2033.5, 2045.0, 2060.5, 2108.0, 2189.0, 2213.5, 3030.5, 3057.5, 3174.0])
{bin(I,12,B) : B = 0..13} = 1 :- item(I).

% Feature 13 (f13): 2 bins  (thresholds: [2.5])
{bin(I,13,B) : B = 0..1} = 1 :- item(I).

% Feature 14 (f14): 2 bins  (thresholds: [4.5])
{bin(I,14,B) : B = 0..1} = 1 :- item(I).

% Feature 15 (f15): 9 bins  (thresholds: [91.5, 97.5, 105.5, 116.5, 132.0, 148.5, 162.5, 167.5])
{bin(I,15,B) : B = 0..8} = 1 :- item(I).

% Feature 16 (f16): 4 bins  (thresholds: [1.5, 2.0, 4.0])
{bin(I,16,B) : B = 0..3} = 1 :- item(I).

% Feature 17 (f17): 8 bins  (thresholds: [3.180000066757202, 3.2300000190734863, 3.25, 3.2549999952316284, 3.3700000047683716, 3.3899999856948853, 3.5])
{bin(I,17,B) : B = 0..7} = 1 :- item(I).

% Feature 18 (f18): 4 bins  (thresholds: [3.190000057220459, 3.309999942779541, 3.3950001001358032])
{bin(I,18,B) : B = 0..3} = 1 :- item(I).

% Feature 19 (f19): 5 bins  (thresholds: [8.550000190734863, 8.75, 8.900000095367432, 9.150000095367432])
{bin(I,19,B) : B = 0..4} = 1 :- item(I).

% Feature 20 (f20): 11 bins  (thresholds: [69.5, 71.5, 85.0, 98.5, 101.5, 106.0, 111.0, 128.0, 129.0, 141.5])
{bin(I,20,B) : B = 0..10} = 1 :- item(I).

% Feature 21 (f21): 7 bins  (thresholds: [4775.0, 4900.0, 5050.0, 5100.0, 5225.0, 5450.0])
{bin(I,21,B) : B = 0..6} = 1 :- item(I).

% Feature 22 (f22): 9 bins  (thresholds: [19.5, 21.0, 22.5, 24.5, 25.5, 26.5, 27.5, 28.5])
{bin(I,22,B) : B = 0..8} = 1 :- item(I).

% Feature 23 (f23): 4 bins  (thresholds: [30.5, 33.0, 36.5])
{bin(I,23,B) : B = 0..3} = 1 :- item(I).

% Feature 24 (f24): 10 bins  (thresholds: [7673.5, 10496.5, 11146.5, 11397.0, 11572.0, 11769.5, 16960.0, 17689.5, 17909.5])
{bin(I,24,B) : B = 0..9} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f12 <= 2045.0  (F12, bin <= 5)  left -> 1, right -> 4
node(0,0,12,5).
left_node(0,0,1).
right_node(0,0,4).
% node 1: f9 <= 158.75  (F9, bin <= 0)  left -> 2, right -> 3
node(0,1,9,0).
left_node(0,1,2).
right_node(0,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(0,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(0,3,3).
% node 4: f4 <= 3.0  (F4, bin <= 0)  left -> 5, right -> 10
node(0,4,4,0).
left_node(0,4,5).
right_node(0,4,10).
% node 5: f19 <= 8.550000190734863  (F19, bin <= 0)  left -> 6, right -> 7
node(0,5,19,0).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class 3 (5)
leaf_class(0,6,5).
% node 7: f9 <= 171.9000015258789  (F9, bin <= 5)  left -> 8, right -> 9
node(0,7,9,5).
left_node(0,7,8).
right_node(0,7,9).
% node 8 (leaf): class 3 (5)
leaf_class(0,8,5).
% node 9 (leaf): class 2 (4)
leaf_class(0,9,4).
% node 10: f8 <= 101.79999923706055  (F8, bin <= 10)  left -> 11, right -> 14
node(0,10,8,10).
left_node(0,10,11).
right_node(0,10,14).
% node 11: f19 <= 8.900000095367432  (F19, bin <= 2)  left -> 12, right -> 13
node(0,11,19,2).
left_node(0,11,12).
right_node(0,11,13).
% node 12 (leaf): class 0 (2)
leaf_class(0,12,2).
% node 13 (leaf): class 0 (2)
leaf_class(0,13,2).
% node 14: f24 <= 16960.0  (F24, bin <= 6)  left -> 15, right -> 16
node(0,14,24,6).
left_node(0,14,15).
right_node(0,14,16).
% node 15 (leaf): class -1 (1)
leaf_class(0,15,1).
% node 16 (leaf): class 0 (2)
leaf_class(0,16,2).

% Tree 1
tree(1).
% node 0: f17 <= 3.2549999952316284  (F17, bin <= 3)  left -> 1, right -> 8
node(1,0,17,3).
left_node(1,0,1).
right_node(1,0,8).
% node 1: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 2, right -> 5
node(1,1,10,1).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f11 <= 53.79999923706055  (F11, bin <= 5)  left -> 3, right -> 4
node(1,2,11,5).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class 1 (3)
leaf_class(1,3,3).
% node 4 (leaf): class 1 (3)
leaf_class(1,4,3).
% node 5: f0 <= 118.5  (F0, bin <= 6)  left -> 6, right -> 7
node(1,5,0,6).
left_node(1,5,6).
right_node(1,5,7).
% node 6 (leaf): class 0 (2)
leaf_class(1,6,2).
% node 7 (leaf): class 2 (4)
leaf_class(1,7,4).
% node 8: f1 <= 13.5  (F1, bin <= 3)  left -> 9, right -> 14
node(1,8,1,3).
left_node(1,8,9).
right_node(1,8,14).
% node 9: f5 <= 2.5  (F5, bin <= 0)  left -> 10, right -> 11
node(1,9,5,0).
left_node(1,9,10).
right_node(1,9,11).
% node 10 (leaf): class 3 (5)
leaf_class(1,10,5).
% node 11: f8 <= 106.4000015258789  (F8, bin <= 13)  left -> 12, right -> 13
node(1,11,8,13).
left_node(1,11,12).
right_node(1,11,13).
% node 12 (leaf): class 0 (2)
leaf_class(1,12,2).
% node 13 (leaf): class 0 (2)
leaf_class(1,13,2).
% node 14: f8 <= 100.75  (F8, bin <= 8)  left -> 15, right -> 16
node(1,14,8,8).
left_node(1,14,15).
right_node(1,14,16).
% node 15 (leaf): class 2 (4)
leaf_class(1,15,4).
% node 16 (leaf): class -1 (1)
leaf_class(1,16,1).

% Tree 2
tree(2).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(2,0,10,1).
left_node(2,0,1).
right_node(2,0,4).
% node 1: f5 <= 2.5  (F5, bin <= 0)  left -> 2, right -> 3
node(2,1,5,0).
left_node(2,1,2).
right_node(2,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(2,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(2,3,3).
% node 4: f0 <= 102.5  (F0, bin <= 2)  left -> 5, right -> 8
node(2,4,0,2).
left_node(2,4,5).
right_node(2,4,8).
% node 5: f0 <= 92.0  (F0, bin <= 0)  left -> 6, right -> 7
node(2,5,0,0).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class 0 (2)
leaf_class(2,6,2).
% node 7 (leaf): class -1 (1)
leaf_class(2,7,1).
% node 8: f15 <= 148.5  (F15, bin <= 5)  left -> 9, right -> 14
node(2,8,15,5).
left_node(2,8,9).
right_node(2,8,14).
% node 9: f19 <= 8.75  (F19, bin <= 1)  left -> 10, right -> 11
node(2,9,19,1).
left_node(2,9,10).
right_node(2,9,11).
% node 10 (leaf): class 1 (3)
leaf_class(2,10,3).
% node 11: f10 <= 65.64999771118164  (F10, bin <= 3)  left -> 12, right -> 13
node(2,11,10,3).
left_node(2,11,12).
right_node(2,11,13).
% node 12 (leaf): class 2 (4)
leaf_class(2,12,4).
% node 13 (leaf): class 2 (4)
leaf_class(2,13,4).
% node 14 (leaf): class 3 (5)
leaf_class(2,14,5).

% Tree 3
tree(3).
% node 0: f9 <= 173.29999542236328  (F9, bin <= 6)  left -> 1, right -> 10
node(3,0,9,6).
left_node(3,0,1).
right_node(3,0,10).
% node 1: f11 <= 50.39999961853027  (F11, bin <= 1)  left -> 2, right -> 3
node(3,1,11,1).
left_node(3,1,2).
right_node(3,1,3).
% node 2 (leaf): class 3 (5)
leaf_class(3,2,5).
% node 3: f11 <= 52.69999885559082  (F11, bin <= 4)  left -> 4, right -> 7
node(3,3,11,4).
left_node(3,3,4).
right_node(3,3,7).
% node 4: f23 <= 30.5  (F23, bin <= 0)  left -> 5, right -> 6
node(3,4,23,0).
left_node(3,4,5).
right_node(3,4,6).
% node 5 (leaf): class 1 (3)
leaf_class(3,5,3).
% node 6 (leaf): class 1 (3)
leaf_class(3,6,3).
% node 7: f23 <= 36.5  (F23, bin <= 2)  left -> 8, right -> 9
node(3,7,23,2).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(3,8,2).
% node 9 (leaf): class 1 (3)
leaf_class(3,9,3).
% node 10: f1 <= 18.5  (F1, bin <= 9)  left -> 11, right -> 16
node(3,10,1,9).
left_node(3,10,11).
right_node(3,10,16).
% node 11: f20 <= 101.5  (F20, bin <= 4)  left -> 12, right -> 15
node(3,11,20,4).
left_node(3,11,12).
right_node(3,11,15).
% node 12: f8 <= 104.10000228881836  (F8, bin <= 12)  left -> 13, right -> 14
node(3,12,8,12).
left_node(3,12,13).
right_node(3,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(3,13,2).
% node 14 (leaf): class 0 (2)
leaf_class(3,14,2).
% node 15 (leaf): class 2 (4)
leaf_class(3,15,4).
% node 16 (leaf): class -1 (1)
leaf_class(3,16,1).

% Tree 4
tree(4).
% node 0: f12 <= 1996.5  (F12, bin <= 1)  left -> 1, right -> 2
node(4,0,12,1).
left_node(4,0,1).
right_node(4,0,2).
% node 1 (leaf): class 1 (3)
leaf_class(4,1,3).
% node 2: f4 <= 3.0  (F4, bin <= 0)  left -> 3, right -> 8
node(4,2,4,0).
left_node(4,2,3).
right_node(4,2,8).
% node 3: f0 <= 138.0  (F0, bin <= 8)  left -> 4, right -> 7
node(4,3,0,8).
left_node(4,3,4).
right_node(4,3,7).
% node 4: f8 <= 96.25  (F8, bin <= 3)  left -> 5, right -> 6
node(4,4,8,3).
left_node(4,4,5).
right_node(4,4,6).
% node 5 (leaf): class 3 (5)
leaf_class(4,5,5).
% node 6 (leaf): class 2 (4)
leaf_class(4,6,4).
% node 7 (leaf): class 3 (5)
leaf_class(4,7,5).
% node 8: f16 <= 2.0  (F16, bin <= 1)  left -> 9, right -> 10
node(4,8,16,1).
left_node(4,8,9).
right_node(4,8,10).
% node 9 (leaf): class 0 (2)
leaf_class(4,9,2).
% node 10: f9 <= 176.70000457763672  (F9, bin <= 10)  left -> 11, right -> 12
node(4,10,9,10).
left_node(4,10,11).
right_node(4,10,12).
% node 11 (leaf): class 2 (4)
leaf_class(4,11,4).
% node 12: f1 <= 15.0  (F1, bin <= 5)  left -> 13, right -> 14
node(4,12,1,5).
left_node(4,12,13).
right_node(4,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(4,13,2).
% node 14 (leaf): class -1 (1)
leaf_class(4,14,1).

% Tree 5
tree(5).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(5,0,10,1).
left_node(5,0,1).
right_node(5,0,4).
% node 1: f12 <= 1999.5  (F12, bin <= 2)  left -> 2, right -> 3
node(5,1,12,2).
left_node(5,1,2).
right_node(5,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(5,2,3).
% node 3 (leaf): class 0 (2)
leaf_class(5,3,2).
% node 4: f8 <= 102.20000076293945  (F8, bin <= 11)  left -> 5, right -> 10
node(5,4,8,11).
left_node(5,4,5).
right_node(5,4,10).
% node 5: f11 <= 51.79999923706055  (F11, bin <= 2)  left -> 6, right -> 7
node(5,5,11,2).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class 3 (5)
leaf_class(5,6,5).
% node 7: f24 <= 11397.0  (F24, bin <= 3)  left -> 8, right -> 9
node(5,7,24,3).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(5,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(5,9,4).
% node 10: f22 <= 21.0  (F22, bin <= 1)  left -> 11, right -> 12
node(5,10,22,1).
left_node(5,10,11).
right_node(5,10,12).
% node 11 (leaf): class 1 (3)
leaf_class(5,11,3).
% node 12 (leaf): class -1 (1)
leaf_class(5,12,1).

% Tree 6
tree(6).
% node 0: f4 <= 3.0  (F4, bin <= 0)  left -> 1, right -> 6
node(6,0,4,0).
left_node(6,0,1).
right_node(6,0,6).
% node 1: f12 <= 2189.0  (F12, bin <= 8)  left -> 2, right -> 3
node(6,1,12,8).
left_node(6,1,2).
right_node(6,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(6,2,3).
% node 3: f18 <= 3.3950001001358032  (F18, bin <= 2)  left -> 4, right -> 5
node(6,3,18,2).
left_node(6,3,4).
right_node(6,3,5).
% node 4 (leaf): class 3 (5)
leaf_class(6,4,5).
% node 5 (leaf): class 2 (4)
leaf_class(6,5,4).
% node 6: f24 <= 7673.5  (F24, bin <= 0)  left -> 7, right -> 8
node(6,6,24,0).
left_node(6,6,7).
right_node(6,6,8).
% node 7 (leaf): class 1 (3)
leaf_class(6,7,3).
% node 8: f0 <= 112.5  (F0, bin <= 4)  left -> 9, right -> 12
node(6,8,0,4).
left_node(6,8,9).
right_node(6,8,12).
% node 9: f24 <= 10496.5  (F24, bin <= 1)  left -> 10, right -> 11
node(6,9,24,1).
left_node(6,9,10).
right_node(6,9,11).
% node 10 (leaf): class 0 (2)
leaf_class(6,10,2).
% node 11 (leaf): class -1 (1)
leaf_class(6,11,1).
% node 12 (leaf): class 0 (2)
leaf_class(6,12,2).

% Tree 7
tree(7).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(7,0,10,1).
left_node(7,0,1).
right_node(7,0,4).
% node 1: f21 <= 5100.0  (F21, bin <= 3)  left -> 2, right -> 3
node(7,1,21,3).
left_node(7,1,2).
right_node(7,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(7,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(7,3,3).
% node 4: f0 <= 98.5  (F0, bin <= 1)  left -> 5, right -> 6
node(7,4,0,1).
left_node(7,4,5).
right_node(7,4,6).
% node 5 (leaf): class -1 (1)
leaf_class(7,5,1).
% node 6: f12 <= 3057.5  (F12, bin <= 11)  left -> 7, right -> 12
node(7,6,12,11).
left_node(7,6,7).
right_node(7,6,12).
% node 7: f22 <= 19.5  (F22, bin <= 0)  left -> 8, right -> 9
node(7,7,22,0).
left_node(7,7,8).
right_node(7,7,9).
% node 8 (leaf): class 3 (5)
leaf_class(7,8,5).
% node 9: f22 <= 24.5  (F22, bin <= 3)  left -> 10, right -> 11
node(7,9,22,3).
left_node(7,9,10).
right_node(7,9,11).
% node 10 (leaf): class 2 (4)
leaf_class(7,10,4).
% node 11 (leaf): class 0 (2)
leaf_class(7,11,2).
% node 12 (leaf): class 0 (2)
leaf_class(7,12,2).

% Tree 8
tree(8).
% node 0: f15 <= 105.5  (F15, bin <= 2)  left -> 1, right -> 6
node(8,0,15,2).
left_node(8,0,1).
right_node(8,0,6).
% node 1: f4 <= 3.0  (F4, bin <= 0)  left -> 2, right -> 5
node(8,1,4,0).
left_node(8,1,2).
right_node(8,1,5).
% node 2: f0 <= 118.5  (F0, bin <= 6)  left -> 3, right -> 4
node(8,2,0,6).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class 1 (3)
leaf_class(8,3,3).
% node 4 (leaf): class 1 (3)
leaf_class(8,4,3).
% node 5 (leaf): class 0 (2)
leaf_class(8,5,2).
% node 6: f8 <= 96.1500015258789  (F8, bin <= 2)  left -> 7, right -> 8
node(8,6,8,2).
left_node(8,6,7).
right_node(8,6,8).
% node 7 (leaf): class 3 (5)
leaf_class(8,7,5).
% node 8: f14 <= 4.5  (F14, bin <= 0)  left -> 9, right -> 14
node(8,8,14,0).
left_node(8,8,9).
right_node(8,8,14).
% node 9: f4 <= 3.0  (F4, bin <= 0)  left -> 10, right -> 11
node(8,9,4,0).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class 2 (4)
leaf_class(8,10,4).
% node 11: f17 <= 3.3700000047683716  (F17, bin <= 4)  left -> 12, right -> 13
node(8,11,17,4).
left_node(8,11,12).
right_node(8,11,13).
% node 12 (leaf): class -1 (1)
leaf_class(8,12,1).
% node 13 (leaf): class 0 (2)
leaf_class(8,13,2).
% node 14 (leaf): class 1 (3)
leaf_class(8,14,3).

% Tree 9
tree(9).
% node 0: f9 <= 167.4000015258789  (F9, bin <= 3)  left -> 1, right -> 4
node(9,0,9,3).
left_node(9,0,1).
right_node(9,0,4).
% node 1: f15 <= 91.5  (F15, bin <= 0)  left -> 2, right -> 3
node(9,1,15,0).
left_node(9,1,2).
right_node(9,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(9,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(9,3,3).
% node 4: f24 <= 11769.5  (F24, bin <= 5)  left -> 5, right -> 8
node(9,4,24,5).
left_node(9,4,5).
right_node(9,4,8).
% node 5: f8 <= 97.25  (F8, bin <= 5)  left -> 6, right -> 7
node(9,5,8,5).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class 0 (2)
leaf_class(9,6,2).
% node 7 (leaf): class -1 (1)
leaf_class(9,7,1).
% node 8: f9 <= 174.6999969482422  (F9, bin <= 9)  left -> 9, right -> 10
node(9,8,9,9).
left_node(9,8,9).
right_node(9,8,10).
% node 9 (leaf): class 3 (5)
leaf_class(9,9,5).
% node 10: f11 <= 56.25  (F11, bin <= 9)  left -> 11, right -> 14
node(9,10,11,9).
left_node(9,10,11).
right_node(9,10,14).
% node 11: f24 <= 17689.5  (F24, bin <= 7)  left -> 12, right -> 13
node(9,11,24,7).
left_node(9,11,12).
right_node(9,11,13).
% node 12 (leaf): class 2 (4)
leaf_class(9,12,4).
% node 13 (leaf): class 1 (3)
leaf_class(9,13,3).
% node 14 (leaf): class 0 (2)
leaf_class(9,14,2).

% Tree 10
tree(10).
% node 0: f15 <= 105.5  (F15, bin <= 2)  left -> 1, right -> 6
node(10,0,15,2).
left_node(10,0,1).
right_node(10,0,6).
% node 1: f18 <= 3.190000057220459  (F18, bin <= 0)  left -> 2, right -> 3
node(10,1,18,0).
left_node(10,1,2).
right_node(10,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(10,2,3).
% node 3: f0 <= 125.0  (F0, bin <= 7)  left -> 4, right -> 5
node(10,3,0,7).
left_node(10,3,4).
right_node(10,3,5).
% node 4 (leaf): class 1 (3)
leaf_class(10,4,3).
% node 5 (leaf): class 2 (4)
leaf_class(10,5,4).
% node 6: f8 <= 100.10000228881836  (F8, bin <= 7)  left -> 7, right -> 12
node(10,6,8,7).
left_node(10,6,7).
right_node(10,6,12).
% node 7: f16 <= 4.0  (F16, bin <= 2)  left -> 8, right -> 9
node(10,7,16,2).
left_node(10,7,8).
right_node(10,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(10,8,2).
% node 9: f5 <= 2.5  (F5, bin <= 0)  left -> 10, right -> 11
node(10,9,5,0).
left_node(10,9,10).
right_node(10,9,11).
% node 10 (leaf): class 3 (5)
leaf_class(10,10,5).
% node 11 (leaf): class 2 (4)
leaf_class(10,11,4).
% node 12: f11 <= 55.85000038146973  (F11, bin <= 8)  left -> 13, right -> 14
node(10,12,11,8).
left_node(10,12,13).
right_node(10,12,14).
% node 13 (leaf): class -1 (1)
leaf_class(10,13,1).
% node 14 (leaf): class 0 (2)
leaf_class(10,14,2).

% Tree 11
tree(11).
% node 0: f4 <= 3.0  (F4, bin <= 0)  left -> 1, right -> 8
node(11,0,4,0).
left_node(11,0,1).
right_node(11,0,8).
% node 1: f0 <= 139.5  (F0, bin <= 9)  left -> 2, right -> 7
node(11,1,0,9).
left_node(11,1,2).
right_node(11,1,7).
% node 2: f1 <= 14.5  (F1, bin <= 4)  left -> 3, right -> 6
node(11,2,1,4).
left_node(11,2,3).
right_node(11,2,6).
% node 3: f20 <= 85.0  (F20, bin <= 2)  left -> 4, right -> 5
node(11,3,20,2).
left_node(11,3,4).
right_node(11,3,5).
% node 4 (leaf): class 1 (3)
leaf_class(11,4,3).
% node 5 (leaf): class 1 (3)
leaf_class(11,5,3).
% node 6 (leaf): class 2 (4)
leaf_class(11,6,4).
% node 7 (leaf): class 3 (5)
leaf_class(11,7,5).
% node 8: f1 <= 19.5  (F1, bin <= 10)  left -> 9, right -> 16
node(11,8,1,10).
left_node(11,8,9).
right_node(11,8,16).
% node 9: f21 <= 4900.0  (F21, bin <= 1)  left -> 10, right -> 13
node(11,9,21,1).
left_node(11,9,10).
right_node(11,9,13).
% node 10: f15 <= 116.5  (F15, bin <= 3)  left -> 11, right -> 12
node(11,10,15,3).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class 0 (2)
leaf_class(11,11,2).
% node 12 (leaf): class 0 (2)
leaf_class(11,12,2).
% node 13: f17 <= 3.3899999856948853  (F17, bin <= 5)  left -> 14, right -> 15
node(11,13,17,5).
left_node(11,13,14).
right_node(11,13,15).
% node 14 (leaf): class 1 (3)
leaf_class(11,14,3).
% node 15 (leaf): class 0 (2)
leaf_class(11,15,2).
% node 16 (leaf): class -1 (1)
leaf_class(11,16,1).

% Tree 12
tree(12).
% node 0: f20 <= 71.5  (F20, bin <= 1)  left -> 1, right -> 4
node(12,0,20,1).
left_node(12,0,1).
right_node(12,0,4).
% node 1: f15 <= 91.5  (F15, bin <= 0)  left -> 2, right -> 3
node(12,1,15,0).
left_node(12,1,2).
right_node(12,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(12,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(12,3,3).
% node 4: f20 <= 101.5  (F20, bin <= 4)  left -> 5, right -> 10
node(12,4,20,4).
left_node(12,4,5).
right_node(12,4,10).
% node 5: f1 <= 14.5  (F1, bin <= 4)  left -> 6, right -> 9
node(12,5,1,4).
left_node(12,5,6).
right_node(12,5,9).
% node 6: f24 <= 11146.5  (F24, bin <= 2)  left -> 7, right -> 8
node(12,6,24,2).
left_node(12,6,7).
right_node(12,6,8).
% node 7 (leaf): class 0 (2)
leaf_class(12,7,2).
% node 8 (leaf): class 0 (2)
leaf_class(12,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(12,9,4).
% node 10: f9 <= 174.4499969482422  (F9, bin <= 7)  left -> 11, right -> 12
node(12,10,9,7).
left_node(12,10,11).
right_node(12,10,12).
% node 11 (leaf): class 3 (5)
leaf_class(12,11,5).
% node 12: f15 <= 162.5  (F15, bin <= 6)  left -> 13, right -> 16
node(12,12,15,6).
left_node(12,12,13).
right_node(12,12,16).
% node 13: f24 <= 17909.5  (F24, bin <= 8)  left -> 14, right -> 15
node(12,13,24,8).
left_node(12,13,14).
right_node(12,13,15).
% node 14 (leaf): class 2 (4)
leaf_class(12,14,4).
% node 15 (leaf): class -1 (1)
leaf_class(12,15,1).
% node 16 (leaf): class 0 (2)
leaf_class(12,16,2).

% Tree 13
tree(13).
% node 0: f8 <= 99.9000015258789  (F8, bin <= 6)  left -> 1, right -> 10
node(13,0,8,6).
left_node(13,0,1).
right_node(13,0,10).
% node 1: f9 <= 168.75  (F9, bin <= 4)  left -> 2, right -> 5
node(13,1,9,4).
left_node(13,1,2).
right_node(13,1,5).
% node 2: f12 <= 1994.5  (F12, bin <= 0)  left -> 3, right -> 4
node(13,2,12,0).
left_node(13,2,3).
right_node(13,2,4).
% node 3 (leaf): class 1 (3)
leaf_class(13,3,3).
% node 4 (leaf): class 1 (3)
leaf_class(13,4,3).
% node 5: f11 <= 51.79999923706055  (F11, bin <= 2)  left -> 6, right -> 7
node(13,5,11,2).
left_node(13,5,6).
right_node(13,5,7).
% node 6 (leaf): class 3 (5)
leaf_class(13,6,5).
% node 7: f16 <= 4.0  (F16, bin <= 2)  left -> 8, right -> 9
node(13,7,16,2).
left_node(13,7,8).
right_node(13,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(13,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(13,9,4).
% node 10: f15 <= 132.0  (F15, bin <= 4)  left -> 11, right -> 12
node(13,10,15,4).
left_node(13,10,11).
right_node(13,10,12).
% node 11 (leaf): class -1 (1)
leaf_class(13,11,1).
% node 12: f12 <= 3174.0  (F12, bin <= 12)  left -> 13, right -> 14
node(13,12,12,12).
left_node(13,12,13).
right_node(13,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(13,13,2).
% node 14 (leaf): class 0 (2)
leaf_class(13,14,2).

% Tree 14
tree(14).
% node 0: f17 <= 3.180000066757202  (F17, bin <= 0)  left -> 1, right -> 6
node(14,0,17,0).
left_node(14,0,1).
right_node(14,0,6).
% node 1: f12 <= 2213.5  (F12, bin <= 9)  left -> 2, right -> 5
node(14,1,12,9).
left_node(14,1,2).
right_node(14,1,5).
% node 2: f9 <= 164.3499984741211  (F9, bin <= 2)  left -> 3, right -> 4
node(14,2,9,2).
left_node(14,2,3).
right_node(14,2,4).
% node 3 (leaf): class 1 (3)
leaf_class(14,3,3).
% node 4 (leaf): class 1 (3)
leaf_class(14,4,3).
% node 5 (leaf): class 0 (2)
leaf_class(14,5,2).
% node 6: f21 <= 5050.0  (F21, bin <= 2)  left -> 7, right -> 12
node(14,6,21,2).
left_node(14,6,7).
right_node(14,6,12).
% node 7: f4 <= 3.0  (F4, bin <= 0)  left -> 8, right -> 9
node(14,7,4,0).
left_node(14,7,8).
right_node(14,7,9).
% node 8 (leaf): class 2 (4)
leaf_class(14,8,4).
% node 9: f21 <= 4775.0  (F21, bin <= 0)  left -> 10, right -> 11
node(14,9,21,0).
left_node(14,9,10).
right_node(14,9,11).
% node 10 (leaf): class 0 (2)
leaf_class(14,10,2).
% node 11 (leaf): class 0 (2)
leaf_class(14,11,2).
% node 12: f9 <= 185.60000610351562  (F9, bin <= 11)  left -> 13, right -> 14
node(14,12,9,11).
left_node(14,12,13).
right_node(14,12,14).
% node 13 (leaf): class 2 (4)
leaf_class(14,13,4).
% node 14 (leaf): class -1 (1)
leaf_class(14,14,1).

% Tree 15
tree(15).
% node 0: f12 <= 2033.5  (F12, bin <= 4)  left -> 1, right -> 2
node(15,0,12,4).
left_node(15,0,1).
right_node(15,0,2).
% node 1 (leaf): class 1 (3)
leaf_class(15,1,3).
% node 2: f22 <= 26.5  (F22, bin <= 5)  left -> 3, right -> 14
node(15,2,22,5).
left_node(15,2,3).
right_node(15,2,14).
% node 3: f4 <= 3.0  (F4, bin <= 0)  left -> 4, right -> 9
node(15,3,4,0).
left_node(15,3,4).
right_node(15,3,9).
% node 4: f24 <= 11572.0  (F24, bin <= 4)  left -> 5, right -> 6
node(15,4,24,4).
left_node(15,4,5).
right_node(15,4,6).
% node 5 (leaf): class 1 (3)
leaf_class(15,5,3).
% node 6: f0 <= 138.0  (F0, bin <= 8)  left -> 7, right -> 8
node(15,6,0,8).
left_node(15,6,7).
right_node(15,6,8).
% node 7 (leaf): class 3 (5)
leaf_class(15,7,5).
% node 8 (leaf): class 3 (5)
leaf_class(15,8,5).
% node 9: f17 <= 3.3899999856948853  (F17, bin <= 5)  left -> 10, right -> 11
node(15,9,17,5).
left_node(15,9,10).
right_node(15,9,11).
% node 10 (leaf): class 1 (3)
leaf_class(15,10,3).
% node 11: f0 <= 111.5  (F0, bin <= 3)  left -> 12, right -> 13
node(15,11,0,3).
left_node(15,11,12).
right_node(15,11,13).
% node 12 (leaf): class -1 (1)
leaf_class(15,12,1).
% node 13 (leaf): class 0 (2)
leaf_class(15,13,2).
% node 14: f11 <= 54.0  (F11, bin <= 6)  left -> 15, right -> 16
node(15,14,11,6).
left_node(15,14,15).
right_node(15,14,16).
% node 15 (leaf): class 0 (2)
leaf_class(15,15,2).
% node 16 (leaf): class 0 (2)
leaf_class(15,16,2).

% Tree 16
tree(16).
% node 0: f4 <= 3.0  (F4, bin <= 0)  left -> 1, right -> 6
node(16,0,4,0).
left_node(16,0,1).
right_node(16,0,6).
% node 1: f16 <= 1.5  (F16, bin <= 0)  left -> 2, right -> 3
node(16,1,16,0).
left_node(16,1,2).
right_node(16,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(16,2,3).
% node 3: f20 <= 128.0  (F20, bin <= 7)  left -> 4, right -> 5
node(16,3,20,7).
left_node(16,3,4).
right_node(16,3,5).
% node 4 (leaf): class 2 (4)
leaf_class(16,4,4).
% node 5 (leaf): class 3 (5)
leaf_class(16,5,5).
% node 6: f17 <= 3.2300000190734863  (F17, bin <= 1)  left -> 7, right -> 10
node(16,6,17,1).
left_node(16,6,7).
right_node(16,6,10).
% node 7: f10 <= 65.45000076293945  (F10, bin <= 2)  left -> 8, right -> 9
node(16,7,10,2).
left_node(16,7,8).
right_node(16,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(16,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(16,9,4).
% node 10: f17 <= 3.5  (F17, bin <= 6)  left -> 11, right -> 12
node(16,10,17,6).
left_node(16,10,11).
right_node(16,10,12).
% node 11 (leaf): class 0 (2)
leaf_class(16,11,2).
% node 12 (leaf): class 0 (2)
leaf_class(16,12,2).

% Tree 17
tree(17).
% node 0: f8 <= 96.4000015258789  (F8, bin <= 4)  left -> 1, right -> 8
node(17,0,8,4).
left_node(17,0,1).
right_node(17,0,8).
% node 1: f10 <= 64.04999923706055  (F10, bin <= 0)  left -> 2, right -> 5
node(17,1,10,0).
left_node(17,1,2).
right_node(17,1,5).
% node 2: f9 <= 162.0  (F9, bin <= 1)  left -> 3, right -> 4
node(17,2,9,1).
left_node(17,2,3).
right_node(17,2,4).
% node 3 (leaf): class 1 (3)
leaf_class(17,3,3).
% node 4 (leaf): class 1 (3)
leaf_class(17,4,3).
% node 5: f20 <= 106.0  (F20, bin <= 5)  left -> 6, right -> 7
node(17,5,20,5).
left_node(17,5,6).
right_node(17,5,7).
% node 6 (leaf): class 2 (4)
leaf_class(17,6,4).
% node 7 (leaf): class 3 (5)
leaf_class(17,7,5).
% node 8: f17 <= 3.3700000047683716  (F17, bin <= 4)  left -> 9, right -> 10
node(17,8,17,4).
left_node(17,8,9).
right_node(17,8,10).
% node 9 (leaf): class -1 (1)
leaf_class(17,9,1).
% node 10: f1 <= 16.0  (F1, bin <= 7)  left -> 11, right -> 14
node(17,10,1,7).
left_node(17,10,11).
right_node(17,10,14).
% node 11: f8 <= 100.79999923706055  (F8, bin <= 9)  left -> 12, right -> 13
node(17,11,8,9).
left_node(17,11,12).
right_node(17,11,13).
% node 12 (leaf): class 0 (2)
leaf_class(17,12,2).
% node 13 (leaf): class 0 (2)
leaf_class(17,13,2).
% node 14 (leaf): class 2 (4)
leaf_class(17,14,4).

% Tree 18
tree(18).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(18,0,10,1).
left_node(18,0,1).
right_node(18,0,4).
% node 1: f23 <= 33.0  (F23, bin <= 1)  left -> 2, right -> 3
node(18,1,23,1).
left_node(18,1,2).
right_node(18,1,3).
% node 2 (leaf): class 0 (2)
leaf_class(18,2,2).
% node 3 (leaf): class 1 (3)
leaf_class(18,3,3).
% node 4: f9 <= 187.25  (F9, bin <= 13)  left -> 5, right -> 14
node(18,4,9,13).
left_node(18,4,5).
right_node(18,4,14).
% node 5: f15 <= 167.5  (F15, bin <= 7)  left -> 6, right -> 13
node(18,5,15,7).
left_node(18,5,6).
right_node(18,5,13).
% node 6: f16 <= 4.0  (F16, bin <= 2)  left -> 7, right -> 10
node(18,6,16,2).
left_node(18,6,7).
right_node(18,6,10).
% node 7: f22 <= 27.5  (F22, bin <= 6)  left -> 8, right -> 9
node(18,7,22,6).
left_node(18,7,8).
right_node(18,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(18,8,2).
% node 9 (leaf): class 0 (2)
leaf_class(18,9,2).
% node 10: f1 <= 16.5  (F1, bin <= 8)  left -> 11, right -> 12
node(18,10,1,8).
left_node(18,10,11).
right_node(18,10,12).
% node 11 (leaf): class 0 (2)
leaf_class(18,11,2).
% node 12 (leaf): class 2 (4)
leaf_class(18,12,4).
% node 13 (leaf): class 3 (5)
leaf_class(18,13,5).
% node 14 (leaf): class -1 (1)
leaf_class(18,14,1).

% Tree 19
tree(19).
% node 0: f8 <= 95.5  (F8, bin <= 1)  left -> 1, right -> 4
node(19,0,8,1).
left_node(19,0,1).
right_node(19,0,4).
% node 1: f20 <= 71.5  (F20, bin <= 1)  left -> 2, right -> 3
node(19,1,20,1).
left_node(19,1,2).
right_node(19,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(19,2,3).
% node 3 (leaf): class 3 (5)
leaf_class(19,3,5).
% node 4: f22 <= 26.5  (F22, bin <= 5)  left -> 5, right -> 12
node(19,4,22,5).
left_node(19,4,5).
right_node(19,4,12).
% node 5: f11 <= 56.25  (F11, bin <= 9)  left -> 6, right -> 11
node(19,5,11,9).
left_node(19,5,6).
right_node(19,5,11).
% node 6: f9 <= 186.6500015258789  (F9, bin <= 12)  left -> 7, right -> 10
node(19,6,9,12).
left_node(19,6,7).
right_node(19,6,10).
% node 7: f19 <= 9.150000095367432  (F19, bin <= 3)  left -> 8, right -> 9
node(19,7,19,3).
left_node(19,7,8).
right_node(19,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(19,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(19,9,4).
% node 10 (leaf): class -1 (1)
leaf_class(19,10,1).
% node 11 (leaf): class -1 (1)
leaf_class(19,11,1).
% node 12: f11 <= 54.80000114440918  (F11, bin <= 7)  left -> 13, right -> 14
node(19,12,11,7).
left_node(19,12,13).
right_node(19,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(19,13,2).
% node 14 (leaf): class 0 (2)
leaf_class(19,14,2).

% Tree 20
tree(20).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(20,0,10,1).
left_node(20,0,1).
right_node(20,0,4).
% node 1: f15 <= 97.5  (F15, bin <= 1)  left -> 2, right -> 3
node(20,1,15,1).
left_node(20,1,2).
right_node(20,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(20,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(20,3,3).
% node 4: f20 <= 129.0  (F20, bin <= 8)  left -> 5, right -> 10
node(20,4,20,8).
left_node(20,4,5).
right_node(20,4,10).
% node 5: f0 <= 98.5  (F0, bin <= 1)  left -> 6, right -> 7
node(20,5,0,1).
left_node(20,5,6).
right_node(20,5,7).
% node 6 (leaf): class -1 (1)
leaf_class(20,6,1).
% node 7: f0 <= 118.5  (F0, bin <= 6)  left -> 8, right -> 9
node(20,7,0,6).
left_node(20,7,8).
right_node(20,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(20,8,2).
% node 9 (leaf): class 2 (4)
leaf_class(20,9,4).
% node 10: f12 <= 3030.5  (F12, bin <= 10)  left -> 11, right -> 12
node(20,10,12,10).
left_node(20,10,11).
right_node(20,10,12).
% node 11 (leaf): class 3 (5)
leaf_class(20,11,5).
% node 12 (leaf): class -1 (1)
leaf_class(20,12,1).

% Tree 21
tree(21).
% node 0: f8 <= 106.85000228881836  (F8, bin <= 14)  left -> 1, right -> 12
node(21,0,8,14).
left_node(21,0,1).
right_node(21,0,12).
% node 1: f20 <= 141.5  (F20, bin <= 9)  left -> 2, right -> 11
node(21,1,20,9).
left_node(21,1,2).
right_node(21,1,11).
% node 2: f0 <= 116.5  (F0, bin <= 5)  left -> 3, right -> 8
node(21,2,0,5).
left_node(21,2,3).
right_node(21,2,8).
% node 3: f5 <= 2.5  (F5, bin <= 0)  left -> 4, right -> 5
node(21,3,5,0).
left_node(21,3,4).
right_node(21,3,5).
% node 4 (leaf): class 2 (4)
leaf_class(21,4,4).
% node 5: f1 <= 13.0  (F1, bin <= 2)  left -> 6, right -> 7
node(21,5,1,2).
left_node(21,5,6).
right_node(21,5,7).
% node 6 (leaf): class 0 (2)
leaf_class(21,6,2).
% node 7 (leaf): class 0 (2)
leaf_class(21,7,2).
% node 8: f22 <= 24.5  (F22, bin <= 3)  left -> 9, right -> 10
node(21,8,22,3).
left_node(21,8,9).
right_node(21,8,10).
% node 9 (leaf): class 2 (4)
leaf_class(21,9,4).
% node 10 (leaf): class 1 (3)
leaf_class(21,10,3).
% node 11 (leaf): class 3 (5)
leaf_class(21,11,5).
% node 12 (leaf): class 0 (2)
leaf_class(21,12,2).

% Tree 22
tree(22).
% node 0: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 1, right -> 4
node(22,0,10,1).
left_node(22,0,1).
right_node(22,0,4).
% node 1: f0 <= 116.5  (F0, bin <= 5)  left -> 2, right -> 3
node(22,1,0,5).
left_node(22,1,2).
right_node(22,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(22,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(22,3,3).
% node 4: f11 <= 52.45000076293945  (F11, bin <= 3)  left -> 5, right -> 6
node(22,4,11,3).
left_node(22,4,5).
right_node(22,4,6).
% node 5 (leaf): class 3 (5)
leaf_class(22,5,5).
% node 6: f21 <= 5225.0  (F21, bin <= 4)  left -> 7, right -> 12
node(22,6,21,4).
left_node(22,6,7).
right_node(22,6,12).
% node 7: f18 <= 3.309999942779541  (F18, bin <= 1)  left -> 8, right -> 9
node(22,7,18,1).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(22,8,2).
% node 9: f2 <= 0.5  (F2, bin <= 0)  left -> 10, right -> 11
node(22,9,2,0).
left_node(22,9,10).
right_node(22,9,11).
% node 10 (leaf): class 0 (2)
leaf_class(22,10,2).
% node 11 (leaf): class 0 (2)
leaf_class(22,11,2).
% node 12 (leaf): class 2 (4)
leaf_class(22,12,4).

% Tree 23
tree(23).
% node 0: f16 <= 1.5  (F16, bin <= 0)  left -> 1, right -> 6
node(23,0,16,0).
left_node(23,0,1).
right_node(23,0,6).
% node 1: f15 <= 91.5  (F15, bin <= 0)  left -> 2, right -> 3
node(23,1,15,0).
left_node(23,1,2).
right_node(23,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(23,2,3).
% node 3: f5 <= 2.5  (F5, bin <= 0)  left -> 4, right -> 5
node(23,3,5,0).
left_node(23,3,4).
right_node(23,3,5).
% node 4 (leaf): class 2 (4)
leaf_class(23,4,4).
% node 5 (leaf): class 0 (2)
leaf_class(23,5,2).
% node 6: f21 <= 5225.0  (F21, bin <= 4)  left -> 7, right -> 12
node(23,6,21,4).
left_node(23,6,7).
right_node(23,6,12).
% node 7: f4 <= 3.0  (F4, bin <= 0)  left -> 8, right -> 9
node(23,7,4,0).
left_node(23,7,8).
right_node(23,7,9).
% node 8 (leaf): class 3 (5)
leaf_class(23,8,5).
% node 9: f18 <= 3.3950001001358032  (F18, bin <= 2)  left -> 10, right -> 11
node(23,9,18,2).
left_node(23,9,10).
right_node(23,9,11).
% node 10 (leaf): class 0 (2)
leaf_class(23,10,2).
% node 11 (leaf): class 0 (2)
leaf_class(23,11,2).
% node 12: f20 <= 111.0  (F20, bin <= 6)  left -> 13, right -> 14
node(23,12,20,6).
left_node(23,12,13).
right_node(23,12,14).
% node 13 (leaf): class 2 (4)
leaf_class(23,13,4).
% node 14 (leaf): class 1 (3)
leaf_class(23,14,3).

% Tree 24
tree(24).
% node 0: f4 <= 3.0  (F4, bin <= 0)  left -> 1, right -> 8
node(24,0,4,0).
left_node(24,0,1).
right_node(24,0,8).
% node 1: f22 <= 25.5  (F22, bin <= 4)  left -> 2, right -> 5
node(24,1,22,4).
left_node(24,1,2).
right_node(24,1,5).
% node 2: f11 <= 51.79999923706055  (F11, bin <= 2)  left -> 3, right -> 4
node(24,2,11,2).
left_node(24,2,3).
right_node(24,2,4).
% node 3 (leaf): class 3 (5)
leaf_class(24,3,5).
% node 4 (leaf): class 2 (4)
leaf_class(24,4,4).
% node 5: f12 <= 2012.5  (F12, bin <= 3)  left -> 6, right -> 7
node(24,5,12,3).
left_node(24,5,6).
right_node(24,5,7).
% node 6 (leaf): class 1 (3)
leaf_class(24,6,3).
% node 7 (leaf): class 1 (3)
leaf_class(24,7,3).
% node 8: f12 <= 2108.0  (F12, bin <= 7)  left -> 9, right -> 10
node(24,8,12,7).
left_node(24,8,9).
right_node(24,8,10).
% node 9 (leaf): class 1 (3)
leaf_class(24,9,3).
% node 10: f21 <= 5225.0  (F21, bin <= 4)  left -> 11, right -> 14
node(24,10,21,4).
left_node(24,10,11).
right_node(24,10,14).
% node 11: f8 <= 101.79999923706055  (F8, bin <= 10)  left -> 12, right -> 13
node(24,11,8,10).
left_node(24,11,12).
right_node(24,11,13).
% node 12 (leaf): class 0 (2)
leaf_class(24,12,2).
% node 13 (leaf): class -1 (1)
leaf_class(24,13,1).
% node 14 (leaf): class 2 (4)
leaf_class(24,14,4).

% Tree 25
tree(25).
% node 0: f1 <= 12.5  (F1, bin <= 1)  left -> 1, right -> 8
node(25,0,1,1).
left_node(25,0,1).
right_node(25,0,8).
% node 1: f11 <= 50.39999961853027  (F11, bin <= 1)  left -> 2, right -> 3
node(25,1,11,1).
left_node(25,1,2).
right_node(25,1,3).
% node 2 (leaf): class 3 (5)
leaf_class(25,2,5).
% node 3: f15 <= 105.5  (F15, bin <= 2)  left -> 4, right -> 5
node(25,3,15,2).
left_node(25,3,4).
right_node(25,3,5).
% node 4 (leaf): class 1 (3)
leaf_class(25,4,3).
% node 5: f22 <= 22.5  (F22, bin <= 2)  left -> 6, right -> 7
node(25,5,22,2).
left_node(25,5,6).
right_node(25,5,7).
% node 6 (leaf): class 1 (3)
leaf_class(25,6,3).
% node 7 (leaf): class 0 (2)
leaf_class(25,7,2).
% node 8: f10 <= 66.70000076293945  (F10, bin <= 4)  left -> 9, right -> 14
node(25,8,10,4).
left_node(25,8,9).
right_node(25,8,14).
% node 9: f8 <= 97.25  (F8, bin <= 5)  left -> 10, right -> 13
node(25,9,8,5).
left_node(25,9,10).
right_node(25,9,13).
% node 10: f4 <= 3.0  (F4, bin <= 0)  left -> 11, right -> 12
node(25,10,4,0).
left_node(25,10,11).
right_node(25,10,12).
% node 11 (leaf): class 3 (5)
leaf_class(25,11,5).
% node 12 (leaf): class 0 (2)
leaf_class(25,12,2).
% node 13 (leaf): class 2 (4)
leaf_class(25,13,4).
% node 14 (leaf): class 0 (2)
leaf_class(25,14,2).

% Tree 26
tree(26).
% node 0: f1 <= 15.5  (F1, bin <= 6)  left -> 1, right -> 12
node(26,0,1,6).
left_node(26,0,1).
right_node(26,0,12).
% node 1: f11 <= 50.35000038146973  (F11, bin <= 0)  left -> 2, right -> 3
node(26,1,11,0).
left_node(26,1,2).
right_node(26,1,3).
% node 2 (leaf): class 3 (5)
leaf_class(26,2,5).
% node 3: f4 <= 3.0  (F4, bin <= 0)  left -> 4, right -> 7
node(26,3,4,0).
left_node(26,3,4).
right_node(26,3,7).
% node 4: f10 <= 64.29999923706055  (F10, bin <= 1)  left -> 5, right -> 6
node(26,4,10,1).
left_node(26,4,5).
right_node(26,4,6).
% node 5 (leaf): class 1 (3)
leaf_class(26,5,3).
% node 6 (leaf): class 1 (3)
leaf_class(26,6,3).
% node 7: f17 <= 3.25  (F17, bin <= 2)  left -> 8, right -> 11
node(26,7,17,2).
left_node(26,7,8).
right_node(26,7,11).
% node 8: f22 <= 28.5  (F22, bin <= 7)  left -> 9, right -> 10
node(26,8,22,7).
left_node(26,8,9).
right_node(26,8,10).
% node 9 (leaf): class 1 (3)
leaf_class(26,9,3).
% node 10 (leaf): class 1 (3)
leaf_class(26,10,3).
% node 11 (leaf): class 0 (2)
leaf_class(26,11,2).
% node 12: f9 <= 174.60000610351562  (F9, bin <= 8)  left -> 13, right -> 14
node(26,12,9,8).
left_node(26,12,13).
right_node(26,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(26,13,2).
% node 14 (leaf): class 2 (4)
leaf_class(26,14,4).

% Tree 27
tree(27).
% node 0: f8 <= 94.9000015258789  (F8, bin <= 0)  left -> 1, right -> 4
node(27,0,8,0).
left_node(27,0,1).
right_node(27,0,4).
% node 1: f20 <= 71.5  (F20, bin <= 1)  left -> 2, right -> 3
node(27,1,20,1).
left_node(27,1,2).
right_node(27,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(27,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(27,3,3).
% node 4: f20 <= 98.5  (F20, bin <= 3)  left -> 5, right -> 10
node(27,4,20,3).
left_node(27,4,5).
right_node(27,4,10).
% node 5: f5 <= 2.5  (F5, bin <= 0)  left -> 6, right -> 7
node(27,5,5,0).
left_node(27,5,6).
right_node(27,5,7).
% node 6 (leaf): class 0 (2)
leaf_class(27,6,2).
% node 7: f9 <= 176.70000457763672  (F9, bin <= 10)  left -> 8, right -> 9
node(27,7,9,10).
left_node(27,7,8).
right_node(27,7,9).
% node 8 (leaf): class 0 (2)
leaf_class(27,8,2).
% node 9 (leaf): class 0 (2)
leaf_class(27,9,2).
% node 10: f4 <= 3.0  (F4, bin <= 0)  left -> 11, right -> 12
node(27,10,4,0).
left_node(27,10,11).
right_node(27,10,12).
% node 11 (leaf): class 2 (4)
leaf_class(27,11,4).
% node 12 (leaf): class 0 (2)
leaf_class(27,12,2).

% Tree 28
tree(28).
% node 0: f12 <= 2060.5  (F12, bin <= 6)  left -> 1, right -> 4
node(28,0,12,6).
left_node(28,0,1).
right_node(28,0,4).
% node 1: f21 <= 5450.0  (F21, bin <= 5)  left -> 2, right -> 3
node(28,1,21,5).
left_node(28,1,2).
right_node(28,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(28,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(28,3,3).
% node 4: f11 <= 51.79999923706055  (F11, bin <= 2)  left -> 5, right -> 6
node(28,4,11,2).
left_node(28,4,5).
right_node(28,4,6).
% node 5 (leaf): class 3 (5)
leaf_class(28,5,5).
% node 6: f8 <= 101.79999923706055  (F8, bin <= 10)  left -> 7, right -> 12
node(28,6,8,10).
left_node(28,6,7).
right_node(28,6,12).
% node 7: f4 <= 3.0  (F4, bin <= 0)  left -> 8, right -> 9
node(28,7,4,0).
left_node(28,7,8).
right_node(28,7,9).
% node 8 (leaf): class 2 (4)
leaf_class(28,8,4).
% node 9: f21 <= 5225.0  (F21, bin <= 4)  left -> 10, right -> 11
node(28,9,21,4).
left_node(28,9,10).
right_node(28,9,11).
% node 10 (leaf): class 0 (2)
leaf_class(28,10,2).
% node 11 (leaf): class 2 (4)
leaf_class(28,11,4).
% node 12: f1 <= 16.0  (F1, bin <= 7)  left -> 13, right -> 14
node(28,12,1,7).
left_node(28,12,13).
right_node(28,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(28,13,2).
% node 14 (leaf): class -1 (1)
leaf_class(28,14,1).

% Tree 29
tree(29).
% node 0: f9 <= 168.75  (F9, bin <= 4)  left -> 1, right -> 4
node(29,0,9,4).
left_node(29,0,1).
right_node(29,0,4).
% node 1: f20 <= 69.5  (F20, bin <= 0)  left -> 2, right -> 3
node(29,1,20,0).
left_node(29,1,2).
right_node(29,1,3).
% node 2 (leaf): class 1 (3)
leaf_class(29,2,3).
% node 3 (leaf): class 1 (3)
leaf_class(29,3,3).
% node 4: f8 <= 100.10000228881836  (F8, bin <= 7)  left -> 5, right -> 10
node(29,4,8,7).
left_node(29,4,5).
right_node(29,4,10).
% node 5: f16 <= 1.5  (F16, bin <= 0)  left -> 6, right -> 7
node(29,5,16,0).
left_node(29,5,6).
right_node(29,5,7).
% node 6 (leaf): class 1 (3)
leaf_class(29,6,3).
% node 7: f5 <= 2.5  (F5, bin <= 0)  left -> 8, right -> 9
node(29,7,5,0).
left_node(29,7,8).
right_node(29,7,9).
% node 8 (leaf): class 3 (5)
leaf_class(29,8,5).
% node 9 (leaf): class 2 (4)
leaf_class(29,9,4).
% node 10: f13 <= 2.5  (F13, bin <= 0)  left -> 11, right -> 12
node(29,10,13,0).
left_node(29,10,11).
right_node(29,10,12).
% node 11 (leaf): class 0 (2)
leaf_class(29,11,2).
% node 12: f1 <= 8.0  (F1, bin <= 0)  left -> 13, right -> 14
node(29,12,1,0).
left_node(29,12,13).
right_node(29,12,14).
% node 13 (leaf): class 0 (2)
leaf_class(29,13,2).
% node 14 (leaf): class -1 (1)
leaf_class(29,14,1).

% --- Class domain ---
class_idx(0).  % -2
class_idx(1).  % -1
class_idx(2).  % 0
class_idx(3).  % 1
class_idx(4).  % 2
class_idx(5).  % 3
