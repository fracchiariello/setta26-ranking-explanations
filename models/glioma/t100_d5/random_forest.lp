% ============================================================
% random_forest.lp — RF facts for glioma
% 100 trees  |  23 features
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

% Feature 0 (Gender): 2 bins  (thresholds: [0.5])
{bin(I,0,B) : B = 0..1} = 1 :- item(I).
bin_max(0,1).

% Feature 1 (Age_at_diagnosis): 173 bins  (thresholds: [21.315000534057617, 22.315000534057617, 24.0, 24.439998626708984, 24.5, 25.214998245239258, 25.244998931884766, 25.44999885559082, 26.405000686645508, 27.470001220703125, 27.639999389648438, 27.915000915527344, 28.635000228881836, 28.954999923706055, 29.255001068115234, 30.854999542236328, 30.975000381469727, 31.155000686645508, 31.270000457763672, 31.839998245239258, 32.040000915527344, 32.48999786376953, 32.584999084472656, 32.6349983215332, 32.744998931884766, 33.529998779296875, 35.19499969482422, 35.27000045776367, 35.46999740600586, 35.874996185302734, 36.054996490478516, 37.43499755859375, 38.474998474121094, 38.56999969482422, 38.869998931884766, 38.8849983215332, 39.03499984741211, 39.11499786376953, 39.30500030517578, 39.334999084472656, 39.6099967956543, 40.06999969482422, 40.380001068115234, 40.79499816894531, 41.82500076293945, 41.84499740600586, 41.915000915527344, 42.50499725341797, 43.14999771118164, 43.36499786376953, 43.529998779296875, 43.554996490478516, 43.644996643066406, 43.814998626708984, 44.125, 44.30999755859375, 44.46999740600586, 44.599998474121094, 45.154998779296875, 45.22999954223633, 45.279998779296875, 45.28999710083008, 45.35499954223633, 45.415000915527344, 45.47999954223633, 45.50499725341797, 45.57999801635742, 45.66999816894531, 45.720001220703125, 45.98999786376953, 46.15999984741211, 46.44499969482422, 46.47999954223633, 46.54999923706055, 46.57500076293945, 46.630001068115234, 46.689998626708984, 46.71500015258789, 47.04999923706055, 47.15999984741211, 47.16999816894531, 47.57999801635742, 48.154998779296875, 48.19999694824219, 48.43000030517578, 48.46999740600586, 48.67499923706055, 48.80999755859375, 48.814998626708984, 48.82999801635742, 48.84000015258789, 48.91999816894531, 48.94499969482422, 49.064998626708984, 49.209999084472656, 49.27499771118164, 49.279998779296875, 49.53499984741211, 50.03499984741211, 50.130001068115234, 50.63999938964844, 50.8650016784668, 51.07499694824219, 51.6099967956543, 52.00499725341797, 52.43499755859375, 52.51499938964844, 52.54999923706055, 52.59000015258789, 52.61000061035156, 52.619998931884766, 52.62999725341797, 52.67499923706055, 52.679996490478516, 52.72999954223633, 52.845001220703125, 53.02000045776367, 53.23999786376953, 53.39999771118164, 55.40999984741211, 56.994998931884766, 57.85499954223633, 57.93499755859375, 58.71500015258789, 58.85499954223633, 58.904998779296875, 59.474998474121094, 60.09000015258789, 60.209999084472656, 60.52000045776367, 61.03499984741211, 62.005001068115234, 62.3849983215332, 62.42499923706055, 63.22999954223633, 63.244998931884766, 63.349998474121094, 63.849998474121094, 64.05999755859375, 64.06999969482422, 64.94499969482422, 65.16500091552734, 66.12999725341797, 66.45999908447266, 66.5250015258789, 66.54999542236328, 66.93499755859375, 66.95500183105469, 67.30999755859375, 67.41500091552734, 68.0, 69.20999908447266, 69.32499694824219, 69.61499786376953, 70.37999725341797, 70.55500030517578, 70.61499786376953, 71.30000305175781, 71.46499633789062, 71.72999572753906, 71.73999786376953, 71.75499725341797, 71.88999938964844, 71.90999603271484, 74.06500244140625, 74.19000244140625, 74.44999694824219, 74.56500244140625, 74.70500183105469, 86.30500030517578, 86.70999908447266, 86.79499816894531])
{bin(I,1,B) : B = 0..172} = 1 :- item(I).
bin_max(1,172).

% Feature 2 (Race): 4 bins  (thresholds: [0.5, 1.5, 2.5])
{bin(I,2,B) : B = 0..3} = 1 :- item(I).
bin_max(2,3).

% Feature 3 (IDH1): 2 bins  (thresholds: [0.5])
{bin(I,3,B) : B = 0..1} = 1 :- item(I).
bin_max(3,1).

% Feature 4 (TP53): 2 bins  (thresholds: [0.5])
{bin(I,4,B) : B = 0..1} = 1 :- item(I).
bin_max(4,1).

% Feature 5 (ATRX): 2 bins  (thresholds: [0.5])
{bin(I,5,B) : B = 0..1} = 1 :- item(I).
bin_max(5,1).

% Feature 6 (PTEN): 2 bins  (thresholds: [0.5])
{bin(I,6,B) : B = 0..1} = 1 :- item(I).
bin_max(6,1).

% Feature 7 (EGFR): 2 bins  (thresholds: [0.5])
{bin(I,7,B) : B = 0..1} = 1 :- item(I).
bin_max(7,1).

% Feature 8 (CIC): 2 bins  (thresholds: [0.5])
{bin(I,8,B) : B = 0..1} = 1 :- item(I).
bin_max(8,1).

% Feature 9 (MUC16): 2 bins  (thresholds: [0.5])
{bin(I,9,B) : B = 0..1} = 1 :- item(I).
bin_max(9,1).

% Feature 10 (PIK3CA): 2 bins  (thresholds: [0.5])
{bin(I,10,B) : B = 0..1} = 1 :- item(I).
bin_max(10,1).

% Feature 11 (NF1): 2 bins  (thresholds: [0.5])
{bin(I,11,B) : B = 0..1} = 1 :- item(I).
bin_max(11,1).

% Feature 12 (PIK3R1): 2 bins  (thresholds: [0.5])
{bin(I,12,B) : B = 0..1} = 1 :- item(I).
bin_max(12,1).

% Feature 13 (FUBP1): 2 bins  (thresholds: [0.5])
{bin(I,13,B) : B = 0..1} = 1 :- item(I).
bin_max(13,1).

% Feature 14 (RB1): 2 bins  (thresholds: [0.5])
{bin(I,14,B) : B = 0..1} = 1 :- item(I).
bin_max(14,1).

% Feature 15 (NOTCH1): 2 bins  (thresholds: [0.5])
{bin(I,15,B) : B = 0..1} = 1 :- item(I).
bin_max(15,1).

% Feature 16 (BCOR): 2 bins  (thresholds: [0.5])
{bin(I,16,B) : B = 0..1} = 1 :- item(I).
bin_max(16,1).

% Feature 17 (CSMD3): 2 bins  (thresholds: [0.5])
{bin(I,17,B) : B = 0..1} = 1 :- item(I).
bin_max(17,1).

% Feature 18 (SMARCA4): 2 bins  (thresholds: [0.5])
{bin(I,18,B) : B = 0..1} = 1 :- item(I).
bin_max(18,1).

% Feature 19 (GRIN2A): 2 bins  (thresholds: [0.5])
{bin(I,19,B) : B = 0..1} = 1 :- item(I).
bin_max(19,1).

% Feature 20 (IDH2): 2 bins  (thresholds: [0.5])
{bin(I,20,B) : B = 0..1} = 1 :- item(I).
bin_max(20,1).

% Feature 21 (FAT4): 2 bins  (thresholds: [0.5])
{bin(I,21,B) : B = 0..1} = 1 :- item(I).
bin_max(21,1).

