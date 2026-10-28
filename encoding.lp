% ============================================================
% encoding.lp — model-independent reasoning rules
% Traversal, majority-voting, and explanation rules.
% Load together with random_forest.lp.
% ============================================================

% --- Predicates defined in random_forest.lp ---
% tree(T)            : T is a tree index.
% node(T,X,F,B)      : internal node X in tree T tests feature F with split bin B.
% left_node(T,X,N2)  : left child of node X in tree T  (condition true:  bin <= B).
% right_node(T,X,N2) : right child of node X in tree T (condition false: bin > B).
% leaf_class(T,X,C)  : leaf X of tree T predicts class C.
%                      A node is a leaf iff it has a leaf_class fact.
% bin(I,F,B)         : item I is assigned to bin B for feature F.
% class_idx(C)       : C is a valid class index.

% --- Tree traversal ---
% next_node(I,T,N): node N is on the path for item I in tree T.
% class(I,T,C):     tree T predicts class C for item I.

next_node(I,T,0) :- item(I), tree(T).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv <= B, left_node(T,N1,N2).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv > B,  right_node(T,N1,N2).

class(I,T,C) :- next_node(I,T,N), leaf_class(T,N,C).

% ============================================================
% --- Majority voting ---
% ============================================================
% Each tree casts one vote. The forest prediction is the class with
% the most votes.
% Vote ties are broken lexicographically toward the LOWEST class index:
% prediction(I,C) is the single smallest C among those sharing the maximum
% vote count.

% vote(I,C,V): class C receives V votes for item I.
vote(I,C,V) :- item(I), class_idx(C), V = #count{T : class(I,T,C)}.
max_votes(I,M) :- item(I), M = #max{V : vote(I,_,V)}.
prediction(I,C) :- max_votes(I,M), C = #min{C2 : vote(I,C2,M)}.

% --- Explanation ---
% selected(F): feature F is selected as part of the candidate explanation.
%              compute_mus.py wraps *all* the features F in a __debug__ choice rule;
%              wasp --mus minimises over them.
% Find items 3 and 4 such that:
%   - item 3 agrees with item 1 on all selected features (it copies their bins)
%   - item 4 agrees with item 2 on all selected features
%   - the predicted class of item 3 is strictly higher than that of item 4
% On non-selected features, bins of 3 and 4 are free (from random_forest.lp choice rules).

item(3). item(4).

bin(3,F,B) :- selected(F), bin(1,F,B).
bin(4,F,B) :- selected(F), bin(2,F,B).

:- prediction(3,C3), prediction(4,C4), C3 <= C4.

#show prediction/2.
