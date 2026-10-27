% ============================================================
% random_forest.lp — RF facts for heart+disease
% 10 trees  |  10 features
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

% Feature 0 (f0): 5 bins  (thresholds: [47.0, 47.5, 48.5, 54.5])
{bin(I,0,B) : B = 0..4} = 1 :- item(I).

% Feature 1 (f1): 2 bins  (thresholds: [0.5])
{bin(I,1,B) : B = 0..1} = 1 :- item(I).

% Feature 2 (f2): 3 bins  (thresholds: [2.5, 3.5])
{bin(I,2,B) : B = 0..2} = 1 :- item(I).

% Feature 3 (f3): 7 bins  (thresholds: [127.0, 127.5, 129.0, 132.5, 143.5, 147.5])
{bin(I,3,B) : B = 0..6} = 1 :- item(I).

% Feature 4 (f4): 8 bins  (thresholds: [223.5, 234.5, 237.5, 245.5, 263.5, 287.5, 292.5])
{bin(I,4,B) : B = 0..7} = 1 :- item(I).

% Feature 6 (f6): 2 bins  (thresholds: [0.5])
{bin(I,6,B) : B = 0..1} = 1 :- item(I).

% Feature 7 (f7): 9 bins  (thresholds: [121.0, 123.0, 124.5, 125.5, 126.5, 131.0, 146.0, 152.0])
{bin(I,7,B) : B = 0..8} = 1 :- item(I).

% Feature 8 (f8): 2 bins  (thresholds: [0.5])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).

