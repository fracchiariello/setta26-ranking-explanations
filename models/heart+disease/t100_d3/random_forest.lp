% ============================================================
% random_forest.lp — RF facts for heart+disease
% 100 trees  |  10 features
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

% Feature 0 (f0): 25 bins  (thresholds: [32.5, 34.5, 36.5, 37.5, 38.5, 39.5, 40.5, 42.5, 43.5, 45.5, 46.5, 47.5, 48.5, 49.5, 51.5, 52.5, 53.5, 54.5, 55.5, 56.5, 57.5, 60.5, 61.5, 62.5])
{bin(I,0,B) : B = 0..24} = 1 :- item(I).
bin_max(0,24).

% Feature 1 (f1): 2 bins  (thresholds: [0.5])
{bin(I,1,B) : B = 0..1} = 1 :- item(I).
bin_max(1,1).

% Feature 2 (f2): 4 bins  (thresholds: [1.5, 2.5, 3.5])
{bin(I,2,B) : B = 0..3} = 1 :- item(I).
bin_max(2,3).

% Feature 3 (f3): 26 bins  (thresholds: [111.5, 114.5, 115.5, 116.5, 119.5, 121.5, 123.5, 124.5, 125.5, 127.5, 129.5, 130.5, 132.5, 133.5, 134.5, 135.5, 138.5, 139.5, 142.5, 143.5, 145.5, 147.5, 155.5, 165.5, 175.5])
{bin(I,3,B) : B = 0..25} = 1 :- item(I).
bin_max(3,25).

% Feature 4 (f4): 50 bins  (thresholds: [150.5, 151.5, 158.5, 161.5, 167.5, 169.5, 180.5, 182.5, 183.5, 184.5, 204.5, 210.5, 223.5, 224.5, 226.5, 230.5, 237.5, 241.5, 245.5, 246.5, 247.5, 252.5, 255.5, 261.5, 262.5, 263.5, 264.5, 274.5, 277.5, 278.5, 282.5, 284.5, 285.5, 286.5, 287.5, 288.5, 290.5, 291.5, 296.5, 301.5, 332.5, 333.5, 339.5, 369.5, 378.5, 430.5, 442.5, 479.5, 493.5])
{bin(I,4,B) : B = 0..49} = 1 :- item(I).
bin_max(4,49).

% Feature 5 (f5): 2 bins  (thresholds: [0.5])
{bin(I,5,B) : B = 0..1} = 1 :- item(I).
bin_max(5,1).

% Feature 6 (f6): 3 bins  (thresholds: [0.5, 1.5])
{bin(I,6,B) : B = 0..2} = 1 :- item(I).
bin_max(6,2).

% Feature 7 (f7): 45 bins  (thresholds: [95.5, 97.5, 99.5, 102.5, 103.5, 109.5, 110.5, 111.5, 119.5, 122.5, 124.5, 126.5, 127.5, 128.5, 129.5, 131.5, 134.5, 135.5, 136.5, 138.5, 141.5, 142.5, 143.5, 144.5, 145.5, 146.5, 147.5, 148.5, 149.5, 152.5, 153.5, 154.5, 155.5, 156.5, 158.5, 159.5, 165.5, 166.5, 167.5, 168.5, 171.5, 172.5, 174.5, 179.5])
{bin(I,7,B) : B = 0..44} = 1 :- item(I).
bin_max(7,44).

% Feature 8 (f8): 2 bins  (thresholds: [0.5])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).
bin_max(8,1).

