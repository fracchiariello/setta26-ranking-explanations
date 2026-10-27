% ============================================================
% random_forest.lp — RF facts for online+shoppers
% 10 trees  |  17 features
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

% Feature 0 (Administrative): 7 bins  (thresholds: [0.5, 1.5, 3.5, 4.5, 5.5, 6.5])
{bin(I,0,B) : B = 0..6} = 1 :- item(I).

% Feature 1 (Administrative_Duration): 6 bins  (thresholds: [2.5, 11.75, 77.75, 100.375, 342.7142791748047])
{bin(I,1,B) : B = 0..5} = 1 :- item(I).

% Feature 2 (Informational): 3 bins  (thresholds: [0.5, 2.5])
{bin(I,2,B) : B = 0..2} = 1 :- item(I).

% Feature 3 (Informational_Duration): 4 bins  (thresholds: [3.5, 78.22916793823242, 104.0])
{bin(I,3,B) : B = 0..3} = 1 :- item(I).

% Feature 4 (ProductRelated): 11 bins  (thresholds: [6.5, 20.5, 22.5, 24.5, 25.5, 33.5, 39.5, 55.5, 71.5, 130.5])
{bin(I,4,B) : B = 0..10} = 1 :- item(I).

% Feature 5 (ProductRelated_Duration): 17 bins  (thresholds: [254.25, 277.3999938964844, 289.5833282470703, 334.875, 407.59165954589844, 479.3428649902344, 486.9938049316406, 488.1666717529297, 1293.875, 1520.129150390625, 2399.4022216796875, 2658.3900146484375, 3137.1622314453125, 3530.8009033203125, 4425.85498046875, 4633.4501953125])
{bin(I,5,B) : B = 0..16} = 1 :- item(I).

% Feature 6 (BounceRates): 11 bins  (thresholds: [0.00017806999676395208, 0.0004715764953289181, 0.0012575029977597296, 0.0031339714769273996, 0.00322945904918015, 0.003851852146908641, 0.0073123041074723005, 0.009552436880767345, 0.017424242570996284, 0.024162184447050095])
{bin(I,6,B) : B = 0..10} = 1 :- item(I).

% Feature 7 (ExitRates): 16 bins  (thresholds: [0.002097902004607022, 0.007573471404612064, 0.014660919550806284, 0.014712906908243895, 0.01554254675284028, 0.015573624521493912, 0.01852322183549404, 0.019150491803884506, 0.02331821620464325, 0.02682539727538824, 0.028678075410425663, 0.02891456615179777, 0.030441750772297382, 0.03053613007068634, 0.04170420579612255])
{bin(I,7,B) : B = 0..15} = 1 :- item(I).

% Feature 8 (PageValues): 39 bins  (thresholds: [0.05254204571247101, 0.06591850519180298, 0.06960031390190125, 0.9915753602981567, 1.0739537477493286, 1.1369141936302185, 1.3630422949790955, 1.3970013856887817, 2.041768431663513, 2.4221882820129395, 2.5960638523101807, 3.502849817276001, 3.5089117288589478, 3.5230103731155396, 3.530182957649231, 3.543730616569519, 3.5903362035751343, 3.6143383979797363, 3.6254725456237793, 3.769658923149109, 3.778010606765747, 3.8437252044677734, 3.924269437789917, 5.997770309448242, 6.543143033981323, 6.568005561828613, 6.955235004425049, 7.4074952602386475, 7.872805833816528, 7.975702524185181, 8.18176794052124, 9.084768295288086, 11.567045211791992, 14.70824146270752, 18.84696674346924, 22.811558723449707, 24.529878616333008, 30.019280433654785])
{bin(I,8,B) : B = 0..38} = 1 :- item(I).

% Feature 9 (SpecialDay): 3 bins  (thresholds: [0.10000000149011612, 0.30000000447034836])
{bin(I,9,B) : B = 0..2} = 1 :- item(I).

% Feature 10 (Month): 6 bins  (thresholds: [6.5, 7.5, 9.5, 10.5, 11.5])
{bin(I,10,B) : B = 0..5} = 1 :- item(I).

% Feature 11 (OperatingSystems): 2 bins  (thresholds: [2.5])
{bin(I,11,B) : B = 0..1} = 1 :- item(I).

% Feature 12 (Browser): 2 bins  (thresholds: [4.5])
{bin(I,12,B) : B = 0..1} = 1 :- item(I).

% Feature 14 (TrafficType): 4 bins  (thresholds: [4.5, 12.0, 19.5])
{bin(I,14,B) : B = 0..3} = 1 :- item(I).

% Feature 15 (VisitorType): 2 bins  (thresholds: [0.5])
{bin(I,15,B) : B = 0..1} = 1 :- item(I).

% Feature 16 (Weekend): 2 bins  (thresholds: [0.5])
{bin(I,16,B) : B = 0..1} = 1 :- item(I).

% --- Tree structural facts ---

