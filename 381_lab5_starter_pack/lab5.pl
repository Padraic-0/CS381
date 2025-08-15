/***************************************/
%     CS 381 - Programming Lab #5       %
%                                       %
%  < berginp@oregonstate.edu>           %
%  < padraic >                          %
%                                       %
/***************************************/

% load family tree
:- consult('royal.pl').

% enables piping in tests
portray(Term) :- atom(Term), format("~s", Term).



% your code here...

mother(M, C):- parent(M,C), female(M).
father(F, C):- parent(F,C), male(F).

spouse(S, X):- married(S,X); married(X,S).
child(C,P):- parent(P,C).
son(S,P):- child(S,P), male(S).
daughter(D,P):- child(D,P), female(D).
sibling(S, X):- father(P,S), father(P,X), S \= X.
brother(B,X):- sibling(B,X), male(B).
sister(S,X):- sibling(S,X), female(S).

uncle(U,X):- parent(P,X), (brother(U,P); (sister(S,P), spouse(U,S))).
aunt(A,X):- parent(P,X), (sister(A,P); (brother(B,P), spouse(A,B))).
grandparent(G,X):- parent(P,X),parent(G,P).
grandfather(Gf,X):- grandparent(Gf,X), male(Gf).
grandmother(Gm,X):- grandparent(Gm,X), female(Gm).
grandchild(Gc,X):- child(C,X), child(Gc,C).

ancestor(A,X):- parent(A,X).
ancestor(A,X):- parent(A,P), ancestor(P,X), A \= X.

descendant(D,X):- child(D,X).
descendant(D,X):- child(D,C), descendant(C,X), D \= X.

older(O,X):- born(O,Odate), born(X,Xdate), Odate < Xdate.
younger(Y,X):- born(Y,Ydate), born(X,Xdate), Ydate > Xdate.

regentWhenBorn(R,X):- born(X,Xdate), reigned(R,S,E), Xdate > S, Xdate < E; 1==0.

cousin(C,X):- child(C,S), sibling(S,P), parent(P,X), C \= X.