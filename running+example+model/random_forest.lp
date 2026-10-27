% ============================================================
% random_forest.lp — RF facts for running+example
% 3 trees  |  4 features
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

% Feature 0 (age): 3 bins  (thresholds: [61.5, 65.0])
{bin(I,0,B) : B = 0..2} = 1 :- item(I).

% Feature 1 (bmi): 3 bins  (thresholds: [38.0, 38.85000038146973])
{bin(I,1,B) : B = 0..2} = 1 :- item(I).

% Feature 2 (glucose): 4 bins  (thresholds: [125.5, 172.1500015258789, 178.75])
{bin(I,2,B) : B = 0..3} = 1 :- item(I).

% Feature 3 (previous_stroke): 2 bins  (thresholds: [0.5])
{bin(I,3,B) : B = 0..1} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: age <= 61.5  (F0, bin <= 0)  left -> 1, right -> 4
node(0,0,0,0).
left_node(0,0,1).
right_node(0,0,4).
% node 1: bmi <= 38.85000038146973  (F1, bin <= 1)  left -> 2, right -> 3
node(0,1,1,1).
left_node(0,1,2).
right_node(0,1,3).
% node 2 (leaf): class low (0)
leaf_class(0,2,0).
% node 3 (leaf): class medium (1)
leaf_class(0,3,1).
% node 4: glucose <= 178.75  (F2, bin <= 2)  left -> 5, right -> 6
node(0,4,2,2).
left_node(0,4,5).
right_node(0,4,6).
% node 5 (leaf): class medium (1)
leaf_class(0,5,1).
% node 6 (leaf): class high (2)
leaf_class(0,6,2).

% Tree 1
tree(1).
% node 0: previous_stroke <= 0.5  (F3, bin <= 0)  left -> 1, right -> 4
node(1,0,3,0).
left_node(1,0,1).
right_node(1,0,4).
% node 1: glucose <= 172.1500015258789  (F2, bin <= 1)  left -> 2, right -> 3
node(1,1,2,1).
left_node(1,1,2).
right_node(1,1,3).
% node 2 (leaf): class medium (1)
leaf_class(1,2,1).
% node 3 (leaf): class high (2)
leaf_class(1,3,2).
% node 4 (leaf): class high (2)
leaf_class(1,4,2).

% Tree 2
tree(2).
% node 0: glucose <= 125.5  (F2, bin <= 0)  left -> 1, right -> 4
node(2,0,2,0).
left_node(2,0,1).
right_node(2,0,4).
% node 1: age <= 65.0  (F0, bin <= 1)  left -> 2, right -> 3
node(2,1,0,1).
left_node(2,1,2).
right_node(2,1,3).
% node 2 (leaf): class low (0)
leaf_class(2,2,0).
% node 3 (leaf): class medium (1)
leaf_class(2,3,1).
% node 4: bmi <= 38.0  (F1, bin <= 0)  left -> 5, right -> 6
node(2,4,1,0).
left_node(2,4,5).
right_node(2,4,6).
% node 5 (leaf): class medium (1)
leaf_class(2,5,1).
% node 6 (leaf): class high (2)
leaf_class(2,6,2).

% --- Class domain ---
class_idx(0).  % low
class_idx(1).  % medium
class_idx(2).  % high