% Feature 9 (f9): 11 bins  (thresholds: [0.25, 0.5, 0.75, 0.8999999761581421, 1.25, 1.5, 1.75, 2.25, 2.5, 2.75])
{bin(I,9,B) : B = 0..10} = 1 :- item(I).
bin_max(9,10).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f7 <= 131.0  (F7, bin <= 15)  left -> 1, right -> 8
node(0,0,7,15).
left_node(0,0,1).
right_node(0,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(0,1,8,0).
left_node(0,1,2).
right_node(0,1,5).
% node 2: f7 <= 111.0  (F7, bin <= 7)  left -> 3, right -> 4
node(0,2,7,7).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(0,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(0,4,1).
% node 5: f7 <= 109.0  (F7, bin <= 5)  left -> 6, right -> 7
node(0,5,7,5).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(0,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(0,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 1)  left -> 9, right -> 12
node(0,8,9,1).
left_node(0,8,9).
right_node(0,8,12).
% node 9: f4 <= 255.5  (F4, bin <= 22)  left -> 10, right -> 11
node(0,9,4,22).
left_node(0,9,10).
right_node(0,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(0,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(0,11,0).
% node 12: f0 <= 52.5  (F0, bin <= 15)  left -> 13, right -> 14
node(0,12,0,15).
left_node(0,12,13).
right_node(0,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(0,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(0,14,0).

% Tree 1
tree(1).
% node 0: f3 <= 143.5  (F3, bin <= 19)  left -> 1, right -> 8
node(1,0,3,19).
left_node(1,0,1).
right_node(1,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(1,1,8,0).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f9 <= 1.25  (F9, bin <= 4)  left -> 3, right -> 4
node(1,2,9,4).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(1,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(1,4,1).
% node 5: f2 <= 2.5  (F2, bin <= 1)  left -> 6, right -> 7
node(1,5,2,1).
left_node(1,5,6).
right_node(1,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(1,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(1,7,1).
% node 8: f7 <= 159.0  (F7, bin <= 35)  left -> 9, right -> 12
node(1,8,7,35).
left_node(1,8,9).
right_node(1,8,12).
% node 9: f8 <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(1,9,8,0).
left_node(1,9,10).
right_node(1,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(1,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(1,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(1,12,0).

% Tree 2
tree(2).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(2,0,8,0).
left_node(2,0,1).
right_node(2,0,8).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(2,1,9,4).
left_node(2,1,2).
right_node(2,1,5).
% node 2: f1 <= 0.5  (F1, bin <= 0)  left -> 3, right -> 4
node(2,2,1,0).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(2,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(2,4,0).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(2,5,1,0).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(2,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(2,7,1).
% node 8: f7 <= 155.0  (F7, bin <= 32)  left -> 9, right -> 12
node(2,8,7,32).
left_node(2,8,9).
right_node(2,8,12).
% node 9: f3 <= 123.0  (F3, bin <= 6)  left -> 10, right -> 11
node(2,9,3,6).
left_node(2,9,10).
right_node(2,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(2,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(2,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(2,12,0).

% Tree 3
tree(3).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(3,0,1,0).
left_node(3,0,1).
right_node(3,0,8).
% node 1: f5 <= 0.5  (F5, bin <= 0)  left -> 2, right -> 5
node(3,1,5,0).
left_node(3,1,2).
right_node(3,1,5).
% node 2: f2 <= 2.5  (F2, bin <= 1)  left -> 3, right -> 4
node(3,2,2,1).
left_node(3,2,3).
right_node(3,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(3,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(3,4,0).
% node 5: f4 <= 245.5  (F4, bin <= 18)  left -> 6, right -> 7
node(3,5,4,18).
left_node(3,5,6).
right_node(3,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(3,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(3,7,1).
% node 8: f2 <= 3.5  (F2, bin <= 2)  left -> 9, right -> 12
node(3,8,2,2).
left_node(3,8,9).
right_node(3,8,12).
% node 9: f2 <= 1.5  (F2, bin <= 0)  left -> 10, right -> 11
node(3,9,2,0).
left_node(3,9,10).
right_node(3,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(3,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(3,11,0).
% node 12: f3 <= 155.0  (F3, bin <= 22)  left -> 13, right -> 14
node(3,12,3,22).
left_node(3,12,13).
right_node(3,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(3,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(3,14,1).

% Tree 4
tree(4).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(4,0,9,3).
left_node(4,0,1).
right_node(4,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(4,1,2,2).
left_node(4,1,2).
right_node(4,1,5).
% node 2: f4 <= 287.5  (F4, bin <= 34)  left -> 3, right -> 4
node(4,2,4,34).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(4,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(4,4,0).
% node 5: f7 <= 149.0  (F7, bin <= 28)  left -> 6, right -> 7
node(4,5,7,28).
left_node(4,5,6).
right_node(4,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(4,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(4,7,1).
% node 8: f2 <= 2.5  (F2, bin <= 1)  left -> 9, right -> 12
node(4,8,2,1).
left_node(4,8,9).
right_node(4,8,12).
% node 9: f5 <= 0.5  (F5, bin <= 0)  left -> 10, right -> 11
node(4,9,5,0).
left_node(4,9,10).
right_node(4,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(4,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(4,11,1).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(4,12,1,0).
left_node(4,12,13).
right_node(4,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(4,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(4,14,1).

% Tree 5
tree(5).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(5,0,8,0).
left_node(5,0,1).
right_node(5,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(5,1,2,1).
left_node(5,1,2).
right_node(5,1,5).
% node 2: f7 <= 174.5  (F7, bin <= 42)  left -> 3, right -> 4
node(5,2,7,42).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(5,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(5,4,0).
% node 5: f2 <= 3.5  (F2, bin <= 2)  left -> 6, right -> 7
node(5,5,2,2).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(5,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(5,7,0).
% node 8: f7 <= 159.0  (F7, bin <= 35)  left -> 9, right -> 12
node(5,8,7,35).
left_node(5,8,9).
right_node(5,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(5,9,1,0).
left_node(5,9,10).
right_node(5,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(5,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(5,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(5,12,0).

% Tree 6
tree(6).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(6,0,2,2).
left_node(6,0,1).
right_node(6,0,8).
% node 1: f3 <= 132.5  (F3, bin <= 12)  left -> 2, right -> 5
node(6,1,3,12).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(6,2,8,0).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(6,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(6,4,0).
% node 5: f3 <= 138.0  (F3, bin <= 16)  left -> 6, right -> 7
node(6,5,3,16).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(6,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(6,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(6,8,9,4).
left_node(6,8,9).
right_node(6,8,12).
% node 9: f7 <= 145.0  (F7, bin <= 24)  left -> 10, right -> 11
node(6,9,7,24).
left_node(6,9,10).
right_node(6,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(6,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(6,11,1).
% node 12: f3 <= 114.0  (F3, bin <= 1)  left -> 13, right -> 14
node(6,12,3,1).
left_node(6,12,13).
right_node(6,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(6,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(6,14,1).

% Tree 7
tree(7).
% node 0: f7 <= 126.5  (F7, bin <= 11)  left -> 1, right -> 6
node(7,0,7,11).
left_node(7,0,1).
right_node(7,0,6).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 3
node(7,1,2,1).
left_node(7,1,2).
right_node(7,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(7,2,0).
% node 3: f8 <= 0.5  (F8, bin <= 0)  left -> 4, right -> 5
node(7,3,8,0).
left_node(7,3,4).
right_node(7,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(7,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(7,5,1).
% node 6: f4 <= 245.5  (F4, bin <= 18)  left -> 7, right -> 10
node(7,6,4,18).
left_node(7,6,7).
right_node(7,6,10).
% node 7: f4 <= 237.5  (F4, bin <= 16)  left -> 8, right -> 9
node(7,7,4,16).
left_node(7,7,8).
right_node(7,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(7,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(7,9,0).
% node 10: f9 <= 0.5  (F9, bin <= 1)  left -> 11, right -> 12
node(7,10,9,1).
left_node(7,10,11).
right_node(7,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(7,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(7,12,1).

% Tree 8
tree(8).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(8,0,2,2).
left_node(8,0,1).
right_node(8,0,8).
% node 1: f2 <= 1.5  (F2, bin <= 0)  left -> 2, right -> 5
node(8,1,2,0).
left_node(8,1,2).
right_node(8,1,5).
% node 2: f4 <= 264.0  (F4, bin <= 26)  left -> 3, right -> 4
node(8,2,4,26).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(8,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(8,4,1).
% node 5: f8 <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(8,5,8,0).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(8,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(8,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(8,8,8,0).
left_node(8,8,9).
right_node(8,8,12).
% node 9: f4 <= 150.5  (F4, bin <= 0)  left -> 10, right -> 11
node(8,9,4,0).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(8,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(8,11,1).
% node 12: f4 <= 230.0  (F4, bin <= 15)  left -> 13, right -> 14
node(8,12,4,15).
left_node(8,12,13).
right_node(8,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(8,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(8,14,1).

% Tree 9
tree(9).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(9,0,1,0).
left_node(9,0,1).
right_node(9,0,8).
% node 1: f9 <= 0.5  (F9, bin <= 1)  left -> 2, right -> 5
node(9,1,9,1).
left_node(9,1,2).
right_node(9,1,5).
% node 2: f4 <= 286.0  (F4, bin <= 33)  left -> 3, right -> 4
node(9,2,4,33).
left_node(9,2,3).
right_node(9,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(9,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(9,4,0).
% node 5: f7 <= 142.5  (F7, bin <= 21)  left -> 6, right -> 7
node(9,5,7,21).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(9,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(9,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 1)  left -> 9, right -> 12
node(9,8,9,1).
left_node(9,8,9).
right_node(9,8,12).
% node 9: f7 <= 141.0  (F7, bin <= 20)  left -> 10, right -> 11
node(9,9,7,20).
left_node(9,9,10).
right_node(9,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(9,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(9,11,0).
% node 12: f9 <= 1.25  (F9, bin <= 4)  left -> 13, right -> 14
node(9,12,9,4).
left_node(9,12,13).
right_node(9,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(9,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(9,14,1).

% Tree 10
tree(10).
% node 0: f0 <= 62.5  (F0, bin <= 23)  left -> 1, right -> 8
node(10,0,0,23).
left_node(10,0,1).
right_node(10,0,8).
% node 1: f6 <= 0.5  (F6, bin <= 0)  left -> 2, right -> 5
node(10,1,6,0).
left_node(10,1,2).
right_node(10,1,5).
% node 2: f9 <= 0.75  (F9, bin <= 2)  left -> 3, right -> 4
node(10,2,9,2).
left_node(10,2,3).
right_node(10,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(10,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(10,4,1).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(10,5,5,0).
left_node(10,5,6).
right_node(10,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(10,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(10,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(10,8,1).

% Tree 11
tree(11).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 6
node(11,0,2,2).
left_node(11,0,1).
right_node(11,0,6).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(11,1,8,0).
left_node(11,1,2).
right_node(11,1,5).
% node 2: f2 <= 1.5  (F2, bin <= 0)  left -> 3, right -> 4
node(11,2,2,0).
left_node(11,2,3).
right_node(11,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(11,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(11,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(11,5,1).
% node 6: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 7, right -> 10
node(11,6,9,3).
left_node(11,6,7).
right_node(11,6,10).
% node 7: f9 <= 0.25  (F9, bin <= 0)  left -> 8, right -> 9
node(11,7,9,0).
left_node(11,7,8).
right_node(11,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(11,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(11,9,0).
% node 10: f1 <= 0.5  (F1, bin <= 0)  left -> 11, right -> 12
node(11,10,1,0).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(11,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(11,12,1).

% Tree 12
tree(12).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(12,0,2,2).
left_node(12,0,1).
right_node(12,0,8).
% node 1: f7 <= 103.0  (F7, bin <= 4)  left -> 2, right -> 5
node(12,1,7,4).
left_node(12,1,2).
right_node(12,1,5).
% node 2: f6 <= 0.5  (F6, bin <= 0)  left -> 3, right -> 4
node(12,2,6,0).
left_node(12,2,3).
right_node(12,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(12,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(12,4,1).
% node 5: f8 <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(12,5,8,0).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(12,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(12,7,0).
% node 8: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 9, right -> 12
node(12,8,9,3).
left_node(12,8,9).
right_node(12,8,12).
% node 9: f3 <= 119.0  (F3, bin <= 4)  left -> 10, right -> 11
node(12,9,3,4).
left_node(12,9,10).
right_node(12,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(12,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(12,11,0).
% node 12: f0 <= 60.0  (F0, bin <= 21)  left -> 13, right -> 14
node(12,12,0,21).
left_node(12,12,13).
right_node(12,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(12,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(12,14,0).

% Tree 13
tree(13).
% node 0: f7 <= 131.0  (F7, bin <= 15)  left -> 1, right -> 8
node(13,0,7,15).
left_node(13,0,1).
right_node(13,0,8).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(13,1,9,4).
left_node(13,1,2).
right_node(13,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(13,2,8,0).
left_node(13,2,3).
right_node(13,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(13,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(13,4,1).
% node 5: f9 <= 2.5  (F9, bin <= 8)  left -> 6, right -> 7
node(13,5,9,8).
left_node(13,5,6).
right_node(13,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(13,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(13,7,0).
% node 8: f6 <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(13,8,6,0).
left_node(13,8,9).
right_node(13,8,12).
% node 9: f2 <= 2.5  (F2, bin <= 1)  left -> 10, right -> 11
node(13,9,2,1).
left_node(13,9,10).
right_node(13,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(13,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(13,11,0).
% node 12: f2 <= 1.5  (F2, bin <= 0)  left -> 13, right -> 14
node(13,12,2,0).
left_node(13,12,13).
right_node(13,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(13,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(13,14,0).

% Tree 14
tree(14).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(14,0,2,2).
left_node(14,0,1).
right_node(14,0,8).
% node 1: f2 <= 1.5  (F2, bin <= 0)  left -> 2, right -> 5
node(14,1,2,0).
left_node(14,1,2).
right_node(14,1,5).
% node 2: f1 <= 0.5  (F1, bin <= 0)  left -> 3, right -> 4
node(14,2,1,0).
left_node(14,2,3).
right_node(14,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(14,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(14,4,1).
% node 5: f8 <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(14,5,8,0).
left_node(14,5,6).
right_node(14,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(14,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(14,7,0).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(14,8,8,0).
left_node(14,8,9).
right_node(14,8,12).
% node 9: f9 <= 1.5  (F9, bin <= 5)  left -> 10, right -> 11
node(14,9,9,5).
left_node(14,9,10).
right_node(14,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(14,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(14,11,1).
% node 12: f3 <= 135.0  (F3, bin <= 15)  left -> 13, right -> 14
node(14,12,3,15).
left_node(14,12,13).
right_node(14,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(14,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(14,14,1).

% Tree 15
tree(15).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(15,0,8,0).
left_node(15,0,1).
right_node(15,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(15,1,2,2).
left_node(15,1,2).
right_node(15,1,5).
% node 2: f7 <= 95.0  (F7, bin <= 0)  left -> 3, right -> 4
node(15,2,7,0).
left_node(15,2,3).
right_node(15,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(15,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(15,4,0).
% node 5: f4 <= 180.5  (F4, bin <= 6)  left -> 6, right -> 7
node(15,5,4,6).
left_node(15,5,6).
right_node(15,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(15,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(15,7,1).
% node 8: f3 <= 129.0  (F3, bin <= 10)  left -> 9, right -> 10
node(15,8,3,10).
left_node(15,8,9).
right_node(15,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(15,9,1).
% node 10: f7 <= 109.0  (F7, bin <= 5)  left -> 11, right -> 12
node(15,10,7,5).
left_node(15,10,11).
right_node(15,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(15,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(15,12,1).

% Tree 16
tree(16).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(16,0,1,0).
left_node(16,0,1).
right_node(16,0,8).
% node 1: f4 <= 245.5  (F4, bin <= 18)  left -> 2, right -> 5
node(16,1,4,18).
left_node(16,1,2).
right_node(16,1,5).
% node 2: f4 <= 183.0  (F4, bin <= 8)  left -> 3, right -> 4
node(16,2,4,8).
left_node(16,2,3).
right_node(16,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(16,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(16,4,0).
% node 5: f6 <= 0.5  (F6, bin <= 0)  left -> 6, right -> 7
node(16,5,6,0).
left_node(16,5,6).
right_node(16,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(16,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(16,7,0).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(16,8,8,0).
left_node(16,8,9).
right_node(16,8,12).
% node 9: f2 <= 3.5  (F2, bin <= 2)  left -> 10, right -> 11
node(16,9,2,2).
left_node(16,9,10).
right_node(16,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(16,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(16,11,1).
% node 12: f9 <= 0.75  (F9, bin <= 2)  left -> 13, right -> 14
node(16,12,9,2).
left_node(16,12,13).
right_node(16,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(16,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(16,14,1).

% Tree 17
tree(17).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(17,0,1,0).
left_node(17,0,1).
right_node(17,0,8).
% node 1: f5 <= 0.5  (F5, bin <= 0)  left -> 2, right -> 5
node(17,1,5,0).
left_node(17,1,2).
right_node(17,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(17,2,8,0).
left_node(17,2,3).
right_node(17,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(17,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(17,4,0).
% node 5: f0 <= 47.5  (F0, bin <= 11)  left -> 6, right -> 7
node(17,5,0,11).
left_node(17,5,6).
right_node(17,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(17,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(17,7,0).
% node 8: f7 <= 136.5  (F7, bin <= 18)  left -> 9, right -> 12
node(17,8,7,18).
left_node(17,8,9).
right_node(17,8,12).
% node 9: f9 <= 1.25  (F9, bin <= 4)  left -> 10, right -> 11
node(17,9,9,4).
left_node(17,9,10).
right_node(17,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(17,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(17,11,1).
% node 12: f9 <= 0.5  (F9, bin <= 1)  left -> 13, right -> 14
node(17,12,9,1).
left_node(17,12,13).
right_node(17,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(17,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(17,14,1).

% Tree 18
tree(18).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(18,0,2,2).
left_node(18,0,1).
right_node(18,0,8).
% node 1: f3 <= 127.5  (F3, bin <= 9)  left -> 2, right -> 5
node(18,1,3,9).
left_node(18,1,2).
right_node(18,1,5).
% node 2: f1 <= 0.5  (F1, bin <= 0)  left -> 3, right -> 4
node(18,2,1,0).
left_node(18,2,3).
right_node(18,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(18,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(18,4,0).
% node 5: f7 <= 158.0  (F7, bin <= 34)  left -> 6, right -> 7
node(18,5,7,34).
left_node(18,5,6).
right_node(18,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(18,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(18,7,0).
% node 8: f7 <= 131.0  (F7, bin <= 15)  left -> 9, right -> 12
node(18,8,7,15).
left_node(18,8,9).
right_node(18,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(18,9,1,0).
left_node(18,9,10).
right_node(18,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(18,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(18,11,1).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(18,12,8,0).
left_node(18,12,13).
right_node(18,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(18,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(18,14,1).

% Tree 19
tree(19).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(19,0,9,3).
left_node(19,0,1).
right_node(19,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(19,1,8,0).
left_node(19,1,2).
right_node(19,1,5).
% node 2: f0 <= 57.0  (F0, bin <= 20)  left -> 3, right -> 4
node(19,2,0,20).
left_node(19,2,3).
right_node(19,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(19,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(19,4,0).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(19,5,5,0).
left_node(19,5,6).
right_node(19,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(19,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(19,7,0).
% node 8: f2 <= 2.5  (F2, bin <= 1)  left -> 9, right -> 12
node(19,8,2,1).
left_node(19,8,9).
right_node(19,8,12).
% node 9: f3 <= 135.0  (F3, bin <= 15)  left -> 10, right -> 11
node(19,9,3,15).
left_node(19,9,10).
right_node(19,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(19,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(19,11,0).
% node 12: f7 <= 159.0  (F7, bin <= 35)  left -> 13, right -> 14
node(19,12,7,35).
left_node(19,12,13).
right_node(19,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(19,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(19,14,0).

% Tree 20
tree(20).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 8
node(20,0,9,4).
left_node(20,0,1).
right_node(20,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(20,1,2,2).
left_node(20,1,2).
right_node(20,1,5).
% node 2: f3 <= 132.5  (F3, bin <= 12)  left -> 3, right -> 4
node(20,2,3,12).
left_node(20,2,3).
right_node(20,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(20,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(20,4,0).
% node 5: f6 <= 0.5  (F6, bin <= 0)  left -> 6, right -> 7
node(20,5,6,0).
left_node(20,5,6).
right_node(20,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(20,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(20,7,0).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(20,8,8,0).
left_node(20,8,9).
right_node(20,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(20,9,1,0).
left_node(20,9,10).
right_node(20,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(20,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(20,11,1).
% node 12: f7 <= 156.5  (F7, bin <= 33)  left -> 13, right -> 14
node(20,12,7,33).
left_node(20,12,13).
right_node(20,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(20,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(20,14,0).

% Tree 21
tree(21).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(21,0,8,0).
left_node(21,0,1).
right_node(21,0,8).
% node 1: f9 <= 1.75  (F9, bin <= 6)  left -> 2, right -> 5
node(21,1,9,6).
left_node(21,1,2).
right_node(21,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(21,2,2,2).
left_node(21,2,3).
right_node(21,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(21,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(21,4,1).
% node 5: f3 <= 114.0  (F3, bin <= 1)  left -> 6, right -> 7
node(21,5,3,1).
left_node(21,5,6).
right_node(21,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(21,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(21,7,1).
% node 8: f0 <= 49.5  (F0, bin <= 13)  left -> 9, right -> 12
node(21,8,0,13).
left_node(21,8,9).
right_node(21,8,12).
% node 9: f2 <= 2.5  (F2, bin <= 1)  left -> 10, right -> 11
node(21,9,2,1).
left_node(21,9,10).
right_node(21,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(21,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(21,11,1).
% node 12: f9 <= 0.5  (F9, bin <= 1)  left -> 13, right -> 14
node(21,12,9,1).
left_node(21,12,13).
right_node(21,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(21,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(21,14,1).

% Tree 22
tree(22).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(22,0,2,2).
left_node(22,0,1).
right_node(22,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(22,1,8,0).
left_node(22,1,2).
right_node(22,1,5).
% node 2: f7 <= 135.5  (F7, bin <= 17)  left -> 3, right -> 4
node(22,2,7,17).
left_node(22,2,3).
right_node(22,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(22,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(22,4,0).
% node 5: f3 <= 125.0  (F3, bin <= 8)  left -> 6, right -> 7
node(22,5,3,8).
left_node(22,5,6).
right_node(22,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(22,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(22,7,1).
% node 8: f0 <= 62.0  (F0, bin <= 23)  left -> 9, right -> 12
node(22,8,0,23).
left_node(22,8,9).
right_node(22,8,12).
% node 9: f6 <= 0.5  (F6, bin <= 0)  left -> 10, right -> 11
node(22,9,6,0).
left_node(22,9,10).
right_node(22,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(22,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(22,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(22,12,1).

% Tree 23
tree(23).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(23,0,9,3).
left_node(23,0,1).
right_node(23,0,8).
% node 1: f0 <= 48.5  (F0, bin <= 12)  left -> 2, right -> 5
node(23,1,0,12).
left_node(23,1,2).
right_node(23,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(23,2,2,2).
left_node(23,2,3).
right_node(23,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(23,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(23,4,0).
% node 5: f7 <= 152.0  (F7, bin <= 29)  left -> 6, right -> 7
node(23,5,7,29).
left_node(23,5,6).
right_node(23,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(23,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(23,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(23,8,1,0).
left_node(23,8,9).
right_node(23,8,12).
% node 9: f4 <= 333.0  (F4, bin <= 41)  left -> 10, right -> 11
node(23,9,4,41).
left_node(23,9,10).
right_node(23,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(23,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(23,11,1).
% node 12: f3 <= 124.5  (F3, bin <= 7)  left -> 13, right -> 14
node(23,12,3,7).
left_node(23,12,13).
right_node(23,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(23,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(23,14,1).

% Tree 24
tree(24).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(24,0,2,2).
left_node(24,0,1).
right_node(24,0,8).
% node 1: f2 <= 1.5  (F2, bin <= 0)  left -> 2, right -> 5
node(24,1,2,0).
left_node(24,1,2).
right_node(24,1,5).
% node 2: f4 <= 158.0  (F4, bin <= 2)  left -> 3, right -> 4
node(24,2,4,2).
left_node(24,2,3).
right_node(24,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(24,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(24,4,0).
% node 5: f4 <= 246.5  (F4, bin <= 19)  left -> 6, right -> 7
node(24,5,4,19).
left_node(24,5,6).
right_node(24,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(24,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(24,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(24,8,1,0).
left_node(24,8,9).
right_node(24,8,12).
% node 9: f7 <= 147.0  (F7, bin <= 26)  left -> 10, right -> 11
node(24,9,7,26).
left_node(24,9,10).
right_node(24,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(24,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(24,11,1).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(24,12,8,0).
left_node(24,12,13).
right_node(24,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(24,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(24,14,1).

% Tree 25
tree(25).
% node 0: f7 <= 131.0  (F7, bin <= 15)  left -> 1, right -> 8
node(25,0,7,15).
left_node(25,0,1).
right_node(25,0,8).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(25,1,9,4).
left_node(25,1,2).
right_node(25,1,5).
% node 2: f2 <= 2.5  (F2, bin <= 1)  left -> 3, right -> 4
node(25,2,2,1).
left_node(25,2,3).
right_node(25,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(25,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(25,4,0).
% node 5: f6 <= 0.5  (F6, bin <= 0)  left -> 6, right -> 7
node(25,5,6,0).
left_node(25,5,6).
right_node(25,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(25,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(25,7,1).
% node 8: f5 <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(25,8,5,0).
left_node(25,8,9).
right_node(25,8,12).
% node 9: f9 <= 0.5  (F9, bin <= 1)  left -> 10, right -> 11
node(25,9,9,1).
left_node(25,9,10).
right_node(25,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(25,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(25,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(25,12,1).

% Tree 26
tree(26).
% node 0: f7 <= 153.0  (F7, bin <= 30)  left -> 1, right -> 8
node(26,0,7,30).
left_node(26,0,1).
right_node(26,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(26,1,2,2).
left_node(26,1,2).
right_node(26,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(26,2,8,0).
left_node(26,2,3).
right_node(26,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(26,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(26,4,1).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(26,5,1,0).
left_node(26,5,6).
right_node(26,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(26,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(26,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 1)  left -> 9, right -> 12
node(26,8,9,1).
left_node(26,8,9).
right_node(26,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(26,9,1,0).
left_node(26,9,10).
right_node(26,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(26,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(26,11,0).
% node 12: f0 <= 42.5  (F0, bin <= 7)  left -> 13, right -> 14
node(26,12,0,7).
left_node(26,12,13).
right_node(26,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(26,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(26,14,1).

% Tree 27
tree(27).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 8
node(27,0,9,4).
left_node(27,0,1).
right_node(27,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(27,1,2,1).
left_node(27,1,2).
right_node(27,1,5).
% node 2: f6 <= 0.5  (F6, bin <= 0)  left -> 3, right -> 4
node(27,2,6,0).
left_node(27,2,3).
right_node(27,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(27,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(27,4,0).
% node 5: f7 <= 171.0  (F7, bin <= 40)  left -> 6, right -> 7
node(27,5,7,40).
left_node(27,5,6).
right_node(27,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(27,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(27,7,0).
% node 8: f7 <= 144.0  (F7, bin <= 23)  left -> 9, right -> 12
node(27,8,7,23).
left_node(27,8,9).
right_node(27,8,12).
% node 9: f6 <= 0.5  (F6, bin <= 0)  left -> 10, right -> 11
node(27,9,6,0).
left_node(27,9,10).
right_node(27,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(27,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(27,11,1).
% node 12: f4 <= 274.0  (F4, bin <= 27)  left -> 13, right -> 14
node(27,12,4,27).
left_node(27,12,13).
right_node(27,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(27,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(27,14,1).

% Tree 28
tree(28).
% node 0: f7 <= 171.0  (F7, bin <= 40)  left -> 1, right -> 8
node(28,0,7,40).
left_node(28,0,1).
right_node(28,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(28,1,8,0).
left_node(28,1,2).
right_node(28,1,5).
% node 2: f3 <= 111.0  (F3, bin <= 0)  left -> 3, right -> 4
node(28,2,3,0).
left_node(28,2,3).
right_node(28,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(28,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(28,4,0).
% node 5: f6 <= 0.5  (F6, bin <= 0)  left -> 6, right -> 7
node(28,5,6,0).
left_node(28,5,6).
right_node(28,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(28,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(28,7,1).
% node 8: f2 <= 1.5  (F2, bin <= 0)  left -> 9, right -> 12
node(28,8,2,0).
left_node(28,8,9).
right_node(28,8,12).
% node 9: f0 <= 34.5  (F0, bin <= 1)  left -> 10, right -> 11
node(28,9,0,1).
left_node(28,9,10).
right_node(28,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(28,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(28,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(28,12,0).

% Tree 29
tree(29).
% node 0: f7 <= 128.5  (F7, bin <= 13)  left -> 1, right -> 8
node(29,0,7,13).
left_node(29,0,1).
right_node(29,0,8).
% node 1: f9 <= 0.75  (F9, bin <= 2)  left -> 2, right -> 5
node(29,1,9,2).
left_node(29,1,2).
right_node(29,1,5).
% node 2: f6 <= 1.5  (F6, bin <= 1)  left -> 3, right -> 4
node(29,2,6,1).
left_node(29,2,3).
right_node(29,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(29,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(29,4,1).
% node 5: f3 <= 133.0  (F3, bin <= 13)  left -> 6, right -> 7
node(29,5,3,13).
left_node(29,5,6).
right_node(29,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(29,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(29,7,1).
% node 8: f4 <= 262.0  (F4, bin <= 24)  left -> 9, right -> 12
node(29,8,4,24).
left_node(29,8,9).
right_node(29,8,12).
% node 9: f8 <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(29,9,8,0).
left_node(29,9,10).
right_node(29,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(29,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(29,11,1).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(29,12,8,0).
left_node(29,12,13).
right_node(29,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(29,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(29,14,1).

% Tree 30
tree(30).
% node 0: f0 <= 45.5  (F0, bin <= 9)  left -> 1, right -> 8
node(30,0,0,9).
left_node(30,0,1).
right_node(30,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(30,1,8,0).
left_node(30,1,2).
right_node(30,1,5).
% node 2: f9 <= 1.5  (F9, bin <= 5)  left -> 3, right -> 4
node(30,2,9,5).
left_node(30,2,3).
right_node(30,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(30,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(30,4,1).
% node 5: f2 <= 3.0  (F2, bin <= 2)  left -> 6, right -> 7
node(30,5,2,2).
left_node(30,5,6).
right_node(30,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(30,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(30,7,1).
% node 8: f2 <= 3.5  (F2, bin <= 2)  left -> 9, right -> 12
node(30,8,2,2).
left_node(30,8,9).
right_node(30,8,12).
% node 9: f3 <= 127.5  (F3, bin <= 9)  left -> 10, right -> 11
node(30,9,3,9).
left_node(30,9,10).
right_node(30,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(30,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(30,11,0).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(30,12,1,0).
left_node(30,12,13).
right_node(30,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(30,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(30,14,1).

% Tree 31
tree(31).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(31,0,8,0).
left_node(31,0,1).
right_node(31,0,8).
% node 1: f1 <= 0.5  (F1, bin <= 0)  left -> 2, right -> 5
node(31,1,1,0).
left_node(31,1,2).
right_node(31,1,5).
% node 2: f3 <= 155.0  (F3, bin <= 22)  left -> 3, right -> 4
node(31,2,3,22).
left_node(31,2,3).
right_node(31,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(31,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(31,4,0).
% node 5: f3 <= 147.5  (F3, bin <= 21)  left -> 6, right -> 7
node(31,5,3,21).
left_node(31,5,6).
right_node(31,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(31,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(31,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(31,8,1,0).
left_node(31,8,9).
right_node(31,8,12).
% node 9: f0 <= 55.5  (F0, bin <= 18)  left -> 10, right -> 11
node(31,9,0,18).
left_node(31,9,10).
right_node(31,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(31,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(31,11,0).
% node 12: f0 <= 39.5  (F0, bin <= 5)  left -> 13, right -> 14
node(31,12,0,5).
left_node(31,12,13).
right_node(31,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(31,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(31,14,1).

% Tree 32
tree(32).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(32,0,2,2).
left_node(32,0,1).
right_node(32,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(32,1,8,0).
left_node(32,1,2).
right_node(32,1,5).
% node 2: f9 <= 2.5  (F9, bin <= 8)  left -> 3, right -> 4
node(32,2,9,8).
left_node(32,2,3).
right_node(32,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(32,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(32,4,1).
% node 5: f7 <= 155.0  (F7, bin <= 32)  left -> 6, right -> 7
node(32,5,7,32).
left_node(32,5,6).
right_node(32,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(32,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(32,7,0).
% node 8: f0 <= 36.0  (F0, bin <= 2)  left -> 9, right -> 10
node(32,8,0,2).
left_node(32,8,9).
right_node(32,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(32,9,0).
% node 10: f1 <= 0.5  (F1, bin <= 0)  left -> 11, right -> 12
node(32,10,1,0).
left_node(32,10,11).
right_node(32,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(32,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(32,12,1).

% Tree 33
tree(33).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(33,0,8,0).
left_node(33,0,1).
right_node(33,0,8).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(33,1,9,4).
left_node(33,1,2).
right_node(33,1,5).
% node 2: f7 <= 129.5  (F7, bin <= 14)  left -> 3, right -> 4
node(33,2,7,14).
left_node(33,2,3).
right_node(33,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(33,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(33,4,0).
% node 5: f2 <= 3.5  (F2, bin <= 2)  left -> 6, right -> 7
node(33,5,2,2).
left_node(33,5,6).
right_node(33,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(33,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(33,7,1).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(33,8,1,0).
left_node(33,8,9).
right_node(33,8,12).
% node 9: f0 <= 49.0  (F0, bin <= 13)  left -> 10, right -> 11
node(33,9,0,13).
left_node(33,9,10).
right_node(33,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(33,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(33,11,0).
% node 12: f7 <= 124.5  (F7, bin <= 10)  left -> 13, right -> 14
node(33,12,7,10).
left_node(33,12,13).
right_node(33,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(33,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(33,14,1).

% Tree 34
tree(34).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(34,0,8,0).
left_node(34,0,1).
right_node(34,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(34,1,2,2).
left_node(34,1,2).
right_node(34,1,5).
% node 2: f2 <= 1.5  (F2, bin <= 0)  left -> 3, right -> 4
node(34,2,2,0).
left_node(34,2,3).
right_node(34,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(34,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(34,4,0).
% node 5: f9 <= 1.25  (F9, bin <= 4)  left -> 6, right -> 7
node(34,5,9,4).
left_node(34,5,6).
right_node(34,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(34,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(34,7,1).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(34,8,1,0).
left_node(34,8,9).
right_node(34,8,12).
% node 9: f6 <= 0.5  (F6, bin <= 0)  left -> 10, right -> 11
node(34,9,6,0).
left_node(34,9,10).
right_node(34,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(34,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(34,11,1).
% node 12: f7 <= 159.0  (F7, bin <= 35)  left -> 13, right -> 14
node(34,12,7,35).
left_node(34,12,13).
right_node(34,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(34,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(34,14,0).

% Tree 35
tree(35).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(35,0,8,0).
left_node(35,0,1).
right_node(35,0,8).
% node 1: f5 <= 0.5  (F5, bin <= 0)  left -> 2, right -> 5
node(35,1,5,0).
left_node(35,1,2).
right_node(35,1,5).
% node 2: f9 <= 1.25  (F9, bin <= 4)  left -> 3, right -> 4
node(35,2,9,4).
left_node(35,2,3).
right_node(35,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(35,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(35,4,1).
% node 5: f0 <= 46.0  (F0, bin <= 10)  left -> 6, right -> 7
node(35,5,0,10).
left_node(35,5,6).
right_node(35,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(35,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(35,7,1).
% node 8: f6 <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(35,8,6,0).
left_node(35,8,9).
right_node(35,8,12).
% node 9: f9 <= 0.75  (F9, bin <= 2)  left -> 10, right -> 11
node(35,9,9,2).
left_node(35,9,10).
right_node(35,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(35,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(35,11,1).
% node 12: f0 <= 60.0  (F0, bin <= 21)  left -> 13, right -> 14
node(35,12,0,21).
left_node(35,12,13).
right_node(35,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(35,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(35,14,0).

% Tree 36
tree(36).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(36,0,8,0).
left_node(36,0,1).
right_node(36,0,8).
% node 1: f3 <= 143.5  (F3, bin <= 19)  left -> 2, right -> 5
node(36,1,3,19).
left_node(36,1,2).
right_node(36,1,5).
% node 2: f6 <= 0.5  (F6, bin <= 0)  left -> 3, right -> 4
node(36,2,6,0).
left_node(36,2,3).
right_node(36,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(36,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(36,4,0).
% node 5: f7 <= 158.0  (F7, bin <= 34)  left -> 6, right -> 7
node(36,5,7,34).
left_node(36,5,6).
right_node(36,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(36,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(36,7,0).
% node 8: f2 <= 3.5  (F2, bin <= 2)  left -> 9, right -> 12
node(36,8,2,2).
left_node(36,8,9).
right_node(36,8,12).
% node 9: f3 <= 133.0  (F3, bin <= 13)  left -> 10, right -> 11
node(36,9,3,13).
left_node(36,9,10).
right_node(36,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(36,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(36,11,1).
% node 12: f0 <= 46.5  (F0, bin <= 10)  left -> 13, right -> 14
node(36,12,0,10).
left_node(36,12,13).
right_node(36,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(36,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(36,14,1).

% Tree 37
tree(37).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(37,0,9,3).
left_node(37,0,1).
right_node(37,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(37,1,2,2).
left_node(37,1,2).
right_node(37,1,5).
% node 2: f4 <= 255.0  (F4, bin <= 22)  left -> 3, right -> 4
node(37,2,4,22).
left_node(37,2,3).
right_node(37,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(37,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(37,4,0).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(37,5,1,0).
left_node(37,5,6).
right_node(37,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(37,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(37,7,0).
% node 8: f2 <= 3.5  (F2, bin <= 2)  left -> 9, right -> 12
node(37,8,2,2).
left_node(37,8,9).
right_node(37,8,12).
% node 9: f3 <= 133.0  (F3, bin <= 13)  left -> 10, right -> 11
node(37,9,3,13).
left_node(37,9,10).
right_node(37,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(37,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(37,11,1).
% node 12: f6 <= 0.5  (F6, bin <= 0)  left -> 13, right -> 14
node(37,12,6,0).
left_node(37,12,13).
right_node(37,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(37,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(37,14,1).

% Tree 38
tree(38).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(38,0,2,2).
left_node(38,0,1).
right_node(38,0,8).
% node 1: f0 <= 55.5  (F0, bin <= 18)  left -> 2, right -> 5
node(38,1,0,18).
left_node(38,1,2).
right_node(38,1,5).
% node 2: f0 <= 37.0  (F0, bin <= 3)  left -> 3, right -> 4
node(38,2,0,3).
left_node(38,2,3).
right_node(38,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(38,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(38,4,0).
% node 5: f9 <= 0.5  (F9, bin <= 1)  left -> 6, right -> 7
node(38,5,9,1).
left_node(38,5,6).
right_node(38,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(38,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(38,7,1).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(38,8,1,0).
left_node(38,8,9).
right_node(38,8,12).
% node 9: f4 <= 369.5  (F4, bin <= 43)  left -> 10, right -> 11
node(38,9,4,43).
left_node(38,9,10).
right_node(38,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(38,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(38,11,1).
% node 12: f4 <= 180.5  (F4, bin <= 6)  left -> 13, right -> 14
node(38,12,4,6).
left_node(38,12,13).
right_node(38,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(38,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(38,14,1).

% Tree 39
tree(39).
% node 0: f7 <= 128.5  (F7, bin <= 13)  left -> 1, right -> 8
node(39,0,7,13).
left_node(39,0,1).
right_node(39,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(39,1,2,2).
left_node(39,1,2).
right_node(39,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(39,2,8,0).
left_node(39,2,3).
right_node(39,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(39,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(39,4,1).
% node 5: f0 <= 56.5  (F0, bin <= 19)  left -> 6, right -> 7
node(39,5,0,19).
left_node(39,5,6).
right_node(39,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(39,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(39,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(39,8,8,0).
left_node(39,8,9).
right_node(39,8,12).
% node 9: f7 <= 154.5  (F7, bin <= 31)  left -> 10, right -> 11
node(39,9,7,31).
left_node(39,9,10).
right_node(39,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(39,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(39,11,0).
% node 12: f9 <= 0.5  (F9, bin <= 1)  left -> 13, right -> 14
node(39,12,9,1).
left_node(39,12,13).
right_node(39,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(39,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(39,14,1).

% Tree 40
tree(40).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(40,0,2,2).
left_node(40,0,1).
right_node(40,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(40,1,8,0).
left_node(40,1,2).
right_node(40,1,5).
% node 2: f5 <= 0.5  (F5, bin <= 0)  left -> 3, right -> 4
node(40,2,5,0).
left_node(40,2,3).
right_node(40,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(40,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(40,4,0).
% node 5: f4 <= 284.0  (F4, bin <= 31)  left -> 6, right -> 7
node(40,5,4,31).
left_node(40,5,6).
right_node(40,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(40,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(40,7,1).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(40,8,9,4).
left_node(40,8,9).
right_node(40,8,12).
% node 9: f4 <= 184.0  (F4, bin <= 9)  left -> 10, right -> 11
node(40,9,4,9).
left_node(40,9,10).
right_node(40,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(40,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(40,11,1).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(40,12,8,0).
left_node(40,12,13).
right_node(40,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(40,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(40,14,1).

% Tree 41
tree(41).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(41,0,8,0).
left_node(41,0,1).
right_node(41,0,8).
% node 1: f2 <= 1.5  (F2, bin <= 0)  left -> 2, right -> 5
node(41,1,2,0).
left_node(41,1,2).
right_node(41,1,5).
% node 2: f4 <= 301.5  (F4, bin <= 39)  left -> 3, right -> 4
node(41,2,4,39).
left_node(41,2,3).
right_node(41,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(41,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(41,4,0).
% node 5: f2 <= 2.5  (F2, bin <= 1)  left -> 6, right -> 7
node(41,5,2,1).
left_node(41,5,6).
right_node(41,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(41,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(41,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(41,8,9,4).
left_node(41,8,9).
right_node(41,8,12).
% node 9: f0 <= 46.5  (F0, bin <= 10)  left -> 10, right -> 11
node(41,9,0,10).
left_node(41,9,10).
right_node(41,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(41,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(41,11,1).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(41,12,1,0).
left_node(41,12,13).
right_node(41,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(41,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(41,14,1).

% Tree 42
tree(42).
% node 0: f3 <= 165.0  (F3, bin <= 23)  left -> 1, right -> 8
node(42,0,3,23).
left_node(42,0,1).
right_node(42,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(42,1,8,0).
left_node(42,1,2).
right_node(42,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(42,2,2,2).
left_node(42,2,3).
right_node(42,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(42,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(42,4,0).
% node 5: f7 <= 159.0  (F7, bin <= 35)  left -> 6, right -> 7
node(42,5,7,35).
left_node(42,5,6).
right_node(42,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(42,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(42,7,0).
% node 8: f0 <= 48.5  (F0, bin <= 12)  left -> 9, right -> 10
node(42,8,0,12).
left_node(42,8,9).
right_node(42,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(42,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(42,10,1).

% Tree 43
tree(43).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(43,0,2,2).
left_node(43,0,1).
right_node(43,0,8).
% node 1: f4 <= 277.5  (F4, bin <= 28)  left -> 2, right -> 5
node(43,1,4,28).
left_node(43,1,2).
right_node(43,1,5).
% node 2: f1 <= 0.5  (F1, bin <= 0)  left -> 3, right -> 4
node(43,2,1,0).
left_node(43,2,3).
right_node(43,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(43,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(43,4,0).
% node 5: f0 <= 42.0  (F0, bin <= 7)  left -> 6, right -> 7
node(43,5,0,7).
left_node(43,5,6).
right_node(43,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(43,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(43,7,0).
% node 8: f3 <= 155.0  (F3, bin <= 22)  left -> 9, right -> 12
node(43,8,3,22).
left_node(43,8,9).
right_node(43,8,12).
% node 9: f9 <= 0.75  (F9, bin <= 2)  left -> 10, right -> 11
node(43,9,9,2).
left_node(43,9,10).
right_node(43,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(43,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(43,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(43,12,1).

% Tree 44
tree(44).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(44,0,2,2).
left_node(44,0,1).
right_node(44,0,8).
% node 1: f4 <= 278.0  (F4, bin <= 29)  left -> 2, right -> 5
node(44,1,4,29).
left_node(44,1,2).
right_node(44,1,5).
% node 2: f7 <= 99.5  (F7, bin <= 2)  left -> 3, right -> 4
node(44,2,7,2).
left_node(44,2,3).
right_node(44,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(44,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(44,4,0).
% node 5: f4 <= 296.5  (F4, bin <= 38)  left -> 6, right -> 7
node(44,5,4,38).
left_node(44,5,6).
right_node(44,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(44,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(44,7,0).
% node 8: f6 <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(44,8,6,0).
left_node(44,8,9).
right_node(44,8,12).
% node 9: f7 <= 131.0  (F7, bin <= 15)  left -> 10, right -> 11
node(44,9,7,15).
left_node(44,9,10).
right_node(44,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(44,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(44,11,1).
% node 12: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 13, right -> 14
node(44,12,9,3).
left_node(44,12,13).
right_node(44,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(44,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(44,14,1).

% Tree 45
tree(45).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(45,0,1,0).
left_node(45,0,1).
right_node(45,0,8).
% node 1: f9 <= 0.5  (F9, bin <= 1)  left -> 2, right -> 5
node(45,1,9,1).
left_node(45,1,2).
right_node(45,1,5).
% node 2: f3 <= 133.5  (F3, bin <= 13)  left -> 3, right -> 4
node(45,2,3,13).
left_node(45,2,3).
right_node(45,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(45,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(45,4,0).
% node 5: f0 <= 43.5  (F0, bin <= 8)  left -> 6, right -> 7
node(45,5,0,8).
left_node(45,5,6).
right_node(45,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(45,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(45,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(45,8,9,4).
left_node(45,8,9).
right_node(45,8,12).
% node 9: f2 <= 3.5  (F2, bin <= 2)  left -> 10, right -> 11
node(45,9,2,2).
left_node(45,9,10).
right_node(45,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(45,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(45,11,0).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(45,12,8,0).
left_node(45,12,13).
right_node(45,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(45,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(45,14,1).

% Tree 46
tree(46).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 6
node(46,0,2,2).
left_node(46,0,1).
right_node(46,0,6).
% node 1: f7 <= 95.0  (F7, bin <= 0)  left -> 2, right -> 3
node(46,1,7,0).
left_node(46,1,2).
right_node(46,1,3).
% node 2 (leaf): class 1 (1)
leaf_class(46,2,1).
% node 3: f8 <= 0.5  (F8, bin <= 0)  left -> 4, right -> 5
node(46,3,8,0).
left_node(46,3,4).
right_node(46,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(46,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(46,5,0).
% node 6: f8 <= 0.5  (F8, bin <= 0)  left -> 7, right -> 10
node(46,6,8,0).
left_node(46,6,7).
right_node(46,6,10).
% node 7: f3 <= 142.5  (F3, bin <= 18)  left -> 8, right -> 9
node(46,7,3,18).
left_node(46,7,8).
right_node(46,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(46,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(46,9,1).
% node 10: f0 <= 56.5  (F0, bin <= 19)  left -> 11, right -> 12
node(46,10,0,19).
left_node(46,10,11).
right_node(46,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(46,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(46,12,0).

% Tree 47
tree(47).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(47,0,1,0).
left_node(47,0,1).
right_node(47,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(47,1,8,0).
left_node(47,1,2).
right_node(47,1,5).
% node 2: f4 <= 245.5  (F4, bin <= 18)  left -> 3, right -> 4
node(47,2,4,18).
left_node(47,2,3).
right_node(47,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(47,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(47,4,0).
% node 5: f3 <= 145.0  (F3, bin <= 20)  left -> 6, right -> 7
node(47,5,3,20).
left_node(47,5,6).
right_node(47,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(47,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(47,7,0).
% node 8: f3 <= 138.0  (F3, bin <= 16)  left -> 9, right -> 12
node(47,8,3,16).
left_node(47,8,9).
right_node(47,8,12).
% node 9: f2 <= 3.5  (F2, bin <= 2)  left -> 10, right -> 11
node(47,9,2,2).
left_node(47,9,10).
right_node(47,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(47,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(47,11,1).
% node 12: f2 <= 2.5  (F2, bin <= 1)  left -> 13, right -> 14
node(47,12,2,1).
left_node(47,12,13).
right_node(47,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(47,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(47,14,0).

% Tree 48
tree(48).
% node 0: f7 <= 159.0  (F7, bin <= 35)  left -> 1, right -> 8
node(48,0,7,35).
left_node(48,0,1).
right_node(48,0,8).
% node 1: f1 <= 0.5  (F1, bin <= 0)  left -> 2, right -> 5
node(48,1,1,0).
left_node(48,1,2).
right_node(48,1,5).
% node 2: f7 <= 155.5  (F7, bin <= 32)  left -> 3, right -> 4
node(48,2,7,32).
left_node(48,2,3).
right_node(48,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(48,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(48,4,1).
% node 5: f9 <= 1.25  (F9, bin <= 4)  left -> 6, right -> 7
node(48,5,9,4).
left_node(48,5,6).
right_node(48,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(48,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(48,7,1).
% node 8: f0 <= 40.5  (F0, bin <= 6)  left -> 9, right -> 10
node(48,8,0,6).
left_node(48,8,9).
right_node(48,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(48,9,0).
% node 10: f7 <= 167.5  (F7, bin <= 38)  left -> 11, right -> 12
node(48,10,7,38).
left_node(48,10,11).
right_node(48,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(48,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(48,12,0).

% Tree 49
tree(49).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 6
node(49,0,9,4).
left_node(49,0,1).
right_node(49,0,6).
% node 1: f4 <= 430.0  (F4, bin <= 45)  left -> 2, right -> 5
node(49,1,4,45).
left_node(49,1,2).
right_node(49,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(49,2,8,0).
left_node(49,2,3).
right_node(49,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(49,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(49,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(49,5,1).
% node 6: f2 <= 3.5  (F2, bin <= 2)  left -> 7, right -> 10
node(49,6,2,2).
left_node(49,6,7).
right_node(49,6,10).
% node 7: f7 <= 144.0  (F7, bin <= 23)  left -> 8, right -> 9
node(49,7,7,23).
left_node(49,7,8).
right_node(49,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(49,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(49,9,0).
% node 10: f7 <= 166.5  (F7, bin <= 37)  left -> 11, right -> 12
node(49,10,7,37).
left_node(49,10,11).
right_node(49,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(49,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(49,12,0).

% Tree 50
tree(50).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(50,0,9,3).
left_node(50,0,1).
right_node(50,0,8).
% node 1: f7 <= 136.5  (F7, bin <= 18)  left -> 2, right -> 5
node(50,1,7,18).
left_node(50,1,2).
right_node(50,1,5).
% node 2: f4 <= 479.5  (F4, bin <= 47)  left -> 3, right -> 4
node(50,2,4,47).
left_node(50,2,3).
right_node(50,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(50,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(50,4,1).
% node 5: f2 <= 3.5  (F2, bin <= 2)  left -> 6, right -> 7
node(50,5,2,2).
left_node(50,5,6).
right_node(50,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(50,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(50,7,0).
% node 8: f3 <= 132.5  (F3, bin <= 12)  left -> 9, right -> 12
node(50,8,3,12).
left_node(50,8,9).
right_node(50,8,12).
% node 9: f4 <= 296.0  (F4, bin <= 38)  left -> 10, right -> 11
node(50,9,4,38).
left_node(50,9,10).
right_node(50,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(50,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(50,11,1).
% node 12: f2 <= 2.5  (F2, bin <= 1)  left -> 13, right -> 14
node(50,12,2,1).
left_node(50,12,13).
right_node(50,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(50,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(50,14,1).

% Tree 51
tree(51).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 6
node(51,0,8,0).
left_node(51,0,1).
right_node(51,0,6).
% node 1: f4 <= 479.5  (F4, bin <= 47)  left -> 2, right -> 5
node(51,1,4,47).
left_node(51,1,2).
right_node(51,1,5).
% node 2: f9 <= 1.75  (F9, bin <= 6)  left -> 3, right -> 4
node(51,2,9,6).
left_node(51,2,3).
right_node(51,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(51,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(51,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(51,5,1).
% node 6: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 7, right -> 10
node(51,6,9,3).
left_node(51,6,7).
right_node(51,6,10).
% node 7: f7 <= 122.0  (F7, bin <= 9)  left -> 8, right -> 9
node(51,7,7,9).
left_node(51,7,8).
right_node(51,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(51,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(51,9,0).
% node 10: f2 <= 3.5  (F2, bin <= 2)  left -> 11, right -> 12
node(51,10,2,2).
left_node(51,10,11).
right_node(51,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(51,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(51,12,1).

% Tree 52
tree(52).
% node 0: f7 <= 134.5  (F7, bin <= 16)  left -> 1, right -> 8
node(52,0,7,16).
left_node(52,0,1).
right_node(52,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(52,1,8,0).
left_node(52,1,2).
right_node(52,1,5).
% node 2: f2 <= 2.5  (F2, bin <= 1)  left -> 3, right -> 4
node(52,2,2,1).
left_node(52,2,3).
right_node(52,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(52,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(52,4,1).
% node 5: f0 <= 49.5  (F0, bin <= 13)  left -> 6, right -> 7
node(52,5,0,13).
left_node(52,5,6).
right_node(52,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(52,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(52,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(52,8,8,0).
left_node(52,8,9).
right_node(52,8,12).
% node 9: f9 <= 1.75  (F9, bin <= 6)  left -> 10, right -> 11
node(52,9,9,6).
left_node(52,9,10).
right_node(52,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(52,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(52,11,1).
% node 12: f9 <= 0.5  (F9, bin <= 1)  left -> 13, right -> 14
node(52,12,9,1).
left_node(52,12,13).
right_node(52,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(52,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(52,14,1).

% Tree 53
tree(53).
% node 0: f5 <= 0.5  (F5, bin <= 0)  left -> 1, right -> 8
node(53,0,5,0).
left_node(53,0,1).
right_node(53,0,8).
% node 1: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 2, right -> 5
node(53,1,9,3).
left_node(53,1,2).
right_node(53,1,5).
% node 2: f4 <= 290.0  (F4, bin <= 36)  left -> 3, right -> 4
node(53,2,4,36).
left_node(53,2,3).
right_node(53,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(53,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(53,4,0).
% node 5: f2 <= 3.5  (F2, bin <= 2)  left -> 6, right -> 7
node(53,5,2,2).
left_node(53,5,6).
right_node(53,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(53,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(53,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(53,8,8,0).
left_node(53,8,9).
right_node(53,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(53,9,1,0).
left_node(53,9,10).
right_node(53,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(53,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(53,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(53,12,1).

% Tree 54
tree(54).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(54,0,2,2).
left_node(54,0,1).
right_node(54,0,8).
% node 1: f9 <= 0.5  (F9, bin <= 1)  left -> 2, right -> 5
node(54,1,9,1).
left_node(54,1,2).
right_node(54,1,5).
% node 2: f5 <= 0.5  (F5, bin <= 0)  left -> 3, right -> 4
node(54,2,5,0).
left_node(54,2,3).
right_node(54,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(54,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(54,4,0).
% node 5: f7 <= 148.0  (F7, bin <= 27)  left -> 6, right -> 7
node(54,5,7,27).
left_node(54,5,6).
right_node(54,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(54,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(54,7,1).
% node 8: f4 <= 169.5  (F4, bin <= 5)  left -> 9, right -> 12
node(54,8,4,5).
left_node(54,8,9).
right_node(54,8,12).
% node 9: f9 <= 2.25  (F9, bin <= 7)  left -> 10, right -> 11
node(54,9,9,7).
left_node(54,9,10).
right_node(54,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(54,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(54,11,1).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(54,12,1,0).
left_node(54,12,13).
right_node(54,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(54,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(54,14,1).

% Tree 55
tree(55).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(55,0,2,2).
left_node(55,0,1).
right_node(55,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(55,1,8,0).
left_node(55,1,2).
right_node(55,1,5).
% node 2: f9 <= 1.5  (F9, bin <= 5)  left -> 3, right -> 4
node(55,2,9,5).
left_node(55,2,3).
right_node(55,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(55,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(55,4,1).
% node 5: f0 <= 53.0  (F0, bin <= 16)  left -> 6, right -> 7
node(55,5,0,16).
left_node(55,5,6).
right_node(55,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(55,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(55,7,1).
% node 8: f3 <= 155.0  (F3, bin <= 22)  left -> 9, right -> 12
node(55,8,3,22).
left_node(55,8,9).
right_node(55,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(55,9,1,0).
left_node(55,9,10).
right_node(55,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(55,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(55,11,1).
% node 12: f4 <= 339.0  (F4, bin <= 42)  left -> 13, right -> 14
node(55,12,4,42).
left_node(55,12,13).
right_node(55,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(55,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(55,14,0).

% Tree 56
tree(56).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 6
node(56,0,2,2).
left_node(56,0,1).
right_node(56,0,6).
% node 1: f5 <= 0.5  (F5, bin <= 0)  left -> 2, right -> 5
node(56,1,5,0).
left_node(56,1,2).
right_node(56,1,5).
% node 2: f4 <= 161.5  (F4, bin <= 3)  left -> 3, right -> 4
node(56,2,4,3).
left_node(56,2,3).
right_node(56,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(56,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(56,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(56,5,1).
% node 6: f4 <= 262.0  (F4, bin <= 24)  left -> 7, right -> 10
node(56,6,4,24).
left_node(56,6,7).
right_node(56,6,10).
% node 7: f1 <= 0.5  (F1, bin <= 0)  left -> 8, right -> 9
node(56,7,1,0).
left_node(56,7,8).
right_node(56,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(56,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(56,9,1).
% node 10: f9 <= 1.25  (F9, bin <= 4)  left -> 11, right -> 12
node(56,10,9,4).
left_node(56,10,11).
right_node(56,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(56,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(56,12,1).

% Tree 57
tree(57).
% node 0: f7 <= 126.5  (F7, bin <= 11)  left -> 1, right -> 6
node(57,0,7,11).
left_node(57,0,1).
right_node(57,0,6).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(57,1,9,4).
left_node(57,1,2).
right_node(57,1,5).
% node 2: f7 <= 97.0  (F7, bin <= 1)  left -> 3, right -> 4
node(57,2,7,1).
left_node(57,2,3).
right_node(57,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(57,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(57,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(57,5,1).
% node 6: f8 <= 0.5  (F8, bin <= 0)  left -> 7, right -> 10
node(57,6,8,0).
left_node(57,6,7).
right_node(57,6,10).
% node 7: f6 <= 0.5  (F6, bin <= 0)  left -> 8, right -> 9
node(57,7,6,0).
left_node(57,7,8).
right_node(57,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(57,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(57,9,0).
% node 10: f1 <= 0.5  (F1, bin <= 0)  left -> 11, right -> 12
node(57,10,1,0).
left_node(57,10,11).
right_node(57,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(57,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(57,12,1).

% Tree 58
tree(58).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(58,0,8,0).
left_node(58,0,1).
right_node(58,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(58,1,2,1).
left_node(58,1,2).
right_node(58,1,5).
% node 2: f7 <= 135.5  (F7, bin <= 17)  left -> 3, right -> 4
node(58,2,7,17).
left_node(58,2,3).
right_node(58,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(58,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(58,4,0).
% node 5: f0 <= 48.5  (F0, bin <= 12)  left -> 6, right -> 7
node(58,5,0,12).
left_node(58,5,6).
right_node(58,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(58,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(58,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(58,8,9,4).
left_node(58,8,9).
right_node(58,8,12).
% node 9: f7 <= 119.5  (F7, bin <= 8)  left -> 10, right -> 11
node(58,9,7,8).
left_node(58,9,10).
right_node(58,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(58,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(58,11,1).
% node 12: f7 <= 110.0  (F7, bin <= 6)  left -> 13, right -> 14
node(58,12,7,6).
left_node(58,12,13).
right_node(58,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(58,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(58,14,1).

% Tree 59
tree(59).
% node 0: f9 <= 0.5  (F9, bin <= 1)  left -> 1, right -> 8
node(59,0,9,1).
left_node(59,0,1).
right_node(59,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(59,1,8,0).
left_node(59,1,2).
right_node(59,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(59,2,2,2).
left_node(59,2,3).
right_node(59,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(59,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(59,4,0).
% node 5: f4 <= 151.0  (F4, bin <= 1)  left -> 6, right -> 7
node(59,5,4,1).
left_node(59,5,6).
right_node(59,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(59,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(59,7,1).
% node 8: f4 <= 282.0  (F4, bin <= 30)  left -> 9, right -> 12
node(59,8,4,30).
left_node(59,8,9).
right_node(59,8,12).
% node 9: f2 <= 3.5  (F2, bin <= 2)  left -> 10, right -> 11
node(59,9,2,2).
left_node(59,9,10).
right_node(59,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(59,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(59,11,1).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(59,12,1,0).
left_node(59,12,13).
right_node(59,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(59,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(59,14,1).

% Tree 60
tree(60).
% node 0: f0 <= 45.5  (F0, bin <= 9)  left -> 1, right -> 8
node(60,0,0,9).
left_node(60,0,1).
right_node(60,0,8).
% node 1: f9 <= 0.5  (F9, bin <= 1)  left -> 2, right -> 5
node(60,1,9,1).
left_node(60,1,2).
right_node(60,1,5).
% node 2: f0 <= 39.5  (F0, bin <= 5)  left -> 3, right -> 4
node(60,2,0,5).
left_node(60,2,3).
right_node(60,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(60,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(60,4,0).
% node 5: f7 <= 138.5  (F7, bin <= 19)  left -> 6, right -> 7
node(60,5,7,19).
left_node(60,5,6).
right_node(60,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(60,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(60,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(60,8,1,0).
left_node(60,8,9).
right_node(60,8,12).
% node 9: f8 <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(60,9,8,0).
left_node(60,9,10).
right_node(60,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(60,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(60,11,1).
% node 12: f8 <= 0.5  (F8, bin <= 0)  left -> 13, right -> 14
node(60,12,8,0).
left_node(60,12,13).
right_node(60,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(60,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(60,14,1).

% Tree 61
tree(61).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 6
node(61,0,9,3).
left_node(61,0,1).
right_node(61,0,6).
% node 1: f4 <= 442.5  (F4, bin <= 46)  left -> 2, right -> 5
node(61,1,4,46).
left_node(61,1,2).
right_node(61,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(61,2,8,0).
left_node(61,2,3).
right_node(61,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(61,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(61,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(61,5,1).
% node 6: f9 <= 1.25  (F9, bin <= 4)  left -> 7, right -> 10
node(61,6,9,4).
left_node(61,6,7).
right_node(61,6,10).
% node 7: f7 <= 143.5  (F7, bin <= 22)  left -> 8, right -> 9
node(61,7,7,22).
left_node(61,7,8).
right_node(61,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(61,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(61,9,1).
% node 10: f4 <= 261.5  (F4, bin <= 23)  left -> 11, right -> 12
node(61,10,4,23).
left_node(61,10,11).
right_node(61,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(61,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(61,12,1).

% Tree 62
tree(62).
% node 0: f4 <= 284.0  (F4, bin <= 31)  left -> 1, right -> 8
node(62,0,4,31).
left_node(62,0,1).
right_node(62,0,8).
% node 1: f1 <= 0.5  (F1, bin <= 0)  left -> 2, right -> 5
node(62,1,1,0).
left_node(62,1,2).
right_node(62,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(62,2,8,0).
left_node(62,2,3).
right_node(62,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(62,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(62,4,0).
% node 5: f2 <= 3.5  (F2, bin <= 2)  left -> 6, right -> 7
node(62,5,2,2).
left_node(62,5,6).
right_node(62,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(62,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(62,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(62,8,8,0).
left_node(62,8,9).
right_node(62,8,12).
% node 9: f4 <= 291.5  (F4, bin <= 37)  left -> 10, right -> 11
node(62,9,4,37).
left_node(62,9,10).
right_node(62,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(62,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(62,11,0).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(62,12,1,0).
left_node(62,12,13).
right_node(62,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(62,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(62,14,1).

% Tree 63
tree(63).
% node 0: f7 <= 153.5  (F7, bin <= 30)  left -> 1, right -> 8
node(63,0,7,30).
left_node(63,0,1).
right_node(63,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(63,1,8,0).
left_node(63,1,2).
right_node(63,1,5).
% node 2: f1 <= 0.5  (F1, bin <= 0)  left -> 3, right -> 4
node(63,2,1,0).
left_node(63,2,3).
right_node(63,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(63,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(63,4,0).
% node 5: f3 <= 123.0  (F3, bin <= 6)  left -> 6, right -> 7
node(63,5,3,6).
left_node(63,5,6).
right_node(63,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(63,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(63,7,1).
% node 8: f6 <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(63,8,6,0).
left_node(63,8,9).
right_node(63,8,12).
% node 9: f5 <= 0.5  (F5, bin <= 0)  left -> 10, right -> 11
node(63,9,5,0).
left_node(63,9,10).
right_node(63,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(63,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(63,11,1).
% node 12: f2 <= 1.5  (F2, bin <= 0)  left -> 13, right -> 14
node(63,12,2,0).
left_node(63,12,13).
right_node(63,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(63,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(63,14,0).

% Tree 64
tree(64).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 6
node(64,0,1,0).
left_node(64,0,1).
right_node(64,0,6).
% node 1: f6 <= 0.5  (F6, bin <= 0)  left -> 2, right -> 5
node(64,1,6,0).
left_node(64,1,2).
right_node(64,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(64,2,8,0).
left_node(64,2,3).
right_node(64,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(64,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(64,4,1).
% node 5 (leaf): class 0 (0)
leaf_class(64,5,0).
% node 6: f2 <= 3.5  (F2, bin <= 2)  left -> 7, right -> 10
node(64,6,2,2).
left_node(64,6,7).
right_node(64,6,10).
% node 7: f2 <= 1.5  (F2, bin <= 0)  left -> 8, right -> 9
node(64,7,2,0).
left_node(64,7,8).
right_node(64,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(64,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(64,9,0).
% node 10: f4 <= 184.0  (F4, bin <= 9)  left -> 11, right -> 12
node(64,10,4,9).
left_node(64,10,11).
right_node(64,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(64,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(64,12,1).

% Tree 65
tree(65).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(65,0,2,2).
left_node(65,0,1).
right_node(65,0,8).
% node 1: f2 <= 1.5  (F2, bin <= 0)  left -> 2, right -> 5
node(65,1,2,0).
left_node(65,1,2).
right_node(65,1,5).
% node 2: f3 <= 130.0  (F3, bin <= 11)  left -> 3, right -> 4
node(65,2,3,11).
left_node(65,2,3).
right_node(65,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(65,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(65,4,1).
% node 5: f9 <= 2.5  (F9, bin <= 8)  left -> 6, right -> 7
node(65,5,9,8).
left_node(65,5,6).
right_node(65,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(65,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(65,7,1).
% node 8: f0 <= 51.5  (F0, bin <= 14)  left -> 9, right -> 12
node(65,8,0,14).
left_node(65,8,9).
right_node(65,8,12).
% node 9: f9 <= 1.25  (F9, bin <= 4)  left -> 10, right -> 11
node(65,9,9,4).
left_node(65,9,10).
right_node(65,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(65,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(65,11,1).
% node 12: f3 <= 132.5  (F3, bin <= 12)  left -> 13, right -> 14
node(65,12,3,12).
left_node(65,12,13).
right_node(65,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(65,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(65,14,1).

% Tree 66
tree(66).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 8
node(66,0,9,4).
left_node(66,0,1).
right_node(66,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(66,1,8,0).
left_node(66,1,2).
right_node(66,1,5).
% node 2: f4 <= 247.0  (F4, bin <= 20)  left -> 3, right -> 4
node(66,2,4,20).
left_node(66,2,3).
right_node(66,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(66,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(66,4,0).
% node 5: f7 <= 155.0  (F7, bin <= 32)  left -> 6, right -> 7
node(66,5,7,32).
left_node(66,5,6).
right_node(66,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(66,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(66,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 10
node(66,8,1,0).
left_node(66,8,9).
right_node(66,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(66,9,0).
% node 10: f3 <= 124.5  (F3, bin <= 7)  left -> 11, right -> 12
node(66,10,3,7).
left_node(66,10,11).
right_node(66,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(66,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(66,12,1).

% Tree 67
tree(67).
% node 0: f9 <= 0.75  (F9, bin <= 2)  left -> 1, right -> 6
node(67,0,9,2).
left_node(67,0,1).
right_node(67,0,6).
% node 1: f4 <= 493.0  (F4, bin <= 48)  left -> 2, right -> 5
node(67,1,4,48).
left_node(67,1,2).
right_node(67,1,5).
% node 2: f0 <= 34.0  (F0, bin <= 1)  left -> 3, right -> 4
node(67,2,0,1).
left_node(67,2,3).
right_node(67,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(67,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(67,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(67,5,1).
% node 6: f1 <= 0.5  (F1, bin <= 0)  left -> 7, right -> 8
node(67,6,1,0).
left_node(67,6,7).
right_node(67,6,8).
% node 7 (leaf): class 0 (0)
leaf_class(67,7,0).
% node 8: f9 <= 2.75  (F9, bin <= 9)  left -> 9, right -> 10
node(67,8,9,9).
left_node(67,8,9).
right_node(67,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(67,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(67,10,0).

% Tree 68
tree(68).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(68,0,2,2).
left_node(68,0,1).
right_node(68,0,8).
% node 1: f9 <= 1.25  (F9, bin <= 4)  left -> 2, right -> 5
node(68,1,9,4).
left_node(68,1,2).
right_node(68,1,5).
% node 2: f3 <= 127.5  (F3, bin <= 9)  left -> 3, right -> 4
node(68,2,3,9).
left_node(68,2,3).
right_node(68,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(68,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(68,4,0).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(68,5,1,0).
left_node(68,5,6).
right_node(68,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(68,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(68,7,1).
% node 8: f7 <= 168.0  (F7, bin <= 39)  left -> 9, right -> 12
node(68,8,7,39).
left_node(68,8,9).
right_node(68,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(68,9,1,0).
left_node(68,9,10).
right_node(68,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(68,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(68,11,1).
% node 12: f7 <= 172.5  (F7, bin <= 41)  left -> 13, right -> 14
node(68,12,7,41).
left_node(68,12,13).
right_node(68,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(68,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(68,14,0).

% Tree 69
tree(69).
% node 0: f0 <= 37.5  (F0, bin <= 3)  left -> 1, right -> 6
node(69,0,0,3).
left_node(69,0,1).
right_node(69,0,6).
% node 1: f9 <= 0.75  (F9, bin <= 2)  left -> 2, right -> 5
node(69,1,9,2).
left_node(69,1,2).
right_node(69,1,5).
% node 2: f3 <= 115.0  (F3, bin <= 2)  left -> 3, right -> 4
node(69,2,3,2).
left_node(69,2,3).
right_node(69,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(69,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(69,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(69,5,1).
% node 6: f9 <= 0.75  (F9, bin <= 2)  left -> 7, right -> 10
node(69,6,9,2).
left_node(69,6,7).
right_node(69,6,10).
% node 7: f4 <= 479.5  (F4, bin <= 47)  left -> 8, right -> 9
node(69,7,4,47).
left_node(69,7,8).
right_node(69,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(69,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(69,9,1).
% node 10: f7 <= 127.0  (F7, bin <= 12)  left -> 11, right -> 12
node(69,10,7,12).
left_node(69,10,11).
right_node(69,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(69,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(69,12,1).

% Tree 70
tree(70).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 6
node(70,0,2,2).
left_node(70,0,1).
right_node(70,0,6).
% node 1: f0 <= 42.5  (F0, bin <= 7)  left -> 2, right -> 3
node(70,1,0,7).
left_node(70,1,2).
right_node(70,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(70,2,0).
% node 3: f2 <= 1.5  (F2, bin <= 0)  left -> 4, right -> 5
node(70,3,2,0).
left_node(70,3,4).
right_node(70,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(70,4,1).
% node 5 (leaf): class 0 (0)
leaf_class(70,5,0).
% node 6: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 7, right -> 10
node(70,6,9,3).
left_node(70,6,7).
right_node(70,6,10).
% node 7: f6 <= 0.5  (F6, bin <= 0)  left -> 8, right -> 9
node(70,7,6,0).
left_node(70,7,8).
right_node(70,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(70,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(70,9,0).
% node 10: f1 <= 0.5  (F1, bin <= 0)  left -> 11, right -> 12
node(70,10,1,0).
left_node(70,10,11).
right_node(70,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(70,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(70,12,1).

% Tree 71
tree(71).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(71,0,2,2).
left_node(71,0,1).
right_node(71,0,8).
% node 1: f4 <= 287.5  (F4, bin <= 34)  left -> 2, right -> 5
node(71,1,4,34).
left_node(71,1,2).
right_node(71,1,5).
% node 2: f2 <= 2.5  (F2, bin <= 1)  left -> 3, right -> 4
node(71,2,2,1).
left_node(71,2,3).
right_node(71,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(71,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(71,4,0).
% node 5: f0 <= 42.0  (F0, bin <= 7)  left -> 6, right -> 7
node(71,5,0,7).
left_node(71,5,6).
right_node(71,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(71,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(71,7,1).
% node 8: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 9, right -> 12
node(71,8,9,3).
left_node(71,8,9).
right_node(71,8,12).
% node 9: f0 <= 61.0  (F0, bin <= 22)  left -> 10, right -> 11
node(71,9,0,22).
left_node(71,9,10).
right_node(71,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(71,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(71,11,1).
% node 12: f4 <= 167.5  (F4, bin <= 4)  left -> 13, right -> 14
node(71,12,4,4).
left_node(71,12,13).
right_node(71,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(71,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(71,14,1).

% Tree 72
tree(72).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 6
node(72,0,2,2).
left_node(72,0,1).
right_node(72,0,6).
% node 1: f7 <= 135.5  (F7, bin <= 17)  left -> 2, right -> 3
node(72,1,7,17).
left_node(72,1,2).
right_node(72,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(72,2,0).
% node 3: f7 <= 158.0  (F7, bin <= 34)  left -> 4, right -> 5
node(72,3,7,34).
left_node(72,3,4).
right_node(72,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(72,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(72,5,0).
% node 6: f0 <= 38.5  (F0, bin <= 4)  left -> 7, right -> 8
node(72,6,0,4).
left_node(72,6,7).
right_node(72,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(72,7,1).
% node 8: f0 <= 56.5  (F0, bin <= 19)  left -> 9, right -> 10
node(72,8,0,19).
left_node(72,8,9).
right_node(72,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(72,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(72,10,0).

% Tree 73
tree(73).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(73,0,8,0).
left_node(73,0,1).
right_node(73,0,8).
% node 1: f4 <= 224.5  (F4, bin <= 13)  left -> 2, right -> 5
node(73,1,4,13).
left_node(73,1,2).
right_node(73,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(73,2,2,2).
left_node(73,2,3).
right_node(73,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(73,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(73,4,1).
% node 5: f3 <= 121.0  (F3, bin <= 5)  left -> 6, right -> 7
node(73,5,3,5).
left_node(73,5,6).
right_node(73,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(73,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(73,7,0).
% node 8: f3 <= 175.0  (F3, bin <= 24)  left -> 9, right -> 12
node(73,8,3,24).
left_node(73,8,9).
right_node(73,8,12).
% node 9: f0 <= 45.5  (F0, bin <= 9)  left -> 10, right -> 11
node(73,9,0,9).
left_node(73,9,10).
right_node(73,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(73,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(73,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(73,12,0).

% Tree 74
tree(74).
% node 0: f9 <= 0.75  (F9, bin <= 2)  left -> 1, right -> 8
node(74,0,9,2).
left_node(74,0,1).
right_node(74,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(74,1,2,2).
left_node(74,1,2).
right_node(74,1,5).
% node 2: f4 <= 285.5  (F4, bin <= 32)  left -> 3, right -> 4
node(74,2,4,32).
left_node(74,2,3).
right_node(74,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(74,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(74,4,0).
% node 5: f3 <= 119.0  (F3, bin <= 4)  left -> 6, right -> 7
node(74,5,3,4).
left_node(74,5,6).
right_node(74,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(74,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(74,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(74,8,1,0).
left_node(74,8,9).
right_node(74,8,12).
% node 9: f9 <= 1.75  (F9, bin <= 6)  left -> 10, right -> 11
node(74,9,9,6).
left_node(74,9,10).
right_node(74,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(74,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(74,11,0).
% node 12: f7 <= 127.0  (F7, bin <= 12)  left -> 13, right -> 14
node(74,12,7,12).
left_node(74,12,13).
right_node(74,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(74,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(74,14,1).

% Tree 75
tree(75).
% node 0: f0 <= 32.5  (F0, bin <= 0)  left -> 1, right -> 2
node(75,0,0,0).
left_node(75,0,1).
right_node(75,0,2).
% node 1 (leaf): class 0 (0)
leaf_class(75,1,0).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 6
node(75,2,2,2).
left_node(75,2,3).
right_node(75,2,6).
% node 3: f4 <= 182.0  (F4, bin <= 7)  left -> 4, right -> 5
node(75,3,4,7).
left_node(75,3,4).
right_node(75,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(75,4,1).
% node 5 (leaf): class 0 (0)
leaf_class(75,5,0).
% node 6: f3 <= 155.0  (F3, bin <= 22)  left -> 7, right -> 8
node(75,6,3,22).
left_node(75,6,7).
right_node(75,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(75,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(75,8,1).

% Tree 76
tree(76).
% node 0: f3 <= 143.5  (F3, bin <= 19)  left -> 1, right -> 8
node(76,0,3,19).
left_node(76,0,1).
right_node(76,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(76,1,8,0).
left_node(76,1,2).
right_node(76,1,5).
% node 2: f0 <= 53.5  (F0, bin <= 16)  left -> 3, right -> 4
node(76,2,0,16).
left_node(76,2,3).
right_node(76,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(76,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(76,4,0).
% node 5: f9 <= 0.5  (F9, bin <= 1)  left -> 6, right -> 7
node(76,5,9,1).
left_node(76,5,6).
right_node(76,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(76,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(76,7,1).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(76,8,9,4).
left_node(76,8,9).
right_node(76,8,12).
% node 9: f7 <= 152.0  (F7, bin <= 29)  left -> 10, right -> 11
node(76,9,7,29).
left_node(76,9,10).
right_node(76,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(76,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(76,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(76,12,1).

% Tree 77
tree(77).
% node 0: f7 <= 159.0  (F7, bin <= 35)  left -> 1, right -> 8
node(77,0,7,35).
left_node(77,0,1).
right_node(77,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(77,1,8,0).
left_node(77,1,2).
right_node(77,1,5).
% node 2: f0 <= 43.5  (F0, bin <= 8)  left -> 3, right -> 4
node(77,2,0,8).
left_node(77,2,3).
right_node(77,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(77,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(77,4,0).
% node 5: f9 <= 1.25  (F9, bin <= 4)  left -> 6, right -> 7
node(77,5,9,4).
left_node(77,5,6).
right_node(77,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(77,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(77,7,1).
% node 8: f4 <= 210.0  (F4, bin <= 11)  left -> 9, right -> 12
node(77,8,4,11).
left_node(77,8,9).
right_node(77,8,12).
% node 9: f9 <= 0.5  (F9, bin <= 1)  left -> 10, right -> 11
node(77,9,9,1).
left_node(77,9,10).
right_node(77,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(77,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(77,11,0).
% node 12: f9 <= 2.5  (F9, bin <= 8)  left -> 13, right -> 14
node(77,12,9,8).
left_node(77,12,13).
right_node(77,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(77,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(77,14,1).

% Tree 78
tree(78).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 6
node(78,0,8,0).
left_node(78,0,1).
right_node(78,0,6).
% node 1: f7 <= 102.5  (F7, bin <= 3)  left -> 2, right -> 3
node(78,1,7,3).
left_node(78,1,2).
right_node(78,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(78,2,0).
% node 3: f4 <= 479.5  (F4, bin <= 47)  left -> 4, right -> 5
node(78,3,4,47).
left_node(78,3,4).
right_node(78,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(78,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(78,5,1).
% node 6: f9 <= 1.25  (F9, bin <= 4)  left -> 7, right -> 10
node(78,6,9,4).
left_node(78,6,7).
right_node(78,6,10).
% node 7: f1 <= 0.5  (F1, bin <= 0)  left -> 8, right -> 9
node(78,7,1,0).
left_node(78,7,8).
right_node(78,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(78,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(78,9,1).
% node 10: f1 <= 0.5  (F1, bin <= 0)  left -> 11, right -> 12
node(78,10,1,0).
left_node(78,10,11).
right_node(78,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(78,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(78,12,1).

% Tree 79
tree(79).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 8
node(79,0,1,0).
left_node(79,0,1).
right_node(79,0,8).
% node 1: f3 <= 134.0  (F3, bin <= 14)  left -> 2, right -> 5
node(79,1,3,14).
left_node(79,1,2).
right_node(79,1,5).
% node 2: f0 <= 53.5  (F0, bin <= 16)  left -> 3, right -> 4
node(79,2,0,16).
left_node(79,2,3).
right_node(79,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(79,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(79,4,0).
% node 5: f2 <= 2.5  (F2, bin <= 1)  left -> 6, right -> 7
node(79,5,2,1).
left_node(79,5,6).
right_node(79,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(79,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(79,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(79,8,8,0).
left_node(79,8,9).
right_node(79,8,12).
% node 9: f0 <= 57.0  (F0, bin <= 20)  left -> 10, right -> 11
node(79,9,0,20).
left_node(79,9,10).
right_node(79,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(79,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(79,11,1).
% node 12: f0 <= 52.5  (F0, bin <= 15)  left -> 13, right -> 14
node(79,12,0,15).
left_node(79,12,13).
right_node(79,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(79,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(79,14,1).

% Tree 80
tree(80).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(80,0,8,0).
left_node(80,0,1).
right_node(80,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(80,1,2,2).
left_node(80,1,2).
right_node(80,1,5).
% node 2: f4 <= 263.5  (F4, bin <= 25)  left -> 3, right -> 4
node(80,2,4,25).
left_node(80,2,3).
right_node(80,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(80,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(80,4,0).
% node 5: f0 <= 51.5  (F0, bin <= 14)  left -> 6, right -> 7
node(80,5,0,14).
left_node(80,5,6).
right_node(80,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(80,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(80,7,1).
% node 8: f4 <= 230.0  (F4, bin <= 15)  left -> 9, right -> 12
node(80,8,4,15).
left_node(80,8,9).
right_node(80,8,12).
% node 9: f3 <= 139.0  (F3, bin <= 17)  left -> 10, right -> 11
node(80,9,3,17).
left_node(80,9,10).
right_node(80,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(80,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(80,11,0).
% node 12: f9 <= 2.75  (F9, bin <= 9)  left -> 13, right -> 14
node(80,12,9,9).
left_node(80,12,13).
right_node(80,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(80,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(80,14,1).

% Tree 81
tree(81).
% node 0: f9 <= 0.75  (F9, bin <= 2)  left -> 1, right -> 8
node(81,0,9,2).
left_node(81,0,1).
right_node(81,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(81,1,2,2).
left_node(81,1,2).
right_node(81,1,5).
% node 2: f5 <= 0.5  (F5, bin <= 0)  left -> 3, right -> 4
node(81,2,5,0).
left_node(81,2,3).
right_node(81,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(81,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(81,4,0).
% node 5: f4 <= 223.0  (F4, bin <= 12)  left -> 6, right -> 7
node(81,5,4,12).
left_node(81,5,6).
right_node(81,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(81,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(81,7,0).
% node 8: f7 <= 167.5  (F7, bin <= 38)  left -> 9, right -> 12
node(81,8,7,38).
left_node(81,8,9).
right_node(81,8,12).
% node 9: f8 <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(81,9,8,0).
left_node(81,9,10).
right_node(81,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(81,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(81,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(81,12,0).

% Tree 82
tree(82).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(82,0,9,3).
left_node(82,0,1).
right_node(82,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(82,1,2,2).
left_node(82,1,2).
right_node(82,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(82,2,8,0).
left_node(82,2,3).
right_node(82,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(82,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(82,4,1).
% node 5: f0 <= 54.0  (F0, bin <= 17)  left -> 6, right -> 7
node(82,5,0,17).
left_node(82,5,6).
right_node(82,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(82,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(82,7,0).
% node 8: f2 <= 3.5  (F2, bin <= 2)  left -> 9, right -> 12
node(82,8,2,2).
left_node(82,8,9).
right_node(82,8,12).
% node 9: f3 <= 133.0  (F3, bin <= 13)  left -> 10, right -> 11
node(82,9,3,13).
left_node(82,9,10).
right_node(82,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(82,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(82,11,0).
% node 12: f3 <= 134.0  (F3, bin <= 14)  left -> 13, right -> 14
node(82,12,3,14).
left_node(82,12,13).
right_node(82,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(82,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(82,14,1).

% Tree 83
tree(83).
% node 0: f9 <= 0.5  (F9, bin <= 1)  left -> 1, right -> 8
node(83,0,9,1).
left_node(83,0,1).
right_node(83,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(83,1,8,0).
left_node(83,1,2).
right_node(83,1,5).
% node 2: f3 <= 119.0  (F3, bin <= 4)  left -> 3, right -> 4
node(83,2,3,4).
left_node(83,2,3).
right_node(83,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(83,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(83,4,0).
% node 5: f3 <= 130.0  (F3, bin <= 11)  left -> 6, right -> 7
node(83,5,3,11).
left_node(83,5,6).
right_node(83,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(83,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(83,7,0).
% node 8: f7 <= 109.0  (F7, bin <= 5)  left -> 9, right -> 10
node(83,8,7,5).
left_node(83,8,9).
right_node(83,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(83,9,1).
% node 10: f4 <= 332.0  (F4, bin <= 40)  left -> 11, right -> 12
node(83,10,4,40).
left_node(83,10,11).
right_node(83,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(83,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(83,12,1).

% Tree 84
tree(84).
% node 0: f4 <= 261.5  (F4, bin <= 23)  left -> 1, right -> 8
node(84,0,4,23).
left_node(84,0,1).
right_node(84,0,8).
% node 1: f9 <= 0.75  (F9, bin <= 2)  left -> 2, right -> 5
node(84,1,9,2).
left_node(84,1,2).
right_node(84,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(84,2,2,2).
left_node(84,2,3).
right_node(84,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(84,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(84,4,0).
% node 5: f4 <= 252.5  (F4, bin <= 21)  left -> 6, right -> 7
node(84,5,4,21).
left_node(84,5,6).
right_node(84,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(84,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(84,7,0).
% node 8: f7 <= 165.0  (F7, bin <= 36)  left -> 9, right -> 12
node(84,8,7,36).
left_node(84,8,9).
right_node(84,8,12).
% node 9: f8 <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(84,9,8,0).
left_node(84,9,10).
right_node(84,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(84,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(84,11,1).
% node 12: f3 <= 115.0  (F3, bin <= 2)  left -> 13, right -> 14
node(84,12,3,2).
left_node(84,12,13).
right_node(84,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(84,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(84,14,0).

% Tree 85
tree(85).
% node 0: f9 <= 0.5  (F9, bin <= 1)  left -> 1, right -> 8
node(85,0,9,1).
left_node(85,0,1).
right_node(85,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 2)  left -> 2, right -> 5
node(85,1,2,2).
left_node(85,1,2).
right_node(85,1,5).
% node 2: f7 <= 179.0  (F7, bin <= 43)  left -> 3, right -> 4
node(85,2,7,43).
left_node(85,2,3).
right_node(85,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(85,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(85,4,0).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(85,5,1,0).
left_node(85,5,6).
right_node(85,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(85,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(85,7,0).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(85,8,8,0).
left_node(85,8,9).
right_node(85,8,12).
% node 9: f3 <= 114.0  (F3, bin <= 1)  left -> 10, right -> 11
node(85,9,3,1).
left_node(85,9,10).
right_node(85,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(85,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(85,11,0).
% node 12: f2 <= 3.5  (F2, bin <= 2)  left -> 13, right -> 14
node(85,12,2,2).
left_node(85,12,13).
right_node(85,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(85,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(85,14,1).

% Tree 86
tree(86).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(86,0,8,0).
left_node(86,0,1).
right_node(86,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(86,1,2,1).
left_node(86,1,2).
right_node(86,1,5).
% node 2: f2 <= 1.5  (F2, bin <= 0)  left -> 3, right -> 4
node(86,2,2,0).
left_node(86,2,3).
right_node(86,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(86,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(86,4,0).
% node 5: f4 <= 378.5  (F4, bin <= 44)  left -> 6, right -> 7
node(86,5,4,44).
left_node(86,5,6).
right_node(86,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(86,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(86,7,1).
% node 8: f0 <= 46.5  (F0, bin <= 10)  left -> 9, right -> 10
node(86,8,0,10).
left_node(86,8,9).
right_node(86,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(86,9,1).
% node 10: f3 <= 175.0  (F3, bin <= 24)  left -> 11, right -> 12
node(86,10,3,24).
left_node(86,10,11).
right_node(86,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(86,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(86,12,0).

% Tree 87
tree(87).
% node 0: f9 <= 0.5  (F9, bin <= 1)  left -> 1, right -> 8
node(87,0,9,1).
left_node(87,0,1).
right_node(87,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(87,1,2,1).
left_node(87,1,2).
right_node(87,1,5).
% node 2: f4 <= 158.0  (F4, bin <= 2)  left -> 3, right -> 4
node(87,2,4,2).
left_node(87,2,3).
right_node(87,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(87,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(87,4,0).
% node 5: f8 <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(87,5,8,0).
left_node(87,5,6).
right_node(87,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(87,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(87,7,1).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(87,8,9,4).
left_node(87,8,9).
right_node(87,8,12).
% node 9: f2 <= 2.5  (F2, bin <= 1)  left -> 10, right -> 11
node(87,9,2,1).
left_node(87,9,10).
right_node(87,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(87,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(87,11,1).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(87,12,1,0).
left_node(87,12,13).
right_node(87,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(87,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(87,14,1).

% Tree 88
tree(88).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 1, right -> 8
node(88,0,9,3).
left_node(88,0,1).
right_node(88,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(88,1,2,1).
left_node(88,1,2).
right_node(88,1,5).
% node 2: f4 <= 255.0  (F4, bin <= 22)  left -> 3, right -> 4
node(88,2,4,22).
left_node(88,2,3).
right_node(88,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(88,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(88,4,0).
% node 5: f7 <= 131.0  (F7, bin <= 15)  left -> 6, right -> 7
node(88,5,7,15).
left_node(88,5,6).
right_node(88,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(88,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(88,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(88,8,9,4).
left_node(88,8,9).
right_node(88,8,12).
% node 9: f4 <= 288.0  (F4, bin <= 35)  left -> 10, right -> 11
node(88,9,4,35).
left_node(88,9,10).
right_node(88,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(88,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(88,11,0).
% node 12: f1 <= 0.5  (F1, bin <= 0)  left -> 13, right -> 14
node(88,12,1,0).
left_node(88,12,13).
right_node(88,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(88,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(88,14,1).

% Tree 89
tree(89).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 8
node(89,0,9,4).
left_node(89,0,1).
right_node(89,0,8).
% node 1: f2 <= 2.5  (F2, bin <= 1)  left -> 2, right -> 5
node(89,1,2,1).
left_node(89,1,2).
right_node(89,1,5).
% node 2: f9 <= 0.5  (F9, bin <= 1)  left -> 3, right -> 4
node(89,2,9,1).
left_node(89,2,3).
right_node(89,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(89,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(89,4,0).
% node 5: f1 <= 0.5  (F1, bin <= 0)  left -> 6, right -> 7
node(89,5,1,0).
left_node(89,5,6).
right_node(89,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(89,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(89,7,0).
% node 8: f9 <= 2.75  (F9, bin <= 9)  left -> 9, right -> 12
node(89,8,9,9).
left_node(89,8,9).
right_node(89,8,12).
% node 9: f7 <= 144.5  (F7, bin <= 23)  left -> 10, right -> 11
node(89,9,7,23).
left_node(89,9,10).
right_node(89,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(89,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(89,11,1).
% node 12: f4 <= 226.5  (F4, bin <= 14)  left -> 13, right -> 14
node(89,12,4,14).
left_node(89,12,13).
right_node(89,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(89,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(89,14,0).

% Tree 90
tree(90).
% node 0: f2 <= 3.5  (F2, bin <= 2)  left -> 1, right -> 8
node(90,0,2,2).
left_node(90,0,1).
right_node(90,0,8).
% node 1: f3 <= 132.5  (F3, bin <= 12)  left -> 2, right -> 5
node(90,1,3,12).
left_node(90,1,2).
right_node(90,1,5).
% node 2: f0 <= 36.5  (F0, bin <= 2)  left -> 3, right -> 4
node(90,2,0,2).
left_node(90,2,3).
right_node(90,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(90,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(90,4,0).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(90,5,5,0).
left_node(90,5,6).
right_node(90,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(90,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(90,7,1).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(90,8,8,0).
left_node(90,8,9).
right_node(90,8,12).
% node 9: f1 <= 0.5  (F1, bin <= 0)  left -> 10, right -> 11
node(90,9,1,0).
left_node(90,9,10).
right_node(90,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(90,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(90,11,1).
% node 12: f9 <= 2.75  (F9, bin <= 9)  left -> 13, right -> 14
node(90,12,9,9).
left_node(90,12,13).
right_node(90,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(90,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(90,14,0).

% Tree 91
tree(91).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(91,0,8,0).
left_node(91,0,1).
right_node(91,0,8).
% node 1: f4 <= 223.5  (F4, bin <= 12)  left -> 2, right -> 5
node(91,1,4,12).
left_node(91,1,2).
right_node(91,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 2)  left -> 3, right -> 4
node(91,2,2,2).
left_node(91,2,3).
right_node(91,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(91,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(91,4,1).
% node 5: f9 <= 2.5  (F9, bin <= 8)  left -> 6, right -> 7
node(91,5,9,8).
left_node(91,5,6).
right_node(91,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(91,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(91,7,1).
% node 8: f7 <= 109.0  (F7, bin <= 5)  left -> 9, right -> 10
node(91,8,7,5).
left_node(91,8,9).
right_node(91,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(91,9,1).
% node 10: f0 <= 46.5  (F0, bin <= 10)  left -> 11, right -> 12
node(91,10,0,10).
left_node(91,10,11).
right_node(91,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(91,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(91,12,1).

% Tree 92
tree(92).
% node 0: f7 <= 97.0  (F7, bin <= 1)  left -> 1, right -> 2
node(92,0,7,1).
left_node(92,0,1).
right_node(92,0,2).
% node 1 (leaf): class 1 (1)
leaf_class(92,1,1).
% node 2: f9 <= 1.25  (F9, bin <= 4)  left -> 3, right -> 6
node(92,2,9,4).
left_node(92,2,3).
right_node(92,2,6).
% node 3: f8 <= 0.5  (F8, bin <= 0)  left -> 4, right -> 5
node(92,3,8,0).
left_node(92,3,4).
right_node(92,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(92,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(92,5,1).
% node 6: f7 <= 146.5  (F7, bin <= 25)  left -> 7, right -> 8
node(92,6,7,25).
left_node(92,6,7).
right_node(92,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(92,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(92,8,1).

% Tree 93
tree(93).
% node 0: f0 <= 45.5  (F0, bin <= 9)  left -> 1, right -> 8
node(93,0,0,9).
left_node(93,0,1).
right_node(93,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(93,1,8,0).
left_node(93,1,2).
right_node(93,1,5).
% node 2: f4 <= 255.5  (F4, bin <= 22)  left -> 3, right -> 4
node(93,2,4,22).
left_node(93,2,3).
right_node(93,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(93,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(93,4,0).
% node 5: f7 <= 156.0  (F7, bin <= 33)  left -> 6, right -> 7
node(93,5,7,33).
left_node(93,5,6).
right_node(93,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(93,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(93,7,0).
% node 8: f8 <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(93,8,8,0).
left_node(93,8,9).
right_node(93,8,12).
% node 9: f6 <= 0.5  (F6, bin <= 0)  left -> 10, right -> 11
node(93,9,6,0).
left_node(93,9,10).
right_node(93,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(93,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(93,11,0).
% node 12: f9 <= 1.25  (F9, bin <= 4)  left -> 13, right -> 14
node(93,12,9,4).
left_node(93,12,13).
right_node(93,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(93,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(93,14,1).

% Tree 94
tree(94).
% node 0: f9 <= 0.75  (F9, bin <= 2)  left -> 1, right -> 6
node(94,0,9,2).
left_node(94,0,1).
right_node(94,0,6).
% node 1: f1 <= 0.5  (F1, bin <= 0)  left -> 2, right -> 3
node(94,1,1,0).
left_node(94,1,2).
right_node(94,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(94,2,0).
% node 3: f8 <= 0.5  (F8, bin <= 0)  left -> 4, right -> 5
node(94,3,8,0).
left_node(94,3,4).
right_node(94,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(94,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(94,5,1).
% node 6: f2 <= 3.5  (F2, bin <= 2)  left -> 7, right -> 10
node(94,6,2,2).
left_node(94,6,7).
right_node(94,6,10).
% node 7: f4 <= 204.5  (F4, bin <= 10)  left -> 8, right -> 9
node(94,7,4,10).
left_node(94,7,8).
right_node(94,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(94,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(94,9,0).
% node 10: f3 <= 121.0  (F3, bin <= 5)  left -> 11, right -> 12
node(94,10,3,5).
left_node(94,10,11).
right_node(94,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(94,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(94,12,1).

% Tree 95
tree(95).
% node 0: f7 <= 153.5  (F7, bin <= 30)  left -> 1, right -> 8
node(95,0,7,30).
left_node(95,0,1).
right_node(95,0,8).
% node 1: f9 <= 0.9000000059604645  (F9, bin <= 3)  left -> 2, right -> 5
node(95,1,9,3).
left_node(95,1,2).
right_node(95,1,5).
% node 2: f8 <= 0.5  (F8, bin <= 0)  left -> 3, right -> 4
node(95,2,8,0).
left_node(95,2,3).
right_node(95,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(95,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(95,4,1).
% node 5: f2 <= 2.5  (F2, bin <= 1)  left -> 6, right -> 7
node(95,5,2,1).
left_node(95,5,6).
right_node(95,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(95,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(95,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 1)  left -> 9, right -> 12
node(95,8,9,1).
left_node(95,8,9).
right_node(95,8,12).
% node 9: f0 <= 38.5  (F0, bin <= 4)  left -> 10, right -> 11
node(95,9,0,4).
left_node(95,9,10).
right_node(95,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(95,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(95,11,0).
% node 12: f3 <= 130.0  (F3, bin <= 11)  left -> 13, right -> 14
node(95,12,3,11).
left_node(95,12,13).
right_node(95,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(95,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(95,14,1).

% Tree 96
tree(96).
% node 0: f9 <= 0.5  (F9, bin <= 1)  left -> 1, right -> 8
node(96,0,9,1).
left_node(96,0,1).
right_node(96,0,8).
% node 1: f0 <= 48.5  (F0, bin <= 12)  left -> 2, right -> 5
node(96,1,0,12).
left_node(96,1,2).
right_node(96,1,5).
% node 2: f4 <= 158.0  (F4, bin <= 2)  left -> 3, right -> 4
node(96,2,4,2).
left_node(96,2,3).
right_node(96,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(96,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(96,4,0).
% node 5: f3 <= 116.5  (F3, bin <= 3)  left -> 6, right -> 7
node(96,5,3,3).
left_node(96,5,6).
right_node(96,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(96,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(96,7,0).
% node 8: f1 <= 0.5  (F1, bin <= 0)  left -> 9, right -> 12
node(96,8,1,0).
left_node(96,8,9).
right_node(96,8,12).
% node 9: f0 <= 43.5  (F0, bin <= 8)  left -> 10, right -> 11
node(96,9,0,8).
left_node(96,9,10).
right_node(96,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(96,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(96,11,0).
% node 12: f0 <= 60.0  (F0, bin <= 21)  left -> 13, right -> 14
node(96,12,0,21).
left_node(96,12,13).
right_node(96,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(96,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(96,14,0).

% Tree 97
tree(97).
% node 0: f9 <= 1.25  (F9, bin <= 4)  left -> 1, right -> 8
node(97,0,9,4).
left_node(97,0,1).
right_node(97,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(97,1,8,0).
left_node(97,1,2).
right_node(97,1,5).
% node 2: f3 <= 111.0  (F3, bin <= 0)  left -> 3, right -> 4
node(97,2,3,0).
left_node(97,2,3).
right_node(97,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(97,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(97,4,0).
% node 5: f5 <= 0.5  (F5, bin <= 0)  left -> 6, right -> 7
node(97,5,5,0).
left_node(97,5,6).
right_node(97,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(97,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(97,7,1).
% node 8: f3 <= 132.5  (F3, bin <= 12)  left -> 9, right -> 12
node(97,8,3,12).
left_node(97,8,9).
right_node(97,8,12).
% node 9: f2 <= 3.5  (F2, bin <= 2)  left -> 10, right -> 11
node(97,9,2,2).
left_node(97,9,10).
right_node(97,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(97,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(97,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(97,12,1).

% Tree 98
tree(98).
% node 0: f5 <= 0.5  (F5, bin <= 0)  left -> 1, right -> 8
node(98,0,5,0).
left_node(98,0,1).
right_node(98,0,8).
% node 1: f0 <= 34.5  (F0, bin <= 1)  left -> 2, right -> 5
node(98,1,0,1).
left_node(98,1,2).
right_node(98,1,5).
% node 2: f4 <= 241.5  (F4, bin <= 17)  left -> 3, right -> 4
node(98,2,4,17).
left_node(98,2,3).
right_node(98,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(98,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(98,4,1).
% node 5: f8 <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(98,5,8,0).
left_node(98,5,6).
right_node(98,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(98,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(98,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 1)  left -> 9, right -> 12
node(98,8,9,1).
left_node(98,8,9).
right_node(98,8,12).
% node 9: f3 <= 127.5  (F3, bin <= 9)  left -> 10, right -> 11
node(98,9,3,9).
left_node(98,9,10).
right_node(98,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(98,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(98,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(98,12,1).

% Tree 99
tree(99).
% node 0: f9 <= 0.75  (F9, bin <= 2)  left -> 1, right -> 8
node(99,0,9,2).
left_node(99,0,1).
right_node(99,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(99,1,8,0).
left_node(99,1,2).
right_node(99,1,5).
% node 2: f2 <= 1.5  (F2, bin <= 0)  left -> 3, right -> 4
node(99,2,2,0).
left_node(99,2,3).
right_node(99,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(99,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(99,4,0).
% node 5: f4 <= 151.0  (F4, bin <= 1)  left -> 6, right -> 7
node(99,5,4,1).
left_node(99,5,6).
right_node(99,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(99,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(99,7,1).
% node 8: f9 <= 1.25  (F9, bin <= 4)  left -> 9, right -> 12
node(99,8,9,4).
left_node(99,8,9).
right_node(99,8,12).
% node 9: f7 <= 146.0  (F7, bin <= 25)  left -> 10, right -> 11
node(99,9,7,25).
left_node(99,9,10).
right_node(99,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(99,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(99,11,1).
% node 12: f7 <= 144.0  (F7, bin <= 23)  left -> 13, right -> 14
node(99,12,7,23).
left_node(99,12,13).
right_node(99,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(99,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(99,14,1).

% --- Class domain ---
class_idx(0).  % 0
class_idx(1).  % 1