% Feature 9 (f9): 4 bins  (thresholds: [0.5, 0.9000000059604645, 1.25])
{bin(I,9,B) : B = 0..3} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f7 <= 131.0  (F7, bin <= 5)  left -> 1, right -> 8
node(0,0,7,5).
left_node(0,0,1).
right_node(0,0,8).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(0,1,8,0).
left_node(0,1,2).
right_node(0,1,5).
% node 2: f7 <= 121.0  (F7, bin <= 0)  left -> 3, right -> 4
node(0,2,7,0).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(0,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(0,4,0).
% node 5: f7 <= 123.0  (F7, bin <= 1)  left -> 6, right -> 7
node(0,5,7,1).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(0,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(0,7,1).
% node 8: f9 <= 0.5  (F9, bin <= 0)  left -> 9, right -> 12
node(0,8,9,0).
left_node(0,8,9).
right_node(0,8,12).
% node 9: f4 <= 263.5  (F4, bin <= 4)  left -> 10, right -> 11
node(0,9,4,4).
left_node(0,9,10).
right_node(0,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(0,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(0,11,0).
% node 12: f0 <= 48.5  (F0, bin <= 2)  left -> 13, right -> 14
node(0,12,0,2).
left_node(0,12,13).
right_node(0,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(0,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(0,14,0).

% Tree 1
tree(1).
% node 0: f3 <= 143.5  (F3, bin <= 4)  left -> 1, right -> 6
node(1,0,3,4).
left_node(1,0,1).
right_node(1,0,6).
% node 1: f8 <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(1,1,8,0).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f9 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 4
node(1,2,9,0).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(1,3,0).
% node 4 (leaf): class 1 (1)
leaf_class(1,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(1,5,1).
% node 6: f7 <= 152.0  (F7, bin <= 7)  left -> 7, right -> 8
node(1,6,7,7).
left_node(1,6,7).
right_node(1,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(1,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(1,8,0).

% Tree 2
tree(2).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 6
node(2,0,8,0).
left_node(2,0,1).
right_node(2,0,6).
% node 1: f9 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 5
node(2,1,9,0).
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
% node 5 (leaf): class 0 (0)
leaf_class(2,5,0).
% node 6: f3 <= 129.0  (F3, bin <= 2)  left -> 7, right -> 8
node(2,6,3,2).
left_node(2,6,7).
right_node(2,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(2,7,1).
% node 8: f7 <= 124.5  (F7, bin <= 2)  left -> 9, right -> 10
node(2,8,7,2).
left_node(2,8,9).
right_node(2,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(2,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(2,10,1).

% Tree 3
tree(3).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 6
node(3,0,1,0).
left_node(3,0,1).
right_node(3,0,6).
% node 1: f3 <= 127.0  (F3, bin <= 0)  left -> 2, right -> 3
node(3,1,3,0).
left_node(3,1,2).
right_node(3,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(3,2,0).
% node 3: f2 <= 2.5  (F2, bin <= 0)  left -> 4, right -> 5
node(3,3,2,0).
left_node(3,3,4).
right_node(3,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(3,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(3,5,0).
% node 6: f4 <= 237.5  (F4, bin <= 2)  left -> 7, right -> 10
node(3,6,4,2).
left_node(3,6,7).
right_node(3,6,10).
% node 7: f2 <= 3.5  (F2, bin <= 1)  left -> 8, right -> 9
node(3,7,2,1).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(3,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(3,9,1).
% node 10: f2 <= 3.5  (F2, bin <= 1)  left -> 11, right -> 12
node(3,10,2,1).
left_node(3,10,11).
right_node(3,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(3,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(3,12,1).

% Tree 4
tree(4).
% node 0: f9 <= 0.9000000059604645  (F9, bin <= 1)  left -> 1, right -> 8
node(4,0,9,1).
left_node(4,0,1).
right_node(4,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 1)  left -> 2, right -> 5
node(4,1,2,1).
left_node(4,1,2).
right_node(4,1,5).
% node 2: f4 <= 287.5  (F4, bin <= 5)  left -> 3, right -> 4
node(4,2,4,5).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(4,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(4,4,0).
% node 5: f4 <= 234.5  (F4, bin <= 1)  left -> 6, right -> 7
node(4,5,4,1).
left_node(4,5,6).
right_node(4,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(4,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(4,7,0).
% node 8: f2 <= 2.5  (F2, bin <= 0)  left -> 9, right -> 10
node(4,8,2,0).
left_node(4,8,9).
right_node(4,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(4,9,0).
% node 10: f0 <= 47.5  (F0, bin <= 1)  left -> 11, right -> 12
node(4,10,0,1).
left_node(4,10,11).
right_node(4,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(4,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(4,12,1).

% Tree 5
tree(5).
% node 0: f8 <= 0.5  (F8, bin <= 0)  left -> 1, right -> 8
node(5,0,8,0).
left_node(5,0,1).
right_node(5,0,8).
% node 1: f2 <= 3.5  (F2, bin <= 1)  left -> 2, right -> 5
node(5,1,2,1).
left_node(5,1,2).
right_node(5,1,5).
% node 2: f3 <= 132.5  (F3, bin <= 3)  left -> 3, right -> 4
node(5,2,3,3).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(5,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(5,4,0).
% node 5: f7 <= 146.0  (F7, bin <= 6)  left -> 6, right -> 7
node(5,5,7,6).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(5,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(5,7,1).
% node 8: f6 <= 0.5  (F6, bin <= 0)  left -> 9, right -> 10
node(5,8,6,0).
left_node(5,8,9).
right_node(5,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(5,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(5,10,1).

% Tree 6
tree(6).
% node 0: f2 <= 3.5  (F2, bin <= 1)  left -> 1, right -> 8
node(6,0,2,1).
left_node(6,0,1).
right_node(6,0,8).
% node 1: f3 <= 132.5  (F3, bin <= 3)  left -> 2, right -> 5
node(6,1,3,3).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f3 <= 127.5  (F3, bin <= 1)  left -> 3, right -> 4
node(6,2,3,1).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(6,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(6,4,0).
% node 5: f3 <= 147.5  (F3, bin <= 5)  left -> 6, right -> 7
node(6,5,3,5).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(6,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(6,7,0).
% node 8: f9 <= 1.25  (F9, bin <= 2)  left -> 9, right -> 12
node(6,8,9,2).
left_node(6,8,9).
right_node(6,8,12).
% node 9: f7 <= 125.5  (F7, bin <= 3)  left -> 10, right -> 11
node(6,9,7,3).
left_node(6,9,10).
right_node(6,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(6,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(6,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(6,12,1).

% Tree 7
tree(7).
% node 0: f7 <= 126.5  (F7, bin <= 4)  left -> 1, right -> 4
node(7,0,7,4).
left_node(7,0,1).
right_node(7,0,4).
% node 1: f2 <= 3.5  (F2, bin <= 1)  left -> 2, right -> 3
node(7,1,2,1).
left_node(7,1,2).
right_node(7,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(7,2,0).
% node 3 (leaf): class 1 (1)
leaf_class(7,3,1).
% node 4: f4 <= 245.5  (F4, bin <= 3)  left -> 5, right -> 8
node(7,4,4,3).
left_node(7,4,5).
right_node(7,4,8).
% node 5: f4 <= 237.5  (F4, bin <= 2)  left -> 6, right -> 7
node(7,5,4,2).
left_node(7,5,6).
right_node(7,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(7,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(7,7,0).
% node 8: f9 <= 0.5  (F9, bin <= 0)  left -> 9, right -> 10
node(7,8,9,0).
left_node(7,8,9).
right_node(7,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(7,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(7,10,1).

% Tree 8
tree(8).
% node 0: f2 <= 3.5  (F2, bin <= 1)  left -> 1, right -> 6
node(8,0,2,1).
left_node(8,0,1).
right_node(8,0,6).
% node 1: f0 <= 54.5  (F0, bin <= 3)  left -> 2, right -> 5
node(8,1,0,3).
left_node(8,1,2).
right_node(8,1,5).
% node 2: f2 <= 2.5  (F2, bin <= 0)  left -> 3, right -> 4
node(8,2,2,0).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(8,3,0).
% node 4 (leaf): class 0 (0)
leaf_class(8,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(8,5,0).
% node 6: f9 <= 0.9000000059604645  (F9, bin <= 1)  left -> 7, right -> 10
node(8,6,9,1).
left_node(8,6,7).
right_node(8,6,10).
% node 7: f0 <= 47.0  (F0, bin <= 0)  left -> 8, right -> 9
node(8,7,0,0).
left_node(8,7,8).
right_node(8,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(8,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(8,9,0).
% node 10: f4 <= 292.5  (F4, bin <= 6)  left -> 11, right -> 12
node(8,10,4,6).
left_node(8,10,11).
right_node(8,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(8,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(8,12,1).

% Tree 9
tree(9).
% node 0: f1 <= 0.5  (F1, bin <= 0)  left -> 1, right -> 4
node(9,0,1,0).
left_node(9,0,1).
right_node(9,0,4).
% node 1: f9 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 3
node(9,1,9,0).
left_node(9,1,2).
right_node(9,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(9,2,0).
% node 3 (leaf): class 0 (0)
leaf_class(9,3,0).
% node 4: f8 <= 0.5  (F8, bin <= 0)  left -> 5, right -> 8
node(9,4,8,0).
left_node(9,4,5).
right_node(9,4,8).
% node 5: f4 <= 223.5  (F4, bin <= 0)  left -> 6, right -> 7
node(9,5,4,0).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(9,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(9,7,0).
% node 8 (leaf): class 1 (1)
leaf_class(9,8,1).

% --- Class domain ---
class_idx(0).  % 0
class_idx(1).  % 1
