% ============================================================
% random_forest.lp — RF facts for breast+cancer
% 10 trees  |  30 features
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

% Feature 0 (f0): 2 bins  (thresholds: [15.03000020980835])
{bin(I,0,B) : B = 0..1} = 1 :- item(I).

% Feature 1 (f1): 3 bins  (thresholds: [15.819999694824219, 21.260000228881836])
{bin(I,1,B) : B = 0..2} = 1 :- item(I).

% Feature 2 (f2): 4 bins  (thresholds: [82.32499694824219, 86.6500015258789, 98.43000030517578])
{bin(I,2,B) : B = 0..3} = 1 :- item(I).

% Feature 3 (f3): 4 bins  (thresholds: [631.4500122070312, 694.1499938964844, 694.4000244140625])
{bin(I,3,B) : B = 0..3} = 1 :- item(I).

% Feature 5 (f5): 2 bins  (thresholds: [0.08555500209331512])
{bin(I,5,B) : B = 0..1} = 1 :- item(I).

% Feature 7 (f7): 5 bins  (thresholds: [0.05127999931573868, 0.05508499965071678, 0.05575999990105629, 0.05591999925673008])
{bin(I,7,B) : B = 0..4} = 1 :- item(I).

% Feature 8 (f8): 2 bins  (thresholds: [0.20865000039339066])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).

% Feature 10 (f10): 3 bins  (thresholds: [0.42045000195503235, 0.453450009226799])
{bin(I,10,B) : B = 0..2} = 1 :- item(I).

% Feature 11 (f11): 2 bins  (thresholds: [0.8208499848842621])
{bin(I,11,B) : B = 0..1} = 1 :- item(I).

% Feature 12 (f12): 2 bins  (thresholds: [2.1880000829696655])
{bin(I,12,B) : B = 0..1} = 1 :- item(I).

% Feature 13 (f13): 2 bins  (thresholds: [31.28499984741211])
{bin(I,13,B) : B = 0..1} = 1 :- item(I).

% Feature 16 (f16): 2 bins  (thresholds: [0.04886000044643879])
{bin(I,16,B) : B = 0..1} = 1 :- item(I).

% Feature 17 (f17): 2 bins  (thresholds: [0.010645000264048576])
{bin(I,17,B) : B = 0..1} = 1 :- item(I).

% Feature 20 (f20): 6 bins  (thresholds: [16.420000076293945, 16.639999389648438, 16.789999961853027, 16.979999542236328, 17.175000190734863])
{bin(I,20,B) : B = 0..5} = 1 :- item(I).

% Feature 21 (f21): 2 bins  (thresholds: [29.664999961853027])
{bin(I,21,B) : B = 0..1} = 1 :- item(I).

% Feature 22 (f22): 4 bins  (thresholds: [104.35000228881836, 114.5999984741211, 116.79999923706055])
{bin(I,22,B) : B = 0..3} = 1 :- item(I).

% Feature 23 (f23): 4 bins  (thresholds: [793.5, 858.1499938964844, 874.8500061035156])
{bin(I,23,B) : B = 0..3} = 1 :- item(I).

% Feature 25 (f25): 4 bins  (thresholds: [0.1757499948143959, 0.1973000019788742, 0.2715499997138977])
{bin(I,25,B) : B = 0..3} = 1 :- item(I).

% Feature 26 (f26): 4 bins  (thresholds: [0.2624000012874603, 0.3160000145435333, 0.4013500064611435])
{bin(I,26,B) : B = 0..3} = 1 :- item(I).

