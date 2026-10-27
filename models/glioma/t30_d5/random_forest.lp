% ============================================================
% random_forest.lp — RF facts for glioma
% 30 trees  |  23 features
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

% Feature 0 (Gender): 2 bins  (thresholds: [0.5])
{bin(I,0,B) : B = 0..1} = 1 :- item(I).

% Feature 1 (Age_at_diagnosis): 38 bins  (thresholds: [24.049999237060547, 25.244999885559082, 30.854999542236328, 33.6150016784668, 39.03499984741211, 40.90500068664551, 43.529998779296875, 44.30999946594238, 45.154998779296875, 45.22999954223633, 45.28999900817871, 45.47999954223633, 45.81500053405762, 47.93499946594238, 48.46999931335449, 49.209999084472656, 49.77000045776367, 51.310001373291016, 52.43499946594238, 52.55000114440918, 52.59000015258789, 52.6200008392334, 52.6299991607666, 52.66499900817871, 52.67499923706055, 53.994998931884766, 54.90999984741211, 55.40500068664551, 60.27499961853027, 60.51499938964844, 62.92500114440918, 63.2450008392334, 64.2599983215332, 66.45999908447266, 67.31000137329102, 70.61499786376953, 71.90999984741211])
{bin(I,1,B) : B = 0..37} = 1 :- item(I).

% Feature 2 (Race): 2 bins  (thresholds: [0.5])
{bin(I,2,B) : B = 0..1} = 1 :- item(I).

% Feature 3 (IDH1): 2 bins  (thresholds: [0.5])
{bin(I,3,B) : B = 0..1} = 1 :- item(I).

% Feature 4 (TP53): 2 bins  (thresholds: [0.5])
{bin(I,4,B) : B = 0..1} = 1 :- item(I).

% Feature 5 (ATRX): 2 bins  (thresholds: [0.5])
{bin(I,5,B) : B = 0..1} = 1 :- item(I).

% Feature 6 (PTEN): 2 bins  (thresholds: [0.5])
{bin(I,6,B) : B = 0..1} = 1 :- item(I).

% Feature 7 (EGFR): 2 bins  (thresholds: [0.5])
{bin(I,7,B) : B = 0..1} = 1 :- item(I).

% Feature 8 (CIC): 2 bins  (thresholds: [0.5])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).

% Feature 9 (MUC16): 2 bins  (thresholds: [0.5])
{bin(I,9,B) : B = 0..1} = 1 :- item(I).

% Feature 10 (PIK3CA): 2 bins  (thresholds: [0.5])
{bin(I,10,B) : B = 0..1} = 1 :- item(I).

% Feature 11 (NF1): 2 bins  (thresholds: [0.5])
{bin(I,11,B) : B = 0..1} = 1 :- item(I).

% Feature 12 (PIK3R1): 2 bins  (thresholds: [0.5])
{bin(I,12,B) : B = 0..1} = 1 :- item(I).

% Feature 13 (FUBP1): 2 bins  (thresholds: [0.5])
{bin(I,13,B) : B = 0..1} = 1 :- item(I).

% Feature 14 (RB1): 2 bins  (thresholds: [0.5])
{bin(I,14,B) : B = 0..1} = 1 :- item(I).

% Feature 15 (NOTCH1): 2 bins  (thresholds: [0.5])
{bin(I,15,B) : B = 0..1} = 1 :- item(I).

% Feature 17 (CSMD3): 2 bins  (thresholds: [0.5])
{bin(I,17,B) : B = 0..1} = 1 :- item(I).

% Feature 18 (SMARCA4): 2 bins  (thresholds: [0.5])
{bin(I,18,B) : B = 0..1} = 1 :- item(I).

% Feature 19 (GRIN2A): 2 bins  (thresholds: [0.5])
{bin(I,19,B) : B = 0..1} = 1 :- item(I).

% Feature 20 (IDH2): 2 bins  (thresholds: [0.5])
{bin(I,20,B) : B = 0..1} = 1 :- item(I).