% Tree 0
tree(0).
% node 0: Administrative <= 0.5  (F0, bin <= 0)  left -> 1, right -> 8
node(0,0,0,0).
left_node(0,0,1).
right_node(0,0,8).
% node 1: ProductRelated <= 6.5  (F4, bin <= 0)  left -> 2, right -> 5
node(0,1,4,0).
left_node(0,1,2).
right_node(0,1,5).
% node 2: PageValues <= 9.084768295288086  (F8, bin <= 31)  left -> 3, right -> 4
node(0,2,8,31).
left_node(0,2,3).
right_node(0,2,4).
% node 3 (leaf): class False (0)
leaf_class(0,3,0).
% node 4 (leaf): class True (1)
leaf_class(0,4,1).
% node 5: PageValues <= 1.3630422949790955  (F8, bin <= 6)  left -> 6, right -> 7
node(0,5,8,6).
left_node(0,5,6).
right_node(0,5,7).
% node 6 (leaf): class False (0)
leaf_class(0,6,0).
% node 7 (leaf): class True (1)
leaf_class(0,7,1).
% node 8: ProductRelated_Duration <= 4425.85498046875  (F5, bin <= 14)  left -> 9, right -> 22
node(0,8,5,14).
left_node(0,8,9).
right_node(0,8,22).
% node 9: PageValues <= 3.6143383979797363  (F8, bin <= 17)  left -> 10, right -> 13
node(0,9,8,17).
left_node(0,9,10).
right_node(0,9,13).
% node 10: PageValues <= 0.06591850519180298  (F8, bin <= 1)  left -> 11, right -> 12
node(0,10,8,1).
left_node(0,10,11).
right_node(0,10,12).
% node 11 (leaf): class False (0)
leaf_class(0,11,0).
% node 12 (leaf): class False (0)
leaf_class(0,12,0).
% node 13: BounceRates <= 0.0004715764953289181  (F6, bin <= 1)  left -> 14, right -> 21
node(0,13,6,1).
left_node(0,13,14).
right_node(0,13,21).
% node 14: Weekend <= 0.5  (F16, bin <= 0)  left -> 15, right -> 20
node(0,14,16,0).
left_node(0,14,15).
right_node(0,14,20).
% node 15: VisitorType <= 0.5  (F15, bin <= 0)  left -> 16, right -> 17
node(0,15,15,0).
left_node(0,15,16).
right_node(0,15,17).
% node 16 (leaf): class True (1)
leaf_class(0,16,1).
% node 17: ProductRelated <= 33.5  (F4, bin <= 5)  left -> 18, right -> 19
node(0,17,4,5).
left_node(0,17,18).
right_node(0,17,19).
% node 18 (leaf): class True (1)
leaf_class(0,18,1).
% node 19 (leaf): class False (0)
leaf_class(0,19,0).
% node 20 (leaf): class True (1)
leaf_class(0,20,1).
% node 21 (leaf): class False (0)
leaf_class(0,21,0).
% node 22: PageValues <= 3.5089117288589478  (F8, bin <= 12)  left -> 23, right -> 28
node(0,22,8,12).
left_node(0,22,23).
right_node(0,22,28).
% node 23: ProductRelated_Duration <= 4633.4501953125  (F5, bin <= 15)  left -> 24, right -> 25
node(0,23,5,15).
left_node(0,23,24).
right_node(0,23,25).
% node 24 (leaf): class True (1)
leaf_class(0,24,1).
% node 25: Month <= 10.5  (F10, bin <= 3)  left -> 26, right -> 27
node(0,25,10,3).
left_node(0,25,26).
right_node(0,25,27).
% node 26 (leaf): class False (0)
leaf_class(0,26,0).
% node 27 (leaf): class False (0)
leaf_class(0,27,0).
% node 28 (leaf): class True (1)
leaf_class(0,28,1).