% Feature 22 (PDGFRA): 2 bins  (thresholds: [0.5])
{bin(I,22,B) : B = 0..1} = 1 :- item(I).
bin_max(22,1).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 110)  left -> 1, right -> 20
node(0,0,1,110).
left_node(0,0,1).
right_node(0,0,20).
% node 1: BCOR <= 0.5  (F16, bin <= 0)  left -> 2, right -> 13
node(0,1,16,0).
left_node(0,1,2).
right_node(0,1,13).
% node 2: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 3, right -> 10
node(0,2,12,0).
left_node(0,2,3).
right_node(0,2,10).
% node 3: Age_at_diagnosis <= 38.47500038146973  (F1, bin <= 32)  left -> 4, right -> 7
node(0,3,1,32).
left_node(0,3,4).
right_node(0,3,7).
% node 4: CIC <= 0.5  (F8, bin <= 0)  left -> 5, right -> 6
node(0,4,8,0).
left_node(0,4,5).
right_node(0,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(0,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(0,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(0,7,3,0).
left_node(0,7,8).
right_node(0,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(0,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(0,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 12
node(0,10,8,0).
left_node(0,10,11).
right_node(0,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(0,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(0,12,0).
% node 13: Gender <= 0.5  (F0, bin <= 0)  left -> 14, right -> 15
node(0,13,0,0).
left_node(0,13,14).
right_node(0,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(0,14,0).
% node 15: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 16, right -> 19
node(0,15,15,0).
left_node(0,15,16).
right_node(0,15,19).
% node 16: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 17, right -> 18
node(0,16,13,0).
left_node(0,16,17).
right_node(0,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(0,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(0,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(0,19,0).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 32
node(0,20,3,0).
left_node(0,20,21).
right_node(0,20,32).
% node 21: Age_at_diagnosis <= 71.30000305175781  (F1, bin <= 157)  left -> 22, right -> 27
node(0,21,1,157).
left_node(0,21,22).
right_node(0,21,27).
% node 22: IDH2 <= 0.5  (F20, bin <= 0)  left -> 23, right -> 26
node(0,22,20,0).
left_node(0,22,23).
right_node(0,22,26).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 25
node(0,23,6,0).
left_node(0,23,24).
right_node(0,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(0,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(0,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(0,26,0).
% node 27: MUC16 <= 0.5  (F9, bin <= 0)  left -> 28, right -> 31
node(0,27,9,0).
left_node(0,27,28).
right_node(0,27,31).
% node 28: PTEN <= 0.5  (F6, bin <= 0)  left -> 29, right -> 30
node(0,28,6,0).
left_node(0,28,29).
right_node(0,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(0,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(0,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(0,31,1).
% node 32: Age_at_diagnosis <= 53.239999771118164  (F1, bin <= 117)  left -> 33, right -> 36
node(0,32,1,117).
left_node(0,32,33).
right_node(0,32,36).
% node 33: FAT4 <= 0.5  (F21, bin <= 0)  left -> 34, right -> 35
node(0,33,21,0).
left_node(0,33,34).
right_node(0,33,35).
% node 34 (leaf): class 0 (0)
leaf_class(0,34,0).
% node 35 (leaf): class 1 (1)
leaf_class(0,35,1).
% node 36: ATRX <= 0.5  (F5, bin <= 0)  left -> 37, right -> 38
node(0,36,5,0).
left_node(0,36,37).
right_node(0,36,38).
% node 37 (leaf): class 0 (0)
leaf_class(0,37,0).
% node 38: TP53 <= 0.5  (F4, bin <= 0)  left -> 39, right -> 40
node(0,38,4,0).
left_node(0,38,39).
right_node(0,38,40).
% node 39 (leaf): class 0 (0)
leaf_class(0,39,0).
% node 40 (leaf): class 0 (0)
leaf_class(0,40,0).

% Tree 1
tree(1).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 26
node(1,0,8,0).
left_node(1,0,1).
right_node(1,0,26).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 17
node(1,1,5,0).
left_node(1,1,2).
right_node(1,1,17).
% node 2: FAT4 <= 0.5  (F21, bin <= 0)  left -> 3, right -> 10
node(1,2,21,0).
left_node(1,2,3).
right_node(1,2,10).
% node 3: Age_at_diagnosis <= 46.44500160217285  (F1, bin <= 71)  left -> 4, right -> 7
node(1,3,1,71).
left_node(1,3,4).
right_node(1,3,7).
% node 4: RB1 <= 0.5  (F14, bin <= 0)  left -> 5, right -> 6
node(1,4,14,0).
left_node(1,4,5).
right_node(1,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(1,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(1,6,1).
% node 7: Age_at_diagnosis <= 71.90999984741211  (F1, bin <= 163)  left -> 8, right -> 9
node(1,7,1,163).
left_node(1,7,8).
right_node(1,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(1,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(1,9,1).
% node 10: IDH1 <= 0.5  (F3, bin <= 0)  left -> 11, right -> 14
node(1,10,3,0).
left_node(1,10,11).
right_node(1,10,14).
% node 11: PTEN <= 0.5  (F6, bin <= 0)  left -> 12, right -> 13
node(1,11,6,0).
left_node(1,11,12).
right_node(1,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(1,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(1,13,0).
% node 14: Age_at_diagnosis <= 45.415000915527344  (F1, bin <= 63)  left -> 15, right -> 16
node(1,14,1,63).
left_node(1,14,15).
right_node(1,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(1,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(1,16,1).
% node 17: PTEN <= 0.5  (F6, bin <= 0)  left -> 18, right -> 25
node(1,17,6,0).
left_node(1,17,18).
right_node(1,17,25).
% node 18: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 19, right -> 22
node(1,18,12,0).
left_node(1,18,19).
right_node(1,18,22).
% node 19: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 20, right -> 21
node(1,19,15,0).
left_node(1,19,20).
right_node(1,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(1,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(1,21,0).
% node 22: MUC16 <= 0.5  (F9, bin <= 0)  left -> 23, right -> 24
node(1,22,9,0).
left_node(1,22,23).
right_node(1,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(1,23,1).
% node 24 (leaf): class 0 (0)
leaf_class(1,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(1,25,1).
% node 26: RB1 <= 0.5  (F14, bin <= 0)  left -> 27, right -> 34
node(1,26,14,0).
left_node(1,26,27).
right_node(1,26,34).
% node 27: TP53 <= 0.5  (F4, bin <= 0)  left -> 28, right -> 29
node(1,27,4,0).
left_node(1,27,28).
right_node(1,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(1,28,0).
% node 29: MUC16 <= 0.5  (F9, bin <= 0)  left -> 30, right -> 33
node(1,29,9,0).
left_node(1,29,30).
right_node(1,29,33).
% node 30: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 31, right -> 32
node(1,30,13,0).
left_node(1,30,31).
right_node(1,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(1,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(1,32,0).
% node 33 (leaf): class 0 (0)
leaf_class(1,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(1,34,1).

% Tree 2
tree(2).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 20
node(2,0,5,0).
left_node(2,0,1).
right_node(2,0,20).
% node 1: RB1 <= 0.5  (F14, bin <= 0)  left -> 2, right -> 13
node(2,1,14,0).
left_node(2,1,2).
right_node(2,1,13).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(2,2,3,0).
left_node(2,2,3).
right_node(2,2,8).
% node 3: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 4, right -> 7
node(2,3,13,0).
left_node(2,3,4).
right_node(2,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(2,4,7,0).
left_node(2,4,5).
right_node(2,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(2,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(2,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(2,7,0).
% node 8: TP53 <= 0.5  (F4, bin <= 0)  left -> 9, right -> 10
node(2,8,4,0).
left_node(2,8,9).
right_node(2,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(2,9,0).
% node 10: Age_at_diagnosis <= 50.130001068115234  (F1, bin <= 99)  left -> 11, right -> 12
node(2,10,1,99).
left_node(2,10,11).
right_node(2,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(2,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(2,12,0).
% node 13: IDH1 <= 0.5  (F3, bin <= 0)  left -> 14, right -> 19
node(2,13,3,0).
left_node(2,13,14).
right_node(2,13,19).
% node 14: MUC16 <= 0.5  (F9, bin <= 0)  left -> 15, right -> 18
node(2,14,9,0).
left_node(2,14,15).
right_node(2,14,18).
% node 15: Gender <= 0.5  (F0, bin <= 0)  left -> 16, right -> 17
node(2,15,0,0).
left_node(2,15,16).
right_node(2,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(2,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(2,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(2,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(2,19,0).
% node 20: RB1 <= 0.5  (F14, bin <= 0)  left -> 21, right -> 30
node(2,20,14,0).
left_node(2,20,21).
right_node(2,20,30).
% node 21: PTEN <= 0.5  (F6, bin <= 0)  left -> 22, right -> 27
node(2,21,6,0).
left_node(2,21,22).
right_node(2,21,27).
% node 22: NF1 <= 0.5  (F11, bin <= 0)  left -> 23, right -> 26
node(2,22,11,0).
left_node(2,22,23).
right_node(2,22,26).
% node 23: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 24, right -> 25
node(2,23,15,0).
left_node(2,23,24).
right_node(2,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(2,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(2,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(2,26,0).
% node 27: IDH1 <= 0.5  (F3, bin <= 0)  left -> 28, right -> 29
node(2,27,3,0).
left_node(2,27,28).
right_node(2,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(2,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(2,29,0).
% node 30 (leaf): class 1 (1)
leaf_class(2,30,1).

% Tree 3
tree(3).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 20
node(3,0,3,0).
left_node(3,0,1).
right_node(3,0,20).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 11
node(3,1,6,0).
left_node(3,1,2).
right_node(3,1,11).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 10
node(3,2,20,0).
left_node(3,2,3).
right_node(3,2,10).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(3,3,9,0).
left_node(3,3,4).
right_node(3,3,7).
% node 4: TP53 <= 0.5  (F4, bin <= 0)  left -> 5, right -> 6
node(3,4,4,0).
left_node(3,4,5).
right_node(3,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(3,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(3,6,1).
% node 7: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 8, right -> 9
node(3,7,10,0).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(3,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(3,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(3,10,0).
% node 11: FAT4 <= 0.5  (F21, bin <= 0)  left -> 12, right -> 19
node(3,11,21,0).
left_node(3,11,12).
right_node(3,11,19).
% node 12: NF1 <= 0.5  (F11, bin <= 0)  left -> 13, right -> 16
node(3,12,11,0).
left_node(3,12,13).
right_node(3,12,16).
% node 13: RB1 <= 0.5  (F14, bin <= 0)  left -> 14, right -> 15
node(3,13,14,0).
left_node(3,13,14).
right_node(3,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(3,14,1).
% node 15 (leaf): class 1 (1)
leaf_class(3,15,1).
% node 16: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 17, right -> 18
node(3,16,17,0).
left_node(3,16,17).
right_node(3,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(3,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(3,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(3,19,0).
% node 20: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 21, right -> 28
node(3,20,10,0).
left_node(3,20,21).
right_node(3,20,28).
% node 21: EGFR <= 0.5  (F7, bin <= 0)  left -> 22, right -> 27
node(3,21,7,0).
left_node(3,21,22).
right_node(3,21,27).
% node 22: MUC16 <= 0.5  (F9, bin <= 0)  left -> 23, right -> 26
node(3,22,9,0).
left_node(3,22,23).
right_node(3,22,26).
% node 23: ATRX <= 0.5  (F5, bin <= 0)  left -> 24, right -> 25
node(3,23,5,0).
left_node(3,23,24).
right_node(3,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(3,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(3,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(3,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(3,27,1).
% node 28: ATRX <= 0.5  (F5, bin <= 0)  left -> 29, right -> 30
node(3,28,5,0).
left_node(3,28,29).
right_node(3,28,30).
% node 29 (leaf): class 0 (0)
leaf_class(3,29,0).
% node 30 (leaf): class 1 (1)
leaf_class(3,30,1).

% Tree 4
tree(4).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 24
node(4,0,6,0).
left_node(4,0,1).
right_node(4,0,24).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 11
node(4,1,4,0).
left_node(4,1,2).
right_node(4,1,11).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 10
node(4,2,8,0).
left_node(4,2,3).
right_node(4,2,10).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(4,3,9,0).
left_node(4,3,4).
right_node(4,3,7).
% node 4: BCOR <= 0.5  (F16, bin <= 0)  left -> 5, right -> 6
node(4,4,16,0).
left_node(4,4,5).
right_node(4,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(4,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(4,6,0).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(4,7,0,0).
left_node(4,7,8).
right_node(4,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(4,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(4,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(4,10,0).
% node 11: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 110)  left -> 12, right -> 19
node(4,11,1,110).
left_node(4,11,12).
right_node(4,11,19).
% node 12: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 13, right -> 16
node(4,12,13,0).
left_node(4,12,13).
right_node(4,12,16).
% node 13: Age_at_diagnosis <= 42.5049991607666  (F1, bin <= 47)  left -> 14, right -> 15
node(4,13,1,47).
left_node(4,13,14).
right_node(4,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(4,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(4,15,0).
% node 16: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 17, right -> 18
node(4,16,12,0).
left_node(4,16,17).
right_node(4,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(4,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(4,18,1).
% node 19: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 20, right -> 23
node(4,19,15,0).
left_node(4,19,20).
right_node(4,19,23).
% node 20: BCOR <= 0.5  (F16, bin <= 0)  left -> 21, right -> 22
node(4,20,16,0).
left_node(4,20,21).
right_node(4,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(4,21,1).
% node 22 (leaf): class 1 (1)
leaf_class(4,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(4,23,0).
% node 24: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 25, right -> 32
node(4,24,12,0).
left_node(4,24,25).
right_node(4,24,32).
% node 25: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 26, right -> 31
node(4,25,18,0).
left_node(4,25,26).
right_node(4,25,31).
% node 26: CIC <= 0.5  (F8, bin <= 0)  left -> 27, right -> 30
node(4,26,8,0).
left_node(4,26,27).
right_node(4,26,30).
% node 27: NF1 <= 0.5  (F11, bin <= 0)  left -> 28, right -> 29
node(4,27,11,0).
left_node(4,27,28).
right_node(4,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(4,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(4,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(4,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(4,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(4,32,1).

% Tree 5
tree(5).
% node 0: Race <= 0.5  (F2, bin <= 0)  left -> 1, right -> 20
node(5,0,2,0).
left_node(5,0,1).
right_node(5,0,20).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 15
node(5,1,13,0).
left_node(5,1,2).
right_node(5,1,15).
% node 2: Age_at_diagnosis <= 44.30999946594238  (F1, bin <= 55)  left -> 3, right -> 10
node(5,2,1,55).
left_node(5,2,3).
right_node(5,2,10).
% node 3: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 4, right -> 7
node(5,3,12,0).
left_node(5,3,4).
right_node(5,3,7).
% node 4: RB1 <= 0.5  (F14, bin <= 0)  left -> 5, right -> 6
node(5,4,14,0).
left_node(5,4,5).
right_node(5,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(5,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(5,6,1).
% node 7: EGFR <= 0.5  (F7, bin <= 0)  left -> 8, right -> 9
node(5,7,7,0).
left_node(5,7,8).
right_node(5,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(5,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(5,9,1).
% node 10: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 11, right -> 14
node(5,10,15,0).
left_node(5,10,11).
right_node(5,10,14).
% node 11: CIC <= 0.5  (F8, bin <= 0)  left -> 12, right -> 13
node(5,11,8,0).
left_node(5,11,12).
right_node(5,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(5,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(5,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(5,14,0).
% node 15: PTEN <= 0.5  (F6, bin <= 0)  left -> 16, right -> 19
node(5,15,6,0).
left_node(5,15,16).
right_node(5,15,19).
% node 16: RB1 <= 0.5  (F14, bin <= 0)  left -> 17, right -> 18
node(5,16,14,0).
left_node(5,16,17).
right_node(5,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(5,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(5,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(5,19,1).
% node 20: CIC <= 0.5  (F8, bin <= 0)  left -> 21, right -> 34
node(5,20,8,0).
left_node(5,20,21).
right_node(5,20,34).
% node 21: EGFR <= 0.5  (F7, bin <= 0)  left -> 22, right -> 29
node(5,21,7,0).
left_node(5,21,22).
right_node(5,21,29).
% node 22: IDH1 <= 0.5  (F3, bin <= 0)  left -> 23, right -> 26
node(5,22,3,0).
left_node(5,22,23).
right_node(5,22,26).
% node 23: Age_at_diagnosis <= 67.31000137329102  (F1, bin <= 148)  left -> 24, right -> 25
node(5,23,1,148).
left_node(5,23,24).
right_node(5,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(5,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(5,25,1).
% node 26: Race <= 1.5  (F2, bin <= 1)  left -> 27, right -> 28
node(5,26,2,1).
left_node(5,26,27).
right_node(5,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(5,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(5,28,1).
% node 29: Gender <= 0.5  (F0, bin <= 0)  left -> 30, right -> 31
node(5,29,0,0).
left_node(5,29,30).
right_node(5,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(5,30,1).
% node 31: TP53 <= 0.5  (F4, bin <= 0)  left -> 32, right -> 33
node(5,31,4,0).
left_node(5,31,32).
right_node(5,31,33).
% node 32 (leaf): class 1 (1)
leaf_class(5,32,1).
% node 33 (leaf): class 1 (1)
leaf_class(5,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(5,34,0).

% Tree 6
tree(6).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 26
node(6,0,8,0).
left_node(6,0,1).
right_node(6,0,26).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(6,1,3,0).
left_node(6,1,2).
right_node(6,1,13).
% node 2: Age_at_diagnosis <= 70.55500030517578  (F1, bin <= 155)  left -> 3, right -> 10
node(6,2,1,155).
left_node(6,2,3).
right_node(6,2,10).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(6,3,20,0).
left_node(6,3,4).
right_node(6,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(6,4,7,0).
left_node(6,4,5).
right_node(6,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(6,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(6,6,1).
% node 7: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 8, right -> 9
node(6,7,19,0).
left_node(6,7,8).
right_node(6,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(6,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(6,9,1).
% node 10: Age_at_diagnosis <= 86.70999908447266  (F1, bin <= 170)  left -> 11, right -> 12
node(6,10,1,170).
left_node(6,10,11).
right_node(6,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(6,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(6,12,0).
% node 13: Race <= 0.5  (F2, bin <= 0)  left -> 14, right -> 19
node(6,13,2,0).
left_node(6,13,14).
right_node(6,13,19).
% node 14: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 15, right -> 18
node(6,14,18,0).
left_node(6,14,15).
right_node(6,14,18).
% node 15: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 16, right -> 17
node(6,15,22,0).
left_node(6,15,16).
right_node(6,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(6,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(6,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(6,18,0).
% node 19: Race <= 1.5  (F2, bin <= 1)  left -> 20, right -> 23
node(6,19,2,1).
left_node(6,19,20).
right_node(6,19,23).
% node 20: Gender <= 0.5  (F0, bin <= 0)  left -> 21, right -> 22
node(6,20,0,0).
left_node(6,20,21).
right_node(6,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(6,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(6,22,0).
% node 23: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 24, right -> 25
node(6,23,18,0).
left_node(6,23,24).
right_node(6,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(6,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(6,25,0).
% node 26: Age_at_diagnosis <= 24.5  (F1, bin <= 4)  left -> 27, right -> 28
node(6,26,1,4).
left_node(6,26,27).
right_node(6,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(6,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(6,28,0).

% Tree 7
tree(7).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 16
node(7,0,14,0).
left_node(7,0,1).
right_node(7,0,16).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 15
node(7,1,8,0).
left_node(7,1,2).
right_node(7,1,15).
% node 2: TP53 <= 0.5  (F4, bin <= 0)  left -> 3, right -> 8
node(7,2,4,0).
left_node(7,2,3).
right_node(7,2,8).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(7,3,3,0).
left_node(7,3,4).
right_node(7,3,7).
% node 4: BCOR <= 0.5  (F16, bin <= 0)  left -> 5, right -> 6
node(7,4,16,0).
left_node(7,4,5).
right_node(7,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(7,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(7,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(7,7,0).
% node 8: PTEN <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(7,8,6,0).
left_node(7,8,9).
right_node(7,8,12).
% node 9: BCOR <= 0.5  (F16, bin <= 0)  left -> 10, right -> 11
node(7,9,16,0).
left_node(7,9,10).
right_node(7,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(7,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(7,11,1).
% node 12: ATRX <= 0.5  (F5, bin <= 0)  left -> 13, right -> 14
node(7,12,5,0).
left_node(7,12,13).
right_node(7,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(7,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(7,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(7,15,0).
% node 16: TP53 <= 0.5  (F4, bin <= 0)  left -> 17, right -> 26
node(7,16,4,0).
left_node(7,16,17).
right_node(7,16,26).
% node 17: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 18, right -> 25
node(7,17,19,0).
left_node(7,17,18).
right_node(7,17,25).
% node 18: Gender <= 0.5  (F0, bin <= 0)  left -> 19, right -> 22
node(7,18,0,0).
left_node(7,18,19).
right_node(7,18,22).
% node 19: Age_at_diagnosis <= 51.60999870300293  (F1, bin <= 103)  left -> 20, right -> 21
node(7,19,1,103).
left_node(7,19,20).
right_node(7,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(7,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(7,21,0).
% node 22: Age_at_diagnosis <= 69.32500076293945  (F1, bin <= 152)  left -> 23, right -> 24
node(7,22,1,152).
left_node(7,22,23).
right_node(7,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(7,23,0).
% node 24 (leaf): class 1 (1)
leaf_class(7,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(7,25,1).
% node 26: Age_at_diagnosis <= 38.885000228881836  (F1, bin <= 35)  left -> 27, right -> 30
node(7,26,1,35).
left_node(7,26,27).
right_node(7,26,30).
% node 27: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 28, right -> 29
node(7,27,12,0).
left_node(7,27,28).
right_node(7,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(7,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(7,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(7,30,1).

% Tree 8
tree(8).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 26
node(8,0,15,0).
left_node(8,0,1).
right_node(8,0,26).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(8,1,6,0).
left_node(8,1,2).
right_node(8,1,15).
% node 2: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 3, right -> 10
node(8,2,22,0).
left_node(8,2,3).
right_node(8,2,10).
% node 3: Age_at_diagnosis <= 45.35499954223633  (F1, bin <= 62)  left -> 4, right -> 7
node(8,3,1,62).
left_node(8,3,4).
right_node(8,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(8,4,7,0).
left_node(8,4,5).
right_node(8,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(8,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(8,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(8,7,3,0).
left_node(8,7,8).
right_node(8,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(8,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(8,9,0).
% node 10: TP53 <= 0.5  (F4, bin <= 0)  left -> 11, right -> 14
node(8,10,4,0).
left_node(8,10,11).
right_node(8,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(8,11,0,0).
left_node(8,11,12).
right_node(8,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(8,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(8,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(8,14,1).
% node 15: TP53 <= 0.5  (F4, bin <= 0)  left -> 16, right -> 21
node(8,15,4,0).
left_node(8,15,16).
right_node(8,15,21).
% node 16: FAT4 <= 0.5  (F21, bin <= 0)  left -> 17, right -> 20
node(8,16,21,0).
left_node(8,16,17).
right_node(8,16,20).
% node 17: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 18, right -> 19
node(8,17,19,0).
left_node(8,17,18).
right_node(8,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(8,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(8,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(8,20,0).
% node 21: Age_at_diagnosis <= 33.52999973297119  (F1, bin <= 25)  left -> 22, right -> 23
node(8,21,1,25).
left_node(8,21,22).
right_node(8,21,23).
% node 22 (leaf): class 0 (0)
leaf_class(8,22,0).
% node 23: Gender <= 0.5  (F0, bin <= 0)  left -> 24, right -> 25
node(8,23,0,0).
left_node(8,23,24).
right_node(8,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(8,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(8,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(8,26,0).

% Tree 9
tree(9).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 22
node(9,0,8,0).
left_node(9,0,1).
right_node(9,0,22).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 13
node(9,1,4,0).
left_node(9,1,2).
right_node(9,1,13).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(9,2,3,0).
left_node(9,2,3).
right_node(9,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(9,3,20,0).
left_node(9,3,4).
right_node(9,3,7).
% node 4: FAT4 <= 0.5  (F21, bin <= 0)  left -> 5, right -> 6
node(9,4,21,0).
left_node(9,4,5).
right_node(9,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(9,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(9,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(9,7,0).
% node 8: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 9, right -> 12
node(9,8,18,0).
left_node(9,8,9).
right_node(9,8,12).
% node 9: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 10, right -> 11
node(9,9,13,0).
left_node(9,9,10).
right_node(9,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(9,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(9,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(9,12,0).
% node 13: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 14, right -> 21
node(9,13,18,0).
left_node(9,13,14).
right_node(9,13,21).
% node 14: IDH1 <= 0.5  (F3, bin <= 0)  left -> 15, right -> 18
node(9,14,3,0).
left_node(9,14,15).
right_node(9,14,18).
% node 15: Race <= 0.5  (F2, bin <= 0)  left -> 16, right -> 17
node(9,15,2,0).
left_node(9,15,16).
right_node(9,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(9,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(9,17,1).
% node 18: Age_at_diagnosis <= 39.03499984741211  (F1, bin <= 36)  left -> 19, right -> 20
node(9,18,1,36).
left_node(9,18,19).
right_node(9,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(9,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(9,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(9,21,0).
% node 22: FAT4 <= 0.5  (F21, bin <= 0)  left -> 23, right -> 24
node(9,22,21,0).
left_node(9,22,23).
right_node(9,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(9,23,0).
% node 24: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 25, right -> 26
node(9,24,15,0).
left_node(9,24,25).
right_node(9,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(9,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(9,26,0).

% Tree 10
tree(10).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 18
node(10,0,15,0).
left_node(10,0,1).
right_node(10,0,18).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 9
node(10,1,5,0).
left_node(10,1,2).
right_node(10,1,9).
% node 2: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 3, right -> 8
node(10,2,18,0).
left_node(10,2,3).
right_node(10,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(10,3,8,0).
left_node(10,3,4).
right_node(10,3,7).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 6
node(10,4,6,0).
left_node(10,4,5).
right_node(10,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(10,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(10,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(10,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(10,8,0).
% node 9: EGFR <= 0.5  (F7, bin <= 0)  left -> 10, right -> 17
node(10,9,7,0).
left_node(10,9,10).
right_node(10,9,17).
% node 10: IDH1 <= 0.5  (F3, bin <= 0)  left -> 11, right -> 14
node(10,10,3,0).
left_node(10,10,11).
right_node(10,10,14).
% node 11: BCOR <= 0.5  (F16, bin <= 0)  left -> 12, right -> 13
node(10,11,16,0).
left_node(10,11,12).
right_node(10,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(10,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(10,13,1).
% node 14: BCOR <= 0.5  (F16, bin <= 0)  left -> 15, right -> 16
node(10,14,16,0).
left_node(10,14,15).
right_node(10,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(10,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(10,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(10,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(10,18,0).

% Tree 11
tree(11).
% node 0: Age_at_diagnosis <= 45.47999954223633  (F1, bin <= 64)  left -> 1, right -> 18
node(11,0,1,64).
left_node(11,0,1).
right_node(11,0,18).
% node 1: RB1 <= 0.5  (F14, bin <= 0)  left -> 2, right -> 13
node(11,1,14,0).
left_node(11,1,2).
right_node(11,1,13).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 8
node(11,2,19,0).
left_node(11,2,3).
right_node(11,2,8).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(11,3,7,0).
left_node(11,3,4).
right_node(11,3,7).
% node 4: Race <= 0.5  (F2, bin <= 0)  left -> 5, right -> 6
node(11,4,2,0).
left_node(11,4,5).
right_node(11,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(11,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(11,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(11,7,1).
% node 8: EGFR <= 0.5  (F7, bin <= 0)  left -> 9, right -> 10
node(11,8,7,0).
left_node(11,8,9).
right_node(11,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(11,9,0).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 12
node(11,10,0,0).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(11,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(11,12,0).
% node 13: NF1 <= 0.5  (F11, bin <= 0)  left -> 14, right -> 15
node(11,13,11,0).
left_node(11,13,14).
right_node(11,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(11,14,1).
% node 15: PTEN <= 0.5  (F6, bin <= 0)  left -> 16, right -> 17
node(11,15,6,0).
left_node(11,15,16).
right_node(11,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(11,16,1).
% node 17 (leaf): class 0 (0)
leaf_class(11,17,0).
% node 18: IDH1 <= 0.5  (F3, bin <= 0)  left -> 19, right -> 28
node(11,18,3,0).
left_node(11,18,19).
right_node(11,18,28).
% node 19: IDH2 <= 0.5  (F20, bin <= 0)  left -> 20, right -> 27
node(11,19,20,0).
left_node(11,19,20).
right_node(11,19,27).
% node 20: FAT4 <= 0.5  (F21, bin <= 0)  left -> 21, right -> 24
node(11,20,21,0).
left_node(11,20,21).
right_node(11,20,24).
% node 21: Age_at_diagnosis <= 67.31000137329102  (F1, bin <= 148)  left -> 22, right -> 23
node(11,21,1,148).
left_node(11,21,22).
right_node(11,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(11,22,1).
% node 23 (leaf): class 1 (1)
leaf_class(11,23,1).
% node 24: PTEN <= 0.5  (F6, bin <= 0)  left -> 25, right -> 26
node(11,24,6,0).
left_node(11,24,25).
right_node(11,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(11,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(11,26,0).
% node 27 (leaf): class 0 (0)
leaf_class(11,27,0).
% node 28: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 29, right -> 34
node(11,28,12,0).
left_node(11,28,29).
right_node(11,28,34).
% node 29: CIC <= 0.5  (F8, bin <= 0)  left -> 30, right -> 33
node(11,29,8,0).
left_node(11,29,30).
right_node(11,29,33).
% node 30: BCOR <= 0.5  (F16, bin <= 0)  left -> 31, right -> 32
node(11,30,16,0).
left_node(11,30,31).
right_node(11,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(11,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(11,32,0).
% node 33 (leaf): class 0 (0)
leaf_class(11,33,0).
% node 34: TP53 <= 0.5  (F4, bin <= 0)  left -> 35, right -> 38
node(11,34,4,0).
left_node(11,34,35).
right_node(11,34,38).
% node 35: NF1 <= 0.5  (F11, bin <= 0)  left -> 36, right -> 37
node(11,35,11,0).
left_node(11,35,36).
right_node(11,35,37).
% node 36 (leaf): class 0 (0)
leaf_class(11,36,0).
% node 37 (leaf): class 0 (0)
leaf_class(11,37,0).
% node 38 (leaf): class 0 (0)
leaf_class(11,38,0).

% Tree 12
tree(12).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 12
node(12,0,19,0).
left_node(12,0,1).
right_node(12,0,12).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 11
node(12,1,20,0).
left_node(12,1,2).
right_node(12,1,11).
% node 2: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 3, right -> 10
node(12,2,13,0).
left_node(12,2,3).
right_node(12,2,10).
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
% node 7: Age_at_diagnosis <= 71.75499725341797  (F1, bin <= 161)  left -> 8, right -> 9
node(12,7,1,161).
left_node(12,7,8).
right_node(12,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(12,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(12,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(12,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(12,11,0).
% node 12: Age_at_diagnosis <= 38.8700008392334  (F1, bin <= 34)  left -> 13, right -> 16
node(12,12,1,34).
left_node(12,12,13).
right_node(12,12,16).
% node 13: CIC <= 0.5  (F8, bin <= 0)  left -> 14, right -> 15
node(12,13,8,0).
left_node(12,13,14).
right_node(12,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(12,14,0).
% node 15 (leaf): class 1 (1)
leaf_class(12,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(12,16,1).

% Tree 13
tree(13).
% node 0: Age_at_diagnosis <= 45.22999954223633  (F1, bin <= 59)  left -> 1, right -> 22
node(13,0,1,59).
left_node(13,0,1).
right_node(13,0,22).
% node 1: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 2, right -> 15
node(13,1,12,0).
left_node(13,1,2).
right_node(13,1,15).
% node 2: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 3, right -> 10
node(13,2,22,0).
left_node(13,2,3).
right_node(13,2,10).
% node 3: Gender <= 0.5  (F0, bin <= 0)  left -> 4, right -> 7
node(13,3,0,0).
left_node(13,3,4).
right_node(13,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(13,4,5,0).
left_node(13,4,5).
right_node(13,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(13,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(13,6,0).
% node 7: IDH2 <= 0.5  (F20, bin <= 0)  left -> 8, right -> 9
node(13,7,20,0).
left_node(13,7,8).
right_node(13,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(13,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(13,9,0).
% node 10: IDH1 <= 0.5  (F3, bin <= 0)  left -> 11, right -> 12
node(13,10,3,0).
left_node(13,10,11).
right_node(13,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(13,11,0).
% node 12: TP53 <= 0.5  (F4, bin <= 0)  left -> 13, right -> 14
node(13,12,4,0).
left_node(13,12,13).
right_node(13,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(13,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(13,14,1).
% node 15: IDH1 <= 0.5  (F3, bin <= 0)  left -> 16, right -> 17
node(13,15,3,0).
left_node(13,15,16).
right_node(13,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(13,16,1).
% node 17: CIC <= 0.5  (F8, bin <= 0)  left -> 18, right -> 21
node(13,17,8,0).
left_node(13,17,18).
right_node(13,17,21).
% node 18: Age_at_diagnosis <= 31.839999198913574  (F1, bin <= 19)  left -> 19, right -> 20
node(13,18,1,19).
left_node(13,18,19).
right_node(13,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(13,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(13,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(13,21,0).
% node 22: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 23, right -> 32
node(13,22,19,0).
left_node(13,22,23).
right_node(13,22,32).
% node 23: IDH1 <= 0.5  (F3, bin <= 0)  left -> 24, right -> 29
node(13,23,3,0).
left_node(13,23,24).
right_node(13,23,29).
% node 24: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 25, right -> 28
node(13,24,15,0).
left_node(13,24,25).
right_node(13,24,28).
% node 25: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 26, right -> 27
node(13,25,18,0).
left_node(13,25,26).
right_node(13,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(13,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(13,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(13,28,0).
% node 29: Age_at_diagnosis <= 45.670000076293945  (F1, bin <= 67)  left -> 30, right -> 31
node(13,29,1,67).
left_node(13,29,30).
right_node(13,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(13,30,1).
% node 31 (leaf): class 0 (0)
leaf_class(13,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(13,32,1).

% Tree 14
tree(14).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 16
node(14,0,5,0).
left_node(14,0,1).
right_node(14,0,16).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 13
node(14,1,13,0).
left_node(14,1,2).
right_node(14,1,13).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(14,2,3,0).
left_node(14,2,3).
right_node(14,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(14,3,20,0).
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
% node 7 (leaf): class 0 (0)
leaf_class(14,7,0).
% node 8: BCOR <= 0.5  (F16, bin <= 0)  left -> 9, right -> 12
node(14,8,16,0).
left_node(14,8,9).
right_node(14,8,12).
% node 9: TP53 <= 0.5  (F4, bin <= 0)  left -> 10, right -> 11
node(14,9,4,0).
left_node(14,9,10).
right_node(14,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(14,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(14,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(14,12,0).
% node 13: IDH1 <= 0.5  (F3, bin <= 0)  left -> 14, right -> 15
node(14,13,3,0).
left_node(14,13,14).
right_node(14,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(14,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(14,15,0).
% node 16: IDH2 <= 0.5  (F20, bin <= 0)  left -> 17, right -> 26
node(14,16,20,0).
left_node(14,16,17).
right_node(14,16,26).
% node 17: RB1 <= 0.5  (F14, bin <= 0)  left -> 18, right -> 25
node(14,17,14,0).
left_node(14,17,18).
right_node(14,17,25).
% node 18: IDH1 <= 0.5  (F3, bin <= 0)  left -> 19, right -> 22
node(14,18,3,0).
left_node(14,18,19).
right_node(14,18,22).
% node 19: EGFR <= 0.5  (F7, bin <= 0)  left -> 20, right -> 21
node(14,19,7,0).
left_node(14,19,20).
right_node(14,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(14,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(14,21,1).
% node 22: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 23, right -> 24
node(14,22,12,0).
left_node(14,22,23).
right_node(14,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(14,23,0).
% node 24 (leaf): class 1 (1)
leaf_class(14,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(14,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(14,26,1).

% Tree 15
tree(15).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 18
node(15,0,6,0).
left_node(15,0,1).
right_node(15,0,18).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 15
node(15,1,13,0).
left_node(15,1,2).
right_node(15,1,15).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(15,2,9,0).
left_node(15,2,3).
right_node(15,2,10).
% node 3: Age_at_diagnosis <= 50.8650016784668  (F1, bin <= 101)  left -> 4, right -> 7
node(15,3,1,101).
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
% node 7: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 8, right -> 9
node(15,7,19,0).
left_node(15,7,8).
right_node(15,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(15,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(15,9,1).
% node 10: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 11, right -> 14
node(15,10,22,0).
left_node(15,10,11).
right_node(15,10,14).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(15,11,3,0).
left_node(15,11,12).
right_node(15,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(15,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(15,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(15,14,1).
% node 15: RB1 <= 0.5  (F14, bin <= 0)  left -> 16, right -> 17
node(15,15,14,0).
left_node(15,15,16).
right_node(15,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(15,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(15,17,1).
% node 18: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 19, right -> 28
node(15,18,15,0).
left_node(15,18,19).
right_node(15,18,28).
% node 19: CIC <= 0.5  (F8, bin <= 0)  left -> 20, right -> 27
node(15,19,8,0).
left_node(15,19,20).
right_node(15,19,27).
% node 20: NF1 <= 0.5  (F11, bin <= 0)  left -> 21, right -> 24
node(15,20,11,0).
left_node(15,20,21).
right_node(15,20,24).
% node 21: IDH1 <= 0.5  (F3, bin <= 0)  left -> 22, right -> 23
node(15,21,3,0).
left_node(15,21,22).
right_node(15,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(15,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(15,23,0).
% node 24: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 25, right -> 26
node(15,24,12,0).
left_node(15,24,25).
right_node(15,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(15,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(15,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(15,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(15,28,0).

% Tree 16
tree(16).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 16
node(16,0,5,0).
left_node(16,0,1).
right_node(16,0,16).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 15
node(16,1,8,0).
left_node(16,1,2).
right_node(16,1,15).
% node 2: Age_at_diagnosis <= 43.529998779296875  (F1, bin <= 50)  left -> 3, right -> 10
node(16,2,1,50).
left_node(16,2,3).
right_node(16,2,10).
% node 3: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 4, right -> 7
node(16,3,17,0).
left_node(16,3,4).
right_node(16,3,7).
% node 4: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 5, right -> 6
node(16,4,18,0).
left_node(16,4,5).
right_node(16,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(16,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(16,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(16,7,3,0).
left_node(16,7,8).
right_node(16,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(16,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(16,9,0).
% node 10: IDH2 <= 0.5  (F20, bin <= 0)  left -> 11, right -> 14
node(16,10,20,0).
left_node(16,10,11).
right_node(16,10,14).
% node 11: RB1 <= 0.5  (F14, bin <= 0)  left -> 12, right -> 13
node(16,11,14,0).
left_node(16,11,12).
right_node(16,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(16,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(16,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(16,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(16,15,0).
% node 16: RB1 <= 0.5  (F14, bin <= 0)  left -> 17, right -> 26
node(16,16,14,0).
left_node(16,16,17).
right_node(16,16,26).
% node 17: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 18, right -> 25
node(16,17,13,0).
left_node(16,17,18).
right_node(16,17,25).
% node 18: IDH1 <= 0.5  (F3, bin <= 0)  left -> 19, right -> 22
node(16,18,3,0).
left_node(16,18,19).
right_node(16,18,22).
% node 19: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 20, right -> 21
node(16,19,22,0).
left_node(16,19,20).
right_node(16,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(16,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(16,21,0).
% node 22: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 23, right -> 24
node(16,22,18,0).
left_node(16,22,23).
right_node(16,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(16,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(16,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(16,25,0).
% node 26: EGFR <= 0.5  (F7, bin <= 0)  left -> 27, right -> 28
node(16,26,7,0).
left_node(16,26,27).
right_node(16,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(16,27,1).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 30
node(16,28,15,0).
left_node(16,28,29).
right_node(16,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(16,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(16,30,0).

% Tree 17
tree(17).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 14
node(17,0,3,0).
left_node(17,0,1).
right_node(17,0,14).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 11
node(17,1,20,0).
left_node(17,1,2).
right_node(17,1,11).
% node 2: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 3, right -> 10
node(17,2,18,0).
left_node(17,2,3).
right_node(17,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(17,3,14,0).
left_node(17,3,4).
right_node(17,3,7).
% node 4: NF1 <= 0.5  (F11, bin <= 0)  left -> 5, right -> 6
node(17,4,11,0).
left_node(17,4,5).
right_node(17,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(17,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(17,6,1).
% node 7: BCOR <= 0.5  (F16, bin <= 0)  left -> 8, right -> 9
node(17,7,16,0).
left_node(17,7,8).
right_node(17,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(17,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(17,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(17,10,1).
% node 11: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 12, right -> 13
node(17,11,19,0).
left_node(17,11,12).
right_node(17,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(17,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(17,13,1).
% node 14: ATRX <= 0.5  (F5, bin <= 0)  left -> 15, right -> 22
node(17,14,5,0).
left_node(17,14,15).
right_node(17,14,22).
% node 15: FAT4 <= 0.5  (F21, bin <= 0)  left -> 16, right -> 17
node(17,15,21,0).
left_node(17,15,16).
right_node(17,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(17,16,0).
% node 17: TP53 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(17,17,4,0).
left_node(17,17,18).
right_node(17,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(17,18,0).
% node 19: Gender <= 0.5  (F0, bin <= 0)  left -> 20, right -> 21
node(17,19,0,0).
left_node(17,19,20).
right_node(17,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(17,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(17,21,1).
% node 22: PTEN <= 0.5  (F6, bin <= 0)  left -> 23, right -> 28
node(17,22,6,0).
left_node(17,22,23).
right_node(17,22,28).
% node 23: Race <= 1.5  (F2, bin <= 1)  left -> 24, right -> 27
node(17,23,2,1).
left_node(17,23,24).
right_node(17,23,27).
% node 24: FAT4 <= 0.5  (F21, bin <= 0)  left -> 25, right -> 26
node(17,24,21,0).
left_node(17,24,25).
right_node(17,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(17,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(17,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(17,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(17,28,1).

% Tree 18
tree(18).
% node 0: Age_at_diagnosis <= 52.55000114440918  (F1, bin <= 107)  left -> 1, right -> 22
node(18,0,1,107).
left_node(18,0,1).
right_node(18,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(18,1,3,0).
left_node(18,1,2).
right_node(18,1,13).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 10
node(18,2,19,0).
left_node(18,2,3).
right_node(18,2,10).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(18,3,7,0).
left_node(18,3,4).
right_node(18,3,7).
% node 4: Race <= 2.0  (F2, bin <= 2)  left -> 5, right -> 6
node(18,4,2,2).
left_node(18,4,5).
right_node(18,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(18,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(18,6,0).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(18,7,0,0).
left_node(18,7,8).
right_node(18,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(18,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(18,9,1).
% node 10: BCOR <= 0.5  (F16, bin <= 0)  left -> 11, right -> 12
node(18,10,16,0).
left_node(18,10,11).
right_node(18,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(18,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(18,12,0).
% node 13: TP53 <= 0.5  (F4, bin <= 0)  left -> 14, right -> 15
node(18,13,4,0).
left_node(18,13,14).
right_node(18,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(18,14,0).
% node 15: Age_at_diagnosis <= 43.64499855041504  (F1, bin <= 52)  left -> 16, right -> 19
node(18,15,1,52).
left_node(18,15,16).
right_node(18,15,19).
% node 16: Race <= 0.5  (F2, bin <= 0)  left -> 17, right -> 18
node(18,16,2,0).
left_node(18,16,17).
right_node(18,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(18,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(18,18,1).
% node 19: Gender <= 0.5  (F0, bin <= 0)  left -> 20, right -> 21
node(18,19,0,0).
left_node(18,19,20).
right_node(18,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(18,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(18,21,0).
% node 22: PTEN <= 0.5  (F6, bin <= 0)  left -> 23, right -> 30
node(18,22,6,0).
left_node(18,22,23).
right_node(18,22,30).
% node 23: IDH1 <= 0.5  (F3, bin <= 0)  left -> 24, right -> 29
node(18,23,3,0).
left_node(18,23,24).
right_node(18,23,29).
% node 24: ATRX <= 0.5  (F5, bin <= 0)  left -> 25, right -> 28
node(18,24,5,0).
left_node(18,24,25).
right_node(18,24,28).
% node 25: BCOR <= 0.5  (F16, bin <= 0)  left -> 26, right -> 27
node(18,25,16,0).
left_node(18,25,26).
right_node(18,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(18,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(18,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(18,28,0).
% node 29 (leaf): class 0 (0)
leaf_class(18,29,0).
% node 30: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 31, right -> 36
node(18,30,17,0).
left_node(18,30,31).
right_node(18,30,36).
% node 31: Gender <= 0.5  (F0, bin <= 0)  left -> 32, right -> 35
node(18,31,0,0).
left_node(18,31,32).
right_node(18,31,35).
% node 32: NF1 <= 0.5  (F11, bin <= 0)  left -> 33, right -> 34
node(18,32,11,0).
left_node(18,32,33).
right_node(18,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(18,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(18,34,1).
% node 35 (leaf): class 1 (1)
leaf_class(18,35,1).
% node 36 (leaf): class 1 (1)
leaf_class(18,36,1).

% Tree 19
tree(19).
% node 0: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 1, right -> 22
node(19,0,18,0).
left_node(19,0,1).
right_node(19,0,22).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 9
node(19,1,4,0).
left_node(19,1,2).
right_node(19,1,9).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(19,2,3,0).
left_node(19,2,3).
right_node(19,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(19,3,8,0).
left_node(19,3,4).
right_node(19,3,7).
% node 4: MUC16 <= 0.5  (F9, bin <= 0)  left -> 5, right -> 6
node(19,4,9,0).
left_node(19,4,5).
right_node(19,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(19,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(19,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(19,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(19,8,0).
% node 9: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 10, right -> 17
node(19,9,10,0).
left_node(19,9,10).
right_node(19,9,17).
% node 10: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 11, right -> 14
node(19,10,17,0).
left_node(19,10,11).
right_node(19,10,14).
% node 11: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 12, right -> 13
node(19,11,19,0).
left_node(19,11,12).
right_node(19,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(19,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(19,13,1).
% node 14: IDH1 <= 0.5  (F3, bin <= 0)  left -> 15, right -> 16
node(19,14,3,0).
left_node(19,14,15).
right_node(19,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(19,15,1).
% node 16 (leaf): class 0 (0)
leaf_class(19,16,0).
% node 17: PTEN <= 0.5  (F6, bin <= 0)  left -> 18, right -> 21
node(19,17,6,0).
left_node(19,17,18).
right_node(19,17,21).
% node 18: IDH1 <= 0.5  (F3, bin <= 0)  left -> 19, right -> 20
node(19,18,3,0).
left_node(19,18,19).
right_node(19,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(19,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(19,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(19,21,1).
% node 22: EGFR <= 0.5  (F7, bin <= 0)  left -> 23, right -> 26
node(19,22,7,0).
left_node(19,22,23).
right_node(19,22,26).
% node 23: RB1 <= 0.5  (F14, bin <= 0)  left -> 24, right -> 25
node(19,23,14,0).
left_node(19,23,24).
right_node(19,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(19,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(19,25,1).
% node 26: Gender <= 0.5  (F0, bin <= 0)  left -> 27, right -> 28
node(19,26,0,0).
left_node(19,26,27).
right_node(19,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(19,27,1).
% node 28: Age_at_diagnosis <= 29.255001068115234  (F1, bin <= 14)  left -> 29, right -> 30
node(19,28,1,14).
left_node(19,28,29).
right_node(19,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(19,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(19,30,0).

% Tree 20
tree(20).
% node 0: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 1, right -> 24
node(20,0,22,0).
left_node(20,0,1).
right_node(20,0,24).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 11
node(20,1,5,0).
left_node(20,1,2).
right_node(20,1,11).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 10
node(20,2,15,0).
left_node(20,2,3).
right_node(20,2,10).
% node 3: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 4, right -> 7
node(20,3,17,0).
left_node(20,3,4).
right_node(20,3,7).
% node 4: Age_at_diagnosis <= 52.67499923706055  (F1, bin <= 112)  left -> 5, right -> 6
node(20,4,1,112).
left_node(20,4,5).
right_node(20,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(20,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(20,6,1).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(20,7,3,0).
left_node(20,7,8).
right_node(20,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(20,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(20,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(20,10,0).
% node 11: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 12, right -> 19
node(20,11,10,0).
left_node(20,11,12).
right_node(20,11,19).
% node 12: PTEN <= 0.5  (F6, bin <= 0)  left -> 13, right -> 16
node(20,12,6,0).
left_node(20,12,13).
right_node(20,12,16).
% node 13: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 14, right -> 15
node(20,13,18,0).
left_node(20,13,14).
right_node(20,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(20,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(20,15,0).
% node 16: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 17, right -> 18
node(20,16,19,0).
left_node(20,16,17).
right_node(20,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(20,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(20,18,1).
% node 19: Age_at_diagnosis <= 48.81500053405762  (F1, bin <= 88)  left -> 20, right -> 23
node(20,19,1,88).
left_node(20,19,20).
right_node(20,19,23).
% node 20: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 21, right -> 22
node(20,20,18,0).
left_node(20,20,21).
right_node(20,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(20,21,1).
% node 22 (leaf): class 1 (1)
leaf_class(20,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(20,23,0).
% node 24: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 25, right -> 32
node(20,24,10,0).
left_node(20,24,25).
right_node(20,24,32).
% node 25: Age_at_diagnosis <= 67.41500091552734  (F1, bin <= 149)  left -> 26, right -> 31
node(20,25,1,149).
left_node(20,25,26).
right_node(20,25,31).
% node 26: Age_at_diagnosis <= 66.93500137329102  (F1, bin <= 146)  left -> 27, right -> 30
node(20,26,1,146).
left_node(20,26,27).
right_node(20,26,30).
% node 27: ATRX <= 0.5  (F5, bin <= 0)  left -> 28, right -> 29
node(20,27,5,0).
left_node(20,27,28).
right_node(20,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(20,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(20,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(20,30,0).
% node 31 (leaf): class 1 (1)
leaf_class(20,31,1).
% node 32: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 33, right -> 34
node(20,32,12,0).
left_node(20,32,33).
right_node(20,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(20,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(20,34,1).

% Tree 21
tree(21).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 20
node(21,0,14,0).
left_node(21,0,1).
right_node(21,0,20).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 13
node(21,1,7,0).
left_node(21,1,2).
right_node(21,1,13).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 10
node(21,2,19,0).
left_node(21,2,3).
right_node(21,2,10).
% node 3: NF1 <= 0.5  (F11, bin <= 0)  left -> 4, right -> 7
node(21,3,11,0).
left_node(21,3,4).
right_node(21,3,7).
% node 4: Age_at_diagnosis <= 52.67999839782715  (F1, bin <= 113)  left -> 5, right -> 6
node(21,4,1,113).
left_node(21,4,5).
right_node(21,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(21,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(21,6,1).
% node 7: Race <= 1.5  (F2, bin <= 1)  left -> 8, right -> 9
node(21,7,2,1).
left_node(21,7,8).
right_node(21,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(21,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(21,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 12
node(21,10,8,0).
left_node(21,10,11).
right_node(21,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(21,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(21,12,0).
% node 13: Age_at_diagnosis <= 66.54999923706055  (F1, bin <= 145)  left -> 14, right -> 19
node(21,13,1,145).
left_node(21,13,14).
right_node(21,13,19).
% node 14: Age_at_diagnosis <= 44.60000038146973  (F1, bin <= 57)  left -> 15, right -> 16
node(21,14,1,57).
left_node(21,14,15).
right_node(21,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(21,15,1).
% node 16: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 17, right -> 18
node(21,16,17,0).
left_node(21,16,17).
right_node(21,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(21,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(21,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(21,19,1).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 28
node(21,20,3,0).
left_node(21,20,21).
right_node(21,20,28).
% node 21: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 22, right -> 27
node(21,21,17,0).
left_node(21,21,22).
right_node(21,21,27).
% node 22: TP53 <= 0.5  (F4, bin <= 0)  left -> 23, right -> 26
node(21,22,4,0).
left_node(21,22,23).
right_node(21,22,26).
% node 23: NF1 <= 0.5  (F11, bin <= 0)  left -> 24, right -> 25
node(21,23,11,0).
left_node(21,23,24).
right_node(21,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(21,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(21,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(21,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(21,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(21,28,0).

% Tree 22
tree(22).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 12
node(22,0,5,0).
left_node(22,0,1).
right_node(22,0,12).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 11
node(22,1,8,0).
left_node(22,1,2).
right_node(22,1,11).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(22,2,3,0).
left_node(22,2,3).
right_node(22,2,10).
% node 3: FAT4 <= 0.5  (F21, bin <= 0)  left -> 4, right -> 7
node(22,3,21,0).
left_node(22,3,4).
right_node(22,3,7).
% node 4: Age_at_diagnosis <= 63.23000144958496  (F1, bin <= 134)  left -> 5, right -> 6
node(22,4,1,134).
left_node(22,4,5).
right_node(22,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(22,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(22,6,1).
% node 7: Race <= 0.5  (F2, bin <= 0)  left -> 8, right -> 9
node(22,7,2,0).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(22,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(22,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(22,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(22,11,0).
% node 12: Age_at_diagnosis <= 45.154998779296875  (F1, bin <= 58)  left -> 13, right -> 24
node(22,12,1,58).
left_node(22,12,13).
right_node(22,12,24).
% node 13: Race <= 0.5  (F2, bin <= 0)  left -> 14, right -> 21
node(22,13,2,0).
left_node(22,13,14).
right_node(22,13,21).
% node 14: CIC <= 0.5  (F8, bin <= 0)  left -> 15, right -> 18
node(22,14,8,0).
left_node(22,14,15).
right_node(22,14,18).
% node 15: IDH1 <= 0.5  (F3, bin <= 0)  left -> 16, right -> 17
node(22,15,3,0).
left_node(22,15,16).
right_node(22,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(22,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(22,17,0).
% node 18: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 19, right -> 20
node(22,18,13,0).
left_node(22,18,19).
right_node(22,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(22,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(22,20,0).
% node 21: Age_at_diagnosis <= 26.405000686645508  (F1, bin <= 8)  left -> 22, right -> 23
node(22,21,1,8).
left_node(22,21,22).
right_node(22,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(22,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(22,23,0).
% node 24: IDH2 <= 0.5  (F20, bin <= 0)  left -> 25, right -> 32
node(22,24,20,0).
left_node(22,24,25).
right_node(22,24,32).
% node 25: TP53 <= 0.5  (F4, bin <= 0)  left -> 26, right -> 29
node(22,25,4,0).
left_node(22,25,26).
right_node(22,25,29).
% node 26: IDH1 <= 0.5  (F3, bin <= 0)  left -> 27, right -> 28
node(22,26,3,0).
left_node(22,26,27).
right_node(22,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(22,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(22,28,0).
% node 29: Age_at_diagnosis <= 46.47999954223633  (F1, bin <= 72)  left -> 30, right -> 31
node(22,29,1,72).
left_node(22,29,30).
right_node(22,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(22,30,1).
% node 31 (leaf): class 0 (0)
leaf_class(22,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(22,32,1).

% Tree 23
tree(23).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 24
node(23,0,8,0).
left_node(23,0,1).
right_node(23,0,24).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 15
node(23,1,5,0).
left_node(23,1,2).
right_node(23,1,15).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 8
node(23,2,7,0).
left_node(23,2,3).
right_node(23,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(23,3,20,0).
left_node(23,3,4).
right_node(23,3,7).
% node 4: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 5, right -> 6
node(23,4,13,0).
left_node(23,4,5).
right_node(23,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(23,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(23,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(23,7,0).
% node 8: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 9, right -> 12
node(23,8,18,0).
left_node(23,8,9).
right_node(23,8,12).
% node 9: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 10, right -> 11
node(23,9,17,0).
left_node(23,9,10).
right_node(23,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(23,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(23,11,1).
% node 12: Age_at_diagnosis <= 52.67499923706055  (F1, bin <= 112)  left -> 13, right -> 14
node(23,12,1,112).
left_node(23,12,13).
right_node(23,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(23,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(23,14,1).
% node 15: RB1 <= 0.5  (F14, bin <= 0)  left -> 16, right -> 23
node(23,15,14,0).
left_node(23,15,16).
right_node(23,15,23).
% node 16: IDH1 <= 0.5  (F3, bin <= 0)  left -> 17, right -> 20
node(23,16,3,0).
left_node(23,16,17).
right_node(23,16,20).
% node 17: Age_at_diagnosis <= 40.795000076293945  (F1, bin <= 43)  left -> 18, right -> 19
node(23,17,1,43).
left_node(23,17,18).
right_node(23,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(23,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(23,19,1).
% node 20: EGFR <= 0.5  (F7, bin <= 0)  left -> 21, right -> 22
node(23,20,7,0).
left_node(23,20,21).
right_node(23,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(23,21,0).
% node 22 (leaf): class 1 (1)
leaf_class(23,22,1).
% node 23 (leaf): class 1 (1)
leaf_class(23,23,1).
% node 24: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 25, right -> 30
node(23,24,10,0).
left_node(23,24,25).
right_node(23,24,30).
% node 25: ATRX <= 0.5  (F5, bin <= 0)  left -> 26, right -> 27
node(23,25,5,0).
left_node(23,25,26).
right_node(23,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(23,26,0).
% node 27: Age_at_diagnosis <= 45.5049991607666  (F1, bin <= 65)  left -> 28, right -> 29
node(23,27,1,65).
left_node(23,27,28).
right_node(23,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(23,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(23,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(23,30,0).

% Tree 24
tree(24).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 20
node(24,0,19,0).
left_node(24,0,1).
right_node(24,0,20).
% node 1: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 2, right -> 17
node(24,1,18,0).
left_node(24,1,2).
right_node(24,1,17).
% node 2: RB1 <= 0.5  (F14, bin <= 0)  left -> 3, right -> 10
node(24,2,14,0).
left_node(24,2,3).
right_node(24,2,10).
% node 3: Age_at_diagnosis <= 52.59000015258789  (F1, bin <= 108)  left -> 4, right -> 7
node(24,3,1,108).
left_node(24,3,4).
right_node(24,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(24,4,7,0).
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
% node 10: PTEN <= 0.5  (F6, bin <= 0)  left -> 11, right -> 14
node(24,10,6,0).
left_node(24,10,11).
right_node(24,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(24,11,0,0).
left_node(24,11,12).
right_node(24,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(24,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(24,13,1).
% node 14: Age_at_diagnosis <= 40.06999969482422  (F1, bin <= 41)  left -> 15, right -> 16
node(24,14,1,41).
left_node(24,14,15).
right_node(24,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(24,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(24,16,1).
% node 17: NF1 <= 0.5  (F11, bin <= 0)  left -> 18, right -> 19
node(24,17,11,0).
left_node(24,17,18).
right_node(24,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(24,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(24,19,1).
% node 20: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 21, right -> 32
node(24,20,10,0).
left_node(24,20,21).
right_node(24,20,32).
% node 21: Gender <= 0.5  (F0, bin <= 0)  left -> 22, right -> 27
node(24,21,0,0).
left_node(24,21,22).
right_node(24,21,27).
% node 22: IDH2 <= 0.5  (F20, bin <= 0)  left -> 23, right -> 26
node(24,22,20,0).
left_node(24,22,23).
right_node(24,22,26).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 25
node(24,23,6,0).
left_node(24,23,24).
right_node(24,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(24,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(24,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(24,26,1).
% node 27: ATRX <= 0.5  (F5, bin <= 0)  left -> 28, right -> 31
node(24,27,5,0).
left_node(24,27,28).
right_node(24,27,31).
% node 28: IDH1 <= 0.5  (F3, bin <= 0)  left -> 29, right -> 30
node(24,28,3,0).
left_node(24,28,29).
right_node(24,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(24,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(24,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(24,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(24,32,1).

% Tree 25
tree(25).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 16
node(25,0,3,0).
left_node(25,0,1).
right_node(25,0,16).
% node 1: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 2, right -> 13
node(25,1,17,0).
left_node(25,1,2).
right_node(25,1,13).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 8
node(25,2,6,0).
left_node(25,2,3).
right_node(25,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(25,3,20,0).
left_node(25,3,4).
right_node(25,3,7).
% node 4: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 5, right -> 6
node(25,4,18,0).
left_node(25,4,5).
right_node(25,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(25,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(25,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(25,7,0).
% node 8: ATRX <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(25,8,5,0).
left_node(25,8,9).
right_node(25,8,12).
% node 9: Age_at_diagnosis <= 52.6299991607666  (F1, bin <= 111)  left -> 10, right -> 11
node(25,9,1,111).
left_node(25,9,10).
right_node(25,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(25,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(25,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(25,12,1).
% node 13: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 14, right -> 15
node(25,13,22,0).
left_node(25,13,14).
right_node(25,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(25,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(25,15,0).
% node 16: EGFR <= 0.5  (F7, bin <= 0)  left -> 17, right -> 30
node(25,16,7,0).
left_node(25,16,17).
right_node(25,16,30).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 25
node(25,17,2,0).
left_node(25,17,18).
right_node(25,17,25).
% node 18: BCOR <= 0.5  (F16, bin <= 0)  left -> 19, right -> 22
node(25,18,16,0).
left_node(25,18,19).
right_node(25,18,22).
% node 19: TP53 <= 0.5  (F4, bin <= 0)  left -> 20, right -> 21
node(25,19,4,0).
left_node(25,19,20).
right_node(25,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(25,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(25,21,0).
% node 22: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 23, right -> 24
node(25,22,13,0).
left_node(25,22,23).
right_node(25,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(25,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(25,24,0).
% node 25: ATRX <= 0.5  (F5, bin <= 0)  left -> 26, right -> 27
node(25,25,5,0).
left_node(25,25,26).
right_node(25,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(25,26,0).
% node 27: Age_at_diagnosis <= 30.975000381469727  (F1, bin <= 16)  left -> 28, right -> 29
node(25,27,1,16).
left_node(25,27,28).
right_node(25,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(25,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(25,29,0).
% node 30: Gender <= 0.5  (F0, bin <= 0)  left -> 31, right -> 32
node(25,30,0,0).
left_node(25,30,31).
right_node(25,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(25,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(25,32,0).

% Tree 26
tree(26).
% node 0: EGFR <= 0.5  (F7, bin <= 0)  left -> 1, right -> 24
node(26,0,7,0).
left_node(26,0,1).
right_node(26,0,24).
% node 1: Age_at_diagnosis <= 45.28999900817871  (F1, bin <= 61)  left -> 2, right -> 15
node(26,1,1,61).
left_node(26,1,2).
right_node(26,1,15).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 10
node(26,2,6,0).
left_node(26,2,3).
right_node(26,2,10).
% node 3: Gender <= 0.5  (F0, bin <= 0)  left -> 4, right -> 7
node(26,3,0,0).
left_node(26,3,4).
right_node(26,3,7).
% node 4: RB1 <= 0.5  (F14, bin <= 0)  left -> 5, right -> 6
node(26,4,14,0).
left_node(26,4,5).
right_node(26,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(26,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(26,6,1).
% node 7: CIC <= 0.5  (F8, bin <= 0)  left -> 8, right -> 9
node(26,7,8,0).
left_node(26,7,8).
right_node(26,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(26,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(26,9,0).
% node 10: Race <= 0.5  (F2, bin <= 0)  left -> 11, right -> 14
node(26,10,2,0).
left_node(26,10,11).
right_node(26,10,14).
% node 11: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 12, right -> 13
node(26,11,10,0).
left_node(26,11,12).
right_node(26,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(26,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(26,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(26,14,1).
% node 15: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 16, right -> 23
node(26,15,19,0).
left_node(26,15,16).
right_node(26,15,23).
% node 16: IDH1 <= 0.5  (F3, bin <= 0)  left -> 17, right -> 20
node(26,16,3,0).
left_node(26,16,17).
right_node(26,16,20).
% node 17: MUC16 <= 0.5  (F9, bin <= 0)  left -> 18, right -> 19
node(26,17,9,0).
left_node(26,17,18).
right_node(26,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(26,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(26,19,1).
% node 20: Age_at_diagnosis <= 45.720001220703125  (F1, bin <= 68)  left -> 21, right -> 22
node(26,20,1,68).
left_node(26,20,21).
right_node(26,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(26,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(26,22,0).
% node 23 (leaf): class 1 (1)
leaf_class(26,23,1).
% node 24: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 25, right -> 32
node(26,24,18,0).
left_node(26,24,25).
right_node(26,24,32).
% node 25: Age_at_diagnosis <= 69.61499786376953  (F1, bin <= 153)  left -> 26, right -> 31
node(26,25,1,153).
left_node(26,25,26).
right_node(26,25,31).
% node 26: RB1 <= 0.5  (F14, bin <= 0)  left -> 27, right -> 30
node(26,26,14,0).
left_node(26,26,27).
right_node(26,26,30).
% node 27: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 28, right -> 29
node(26,27,12,0).
left_node(26,27,28).
right_node(26,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(26,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(26,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(26,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(26,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(26,32,0).

% Tree 27
tree(27).
% node 0: Age_at_diagnosis <= 48.94499969482422  (F1, bin <= 92)  left -> 1, right -> 24
node(27,0,1,92).
left_node(27,0,1).
right_node(27,0,24).
% node 1: Gender <= 0.5  (F0, bin <= 0)  left -> 2, right -> 15
node(27,1,0,0).
left_node(27,1,2).
right_node(27,1,15).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(27,2,3,0).
left_node(27,2,3).
right_node(27,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(27,3,20,0).
left_node(27,3,4).
right_node(27,3,7).
% node 4: Age_at_diagnosis <= 46.15999984741211  (F1, bin <= 70)  left -> 5, right -> 6
node(27,4,1,70).
left_node(27,4,5).
right_node(27,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(27,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(27,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(27,7,0).
% node 8: ATRX <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(27,8,5,0).
left_node(27,8,9).
right_node(27,8,12).
% node 9: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 10, right -> 11
node(27,9,15,0).
left_node(27,9,10).
right_node(27,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(27,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(27,11,0).
% node 12: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 13, right -> 14
node(27,12,22,0).
left_node(27,12,13).
right_node(27,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(27,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(27,14,1).
% node 15: CIC <= 0.5  (F8, bin <= 0)  left -> 16, right -> 23
node(27,15,8,0).
left_node(27,15,16).
right_node(27,15,23).
% node 16: Age_at_diagnosis <= 45.47999954223633  (F1, bin <= 64)  left -> 17, right -> 20
node(27,16,1,64).
left_node(27,16,17).
right_node(27,16,20).
% node 17: RB1 <= 0.5  (F14, bin <= 0)  left -> 18, right -> 19
node(27,17,14,0).
left_node(27,17,18).
right_node(27,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(27,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(27,19,1).
% node 20: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 21, right -> 22
node(27,20,13,0).
left_node(27,20,21).
right_node(27,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(27,21,1).
% node 22 (leaf): class 1 (1)
leaf_class(27,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(27,23,0).
% node 24: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 25, right -> 36
node(27,24,13,0).
left_node(27,24,25).
right_node(27,24,36).
% node 25: PTEN <= 0.5  (F6, bin <= 0)  left -> 26, right -> 31
node(27,25,6,0).
left_node(27,25,26).
right_node(27,25,31).
% node 26: Age_at_diagnosis <= 74.70500183105469  (F1, bin <= 168)  left -> 27, right -> 30
node(27,26,1,168).
left_node(27,26,27).
right_node(27,26,30).
% node 27: NF1 <= 0.5  (F11, bin <= 0)  left -> 28, right -> 29
node(27,27,11,0).
left_node(27,27,28).
right_node(27,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(27,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(27,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(27,30,1).
% node 31: CIC <= 0.5  (F8, bin <= 0)  left -> 32, right -> 35
node(27,31,8,0).
left_node(27,31,32).
right_node(27,31,35).
% node 32: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 33, right -> 34
node(27,32,10,0).
left_node(27,32,33).
right_node(27,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(27,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(27,34,1).
% node 35 (leaf): class 0 (0)
leaf_class(27,35,0).
% node 36 (leaf): class 0 (0)
leaf_class(27,36,0).

% Tree 28
tree(28).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 24
node(28,0,6,0).
left_node(28,0,1).
right_node(28,0,24).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(28,1,3,0).
left_node(28,1,2).
right_node(28,1,13).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 10
node(28,2,20,0).
left_node(28,2,3).
right_node(28,2,10).
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
% node 7: Age_at_diagnosis <= 50.03499984741211  (F1, bin <= 98)  left -> 8, right -> 9
node(28,7,1,98).
left_node(28,7,8).
right_node(28,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(28,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(28,9,1).
% node 10: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 11, right -> 12
node(28,10,17,0).
left_node(28,10,11).
right_node(28,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(28,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(28,12,1).
% node 13: BCOR <= 0.5  (F16, bin <= 0)  left -> 14, right -> 19
node(28,13,16,0).
left_node(28,13,14).
right_node(28,13,19).
% node 14: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 15, right -> 18
node(28,14,18,0).
left_node(28,14,15).
right_node(28,14,18).
% node 15: ATRX <= 0.5  (F5, bin <= 0)  left -> 16, right -> 17
node(28,15,5,0).
left_node(28,15,16).
right_node(28,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(28,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(28,17,0).
% node 18 (leaf): class 0 (0)
leaf_class(28,18,0).
% node 19: CIC <= 0.5  (F8, bin <= 0)  left -> 20, right -> 23
node(28,19,8,0).
left_node(28,19,20).
right_node(28,19,23).
% node 20: ATRX <= 0.5  (F5, bin <= 0)  left -> 21, right -> 22
node(28,20,5,0).
left_node(28,20,21).
right_node(28,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(28,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(28,22,0).
% node 23 (leaf): class 0 (0)
leaf_class(28,23,0).
% node 24: MUC16 <= 0.5  (F9, bin <= 0)  left -> 25, right -> 36
node(28,24,9,0).
left_node(28,24,25).
right_node(28,24,36).
% node 25: EGFR <= 0.5  (F7, bin <= 0)  left -> 26, right -> 31
node(28,25,7,0).
left_node(28,25,26).
right_node(28,25,31).
% node 26: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 27, right -> 30
node(28,26,10,0).
left_node(28,26,27).
right_node(28,26,30).
% node 27: IDH1 <= 0.5  (F3, bin <= 0)  left -> 28, right -> 29
node(28,27,3,0).
left_node(28,27,28).
right_node(28,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(28,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(28,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(28,30,0).
% node 31: Race <= 0.5  (F2, bin <= 0)  left -> 32, right -> 35
node(28,31,2,0).
left_node(28,31,32).
right_node(28,31,35).
% node 32: Age_at_diagnosis <= 63.849998474121094  (F1, bin <= 137)  left -> 33, right -> 34
node(28,32,1,137).
left_node(28,32,33).
right_node(28,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(28,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(28,34,1).
% node 35 (leaf): class 1 (1)
leaf_class(28,35,1).
% node 36: EGFR <= 0.5  (F7, bin <= 0)  left -> 37, right -> 38
node(28,36,7,0).
left_node(28,36,37).
right_node(28,36,38).
% node 37 (leaf): class 1 (1)
leaf_class(28,37,1).
% node 38: TP53 <= 0.5  (F4, bin <= 0)  left -> 39, right -> 42
node(28,38,4,0).
left_node(28,38,39).
right_node(28,38,42).
% node 39: NF1 <= 0.5  (F11, bin <= 0)  left -> 40, right -> 41
node(28,39,11,0).
left_node(28,39,40).
right_node(28,39,41).
% node 40 (leaf): class 1 (1)
leaf_class(28,40,1).
% node 41 (leaf): class 0 (0)
leaf_class(28,41,0).
% node 42 (leaf): class 1 (1)
leaf_class(28,42,1).

% Tree 29
tree(29).
% node 0: IDH2 <= 0.5  (F20, bin <= 0)  left -> 1, right -> 26
node(29,0,20,0).
left_node(29,0,1).
right_node(29,0,26).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 15
node(29,1,3,0).
left_node(29,1,2).
right_node(29,1,15).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(29,2,9,0).
left_node(29,2,3).
right_node(29,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(29,3,14,0).
left_node(29,3,4).
right_node(29,3,7).
% node 4: Age_at_diagnosis <= 63.2450008392334  (F1, bin <= 135)  left -> 5, right -> 6
node(29,4,1,135).
left_node(29,4,5).
right_node(29,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(29,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(29,6,1).
% node 7: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 8, right -> 9
node(29,7,19,0).
left_node(29,7,8).
right_node(29,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(29,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(29,9,1).
% node 10: EGFR <= 0.5  (F7, bin <= 0)  left -> 11, right -> 14
node(29,10,7,0).
left_node(29,10,11).
right_node(29,10,14).
% node 11: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 12, right -> 13
node(29,11,12,0).
left_node(29,11,12).
right_node(29,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(29,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(29,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(29,14,1).
% node 15: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 16, right -> 21
node(29,15,12,0).
left_node(29,15,16).
right_node(29,15,21).
% node 16: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 17, right -> 20
node(29,16,13,0).
left_node(29,16,17).
right_node(29,16,20).
% node 17: ATRX <= 0.5  (F5, bin <= 0)  left -> 18, right -> 19
node(29,17,5,0).
left_node(29,17,18).
right_node(29,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(29,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(29,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(29,20,0).
% node 21: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 22, right -> 25
node(29,21,15,0).
left_node(29,21,22).
right_node(29,21,25).
% node 22: CIC <= 0.5  (F8, bin <= 0)  left -> 23, right -> 24
node(29,22,8,0).
left_node(29,22,23).
right_node(29,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(29,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(29,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(29,25,0).
% node 26: EGFR <= 0.5  (F7, bin <= 0)  left -> 27, right -> 30
node(29,26,7,0).
left_node(29,26,27).
right_node(29,26,30).
% node 27: PTEN <= 0.5  (F6, bin <= 0)  left -> 28, right -> 29
node(29,27,6,0).
left_node(29,27,28).
right_node(29,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(29,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(29,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(29,30,1).

% Tree 30
tree(30).
% node 0: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 1, right -> 18
node(30,0,13,0).
left_node(30,0,1).
right_node(30,0,18).
% node 1: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 2, right -> 17
node(30,1,15,0).
left_node(30,1,2).
right_node(30,1,17).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(30,2,9,0).
left_node(30,2,3).
right_node(30,2,10).
% node 3: Age_at_diagnosis <= 48.94499969482422  (F1, bin <= 92)  left -> 4, right -> 7
node(30,3,1,92).
left_node(30,3,4).
right_node(30,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(30,4,3,0).
left_node(30,4,5).
right_node(30,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(30,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(30,6,0).
% node 7: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 8, right -> 9
node(30,7,18,0).
left_node(30,7,8).
right_node(30,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(30,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(30,9,0).
% node 10: ATRX <= 0.5  (F5, bin <= 0)  left -> 11, right -> 14
node(30,10,5,0).
left_node(30,10,11).
right_node(30,10,14).
% node 11: EGFR <= 0.5  (F7, bin <= 0)  left -> 12, right -> 13
node(30,11,7,0).
left_node(30,11,12).
right_node(30,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(30,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(30,13,1).
% node 14: Age_at_diagnosis <= 41.84499931335449  (F1, bin <= 45)  left -> 15, right -> 16
node(30,14,1,45).
left_node(30,14,15).
right_node(30,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(30,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(30,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(30,17,0).
% node 18: Age_at_diagnosis <= 28.635000228881836  (F1, bin <= 12)  left -> 19, right -> 20
node(30,18,1,12).
left_node(30,18,19).
right_node(30,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(30,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(30,20,0).

% Tree 31
tree(31).
% node 0: Age_at_diagnosis <= 52.72999954223633  (F1, bin <= 114)  left -> 1, right -> 18
node(31,0,1,114).
left_node(31,0,1).
right_node(31,0,18).
% node 1: Age_at_diagnosis <= 43.81500053405762  (F1, bin <= 53)  left -> 2, right -> 11
node(31,1,1,53).
left_node(31,1,2).
right_node(31,1,11).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(31,2,7,0).
left_node(31,2,3).
right_node(31,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(31,3,3,0).
left_node(31,3,4).
right_node(31,3,7).
% node 4: NF1 <= 0.5  (F11, bin <= 0)  left -> 5, right -> 6
node(31,4,11,0).
left_node(31,4,5).
right_node(31,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(31,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(31,6,0).
% node 7: Race <= 0.5  (F2, bin <= 0)  left -> 8, right -> 9
node(31,7,2,0).
left_node(31,7,8).
right_node(31,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(31,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(31,9,0).
% node 10 (leaf): class 1 (1)
leaf_class(31,10,1).
% node 11: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 12, right -> 17
node(31,11,18,0).
left_node(31,11,12).
right_node(31,11,17).
% node 12: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 13, right -> 16
node(31,12,15,0).
left_node(31,12,13).
right_node(31,12,16).
% node 13: Age_at_diagnosis <= 44.46999931335449  (F1, bin <= 56)  left -> 14, right -> 15
node(31,13,1,56).
left_node(31,13,14).
right_node(31,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(31,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(31,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(31,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(31,17,0).
% node 18: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 19, right -> 30
node(31,18,13,0).
left_node(31,18,19).
right_node(31,18,30).
% node 19: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 20, right -> 25
node(31,19,22,0).
left_node(31,19,20).
right_node(31,19,25).
% node 20: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 21, right -> 24
node(31,20,19,0).
left_node(31,20,21).
right_node(31,20,24).
% node 21: Age_at_diagnosis <= 74.70500183105469  (F1, bin <= 168)  left -> 22, right -> 23
node(31,21,1,168).
left_node(31,21,22).
right_node(31,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(31,22,1).
% node 23 (leaf): class 1 (1)
leaf_class(31,23,1).
% node 24 (leaf): class 1 (1)
leaf_class(31,24,1).
% node 25: Age_at_diagnosis <= 62.005001068115234  (F1, bin <= 131)  left -> 26, right -> 29
node(31,25,1,131).
left_node(31,25,26).
right_node(31,25,29).
% node 26: Gender <= 0.5  (F0, bin <= 0)  left -> 27, right -> 28
node(31,26,0,0).
left_node(31,26,27).
right_node(31,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(31,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(31,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(31,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(31,30,0).

% Tree 32
tree(32).
% node 0: EGFR <= 0.5  (F7, bin <= 0)  left -> 1, right -> 22
node(32,0,7,0).
left_node(32,0,1).
right_node(32,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(32,1,3,0).
left_node(32,1,2).
right_node(32,1,13).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(32,2,20,0).
left_node(32,2,3).
right_node(32,2,8).
% node 3: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 4, right -> 7
node(32,3,19,0).
left_node(32,3,4).
right_node(32,3,7).
% node 4: Age_at_diagnosis <= 48.43000030517578  (F1, bin <= 84)  left -> 5, right -> 6
node(32,4,1,84).
left_node(32,4,5).
right_node(32,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(32,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(32,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(32,7,1).
% node 8: Race <= 0.5  (F2, bin <= 0)  left -> 9, right -> 12
node(32,8,2,0).
left_node(32,8,9).
right_node(32,8,12).
% node 9: CIC <= 0.5  (F8, bin <= 0)  left -> 10, right -> 11
node(32,9,8,0).
left_node(32,9,10).
right_node(32,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(32,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(32,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(32,12,0).
% node 13: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 14, right -> 21
node(32,13,22,0).
left_node(32,13,14).
right_node(32,13,21).
% node 14: ATRX <= 0.5  (F5, bin <= 0)  left -> 15, right -> 18
node(32,14,5,0).
left_node(32,14,15).
right_node(32,14,18).
% node 15: MUC16 <= 0.5  (F9, bin <= 0)  left -> 16, right -> 17
node(32,15,9,0).
left_node(32,15,16).
right_node(32,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(32,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(32,17,0).
% node 18: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 19, right -> 20
node(32,18,18,0).
left_node(32,18,19).
right_node(32,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(32,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(32,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(32,21,1).
% node 22: CIC <= 0.5  (F8, bin <= 0)  left -> 23, right -> 32
node(32,22,8,0).
left_node(32,22,23).
right_node(32,22,32).
% node 23: Age_at_diagnosis <= 70.61499786376953  (F1, bin <= 156)  left -> 24, right -> 31
node(32,23,1,156).
left_node(32,23,24).
right_node(32,23,31).
% node 24: MUC16 <= 0.5  (F9, bin <= 0)  left -> 25, right -> 28
node(32,24,9,0).
left_node(32,24,25).
right_node(32,24,28).
% node 25: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 26, right -> 27
node(32,25,18,0).
left_node(32,25,26).
right_node(32,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(32,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(32,27,0).
% node 28: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 29, right -> 30
node(32,28,18,0).
left_node(32,28,29).
right_node(32,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(32,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(32,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(32,31,1).
% node 32: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 33, right -> 34
node(32,32,15,0).
left_node(32,32,33).
right_node(32,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(32,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(32,34,0).

% Tree 33
tree(33).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 20
node(33,0,8,0).
left_node(33,0,1).
right_node(33,0,20).
% node 1: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 2, right -> 13
node(33,1,19,0).
left_node(33,1,2).
right_node(33,1,13).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(33,2,3,0).
left_node(33,2,3).
right_node(33,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(33,3,20,0).
left_node(33,3,4).
right_node(33,3,7).
% node 4: BCOR <= 0.5  (F16, bin <= 0)  left -> 5, right -> 6
node(33,4,16,0).
left_node(33,4,5).
right_node(33,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(33,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(33,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(33,7,0).
% node 8: EGFR <= 0.5  (F7, bin <= 0)  left -> 9, right -> 12
node(33,8,7,0).
left_node(33,8,9).
right_node(33,8,12).
% node 9: Race <= 0.5  (F2, bin <= 0)  left -> 10, right -> 11
node(33,9,2,0).
left_node(33,9,10).
right_node(33,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(33,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(33,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(33,12,1).
% node 13: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 14, right -> 19
node(33,13,12,0).
left_node(33,13,14).
right_node(33,13,19).
% node 14: IDH2 <= 0.5  (F20, bin <= 0)  left -> 15, right -> 18
node(33,14,20,0).
left_node(33,14,15).
right_node(33,14,18).
% node 15: NF1 <= 0.5  (F11, bin <= 0)  left -> 16, right -> 17
node(33,15,11,0).
left_node(33,15,16).
right_node(33,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(33,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(33,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(33,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(33,19,1).
% node 20: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 21, right -> 26
node(33,20,19,0).
left_node(33,20,21).
right_node(33,20,26).
% node 21: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 22, right -> 25
node(33,21,13,0).
left_node(33,21,22).
right_node(33,21,25).
% node 22: TP53 <= 0.5  (F4, bin <= 0)  left -> 23, right -> 24
node(33,22,4,0).
left_node(33,22,23).
right_node(33,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(33,23,0).
% node 24 (leaf): class 1 (1)
leaf_class(33,24,1).
% node 25 (leaf): class 0 (0)
leaf_class(33,25,0).
% node 26 (leaf): class 1 (1)
leaf_class(33,26,1).

% Tree 34
tree(34).
% node 0: Age_at_diagnosis <= 52.67499923706055  (F1, bin <= 112)  left -> 1, right -> 26
node(34,0,1,112).
left_node(34,0,1).
right_node(34,0,26).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 17
node(34,1,6,0).
left_node(34,1,2).
right_node(34,1,17).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(34,2,3,0).
left_node(34,2,3).
right_node(34,2,10).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(34,3,20,0).
left_node(34,3,4).
right_node(34,3,7).
% node 4: Age_at_diagnosis <= 50.03499984741211  (F1, bin <= 98)  left -> 5, right -> 6
node(34,4,1,98).
left_node(34,4,5).
right_node(34,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(34,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(34,6,1).
% node 7: NF1 <= 0.5  (F11, bin <= 0)  left -> 8, right -> 9
node(34,7,11,0).
left_node(34,7,8).
right_node(34,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(34,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(34,9,1).
% node 10: Race <= 0.5  (F2, bin <= 0)  left -> 11, right -> 14
node(34,10,2,0).
left_node(34,10,11).
right_node(34,10,14).
% node 11: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 12, right -> 13
node(34,11,22,0).
left_node(34,11,12).
right_node(34,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(34,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(34,13,1).
% node 14: Age_at_diagnosis <= 30.975000381469727  (F1, bin <= 16)  left -> 15, right -> 16
node(34,14,1,16).
left_node(34,14,15).
right_node(34,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(34,15,1).
% node 16 (leaf): class 0 (0)
leaf_class(34,16,0).
% node 17: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 18, right -> 23
node(34,17,18,0).
left_node(34,17,18).
right_node(34,17,23).
% node 18: BCOR <= 0.5  (F16, bin <= 0)  left -> 19, right -> 22
node(34,18,16,0).
left_node(34,18,19).
right_node(34,18,22).
% node 19: ATRX <= 0.5  (F5, bin <= 0)  left -> 20, right -> 21
node(34,19,5,0).
left_node(34,19,20).
right_node(34,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(34,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(34,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(34,22,0).
% node 23: Age_at_diagnosis <= 41.915000915527344  (F1, bin <= 46)  left -> 24, right -> 25
node(34,23,1,46).
left_node(34,23,24).
right_node(34,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(34,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(34,25,1).
% node 26: IDH1 <= 0.5  (F3, bin <= 0)  left -> 27, right -> 42
node(34,26,3,0).
left_node(34,26,27).
right_node(34,26,42).
% node 27: Age_at_diagnosis <= 66.5250015258789  (F1, bin <= 144)  left -> 28, right -> 35
node(34,27,1,144).
left_node(34,27,28).
right_node(34,27,35).
% node 28: TP53 <= 0.5  (F4, bin <= 0)  left -> 29, right -> 32
node(34,28,4,0).
left_node(34,28,29).
right_node(34,28,32).
% node 29: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 30, right -> 31
node(34,29,19,0).
left_node(34,29,30).
right_node(34,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(34,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(34,31,1).
% node 32: EGFR <= 0.5  (F7, bin <= 0)  left -> 33, right -> 34
node(34,32,7,0).
left_node(34,32,33).
right_node(34,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(34,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(34,34,1).
% node 35: EGFR <= 0.5  (F7, bin <= 0)  left -> 36, right -> 39
node(34,35,7,0).
left_node(34,35,36).
right_node(34,35,39).
% node 36: MUC16 <= 0.5  (F9, bin <= 0)  left -> 37, right -> 38
node(34,36,9,0).
left_node(34,36,37).
right_node(34,36,38).
% node 37 (leaf): class 1 (1)
leaf_class(34,37,1).
% node 38 (leaf): class 1 (1)
leaf_class(34,38,1).
% node 39: Gender <= 0.5  (F0, bin <= 0)  left -> 40, right -> 41
node(34,39,0,0).
left_node(34,39,40).
right_node(34,39,41).
% node 40 (leaf): class 1 (1)
leaf_class(34,40,1).
% node 41 (leaf): class 1 (1)
leaf_class(34,41,1).
% node 42: NF1 <= 0.5  (F11, bin <= 0)  left -> 43, right -> 48
node(34,42,11,0).
left_node(34,42,43).
right_node(34,42,48).
% node 43: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 44, right -> 47
node(34,43,10,0).
left_node(34,43,44).
right_node(34,43,47).
% node 44: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 45, right -> 46
node(34,44,12,0).
left_node(34,44,45).
right_node(34,44,46).
% node 45 (leaf): class 0 (0)
leaf_class(34,45,0).
% node 46 (leaf): class 0 (0)
leaf_class(34,46,0).
% node 47 (leaf): class 0 (0)
leaf_class(34,47,0).
% node 48 (leaf): class 0 (0)
leaf_class(34,48,0).

% Tree 35
tree(35).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 26
node(35,0,8,0).
left_node(35,0,1).
right_node(35,0,26).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 17
node(35,1,4,0).
left_node(35,1,2).
right_node(35,1,17).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 10
node(35,2,6,0).
left_node(35,2,3).
right_node(35,2,10).
% node 3: FAT4 <= 0.5  (F21, bin <= 0)  left -> 4, right -> 7
node(35,3,21,0).
left_node(35,3,4).
right_node(35,3,7).
% node 4: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 5, right -> 6
node(35,4,13,0).
left_node(35,4,5).
right_node(35,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(35,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(35,6,0).
% node 7: Age_at_diagnosis <= 64.94500160217285  (F1, bin <= 140)  left -> 8, right -> 9
node(35,7,1,140).
left_node(35,7,8).
right_node(35,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(35,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(35,9,1).
% node 10: Age_at_diagnosis <= 57.93499946594238  (F1, bin <= 122)  left -> 11, right -> 14
node(35,10,1,122).
left_node(35,10,11).
right_node(35,10,14).
% node 11: MUC16 <= 0.5  (F9, bin <= 0)  left -> 12, right -> 13
node(35,11,9,0).
left_node(35,11,12).
right_node(35,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(35,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(35,13,1).
% node 14: NF1 <= 0.5  (F11, bin <= 0)  left -> 15, right -> 16
node(35,14,11,0).
left_node(35,14,15).
right_node(35,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(35,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(35,16,1).
% node 17: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 18, right -> 25
node(35,17,13,0).
left_node(35,17,18).
right_node(35,17,25).
% node 18: PTEN <= 0.5  (F6, bin <= 0)  left -> 19, right -> 22
node(35,18,6,0).
left_node(35,18,19).
right_node(35,18,22).
% node 19: Age_at_diagnosis <= 52.845001220703125  (F1, bin <= 115)  left -> 20, right -> 21
node(35,19,1,115).
left_node(35,19,20).
right_node(35,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(35,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(35,21,1).
% node 22: MUC16 <= 0.5  (F9, bin <= 0)  left -> 23, right -> 24
node(35,22,9,0).
left_node(35,22,23).
right_node(35,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(35,23,1).
% node 24 (leaf): class 1 (1)
leaf_class(35,24,1).
% node 25 (leaf): class 0 (0)
leaf_class(35,25,0).
% node 26: ATRX <= 0.5  (F5, bin <= 0)  left -> 27, right -> 28
node(35,26,5,0).
left_node(35,26,27).
right_node(35,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(35,27,0).
% node 28: PTEN <= 0.5  (F6, bin <= 0)  left -> 29, right -> 30
node(35,28,6,0).
left_node(35,28,29).
right_node(35,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(35,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(35,30,0).

% Tree 36
tree(36).
% node 0: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 1, right -> 28
node(36,0,13,0).
left_node(36,0,1).
right_node(36,0,28).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 15
node(36,1,5,0).
left_node(36,1,2).
right_node(36,1,15).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(36,2,3,0).
left_node(36,2,3).
right_node(36,2,10).
% node 3: Age_at_diagnosis <= 48.80999946594238  (F1, bin <= 87)  left -> 4, right -> 7
node(36,3,1,87).
left_node(36,3,4).
right_node(36,3,7).
% node 4: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 5, right -> 6
node(36,4,10,0).
left_node(36,4,5).
right_node(36,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(36,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(36,6,0).
% node 7: EGFR <= 0.5  (F7, bin <= 0)  left -> 8, right -> 9
node(36,7,7,0).
left_node(36,7,8).
right_node(36,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(36,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(36,9,1).
% node 10: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 11, right -> 14
node(36,10,15,0).
left_node(36,10,11).
right_node(36,10,14).
% node 11: Age_at_diagnosis <= 43.364999771118164  (F1, bin <= 49)  left -> 12, right -> 13
node(36,11,1,49).
left_node(36,11,12).
right_node(36,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(36,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(36,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(36,14,0).
% node 15: Race <= 0.5  (F2, bin <= 0)  left -> 16, right -> 23
node(36,15,2,0).
left_node(36,15,16).
right_node(36,15,23).
% node 16: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 17, right -> 20
node(36,16,12,0).
left_node(36,16,17).
right_node(36,16,20).
% node 17: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 18, right -> 19
node(36,17,15,0).
left_node(36,17,18).
right_node(36,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(36,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(36,19,0).
% node 20: Age_at_diagnosis <= 51.07499885559082  (F1, bin <= 102)  left -> 21, right -> 22
node(36,20,1,102).
left_node(36,20,21).
right_node(36,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(36,21,0).
% node 22 (leaf): class 1 (1)
leaf_class(36,22,1).
% node 23: Age_at_diagnosis <= 27.470001220703125  (F1, bin <= 9)  left -> 24, right -> 25
node(36,23,1,9).
left_node(36,23,24).
right_node(36,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(36,24,1).
% node 25: Race <= 1.5  (F2, bin <= 1)  left -> 26, right -> 27
node(36,25,2,1).
left_node(36,25,26).
right_node(36,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(36,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(36,27,1).
% node 28: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 29, right -> 30
node(36,28,19,0).
left_node(36,28,29).
right_node(36,28,30).
% node 29 (leaf): class 0 (0)
leaf_class(36,29,0).
% node 30: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 31, right -> 34
node(36,30,12,0).
left_node(36,30,31).
right_node(36,30,34).
% node 31: Age_at_diagnosis <= 41.82500076293945  (F1, bin <= 44)  left -> 32, right -> 33
node(36,31,1,44).
left_node(36,31,32).
right_node(36,31,33).
% node 32 (leaf): class 0 (0)
leaf_class(36,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(36,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(36,34,1).

% Tree 37
tree(37).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 22
node(37,0,8,0).
left_node(37,0,1).
right_node(37,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(37,1,3,0).
left_node(37,1,2).
right_node(37,1,13).
% node 2: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 3, right -> 8
node(37,2,12,0).
left_node(37,2,3).
right_node(37,2,8).
% node 3: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 4, right -> 7
node(37,3,15,0).
left_node(37,3,4).
right_node(37,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(37,4,20,0).
left_node(37,4,5).
right_node(37,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(37,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(37,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(37,7,0).
% node 8: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 9, right -> 12
node(37,8,19,0).
left_node(37,8,9).
right_node(37,8,12).
% node 9: Age_at_diagnosis <= 56.9950008392334  (F1, bin <= 120)  left -> 10, right -> 11
node(37,9,1,120).
left_node(37,9,10).
right_node(37,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(37,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(37,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(37,12,1).
% node 13: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 14, right -> 21
node(37,13,15,0).
left_node(37,13,14).
right_node(37,13,21).
% node 14: Age_at_diagnosis <= 25.449999809265137  (F1, bin <= 7)  left -> 15, right -> 18
node(37,14,1,7).
left_node(37,14,15).
right_node(37,14,18).
% node 15: ATRX <= 0.5  (F5, bin <= 0)  left -> 16, right -> 17
node(37,15,5,0).
left_node(37,15,16).
right_node(37,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(37,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(37,17,0).
% node 18: Race <= 0.5  (F2, bin <= 0)  left -> 19, right -> 20
node(37,18,2,0).
left_node(37,18,19).
right_node(37,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(37,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(37,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(37,21,0).
% node 22: BCOR <= 0.5  (F16, bin <= 0)  left -> 23, right -> 24
node(37,22,16,0).
left_node(37,22,23).
right_node(37,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(37,23,0).
% node 24: TP53 <= 0.5  (F4, bin <= 0)  left -> 25, right -> 26
node(37,24,4,0).
left_node(37,24,25).
right_node(37,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(37,25,0).
% node 26: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 27, right -> 28
node(37,26,12,0).
left_node(37,26,27).
right_node(37,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(37,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(37,28,1).

% Tree 38
tree(38).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 26
node(38,0,6,0).
left_node(38,0,1).
right_node(38,0,26).
% node 1: MUC16 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 15
node(38,1,9,0).
left_node(38,1,2).
right_node(38,1,15).
% node 2: Age_at_diagnosis <= 71.46500015258789  (F1, bin <= 158)  left -> 3, right -> 10
node(38,2,1,158).
left_node(38,2,3).
right_node(38,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(38,3,3,0).
left_node(38,3,4).
right_node(38,3,7).
% node 4: RB1 <= 0.5  (F14, bin <= 0)  left -> 5, right -> 6
node(38,4,14,0).
left_node(38,4,5).
right_node(38,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(38,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(38,6,1).
% node 7: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 8, right -> 9
node(38,7,13,0).
left_node(38,7,8).
right_node(38,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(38,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(38,9,0).
% node 10: Age_at_diagnosis <= 86.70999908447266  (F1, bin <= 170)  left -> 11, right -> 14
node(38,10,1,170).
left_node(38,10,11).
right_node(38,10,14).
% node 11: CIC <= 0.5  (F8, bin <= 0)  left -> 12, right -> 13
node(38,11,8,0).
left_node(38,11,12).
right_node(38,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(38,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(38,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(38,14,0).
% node 15: EGFR <= 0.5  (F7, bin <= 0)  left -> 16, right -> 21
node(38,15,7,0).
left_node(38,15,16).
right_node(38,15,21).
% node 16: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 17, right -> 20
node(38,16,17,0).
left_node(38,16,17).
right_node(38,16,20).
% node 17: TP53 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(38,17,4,0).
left_node(38,17,18).
right_node(38,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(38,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(38,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(38,20,0).
% node 21: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 22, right -> 25
node(38,21,18,0).
left_node(38,21,22).
right_node(38,21,25).
% node 22: Age_at_diagnosis <= 65.16500091552734  (F1, bin <= 141)  left -> 23, right -> 24
node(38,22,1,141).
left_node(38,22,23).
right_node(38,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(38,23,1).
% node 24 (leaf): class 0 (0)
leaf_class(38,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(38,25,1).
% node 26: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 27, right -> 34
node(38,26,17,0).
left_node(38,26,27).
right_node(38,26,34).
% node 27: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 28, right -> 33
node(38,27,12,0).
left_node(38,27,28).
right_node(38,27,33).
% node 28: CIC <= 0.5  (F8, bin <= 0)  left -> 29, right -> 32
node(38,28,8,0).
left_node(38,28,29).
right_node(38,28,32).
% node 29: RB1 <= 0.5  (F14, bin <= 0)  left -> 30, right -> 31
node(38,29,14,0).
left_node(38,29,30).
right_node(38,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(38,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(38,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(38,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(38,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(38,34,1).

% Tree 39
tree(39).
% node 0: IDH2 <= 0.5  (F20, bin <= 0)  left -> 1, right -> 12
node(39,0,20,0).
left_node(39,0,1).
right_node(39,0,12).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 11
node(39,1,13,0).
left_node(39,1,2).
right_node(39,1,11).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 10
node(39,2,15,0).
left_node(39,2,3).
right_node(39,2,10).
% node 3: ATRX <= 0.5  (F5, bin <= 0)  left -> 4, right -> 7
node(39,3,5,0).
left_node(39,3,4).
right_node(39,3,7).
% node 4: MUC16 <= 0.5  (F9, bin <= 0)  left -> 5, right -> 6
node(39,4,9,0).
left_node(39,4,5).
right_node(39,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(39,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(39,6,1).
% node 7: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 8, right -> 9
node(39,7,12,0).
left_node(39,7,8).
right_node(39,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(39,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(39,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(39,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(39,11,0).
% node 12: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 13, right -> 14
node(39,12,12,0).
left_node(39,12,13).
right_node(39,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(39,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(39,14,1).

% Tree 40
tree(40).
% node 0: Age_at_diagnosis <= 48.84000015258789  (F1, bin <= 90)  left -> 1, right -> 20
node(40,0,1,90).
left_node(40,0,1).
right_node(40,0,20).
% node 1: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 2, right -> 11
node(40,1,10,0).
left_node(40,1,2).
right_node(40,1,11).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 10
node(40,2,15,0).
left_node(40,2,3).
right_node(40,2,10).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(40,3,7,0).
left_node(40,3,4).
right_node(40,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(40,4,3,0).
left_node(40,4,5).
right_node(40,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(40,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(40,6,0).
% node 7: Age_at_diagnosis <= 48.19999885559082  (F1, bin <= 83)  left -> 8, right -> 9
node(40,7,1,83).
left_node(40,7,8).
right_node(40,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(40,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(40,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(40,10,0).
% node 11: EGFR <= 0.5  (F7, bin <= 0)  left -> 12, right -> 19
node(40,11,7,0).
left_node(40,11,12).
right_node(40,11,19).
% node 12: ATRX <= 0.5  (F5, bin <= 0)  left -> 13, right -> 16
node(40,12,5,0).
left_node(40,12,13).
right_node(40,12,16).
% node 13: Age_at_diagnosis <= 46.69000053405762  (F1, bin <= 76)  left -> 14, right -> 15
node(40,13,1,76).
left_node(40,13,14).
right_node(40,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(40,14,0).
% node 15 (leaf): class 1 (1)
leaf_class(40,15,1).
% node 16: IDH1 <= 0.5  (F3, bin <= 0)  left -> 17, right -> 18
node(40,16,3,0).
left_node(40,16,17).
right_node(40,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(40,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(40,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(40,19,0).
% node 20: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 21, right -> 32
node(40,20,13,0).
left_node(40,20,21).
right_node(40,20,32).
% node 21: IDH1 <= 0.5  (F3, bin <= 0)  left -> 22, right -> 27
node(40,21,3,0).
left_node(40,21,22).
right_node(40,21,27).
% node 22: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 23, right -> 26
node(40,22,19,0).
left_node(40,22,23).
right_node(40,22,26).
% node 23: EGFR <= 0.5  (F7, bin <= 0)  left -> 24, right -> 25
node(40,23,7,0).
left_node(40,23,24).
right_node(40,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(40,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(40,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(40,26,1).
% node 27: ATRX <= 0.5  (F5, bin <= 0)  left -> 28, right -> 29
node(40,27,5,0).
left_node(40,27,28).
right_node(40,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(40,28,0).
% node 29: Gender <= 0.5  (F0, bin <= 0)  left -> 30, right -> 31
node(40,29,0,0).
left_node(40,29,30).
right_node(40,29,31).
% node 30 (leaf): class 0 (0)
leaf_class(40,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(40,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(40,32,0).

% Tree 41
tree(41).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 22
node(41,0,8,0).
left_node(41,0,1).
right_node(41,0,22).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(41,1,6,0).
left_node(41,1,2).
right_node(41,1,15).
% node 2: Age_at_diagnosis <= 43.55499839782715  (F1, bin <= 51)  left -> 3, right -> 8
node(41,2,1,51).
left_node(41,2,3).
right_node(41,2,8).
% node 3: Age_at_diagnosis <= 39.60999870300293  (F1, bin <= 40)  left -> 4, right -> 7
node(41,3,1,40).
left_node(41,3,4).
right_node(41,3,7).
% node 4: Race <= 0.5  (F2, bin <= 0)  left -> 5, right -> 6
node(41,4,2,0).
left_node(41,4,5).
right_node(41,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(41,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(41,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(41,7,0).
% node 8: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 9, right -> 12
node(41,8,19,0).
left_node(41,8,9).
right_node(41,8,12).
% node 9: ATRX <= 0.5  (F5, bin <= 0)  left -> 10, right -> 11
node(41,9,5,0).
left_node(41,9,10).
right_node(41,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(41,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(41,11,0).
% node 12: EGFR <= 0.5  (F7, bin <= 0)  left -> 13, right -> 14
node(41,12,7,0).
left_node(41,12,13).
right_node(41,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(41,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(41,14,1).
% node 15: Age_at_diagnosis <= 66.45999908447266  (F1, bin <= 143)  left -> 16, right -> 21
node(41,15,1,143).
left_node(41,15,16).
right_node(41,15,21).
% node 16: RB1 <= 0.5  (F14, bin <= 0)  left -> 17, right -> 20
node(41,16,14,0).
left_node(41,16,17).
right_node(41,16,20).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(41,17,2,0).
left_node(41,17,18).
right_node(41,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(41,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(41,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(41,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(41,21,1).
% node 22: TP53 <= 0.5  (F4, bin <= 0)  left -> 23, right -> 24
node(41,22,4,0).
left_node(41,22,23).
right_node(41,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(41,23,0).
% node 24: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 25, right -> 26
node(41,24,13,0).
left_node(41,24,25).
right_node(41,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(41,25,1).
% node 26: Gender <= 0.5  (F0, bin <= 0)  left -> 27, right -> 28
node(41,26,0,0).
left_node(41,26,27).
right_node(41,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(41,27,0).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 30
node(41,28,15,0).
left_node(41,28,29).
right_node(41,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(41,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(41,30,0).

% Tree 42
tree(42).
% node 0: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 1, right -> 22
node(42,0,13,0).
left_node(42,0,1).
right_node(42,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(42,1,3,0).
left_node(42,1,2).
right_node(42,1,13).
% node 2: Age_at_diagnosis <= 64.06999969482422  (F1, bin <= 139)  left -> 3, right -> 8
node(42,2,1,139).
left_node(42,2,3).
right_node(42,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(42,3,8,0).
left_node(42,3,4).
right_node(42,3,7).
% node 4: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 5, right -> 6
node(42,4,15,0).
left_node(42,4,5).
right_node(42,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(42,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(42,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(42,7,0).
% node 8: MUC16 <= 0.5  (F9, bin <= 0)  left -> 9, right -> 12
node(42,8,9,0).
left_node(42,8,9).
right_node(42,8,12).
% node 9: EGFR <= 0.5  (F7, bin <= 0)  left -> 10, right -> 11
node(42,9,7,0).
left_node(42,9,10).
right_node(42,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(42,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(42,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(42,12,1).
% node 13: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 14, right -> 21
node(42,13,15,0).
left_node(42,13,14).
right_node(42,13,21).
% node 14: TP53 <= 0.5  (F4, bin <= 0)  left -> 15, right -> 18
node(42,14,4,0).
left_node(42,14,15).
right_node(42,14,18).
% node 15: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 16, right -> 17
node(42,15,12,0).
left_node(42,15,16).
right_node(42,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(42,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(42,17,0).
% node 18: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 19, right -> 20
node(42,18,12,0).
left_node(42,18,19).
right_node(42,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(42,19,0).
% node 20 (leaf): class 1 (1)
leaf_class(42,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(42,21,0).
% node 22: EGFR <= 0.5  (F7, bin <= 0)  left -> 23, right -> 30
node(42,22,7,0).
left_node(42,22,23).
right_node(42,22,30).
% node 23: CIC <= 0.5  (F8, bin <= 0)  left -> 24, right -> 29
node(42,23,8,0).
left_node(42,23,24).
right_node(42,23,29).
% node 24: Age_at_diagnosis <= 48.15500068664551  (F1, bin <= 82)  left -> 25, right -> 26
node(42,24,1,82).
left_node(42,24,25).
right_node(42,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(42,25,0).
% node 26: IDH1 <= 0.5  (F3, bin <= 0)  left -> 27, right -> 28
node(42,26,3,0).
left_node(42,26,27).
right_node(42,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(42,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(42,28,0).
% node 29 (leaf): class 0 (0)
leaf_class(42,29,0).
% node 30 (leaf): class 1 (1)
leaf_class(42,30,1).

% Tree 43
tree(43).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 24
node(43,0,14,0).
left_node(43,0,1).
right_node(43,0,24).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 15
node(43,1,7,0).
left_node(43,1,2).
right_node(43,1,15).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(43,2,3,0).
left_node(43,2,3).
right_node(43,2,10).
% node 3: Age_at_diagnosis <= 48.829999923706055  (F1, bin <= 89)  left -> 4, right -> 7
node(43,3,1,89).
left_node(43,3,4).
right_node(43,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(43,4,20,0).
left_node(43,4,5).
right_node(43,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(43,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(43,6,0).
% node 7: CIC <= 0.5  (F8, bin <= 0)  left -> 8, right -> 9
node(43,7,8,0).
left_node(43,7,8).
right_node(43,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(43,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(43,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 14
node(43,10,8,0).
left_node(43,10,11).
right_node(43,10,14).
% node 11: BCOR <= 0.5  (F16, bin <= 0)  left -> 12, right -> 13
node(43,11,16,0).
left_node(43,11,12).
right_node(43,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(43,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(43,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(43,14,0).
% node 15: Race <= 0.5  (F2, bin <= 0)  left -> 16, right -> 23
node(43,15,2,0).
left_node(43,15,16).
right_node(43,15,23).
% node 16: MUC16 <= 0.5  (F9, bin <= 0)  left -> 17, right -> 20
node(43,16,9,0).
left_node(43,16,17).
right_node(43,16,20).
% node 17: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 18, right -> 19
node(43,17,17,0).
left_node(43,17,18).
right_node(43,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(43,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(43,19,1).
% node 20: NF1 <= 0.5  (F11, bin <= 0)  left -> 21, right -> 22
node(43,20,11,0).
left_node(43,20,21).
right_node(43,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(43,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(43,22,0).
% node 23 (leaf): class 1 (1)
leaf_class(43,23,1).
% node 24: ATRX <= 0.5  (F5, bin <= 0)  left -> 25, right -> 32
node(43,24,5,0).
left_node(43,24,25).
right_node(43,24,32).
% node 25: IDH1 <= 0.5  (F3, bin <= 0)  left -> 26, right -> 31
node(43,25,3,0).
left_node(43,25,26).
right_node(43,25,31).
% node 26: MUC16 <= 0.5  (F9, bin <= 0)  left -> 27, right -> 30
node(43,26,9,0).
left_node(43,26,27).
right_node(43,26,30).
% node 27: TP53 <= 0.5  (F4, bin <= 0)  left -> 28, right -> 29
node(43,27,4,0).
left_node(43,27,28).
right_node(43,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(43,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(43,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(43,30,1).
% node 31 (leaf): class 0 (0)
leaf_class(43,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(43,32,1).

% Tree 44
tree(44).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 18
node(44,0,3,0).
left_node(44,0,1).
right_node(44,0,18).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 11
node(44,1,7,0).
left_node(44,1,2).
right_node(44,1,11).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 10
node(44,2,8,0).
left_node(44,2,3).
right_node(44,2,10).
% node 3: Age_at_diagnosis <= 60.21000099182129  (F1, bin <= 128)  left -> 4, right -> 7
node(44,3,1,128).
left_node(44,3,4).
right_node(44,3,7).
% node 4: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 5, right -> 6
node(44,4,15,0).
left_node(44,4,5).
right_node(44,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(44,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(44,6,0).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(44,7,0,0).
left_node(44,7,8).
right_node(44,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(44,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(44,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(44,10,0).
% node 11: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 12, right -> 17
node(44,11,17,0).
left_node(44,11,12).
right_node(44,11,17).
% node 12: Age_at_diagnosis <= 70.61499786376953  (F1, bin <= 156)  left -> 13, right -> 16
node(44,12,1,156).
left_node(44,12,13).
right_node(44,12,16).
% node 13: TP53 <= 0.5  (F4, bin <= 0)  left -> 14, right -> 15
node(44,13,4,0).
left_node(44,13,14).
right_node(44,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(44,14,1).
% node 15 (leaf): class 1 (1)
leaf_class(44,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(44,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(44,17,1).
% node 18: Race <= 0.5  (F2, bin <= 0)  left -> 19, right -> 30
node(44,18,2,0).
left_node(44,18,19).
right_node(44,18,30).
% node 19: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 20, right -> 25
node(44,19,10,0).
left_node(44,19,20).
right_node(44,19,25).
% node 20: ATRX <= 0.5  (F5, bin <= 0)  left -> 21, right -> 22
node(44,20,5,0).
left_node(44,20,21).
right_node(44,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(44,21,0).
% node 22: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 23, right -> 24
node(44,22,15,0).
left_node(44,22,23).
right_node(44,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(44,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(44,24,0).
% node 25: Age_at_diagnosis <= 47.04999923706055  (F1, bin <= 78)  left -> 26, right -> 29
node(44,25,1,78).
left_node(44,25,26).
right_node(44,25,29).
% node 26: ATRX <= 0.5  (F5, bin <= 0)  left -> 27, right -> 28
node(44,26,5,0).
left_node(44,26,27).
right_node(44,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(44,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(44,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(44,29,0).
% node 30: TP53 <= 0.5  (F4, bin <= 0)  left -> 31, right -> 32
node(44,30,4,0).
left_node(44,30,31).
right_node(44,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(44,31,0).
% node 32: MUC16 <= 0.5  (F9, bin <= 0)  left -> 33, right -> 36
node(44,32,9,0).
left_node(44,32,33).
right_node(44,32,36).
% node 33: PTEN <= 0.5  (F6, bin <= 0)  left -> 34, right -> 35
node(44,33,6,0).
left_node(44,33,34).
right_node(44,33,35).
% node 34 (leaf): class 1 (1)
leaf_class(44,34,1).
% node 35 (leaf): class 1 (1)
leaf_class(44,35,1).
% node 36 (leaf): class 0 (0)
leaf_class(44,36,0).

% Tree 45
tree(45).
% node 0: Age_at_diagnosis <= 45.35499954223633  (F1, bin <= 62)  left -> 1, right -> 20
node(45,0,1,62).
left_node(45,0,1).
right_node(45,0,20).
% node 1: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 2, right -> 13
node(45,1,19,0).
left_node(45,1,2).
right_node(45,1,13).
% node 2: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 3, right -> 10
node(45,2,17,0).
left_node(45,2,3).
right_node(45,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(45,3,3,0).
left_node(45,3,4).
right_node(45,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(45,4,20,0).
left_node(45,4,5).
right_node(45,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(45,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(45,6,0).
% node 7: TP53 <= 0.5  (F4, bin <= 0)  left -> 8, right -> 9
node(45,7,4,0).
left_node(45,7,8).
right_node(45,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(45,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(45,9,0).
% node 10: RB1 <= 0.5  (F14, bin <= 0)  left -> 11, right -> 12
node(45,10,14,0).
left_node(45,10,11).
right_node(45,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(45,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(45,12,1).
% node 13: NF1 <= 0.5  (F11, bin <= 0)  left -> 14, right -> 17
node(45,13,11,0).
left_node(45,13,14).
right_node(45,13,17).
% node 14: EGFR <= 0.5  (F7, bin <= 0)  left -> 15, right -> 16
node(45,14,7,0).
left_node(45,14,15).
right_node(45,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(45,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(45,16,1).
% node 17: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 18, right -> 19
node(45,17,15,0).
left_node(45,17,18).
right_node(45,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(45,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(45,19,0).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 30
node(45,20,3,0).
left_node(45,20,21).
right_node(45,20,30).
% node 21: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 22, right -> 29
node(45,21,15,0).
left_node(45,21,22).
right_node(45,21,29).
% node 22: EGFR <= 0.5  (F7, bin <= 0)  left -> 23, right -> 26
node(45,22,7,0).
left_node(45,22,23).
right_node(45,22,26).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 25
node(45,23,6,0).
left_node(45,23,24).
right_node(45,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(45,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(45,25,1).
% node 26: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 27, right -> 28
node(45,26,17,0).
left_node(45,26,27).
right_node(45,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(45,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(45,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(45,29,0).
% node 30: CIC <= 0.5  (F8, bin <= 0)  left -> 31, right -> 38
node(45,30,8,0).
left_node(45,30,31).
right_node(45,30,38).
% node 31: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 32, right -> 35
node(45,31,12,0).
left_node(45,31,32).
right_node(45,31,35).
% node 32: Age_at_diagnosis <= 46.55000114440918  (F1, bin <= 73)  left -> 33, right -> 34
node(45,32,1,73).
left_node(45,32,33).
right_node(45,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(45,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(45,34,0).
% node 35: NF1 <= 0.5  (F11, bin <= 0)  left -> 36, right -> 37
node(45,35,11,0).
left_node(45,35,36).
right_node(45,35,37).
% node 36 (leaf): class 1 (1)
leaf_class(45,36,1).
% node 37 (leaf): class 0 (0)
leaf_class(45,37,0).
% node 38 (leaf): class 0 (0)
leaf_class(45,38,0).

% Tree 46
tree(46).
% node 0: Age_at_diagnosis <= 46.57500076293945  (F1, bin <= 74)  left -> 1, right -> 18
node(46,0,1,74).
left_node(46,0,1).
right_node(46,0,18).
% node 1: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 2, right -> 11
node(46,1,12,0).
left_node(46,1,2).
right_node(46,1,11).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 10
node(46,2,20,0).
left_node(46,2,3).
right_node(46,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(46,3,14,0).
left_node(46,3,4).
right_node(46,3,7).
% node 4: Age_at_diagnosis <= 44.30999946594238  (F1, bin <= 55)  left -> 5, right -> 6
node(46,4,1,55).
left_node(46,4,5).
right_node(46,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(46,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(46,6,0).
% node 7: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 8, right -> 9
node(46,7,10,0).
left_node(46,7,8).
right_node(46,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(46,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(46,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(46,10,0).
% node 11: EGFR <= 0.5  (F7, bin <= 0)  left -> 12, right -> 17
node(46,11,7,0).
left_node(46,11,12).
right_node(46,11,17).
% node 12: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 13, right -> 16
node(46,12,13,0).
left_node(46,12,13).
right_node(46,12,16).
% node 13: BCOR <= 0.5  (F16, bin <= 0)  left -> 14, right -> 15
node(46,13,16,0).
left_node(46,13,14).
right_node(46,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(46,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(46,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(46,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(46,17,1).
% node 18: ATRX <= 0.5  (F5, bin <= 0)  left -> 19, right -> 28
node(46,18,5,0).
left_node(46,18,19).
right_node(46,18,28).
% node 19: Age_at_diagnosis <= 71.7400016784668  (F1, bin <= 160)  left -> 20, right -> 27
node(46,19,1,160).
left_node(46,19,20).
right_node(46,19,27).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 24
node(46,20,3,0).
left_node(46,20,21).
right_node(46,20,24).
% node 21: FAT4 <= 0.5  (F21, bin <= 0)  left -> 22, right -> 23
node(46,21,21,0).
left_node(46,21,22).
right_node(46,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(46,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(46,23,0).
% node 24: RB1 <= 0.5  (F14, bin <= 0)  left -> 25, right -> 26
node(46,24,14,0).
left_node(46,24,25).
right_node(46,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(46,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(46,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(46,27,1).
% node 28: Age_at_diagnosis <= 69.21000289916992  (F1, bin <= 151)  left -> 29, right -> 34
node(46,28,1,151).
left_node(46,28,29).
right_node(46,28,34).
% node 29: PTEN <= 0.5  (F6, bin <= 0)  left -> 30, right -> 33
node(46,29,6,0).
left_node(46,29,30).
right_node(46,29,33).
% node 30: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 31, right -> 32
node(46,30,10,0).
left_node(46,30,31).
right_node(46,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(46,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(46,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(46,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(46,34,1).

% Tree 47
tree(47).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 16
node(47,0,3,0).
left_node(47,0,1).
right_node(47,0,16).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 13
node(47,1,20,0).
left_node(47,1,2).
right_node(47,1,13).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(47,2,9,0).
left_node(47,2,3).
right_node(47,2,8).
% node 3: Race <= 2.5  (F2, bin <= 2)  left -> 4, right -> 7
node(47,3,2,2).
left_node(47,3,4).
right_node(47,3,7).
% node 4: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 5, right -> 6
node(47,4,10,0).
left_node(47,4,5).
right_node(47,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(47,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(47,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(47,7,0).
% node 8: CIC <= 0.5  (F8, bin <= 0)  left -> 9, right -> 12
node(47,8,8,0).
left_node(47,8,9).
right_node(47,8,12).
% node 9: NF1 <= 0.5  (F11, bin <= 0)  left -> 10, right -> 11
node(47,9,11,0).
left_node(47,9,10).
right_node(47,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(47,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(47,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(47,12,0).
% node 13: ATRX <= 0.5  (F5, bin <= 0)  left -> 14, right -> 15
node(47,13,5,0).
left_node(47,13,14).
right_node(47,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(47,14,0).
% node 15 (leaf): class 1 (1)
leaf_class(47,15,1).
% node 16: ATRX <= 0.5  (F5, bin <= 0)  left -> 17, right -> 28
node(47,16,5,0).
left_node(47,16,17).
right_node(47,16,28).
% node 17: Gender <= 0.5  (F0, bin <= 0)  left -> 18, right -> 23
node(47,17,0,0).
left_node(47,17,18).
right_node(47,17,23).
% node 18: CIC <= 0.5  (F8, bin <= 0)  left -> 19, right -> 22
node(47,18,8,0).
left_node(47,18,19).
right_node(47,18,22).
% node 19: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 20, right -> 21
node(47,19,18,0).
left_node(47,19,20).
right_node(47,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(47,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(47,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(47,22,0).
% node 23: TP53 <= 0.5  (F4, bin <= 0)  left -> 24, right -> 25
node(47,23,4,0).
left_node(47,23,24).
right_node(47,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(47,24,0).
% node 25: FAT4 <= 0.5  (F21, bin <= 0)  left -> 26, right -> 27
node(47,25,21,0).
left_node(47,25,26).
right_node(47,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(47,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(47,27,1).
% node 28: Race <= 1.5  (F2, bin <= 1)  left -> 29, right -> 36
node(47,28,2,1).
left_node(47,28,29).
right_node(47,28,36).
% node 29: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 30, right -> 33
node(47,29,12,0).
left_node(47,29,30).
right_node(47,29,33).
% node 30: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 31, right -> 32
node(47,30,22,0).
left_node(47,30,31).
right_node(47,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(47,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(47,32,1).
% node 33: MUC16 <= 0.5  (F9, bin <= 0)  left -> 34, right -> 35
node(47,33,9,0).
left_node(47,33,34).
right_node(47,33,35).
% node 34 (leaf): class 1 (1)
leaf_class(47,34,1).
% node 35 (leaf): class 0 (0)
leaf_class(47,35,0).
% node 36 (leaf): class 1 (1)
leaf_class(47,36,1).

% Tree 48
tree(48).
% node 0: MUC16 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 22
node(48,0,9,0).
left_node(48,0,1).
right_node(48,0,22).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(48,1,6,0).
left_node(48,1,2).
right_node(48,1,15).
% node 2: Age_at_diagnosis <= 49.209999084472656  (F1, bin <= 94)  left -> 3, right -> 10
node(48,2,1,94).
left_node(48,2,3).
right_node(48,2,10).
% node 3: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 4, right -> 7
node(48,3,12,0).
left_node(48,3,4).
right_node(48,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(48,4,3,0).
left_node(48,4,5).
right_node(48,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(48,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(48,6,0).
% node 7: Age_at_diagnosis <= 35.874999046325684  (F1, bin <= 29)  left -> 8, right -> 9
node(48,7,1,29).
left_node(48,7,8).
right_node(48,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(48,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(48,9,0).
% node 10: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 11, right -> 14
node(48,10,15,0).
left_node(48,10,11).
right_node(48,10,14).
% node 11: IDH2 <= 0.5  (F20, bin <= 0)  left -> 12, right -> 13
node(48,11,20,0).
left_node(48,11,12).
right_node(48,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(48,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(48,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(48,14,0).
% node 15: CIC <= 0.5  (F8, bin <= 0)  left -> 16, right -> 21
node(48,15,8,0).
left_node(48,15,16).
right_node(48,15,21).
% node 16: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 17, right -> 20
node(48,16,19,0).
left_node(48,16,17).
right_node(48,16,20).
% node 17: EGFR <= 0.5  (F7, bin <= 0)  left -> 18, right -> 19
node(48,17,7,0).
left_node(48,17,18).
right_node(48,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(48,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(48,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(48,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(48,21,0).
% node 22: FAT4 <= 0.5  (F21, bin <= 0)  left -> 23, right -> 34
node(48,22,21,0).
left_node(48,22,23).
right_node(48,22,34).
% node 23: ATRX <= 0.5  (F5, bin <= 0)  left -> 24, right -> 29
node(48,23,5,0).
left_node(48,23,24).
right_node(48,23,29).
% node 24: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 25, right -> 28
node(48,24,10,0).
left_node(48,24,25).
right_node(48,24,28).
% node 25: TP53 <= 0.5  (F4, bin <= 0)  left -> 26, right -> 27
node(48,25,4,0).
left_node(48,25,26).
right_node(48,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(48,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(48,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(48,28,1).
% node 29: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 30, right -> 33
node(48,29,15,0).
left_node(48,29,30).
right_node(48,29,33).
% node 30: RB1 <= 0.5  (F14, bin <= 0)  left -> 31, right -> 32
node(48,30,14,0).
left_node(48,30,31).
right_node(48,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(48,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(48,32,1).
% node 33 (leaf): class 0 (0)
leaf_class(48,33,0).
% node 34 (leaf): class 0 (0)
leaf_class(48,34,0).

% Tree 49
tree(49).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 22
node(49,0,14,0).
left_node(49,0,1).
right_node(49,0,22).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(49,1,6,0).
left_node(49,1,2).
right_node(49,1,15).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(49,2,9,0).
left_node(49,2,3).
right_node(49,2,10).
% node 3: TP53 <= 0.5  (F4, bin <= 0)  left -> 4, right -> 7
node(49,3,4,0).
left_node(49,3,4).
right_node(49,3,7).
% node 4: Age_at_diagnosis <= 49.279998779296875  (F1, bin <= 96)  left -> 5, right -> 6
node(49,4,1,96).
left_node(49,4,5).
right_node(49,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(49,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(49,6,1).
% node 7: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 8, right -> 9
node(49,7,18,0).
left_node(49,7,8).
right_node(49,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(49,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(49,9,0).
% node 10: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 11, right -> 14
node(49,10,19,0).
left_node(49,10,11).
right_node(49,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(49,11,0,0).
left_node(49,11,12).
right_node(49,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(49,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(49,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(49,14,1).
% node 15: CIC <= 0.5  (F8, bin <= 0)  left -> 16, right -> 21
node(49,15,8,0).
left_node(49,15,16).
right_node(49,15,21).
% node 16: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 17, right -> 20
node(49,16,12,0).
left_node(49,16,17).
right_node(49,16,20).
% node 17: MUC16 <= 0.5  (F9, bin <= 0)  left -> 18, right -> 19
node(49,17,9,0).
left_node(49,17,18).
right_node(49,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(49,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(49,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(49,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(49,21,0).
% node 22: IDH1 <= 0.5  (F3, bin <= 0)  left -> 23, right -> 30
node(49,22,3,0).
left_node(49,22,23).
right_node(49,22,30).
% node 23: FAT4 <= 0.5  (F21, bin <= 0)  left -> 24, right -> 27
node(49,23,21,0).
left_node(49,23,24).
right_node(49,23,27).
% node 24: Race <= 0.5  (F2, bin <= 0)  left -> 25, right -> 26
node(49,24,2,0).
left_node(49,24,25).
right_node(49,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(49,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(49,26,0).
% node 27: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 28, right -> 29
node(49,27,15,0).
left_node(49,27,28).
right_node(49,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(49,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(49,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(49,30,0).

% Tree 50
tree(50).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 14
node(50,0,3,0).
left_node(50,0,1).
right_node(50,0,14).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 13
node(50,1,8,0).
left_node(50,1,2).
right_node(50,1,13).
% node 2: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 3, right -> 10
node(50,2,17,0).
left_node(50,2,3).
right_node(50,2,10).
% node 3: PTEN <= 0.5  (F6, bin <= 0)  left -> 4, right -> 7
node(50,3,6,0).
left_node(50,3,4).
right_node(50,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(50,4,20,0).
left_node(50,4,5).
right_node(50,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(50,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(50,6,0).
% node 7: Age_at_diagnosis <= 64.06000137329102  (F1, bin <= 138)  left -> 8, right -> 9
node(50,7,1,138).
left_node(50,7,8).
right_node(50,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(50,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(50,9,1).
% node 10: FAT4 <= 0.5  (F21, bin <= 0)  left -> 11, right -> 12
node(50,10,21,0).
left_node(50,10,11).
right_node(50,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(50,11,1).
% node 12 (leaf): class 0 (0)
leaf_class(50,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(50,13,0).
% node 14: FAT4 <= 0.5  (F21, bin <= 0)  left -> 15, right -> 24
node(50,14,21,0).
left_node(50,14,15).
right_node(50,14,24).
% node 15: TP53 <= 0.5  (F4, bin <= 0)  left -> 16, right -> 17
node(50,15,4,0).
left_node(50,15,16).
right_node(50,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(50,16,0).
% node 17: CIC <= 0.5  (F8, bin <= 0)  left -> 18, right -> 21
node(50,17,8,0).
left_node(50,17,18).
right_node(50,17,21).
% node 18: Gender <= 0.5  (F0, bin <= 0)  left -> 19, right -> 20
node(50,18,0,0).
left_node(50,18,19).
right_node(50,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(50,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(50,20,0).
% node 21: MUC16 <= 0.5  (F9, bin <= 0)  left -> 22, right -> 23
node(50,21,9,0).
left_node(50,21,22).
right_node(50,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(50,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(50,23,0).
% node 24: MUC16 <= 0.5  (F9, bin <= 0)  left -> 25, right -> 26
node(50,24,9,0).
left_node(50,24,25).
right_node(50,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(50,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(50,26,0).

% Tree 51
tree(51).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 24
node(51,0,8,0).
left_node(51,0,1).
right_node(51,0,24).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 15
node(51,1,4,0).
left_node(51,1,2).
right_node(51,1,15).
% node 2: ATRX <= 0.5  (F5, bin <= 0)  left -> 3, right -> 10
node(51,2,5,0).
left_node(51,2,3).
right_node(51,2,10).
% node 3: PTEN <= 0.5  (F6, bin <= 0)  left -> 4, right -> 7
node(51,3,6,0).
left_node(51,3,4).
right_node(51,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(51,4,20,0).
left_node(51,4,5).
right_node(51,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(51,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(51,6,0).
% node 7: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 8, right -> 9
node(51,7,12,0).
left_node(51,7,8).
right_node(51,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(51,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(51,9,1).
% node 10: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 11, right -> 14
node(51,10,12,0).
left_node(51,10,11).
right_node(51,10,14).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(51,11,3,0).
left_node(51,11,12).
right_node(51,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(51,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(51,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(51,14,1).
% node 15: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 16, right -> 23
node(51,15,15,0).
left_node(51,15,16).
right_node(51,15,23).
% node 16: Age_at_diagnosis <= 45.279998779296875  (F1, bin <= 60)  left -> 17, right -> 20
node(51,16,1,60).
left_node(51,16,17).
right_node(51,16,20).
% node 17: NF1 <= 0.5  (F11, bin <= 0)  left -> 18, right -> 19
node(51,17,11,0).
left_node(51,17,18).
right_node(51,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(51,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(51,19,0).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 22
node(51,20,3,0).
left_node(51,20,21).
right_node(51,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(51,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(51,22,0).
% node 23 (leaf): class 0 (0)
leaf_class(51,23,0).
% node 24: EGFR <= 0.5  (F7, bin <= 0)  left -> 25, right -> 26
node(51,24,7,0).
left_node(51,24,25).
right_node(51,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(51,25,0).
% node 26: IDH2 <= 0.5  (F20, bin <= 0)  left -> 27, right -> 28
node(51,26,20,0).
left_node(51,26,27).
right_node(51,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(51,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(51,28,1).

% Tree 52
tree(52).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 18
node(52,0,3,0).
left_node(52,0,1).
right_node(52,0,18).
% node 1: MUC16 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 11
node(52,1,9,0).
left_node(52,1,2).
right_node(52,1,11).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 10
node(52,2,8,0).
left_node(52,2,3).
right_node(52,2,10).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(52,3,7,0).
left_node(52,3,4).
right_node(52,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(52,4,20,0).
left_node(52,4,5).
right_node(52,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(52,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(52,6,0).
% node 7: PTEN <= 0.5  (F6, bin <= 0)  left -> 8, right -> 9
node(52,7,6,0).
left_node(52,7,8).
right_node(52,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(52,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(52,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(52,10,0).
% node 11: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 12, right -> 17
node(52,11,15,0).
left_node(52,11,12).
right_node(52,11,17).
% node 12: RB1 <= 0.5  (F14, bin <= 0)  left -> 13, right -> 16
node(52,12,14,0).
left_node(52,12,13).
right_node(52,12,16).
% node 13: Age_at_diagnosis <= 66.95500183105469  (F1, bin <= 147)  left -> 14, right -> 15
node(52,13,1,147).
left_node(52,13,14).
right_node(52,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(52,14,1).
% node 15 (leaf): class 1 (1)
leaf_class(52,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(52,16,1).
% node 17 (leaf): class 0 (0)
leaf_class(52,17,0).
% node 18: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 19, right -> 30
node(52,18,12,0).
left_node(52,18,19).
right_node(52,18,30).
% node 19: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 20, right -> 27
node(52,19,22,0).
left_node(52,19,20).
right_node(52,19,27).
% node 20: ATRX <= 0.5  (F5, bin <= 0)  left -> 21, right -> 24
node(52,20,5,0).
left_node(52,20,21).
right_node(52,20,24).
% node 21: CIC <= 0.5  (F8, bin <= 0)  left -> 22, right -> 23
node(52,21,8,0).
left_node(52,21,22).
right_node(52,21,23).
% node 22 (leaf): class 0 (0)
leaf_class(52,22,0).
% node 23 (leaf): class 0 (0)
leaf_class(52,23,0).
% node 24: MUC16 <= 0.5  (F9, bin <= 0)  left -> 25, right -> 26
node(52,24,9,0).
left_node(52,24,25).
right_node(52,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(52,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(52,26,0).
% node 27: TP53 <= 0.5  (F4, bin <= 0)  left -> 28, right -> 29
node(52,27,4,0).
left_node(52,27,28).
right_node(52,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(52,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(52,29,1).
% node 30: Gender <= 0.5  (F0, bin <= 0)  left -> 31, right -> 36
node(52,30,0,0).
left_node(52,30,31).
right_node(52,30,36).
% node 31: CIC <= 0.5  (F8, bin <= 0)  left -> 32, right -> 35
node(52,31,8,0).
left_node(52,31,32).
right_node(52,31,35).
% node 32: EGFR <= 0.5  (F7, bin <= 0)  left -> 33, right -> 34
node(52,32,7,0).
left_node(52,32,33).
right_node(52,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(52,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(52,34,1).
% node 35 (leaf): class 0 (0)
leaf_class(52,35,0).
% node 36 (leaf): class 0 (0)
leaf_class(52,36,0).

% Tree 53
tree(53).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 12
node(53,0,3,0).
left_node(53,0,1).
right_node(53,0,12).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 11
node(53,1,8,0).
left_node(53,1,2).
right_node(53,1,11).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 10
node(53,2,19,0).
left_node(53,2,3).
right_node(53,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(53,3,14,0).
left_node(53,3,4).
right_node(53,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(53,4,5,0).
left_node(53,4,5).
right_node(53,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(53,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(53,6,0).
% node 7: Age_at_diagnosis <= 39.33500099182129  (F1, bin <= 39)  left -> 8, right -> 9
node(53,7,1,39).
left_node(53,7,8).
right_node(53,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(53,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(53,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(53,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(53,11,0).
% node 12: EGFR <= 0.5  (F7, bin <= 0)  left -> 13, right -> 22
node(53,12,7,0).
left_node(53,12,13).
right_node(53,12,22).
% node 13: TP53 <= 0.5  (F4, bin <= 0)  left -> 14, right -> 15
node(53,13,4,0).
left_node(53,13,14).
right_node(53,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(53,14,0).
% node 15: BCOR <= 0.5  (F16, bin <= 0)  left -> 16, right -> 19
node(53,15,16,0).
left_node(53,15,16).
right_node(53,15,19).
% node 16: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 17, right -> 18
node(53,16,10,0).
left_node(53,16,17).
right_node(53,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(53,17,0).
% node 18 (leaf): class 0 (0)
leaf_class(53,18,0).
% node 19: Race <= 0.5  (F2, bin <= 0)  left -> 20, right -> 21
node(53,19,2,0).
left_node(53,19,20).
right_node(53,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(53,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(53,21,0).
% node 22 (leaf): class 1 (1)
leaf_class(53,22,1).

% Tree 54
tree(54).
% node 0: Race <= 0.5  (F2, bin <= 0)  left -> 1, right -> 20
node(54,0,2,0).
left_node(54,0,1).
right_node(54,0,20).
% node 1: MUC16 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 13
node(54,1,9,0).
left_node(54,1,2).
right_node(54,1,13).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 8
node(54,2,3,0).
left_node(54,2,3).
right_node(54,2,8).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(54,3,14,0).
left_node(54,3,4).
right_node(54,3,7).
% node 4: CIC <= 0.5  (F8, bin <= 0)  left -> 5, right -> 6
node(54,4,8,0).
left_node(54,4,5).
right_node(54,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(54,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(54,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(54,7,1).
% node 8: TP53 <= 0.5  (F4, bin <= 0)  left -> 9, right -> 10
node(54,8,4,0).
left_node(54,8,9).
right_node(54,8,10).
% node 9 (leaf): class 0 (0)
leaf_class(54,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 12
node(54,10,8,0).
left_node(54,10,11).
right_node(54,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(54,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(54,12,0).
% node 13: IDH1 <= 0.5  (F3, bin <= 0)  left -> 14, right -> 19
node(54,13,3,0).
left_node(54,13,14).
right_node(54,13,19).
% node 14: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 15, right -> 18
node(54,14,15,0).
left_node(54,14,15).
right_node(54,14,18).
% node 15: Gender <= 0.5  (F0, bin <= 0)  left -> 16, right -> 17
node(54,15,0,0).
left_node(54,15,16).
right_node(54,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(54,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(54,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(54,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(54,19,0).
% node 20: IDH1 <= 0.5  (F3, bin <= 0)  left -> 21, right -> 30
node(54,20,3,0).
left_node(54,20,21).
right_node(54,20,30).
% node 21: Race <= 1.5  (F2, bin <= 1)  left -> 22, right -> 27
node(54,21,2,1).
left_node(54,21,22).
right_node(54,21,27).
% node 22: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 23, right -> 26
node(54,22,19,0).
left_node(54,22,23).
right_node(54,22,26).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 25
node(54,23,6,0).
left_node(54,23,24).
right_node(54,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(54,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(54,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(54,26,1).
% node 27: Age_at_diagnosis <= 57.85499954223633  (F1, bin <= 121)  left -> 28, right -> 29
node(54,27,1,121).
left_node(54,27,28).
right_node(54,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(54,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(54,29,1).
% node 30: Age_at_diagnosis <= 32.040000915527344  (F1, bin <= 20)  left -> 31, right -> 32
node(54,30,1,20).
left_node(54,30,31).
right_node(54,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(54,31,1).
% node 32: TP53 <= 0.5  (F4, bin <= 0)  left -> 33, right -> 34
node(54,32,4,0).
left_node(54,32,33).
right_node(54,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(54,33,0).
% node 34: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 35, right -> 36
node(54,34,10,0).
left_node(54,34,35).
right_node(54,34,36).
% node 35 (leaf): class 0 (0)
leaf_class(54,35,0).
% node 36 (leaf): class 0 (0)
leaf_class(54,36,0).

% Tree 55
tree(55).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 22
node(55,0,19,0).
left_node(55,0,1).
right_node(55,0,22).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 9
node(55,1,5,0).
left_node(55,1,2).
right_node(55,1,9).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 8
node(55,2,15,0).
left_node(55,2,3).
right_node(55,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(55,3,20,0).
left_node(55,3,4).
right_node(55,3,7).
% node 4: Age_at_diagnosis <= 46.630001068115234  (F1, bin <= 75)  left -> 5, right -> 6
node(55,4,1,75).
left_node(55,4,5).
right_node(55,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(55,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(55,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(55,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(55,8,0).
% node 9: IDH1 <= 0.5  (F3, bin <= 0)  left -> 10, right -> 15
node(55,9,3,0).
left_node(55,9,10).
right_node(55,9,15).
% node 10: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 11, right -> 14
node(55,10,22,0).
left_node(55,10,11).
right_node(55,10,14).
% node 11: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 12, right -> 13
node(55,11,12,0).
left_node(55,11,12).
right_node(55,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(55,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(55,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(55,14,0).
% node 15: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 16, right -> 19
node(55,15,10,0).
left_node(55,15,16).
right_node(55,15,19).
% node 16: Race <= 1.5  (F2, bin <= 1)  left -> 17, right -> 18
node(55,16,2,1).
left_node(55,16,17).
right_node(55,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(55,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(55,18,1).
% node 19: Age_at_diagnosis <= 28.954999923706055  (F1, bin <= 13)  left -> 20, right -> 21
node(55,19,1,13).
left_node(55,19,20).
right_node(55,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(55,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(55,21,0).
% node 22: Race <= 0.5  (F2, bin <= 0)  left -> 23, right -> 26
node(55,22,2,0).
left_node(55,22,23).
right_node(55,22,26).
% node 23: IDH1 <= 0.5  (F3, bin <= 0)  left -> 24, right -> 25
node(55,23,3,0).
left_node(55,23,24).
right_node(55,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(55,24,1).
% node 25 (leaf): class 0 (0)
leaf_class(55,25,0).
% node 26 (leaf): class 1 (1)
leaf_class(55,26,1).

% Tree 56
tree(56).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 24
node(56,0,15,0).
left_node(56,0,1).
right_node(56,0,24).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 11
node(56,1,3,0).
left_node(56,1,2).
right_node(56,1,11).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 10
node(56,2,20,0).
left_node(56,2,3).
right_node(56,2,10).
% node 3: TP53 <= 0.5  (F4, bin <= 0)  left -> 4, right -> 7
node(56,3,4,0).
left_node(56,3,4).
right_node(56,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(56,4,7,0).
left_node(56,4,5).
right_node(56,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(56,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(56,6,1).
% node 7: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 8, right -> 9
node(56,7,19,0).
left_node(56,7,8).
right_node(56,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(56,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(56,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(56,10,0).
% node 11: ATRX <= 0.5  (F5, bin <= 0)  left -> 12, right -> 17
node(56,11,5,0).
left_node(56,11,12).
right_node(56,11,17).
% node 12: Age_at_diagnosis <= 52.61000061035156  (F1, bin <= 109)  left -> 13, right -> 14
node(56,12,1,109).
left_node(56,12,13).
right_node(56,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(56,13,0).
% node 14: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 15, right -> 16
node(56,14,13,0).
left_node(56,14,15).
right_node(56,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(56,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(56,16,0).
% node 17: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 18, right -> 21
node(56,17,12,0).
left_node(56,17,18).
right_node(56,17,21).
% node 18: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 19, right -> 20
node(56,18,10,0).
left_node(56,18,19).
right_node(56,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(56,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(56,20,0).
% node 21: FAT4 <= 0.5  (F21, bin <= 0)  left -> 22, right -> 23
node(56,21,21,0).
left_node(56,21,22).
right_node(56,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(56,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(56,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(56,24,0).

% Tree 57
tree(57).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 24
node(57,0,6,0).
left_node(57,0,1).
right_node(57,0,24).
% node 1: Age_at_diagnosis <= 55.40999984741211  (F1, bin <= 119)  left -> 2, right -> 15
node(57,1,1,119).
left_node(57,1,2).
right_node(57,1,15).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(57,2,7,0).
left_node(57,2,3).
right_node(57,2,10).
% node 3: Race <= 0.5  (F2, bin <= 0)  left -> 4, right -> 7
node(57,3,2,0).
left_node(57,3,4).
right_node(57,3,7).
% node 4: Age_at_diagnosis <= 44.125  (F1, bin <= 54)  left -> 5, right -> 6
node(57,4,1,54).
left_node(57,4,5).
right_node(57,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(57,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(57,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(57,7,3,0).
left_node(57,7,8).
right_node(57,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(57,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(57,9,0).
% node 10: NF1 <= 0.5  (F11, bin <= 0)  left -> 11, right -> 14
node(57,10,11,0).
left_node(57,10,11).
right_node(57,10,14).
% node 11: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 12, right -> 13
node(57,11,19,0).
left_node(57,11,12).
right_node(57,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(57,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(57,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(57,14,1).
% node 15: Age_at_diagnosis <= 74.56500244140625  (F1, bin <= 167)  left -> 16, right -> 21
node(57,15,1,167).
left_node(57,15,16).
right_node(57,15,21).
% node 16: CIC <= 0.5  (F8, bin <= 0)  left -> 17, right -> 20
node(57,16,8,0).
left_node(57,16,17).
right_node(57,16,20).
% node 17: Age_at_diagnosis <= 70.38000106811523  (F1, bin <= 154)  left -> 18, right -> 19
node(57,17,1,154).
left_node(57,17,18).
right_node(57,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(57,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(57,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(57,20,0).
% node 21: CIC <= 0.5  (F8, bin <= 0)  left -> 22, right -> 23
node(57,21,8,0).
left_node(57,21,22).
right_node(57,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(57,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(57,23,0).
% node 24: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 25, right -> 36
node(57,24,18,0).
left_node(57,24,25).
right_node(57,24,36).
% node 25: BCOR <= 0.5  (F16, bin <= 0)  left -> 26, right -> 31
node(57,25,16,0).
left_node(57,25,26).
right_node(57,25,31).
% node 26: CIC <= 0.5  (F8, bin <= 0)  left -> 27, right -> 30
node(57,26,8,0).
left_node(57,26,27).
right_node(57,26,30).
% node 27: Gender <= 0.5  (F0, bin <= 0)  left -> 28, right -> 29
node(57,27,0,0).
left_node(57,27,28).
right_node(57,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(57,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(57,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(57,30,0).
% node 31: Race <= 0.5  (F2, bin <= 0)  left -> 32, right -> 35
node(57,31,2,0).
left_node(57,31,32).
right_node(57,31,35).
% node 32: ATRX <= 0.5  (F5, bin <= 0)  left -> 33, right -> 34
node(57,32,5,0).
left_node(57,32,33).
right_node(57,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(57,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(57,34,0).
% node 35 (leaf): class 1 (1)
leaf_class(57,35,1).
% node 36: FAT4 <= 0.5  (F21, bin <= 0)  left -> 37, right -> 40
node(57,36,21,0).
left_node(57,36,37).
right_node(57,36,40).
% node 37: ATRX <= 0.5  (F5, bin <= 0)  left -> 38, right -> 39
node(57,37,5,0).
left_node(57,37,38).
right_node(57,37,39).
% node 38 (leaf): class 0 (0)
leaf_class(57,38,0).
% node 39 (leaf): class 1 (1)
leaf_class(57,39,1).
% node 40 (leaf): class 0 (0)
leaf_class(57,40,0).

% Tree 58
tree(58).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 22
node(58,0,3,0).
left_node(58,0,1).
right_node(58,0,22).
% node 1: Age_at_diagnosis <= 67.31000137329102  (F1, bin <= 148)  left -> 2, right -> 15
node(58,1,1,148).
left_node(58,1,2).
right_node(58,1,15).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 10
node(58,2,9,0).
left_node(58,2,3).
right_node(58,2,10).
% node 3: Age_at_diagnosis <= 48.67499923706055  (F1, bin <= 86)  left -> 4, right -> 7
node(58,3,1,86).
left_node(58,3,4).
right_node(58,3,7).
% node 4: TP53 <= 0.5  (F4, bin <= 0)  left -> 5, right -> 6
node(58,4,4,0).
left_node(58,4,5).
right_node(58,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(58,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(58,6,0).
% node 7: Race <= 0.5  (F2, bin <= 0)  left -> 8, right -> 9
node(58,7,2,0).
left_node(58,7,8).
right_node(58,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(58,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(58,9,0).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 14
node(58,10,8,0).
left_node(58,10,11).
right_node(58,10,14).
% node 11: PTEN <= 0.5  (F6, bin <= 0)  left -> 12, right -> 13
node(58,11,6,0).
left_node(58,11,12).
right_node(58,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(58,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(58,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(58,14,0).
% node 15: TP53 <= 0.5  (F4, bin <= 0)  left -> 16, right -> 21
node(58,15,4,0).
left_node(58,15,16).
right_node(58,15,21).
% node 16: Age_at_diagnosis <= 71.72999954223633  (F1, bin <= 159)  left -> 17, right -> 20
node(58,16,1,159).
left_node(58,16,17).
right_node(58,16,20).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(58,17,2,0).
left_node(58,17,18).
right_node(58,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(58,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(58,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(58,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(58,21,1).
% node 22: ATRX <= 0.5  (F5, bin <= 0)  left -> 23, right -> 30
node(58,22,5,0).
left_node(58,22,23).
right_node(58,22,30).
% node 23: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 24, right -> 29
node(58,23,15,0).
left_node(58,23,24).
right_node(58,23,29).
% node 24: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 25, right -> 28
node(58,24,13,0).
left_node(58,24,25).
right_node(58,24,28).
% node 25: MUC16 <= 0.5  (F9, bin <= 0)  left -> 26, right -> 27
node(58,25,9,0).
left_node(58,25,26).
right_node(58,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(58,26,0).
% node 27 (leaf): class 0 (0)
leaf_class(58,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(58,28,0).
% node 29 (leaf): class 0 (0)
leaf_class(58,29,0).
% node 30: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 31, right -> 38
node(58,30,22,0).
left_node(58,30,31).
right_node(58,30,38).
% node 31: Race <= 0.5  (F2, bin <= 0)  left -> 32, right -> 35
node(58,31,2,0).
left_node(58,31,32).
right_node(58,31,35).
% node 32: EGFR <= 0.5  (F7, bin <= 0)  left -> 33, right -> 34
node(58,32,7,0).
left_node(58,32,33).
right_node(58,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(58,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(58,34,1).
% node 35: Age_at_diagnosis <= 40.380001068115234  (F1, bin <= 42)  left -> 36, right -> 37
node(58,35,1,42).
left_node(58,35,36).
right_node(58,35,37).
% node 36 (leaf): class 0 (0)
leaf_class(58,36,0).
% node 37 (leaf): class 1 (1)
leaf_class(58,37,1).
% node 38: Age_at_diagnosis <= 32.489999771118164  (F1, bin <= 21)  left -> 39, right -> 40
node(58,38,1,21).
left_node(58,38,39).
right_node(58,38,40).
% node 39 (leaf): class 1 (1)
leaf_class(58,39,1).
% node 40 (leaf): class 0 (0)
leaf_class(58,40,0).

% Tree 59
tree(59).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 22
node(59,0,6,0).
left_node(59,0,1).
right_node(59,0,22).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 11
node(59,1,5,0).
left_node(59,1,2).
right_node(59,1,11).
% node 2: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 3, right -> 10
node(59,2,13,0).
left_node(59,2,3).
right_node(59,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(59,3,3,0).
left_node(59,3,4).
right_node(59,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(59,4,20,0).
left_node(59,4,5).
right_node(59,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(59,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(59,6,0).
% node 7: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 8, right -> 9
node(59,7,15,0).
left_node(59,7,8).
right_node(59,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(59,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(59,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(59,10,0).
% node 11: Age_at_diagnosis <= 22.315000534057617  (F1, bin <= 1)  left -> 12, right -> 15
node(59,11,1,1).
left_node(59,11,12).
right_node(59,11,15).
% node 12: Age_at_diagnosis <= 21.315000534057617  (F1, bin <= 0)  left -> 13, right -> 14
node(59,12,1,0).
left_node(59,12,13).
right_node(59,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(59,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(59,14,1).
% node 15: Gender <= 0.5  (F0, bin <= 0)  left -> 16, right -> 19
node(59,15,0,0).
left_node(59,15,16).
right_node(59,15,19).
% node 16: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 17, right -> 18
node(59,16,15,0).
left_node(59,16,17).
right_node(59,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(59,17,0).
% node 18 (leaf): class 0 (0)
leaf_class(59,18,0).
% node 19: Age_at_diagnosis <= 35.27000045776367  (F1, bin <= 27)  left -> 20, right -> 21
node(59,19,1,27).
left_node(59,19,20).
right_node(59,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(59,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(59,21,0).
% node 22: IDH1 <= 0.5  (F3, bin <= 0)  left -> 23, right -> 32
node(59,22,3,0).
left_node(59,22,23).
right_node(59,22,32).
% node 23: TP53 <= 0.5  (F4, bin <= 0)  left -> 24, right -> 31
node(59,23,4,0).
left_node(59,23,24).
right_node(59,23,31).
% node 24: Age_at_diagnosis <= 53.39999961853027  (F1, bin <= 118)  left -> 25, right -> 28
node(59,24,1,118).
left_node(59,24,25).
right_node(59,24,28).
% node 25: FAT4 <= 0.5  (F21, bin <= 0)  left -> 26, right -> 27
node(59,25,21,0).
left_node(59,25,26).
right_node(59,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(59,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(59,27,0).
% node 28: MUC16 <= 0.5  (F9, bin <= 0)  left -> 29, right -> 30
node(59,28,9,0).
left_node(59,28,29).
right_node(59,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(59,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(59,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(59,31,1).
% node 32: ATRX <= 0.5  (F5, bin <= 0)  left -> 33, right -> 34
node(59,32,5,0).
left_node(59,32,33).
right_node(59,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(59,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(59,34,1).

% Tree 60
tree(60).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 24
node(60,0,8,0).
left_node(60,0,1).
right_node(60,0,24).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 11
node(60,1,3,0).
left_node(60,1,2).
right_node(60,1,11).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 10
node(60,2,19,0).
left_node(60,2,3).
right_node(60,2,10).
% node 3: Age_at_diagnosis <= 67.31000137329102  (F1, bin <= 148)  left -> 4, right -> 7
node(60,3,1,148).
left_node(60,3,4).
right_node(60,3,7).
% node 4: TP53 <= 0.5  (F4, bin <= 0)  left -> 5, right -> 6
node(60,4,4,0).
left_node(60,4,5).
right_node(60,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(60,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(60,6,1).
% node 7: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 8, right -> 9
node(60,7,12,0).
left_node(60,7,8).
right_node(60,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(60,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(60,9,1).
% node 10 (leaf): class 1 (1)
leaf_class(60,10,1).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 19
node(60,11,0,0).
left_node(60,11,12).
right_node(60,11,19).
% node 12: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 13, right -> 16
node(60,12,12,0).
left_node(60,12,13).
right_node(60,12,16).
% node 13: Race <= 0.5  (F2, bin <= 0)  left -> 14, right -> 15
node(60,13,2,0).
left_node(60,13,14).
right_node(60,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(60,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(60,15,0).
% node 16: Age_at_diagnosis <= 36.054999351501465  (F1, bin <= 30)  left -> 17, right -> 18
node(60,16,1,30).
left_node(60,16,17).
right_node(60,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(60,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(60,18,0).
% node 19: TP53 <= 0.5  (F4, bin <= 0)  left -> 20, right -> 21
node(60,19,4,0).
left_node(60,19,20).
right_node(60,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(60,20,0).
% node 21: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 22, right -> 23
node(60,21,18,0).
left_node(60,21,22).
right_node(60,21,23).
% node 22 (leaf): class 0 (0)
leaf_class(60,22,0).
% node 23 (leaf): class 0 (0)
leaf_class(60,23,0).
% node 24: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 25, right -> 32
node(60,24,12,0).
left_node(60,24,25).
right_node(60,24,32).
% node 25: TP53 <= 0.5  (F4, bin <= 0)  left -> 26, right -> 27
node(60,25,4,0).
left_node(60,25,26).
right_node(60,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(60,26,0).
% node 27: FAT4 <= 0.5  (F21, bin <= 0)  left -> 28, right -> 31
node(60,27,21,0).
left_node(60,27,28).
right_node(60,27,31).
% node 28: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 29, right -> 30
node(60,28,13,0).
left_node(60,28,29).
right_node(60,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(60,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(60,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(60,31,0).
% node 32: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 33, right -> 34
node(60,32,17,0).
left_node(60,32,33).
right_node(60,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(60,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(60,34,1).

% Tree 61
tree(61).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 16
node(61,0,6,0).
left_node(61,0,1).
right_node(61,0,16).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(61,1,3,0).
left_node(61,1,2).
right_node(61,1,9).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 8
node(61,2,15,0).
left_node(61,2,3).
right_node(61,2,8).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(61,3,9,0).
left_node(61,3,4).
right_node(61,3,7).
% node 4: BCOR <= 0.5  (F16, bin <= 0)  left -> 5, right -> 6
node(61,4,16,0).
left_node(61,4,5).
right_node(61,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(61,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(61,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(61,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(61,8,0).
% node 9: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 10, right -> 15
node(61,9,13,0).
left_node(61,9,10).
right_node(61,9,15).
% node 10: CIC <= 0.5  (F8, bin <= 0)  left -> 11, right -> 14
node(61,10,8,0).
left_node(61,10,11).
right_node(61,10,14).
% node 11: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 12, right -> 13
node(61,11,18,0).
left_node(61,11,12).
right_node(61,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(61,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(61,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(61,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(61,15,0).
% node 16: Age_at_diagnosis <= 50.64000129699707  (F1, bin <= 100)  left -> 17, right -> 24
node(61,16,1,100).
left_node(61,16,17).
right_node(61,16,24).
% node 17: IDH1 <= 0.5  (F3, bin <= 0)  left -> 18, right -> 23
node(61,17,3,0).
left_node(61,17,18).
right_node(61,17,23).
% node 18: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 19, right -> 22
node(61,18,13,0).
left_node(61,18,19).
right_node(61,18,22).
% node 19: IDH2 <= 0.5  (F20, bin <= 0)  left -> 20, right -> 21
node(61,19,20,0).
left_node(61,19,20).
right_node(61,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(61,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(61,21,1).
% node 22 (leaf): class 1 (1)
leaf_class(61,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(61,23,0).
% node 24: Gender <= 0.5  (F0, bin <= 0)  left -> 25, right -> 30
node(61,24,0,0).
left_node(61,24,25).
right_node(61,24,30).
% node 25: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 26, right -> 29
node(61,25,12,0).
left_node(61,25,26).
right_node(61,25,29).
% node 26: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 27, right -> 28
node(61,26,19,0).
left_node(61,26,27).
right_node(61,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(61,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(61,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(61,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(61,30,1).

% Tree 62
tree(62).
% node 0: EGFR <= 0.5  (F7, bin <= 0)  left -> 1, right -> 28
node(62,0,7,0).
left_node(62,0,1).
right_node(62,0,28).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 15
node(62,1,5,0).
left_node(62,1,2).
right_node(62,1,15).
% node 2: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 3, right -> 10
node(62,2,22,0).
left_node(62,2,3).
right_node(62,2,10).
% node 3: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 4, right -> 7
node(62,3,13,0).
left_node(62,3,4).
right_node(62,3,7).
% node 4: BCOR <= 0.5  (F16, bin <= 0)  left -> 5, right -> 6
node(62,4,16,0).
left_node(62,4,5).
right_node(62,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(62,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(62,6,0).
% node 7: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 8, right -> 9
node(62,7,19,0).
left_node(62,7,8).
right_node(62,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(62,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(62,9,1).
% node 10: TP53 <= 0.5  (F4, bin <= 0)  left -> 11, right -> 14
node(62,10,4,0).
left_node(62,10,11).
right_node(62,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(62,11,0,0).
left_node(62,11,12).
right_node(62,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(62,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(62,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(62,14,1).
% node 15: PTEN <= 0.5  (F6, bin <= 0)  left -> 16, right -> 23
node(62,15,6,0).
left_node(62,15,16).
right_node(62,15,23).
% node 16: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 17, right -> 20
node(62,16,12,0).
left_node(62,16,17).
right_node(62,16,20).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(62,17,2,0).
left_node(62,17,18).
right_node(62,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(62,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(62,19,0).
% node 20: Gender <= 0.5  (F0, bin <= 0)  left -> 21, right -> 22
node(62,20,0,0).
left_node(62,20,21).
right_node(62,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(62,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(62,22,0).
% node 23: Gender <= 0.5  (F0, bin <= 0)  left -> 24, right -> 27
node(62,23,0,0).
left_node(62,23,24).
right_node(62,23,27).
% node 24: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 25, right -> 26
node(62,24,19,0).
left_node(62,24,25).
right_node(62,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(62,25,0).
% node 26 (leaf): class 1 (1)
leaf_class(62,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(62,27,1).
% node 28: TP53 <= 0.5  (F4, bin <= 0)  left -> 29, right -> 40
node(62,28,4,0).
left_node(62,28,29).
right_node(62,28,40).
% node 29: Gender <= 0.5  (F0, bin <= 0)  left -> 30, right -> 35
node(62,29,0,0).
left_node(62,29,30).
right_node(62,29,35).
% node 30: NF1 <= 0.5  (F11, bin <= 0)  left -> 31, right -> 34
node(62,30,11,0).
left_node(62,30,31).
right_node(62,30,34).
% node 31: Race <= 0.5  (F2, bin <= 0)  left -> 32, right -> 33
node(62,31,2,0).
left_node(62,31,32).
right_node(62,31,33).
% node 32 (leaf): class 1 (1)
leaf_class(62,32,1).
% node 33 (leaf): class 1 (1)
leaf_class(62,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(62,34,0).
% node 35: Age_at_diagnosis <= 47.579999923706055  (F1, bin <= 81)  left -> 36, right -> 37
node(62,35,1,81).
left_node(62,35,36).
right_node(62,35,37).
% node 36 (leaf): class 0 (0)
leaf_class(62,36,0).
% node 37: Race <= 0.5  (F2, bin <= 0)  left -> 38, right -> 39
node(62,37,2,0).
left_node(62,37,38).
right_node(62,37,39).
% node 38 (leaf): class 0 (0)
leaf_class(62,38,0).
% node 39 (leaf): class 1 (1)
leaf_class(62,39,1).
% node 40: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 41, right -> 42
node(62,40,10,0).
left_node(62,40,41).
right_node(62,40,42).
% node 41 (leaf): class 1 (1)
leaf_class(62,41,1).
% node 42: BCOR <= 0.5  (F16, bin <= 0)  left -> 43, right -> 44
node(62,42,16,0).
left_node(62,42,43).
right_node(62,42,44).
% node 43 (leaf): class 0 (0)
leaf_class(62,43,0).
% node 44 (leaf): class 1 (1)
leaf_class(62,44,1).

% Tree 63
tree(63).
% node 0: TP53 <= 0.5  (F4, bin <= 0)  left -> 1, right -> 16
node(63,0,4,0).
left_node(63,0,1).
right_node(63,0,16).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(63,1,3,0).
left_node(63,1,2).
right_node(63,1,9).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(63,2,20,0).
left_node(63,2,3).
right_node(63,2,8).
% node 3: Age_at_diagnosis <= 32.584999084472656  (F1, bin <= 22)  left -> 4, right -> 5
node(63,3,1,22).
left_node(63,3,4).
right_node(63,3,5).
% node 4 (leaf): class 0 (0)
leaf_class(63,4,0).
% node 5: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 6, right -> 7
node(63,5,12,0).
left_node(63,5,6).
right_node(63,5,7).
% node 6 (leaf): class 1 (1)
leaf_class(63,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(63,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(63,8,0).
% node 9: CIC <= 0.5  (F8, bin <= 0)  left -> 10, right -> 15
node(63,9,8,0).
left_node(63,9,10).
right_node(63,9,15).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 14
node(63,10,0,0).
left_node(63,10,11).
right_node(63,10,14).
% node 11: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 12, right -> 13
node(63,11,15,0).
left_node(63,11,12).
right_node(63,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(63,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(63,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(63,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(63,15,0).
% node 16: IDH1 <= 0.5  (F3, bin <= 0)  left -> 17, right -> 26
node(63,16,3,0).
left_node(63,16,17).
right_node(63,16,26).
% node 17: RB1 <= 0.5  (F14, bin <= 0)  left -> 18, right -> 25
node(63,17,14,0).
left_node(63,17,18).
right_node(63,17,25).
% node 18: IDH2 <= 0.5  (F20, bin <= 0)  left -> 19, right -> 22
node(63,18,20,0).
left_node(63,18,19).
right_node(63,18,22).
% node 19: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 20, right -> 21
node(63,19,17,0).
left_node(63,19,20).
right_node(63,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(63,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(63,21,1).
% node 22: PTEN <= 0.5  (F6, bin <= 0)  left -> 23, right -> 24
node(63,22,6,0).
left_node(63,22,23).
right_node(63,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(63,23,0).
% node 24 (leaf): class 1 (1)
leaf_class(63,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(63,25,1).
% node 26: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 27, right -> 32
node(63,26,18,0).
left_node(63,26,27).
right_node(63,26,32).
% node 27: MUC16 <= 0.5  (F9, bin <= 0)  left -> 28, right -> 31
node(63,27,9,0).
left_node(63,27,28).
right_node(63,27,31).
% node 28: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 29, right -> 30
node(63,28,19,0).
left_node(63,28,29).
right_node(63,28,30).
% node 29 (leaf): class 0 (0)
leaf_class(63,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(63,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(63,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(63,32,0).

% Tree 64
tree(64).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 22
node(64,0,14,0).
left_node(64,0,1).
right_node(64,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(64,1,3,0).
left_node(64,1,2).
right_node(64,1,13).
% node 2: Age_at_diagnosis <= 48.46999931335449  (F1, bin <= 85)  left -> 3, right -> 8
node(64,2,1,85).
left_node(64,2,3).
right_node(64,2,8).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(64,3,9,0).
left_node(64,3,4).
right_node(64,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(64,4,20,0).
left_node(64,4,5).
right_node(64,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(64,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(64,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(64,7,1).
% node 8: Age_at_diagnosis <= 71.30000305175781  (F1, bin <= 157)  left -> 9, right -> 12
node(64,8,1,157).
left_node(64,8,9).
right_node(64,8,12).
% node 9: NF1 <= 0.5  (F11, bin <= 0)  left -> 10, right -> 11
node(64,9,11,0).
left_node(64,9,10).
right_node(64,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(64,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(64,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(64,12,1).
% node 13: EGFR <= 0.5  (F7, bin <= 0)  left -> 14, right -> 21
node(64,13,7,0).
left_node(64,13,14).
right_node(64,13,21).
% node 14: Race <= 0.5  (F2, bin <= 0)  left -> 15, right -> 18
node(64,14,2,0).
left_node(64,14,15).
right_node(64,14,18).
% node 15: Age_at_diagnosis <= 61.03499984741211  (F1, bin <= 130)  left -> 16, right -> 17
node(64,15,1,130).
left_node(64,15,16).
right_node(64,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(64,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(64,17,0).
% node 18: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 19, right -> 20
node(64,18,15,0).
left_node(64,18,19).
right_node(64,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(64,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(64,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(64,21,1).
% node 22: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 23, right -> 30
node(64,22,13,0).
left_node(64,22,23).
right_node(64,22,30).
% node 23: EGFR <= 0.5  (F7, bin <= 0)  left -> 24, right -> 29
node(64,23,7,0).
left_node(64,23,24).
right_node(64,23,29).
% node 24: Race <= 0.5  (F2, bin <= 0)  left -> 25, right -> 28
node(64,24,2,0).
left_node(64,24,25).
right_node(64,24,28).
% node 25: Gender <= 0.5  (F0, bin <= 0)  left -> 26, right -> 27
node(64,25,0,0).
left_node(64,25,26).
right_node(64,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(64,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(64,27,1).
% node 28 (leaf): class 0 (0)
leaf_class(64,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(64,29,1).
% node 30: Age_at_diagnosis <= 29.255001068115234  (F1, bin <= 14)  left -> 31, right -> 32
node(64,30,1,14).
left_node(64,30,31).
right_node(64,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(64,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(64,32,0).

% Tree 65
tree(65).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 18
node(65,0,3,0).
left_node(65,0,1).
right_node(65,0,18).
% node 1: Race <= 2.5  (F2, bin <= 2)  left -> 2, right -> 17
node(65,1,2,2).
left_node(65,1,2).
right_node(65,1,17).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 10
node(65,2,6,0).
left_node(65,2,3).
right_node(65,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(65,3,14,0).
left_node(65,3,4).
right_node(65,3,7).
% node 4: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 5, right -> 6
node(65,4,15,0).
left_node(65,4,5).
right_node(65,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(65,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(65,6,0).
% node 7: NF1 <= 0.5  (F11, bin <= 0)  left -> 8, right -> 9
node(65,7,11,0).
left_node(65,7,8).
right_node(65,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(65,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(65,9,1).
% node 10: EGFR <= 0.5  (F7, bin <= 0)  left -> 11, right -> 14
node(65,10,7,0).
left_node(65,10,11).
right_node(65,10,14).
% node 11: RB1 <= 0.5  (F14, bin <= 0)  left -> 12, right -> 13
node(65,11,14,0).
left_node(65,11,12).
right_node(65,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(65,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(65,13,1).
% node 14: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 15, right -> 16
node(65,14,15,0).
left_node(65,14,15).
right_node(65,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(65,15,1).
% node 16 (leaf): class 0 (0)
leaf_class(65,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(65,17,0).
% node 18: FAT4 <= 0.5  (F21, bin <= 0)  left -> 19, right -> 30
node(65,18,21,0).
left_node(65,18,19).
right_node(65,18,30).
% node 19: TP53 <= 0.5  (F4, bin <= 0)  left -> 20, right -> 25
node(65,19,4,0).
left_node(65,19,20).
right_node(65,19,25).
% node 20: CIC <= 0.5  (F8, bin <= 0)  left -> 21, right -> 24
node(65,20,8,0).
left_node(65,20,21).
right_node(65,20,24).
% node 21: EGFR <= 0.5  (F7, bin <= 0)  left -> 22, right -> 23
node(65,21,7,0).
left_node(65,21,22).
right_node(65,21,23).
% node 22 (leaf): class 0 (0)
leaf_class(65,22,0).
% node 23 (leaf): class 0 (0)
leaf_class(65,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(65,24,0).
% node 25: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 26, right -> 29
node(65,25,17,0).
left_node(65,25,26).
right_node(65,25,29).
% node 26: ATRX <= 0.5  (F5, bin <= 0)  left -> 27, right -> 28
node(65,26,5,0).
left_node(65,26,27).
right_node(65,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(65,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(65,28,0).
% node 29 (leaf): class 0 (0)
leaf_class(65,29,0).
% node 30: MUC16 <= 0.5  (F9, bin <= 0)  left -> 31, right -> 32
node(65,30,9,0).
left_node(65,30,31).
right_node(65,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(65,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(65,32,0).

% Tree 66
tree(66).
% node 0: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 1, right -> 20
node(66,0,13,0).
left_node(66,0,1).
right_node(66,0,20).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(66,1,3,0).
left_node(66,1,2).
right_node(66,1,9).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(66,2,20,0).
left_node(66,2,3).
right_node(66,2,8).
% node 3: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 4, right -> 7
node(66,3,19,0).
left_node(66,3,4).
right_node(66,3,7).
% node 4: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 5, right -> 6
node(66,4,15,0).
left_node(66,4,5).
right_node(66,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(66,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(66,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(66,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(66,8,0).
% node 9: ATRX <= 0.5  (F5, bin <= 0)  left -> 10, right -> 15
node(66,9,5,0).
left_node(66,9,10).
right_node(66,9,15).
% node 10: RB1 <= 0.5  (F14, bin <= 0)  left -> 11, right -> 14
node(66,10,14,0).
left_node(66,10,11).
right_node(66,10,14).
% node 11: Age_at_diagnosis <= 43.529998779296875  (F1, bin <= 50)  left -> 12, right -> 13
node(66,11,1,50).
left_node(66,11,12).
right_node(66,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(66,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(66,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(66,14,0).
% node 15: Race <= 1.5  (F2, bin <= 1)  left -> 16, right -> 19
node(66,15,2,1).
left_node(66,15,16).
right_node(66,15,19).
% node 16: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 17, right -> 18
node(66,16,10,0).
left_node(66,16,17).
right_node(66,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(66,17,0).
% node 18 (leaf): class 0 (0)
leaf_class(66,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(66,19,1).
% node 20: Age_at_diagnosis <= 28.635000228881836  (F1, bin <= 12)  left -> 21, right -> 22
node(66,20,1,12).
left_node(66,20,21).
right_node(66,20,22).
% node 21 (leaf): class 1 (1)
leaf_class(66,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(66,22,0).

% Tree 67
tree(67).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 14
node(67,0,6,0).
left_node(67,0,1).
right_node(67,0,14).
% node 1: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 2, right -> 13
node(67,1,15,0).
left_node(67,1,2).
right_node(67,1,13).
% node 2: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 3, right -> 8
node(67,2,12,0).
left_node(67,2,3).
right_node(67,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(67,3,20,0).
left_node(67,3,4).
right_node(67,3,7).
% node 4: CIC <= 0.5  (F8, bin <= 0)  left -> 5, right -> 6
node(67,4,8,0).
left_node(67,4,5).
right_node(67,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(67,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(67,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(67,7,0).
% node 8: Age_at_diagnosis <= 63.35000038146973  (F1, bin <= 136)  left -> 9, right -> 12
node(67,8,1,136).
left_node(67,8,9).
right_node(67,8,12).
% node 9: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 10, right -> 11
node(67,9,13,0).
left_node(67,9,10).
right_node(67,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(67,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(67,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(67,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(67,13,0).
% node 14: BCOR <= 0.5  (F16, bin <= 0)  left -> 15, right -> 26
node(67,14,16,0).
left_node(67,14,15).
right_node(67,14,26).
% node 15: Age_at_diagnosis <= 46.71500015258789  (F1, bin <= 77)  left -> 16, right -> 21
node(67,15,1,77).
left_node(67,15,16).
right_node(67,15,21).
% node 16: NF1 <= 0.5  (F11, bin <= 0)  left -> 17, right -> 20
node(67,16,11,0).
left_node(67,16,17).
right_node(67,16,20).
% node 17: EGFR <= 0.5  (F7, bin <= 0)  left -> 18, right -> 19
node(67,17,7,0).
left_node(67,17,18).
right_node(67,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(67,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(67,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(67,20,0).
% node 21: Age_at_diagnosis <= 66.45999908447266  (F1, bin <= 143)  left -> 22, right -> 25
node(67,21,1,143).
left_node(67,21,22).
right_node(67,21,25).
% node 22: EGFR <= 0.5  (F7, bin <= 0)  left -> 23, right -> 24
node(67,22,7,0).
left_node(67,22,23).
right_node(67,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(67,23,1).
% node 24 (leaf): class 1 (1)
leaf_class(67,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(67,25,1).
% node 26: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 27, right -> 30
node(67,26,10,0).
left_node(67,26,27).
right_node(67,26,30).
% node 27: EGFR <= 0.5  (F7, bin <= 0)  left -> 28, right -> 29
node(67,27,7,0).
left_node(67,27,28).
right_node(67,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(67,28,0).
% node 29 (leaf): class 1 (1)
leaf_class(67,29,1).
% node 30 (leaf): class 1 (1)
leaf_class(67,30,1).

% Tree 68
tree(68).
% node 0: Age_at_diagnosis <= 52.43499946594238  (F1, bin <= 105)  left -> 1, right -> 24
node(68,0,1,105).
left_node(68,0,1).
right_node(68,0,24).
% node 1: Age_at_diagnosis <= 45.28999900817871  (F1, bin <= 61)  left -> 2, right -> 15
node(68,1,1,61).
left_node(68,1,2).
right_node(68,1,15).
% node 2: Age_at_diagnosis <= 25.244999885559082  (F1, bin <= 6)  left -> 3, right -> 8
node(68,2,1,6).
left_node(68,2,3).
right_node(68,2,8).
% node 3: Age_at_diagnosis <= 25.214999198913574  (F1, bin <= 5)  left -> 4, right -> 7
node(68,3,1,5).
left_node(68,3,4).
right_node(68,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(68,4,5,0).
left_node(68,4,5).
right_node(68,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(68,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(68,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(68,7,1).
% node 8: Race <= 0.5  (F2, bin <= 0)  left -> 9, right -> 12
node(68,8,2,0).
left_node(68,8,9).
right_node(68,8,12).
% node 9: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 10, right -> 11
node(68,9,13,0).
left_node(68,9,10).
right_node(68,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(68,10,0).
% node 11 (leaf): class 0 (0)
leaf_class(68,11,0).
% node 12: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 13, right -> 14
node(68,12,15,0).
left_node(68,12,13).
right_node(68,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(68,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(68,14,0).
% node 15: IDH1 <= 0.5  (F3, bin <= 0)  left -> 16, right -> 21
node(68,15,3,0).
left_node(68,15,16).
right_node(68,15,21).
% node 16: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 17, right -> 20
node(68,16,18,0).
left_node(68,16,17).
right_node(68,16,20).
% node 17: ATRX <= 0.5  (F5, bin <= 0)  left -> 18, right -> 19
node(68,17,5,0).
left_node(68,17,18).
right_node(68,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(68,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(68,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(68,20,1).
% node 21: Age_at_diagnosis <= 45.989999771118164  (F1, bin <= 69)  left -> 22, right -> 23
node(68,21,1,69).
left_node(68,21,22).
right_node(68,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(68,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(68,23,0).
% node 24: IDH1 <= 0.5  (F3, bin <= 0)  left -> 25, right -> 40
node(68,24,3,0).
left_node(68,24,25).
right_node(68,24,40).
% node 25: NF1 <= 0.5  (F11, bin <= 0)  left -> 26, right -> 33
node(68,25,11,0).
left_node(68,25,26).
right_node(68,25,33).
% node 26: PTEN <= 0.5  (F6, bin <= 0)  left -> 27, right -> 30
node(68,26,6,0).
left_node(68,26,27).
right_node(68,26,30).
% node 27: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 28, right -> 29
node(68,27,17,0).
left_node(68,27,28).
right_node(68,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(68,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(68,29,1).
% node 30: Age_at_diagnosis <= 64.06000137329102  (F1, bin <= 138)  left -> 31, right -> 32
node(68,30,1,138).
left_node(68,30,31).
right_node(68,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(68,31,1).
% node 32 (leaf): class 1 (1)
leaf_class(68,32,1).
% node 33: Gender <= 0.5  (F0, bin <= 0)  left -> 34, right -> 37
node(68,33,0,0).
left_node(68,33,34).
right_node(68,33,37).
% node 34: FAT4 <= 0.5  (F21, bin <= 0)  left -> 35, right -> 36
node(68,34,21,0).
left_node(68,34,35).
right_node(68,34,36).
% node 35 (leaf): class 1 (1)
leaf_class(68,35,1).
% node 36 (leaf): class 1 (1)
leaf_class(68,36,1).
% node 37: MUC16 <= 0.5  (F9, bin <= 0)  left -> 38, right -> 39
node(68,37,9,0).
left_node(68,37,38).
right_node(68,37,39).
% node 38 (leaf): class 1 (1)
leaf_class(68,38,1).
% node 39 (leaf): class 1 (1)
leaf_class(68,39,1).
% node 40: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 41, right -> 46
node(68,40,15,0).
left_node(68,40,41).
right_node(68,40,46).
% node 41: ATRX <= 0.5  (F5, bin <= 0)  left -> 42, right -> 43
node(68,41,5,0).
left_node(68,41,42).
right_node(68,41,43).
% node 42 (leaf): class 0 (0)
leaf_class(68,42,0).
% node 43: Age_at_diagnosis <= 60.09000015258789  (F1, bin <= 127)  left -> 44, right -> 45
node(68,43,1,127).
left_node(68,43,44).
right_node(68,43,45).
% node 44 (leaf): class 0 (0)
leaf_class(68,44,0).
% node 45 (leaf): class 0 (0)
leaf_class(68,45,0).
% node 46 (leaf): class 0 (0)
leaf_class(68,46,0).

% Tree 69
tree(69).
% node 0: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 1, right -> 28
node(69,0,12,0).
left_node(69,0,1).
right_node(69,0,28).
% node 1: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 110)  left -> 2, right -> 15
node(69,1,1,110).
left_node(69,1,2).
right_node(69,1,15).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(69,2,3,0).
left_node(69,2,3).
right_node(69,2,10).
% node 3: Age_at_diagnosis <= 32.7450008392334  (F1, bin <= 24)  left -> 4, right -> 7
node(69,3,1,24).
left_node(69,3,4).
right_node(69,3,7).
% node 4: TP53 <= 0.5  (F4, bin <= 0)  left -> 5, right -> 6
node(69,4,4,0).
left_node(69,4,5).
right_node(69,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(69,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(69,6,0).
% node 7: MUC16 <= 0.5  (F9, bin <= 0)  left -> 8, right -> 9
node(69,7,9,0).
left_node(69,7,8).
right_node(69,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(69,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(69,9,1).
% node 10: TP53 <= 0.5  (F4, bin <= 0)  left -> 11, right -> 12
node(69,10,4,0).
left_node(69,10,11).
right_node(69,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(69,11,0).
% node 12: Race <= 1.5  (F2, bin <= 1)  left -> 13, right -> 14
node(69,12,2,1).
left_node(69,12,13).
right_node(69,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(69,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(69,14,1).
% node 15: Age_at_diagnosis <= 74.19000244140625  (F1, bin <= 165)  left -> 16, right -> 23
node(69,15,1,165).
left_node(69,15,16).
right_node(69,15,23).
% node 16: IDH1 <= 0.5  (F3, bin <= 0)  left -> 17, right -> 20
node(69,16,3,0).
left_node(69,16,17).
right_node(69,16,20).
% node 17: TP53 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(69,17,4,0).
left_node(69,17,18).
right_node(69,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(69,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(69,19,1).
% node 20: CIC <= 0.5  (F8, bin <= 0)  left -> 21, right -> 22
node(69,20,8,0).
left_node(69,20,21).
right_node(69,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(69,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(69,22,0).
% node 23: EGFR <= 0.5  (F7, bin <= 0)  left -> 24, right -> 27
node(69,23,7,0).
left_node(69,23,24).
right_node(69,23,27).
% node 24: Race <= 0.5  (F2, bin <= 0)  left -> 25, right -> 26
node(69,24,2,0).
left_node(69,24,25).
right_node(69,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(69,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(69,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(69,27,1).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 38
node(69,28,15,0).
left_node(69,28,29).
right_node(69,28,38).
% node 29: MUC16 <= 0.5  (F9, bin <= 0)  left -> 30, right -> 35
node(69,29,9,0).
left_node(69,29,30).
right_node(69,29,35).
% node 30: Race <= 1.5  (F2, bin <= 1)  left -> 31, right -> 34
node(69,30,2,1).
left_node(69,30,31).
right_node(69,30,34).
% node 31: Age_at_diagnosis <= 47.170000076293945  (F1, bin <= 80)  left -> 32, right -> 33
node(69,31,1,80).
left_node(69,31,32).
right_node(69,31,33).
% node 32 (leaf): class 0 (0)
leaf_class(69,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(69,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(69,34,0).
% node 35: PTEN <= 0.5  (F6, bin <= 0)  left -> 36, right -> 37
node(69,35,6,0).
left_node(69,35,36).
right_node(69,35,37).
% node 36 (leaf): class 0 (0)
leaf_class(69,36,0).
% node 37 (leaf): class 1 (1)
leaf_class(69,37,1).
% node 38 (leaf): class 0 (0)
leaf_class(69,38,0).

% Tree 70
tree(70).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 24
node(70,0,8,0).
left_node(70,0,1).
right_node(70,0,24).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 15
node(70,1,4,0).
left_node(70,1,2).
right_node(70,1,15).
% node 2: Age_at_diagnosis <= 44.30999946594238  (F1, bin <= 55)  left -> 3, right -> 8
node(70,2,1,55).
left_node(70,2,3).
right_node(70,2,8).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(70,3,3,0).
left_node(70,3,4).
right_node(70,3,7).
% node 4: MUC16 <= 0.5  (F9, bin <= 0)  left -> 5, right -> 6
node(70,4,9,0).
left_node(70,4,5).
right_node(70,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(70,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(70,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(70,7,0).
% node 8: PTEN <= 0.5  (F6, bin <= 0)  left -> 9, right -> 12
node(70,8,6,0).
left_node(70,8,9).
right_node(70,8,12).
% node 9: IDH1 <= 0.5  (F3, bin <= 0)  left -> 10, right -> 11
node(70,9,3,0).
left_node(70,9,10).
right_node(70,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(70,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(70,11,0).
% node 12: EGFR <= 0.5  (F7, bin <= 0)  left -> 13, right -> 14
node(70,12,7,0).
left_node(70,12,13).
right_node(70,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(70,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(70,14,1).
% node 15: RB1 <= 0.5  (F14, bin <= 0)  left -> 16, right -> 23
node(70,15,14,0).
left_node(70,15,16).
right_node(70,15,23).
% node 16: ATRX <= 0.5  (F5, bin <= 0)  left -> 17, right -> 20
node(70,16,5,0).
left_node(70,16,17).
right_node(70,16,20).
% node 17: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 18, right -> 19
node(70,17,15,0).
left_node(70,17,18).
right_node(70,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(70,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(70,19,0).
% node 20: FAT4 <= 0.5  (F21, bin <= 0)  left -> 21, right -> 22
node(70,20,21,0).
left_node(70,20,21).
right_node(70,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(70,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(70,22,0).
% node 23 (leaf): class 1 (1)
leaf_class(70,23,1).
% node 24: TP53 <= 0.5  (F4, bin <= 0)  left -> 25, right -> 26
node(70,24,4,0).
left_node(70,24,25).
right_node(70,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(70,25,0).
% node 26: PTEN <= 0.5  (F6, bin <= 0)  left -> 27, right -> 32
node(70,26,6,0).
left_node(70,26,27).
right_node(70,26,32).
% node 27: RB1 <= 0.5  (F14, bin <= 0)  left -> 28, right -> 31
node(70,27,14,0).
left_node(70,27,28).
right_node(70,27,31).
% node 28: Age_at_diagnosis <= 37.43499946594238  (F1, bin <= 31)  left -> 29, right -> 30
node(70,28,1,31).
left_node(70,28,29).
right_node(70,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(70,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(70,30,0).
% node 31 (leaf): class 1 (1)
leaf_class(70,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(70,32,0).

% Tree 71
tree(71).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 14
node(71,0,3,0).
left_node(71,0,1).
right_node(71,0,14).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 13
node(71,1,20,0).
left_node(71,1,2).
right_node(71,1,13).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(71,2,9,0).
left_node(71,2,3).
right_node(71,2,8).
% node 3: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 4, right -> 7
node(71,3,22,0).
left_node(71,3,4).
right_node(71,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(71,4,7,0).
left_node(71,4,5).
right_node(71,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(71,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(71,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(71,7,1).
% node 8: ATRX <= 0.5  (F5, bin <= 0)  left -> 9, right -> 12
node(71,8,5,0).
left_node(71,8,9).
right_node(71,8,12).
% node 9: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 10, right -> 11
node(71,9,17,0).
left_node(71,9,10).
right_node(71,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(71,10,1).
% node 11 (leaf): class 1 (1)
leaf_class(71,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(71,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(71,13,0).
% node 14: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 15, right -> 22
node(71,14,10,0).
left_node(71,14,15).
right_node(71,14,22).
% node 15: EGFR <= 0.5  (F7, bin <= 0)  left -> 16, right -> 21
node(71,15,7,0).
left_node(71,15,16).
right_node(71,15,21).
% node 16: Age_at_diagnosis <= 30.854999542236328  (F1, bin <= 15)  left -> 17, right -> 18
node(71,16,1,15).
left_node(71,16,17).
right_node(71,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(71,17,0).
% node 18: Age_at_diagnosis <= 31.155000686645508  (F1, bin <= 17)  left -> 19, right -> 20
node(71,18,1,17).
left_node(71,18,19).
right_node(71,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(71,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(71,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(71,21,1).
% node 22: Gender <= 0.5  (F0, bin <= 0)  left -> 23, right -> 24
node(71,22,0,0).
left_node(71,22,23).
right_node(71,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(71,23,0).
% node 24: CIC <= 0.5  (F8, bin <= 0)  left -> 25, right -> 28
node(71,24,8,0).
left_node(71,24,25).
right_node(71,24,28).
% node 25: TP53 <= 0.5  (F4, bin <= 0)  left -> 26, right -> 27
node(71,25,4,0).
left_node(71,25,26).
right_node(71,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(71,26,0).
% node 27 (leaf): class 0 (0)
leaf_class(71,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(71,28,0).

% Tree 72
tree(72).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 26
node(72,0,8,0).
left_node(72,0,1).
right_node(72,0,26).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 17
node(72,1,6,0).
left_node(72,1,2).
right_node(72,1,17).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(72,2,7,0).
left_node(72,2,3).
right_node(72,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(72,3,3,0).
left_node(72,3,4).
right_node(72,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(72,4,5,0).
left_node(72,4,5).
right_node(72,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(72,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(72,6,0).
% node 7: ATRX <= 0.5  (F5, bin <= 0)  left -> 8, right -> 9
node(72,7,5,0).
left_node(72,7,8).
right_node(72,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(72,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(72,9,0).
% node 10: TP53 <= 0.5  (F4, bin <= 0)  left -> 11, right -> 14
node(72,10,4,0).
left_node(72,10,11).
right_node(72,10,14).
% node 11: MUC16 <= 0.5  (F9, bin <= 0)  left -> 12, right -> 13
node(72,11,9,0).
left_node(72,11,12).
right_node(72,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(72,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(72,13,1).
% node 14: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 15, right -> 16
node(72,14,17,0).
left_node(72,14,15).
right_node(72,14,16).
% node 15 (leaf): class 1 (1)
leaf_class(72,15,1).
% node 16 (leaf): class 1 (1)
leaf_class(72,16,1).
% node 17: MUC16 <= 0.5  (F9, bin <= 0)  left -> 18, right -> 25
node(72,17,9,0).
left_node(72,17,18).
right_node(72,17,25).
% node 18: EGFR <= 0.5  (F7, bin <= 0)  left -> 19, right -> 22
node(72,18,7,0).
left_node(72,18,19).
right_node(72,18,22).
% node 19: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 20, right -> 21
node(72,19,12,0).
left_node(72,19,20).
right_node(72,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(72,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(72,21,1).
% node 22: BCOR <= 0.5  (F16, bin <= 0)  left -> 23, right -> 24
node(72,22,16,0).
left_node(72,22,23).
right_node(72,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(72,23,1).
% node 24 (leaf): class 1 (1)
leaf_class(72,24,1).
% node 25 (leaf): class 1 (1)
leaf_class(72,25,1).
% node 26: RB1 <= 0.5  (F14, bin <= 0)  left -> 27, right -> 34
node(72,26,14,0).
left_node(72,26,27).
right_node(72,26,34).
% node 27: Gender <= 0.5  (F0, bin <= 0)  left -> 28, right -> 33
node(72,27,0,0).
left_node(72,27,28).
right_node(72,27,33).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 32
node(72,28,15,0).
left_node(72,28,29).
right_node(72,28,32).
% node 29: IDH1 <= 0.5  (F3, bin <= 0)  left -> 30, right -> 31
node(72,29,3,0).
left_node(72,29,30).
right_node(72,29,31).
% node 30 (leaf): class 0 (0)
leaf_class(72,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(72,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(72,32,0).
% node 33 (leaf): class 0 (0)
leaf_class(72,33,0).
% node 34: PTEN <= 0.5  (F6, bin <= 0)  left -> 35, right -> 36
node(72,34,6,0).
left_node(72,34,35).
right_node(72,34,36).
% node 35 (leaf): class 1 (1)
leaf_class(72,35,1).
% node 36 (leaf): class 0 (0)
leaf_class(72,36,0).

% Tree 73
tree(73).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 24
node(73,0,5,0).
left_node(73,0,1).
right_node(73,0,24).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 11
node(73,1,6,0).
left_node(73,1,2).
right_node(73,1,11).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 10
node(73,2,15,0).
left_node(73,2,3).
right_node(73,2,10).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(73,3,9,0).
left_node(73,3,4).
right_node(73,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(73,4,20,0).
left_node(73,4,5).
right_node(73,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(73,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(73,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(73,7,3,0).
left_node(73,7,8).
right_node(73,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(73,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(73,9,0).
% node 10 (leaf): class 0 (0)
leaf_class(73,10,0).
% node 11: Age_at_diagnosis <= 46.71500015258789  (F1, bin <= 77)  left -> 12, right -> 17
node(73,11,1,77).
left_node(73,11,12).
right_node(73,11,17).
% node 12: CIC <= 0.5  (F8, bin <= 0)  left -> 13, right -> 16
node(73,12,8,0).
left_node(73,12,13).
right_node(73,12,16).
% node 13: EGFR <= 0.5  (F7, bin <= 0)  left -> 14, right -> 15
node(73,13,7,0).
left_node(73,13,14).
right_node(73,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(73,14,0).
% node 15 (leaf): class 1 (1)
leaf_class(73,15,1).
% node 16 (leaf): class 0 (0)
leaf_class(73,16,0).
% node 17: NF1 <= 0.5  (F11, bin <= 0)  left -> 18, right -> 21
node(73,17,11,0).
left_node(73,17,18).
right_node(73,17,21).
% node 18: Age_at_diagnosis <= 62.42499923706055  (F1, bin <= 133)  left -> 19, right -> 20
node(73,18,1,133).
left_node(73,18,19).
right_node(73,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(73,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(73,20,1).
% node 21: TP53 <= 0.5  (F4, bin <= 0)  left -> 22, right -> 23
node(73,21,4,0).
left_node(73,21,22).
right_node(73,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(73,22,1).
% node 23 (leaf): class 1 (1)
leaf_class(73,23,1).
% node 24: BCOR <= 0.5  (F16, bin <= 0)  left -> 25, right -> 34
node(73,24,16,0).
left_node(73,24,25).
right_node(73,24,34).
% node 25: PTEN <= 0.5  (F6, bin <= 0)  left -> 26, right -> 33
node(73,25,6,0).
left_node(73,25,26).
right_node(73,25,33).
% node 26: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 27, right -> 30
node(73,26,12,0).
left_node(73,26,27).
right_node(73,26,30).
% node 27: IDH1 <= 0.5  (F3, bin <= 0)  left -> 28, right -> 29
node(73,27,3,0).
left_node(73,27,28).
right_node(73,27,29).
% node 28 (leaf): class 0 (0)
leaf_class(73,28,0).
% node 29 (leaf): class 0 (0)
leaf_class(73,29,0).
% node 30: MUC16 <= 0.5  (F9, bin <= 0)  left -> 31, right -> 32
node(73,30,9,0).
left_node(73,30,31).
right_node(73,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(73,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(73,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(73,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(73,34,1).

% Tree 74
tree(74).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 22
node(74,0,15,0).
left_node(74,0,1).
right_node(74,0,22).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 15
node(74,1,13,0).
left_node(74,1,2).
right_node(74,1,15).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(74,2,7,0).
left_node(74,2,3).
right_node(74,2,10).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(74,3,8,0).
left_node(74,3,4).
right_node(74,3,7).
% node 4: Age_at_diagnosis <= 45.28999900817871  (F1, bin <= 61)  left -> 5, right -> 6
node(74,4,1,61).
left_node(74,4,5).
right_node(74,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(74,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(74,6,1).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(74,7,0,0).
left_node(74,7,8).
right_node(74,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(74,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(74,9,0).
% node 10: MUC16 <= 0.5  (F9, bin <= 0)  left -> 11, right -> 14
node(74,10,9,0).
left_node(74,10,11).
right_node(74,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(74,11,0,0).
left_node(74,11,12).
right_node(74,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(74,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(74,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(74,14,1).
% node 15: Gender <= 0.5  (F0, bin <= 0)  left -> 16, right -> 17
node(74,15,0,0).
left_node(74,15,16).
right_node(74,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(74,16,0).
% node 17: IDH1 <= 0.5  (F3, bin <= 0)  left -> 18, right -> 21
node(74,17,3,0).
left_node(74,17,18).
right_node(74,17,21).
% node 18: FAT4 <= 0.5  (F21, bin <= 0)  left -> 19, right -> 20
node(74,18,21,0).
left_node(74,18,19).
right_node(74,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(74,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(74,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(74,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(74,22,0).

% Tree 75
tree(75).
% node 0: TP53 <= 0.5  (F4, bin <= 0)  left -> 1, right -> 16
node(75,0,4,0).
left_node(75,0,1).
right_node(75,0,16).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 15
node(75,1,8,0).
left_node(75,1,2).
right_node(75,1,15).
% node 2: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 3, right -> 10
node(75,2,19,0).
left_node(75,2,3).
right_node(75,2,10).
% node 3: PTEN <= 0.5  (F6, bin <= 0)  left -> 4, right -> 7
node(75,3,6,0).
left_node(75,3,4).
right_node(75,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(75,4,5,0).
left_node(75,4,5).
right_node(75,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(75,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(75,6,0).
% node 7: RB1 <= 0.5  (F14, bin <= 0)  left -> 8, right -> 9
node(75,7,14,0).
left_node(75,7,8).
right_node(75,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(75,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(75,9,1).
% node 10: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 11, right -> 14
node(75,10,12,0).
left_node(75,10,11).
right_node(75,10,14).
% node 11: EGFR <= 0.5  (F7, bin <= 0)  left -> 12, right -> 13
node(75,11,7,0).
left_node(75,11,12).
right_node(75,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(75,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(75,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(75,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(75,15,0).
% node 16: RB1 <= 0.5  (F14, bin <= 0)  left -> 17, right -> 32
node(75,16,14,0).
left_node(75,16,17).
right_node(75,16,32).
% node 17: IDH1 <= 0.5  (F3, bin <= 0)  left -> 18, right -> 25
node(75,17,3,0).
left_node(75,17,18).
right_node(75,17,25).
% node 18: Age_at_diagnosis <= 46.57500076293945  (F1, bin <= 74)  left -> 19, right -> 22
node(75,18,1,74).
left_node(75,18,19).
right_node(75,18,22).
% node 19: Gender <= 0.5  (F0, bin <= 0)  left -> 20, right -> 21
node(75,19,0,0).
left_node(75,19,20).
right_node(75,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(75,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(75,21,0).
% node 22: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 23, right -> 24
node(75,22,10,0).
left_node(75,22,23).
right_node(75,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(75,23,1).
% node 24 (leaf): class 0 (0)
leaf_class(75,24,0).
% node 25: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 26, right -> 29
node(75,25,10,0).
left_node(75,25,26).
right_node(75,25,29).
% node 26: NF1 <= 0.5  (F11, bin <= 0)  left -> 27, right -> 28
node(75,26,11,0).
left_node(75,26,27).
right_node(75,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(75,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(75,28,0).
% node 29: Gender <= 0.5  (F0, bin <= 0)  left -> 30, right -> 31
node(75,29,0,0).
left_node(75,29,30).
right_node(75,29,31).
% node 30 (leaf): class 0 (0)
leaf_class(75,30,0).
% node 31 (leaf): class 0 (0)
leaf_class(75,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(75,32,1).

% Tree 76
tree(76).
% node 0: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 1, right -> 22
node(76,0,18,0).
left_node(76,0,1).
right_node(76,0,22).
% node 1: RB1 <= 0.5  (F14, bin <= 0)  left -> 2, right -> 15
node(76,1,14,0).
left_node(76,1,2).
right_node(76,1,15).
% node 2: ATRX <= 0.5  (F5, bin <= 0)  left -> 3, right -> 8
node(76,2,5,0).
left_node(76,2,3).
right_node(76,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(76,3,8,0).
left_node(76,3,4).
right_node(76,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(76,4,7,0).
left_node(76,4,5).
right_node(76,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(76,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(76,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(76,7,0).
% node 8: EGFR <= 0.5  (F7, bin <= 0)  left -> 9, right -> 12
node(76,8,7,0).
left_node(76,8,9).
right_node(76,8,12).
% node 9: IDH1 <= 0.5  (F3, bin <= 0)  left -> 10, right -> 11
node(76,9,3,0).
left_node(76,9,10).
right_node(76,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(76,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(76,11,0).
% node 12: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 13, right -> 14
node(76,12,12,0).
left_node(76,12,13).
right_node(76,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(76,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(76,14,1).
% node 15: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 16, right -> 21
node(76,15,19,0).
left_node(76,15,16).
right_node(76,15,21).
% node 16: BCOR <= 0.5  (F16, bin <= 0)  left -> 17, right -> 20
node(76,16,16,0).
left_node(76,16,17).
right_node(76,16,20).
% node 17: TP53 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(76,17,4,0).
left_node(76,17,18).
right_node(76,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(76,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(76,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(76,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(76,21,1).
% node 22: FAT4 <= 0.5  (F21, bin <= 0)  left -> 23, right -> 28
node(76,22,21,0).
left_node(76,22,23).
right_node(76,22,28).
% node 23: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 24, right -> 25
node(76,23,17,0).
left_node(76,23,24).
right_node(76,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(76,24,0).
% node 25: Age_at_diagnosis <= 53.02000045776367  (F1, bin <= 116)  left -> 26, right -> 27
node(76,25,1,116).
left_node(76,25,26).
right_node(76,25,27).
% node 26 (leaf): class 0 (0)
leaf_class(76,26,0).
% node 27 (leaf): class 1 (1)
leaf_class(76,27,1).
% node 28: Age_at_diagnosis <= 29.255001068115234  (F1, bin <= 14)  left -> 29, right -> 30
node(76,28,1,14).
left_node(76,28,29).
right_node(76,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(76,29,1).
% node 30 (leaf): class 0 (0)
leaf_class(76,30,0).

% Tree 77
tree(77).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 14
node(77,0,5,0).
left_node(77,0,1).
right_node(77,0,14).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 13
node(77,1,8,0).
left_node(77,1,2).
right_node(77,1,13).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(77,2,9,0).
left_node(77,2,3).
right_node(77,2,8).
% node 3: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 4, right -> 7
node(77,3,15,0).
left_node(77,3,4).
right_node(77,3,7).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 6
node(77,4,6,0).
left_node(77,4,5).
right_node(77,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(77,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(77,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(77,7,0).
% node 8: Race <= 0.5  (F2, bin <= 0)  left -> 9, right -> 12
node(77,8,2,0).
left_node(77,8,9).
right_node(77,8,12).
% node 9: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 10, right -> 11
node(77,9,17,0).
left_node(77,9,10).
right_node(77,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(77,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(77,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(77,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(77,13,0).
% node 14: Age_at_diagnosis <= 24.4399995803833  (F1, bin <= 3)  left -> 15, right -> 22
node(77,14,1,3).
left_node(77,14,15).
right_node(77,14,22).
% node 15: BCOR <= 0.5  (F16, bin <= 0)  left -> 16, right -> 21
node(77,15,16,0).
left_node(77,15,16).
right_node(77,15,21).
% node 16: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 17, right -> 20
node(77,16,10,0).
left_node(77,16,17).
right_node(77,16,20).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(77,17,2,0).
left_node(77,17,18).
right_node(77,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(77,18,0).
% node 19 (leaf): class 1 (1)
leaf_class(77,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(77,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(77,21,1).
% node 22: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 23, right -> 30
node(77,22,12,0).
left_node(77,22,23).
right_node(77,22,30).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 27
node(77,23,6,0).
left_node(77,23,24).
right_node(77,23,27).
% node 24: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 25, right -> 26
node(77,24,10,0).
left_node(77,24,25).
right_node(77,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(77,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(77,26,0).
% node 27: EGFR <= 0.5  (F7, bin <= 0)  left -> 28, right -> 29
node(77,27,7,0).
left_node(77,27,28).
right_node(77,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(77,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(77,29,1).
% node 30: Age_at_diagnosis <= 51.07499885559082  (F1, bin <= 102)  left -> 31, right -> 34
node(77,30,1,102).
left_node(77,30,31).
right_node(77,30,34).
% node 31: Race <= 1.0  (F2, bin <= 1)  left -> 32, right -> 33
node(77,31,2,1).
left_node(77,31,32).
right_node(77,31,33).
% node 32 (leaf): class 0 (0)
leaf_class(77,32,0).
% node 33 (leaf): class 1 (1)
leaf_class(77,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(77,34,1).

% Tree 78
tree(78).
% node 0: IDH1 <= 0.5  (F3, bin <= 0)  left -> 1, right -> 20
node(78,0,3,0).
left_node(78,0,1).
right_node(78,0,20).
% node 1: MUC16 <= 0.5  (F9, bin <= 0)  left -> 2, right -> 13
node(78,1,9,0).
left_node(78,1,2).
right_node(78,1,13).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 10
node(78,2,20,0).
left_node(78,2,3).
right_node(78,2,10).
% node 3: Age_at_diagnosis <= 70.61499786376953  (F1, bin <= 156)  left -> 4, right -> 7
node(78,3,1,156).
left_node(78,3,4).
right_node(78,3,7).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 6
node(78,4,6,0).
left_node(78,4,5).
right_node(78,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(78,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(78,6,1).
% node 7: Race <= 0.5  (F2, bin <= 0)  left -> 8, right -> 9
node(78,7,2,0).
left_node(78,7,8).
right_node(78,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(78,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(78,9,1).
% node 10: PTEN <= 0.5  (F6, bin <= 0)  left -> 11, right -> 12
node(78,10,6,0).
left_node(78,10,11).
right_node(78,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(78,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(78,12,1).
% node 13: Age_at_diagnosis <= 58.85499954223633  (F1, bin <= 124)  left -> 14, right -> 19
node(78,13,1,124).
left_node(78,13,14).
right_node(78,13,19).
% node 14: TP53 <= 0.5  (F4, bin <= 0)  left -> 15, right -> 18
node(78,14,4,0).
left_node(78,14,15).
right_node(78,14,18).
% node 15: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 16, right -> 17
node(78,15,19,0).
left_node(78,15,16).
right_node(78,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(78,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(78,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(78,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(78,19,1).
% node 20: TP53 <= 0.5  (F4, bin <= 0)  left -> 21, right -> 22
node(78,20,4,0).
left_node(78,20,21).
right_node(78,20,22).
% node 21 (leaf): class 0 (0)
leaf_class(78,21,0).
% node 22: Race <= 1.5  (F2, bin <= 1)  left -> 23, right -> 28
node(78,22,2,1).
left_node(78,22,23).
right_node(78,22,28).
% node 23: PTEN <= 0.5  (F6, bin <= 0)  left -> 24, right -> 27
node(78,23,6,0).
left_node(78,23,24).
right_node(78,23,27).
% node 24: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 25, right -> 26
node(78,24,17,0).
left_node(78,24,25).
right_node(78,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(78,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(78,26,0).
% node 27 (leaf): class 0 (0)
leaf_class(78,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(78,28,1).

% Tree 79
tree(79).
% node 0: Age_at_diagnosis <= 43.64499855041504  (F1, bin <= 52)  left -> 1, right -> 14
node(79,0,1,52).
left_node(79,0,1).
right_node(79,0,14).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 9
node(79,1,7,0).
left_node(79,1,2).
right_node(79,1,9).
% node 2: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 3, right -> 8
node(79,2,17,0).
left_node(79,2,3).
right_node(79,2,8).
% node 3: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 4, right -> 7
node(79,3,13,0).
left_node(79,3,4).
right_node(79,3,7).
% node 4: FAT4 <= 0.5  (F21, bin <= 0)  left -> 5, right -> 6
node(79,4,21,0).
left_node(79,4,5).
right_node(79,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(79,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(79,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(79,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(79,8,0).
% node 9: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 10, right -> 11
node(79,9,19,0).
left_node(79,9,10).
right_node(79,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(79,10,1).
% node 11: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 12, right -> 13
node(79,11,12,0).
left_node(79,11,12).
right_node(79,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(79,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(79,13,1).
% node 14: IDH1 <= 0.5  (F3, bin <= 0)  left -> 15, right -> 26
node(79,14,3,0).
left_node(79,14,15).
right_node(79,14,26).
% node 15: Age_at_diagnosis <= 70.61499786376953  (F1, bin <= 156)  left -> 16, right -> 21
node(79,15,1,156).
left_node(79,15,16).
right_node(79,15,21).
% node 16: CIC <= 0.5  (F8, bin <= 0)  left -> 17, right -> 20
node(79,16,8,0).
left_node(79,16,17).
right_node(79,16,20).
% node 17: EGFR <= 0.5  (F7, bin <= 0)  left -> 18, right -> 19
node(79,17,7,0).
left_node(79,17,18).
right_node(79,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(79,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(79,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(79,20,0).
% node 21: PTEN <= 0.5  (F6, bin <= 0)  left -> 22, right -> 25
node(79,21,6,0).
left_node(79,21,22).
right_node(79,21,25).
% node 22: Age_at_diagnosis <= 86.30500030517578  (F1, bin <= 169)  left -> 23, right -> 24
node(79,22,1,169).
left_node(79,22,23).
right_node(79,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(79,23,1).
% node 24 (leaf): class 0 (0)
leaf_class(79,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(79,25,1).
% node 26: CIC <= 0.5  (F8, bin <= 0)  left -> 27, right -> 32
node(79,26,8,0).
left_node(79,26,27).
right_node(79,26,32).
% node 27: MUC16 <= 0.5  (F9, bin <= 0)  left -> 28, right -> 31
node(79,27,9,0).
left_node(79,27,28).
right_node(79,27,31).
% node 28: FAT4 <= 0.5  (F21, bin <= 0)  left -> 29, right -> 30
node(79,28,21,0).
left_node(79,28,29).
right_node(79,28,30).
% node 29 (leaf): class 0 (0)
leaf_class(79,29,0).
% node 30 (leaf): class 1 (1)
leaf_class(79,30,1).
% node 31 (leaf): class 0 (0)
leaf_class(79,31,0).
% node 32 (leaf): class 0 (0)
leaf_class(79,32,0).

% Tree 80
tree(80).
% node 0: IDH2 <= 0.5  (F20, bin <= 0)  left -> 1, right -> 22
node(80,0,20,0).
left_node(80,0,1).
right_node(80,0,22).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(80,1,6,0).
left_node(80,1,2).
right_node(80,1,15).
% node 2: Age_at_diagnosis <= 52.0049991607666  (F1, bin <= 104)  left -> 3, right -> 10
node(80,2,1,104).
left_node(80,2,3).
right_node(80,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(80,3,3,0).
left_node(80,3,4).
right_node(80,3,7).
% node 4: Age_at_diagnosis <= 27.639999389648438  (F1, bin <= 10)  left -> 5, right -> 6
node(80,4,1,10).
left_node(80,4,5).
right_node(80,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(80,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(80,6,1).
% node 7: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 8, right -> 9
node(80,7,22,0).
left_node(80,7,8).
right_node(80,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(80,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(80,9,1).
% node 10: Race <= 1.5  (F2, bin <= 1)  left -> 11, right -> 14
node(80,10,2,1).
left_node(80,10,11).
right_node(80,10,14).
% node 11: Age_at_diagnosis <= 60.52000045776367  (F1, bin <= 129)  left -> 12, right -> 13
node(80,11,1,129).
left_node(80,11,12).
right_node(80,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(80,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(80,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(80,14,1).
% node 15: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 16, right -> 21
node(80,15,12,0).
left_node(80,15,16).
right_node(80,15,21).
% node 16: CIC <= 0.5  (F8, bin <= 0)  left -> 17, right -> 20
node(80,16,8,0).
left_node(80,16,17).
right_node(80,16,20).
% node 17: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 18, right -> 19
node(80,17,19,0).
left_node(80,17,18).
right_node(80,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(80,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(80,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(80,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(80,21,1).
% node 22 (leaf): class 0 (0)
leaf_class(80,22,0).

% Tree 81
tree(81).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 18
node(81,0,15,0).
left_node(81,0,1).
right_node(81,0,18).
% node 1: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 2, right -> 15
node(81,1,13,0).
left_node(81,1,2).
right_node(81,1,15).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 10
node(81,2,8,0).
left_node(81,2,3).
right_node(81,2,10).
% node 3: IDH1 <= 0.5  (F3, bin <= 0)  left -> 4, right -> 7
node(81,3,3,0).
left_node(81,3,4).
right_node(81,3,7).
% node 4: Gender <= 0.5  (F0, bin <= 0)  left -> 5, right -> 6
node(81,4,0,0).
left_node(81,4,5).
right_node(81,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(81,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(81,6,1).
% node 7: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 8, right -> 9
node(81,7,12,0).
left_node(81,7,8).
right_node(81,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(81,8,0).
% node 9 (leaf): class 1 (1)
leaf_class(81,9,1).
% node 10: Age_at_diagnosis <= 35.46999931335449  (F1, bin <= 28)  left -> 11, right -> 14
node(81,10,1,28).
left_node(81,10,11).
right_node(81,10,14).
% node 11: ATRX <= 0.5  (F5, bin <= 0)  left -> 12, right -> 13
node(81,11,5,0).
left_node(81,11,12).
right_node(81,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(81,12,0).
% node 13 (leaf): class 1 (1)
leaf_class(81,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(81,14,0).
% node 15: PTEN <= 0.5  (F6, bin <= 0)  left -> 16, right -> 17
node(81,15,6,0).
left_node(81,15,16).
right_node(81,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(81,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(81,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(81,18,0).

% Tree 82
tree(82).
% node 0: MUC16 <= 0.5  (F9, bin <= 0)  left -> 1, right -> 26
node(82,0,9,0).
left_node(82,0,1).
right_node(82,0,26).
% node 1: ATRX <= 0.5  (F5, bin <= 0)  left -> 2, right -> 15
node(82,1,5,0).
left_node(82,1,2).
right_node(82,1,15).
% node 2: Age_at_diagnosis <= 48.46999931335449  (F1, bin <= 85)  left -> 3, right -> 10
node(82,2,1,85).
left_node(82,2,3).
right_node(82,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(82,3,14,0).
left_node(82,3,4).
right_node(82,3,7).
% node 4: Age_at_diagnosis <= 32.635000228881836  (F1, bin <= 23)  left -> 5, right -> 6
node(82,4,1,23).
left_node(82,4,5).
right_node(82,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(82,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(82,6,0).
% node 7: EGFR <= 0.5  (F7, bin <= 0)  left -> 8, right -> 9
node(82,7,7,0).
left_node(82,7,8).
right_node(82,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(82,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(82,9,1).
% node 10: IDH2 <= 0.5  (F20, bin <= 0)  left -> 11, right -> 14
node(82,10,20,0).
left_node(82,10,11).
right_node(82,10,14).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(82,11,3,0).
left_node(82,11,12).
right_node(82,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(82,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(82,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(82,14,0).
% node 15: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 16, right -> 21
node(82,15,12,0).
left_node(82,15,16).
right_node(82,15,21).
% node 16: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 17, right -> 20
node(82,16,15,0).
left_node(82,16,17).
right_node(82,16,20).
% node 17: IDH1 <= 0.5  (F3, bin <= 0)  left -> 18, right -> 19
node(82,17,3,0).
left_node(82,17,18).
right_node(82,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(82,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(82,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(82,20,0).
% node 21: Age_at_diagnosis <= 36.054999351501465  (F1, bin <= 30)  left -> 22, right -> 23
node(82,21,1,30).
left_node(82,21,22).
right_node(82,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(82,22,1).
% node 23: Gender <= 0.5  (F0, bin <= 0)  left -> 24, right -> 25
node(82,23,0,0).
left_node(82,23,24).
right_node(82,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(82,24,0).
% node 25 (leaf): class 1 (1)
leaf_class(82,25,1).
% node 26: Age_at_diagnosis <= 52.51500129699707  (F1, bin <= 106)  left -> 27, right -> 40
node(82,26,1,106).
left_node(82,26,27).
right_node(82,26,40).
% node 27: TP53 <= 0.5  (F4, bin <= 0)  left -> 28, right -> 33
node(82,27,4,0).
left_node(82,27,28).
right_node(82,27,33).
% node 28: Age_at_diagnosis <= 49.27499961853027  (F1, bin <= 95)  left -> 29, right -> 32
node(82,28,1,95).
left_node(82,28,29).
right_node(82,28,32).
% node 29: Age_at_diagnosis <= 39.30500030517578  (F1, bin <= 38)  left -> 30, right -> 31
node(82,29,1,38).
left_node(82,29,30).
right_node(82,29,31).
% node 30 (leaf): class 0 (0)
leaf_class(82,30,0).
% node 31 (leaf): class 1 (1)
leaf_class(82,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(82,32,0).
% node 33: Age_at_diagnosis <= 43.14999961853027  (F1, bin <= 48)  left -> 34, right -> 37
node(82,33,1,48).
left_node(82,33,34).
right_node(82,33,37).
% node 34: BCOR <= 0.5  (F16, bin <= 0)  left -> 35, right -> 36
node(82,34,16,0).
left_node(82,34,35).
right_node(82,34,36).
% node 35 (leaf): class 0 (0)
leaf_class(82,35,0).
% node 36 (leaf): class 0 (0)
leaf_class(82,36,0).
% node 37: RB1 <= 0.5  (F14, bin <= 0)  left -> 38, right -> 39
node(82,37,14,0).
left_node(82,37,38).
right_node(82,37,39).
% node 38 (leaf): class 0 (0)
leaf_class(82,38,0).
% node 39 (leaf): class 1 (1)
leaf_class(82,39,1).
% node 40: PTEN <= 0.5  (F6, bin <= 0)  left -> 41, right -> 46
node(82,40,6,0).
left_node(82,40,41).
right_node(82,40,46).
% node 41: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 42, right -> 45
node(82,41,22,0).
left_node(82,41,42).
right_node(82,41,45).
% node 42: IDH1 <= 0.5  (F3, bin <= 0)  left -> 43, right -> 44
node(82,42,3,0).
left_node(82,42,43).
right_node(82,42,44).
% node 43 (leaf): class 1 (1)
leaf_class(82,43,1).
% node 44 (leaf): class 0 (0)
leaf_class(82,44,0).
% node 45 (leaf): class 1 (1)
leaf_class(82,45,1).
% node 46: Gender <= 0.5  (F0, bin <= 0)  left -> 47, right -> 50
node(82,46,0,0).
left_node(82,46,47).
right_node(82,46,50).
% node 47: NF1 <= 0.5  (F11, bin <= 0)  left -> 48, right -> 49
node(82,47,11,0).
left_node(82,47,48).
right_node(82,47,49).
% node 48 (leaf): class 1 (1)
leaf_class(82,48,1).
% node 49 (leaf): class 0 (0)
leaf_class(82,49,0).
% node 50 (leaf): class 1 (1)
leaf_class(82,50,1).

% Tree 83
tree(83).
% node 0: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 1, right -> 22
node(83,0,19,0).
left_node(83,0,1).
right_node(83,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 11
node(83,1,3,0).
left_node(83,1,2).
right_node(83,1,11).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 10
node(83,2,8,0).
left_node(83,2,3).
right_node(83,2,10).
% node 3: MUC16 <= 0.5  (F9, bin <= 0)  left -> 4, right -> 7
node(83,3,9,0).
left_node(83,3,4).
right_node(83,3,7).
% node 4: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 5, right -> 6
node(83,4,22,0).
left_node(83,4,5).
right_node(83,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(83,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(83,6,0).
% node 7: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 8, right -> 9
node(83,7,18,0).
left_node(83,7,8).
right_node(83,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(83,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(83,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(83,10,0).
% node 11: ATRX <= 0.5  (F5, bin <= 0)  left -> 12, right -> 17
node(83,11,5,0).
left_node(83,11,12).
right_node(83,11,17).
% node 12: FAT4 <= 0.5  (F21, bin <= 0)  left -> 13, right -> 14
node(83,12,21,0).
left_node(83,12,13).
right_node(83,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(83,13,0).
% node 14: MUC16 <= 0.5  (F9, bin <= 0)  left -> 15, right -> 16
node(83,14,9,0).
left_node(83,14,15).
right_node(83,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(83,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(83,16,0).
% node 17: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 18, right -> 21
node(83,17,15,0).
left_node(83,17,18).
right_node(83,17,21).
% node 18: PTEN <= 0.5  (F6, bin <= 0)  left -> 19, right -> 20
node(83,18,6,0).
left_node(83,18,19).
right_node(83,18,20).
% node 19 (leaf): class 0 (0)
leaf_class(83,19,0).
% node 20 (leaf): class 1 (1)
leaf_class(83,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(83,21,0).
% node 22: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 23, right -> 30
node(83,22,10,0).
left_node(83,22,23).
right_node(83,22,30).
% node 23: NF1 <= 0.5  (F11, bin <= 0)  left -> 24, right -> 29
node(83,23,11,0).
left_node(83,23,24).
right_node(83,23,29).
% node 24: RB1 <= 0.5  (F14, bin <= 0)  left -> 25, right -> 28
node(83,24,14,0).
left_node(83,24,25).
right_node(83,24,28).
% node 25: Gender <= 0.5  (F0, bin <= 0)  left -> 26, right -> 27
node(83,25,0,0).
left_node(83,25,26).
right_node(83,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(83,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(83,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(83,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(83,29,1).
% node 30: ATRX <= 0.5  (F5, bin <= 0)  left -> 31, right -> 32
node(83,30,5,0).
left_node(83,30,31).
right_node(83,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(83,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(83,32,1).

% Tree 84
tree(84).
% node 0: Age_at_diagnosis <= 45.35499954223633  (F1, bin <= 62)  left -> 1, right -> 26
node(84,0,1,62).
left_node(84,0,1).
right_node(84,0,26).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 13
node(84,1,3,0).
left_node(84,1,2).
right_node(84,1,13).
% node 2: TP53 <= 0.5  (F4, bin <= 0)  left -> 3, right -> 8
node(84,2,4,0).
left_node(84,2,3).
right_node(84,2,8).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(84,3,14,0).
left_node(84,3,4).
right_node(84,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(84,4,20,0).
left_node(84,4,5).
right_node(84,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(84,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(84,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(84,7,1).
% node 8: Age_at_diagnosis <= 27.915000915527344  (F1, bin <= 11)  left -> 9, right -> 10
node(84,8,1,11).
left_node(84,8,9).
right_node(84,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(84,9,1).
% node 10: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 11, right -> 12
node(84,10,10,0).
left_node(84,10,11).
right_node(84,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(84,11,0).
% node 12 (leaf): class 0 (0)
leaf_class(84,12,0).
% node 13: Gender <= 0.5  (F0, bin <= 0)  left -> 14, right -> 21
node(84,13,0,0).
left_node(84,13,14).
right_node(84,13,21).
% node 14: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 15, right -> 18
node(84,14,12,0).
left_node(84,14,15).
right_node(84,14,18).
% node 15: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 16, right -> 17
node(84,15,10,0).
left_node(84,15,16).
right_node(84,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(84,16,0).
% node 17 (leaf): class 0 (0)
leaf_class(84,17,0).
% node 18: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 19, right -> 20
node(84,18,13,0).
left_node(84,18,19).
right_node(84,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(84,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(84,20,0).
% node 21: MUC16 <= 0.5  (F9, bin <= 0)  left -> 22, right -> 25
node(84,21,9,0).
left_node(84,21,22).
right_node(84,21,25).
% node 22: CIC <= 0.5  (F8, bin <= 0)  left -> 23, right -> 24
node(84,22,8,0).
left_node(84,22,23).
right_node(84,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(84,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(84,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(84,25,0).
% node 26: Age_at_diagnosis <= 74.45000076293945  (F1, bin <= 166)  left -> 27, right -> 34
node(84,26,1,166).
left_node(84,26,27).
right_node(84,26,34).
% node 27: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 28, right -> 33
node(84,27,18,0).
left_node(84,27,28).
right_node(84,27,33).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 32
node(84,28,15,0).
left_node(84,28,29).
right_node(84,28,32).
% node 29: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 30, right -> 31
node(84,29,19,0).
left_node(84,29,30).
right_node(84,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(84,30,1).
% node 31 (leaf): class 1 (1)
leaf_class(84,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(84,32,0).
% node 33 (leaf): class 0 (0)
leaf_class(84,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(84,34,1).

% Tree 85
tree(85).
% node 0: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 1, right -> 22
node(85,0,13,0).
left_node(85,0,1).
right_node(85,0,22).
% node 1: PTEN <= 0.5  (F6, bin <= 0)  left -> 2, right -> 15
node(85,1,6,0).
left_node(85,1,2).
right_node(85,1,15).
% node 2: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 3, right -> 10
node(85,2,12,0).
left_node(85,2,3).
right_node(85,2,10).
% node 3: EGFR <= 0.5  (F7, bin <= 0)  left -> 4, right -> 7
node(85,3,7,0).
left_node(85,3,4).
right_node(85,3,7).
% node 4: ATRX <= 0.5  (F5, bin <= 0)  left -> 5, right -> 6
node(85,4,5,0).
left_node(85,4,5).
right_node(85,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(85,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(85,6,0).
% node 7: RB1 <= 0.5  (F14, bin <= 0)  left -> 8, right -> 9
node(85,7,14,0).
left_node(85,7,8).
right_node(85,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(85,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(85,9,1).
% node 10: Gender <= 0.5  (F0, bin <= 0)  left -> 11, right -> 12
node(85,10,0,0).
left_node(85,10,11).
right_node(85,10,12).
% node 11 (leaf): class 1 (1)
leaf_class(85,11,1).
% node 12: TP53 <= 0.5  (F4, bin <= 0)  left -> 13, right -> 14
node(85,12,4,0).
left_node(85,12,13).
right_node(85,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(85,13,1).
% node 14 (leaf): class 0 (0)
leaf_class(85,14,0).
% node 15: RB1 <= 0.5  (F14, bin <= 0)  left -> 16, right -> 21
node(85,15,14,0).
left_node(85,15,16).
right_node(85,15,21).
% node 16: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 17, right -> 20
node(85,16,19,0).
left_node(85,16,17).
right_node(85,16,20).
% node 17: CIC <= 0.5  (F8, bin <= 0)  left -> 18, right -> 19
node(85,17,8,0).
left_node(85,17,18).
right_node(85,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(85,18,1).
% node 19 (leaf): class 0 (0)
leaf_class(85,19,0).
% node 20 (leaf): class 1 (1)
leaf_class(85,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(85,21,1).
% node 22: BCOR <= 0.5  (F16, bin <= 0)  left -> 23, right -> 24
node(85,22,16,0).
left_node(85,22,23).
right_node(85,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(85,23,0).
% node 24: Age_at_diagnosis <= 39.114999771118164  (F1, bin <= 37)  left -> 25, right -> 26
node(85,24,1,37).
left_node(85,24,25).
right_node(85,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(85,25,1).
% node 26 (leaf): class 0 (0)
leaf_class(85,26,0).

% Tree 86
tree(86).
% node 0: TP53 <= 0.5  (F4, bin <= 0)  left -> 1, right -> 16
node(86,0,4,0).
left_node(86,0,1).
right_node(86,0,16).
% node 1: IDH2 <= 0.5  (F20, bin <= 0)  left -> 2, right -> 15
node(86,1,20,0).
left_node(86,1,2).
right_node(86,1,15).
% node 2: IDH1 <= 0.5  (F3, bin <= 0)  left -> 3, right -> 10
node(86,2,3,0).
left_node(86,2,3).
right_node(86,2,10).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(86,3,14,0).
left_node(86,3,4).
right_node(86,3,7).
% node 4: PTEN <= 0.5  (F6, bin <= 0)  left -> 5, right -> 6
node(86,4,6,0).
left_node(86,4,5).
right_node(86,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(86,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(86,6,1).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(86,7,0,0).
left_node(86,7,8).
right_node(86,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(86,8,1).
% node 9 (leaf): class 0 (0)
leaf_class(86,9,0).
% node 10: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 11, right -> 12
node(86,10,12,0).
left_node(86,10,11).
right_node(86,10,12).
% node 11 (leaf): class 0 (0)
leaf_class(86,11,0).
% node 12: Age_at_diagnosis <= 59.474998474121094  (F1, bin <= 126)  left -> 13, right -> 14
node(86,12,1,126).
left_node(86,12,13).
right_node(86,12,14).
% node 13 (leaf): class 0 (0)
leaf_class(86,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(86,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(86,15,0).
% node 16: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 17, right -> 32
node(86,16,10,0).
left_node(86,16,17).
right_node(86,16,32).
% node 17: ATRX <= 0.5  (F5, bin <= 0)  left -> 18, right -> 25
node(86,17,5,0).
left_node(86,17,18).
right_node(86,17,25).
% node 18: Gender <= 0.5  (F0, bin <= 0)  left -> 19, right -> 22
node(86,18,0,0).
left_node(86,18,19).
right_node(86,18,22).
% node 19: Age_at_diagnosis <= 49.06500053405762  (F1, bin <= 93)  left -> 20, right -> 21
node(86,19,1,93).
left_node(86,19,20).
right_node(86,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(86,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(86,21,1).
% node 22: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 23, right -> 24
node(86,22,22,0).
left_node(86,22,23).
right_node(86,22,24).
% node 23 (leaf): class 1 (1)
leaf_class(86,23,1).
% node 24 (leaf): class 1 (1)
leaf_class(86,24,1).
% node 25: Age_at_diagnosis <= 31.270000457763672  (F1, bin <= 18)  left -> 26, right -> 29
node(86,25,1,18).
left_node(86,25,26).
right_node(86,25,29).
% node 26: MUC16 <= 0.5  (F9, bin <= 0)  left -> 27, right -> 28
node(86,26,9,0).
left_node(86,26,27).
right_node(86,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(86,27,0).
% node 28 (leaf): class 0 (0)
leaf_class(86,28,0).
% node 29: RB1 <= 0.5  (F14, bin <= 0)  left -> 30, right -> 31
node(86,29,14,0).
left_node(86,29,30).
right_node(86,29,31).
% node 30 (leaf): class 0 (0)
leaf_class(86,30,0).
% node 31 (leaf): class 1 (1)
leaf_class(86,31,1).
% node 32: EGFR <= 0.5  (F7, bin <= 0)  left -> 33, right -> 38
node(86,32,7,0).
left_node(86,32,33).
right_node(86,32,38).
% node 33: IDH1 <= 0.5  (F3, bin <= 0)  left -> 34, right -> 35
node(86,33,3,0).
left_node(86,33,34).
right_node(86,33,35).
% node 34 (leaf): class 1 (1)
leaf_class(86,34,1).
% node 35: Age_at_diagnosis <= 47.15999984741211  (F1, bin <= 79)  left -> 36, right -> 37
node(86,35,1,79).
left_node(86,35,36).
right_node(86,35,37).
% node 36 (leaf): class 1 (1)
leaf_class(86,36,1).
% node 37 (leaf): class 0 (0)
leaf_class(86,37,0).
% node 38: Race <= 0.5  (F2, bin <= 0)  left -> 39, right -> 42
node(86,38,2,0).
left_node(86,38,39).
right_node(86,38,42).
% node 39: Gender <= 0.5  (F0, bin <= 0)  left -> 40, right -> 41
node(86,39,0,0).
left_node(86,39,40).
right_node(86,39,41).
% node 40 (leaf): class 0 (0)
leaf_class(86,40,0).
% node 41 (leaf): class 1 (1)
leaf_class(86,41,1).
% node 42 (leaf): class 1 (1)
leaf_class(86,42,1).

% Tree 87
tree(87).
% node 0: Age_at_diagnosis <= 46.630001068115234  (F1, bin <= 75)  left -> 1, right -> 18
node(87,0,1,75).
left_node(87,0,1).
right_node(87,0,18).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(87,1,3,0).
left_node(87,1,2).
right_node(87,1,9).
% node 2: NF1 <= 0.5  (F11, bin <= 0)  left -> 3, right -> 8
node(87,2,11,0).
left_node(87,2,3).
right_node(87,2,8).
% node 3: IDH2 <= 0.5  (F20, bin <= 0)  left -> 4, right -> 7
node(87,3,20,0).
left_node(87,3,4).
right_node(87,3,7).
% node 4: RB1 <= 0.5  (F14, bin <= 0)  left -> 5, right -> 6
node(87,4,14,0).
left_node(87,4,5).
right_node(87,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(87,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(87,6,1).
% node 7 (leaf): class 0 (0)
leaf_class(87,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(87,8,0).
% node 9: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 10, right -> 17
node(87,9,15,0).
left_node(87,9,10).
right_node(87,9,17).
% node 10: ATRX <= 0.5  (F5, bin <= 0)  left -> 11, right -> 14
node(87,10,5,0).
left_node(87,10,11).
right_node(87,10,14).
% node 11: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 12, right -> 13
node(87,11,19,0).
left_node(87,11,12).
right_node(87,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(87,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(87,13,0).
% node 14: Race <= 1.5  (F2, bin <= 1)  left -> 15, right -> 16
node(87,14,2,1).
left_node(87,14,15).
right_node(87,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(87,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(87,16,1).
% node 17 (leaf): class 0 (0)
leaf_class(87,17,0).
% node 18: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 19, right -> 32
node(87,18,18,0).
left_node(87,18,19).
right_node(87,18,32).
% node 19: TP53 <= 0.5  (F4, bin <= 0)  left -> 20, right -> 25
node(87,19,4,0).
left_node(87,19,20).
right_node(87,19,25).
% node 20: IDH2 <= 0.5  (F20, bin <= 0)  left -> 21, right -> 24
node(87,20,20,0).
left_node(87,20,21).
right_node(87,20,24).
% node 21: IDH1 <= 0.5  (F3, bin <= 0)  left -> 22, right -> 23
node(87,21,3,0).
left_node(87,21,22).
right_node(87,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(87,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(87,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(87,24,0).
% node 25: Age_at_diagnosis <= 58.71500015258789  (F1, bin <= 123)  left -> 26, right -> 29
node(87,25,1,123).
left_node(87,25,26).
right_node(87,25,29).
% node 26: PTEN <= 0.5  (F6, bin <= 0)  left -> 27, right -> 28
node(87,26,6,0).
left_node(87,26,27).
right_node(87,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(87,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(87,28,1).
% node 29: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 30, right -> 31
node(87,29,10,0).
left_node(87,29,30).
right_node(87,29,31).
% node 30 (leaf): class 1 (1)
leaf_class(87,30,1).
% node 31 (leaf): class 0 (0)
leaf_class(87,31,0).
% node 32: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 33, right -> 34
node(87,32,17,0).
left_node(87,32,33).
right_node(87,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(87,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(87,34,1).

% Tree 88
tree(88).
% node 0: RB1 <= 0.5  (F14, bin <= 0)  left -> 1, right -> 22
node(88,0,14,0).
left_node(88,0,1).
right_node(88,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 9
node(88,1,3,0).
left_node(88,1,2).
right_node(88,1,9).
% node 2: CIC <= 0.5  (F8, bin <= 0)  left -> 3, right -> 8
node(88,2,8,0).
left_node(88,2,3).
right_node(88,2,8).
% node 3: Age_at_diagnosis <= 71.30000305175781  (F1, bin <= 157)  left -> 4, right -> 7
node(88,3,1,157).
left_node(88,3,4).
right_node(88,3,7).
% node 4: FAT4 <= 0.5  (F21, bin <= 0)  left -> 5, right -> 6
node(88,4,21,0).
left_node(88,4,5).
right_node(88,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(88,5,1).
% node 6 (leaf): class 1 (1)
leaf_class(88,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(88,7,1).
% node 8 (leaf): class 0 (0)
leaf_class(88,8,0).
% node 9: ATRX <= 0.5  (F5, bin <= 0)  left -> 10, right -> 15
node(88,9,5,0).
left_node(88,9,10).
right_node(88,9,15).
% node 10: NF1 <= 0.5  (F11, bin <= 0)  left -> 11, right -> 14
node(88,10,11,0).
left_node(88,10,11).
right_node(88,10,14).
% node 11: Age_at_diagnosis <= 43.529998779296875  (F1, bin <= 50)  left -> 12, right -> 13
node(88,11,1,50).
left_node(88,11,12).
right_node(88,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(88,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(88,13,0).
% node 14 (leaf): class 0 (0)
leaf_class(88,14,0).
% node 15: PTEN <= 0.5  (F6, bin <= 0)  left -> 16, right -> 19
node(88,15,6,0).
left_node(88,15,16).
right_node(88,15,19).
% node 16: BCOR <= 0.5  (F16, bin <= 0)  left -> 17, right -> 18
node(88,16,16,0).
left_node(88,16,17).
right_node(88,16,18).
% node 17 (leaf): class 0 (0)
leaf_class(88,17,0).
% node 18 (leaf): class 1 (1)
leaf_class(88,18,1).
% node 19: Age_at_diagnosis <= 45.35500144958496  (F1, bin <= 62)  left -> 20, right -> 21
node(88,19,1,62).
left_node(88,19,20).
right_node(88,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(88,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(88,21,0).
% node 22: Race <= 0.5  (F2, bin <= 0)  left -> 23, right -> 30
node(88,22,2,0).
left_node(88,22,23).
right_node(88,22,30).
% node 23: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 24, right -> 29
node(88,23,15,0).
left_node(88,23,24).
right_node(88,23,29).
% node 24: Age_at_diagnosis <= 38.56999969482422  (F1, bin <= 33)  left -> 25, right -> 26
node(88,24,1,33).
left_node(88,24,25).
right_node(88,24,26).
% node 25 (leaf): class 0 (0)
leaf_class(88,25,0).
% node 26: TP53 <= 0.5  (F4, bin <= 0)  left -> 27, right -> 28
node(88,26,4,0).
left_node(88,26,27).
right_node(88,26,28).
% node 27 (leaf): class 1 (1)
leaf_class(88,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(88,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(88,29,0).
% node 30: Age_at_diagnosis <= 49.53499984741211  (F1, bin <= 97)  left -> 31, right -> 32
node(88,30,1,97).
left_node(88,30,31).
right_node(88,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(88,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(88,32,0).

% Tree 89
tree(89).
% node 0: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 1, right -> 18
node(89,0,15,0).
left_node(89,0,1).
right_node(89,0,18).
% node 1: CIC <= 0.5  (F8, bin <= 0)  left -> 2, right -> 15
node(89,1,8,0).
left_node(89,1,2).
right_node(89,1,15).
% node 2: Age_at_diagnosis <= 43.64499855041504  (F1, bin <= 52)  left -> 3, right -> 8
node(89,2,1,52).
left_node(89,2,3).
right_node(89,2,8).
% node 3: RB1 <= 0.5  (F14, bin <= 0)  left -> 4, right -> 7
node(89,3,14,0).
left_node(89,3,4).
right_node(89,3,7).
% node 4: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 5, right -> 6
node(89,4,17,0).
left_node(89,4,5).
right_node(89,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(89,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(89,6,0).
% node 7 (leaf): class 1 (1)
leaf_class(89,7,1).
% node 8: Age_at_diagnosis <= 74.45000076293945  (F1, bin <= 166)  left -> 9, right -> 12
node(89,8,1,166).
left_node(89,8,9).
right_node(89,8,12).
% node 9: IDH2 <= 0.5  (F20, bin <= 0)  left -> 10, right -> 11
node(89,9,20,0).
left_node(89,9,10).
right_node(89,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(89,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(89,11,0).
% node 12: Gender <= 0.5  (F0, bin <= 0)  left -> 13, right -> 14
node(89,12,0,0).
left_node(89,12,13).
right_node(89,12,14).
% node 13 (leaf): class 1 (1)
leaf_class(89,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(89,14,1).
% node 15: EGFR <= 0.5  (F7, bin <= 0)  left -> 16, right -> 17
node(89,15,7,0).
left_node(89,15,16).
right_node(89,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(89,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(89,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(89,18,0).

% Tree 90
tree(90).
% node 0: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 110)  left -> 1, right -> 22
node(90,0,1,110).
left_node(90,0,1).
right_node(90,0,22).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 11
node(90,1,3,0).
left_node(90,1,2).
right_node(90,1,11).
% node 2: RB1 <= 0.5  (F14, bin <= 0)  left -> 3, right -> 8
node(90,2,14,0).
left_node(90,2,3).
right_node(90,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(90,3,8,0).
left_node(90,3,4).
right_node(90,3,7).
% node 4: IDH2 <= 0.5  (F20, bin <= 0)  left -> 5, right -> 6
node(90,4,20,0).
left_node(90,4,5).
right_node(90,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(90,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(90,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(90,7,0).
% node 8: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 9, right -> 10
node(90,8,18,0).
left_node(90,8,9).
right_node(90,8,10).
% node 9 (leaf): class 1 (1)
leaf_class(90,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(90,10,0).
% node 11: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 12, right -> 17
node(90,11,12,0).
left_node(90,11,12).
right_node(90,11,17).
% node 12: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 13, right -> 16
node(90,12,22,0).
left_node(90,12,13).
right_node(90,12,16).
% node 13: Age_at_diagnosis <= 25.244999885559082  (F1, bin <= 6)  left -> 14, right -> 15
node(90,13,1,6).
left_node(90,13,14).
right_node(90,13,15).
% node 14 (leaf): class 0 (0)
leaf_class(90,14,0).
% node 15 (leaf): class 0 (0)
leaf_class(90,15,0).
% node 16 (leaf): class 1 (1)
leaf_class(90,16,1).
% node 17: EGFR <= 0.5  (F7, bin <= 0)  left -> 18, right -> 21
node(90,17,7,0).
left_node(90,17,18).
right_node(90,17,21).
% node 18: Gender <= 0.5  (F0, bin <= 0)  left -> 19, right -> 20
node(90,18,0,0).
left_node(90,18,19).
right_node(90,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(90,19,1).
% node 20 (leaf): class 0 (0)
leaf_class(90,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(90,21,1).
% node 22: CIC <= 0.5  (F8, bin <= 0)  left -> 23, right -> 34
node(90,22,8,0).
left_node(90,22,23).
right_node(90,22,34).
% node 23: MUC16 <= 0.5  (F9, bin <= 0)  left -> 24, right -> 29
node(90,23,9,0).
left_node(90,23,24).
right_node(90,23,29).
% node 24: RB1 <= 0.5  (F14, bin <= 0)  left -> 25, right -> 28
node(90,24,14,0).
left_node(90,24,25).
right_node(90,24,28).
% node 25: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 26, right -> 27
node(90,25,19,0).
left_node(90,25,26).
right_node(90,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(90,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(90,27,1).
% node 28 (leaf): class 1 (1)
leaf_class(90,28,1).
% node 29: PTEN <= 0.5  (F6, bin <= 0)  left -> 30, right -> 33
node(90,29,6,0).
left_node(90,29,30).
right_node(90,29,33).
% node 30: Age_at_diagnosis <= 58.90500068664551  (F1, bin <= 125)  left -> 31, right -> 32
node(90,30,1,125).
left_node(90,30,31).
right_node(90,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(90,31,1).
% node 32 (leaf): class 1 (1)
leaf_class(90,32,1).
% node 33 (leaf): class 1 (1)
leaf_class(90,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(90,34,0).

% Tree 91
tree(91).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 20
node(91,0,5,0).
left_node(91,0,1).
right_node(91,0,20).
% node 1: EGFR <= 0.5  (F7, bin <= 0)  left -> 2, right -> 11
node(91,1,7,0).
left_node(91,1,2).
right_node(91,1,11).
% node 2: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 3, right -> 10
node(91,2,15,0).
left_node(91,2,3).
right_node(91,2,10).
% node 3: PTEN <= 0.5  (F6, bin <= 0)  left -> 4, right -> 7
node(91,3,6,0).
left_node(91,3,4).
right_node(91,3,7).
% node 4: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 5, right -> 6
node(91,4,22,0).
left_node(91,4,5).
right_node(91,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(91,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(91,6,1).
% node 7: Age_at_diagnosis <= 62.385000228881836  (F1, bin <= 132)  left -> 8, right -> 9
node(91,7,1,132).
left_node(91,7,8).
right_node(91,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(91,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(91,9,1).
% node 10 (leaf): class 0 (0)
leaf_class(91,10,0).
% node 11: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 12, right -> 19
node(91,11,19,0).
left_node(91,11,12).
right_node(91,11,19).
% node 12: Race <= 0.5  (F2, bin <= 0)  left -> 13, right -> 16
node(91,12,2,0).
left_node(91,12,13).
right_node(91,12,16).
% node 13: TP53 <= 0.5  (F4, bin <= 0)  left -> 14, right -> 15
node(91,13,4,0).
left_node(91,13,14).
right_node(91,13,15).
% node 14 (leaf): class 1 (1)
leaf_class(91,14,1).
% node 15 (leaf): class 1 (1)
leaf_class(91,15,1).
% node 16: BCOR <= 0.5  (F16, bin <= 0)  left -> 17, right -> 18
node(91,16,16,0).
left_node(91,16,17).
right_node(91,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(91,17,1).
% node 18 (leaf): class 1 (1)
leaf_class(91,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(91,19,1).
% node 20: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 21, right -> 28
node(91,20,10,0).
left_node(91,20,21).
right_node(91,20,28).
% node 21: EGFR <= 0.5  (F7, bin <= 0)  left -> 22, right -> 27
node(91,21,7,0).
left_node(91,21,22).
right_node(91,21,27).
% node 22: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 23, right -> 26
node(91,22,12,0).
left_node(91,22,23).
right_node(91,22,26).
% node 23: IDH2 <= 0.5  (F20, bin <= 0)  left -> 24, right -> 25
node(91,23,20,0).
left_node(91,23,24).
right_node(91,23,25).
% node 24 (leaf): class 0 (0)
leaf_class(91,24,0).
% node 25 (leaf): class 0 (0)
leaf_class(91,25,0).
% node 26 (leaf): class 1 (1)
leaf_class(91,26,1).
% node 27 (leaf): class 1 (1)
leaf_class(91,27,1).
% node 28: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 29, right -> 34
node(91,28,15,0).
left_node(91,28,29).
right_node(91,28,34).
% node 29: BCOR <= 0.5  (F16, bin <= 0)  left -> 30, right -> 33
node(91,29,16,0).
left_node(91,29,30).
right_node(91,29,33).
% node 30: Gender <= 0.5  (F0, bin <= 0)  left -> 31, right -> 32
node(91,30,0,0).
left_node(91,30,31).
right_node(91,30,32).
% node 31 (leaf): class 0 (0)
leaf_class(91,31,0).
% node 32 (leaf): class 1 (1)
leaf_class(91,32,1).
% node 33 (leaf): class 1 (1)
leaf_class(91,33,1).
% node 34 (leaf): class 0 (0)
leaf_class(91,34,0).

% Tree 92
tree(92).
% node 0: Age_at_diagnosis <= 45.35499954223633  (F1, bin <= 62)  left -> 1, right -> 22
node(92,0,1,62).
left_node(92,0,1).
right_node(92,0,22).
% node 1: TP53 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 9
node(92,1,4,0).
left_node(92,1,2).
right_node(92,1,9).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(92,2,20,0).
left_node(92,2,3).
right_node(92,2,8).
% node 3: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 4, right -> 7
node(92,3,15,0).
left_node(92,3,4).
right_node(92,3,7).
% node 4: Race <= 0.5  (F2, bin <= 0)  left -> 5, right -> 6
node(92,4,2,0).
left_node(92,4,5).
right_node(92,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(92,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(92,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(92,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(92,8,0).
% node 9: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 10, right -> 15
node(92,9,10,0).
left_node(92,9,10).
right_node(92,9,15).
% node 10: RB1 <= 0.5  (F14, bin <= 0)  left -> 11, right -> 14
node(92,10,14,0).
left_node(92,10,11).
right_node(92,10,14).
% node 11: PTEN <= 0.5  (F6, bin <= 0)  left -> 12, right -> 13
node(92,11,6,0).
left_node(92,11,12).
right_node(92,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(92,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(92,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(92,14,1).
% node 15: MUC16 <= 0.5  (F9, bin <= 0)  left -> 16, right -> 19
node(92,15,9,0).
left_node(92,15,16).
right_node(92,15,19).
% node 16: Age_at_diagnosis <= 28.954999923706055  (F1, bin <= 13)  left -> 17, right -> 18
node(92,16,1,13).
left_node(92,16,17).
right_node(92,16,18).
% node 17 (leaf): class 1 (1)
leaf_class(92,17,1).
% node 18 (leaf): class 0 (0)
leaf_class(92,18,0).
% node 19: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 20, right -> 21
node(92,19,12,0).
left_node(92,19,20).
right_node(92,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(92,20,0).
% node 21 (leaf): class 1 (1)
leaf_class(92,21,1).
% node 22: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 23, right -> 34
node(92,22,15,0).
left_node(92,22,23).
right_node(92,22,34).
% node 23: Age_at_diagnosis <= 74.06500244140625  (F1, bin <= 164)  left -> 24, right -> 29
node(92,23,1,164).
left_node(92,23,24).
right_node(92,23,29).
% node 24: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 25, right -> 28
node(92,24,19,0).
left_node(92,24,25).
right_node(92,24,28).
% node 25: ATRX <= 0.5  (F5, bin <= 0)  left -> 26, right -> 27
node(92,25,5,0).
left_node(92,25,26).
right_node(92,25,27).
% node 26 (leaf): class 1 (1)
leaf_class(92,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(92,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(92,28,1).
% node 29: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 30, right -> 33
node(92,29,13,0).
left_node(92,29,30).
right_node(92,29,33).
% node 30: Age_at_diagnosis <= 86.79499816894531  (F1, bin <= 171)  left -> 31, right -> 32
node(92,30,1,171).
left_node(92,30,31).
right_node(92,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(92,31,1).
% node 32 (leaf): class 0 (0)
leaf_class(92,32,0).
% node 33 (leaf): class 0 (0)
leaf_class(92,33,0).
% node 34 (leaf): class 0 (0)
leaf_class(92,34,0).

% Tree 93
tree(93).
% node 0: ATRX <= 0.5  (F5, bin <= 0)  left -> 1, right -> 16
node(93,0,5,0).
left_node(93,0,1).
right_node(93,0,16).
% node 1: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 2, right -> 9
node(93,1,12,0).
left_node(93,1,2).
right_node(93,1,9).
% node 2: IDH2 <= 0.5  (F20, bin <= 0)  left -> 3, right -> 8
node(93,2,20,0).
left_node(93,2,3).
right_node(93,2,8).
% node 3: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 4, right -> 7
node(93,3,15,0).
left_node(93,3,4).
right_node(93,3,7).
% node 4: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 5, right -> 6
node(93,4,18,0).
left_node(93,4,5).
right_node(93,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(93,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(93,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(93,7,0).
% node 8 (leaf): class 0 (0)
leaf_class(93,8,0).
% node 9: IDH1 <= 0.5  (F3, bin <= 0)  left -> 10, right -> 15
node(93,9,3,0).
left_node(93,9,10).
right_node(93,9,15).
% node 10: EGFR <= 0.5  (F7, bin <= 0)  left -> 11, right -> 14
node(93,10,7,0).
left_node(93,10,11).
right_node(93,10,14).
% node 11: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 12, right -> 13
node(93,11,17,0).
left_node(93,11,12).
right_node(93,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(93,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(93,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(93,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(93,15,0).
% node 16: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 17, right -> 30
node(93,16,12,0).
left_node(93,16,17).
right_node(93,16,30).
% node 17: Race <= 0.5  (F2, bin <= 0)  left -> 18, right -> 25
node(93,17,2,0).
left_node(93,17,18).
right_node(93,17,25).
% node 18: BCOR <= 0.5  (F16, bin <= 0)  left -> 19, right -> 22
node(93,18,16,0).
left_node(93,18,19).
right_node(93,18,22).
% node 19: Age_at_diagnosis <= 25.244999885559082  (F1, bin <= 6)  left -> 20, right -> 21
node(93,19,1,6).
left_node(93,19,20).
right_node(93,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(93,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(93,21,0).
% node 22: EGFR <= 0.5  (F7, bin <= 0)  left -> 23, right -> 24
node(93,22,7,0).
left_node(93,22,23).
right_node(93,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(93,23,0).
% node 24 (leaf): class 0 (0)
leaf_class(93,24,0).
% node 25: PTEN <= 0.5  (F6, bin <= 0)  left -> 26, right -> 29
node(93,25,6,0).
left_node(93,25,26).
right_node(93,25,29).
% node 26: Race <= 1.5  (F2, bin <= 1)  left -> 27, right -> 28
node(93,26,2,1).
left_node(93,26,27).
right_node(93,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(93,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(93,28,1).
% node 29 (leaf): class 1 (1)
leaf_class(93,29,1).
% node 30: Race <= 1.0  (F2, bin <= 1)  left -> 31, right -> 36
node(93,30,2,1).
left_node(93,30,31).
right_node(93,30,36).
% node 31: IDH1 <= 0.5  (F3, bin <= 0)  left -> 32, right -> 33
node(93,31,3,0).
left_node(93,31,32).
right_node(93,31,33).
% node 32 (leaf): class 1 (1)
leaf_class(93,32,1).
% node 33: TP53 <= 0.5  (F4, bin <= 0)  left -> 34, right -> 35
node(93,33,4,0).
left_node(93,33,34).
right_node(93,33,35).
% node 34 (leaf): class 1 (1)
leaf_class(93,34,1).
% node 35 (leaf): class 0 (0)
leaf_class(93,35,0).
% node 36 (leaf): class 1 (1)
leaf_class(93,36,1).

% Tree 94
tree(94).
% node 0: Age_at_diagnosis <= 45.35499954223633  (F1, bin <= 62)  left -> 1, right -> 16
node(94,0,1,62).
left_node(94,0,1).
right_node(94,0,16).
% node 1: Age_at_diagnosis <= 24.0  (F1, bin <= 2)  left -> 2, right -> 9
node(94,1,1,2).
left_node(94,1,2).
right_node(94,1,9).
% node 2: MUC16 <= 0.5  (F9, bin <= 0)  left -> 3, right -> 8
node(94,2,9,0).
left_node(94,2,3).
right_node(94,2,8).
% node 3: PIK3CA <= 0.5  (F10, bin <= 0)  left -> 4, right -> 7
node(94,3,10,0).
left_node(94,3,4).
right_node(94,3,7).
% node 4: EGFR <= 0.5  (F7, bin <= 0)  left -> 5, right -> 6
node(94,4,7,0).
left_node(94,4,5).
right_node(94,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(94,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(94,6,1).
% node 7 (leaf): class 1 (1)
leaf_class(94,7,1).
% node 8 (leaf): class 1 (1)
leaf_class(94,8,1).
% node 9: NF1 <= 0.5  (F11, bin <= 0)  left -> 10, right -> 15
node(94,9,11,0).
left_node(94,9,10).
right_node(94,9,15).
% node 10: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 11, right -> 14
node(94,10,22,0).
left_node(94,10,11).
right_node(94,10,14).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(94,11,3,0).
left_node(94,11,12).
right_node(94,11,13).
% node 12 (leaf): class 0 (0)
leaf_class(94,12,0).
% node 13 (leaf): class 0 (0)
leaf_class(94,13,0).
% node 14 (leaf): class 1 (1)
leaf_class(94,14,1).
% node 15 (leaf): class 0 (0)
leaf_class(94,15,0).
% node 16: CIC <= 0.5  (F8, bin <= 0)  left -> 17, right -> 26
node(94,16,8,0).
left_node(94,16,17).
right_node(94,16,26).
% node 17: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 18, right -> 25
node(94,17,15,0).
left_node(94,17,18).
right_node(94,17,25).
% node 18: ATRX <= 0.5  (F5, bin <= 0)  left -> 19, right -> 22
node(94,18,5,0).
left_node(94,18,19).
right_node(94,18,22).
% node 19: MUC16 <= 0.5  (F9, bin <= 0)  left -> 20, right -> 21
node(94,19,9,0).
left_node(94,19,20).
right_node(94,19,21).
% node 20 (leaf): class 1 (1)
leaf_class(94,20,1).
% node 21 (leaf): class 1 (1)
leaf_class(94,21,1).
% node 22: PTEN <= 0.5  (F6, bin <= 0)  left -> 23, right -> 24
node(94,22,6,0).
left_node(94,22,23).
right_node(94,22,24).
% node 23 (leaf): class 0 (0)
leaf_class(94,23,0).
% node 24 (leaf): class 1 (1)
leaf_class(94,24,1).
% node 25 (leaf): class 0 (0)
leaf_class(94,25,0).
% node 26 (leaf): class 0 (0)
leaf_class(94,26,0).

% Tree 95
tree(95).
% node 0: IDH2 <= 0.5  (F20, bin <= 0)  left -> 1, right -> 26
node(95,0,20,0).
left_node(95,0,1).
right_node(95,0,26).
% node 1: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 2, right -> 17
node(95,1,18,0).
left_node(95,1,2).
right_node(95,1,17).
% node 2: Race <= 0.5  (F2, bin <= 0)  left -> 3, right -> 10
node(95,2,2,0).
left_node(95,2,3).
right_node(95,2,10).
% node 3: ATRX <= 0.5  (F5, bin <= 0)  left -> 4, right -> 7
node(95,3,5,0).
left_node(95,3,4).
right_node(95,3,7).
% node 4: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 5, right -> 6
node(95,4,13,0).
left_node(95,4,5).
right_node(95,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(95,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(95,6,0).
% node 7: IDH1 <= 0.5  (F3, bin <= 0)  left -> 8, right -> 9
node(95,7,3,0).
left_node(95,7,8).
right_node(95,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(95,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(95,9,0).
% node 10: Race <= 1.5  (F2, bin <= 1)  left -> 11, right -> 14
node(95,10,2,1).
left_node(95,10,11).
right_node(95,10,14).
% node 11: IDH1 <= 0.5  (F3, bin <= 0)  left -> 12, right -> 13
node(95,11,3,0).
left_node(95,11,12).
right_node(95,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(95,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(95,13,0).
% node 14: Age_at_diagnosis <= 45.579999923706055  (F1, bin <= 66)  left -> 15, right -> 16
node(95,14,1,66).
left_node(95,14,15).
right_node(95,14,16).
% node 15 (leaf): class 0 (0)
leaf_class(95,15,0).
% node 16 (leaf): class 0 (0)
leaf_class(95,16,0).
% node 17: RB1 <= 0.5  (F14, bin <= 0)  left -> 18, right -> 23
node(95,17,14,0).
left_node(95,17,18).
right_node(95,17,23).
% node 18: ATRX <= 0.5  (F5, bin <= 0)  left -> 19, right -> 22
node(95,18,5,0).
left_node(95,18,19).
right_node(95,18,22).
% node 19: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 20, right -> 21
node(95,19,17,0).
left_node(95,19,20).
right_node(95,19,21).
% node 20 (leaf): class 0 (0)
leaf_class(95,20,0).
% node 21 (leaf): class 0 (0)
leaf_class(95,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(95,22,0).
% node 23: MUC16 <= 0.5  (F9, bin <= 0)  left -> 24, right -> 25
node(95,23,9,0).
left_node(95,23,24).
right_node(95,23,25).
% node 24 (leaf): class 1 (1)
leaf_class(95,24,1).
% node 25 (leaf): class 0 (0)
leaf_class(95,25,0).
% node 26: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 27, right -> 28
node(95,26,19,0).
left_node(95,26,27).
right_node(95,26,28).
% node 27 (leaf): class 0 (0)
leaf_class(95,27,0).
% node 28 (leaf): class 1 (1)
leaf_class(95,28,1).

% Tree 96
tree(96).
% node 0: CIC <= 0.5  (F8, bin <= 0)  left -> 1, right -> 22
node(96,0,8,0).
left_node(96,0,1).
right_node(96,0,22).
% node 1: Age_at_diagnosis <= 48.920000076293945  (F1, bin <= 91)  left -> 2, right -> 13
node(96,1,1,91).
left_node(96,1,2).
right_node(96,1,13).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 8
node(96,2,7,0).
left_node(96,2,3).
right_node(96,2,8).
% node 3: FAT4 <= 0.5  (F21, bin <= 0)  left -> 4, right -> 7
node(96,3,21,0).
left_node(96,3,4).
right_node(96,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(96,4,3,0).
left_node(96,4,5).
right_node(96,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(96,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(96,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(96,7,0).
% node 8: TP53 <= 0.5  (F4, bin <= 0)  left -> 9, right -> 12
node(96,8,4,0).
left_node(96,8,9).
right_node(96,8,12).
% node 9: IDH1 <= 0.5  (F3, bin <= 0)  left -> 10, right -> 11
node(96,9,3,0).
left_node(96,9,10).
right_node(96,9,11).
% node 10 (leaf): class 1 (1)
leaf_class(96,10,1).
% node 11 (leaf): class 0 (0)
leaf_class(96,11,0).
% node 12 (leaf): class 1 (1)
leaf_class(96,12,1).
% node 13: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 14, right -> 21
node(96,13,13,0).
left_node(96,13,14).
right_node(96,13,21).
% node 14: PTEN <= 0.5  (F6, bin <= 0)  left -> 15, right -> 18
node(96,14,6,0).
left_node(96,14,15).
right_node(96,14,18).
% node 15: Age_at_diagnosis <= 71.8900032043457  (F1, bin <= 162)  left -> 16, right -> 17
node(96,15,1,162).
left_node(96,15,16).
right_node(96,15,17).
% node 16 (leaf): class 1 (1)
leaf_class(96,16,1).
% node 17 (leaf): class 1 (1)
leaf_class(96,17,1).
% node 18: CSMD3 <= 0.5  (F17, bin <= 0)  left -> 19, right -> 20
node(96,18,17,0).
left_node(96,18,19).
right_node(96,18,20).
% node 19 (leaf): class 1 (1)
leaf_class(96,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(96,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(96,21,0).
% node 22 (leaf): class 0 (0)
leaf_class(96,22,0).

% Tree 97
tree(97).
% node 0: PTEN <= 0.5  (F6, bin <= 0)  left -> 1, right -> 14
node(97,0,6,0).
left_node(97,0,1).
right_node(97,0,14).
% node 1: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 2, right -> 13
node(97,1,15,0).
left_node(97,1,2).
right_node(97,1,13).
% node 2: ATRX <= 0.5  (F5, bin <= 0)  left -> 3, right -> 8
node(97,2,5,0).
left_node(97,2,3).
right_node(97,2,8).
% node 3: CIC <= 0.5  (F8, bin <= 0)  left -> 4, right -> 7
node(97,3,8,0).
left_node(97,3,4).
right_node(97,3,7).
% node 4: IDH1 <= 0.5  (F3, bin <= 0)  left -> 5, right -> 6
node(97,4,3,0).
left_node(97,4,5).
right_node(97,4,6).
% node 5 (leaf): class 1 (1)
leaf_class(97,5,1).
% node 6 (leaf): class 0 (0)
leaf_class(97,6,0).
% node 7 (leaf): class 0 (0)
leaf_class(97,7,0).
% node 8: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 9, right -> 12
node(97,8,22,0).
left_node(97,8,9).
right_node(97,8,12).
% node 9: EGFR <= 0.5  (F7, bin <= 0)  left -> 10, right -> 11
node(97,9,7,0).
left_node(97,9,10).
right_node(97,9,11).
% node 10 (leaf): class 0 (0)
leaf_class(97,10,0).
% node 11 (leaf): class 1 (1)
leaf_class(97,11,1).
% node 12 (leaf): class 1 (1)
leaf_class(97,12,1).
% node 13 (leaf): class 0 (0)
leaf_class(97,13,0).
% node 14: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 15, right -> 22
node(97,14,12,0).
left_node(97,14,15).
right_node(97,14,22).
% node 15: IDH1 <= 0.5  (F3, bin <= 0)  left -> 16, right -> 21
node(97,15,3,0).
left_node(97,15,16).
right_node(97,15,21).
% node 16: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 17, right -> 20
node(97,16,19,0).
left_node(97,16,17).
right_node(97,16,20).
% node 17: TP53 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(97,17,4,0).
left_node(97,17,18).
right_node(97,17,19).
% node 18 (leaf): class 1 (1)
leaf_class(97,18,1).
% node 19 (leaf): class 1 (1)
leaf_class(97,19,1).
% node 20 (leaf): class 1 (1)
leaf_class(97,20,1).
% node 21 (leaf): class 0 (0)
leaf_class(97,21,0).
% node 22 (leaf): class 1 (1)
leaf_class(97,22,1).

% Tree 98
tree(98).
% node 0: Age_at_diagnosis <= 52.6200008392334  (F1, bin <= 110)  left -> 1, right -> 18
node(98,0,1,110).
left_node(98,0,1).
right_node(98,0,18).
% node 1: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 2, right -> 15
node(98,1,19,0).
left_node(98,1,2).
right_node(98,1,15).
% node 2: EGFR <= 0.5  (F7, bin <= 0)  left -> 3, right -> 10
node(98,2,7,0).
left_node(98,2,3).
right_node(98,2,10).
% node 3: Age_at_diagnosis <= 30.854999542236328  (F1, bin <= 15)  left -> 4, right -> 7
node(98,3,1,15).
left_node(98,3,4).
right_node(98,3,7).
% node 4: CIC <= 0.5  (F8, bin <= 0)  left -> 5, right -> 6
node(98,4,8,0).
left_node(98,4,5).
right_node(98,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(98,5,0).
% node 6 (leaf): class 0 (0)
leaf_class(98,6,0).
% node 7: CIC <= 0.5  (F8, bin <= 0)  left -> 8, right -> 9
node(98,7,8,0).
left_node(98,7,8).
right_node(98,7,9).
% node 8 (leaf): class 0 (0)
leaf_class(98,8,0).
% node 9 (leaf): class 0 (0)
leaf_class(98,9,0).
% node 10: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 11, right -> 14
node(98,10,12,0).
left_node(98,10,11).
right_node(98,10,14).
% node 11: MUC16 <= 0.5  (F9, bin <= 0)  left -> 12, right -> 13
node(98,11,9,0).
left_node(98,11,12).
right_node(98,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(98,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(98,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(98,14,1).
% node 15: IDH2 <= 0.5  (F20, bin <= 0)  left -> 16, right -> 17
node(98,15,20,0).
left_node(98,15,16).
right_node(98,15,17).
% node 16 (leaf): class 0 (0)
leaf_class(98,16,0).
% node 17 (leaf): class 1 (1)
leaf_class(98,17,1).
% node 18: PDGFRA <= 0.5  (F22, bin <= 0)  left -> 19, right -> 28
node(98,18,22,0).
left_node(98,18,19).
right_node(98,18,28).
% node 19: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 20, right -> 27
node(98,19,15,0).
left_node(98,19,20).
right_node(98,19,27).
% node 20: MUC16 <= 0.5  (F9, bin <= 0)  left -> 21, right -> 24
node(98,20,9,0).
left_node(98,20,21).
right_node(98,20,24).
% node 21: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 22, right -> 23
node(98,21,19,0).
left_node(98,21,22).
right_node(98,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(98,22,1).
% node 23 (leaf): class 1 (1)
leaf_class(98,23,1).
% node 24: Age_at_diagnosis <= 68.0  (F1, bin <= 150)  left -> 25, right -> 26
node(98,24,1,150).
left_node(98,24,25).
right_node(98,24,26).
% node 25 (leaf): class 1 (1)
leaf_class(98,25,1).
% node 26 (leaf): class 1 (1)
leaf_class(98,26,1).
% node 27 (leaf): class 0 (0)
leaf_class(98,27,0).
% node 28: MUC16 <= 0.5  (F9, bin <= 0)  left -> 29, right -> 30
node(98,28,9,0).
left_node(98,28,29).
right_node(98,28,30).
% node 29 (leaf): class 1 (1)
leaf_class(98,29,1).
% node 30: Gender <= 0.5  (F0, bin <= 0)  left -> 31, right -> 32
node(98,30,0,0).
left_node(98,30,31).
right_node(98,30,32).
% node 31 (leaf): class 1 (1)
leaf_class(98,31,1).
% node 32: Age_at_diagnosis <= 66.13000106811523  (F1, bin <= 142)  left -> 33, right -> 34
node(98,32,1,142).
left_node(98,32,33).
right_node(98,32,34).
% node 33 (leaf): class 0 (0)
leaf_class(98,33,0).
% node 34 (leaf): class 1 (1)
leaf_class(98,34,1).

% Tree 99
tree(99).
% node 0: Age_at_diagnosis <= 50.8650016784668  (F1, bin <= 101)  left -> 1, right -> 24
node(99,0,1,101).
left_node(99,0,1).
right_node(99,0,24).
% node 1: IDH1 <= 0.5  (F3, bin <= 0)  left -> 2, right -> 15
node(99,1,3,0).
left_node(99,1,2).
right_node(99,1,15).
% node 2: PTEN <= 0.5  (F6, bin <= 0)  left -> 3, right -> 10
node(99,2,6,0).
left_node(99,2,3).
right_node(99,2,10).
% node 3: Race <= 0.5  (F2, bin <= 0)  left -> 4, right -> 7
node(99,3,2,0).
left_node(99,3,4).
right_node(99,3,7).
% node 4: MUC16 <= 0.5  (F9, bin <= 0)  left -> 5, right -> 6
node(99,4,9,0).
left_node(99,4,5).
right_node(99,4,6).
% node 5 (leaf): class 0 (0)
leaf_class(99,5,0).
% node 6 (leaf): class 1 (1)
leaf_class(99,6,1).
% node 7: Gender <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(99,7,0,0).
left_node(99,7,8).
right_node(99,7,9).
% node 8 (leaf): class 1 (1)
leaf_class(99,8,1).
% node 9 (leaf): class 1 (1)
leaf_class(99,9,1).
% node 10: MUC16 <= 0.5  (F9, bin <= 0)  left -> 11, right -> 14
node(99,10,9,0).
left_node(99,10,11).
right_node(99,10,14).
% node 11: Gender <= 0.5  (F0, bin <= 0)  left -> 12, right -> 13
node(99,11,0,0).
left_node(99,11,12).
right_node(99,11,13).
% node 12 (leaf): class 1 (1)
leaf_class(99,12,1).
% node 13 (leaf): class 1 (1)
leaf_class(99,13,1).
% node 14 (leaf): class 1 (1)
leaf_class(99,14,1).
% node 15: PIK3R1 <= 0.5  (F12, bin <= 0)  left -> 16, right -> 21
node(99,15,12,0).
left_node(99,15,16).
right_node(99,15,21).
% node 16: NOTCH1 <= 0.5  (F15, bin <= 0)  left -> 17, right -> 20
node(99,16,15,0).
left_node(99,16,17).
right_node(99,16,20).
% node 17: GRIN2A <= 0.5  (F19, bin <= 0)  left -> 18, right -> 19
node(99,17,19,0).
left_node(99,17,18).
right_node(99,17,19).
% node 18 (leaf): class 0 (0)
leaf_class(99,18,0).
% node 19 (leaf): class 0 (0)
leaf_class(99,19,0).
% node 20 (leaf): class 0 (0)
leaf_class(99,20,0).
% node 21: Age_at_diagnosis <= 35.195000648498535  (F1, bin <= 26)  left -> 22, right -> 23
node(99,21,1,26).
left_node(99,21,22).
right_node(99,21,23).
% node 22 (leaf): class 1 (1)
leaf_class(99,22,1).
% node 23 (leaf): class 0 (0)
leaf_class(99,23,0).
% node 24: PTEN <= 0.5  (F6, bin <= 0)  left -> 25, right -> 36
node(99,24,6,0).
left_node(99,24,25).
right_node(99,24,36).
% node 25: MUC16 <= 0.5  (F9, bin <= 0)  left -> 26, right -> 31
node(99,25,9,0).
left_node(99,25,26).
right_node(99,25,31).
% node 26: SMARCA4 <= 0.5  (F18, bin <= 0)  left -> 27, right -> 30
node(99,26,18,0).
left_node(99,26,27).
right_node(99,26,30).
% node 27: FUBP1 <= 0.5  (F13, bin <= 0)  left -> 28, right -> 29
node(99,27,13,0).
left_node(99,27,28).
right_node(99,27,29).
% node 28 (leaf): class 1 (1)
leaf_class(99,28,1).
% node 29 (leaf): class 0 (0)
leaf_class(99,29,0).
% node 30 (leaf): class 0 (0)
leaf_class(99,30,0).
% node 31: IDH1 <= 0.5  (F3, bin <= 0)  left -> 32, right -> 35
node(99,31,3,0).
left_node(99,31,32).
right_node(99,31,35).
% node 32: EGFR <= 0.5  (F7, bin <= 0)  left -> 33, right -> 34
node(99,32,7,0).
left_node(99,32,33).
right_node(99,32,34).
% node 33 (leaf): class 1 (1)
leaf_class(99,33,1).
% node 34 (leaf): class 1 (1)
leaf_class(99,34,1).
% node 35 (leaf): class 0 (0)
leaf_class(99,35,0).
% node 36: IDH1 <= 0.5  (F3, bin <= 0)  left -> 37, right -> 44
node(99,36,3,0).
left_node(99,36,37).
right_node(99,36,44).
% node 37: NF1 <= 0.5  (F11, bin <= 0)  left -> 38, right -> 41
node(99,37,11,0).
left_node(99,37,38).
right_node(99,37,41).
% node 38: MUC16 <= 0.5  (F9, bin <= 0)  left -> 39, right -> 40
node(99,38,9,0).
left_node(99,38,39).
right_node(99,38,40).
% node 39 (leaf): class 1 (1)
leaf_class(99,39,1).
% node 40 (leaf): class 1 (1)
leaf_class(99,40,1).
% node 41: EGFR <= 0.5  (F7, bin <= 0)  left -> 42, right -> 43
node(99,41,7,0).
left_node(99,41,42).
right_node(99,41,43).
% node 42 (leaf): class 1 (1)
leaf_class(99,42,1).
% node 43 (leaf): class 0 (0)
leaf_class(99,43,0).
% node 44 (leaf): class 0 (0)
leaf_class(99,44,0).

% --- Class domain ---
class_idx(0).  % 0
class_idx(1).  % 1