% Feature 22 (PDGFRA): 2 bins  (thresholds: [0.5])
{bin(I,22,B) : B = 0..1} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 21)  left -> 1, right -> 10
node(0,0,1,21).
left_node(0,0,1).
right_node(0,0,10).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 9
node(0,1,20,0).
left_node(0,1,2).
right_node(0,1,9).
% node 2: ATRX <= 0.5  (F5, bin <= 0)  left -> 3, right -> 8
node(0,2,5,0).
left_node(0,2,3).
right_node(0,2,8).
% node 3: Age_at_diagnosis <= 33.6150016784668  (F1, bin <= 3)  left -> 4, right -> 5
node(0,3,1,3).
left_node(0,3,4).
right_node(0,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(0,4,0).
% node 5: CIC <= 0.5  (F8, bin <= 0)  left -> 6, right -> 7
node(0,5,8,0).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(0,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(0,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(0,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(0,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 18
node(0,10,8,0).
left_node(0,10,11).
right_node(0,10,18).
% node 11: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 12, right -> 17
node(0,11,12,0).
left_node(0,11,12).
right_node(0,11,17).
% node 12: ATRX <= 0.5  (F5, bin <= 0)  left -> 13, right -> 16
node(0,12,5,0).
left_node(0,12,13).
right_node(0,12,16).
% node 13: IDH1 <= 0.5  (F3, bin <= 0)  left -> 14, right -> 15
node(0,13,3,0).
left_node(0,13,14).
right_node(0,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(0,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(0,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(0,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(0,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(0,18,0).

% Tree 1
tree(1).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 10
node(1,0,8,0).
left_node(1,0,1).
right_node(1,0,10).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 9
node(1,1,5,0).
left_node(1,1,2).
right_node(1,1,9).
% node 2: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 3, right -> 8
node(1,2,10,0).
left_node(1,2,3).
right_node(1,2,8).
% node 3: Age_at_diagnosis <= 45.81500053405762  (F1, bin <= 12)  left -> 4, right -> 5
node(1,3,1,12).
left_node(1,3,4).
right_node(1,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(1,4,0).
% node 5: Age_at_diagnosis <= 71.90999984741211  (F1, bin <= 36)  left -> 6, right -> 7
node(1,5,1,36).
left_node(1,5,6).
right_node(1,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(1,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(1,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(1,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(1,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(1,10,0).

% Tree 2
tree(2).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 6
node(2,0,5,0).
left_node(2,0,1).
right_node(2,0,6).
% node 1: RB1 <= 0.5  (F14, bin <= 0)  left -> 2, right -> 5
node(2,1,14,0).
left_node(2,1,2).
right_node(2,1,5).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 4
node(2,2,3,0).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(2,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(2,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(2,5,1).
% node 6: IDH1 <= 0.5  (F3, bin <= 0)  left -> 7, right -> 8
node(2,6,3,0).
left_node(2,6,7).
right_node(2,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(2,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(2,8,0).

% Tree 3
tree(3).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 12
node(3,0,3,0).
left_node(3,0,1).
right_node(3,0,12).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 7
node(3,1,6,0).
left_node(3,1,2).
right_node(3,1,7).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 6
node(3,2,20,0).
left_node(3,2,3).
right_node(3,2,6).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 5
node(3,3,9,0).
left_node(3,3,4).
right_node(3,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(3,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(3,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(3,6,0).
% node 7: EGFR <= 0.5  (F7, bin <= 0)  left -> 8, right -> 11
node(3,7,7,0).
left_node(3,7,8).
right_node(3,7,11).
% node 8: NF1 <= 0.5  (F11, bin <= 0)  left -> 9, right -> 10
node(3,8,11,0).
left_node(3,8,9).
right_node(3,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(3,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(3,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(3,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(3,12,0).

% Tree 4
tree(4).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 14
node(4,0,6,0).
left_node(4,0,1).
right_node(4,0,14).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 7
node(4,1,4,0).
left_node(4,1,2).
right_node(4,1,7).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 6
node(4,2,8,0).
left_node(4,2,3).
right_node(4,2,6).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 5
node(4,3,9,0).
left_node(4,3,4).
right_node(4,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(4,4,0).
% node 5 (leaf): class 1 (1)
leaf_class(4,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(4,6,0).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 11
node(4,7,0,0).
left_node(4,7,8).
right_node(4,7,11).
% node 8: Age_at_diagnosis <= 54.90999984741211  (F1, bin <= 26)  left -> 9, right -> 10
node(4,8,1,26).
left_node(4,8,9).
right_node(4,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(4,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(4,10,1).
% node 11: Age_at_diagnosis <= 51.310001373291016  (F1, bin <= 17)  left -> 12, right -> 13
node(4,11,1,17).
left_node(4,11,12).
right_node(4,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(4,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(4,13,1).
% node 14: Age_at_diagnosis <= 49.77000045776367  (F1, bin <= 16)  left -> 15, right -> 16
node(4,14,1,16).
left_node(4,14,15).
right_node(4,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(4,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(4,16,1).

% Tree 5
tree(5).
% node 0: Race <= 0.5  (F2, bin <= 0)  left -> 1, right -> 12
node(5,0,2,0).
left_node(5,0,1).
right_node(5,0,12).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 11
node(5,1,13,0).
left_node(5,1,2).
right_node(5,1,11).
% node 2: Age_at_diagnosis <= 44.30999946594238  (F1, bin <= 7)  left -> 3, right -> 4
node(5,2,1,7).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(5,3,0).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 8
node(5,4,6,0).
left_node(5,4,5).
right_node(5,4,8).
% node 5: Age_at_diagnosis <= 62.92500114440918  (F1, bin <= 30)  left -> 6, right -> 7
node(5,5,1,30).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class 0 (0)
leaf_class(5,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(5,7,1).
% node 8: Age_at_diagnosis <= 66.45999908447266  (F1, bin <= 33)  left -> 9, right -> 10
node(5,8,1,33).
left_node(5,8,9).
right_node(5,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(5,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(5,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(5,11,0).
% node 12: IDH1 <= 0.5  (F3, bin <= 0)  left -> 13, right -> 14
node(5,12,3,0).
left_node(5,12,13).
right_node(5,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(5,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(5,14,0).

% Tree 6
tree(6).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 10
node(6,0,8,0).
left_node(6,0,1).
right_node(6,0,10).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(6,1,3,0).
left_node(6,1,2).
right_node(6,1,9).
% node 2: Age_at_diagnosis <= 47.93499946594238  (F1, bin <= 13)  left -> 3, right -> 4
node(6,2,1,13).
left_node(6,2,3).
right_node(6,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(6,3,1).
% node 4: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 5, right -> 8
node(6,4,10,0).
left_node(6,4,5).
right_node(6,4,8).
% node 5: TP53 <= 0.5  (F4, bin <= 0)  left -> 6, right -> 7
node(6,5,4,0).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(6,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(6,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(6,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(6,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(6,10,0).

% Tree 7
tree(7).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 12
node(7,0,14,0).
left_node(7,0,1).
right_node(7,0,12).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 11
node(7,1,8,0).
left_node(7,1,2).
right_node(7,1,11).
% node 2: TP53 <= 0.5  (F4, bin <= 0)  left -> 3, right -> 8
node(7,2,4,0).
left_node(7,2,3).
right_node(7,2,8).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(7,3,3,0).
left_node(7,3,4).
right_node(7,3,7).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 6
node(7,4,6,0).
left_node(7,4,5).
right_node(7,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(7,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(7,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(7,7,0).
% node 8: PTEN <= 0.5  (F6, bin <= 0)  left -> 9, right -> 10
node(7,8,6,0).
left_node(7,8,9).
right_node(7,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(7,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(7,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(7,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(7,12,1).

% Tree 8
tree(8).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 14
node(8,0,15,0).
left_node(8,0,1).
right_node(8,0,14).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 9
node(8,1,6,0).
left_node(8,1,2).
right_node(8,1,9).
% node 2: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 3, right -> 8
node(8,2,22,0).
left_node(8,2,3).
right_node(8,2,8).
% node 3: Age_at_diagnosis <= 49.209999084472656  (F1, bin <= 15)  left -> 4, right -> 5
node(8,3,1,15).
left_node(8,3,4).
right_node(8,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(8,4,0).
% node 5: IDH1 <= 0.5  (F3, bin <= 0)  left -> 6, right -> 7
node(8,5,3,0).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(8,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(8,7,0).
% node 8 (leaf): class 1 (1)
leaf_class(8,8,1).
% node 9: TP53 <= 0.5  (F4, bin <= 0)  left -> 10, right -> 13
node(8,9,4,0).
left_node(8,9,10).
right_node(8,9,13).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 12
node(8,10,0,0).
left_node(8,10,11).
right_node(8,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(8,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(8,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(8,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(8,14,0).

% Tree 9
tree(9).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 10
node(9,0,8,0).
left_node(9,0,1).
right_node(9,0,10).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 5
node(9,1,4,0).
left_node(9,1,2).
right_node(9,1,5).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 4
node(9,2,3,0).
left_node(9,2,3).
right_node(9,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(9,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(9,4,0).
% node 5: PTEN <= 0.5  (F6, bin <= 0)  left -> 6, right -> 9
node(9,5,6,0).
left_node(9,5,6).
right_node(9,5,9).
% node 6: IDH1 <= 0.5  (F3, bin <= 0)  left -> 7, right -> 8
node(9,6,3,0).
left_node(9,6,7).
right_node(9,6,8).
% node 7 (leaf): class 1 (1)
leaf_class(9,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(9,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(9,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(9,10,0).

% Tree 10
tree(10).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 14
node(10,0,15,0).
left_node(10,0,1).
right_node(10,0,14).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 11
node(10,1,5,0).
left_node(10,1,2).
right_node(10,1,11).
% node 2: Race <= 0.5  (F2, bin <= 0)  left -> 3, right -> 10
node(10,2,2,0).
left_node(10,2,3).
right_node(10,2,10).
% node 3: PTEN <= 0.5  (F6, bin <= 0)  left -> 4, right -> 7
node(10,3,6,0).
left_node(10,3,4).
right_node(10,3,7).
% node 4: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 5, right -> 6
node(10,4,13,0).
left_node(10,4,5).
right_node(10,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(10,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(10,6,0).
% node 7: Age_at_diagnosis <= 64.2599983215332  (F1, bin <= 32)  left -> 8, right -> 9
node(10,7,1,32).
left_node(10,7,8).
right_node(10,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(10,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(10,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(10,10,1).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(10,11,3,0).
left_node(10,11,12).
right_node(10,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(10,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(10,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(10,14,0).

% Tree 11
tree(11).
% node 0: Age_at_diagnosis <= 45.47999954223633  (F1, bin <= 11)  left -> 1, right -> 6
node(11,0,1,11).
left_node(11,0,1).
right_node(11,0,6).
% node 1: Age_at_diagnosis <= 25.244999885559082  (F1, bin <= 1)  left -> 2, right -> 3
node(11,1,1,1).
left_node(11,1,2).
right_node(11,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(11,2,0).
% node 3: ATRX <= 0.5  (F5, bin <= 0)  left -> 4, right -> 5
node(11,3,5,0).
left_node(11,3,4).
right_node(11,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(11,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(11,5,0).
% node 6: PTEN <= 0.5  (F6, bin <= 0)  left -> 7, right -> 12
node(11,6,6,0).
left_node(11,6,7).
right_node(11,6,12).
% node 7: ATRX <= 0.5  (F5, bin <= 0)  left -> 8, right -> 11
node(11,7,5,0).
left_node(11,7,8).
right_node(11,7,11).
% node 8: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 9, right -> 10
node(11,8,13,0).
left_node(11,8,9).
right_node(11,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(11,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(11,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(11,11,0).
% node 12: Age_at_diagnosis <= 52.6299991607666  (F1, bin <= 22)  left -> 13, right -> 14
node(11,12,1,22).
left_node(11,12,13).
right_node(11,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(11,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(11,14,1).

% Tree 12
tree(12).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 10
node(12,0,19,0).
left_node(12,0,1).
right_node(12,0,10).
% node 1: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 2, right -> 9
node(12,1,10,0).
left_node(12,1,2).
right_node(12,1,9).
% node 2: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 3, right -> 8
node(12,2,13,0).
left_node(12,2,3).
right_node(12,2,8).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(12,3,7,0).
left_node(12,3,4).
right_node(12,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(12,4,3,0).
left_node(12,4,5).
right_node(12,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(12,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(12,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(12,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(12,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(12,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(12,10,1).

% Tree 13
tree(13).
% node 0: Age_at_diagnosis <= 48.46999931335449  (F1, bin <= 14)  left -> 1, right -> 8
node(13,0,1,14).
left_node(13,0,1).
right_node(13,0,8).
% node 1: Gender <= 0.5  (F0, bin <= 0)  left -> 2, right -> 7
node(13,1,0,0).
left_node(13,1,2).
right_node(13,1,7).
% node 2: ATRX <= 0.5  (F5, bin <= 0)  left -> 3, right -> 4
node(13,2,5,0).
left_node(13,2,3).
right_node(13,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(13,3,0).
% node 4: Age_at_diagnosis <= 30.854999542236328  (F1, bin <= 2)  left -> 5, right -> 6
node(13,4,1,2).
left_node(13,4,5).
right_node(13,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(13,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(13,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(13,7,0).
% node 8: IDH1 <= 0.5  (F3, bin <= 0)  left -> 9, right -> 16
node(13,8,3,0).
left_node(13,8,9).
right_node(13,8,16).
% node 9: TP53 <= 0.5  (F4, bin <= 0)  left -> 10, right -> 15
node(13,9,4,0).
left_node(13,9,10).
right_node(13,9,15).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 14
node(13,10,0,0).
left_node(13,10,11).
right_node(13,10,14).
% node 11: EGFR <= 0.5  (F7, bin <= 0)  left -> 12, right -> 13
node(13,11,7,0).
left_node(13,11,12).
right_node(13,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(13,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(13,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(13,14,1).
% node 15 (leaf): class 1 (1)
leaf_class(13,15,1).
% node 16 (leaf): class 0 (0)
leaf_class(13,16,0).

% Tree 14
tree(14).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 10
node(14,0,5,0).
left_node(14,0,1).
right_node(14,0,10).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 9
node(14,1,13,0).
left_node(14,1,2).
right_node(14,1,9).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(14,2,3,0).
left_node(14,2,3).
right_node(14,2,8).
% node 3: Gender <= 0.5  (F0, bin <= 0)  left -> 4, right -> 7
node(14,3,0,0).
left_node(14,3,4).
right_node(14,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(14,4,7,0).
left_node(14,4,5).
right_node(14,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(14,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(14,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(14,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(14,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(14,9,0).
% node 10: IDH1 <= 0.5  (F3, bin <= 0)  left -> 11, right -> 12
node(14,10,3,0).
left_node(14,10,11).
right_node(14,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(14,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(14,12,0).

% Tree 15
tree(15).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 10
node(15,0,6,0).
left_node(15,0,1).
right_node(15,0,10).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 9
node(15,1,13,0).
left_node(15,1,2).
right_node(15,1,9).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(15,2,9,0).
left_node(15,2,3).
right_node(15,2,8).
% node 3: Age_at_diagnosis <= 52.43499946594238  (F1, bin <= 18)  left -> 4, right -> 7
node(15,3,1,18).
left_node(15,3,4).
right_node(15,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(15,4,3,0).
left_node(15,4,5).
right_node(15,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(15,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(15,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(15,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(15,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(15,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(15,10,1).

% Tree 16
tree(16).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 10
node(16,0,5,0).
left_node(16,0,1).
right_node(16,0,10).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 9
node(16,1,8,0).
left_node(16,1,2).
right_node(16,1,9).
% node 2: Age_at_diagnosis <= 43.529998779296875  (F1, bin <= 6)  left -> 3, right -> 4
node(16,2,1,6).
left_node(16,2,3).
right_node(16,2,4).
% node 3 (leaf): class 0 (0)
leaf_class(16,3,0).
% node 4: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 5, right -> 8
node(16,4,19,0).
left_node(16,4,5).
right_node(16,4,8).
% node 5: Age_at_diagnosis <= 60.51499938964844  (F1, bin <= 29)  left -> 6, right -> 7
node(16,5,1,29).
left_node(16,5,6).
right_node(16,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(16,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(16,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(16,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(16,9,0).
% node 10: Age_at_diagnosis <= 60.27499961853027  (F1, bin <= 28)  left -> 11, right -> 12
node(16,10,1,28).
left_node(16,10,11).
right_node(16,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(16,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(16,12,1).

% Tree 17
tree(17).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 10
node(17,0,3,0).
left_node(17,0,1).
right_node(17,0,10).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 9
node(17,1,20,0).
left_node(17,1,2).
right_node(17,1,9).
% node 2: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 3, right -> 8
node(17,2,22,0).
left_node(17,2,3).
right_node(17,2,8).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(17,3,9,0).
left_node(17,3,4).
right_node(17,3,7).
% node 4: Age_at_diagnosis <= 70.61499786376953  (F1, bin <= 35)  left -> 5, right -> 6
node(17,4,1,35).
left_node(17,4,5).
right_node(17,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(17,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(17,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(17,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(17,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(17,9,0).
% node 10: TP53 <= 0.5  (F4, bin <= 0)  left -> 11, right -> 12
node(17,10,4,0).
left_node(17,10,11).
right_node(17,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(17,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(17,12,0).

% Tree 18
tree(18).
% node 0: Age_at_diagnosis <= 52.55000114440918  (F1, bin <= 19)  left -> 1, right -> 6
node(18,0,1,19).
left_node(18,0,1).
right_node(18,0,6).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 3
node(18,1,3,0).
left_node(18,1,2).
right_node(18,1,3).
% node 2 (leaf): class 0 (0)
leaf_class(18,2,0).
% node 3: TP53 <= 0.5  (F4, bin <= 0)  left -> 4, right -> 5
node(18,3,4,0).
left_node(18,3,4).
right_node(18,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(18,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(18,5,0).
% node 6: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 7, right -> 14
node(18,6,15,0).
left_node(18,6,7).
right_node(18,6,14).
% node 7: PTEN <= 0.5  (F6, bin <= 0)  left -> 8, right -> 13
node(18,7,6,0).
left_node(18,7,8).
right_node(18,7,13).
% node 8: ATRX <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(18,8,5,0).
left_node(18,8,9).
right_node(18,8,12).
% node 9: CIC <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(18,9,8,0).
left_node(18,9,10).
right_node(18,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(18,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(18,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(18,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(18,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(18,14,0).

% Tree 19
tree(19).
% node 0: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 1, right -> 8
node(19,0,18,0).
left_node(19,0,1).
right_node(19,0,8).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 7
node(19,1,4,0).
left_node(19,1,2).
right_node(19,1,7).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 6
node(19,2,3,0).
left_node(19,2,3).
right_node(19,2,6).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 5
node(19,3,9,0).
left_node(19,3,4).
right_node(19,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(19,4,1).
% node 5 (leaf): class 1 (1)
leaf_class(19,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(19,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(19,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(19,8,0).

% Tree 20
tree(20).
% node 0: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 1, right -> 12
node(20,0,22,0).
left_node(20,0,1).
right_node(20,0,12).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 9
node(20,1,5,0).
left_node(20,1,2).
right_node(20,1,9).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 8
node(20,2,15,0).
left_node(20,2,3).
right_node(20,2,8).
% node 3: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 4, right -> 7
node(20,3,17,0).
left_node(20,3,4).
right_node(20,3,7).
% node 4: Age_at_diagnosis <= 52.67499923706055  (F1, bin <= 24)  left -> 5, right -> 6
node(20,4,1,24).
left_node(20,4,5).
right_node(20,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(20,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(20,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(20,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(20,8,0).
% node 9: Age_at_diagnosis <= 53.994998931884766  (F1, bin <= 25)  left -> 10, right -> 11
node(20,9,1,25).
left_node(20,9,10).
right_node(20,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(20,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(20,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(20,12,1).

% Tree 21
tree(21).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 12
node(21,0,14,0).
left_node(21,0,1).
right_node(21,0,12).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 11
node(21,1,7,0).
left_node(21,1,2).
right_node(21,1,11).
% node 2: NF1 <= 0.5  (F11, bin <= 0)  left -> 3, right -> 10
node(21,2,11,0).
left_node(21,2,3).
right_node(21,2,10).
% node 3: Age_at_diagnosis <= 55.40500068664551  (F1, bin <= 27)  left -> 4, right -> 7
node(21,3,1,27).
left_node(21,3,4).
right_node(21,3,7).
% node 4: Age_at_diagnosis <= 45.22999954223633  (F1, bin <= 9)  left -> 5, right -> 6
node(21,4,1,9).
left_node(21,4,5).
right_node(21,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(21,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(21,6,0).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(21,7,0,0).
left_node(21,7,8).
right_node(21,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(21,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(21,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(21,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(21,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(21,12,1).

% Tree 22
tree(22).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 6
node(22,0,5,0).
left_node(22,0,1).
right_node(22,0,6).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 5
node(22,1,8,0).
left_node(22,1,2).
right_node(22,1,5).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 4
node(22,2,3,0).
left_node(22,2,3).
right_node(22,2,4).
% node 3 (leaf): class 1 (1)
leaf_class(22,3,1).
% node 4 (leaf): class 0 (0)
leaf_class(22,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(22,5,0).
% node 6: Age_at_diagnosis <= 45.154998779296875  (F1, bin <= 8)  left -> 7, right -> 8
node(22,6,1,8).
left_node(22,6,7).
right_node(22,6,8).
% node 7 (leaf): class 0 (0)
leaf_class(22,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(22,8,0).

% Tree 23
tree(23).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 10
node(23,0,8,0).
left_node(23,0,1).
right_node(23,0,10).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 7
node(23,1,5,0).
left_node(23,1,2).
right_node(23,1,7).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 6
node(23,2,7,0).
left_node(23,2,3).
right_node(23,2,6).
% node 3: TP53 <= 0.5  (F4, bin <= 0)  left -> 4, right -> 5
node(23,3,4,0).
left_node(23,3,4).
right_node(23,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(23,4,1).
% node 5 (leaf): class 0 (0)
leaf_class(23,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(23,6,1).
% node 7: Age_at_diagnosis <= 40.90500068664551  (F1, bin <= 5)  left -> 8, right -> 9
node(23,7,1,5).
left_node(23,7,8).
right_node(23,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(23,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(23,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(23,10,0).

% Tree 24
tree(24).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 12
node(24,0,19,0).
left_node(24,0,1).
right_node(24,0,12).
% node 1: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 2, right -> 11
node(24,1,18,0).
left_node(24,1,2).
right_node(24,1,11).
% node 2: RB1 <= 0.5  (F14, bin <= 0)  left -> 3, right -> 10
node(24,2,14,0).
left_node(24,2,3).
right_node(24,2,10).
% node 3: Age_at_diagnosis <= 52.59000015258789  (F1, bin <= 20)  left -> 4, right -> 7
node(24,3,1,20).
left_node(24,3,4).
right_node(24,3,7).
% node 4: Age_at_diagnosis <= 39.03499984741211  (F1, bin <= 4)  left -> 5, right -> 6
node(24,4,1,4).
left_node(24,4,5).
right_node(24,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(24,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(24,6,0).
% node 7: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 8, right -> 9
node(24,7,13,0).
left_node(24,7,8).
right_node(24,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(24,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(24,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(24,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(24,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(24,12,1).

% Tree 25
tree(25).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 8
node(25,0,3,0).
left_node(25,0,1).
right_node(25,0,8).
% node 1: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 2, right -> 7
node(25,1,22,0).
left_node(25,1,2).
right_node(25,1,7).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 6
node(25,2,6,0).
left_node(25,2,3).
right_node(25,2,6).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 5
node(25,3,20,0).
left_node(25,3,4).
right_node(25,3,5).
% node 4 (leaf): class 1 (1)
leaf_class(25,4,1).
% node 5 (leaf): class 0 (0)
leaf_class(25,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(25,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(25,7,1).
% node 8: Age_at_diagnosis <= 24.049999237060547  (F1, bin <= 0)  left -> 9, right -> 10
node(25,8,1,0).
left_node(25,8,9).
right_node(25,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(25,9,0).
% node 10: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 11, right -> 12
node(25,10,12,0).
left_node(25,10,11).
right_node(25,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(25,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(25,12,0).

% Tree 26
tree(26).
% node 0: EGFR <= 0.5  (F7, bin <= 0)  left -> 1, right -> 10
node(26,0,7,0).
left_node(26,0,1).
right_node(26,0,10).
% node 1: Age_at_diagnosis <= 45.28999900817871  (F1, bin <= 10)  left -> 2, right -> 7
node(26,1,1,10).
left_node(26,1,2).
right_node(26,1,7).
% node 2: Race <= 0.5  (F2, bin <= 0)  left -> 3, right -> 6
node(26,2,2,0).
left_node(26,2,3).
right_node(26,2,6).
% node 3: Gender <= 0.5  (F0, bin <= 0)  left -> 4, right -> 5
node(26,3,0,0).
left_node(26,3,4).
right_node(26,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(26,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(26,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(26,6,0).
% node 7: ATRX <= 0.5  (F5, bin <= 0)  left -> 8, right -> 9
node(26,7,5,0).
left_node(26,7,8).
right_node(26,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(26,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(26,9,0).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 12
node(26,10,0,0).
left_node(26,10,11).
right_node(26,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(26,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(26,12,1).

% Tree 27
tree(27).
% node 0: Age_at_diagnosis <= 52.66499900817871  (F1, bin <= 23)  left -> 1, right -> 8
node(27,0,1,23).
left_node(27,0,1).
right_node(27,0,8).
% node 1: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 2, right -> 7
node(27,1,10,0).
left_node(27,1,2).
right_node(27,1,7).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 6
node(27,2,6,0).
left_node(27,2,3).
right_node(27,2,6).
% node 3: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 4, right -> 5
node(27,3,13,0).
left_node(27,3,4).
right_node(27,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(27,4,0).
% node 5 (leaf): class 0 (0)
leaf_class(27,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(27,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(27,7,0).
% node 8: MUC16 <= 0.5  (F9, bin <= 0)  left -> 9, right -> 16
node(27,8,9,0).
left_node(27,8,9).
right_node(27,8,16).
% node 9: CIC <= 0.5  (F8, bin <= 0)  left -> 10, right -> 15
node(27,9,8,0).
left_node(27,9,10).
right_node(27,9,15).
% node 10: IDH1 <= 0.5  (F3, bin <= 0)  left -> 11, right -> 14
node(27,10,3,0).
left_node(27,10,11).
right_node(27,10,14).
% node 11: Age_at_diagnosis <= 67.31000137329102  (F1, bin <= 34)  left -> 12, right -> 13
node(27,11,1,34).
left_node(27,11,12).
right_node(27,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(27,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(27,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(27,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(27,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(27,16,1).

% Tree 28
tree(28).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 10
node(28,0,6,0).
left_node(28,0,1).
right_node(28,0,10).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(28,1,3,0).
left_node(28,1,2).
right_node(28,1,9).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(28,2,20,0).
left_node(28,2,3).
right_node(28,2,8).
% node 3: NF1 <= 0.5  (F11, bin <= 0)  left -> 4, right -> 7
node(28,3,11,0).
left_node(28,3,4).
right_node(28,3,7).
% node 4: MUC16 <= 0.5  (F9, bin <= 0)  left -> 5, right -> 6
node(28,4,9,0).
left_node(28,4,5).
right_node(28,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(28,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(28,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(28,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(28,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(28,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(28,10,1).

% Tree 29
tree(29).
% node 0: IDH2 <= 0.5  (F20, bin <= 0)  left -> 1, right -> 10
node(29,0,20,0).
left_node(29,0,1).
right_node(29,0,10).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(29,1,3,0).
left_node(29,1,2).
right_node(29,1,9).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(29,2,9,0).
left_node(29,2,3).
right_node(29,2,8).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(29,3,14,0).
left_node(29,3,4).
right_node(29,3,7).
% node 4: Age_at_diagnosis <= 63.2450008392334  (F1, bin <= 31)  left -> 5, right -> 6
node(29,4,1,31).
left_node(29,4,5).
right_node(29,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(29,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(29,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(29,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(29,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(29,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(29,10,0).

% --- Class domain ---
class_idx(0).  % 0
class_idx(1).  % 1