% Tree 1
tree(1).
% node 0: ExitRates <= 0.030441750772297382  (F7, bin <= 12)  left -> 1, right -> 28
node(1,0,7,12).
left_node(1,0,1).
right_node(1,0,28).
% node 1: Month <= 6.5  (F10, bin <= 0)  left -> 2, right -> 13
node(1,1,10,0).
left_node(1,1,2).
right_node(1,1,13).
% node 2: ProductRelated_Duration <= 289.5833282470703  (F5, bin <= 2)  left -> 3, right -> 6
node(1,2,5,2).
left_node(1,2,3).
right_node(1,2,6).
% node 3: PageValues <= 5.997770309448242  (F8, bin <= 23)  left -> 4, right -> 5
node(1,3,8,23).
left_node(1,3,4).
right_node(1,3,5).
% node 4 (leaf): class False (0)
leaf_class(1,4,0).
% node 5 (leaf): class True (1)
leaf_class(1,5,1).
% node 6: BounceRates <= 0.0073123041074723005  (F6, bin <= 6)  left -> 7, right -> 12
node(1,6,6,6).
left_node(1,6,7).
right_node(1,6,12).
% node 7: PageValues <= 7.975702524185181  (F8, bin <= 29)  left -> 8, right -> 9
node(1,7,8,29).
left_node(1,7,8).
right_node(1,7,9).
% node 8 (leaf): class False (0)
leaf_class(1,8,0).
% node 9: VisitorType <= 0.5  (F15, bin <= 0)  left -> 10, right -> 11
node(1,9,15,0).
left_node(1,9,10).
right_node(1,9,11).
% node 10 (leaf): class True (1)
leaf_class(1,10,1).
% node 11 (leaf): class True (1)
leaf_class(1,11,1).
% node 12 (leaf): class False (0)
leaf_class(1,12,0).
% node 13: Informational_Duration <= 78.22916793823242  (F3, bin <= 1)  left -> 14, right -> 25
node(1,13,3,1).
left_node(1,13,14).
right_node(1,13,25).
% node 14: ExitRates <= 0.014660919550806284  (F7, bin <= 2)  left -> 15, right -> 18
node(1,14,7,2).
left_node(1,14,15).
right_node(1,14,18).
% node 15: ProductRelated_Duration <= 479.3428649902344  (F5, bin <= 5)  left -> 16, right -> 17
node(1,15,5,5).
left_node(1,15,16).
right_node(1,15,17).
% node 16 (leaf): class False (0)
leaf_class(1,16,0).
% node 17 (leaf): class False (0)
leaf_class(1,17,0).
% node 18: ProductRelated_Duration <= 2658.3900146484375  (F5, bin <= 11)  left -> 19, right -> 24
node(1,18,5,11).
left_node(1,18,19).
right_node(1,18,24).
% node 19: Month <= 11.5  (F10, bin <= 4)  left -> 20, right -> 21
node(1,19,10,4).
left_node(1,19,20).
right_node(1,19,21).
% node 20 (leaf): class False (0)
leaf_class(1,20,0).
% node 21: PageValues <= 2.4221882820129395  (F8, bin <= 9)  left -> 22, right -> 23
node(1,21,8,9).
left_node(1,21,22).
right_node(1,21,23).
% node 22 (leaf): class False (0)
leaf_class(1,22,0).
% node 23 (leaf): class True (1)
leaf_class(1,23,1).
% node 24 (leaf): class False (0)
leaf_class(1,24,0).
% node 25: PageValues <= 1.0739537477493286  (F8, bin <= 4)  left -> 26, right -> 27
node(1,25,8,4).
left_node(1,25,26).
right_node(1,25,27).
% node 26 (leaf): class False (0)
leaf_class(1,26,0).
% node 27 (leaf): class True (1)
leaf_class(1,27,1).
% node 28: Administrative <= 0.5  (F0, bin <= 0)  left -> 29, right -> 38
node(1,28,0,0).
left_node(1,28,29).
right_node(1,28,38).
% node 29: ProductRelated_Duration <= 254.25  (F5, bin <= 0)  left -> 30, right -> 31
node(1,29,5,0).
left_node(1,29,30).
right_node(1,29,31).
% node 30 (leaf): class False (0)
leaf_class(1,30,0).
% node 31: Month <= 7.5  (F10, bin <= 1)  left -> 32, right -> 35
node(1,31,10,1).
left_node(1,31,32).
right_node(1,31,35).
% node 32: PageValues <= 7.872805833816528  (F8, bin <= 28)  left -> 33, right -> 34
node(1,32,8,28).
left_node(1,32,33).
right_node(1,32,34).
% node 33 (leaf): class False (0)
leaf_class(1,33,0).
% node 34 (leaf): class True (1)
leaf_class(1,34,1).
% node 35: PageValues <= 7.4074952602386475  (F8, bin <= 27)  left -> 36, right -> 37
node(1,35,8,27).
left_node(1,35,36).
right_node(1,35,37).
% node 36 (leaf): class False (0)
leaf_class(1,36,0).
% node 37 (leaf): class True (1)
leaf_class(1,37,1).
% node 38 (leaf): class False (0)
leaf_class(1,38,0).

% Tree 2
tree(2).
% node 0: ProductRelated_Duration <= 486.9938049316406  (F5, bin <= 6)  left -> 1, right -> 4
node(2,0,5,6).
left_node(2,0,1).
right_node(2,0,4).
% node 1: PageValues <= 3.6254725456237793  (F8, bin <= 18)  left -> 2, right -> 3
node(2,1,8,18).
left_node(2,1,2).
right_node(2,1,3).
% node 2 (leaf): class False (0)
leaf_class(2,2,0).
% node 3 (leaf): class True (1)
leaf_class(2,3,1).
% node 4: TrafficType <= 12.0  (F14, bin <= 1)  left -> 5, right -> 18
node(2,4,14,1).
left_node(2,4,5).
right_node(2,4,18).
% node 5: PageValues <= 6.568005561828613  (F8, bin <= 25)  left -> 6, right -> 11
node(2,5,8,25).
left_node(2,5,6).
right_node(2,5,11).
% node 6: ProductRelated_Duration <= 2399.4022216796875  (F5, bin <= 10)  left -> 7, right -> 8
node(2,6,5,10).
left_node(2,6,7).
right_node(2,6,8).
% node 7 (leaf): class False (0)
leaf_class(2,7,0).
% node 8: Month <= 10.5  (F10, bin <= 3)  left -> 9, right -> 10
node(2,8,10,3).
left_node(2,8,9).
right_node(2,8,10).
% node 9 (leaf): class False (0)
leaf_class(2,9,0).
% node 10 (leaf): class False (0)
leaf_class(2,10,0).
% node 11: ExitRates <= 0.01554254675284028  (F7, bin <= 4)  left -> 12, right -> 15
node(2,11,7,4).
left_node(2,11,12).
right_node(2,11,15).
% node 12: Administrative_Duration <= 100.375  (F1, bin <= 3)  left -> 13, right -> 14
node(2,12,1,3).
left_node(2,12,13).
right_node(2,12,14).
% node 13 (leaf): class True (1)
leaf_class(2,13,1).
% node 14 (leaf): class True (1)
leaf_class(2,14,1).
% node 15: ProductRelated <= 25.5  (F4, bin <= 4)  left -> 16, right -> 17
node(2,15,4,4).
left_node(2,15,16).
right_node(2,15,17).
% node 16 (leaf): class True (1)
leaf_class(2,16,1).
% node 17 (leaf): class False (0)
leaf_class(2,17,0).
% node 18: PageValues <= 11.567045211791992  (F8, bin <= 32)  left -> 19, right -> 20
node(2,18,8,32).
left_node(2,18,19).
right_node(2,18,20).
% node 19 (leaf): class False (0)
leaf_class(2,19,0).
% node 20 (leaf): class True (1)
leaf_class(2,20,1).

