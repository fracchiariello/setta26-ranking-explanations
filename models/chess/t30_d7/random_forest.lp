% ============================================================
% random_forest.lp — RF facts for chess
% 30 trees  |  6 features
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

% Feature 0 (f0): 4 bins  (thresholds: [0.5, 1.5, 2.5])
{bin(I,0,B) : B = 0..3} = 1 :- item(I).

% Feature 1 (f1): 4 bins  (thresholds: [1.5, 2.5, 3.5])
{bin(I,1,B) : B = 0..3} = 1 :- item(I).

% Feature 2 (f2): 8 bins  (thresholds: [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5])
{bin(I,2,B) : B = 0..7} = 1 :- item(I).

% Feature 3 (f3): 8 bins  (thresholds: [1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5])
{bin(I,3,B) : B = 0..7} = 1 :- item(I).

% Feature 4 (f4): 10 bins  (thresholds: [0.5, 1.5, 2.0, 2.5, 3.0, 3.5, 4.5, 5.5, 6.5])
{bin(I,4,B) : B = 0..9} = 1 :- item(I).

% Feature 5 (f5): 7 bins  (thresholds: [1.5, 2.5, 3.5, 5.5, 6.5, 7.5])
{bin(I,5,B) : B = 0..6} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: f1 <= 1.5  (F1, bin <= 0)  left -> 1, right -> 24
node(0,0,1,0).
left_node(0,0,1).
right_node(0,0,24).
% node 1: f4 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 3
node(0,1,4,0).
left_node(0,1,2).
right_node(0,1,3).
% node 2 (leaf): class twelve (13)
leaf_class(0,2,13).
% node 3: f5 <= 2.5  (F5, bin <= 1)  left -> 4, right -> 5
node(0,3,5,1).
left_node(0,3,4).
right_node(0,3,5).
% node 4 (leaf): class twelve (13)
leaf_class(0,4,13).
% node 5: f5 <= 6.5  (F5, bin <= 4)  left -> 6, right -> 19
node(0,5,5,4).
left_node(0,5,6).
right_node(0,5,19).
% node 6: f0 <= 1.5  (F0, bin <= 1)  left -> 7, right -> 12
node(0,6,0,1).
left_node(0,6,7).
right_node(0,6,12).
% node 7: f4 <= 6.5  (F4, bin <= 8)  left -> 8, right -> 11
node(0,7,4,8).
left_node(0,7,8).
right_node(0,7,11).
% node 8: f0 <= 0.5  (F0, bin <= 0)  left -> 9, right -> 10
node(0,8,0,0).
left_node(0,8,9).
right_node(0,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(0,9,16).
% node 10 (leaf): class fifteen (16)
leaf_class(0,10,16).
% node 11 (leaf): class fourteen (15)
leaf_class(0,11,15).
% node 12: f3 <= 5.5  (F3, bin <= 4)  left -> 13, right -> 16
node(0,12,3,4).
left_node(0,12,13).
right_node(0,12,16).
% node 13: f4 <= 6.5  (F4, bin <= 8)  left -> 14, right -> 15
node(0,13,4,8).
left_node(0,13,14).
right_node(0,13,15).
% node 14 (leaf): class fourteen (15)
leaf_class(0,14,15).
% node 15 (leaf): class thirteen (14)
leaf_class(0,15,14).
% node 16: f2 <= 0.5  (F2, bin <= 0)  left -> 17, right -> 18
node(0,16,2,0).
left_node(0,16,17).
right_node(0,16,18).
% node 17 (leaf): class fourteen (15)
leaf_class(0,17,15).
% node 18 (leaf): class fifteen (16)
leaf_class(0,18,16).
% node 19: f4 <= 1.5  (F4, bin <= 1)  left -> 20, right -> 21
node(0,19,4,1).
left_node(0,19,20).
right_node(0,19,21).
% node 20 (leaf): class thirteen (14)
leaf_class(0,20,14).
% node 21: f3 <= 5.5  (F3, bin <= 4)  left -> 22, right -> 23
node(0,21,3,4).
left_node(0,21,22).
right_node(0,21,23).
% node 22 (leaf): class fourteen (15)
leaf_class(0,22,15).
% node 23 (leaf): class draw (0)
leaf_class(0,23,0).
% node 24: f1 <= 2.5  (F1, bin <= 1)  left -> 25, right -> 44
node(0,24,1,1).
left_node(0,24,25).
right_node(0,24,44).
% node 25: f3 <= 4.5  (F3, bin <= 3)  left -> 26, right -> 37
node(0,25,3,3).
left_node(0,25,26).
right_node(0,25,37).
% node 26: f5 <= 3.5  (F5, bin <= 2)  left -> 27, right -> 30
node(0,26,5,2).
left_node(0,26,27).
right_node(0,26,30).
% node 27: f2 <= 3.5  (F2, bin <= 3)  left -> 28, right -> 29
node(0,27,2,3).
left_node(0,27,28).
right_node(0,27,29).
% node 28 (leaf): class eight (9)
leaf_class(0,28,9).
% node 29 (leaf): class draw (0)
leaf_class(0,29,0).
% node 30: f0 <= 1.5  (F0, bin <= 1)  left -> 31, right -> 32
node(0,30,0,1).
left_node(0,30,31).
right_node(0,30,32).
% node 31 (leaf): class fourteen (15)
leaf_class(0,31,15).
% node 32: f0 <= 2.5  (F0, bin <= 2)  left -> 33, right -> 34
node(0,32,0,2).
left_node(0,32,33).
right_node(0,32,34).
% node 33 (leaf): class thirteen (14)
leaf_class(0,33,14).
% node 34: f4 <= 0.5  (F4, bin <= 0)  left -> 35, right -> 36
node(0,34,4,0).
left_node(0,34,35).
right_node(0,34,36).
% node 35 (leaf): class eleven (12)
leaf_class(0,35,12).
% node 36 (leaf): class thirteen (14)
leaf_class(0,36,14).
% node 37: f0 <= 1.5  (F0, bin <= 1)  left -> 38, right -> 39
node(0,37,0,1).
left_node(0,37,38).
right_node(0,37,39).
% node 38 (leaf): class thirteen (14)
leaf_class(0,38,14).
% node 39: f4 <= 1.5  (F4, bin <= 1)  left -> 40, right -> 41
node(0,39,4,1).
left_node(0,39,40).
right_node(0,39,41).
% node 40 (leaf): class twelve (13)
leaf_class(0,40,13).
% node 41: f5 <= 2.5  (F5, bin <= 1)  left -> 42, right -> 43
node(0,41,5,1).
left_node(0,41,42).
right_node(0,41,43).
% node 42 (leaf): class eight (9)
leaf_class(0,42,9).
% node 43 (leaf): class thirteen (14)
leaf_class(0,43,14).
% node 44: f5 <= 2.5  (F5, bin <= 1)  left -> 45, right -> 52
node(0,44,5,1).
left_node(0,44,45).
right_node(0,44,52).
% node 45: f0 <= 2.5  (F0, bin <= 2)  left -> 46, right -> 49
node(0,45,0,2).
left_node(0,45,46).
right_node(0,45,49).
% node 46: f4 <= 2.5  (F4, bin <= 3)  left -> 47, right -> 48
node(0,46,4,3).
left_node(0,46,47).
right_node(0,46,48).
% node 47 (leaf): class two (3)
leaf_class(0,47,3).
% node 48 (leaf): class ten (11)
leaf_class(0,48,11).
% node 49: f5 <= 1.5  (F5, bin <= 0)  left -> 50, right -> 51
node(0,49,5,0).
left_node(0,49,50).
right_node(0,49,51).
% node 50 (leaf): class eight (9)
leaf_class(0,50,9).
% node 51 (leaf): class eight (9)
leaf_class(0,51,9).
% node 52: f1 <= 3.5  (F1, bin <= 2)  left -> 53, right -> 60
node(0,52,1,2).
left_node(0,52,53).
right_node(0,52,60).
% node 53: f4 <= 1.5  (F4, bin <= 1)  left -> 54, right -> 55
node(0,53,4,1).
left_node(0,53,54).
right_node(0,53,55).
% node 54 (leaf): class ten (11)
leaf_class(0,54,11).
% node 55: f5 <= 7.5  (F5, bin <= 5)  left -> 56, right -> 59
node(0,55,5,5).
left_node(0,55,56).
right_node(0,55,59).
% node 56: f4 <= 6.5  (F4, bin <= 8)  left -> 57, right -> 58
node(0,56,4,8).
left_node(0,56,57).
right_node(0,56,58).
% node 57 (leaf): class twelve (13)
leaf_class(0,57,13).
% node 58 (leaf): class eleven (12)
leaf_class(0,58,12).
% node 59 (leaf): class eleven (12)
leaf_class(0,59,12).
% node 60: f2 <= 5.5  (F2, bin <= 5)  left -> 61, right -> 62
node(0,60,2,5).
left_node(0,60,61).
right_node(0,60,62).
% node 61 (leaf): class nine (10)
leaf_class(0,61,10).
% node 62 (leaf): class eleven (12)
leaf_class(0,62,12).

% Tree 1
tree(1).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 30
node(1,0,5,1).
left_node(1,0,1).
right_node(1,0,30).
% node 1: f4 <= 1.5  (F4, bin <= 1)  left -> 2, right -> 9
node(1,1,4,1).
left_node(1,1,2).
right_node(1,1,9).
% node 2: f0 <= 2.5  (F0, bin <= 2)  left -> 3, right -> 4
node(1,2,0,2).
left_node(1,2,3).
right_node(1,2,4).
% node 3 (leaf): class two (3)
leaf_class(1,3,3).
% node 4: f3 <= 3.5  (F3, bin <= 2)  left -> 5, right -> 6
node(1,4,3,2).
left_node(1,4,5).
right_node(1,4,6).
% node 5 (leaf): class four (5)
leaf_class(1,5,5).
% node 6: f1 <= 3.5  (F1, bin <= 2)  left -> 7, right -> 8
node(1,6,1,2).
left_node(1,6,7).
right_node(1,6,8).
% node 7 (leaf): class five (6)
leaf_class(1,7,6).
% node 8 (leaf): class eight (9)
leaf_class(1,8,9).
% node 9: f5 <= 1.5  (F5, bin <= 0)  left -> 10, right -> 19
node(1,9,5,0).
left_node(1,9,10).
right_node(1,9,19).
% node 10: f3 <= 2.5  (F3, bin <= 1)  left -> 11, right -> 14
node(1,10,3,1).
left_node(1,10,11).
right_node(1,10,14).
% node 11: f3 <= 1.5  (F3, bin <= 0)  left -> 12, right -> 13
node(1,11,3,0).
left_node(1,11,12).
right_node(1,11,13).
% node 12 (leaf): class nine (10)
leaf_class(1,12,10).
% node 13 (leaf): class draw (0)
leaf_class(1,13,0).
% node 14: f0 <= 1.5  (F0, bin <= 1)  left -> 15, right -> 16
node(1,14,0,1).
left_node(1,14,15).
right_node(1,14,16).
% node 15 (leaf): class ten (11)
leaf_class(1,15,11).
% node 16: f4 <= 3.5  (F4, bin <= 5)  left -> 17, right -> 18
node(1,16,4,5).
left_node(1,16,17).
right_node(1,16,18).
% node 17 (leaf): class eight (9)
leaf_class(1,17,9).
% node 18 (leaf): class eight (9)
leaf_class(1,18,9).
% node 19: f2 <= 3.5  (F2, bin <= 3)  left -> 20, right -> 27
node(1,19,2,3).
left_node(1,19,20).
right_node(1,19,27).
% node 20: f4 <= 6.5  (F4, bin <= 8)  left -> 21, right -> 26
node(1,20,4,8).
left_node(1,20,21).
right_node(1,20,26).
% node 21: f4 <= 4.5  (F4, bin <= 6)  left -> 22, right -> 25
node(1,21,4,6).
left_node(1,21,22).
right_node(1,21,25).
% node 22: f1 <= 2.5  (F1, bin <= 1)  left -> 23, right -> 24
node(1,22,1,1).
left_node(1,22,23).
right_node(1,22,24).
% node 23 (leaf): class fifteen (16)
leaf_class(1,23,16).
% node 24 (leaf): class ten (11)
leaf_class(1,24,11).
% node 25 (leaf): class ten (11)
leaf_class(1,25,11).
% node 26 (leaf): class eight (9)
leaf_class(1,26,9).
% node 27: f0 <= 2.5  (F0, bin <= 2)  left -> 28, right -> 29
node(1,27,0,2).
left_node(1,27,28).
right_node(1,27,29).
% node 28 (leaf): class draw (0)
leaf_class(1,28,0).
% node 29 (leaf): class eight (9)
leaf_class(1,29,9).
% node 30: f5 <= 6.5  (F5, bin <= 4)  left -> 31, right -> 60
node(1,30,5,4).
left_node(1,30,31).
right_node(1,30,60).
% node 31: f4 <= 6.5  (F4, bin <= 8)  left -> 32, right -> 49
node(1,31,4,8).
left_node(1,31,32).
right_node(1,31,49).
% node 32: f0 <= 1.5  (F0, bin <= 1)  left -> 33, right -> 40
node(1,32,0,1).
left_node(1,32,33).
right_node(1,32,40).
% node 33: f4 <= 0.5  (F4, bin <= 0)  left -> 34, right -> 35
node(1,33,4,0).
left_node(1,33,34).
right_node(1,33,35).
% node 34 (leaf): class eleven (12)
leaf_class(1,34,12).
% node 35: f0 <= 0.5  (F0, bin <= 0)  left -> 36, right -> 37
node(1,35,0,0).
left_node(1,35,36).
right_node(1,35,37).
% node 36 (leaf): class fifteen (16)
leaf_class(1,36,16).
% node 37: f1 <= 1.5  (F1, bin <= 0)  left -> 38, right -> 39
node(1,37,1,0).
left_node(1,37,38).
right_node(1,37,39).
% node 38 (leaf): class fifteen (16)
leaf_class(1,38,16).
% node 39 (leaf): class fourteen (15)
leaf_class(1,39,15).
% node 40: f4 <= 0.5  (F4, bin <= 0)  left -> 41, right -> 42
node(1,40,4,0).
left_node(1,40,41).
right_node(1,40,42).
% node 41 (leaf): class eleven (12)
leaf_class(1,41,12).
% node 42: f2 <= 0.5  (F2, bin <= 0)  left -> 43, right -> 46
node(1,42,2,0).
left_node(1,42,43).
right_node(1,42,46).
% node 43: f4 <= 1.5  (F4, bin <= 1)  left -> 44, right -> 45
node(1,43,4,1).
left_node(1,43,44).
right_node(1,43,45).
% node 44 (leaf): class draw (0)
leaf_class(1,44,0).
% node 45 (leaf): class fourteen (15)
leaf_class(1,45,15).
% node 46: f0 <= 2.5  (F0, bin <= 2)  left -> 47, right -> 48
node(1,46,0,2).
left_node(1,46,47).
right_node(1,46,48).
% node 47 (leaf): class fourteen (15)
leaf_class(1,47,15).
% node 48 (leaf): class fourteen (15)
leaf_class(1,48,15).
% node 49: f2 <= 5.5  (F2, bin <= 5)  left -> 50, right -> 59
node(1,49,2,5).
left_node(1,49,50).
right_node(1,49,59).
% node 50: f2 <= 3.5  (F2, bin <= 3)  left -> 51, right -> 58
node(1,50,2,3).
left_node(1,50,51).
right_node(1,50,58).
% node 51: f0 <= 1.5  (F0, bin <= 1)  left -> 52, right -> 55
node(1,51,0,1).
left_node(1,51,52).
right_node(1,51,55).
% node 52: f1 <= 1.5  (F1, bin <= 0)  left -> 53, right -> 54
node(1,52,1,0).
left_node(1,52,53).
right_node(1,52,54).
% node 53 (leaf): class fourteen (15)
leaf_class(1,53,15).
% node 54 (leaf): class thirteen (14)
leaf_class(1,54,14).
% node 55: f0 <= 2.5  (F0, bin <= 2)  left -> 56, right -> 57
node(1,55,0,2).
left_node(1,55,56).
right_node(1,55,57).
% node 56 (leaf): class thirteen (14)
leaf_class(1,56,14).
% node 57 (leaf): class nine (10)
leaf_class(1,57,10).
% node 58 (leaf): class twelve (13)
leaf_class(1,58,13).
% node 59 (leaf): class draw (0)
leaf_class(1,59,0).
% node 60: f1 <= 1.5  (F1, bin <= 0)  left -> 61, right -> 72
node(1,60,1,0).
left_node(1,60,61).
right_node(1,60,72).
% node 61: f3 <= 5.5  (F3, bin <= 4)  left -> 62, right -> 71
node(1,61,3,4).
left_node(1,61,62).
right_node(1,61,71).
% node 62: f2 <= 2.5  (F2, bin <= 2)  left -> 63, right -> 68
node(1,62,2,2).
left_node(1,62,63).
right_node(1,62,68).
% node 63: f4 <= 1.5  (F4, bin <= 1)  left -> 64, right -> 65
node(1,63,4,1).
left_node(1,63,64).
right_node(1,63,65).
% node 64 (leaf): class nine (10)
leaf_class(1,64,10).
% node 65: f4 <= 6.5  (F4, bin <= 8)  left -> 66, right -> 67
node(1,65,4,8).
left_node(1,65,66).
right_node(1,65,67).
% node 66 (leaf): class fourteen (15)
leaf_class(1,66,15).
% node 67 (leaf): class thirteen (14)
leaf_class(1,67,14).
% node 68: f2 <= 4.5  (F2, bin <= 4)  left -> 69, right -> 70
node(1,68,2,4).
left_node(1,68,69).
right_node(1,68,70).
% node 69 (leaf): class thirteen (14)
leaf_class(1,69,14).
% node 70 (leaf): class fourteen (15)
leaf_class(1,70,15).
% node 71 (leaf): class draw (0)
leaf_class(1,71,0).
% node 72: f0 <= 2.5  (F0, bin <= 2)  left -> 73, right -> 74
node(1,72,0,2).
left_node(1,72,73).
right_node(1,72,74).
% node 73 (leaf): class thirteen (14)
leaf_class(1,73,14).
% node 74: f3 <= 5.5  (F3, bin <= 4)  left -> 75, right -> 80
node(1,74,3,4).
left_node(1,74,75).
right_node(1,74,80).
% node 75: f4 <= 0.5  (F4, bin <= 0)  left -> 76, right -> 77
node(1,75,4,0).
left_node(1,75,76).
right_node(1,75,77).
% node 76 (leaf): class nine (10)
leaf_class(1,76,10).
% node 77: f4 <= 6.5  (F4, bin <= 8)  left -> 78, right -> 79
node(1,77,4,8).
left_node(1,77,78).
right_node(1,77,79).
% node 78 (leaf): class twelve (13)
leaf_class(1,78,13).
% node 79 (leaf): class eleven (12)
leaf_class(1,79,12).
% node 80 (leaf): class draw (0)
leaf_class(1,80,0).

% Tree 2
tree(2).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 58
node(2,0,4,8).
left_node(2,0,1).
right_node(2,0,58).
% node 1: f5 <= 2.5  (F5, bin <= 1)  left -> 2, right -> 15
node(2,1,5,1).
left_node(2,1,2).
right_node(2,1,15).
% node 2: f3 <= 3.5  (F3, bin <= 2)  left -> 3, right -> 4
node(2,2,3,2).
left_node(2,2,3).
right_node(2,2,4).
% node 3 (leaf): class draw (0)
leaf_class(2,3,0).
% node 4: f1 <= 2.5  (F1, bin <= 1)  left -> 5, right -> 10
node(2,4,1,1).
left_node(2,4,5).
right_node(2,4,10).
% node 5: f0 <= 1.5  (F0, bin <= 1)  left -> 6, right -> 7
node(2,5,0,1).
left_node(2,5,6).
right_node(2,5,7).
% node 6 (leaf): class twelve (13)
leaf_class(2,6,13).
% node 7: f0 <= 2.5  (F0, bin <= 2)  left -> 8, right -> 9
node(2,7,0,2).
left_node(2,7,8).
right_node(2,7,9).
% node 8 (leaf): class nine (10)
leaf_class(2,8,10).
% node 9 (leaf): class five (6)
leaf_class(2,9,6).
% node 10: f1 <= 3.5  (F1, bin <= 2)  left -> 11, right -> 12
node(2,10,1,2).
left_node(2,10,11).
right_node(2,10,12).
% node 11 (leaf): class eight (9)
leaf_class(2,11,9).
% node 12: f4 <= 3.5  (F4, bin <= 5)  left -> 13, right -> 14
node(2,12,4,5).
left_node(2,12,13).
right_node(2,12,14).
% node 13 (leaf): class eight (9)
leaf_class(2,13,9).
% node 14 (leaf): class nine (10)
leaf_class(2,14,10).
% node 15: f4 <= 1.5  (F4, bin <= 1)  left -> 16, right -> 31
node(2,15,4,1).
left_node(2,15,16).
right_node(2,15,31).
% node 16: f3 <= 3.5  (F3, bin <= 2)  left -> 17, right -> 24
node(2,16,3,2).
left_node(2,16,17).
right_node(2,16,24).
% node 17: f4 <= 0.5  (F4, bin <= 0)  left -> 18, right -> 19
node(2,17,4,0).
left_node(2,17,18).
right_node(2,17,19).
% node 18 (leaf): class eleven (12)
leaf_class(2,18,12).
% node 19: f1 <= 1.5  (F1, bin <= 0)  left -> 20, right -> 23
node(2,19,1,0).
left_node(2,19,20).
right_node(2,19,23).
% node 20: f5 <= 7.5  (F5, bin <= 5)  left -> 21, right -> 22
node(2,20,5,5).
left_node(2,20,21).
right_node(2,20,22).
% node 21 (leaf): class fourteen (15)
leaf_class(2,21,15).
% node 22 (leaf): class twelve (13)
leaf_class(2,22,13).
% node 23 (leaf): class twelve (13)
leaf_class(2,23,13).
% node 24: f4 <= 0.5  (F4, bin <= 0)  left -> 25, right -> 30
node(2,24,4,0).
left_node(2,24,25).
right_node(2,24,30).
% node 25: f2 <= 1.5  (F2, bin <= 1)  left -> 26, right -> 27
node(2,25,2,1).
left_node(2,25,26).
right_node(2,25,27).
% node 26 (leaf): class draw (0)
leaf_class(2,26,0).
% node 27: f1 <= 1.5  (F1, bin <= 0)  left -> 28, right -> 29
node(2,27,1,0).
left_node(2,27,28).
right_node(2,27,29).
% node 28 (leaf): class twelve (13)
leaf_class(2,28,13).
% node 29 (leaf): class nine (10)
leaf_class(2,29,10).
% node 30 (leaf): class fourteen (15)
leaf_class(2,30,15).
% node 31: f5 <= 6.5  (F5, bin <= 4)  left -> 32, right -> 45
node(2,31,5,4).
left_node(2,31,32).
right_node(2,31,45).
% node 32: f1 <= 2.5  (F1, bin <= 1)  left -> 33, right -> 40
node(2,32,1,1).
left_node(2,32,33).
right_node(2,32,40).
% node 33: f0 <= 1.5  (F0, bin <= 1)  left -> 34, right -> 37
node(2,33,0,1).
left_node(2,33,34).
right_node(2,33,37).
% node 34: f4 <= 4.5  (F4, bin <= 6)  left -> 35, right -> 36
node(2,34,4,6).
left_node(2,34,35).
right_node(2,34,36).
% node 35 (leaf): class fifteen (16)
leaf_class(2,35,16).
% node 36 (leaf): class fourteen (15)
leaf_class(2,36,15).
% node 37: f1 <= 1.5  (F1, bin <= 0)  left -> 38, right -> 39
node(2,37,1,0).
left_node(2,37,38).
right_node(2,37,39).
% node 38 (leaf): class fourteen (15)
leaf_class(2,38,15).
% node 39 (leaf): class thirteen (14)
leaf_class(2,39,14).
% node 40: f5 <= 3.5  (F5, bin <= 2)  left -> 41, right -> 44
node(2,40,5,2).
left_node(2,40,41).
right_node(2,40,44).
% node 41: f0 <= 2.5  (F0, bin <= 2)  left -> 42, right -> 43
node(2,41,0,2).
left_node(2,41,42).
right_node(2,41,43).
% node 42 (leaf): class twelve (13)
leaf_class(2,42,13).
% node 43 (leaf): class eleven (12)
leaf_class(2,43,12).
% node 44 (leaf): class twelve (13)
leaf_class(2,44,13).
% node 45: f5 <= 7.5  (F5, bin <= 5)  left -> 46, right -> 51
node(2,45,5,5).
left_node(2,45,46).
right_node(2,45,51).
% node 46: f1 <= 1.5  (F1, bin <= 0)  left -> 47, right -> 50
node(2,46,1,0).
left_node(2,46,47).
right_node(2,46,50).
% node 47: f3 <= 5.5  (F3, bin <= 4)  left -> 48, right -> 49
node(2,47,3,4).
left_node(2,47,48).
right_node(2,47,49).
% node 48 (leaf): class fourteen (15)
leaf_class(2,48,15).
% node 49 (leaf): class draw (0)
leaf_class(2,49,0).
% node 50 (leaf): class thirteen (14)
leaf_class(2,50,14).
% node 51: f1 <= 1.5  (F1, bin <= 0)  left -> 52, right -> 55
node(2,51,1,0).
left_node(2,51,52).
right_node(2,51,55).
% node 52: f3 <= 5.5  (F3, bin <= 4)  left -> 53, right -> 54
node(2,52,3,4).
left_node(2,52,53).
right_node(2,52,54).
% node 53 (leaf): class fourteen (15)
leaf_class(2,53,15).
% node 54 (leaf): class thirteen (14)
leaf_class(2,54,14).
% node 55: f1 <= 2.5  (F1, bin <= 1)  left -> 56, right -> 57
node(2,55,1,1).
left_node(2,55,56).
right_node(2,55,57).
% node 56 (leaf): class thirteen (14)
leaf_class(2,56,14).
% node 57 (leaf): class eleven (12)
leaf_class(2,57,12).
% node 58: f5 <= 2.5  (F5, bin <= 1)  left -> 59, right -> 66
node(2,58,5,1).
left_node(2,58,59).
right_node(2,58,66).
% node 59: f0 <= 2.5  (F0, bin <= 2)  left -> 60, right -> 63
node(2,59,0,2).
left_node(2,59,60).
right_node(2,59,63).
% node 60: f0 <= 1.5  (F0, bin <= 1)  left -> 61, right -> 62
node(2,60,0,1).
left_node(2,60,61).
right_node(2,60,62).
% node 61 (leaf): class twelve (13)
leaf_class(2,61,13).
% node 62 (leaf): class eight (9)
leaf_class(2,62,9).
% node 63: f5 <= 1.5  (F5, bin <= 0)  left -> 64, right -> 65
node(2,63,5,0).
left_node(2,63,64).
right_node(2,63,65).
% node 64 (leaf): class six (7)
leaf_class(2,64,7).
% node 65 (leaf): class eight (9)
leaf_class(2,65,9).
% node 66: f0 <= 1.5  (F0, bin <= 1)  left -> 67, right -> 70
node(2,66,0,1).
left_node(2,66,67).
right_node(2,66,70).
% node 67: f0 <= 0.5  (F0, bin <= 0)  left -> 68, right -> 69
node(2,67,0,0).
left_node(2,67,68).
right_node(2,67,69).
% node 68 (leaf): class fourteen (15)
leaf_class(2,68,15).
% node 69 (leaf): class thirteen (14)
leaf_class(2,69,14).
% node 70: f0 <= 2.5  (F0, bin <= 2)  left -> 71, right -> 72
node(2,70,0,2).
left_node(2,70,71).
right_node(2,70,72).
% node 71 (leaf): class twelve (13)
leaf_class(2,71,13).
% node 72 (leaf): class nine (10)
leaf_class(2,72,10).

% Tree 3
tree(3).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 32
node(3,0,5,1).
left_node(3,0,1).
right_node(3,0,32).
% node 1: f0 <= 2.5  (F0, bin <= 2)  left -> 2, right -> 17
node(3,1,0,2).
left_node(3,1,2).
right_node(3,1,17).
% node 2: f4 <= 1.5  (F4, bin <= 1)  left -> 3, right -> 4
node(3,2,4,1).
left_node(3,2,3).
right_node(3,2,4).
% node 3 (leaf): class two (3)
leaf_class(3,3,3).
% node 4: f0 <= 1.5  (F0, bin <= 1)  left -> 5, right -> 14
node(3,4,0,1).
left_node(3,4,5).
right_node(3,4,14).
% node 5: f3 <= 3.5  (F3, bin <= 2)  left -> 6, right -> 9
node(3,5,3,2).
left_node(3,5,6).
right_node(3,5,9).
% node 6: f3 <= 2.5  (F3, bin <= 1)  left -> 7, right -> 8
node(3,6,3,1).
left_node(3,6,7).
right_node(3,6,8).
% node 7 (leaf): class draw (0)
leaf_class(3,7,0).
% node 8 (leaf): class nine (10)
leaf_class(3,8,10).
% node 9: f5 <= 1.5  (F5, bin <= 0)  left -> 10, right -> 13
node(3,9,5,0).
left_node(3,9,10).
right_node(3,9,13).
% node 10: f2 <= 3.5  (F2, bin <= 3)  left -> 11, right -> 12
node(3,10,2,3).
left_node(3,10,11).
right_node(3,10,12).
% node 11 (leaf): class ten (11)
leaf_class(3,11,11).
% node 12 (leaf): class twelve (13)
leaf_class(3,12,13).
% node 13 (leaf): class fourteen (15)
leaf_class(3,13,15).
% node 14: f3 <= 3.5  (F3, bin <= 2)  left -> 15, right -> 16
node(3,14,3,2).
left_node(3,14,15).
right_node(3,14,16).
% node 15 (leaf): class draw (0)
leaf_class(3,15,0).
% node 16 (leaf): class ten (11)
leaf_class(3,16,11).
% node 17: f4 <= 1.5  (F4, bin <= 1)  left -> 18, right -> 19
node(3,17,4,1).
left_node(3,17,18).
right_node(3,17,19).
% node 18 (leaf): class five (6)
leaf_class(3,18,6).
% node 19: f1 <= 2.5  (F1, bin <= 1)  left -> 20, right -> 25
node(3,19,1,1).
left_node(3,19,20).
right_node(3,19,25).
% node 20: f2 <= 4.5  (F2, bin <= 4)  left -> 21, right -> 24
node(3,20,2,4).
left_node(3,20,21).
right_node(3,20,24).
% node 21: f5 <= 1.5  (F5, bin <= 0)  left -> 22, right -> 23
node(3,21,5,0).
left_node(3,21,22).
right_node(3,21,23).
% node 22 (leaf): class six (7)
leaf_class(3,22,7).
% node 23 (leaf): class eight (9)
leaf_class(3,23,9).
% node 24 (leaf): class draw (0)
leaf_class(3,24,0).
% node 25: f4 <= 6.5  (F4, bin <= 8)  left -> 26, right -> 29
node(3,25,4,8).
left_node(3,25,26).
right_node(3,25,29).
% node 26: f3 <= 4.5  (F3, bin <= 3)  left -> 27, right -> 28
node(3,26,3,3).
left_node(3,26,27).
right_node(3,26,28).
% node 27 (leaf): class eight (9)
leaf_class(3,27,9).
% node 28 (leaf): class eight (9)
leaf_class(3,28,9).
% node 29: f5 <= 1.5  (F5, bin <= 0)  left -> 30, right -> 31
node(3,29,5,0).
left_node(3,29,30).
right_node(3,29,31).
% node 30 (leaf): class seven (8)
leaf_class(3,30,8).
% node 31 (leaf): class eight (9)
leaf_class(3,31,9).
% node 32: f0 <= 1.5  (F0, bin <= 1)  left -> 33, right -> 50
node(3,32,0,1).
left_node(3,32,33).
right_node(3,32,50).
% node 33: f0 <= 0.5  (F0, bin <= 0)  left -> 34, right -> 45
node(3,33,0,0).
left_node(3,33,34).
right_node(3,33,45).
% node 34: f3 <= 1.5  (F3, bin <= 0)  left -> 35, right -> 38
node(3,34,3,0).
left_node(3,34,35).
right_node(3,34,38).
% node 35: f4 <= 6.5  (F4, bin <= 8)  left -> 36, right -> 37
node(3,35,4,8).
left_node(3,35,36).
right_node(3,35,37).
% node 36 (leaf): class fifteen (16)
leaf_class(3,36,16).
% node 37 (leaf): class thirteen (14)
leaf_class(3,37,14).
% node 38: f5 <= 6.5  (F5, bin <= 4)  left -> 39, right -> 44
node(3,38,5,4).
left_node(3,38,39).
right_node(3,38,44).
% node 39: f2 <= 0.5  (F2, bin <= 0)  left -> 40, right -> 41
node(3,39,2,0).
left_node(3,39,40).
right_node(3,39,41).
% node 40 (leaf): class fifteen (16)
leaf_class(3,40,16).
% node 41: f4 <= 5.5  (F4, bin <= 7)  left -> 42, right -> 43
node(3,41,4,7).
left_node(3,41,42).
right_node(3,41,43).
% node 42 (leaf): class sixteen (17)
leaf_class(3,42,17).
% node 43 (leaf): class fifteen (16)
leaf_class(3,43,16).
% node 44 (leaf): class fourteen (15)
leaf_class(3,44,15).
% node 45: f4 <= 6.5  (F4, bin <= 8)  left -> 46, right -> 49
node(3,45,4,8).
left_node(3,45,46).
right_node(3,45,49).
% node 46: f3 <= 1.5  (F3, bin <= 0)  left -> 47, right -> 48
node(3,46,3,0).
left_node(3,46,47).
right_node(3,46,48).
% node 47 (leaf): class fourteen (15)
leaf_class(3,47,15).
% node 48 (leaf): class fourteen (15)
leaf_class(3,48,15).
% node 49 (leaf): class thirteen (14)
leaf_class(3,49,14).
% node 50: f3 <= 3.5  (F3, bin <= 2)  left -> 51, right -> 74
node(3,50,3,2).
left_node(3,50,51).
right_node(3,50,74).
% node 51: f1 <= 1.5  (F1, bin <= 0)  left -> 52, right -> 59
node(3,51,1,0).
left_node(3,51,52).
right_node(3,51,59).
% node 52: f2 <= 0.5  (F2, bin <= 0)  left -> 53, right -> 54
node(3,52,2,0).
left_node(3,52,53).
right_node(3,52,54).
% node 53 (leaf): class fourteen (15)
leaf_class(3,53,15).
% node 54: f5 <= 6.5  (F5, bin <= 4)  left -> 55, right -> 58
node(3,54,5,4).
left_node(3,54,55).
right_node(3,54,58).
% node 55: f4 <= 0.5  (F4, bin <= 0)  left -> 56, right -> 57
node(3,55,4,0).
left_node(3,55,56).
right_node(3,55,57).
% node 56 (leaf): class thirteen (14)
leaf_class(3,56,14).
% node 57 (leaf): class fourteen (15)
leaf_class(3,57,15).
% node 58 (leaf): class fourteen (15)
leaf_class(3,58,15).
% node 59: f0 <= 2.5  (F0, bin <= 2)  left -> 60, right -> 67
node(3,59,0,2).
left_node(3,59,60).
right_node(3,59,67).
% node 60: f1 <= 2.5  (F1, bin <= 1)  left -> 61, right -> 64
node(3,60,1,1).
left_node(3,60,61).
right_node(3,60,64).
% node 61: f4 <= 1.5  (F4, bin <= 1)  left -> 62, right -> 63
node(3,61,4,1).
left_node(3,61,62).
right_node(3,61,63).
% node 62 (leaf): class eleven (12)
leaf_class(3,62,12).
% node 63 (leaf): class thirteen (14)
leaf_class(3,63,14).
% node 64: f4 <= 5.5  (F4, bin <= 7)  left -> 65, right -> 66
node(3,64,4,7).
left_node(3,64,65).
right_node(3,64,66).
% node 65 (leaf): class thirteen (14)
leaf_class(3,65,14).
% node 66 (leaf): class twelve (13)
leaf_class(3,66,13).
% node 67: f1 <= 2.5  (F1, bin <= 1)  left -> 68, right -> 71
node(3,67,1,1).
left_node(3,67,68).
right_node(3,67,71).
% node 68: f4 <= 6.5  (F4, bin <= 8)  left -> 69, right -> 70
node(3,68,4,8).
left_node(3,68,69).
right_node(3,68,70).
% node 69 (leaf): class thirteen (14)
leaf_class(3,69,14).
% node 70 (leaf): class eleven (12)
leaf_class(3,70,12).
% node 71: f1 <= 3.5  (F1, bin <= 2)  left -> 72, right -> 73
node(3,71,1,2).
left_node(3,71,72).
right_node(3,71,73).
% node 72 (leaf): class twelve (13)
leaf_class(3,72,13).
% node 73 (leaf): class eleven (12)
leaf_class(3,73,12).
% node 74: f0 <= 2.5  (F0, bin <= 2)  left -> 75, right -> 78
node(3,74,0,2).
left_node(3,74,75).
right_node(3,74,78).
% node 75: f1 <= 1.5  (F1, bin <= 0)  left -> 76, right -> 77
node(3,75,1,0).
left_node(3,75,76).
right_node(3,75,77).
% node 76 (leaf): class fourteen (15)
leaf_class(3,76,15).
% node 77 (leaf): class thirteen (14)
leaf_class(3,77,14).
% node 78: f1 <= 1.5  (F1, bin <= 0)  left -> 79, right -> 80
node(3,78,1,0).
left_node(3,78,79).
right_node(3,78,80).
% node 79 (leaf): class fourteen (15)
leaf_class(3,79,15).
% node 80: f4 <= 6.5  (F4, bin <= 8)  left -> 81, right -> 82
node(3,80,4,8).
left_node(3,80,81).
right_node(3,80,82).
% node 81 (leaf): class eleven (12)
leaf_class(3,81,12).
% node 82 (leaf): class nine (10)
leaf_class(3,82,10).

% Tree 4
tree(4).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 24
node(4,0,5,1).
left_node(4,0,1).
right_node(4,0,24).
% node 1: f3 <= 3.5  (F3, bin <= 2)  left -> 2, right -> 5
node(4,1,3,2).
left_node(4,1,2).
right_node(4,1,5).
% node 2: f2 <= 3.5  (F2, bin <= 3)  left -> 3, right -> 4
node(4,2,2,3).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class eight (9)
leaf_class(4,3,9).
% node 4 (leaf): class draw (0)
leaf_class(4,4,0).
% node 5: f1 <= 2.5  (F1, bin <= 1)  left -> 6, right -> 17
node(4,5,1,1).
left_node(4,5,6).
right_node(4,5,17).
% node 6: f0 <= 1.5  (F0, bin <= 1)  left -> 7, right -> 8
node(4,6,0,1).
left_node(4,6,7).
right_node(4,6,8).
% node 7 (leaf): class twelve (13)
leaf_class(4,7,13).
% node 8: f0 <= 2.5  (F0, bin <= 2)  left -> 9, right -> 12
node(4,8,0,2).
left_node(4,8,9).
right_node(4,8,12).
% node 9: f4 <= 2.0  (F4, bin <= 2)  left -> 10, right -> 11
node(4,9,4,2).
left_node(4,9,10).
right_node(4,9,11).
% node 10 (leaf): class two (3)
leaf_class(4,10,3).
% node 11 (leaf): class nine (10)
leaf_class(4,11,10).
% node 12: f5 <= 1.5  (F5, bin <= 0)  left -> 13, right -> 16
node(4,12,5,0).
left_node(4,12,13).
right_node(4,12,16).
% node 13: f2 <= 4.5  (F2, bin <= 4)  left -> 14, right -> 15
node(4,13,2,4).
left_node(4,13,14).
right_node(4,13,15).
% node 14 (leaf): class six (7)
leaf_class(4,14,7).
% node 15 (leaf): class four (5)
leaf_class(4,15,5).
% node 16 (leaf): class eight (9)
leaf_class(4,16,9).
% node 17: f1 <= 3.5  (F1, bin <= 2)  left -> 18, right -> 19
node(4,17,1,2).
left_node(4,17,18).
right_node(4,17,19).
% node 18 (leaf): class eight (9)
leaf_class(4,18,9).
% node 19: f5 <= 1.5  (F5, bin <= 0)  left -> 20, right -> 21
node(4,19,5,0).
left_node(4,19,20).
right_node(4,19,21).
% node 20 (leaf): class eight (9)
leaf_class(4,20,9).
% node 21: f4 <= 3.5  (F4, bin <= 5)  left -> 22, right -> 23
node(4,21,4,5).
left_node(4,21,22).
right_node(4,21,23).
% node 22 (leaf): class eight (9)
leaf_class(4,22,9).
% node 23 (leaf): class ten (11)
leaf_class(4,23,11).
% node 24: f1 <= 1.5  (F1, bin <= 0)  left -> 25, right -> 48
node(4,24,1,0).
left_node(4,24,25).
right_node(4,24,48).
% node 25: f5 <= 6.5  (F5, bin <= 4)  left -> 26, right -> 43
node(4,25,5,4).
left_node(4,25,26).
right_node(4,25,43).
% node 26: f0 <= 1.5  (F0, bin <= 1)  left -> 27, right -> 34
node(4,26,0,1).
left_node(4,26,27).
right_node(4,26,34).
% node 27: f2 <= 0.5  (F2, bin <= 0)  left -> 28, right -> 29
node(4,27,2,0).
left_node(4,27,28).
right_node(4,27,29).
% node 28 (leaf): class fourteen (15)
leaf_class(4,28,15).
% node 29: f2 <= 2.5  (F2, bin <= 2)  left -> 30, right -> 31
node(4,29,2,2).
left_node(4,29,30).
right_node(4,29,31).
% node 30 (leaf): class fifteen (16)
leaf_class(4,30,16).
% node 31: f4 <= 1.5  (F4, bin <= 1)  left -> 32, right -> 33
node(4,31,4,1).
left_node(4,31,32).
right_node(4,31,33).
% node 32 (leaf): class fourteen (15)
leaf_class(4,32,15).
% node 33 (leaf): class fifteen (16)
leaf_class(4,33,16).
% node 34: f0 <= 2.5  (F0, bin <= 2)  left -> 35, right -> 40
node(4,34,0,2).
left_node(4,34,35).
right_node(4,34,40).
% node 35: f2 <= 0.5  (F2, bin <= 0)  left -> 36, right -> 37
node(4,35,2,0).
left_node(4,35,36).
right_node(4,35,37).
% node 36 (leaf): class fourteen (15)
leaf_class(4,36,15).
% node 37: f2 <= 6.5  (F2, bin <= 6)  left -> 38, right -> 39
node(4,37,2,6).
left_node(4,37,38).
right_node(4,37,39).
% node 38 (leaf): class fifteen (16)
leaf_class(4,38,16).
% node 39 (leaf): class fourteen (15)
leaf_class(4,39,15).
% node 40: f4 <= 6.5  (F4, bin <= 8)  left -> 41, right -> 42
node(4,40,4,8).
left_node(4,40,41).
right_node(4,40,42).
% node 41 (leaf): class fourteen (15)
leaf_class(4,41,15).
% node 42 (leaf): class twelve (13)
leaf_class(4,42,13).
% node 43: f0 <= 1.5  (F0, bin <= 1)  left -> 44, right -> 47
node(4,43,0,1).
left_node(4,43,44).
right_node(4,43,47).
% node 44: f3 <= 5.5  (F3, bin <= 4)  left -> 45, right -> 46
node(4,44,3,4).
left_node(4,44,45).
right_node(4,44,46).
% node 45 (leaf): class fourteen (15)
leaf_class(4,45,15).
% node 46 (leaf): class draw (0)
leaf_class(4,46,0).
% node 47 (leaf): class fourteen (15)
leaf_class(4,47,15).
% node 48: f4 <= 0.5  (F4, bin <= 0)  left -> 49, right -> 50
node(4,48,4,0).
left_node(4,48,49).
right_node(4,48,50).
% node 49 (leaf): class ten (11)
leaf_class(4,49,11).
% node 50: f1 <= 2.5  (F1, bin <= 1)  left -> 51, right -> 62
node(4,50,1,1).
left_node(4,50,51).
right_node(4,50,62).
% node 51: f4 <= 6.5  (F4, bin <= 8)  left -> 52, right -> 57
node(4,51,4,8).
left_node(4,51,52).
right_node(4,51,57).
% node 52: f5 <= 5.5  (F5, bin <= 3)  left -> 53, right -> 54
node(4,52,5,3).
left_node(4,52,53).
right_node(4,52,54).
% node 53 (leaf): class fourteen (15)
leaf_class(4,53,15).
% node 54: f3 <= 4.5  (F3, bin <= 3)  left -> 55, right -> 56
node(4,54,3,3).
left_node(4,54,55).
right_node(4,54,56).
% node 55 (leaf): class thirteen (14)
leaf_class(4,55,14).
% node 56 (leaf): class thirteen (14)
leaf_class(4,56,14).
% node 57: f3 <= 1.5  (F3, bin <= 0)  left -> 58, right -> 59
node(4,57,3,0).
left_node(4,57,58).
right_node(4,57,59).
% node 58 (leaf): class twelve (13)
leaf_class(4,58,13).
% node 59: f2 <= 5.5  (F2, bin <= 5)  left -> 60, right -> 61
node(4,59,2,5).
left_node(4,59,60).
right_node(4,59,61).
% node 60 (leaf): class thirteen (14)
leaf_class(4,60,14).
% node 61 (leaf): class draw (0)
leaf_class(4,61,0).
% node 62: f4 <= 6.5  (F4, bin <= 8)  left -> 63, right -> 68
node(4,62,4,8).
left_node(4,62,63).
right_node(4,62,68).
% node 63: f5 <= 3.5  (F5, bin <= 2)  left -> 64, right -> 65
node(4,63,5,2).
left_node(4,63,64).
right_node(4,63,65).
% node 64 (leaf): class ten (11)
leaf_class(4,64,11).
% node 65: f5 <= 7.5  (F5, bin <= 5)  left -> 66, right -> 67
node(4,65,5,5).
left_node(4,65,66).
right_node(4,65,67).
% node 66 (leaf): class twelve (13)
leaf_class(4,66,13).
% node 67 (leaf): class eleven (12)
leaf_class(4,67,12).
% node 68: f2 <= 5.5  (F2, bin <= 5)  left -> 69, right -> 70
node(4,68,2,5).
left_node(4,68,69).
right_node(4,68,70).
% node 69 (leaf): class nine (10)
leaf_class(4,69,10).
% node 70 (leaf): class draw (0)
leaf_class(4,70,0).

% Tree 5
tree(5).
% node 0: f1 <= 1.5  (F1, bin <= 0)  left -> 1, right -> 30
node(5,0,1,0).
left_node(5,0,1).
right_node(5,0,30).
% node 1: f5 <= 2.5  (F5, bin <= 1)  left -> 2, right -> 7
node(5,1,5,1).
left_node(5,1,2).
right_node(5,1,7).
% node 2: f2 <= 2.5  (F2, bin <= 2)  left -> 3, right -> 4
node(5,2,2,2).
left_node(5,2,3).
right_node(5,2,4).
% node 3 (leaf): class nine (10)
leaf_class(5,3,10).
% node 4: f3 <= 3.5  (F3, bin <= 2)  left -> 5, right -> 6
node(5,4,3,2).
left_node(5,4,5).
right_node(5,4,6).
% node 5 (leaf): class draw (0)
leaf_class(5,5,0).
% node 6 (leaf): class thirteen (14)
leaf_class(5,6,14).
% node 7: f2 <= 0.5  (F2, bin <= 0)  left -> 8, right -> 11
node(5,7,2,0).
left_node(5,7,8).
right_node(5,7,11).
% node 8: f0 <= 0.5  (F0, bin <= 0)  left -> 9, right -> 10
node(5,8,0,0).
left_node(5,8,9).
right_node(5,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(5,9,16).
% node 10 (leaf): class fourteen (15)
leaf_class(5,10,15).
% node 11: f4 <= 1.5  (F4, bin <= 1)  left -> 12, right -> 19
node(5,11,4,1).
left_node(5,11,12).
right_node(5,11,19).
% node 12: f2 <= 2.5  (F2, bin <= 2)  left -> 13, right -> 14
node(5,12,2,2).
left_node(5,12,13).
right_node(5,12,14).
% node 13 (leaf): class eleven (12)
leaf_class(5,13,12).
% node 14: f4 <= 0.5  (F4, bin <= 0)  left -> 15, right -> 16
node(5,14,4,0).
left_node(5,14,15).
right_node(5,14,16).
% node 15 (leaf): class twelve (13)
leaf_class(5,15,13).
% node 16: f5 <= 7.5  (F5, bin <= 5)  left -> 17, right -> 18
node(5,16,5,5).
left_node(5,16,17).
right_node(5,16,18).
% node 17 (leaf): class fourteen (15)
leaf_class(5,17,15).
% node 18 (leaf): class twelve (13)
leaf_class(5,18,13).
% node 19: f3 <= 5.5  (F3, bin <= 4)  left -> 20, right -> 27
node(5,19,3,4).
left_node(5,19,20).
right_node(5,19,27).
% node 20: f3 <= 3.5  (F3, bin <= 2)  left -> 21, right -> 24
node(5,20,3,2).
left_node(5,20,21).
right_node(5,20,24).
% node 21: f4 <= 6.5  (F4, bin <= 8)  left -> 22, right -> 23
node(5,21,4,8).
left_node(5,21,22).
right_node(5,21,23).
% node 22 (leaf): class fourteen (15)
leaf_class(5,22,15).
% node 23 (leaf): class thirteen (14)
leaf_class(5,23,14).
% node 24: f5 <= 6.5  (F5, bin <= 4)  left -> 25, right -> 26
node(5,24,5,4).
left_node(5,24,25).
right_node(5,24,26).
% node 25 (leaf): class draw (0)
leaf_class(5,25,0).
% node 26 (leaf): class fourteen (15)
leaf_class(5,26,15).
% node 27: f5 <= 6.5  (F5, bin <= 4)  left -> 28, right -> 29
node(5,27,5,4).
left_node(5,27,28).
right_node(5,27,29).
% node 28 (leaf): class fifteen (16)
leaf_class(5,28,16).
% node 29 (leaf): class draw (0)
leaf_class(5,29,0).
% node 30: f1 <= 2.5  (F1, bin <= 1)  left -> 31, right -> 54
node(5,30,1,1).
left_node(5,30,31).
right_node(5,30,54).
% node 31: f0 <= 1.5  (F0, bin <= 1)  left -> 32, right -> 37
node(5,31,0,1).
left_node(5,31,32).
right_node(5,31,37).
% node 32: f5 <= 1.5  (F5, bin <= 0)  left -> 33, right -> 34
node(5,32,5,0).
left_node(5,32,33).
right_node(5,32,34).
% node 33 (leaf): class ten (11)
leaf_class(5,33,11).
% node 34: f2 <= 4.5  (F2, bin <= 4)  left -> 35, right -> 36
node(5,34,2,4).
left_node(5,34,35).
right_node(5,34,36).
% node 35 (leaf): class fourteen (15)
leaf_class(5,35,15).
% node 36 (leaf): class fourteen (15)
leaf_class(5,36,15).
% node 37: f3 <= 4.5  (F3, bin <= 3)  left -> 38, right -> 45
node(5,37,3,3).
left_node(5,37,38).
right_node(5,37,45).
% node 38: f2 <= 2.5  (F2, bin <= 2)  left -> 39, right -> 40
node(5,38,2,2).
left_node(5,38,39).
right_node(5,38,40).
% node 39 (leaf): class thirteen (14)
leaf_class(5,39,14).
% node 40: f5 <= 2.5  (F5, bin <= 1)  left -> 41, right -> 42
node(5,40,5,1).
left_node(5,40,41).
right_node(5,40,42).
% node 41 (leaf): class draw (0)
leaf_class(5,41,0).
% node 42: f5 <= 5.5  (F5, bin <= 3)  left -> 43, right -> 44
node(5,42,5,3).
left_node(5,42,43).
right_node(5,42,44).
% node 43 (leaf): class thirteen (14)
leaf_class(5,43,14).
% node 44 (leaf): class thirteen (14)
leaf_class(5,44,14).
% node 45: f3 <= 5.5  (F3, bin <= 4)  left -> 46, right -> 47
node(5,45,3,4).
left_node(5,45,46).
right_node(5,45,47).
% node 46 (leaf): class twelve (13)
leaf_class(5,46,13).
% node 47: f4 <= 1.5  (F4, bin <= 1)  left -> 48, right -> 51
node(5,47,4,1).
left_node(5,47,48).
right_node(5,47,51).
% node 48: f5 <= 2.5  (F5, bin <= 1)  left -> 49, right -> 50
node(5,48,5,1).
left_node(5,48,49).
right_node(5,48,50).
% node 49 (leaf): class five (6)
leaf_class(5,49,6).
% node 50 (leaf): class twelve (13)
leaf_class(5,50,13).
% node 51: f5 <= 2.5  (F5, bin <= 1)  left -> 52, right -> 53
node(5,51,5,1).
left_node(5,51,52).
right_node(5,51,53).
% node 52 (leaf): class eight (9)
leaf_class(5,52,9).
% node 53 (leaf): class thirteen (14)
leaf_class(5,53,14).
% node 54: f5 <= 2.5  (F5, bin <= 1)  left -> 55, right -> 66
node(5,54,5,1).
left_node(5,54,55).
right_node(5,54,66).
% node 55: f0 <= 2.5  (F0, bin <= 2)  left -> 56, right -> 61
node(5,55,0,2).
left_node(5,55,56).
right_node(5,55,61).
% node 56: f2 <= 2.5  (F2, bin <= 2)  left -> 57, right -> 58
node(5,56,2,2).
left_node(5,56,57).
right_node(5,56,58).
% node 57 (leaf): class ten (11)
leaf_class(5,57,11).
% node 58: f4 <= 2.5  (F4, bin <= 3)  left -> 59, right -> 60
node(5,58,4,3).
left_node(5,58,59).
right_node(5,58,60).
% node 59 (leaf): class two (3)
leaf_class(5,59,3).
% node 60 (leaf): class eight (9)
leaf_class(5,60,9).
% node 61: f1 <= 3.5  (F1, bin <= 2)  left -> 62, right -> 65
node(5,61,1,2).
left_node(5,61,62).
right_node(5,61,65).
% node 62: f4 <= 3.5  (F4, bin <= 5)  left -> 63, right -> 64
node(5,62,4,5).
left_node(5,62,63).
right_node(5,62,64).
% node 63 (leaf): class five (6)
leaf_class(5,63,6).
% node 64 (leaf): class eight (9)
leaf_class(5,64,9).
% node 65 (leaf): class eight (9)
leaf_class(5,65,9).
% node 66: f1 <= 3.5  (F1, bin <= 2)  left -> 67, right -> 74
node(5,66,1,2).
left_node(5,66,67).
right_node(5,66,74).
% node 67: f4 <= 1.5  (F4, bin <= 1)  left -> 68, right -> 69
node(5,67,4,1).
left_node(5,67,68).
right_node(5,67,69).
% node 68 (leaf): class ten (11)
leaf_class(5,68,11).
% node 69: f4 <= 6.5  (F4, bin <= 8)  left -> 70, right -> 73
node(5,69,4,8).
left_node(5,69,70).
right_node(5,69,73).
% node 70: f5 <= 7.5  (F5, bin <= 5)  left -> 71, right -> 72
node(5,70,5,5).
left_node(5,70,71).
right_node(5,70,72).
% node 71 (leaf): class twelve (13)
leaf_class(5,71,13).
% node 72 (leaf): class eleven (12)
leaf_class(5,72,12).
% node 73 (leaf): class eleven (12)
leaf_class(5,73,12).
% node 74 (leaf): class eleven (12)
leaf_class(5,74,12).

% Tree 6
tree(6).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 68
node(6,0,4,8).
left_node(6,0,1).
right_node(6,0,68).
% node 1: f0 <= 1.5  (F0, bin <= 1)  left -> 2, right -> 19
node(6,1,0,1).
left_node(6,1,2).
right_node(6,1,19).
% node 2: f0 <= 0.5  (F0, bin <= 0)  left -> 3, right -> 10
node(6,2,0,0).
left_node(6,2,3).
right_node(6,2,10).
% node 3: f3 <= 1.5  (F3, bin <= 0)  left -> 4, right -> 5
node(6,3,3,0).
left_node(6,3,4).
right_node(6,3,5).
% node 4 (leaf): class fifteen (16)
leaf_class(6,4,16).
% node 5: f5 <= 2.5  (F5, bin <= 1)  left -> 6, right -> 7
node(6,5,5,1).
left_node(6,5,6).
right_node(6,5,7).
% node 6 (leaf): class fourteen (15)
leaf_class(6,6,15).
% node 7: f2 <= 4.5  (F2, bin <= 4)  left -> 8, right -> 9
node(6,7,2,4).
left_node(6,7,8).
right_node(6,7,9).
% node 8 (leaf): class fifteen (16)
leaf_class(6,8,16).
% node 9 (leaf): class sixteen (17)
leaf_class(6,9,17).
% node 10: f5 <= 1.5  (F5, bin <= 0)  left -> 11, right -> 12
node(6,10,5,0).
left_node(6,10,11).
right_node(6,10,12).
% node 11 (leaf): class ten (11)
leaf_class(6,11,11).
% node 12: f2 <= 0.5  (F2, bin <= 0)  left -> 13, right -> 14
node(6,12,2,0).
left_node(6,12,13).
right_node(6,12,14).
% node 13 (leaf): class fourteen (15)
leaf_class(6,13,15).
% node 14: f3 <= 5.5  (F3, bin <= 4)  left -> 15, right -> 18
node(6,14,3,4).
left_node(6,14,15).
right_node(6,14,18).
% node 15: f5 <= 6.5  (F5, bin <= 4)  left -> 16, right -> 17
node(6,15,5,4).
left_node(6,15,16).
right_node(6,15,17).
% node 16 (leaf): class fourteen (15)
leaf_class(6,16,15).
% node 17 (leaf): class fourteen (15)
leaf_class(6,17,15).
% node 18 (leaf): class fifteen (16)
leaf_class(6,18,16).
% node 19: f1 <= 1.5  (F1, bin <= 0)  left -> 20, right -> 43
node(6,19,1,0).
left_node(6,19,20).
right_node(6,19,43).
% node 20: f4 <= 1.5  (F4, bin <= 1)  left -> 21, right -> 30
node(6,20,4,1).
left_node(6,20,21).
right_node(6,20,30).
% node 21: f2 <= 2.5  (F2, bin <= 2)  left -> 22, right -> 23
node(6,21,2,2).
left_node(6,21,22).
right_node(6,21,23).
% node 22 (leaf): class draw (0)
leaf_class(6,22,0).
% node 23: f5 <= 1.5  (F5, bin <= 0)  left -> 24, right -> 27
node(6,23,5,0).
left_node(6,23,24).
right_node(6,23,27).
% node 24: f0 <= 2.5  (F0, bin <= 2)  left -> 25, right -> 26
node(6,24,0,2).
left_node(6,24,25).
right_node(6,24,26).
% node 25 (leaf): class two (3)
leaf_class(6,25,3).
% node 26 (leaf): class five (6)
leaf_class(6,26,6).
% node 27: f2 <= 3.5  (F2, bin <= 3)  left -> 28, right -> 29
node(6,27,2,3).
left_node(6,27,28).
right_node(6,27,29).
% node 28 (leaf): class twelve (13)
leaf_class(6,28,13).
% node 29 (leaf): class thirteen (14)
leaf_class(6,29,14).
% node 30: f3 <= 5.5  (F3, bin <= 4)  left -> 31, right -> 38
node(6,30,3,4).
left_node(6,30,31).
right_node(6,30,38).
% node 31: f2 <= 2.5  (F2, bin <= 2)  left -> 32, right -> 35
node(6,31,2,2).
left_node(6,31,32).
right_node(6,31,35).
% node 32: f5 <= 2.5  (F5, bin <= 1)  left -> 33, right -> 34
node(6,32,5,1).
left_node(6,32,33).
right_node(6,32,34).
% node 33 (leaf): class six (7)
leaf_class(6,33,7).
% node 34 (leaf): class fourteen (15)
leaf_class(6,34,15).
% node 35: f5 <= 2.5  (F5, bin <= 1)  left -> 36, right -> 37
node(6,35,5,1).
left_node(6,35,36).
right_node(6,35,37).
% node 36 (leaf): class draw (0)
leaf_class(6,36,0).
% node 37 (leaf): class fourteen (15)
leaf_class(6,37,15).
% node 38: f2 <= 0.5  (F2, bin <= 0)  left -> 39, right -> 40
node(6,38,2,0).
left_node(6,38,39).
right_node(6,38,40).
% node 39 (leaf): class fourteen (15)
leaf_class(6,39,15).
% node 40: f2 <= 6.5  (F2, bin <= 6)  left -> 41, right -> 42
node(6,40,2,6).
left_node(6,40,41).
right_node(6,40,42).
% node 41 (leaf): class fifteen (16)
leaf_class(6,41,16).
% node 42 (leaf): class fourteen (15)
leaf_class(6,42,15).
% node 43: f1 <= 2.5  (F1, bin <= 1)  left -> 44, right -> 55
node(6,43,1,1).
left_node(6,43,44).
right_node(6,43,55).
% node 44: f4 <= 1.5  (F4, bin <= 1)  left -> 45, right -> 50
node(6,44,4,1).
left_node(6,44,45).
right_node(6,44,50).
% node 45: f4 <= 0.5  (F4, bin <= 0)  left -> 46, right -> 47
node(6,45,4,0).
left_node(6,45,46).
right_node(6,45,47).
% node 46 (leaf): class eleven (12)
leaf_class(6,46,12).
% node 47: f5 <= 2.5  (F5, bin <= 1)  left -> 48, right -> 49
node(6,47,5,1).
left_node(6,47,48).
right_node(6,47,49).
% node 48 (leaf): class five (6)
leaf_class(6,48,6).
% node 49 (leaf): class twelve (13)
leaf_class(6,49,13).
% node 50: f2 <= 5.5  (F2, bin <= 5)  left -> 51, right -> 54
node(6,50,2,5).
left_node(6,50,51).
right_node(6,50,54).
% node 51: f2 <= 2.5  (F2, bin <= 2)  left -> 52, right -> 53
node(6,51,2,2).
left_node(6,51,52).
right_node(6,51,53).
% node 52 (leaf): class thirteen (14)
leaf_class(6,52,14).
% node 53 (leaf): class thirteen (14)
leaf_class(6,53,14).
% node 54 (leaf): class thirteen (14)
leaf_class(6,54,14).
% node 55: f5 <= 2.5  (F5, bin <= 1)  left -> 56, right -> 63
node(6,55,5,1).
left_node(6,55,56).
right_node(6,55,63).
% node 56: f4 <= 2.5  (F4, bin <= 3)  left -> 57, right -> 60
node(6,56,4,3).
left_node(6,56,57).
right_node(6,56,60).
% node 57: f0 <= 2.5  (F0, bin <= 2)  left -> 58, right -> 59
node(6,57,0,2).
left_node(6,57,58).
right_node(6,57,59).
% node 58 (leaf): class two (3)
leaf_class(6,58,3).
% node 59 (leaf): class eight (9)
leaf_class(6,59,9).
% node 60: f5 <= 1.5  (F5, bin <= 0)  left -> 61, right -> 62
node(6,60,5,0).
left_node(6,60,61).
right_node(6,60,62).
% node 61 (leaf): class eight (9)
leaf_class(6,61,9).
% node 62 (leaf): class ten (11)
leaf_class(6,62,11).
% node 63: f0 <= 2.5  (F0, bin <= 2)  left -> 64, right -> 65
node(6,63,0,2).
left_node(6,63,64).
right_node(6,63,65).
% node 64 (leaf): class twelve (13)
leaf_class(6,64,13).
% node 65: f5 <= 3.5  (F5, bin <= 2)  left -> 66, right -> 67
node(6,65,5,2).
left_node(6,65,66).
right_node(6,65,67).
% node 66 (leaf): class nine (10)
leaf_class(6,66,10).
% node 67 (leaf): class twelve (13)
leaf_class(6,67,13).
% node 68: f5 <= 2.5  (F5, bin <= 1)  left -> 69, right -> 76
node(6,68,5,1).
left_node(6,68,69).
right_node(6,68,76).
% node 69: f5 <= 1.5  (F5, bin <= 0)  left -> 70, right -> 75
node(6,69,5,0).
left_node(6,69,70).
right_node(6,69,75).
% node 70: f0 <= 2.5  (F0, bin <= 2)  left -> 71, right -> 72
node(6,70,0,2).
left_node(6,70,71).
right_node(6,70,72).
% node 71 (leaf): class eight (9)
leaf_class(6,71,9).
% node 72: f1 <= 3.5  (F1, bin <= 2)  left -> 73, right -> 74
node(6,72,1,2).
left_node(6,72,73).
right_node(6,72,74).
% node 73 (leaf): class six (7)
leaf_class(6,73,7).
% node 74 (leaf): class seven (8)
leaf_class(6,74,8).
% node 75 (leaf): class eight (9)
leaf_class(6,75,9).
% node 76: f0 <= 1.5  (F0, bin <= 1)  left -> 77, right -> 78
node(6,76,0,1).
left_node(6,76,77).
right_node(6,76,78).
% node 77 (leaf): class thirteen (14)
leaf_class(6,77,14).
% node 78: f1 <= 3.5  (F1, bin <= 2)  left -> 79, right -> 86
node(6,78,1,2).
left_node(6,78,79).
right_node(6,78,86).
% node 79: f1 <= 1.5  (F1, bin <= 0)  left -> 80, right -> 81
node(6,79,1,0).
left_node(6,79,80).
right_node(6,79,81).
% node 80 (leaf): class twelve (13)
leaf_class(6,80,13).
% node 81: f0 <= 2.5  (F0, bin <= 2)  left -> 82, right -> 83
node(6,81,0,2).
left_node(6,81,82).
right_node(6,81,83).
% node 82 (leaf): class eleven (12)
leaf_class(6,82,12).
% node 83: f2 <= 5.5  (F2, bin <= 5)  left -> 84, right -> 85
node(6,83,2,5).
left_node(6,83,84).
right_node(6,83,85).
% node 84 (leaf): class eleven (12)
leaf_class(6,84,12).
% node 85 (leaf): class draw (0)
leaf_class(6,85,0).
% node 86 (leaf): class nine (10)
leaf_class(6,86,10).

% Tree 7
tree(7).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 42
node(7,0,5,1).
left_node(7,0,1).
right_node(7,0,42).
% node 1: f4 <= 1.5  (F4, bin <= 1)  left -> 2, right -> 13
node(7,1,4,1).
left_node(7,1,2).
right_node(7,1,13).
% node 2: f1 <= 3.5  (F1, bin <= 2)  left -> 3, right -> 12
node(7,2,1,2).
left_node(7,2,3).
right_node(7,2,12).
% node 3: f2 <= 2.5  (F2, bin <= 2)  left -> 4, right -> 5
node(7,3,2,2).
left_node(7,3,4).
right_node(7,3,5).
% node 4 (leaf): class draw (0)
leaf_class(7,4,0).
% node 5: f5 <= 1.5  (F5, bin <= 0)  left -> 6, right -> 9
node(7,5,5,0).
left_node(7,5,6).
right_node(7,5,9).
% node 6: f0 <= 2.5  (F0, bin <= 2)  left -> 7, right -> 8
node(7,6,0,2).
left_node(7,6,7).
right_node(7,6,8).
% node 7 (leaf): class two (3)
leaf_class(7,7,3).
% node 8 (leaf): class five (6)
leaf_class(7,8,6).
% node 9: f1 <= 2.5  (F1, bin <= 1)  left -> 10, right -> 11
node(7,9,1,1).
left_node(7,9,10).
right_node(7,9,11).
% node 10 (leaf): class five (6)
leaf_class(7,10,6).
% node 11 (leaf): class six (7)
leaf_class(7,11,7).
% node 12 (leaf): class eight (9)
leaf_class(7,12,9).
% node 13: f3 <= 3.5  (F3, bin <= 2)  left -> 14, right -> 17
node(7,13,3,2).
left_node(7,13,14).
right_node(7,13,17).
% node 14: f3 <= 2.5  (F3, bin <= 1)  left -> 15, right -> 16
node(7,14,3,1).
left_node(7,14,15).
right_node(7,14,16).
% node 15 (leaf): class draw (0)
leaf_class(7,15,0).
% node 16 (leaf): class eight (9)
leaf_class(7,16,9).
% node 17: f5 <= 1.5  (F5, bin <= 0)  left -> 18, right -> 31
node(7,17,5,0).
left_node(7,17,18).
right_node(7,17,31).
% node 18: f1 <= 2.5  (F1, bin <= 1)  left -> 19, right -> 26
node(7,18,1,1).
left_node(7,18,19).
right_node(7,18,26).
% node 19: f0 <= 2.5  (F0, bin <= 2)  left -> 20, right -> 23
node(7,19,0,2).
left_node(7,19,20).
right_node(7,19,23).
% node 20: f4 <= 5.5  (F4, bin <= 7)  left -> 21, right -> 22
node(7,20,4,7).
left_node(7,20,21).
right_node(7,20,22).
% node 21 (leaf): class ten (11)
leaf_class(7,21,11).
% node 22 (leaf): class nine (10)
leaf_class(7,22,10).
% node 23: f2 <= 4.5  (F2, bin <= 4)  left -> 24, right -> 25
node(7,23,2,4).
left_node(7,23,24).
right_node(7,23,25).
% node 24 (leaf): class six (7)
leaf_class(7,24,7).
% node 25 (leaf): class eight (9)
leaf_class(7,25,9).
% node 26: f4 <= 3.5  (F4, bin <= 5)  left -> 27, right -> 30
node(7,26,4,5).
left_node(7,26,27).
right_node(7,26,30).
% node 27: f1 <= 3.5  (F1, bin <= 2)  left -> 28, right -> 29
node(7,27,1,2).
left_node(7,27,28).
right_node(7,27,29).
% node 28 (leaf): class two (3)
leaf_class(7,28,3).
% node 29 (leaf): class eight (9)
leaf_class(7,29,9).
% node 30 (leaf): class eight (9)
leaf_class(7,30,9).
% node 31: f2 <= 3.5  (F2, bin <= 3)  left -> 32, right -> 39
node(7,31,2,3).
left_node(7,31,32).
right_node(7,31,39).
% node 32: f4 <= 6.5  (F4, bin <= 8)  left -> 33, right -> 36
node(7,32,4,8).
left_node(7,32,33).
right_node(7,32,36).
% node 33: f1 <= 1.5  (F1, bin <= 0)  left -> 34, right -> 35
node(7,33,1,0).
left_node(7,33,34).
right_node(7,33,35).
% node 34 (leaf): class thirteen (14)
leaf_class(7,34,14).
% node 35 (leaf): class ten (11)
leaf_class(7,35,11).
% node 36: f0 <= 1.5  (F0, bin <= 1)  left -> 37, right -> 38
node(7,36,0,1).
left_node(7,36,37).
right_node(7,36,38).
% node 37 (leaf): class eleven (12)
leaf_class(7,37,12).
% node 38 (leaf): class eight (9)
leaf_class(7,38,9).
% node 39: f1 <= 2.5  (F1, bin <= 1)  left -> 40, right -> 41
node(7,39,1,1).
left_node(7,39,40).
right_node(7,39,41).
% node 40 (leaf): class thirteen (14)
leaf_class(7,40,14).
% node 41 (leaf): class eight (9)
leaf_class(7,41,9).
% node 42: f1 <= 1.5  (F1, bin <= 0)  left -> 43, right -> 58
node(7,42,1,0).
left_node(7,42,43).
right_node(7,42,58).
% node 43: f0 <= 0.5  (F0, bin <= 0)  left -> 44, right -> 45
node(7,43,0,0).
left_node(7,43,44).
right_node(7,43,45).
% node 44 (leaf): class fifteen (16)
leaf_class(7,44,16).
% node 45: f4 <= 0.5  (F4, bin <= 0)  left -> 46, right -> 47
node(7,45,4,0).
left_node(7,45,46).
right_node(7,45,47).
% node 46 (leaf): class twelve (13)
leaf_class(7,46,13).
% node 47: f5 <= 6.5  (F5, bin <= 4)  left -> 48, right -> 53
node(7,47,5,4).
left_node(7,47,48).
right_node(7,47,53).
% node 48: f4 <= 6.5  (F4, bin <= 8)  left -> 49, right -> 52
node(7,48,4,8).
left_node(7,48,49).
right_node(7,48,52).
% node 49: f0 <= 1.5  (F0, bin <= 1)  left -> 50, right -> 51
node(7,49,0,1).
left_node(7,49,50).
right_node(7,49,51).
% node 50 (leaf): class fifteen (16)
leaf_class(7,50,16).
% node 51 (leaf): class fourteen (15)
leaf_class(7,51,15).
% node 52 (leaf): class thirteen (14)
leaf_class(7,52,14).
% node 53: f4 <= 6.5  (F4, bin <= 8)  left -> 54, right -> 57
node(7,53,4,8).
left_node(7,53,54).
right_node(7,53,57).
% node 54: f4 <= 1.5  (F4, bin <= 1)  left -> 55, right -> 56
node(7,54,4,1).
left_node(7,54,55).
right_node(7,54,56).
% node 55 (leaf): class thirteen (14)
leaf_class(7,55,14).
% node 56 (leaf): class fourteen (15)
leaf_class(7,56,15).
% node 57 (leaf): class twelve (13)
leaf_class(7,57,13).
% node 58: f1 <= 2.5  (F1, bin <= 1)  left -> 59, right -> 74
node(7,58,1,1).
left_node(7,58,59).
right_node(7,58,74).
% node 59: f4 <= 0.5  (F4, bin <= 0)  left -> 60, right -> 63
node(7,59,4,0).
left_node(7,59,60).
right_node(7,59,63).
% node 60: f2 <= 1.5  (F2, bin <= 1)  left -> 61, right -> 62
node(7,60,2,1).
left_node(7,60,61).
right_node(7,60,62).
% node 61 (leaf): class draw (0)
leaf_class(7,61,0).
% node 62 (leaf): class eleven (12)
leaf_class(7,62,12).
% node 63: f2 <= 2.5  (F2, bin <= 2)  left -> 64, right -> 67
node(7,63,2,2).
left_node(7,63,64).
right_node(7,63,67).
% node 64: f5 <= 6.5  (F5, bin <= 4)  left -> 65, right -> 66
node(7,64,5,4).
left_node(7,64,65).
right_node(7,64,66).
% node 65 (leaf): class thirteen (14)
leaf_class(7,65,14).
% node 66 (leaf): class thirteen (14)
leaf_class(7,66,14).
% node 67: f4 <= 6.5  (F4, bin <= 8)  left -> 68, right -> 71
node(7,67,4,8).
left_node(7,67,68).
right_node(7,67,71).
% node 68: f0 <= 1.5  (F0, bin <= 1)  left -> 69, right -> 70
node(7,68,0,1).
left_node(7,68,69).
right_node(7,68,70).
% node 69 (leaf): class fourteen (15)
leaf_class(7,69,15).
% node 70 (leaf): class thirteen (14)
leaf_class(7,70,14).
% node 71: f2 <= 5.5  (F2, bin <= 5)  left -> 72, right -> 73
node(7,71,2,5).
left_node(7,71,72).
right_node(7,71,73).
% node 72 (leaf): class twelve (13)
leaf_class(7,72,13).
% node 73 (leaf): class draw (0)
leaf_class(7,73,0).
% node 74: f1 <= 3.5  (F1, bin <= 2)  left -> 75, right -> 86
node(7,74,1,2).
left_node(7,74,75).
right_node(7,74,86).
% node 75: f0 <= 2.5  (F0, bin <= 2)  left -> 76, right -> 81
node(7,75,0,2).
left_node(7,75,76).
right_node(7,75,81).
% node 76: f2 <= 4.5  (F2, bin <= 4)  left -> 77, right -> 80
node(7,76,2,4).
left_node(7,76,77).
right_node(7,76,80).
% node 77: f4 <= 5.5  (F4, bin <= 7)  left -> 78, right -> 79
node(7,77,4,7).
left_node(7,77,78).
right_node(7,77,79).
% node 78 (leaf): class thirteen (14)
leaf_class(7,78,14).
% node 79 (leaf): class twelve (13)
leaf_class(7,79,13).
% node 80 (leaf): class thirteen (14)
leaf_class(7,80,14).
% node 81: f2 <= 5.5  (F2, bin <= 5)  left -> 82, right -> 85
node(7,81,2,5).
left_node(7,81,82).
right_node(7,81,85).
% node 82: f4 <= 1.5  (F4, bin <= 1)  left -> 83, right -> 84
node(7,82,4,1).
left_node(7,82,83).
right_node(7,82,84).
% node 83 (leaf): class ten (11)
leaf_class(7,83,11).
% node 84 (leaf): class twelve (13)
leaf_class(7,84,13).
% node 85 (leaf): class twelve (13)
leaf_class(7,85,13).
% node 86: f4 <= 6.5  (F4, bin <= 8)  left -> 87, right -> 88
node(7,86,4,8).
left_node(7,86,87).
right_node(7,86,88).
% node 87 (leaf): class eleven (12)
leaf_class(7,87,12).
% node 88: f2 <= 5.5  (F2, bin <= 5)  left -> 89, right -> 90
node(7,88,2,5).
left_node(7,88,89).
right_node(7,88,90).
% node 89 (leaf): class nine (10)
leaf_class(7,89,10).
% node 90 (leaf): class draw (0)
leaf_class(7,90,0).

% Tree 8
tree(8).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 50
node(8,0,4,8).
left_node(8,0,1).
right_node(8,0,50).
% node 1: f0 <= 1.5  (F0, bin <= 1)  left -> 2, right -> 13
node(8,1,0,1).
left_node(8,1,2).
right_node(8,1,13).
% node 2: f4 <= 1.5  (F4, bin <= 1)  left -> 3, right -> 4
node(8,2,4,1).
left_node(8,2,3).
right_node(8,2,4).
% node 3 (leaf): class fourteen (15)
leaf_class(8,3,15).
% node 4: f1 <= 1.5  (F1, bin <= 0)  left -> 5, right -> 12
node(8,4,1,0).
left_node(8,4,5).
right_node(8,4,12).
% node 5: f0 <= 0.5  (F0, bin <= 0)  left -> 6, right -> 7
node(8,5,0,0).
left_node(8,5,6).
right_node(8,5,7).
% node 6 (leaf): class fifteen (16)
leaf_class(8,6,16).
% node 7: f2 <= 0.5  (F2, bin <= 0)  left -> 8, right -> 9
node(8,7,2,0).
left_node(8,7,8).
right_node(8,7,9).
% node 8 (leaf): class fourteen (15)
leaf_class(8,8,15).
% node 9: f4 <= 5.5  (F4, bin <= 7)  left -> 10, right -> 11
node(8,9,4,7).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class fifteen (16)
leaf_class(8,10,16).
% node 11 (leaf): class fourteen (15)
leaf_class(8,11,15).
% node 12 (leaf): class fourteen (15)
leaf_class(8,12,15).
% node 13: f5 <= 2.5  (F5, bin <= 1)  left -> 14, right -> 35
node(8,13,5,1).
left_node(8,13,14).
right_node(8,13,35).
% node 14: f4 <= 2.5  (F4, bin <= 3)  left -> 15, right -> 22
node(8,14,4,3).
left_node(8,14,15).
right_node(8,14,22).
% node 15: f5 <= 1.5  (F5, bin <= 0)  left -> 16, right -> 21
node(8,15,5,0).
left_node(8,15,16).
right_node(8,15,21).
% node 16: f3 <= 3.5  (F3, bin <= 2)  left -> 17, right -> 18
node(8,16,3,2).
left_node(8,16,17).
right_node(8,16,18).
% node 17 (leaf): class four (5)
leaf_class(8,17,5).
% node 18: f0 <= 2.5  (F0, bin <= 2)  left -> 19, right -> 20
node(8,18,0,2).
left_node(8,18,19).
right_node(8,18,20).
% node 19 (leaf): class two (3)
leaf_class(8,19,3).
% node 20 (leaf): class five (6)
leaf_class(8,20,6).
% node 21 (leaf): class eight (9)
leaf_class(8,21,9).
% node 22: f5 <= 1.5  (F5, bin <= 0)  left -> 23, right -> 28
node(8,22,5,0).
left_node(8,22,23).
right_node(8,22,28).
% node 23: f3 <= 2.5  (F3, bin <= 1)  left -> 24, right -> 27
node(8,23,3,1).
left_node(8,23,24).
right_node(8,23,27).
% node 24: f2 <= 3.5  (F2, bin <= 3)  left -> 25, right -> 26
node(8,24,2,3).
left_node(8,24,25).
right_node(8,24,26).
% node 25 (leaf): class five (6)
leaf_class(8,25,6).
% node 26 (leaf): class draw (0)
leaf_class(8,26,0).
% node 27 (leaf): class eight (9)
leaf_class(8,27,9).
% node 28: f2 <= 2.5  (F2, bin <= 2)  left -> 29, right -> 32
node(8,28,2,2).
left_node(8,28,29).
right_node(8,28,32).
% node 29: f0 <= 2.5  (F0, bin <= 2)  left -> 30, right -> 31
node(8,29,0,2).
left_node(8,29,30).
right_node(8,29,31).
% node 30 (leaf): class ten (11)
leaf_class(8,30,11).
% node 31 (leaf): class eight (9)
leaf_class(8,31,9).
% node 32: f3 <= 3.5  (F3, bin <= 2)  left -> 33, right -> 34
node(8,32,3,2).
left_node(8,32,33).
right_node(8,32,34).
% node 33 (leaf): class draw (0)
leaf_class(8,33,0).
% node 34 (leaf): class ten (11)
leaf_class(8,34,11).
% node 35: f4 <= 0.5  (F4, bin <= 0)  left -> 36, right -> 41
node(8,35,4,0).
left_node(8,35,36).
right_node(8,35,41).
% node 36: f1 <= 1.5  (F1, bin <= 0)  left -> 37, right -> 40
node(8,36,1,0).
left_node(8,36,37).
right_node(8,36,40).
% node 37: f2 <= 2.5  (F2, bin <= 2)  left -> 38, right -> 39
node(8,37,2,2).
left_node(8,37,38).
right_node(8,37,39).
% node 38 (leaf): class eleven (12)
leaf_class(8,38,12).
% node 39 (leaf): class twelve (13)
leaf_class(8,39,13).
% node 40 (leaf): class eleven (12)
leaf_class(8,40,12).
% node 41: f0 <= 2.5  (F0, bin <= 2)  left -> 42, right -> 49
node(8,41,0,2).
left_node(8,41,42).
right_node(8,41,49).
% node 42: f1 <= 1.5  (F1, bin <= 0)  left -> 43, right -> 46
node(8,42,1,0).
left_node(8,42,43).
right_node(8,42,46).
% node 43: f3 <= 5.5  (F3, bin <= 4)  left -> 44, right -> 45
node(8,43,3,4).
left_node(8,43,44).
right_node(8,43,45).
% node 44 (leaf): class fourteen (15)
leaf_class(8,44,15).
% node 45 (leaf): class fourteen (15)
leaf_class(8,45,15).
% node 46: f1 <= 2.5  (F1, bin <= 1)  left -> 47, right -> 48
node(8,46,1,1).
left_node(8,46,47).
right_node(8,46,48).
% node 47 (leaf): class thirteen (14)
leaf_class(8,47,14).
% node 48 (leaf): class twelve (13)
leaf_class(8,48,13).
% node 49 (leaf): class fourteen (15)
leaf_class(8,49,15).
% node 50: f2 <= 5.5  (F2, bin <= 5)  left -> 51, right -> 62
node(8,50,2,5).
left_node(8,50,51).
right_node(8,50,62).
% node 51: f1 <= 3.5  (F1, bin <= 2)  left -> 52, right -> 61
node(8,51,1,2).
left_node(8,51,52).
right_node(8,51,61).
% node 52: f0 <= 1.5  (F0, bin <= 1)  left -> 53, right -> 56
node(8,52,0,1).
left_node(8,52,53).
right_node(8,52,56).
% node 53: f2 <= 3.5  (F2, bin <= 3)  left -> 54, right -> 55
node(8,53,2,3).
left_node(8,53,54).
right_node(8,53,55).
% node 54 (leaf): class thirteen (14)
leaf_class(8,54,14).
% node 55 (leaf): class twelve (13)
leaf_class(8,55,13).
% node 56: f2 <= 4.5  (F2, bin <= 4)  left -> 57, right -> 60
node(8,56,2,4).
left_node(8,56,57).
right_node(8,56,60).
% node 57: f5 <= 2.5  (F5, bin <= 1)  left -> 58, right -> 59
node(8,57,5,1).
left_node(8,57,58).
right_node(8,57,59).
% node 58 (leaf): class eight (9)
leaf_class(8,58,9).
% node 59 (leaf): class twelve (13)
leaf_class(8,59,13).
% node 60 (leaf): class ten (11)
leaf_class(8,60,11).
% node 61 (leaf): class nine (10)
leaf_class(8,61,10).
% node 62: f2 <= 6.5  (F2, bin <= 6)  left -> 63, right -> 64
node(8,62,2,6).
left_node(8,62,63).
right_node(8,62,64).
% node 63 (leaf): class draw (0)
leaf_class(8,63,0).
% node 64 (leaf): class draw (0)
leaf_class(8,64,0).

% Tree 9
tree(9).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 50
node(9,0,4,8).
left_node(9,0,1).
right_node(9,0,50).
% node 1: f4 <= 1.5  (F4, bin <= 1)  left -> 2, right -> 21
node(9,1,4,1).
left_node(9,1,2).
right_node(9,1,21).
% node 2: f5 <= 2.5  (F5, bin <= 1)  left -> 3, right -> 8
node(9,2,5,1).
left_node(9,2,3).
right_node(9,2,8).
% node 3: f0 <= 2.5  (F0, bin <= 2)  left -> 4, right -> 5
node(9,3,0,2).
left_node(9,3,4).
right_node(9,3,5).
% node 4 (leaf): class two (3)
leaf_class(9,4,3).
% node 5: f1 <= 3.5  (F1, bin <= 2)  left -> 6, right -> 7
node(9,5,1,2).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class five (6)
leaf_class(9,6,6).
% node 7 (leaf): class eight (9)
leaf_class(9,7,9).
% node 8: f3 <= 2.5  (F3, bin <= 1)  left -> 9, right -> 10
node(9,8,3,1).
left_node(9,8,9).
right_node(9,8,10).
% node 9 (leaf): class twelve (13)
leaf_class(9,9,13).
% node 10: f1 <= 1.5  (F1, bin <= 0)  left -> 11, right -> 16
node(9,10,1,0).
left_node(9,10,11).
right_node(9,10,16).
% node 11: f3 <= 5.5  (F3, bin <= 4)  left -> 12, right -> 15
node(9,11,3,4).
left_node(9,11,12).
right_node(9,11,15).
% node 12: f2 <= 2.5  (F2, bin <= 2)  left -> 13, right -> 14
node(9,12,2,2).
left_node(9,12,13).
right_node(9,12,14).
% node 13 (leaf): class draw (0)
leaf_class(9,13,0).
% node 14 (leaf): class thirteen (14)
leaf_class(9,14,14).
% node 15 (leaf): class fourteen (15)
leaf_class(9,15,15).
% node 16: f2 <= 2.5  (F2, bin <= 2)  left -> 17, right -> 18
node(9,16,2,2).
left_node(9,16,17).
right_node(9,16,18).
% node 17 (leaf): class draw (0)
leaf_class(9,17,0).
% node 18: f5 <= 3.5  (F5, bin <= 2)  left -> 19, right -> 20
node(9,18,5,2).
left_node(9,18,19).
right_node(9,18,20).
% node 19 (leaf): class seven (8)
leaf_class(9,19,8).
% node 20 (leaf): class eleven (12)
leaf_class(9,20,12).
% node 21: f0 <= 1.5  (F0, bin <= 1)  left -> 22, right -> 33
node(9,21,0,1).
left_node(9,21,22).
right_node(9,21,33).
% node 22: f2 <= 0.5  (F2, bin <= 0)  left -> 23, right -> 24
node(9,22,2,0).
left_node(9,22,23).
right_node(9,22,24).
% node 23 (leaf): class fourteen (15)
leaf_class(9,23,15).
% node 24: f0 <= 0.5  (F0, bin <= 0)  left -> 25, right -> 28
node(9,24,0,0).
left_node(9,24,25).
right_node(9,24,28).
% node 25: f5 <= 2.5  (F5, bin <= 1)  left -> 26, right -> 27
node(9,25,5,1).
left_node(9,25,26).
right_node(9,25,27).
% node 26 (leaf): class thirteen (14)
leaf_class(9,26,14).
% node 27 (leaf): class fifteen (16)
leaf_class(9,27,16).
% node 28: f1 <= 1.5  (F1, bin <= 0)  left -> 29, right -> 32
node(9,28,1,0).
left_node(9,28,29).
right_node(9,28,32).
% node 29: f5 <= 6.5  (F5, bin <= 4)  left -> 30, right -> 31
node(9,29,5,4).
left_node(9,29,30).
right_node(9,29,31).
% node 30 (leaf): class fifteen (16)
leaf_class(9,30,16).
% node 31 (leaf): class fourteen (15)
leaf_class(9,31,15).
% node 32 (leaf): class fourteen (15)
leaf_class(9,32,15).
% node 33: f1 <= 1.5  (F1, bin <= 0)  left -> 34, right -> 39
node(9,33,1,0).
left_node(9,33,34).
right_node(9,33,39).
% node 34: f2 <= 0.5  (F2, bin <= 0)  left -> 35, right -> 36
node(9,34,2,0).
left_node(9,34,35).
right_node(9,34,36).
% node 35 (leaf): class fourteen (15)
leaf_class(9,35,15).
% node 36: f2 <= 6.5  (F2, bin <= 6)  left -> 37, right -> 38
node(9,36,2,6).
left_node(9,36,37).
right_node(9,36,38).
% node 37 (leaf): class fourteen (15)
leaf_class(9,37,15).
% node 38 (leaf): class fourteen (15)
leaf_class(9,38,15).
% node 39: f5 <= 2.5  (F5, bin <= 1)  left -> 40, right -> 43
node(9,39,5,1).
left_node(9,39,40).
right_node(9,39,43).
% node 40: f3 <= 3.5  (F3, bin <= 2)  left -> 41, right -> 42
node(9,40,3,2).
left_node(9,40,41).
right_node(9,40,42).
% node 41 (leaf): class draw (0)
leaf_class(9,41,0).
% node 42 (leaf): class eight (9)
leaf_class(9,42,9).
% node 43: f4 <= 5.5  (F4, bin <= 7)  left -> 44, right -> 47
node(9,43,4,7).
left_node(9,43,44).
right_node(9,43,47).
% node 44: f3 <= 4.5  (F3, bin <= 3)  left -> 45, right -> 46
node(9,44,3,3).
left_node(9,44,45).
right_node(9,44,46).
% node 45 (leaf): class thirteen (14)
leaf_class(9,45,14).
% node 46 (leaf): class thirteen (14)
leaf_class(9,46,14).
% node 47: f1 <= 2.5  (F1, bin <= 1)  left -> 48, right -> 49
node(9,47,1,1).
left_node(9,47,48).
right_node(9,47,49).
% node 48 (leaf): class thirteen (14)
leaf_class(9,48,14).
% node 49 (leaf): class twelve (13)
leaf_class(9,49,13).
% node 50: f5 <= 2.5  (F5, bin <= 1)  left -> 51, right -> 54
node(9,50,5,1).
left_node(9,50,51).
right_node(9,50,54).
% node 51: f0 <= 2.5  (F0, bin <= 2)  left -> 52, right -> 53
node(9,51,0,2).
left_node(9,51,52).
right_node(9,51,53).
% node 52 (leaf): class nine (10)
leaf_class(9,52,10).
% node 53 (leaf): class six (7)
leaf_class(9,53,7).
% node 54: f1 <= 3.5  (F1, bin <= 2)  left -> 55, right -> 68
node(9,54,1,2).
left_node(9,54,55).
right_node(9,54,68).
% node 55: f0 <= 1.5  (F0, bin <= 1)  left -> 56, right -> 61
node(9,55,0,1).
left_node(9,55,56).
right_node(9,55,61).
% node 56: f2 <= 5.5  (F2, bin <= 5)  left -> 57, right -> 60
node(9,56,2,5).
left_node(9,56,57).
right_node(9,56,60).
% node 57: f1 <= 1.5  (F1, bin <= 0)  left -> 58, right -> 59
node(9,57,1,0).
left_node(9,57,58).
right_node(9,57,59).
% node 58 (leaf): class thirteen (14)
leaf_class(9,58,14).
% node 59 (leaf): class thirteen (14)
leaf_class(9,59,14).
% node 60 (leaf): class draw (0)
leaf_class(9,60,0).
% node 61: f1 <= 1.5  (F1, bin <= 0)  left -> 62, right -> 63
node(9,61,1,0).
left_node(9,61,62).
right_node(9,61,63).
% node 62 (leaf): class twelve (13)
leaf_class(9,62,13).
% node 63: f2 <= 5.5  (F2, bin <= 5)  left -> 64, right -> 67
node(9,63,2,5).
left_node(9,63,64).
right_node(9,63,67).
% node 64: f2 <= 3.5  (F2, bin <= 3)  left -> 65, right -> 66
node(9,64,2,3).
left_node(9,64,65).
right_node(9,64,66).
% node 65 (leaf): class eleven (12)
leaf_class(9,65,12).
% node 66 (leaf): class eleven (12)
leaf_class(9,66,12).
% node 67 (leaf): class draw (0)
leaf_class(9,67,0).
% node 68: f2 <= 5.5  (F2, bin <= 5)  left -> 69, right -> 70
node(9,68,2,5).
left_node(9,68,69).
right_node(9,68,70).
% node 69 (leaf): class nine (10)
leaf_class(9,69,10).
% node 70 (leaf): class draw (0)
leaf_class(9,70,0).

% Tree 10
tree(10).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 32
node(10,0,0,1).
left_node(10,0,1).
right_node(10,0,32).
% node 1: f4 <= 6.5  (F4, bin <= 8)  left -> 2, right -> 25
node(10,1,4,8).
left_node(10,1,2).
right_node(10,1,25).
% node 2: f1 <= 1.5  (F1, bin <= 0)  left -> 3, right -> 18
node(10,2,1,0).
left_node(10,2,3).
right_node(10,2,18).
% node 3: f0 <= 0.5  (F0, bin <= 0)  left -> 4, right -> 9
node(10,3,0,0).
left_node(10,3,4).
right_node(10,3,9).
% node 4: f5 <= 2.5  (F5, bin <= 1)  left -> 5, right -> 8
node(10,4,5,1).
left_node(10,4,5).
right_node(10,4,8).
% node 5: f3 <= 3.5  (F3, bin <= 2)  left -> 6, right -> 7
node(10,5,3,2).
left_node(10,5,6).
right_node(10,5,7).
% node 6 (leaf): class draw (0)
leaf_class(10,6,0).
% node 7 (leaf): class thirteen (14)
leaf_class(10,7,14).
% node 8 (leaf): class fifteen (16)
leaf_class(10,8,16).
% node 9: f3 <= 5.5  (F3, bin <= 4)  left -> 10, right -> 13
node(10,9,3,4).
left_node(10,9,10).
right_node(10,9,13).
% node 10: f4 <= 1.5  (F4, bin <= 1)  left -> 11, right -> 12
node(10,10,4,1).
left_node(10,10,11).
right_node(10,10,12).
% node 11 (leaf): class twelve (13)
leaf_class(10,11,13).
% node 12 (leaf): class fourteen (15)
leaf_class(10,12,15).
% node 13: f3 <= 7.5  (F3, bin <= 6)  left -> 14, right -> 17
node(10,13,3,6).
left_node(10,13,14).
right_node(10,13,17).
% node 14: f5 <= 6.5  (F5, bin <= 4)  left -> 15, right -> 16
node(10,14,5,4).
left_node(10,14,15).
right_node(10,14,16).
% node 15 (leaf): class fifteen (16)
leaf_class(10,15,16).
% node 16 (leaf): class thirteen (14)
leaf_class(10,16,14).
% node 17 (leaf): class fourteen (15)
leaf_class(10,17,15).
% node 18: f3 <= 1.5  (F3, bin <= 0)  left -> 19, right -> 22
node(10,18,3,0).
left_node(10,18,19).
right_node(10,18,22).
% node 19: f5 <= 2.5  (F5, bin <= 1)  left -> 20, right -> 21
node(10,19,5,1).
left_node(10,19,20).
right_node(10,19,21).
% node 20 (leaf): class draw (0)
leaf_class(10,20,0).
% node 21 (leaf): class fourteen (15)
leaf_class(10,21,15).
% node 22: f5 <= 1.5  (F5, bin <= 0)  left -> 23, right -> 24
node(10,22,5,0).
left_node(10,22,23).
right_node(10,22,24).
% node 23 (leaf): class ten (11)
leaf_class(10,23,11).
% node 24 (leaf): class fourteen (15)
leaf_class(10,24,15).
% node 25: f2 <= 5.5  (F2, bin <= 5)  left -> 26, right -> 31
node(10,25,2,5).
left_node(10,25,26).
right_node(10,25,31).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 28
node(10,26,5,1).
left_node(10,26,27).
right_node(10,26,28).
% node 27 (leaf): class twelve (13)
leaf_class(10,27,13).
% node 28: f0 <= 0.5  (F0, bin <= 0)  left -> 29, right -> 30
node(10,28,0,0).
left_node(10,28,29).
right_node(10,28,30).
% node 29 (leaf): class fourteen (15)
leaf_class(10,29,15).
% node 30 (leaf): class thirteen (14)
leaf_class(10,30,14).
% node 31 (leaf): class draw (0)
leaf_class(10,31,0).
% node 32: f1 <= 2.5  (F1, bin <= 1)  left -> 33, right -> 66
node(10,32,1,1).
left_node(10,32,33).
right_node(10,32,66).
% node 33: f1 <= 1.5  (F1, bin <= 0)  left -> 34, right -> 51
node(10,33,1,0).
left_node(10,33,34).
right_node(10,33,51).
% node 34: f2 <= 0.5  (F2, bin <= 0)  left -> 35, right -> 40
node(10,34,2,0).
left_node(10,34,35).
right_node(10,34,40).
% node 35: f5 <= 2.5  (F5, bin <= 1)  left -> 36, right -> 37
node(10,35,5,1).
left_node(10,35,36).
right_node(10,35,37).
% node 36 (leaf): class six (7)
leaf_class(10,36,7).
% node 37: f4 <= 1.5  (F4, bin <= 1)  left -> 38, right -> 39
node(10,37,4,1).
left_node(10,37,38).
right_node(10,37,39).
% node 38 (leaf): class draw (0)
leaf_class(10,38,0).
% node 39 (leaf): class fourteen (15)
leaf_class(10,39,15).
% node 40: f4 <= 6.5  (F4, bin <= 8)  left -> 41, right -> 48
node(10,40,4,8).
left_node(10,40,41).
right_node(10,40,48).
% node 41: f2 <= 6.5  (F2, bin <= 6)  left -> 42, right -> 45
node(10,41,2,6).
left_node(10,41,42).
right_node(10,41,45).
% node 42: f3 <= 5.5  (F3, bin <= 4)  left -> 43, right -> 44
node(10,42,3,4).
left_node(10,42,43).
right_node(10,42,44).
% node 43 (leaf): class fourteen (15)
leaf_class(10,43,15).
% node 44 (leaf): class fifteen (16)
leaf_class(10,44,16).
% node 45: f5 <= 2.5  (F5, bin <= 1)  left -> 46, right -> 47
node(10,45,5,1).
left_node(10,45,46).
right_node(10,45,47).
% node 46 (leaf): class nine (10)
leaf_class(10,46,10).
% node 47 (leaf): class fourteen (15)
leaf_class(10,47,15).
% node 48: f5 <= 2.5  (F5, bin <= 1)  left -> 49, right -> 50
node(10,48,5,1).
left_node(10,48,49).
right_node(10,48,50).
% node 49 (leaf): class eight (9)
leaf_class(10,49,9).
% node 50 (leaf): class twelve (13)
leaf_class(10,50,13).
% node 51: f4 <= 1.5  (F4, bin <= 1)  left -> 52, right -> 57
node(10,51,4,1).
left_node(10,51,52).
right_node(10,51,57).
% node 52: f4 <= 0.5  (F4, bin <= 0)  left -> 53, right -> 56
node(10,52,4,0).
left_node(10,52,53).
right_node(10,52,56).
% node 53: f5 <= 2.5  (F5, bin <= 1)  left -> 54, right -> 55
node(10,53,5,1).
left_node(10,53,54).
right_node(10,53,55).
% node 54 (leaf): class four (5)
leaf_class(10,54,5).
% node 55 (leaf): class eleven (12)
leaf_class(10,55,12).
% node 56 (leaf): class twelve (13)
leaf_class(10,56,13).
% node 57: f5 <= 2.5  (F5, bin <= 1)  left -> 58, right -> 61
node(10,57,5,1).
left_node(10,57,58).
right_node(10,57,61).
% node 58: f2 <= 4.5  (F2, bin <= 4)  left -> 59, right -> 60
node(10,58,2,4).
left_node(10,58,59).
right_node(10,58,60).
% node 59 (leaf): class eight (9)
leaf_class(10,59,9).
% node 60 (leaf): class draw (0)
leaf_class(10,60,0).
% node 61: f3 <= 4.5  (F3, bin <= 3)  left -> 62, right -> 63
node(10,61,3,3).
left_node(10,61,62).
right_node(10,61,63).
% node 62 (leaf): class thirteen (14)
leaf_class(10,62,14).
% node 63: f3 <= 6.5  (F3, bin <= 5)  left -> 64, right -> 65
node(10,63,3,5).
left_node(10,63,64).
right_node(10,63,65).
% node 64 (leaf): class twelve (13)
leaf_class(10,64,13).
% node 65 (leaf): class thirteen (14)
leaf_class(10,65,14).
% node 66: f1 <= 3.5  (F1, bin <= 2)  left -> 67, right -> 86
node(10,66,1,2).
left_node(10,66,67).
right_node(10,66,86).
% node 67: f4 <= 1.5  (F4, bin <= 1)  left -> 68, right -> 77
node(10,67,4,1).
left_node(10,67,68).
right_node(10,67,77).
% node 68: f3 <= 3.5  (F3, bin <= 2)  left -> 69, right -> 72
node(10,68,3,2).
left_node(10,68,69).
right_node(10,68,72).
% node 69: f5 <= 2.5  (F5, bin <= 1)  left -> 70, right -> 71
node(10,69,5,1).
left_node(10,69,70).
right_node(10,69,71).
% node 70 (leaf): class draw (0)
leaf_class(10,70,0).
% node 71 (leaf): class ten (11)
leaf_class(10,71,11).
% node 72: f0 <= 2.5  (F0, bin <= 2)  left -> 73, right -> 74
node(10,72,0,2).
left_node(10,72,73).
right_node(10,72,74).
% node 73 (leaf): class two (3)
leaf_class(10,73,3).
% node 74: f5 <= 1.5  (F5, bin <= 0)  left -> 75, right -> 76
node(10,74,5,0).
left_node(10,74,75).
right_node(10,74,76).
% node 75 (leaf): class five (6)
leaf_class(10,75,6).
% node 76 (leaf): class ten (11)
leaf_class(10,76,11).
% node 77: f5 <= 2.5  (F5, bin <= 1)  left -> 78, right -> 81
node(10,77,5,1).
left_node(10,77,78).
right_node(10,77,81).
% node 78: f4 <= 3.5  (F4, bin <= 5)  left -> 79, right -> 80
node(10,78,4,5).
left_node(10,78,79).
right_node(10,78,80).
% node 79 (leaf): class two (3)
leaf_class(10,79,3).
% node 80 (leaf): class eight (9)
leaf_class(10,80,9).
% node 81: f5 <= 7.5  (F5, bin <= 5)  left -> 82, right -> 85
node(10,81,5,5).
left_node(10,81,82).
right_node(10,81,85).
% node 82: f4 <= 6.5  (F4, bin <= 8)  left -> 83, right -> 84
node(10,82,4,8).
left_node(10,82,83).
right_node(10,82,84).
% node 83 (leaf): class twelve (13)
leaf_class(10,83,13).
% node 84 (leaf): class eleven (12)
leaf_class(10,84,12).
% node 85 (leaf): class eleven (12)
leaf_class(10,85,12).
% node 86: f4 <= 3.5  (F4, bin <= 5)  left -> 87, right -> 88
node(10,86,4,5).
left_node(10,86,87).
right_node(10,86,88).
% node 87 (leaf): class eight (9)
leaf_class(10,87,9).
% node 88: f4 <= 6.5  (F4, bin <= 8)  left -> 89, right -> 92
node(10,88,4,8).
left_node(10,88,89).
right_node(10,88,92).
% node 89: f5 <= 2.5  (F5, bin <= 1)  left -> 90, right -> 91
node(10,89,5,1).
left_node(10,89,90).
right_node(10,89,91).
% node 90 (leaf): class nine (10)
leaf_class(10,90,10).
% node 91 (leaf): class eleven (12)
leaf_class(10,91,12).
% node 92 (leaf): class nine (10)
leaf_class(10,92,10).

% Tree 11
tree(11).
% node 0: f1 <= 2.5  (F1, bin <= 1)  left -> 1, right -> 44
node(11,0,1,1).
left_node(11,0,1).
right_node(11,0,44).
% node 1: f4 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 5
node(11,1,4,0).
left_node(11,1,2).
right_node(11,1,5).
% node 2: f5 <= 2.5  (F5, bin <= 1)  left -> 3, right -> 4
node(11,2,5,1).
left_node(11,2,3).
right_node(11,2,4).
% node 3 (leaf): class two (3)
leaf_class(11,3,3).
% node 4 (leaf): class eleven (12)
leaf_class(11,4,12).
% node 5: f5 <= 2.5  (F5, bin <= 1)  left -> 6, right -> 23
node(11,5,5,1).
left_node(11,5,6).
right_node(11,5,23).
% node 6: f0 <= 2.5  (F0, bin <= 2)  left -> 7, right -> 16
node(11,6,0,2).
left_node(11,6,7).
right_node(11,6,16).
% node 7: f5 <= 1.5  (F5, bin <= 0)  left -> 8, right -> 9
node(11,7,5,0).
left_node(11,7,8).
right_node(11,7,9).
% node 8 (leaf): class ten (11)
leaf_class(11,8,11).
% node 9: f4 <= 5.5  (F4, bin <= 7)  left -> 10, right -> 13
node(11,9,4,7).
left_node(11,9,10).
right_node(11,9,13).
% node 10: f3 <= 4.5  (F3, bin <= 3)  left -> 11, right -> 12
node(11,10,3,3).
left_node(11,10,11).
right_node(11,10,12).
% node 11 (leaf): class draw (0)
leaf_class(11,11,0).
% node 12 (leaf): class fourteen (15)
leaf_class(11,12,15).
% node 13: f2 <= 4.5  (F2, bin <= 4)  left -> 14, right -> 15
node(11,13,2,4).
left_node(11,13,14).
right_node(11,13,15).
% node 14 (leaf): class nine (10)
leaf_class(11,14,10).
% node 15 (leaf): class draw (0)
leaf_class(11,15,0).
% node 16: f5 <= 1.5  (F5, bin <= 0)  left -> 17, right -> 22
node(11,16,5,0).
left_node(11,16,17).
right_node(11,16,22).
% node 17: f2 <= 4.5  (F2, bin <= 4)  left -> 18, right -> 21
node(11,17,2,4).
left_node(11,17,18).
right_node(11,17,21).
% node 18: f4 <= 3.0  (F4, bin <= 4)  left -> 19, right -> 20
node(11,18,4,4).
left_node(11,18,19).
right_node(11,18,20).
% node 19 (leaf): class five (6)
leaf_class(11,19,6).
% node 20 (leaf): class six (7)
leaf_class(11,20,7).
% node 21 (leaf): class four (5)
leaf_class(11,21,5).
% node 22 (leaf): class eight (9)
leaf_class(11,22,9).
% node 23: f5 <= 6.5  (F5, bin <= 4)  left -> 24, right -> 33
node(11,23,5,4).
left_node(11,23,24).
right_node(11,23,33).
% node 24: f4 <= 6.5  (F4, bin <= 8)  left -> 25, right -> 30
node(11,24,4,8).
left_node(11,24,25).
right_node(11,24,30).
% node 25: f2 <= 0.5  (F2, bin <= 0)  left -> 26, right -> 27
node(11,25,2,0).
left_node(11,25,26).
right_node(11,25,27).
% node 26 (leaf): class fourteen (15)
leaf_class(11,26,15).
% node 27: f3 <= 5.5  (F3, bin <= 4)  left -> 28, right -> 29
node(11,27,3,4).
left_node(11,27,28).
right_node(11,27,29).
% node 28 (leaf): class fourteen (15)
leaf_class(11,28,15).
% node 29 (leaf): class fourteen (15)
leaf_class(11,29,15).
% node 30: f2 <= 5.5  (F2, bin <= 5)  left -> 31, right -> 32
node(11,30,2,5).
left_node(11,30,31).
right_node(11,30,32).
% node 31 (leaf): class thirteen (14)
leaf_class(11,31,14).
% node 32 (leaf): class draw (0)
leaf_class(11,32,0).
% node 33: f5 <= 7.5  (F5, bin <= 5)  left -> 34, right -> 39
node(11,33,5,5).
left_node(11,33,34).
right_node(11,33,39).
% node 34: f0 <= 1.5  (F0, bin <= 1)  left -> 35, right -> 36
node(11,34,0,1).
left_node(11,34,35).
right_node(11,34,36).
% node 35 (leaf): class fourteen (15)
leaf_class(11,35,15).
% node 36: f1 <= 1.5  (F1, bin <= 0)  left -> 37, right -> 38
node(11,36,1,0).
left_node(11,36,37).
right_node(11,36,38).
% node 37 (leaf): class fourteen (15)
leaf_class(11,37,15).
% node 38 (leaf): class thirteen (14)
leaf_class(11,38,14).
% node 39: f2 <= 6.5  (F2, bin <= 6)  left -> 40, right -> 43
node(11,39,2,6).
left_node(11,39,40).
right_node(11,39,43).
% node 40: f3 <= 6.5  (F3, bin <= 5)  left -> 41, right -> 42
node(11,40,3,5).
left_node(11,40,41).
right_node(11,40,42).
% node 41 (leaf): class thirteen (14)
leaf_class(11,41,14).
% node 42 (leaf): class draw (0)
leaf_class(11,42,0).
% node 43 (leaf): class twelve (13)
leaf_class(11,43,13).
% node 44: f1 <= 3.5  (F1, bin <= 2)  left -> 45, right -> 70
node(11,44,1,2).
left_node(11,44,45).
right_node(11,44,70).
% node 45: f4 <= 1.5  (F4, bin <= 1)  left -> 46, right -> 55
node(11,45,4,1).
left_node(11,45,46).
right_node(11,45,55).
% node 46: f0 <= 2.5  (F0, bin <= 2)  left -> 47, right -> 48
node(11,46,0,2).
left_node(11,46,47).
right_node(11,46,48).
% node 47 (leaf): class two (3)
leaf_class(11,47,3).
% node 48: f2 <= 1.5  (F2, bin <= 1)  left -> 49, right -> 50
node(11,48,2,1).
left_node(11,48,49).
right_node(11,48,50).
% node 49 (leaf): class draw (0)
leaf_class(11,49,0).
% node 50: f5 <= 3.5  (F5, bin <= 2)  left -> 51, right -> 54
node(11,50,5,2).
left_node(11,50,51).
right_node(11,50,54).
% node 51: f5 <= 2.5  (F5, bin <= 1)  left -> 52, right -> 53
node(11,51,5,1).
left_node(11,51,52).
right_node(11,51,53).
% node 52 (leaf): class six (7)
leaf_class(11,52,7).
% node 53 (leaf): class seven (8)
leaf_class(11,53,8).
% node 54 (leaf): class nine (10)
leaf_class(11,54,10).
% node 55: f2 <= 3.5  (F2, bin <= 3)  left -> 56, right -> 61
node(11,55,2,3).
left_node(11,55,56).
right_node(11,55,61).
% node 56: f0 <= 2.5  (F0, bin <= 2)  left -> 57, right -> 58
node(11,56,0,2).
left_node(11,56,57).
right_node(11,56,58).
% node 57 (leaf): class twelve (13)
leaf_class(11,57,13).
% node 58: f5 <= 3.5  (F5, bin <= 2)  left -> 59, right -> 60
node(11,58,5,2).
left_node(11,58,59).
right_node(11,58,60).
% node 59 (leaf): class eight (9)
leaf_class(11,59,9).
% node 60 (leaf): class twelve (13)
leaf_class(11,60,13).
% node 61: f4 <= 6.5  (F4, bin <= 8)  left -> 62, right -> 67
node(11,61,4,8).
left_node(11,61,62).
right_node(11,61,67).
% node 62: f0 <= 2.5  (F0, bin <= 2)  left -> 63, right -> 64
node(11,62,0,2).
left_node(11,62,63).
right_node(11,62,64).
% node 63 (leaf): class draw (0)
leaf_class(11,63,0).
% node 64: f5 <= 2.5  (F5, bin <= 1)  left -> 65, right -> 66
node(11,64,5,1).
left_node(11,64,65).
right_node(11,64,66).
% node 65 (leaf): class eight (9)
leaf_class(11,65,9).
% node 66 (leaf): class twelve (13)
leaf_class(11,66,13).
% node 67: f2 <= 5.5  (F2, bin <= 5)  left -> 68, right -> 69
node(11,67,2,5).
left_node(11,67,68).
right_node(11,67,69).
% node 68 (leaf): class ten (11)
leaf_class(11,68,11).
% node 69 (leaf): class draw (0)
leaf_class(11,69,0).
% node 70: f4 <= 3.5  (F4, bin <= 5)  left -> 71, right -> 72
node(11,70,4,5).
left_node(11,70,71).
right_node(11,70,72).
% node 71 (leaf): class eight (9)
leaf_class(11,71,9).
% node 72: f4 <= 6.5  (F4, bin <= 8)  left -> 73, right -> 80
node(11,72,4,8).
left_node(11,72,73).
right_node(11,72,80).
% node 73: f2 <= 3.5  (F2, bin <= 3)  left -> 74, right -> 77
node(11,73,2,3).
left_node(11,73,74).
right_node(11,73,77).
% node 74: f5 <= 2.5  (F5, bin <= 1)  left -> 75, right -> 76
node(11,74,5,1).
left_node(11,74,75).
right_node(11,74,76).
% node 75 (leaf): class nine (10)
leaf_class(11,75,10).
% node 76 (leaf): class eleven (12)
leaf_class(11,76,12).
% node 77: f5 <= 3.5  (F5, bin <= 2)  left -> 78, right -> 79
node(11,77,5,2).
left_node(11,77,78).
right_node(11,77,79).
% node 78 (leaf): class eight (9)
leaf_class(11,78,9).
% node 79 (leaf): class eleven (12)
leaf_class(11,79,12).
% node 80: f2 <= 5.5  (F2, bin <= 5)  left -> 81, right -> 84
node(11,80,2,5).
left_node(11,80,81).
right_node(11,80,84).
% node 81: f5 <= 2.5  (F5, bin <= 1)  left -> 82, right -> 83
node(11,81,5,1).
left_node(11,81,82).
right_node(11,81,83).
% node 82 (leaf): class eight (9)
leaf_class(11,82,9).
% node 83 (leaf): class nine (10)
leaf_class(11,83,10).
% node 84 (leaf): class draw (0)
leaf_class(11,84,0).

% Tree 12
tree(12).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 24
node(12,0,0,1).
left_node(12,0,1).
right_node(12,0,24).
% node 1: f0 <= 0.5  (F0, bin <= 0)  left -> 2, right -> 9
node(12,1,0,0).
left_node(12,1,2).
right_node(12,1,9).
% node 2: f2 <= 4.5  (F2, bin <= 4)  left -> 3, right -> 8
node(12,2,2,4).
left_node(12,2,3).
right_node(12,2,8).
% node 3: f5 <= 2.5  (F5, bin <= 1)  left -> 4, right -> 5
node(12,3,5,1).
left_node(12,3,4).
right_node(12,3,5).
% node 4 (leaf): class thirteen (14)
leaf_class(12,4,14).
% node 5: f4 <= 6.5  (F4, bin <= 8)  left -> 6, right -> 7
node(12,5,4,8).
left_node(12,5,6).
right_node(12,5,7).
% node 6 (leaf): class fifteen (16)
leaf_class(12,6,16).
% node 7 (leaf): class fourteen (15)
leaf_class(12,7,15).
% node 8 (leaf): class sixteen (17)
leaf_class(12,8,17).
% node 9: f4 <= 6.5  (F4, bin <= 8)  left -> 10, right -> 23
node(12,9,4,8).
left_node(12,9,10).
right_node(12,9,23).
% node 10: f2 <= 0.5  (F2, bin <= 0)  left -> 11, right -> 16
node(12,10,2,0).
left_node(12,10,11).
right_node(12,10,16).
% node 11: f4 <= 1.5  (F4, bin <= 1)  left -> 12, right -> 13
node(12,11,4,1).
left_node(12,11,12).
right_node(12,11,13).
% node 12 (leaf): class draw (0)
leaf_class(12,12,0).
% node 13: f5 <= 2.5  (F5, bin <= 1)  left -> 14, right -> 15
node(12,13,5,1).
left_node(12,13,14).
right_node(12,13,15).
% node 14 (leaf): class ten (11)
leaf_class(12,14,11).
% node 15 (leaf): class fourteen (15)
leaf_class(12,15,15).
% node 16: f5 <= 1.5  (F5, bin <= 0)  left -> 17, right -> 18
node(12,16,5,0).
left_node(12,16,17).
right_node(12,16,18).
% node 17 (leaf): class ten (11)
leaf_class(12,17,11).
% node 18: f2 <= 2.5  (F2, bin <= 2)  left -> 19, right -> 20
node(12,18,2,2).
left_node(12,18,19).
right_node(12,18,20).
% node 19 (leaf): class fifteen (16)
leaf_class(12,19,16).
% node 20: f4 <= 1.5  (F4, bin <= 1)  left -> 21, right -> 22
node(12,20,4,1).
left_node(12,20,21).
right_node(12,20,22).
% node 21 (leaf): class thirteen (14)
leaf_class(12,21,14).
% node 22 (leaf): class fourteen (15)
leaf_class(12,22,15).
% node 23 (leaf): class thirteen (14)
leaf_class(12,23,14).
% node 24: f4 <= 5.5  (F4, bin <= 7)  left -> 25, right -> 52
node(12,24,4,7).
left_node(12,24,25).
right_node(12,24,52).
% node 25: f4 <= 1.5  (F4, bin <= 1)  left -> 26, right -> 39
node(12,25,4,1).
left_node(12,25,26).
right_node(12,25,39).
% node 26: f2 <= 1.5  (F2, bin <= 1)  left -> 27, right -> 28
node(12,26,2,1).
left_node(12,26,27).
right_node(12,26,28).
% node 27 (leaf): class draw (0)
leaf_class(12,27,0).
% node 28: f1 <= 2.5  (F1, bin <= 1)  left -> 29, right -> 36
node(12,28,1,1).
left_node(12,28,29).
right_node(12,28,36).
% node 29: f1 <= 1.5  (F1, bin <= 0)  left -> 30, right -> 33
node(12,29,1,0).
left_node(12,29,30).
right_node(12,29,33).
% node 30: f2 <= 2.5  (F2, bin <= 2)  left -> 31, right -> 32
node(12,30,2,2).
left_node(12,30,31).
right_node(12,30,32).
% node 31 (leaf): class eleven (12)
leaf_class(12,31,12).
% node 32 (leaf): class thirteen (14)
leaf_class(12,32,14).
% node 33: f5 <= 2.5  (F5, bin <= 1)  left -> 34, right -> 35
node(12,33,5,1).
left_node(12,33,34).
right_node(12,33,35).
% node 34 (leaf): class four (5)
leaf_class(12,34,5).
% node 35 (leaf): class eleven (12)
leaf_class(12,35,12).
% node 36: f0 <= 2.5  (F0, bin <= 2)  left -> 37, right -> 38
node(12,36,0,2).
left_node(12,36,37).
right_node(12,36,38).
% node 37 (leaf): class two (3)
leaf_class(12,37,3).
% node 38 (leaf): class nine (10)
leaf_class(12,38,10).
% node 39: f0 <= 2.5  (F0, bin <= 2)  left -> 40, right -> 47
node(12,39,0,2).
left_node(12,39,40).
right_node(12,39,47).
% node 40: f1 <= 1.5  (F1, bin <= 0)  left -> 41, right -> 42
node(12,40,1,0).
left_node(12,40,41).
right_node(12,40,42).
% node 41 (leaf): class fourteen (15)
leaf_class(12,41,15).
% node 42: f5 <= 2.5  (F5, bin <= 1)  left -> 43, right -> 46
node(12,42,5,1).
left_node(12,42,43).
right_node(12,42,46).
% node 43: f2 <= 2.5  (F2, bin <= 2)  left -> 44, right -> 45
node(12,43,2,2).
left_node(12,43,44).
right_node(12,43,45).
% node 44 (leaf): class ten (11)
leaf_class(12,44,11).
% node 45 (leaf): class nine (10)
leaf_class(12,45,10).
% node 46 (leaf): class thirteen (14)
leaf_class(12,46,14).
% node 47: f3 <= 3.5  (F3, bin <= 2)  left -> 48, right -> 49
node(12,47,3,2).
left_node(12,47,48).
right_node(12,47,49).
% node 48 (leaf): class fourteen (15)
leaf_class(12,48,15).
% node 49: f1 <= 2.5  (F1, bin <= 1)  left -> 50, right -> 51
node(12,49,1,1).
left_node(12,49,50).
right_node(12,49,51).
% node 50 (leaf): class fourteen (15)
leaf_class(12,50,15).
% node 51 (leaf): class eight (9)
leaf_class(12,51,9).
% node 52: f1 <= 2.5  (F1, bin <= 1)  left -> 53, right -> 66
node(12,52,1,1).
left_node(12,52,53).
right_node(12,52,66).
% node 53: f4 <= 6.5  (F4, bin <= 8)  left -> 54, right -> 63
node(12,53,4,8).
left_node(12,53,54).
right_node(12,53,63).
% node 54: f1 <= 1.5  (F1, bin <= 0)  left -> 55, right -> 60
node(12,54,1,0).
left_node(12,54,55).
right_node(12,54,60).
% node 55: f2 <= 4.5  (F2, bin <= 4)  left -> 56, right -> 59
node(12,55,2,4).
left_node(12,55,56).
right_node(12,55,59).
% node 56: f5 <= 2.5  (F5, bin <= 1)  left -> 57, right -> 58
node(12,56,5,1).
left_node(12,56,57).
right_node(12,56,58).
% node 57 (leaf): class ten (11)
leaf_class(12,57,11).
% node 58 (leaf): class fourteen (15)
leaf_class(12,58,15).
% node 59 (leaf): class draw (0)
leaf_class(12,59,0).
% node 60: f5 <= 2.5  (F5, bin <= 1)  left -> 61, right -> 62
node(12,60,5,1).
left_node(12,60,61).
right_node(12,60,62).
% node 61 (leaf): class eight (9)
leaf_class(12,61,9).
% node 62 (leaf): class thirteen (14)
leaf_class(12,62,14).
% node 63: f5 <= 2.5  (F5, bin <= 1)  left -> 64, right -> 65
node(12,63,5,1).
left_node(12,63,64).
right_node(12,63,65).
% node 64 (leaf): class eight (9)
leaf_class(12,64,9).
% node 65 (leaf): class twelve (13)
leaf_class(12,65,13).
% node 66: f0 <= 2.5  (F0, bin <= 2)  left -> 67, right -> 74
node(12,66,0,2).
left_node(12,66,67).
right_node(12,66,74).
% node 67: f2 <= 4.5  (F2, bin <= 4)  left -> 68, right -> 73
node(12,67,2,4).
left_node(12,67,68).
right_node(12,67,73).
% node 68: f2 <= 3.5  (F2, bin <= 3)  left -> 69, right -> 72
node(12,68,2,3).
left_node(12,68,69).
right_node(12,68,72).
% node 69: f5 <= 2.5  (F5, bin <= 1)  left -> 70, right -> 71
node(12,69,5,1).
left_node(12,69,70).
right_node(12,69,71).
% node 70 (leaf): class nine (10)
leaf_class(12,70,10).
% node 71 (leaf): class twelve (13)
leaf_class(12,71,13).
% node 72 (leaf): class eleven (12)
leaf_class(12,72,12).
% node 73 (leaf): class draw (0)
leaf_class(12,73,0).
% node 74: f5 <= 2.5  (F5, bin <= 1)  left -> 75, right -> 76
node(12,74,5,1).
left_node(12,74,75).
right_node(12,74,76).
% node 75 (leaf): class eight (9)
leaf_class(12,75,9).
% node 76: f2 <= 5.5  (F2, bin <= 5)  left -> 77, right -> 78
node(12,76,2,5).
left_node(12,76,77).
right_node(12,76,78).
% node 77 (leaf): class nine (10)
leaf_class(12,77,10).
% node 78 (leaf): class draw (0)
leaf_class(12,78,0).

% Tree 13
tree(13).
% node 0: f1 <= 2.5  (F1, bin <= 1)  left -> 1, right -> 64
node(13,0,1,1).
left_node(13,0,1).
right_node(13,0,64).
% node 1: f4 <= 1.5  (F4, bin <= 1)  left -> 2, right -> 23
node(13,1,4,1).
left_node(13,1,2).
right_node(13,1,23).
% node 2: f3 <= 2.5  (F3, bin <= 1)  left -> 3, right -> 4
node(13,2,3,1).
left_node(13,2,3).
right_node(13,2,4).
% node 3 (leaf): class thirteen (14)
leaf_class(13,3,14).
% node 4: f2 <= 2.5  (F2, bin <= 2)  left -> 5, right -> 12
node(13,4,2,2).
left_node(13,4,5).
right_node(13,4,12).
% node 5: f5 <= 2.5  (F5, bin <= 1)  left -> 6, right -> 7
node(13,5,5,1).
left_node(13,5,6).
right_node(13,5,7).
% node 6 (leaf): class eleven (12)
leaf_class(13,6,12).
% node 7: f4 <= 0.5  (F4, bin <= 0)  left -> 8, right -> 11
node(13,7,4,0).
left_node(13,7,8).
right_node(13,7,11).
% node 8: f2 <= 1.5  (F2, bin <= 1)  left -> 9, right -> 10
node(13,8,2,1).
left_node(13,8,9).
right_node(13,8,10).
% node 9 (leaf): class draw (0)
leaf_class(13,9,0).
% node 10 (leaf): class ten (11)
leaf_class(13,10,11).
% node 11 (leaf): class draw (0)
leaf_class(13,11,0).
% node 12: f4 <= 0.5  (F4, bin <= 0)  left -> 13, right -> 18
node(13,12,4,0).
left_node(13,12,13).
right_node(13,12,18).
% node 13: f5 <= 2.5  (F5, bin <= 1)  left -> 14, right -> 17
node(13,13,5,1).
left_node(13,13,14).
right_node(13,13,17).
% node 14: f0 <= 2.5  (F0, bin <= 2)  left -> 15, right -> 16
node(13,14,0,2).
left_node(13,14,15).
right_node(13,14,16).
% node 15 (leaf): class two (3)
leaf_class(13,15,3).
% node 16 (leaf): class four (5)
leaf_class(13,16,5).
% node 17 (leaf): class twelve (13)
leaf_class(13,17,13).
% node 18: f2 <= 3.5  (F2, bin <= 3)  left -> 19, right -> 20
node(13,18,2,3).
left_node(13,18,19).
right_node(13,18,20).
% node 19 (leaf): class eleven (12)
leaf_class(13,19,12).
% node 20: f5 <= 2.5  (F5, bin <= 1)  left -> 21, right -> 22
node(13,20,5,1).
left_node(13,20,21).
right_node(13,20,22).
% node 21 (leaf): class four (5)
leaf_class(13,21,5).
% node 22 (leaf): class thirteen (14)
leaf_class(13,22,14).
% node 23: f1 <= 1.5  (F1, bin <= 0)  left -> 24, right -> 45
node(13,23,1,0).
left_node(13,23,24).
right_node(13,23,45).
% node 24: f4 <= 6.5  (F4, bin <= 8)  left -> 25, right -> 38
node(13,24,4,8).
left_node(13,24,25).
right_node(13,24,38).
% node 25: f2 <= 0.5  (F2, bin <= 0)  left -> 26, right -> 31
node(13,25,2,0).
left_node(13,25,26).
right_node(13,25,31).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 28
node(13,26,5,1).
left_node(13,26,27).
right_node(13,26,28).
% node 27 (leaf): class ten (11)
leaf_class(13,27,11).
% node 28: f5 <= 7.5  (F5, bin <= 5)  left -> 29, right -> 30
node(13,28,5,5).
left_node(13,28,29).
right_node(13,28,30).
% node 29 (leaf): class fourteen (15)
leaf_class(13,29,15).
% node 30 (leaf): class thirteen (14)
leaf_class(13,30,14).
% node 31: f2 <= 2.5  (F2, bin <= 2)  left -> 32, right -> 35
node(13,31,2,2).
left_node(13,31,32).
right_node(13,31,35).
% node 32: f5 <= 2.5  (F5, bin <= 1)  left -> 33, right -> 34
node(13,32,5,1).
left_node(13,32,33).
right_node(13,32,34).
% node 33 (leaf): class ten (11)
leaf_class(13,33,11).
% node 34 (leaf): class fourteen (15)
leaf_class(13,34,15).
% node 35: f5 <= 6.5  (F5, bin <= 4)  left -> 36, right -> 37
node(13,35,5,4).
left_node(13,35,36).
right_node(13,35,37).
% node 36 (leaf): class fifteen (16)
leaf_class(13,36,16).
% node 37 (leaf): class fourteen (15)
leaf_class(13,37,15).
% node 38: f5 <= 2.5  (F5, bin <= 1)  left -> 39, right -> 40
node(13,38,5,1).
left_node(13,38,39).
right_node(13,38,40).
% node 39 (leaf): class twelve (13)
leaf_class(13,39,13).
% node 40: f2 <= 5.5  (F2, bin <= 5)  left -> 41, right -> 44
node(13,40,2,5).
left_node(13,40,41).
right_node(13,40,44).
% node 41: f2 <= 3.5  (F2, bin <= 3)  left -> 42, right -> 43
node(13,41,2,3).
left_node(13,41,42).
right_node(13,41,43).
% node 42 (leaf): class fourteen (15)
leaf_class(13,42,15).
% node 43 (leaf): class twelve (13)
leaf_class(13,43,13).
% node 44 (leaf): class draw (0)
leaf_class(13,44,0).
% node 45: f2 <= 2.5  (F2, bin <= 2)  left -> 46, right -> 57
node(13,45,2,2).
left_node(13,45,46).
right_node(13,45,57).
% node 46: f0 <= 1.5  (F0, bin <= 1)  left -> 47, right -> 52
node(13,46,0,1).
left_node(13,46,47).
right_node(13,46,52).
% node 47: f5 <= 2.5  (F5, bin <= 1)  left -> 48, right -> 49
node(13,47,5,1).
left_node(13,47,48).
right_node(13,47,49).
% node 48 (leaf): class ten (11)
leaf_class(13,48,11).
% node 49: f4 <= 6.5  (F4, bin <= 8)  left -> 50, right -> 51
node(13,49,4,8).
left_node(13,49,50).
right_node(13,49,51).
% node 50 (leaf): class fourteen (15)
leaf_class(13,50,15).
% node 51 (leaf): class thirteen (14)
leaf_class(13,51,14).
% node 52: f4 <= 6.5  (F4, bin <= 8)  left -> 53, right -> 56
node(13,52,4,8).
left_node(13,52,53).
right_node(13,52,56).
% node 53: f5 <= 2.5  (F5, bin <= 1)  left -> 54, right -> 55
node(13,53,5,1).
left_node(13,53,54).
right_node(13,53,55).
% node 54 (leaf): class eight (9)
leaf_class(13,54,9).
% node 55 (leaf): class thirteen (14)
leaf_class(13,55,14).
% node 56 (leaf): class eleven (12)
leaf_class(13,56,12).
% node 57: f5 <= 5.5  (F5, bin <= 3)  left -> 58, right -> 61
node(13,57,5,3).
left_node(13,57,58).
right_node(13,57,61).
% node 58: f5 <= 2.5  (F5, bin <= 1)  left -> 59, right -> 60
node(13,58,5,1).
left_node(13,58,59).
right_node(13,58,60).
% node 59 (leaf): class draw (0)
leaf_class(13,59,0).
% node 60 (leaf): class fourteen (15)
leaf_class(13,60,15).
% node 61: f3 <= 5.5  (F3, bin <= 4)  left -> 62, right -> 63
node(13,61,3,4).
left_node(13,61,62).
right_node(13,61,63).
% node 62 (leaf): class thirteen (14)
leaf_class(13,62,14).
% node 63 (leaf): class draw (0)
leaf_class(13,63,0).
% node 64: f5 <= 2.5  (F5, bin <= 1)  left -> 65, right -> 72
node(13,64,5,1).
left_node(13,64,65).
right_node(13,64,72).
% node 65: f4 <= 2.5  (F4, bin <= 3)  left -> 66, right -> 71
node(13,65,4,3).
left_node(13,65,66).
right_node(13,65,71).
% node 66: f1 <= 3.5  (F1, bin <= 2)  left -> 67, right -> 70
node(13,66,1,2).
left_node(13,66,67).
right_node(13,66,70).
% node 67: f0 <= 2.5  (F0, bin <= 2)  left -> 68, right -> 69
node(13,67,0,2).
left_node(13,67,68).
right_node(13,67,69).
% node 68 (leaf): class two (3)
leaf_class(13,68,3).
% node 69 (leaf): class five (6)
leaf_class(13,69,6).
% node 70 (leaf): class eight (9)
leaf_class(13,70,9).
% node 71 (leaf): class eight (9)
leaf_class(13,71,9).
% node 72: f1 <= 3.5  (F1, bin <= 2)  left -> 73, right -> 84
node(13,72,1,2).
left_node(13,72,73).
right_node(13,72,84).
% node 73: f5 <= 7.5  (F5, bin <= 5)  left -> 74, right -> 83
node(13,73,5,5).
left_node(13,73,74).
right_node(13,73,83).
% node 74: f0 <= 2.5  (F0, bin <= 2)  left -> 75, right -> 78
node(13,74,0,2).
left_node(13,74,75).
right_node(13,74,78).
% node 75: f2 <= 4.5  (F2, bin <= 4)  left -> 76, right -> 77
node(13,75,2,4).
left_node(13,75,76).
right_node(13,75,77).
% node 76 (leaf): class twelve (13)
leaf_class(13,76,13).
% node 77 (leaf): class thirteen (14)
leaf_class(13,77,14).
% node 78: f4 <= 0.5  (F4, bin <= 0)  left -> 79, right -> 80
node(13,78,4,0).
left_node(13,78,79).
right_node(13,78,80).
% node 79 (leaf): class nine (10)
leaf_class(13,79,10).
% node 80: f5 <= 3.5  (F5, bin <= 2)  left -> 81, right -> 82
node(13,80,5,2).
left_node(13,80,81).
right_node(13,80,82).
% node 81 (leaf): class nine (10)
leaf_class(13,81,10).
% node 82 (leaf): class twelve (13)
leaf_class(13,82,13).
% node 83 (leaf): class eleven (12)
leaf_class(13,83,12).
% node 84 (leaf): class eleven (12)
leaf_class(13,84,12).

% Tree 14
tree(14).
% node 0: f1 <= 1.5  (F1, bin <= 0)  left -> 1, right -> 30
node(14,0,1,0).
left_node(14,0,1).
right_node(14,0,30).
% node 1: f0 <= 1.5  (F0, bin <= 1)  left -> 2, right -> 17
node(14,1,0,1).
left_node(14,1,2).
right_node(14,1,17).
% node 2: f2 <= 2.5  (F2, bin <= 2)  left -> 3, right -> 10
node(14,2,2,2).
left_node(14,2,3).
right_node(14,2,10).
% node 3: f4 <= 1.5  (F4, bin <= 1)  left -> 4, right -> 5
node(14,3,4,1).
left_node(14,3,4).
right_node(14,3,5).
% node 4 (leaf): class draw (0)
leaf_class(14,4,0).
% node 5: f5 <= 2.5  (F5, bin <= 1)  left -> 6, right -> 7
node(14,5,5,1).
left_node(14,5,6).
right_node(14,5,7).
% node 6 (leaf): class eleven (12)
leaf_class(14,6,12).
% node 7: f4 <= 6.5  (F4, bin <= 8)  left -> 8, right -> 9
node(14,7,4,8).
left_node(14,7,8).
right_node(14,7,9).
% node 8 (leaf): class fifteen (16)
leaf_class(14,8,16).
% node 9 (leaf): class fourteen (15)
leaf_class(14,9,15).
% node 10: f5 <= 6.5  (F5, bin <= 4)  left -> 11, right -> 16
node(14,10,5,4).
left_node(14,10,11).
right_node(14,10,16).
% node 11: f5 <= 2.5  (F5, bin <= 1)  left -> 12, right -> 13
node(14,11,5,1).
left_node(14,11,12).
right_node(14,11,13).
% node 12 (leaf): class thirteen (14)
leaf_class(14,12,14).
% node 13: f4 <= 0.5  (F4, bin <= 0)  left -> 14, right -> 15
node(14,13,4,0).
left_node(14,13,14).
right_node(14,13,15).
% node 14 (leaf): class twelve (13)
leaf_class(14,14,13).
% node 15 (leaf): class fifteen (16)
leaf_class(14,15,16).
% node 16 (leaf): class fourteen (15)
leaf_class(14,16,15).
% node 17: f5 <= 2.5  (F5, bin <= 1)  left -> 18, right -> 19
node(14,17,5,1).
left_node(14,17,18).
right_node(14,17,19).
% node 18 (leaf): class eight (9)
leaf_class(14,18,9).
% node 19: f0 <= 2.5  (F0, bin <= 2)  left -> 20, right -> 23
node(14,19,0,2).
left_node(14,19,20).
right_node(14,19,23).
% node 20: f5 <= 6.5  (F5, bin <= 4)  left -> 21, right -> 22
node(14,20,5,4).
left_node(14,20,21).
right_node(14,20,22).
% node 21 (leaf): class fourteen (15)
leaf_class(14,21,15).
% node 22 (leaf): class fourteen (15)
leaf_class(14,22,15).
% node 23: f4 <= 0.5  (F4, bin <= 0)  left -> 24, right -> 25
node(14,23,4,0).
left_node(14,23,24).
right_node(14,23,25).
% node 24 (leaf): class twelve (13)
leaf_class(14,24,13).
% node 25: f2 <= 0.5  (F2, bin <= 0)  left -> 26, right -> 27
node(14,25,2,0).
left_node(14,25,26).
right_node(14,25,27).
% node 26 (leaf): class fourteen (15)
leaf_class(14,26,15).
% node 27: f4 <= 6.5  (F4, bin <= 8)  left -> 28, right -> 29
node(14,27,4,8).
left_node(14,27,28).
right_node(14,27,29).
% node 28 (leaf): class fourteen (15)
leaf_class(14,28,15).
% node 29 (leaf): class twelve (13)
leaf_class(14,29,13).
% node 30: f2 <= 2.5  (F2, bin <= 2)  left -> 31, right -> 58
node(14,30,2,2).
left_node(14,30,31).
right_node(14,30,58).
% node 31: f4 <= 1.5  (F4, bin <= 1)  left -> 32, right -> 33
node(14,31,4,1).
left_node(14,31,32).
right_node(14,31,33).
% node 32 (leaf): class draw (0)
leaf_class(14,32,0).
% node 33: f0 <= 2.5  (F0, bin <= 2)  left -> 34, right -> 45
node(14,33,0,2).
left_node(14,33,34).
right_node(14,33,45).
% node 34: f1 <= 2.5  (F1, bin <= 1)  left -> 35, right -> 40
node(14,34,1,1).
left_node(14,34,35).
right_node(14,34,40).
% node 35: f5 <= 2.5  (F5, bin <= 1)  left -> 36, right -> 37
node(14,35,5,1).
left_node(14,35,36).
right_node(14,35,37).
% node 36 (leaf): class eight (9)
leaf_class(14,36,9).
% node 37: f5 <= 5.5  (F5, bin <= 3)  left -> 38, right -> 39
node(14,37,5,3).
left_node(14,37,38).
right_node(14,37,39).
% node 38 (leaf): class fourteen (15)
leaf_class(14,38,15).
% node 39 (leaf): class thirteen (14)
leaf_class(14,39,14).
% node 40: f5 <= 2.5  (F5, bin <= 1)  left -> 41, right -> 42
node(14,40,5,1).
left_node(14,40,41).
right_node(14,40,42).
% node 41 (leaf): class ten (11)
leaf_class(14,41,11).
% node 42: f4 <= 5.5  (F4, bin <= 7)  left -> 43, right -> 44
node(14,42,4,7).
left_node(14,42,43).
right_node(14,42,44).
% node 43 (leaf): class thirteen (14)
leaf_class(14,43,14).
% node 44 (leaf): class twelve (13)
leaf_class(14,44,13).
% node 45: f4 <= 6.5  (F4, bin <= 8)  left -> 46, right -> 51
node(14,45,4,8).
left_node(14,45,46).
right_node(14,45,51).
% node 46: f1 <= 2.5  (F1, bin <= 1)  left -> 47, right -> 48
node(14,46,1,1).
left_node(14,46,47).
right_node(14,46,48).
% node 47 (leaf): class thirteen (14)
leaf_class(14,47,14).
% node 48: f5 <= 3.5  (F5, bin <= 2)  left -> 49, right -> 50
node(14,48,5,2).
left_node(14,48,49).
right_node(14,48,50).
% node 49 (leaf): class eight (9)
leaf_class(14,49,9).
% node 50 (leaf): class twelve (13)
leaf_class(14,50,13).
% node 51: f5 <= 2.5  (F5, bin <= 1)  left -> 52, right -> 55
node(14,51,5,1).
left_node(14,51,52).
right_node(14,51,55).
% node 52: f5 <= 1.5  (F5, bin <= 0)  left -> 53, right -> 54
node(14,52,5,0).
left_node(14,52,53).
right_node(14,52,54).
% node 53 (leaf): class six (7)
leaf_class(14,53,7).
% node 54 (leaf): class eight (9)
leaf_class(14,54,9).
% node 55: f1 <= 3.5  (F1, bin <= 2)  left -> 56, right -> 57
node(14,55,1,2).
left_node(14,55,56).
right_node(14,55,57).
% node 56 (leaf): class eleven (12)
leaf_class(14,56,12).
% node 57 (leaf): class nine (10)
leaf_class(14,57,10).
% node 58: f1 <= 2.5  (F1, bin <= 1)  left -> 59, right -> 80
node(14,58,1,1).
left_node(14,58,59).
right_node(14,58,80).
% node 59: f5 <= 2.5  (F5, bin <= 1)  left -> 60, right -> 71
node(14,59,5,1).
left_node(14,59,60).
right_node(14,59,71).
% node 60: f5 <= 1.5  (F5, bin <= 0)  left -> 61, right -> 66
node(14,60,5,0).
left_node(14,60,61).
right_node(14,60,66).
% node 61: f0 <= 2.5  (F0, bin <= 2)  left -> 62, right -> 63
node(14,61,0,2).
left_node(14,61,62).
right_node(14,61,63).
% node 62 (leaf): class nine (10)
leaf_class(14,62,10).
% node 63: f4 <= 3.0  (F4, bin <= 4)  left -> 64, right -> 65
node(14,63,4,4).
left_node(14,63,64).
right_node(14,63,65).
% node 64 (leaf): class four (5)
leaf_class(14,64,5).
% node 65 (leaf): class six (7)
leaf_class(14,65,7).
% node 66: f3 <= 3.5  (F3, bin <= 2)  left -> 67, right -> 68
node(14,66,3,2).
left_node(14,66,67).
right_node(14,66,68).
% node 67 (leaf): class draw (0)
leaf_class(14,67,0).
% node 68: f4 <= 2.0  (F4, bin <= 2)  left -> 69, right -> 70
node(14,68,4,2).
left_node(14,68,69).
right_node(14,68,70).
% node 69 (leaf): class five (6)
leaf_class(14,69,6).
% node 70 (leaf): class ten (11)
leaf_class(14,70,11).
% node 71: f0 <= 1.5  (F0, bin <= 1)  left -> 72, right -> 73
node(14,71,0,1).
left_node(14,71,72).
right_node(14,71,73).
% node 72 (leaf): class fourteen (15)
leaf_class(14,72,15).
% node 73: f2 <= 4.5  (F2, bin <= 4)  left -> 74, right -> 77
node(14,73,2,4).
left_node(14,73,74).
right_node(14,73,77).
% node 74: f5 <= 7.5  (F5, bin <= 5)  left -> 75, right -> 76
node(14,74,5,5).
left_node(14,74,75).
right_node(14,74,76).
% node 75 (leaf): class twelve (13)
leaf_class(14,75,13).
% node 76 (leaf): class eleven (12)
leaf_class(14,76,12).
% node 77: f3 <= 4.5  (F3, bin <= 3)  left -> 78, right -> 79
node(14,77,3,3).
left_node(14,77,78).
right_node(14,77,79).
% node 78 (leaf): class thirteen (14)
leaf_class(14,78,14).
% node 79 (leaf): class thirteen (14)
leaf_class(14,79,14).
% node 80: f0 <= 2.5  (F0, bin <= 2)  left -> 81, right -> 84
node(14,80,0,2).
left_node(14,80,81).
right_node(14,80,84).
% node 81: f4 <= 2.5  (F4, bin <= 3)  left -> 82, right -> 83
node(14,81,4,3).
left_node(14,81,82).
right_node(14,81,83).
% node 82 (leaf): class two (3)
leaf_class(14,82,3).
% node 83 (leaf): class eleven (12)
leaf_class(14,83,12).
% node 84: f5 <= 2.5  (F5, bin <= 1)  left -> 85, right -> 88
node(14,84,5,1).
left_node(14,84,85).
right_node(14,84,88).
% node 85: f3 <= 3.5  (F3, bin <= 2)  left -> 86, right -> 87
node(14,85,3,2).
left_node(14,85,86).
right_node(14,85,87).
% node 86 (leaf): class draw (0)
leaf_class(14,86,0).
% node 87 (leaf): class eight (9)
leaf_class(14,87,9).
% node 88: f2 <= 5.5  (F2, bin <= 5)  left -> 89, right -> 92
node(14,88,2,5).
left_node(14,88,89).
right_node(14,88,92).
% node 89: f1 <= 3.5  (F1, bin <= 2)  left -> 90, right -> 91
node(14,89,1,2).
left_node(14,89,90).
right_node(14,89,91).
% node 90 (leaf): class ten (11)
leaf_class(14,90,11).
% node 91 (leaf): class nine (10)
leaf_class(14,91,10).
% node 92 (leaf): class twelve (13)
leaf_class(14,92,13).

% Tree 15
tree(15).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 24
node(15,0,0,1).
left_node(15,0,1).
right_node(15,0,24).
% node 1: f1 <= 1.5  (F1, bin <= 0)  left -> 2, right -> 15
node(15,1,1,0).
left_node(15,1,2).
right_node(15,1,15).
% node 2: f5 <= 6.5  (F5, bin <= 4)  left -> 3, right -> 12
node(15,2,5,4).
left_node(15,2,3).
right_node(15,2,12).
% node 3: f5 <= 2.5  (F5, bin <= 1)  left -> 4, right -> 7
node(15,3,5,1).
left_node(15,3,4).
right_node(15,3,7).
% node 4: f3 <= 3.5  (F3, bin <= 2)  left -> 5, right -> 6
node(15,4,3,2).
left_node(15,4,5).
right_node(15,4,6).
% node 5 (leaf): class draw (0)
leaf_class(15,5,0).
% node 6 (leaf): class thirteen (14)
leaf_class(15,6,14).
% node 7: f0 <= 0.5  (F0, bin <= 0)  left -> 8, right -> 11
node(15,7,0,0).
left_node(15,7,8).
right_node(15,7,11).
% node 8: f4 <= 6.5  (F4, bin <= 8)  left -> 9, right -> 10
node(15,8,4,8).
left_node(15,8,9).
right_node(15,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(15,9,16).
% node 10 (leaf): class fourteen (15)
leaf_class(15,10,15).
% node 11 (leaf): class fifteen (16)
leaf_class(15,11,16).
% node 12: f4 <= 1.5  (F4, bin <= 1)  left -> 13, right -> 14
node(15,12,4,1).
left_node(15,12,13).
right_node(15,12,14).
% node 13 (leaf): class twelve (13)
leaf_class(15,13,13).
% node 14 (leaf): class fourteen (15)
leaf_class(15,14,15).
% node 15: f2 <= 4.5  (F2, bin <= 4)  left -> 16, right -> 23
node(15,15,2,4).
left_node(15,15,16).
right_node(15,15,23).
% node 16: f5 <= 2.5  (F5, bin <= 1)  left -> 17, right -> 18
node(15,16,5,1).
left_node(15,16,17).
right_node(15,16,18).
% node 17 (leaf): class ten (11)
leaf_class(15,17,11).
% node 18: f5 <= 6.5  (F5, bin <= 4)  left -> 19, right -> 22
node(15,18,5,4).
left_node(15,18,19).
right_node(15,18,22).
% node 19: f4 <= 6.5  (F4, bin <= 8)  left -> 20, right -> 21
node(15,19,4,8).
left_node(15,19,20).
right_node(15,19,21).
% node 20 (leaf): class fourteen (15)
leaf_class(15,20,15).
% node 21 (leaf): class thirteen (14)
leaf_class(15,21,14).
% node 22 (leaf): class thirteen (14)
leaf_class(15,22,14).
% node 23 (leaf): class fourteen (15)
leaf_class(15,23,15).
% node 24: f4 <= 6.5  (F4, bin <= 8)  left -> 25, right -> 78
node(15,24,4,8).
left_node(15,24,25).
right_node(15,24,78).
% node 25: f4 <= 1.5  (F4, bin <= 1)  left -> 26, right -> 49
node(15,25,4,1).
left_node(15,25,26).
right_node(15,25,49).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 36
node(15,26,5,1).
left_node(15,26,27).
right_node(15,26,36).
% node 27: f1 <= 3.5  (F1, bin <= 2)  left -> 28, right -> 35
node(15,27,1,2).
left_node(15,27,28).
right_node(15,27,35).
% node 28: f0 <= 2.5  (F0, bin <= 2)  left -> 29, right -> 32
node(15,28,0,2).
left_node(15,28,29).
right_node(15,28,32).
% node 29: f2 <= 1.5  (F2, bin <= 1)  left -> 30, right -> 31
node(15,29,2,1).
left_node(15,29,30).
right_node(15,29,31).
% node 30 (leaf): class zero (1)
leaf_class(15,30,1).
% node 31 (leaf): class two (3)
leaf_class(15,31,3).
% node 32: f5 <= 1.5  (F5, bin <= 0)  left -> 33, right -> 34
node(15,32,5,0).
left_node(15,32,33).
right_node(15,32,34).
% node 33 (leaf): class five (6)
leaf_class(15,33,6).
% node 34 (leaf): class six (7)
leaf_class(15,34,7).
% node 35 (leaf): class eight (9)
leaf_class(15,35,9).
% node 36: f1 <= 1.5  (F1, bin <= 0)  left -> 37, right -> 44
node(15,36,1,0).
left_node(15,36,37).
right_node(15,36,44).
% node 37: f2 <= 2.5  (F2, bin <= 2)  left -> 38, right -> 41
node(15,37,2,2).
left_node(15,37,38).
right_node(15,37,41).
% node 38: f2 <= 1.5  (F2, bin <= 1)  left -> 39, right -> 40
node(15,38,2,1).
left_node(15,38,39).
right_node(15,38,40).
% node 39 (leaf): class draw (0)
leaf_class(15,39,0).
% node 40 (leaf): class eleven (12)
leaf_class(15,40,12).
% node 41: f2 <= 3.5  (F2, bin <= 3)  left -> 42, right -> 43
node(15,41,2,3).
left_node(15,41,42).
right_node(15,41,43).
% node 42 (leaf): class twelve (13)
leaf_class(15,42,13).
% node 43 (leaf): class thirteen (14)
leaf_class(15,43,14).
% node 44: f1 <= 2.5  (F1, bin <= 1)  left -> 45, right -> 48
node(15,44,1,1).
left_node(15,44,45).
right_node(15,44,48).
% node 45: f4 <= 0.5  (F4, bin <= 0)  left -> 46, right -> 47
node(15,45,4,0).
left_node(15,45,46).
right_node(15,45,47).
% node 46 (leaf): class eleven (12)
leaf_class(15,46,12).
% node 47 (leaf): class twelve (13)
leaf_class(15,47,13).
% node 48 (leaf): class ten (11)
leaf_class(15,48,11).
% node 49: f1 <= 2.5  (F1, bin <= 1)  left -> 50, right -> 65
node(15,49,1,1).
left_node(15,49,50).
right_node(15,49,65).
% node 50: f1 <= 1.5  (F1, bin <= 0)  left -> 51, right -> 58
node(15,50,1,0).
left_node(15,50,51).
right_node(15,50,58).
% node 51: f3 <= 5.5  (F3, bin <= 4)  left -> 52, right -> 55
node(15,51,3,4).
left_node(15,51,52).
right_node(15,51,55).
% node 52: f4 <= 5.5  (F4, bin <= 7)  left -> 53, right -> 54
node(15,52,4,7).
left_node(15,52,53).
right_node(15,52,54).
% node 53 (leaf): class fourteen (15)
leaf_class(15,53,15).
% node 54 (leaf): class fourteen (15)
leaf_class(15,54,15).
% node 55: f2 <= 0.5  (F2, bin <= 0)  left -> 56, right -> 57
node(15,55,2,0).
left_node(15,55,56).
right_node(15,55,57).
% node 56 (leaf): class fourteen (15)
leaf_class(15,56,15).
% node 57 (leaf): class fifteen (16)
leaf_class(15,57,16).
% node 58: f2 <= 5.5  (F2, bin <= 5)  left -> 59, right -> 62
node(15,58,2,5).
left_node(15,58,59).
right_node(15,58,62).
% node 59: f3 <= 5.5  (F3, bin <= 4)  left -> 60, right -> 61
node(15,59,3,4).
left_node(15,59,60).
right_node(15,59,61).
% node 60 (leaf): class thirteen (14)
leaf_class(15,60,14).
% node 61 (leaf): class fourteen (15)
leaf_class(15,61,15).
% node 62: f5 <= 2.5  (F5, bin <= 1)  left -> 63, right -> 64
node(15,62,5,1).
left_node(15,62,63).
right_node(15,62,64).
% node 63 (leaf): class eleven (12)
leaf_class(15,63,12).
% node 64 (leaf): class thirteen (14)
leaf_class(15,64,14).
% node 65: f0 <= 2.5  (F0, bin <= 2)  left -> 66, right -> 71
node(15,65,0,2).
left_node(15,65,66).
right_node(15,65,71).
% node 66: f3 <= 3.5  (F3, bin <= 2)  left -> 67, right -> 68
node(15,66,3,2).
left_node(15,66,67).
right_node(15,66,68).
% node 67 (leaf): class twelve (13)
leaf_class(15,67,13).
% node 68: f4 <= 2.5  (F4, bin <= 3)  left -> 69, right -> 70
node(15,68,4,3).
left_node(15,68,69).
right_node(15,68,70).
% node 69 (leaf): class two (3)
leaf_class(15,69,3).
% node 70 (leaf): class ten (11)
leaf_class(15,70,11).
% node 71: f5 <= 2.5  (F5, bin <= 1)  left -> 72, right -> 75
node(15,71,5,1).
left_node(15,71,72).
right_node(15,71,75).
% node 72: f1 <= 3.5  (F1, bin <= 2)  left -> 73, right -> 74
node(15,72,1,2).
left_node(15,72,73).
right_node(15,72,74).
% node 73 (leaf): class eight (9)
leaf_class(15,73,9).
% node 74 (leaf): class eight (9)
leaf_class(15,74,9).
% node 75: f4 <= 4.5  (F4, bin <= 6)  left -> 76, right -> 77
node(15,75,4,6).
left_node(15,75,76).
right_node(15,75,77).
% node 76 (leaf): class twelve (13)
leaf_class(15,76,13).
% node 77 (leaf): class eleven (12)
leaf_class(15,77,12).
% node 78: f1 <= 3.5  (F1, bin <= 2)  left -> 79, right -> 84
node(15,78,1,2).
left_node(15,78,79).
right_node(15,78,84).
% node 79: f2 <= 5.5  (F2, bin <= 5)  left -> 80, right -> 83
node(15,79,2,5).
left_node(15,79,80).
right_node(15,79,83).
% node 80: f5 <= 2.5  (F5, bin <= 1)  left -> 81, right -> 82
node(15,80,5,1).
left_node(15,80,81).
right_node(15,80,82).
% node 81 (leaf): class eight (9)
leaf_class(15,81,9).
% node 82 (leaf): class eleven (12)
leaf_class(15,82,12).
% node 83 (leaf): class draw (0)
leaf_class(15,83,0).
% node 84: f5 <= 2.5  (F5, bin <= 1)  left -> 85, right -> 86
node(15,84,5,1).
left_node(15,84,85).
right_node(15,84,86).
% node 85 (leaf): class seven (8)
leaf_class(15,85,8).
% node 86 (leaf): class nine (10)
leaf_class(15,86,10).

% Tree 16
tree(16).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 28
node(16,0,5,1).
left_node(16,0,1).
right_node(16,0,28).
% node 1: f3 <= 3.5  (F3, bin <= 2)  left -> 2, right -> 7
node(16,1,3,2).
left_node(16,1,2).
right_node(16,1,7).
% node 2: f4 <= 1.5  (F4, bin <= 1)  left -> 3, right -> 6
node(16,2,4,1).
left_node(16,2,3).
right_node(16,2,6).
% node 3: f0 <= 2.5  (F0, bin <= 2)  left -> 4, right -> 5
node(16,3,0,2).
left_node(16,3,4).
right_node(16,3,5).
% node 4 (leaf): class two (3)
leaf_class(16,4,3).
% node 5 (leaf): class four (5)
leaf_class(16,5,5).
% node 6 (leaf): class draw (0)
leaf_class(16,6,0).
% node 7: f0 <= 1.5  (F0, bin <= 1)  left -> 8, right -> 17
node(16,7,0,1).
left_node(16,7,8).
right_node(16,7,17).
% node 8: f5 <= 1.5  (F5, bin <= 0)  left -> 9, right -> 14
node(16,8,5,0).
left_node(16,8,9).
right_node(16,8,14).
% node 9: f4 <= 5.5  (F4, bin <= 7)  left -> 10, right -> 11
node(16,9,4,7).
left_node(16,9,10).
right_node(16,9,11).
% node 10 (leaf): class ten (11)
leaf_class(16,10,11).
% node 11: f2 <= 3.5  (F2, bin <= 3)  left -> 12, right -> 13
node(16,11,2,3).
left_node(16,11,12).
right_node(16,11,13).
% node 12 (leaf): class nine (10)
leaf_class(16,12,10).
% node 13 (leaf): class twelve (13)
leaf_class(16,13,13).
% node 14: f4 <= 5.5  (F4, bin <= 7)  left -> 15, right -> 16
node(16,14,4,7).
left_node(16,14,15).
right_node(16,14,16).
% node 15 (leaf): class fourteen (15)
leaf_class(16,15,15).
% node 16 (leaf): class eleven (12)
leaf_class(16,16,12).
% node 17: f0 <= 2.5  (F0, bin <= 2)  left -> 18, right -> 19
node(16,17,0,2).
left_node(16,17,18).
right_node(16,17,19).
% node 18 (leaf): class nine (10)
leaf_class(16,18,10).
% node 19: f4 <= 1.5  (F4, bin <= 1)  left -> 20, right -> 23
node(16,19,4,1).
left_node(16,19,20).
right_node(16,19,23).
% node 20: f1 <= 3.5  (F1, bin <= 2)  left -> 21, right -> 22
node(16,20,1,2).
left_node(16,20,21).
right_node(16,20,22).
% node 21 (leaf): class five (6)
leaf_class(16,21,6).
% node 22 (leaf): class eight (9)
leaf_class(16,22,9).
% node 23: f5 <= 1.5  (F5, bin <= 0)  left -> 24, right -> 27
node(16,23,5,0).
left_node(16,23,24).
right_node(16,23,27).
% node 24: f4 <= 6.5  (F4, bin <= 8)  left -> 25, right -> 26
node(16,24,4,8).
left_node(16,24,25).
right_node(16,24,26).
% node 25 (leaf): class eight (9)
leaf_class(16,25,9).
% node 26 (leaf): class six (7)
leaf_class(16,26,7).
% node 27 (leaf): class eight (9)
leaf_class(16,27,9).
% node 28: f1 <= 1.5  (F1, bin <= 0)  left -> 29, right -> 48
node(16,28,1,0).
left_node(16,28,29).
right_node(16,28,48).
% node 29: f4 <= 0.5  (F4, bin <= 0)  left -> 30, right -> 35
node(16,29,4,0).
left_node(16,29,30).
right_node(16,29,35).
% node 30: f3 <= 4.5  (F3, bin <= 3)  left -> 31, right -> 32
node(16,30,3,3).
left_node(16,30,31).
right_node(16,30,32).
% node 31 (leaf): class eleven (12)
leaf_class(16,31,12).
% node 32: f2 <= 2.5  (F2, bin <= 2)  left -> 33, right -> 34
node(16,32,2,2).
left_node(16,32,33).
right_node(16,32,34).
% node 33 (leaf): class draw (0)
leaf_class(16,33,0).
% node 34 (leaf): class twelve (13)
leaf_class(16,34,13).
% node 35: f5 <= 6.5  (F5, bin <= 4)  left -> 36, right -> 47
node(16,35,5,4).
left_node(16,35,36).
right_node(16,35,47).
% node 36: f3 <= 5.5  (F3, bin <= 4)  left -> 37, right -> 42
node(16,36,3,4).
left_node(16,36,37).
right_node(16,36,42).
% node 37: f3 <= 3.5  (F3, bin <= 2)  left -> 38, right -> 41
node(16,37,3,2).
left_node(16,37,38).
right_node(16,37,41).
% node 38: f2 <= 0.5  (F2, bin <= 0)  left -> 39, right -> 40
node(16,38,2,0).
left_node(16,38,39).
right_node(16,38,40).
% node 39 (leaf): class fourteen (15)
leaf_class(16,39,15).
% node 40 (leaf): class fifteen (16)
leaf_class(16,40,16).
% node 41 (leaf): class fourteen (15)
leaf_class(16,41,15).
% node 42: f2 <= 0.5  (F2, bin <= 0)  left -> 43, right -> 44
node(16,42,2,0).
left_node(16,42,43).
right_node(16,42,44).
% node 43 (leaf): class fourteen (15)
leaf_class(16,43,15).
% node 44: f3 <= 7.5  (F3, bin <= 6)  left -> 45, right -> 46
node(16,44,3,6).
left_node(16,44,45).
right_node(16,44,46).
% node 45 (leaf): class fifteen (16)
leaf_class(16,45,16).
% node 46 (leaf): class fourteen (15)
leaf_class(16,46,15).
% node 47 (leaf): class fourteen (15)
leaf_class(16,47,15).
% node 48: f4 <= 0.5  (F4, bin <= 0)  left -> 49, right -> 52
node(16,48,4,0).
left_node(16,48,49).
right_node(16,48,52).
% node 49: f2 <= 1.5  (F2, bin <= 1)  left -> 50, right -> 51
node(16,49,2,1).
left_node(16,49,50).
right_node(16,49,51).
% node 50 (leaf): class draw (0)
leaf_class(16,50,0).
% node 51 (leaf): class ten (11)
leaf_class(16,51,11).
% node 52: f0 <= 1.5  (F0, bin <= 1)  left -> 53, right -> 60
node(16,52,0,1).
left_node(16,52,53).
right_node(16,52,60).
% node 53: f2 <= 4.5  (F2, bin <= 4)  left -> 54, right -> 59
node(16,53,2,4).
left_node(16,53,54).
right_node(16,53,59).
% node 54: f4 <= 6.5  (F4, bin <= 8)  left -> 55, right -> 56
node(16,54,4,8).
left_node(16,54,55).
right_node(16,54,56).
% node 55 (leaf): class fourteen (15)
leaf_class(16,55,15).
% node 56: f3 <= 1.5  (F3, bin <= 0)  left -> 57, right -> 58
node(16,56,3,0).
left_node(16,56,57).
right_node(16,56,58).
% node 57 (leaf): class twelve (13)
leaf_class(16,57,13).
% node 58 (leaf): class thirteen (14)
leaf_class(16,58,14).
% node 59 (leaf): class fourteen (15)
leaf_class(16,59,15).
% node 60: f4 <= 6.5  (F4, bin <= 8)  left -> 61, right -> 66
node(16,60,4,8).
left_node(16,60,61).
right_node(16,60,66).
% node 61: f3 <= 3.5  (F3, bin <= 2)  left -> 62, right -> 63
node(16,61,3,2).
left_node(16,61,62).
right_node(16,61,63).
% node 62 (leaf): class thirteen (14)
leaf_class(16,62,14).
% node 63: f0 <= 2.5  (F0, bin <= 2)  left -> 64, right -> 65
node(16,63,0,2).
left_node(16,63,64).
right_node(16,63,65).
% node 64 (leaf): class thirteen (14)
leaf_class(16,64,14).
% node 65 (leaf): class twelve (13)
leaf_class(16,65,13).
% node 66: f3 <= 1.5  (F3, bin <= 0)  left -> 67, right -> 68
node(16,66,3,0).
left_node(16,66,67).
right_node(16,66,68).
% node 67 (leaf): class eleven (12)
leaf_class(16,67,12).
% node 68: f1 <= 3.5  (F1, bin <= 2)  left -> 69, right -> 70
node(16,68,1,2).
left_node(16,68,69).
right_node(16,68,70).
% node 69 (leaf): class eleven (12)
leaf_class(16,69,12).
% node 70 (leaf): class nine (10)
leaf_class(16,70,10).

% Tree 17
tree(17).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 32
node(17,0,0,1).
left_node(17,0,1).
right_node(17,0,32).
% node 1: f4 <= 6.5  (F4, bin <= 8)  left -> 2, right -> 25
node(17,1,4,8).
left_node(17,1,2).
right_node(17,1,25).
% node 2: f0 <= 0.5  (F0, bin <= 0)  left -> 3, right -> 12
node(17,2,0,0).
left_node(17,2,3).
right_node(17,2,12).
% node 3: f5 <= 2.5  (F5, bin <= 1)  left -> 4, right -> 7
node(17,3,5,1).
left_node(17,3,4).
right_node(17,3,7).
% node 4: f3 <= 3.5  (F3, bin <= 2)  left -> 5, right -> 6
node(17,4,3,2).
left_node(17,4,5).
right_node(17,4,6).
% node 5 (leaf): class draw (0)
leaf_class(17,5,0).
% node 6 (leaf): class fourteen (15)
leaf_class(17,6,15).
% node 7: f4 <= 5.5  (F4, bin <= 7)  left -> 8, right -> 11
node(17,7,4,7).
left_node(17,7,8).
right_node(17,7,11).
% node 8: f3 <= 1.5  (F3, bin <= 0)  left -> 9, right -> 10
node(17,8,3,0).
left_node(17,8,9).
right_node(17,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(17,9,16).
% node 10 (leaf): class sixteen (17)
leaf_class(17,10,17).
% node 11 (leaf): class fifteen (16)
leaf_class(17,11,16).
% node 12: f2 <= 0.5  (F2, bin <= 0)  left -> 13, right -> 16
node(17,12,2,0).
left_node(17,12,13).
right_node(17,12,16).
% node 13: f5 <= 1.5  (F5, bin <= 0)  left -> 14, right -> 15
node(17,13,5,0).
left_node(17,13,14).
right_node(17,13,15).
% node 14 (leaf): class ten (11)
leaf_class(17,14,11).
% node 15 (leaf): class fourteen (15)
leaf_class(17,15,15).
% node 16: f5 <= 1.5  (F5, bin <= 0)  left -> 17, right -> 18
node(17,16,5,0).
left_node(17,16,17).
right_node(17,16,18).
% node 17 (leaf): class ten (11)
leaf_class(17,17,11).
% node 18: f5 <= 6.5  (F5, bin <= 4)  left -> 19, right -> 22
node(17,18,5,4).
left_node(17,18,19).
right_node(17,18,22).
% node 19: f4 <= 1.5  (F4, bin <= 1)  left -> 20, right -> 21
node(17,19,4,1).
left_node(17,19,20).
right_node(17,19,21).
% node 20 (leaf): class twelve (13)
leaf_class(17,20,13).
% node 21 (leaf): class fifteen (16)
leaf_class(17,21,16).
% node 22: f4 <= 1.5  (F4, bin <= 1)  left -> 23, right -> 24
node(17,22,4,1).
left_node(17,22,23).
right_node(17,22,24).
% node 23 (leaf): class thirteen (14)
leaf_class(17,23,14).
% node 24 (leaf): class fourteen (15)
leaf_class(17,24,15).
% node 25: f1 <= 1.5  (F1, bin <= 0)  left -> 26, right -> 31
node(17,25,1,0).
left_node(17,25,26).
right_node(17,25,31).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 28
node(17,26,5,1).
left_node(17,26,27).
right_node(17,26,28).
% node 27 (leaf): class twelve (13)
leaf_class(17,27,13).
% node 28: f2 <= 5.5  (F2, bin <= 5)  left -> 29, right -> 30
node(17,28,2,5).
left_node(17,28,29).
right_node(17,28,30).
% node 29 (leaf): class fourteen (15)
leaf_class(17,29,15).
% node 30 (leaf): class draw (0)
leaf_class(17,30,0).
% node 31 (leaf): class thirteen (14)
leaf_class(17,31,14).
% node 32: f5 <= 2.5  (F5, bin <= 1)  left -> 33, right -> 48
node(17,32,5,1).
left_node(17,32,33).
right_node(17,32,48).
% node 33: f3 <= 3.5  (F3, bin <= 2)  left -> 34, right -> 35
node(17,33,3,2).
left_node(17,33,34).
right_node(17,33,35).
% node 34 (leaf): class draw (0)
leaf_class(17,34,0).
% node 35: f4 <= 2.5  (F4, bin <= 3)  left -> 36, right -> 43
node(17,35,4,3).
left_node(17,35,36).
right_node(17,35,43).
% node 36: f1 <= 3.5  (F1, bin <= 2)  left -> 37, right -> 42
node(17,36,1,2).
left_node(17,36,37).
right_node(17,36,42).
% node 37: f1 <= 2.5  (F1, bin <= 1)  left -> 38, right -> 39
node(17,37,1,1).
left_node(17,37,38).
right_node(17,37,39).
% node 38 (leaf): class five (6)
leaf_class(17,38,6).
% node 39: f0 <= 2.5  (F0, bin <= 2)  left -> 40, right -> 41
node(17,39,0,2).
left_node(17,39,40).
right_node(17,39,41).
% node 40 (leaf): class two (3)
leaf_class(17,40,3).
% node 41 (leaf): class five (6)
leaf_class(17,41,6).
% node 42 (leaf): class eight (9)
leaf_class(17,42,9).
% node 43: f0 <= 2.5  (F0, bin <= 2)  left -> 44, right -> 45
node(17,43,0,2).
left_node(17,43,44).
right_node(17,43,45).
% node 44 (leaf): class nine (10)
leaf_class(17,44,10).
% node 45: f1 <= 3.5  (F1, bin <= 2)  left -> 46, right -> 47
node(17,45,1,2).
left_node(17,45,46).
right_node(17,45,47).
% node 46 (leaf): class eight (9)
leaf_class(17,46,9).
% node 47 (leaf): class eight (9)
leaf_class(17,47,9).
% node 48: f1 <= 1.5  (F1, bin <= 0)  left -> 49, right -> 64
node(17,48,1,0).
left_node(17,48,49).
right_node(17,48,64).
% node 49: f5 <= 6.5  (F5, bin <= 4)  left -> 50, right -> 59
node(17,49,5,4).
left_node(17,49,50).
right_node(17,49,59).
% node 50: f4 <= 0.5  (F4, bin <= 0)  left -> 51, right -> 52
node(17,50,4,0).
left_node(17,50,51).
right_node(17,50,52).
% node 51 (leaf): class twelve (13)
leaf_class(17,51,13).
% node 52: f3 <= 5.5  (F3, bin <= 4)  left -> 53, right -> 56
node(17,52,3,4).
left_node(17,52,53).
right_node(17,52,56).
% node 53: f4 <= 6.5  (F4, bin <= 8)  left -> 54, right -> 55
node(17,53,4,8).
left_node(17,53,54).
right_node(17,53,55).
% node 54 (leaf): class fourteen (15)
leaf_class(17,54,15).
% node 55 (leaf): class twelve (13)
leaf_class(17,55,13).
% node 56: f4 <= 6.5  (F4, bin <= 8)  left -> 57, right -> 58
node(17,56,4,8).
left_node(17,56,57).
right_node(17,56,58).
% node 57 (leaf): class fourteen (15)
leaf_class(17,57,15).
% node 58 (leaf): class twelve (13)
leaf_class(17,58,13).
% node 59: f4 <= 1.5  (F4, bin <= 1)  left -> 60, right -> 61
node(17,59,4,1).
left_node(17,59,60).
right_node(17,59,61).
% node 60 (leaf): class twelve (13)
leaf_class(17,60,13).
% node 61: f4 <= 5.5  (F4, bin <= 7)  left -> 62, right -> 63
node(17,61,4,7).
left_node(17,61,62).
right_node(17,61,63).
% node 62 (leaf): class fourteen (15)
leaf_class(17,62,15).
% node 63 (leaf): class twelve (13)
leaf_class(17,63,13).
% node 64: f4 <= 6.5  (F4, bin <= 8)  left -> 65, right -> 76
node(17,64,4,8).
left_node(17,64,65).
right_node(17,64,76).
% node 65: f4 <= 1.5  (F4, bin <= 1)  left -> 66, right -> 69
node(17,65,4,1).
left_node(17,65,66).
right_node(17,65,69).
% node 66: f4 <= 0.5  (F4, bin <= 0)  left -> 67, right -> 68
node(17,66,4,0).
left_node(17,66,67).
right_node(17,66,68).
% node 67 (leaf): class ten (11)
leaf_class(17,67,11).
% node 68 (leaf): class twelve (13)
leaf_class(17,68,13).
% node 69: f4 <= 5.5  (F4, bin <= 7)  left -> 70, right -> 73
node(17,69,4,7).
left_node(17,69,70).
right_node(17,69,73).
% node 70: f5 <= 5.5  (F5, bin <= 3)  left -> 71, right -> 72
node(17,70,5,3).
left_node(17,70,71).
right_node(17,70,72).
% node 71 (leaf): class thirteen (14)
leaf_class(17,71,14).
% node 72 (leaf): class thirteen (14)
leaf_class(17,72,14).
% node 73: f1 <= 2.5  (F1, bin <= 1)  left -> 74, right -> 75
node(17,73,1,1).
left_node(17,73,74).
right_node(17,73,75).
% node 74 (leaf): class thirteen (14)
leaf_class(17,74,14).
% node 75 (leaf): class twelve (13)
leaf_class(17,75,13).
% node 76: f5 <= 3.5  (F5, bin <= 2)  left -> 77, right -> 80
node(17,76,5,2).
left_node(17,76,77).
right_node(17,76,80).
% node 77: f0 <= 2.5  (F0, bin <= 2)  left -> 78, right -> 79
node(17,77,0,2).
left_node(17,77,78).
right_node(17,77,79).
% node 78 (leaf): class eleven (12)
leaf_class(17,78,12).
% node 79 (leaf): class nine (10)
leaf_class(17,79,10).
% node 80: f1 <= 3.5  (F1, bin <= 2)  left -> 81, right -> 84
node(17,80,1,2).
left_node(17,80,81).
right_node(17,80,84).
% node 81: f0 <= 2.5  (F0, bin <= 2)  left -> 82, right -> 83
node(17,81,0,2).
left_node(17,81,82).
right_node(17,81,83).
% node 82 (leaf): class twelve (13)
leaf_class(17,82,13).
% node 83 (leaf): class eleven (12)
leaf_class(17,83,12).
% node 84: f2 <= 5.5  (F2, bin <= 5)  left -> 85, right -> 86
node(17,84,2,5).
left_node(17,84,85).
right_node(17,84,86).
% node 85 (leaf): class nine (10)
leaf_class(17,85,10).
% node 86 (leaf): class draw (0)
leaf_class(17,86,0).

% Tree 18
tree(18).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 54
node(18,0,4,8).
left_node(18,0,1).
right_node(18,0,54).
% node 1: f4 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 19
node(18,1,4,0).
left_node(18,1,2).
right_node(18,1,19).
% node 2: f1 <= 1.5  (F1, bin <= 0)  left -> 3, right -> 10
node(18,2,1,0).
left_node(18,2,3).
right_node(18,2,10).
% node 3: f2 <= 2.5  (F2, bin <= 2)  left -> 4, right -> 7
node(18,3,2,2).
left_node(18,3,4).
right_node(18,3,7).
% node 4: f2 <= 1.5  (F2, bin <= 1)  left -> 5, right -> 6
node(18,4,2,1).
left_node(18,4,5).
right_node(18,4,6).
% node 5 (leaf): class draw (0)
leaf_class(18,5,0).
% node 6 (leaf): class eleven (12)
leaf_class(18,6,12).
% node 7: f5 <= 1.5  (F5, bin <= 0)  left -> 8, right -> 9
node(18,7,5,0).
left_node(18,7,8).
right_node(18,7,9).
% node 8 (leaf): class two (3)
leaf_class(18,8,3).
% node 9 (leaf): class twelve (13)
leaf_class(18,9,13).
% node 10: f5 <= 2.5  (F5, bin <= 1)  left -> 11, right -> 14
node(18,10,5,1).
left_node(18,10,11).
right_node(18,10,14).
% node 11: f0 <= 2.5  (F0, bin <= 2)  left -> 12, right -> 13
node(18,11,0,2).
left_node(18,11,12).
right_node(18,11,13).
% node 12 (leaf): class two (3)
leaf_class(18,12,3).
% node 13 (leaf): class five (6)
leaf_class(18,13,6).
% node 14: f5 <= 6.5  (F5, bin <= 4)  left -> 15, right -> 18
node(18,14,5,4).
left_node(18,14,15).
right_node(18,14,18).
% node 15: f2 <= 1.5  (F2, bin <= 1)  left -> 16, right -> 17
node(18,15,2,1).
left_node(18,15,16).
right_node(18,15,17).
% node 16 (leaf): class draw (0)
leaf_class(18,16,0).
% node 17 (leaf): class ten (11)
leaf_class(18,17,11).
% node 18 (leaf): class nine (10)
leaf_class(18,18,10).
% node 19: f2 <= 0.5  (F2, bin <= 0)  left -> 20, right -> 31
node(18,19,2,0).
left_node(18,19,20).
right_node(18,19,31).
% node 20: f4 <= 1.5  (F4, bin <= 1)  left -> 21, right -> 22
node(18,20,4,1).
left_node(18,20,21).
right_node(18,20,22).
% node 21 (leaf): class draw (0)
leaf_class(18,21,0).
% node 22: f1 <= 1.5  (F1, bin <= 0)  left -> 23, right -> 26
node(18,22,1,0).
left_node(18,22,23).
right_node(18,22,26).
% node 23: f5 <= 2.5  (F5, bin <= 1)  left -> 24, right -> 25
node(18,23,5,1).
left_node(18,23,24).
right_node(18,23,25).
% node 24 (leaf): class eleven (12)
leaf_class(18,24,12).
% node 25 (leaf): class fourteen (15)
leaf_class(18,25,15).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 28
node(18,26,5,1).
left_node(18,26,27).
right_node(18,26,28).
% node 27 (leaf): class ten (11)
leaf_class(18,27,11).
% node 28: f0 <= 1.5  (F0, bin <= 1)  left -> 29, right -> 30
node(18,28,0,1).
left_node(18,28,29).
right_node(18,28,30).
% node 29 (leaf): class fourteen (15)
leaf_class(18,29,15).
% node 30 (leaf): class twelve (13)
leaf_class(18,30,13).
% node 31: f3 <= 5.5  (F3, bin <= 4)  left -> 32, right -> 43
node(18,31,3,4).
left_node(18,31,32).
right_node(18,31,43).
% node 32: f5 <= 2.5  (F5, bin <= 1)  left -> 33, right -> 38
node(18,32,5,1).
left_node(18,32,33).
right_node(18,32,38).
% node 33: f3 <= 2.5  (F3, bin <= 1)  left -> 34, right -> 35
node(18,33,3,1).
left_node(18,33,34).
right_node(18,33,35).
% node 34 (leaf): class draw (0)
leaf_class(18,34,0).
% node 35: f4 <= 2.5  (F4, bin <= 3)  left -> 36, right -> 37
node(18,35,4,3).
left_node(18,35,36).
right_node(18,35,37).
% node 36 (leaf): class five (6)
leaf_class(18,36,6).
% node 37 (leaf): class eight (9)
leaf_class(18,37,9).
% node 38: f3 <= 3.5  (F3, bin <= 2)  left -> 39, right -> 42
node(18,38,3,2).
left_node(18,38,39).
right_node(18,38,42).
% node 39: f5 <= 5.5  (F5, bin <= 3)  left -> 40, right -> 41
node(18,39,5,3).
left_node(18,39,40).
right_node(18,39,41).
% node 40 (leaf): class fourteen (15)
leaf_class(18,40,15).
% node 41 (leaf): class thirteen (14)
leaf_class(18,41,14).
% node 42 (leaf): class fourteen (15)
leaf_class(18,42,15).
% node 43: f1 <= 2.5  (F1, bin <= 1)  left -> 44, right -> 51
node(18,43,1,1).
left_node(18,43,44).
right_node(18,43,51).
% node 44: f1 <= 1.5  (F1, bin <= 0)  left -> 45, right -> 48
node(18,44,1,0).
left_node(18,44,45).
right_node(18,44,48).
% node 45: f5 <= 6.5  (F5, bin <= 4)  left -> 46, right -> 47
node(18,45,5,4).
left_node(18,45,46).
right_node(18,45,47).
% node 46 (leaf): class fifteen (16)
leaf_class(18,46,16).
% node 47 (leaf): class draw (0)
leaf_class(18,47,0).
% node 48: f5 <= 6.5  (F5, bin <= 4)  left -> 49, right -> 50
node(18,48,5,4).
left_node(18,48,49).
right_node(18,48,50).
% node 49 (leaf): class fourteen (15)
leaf_class(18,49,15).
% node 50 (leaf): class draw (0)
leaf_class(18,50,0).
% node 51: f1 <= 3.5  (F1, bin <= 2)  left -> 52, right -> 53
node(18,51,1,2).
left_node(18,51,52).
right_node(18,51,53).
% node 52 (leaf): class twelve (13)
leaf_class(18,52,13).
% node 53 (leaf): class eight (9)
leaf_class(18,53,9).
% node 54: f2 <= 5.5  (F2, bin <= 5)  left -> 55, right -> 68
node(18,54,2,5).
left_node(18,54,55).
right_node(18,54,68).
% node 55: f2 <= 3.5  (F2, bin <= 3)  left -> 56, right -> 65
node(18,55,2,3).
left_node(18,55,56).
right_node(18,55,65).
% node 56: f2 <= 1.5  (F2, bin <= 1)  left -> 57, right -> 64
node(18,56,2,1).
left_node(18,56,57).
right_node(18,56,64).
% node 57: f1 <= 3.5  (F1, bin <= 2)  left -> 58, right -> 63
node(18,57,1,2).
left_node(18,57,58).
right_node(18,57,63).
% node 58: f1 <= 1.5  (F1, bin <= 0)  left -> 59, right -> 60
node(18,58,1,0).
left_node(18,58,59).
right_node(18,58,60).
% node 59 (leaf): class fourteen (15)
leaf_class(18,59,15).
% node 60: f5 <= 2.5  (F5, bin <= 1)  left -> 61, right -> 62
node(18,60,5,1).
left_node(18,60,61).
right_node(18,60,62).
% node 61 (leaf): class nine (10)
leaf_class(18,61,10).
% node 62 (leaf): class eleven (12)
leaf_class(18,62,12).
% node 63 (leaf): class nine (10)
leaf_class(18,63,10).
% node 64 (leaf): class thirteen (14)
leaf_class(18,64,14).
% node 65: f0 <= 1.5  (F0, bin <= 1)  left -> 66, right -> 67
node(18,65,0,1).
left_node(18,65,66).
right_node(18,65,67).
% node 66 (leaf): class thirteen (14)
leaf_class(18,66,14).
% node 67 (leaf): class eleven (12)
leaf_class(18,67,12).
% node 68 (leaf): class draw (0)
leaf_class(18,68,0).

% Tree 19
tree(19).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 20
node(19,0,0,1).
left_node(19,0,1).
right_node(19,0,20).
% node 1: f0 <= 0.5  (F0, bin <= 0)  left -> 2, right -> 7
node(19,1,0,0).
left_node(19,1,2).
right_node(19,1,7).
% node 2: f4 <= 6.5  (F4, bin <= 8)  left -> 3, right -> 6
node(19,2,4,8).
left_node(19,2,3).
right_node(19,2,6).
% node 3: f5 <= 2.5  (F5, bin <= 1)  left -> 4, right -> 5
node(19,3,5,1).
left_node(19,3,4).
right_node(19,3,5).
% node 4 (leaf): class fourteen (15)
leaf_class(19,4,15).
% node 5 (leaf): class fifteen (16)
leaf_class(19,5,16).
% node 6 (leaf): class fourteen (15)
leaf_class(19,6,15).
% node 7: f2 <= 0.5  (F2, bin <= 0)  left -> 8, right -> 11
node(19,7,2,0).
left_node(19,7,8).
right_node(19,7,11).
% node 8: f5 <= 2.5  (F5, bin <= 1)  left -> 9, right -> 10
node(19,8,5,1).
left_node(19,8,9).
right_node(19,8,10).
% node 9 (leaf): class nine (10)
leaf_class(19,9,10).
% node 10 (leaf): class fourteen (15)
leaf_class(19,10,15).
% node 11: f1 <= 1.5  (F1, bin <= 0)  left -> 12, right -> 17
node(19,11,1,0).
left_node(19,11,12).
right_node(19,11,17).
% node 12: f3 <= 6.5  (F3, bin <= 5)  left -> 13, right -> 16
node(19,12,3,5).
left_node(19,12,13).
right_node(19,12,16).
% node 13: f5 <= 6.5  (F5, bin <= 4)  left -> 14, right -> 15
node(19,13,5,4).
left_node(19,13,14).
right_node(19,13,15).
% node 14 (leaf): class fifteen (16)
leaf_class(19,14,16).
% node 15 (leaf): class fourteen (15)
leaf_class(19,15,15).
% node 16 (leaf): class fifteen (16)
leaf_class(19,16,16).
% node 17: f4 <= 6.5  (F4, bin <= 8)  left -> 18, right -> 19
node(19,17,4,8).
left_node(19,17,18).
right_node(19,17,19).
% node 18 (leaf): class fourteen (15)
leaf_class(19,18,15).
% node 19 (leaf): class thirteen (14)
leaf_class(19,19,14).
% node 20: f4 <= 6.5  (F4, bin <= 8)  left -> 21, right -> 62
node(19,20,4,8).
left_node(19,20,21).
right_node(19,20,62).
% node 21: f0 <= 2.5  (F0, bin <= 2)  left -> 22, right -> 43
node(19,21,0,2).
left_node(19,21,22).
right_node(19,21,43).
% node 22: f5 <= 2.5  (F5, bin <= 1)  left -> 23, right -> 28
node(19,22,5,1).
left_node(19,22,23).
right_node(19,22,28).
% node 23: f4 <= 2.5  (F4, bin <= 3)  left -> 24, right -> 25
node(19,23,4,3).
left_node(19,23,24).
right_node(19,23,25).
% node 24 (leaf): class two (3)
leaf_class(19,24,3).
% node 25: f2 <= 2.5  (F2, bin <= 2)  left -> 26, right -> 27
node(19,25,2,2).
left_node(19,25,26).
right_node(19,25,27).
% node 26 (leaf): class ten (11)
leaf_class(19,26,11).
% node 27 (leaf): class nine (10)
leaf_class(19,27,10).
% node 28: f1 <= 1.5  (F1, bin <= 0)  left -> 29, right -> 36
node(19,28,1,0).
left_node(19,28,29).
right_node(19,28,36).
% node 29: f4 <= 1.5  (F4, bin <= 1)  left -> 30, right -> 33
node(19,29,4,1).
left_node(19,29,30).
right_node(19,29,33).
% node 30: f2 <= 2.5  (F2, bin <= 2)  left -> 31, right -> 32
node(19,30,2,2).
left_node(19,30,31).
right_node(19,30,32).
% node 31 (leaf): class draw (0)
leaf_class(19,31,0).
% node 32 (leaf): class thirteen (14)
leaf_class(19,32,14).
% node 33: f2 <= 0.5  (F2, bin <= 0)  left -> 34, right -> 35
node(19,33,2,0).
left_node(19,33,34).
right_node(19,33,35).
% node 34 (leaf): class fourteen (15)
leaf_class(19,34,15).
% node 35 (leaf): class fourteen (15)
leaf_class(19,35,15).
% node 36: f1 <= 2.5  (F1, bin <= 1)  left -> 37, right -> 40
node(19,36,1,1).
left_node(19,36,37).
right_node(19,36,40).
% node 37: f5 <= 5.5  (F5, bin <= 3)  left -> 38, right -> 39
node(19,37,5,3).
left_node(19,37,38).
right_node(19,37,39).
% node 38 (leaf): class fourteen (15)
leaf_class(19,38,15).
% node 39 (leaf): class thirteen (14)
leaf_class(19,39,14).
% node 40: f4 <= 5.5  (F4, bin <= 7)  left -> 41, right -> 42
node(19,40,4,7).
left_node(19,40,41).
right_node(19,40,42).
% node 41 (leaf): class thirteen (14)
leaf_class(19,41,14).
% node 42 (leaf): class twelve (13)
leaf_class(19,42,13).
% node 43: f4 <= 1.5  (F4, bin <= 1)  left -> 44, right -> 53
node(19,43,4,1).
left_node(19,43,44).
right_node(19,43,53).
% node 44: f5 <= 2.5  (F5, bin <= 1)  left -> 45, right -> 48
node(19,44,5,1).
left_node(19,44,45).
right_node(19,44,48).
% node 45: f1 <= 3.5  (F1, bin <= 2)  left -> 46, right -> 47
node(19,45,1,2).
left_node(19,45,46).
right_node(19,45,47).
% node 46 (leaf): class five (6)
leaf_class(19,46,6).
% node 47 (leaf): class eight (9)
leaf_class(19,47,9).
% node 48: f2 <= 2.5  (F2, bin <= 2)  left -> 49, right -> 50
node(19,48,2,2).
left_node(19,48,49).
right_node(19,48,50).
% node 49 (leaf): class draw (0)
leaf_class(19,49,0).
% node 50: f1 <= 1.5  (F1, bin <= 0)  left -> 51, right -> 52
node(19,50,1,0).
left_node(19,50,51).
right_node(19,50,52).
% node 51 (leaf): class twelve (13)
leaf_class(19,51,13).
% node 52 (leaf): class ten (11)
leaf_class(19,52,11).
% node 53: f5 <= 2.5  (F5, bin <= 1)  left -> 54, right -> 55
node(19,53,5,1).
left_node(19,53,54).
right_node(19,53,55).
% node 54 (leaf): class eight (9)
leaf_class(19,54,9).
% node 55: f1 <= 2.5  (F1, bin <= 1)  left -> 56, right -> 59
node(19,55,1,1).
left_node(19,55,56).
right_node(19,55,59).
% node 56: f5 <= 6.5  (F5, bin <= 4)  left -> 57, right -> 58
node(19,56,5,4).
left_node(19,56,57).
right_node(19,56,58).
% node 57 (leaf): class fourteen (15)
leaf_class(19,57,15).
% node 58 (leaf): class thirteen (14)
leaf_class(19,58,14).
% node 59: f4 <= 4.5  (F4, bin <= 6)  left -> 60, right -> 61
node(19,59,4,6).
left_node(19,59,60).
right_node(19,59,61).
% node 60 (leaf): class twelve (13)
leaf_class(19,60,13).
% node 61 (leaf): class eleven (12)
leaf_class(19,61,12).
% node 62: f1 <= 3.5  (F1, bin <= 2)  left -> 63, right -> 74
node(19,62,1,2).
left_node(19,62,63).
right_node(19,62,74).
% node 63: f0 <= 2.5  (F0, bin <= 2)  left -> 64, right -> 67
node(19,63,0,2).
left_node(19,63,64).
right_node(19,63,67).
% node 64: f5 <= 2.5  (F5, bin <= 1)  left -> 65, right -> 66
node(19,64,5,1).
left_node(19,64,65).
right_node(19,64,66).
% node 65 (leaf): class nine (10)
leaf_class(19,65,10).
% node 66 (leaf): class twelve (13)
leaf_class(19,66,13).
% node 67: f5 <= 2.5  (F5, bin <= 1)  left -> 68, right -> 69
node(19,67,5,1).
left_node(19,67,68).
right_node(19,67,69).
% node 68 (leaf): class eight (9)
leaf_class(19,68,9).
% node 69: f2 <= 5.5  (F2, bin <= 5)  left -> 70, right -> 73
node(19,69,2,5).
left_node(19,69,70).
right_node(19,69,73).
% node 70: f1 <= 1.5  (F1, bin <= 0)  left -> 71, right -> 72
node(19,70,1,0).
left_node(19,70,71).
right_node(19,70,72).
% node 71 (leaf): class twelve (13)
leaf_class(19,71,13).
% node 72 (leaf): class eleven (12)
leaf_class(19,72,12).
% node 73 (leaf): class draw (0)
leaf_class(19,73,0).
% node 74 (leaf): class nine (10)
leaf_class(19,74,10).

% Tree 20
tree(20).
% node 0: f1 <= 1.5  (F1, bin <= 0)  left -> 1, right -> 26
node(20,0,1,0).
left_node(20,0,1).
right_node(20,0,26).
% node 1: f4 <= 0.5  (F4, bin <= 0)  left -> 2, right -> 11
node(20,1,4,0).
left_node(20,1,2).
right_node(20,1,11).
% node 2: f3 <= 3.5  (F3, bin <= 2)  left -> 3, right -> 4
node(20,2,3,2).
left_node(20,2,3).
right_node(20,2,4).
% node 3 (leaf): class eleven (12)
leaf_class(20,3,12).
% node 4: f5 <= 1.5  (F5, bin <= 0)  left -> 5, right -> 8
node(20,4,5,0).
left_node(20,4,5).
right_node(20,4,8).
% node 5: f0 <= 2.5  (F0, bin <= 2)  left -> 6, right -> 7
node(20,5,0,2).
left_node(20,5,6).
right_node(20,5,7).
% node 6 (leaf): class two (3)
leaf_class(20,6,3).
% node 7 (leaf): class five (6)
leaf_class(20,7,6).
% node 8: f2 <= 1.5  (F2, bin <= 1)  left -> 9, right -> 10
node(20,8,2,1).
left_node(20,8,9).
right_node(20,8,10).
% node 9 (leaf): class draw (0)
leaf_class(20,9,0).
% node 10 (leaf): class twelve (13)
leaf_class(20,10,13).
% node 11: f4 <= 6.5  (F4, bin <= 8)  left -> 12, right -> 23
node(20,11,4,8).
left_node(20,11,12).
right_node(20,11,23).
% node 12: f5 <= 2.5  (F5, bin <= 1)  left -> 13, right -> 14
node(20,12,5,1).
left_node(20,12,13).
right_node(20,12,14).
% node 13 (leaf): class thirteen (14)
leaf_class(20,13,14).
% node 14: f0 <= 0.5  (F0, bin <= 0)  left -> 15, right -> 16
node(20,14,0,0).
left_node(20,14,15).
right_node(20,14,16).
% node 15 (leaf): class fifteen (16)
leaf_class(20,15,16).
% node 16: f5 <= 6.5  (F5, bin <= 4)  left -> 17, right -> 20
node(20,16,5,4).
left_node(20,16,17).
right_node(20,16,20).
% node 17: f2 <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(20,17,2,0).
left_node(20,17,18).
right_node(20,17,19).
% node 18 (leaf): class fourteen (15)
leaf_class(20,18,15).
% node 19 (leaf): class fifteen (16)
leaf_class(20,19,16).
% node 20: f3 <= 5.5  (F3, bin <= 4)  left -> 21, right -> 22
node(20,20,3,4).
left_node(20,20,21).
right_node(20,20,22).
% node 21 (leaf): class fourteen (15)
leaf_class(20,21,15).
% node 22 (leaf): class draw (0)
leaf_class(20,22,0).
% node 23: f5 <= 2.5  (F5, bin <= 1)  left -> 24, right -> 25
node(20,23,5,1).
left_node(20,23,24).
right_node(20,23,25).
% node 24 (leaf): class eight (9)
leaf_class(20,24,9).
% node 25 (leaf): class thirteen (14)
leaf_class(20,25,14).
% node 26: f5 <= 2.5  (F5, bin <= 1)  left -> 27, right -> 34
node(20,26,5,1).
left_node(20,26,27).
right_node(20,26,34).
% node 27: f0 <= 2.5  (F0, bin <= 2)  left -> 28, right -> 31
node(20,27,0,2).
left_node(20,27,28).
right_node(20,27,31).
% node 28: f4 <= 2.5  (F4, bin <= 3)  left -> 29, right -> 30
node(20,28,4,3).
left_node(20,28,29).
right_node(20,28,30).
% node 29 (leaf): class two (3)
leaf_class(20,29,3).
% node 30 (leaf): class ten (11)
leaf_class(20,30,11).
% node 31: f1 <= 3.5  (F1, bin <= 2)  left -> 32, right -> 33
node(20,31,1,2).
left_node(20,31,32).
right_node(20,31,33).
% node 32 (leaf): class eight (9)
leaf_class(20,32,9).
% node 33 (leaf): class eight (9)
leaf_class(20,33,9).
% node 34: f0 <= 2.5  (F0, bin <= 2)  left -> 35, right -> 50
node(20,34,0,2).
left_node(20,34,35).
right_node(20,34,50).
% node 35: f1 <= 2.5  (F1, bin <= 1)  left -> 36, right -> 45
node(20,35,1,1).
left_node(20,35,36).
right_node(20,35,45).
% node 36: f5 <= 5.5  (F5, bin <= 3)  left -> 37, right -> 42
node(20,36,5,3).
left_node(20,36,37).
right_node(20,36,42).
% node 37: f4 <= 5.5  (F4, bin <= 7)  left -> 38, right -> 41
node(20,37,4,7).
left_node(20,37,38).
right_node(20,37,41).
% node 38: f0 <= 1.5  (F0, bin <= 1)  left -> 39, right -> 40
node(20,38,0,1).
left_node(20,38,39).
right_node(20,38,40).
% node 39 (leaf): class fourteen (15)
leaf_class(20,39,15).
% node 40 (leaf): class fourteen (15)
leaf_class(20,40,15).
% node 41 (leaf): class thirteen (14)
leaf_class(20,41,14).
% node 42: f3 <= 4.5  (F3, bin <= 3)  left -> 43, right -> 44
node(20,42,3,3).
left_node(20,42,43).
right_node(20,42,44).
% node 43 (leaf): class thirteen (14)
leaf_class(20,43,14).
% node 44 (leaf): class twelve (13)
leaf_class(20,44,13).
% node 45: f5 <= 6.5  (F5, bin <= 4)  left -> 46, right -> 49
node(20,45,5,4).
left_node(20,45,46).
right_node(20,45,49).
% node 46: f4 <= 5.5  (F4, bin <= 7)  left -> 47, right -> 48
node(20,46,4,7).
left_node(20,46,47).
right_node(20,46,48).
% node 47 (leaf): class thirteen (14)
leaf_class(20,47,14).
% node 48 (leaf): class twelve (13)
leaf_class(20,48,13).
% node 49 (leaf): class eleven (12)
leaf_class(20,49,12).
% node 50: f3 <= 3.5  (F3, bin <= 2)  left -> 51, right -> 56
node(20,50,3,2).
left_node(20,50,51).
right_node(20,50,56).
% node 51: f5 <= 3.5  (F5, bin <= 2)  left -> 52, right -> 53
node(20,51,5,2).
left_node(20,51,52).
right_node(20,51,53).
% node 52 (leaf): class ten (11)
leaf_class(20,52,11).
% node 53: f4 <= 6.5  (F4, bin <= 8)  left -> 54, right -> 55
node(20,53,4,8).
left_node(20,53,54).
right_node(20,53,55).
% node 54 (leaf): class twelve (13)
leaf_class(20,54,13).
% node 55 (leaf): class eleven (12)
leaf_class(20,55,12).
% node 56 (leaf): class eleven (12)
leaf_class(20,56,12).

% Tree 21
tree(21).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 22
node(21,0,5,1).
left_node(21,0,1).
right_node(21,0,22).
% node 1: f3 <= 3.5  (F3, bin <= 2)  left -> 2, right -> 5
node(21,1,3,2).
left_node(21,1,2).
right_node(21,1,5).
% node 2: f5 <= 1.5  (F5, bin <= 0)  left -> 3, right -> 4
node(21,2,5,0).
left_node(21,2,3).
right_node(21,2,4).
% node 3 (leaf): class draw (0)
leaf_class(21,3,0).
% node 4 (leaf): class draw (0)
leaf_class(21,4,0).
% node 5: f4 <= 2.5  (F4, bin <= 3)  left -> 6, right -> 11
node(21,5,4,3).
left_node(21,5,6).
right_node(21,5,11).
% node 6: f2 <= 2.5  (F2, bin <= 2)  left -> 7, right -> 8
node(21,6,2,2).
left_node(21,6,7).
right_node(21,6,8).
% node 7 (leaf): class five (6)
leaf_class(21,7,6).
% node 8: f1 <= 3.5  (F1, bin <= 2)  left -> 9, right -> 10
node(21,8,1,2).
left_node(21,8,9).
right_node(21,8,10).
% node 9 (leaf): class five (6)
leaf_class(21,9,6).
% node 10 (leaf): class eight (9)
leaf_class(21,10,9).
% node 11: f0 <= 1.5  (F0, bin <= 1)  left -> 12, right -> 15
node(21,11,0,1).
left_node(21,11,12).
right_node(21,11,15).
% node 12: f4 <= 5.5  (F4, bin <= 7)  left -> 13, right -> 14
node(21,12,4,7).
left_node(21,12,13).
right_node(21,12,14).
% node 13 (leaf): class fourteen (15)
leaf_class(21,13,15).
% node 14 (leaf): class eleven (12)
leaf_class(21,14,12).
% node 15: f5 <= 1.5  (F5, bin <= 0)  left -> 16, right -> 17
node(21,15,5,0).
left_node(21,15,16).
right_node(21,15,17).
% node 16 (leaf): class eight (9)
leaf_class(21,16,9).
% node 17: f0 <= 2.5  (F0, bin <= 2)  left -> 18, right -> 21
node(21,17,0,2).
left_node(21,17,18).
right_node(21,17,21).
% node 18: f3 <= 4.5  (F3, bin <= 3)  left -> 19, right -> 20
node(21,18,3,3).
left_node(21,18,19).
right_node(21,18,20).
% node 19 (leaf): class nine (10)
leaf_class(21,19,10).
% node 20 (leaf): class ten (11)
leaf_class(21,20,11).
% node 21 (leaf): class eight (9)
leaf_class(21,21,9).
% node 22: f0 <= 1.5  (F0, bin <= 1)  left -> 23, right -> 48
node(21,22,0,1).
left_node(21,22,23).
right_node(21,22,48).
% node 23: f4 <= 6.5  (F4, bin <= 8)  left -> 24, right -> 41
node(21,23,4,8).
left_node(21,23,24).
right_node(21,23,41).
% node 24: f0 <= 0.5  (F0, bin <= 0)  left -> 25, right -> 32
node(21,24,0,0).
left_node(21,24,25).
right_node(21,24,32).
% node 25: f4 <= 5.5  (F4, bin <= 7)  left -> 26, right -> 31
node(21,25,4,7).
left_node(21,25,26).
right_node(21,25,31).
% node 26: f3 <= 1.5  (F3, bin <= 0)  left -> 27, right -> 28
node(21,26,3,0).
left_node(21,26,27).
right_node(21,26,28).
% node 27 (leaf): class fifteen (16)
leaf_class(21,27,16).
% node 28: f2 <= 0.5  (F2, bin <= 0)  left -> 29, right -> 30
node(21,28,2,0).
left_node(21,28,29).
right_node(21,28,30).
% node 29 (leaf): class fifteen (16)
leaf_class(21,29,16).
% node 30 (leaf): class sixteen (17)
leaf_class(21,30,17).
% node 31 (leaf): class fifteen (16)
leaf_class(21,31,16).
% node 32: f4 <= 1.5  (F4, bin <= 1)  left -> 33, right -> 34
node(21,32,4,1).
left_node(21,32,33).
right_node(21,32,34).
% node 33 (leaf): class fourteen (15)
leaf_class(21,33,15).
% node 34: f4 <= 5.5  (F4, bin <= 7)  left -> 35, right -> 38
node(21,34,4,7).
left_node(21,34,35).
right_node(21,34,38).
% node 35: f5 <= 6.5  (F5, bin <= 4)  left -> 36, right -> 37
node(21,35,5,4).
left_node(21,35,36).
right_node(21,35,37).
% node 36 (leaf): class fifteen (16)
leaf_class(21,36,16).
% node 37 (leaf): class fourteen (15)
leaf_class(21,37,15).
% node 38: f2 <= 4.5  (F2, bin <= 4)  left -> 39, right -> 40
node(21,38,2,4).
left_node(21,38,39).
right_node(21,38,40).
% node 39 (leaf): class fourteen (15)
leaf_class(21,39,15).
% node 40 (leaf): class draw (0)
leaf_class(21,40,0).
% node 41: f0 <= 0.5  (F0, bin <= 0)  left -> 42, right -> 43
node(21,41,0,0).
left_node(21,41,42).
right_node(21,41,43).
% node 42 (leaf): class fourteen (15)
leaf_class(21,42,15).
% node 43: f2 <= 4.5  (F2, bin <= 4)  left -> 44, right -> 45
node(21,43,2,4).
left_node(21,43,44).
right_node(21,43,45).
% node 44 (leaf): class thirteen (14)
leaf_class(21,44,14).
% node 45: f2 <= 5.5  (F2, bin <= 5)  left -> 46, right -> 47
node(21,45,2,5).
left_node(21,45,46).
right_node(21,45,47).
% node 46 (leaf): class twelve (13)
leaf_class(21,46,13).
% node 47 (leaf): class draw (0)
leaf_class(21,47,0).
% node 48: f0 <= 2.5  (F0, bin <= 2)  left -> 49, right -> 66
node(21,48,0,2).
left_node(21,48,49).
right_node(21,48,66).
% node 49: f1 <= 1.5  (F1, bin <= 0)  left -> 50, right -> 57
node(21,49,1,0).
left_node(21,49,50).
right_node(21,49,57).
% node 50: f2 <= 6.5  (F2, bin <= 6)  left -> 51, right -> 56
node(21,50,2,6).
left_node(21,50,51).
right_node(21,50,56).
% node 51: f4 <= 0.5  (F4, bin <= 0)  left -> 52, right -> 53
node(21,51,4,0).
left_node(21,51,52).
right_node(21,51,53).
% node 52 (leaf): class eleven (12)
leaf_class(21,52,12).
% node 53: f5 <= 6.5  (F5, bin <= 4)  left -> 54, right -> 55
node(21,53,5,4).
left_node(21,53,54).
right_node(21,53,55).
% node 54 (leaf): class fourteen (15)
leaf_class(21,54,15).
% node 55 (leaf): class fourteen (15)
leaf_class(21,55,15).
% node 56 (leaf): class fourteen (15)
leaf_class(21,56,15).
% node 57: f2 <= 4.5  (F2, bin <= 4)  left -> 58, right -> 65
node(21,57,2,4).
left_node(21,57,58).
right_node(21,57,65).
% node 58: f4 <= 5.5  (F4, bin <= 7)  left -> 59, right -> 62
node(21,58,4,7).
left_node(21,58,59).
right_node(21,58,62).
% node 59: f4 <= 1.5  (F4, bin <= 1)  left -> 60, right -> 61
node(21,59,4,1).
left_node(21,59,60).
right_node(21,59,61).
% node 60 (leaf): class eleven (12)
leaf_class(21,60,12).
% node 61 (leaf): class thirteen (14)
leaf_class(21,61,14).
% node 62: f1 <= 2.5  (F1, bin <= 1)  left -> 63, right -> 64
node(21,62,1,1).
left_node(21,62,63).
right_node(21,62,64).
% node 63 (leaf): class twelve (13)
leaf_class(21,63,13).
% node 64 (leaf): class twelve (13)
leaf_class(21,64,13).
% node 65 (leaf): class thirteen (14)
leaf_class(21,65,14).
% node 66: f1 <= 1.5  (F1, bin <= 0)  left -> 67, right -> 74
node(21,66,1,0).
left_node(21,66,67).
right_node(21,66,74).
% node 67: f5 <= 6.5  (F5, bin <= 4)  left -> 68, right -> 73
node(21,67,5,4).
left_node(21,67,68).
right_node(21,67,73).
% node 68: f2 <= 0.5  (F2, bin <= 0)  left -> 69, right -> 70
node(21,68,2,0).
left_node(21,68,69).
right_node(21,68,70).
% node 69 (leaf): class fourteen (15)
leaf_class(21,69,15).
% node 70: f2 <= 6.5  (F2, bin <= 6)  left -> 71, right -> 72
node(21,70,2,6).
left_node(21,70,71).
right_node(21,70,72).
% node 71 (leaf): class fourteen (15)
leaf_class(21,71,15).
% node 72 (leaf): class fourteen (15)
leaf_class(21,72,15).
% node 73 (leaf): class fourteen (15)
leaf_class(21,73,15).
% node 74: f5 <= 3.5  (F5, bin <= 2)  left -> 75, right -> 76
node(21,74,5,2).
left_node(21,74,75).
right_node(21,74,76).
% node 75 (leaf): class ten (11)
leaf_class(21,75,11).
% node 76: f1 <= 2.5  (F1, bin <= 1)  left -> 77, right -> 78
node(21,76,1,1).
left_node(21,76,77).
right_node(21,76,78).
% node 77 (leaf): class thirteen (14)
leaf_class(21,77,14).
% node 78 (leaf): class eleven (12)
leaf_class(21,78,12).

% Tree 22
tree(22).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 18
node(22,0,0,1).
left_node(22,0,1).
right_node(22,0,18).
% node 1: f5 <= 1.5  (F5, bin <= 0)  left -> 2, right -> 5
node(22,1,5,0).
left_node(22,1,2).
right_node(22,1,5).
% node 2: f0 <= 0.5  (F0, bin <= 0)  left -> 3, right -> 4
node(22,2,0,0).
left_node(22,2,3).
right_node(22,2,4).
% node 3 (leaf): class eleven (12)
leaf_class(22,3,12).
% node 4 (leaf): class ten (11)
leaf_class(22,4,11).
% node 5: f5 <= 6.5  (F5, bin <= 4)  left -> 6, right -> 17
node(22,5,5,4).
left_node(22,5,6).
right_node(22,5,17).
% node 6: f0 <= 0.5  (F0, bin <= 0)  left -> 7, right -> 10
node(22,6,0,0).
left_node(22,6,7).
right_node(22,6,10).
% node 7: f4 <= 6.5  (F4, bin <= 8)  left -> 8, right -> 9
node(22,7,4,8).
left_node(22,7,8).
right_node(22,7,9).
% node 8 (leaf): class fifteen (16)
leaf_class(22,8,16).
% node 9 (leaf): class fourteen (15)
leaf_class(22,9,15).
% node 10: f4 <= 6.5  (F4, bin <= 8)  left -> 11, right -> 16
node(22,10,4,8).
left_node(22,10,11).
right_node(22,10,16).
% node 11: f4 <= 0.5  (F4, bin <= 0)  left -> 12, right -> 13
node(22,11,4,0).
left_node(22,11,12).
right_node(22,11,13).
% node 12 (leaf): class twelve (13)
leaf_class(22,12,13).
% node 13: f5 <= 2.5  (F5, bin <= 1)  left -> 14, right -> 15
node(22,13,5,1).
left_node(22,13,14).
right_node(22,13,15).
% node 14 (leaf): class fourteen (15)
leaf_class(22,14,15).
% node 15 (leaf): class fifteen (16)
leaf_class(22,15,16).
% node 16 (leaf): class thirteen (14)
leaf_class(22,16,14).
% node 17 (leaf): class fourteen (15)
leaf_class(22,17,15).
% node 18: f5 <= 2.5  (F5, bin <= 1)  left -> 19, right -> 38
node(22,18,5,1).
left_node(22,18,19).
right_node(22,18,38).
% node 19: f4 <= 2.5  (F4, bin <= 3)  left -> 20, right -> 27
node(22,19,4,3).
left_node(22,19,20).
right_node(22,19,27).
% node 20: f3 <= 3.5  (F3, bin <= 2)  left -> 21, right -> 26
node(22,20,3,2).
left_node(22,20,21).
right_node(22,20,26).
% node 21: f2 <= 1.5  (F2, bin <= 1)  left -> 22, right -> 23
node(22,21,2,1).
left_node(22,21,22).
right_node(22,21,23).
% node 22 (leaf): class draw (0)
leaf_class(22,22,0).
% node 23: f0 <= 2.5  (F0, bin <= 2)  left -> 24, right -> 25
node(22,23,0,2).
left_node(22,23,24).
right_node(22,23,25).
% node 24 (leaf): class two (3)
leaf_class(22,24,3).
% node 25 (leaf): class four (5)
leaf_class(22,25,5).
% node 26 (leaf): class five (6)
leaf_class(22,26,6).
% node 27: f3 <= 3.5  (F3, bin <= 2)  left -> 28, right -> 35
node(22,27,3,2).
left_node(22,27,28).
right_node(22,27,35).
% node 28: f2 <= 4.5  (F2, bin <= 4)  left -> 29, right -> 34
node(22,28,2,4).
left_node(22,28,29).
right_node(22,28,34).
% node 29: f3 <= 2.5  (F3, bin <= 1)  left -> 30, right -> 33
node(22,29,3,1).
left_node(22,29,30).
right_node(22,29,33).
% node 30: f5 <= 1.5  (F5, bin <= 0)  left -> 31, right -> 32
node(22,30,5,0).
left_node(22,30,31).
right_node(22,30,32).
% node 31 (leaf): class five (6)
leaf_class(22,31,6).
% node 32 (leaf): class ten (11)
leaf_class(22,32,11).
% node 33 (leaf): class seven (8)
leaf_class(22,33,8).
% node 34 (leaf): class draw (0)
leaf_class(22,34,0).
% node 35: f1 <= 1.5  (F1, bin <= 0)  left -> 36, right -> 37
node(22,35,1,0).
left_node(22,35,36).
right_node(22,35,37).
% node 36 (leaf): class nine (10)
leaf_class(22,36,10).
% node 37 (leaf): class eight (9)
leaf_class(22,37,9).
% node 38: f1 <= 1.5  (F1, bin <= 0)  left -> 39, right -> 56
node(22,38,1,0).
left_node(22,38,39).
right_node(22,38,56).
% node 39: f5 <= 6.5  (F5, bin <= 4)  left -> 40, right -> 47
node(22,39,5,4).
left_node(22,39,40).
right_node(22,39,47).
% node 40: f2 <= 0.5  (F2, bin <= 0)  left -> 41, right -> 42
node(22,40,2,0).
left_node(22,40,41).
right_node(22,40,42).
% node 41 (leaf): class fourteen (15)
leaf_class(22,41,15).
% node 42: f4 <= 1.5  (F4, bin <= 1)  left -> 43, right -> 44
node(22,42,4,1).
left_node(22,42,43).
right_node(22,42,44).
% node 43 (leaf): class fourteen (15)
leaf_class(22,43,15).
% node 44: f4 <= 6.5  (F4, bin <= 8)  left -> 45, right -> 46
node(22,44,4,8).
left_node(22,44,45).
right_node(22,44,46).
% node 45 (leaf): class fourteen (15)
leaf_class(22,45,15).
% node 46 (leaf): class twelve (13)
leaf_class(22,46,13).
% node 47: f5 <= 7.5  (F5, bin <= 5)  left -> 48, right -> 53
node(22,47,5,5).
left_node(22,47,48).
right_node(22,47,53).
% node 48: f3 <= 5.5  (F3, bin <= 4)  left -> 49, right -> 52
node(22,48,3,4).
left_node(22,48,49).
right_node(22,48,52).
% node 49: f4 <= 1.5  (F4, bin <= 1)  left -> 50, right -> 51
node(22,49,4,1).
left_node(22,49,50).
right_node(22,49,51).
% node 50 (leaf): class thirteen (14)
leaf_class(22,50,14).
% node 51 (leaf): class fourteen (15)
leaf_class(22,51,15).
% node 52 (leaf): class draw (0)
leaf_class(22,52,0).
% node 53: f4 <= 1.5  (F4, bin <= 1)  left -> 54, right -> 55
node(22,53,4,1).
left_node(22,53,54).
right_node(22,53,55).
% node 54 (leaf): class twelve (13)
leaf_class(22,54,13).
% node 55 (leaf): class fourteen (15)
leaf_class(22,55,15).
% node 56: f1 <= 2.5  (F1, bin <= 1)  left -> 57, right -> 66
node(22,56,1,1).
left_node(22,56,57).
right_node(22,56,66).
% node 57: f5 <= 5.5  (F5, bin <= 3)  left -> 58, right -> 63
node(22,57,5,3).
left_node(22,57,58).
right_node(22,57,63).
% node 58: f0 <= 2.5  (F0, bin <= 2)  left -> 59, right -> 62
node(22,58,0,2).
left_node(22,58,59).
right_node(22,58,62).
% node 59: f4 <= 1.5  (F4, bin <= 1)  left -> 60, right -> 61
node(22,59,4,1).
left_node(22,59,60).
right_node(22,59,61).
% node 60 (leaf): class twelve (13)
leaf_class(22,60,13).
% node 61 (leaf): class fourteen (15)
leaf_class(22,61,15).
% node 62 (leaf): class thirteen (14)
leaf_class(22,62,14).
% node 63: f3 <= 4.5  (F3, bin <= 3)  left -> 64, right -> 65
node(22,63,3,3).
left_node(22,63,64).
right_node(22,63,65).
% node 64 (leaf): class thirteen (14)
leaf_class(22,64,14).
% node 65 (leaf): class twelve (13)
leaf_class(22,65,13).
% node 66: f0 <= 2.5  (F0, bin <= 2)  left -> 67, right -> 72
node(22,66,0,2).
left_node(22,66,67).
right_node(22,66,72).
% node 67: f4 <= 5.5  (F4, bin <= 7)  left -> 68, right -> 69
node(22,67,4,7).
left_node(22,67,68).
right_node(22,67,69).
% node 68 (leaf): class thirteen (14)
leaf_class(22,68,14).
% node 69: f2 <= 3.5  (F2, bin <= 3)  left -> 70, right -> 71
node(22,69,2,3).
left_node(22,69,70).
right_node(22,69,71).
% node 70 (leaf): class twelve (13)
leaf_class(22,70,13).
% node 71 (leaf): class eleven (12)
leaf_class(22,71,12).
% node 72: f1 <= 3.5  (F1, bin <= 2)  left -> 73, right -> 74
node(22,72,1,2).
left_node(22,72,73).
right_node(22,72,74).
% node 73 (leaf): class twelve (13)
leaf_class(22,73,13).
% node 74: f4 <= 6.5  (F4, bin <= 8)  left -> 75, right -> 76
node(22,74,4,8).
left_node(22,74,75).
right_node(22,74,76).
% node 75 (leaf): class eleven (12)
leaf_class(22,75,12).
% node 76 (leaf): class nine (10)
leaf_class(22,76,10).

% Tree 23
tree(23).
% node 0: f1 <= 1.5  (F1, bin <= 0)  left -> 1, right -> 38
node(23,0,1,0).
left_node(23,0,1).
right_node(23,0,38).
% node 1: f2 <= 0.5  (F2, bin <= 0)  left -> 2, right -> 13
node(23,1,2,0).
left_node(23,1,2).
right_node(23,1,13).
% node 2: f5 <= 2.5  (F5, bin <= 1)  left -> 3, right -> 4
node(23,2,5,1).
left_node(23,2,3).
right_node(23,2,4).
% node 3 (leaf): class nine (10)
leaf_class(23,3,10).
% node 4: f4 <= 1.5  (F4, bin <= 1)  left -> 5, right -> 6
node(23,4,4,1).
left_node(23,4,5).
right_node(23,4,6).
% node 5 (leaf): class draw (0)
leaf_class(23,5,0).
% node 6: f5 <= 7.5  (F5, bin <= 5)  left -> 7, right -> 12
node(23,6,5,5).
left_node(23,6,7).
right_node(23,6,12).
% node 7: f0 <= 0.5  (F0, bin <= 0)  left -> 8, right -> 9
node(23,7,0,0).
left_node(23,7,8).
right_node(23,7,9).
% node 8 (leaf): class fifteen (16)
leaf_class(23,8,16).
% node 9: f4 <= 6.5  (F4, bin <= 8)  left -> 10, right -> 11
node(23,9,4,8).
left_node(23,9,10).
right_node(23,9,11).
% node 10 (leaf): class fourteen (15)
leaf_class(23,10,15).
% node 11 (leaf): class thirteen (14)
leaf_class(23,11,14).
% node 12 (leaf): class thirteen (14)
leaf_class(23,12,14).
% node 13: f5 <= 2.5  (F5, bin <= 1)  left -> 14, right -> 19
node(23,13,5,1).
left_node(23,13,14).
right_node(23,13,19).
% node 14: f0 <= 1.5  (F0, bin <= 1)  left -> 15, right -> 18
node(23,14,0,1).
left_node(23,14,15).
right_node(23,14,18).
% node 15: f3 <= 3.5  (F3, bin <= 2)  left -> 16, right -> 17
node(23,15,3,2).
left_node(23,15,16).
right_node(23,15,17).
% node 16 (leaf): class draw (0)
leaf_class(23,16,0).
% node 17 (leaf): class twelve (13)
leaf_class(23,17,13).
% node 18 (leaf): class eight (9)
leaf_class(23,18,9).
% node 19: f5 <= 6.5  (F5, bin <= 4)  left -> 20, right -> 33
node(23,19,5,4).
left_node(23,19,20).
right_node(23,19,33).
% node 20: f4 <= 1.5  (F4, bin <= 1)  left -> 21, right -> 26
node(23,20,4,1).
left_node(23,20,21).
right_node(23,20,26).
% node 21: f2 <= 2.5  (F2, bin <= 2)  left -> 22, right -> 23
node(23,21,2,2).
left_node(23,21,22).
right_node(23,21,23).
% node 22 (leaf): class draw (0)
leaf_class(23,22,0).
% node 23: f4 <= 0.5  (F4, bin <= 0)  left -> 24, right -> 25
node(23,23,4,0).
left_node(23,23,24).
right_node(23,23,25).
% node 24 (leaf): class twelve (13)
leaf_class(23,24,13).
% node 25 (leaf): class fourteen (15)
leaf_class(23,25,15).
% node 26: f4 <= 5.5  (F4, bin <= 7)  left -> 27, right -> 30
node(23,26,4,7).
left_node(23,26,27).
right_node(23,26,30).
% node 27: f0 <= 0.5  (F0, bin <= 0)  left -> 28, right -> 29
node(23,27,0,0).
left_node(23,27,28).
right_node(23,27,29).
% node 28 (leaf): class sixteen (17)
leaf_class(23,28,17).
% node 29 (leaf): class fifteen (16)
leaf_class(23,29,16).
% node 30: f0 <= 0.5  (F0, bin <= 0)  left -> 31, right -> 32
node(23,30,0,0).
left_node(23,30,31).
right_node(23,30,32).
% node 31 (leaf): class fifteen (16)
leaf_class(23,31,16).
% node 32 (leaf): class fourteen (15)
leaf_class(23,32,15).
% node 33: f0 <= 1.5  (F0, bin <= 1)  left -> 34, right -> 35
node(23,33,0,1).
left_node(23,33,34).
right_node(23,33,35).
% node 34 (leaf): class fourteen (15)
leaf_class(23,34,15).
% node 35: f3 <= 5.5  (F3, bin <= 4)  left -> 36, right -> 37
node(23,35,3,4).
left_node(23,35,36).
right_node(23,35,37).
% node 36 (leaf): class fourteen (15)
leaf_class(23,36,15).
% node 37 (leaf): class thirteen (14)
leaf_class(23,37,14).
% node 38: f1 <= 2.5  (F1, bin <= 1)  left -> 39, right -> 62
node(23,38,1,1).
left_node(23,38,39).
right_node(23,38,62).
% node 39: f0 <= 1.5  (F0, bin <= 1)  left -> 40, right -> 47
node(23,39,0,1).
left_node(23,39,40).
right_node(23,39,47).
% node 40: f5 <= 2.5  (F5, bin <= 1)  left -> 41, right -> 42
node(23,40,5,1).
left_node(23,40,41).
right_node(23,40,42).
% node 41 (leaf): class twelve (13)
leaf_class(23,41,13).
% node 42: f2 <= 4.5  (F2, bin <= 4)  left -> 43, right -> 46
node(23,42,2,4).
left_node(23,42,43).
right_node(23,42,46).
% node 43: f4 <= 6.5  (F4, bin <= 8)  left -> 44, right -> 45
node(23,43,4,8).
left_node(23,43,44).
right_node(23,43,45).
% node 44 (leaf): class fourteen (15)
leaf_class(23,44,15).
% node 45 (leaf): class thirteen (14)
leaf_class(23,45,14).
% node 46 (leaf): class fourteen (15)
leaf_class(23,46,15).
% node 47: f4 <= 0.5  (F4, bin <= 0)  left -> 48, right -> 51
node(23,47,4,0).
left_node(23,47,48).
right_node(23,47,51).
% node 48: f5 <= 2.5  (F5, bin <= 1)  left -> 49, right -> 50
node(23,48,5,1).
left_node(23,48,49).
right_node(23,48,50).
% node 49 (leaf): class four (5)
leaf_class(23,49,5).
% node 50 (leaf): class eleven (12)
leaf_class(23,50,12).
% node 51: f5 <= 2.5  (F5, bin <= 1)  left -> 52, right -> 57
node(23,51,5,1).
left_node(23,51,52).
right_node(23,51,57).
% node 52: f5 <= 1.5  (F5, bin <= 0)  left -> 53, right -> 56
node(23,52,5,0).
left_node(23,52,53).
right_node(23,52,56).
% node 53: f4 <= 2.5  (F4, bin <= 3)  left -> 54, right -> 55
node(23,53,4,3).
left_node(23,53,54).
right_node(23,53,55).
% node 54 (leaf): class four (5)
leaf_class(23,54,5).
% node 55 (leaf): class six (7)
leaf_class(23,55,7).
% node 56 (leaf): class eight (9)
leaf_class(23,56,9).
% node 57: f4 <= 6.5  (F4, bin <= 8)  left -> 58, right -> 61
node(23,57,4,8).
left_node(23,57,58).
right_node(23,57,61).
% node 58: f5 <= 5.5  (F5, bin <= 3)  left -> 59, right -> 60
node(23,58,5,3).
left_node(23,58,59).
right_node(23,58,60).
% node 59 (leaf): class thirteen (14)
leaf_class(23,59,14).
% node 60 (leaf): class thirteen (14)
leaf_class(23,60,14).
% node 61 (leaf): class eleven (12)
leaf_class(23,61,12).
% node 62: f4 <= 1.5  (F4, bin <= 1)  left -> 63, right -> 74
node(23,62,4,1).
left_node(23,62,63).
right_node(23,62,74).
% node 63: f0 <= 2.5  (F0, bin <= 2)  left -> 64, right -> 65
node(23,63,0,2).
left_node(23,63,64).
right_node(23,63,65).
% node 64 (leaf): class two (3)
leaf_class(23,64,3).
% node 65: f4 <= 0.5  (F4, bin <= 0)  left -> 66, right -> 69
node(23,65,4,0).
left_node(23,65,66).
right_node(23,65,69).
% node 66: f5 <= 3.5  (F5, bin <= 2)  left -> 67, right -> 68
node(23,66,5,2).
left_node(23,66,67).
right_node(23,66,68).
% node 67 (leaf): class five (6)
leaf_class(23,67,6).
% node 68 (leaf): class nine (10)
leaf_class(23,68,10).
% node 69: f1 <= 3.5  (F1, bin <= 2)  left -> 70, right -> 73
node(23,69,1,2).
left_node(23,69,70).
right_node(23,69,73).
% node 70: f5 <= 2.5  (F5, bin <= 1)  left -> 71, right -> 72
node(23,70,5,1).
left_node(23,70,71).
right_node(23,70,72).
% node 71 (leaf): class six (7)
leaf_class(23,71,7).
% node 72 (leaf): class ten (11)
leaf_class(23,72,11).
% node 73 (leaf): class eight (9)
leaf_class(23,73,9).
% node 74: f1 <= 3.5  (F1, bin <= 2)  left -> 75, right -> 86
node(23,74,1,2).
left_node(23,74,75).
right_node(23,74,86).
% node 75: f2 <= 2.5  (F2, bin <= 2)  left -> 76, right -> 81
node(23,75,2,2).
left_node(23,75,76).
right_node(23,75,81).
% node 76: f5 <= 2.5  (F5, bin <= 1)  left -> 77, right -> 80
node(23,76,5,1).
left_node(23,76,77).
right_node(23,76,80).
% node 77: f0 <= 2.5  (F0, bin <= 2)  left -> 78, right -> 79
node(23,77,0,2).
left_node(23,77,78).
right_node(23,77,79).
% node 78 (leaf): class ten (11)
leaf_class(23,78,11).
% node 79 (leaf): class eight (9)
leaf_class(23,79,9).
% node 80 (leaf): class twelve (13)
leaf_class(23,80,13).
% node 81: f5 <= 2.5  (F5, bin <= 1)  left -> 82, right -> 83
node(23,81,5,1).
left_node(23,81,82).
right_node(23,81,83).
% node 82 (leaf): class eight (9)
leaf_class(23,82,9).
% node 83: f2 <= 5.5  (F2, bin <= 5)  left -> 84, right -> 85
node(23,83,2,5).
left_node(23,83,84).
right_node(23,83,85).
% node 84 (leaf): class eleven (12)
leaf_class(23,84,12).
% node 85 (leaf): class twelve (13)
leaf_class(23,85,13).
% node 86: f4 <= 3.5  (F4, bin <= 5)  left -> 87, right -> 88
node(23,86,4,5).
left_node(23,86,87).
right_node(23,86,88).
% node 87 (leaf): class eight (9)
leaf_class(23,87,9).
% node 88: f5 <= 2.5  (F5, bin <= 1)  left -> 89, right -> 92
node(23,88,5,1).
left_node(23,88,89).
right_node(23,88,92).
% node 89: f4 <= 6.5  (F4, bin <= 8)  left -> 90, right -> 91
node(23,89,4,8).
left_node(23,89,90).
right_node(23,89,91).
% node 90 (leaf): class nine (10)
leaf_class(23,90,10).
% node 91 (leaf): class seven (8)
leaf_class(23,91,8).
% node 92 (leaf): class nine (10)
leaf_class(23,92,10).

% Tree 24
tree(24).
% node 0: f1 <= 2.5  (F1, bin <= 1)  left -> 1, right -> 46
node(24,0,1,1).
left_node(24,0,1).
right_node(24,0,46).
% node 1: f1 <= 1.5  (F1, bin <= 0)  left -> 2, right -> 25
node(24,1,1,0).
left_node(24,1,2).
right_node(24,1,25).
% node 2: f5 <= 2.5  (F5, bin <= 1)  left -> 3, right -> 6
node(24,2,5,1).
left_node(24,2,3).
right_node(24,2,6).
% node 3: f5 <= 1.5  (F5, bin <= 0)  left -> 4, right -> 5
node(24,3,5,0).
left_node(24,3,4).
right_node(24,3,5).
% node 4 (leaf): class nine (10)
leaf_class(24,4,10).
% node 5 (leaf): class eleven (12)
leaf_class(24,5,12).
% node 6: f5 <= 6.5  (F5, bin <= 4)  left -> 7, right -> 18
node(24,6,5,4).
left_node(24,6,7).
right_node(24,6,18).
% node 7: f3 <= 5.5  (F3, bin <= 4)  left -> 8, right -> 13
node(24,7,3,4).
left_node(24,7,8).
right_node(24,7,13).
% node 8: f3 <= 3.5  (F3, bin <= 2)  left -> 9, right -> 12
node(24,8,3,2).
left_node(24,8,9).
right_node(24,8,12).
% node 9: f2 <= 0.5  (F2, bin <= 0)  left -> 10, right -> 11
node(24,9,2,0).
left_node(24,9,10).
right_node(24,9,11).
% node 10 (leaf): class fourteen (15)
leaf_class(24,10,15).
% node 11 (leaf): class fifteen (16)
leaf_class(24,11,16).
% node 12 (leaf): class fourteen (15)
leaf_class(24,12,15).
% node 13: f3 <= 7.5  (F3, bin <= 6)  left -> 14, right -> 17
node(24,13,3,6).
left_node(24,13,14).
right_node(24,13,17).
% node 14: f0 <= 0.5  (F0, bin <= 0)  left -> 15, right -> 16
node(24,14,0,0).
left_node(24,14,15).
right_node(24,14,16).
% node 15 (leaf): class sixteen (17)
leaf_class(24,15,17).
% node 16 (leaf): class fifteen (16)
leaf_class(24,16,16).
% node 17 (leaf): class fourteen (15)
leaf_class(24,17,15).
% node 18: f2 <= 2.5  (F2, bin <= 2)  left -> 19, right -> 24
node(24,18,2,2).
left_node(24,18,19).
right_node(24,18,24).
% node 19: f4 <= 1.5  (F4, bin <= 1)  left -> 20, right -> 21
node(24,19,4,1).
left_node(24,19,20).
right_node(24,19,21).
% node 20 (leaf): class draw (0)
leaf_class(24,20,0).
% node 21: f3 <= 5.5  (F3, bin <= 4)  left -> 22, right -> 23
node(24,21,3,4).
left_node(24,21,22).
right_node(24,21,23).
% node 22 (leaf): class fourteen (15)
leaf_class(24,22,15).
% node 23 (leaf): class thirteen (14)
leaf_class(24,23,14).
% node 24 (leaf): class fourteen (15)
leaf_class(24,24,15).
% node 25: f3 <= 4.5  (F3, bin <= 3)  left -> 26, right -> 35
node(24,25,3,3).
left_node(24,25,26).
right_node(24,25,35).
% node 26: f5 <= 3.5  (F5, bin <= 2)  left -> 27, right -> 28
node(24,26,5,2).
left_node(24,26,27).
right_node(24,26,28).
% node 27 (leaf): class draw (0)
leaf_class(24,27,0).
% node 28: f5 <= 5.5  (F5, bin <= 3)  left -> 29, right -> 34
node(24,28,5,3).
left_node(24,28,29).
right_node(24,28,34).
% node 29: f4 <= 1.5  (F4, bin <= 1)  left -> 30, right -> 31
node(24,29,4,1).
left_node(24,29,30).
right_node(24,29,31).
% node 30 (leaf): class twelve (13)
leaf_class(24,30,13).
% node 31: f3 <= 3.5  (F3, bin <= 2)  left -> 32, right -> 33
node(24,31,3,2).
left_node(24,31,32).
right_node(24,31,33).
% node 32 (leaf): class fourteen (15)
leaf_class(24,32,15).
% node 33 (leaf): class thirteen (14)
leaf_class(24,33,14).
% node 34 (leaf): class thirteen (14)
leaf_class(24,34,14).
% node 35: f3 <= 5.5  (F3, bin <= 4)  left -> 36, right -> 37
node(24,35,3,4).
left_node(24,35,36).
right_node(24,35,37).
% node 36 (leaf): class twelve (13)
leaf_class(24,36,13).
% node 37: f5 <= 2.5  (F5, bin <= 1)  left -> 38, right -> 41
node(24,37,5,1).
left_node(24,37,38).
right_node(24,37,41).
% node 38: f4 <= 2.0  (F4, bin <= 2)  left -> 39, right -> 40
node(24,38,4,2).
left_node(24,38,39).
right_node(24,38,40).
% node 39 (leaf): class five (6)
leaf_class(24,39,6).
% node 40 (leaf): class ten (11)
leaf_class(24,40,11).
% node 41: f5 <= 6.5  (F5, bin <= 4)  left -> 42, right -> 43
node(24,41,5,4).
left_node(24,41,42).
right_node(24,41,43).
% node 42 (leaf): class thirteen (14)
leaf_class(24,42,14).
% node 43: f3 <= 6.5  (F3, bin <= 5)  left -> 44, right -> 45
node(24,43,3,5).
left_node(24,43,44).
right_node(24,43,45).
% node 44 (leaf): class twelve (13)
leaf_class(24,44,13).
% node 45 (leaf): class draw (0)
leaf_class(24,45,0).
% node 46: f4 <= 6.5  (F4, bin <= 8)  left -> 47, right -> 68
node(24,46,4,8).
left_node(24,46,47).
right_node(24,46,68).
% node 47: f5 <= 2.5  (F5, bin <= 1)  left -> 48, right -> 57
node(24,47,5,1).
left_node(24,47,48).
right_node(24,47,57).
% node 48: f0 <= 2.5  (F0, bin <= 2)  left -> 49, right -> 50
node(24,48,0,2).
left_node(24,48,49).
right_node(24,48,50).
% node 49 (leaf): class ten (11)
leaf_class(24,49,11).
% node 50: f3 <= 2.5  (F3, bin <= 1)  left -> 51, right -> 52
node(24,50,3,1).
left_node(24,50,51).
right_node(24,50,52).
% node 51 (leaf): class draw (0)
leaf_class(24,51,0).
% node 52: f1 <= 3.5  (F1, bin <= 2)  left -> 53, right -> 54
node(24,52,1,2).
left_node(24,52,53).
right_node(24,52,54).
% node 53 (leaf): class eight (9)
leaf_class(24,53,9).
% node 54: f4 <= 3.5  (F4, bin <= 5)  left -> 55, right -> 56
node(24,54,4,5).
left_node(24,54,55).
right_node(24,54,56).
% node 55 (leaf): class eight (9)
leaf_class(24,55,9).
% node 56 (leaf): class nine (10)
leaf_class(24,56,10).
% node 57: f0 <= 2.5  (F0, bin <= 2)  left -> 58, right -> 61
node(24,57,0,2).
left_node(24,57,58).
right_node(24,57,61).
% node 58: f4 <= 5.5  (F4, bin <= 7)  left -> 59, right -> 60
node(24,58,4,7).
left_node(24,58,59).
right_node(24,58,60).
% node 59 (leaf): class thirteen (14)
leaf_class(24,59,14).
% node 60 (leaf): class twelve (13)
leaf_class(24,60,13).
% node 61: f5 <= 3.5  (F5, bin <= 2)  left -> 62, right -> 63
node(24,61,5,2).
left_node(24,61,62).
right_node(24,61,63).
% node 62 (leaf): class ten (11)
leaf_class(24,62,11).
% node 63: f4 <= 1.5  (F4, bin <= 1)  left -> 64, right -> 65
node(24,63,4,1).
left_node(24,63,64).
right_node(24,63,65).
% node 64 (leaf): class ten (11)
leaf_class(24,64,11).
% node 65: f1 <= 3.5  (F1, bin <= 2)  left -> 66, right -> 67
node(24,65,1,2).
left_node(24,65,66).
right_node(24,65,67).
% node 66 (leaf): class twelve (13)
leaf_class(24,66,13).
% node 67 (leaf): class eleven (12)
leaf_class(24,67,12).
% node 68: f5 <= 2.5  (F5, bin <= 1)  left -> 69, right -> 70
node(24,68,5,1).
left_node(24,68,69).
right_node(24,68,70).
% node 69 (leaf): class eight (9)
leaf_class(24,69,9).
% node 70: f2 <= 5.5  (F2, bin <= 5)  left -> 71, right -> 76
node(24,70,2,5).
left_node(24,70,71).
right_node(24,70,76).
% node 71: f2 <= 3.5  (F2, bin <= 3)  left -> 72, right -> 75
node(24,71,2,3).
left_node(24,71,72).
right_node(24,71,75).
% node 72: f0 <= 2.5  (F0, bin <= 2)  left -> 73, right -> 74
node(24,72,0,2).
left_node(24,72,73).
right_node(24,72,74).
% node 73 (leaf): class eleven (12)
leaf_class(24,73,12).
% node 74 (leaf): class nine (10)
leaf_class(24,74,10).
% node 75 (leaf): class ten (11)
leaf_class(24,75,11).
% node 76 (leaf): class draw (0)
leaf_class(24,76,0).

% Tree 25
tree(25).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 16
node(25,0,0,1).
left_node(25,0,1).
right_node(25,0,16).
% node 1: f4 <= 6.5  (F4, bin <= 8)  left -> 2, right -> 13
node(25,1,4,8).
left_node(25,1,2).
right_node(25,1,13).
% node 2: f4 <= 0.5  (F4, bin <= 0)  left -> 3, right -> 4
node(25,2,4,0).
left_node(25,2,3).
right_node(25,2,4).
% node 3 (leaf): class eleven (12)
leaf_class(25,3,12).
% node 4: f5 <= 1.5  (F5, bin <= 0)  left -> 5, right -> 6
node(25,4,5,0).
left_node(25,4,5).
right_node(25,4,6).
% node 5 (leaf): class ten (11)
leaf_class(25,5,11).
% node 6: f0 <= 0.5  (F0, bin <= 0)  left -> 7, right -> 12
node(25,6,0,0).
left_node(25,6,7).
right_node(25,6,12).
% node 7: f5 <= 2.5  (F5, bin <= 1)  left -> 8, right -> 9
node(25,7,5,1).
left_node(25,7,8).
right_node(25,7,9).
% node 8 (leaf): class fourteen (15)
leaf_class(25,8,15).
% node 9: f3 <= 1.5  (F3, bin <= 0)  left -> 10, right -> 11
node(25,9,3,0).
left_node(25,9,10).
right_node(25,9,11).
% node 10 (leaf): class fifteen (16)
leaf_class(25,10,16).
% node 11 (leaf): class sixteen (17)
leaf_class(25,11,17).
% node 12 (leaf): class fourteen (15)
leaf_class(25,12,15).
% node 13: f2 <= 5.5  (F2, bin <= 5)  left -> 14, right -> 15
node(25,13,2,5).
left_node(25,13,14).
right_node(25,13,15).
% node 14 (leaf): class thirteen (14)
leaf_class(25,14,14).
% node 15 (leaf): class draw (0)
leaf_class(25,15,0).
% node 16: f1 <= 1.5  (F1, bin <= 0)  left -> 17, right -> 38
node(25,16,1,0).
left_node(25,16,17).
right_node(25,16,38).
% node 17: f2 <= 0.5  (F2, bin <= 0)  left -> 18, right -> 19
node(25,17,2,0).
left_node(25,17,18).
right_node(25,17,19).
% node 18 (leaf): class fourteen (15)
leaf_class(25,18,15).
% node 19: f5 <= 2.5  (F5, bin <= 1)  left -> 20, right -> 27
node(25,19,5,1).
left_node(25,19,20).
right_node(25,19,27).
% node 20: f5 <= 1.5  (F5, bin <= 0)  left -> 21, right -> 26
node(25,20,5,0).
left_node(25,20,21).
right_node(25,20,26).
% node 21: f4 <= 2.5  (F4, bin <= 3)  left -> 22, right -> 25
node(25,21,4,3).
left_node(25,21,22).
right_node(25,21,25).
% node 22: f0 <= 2.5  (F0, bin <= 2)  left -> 23, right -> 24
node(25,22,0,2).
left_node(25,22,23).
right_node(25,22,24).
% node 23 (leaf): class two (3)
leaf_class(25,23,3).
% node 24 (leaf): class five (6)
leaf_class(25,24,6).
% node 25 (leaf): class eight (9)
leaf_class(25,25,9).
% node 26 (leaf): class eleven (12)
leaf_class(25,26,12).
% node 27: f0 <= 2.5  (F0, bin <= 2)  left -> 28, right -> 33
node(25,27,0,2).
left_node(25,27,28).
right_node(25,27,33).
% node 28: f4 <= 6.5  (F4, bin <= 8)  left -> 29, right -> 32
node(25,28,4,8).
left_node(25,28,29).
right_node(25,28,32).
% node 29: f4 <= 1.5  (F4, bin <= 1)  left -> 30, right -> 31
node(25,29,4,1).
left_node(25,29,30).
right_node(25,29,31).
% node 30 (leaf): class thirteen (14)
leaf_class(25,30,14).
% node 31 (leaf): class fourteen (15)
leaf_class(25,31,15).
% node 32 (leaf): class twelve (13)
leaf_class(25,32,13).
% node 33: f4 <= 0.5  (F4, bin <= 0)  left -> 34, right -> 35
node(25,33,4,0).
left_node(25,33,34).
right_node(25,33,35).
% node 34 (leaf): class twelve (13)
leaf_class(25,34,13).
% node 35: f4 <= 6.5  (F4, bin <= 8)  left -> 36, right -> 37
node(25,35,4,8).
left_node(25,35,36).
right_node(25,35,37).
% node 36 (leaf): class fourteen (15)
leaf_class(25,36,15).
% node 37 (leaf): class twelve (13)
leaf_class(25,37,13).
% node 38: f3 <= 3.5  (F3, bin <= 2)  left -> 39, right -> 52
node(25,38,3,2).
left_node(25,38,39).
right_node(25,38,52).
% node 39: f4 <= 6.5  (F4, bin <= 8)  left -> 40, right -> 49
node(25,39,4,8).
left_node(25,39,40).
right_node(25,39,49).
% node 40: f1 <= 2.5  (F1, bin <= 1)  left -> 41, right -> 48
node(25,40,1,1).
left_node(25,40,41).
right_node(25,40,48).
% node 41: f0 <= 2.5  (F0, bin <= 2)  left -> 42, right -> 45
node(25,41,0,2).
left_node(25,41,42).
right_node(25,41,45).
% node 42: f5 <= 5.5  (F5, bin <= 3)  left -> 43, right -> 44
node(25,42,5,3).
left_node(25,42,43).
right_node(25,42,44).
% node 43 (leaf): class fourteen (15)
leaf_class(25,43,15).
% node 44 (leaf): class thirteen (14)
leaf_class(25,44,14).
% node 45: f4 <= 0.5  (F4, bin <= 0)  left -> 46, right -> 47
node(25,45,4,0).
left_node(25,45,46).
right_node(25,45,47).
% node 46 (leaf): class eleven (12)
leaf_class(25,46,12).
% node 47 (leaf): class thirteen (14)
leaf_class(25,47,14).
% node 48 (leaf): class twelve (13)
leaf_class(25,48,13).
% node 49: f1 <= 3.5  (F1, bin <= 2)  left -> 50, right -> 51
node(25,49,1,2).
left_node(25,49,50).
right_node(25,49,51).
% node 50 (leaf): class eleven (12)
leaf_class(25,50,12).
% node 51 (leaf): class nine (10)
leaf_class(25,51,10).
% node 52: f4 <= 5.5  (F4, bin <= 7)  left -> 53, right -> 64
node(25,52,4,7).
left_node(25,52,53).
right_node(25,52,64).
% node 53: f0 <= 2.5  (F0, bin <= 2)  left -> 54, right -> 61
node(25,53,0,2).
left_node(25,53,54).
right_node(25,53,61).
% node 54: f1 <= 2.5  (F1, bin <= 1)  left -> 55, right -> 58
node(25,54,1,1).
left_node(25,54,55).
right_node(25,54,58).
% node 55: f3 <= 5.5  (F3, bin <= 4)  left -> 56, right -> 57
node(25,55,3,4).
left_node(25,55,56).
right_node(25,55,57).
% node 56 (leaf): class thirteen (14)
leaf_class(25,56,14).
% node 57 (leaf): class fourteen (15)
leaf_class(25,57,15).
% node 58: f5 <= 2.5  (F5, bin <= 1)  left -> 59, right -> 60
node(25,58,5,1).
left_node(25,58,59).
right_node(25,58,60).
% node 59 (leaf): class ten (11)
leaf_class(25,59,11).
% node 60 (leaf): class thirteen (14)
leaf_class(25,60,14).
% node 61: f4 <= 1.5  (F4, bin <= 1)  left -> 62, right -> 63
node(25,61,4,1).
left_node(25,61,62).
right_node(25,61,63).
% node 62 (leaf): class five (6)
leaf_class(25,62,6).
% node 63 (leaf): class thirteen (14)
leaf_class(25,63,14).
% node 64: f2 <= 4.5  (F2, bin <= 4)  left -> 65, right -> 72
node(25,64,2,4).
left_node(25,64,65).
right_node(25,64,72).
% node 65: f3 <= 5.5  (F3, bin <= 4)  left -> 66, right -> 69
node(25,65,3,4).
left_node(25,65,66).
right_node(25,65,69).
% node 66: f5 <= 3.5  (F5, bin <= 2)  left -> 67, right -> 68
node(25,66,5,2).
left_node(25,66,67).
right_node(25,66,68).
% node 67 (leaf): class eight (9)
leaf_class(25,67,9).
% node 68 (leaf): class twelve (13)
leaf_class(25,68,13).
% node 69: f5 <= 2.5  (F5, bin <= 1)  left -> 70, right -> 71
node(25,69,5,1).
left_node(25,69,70).
right_node(25,69,71).
% node 70 (leaf): class eight (9)
leaf_class(25,70,9).
% node 71 (leaf): class twelve (13)
leaf_class(25,71,13).
% node 72: f5 <= 2.5  (F5, bin <= 1)  left -> 73, right -> 74
node(25,72,5,1).
left_node(25,72,73).
right_node(25,72,74).
% node 73 (leaf): class eight (9)
leaf_class(25,73,9).
% node 74: f2 <= 5.5  (F2, bin <= 5)  left -> 75, right -> 76
node(25,74,2,5).
left_node(25,74,75).
right_node(25,74,76).
% node 75 (leaf): class nine (10)
leaf_class(25,75,10).
% node 76 (leaf): class draw (0)
leaf_class(25,76,0).

% Tree 26
tree(26).
% node 0: f5 <= 2.5  (F5, bin <= 1)  left -> 1, right -> 40
node(26,0,5,1).
left_node(26,0,1).
right_node(26,0,40).
% node 1: f0 <= 2.5  (F0, bin <= 2)  left -> 2, right -> 23
node(26,1,0,2).
left_node(26,1,2).
right_node(26,1,23).
% node 2: f5 <= 1.5  (F5, bin <= 0)  left -> 3, right -> 14
node(26,2,5,0).
left_node(26,2,3).
right_node(26,2,14).
% node 3: f3 <= 2.5  (F3, bin <= 1)  left -> 4, right -> 5
node(26,3,3,1).
left_node(26,3,4).
right_node(26,3,5).
% node 4 (leaf): class draw (0)
leaf_class(26,4,0).
% node 5: f4 <= 2.5  (F4, bin <= 3)  left -> 6, right -> 7
node(26,5,4,3).
left_node(26,5,6).
right_node(26,5,7).
% node 6 (leaf): class two (3)
leaf_class(26,6,3).
% node 7: f4 <= 5.5  (F4, bin <= 7)  left -> 8, right -> 11
node(26,7,4,7).
left_node(26,7,8).
right_node(26,7,11).
% node 8: f0 <= 1.5  (F0, bin <= 1)  left -> 9, right -> 10
node(26,8,0,1).
left_node(26,8,9).
right_node(26,8,10).
% node 9 (leaf): class ten (11)
leaf_class(26,9,11).
% node 10 (leaf): class eight (9)
leaf_class(26,10,9).
% node 11: f0 <= 1.5  (F0, bin <= 1)  left -> 12, right -> 13
node(26,11,0,1).
left_node(26,11,12).
right_node(26,11,13).
% node 12 (leaf): class nine (10)
leaf_class(26,12,10).
% node 13 (leaf): class eight (9)
leaf_class(26,13,9).
% node 14: f1 <= 2.5  (F1, bin <= 1)  left -> 15, right -> 22
node(26,14,1,1).
left_node(26,14,15).
right_node(26,14,22).
% node 15: f3 <= 3.5  (F3, bin <= 2)  left -> 16, right -> 17
node(26,15,3,2).
left_node(26,15,16).
right_node(26,15,17).
% node 16 (leaf): class draw (0)
leaf_class(26,16,0).
% node 17: f0 <= 1.5  (F0, bin <= 1)  left -> 18, right -> 21
node(26,17,0,1).
left_node(26,17,18).
right_node(26,17,21).
% node 18: f4 <= 5.5  (F4, bin <= 7)  left -> 19, right -> 20
node(26,18,4,7).
left_node(26,18,19).
right_node(26,18,20).
% node 19 (leaf): class fourteen (15)
leaf_class(26,19,15).
% node 20 (leaf): class eleven (12)
leaf_class(26,20,12).
% node 21 (leaf): class ten (11)
leaf_class(26,21,11).
% node 22 (leaf): class ten (11)
leaf_class(26,22,11).
% node 23: f1 <= 3.5  (F1, bin <= 2)  left -> 24, right -> 37
node(26,23,1,2).
left_node(26,23,24).
right_node(26,23,37).
% node 24: f5 <= 1.5  (F5, bin <= 0)  left -> 25, right -> 32
node(26,24,5,0).
left_node(26,24,25).
right_node(26,24,32).
% node 25: f4 <= 3.5  (F4, bin <= 5)  left -> 26, right -> 27
node(26,25,4,5).
left_node(26,25,26).
right_node(26,25,27).
% node 26 (leaf): class five (6)
leaf_class(26,26,6).
% node 27: f3 <= 2.5  (F3, bin <= 1)  left -> 28, right -> 29
node(26,27,3,1).
left_node(26,27,28).
right_node(26,27,29).
% node 28 (leaf): class draw (0)
leaf_class(26,28,0).
% node 29: f1 <= 2.5  (F1, bin <= 1)  left -> 30, right -> 31
node(26,29,1,1).
left_node(26,29,30).
right_node(26,29,31).
% node 30 (leaf): class six (7)
leaf_class(26,30,7).
% node 31 (leaf): class eight (9)
leaf_class(26,31,9).
% node 32: f4 <= 3.0  (F4, bin <= 4)  left -> 33, right -> 36
node(26,32,4,4).
left_node(26,32,33).
right_node(26,32,36).
% node 33: f1 <= 2.5  (F1, bin <= 1)  left -> 34, right -> 35
node(26,33,1,1).
left_node(26,33,34).
right_node(26,33,35).
% node 34 (leaf): class five (6)
leaf_class(26,34,6).
% node 35 (leaf): class six (7)
leaf_class(26,35,7).
% node 36 (leaf): class eight (9)
leaf_class(26,36,9).
% node 37: f3 <= 2.5  (F3, bin <= 1)  left -> 38, right -> 39
node(26,37,3,1).
left_node(26,37,38).
right_node(26,37,39).
% node 38 (leaf): class draw (0)
leaf_class(26,38,0).
% node 39 (leaf): class eight (9)
leaf_class(26,39,9).
% node 40: f4 <= 0.5  (F4, bin <= 0)  left -> 41, right -> 44
node(26,40,4,0).
left_node(26,40,41).
right_node(26,40,44).
% node 41: f1 <= 1.5  (F1, bin <= 0)  left -> 42, right -> 43
node(26,41,1,0).
left_node(26,41,42).
right_node(26,41,43).
% node 42 (leaf): class twelve (13)
leaf_class(26,42,13).
% node 43 (leaf): class ten (11)
leaf_class(26,43,11).
% node 44: f0 <= 1.5  (F0, bin <= 1)  left -> 45, right -> 52
node(26,44,0,1).
left_node(26,44,45).
right_node(26,44,52).
% node 45: f5 <= 6.5  (F5, bin <= 4)  left -> 46, right -> 51
node(26,45,5,4).
left_node(26,45,46).
right_node(26,45,51).
% node 46: f1 <= 1.5  (F1, bin <= 0)  left -> 47, right -> 50
node(26,46,1,0).
left_node(26,46,47).
right_node(26,46,50).
% node 47: f4 <= 6.5  (F4, bin <= 8)  left -> 48, right -> 49
node(26,47,4,8).
left_node(26,47,48).
right_node(26,47,49).
% node 48 (leaf): class fifteen (16)
leaf_class(26,48,16).
% node 49 (leaf): class fourteen (15)
leaf_class(26,49,15).
% node 50 (leaf): class fourteen (15)
leaf_class(26,50,15).
% node 51 (leaf): class fourteen (15)
leaf_class(26,51,15).
% node 52: f0 <= 2.5  (F0, bin <= 2)  left -> 53, right -> 62
node(26,52,0,2).
left_node(26,52,53).
right_node(26,52,62).
% node 53: f1 <= 1.5  (F1, bin <= 0)  left -> 54, right -> 57
node(26,53,1,0).
left_node(26,53,54).
right_node(26,53,57).
% node 54: f3 <= 5.5  (F3, bin <= 4)  left -> 55, right -> 56
node(26,54,3,4).
left_node(26,54,55).
right_node(26,54,56).
% node 55 (leaf): class fourteen (15)
leaf_class(26,55,15).
% node 56 (leaf): class fourteen (15)
leaf_class(26,56,15).
% node 57: f5 <= 5.5  (F5, bin <= 3)  left -> 58, right -> 61
node(26,57,5,3).
left_node(26,57,58).
right_node(26,57,61).
% node 58: f4 <= 5.5  (F4, bin <= 7)  left -> 59, right -> 60
node(26,58,4,7).
left_node(26,58,59).
right_node(26,58,60).
% node 59 (leaf): class fourteen (15)
leaf_class(26,59,15).
% node 60 (leaf): class twelve (13)
leaf_class(26,60,13).
% node 61 (leaf): class thirteen (14)
leaf_class(26,61,14).
% node 62: f3 <= 3.5  (F3, bin <= 2)  left -> 63, right -> 68
node(26,62,3,2).
left_node(26,62,63).
right_node(26,62,68).
% node 63: f4 <= 5.5  (F4, bin <= 7)  left -> 64, right -> 65
node(26,63,4,7).
left_node(26,63,64).
right_node(26,63,65).
% node 64 (leaf): class fourteen (15)
leaf_class(26,64,15).
% node 65: f1 <= 2.5  (F1, bin <= 1)  left -> 66, right -> 67
node(26,65,1,1).
left_node(26,65,66).
right_node(26,65,67).
% node 66 (leaf): class twelve (13)
leaf_class(26,66,13).
% node 67 (leaf): class eleven (12)
leaf_class(26,67,12).
% node 68: f4 <= 6.5  (F4, bin <= 8)  left -> 69, right -> 72
node(26,68,4,8).
left_node(26,68,69).
right_node(26,68,72).
% node 69: f1 <= 2.5  (F1, bin <= 1)  left -> 70, right -> 71
node(26,69,1,1).
left_node(26,69,70).
right_node(26,69,71).
% node 70 (leaf): class fourteen (15)
leaf_class(26,70,15).
% node 71 (leaf): class eleven (12)
leaf_class(26,71,12).
% node 72: f2 <= 5.5  (F2, bin <= 5)  left -> 73, right -> 74
node(26,72,2,5).
left_node(26,72,73).
right_node(26,72,74).
% node 73 (leaf): class nine (10)
leaf_class(26,73,10).
% node 74 (leaf): class draw (0)
leaf_class(26,74,0).

% Tree 27
tree(27).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 64
node(27,0,4,8).
left_node(27,0,1).
right_node(27,0,64).
% node 1: f5 <= 2.5  (F5, bin <= 1)  left -> 2, right -> 25
node(27,1,5,1).
left_node(27,1,2).
right_node(27,1,25).
% node 2: f0 <= 2.5  (F0, bin <= 2)  left -> 3, right -> 12
node(27,2,0,2).
left_node(27,2,3).
right_node(27,2,12).
% node 3: f4 <= 1.5  (F4, bin <= 1)  left -> 4, right -> 5
node(27,3,4,1).
left_node(27,3,4).
right_node(27,3,5).
% node 4 (leaf): class two (3)
leaf_class(27,4,3).
% node 5: f0 <= 1.5  (F0, bin <= 1)  left -> 6, right -> 11
node(27,5,0,1).
left_node(27,5,6).
right_node(27,5,11).
% node 6: f2 <= 2.5  (F2, bin <= 2)  left -> 7, right -> 8
node(27,6,2,2).
left_node(27,6,7).
right_node(27,6,8).
% node 7 (leaf): class ten (11)
leaf_class(27,7,11).
% node 8: f3 <= 3.5  (F3, bin <= 2)  left -> 9, right -> 10
node(27,8,3,2).
left_node(27,8,9).
right_node(27,8,10).
% node 9 (leaf): class draw (0)
leaf_class(27,9,0).
% node 10 (leaf): class thirteen (14)
leaf_class(27,10,14).
% node 11 (leaf): class ten (11)
leaf_class(27,11,11).
% node 12: f1 <= 3.5  (F1, bin <= 2)  left -> 13, right -> 20
node(27,12,1,2).
left_node(27,12,13).
right_node(27,12,20).
% node 13: f5 <= 1.5  (F5, bin <= 0)  left -> 14, right -> 19
node(27,13,5,0).
left_node(27,13,14).
right_node(27,13,19).
% node 14: f3 <= 3.5  (F3, bin <= 2)  left -> 15, right -> 16
node(27,14,3,2).
left_node(27,14,15).
right_node(27,14,16).
% node 15 (leaf): class four (5)
leaf_class(27,15,5).
% node 16: f4 <= 2.5  (F4, bin <= 3)  left -> 17, right -> 18
node(27,16,4,3).
left_node(27,16,17).
right_node(27,16,18).
% node 17 (leaf): class five (6)
leaf_class(27,17,6).
% node 18 (leaf): class eight (9)
leaf_class(27,18,9).
% node 19 (leaf): class eight (9)
leaf_class(27,19,9).
% node 20: f4 <= 3.5  (F4, bin <= 5)  left -> 21, right -> 22
node(27,20,4,5).
left_node(27,20,21).
right_node(27,20,22).
% node 21 (leaf): class eight (9)
leaf_class(27,21,9).
% node 22: f5 <= 1.5  (F5, bin <= 0)  left -> 23, right -> 24
node(27,22,5,0).
left_node(27,22,23).
right_node(27,22,24).
% node 23 (leaf): class nine (10)
leaf_class(27,23,10).
% node 24 (leaf): class ten (11)
leaf_class(27,24,11).
% node 25: f3 <= 3.5  (F3, bin <= 2)  left -> 26, right -> 43
node(27,25,3,2).
left_node(27,25,26).
right_node(27,25,43).
% node 26: f0 <= 1.5  (F0, bin <= 1)  left -> 27, right -> 34
node(27,26,0,1).
left_node(27,26,27).
right_node(27,26,34).
% node 27: f0 <= 0.5  (F0, bin <= 0)  left -> 28, right -> 29
node(27,27,0,0).
left_node(27,27,28).
right_node(27,27,29).
% node 28 (leaf): class fifteen (16)
leaf_class(27,28,16).
% node 29: f1 <= 1.5  (F1, bin <= 0)  left -> 30, right -> 33
node(27,29,1,0).
left_node(27,29,30).
right_node(27,29,33).
% node 30: f5 <= 6.5  (F5, bin <= 4)  left -> 31, right -> 32
node(27,30,5,4).
left_node(27,30,31).
right_node(27,30,32).
% node 31 (leaf): class fifteen (16)
leaf_class(27,31,16).
% node 32 (leaf): class fourteen (15)
leaf_class(27,32,15).
% node 33 (leaf): class fourteen (15)
leaf_class(27,33,15).
% node 34: f2 <= 2.5  (F2, bin <= 2)  left -> 35, right -> 42
node(27,34,2,2).
left_node(27,34,35).
right_node(27,34,42).
% node 35: f5 <= 5.5  (F5, bin <= 3)  left -> 36, right -> 39
node(27,35,5,3).
left_node(27,35,36).
right_node(27,35,39).
% node 36: f4 <= 1.5  (F4, bin <= 1)  left -> 37, right -> 38
node(27,36,4,1).
left_node(27,36,37).
right_node(27,36,38).
% node 37 (leaf): class draw (0)
leaf_class(27,37,0).
% node 38 (leaf): class fourteen (15)
leaf_class(27,38,15).
% node 39: f1 <= 1.5  (F1, bin <= 0)  left -> 40, right -> 41
node(27,39,1,0).
left_node(27,39,40).
right_node(27,39,41).
% node 40 (leaf): class fourteen (15)
leaf_class(27,40,15).
% node 41 (leaf): class thirteen (14)
leaf_class(27,41,14).
% node 42 (leaf): class thirteen (14)
leaf_class(27,42,14).
% node 43: f3 <= 5.5  (F3, bin <= 4)  left -> 44, right -> 53
node(27,43,3,4).
left_node(27,43,44).
right_node(27,43,53).
% node 44: f0 <= 1.5  (F0, bin <= 1)  left -> 45, right -> 48
node(27,44,0,1).
left_node(27,44,45).
right_node(27,44,48).
% node 45: f5 <= 5.5  (F5, bin <= 3)  left -> 46, right -> 47
node(27,45,5,3).
left_node(27,45,46).
right_node(27,45,47).
% node 46 (leaf): class draw (0)
leaf_class(27,46,0).
% node 47 (leaf): class fourteen (15)
leaf_class(27,47,15).
% node 48: f0 <= 2.5  (F0, bin <= 2)  left -> 49, right -> 50
node(27,48,0,2).
left_node(27,48,49).
right_node(27,48,50).
% node 49 (leaf): class thirteen (14)
leaf_class(27,49,14).
% node 50: f1 <= 1.5  (F1, bin <= 0)  left -> 51, right -> 52
node(27,50,1,0).
left_node(27,50,51).
right_node(27,50,52).
% node 51 (leaf): class fourteen (15)
leaf_class(27,51,15).
% node 52 (leaf): class eleven (12)
leaf_class(27,52,12).
% node 53: f0 <= 1.5  (F0, bin <= 1)  left -> 54, right -> 59
node(27,53,0,1).
left_node(27,53,54).
right_node(27,53,59).
% node 54: f0 <= 0.5  (F0, bin <= 0)  left -> 55, right -> 56
node(27,54,0,0).
left_node(27,54,55).
right_node(27,54,56).
% node 55 (leaf): class sixteen (17)
leaf_class(27,55,17).
% node 56: f5 <= 5.5  (F5, bin <= 3)  left -> 57, right -> 58
node(27,56,5,3).
left_node(27,56,57).
right_node(27,56,58).
% node 57 (leaf): class fifteen (16)
leaf_class(27,57,16).
% node 58 (leaf): class draw (0)
leaf_class(27,58,0).
% node 59: f5 <= 5.5  (F5, bin <= 3)  left -> 60, right -> 63
node(27,59,5,3).
left_node(27,59,60).
right_node(27,59,63).
% node 60: f1 <= 1.5  (F1, bin <= 0)  left -> 61, right -> 62
node(27,60,1,0).
left_node(27,60,61).
right_node(27,60,62).
% node 61 (leaf): class fourteen (15)
leaf_class(27,61,15).
% node 62 (leaf): class thirteen (14)
leaf_class(27,62,14).
% node 63 (leaf): class draw (0)
leaf_class(27,63,0).
% node 64: f2 <= 5.5  (F2, bin <= 5)  left -> 65, right -> 80
node(27,64,2,5).
left_node(27,64,65).
right_node(27,64,80).
% node 65: f2 <= 4.5  (F2, bin <= 4)  left -> 66, right -> 77
node(27,65,2,4).
left_node(27,65,66).
right_node(27,65,77).
% node 66: f1 <= 2.5  (F1, bin <= 1)  left -> 67, right -> 68
node(27,66,1,1).
left_node(27,66,67).
right_node(27,66,68).
% node 67 (leaf): class thirteen (14)
leaf_class(27,67,14).
% node 68: f2 <= 3.5  (F2, bin <= 3)  left -> 69, right -> 76
node(27,68,2,3).
left_node(27,68,69).
right_node(27,68,76).
% node 69: f0 <= 2.5  (F0, bin <= 2)  left -> 70, right -> 73
node(27,69,0,2).
left_node(27,69,70).
right_node(27,69,73).
% node 70: f5 <= 2.5  (F5, bin <= 1)  left -> 71, right -> 72
node(27,70,5,1).
left_node(27,70,71).
right_node(27,70,72).
% node 71 (leaf): class nine (10)
leaf_class(27,71,10).
% node 72 (leaf): class eleven (12)
leaf_class(27,72,12).
% node 73: f5 <= 2.5  (F5, bin <= 1)  left -> 74, right -> 75
node(27,73,5,1).
left_node(27,73,74).
right_node(27,73,75).
% node 74 (leaf): class eight (9)
leaf_class(27,74,9).
% node 75 (leaf): class nine (10)
leaf_class(27,75,10).
% node 76 (leaf): class nine (10)
leaf_class(27,76,10).
% node 77: f0 <= 1.5  (F0, bin <= 1)  left -> 78, right -> 79
node(27,77,0,1).
left_node(27,77,78).
right_node(27,77,79).
% node 78 (leaf): class twelve (13)
leaf_class(27,78,13).
% node 79 (leaf): class eleven (12)
leaf_class(27,79,12).
% node 80 (leaf): class draw (0)
leaf_class(27,80,0).

% Tree 28
tree(28).
% node 0: f0 <= 1.5  (F0, bin <= 1)  left -> 1, right -> 24
node(28,0,0,1).
left_node(28,0,1).
right_node(28,0,24).
% node 1: f1 <= 1.5  (F1, bin <= 0)  left -> 2, right -> 19
node(28,1,1,0).
left_node(28,1,2).
right_node(28,1,19).
% node 2: f5 <= 6.5  (F5, bin <= 4)  left -> 3, right -> 18
node(28,2,5,4).
left_node(28,2,3).
right_node(28,2,18).
% node 3: f0 <= 0.5  (F0, bin <= 0)  left -> 4, right -> 11
node(28,3,0,0).
left_node(28,3,4).
right_node(28,3,11).
% node 4: f5 <= 2.5  (F5, bin <= 1)  left -> 5, right -> 8
node(28,4,5,1).
left_node(28,4,5).
right_node(28,4,8).
% node 5: f3 <= 3.5  (F3, bin <= 2)  left -> 6, right -> 7
node(28,5,3,2).
left_node(28,5,6).
right_node(28,5,7).
% node 6 (leaf): class draw (0)
leaf_class(28,6,0).
% node 7 (leaf): class fourteen (15)
leaf_class(28,7,15).
% node 8: f4 <= 6.5  (F4, bin <= 8)  left -> 9, right -> 10
node(28,8,4,8).
left_node(28,8,9).
right_node(28,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(28,9,16).
% node 10 (leaf): class fourteen (15)
leaf_class(28,10,15).
% node 11: f2 <= 0.5  (F2, bin <= 0)  left -> 12, right -> 13
node(28,11,2,0).
left_node(28,11,12).
right_node(28,11,13).
% node 12 (leaf): class fourteen (15)
leaf_class(28,12,15).
% node 13: f4 <= 5.5  (F4, bin <= 7)  left -> 14, right -> 17
node(28,13,4,7).
left_node(28,13,14).
right_node(28,13,17).
% node 14: f4 <= 1.5  (F4, bin <= 1)  left -> 15, right -> 16
node(28,14,4,1).
left_node(28,14,15).
right_node(28,14,16).
% node 15 (leaf): class thirteen (14)
leaf_class(28,15,14).
% node 16 (leaf): class fifteen (16)
leaf_class(28,16,16).
% node 17 (leaf): class fourteen (15)
leaf_class(28,17,15).
% node 18 (leaf): class fourteen (15)
leaf_class(28,18,15).
% node 19: f4 <= 6.5  (F4, bin <= 8)  left -> 20, right -> 21
node(28,19,4,8).
left_node(28,19,20).
right_node(28,19,21).
% node 20 (leaf): class fourteen (15)
leaf_class(28,20,15).
% node 21: f5 <= 2.5  (F5, bin <= 1)  left -> 22, right -> 23
node(28,21,5,1).
left_node(28,21,22).
right_node(28,21,23).
% node 22 (leaf): class nine (10)
leaf_class(28,22,10).
% node 23 (leaf): class thirteen (14)
leaf_class(28,23,14).
% node 24: f5 <= 2.5  (F5, bin <= 1)  left -> 25, right -> 42
node(28,24,5,1).
left_node(28,24,25).
right_node(28,24,42).
% node 25: f3 <= 3.5  (F3, bin <= 2)  left -> 26, right -> 35
node(28,25,3,2).
left_node(28,25,26).
right_node(28,25,35).
% node 26: f5 <= 1.5  (F5, bin <= 0)  left -> 27, right -> 30
node(28,26,5,0).
left_node(28,26,27).
right_node(28,26,30).
% node 27: f4 <= 2.5  (F4, bin <= 3)  left -> 28, right -> 29
node(28,27,4,3).
left_node(28,27,28).
right_node(28,27,29).
% node 28 (leaf): class three (4)
leaf_class(28,28,4).
% node 29 (leaf): class draw (0)
leaf_class(28,29,0).
% node 30: f4 <= 1.5  (F4, bin <= 1)  left -> 31, right -> 32
node(28,30,4,1).
left_node(28,30,31).
right_node(28,30,32).
% node 31 (leaf): class draw (0)
leaf_class(28,31,0).
% node 32: f2 <= 3.5  (F2, bin <= 3)  left -> 33, right -> 34
node(28,32,2,3).
left_node(28,32,33).
right_node(28,32,34).
% node 33 (leaf): class ten (11)
leaf_class(28,33,11).
% node 34 (leaf): class draw (0)
leaf_class(28,34,0).
% node 35: f0 <= 2.5  (F0, bin <= 2)  left -> 36, right -> 39
node(28,35,0,2).
left_node(28,35,36).
right_node(28,35,39).
% node 36: f5 <= 1.5  (F5, bin <= 0)  left -> 37, right -> 38
node(28,36,5,0).
left_node(28,36,37).
right_node(28,36,38).
% node 37 (leaf): class nine (10)
leaf_class(28,37,10).
% node 38 (leaf): class ten (11)
leaf_class(28,38,11).
% node 39: f1 <= 3.5  (F1, bin <= 2)  left -> 40, right -> 41
node(28,39,1,2).
left_node(28,39,40).
right_node(28,39,41).
% node 40 (leaf): class eight (9)
leaf_class(28,40,9).
% node 41 (leaf): class eight (9)
leaf_class(28,41,9).
% node 42: f1 <= 1.5  (F1, bin <= 0)  left -> 43, right -> 50
node(28,42,1,0).
left_node(28,42,43).
right_node(28,42,50).
% node 43: f2 <= 0.5  (F2, bin <= 0)  left -> 44, right -> 45
node(28,43,2,0).
left_node(28,43,44).
right_node(28,43,45).
% node 44 (leaf): class fourteen (15)
leaf_class(28,44,15).
% node 45: f5 <= 6.5  (F5, bin <= 4)  left -> 46, right -> 49
node(28,45,5,4).
left_node(28,45,46).
right_node(28,45,49).
% node 46: f2 <= 6.5  (F2, bin <= 6)  left -> 47, right -> 48
node(28,46,2,6).
left_node(28,46,47).
right_node(28,46,48).
% node 47 (leaf): class fourteen (15)
leaf_class(28,47,15).
% node 48 (leaf): class fourteen (15)
leaf_class(28,48,15).
% node 49 (leaf): class fourteen (15)
leaf_class(28,49,15).
% node 50: f4 <= 6.5  (F4, bin <= 8)  left -> 51, right -> 62
node(28,50,4,8).
left_node(28,50,51).
right_node(28,50,62).
% node 51: f0 <= 2.5  (F0, bin <= 2)  left -> 52, right -> 57
node(28,51,0,2).
left_node(28,51,52).
right_node(28,51,57).
% node 52: f4 <= 1.5  (F4, bin <= 1)  left -> 53, right -> 54
node(28,52,4,1).
left_node(28,52,53).
right_node(28,52,54).
% node 53 (leaf): class twelve (13)
leaf_class(28,53,13).
% node 54: f4 <= 5.5  (F4, bin <= 7)  left -> 55, right -> 56
node(28,54,4,7).
left_node(28,54,55).
right_node(28,54,56).
% node 55 (leaf): class thirteen (14)
leaf_class(28,55,14).
% node 56 (leaf): class twelve (13)
leaf_class(28,56,13).
% node 57: f3 <= 3.5  (F3, bin <= 2)  left -> 58, right -> 59
node(28,57,3,2).
left_node(28,57,58).
right_node(28,57,59).
% node 58 (leaf): class twelve (13)
leaf_class(28,58,13).
% node 59: f1 <= 2.5  (F1, bin <= 1)  left -> 60, right -> 61
node(28,59,1,1).
left_node(28,59,60).
right_node(28,59,61).
% node 60 (leaf): class thirteen (14)
leaf_class(28,60,14).
% node 61 (leaf): class eleven (12)
leaf_class(28,61,12).
% node 62: f1 <= 3.5  (F1, bin <= 2)  left -> 63, right -> 66
node(28,62,1,2).
left_node(28,62,63).
right_node(28,62,66).
% node 63: f2 <= 5.5  (F2, bin <= 5)  left -> 64, right -> 65
node(28,63,2,5).
left_node(28,63,64).
right_node(28,63,65).
% node 64 (leaf): class eleven (12)
leaf_class(28,64,12).
% node 65 (leaf): class draw (0)
leaf_class(28,65,0).
% node 66 (leaf): class nine (10)
leaf_class(28,66,10).

% Tree 29
tree(29).
% node 0: f4 <= 6.5  (F4, bin <= 8)  left -> 1, right -> 54
node(29,0,4,8).
left_node(29,0,1).
right_node(29,0,54).
% node 1: f0 <= 1.5  (F0, bin <= 1)  left -> 2, right -> 13
node(29,1,0,1).
left_node(29,1,2).
right_node(29,1,13).
% node 2: f0 <= 0.5  (F0, bin <= 0)  left -> 3, right -> 4
node(29,2,0,0).
left_node(29,2,3).
right_node(29,2,4).
% node 3 (leaf): class fifteen (16)
leaf_class(29,3,16).
% node 4: f1 <= 1.5  (F1, bin <= 0)  left -> 5, right -> 12
node(29,4,1,0).
left_node(29,4,5).
right_node(29,4,12).
% node 5: f3 <= 5.5  (F3, bin <= 4)  left -> 6, right -> 11
node(29,5,3,4).
left_node(29,5,6).
right_node(29,5,11).
% node 6: f4 <= 1.5  (F4, bin <= 1)  left -> 7, right -> 8
node(29,6,4,1).
left_node(29,6,7).
right_node(29,6,8).
% node 7 (leaf): class twelve (13)
leaf_class(29,7,13).
% node 8: f5 <= 6.5  (F5, bin <= 4)  left -> 9, right -> 10
node(29,8,5,4).
left_node(29,8,9).
right_node(29,8,10).
% node 9 (leaf): class fifteen (16)
leaf_class(29,9,16).
% node 10 (leaf): class fourteen (15)
leaf_class(29,10,15).
% node 11 (leaf): class fifteen (16)
leaf_class(29,11,16).
% node 12 (leaf): class fourteen (15)
leaf_class(29,12,15).
% node 13: f0 <= 2.5  (F0, bin <= 2)  left -> 14, right -> 33
node(29,13,0,2).
left_node(29,13,14).
right_node(29,13,33).
% node 14: f1 <= 1.5  (F1, bin <= 0)  left -> 15, right -> 24
node(29,14,1,0).
left_node(29,14,15).
right_node(29,14,24).
% node 15: f5 <= 2.5  (F5, bin <= 1)  left -> 16, right -> 17
node(29,15,5,1).
left_node(29,15,16).
right_node(29,15,17).
% node 16 (leaf): class nine (10)
leaf_class(29,16,10).
% node 17: f5 <= 6.5  (F5, bin <= 4)  left -> 18, right -> 21
node(29,17,5,4).
left_node(29,17,18).
right_node(29,17,21).
% node 18: f2 <= 0.5  (F2, bin <= 0)  left -> 19, right -> 20
node(29,18,2,0).
left_node(29,18,19).
right_node(29,18,20).
% node 19 (leaf): class fourteen (15)
leaf_class(29,19,15).
% node 20 (leaf): class fourteen (15)
leaf_class(29,20,15).
% node 21: f3 <= 5.5  (F3, bin <= 4)  left -> 22, right -> 23
node(29,21,3,4).
left_node(29,21,22).
right_node(29,21,23).
% node 22 (leaf): class fourteen (15)
leaf_class(29,22,15).
% node 23 (leaf): class draw (0)
leaf_class(29,23,0).
% node 24: f3 <= 5.5  (F3, bin <= 4)  left -> 25, right -> 28
node(29,24,3,4).
left_node(29,24,25).
right_node(29,24,28).
% node 25: f4 <= 1.5  (F4, bin <= 1)  left -> 26, right -> 27
node(29,25,4,1).
left_node(29,25,26).
right_node(29,25,27).
% node 26 (leaf): class eleven (12)
leaf_class(29,26,12).
% node 27 (leaf): class thirteen (14)
leaf_class(29,27,14).
% node 28: f4 <= 2.5  (F4, bin <= 3)  left -> 29, right -> 32
node(29,28,4,3).
left_node(29,28,29).
right_node(29,28,32).
% node 29: f5 <= 2.5  (F5, bin <= 1)  left -> 30, right -> 31
node(29,29,5,1).
left_node(29,29,30).
right_node(29,29,31).
% node 30 (leaf): class two (3)
leaf_class(29,30,3).
% node 31 (leaf): class thirteen (14)
leaf_class(29,31,14).
% node 32 (leaf): class fourteen (15)
leaf_class(29,32,15).
% node 33: f5 <= 2.5  (F5, bin <= 1)  left -> 34, right -> 43
node(29,33,5,1).
left_node(29,33,34).
right_node(29,33,43).
% node 34: f2 <= 2.5  (F2, bin <= 2)  left -> 35, right -> 40
node(29,34,2,2).
left_node(29,34,35).
right_node(29,34,40).
% node 35: f5 <= 1.5  (F5, bin <= 0)  left -> 36, right -> 39
node(29,35,5,0).
left_node(29,35,36).
right_node(29,35,39).
% node 36: f1 <= 2.5  (F1, bin <= 1)  left -> 37, right -> 38
node(29,36,1,1).
left_node(29,36,37).
right_node(29,36,38).
% node 37 (leaf): class six (7)
leaf_class(29,37,7).
% node 38 (leaf): class eight (9)
leaf_class(29,38,9).
% node 39 (leaf): class eight (9)
leaf_class(29,39,9).
% node 40: f1 <= 3.5  (F1, bin <= 2)  left -> 41, right -> 42
node(29,40,1,2).
left_node(29,40,41).
right_node(29,40,42).
% node 41 (leaf): class five (6)
leaf_class(29,41,6).
% node 42 (leaf): class eight (9)
leaf_class(29,42,9).
% node 43: f5 <= 3.5  (F5, bin <= 2)  left -> 44, right -> 49
node(29,43,5,2).
left_node(29,43,44).
right_node(29,43,49).
% node 44: f1 <= 2.5  (F1, bin <= 1)  left -> 45, right -> 46
node(29,44,1,1).
left_node(29,44,45).
right_node(29,44,46).
% node 45 (leaf): class fourteen (15)
leaf_class(29,45,15).
% node 46: f1 <= 3.5  (F1, bin <= 2)  left -> 47, right -> 48
node(29,46,1,2).
left_node(29,46,47).
right_node(29,46,48).
% node 47 (leaf): class seven (8)
leaf_class(29,47,8).
% node 48 (leaf): class ten (11)
leaf_class(29,48,11).
% node 49: f4 <= 0.5  (F4, bin <= 0)  left -> 50, right -> 51
node(29,49,4,0).
left_node(29,49,50).
right_node(29,49,51).
% node 50 (leaf): class nine (10)
leaf_class(29,50,10).
% node 51: f1 <= 2.5  (F1, bin <= 1)  left -> 52, right -> 53
node(29,51,1,1).
left_node(29,51,52).
right_node(29,51,53).
% node 52 (leaf): class fourteen (15)
leaf_class(29,52,15).
% node 53 (leaf): class twelve (13)
leaf_class(29,53,13).
% node 54: f2 <= 5.5  (F2, bin <= 5)  left -> 55, right -> 68
node(29,54,2,5).
left_node(29,54,55).
right_node(29,54,68).
% node 55: f1 <= 3.5  (F1, bin <= 2)  left -> 56, right -> 67
node(29,55,1,2).
left_node(29,55,56).
right_node(29,55,67).
% node 56: f5 <= 2.5  (F5, bin <= 1)  left -> 57, right -> 60
node(29,56,5,1).
left_node(29,56,57).
right_node(29,56,60).
% node 57: f0 <= 2.5  (F0, bin <= 2)  left -> 58, right -> 59
node(29,57,0,2).
left_node(29,57,58).
right_node(29,57,59).
% node 58 (leaf): class nine (10)
leaf_class(29,58,10).
% node 59 (leaf): class six (7)
leaf_class(29,59,7).
% node 60: f1 <= 1.5  (F1, bin <= 0)  left -> 61, right -> 64
node(29,60,1,0).
left_node(29,60,61).
right_node(29,60,64).
% node 61: f0 <= 0.5  (F0, bin <= 0)  left -> 62, right -> 63
node(29,61,0,0).
left_node(29,61,62).
right_node(29,61,63).
% node 62 (leaf): class fourteen (15)
leaf_class(29,62,15).
% node 63 (leaf): class thirteen (14)
leaf_class(29,63,14).
% node 64: f0 <= 1.5  (F0, bin <= 1)  left -> 65, right -> 66
node(29,64,0,1).
left_node(29,64,65).
right_node(29,64,66).
% node 65 (leaf): class thirteen (14)
leaf_class(29,65,14).
% node 66 (leaf): class eleven (12)
leaf_class(29,66,12).
% node 67 (leaf): class nine (10)
leaf_class(29,67,10).
% node 68 (leaf): class draw (0)
leaf_class(29,68,0).

% --- Class domain ---
class_idx(0).  % draw
class_idx(1).  % zero
class_idx(2).  % one
class_idx(3).  % two
class_idx(4).  % three
class_idx(5).  % four
class_idx(6).  % five
class_idx(7).  % six
class_idx(8).  % seven
class_idx(9).  % eight
class_idx(10).  % nine
class_idx(11).  % ten
class_idx(12).  % eleven
class_idx(13).  % twelve
class_idx(14).  % thirteen
class_idx(15).  % fourteen
class_idx(16).  % fifteen
class_idx(17).  % sixteen
