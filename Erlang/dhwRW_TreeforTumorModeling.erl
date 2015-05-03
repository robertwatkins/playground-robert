%% A. Tuples
%%%T
%%A tuple is a fixed number of elements joined in a single item. A tuple is formed by enclosing the values between %%curly braces, and seperating the elements with commas. Tuples can contain tuples. Tuples are similar to a C %%struct, only anonymous. Some examples of tuples being assigned to variables:
%%% > P = { 13, 23}.
%%%{12, 23}
%%%> Person = { person, {name, bob} ,{age, 15} }.
%%%{ person, {name, bob} ,{age, 15} }.
%%%To extract information from a tuple, you assign the tupple (pattern match) to a series of variables with the same format and arity:
%%%
%%%{person, {name, Username} ,{age, Userage}}.
%%%{ person, {name, bob} ,{age, 15} }
%%%%%> Username.
%%%bob
%%%> Userage.
%%%15
%%%When extracting values f rom a tupple, in order to ignore variables in a tuple that you don't want, you use the underscore character:
%%%
%%%> {_ , {_, Username}, {_,_} }.
%%%{ person, {name, bob} ,{age, 15} }
%%%> Username.
%%%bob
%%%Lists
%%%
%%%Lists are a series of values seperated by commas, surrounded by square brackets. The first element in the list is the head, the rest of the list is the tail.
%%%
%%%> MyList = [1,2,3,4,5].
%%%%%[1,2,3,4,5]
%%%> [Head | Tail] = MyList.
%%%[1,2,3,4,5]
%%%> Head.
%%%1
%%%> Tail
%%%[2,3,4,5]


%% 1) Create Empty Tree

T=gb_trees:empty().



%%% 2a) Create a key with a coordinate {1,3}

T2old=gb_trees:enter(1200,{1,3},T).


%%% 2b) Create a key with a coordinate [1,3]  Advantage here is to use Head and Tail to rip off
%%% the coordinates (less lines of code than with tuple in 2a)

T2=gb_trees:enter(1200,[1,3],T).

%%% 3) P will be the retrieved value for Key==1200, will return coordinate{1,3} 

P=gb_trees:get(1200,T2).

%%% Example 
%%%[AA,BB] = [1,3] .    
%%% returns [1,3]
%%%AA.is  1
%%%BB is 3

%% 
%%% Actually works with tuples too {PPx,PPy} = {1,3} .
%%%{1,3}

%% 4) Px and PY will be set,  the hard coded values here actually
% should randomly be combinations in a square. ie you get two points
%
%from  coordinates (1,1),(1,0),(1,-1),
%from  coordinates (0,1),      , (0,-1),
%from  coordinates (-1,1),(-1,0),(-1,-1),

[Px,Py] = P .    
%returns [1,3]

PPx2= Px+2.
PPy2= Py-1.

PNx2= Px+4.
PNy2= Py+3.

%% 5) Assembly
PP=[PPx2,PPy2].
PN=[PNx2,PNy2].

% 6)  Let's spawn left and right children  with keys 600 and 1800


T3a=gb_trees:enter(600,PP,T2).

T3=gb_trees:enter(1800,PN,T2).

% results: {2,{1200,[1,3],nil,{1800,[5,6],nil,nil}}}

% 7) Here let's get all the spawned values
gb_trees:values(T3).

%%  NOW we just need to get functions that build up this with functions.
% for example we need to start with the number of generations to go
% result from above,
%  I'll write a parser later to pick off the below values
% but ideally we can get this into
%  a file
> gb_trees:values(T3). becomesj  [[1,3],[5,6]]

% but better if I can get a file with
%1 3
%5 6
%...







%%%%%%%%%%%%%%%%%%%%%
%% Notes: 
%%%%%%%%%%%%%%%%%%%%%
% Doesn't work
%> {1,3} +{3,4}.
** exception error: bad argument in an arithmetic expression
     in operator  +/2
        called as {1,3} + {3,4}
% works
%
% > {1+3,4+1}.
%{4,5}