% Tree 3
tree(3).
% node 0: ProductRelated_Duration <= 334.875  (F5, bin <= 3)  left -> 1, right -> 14
node(3,0,5,3).
left_node(3,0,1).
right_node(3,0,14).
% node 1: BounceRates <= 0.017424242570996284  (F6, bin <= 8)  left -> 2, right -> 13
node(3,1,6,8).
left_node(3,1,2).
right_node(3,1,13).
% node 2: Administrative <= 0.5  (F0, bin <= 0)  left -> 3, right -> 12
node(3,2,0,0).
left_node(3,2,3).
right_node(3,2,12).
% node 3: ExitRates <= 0.002097902004607022  (F7, bin <= 0)  left -> 4, right -> 5
node(3,3,7,0).
left_node(3,3,4).
right_node(3,3,5).
% node 4 (leaf): class True (1)
leaf_class(3,4,1).
% node 5: ExitRates <= 0.02682539727538824  (F7, bin <= 9)  left -> 6, right -> 11
node(3,5,7,9).
left_node(3,5,6).
right_node(3,5,11).
% node 6: SpecialDay <= 0.10000000149011612  (F9, bin <= 0)  left -> 7, right -> 10
node(3,6,9,0).
left_node(3,6,7).
right_node(3,6,10).
% node 7: PageValues <= 3.8437252044677734  (F8, bin <= 21)  left -> 8, right -> 9
node(3,7,8,21).
left_node(3,7,8).
right_node(3,7,9).
% node 8 (leaf): class False (0)
leaf_class(3,8,0).
% node 9 (leaf): class True (1)
leaf_class(3,9,1).
% node 10 (leaf): class False (0)
leaf_class(3,10,0).
% node 11 (leaf): class False (0)
leaf_class(3,11,0).
% node 12 (leaf): class False (0)
leaf_class(3,12,0).
% node 13 (leaf): class False (0)
leaf_class(3,13,0).
% node 14: PageValues <= 0.9915753602981567  (F8, bin <= 3)  left -> 15, right -> 18
node(3,14,8,3).
left_node(3,14,15).
right_node(3,14,18).
% node 15: ProductRelated <= 55.5  (F4, bin <= 7)  left -> 16, right -> 17
node(3,15,4,7).
left_node(3,15,16).
right_node(3,15,17).
% node 16 (leaf): class False (0)
leaf_class(3,16,0).
% node 17 (leaf): class False (0)
leaf_class(3,17,0).
% node 18: PageValues <= 22.811558723449707  (F8, bin <= 35)  left -> 19, right -> 36
node(3,18,8,35).
left_node(3,18,19).
right_node(3,18,36).
% node 19: Informational <= 0.5  (F2, bin <= 0)  left -> 20, right -> 31
node(3,19,2,0).
left_node(3,19,20).
right_node(3,19,31).
% node 20: Administrative <= 4.5  (F0, bin <= 3)  left -> 21, right -> 26
node(3,20,0,3).
left_node(3,20,21).
right_node(3,20,26).
% node 21: ProductRelated <= 39.5  (F4, bin <= 6)  left -> 22, right -> 25
node(3,21,4,6).
left_node(3,21,22).
right_node(3,21,25).
% node 22: BounceRates <= 0.003851852146908641  (F6, bin <= 5)  left -> 23, right -> 24
node(3,22,6,5).
left_node(3,22,23).
right_node(3,22,24).
% node 23 (leaf): class True (1)
leaf_class(3,23,1).
% node 24 (leaf): class False (0)
leaf_class(3,24,0).
% node 25 (leaf): class False (0)
leaf_class(3,25,0).
% node 26: Administrative_Duration <= 342.7142791748047  (F1, bin <= 4)  left -> 27, right -> 30
node(3,26,1,4).
left_node(3,26,27).
right_node(3,26,30).
% node 27: ProductRelated <= 24.5  (F4, bin <= 3)  left -> 28, right -> 29
node(3,27,4,3).
left_node(3,27,28).
right_node(3,27,29).
% node 28 (leaf): class True (1)
leaf_class(3,28,1).
% node 29 (leaf): class False (0)
leaf_class(3,29,0).
% node 30 (leaf): class True (1)
leaf_class(3,30,1).
% node 31: PageValues <= 2.041768431663513  (F8, bin <= 8)  left -> 32, right -> 33
node(3,31,8,8).
left_node(3,31,32).
right_node(3,31,33).
% node 32 (leaf): class True (1)
leaf_class(3,32,1).
% node 33: BounceRates <= 0.009552436880767345  (F6, bin <= 7)  left -> 34, right -> 35
node(3,33,6,7).
left_node(3,33,34).
right_node(3,33,35).
% node 34 (leaf): class False (0)
leaf_class(3,34,0).
% node 35 (leaf): class False (0)
leaf_class(3,35,0).
% node 36: Administrative <= 1.5  (F0, bin <= 1)  left -> 37, right -> 40
node(3,36,0,1).
left_node(3,36,37).
right_node(3,36,40).
% node 37: BounceRates <= 0.0031339714769273996  (F6, bin <= 3)  left -> 38, right -> 39
node(3,37,6,3).
left_node(3,37,38).
right_node(3,37,39).
% node 38 (leaf): class True (1)
leaf_class(3,38,1).
% node 39 (leaf): class True (1)
leaf_class(3,39,1).
% node 40: VisitorType <= 0.5  (F15, bin <= 0)  left -> 41, right -> 42
node(3,40,15,0).
left_node(3,40,41).
right_node(3,40,42).
% node 41 (leaf): class True (1)
leaf_class(3,41,1).
% node 42 (leaf): class True (1)
leaf_class(3,42,1).