% Feature 27 (f27): 11 bins  (thresholds: [0.0634050015360117, 0.10954999923706055, 0.12515000253915787, 0.13164999336004257, 0.13580000400543213, 0.1423499956727028, 0.14594999700784683, 0.1472500041127205, 0.15839999914169312, 0.16125000268220901])
{bin(I,27,B) : B = 0..10} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f27 <= 0.13164999336004257  (F27, bin <= 3)  left -> 1, right -> 8
node(0,0,27,3).
left_node(0,0,1).
right_node(0,0,8).
% node 1: f27 <= 0.10954999923706055  (F27, bin <= 1)  left -> 2, right -> 5
node(0,1,27,1).
left_node(0,1,2).
right_node(0,1,5).
% node 2: f23 <= 793.5  (F23, bin <= 0)  left -> 3, right -> 4
node(0,2,23,0).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class B (0)
leaf_class(0,3,0).
% node 4 (leaf): class B (0)
leaf_class(0,4,0).
% node 5: f3 <= 694.4000244140625  (F3, bin <= 2)  left -> 6, right -> 7
node(0,5,3,2).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class B (0)
leaf_class(0,6,0).
% node 7 (leaf): class M (1)
leaf_class(0,7,1).
% node 8: f22 <= 104.35000228881836  (F22, bin <= 0)  left -> 9, right -> 10
node(0,8,22,0).
left_node(0,8,9).
right_node(0,8,10).
% node 9 (leaf): class B (0)
leaf_class(0,9,0).
% node 10: f11 <= 0.8208499848842621  (F11, bin <= 0)  left -> 11, right -> 12
node(0,10,11,0).
left_node(0,10,11).
right_node(0,10,12).
% node 11 (leaf): class M (1)
leaf_class(0,11,1).
% node 12 (leaf): class M (1)
leaf_class(0,12,1).

% Tree 1
tree(1).
% node 0: f10 <= 0.42045000195503235  (F10, bin <= 0)  left -> 1, right -> 6
node(1,0,10,0).
left_node(1,0,1).
right_node(1,0,6).
% node 1: f27 <= 0.15839999914169312  (F27, bin <= 8)  left -> 2, right -> 5
node(1,1,27,8).
left_node(1,1,2).
right_node(1,1,5).
% node 2: f23 <= 858.1499938964844  (F23, bin <= 1)  left -> 3, right -> 4
node(1,2,23,1).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class B (0)
leaf_class(1,3,0).
% node 4 (leaf): class M (1)
leaf_class(1,4,1).
% node 5 (leaf): class M (1)
leaf_class(1,5,1).
% node 6: f27 <= 0.0634050015360117  (F27, bin <= 0)  left -> 7, right -> 8
node(1,6,27,0).
left_node(1,6,7).
right_node(1,6,8).
% node 7 (leaf): class B (0)
leaf_class(1,7,0).
% node 8: f20 <= 17.175000190734863  (F20, bin <= 4)  left -> 9, right -> 10
node(1,8,20,4).
left_node(1,8,9).
right_node(1,8,10).
% node 9 (leaf): class M (1)
leaf_class(1,9,1).
% node 10 (leaf): class M (1)
leaf_class(1,10,1).

% Tree 2
tree(2).
% node 0: f27 <= 0.14594999700784683  (F27, bin <= 6)  left -> 1, right -> 6
node(2,0,27,6).
left_node(2,0,1).
right_node(2,0,6).
% node 1: f3 <= 694.1499938964844  (F3, bin <= 1)  left -> 2, right -> 5
node(2,1,3,1).
left_node(2,1,2).
right_node(2,1,5).
% node 2: f7 <= 0.05575999990105629  (F7, bin <= 2)  left -> 3, right -> 4
node(2,2,7,2).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class B (0)
leaf_class(2,3,0).
% node 4 (leaf): class B (0)
leaf_class(2,4,0).
% node 5 (leaf): class M (1)
leaf_class(2,5,1).
% node 6: f2 <= 86.6500015258789  (F2, bin <= 1)  left -> 7, right -> 8
node(2,6,2,1).
left_node(2,6,7).
right_node(2,6,8).
% node 7 (leaf): class B (0)
leaf_class(2,7,0).
% node 8 (leaf): class M (1)
leaf_class(2,8,1).

% Tree 3
tree(3).
% node 0: f20 <= 16.789999961853027  (F20, bin <= 2)  left -> 1, right -> 4
node(3,0,20,2).
left_node(3,0,1).
right_node(3,0,4).
% node 1: f27 <= 0.1423499956727028  (F27, bin <= 5)  left -> 2, right -> 3
node(3,1,27,5).
left_node(3,1,2).
right_node(3,1,3).
% node 2 (leaf): class B (0)
leaf_class(3,2,0).
% node 3 (leaf): class M (1)
leaf_class(3,3,1).
% node 4: f22 <= 116.79999923706055  (F22, bin <= 2)  left -> 5, right -> 6
node(3,4,22,2).
left_node(3,4,5).
right_node(3,4,6).
% node 5 (leaf): class M (1)
leaf_class(3,5,1).
% node 6: f7 <= 0.05508499965071678  (F7, bin <= 1)  left -> 7, right -> 8
node(3,6,7,1).
left_node(3,6,7).
right_node(3,6,8).
% node 7 (leaf): class M (1)
leaf_class(3,7,1).
% node 8 (leaf): class M (1)
leaf_class(3,8,1).