% Tree 4
tree(4).
% node 0: ExitRates <= 0.02331821620464325  (F7, bin <= 8)  left -> 1, right -> 14
node(4,0,7,8).
left_node(4,0,1).
right_node(4,0,14).
% node 1: PageValues <= 3.502849817276001  (F8, bin <= 11)  left -> 2, right -> 5
node(4,1,8,11).
left_node(4,1,2).
right_node(4,1,5).
% node 2: PageValues <= 0.05254204571247101  (F8, bin <= 0)  left -> 3, right -> 4
node(4,2,8,0).
left_node(4,2,3).
right_node(4,2,4).
% node 3 (leaf): class False (0)
leaf_class(4,3,0).
% node 4 (leaf): class False (0)
leaf_class(4,4,0).
% node 5: ProductRelated <= 22.5  (F4, bin <= 2)  left -> 6, right -> 9
node(4,5,4,2).
left_node(4,5,6).
right_node(4,5,9).
% node 6: Informational_Duration <= 104.0  (F3, bin <= 2)  left -> 7, right -> 8
node(4,6,3,2).
left_node(4,6,7).
right_node(4,6,8).
% node 7 (leaf): class True (1)
leaf_class(4,7,1).
% node 8 (leaf): class False (0)
leaf_class(4,8,0).
% node 9: VisitorType <= 0.5  (F15, bin <= 0)  left -> 10, right -> 11
node(4,9,15,0).
left_node(4,9,10).
right_node(4,9,11).
% node 10 (leaf): class True (1)
leaf_class(4,10,1).
% node 11: ExitRates <= 0.007573471404612064  (F7, bin <= 1)  left -> 12, right -> 13
node(4,11,7,1).
left_node(4,11,12).
right_node(4,11,13).
% node 12 (leaf): class True (1)
leaf_class(4,12,1).
% node 13 (leaf): class False (0)
leaf_class(4,13,0).
% node 14: BounceRates <= 0.024162184447050095  (F6, bin <= 9)  left -> 15, right -> 26
node(4,14,6,9).
left_node(4,14,15).
right_node(4,14,26).
% node 15: ExitRates <= 0.04170420579612255  (F7, bin <= 14)  left -> 16, right -> 25
node(4,15,7,14).
left_node(4,15,16).
right_node(4,15,25).
% node 16: ProductRelated_Duration <= 277.3999938964844  (F5, bin <= 1)  left -> 17, right -> 18
node(4,16,5,1).
left_node(4,16,17).
right_node(4,16,18).
% node 17 (leaf): class False (0)
leaf_class(4,17,0).
% node 18: PageValues <= 1.1369141936302185  (F8, bin <= 5)  left -> 19, right -> 20
node(4,18,8,5).
left_node(4,18,19).
right_node(4,18,20).
% node 19 (leaf): class False (0)
leaf_class(4,19,0).
% node 20: PageValues <= 30.019280433654785  (F8, bin <= 37)  left -> 21, right -> 24
node(4,20,8,37).
left_node(4,20,21).
right_node(4,20,24).
% node 21: ProductRelated_Duration <= 1520.129150390625  (F5, bin <= 9)  left -> 22, right -> 23
node(4,21,5,9).
left_node(4,21,22).
right_node(4,21,23).
% node 22 (leaf): class True (1)
leaf_class(4,22,1).
% node 23 (leaf): class False (0)
leaf_class(4,23,0).
% node 24 (leaf): class True (1)
leaf_class(4,24,1).
% node 25 (leaf): class False (0)
leaf_class(4,25,0).
% node 26: PageValues <= 3.778010606765747  (F8, bin <= 20)  left -> 27, right -> 28
node(4,26,8,20).
left_node(4,26,27).
right_node(4,26,28).
% node 27 (leaf): class False (0)
leaf_class(4,27,0).
% node 28 (leaf): class False (0)
leaf_class(4,28,0).

% Tree 5
tree(5).
% node 0: ProductRelated_Duration <= 488.1666717529297  (F5, bin <= 7)  left -> 1, right -> 18
node(5,0,5,7).
left_node(5,0,1).
right_node(5,0,18).
% node 1: TrafficType <= 19.5  (F14, bin <= 2)  left -> 2, right -> 15
node(5,1,14,2).
left_node(5,1,2).
right_node(5,1,15).
% node 2: Month <= 6.5  (F10, bin <= 0)  left -> 3, right -> 10
node(5,2,10,0).
left_node(5,2,3).
right_node(5,2,10).
% node 3: ExitRates <= 0.028678075410425663  (F7, bin <= 10)  left -> 4, right -> 9
node(5,3,7,10).
left_node(5,3,4).
right_node(5,3,9).
% node 4: OperatingSystems <= 2.5  (F11, bin <= 0)  left -> 5, right -> 8
node(5,4,11,0).
left_node(5,4,5).
right_node(5,4,8).
% node 5: PageValues <= 8.18176794052124  (F8, bin <= 30)  left -> 6, right -> 7
node(5,5,8,30).
left_node(5,5,6).
right_node(5,5,7).
% node 6 (leaf): class False (0)
leaf_class(5,6,0).
% node 7 (leaf): class True (1)
leaf_class(5,7,1).
% node 8 (leaf): class False (0)
leaf_class(5,8,0).
% node 9 (leaf): class False (0)
leaf_class(5,9,0).
% node 10: VisitorType <= 0.5  (F15, bin <= 0)  left -> 11, right -> 14
node(5,10,15,0).
left_node(5,10,11).
right_node(5,10,14).
% node 11: PageValues <= 3.8437252044677734  (F8, bin <= 21)  left -> 12, right -> 13
node(5,11,8,21).
left_node(5,11,12).
right_node(5,11,13).
% node 12 (leaf): class False (0)
leaf_class(5,12,0).
% node 13 (leaf): class True (1)
leaf_class(5,13,1).
% node 14 (leaf): class False (0)
leaf_class(5,14,0).
% node 15: PageValues <= 6.955235004425049  (F8, bin <= 26)  left -> 16, right -> 17
node(5,15,8,26).
left_node(5,15,16).
right_node(5,15,17).
% node 16 (leaf): class False (0)
leaf_class(5,16,0).
% node 17 (leaf): class True (1)
leaf_class(5,17,1).
% node 18: PageValues <= 0.9915753602981567  (F8, bin <= 3)  left -> 19, right -> 20
node(5,18,8,3).
left_node(5,18,19).
right_node(5,18,20).
% node 19 (leaf): class False (0)
leaf_class(5,19,0).
% node 20: PageValues <= 24.529878616333008  (F8, bin <= 36)  left -> 21, right -> 28
node(5,20,8,36).
left_node(5,20,21).
right_node(5,20,28).
% node 21: Administrative <= 6.5  (F0, bin <= 5)  left -> 22, right -> 25
node(5,21,0,5).
left_node(5,21,22).
right_node(5,21,25).
% node 22: Administrative_Duration <= 2.5  (F1, bin <= 0)  left -> 23, right -> 24
node(5,22,1,0).
left_node(5,22,23).
right_node(5,22,24).
% node 23 (leaf): class True (1)
leaf_class(5,23,1).
% node 24 (leaf): class False (0)
leaf_class(5,24,0).
% node 25: Month <= 9.5  (F10, bin <= 2)  left -> 26, right -> 27
node(5,25,10,2).
left_node(5,25,26).
right_node(5,25,27).
% node 26 (leaf): class False (0)
leaf_class(5,26,0).
% node 27 (leaf): class False (0)
leaf_class(5,27,0).
% node 28: Administrative_Duration <= 77.75  (F1, bin <= 2)  left -> 29, right -> 30
node(5,28,1,2).
left_node(5,28,29).
right_node(5,28,30).
% node 29 (leaf): class True (1)
leaf_class(5,29,1).
% node 30: BounceRates <= 0.0012575029977597296  (F6, bin <= 2)  left -> 31, right -> 32
node(5,30,6,2).
left_node(5,30,31).
right_node(5,30,32).
% node 31 (leaf): class True (1)
leaf_class(5,31,1).
% node 32 (leaf): class False (0)
leaf_class(5,32,0).