% Tree 4
tree(4).
% node 0: f13 <= 31.28499984741211  (F13, bin <= 0)  left -> 1, right -> 6
node(4,0,13,0).
left_node(4,0,1).
right_node(4,0,6).
% node 1: f22 <= 114.5999984741211  (F22, bin <= 1)  left -> 2, right -> 5
node(4,1,22,1).
left_node(4,1,2).
right_node(4,1,5).
% node 2: f26 <= 0.4013500064611435  (F26, bin <= 2)  left -> 3, right -> 4
node(4,2,26,2).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class B (0)
leaf_class(4,3,0).
% node 4 (leaf): class B (0)
leaf_class(4,4,0).
% node 5 (leaf): class M (1)
leaf_class(4,5,1).
% node 6: f3 <= 694.1499938964844  (F3, bin <= 1)  left -> 7, right -> 10
node(4,6,3,1).
left_node(4,6,7).
right_node(4,6,10).
% node 7: f26 <= 0.2624000012874603  (F26, bin <= 0)  left -> 8, right -> 9
node(4,7,26,0).
left_node(4,7,8).
right_node(4,7,9).
% node 8 (leaf): class B (0)
leaf_class(4,8,0).
% node 9 (leaf): class M (1)
leaf_class(4,9,1).
% node 10: f17 <= 0.010645000264048576  (F17, bin <= 0)  left -> 11, right -> 12
node(4,10,17,0).
left_node(4,10,11).
right_node(4,10,12).
% node 11 (leaf): class M (1)
leaf_class(4,11,1).
% node 12 (leaf): class M (1)
leaf_class(4,12,1).

% Tree 5
tree(5).
% node 0: f25 <= 0.2715499997138977  (F25, bin <= 2)  left -> 1, right -> 6
node(5,0,25,2).
left_node(5,0,1).
right_node(5,0,6).
% node 1: f27 <= 0.13580000400543213  (F27, bin <= 4)  left -> 2, right -> 5
node(5,1,27,4).
left_node(5,1,2).
right_node(5,1,5).
% node 2: f20 <= 16.979999542236328  (F20, bin <= 3)  left -> 3, right -> 4
node(5,2,20,3).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class B (0)
leaf_class(5,3,0).
% node 4 (leaf): class M (1)
leaf_class(5,4,1).
% node 5 (leaf): class M (1)
leaf_class(5,5,1).
% node 6: f20 <= 16.639999389648438  (F20, bin <= 1)  left -> 7, right -> 10
node(5,6,20,1).
left_node(5,6,7).
right_node(5,6,10).
% node 7: f8 <= 0.20865000039339066  (F8, bin <= 0)  left -> 8, right -> 9
node(5,7,8,0).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class B (0)
leaf_class(5,8,0).
% node 9 (leaf): class M (1)
leaf_class(5,9,1).
% node 10 (leaf): class M (1)
leaf_class(5,10,1).

% Tree 6
tree(6).
% node 0: f7 <= 0.05591999925673008  (F7, bin <= 3)  left -> 1, right -> 8
node(6,0,7,3).
left_node(6,0,1).
right_node(6,0,8).
% node 1: f10 <= 0.453450009226799  (F10, bin <= 1)  left -> 2, right -> 5
node(6,1,10,1).
left_node(6,1,2).
right_node(6,1,5).
% node 2: f27 <= 0.12515000253915787  (F27, bin <= 2)  left -> 3, right -> 4
node(6,2,27,2).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class B (0)
leaf_class(6,3,0).
% node 4 (leaf): class B (0)
leaf_class(6,4,0).
% node 5: f2 <= 82.32499694824219  (F2, bin <= 0)  left -> 6, right -> 7
node(6,5,2,0).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class B (0)
leaf_class(6,6,0).
% node 7 (leaf): class M (1)
leaf_class(6,7,1).
% node 8: f1 <= 15.819999694824219  (F1, bin <= 0)  left -> 9, right -> 10
node(6,8,1,0).
left_node(6,8,9).
right_node(6,8,10).
% node 9 (leaf): class B (0)
leaf_class(6,9,0).
% node 10: f3 <= 631.4500122070312  (F3, bin <= 0)  left -> 11, right -> 12
node(6,10,3,0).
left_node(6,10,11).
right_node(6,10,12).
% node 11 (leaf): class M (1)
leaf_class(6,11,1).
% node 12 (leaf): class M (1)
leaf_class(6,12,1).