% Tree 6
tree(6).
% node 0: ProductRelated_Duration <= 407.59165954589844  (F5, bin <= 4)  left -> 1, right -> 4
node(6,0,5,4).
left_node(6,0,1).
right_node(6,0,4).
% node 1: PageValues <= 3.5903362035751343  (F8, bin <= 16)  left -> 2, right -> 3
node(6,1,8,16).
left_node(6,1,2).
right_node(6,1,3).
% node 2 (leaf): class False (0)
leaf_class(6,2,0).
% node 3 (leaf): class True (1)
leaf_class(6,3,1).
% node 4: Administrative_Duration <= 11.75  (F1, bin <= 1)  left -> 5, right -> 16
node(6,4,1,1).
left_node(6,4,5).
right_node(6,4,16).
% node 5: VisitorType <= 0.5  (F15, bin <= 0)  left -> 6, right -> 9
node(6,5,15,0).
left_node(6,5,6).
right_node(6,5,9).
% node 6: PageValues <= 3.924269437789917  (F8, bin <= 22)  left -> 7, right -> 8
node(6,6,8,22).
left_node(6,6,7).
right_node(6,6,8).
% node 7 (leaf): class False (0)
leaf_class(6,7,0).
% node 8 (leaf): class True (1)
leaf_class(6,8,1).
% node 9: SpecialDay <= 0.30000000447034836  (F9, bin <= 1)  left -> 10, right -> 15
node(6,9,9,1).
left_node(6,9,10).
right_node(6,9,15).
% node 10: ExitRates <= 0.015573624521493912  (F7, bin <= 5)  left -> 11, right -> 14
node(6,10,7,5).
left_node(6,10,11).
right_node(6,10,14).
% node 11: PageValues <= 0.06960031390190125  (F8, bin <= 2)  left -> 12, right -> 13
node(6,11,8,2).
left_node(6,11,12).
right_node(6,11,13).
% node 12 (leaf): class False (0)
leaf_class(6,12,0).
% node 13 (leaf): class True (1)
leaf_class(6,13,1).
% node 14 (leaf): class False (0)
leaf_class(6,14,0).
% node 15 (leaf): class False (0)
leaf_class(6,15,0).
% node 16: ExitRates <= 0.019150491803884506  (F7, bin <= 7)  left -> 17, right -> 30
node(6,16,7,7).
left_node(6,16,17).
right_node(6,16,30).
% node 17: TrafficType <= 4.5  (F14, bin <= 0)  left -> 18, right -> 29
node(6,17,14,0).
left_node(6,17,18).
right_node(6,17,29).
% node 18: Informational_Duration <= 3.5  (F3, bin <= 0)  left -> 19, right -> 24
node(6,18,3,0).
left_node(6,18,19).
right_node(6,18,24).
% node 19: Month <= 10.5  (F10, bin <= 3)  left -> 20, right -> 21
node(6,19,10,3).
left_node(6,19,20).
right_node(6,19,21).
% node 20 (leaf): class False (0)
leaf_class(6,20,0).
% node 21: PageValues <= 3.530182957649231  (F8, bin <= 14)  left -> 22, right -> 23
node(6,21,8,14).
left_node(6,21,22).
right_node(6,21,23).
% node 22 (leaf): class False (0)
leaf_class(6,22,0).
% node 23 (leaf): class True (1)
leaf_class(6,23,1).
% node 24: PageValues <= 6.543143033981323  (F8, bin <= 24)  left -> 25, right -> 26
node(6,24,8,24).
left_node(6,24,25).
right_node(6,24,26).
% node 25 (leaf): class False (0)
leaf_class(6,25,0).
% node 26: Administrative <= 3.5  (F0, bin <= 2)  left -> 27, right -> 28
node(6,26,0,2).
left_node(6,26,27).
right_node(6,26,28).
% node 27 (leaf): class True (1)
leaf_class(6,27,1).
% node 28 (leaf): class False (0)
leaf_class(6,28,0).
% node 29 (leaf): class False (0)
leaf_class(6,29,0).
% node 30: ProductRelated <= 130.5  (F4, bin <= 9)  left -> 31, right -> 34
node(6,30,4,9).
left_node(6,30,31).
right_node(6,30,34).
% node 31: PageValues <= 3.769658923149109  (F8, bin <= 19)  left -> 32, right -> 33
node(6,31,8,19).
left_node(6,31,32).
right_node(6,31,33).
% node 32 (leaf): class False (0)
leaf_class(6,32,0).
% node 33 (leaf): class False (0)
leaf_class(6,33,0).
% node 34 (leaf): class False (0)
leaf_class(6,34,0).

% Tree 7
tree(7).
% node 0: PageValues <= 2.5960638523101807  (F8, bin <= 10)  left -> 1, right -> 4
node(7,0,8,10).
left_node(7,0,1).
right_node(7,0,4).
% node 1: ProductRelated <= 71.5  (F4, bin <= 8)  left -> 2, right -> 3
node(7,1,4,8).
left_node(7,1,2).
right_node(7,1,3).
% node 2 (leaf): class False (0)
leaf_class(7,2,0).
% node 3 (leaf): class False (0)
leaf_class(7,3,0).
% node 4: PageValues <= 18.84696674346924  (F8, bin <= 34)  left -> 5, right -> 14
node(7,4,8,34).
left_node(7,4,5).
right_node(7,4,14).
% node 5: ProductRelated <= 22.5  (F4, bin <= 2)  left -> 6, right -> 7
node(7,5,4,2).
left_node(7,5,6).
right_node(7,5,7).
% node 6 (leaf): class True (1)
leaf_class(7,6,1).
% node 7: Administrative <= 4.5  (F0, bin <= 3)  left -> 8, right -> 9
node(7,7,0,3).
left_node(7,7,8).
right_node(7,7,9).
% node 8 (leaf): class False (0)
leaf_class(7,8,0).
% node 9: Month <= 9.5  (F10, bin <= 2)  left -> 10, right -> 11
node(7,9,10,2).
left_node(7,9,10).
right_node(7,9,11).
% node 10 (leaf): class False (0)
leaf_class(7,10,0).
% node 11: PageValues <= 14.70824146270752  (F8, bin <= 33)  left -> 12, right -> 13
node(7,11,8,33).
left_node(7,11,12).
right_node(7,11,13).
% node 12 (leaf): class True (1)
leaf_class(7,12,1).
% node 13 (leaf): class False (0)
leaf_class(7,13,0).
% node 14: VisitorType <= 0.5  (F15, bin <= 0)  left -> 15, right -> 16
node(7,14,15,0).
left_node(7,14,15).
right_node(7,14,16).
% node 15 (leaf): class True (1)
leaf_class(7,15,1).
% node 16: ProductRelated <= 20.5  (F4, bin <= 1)  left -> 17, right -> 20
node(7,16,4,1).
left_node(7,16,17).
right_node(7,16,20).
% node 17: ExitRates <= 0.03053613007068634  (F7, bin <= 13)  left -> 18, right -> 19
node(7,17,7,13).
left_node(7,17,18).
right_node(7,17,19).
% node 18 (leaf): class True (1)
leaf_class(7,18,1).
% node 19 (leaf): class True (1)
leaf_class(7,19,1).
% node 20: BounceRates <= 0.00322945904918015  (F6, bin <= 4)  left -> 21, right -> 22
node(7,20,6,4).
left_node(7,20,21).
right_node(7,20,22).
% node 21 (leaf): class True (1)
leaf_class(7,21,1).
% node 22: ProductRelated_Duration <= 3530.8009033203125  (F5, bin <= 13)  left -> 23, right -> 24
node(7,22,5,13).
left_node(7,22,23).
right_node(7,22,24).
% node 23 (leaf): class False (0)
leaf_class(7,23,0).
% node 24 (leaf): class True (1)
leaf_class(7,24,1).