% Tree 7
tree(7).
% node 0: f0 <= 15.03000020980835  (F0, bin <= 0)  left -> 1, right -> 8
node(7,0,0,0).
left_node(7,0,1).
right_node(7,0,8).
% node 1: f26 <= 0.3160000145435333  (F26, bin <= 1)  left -> 2, right -> 5
node(7,1,26,1).
left_node(7,1,2).
right_node(7,1,5).
% node 2: f21 <= 29.664999961853027  (F21, bin <= 0)  left -> 3, right -> 4
node(7,2,21,0).
left_node(7,2,3).
right_node(7,2,4).
% node 3 (leaf): class B (0)
leaf_class(7,3,0).
% node 4 (leaf): class B (0)
leaf_class(7,4,0).
% node 5: f16 <= 0.04886000044643879  (F16, bin <= 0)  left -> 6, right -> 7
node(7,5,16,0).
left_node(7,5,6).
right_node(7,5,7).
% node 6 (leaf): class M (1)
leaf_class(7,6,1).
% node 7 (leaf): class B (0)
leaf_class(7,7,0).
% node 8: f25 <= 0.1757499948143959  (F25, bin <= 0)  left -> 9, right -> 10
node(7,8,25,0).
left_node(7,8,9).
right_node(7,8,10).
% node 9 (leaf): class M (1)
leaf_class(7,9,1).
% node 10 (leaf): class M (1)
leaf_class(7,10,1).

% Tree 8
tree(8).
% node 0: f2 <= 98.43000030517578  (F2, bin <= 2)  left -> 1, right -> 8
node(8,0,2,2).
left_node(8,0,1).
right_node(8,0,8).
% node 1: f7 <= 0.05127999931573868  (F7, bin <= 0)  left -> 2, right -> 5
node(8,1,7,0).
left_node(8,1,2).
right_node(8,1,5).
% node 2: f20 <= 16.420000076293945  (F20, bin <= 0)  left -> 3, right -> 4
node(8,2,20,0).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class B (0)
leaf_class(8,3,0).
% node 4 (leaf): class B (0)
leaf_class(8,4,0).
% node 5: f27 <= 0.1472500041127205  (F27, bin <= 7)  left -> 6, right -> 7
node(8,5,27,7).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class B (0)
leaf_class(8,6,0).
% node 7 (leaf): class M (1)
leaf_class(8,7,1).
% node 8: f25 <= 0.1973000019788742  (F25, bin <= 1)  left -> 9, right -> 10
node(8,8,25,1).
left_node(8,8,9).
right_node(8,8,10).
% node 9 (leaf): class M (1)
leaf_class(8,9,1).
% node 10: f12 <= 2.1880000829696655  (F12, bin <= 0)  left -> 11, right -> 12
node(8,10,12,0).
left_node(8,10,11).
right_node(8,10,12).
% node 11 (leaf): class M (1)
leaf_class(8,11,1).
% node 12 (leaf): class M (1)
leaf_class(8,12,1).

% Tree 9
tree(9).
% node 0: f23 <= 874.8500061035156  (F23, bin <= 2)  left -> 1, right -> 6
node(9,0,23,2).
left_node(9,0,1).
right_node(9,0,6).
% node 1: f27 <= 0.16125000268220901  (F27, bin <= 9)  left -> 2, right -> 5
node(9,1,27,9).
left_node(9,1,2).
right_node(9,1,5).
% node 2: f1 <= 21.260000228881836  (F1, bin <= 1)  left -> 3, right -> 4
node(9,2,1,1).
left_node(9,2,3).
right_node(9,2,4).
% node 3 (leaf): class B (0)
leaf_class(9,3,0).
% node 4 (leaf): class B (0)
leaf_class(9,4,0).
% node 5 (leaf): class M (1)
leaf_class(9,5,1).
% node 6: f5 <= 0.08555500209331512  (F5, bin <= 0)  left -> 7, right -> 8
node(9,6,5,0).
left_node(9,6,7).
right_node(9,6,8).
% node 7 (leaf): class M (1)
leaf_class(9,7,1).
% node 8 (leaf): class M (1)
leaf_class(9,8,1).

% --- Class domain ---
class_idx(0).  % B
class_idx(1).  % M