% Tree 8
tree(8).
% node 0: ExitRates <= 0.02891456615179777  (F7, bin <= 11)  left -> 1, right -> 18
node(8,0,7,11).
left_node(8,0,1).
right_node(8,0,18).
% node 1: ExitRates <= 0.01852322183549404  (F7, bin <= 6)  left -> 2, right -> 13
node(8,1,7,6).
left_node(8,1,2).
right_node(8,1,13).
% node 2: Informational <= 2.5  (F2, bin <= 1)  left -> 3, right -> 12
node(8,2,2,1).
left_node(8,2,3).
right_node(8,2,12).
% node 3: PageValues <= 3.5230103731155396  (F8, bin <= 13)  left -> 4, right -> 5
node(8,3,8,13).
left_node(8,3,4).
right_node(8,3,5).
% node 4 (leaf): class False (0)
leaf_class(8,4,0).
% node 5: BounceRates <= 0.00017806999676395208  (F6, bin <= 0)  left -> 6, right -> 9
node(8,5,6,0).
left_node(8,5,6).
right_node(8,5,9).
% node 6: Administrative <= 4.5  (F0, bin <= 3)  left -> 7, right -> 8
node(8,6,0,3).
left_node(8,6,7).
right_node(8,6,8).
% node 7 (leaf): class True (1)
leaf_class(8,7,1).
% node 8 (leaf): class True (1)
leaf_class(8,8,1).
% node 9: Month <= 10.5  (F10, bin <= 3)  left -> 10, right -> 11
node(8,9,10,3).
left_node(8,9,10).
right_node(8,9,11).
% node 10 (leaf): class False (0)
leaf_class(8,10,0).
% node 11 (leaf): class True (1)
leaf_class(8,11,1).
% node 12 (leaf): class False (0)
leaf_class(8,12,0).
% node 13: PageValues <= 1.3970013856887817  (F8, bin <= 7)  left -> 14, right -> 15
node(8,13,8,7).
left_node(8,13,14).
right_node(8,13,15).
% node 14 (leaf): class False (0)
leaf_class(8,14,0).
% node 15: ProductRelated <= 22.5  (F4, bin <= 2)  left -> 16, right -> 17
node(8,15,4,2).
left_node(8,15,16).
right_node(8,15,17).
% node 16 (leaf): class True (1)
leaf_class(8,16,1).
% node 17 (leaf): class False (0)
leaf_class(8,17,0).
% node 18: Administrative <= 0.5  (F0, bin <= 0)  left -> 19, right -> 20
node(8,18,0,0).
left_node(8,18,19).
right_node(8,18,20).
% node 19 (leaf): class False (0)
leaf_class(8,19,0).
% node 20 (leaf): class False (0)
leaf_class(8,20,0).

% Tree 9
tree(9).
% node 0: PageValues <= 3.543730616569519  (F8, bin <= 15)  left -> 1, right -> 10
node(9,0,8,15).
left_node(9,0,1).
right_node(9,0,10).
% node 1: Month <= 6.5  (F10, bin <= 0)  left -> 2, right -> 3
node(9,1,10,0).
left_node(9,1,2).
right_node(9,1,3).
% node 2 (leaf): class False (0)
leaf_class(9,2,0).
% node 3: Informational <= 0.5  (F2, bin <= 0)  left -> 4, right -> 5
node(9,3,2,0).
left_node(9,3,4).
right_node(9,3,5).
% node 4 (leaf): class False (0)
leaf_class(9,4,0).
% node 5: ProductRelated_Duration <= 3137.1622314453125  (F5, bin <= 12)  left -> 6, right -> 7
node(9,5,5,12).
left_node(9,5,6).
right_node(9,5,7).
% node 6 (leaf): class False (0)
leaf_class(9,6,0).
% node 7: PageValues <= 0.05254204571247101  (F8, bin <= 0)  left -> 8, right -> 9
node(9,7,8,0).
left_node(9,7,8).
right_node(9,7,9).
% node 8 (leaf): class False (0)
leaf_class(9,8,0).
% node 9 (leaf): class True (1)
leaf_class(9,9,1).
% node 10: Administrative <= 5.5  (F0, bin <= 4)  left -> 11, right -> 18
node(9,10,0,4).
left_node(9,10,11).
right_node(9,10,18).
% node 11: ProductRelated_Duration <= 1293.875  (F5, bin <= 8)  left -> 12, right -> 13
node(9,11,5,8).
left_node(9,11,12).
right_node(9,11,13).
% node 12 (leaf): class True (1)
leaf_class(9,12,1).
% node 13: Browser <= 4.5  (F12, bin <= 0)  left -> 14, right -> 17
node(9,13,12,0).
left_node(9,13,14).
right_node(9,13,17).
% node 14: ExitRates <= 0.014712906908243895  (F7, bin <= 3)  left -> 15, right -> 16
node(9,14,7,3).
left_node(9,14,15).
right_node(9,14,16).
% node 15 (leaf): class True (1)
leaf_class(9,15,1).
% node 16 (leaf): class False (0)
leaf_class(9,16,0).
% node 17 (leaf): class True (1)
leaf_class(9,17,1).
% node 18 (leaf): class False (0)
leaf_class(9,18,0).

% --- Class domain ---
class_idx(0).  % False
class_idx(1).  % True
