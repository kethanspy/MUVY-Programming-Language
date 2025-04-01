/*---------------------------------------------------------------
MuVY programming language
Vesion: muvy 1.1
Purpose: It is used to evaluate the parse tree generated and display the result.
Created by:
SER-502 Team-19
Authors:
    Harsha Vardhan Mupparaju
    Kethan Yeddla
    Pavithra Moravaneni
    Vishnu Teja Vantukala
    Vishwanath Reddy Yasa

------------------------------------------------------------------ */


% muvyEvaluator file

% Defining the declaration of the datatype used in the program.
muvy_data(dec_number(X),X):- number(X).
muvy_data(dec_str(X),X):- string(X).
muvy_data(dec_bool(X),X).
muvy_eval_integer(id(P),P).

% Evaluating the expression with Comparator Operators
muvy_equal(Result1,Result2,true):- Result1=Result2.
muvy_equal(Result1,Result2,false):- Result1\=Result2.
muvy_inequal(Result1,Result2,true):- Result1\=Result2.
muvy_inequal(Result1,Result2,false):- Result1=Result2.
muvy_less(Result1,Result2,true):- Result1<Result2.
muvy_less(Result1,Result2,false):- Result1>=Result2.
muvy_greater(Result1,Result2,true):- Result1>Result2.
muvy_greater(Result1,Result2,false):- Result1=<Result2.
muvy_lessequal(Result1,Result2,true):- Result1=<Result2.
muvy_lessequal(Result1,Result2,false):- Result1>Result2.
muvy_greaterequal(Result1,Result2,true):- Result1>=Result2.
muvy_greaterequal(Result1,Result2,false):- Result1<Result2.
muvy_not(true,false).
muvy_not(false,true).

% Defining the default values of datatypes used in the program.
muvy_datatype(num,Value,correct) :- integer(Value).
muvy_datatype(num,Value,incorrect) :- \+ integer(Value).
muvy_datatype(boolean,true,correct).
muvy_datatype(boolean,false,correct).
muvy_datatype(boolean,Value,incorrect) :- Value\= true ; Value\= false.
muvy_datatype(string,Value,correct) :- string(Value).
muvy_datatype(string,Value,incorrect) :- \+ string(Value).

% Declaraing the Initialization of the datatypes with default values.
muvy_datatypes_initialize('int',0).
muvy_datatypes_initialize('boolean',false).
muvy_datatypes_initialize('string',"").

% Defining the boolean operators.
mvy_booleanAND(Val1,Val2,true):- Val1 = true,Val2 = true.
mvy_booleanAND(Val1,Val2,false):- Val1 = false;Val2 = false.
mvy_booleanOR(Val1,Val2,true):- Val1 = true; Val2 = true.
mvy_booleanOR(Val1,Val2,false):- Val1 = false, Val2 = false.


% Defining the start of the program with initializing block of the code. 
e_muvypgm(begin(P)) :- muvy_block(P,_,_).

% Defining the block of the program.
muvy_block(seqnce(P),Var,EVar) :- e_seqnce_stmnts(P,Var,EVar).

% Defining the statements block of code.
e_seqnce_stmnts(cmd(A,B),Var,EVar) :- muvy_eval_c(A,Var,Var1),e_seqnce_stmnts(B,Var1,EVar).
e_seqnce_stmnts(P,Var,EVar) :- muvy_eval_c(P,Var,EVar).

% Defining the evaluation of increment and decrement operators
muvy_increment_operator(P,Var,Resultant,Result):-muvy_eval_integer(P,Value1),table1(Value1,Var,Val), Result is Val+1, muvy_insert(Value1,Result,Var,Resultant).
muvy_decrement_operator(P,Var,Resultant,Result):-muvy_eval_integer(P,Value1),table1(Value1,Var,Val), Result is Val-1, muvy_insert(Value1,Result,Var,Resultant).

% Defining the predicate for the ternary operator by evaluating the expression. 
muvy_ternary_operator(ternary_op(A,B,_),Var,Resultant,Result):- muvy_boolean_comparison(A,Var,Var1,true),muvy_eval_expression(B,Var1,Resultant,Result).
muvy_ternary_operator(ternary_op(A,_,C),Var,Resultant,Result):- muvy_boolean_comparison(A,Var,Var1,false),muvy_eval_expression(C,Var1,Resultant,Result).


% Evaluating the boolean operations with Comparator operators.
muvy_boolean_comparison(mvy_booleanAND(A,B),Var,Resultant,Val) :- muvy_boolean(A,Var,Var1,Res1), muvy_boolean_comparison(B,Var1,Resultant,Res2),mvy_booleanAND(Res1,Res2,Val).
muvy_boolean_comparison(mvy_booleanOR(A,B),Var,Resultant,Val) :- muvy_boolean(A,Var,Var1,Res1), muvy_boolean_comparison(B,Var1,Resultant,Res2),mvy_booleanOR(Res1,Res2,Val).
muvy_boolean_comparison(P,Var,Resultant,Result):- muvy_boolean(P,Var,Resultant,Result).

muvy_boolean(P,Var,EVar,Value):- muvy_eval_expression(P,Var,EVar,Value).
muvy_boolean(compare_not(P),Var,EVar,Value) :- muvy_boolean(P,Var,EVar,Value1),muvy_not(Value1,Value).
muvy_boolean(comp_equal(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_equal(Result1,Result2,Value).
muvy_boolean(comp_notequal(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_inequal(Result1,Result2,Value).
muvy_boolean(comp_less(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_less(Result1,Result2,Value).
muvy_boolean(comp_great(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_greater(Result1,Result2,Value).
muvy_boolean(comp_less(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_less(Result1,Result2,Value).
muvy_boolean(comp_great(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_greater(Result1,Result2,Value).
muvy_boolean(comp_lessOReq(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_lessequal(Result1,Result2,Value).
muvy_boolean(comp_greatOReq(A,B),Var,EVar,Value) :- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), muvy_greaterequal(Result1,Result2,Value).
muvy_boolean(true,Var,Var,true).
muvy_boolean(false,Var,Var,false).

% Evaluating the arithmetic operations along with string operations.
muvy_eval_expression(operator_assign(A,B),Var,EVar,Result):- muvy_eval_expression(B,Var,Var1,Result),muvy_eval_integer(A,ValueI), muvy_insert(ValueI,Result,Var1,EVar).
muvy_eval_expression(str_reverse(P),Var,Var,Result):- muvy_eval_expression(P,Var,Var,Str),string(Str),string_to_list(Str,L),reverse(L,Rev),string_to_list(Result,Rev).
muvy_eval_expression(str_concat(A,B),Var,Var,Result) :- muvy_eval_expression(A,Var,Var,R1),muvy_eval_expression(B,Var,Var,R2),string(R1),string(R2),string_concat(R1,R2,Result).
muvy_eval_expression(increment_op(P),Var,EVar,Result):- muvy_increment_operator(P,Var,EVar,Result).
muvy_eval_expression(decrement_op(P),Var,EVar,Result):- muvy_decrement_operator(P,Var,EVar,Result).
muvy_eval_expression(addition(A,B), Var,EVar, Result):- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), Result is Result1 + Result2.
muvy_eval_expression(subtract(A,B), Var,EVar, Result):- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), Result is Result1 - Result2.
muvy_eval_expression(multiply(A,B), Var,EVar, Result):- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), Result is Result1 * Result2.
muvy_eval_expression(divide(A,B), Var,EVar, Result):- muvy_eval_expression(A,Var,Var1,Result1),muvy_eval_expression(B,Var1,EVar,Result2), Result is Result1 / Result2.
muvy_eval_expression(P,Var,Var,Result):- muvy_data(P,Result).
muvy_eval_expression(P,Var,Var,Result):- muvy_eval_integer(P,ValueI),table1(ValueI,Var,Result).


% Defining the lookup by assigning values to variables.
table1(Value,[],_):- write(Value),fail.
table1(Value,[(Value,_,Value1)|_],Value1).
table1(Value1,[(Value2,_,_)|Value],Result):- Value1 \= Value2, table1(Value1,Value,Result).

% Defining the conditional and loop statements, if, if else, for loop, while loop, for range loop and printing the values.
muvy_eval_c(declaration(A,B),Var,EVar) :- muvy_eval_integer(B,ValueI),muvy_datatypes_initialize(A,Value),muvy_update(ValueI,A,Value,Var,EVar).
muvy_eval_c(declaration(A,B,C),Var,EVar) :- muvy_eval_integer(B,ValueI), muvy_data(C,Value),muvy_update(ValueI,A,Value,Var,EVar).
muvy_eval_c(assignment(A,B),Var,EVar):- muvy_eval_expression(B,Var,Var1,Result1),muvy_eval_integer(A,ValueI), muvy_insert(ValueI,Result1,Var1,EVar).
muvy_eval_c(assignment(A,B),Var,EVar):- muvy_ternary_operator(B,Var,Var1,Result1),muvy_eval_integer(A,ValueI), muvy_insert(ValueI,Result1,Var1,EVar).
muvy_eval_c(increment_op(P),Var,EVar):- muvy_increment_operator(P,Var,EVar,_).
muvy_eval_c(decrement_op(P),Var,EVar):- muvy_decrement_operator(P,Var,EVar,_).
muvy_eval_c(if(A,B),Var,EVar) :- muvy_boolean_comparison(A,Var,Var1,true),muvy_eval_c(B,Var1,EVar).
muvy_eval_c(if(A,_),Var,EVar) :- muvy_boolean_comparison(A,Var,EVar,false).
muvy_eval_c(ifel(A,B,_),Var,EVar) :- muvy_boolean_comparison(A,Var,Var1,true),muvy_eval_c(B,Var1,EVar).
muvy_eval_c(ifel(A,_,C),Var,EVar) :- muvy_boolean_comparison(A,Var,Var1,false),muvy_eval_c(C,Var1,EVar).
muvy_eval_c(while(A,B),Var,EVar) :- muvy_boolean_comparison(A,Var,Var1,true),muvy_eval_c(B,Var1,Var2), muvy_eval_c(while(A,B),Var2,EVar).
muvy_eval_c(while(A,_),Var,EVar) :- muvy_boolean_comparison(A,Var,EVar,false).
muvy_eval_c(seqnce(P),Var,EVar):- muvy_block(seqnce(P),Var,EVar).
muvy_eval_c(for(A,B),Var,EVar) :- muvy_limit_value(A,Var,Var1,true),muvy_block(B,Var1,Var2),muvy_eval_c(forcommand(A,B),Var2,EVar).
muvy_eval_c(for(A,_),Var,EVar) :- muvy_limit_value(A,Var,EVar,false).
muvy_eval_c(forcommand(A,B),Var,EVar) :- muvy_limit(A,Var,Var1,true),muvy_block(B,Var1,Var2),muvy_eval_c(forcommand(A,B),Var2,EVar).
muvy_eval_c(forcommand(A,_),Var,EVar) :- muvy_limit(A,Var,EVar,false).
muvy_eval_c(forvalue(A,B,C,D),Var,EVar):-muvy_data(B,IValue),muvy_eval_integer(A,ValueI),muvy_insert(ValueI,IValue,Var,Var1),muvy_boolean(comp_less(A,C),Var1,Var2,true),muvy_block(D,Var2,Var3),table1(ValueI,Var3,Value),Result is Value+1, muvy_insert(ValueI,Result,Var3,Var4),muvy_eval_c(forRangeLoop(A,C,D),Var4,EVar).
muvy_eval_c(forvalue(A,B,C,_),Var,EVar):- muvy_data(B,Value),muvy_eval_integer(A,ValueI),muvy_insert(ValueI,Value,Var,Var1),muvy_boolean(comp_less(A,C),Var1,EVar,false).
muvy_eval_c(forRangeLoop(A,C,D),Var,EVar):-muvy_eval_integer(A,ValueI), muvy_boolean(comp_less(A,C),Var,Var1,true),muvy_block(D,Var1,Var2), table1(ValueI,Var2,Value), Result is Value+1, muvy_insert(ValueI,Result,Var2,Var3),muvy_eval_c(forRangeLoop(A,C,D),Var3,EVar).
muvy_eval_c(forRangeLoop(A,C,_),Var,EVar):- muvy_boolean(comp_less(A,C),Var,EVar,false).
muvy_eval_c(print(P),Var,Var):- muvy_eval_expression(P,Var,Var,Result),write(Result).
muvy_eval_c(printnl(empty),Var,Var):-writeln("").
muvy_eval_c(printnl(P),Var,Var):- muvy_eval_expression(P,Var,Var,Result),writeln(Result).

% Updates the environment with change or assign of the variable.
muvy_update(ValueI,Kind,Value,[],[(ValueI,Kind,Value)]) :- muvy_datatype(Kind, Value , correct).
muvy_update(_Id,Kind,Value,X,X) :- muvy_datatype(Kind, Value , incorrect),!,fail.
muvy_update(ValueI,Kind,Value,[H|P],[H|R]) :- muvy_update(ValueI, Kind, Value, P, R).

% Defining the values to be inserted if the datatype declared is valid.
muvy_insert(ValueI,_,[],_):- write(ValueI),fail.
muvy_insert(ValueI,Value,[(ValueI,Kind,_)|P],[(ValueI,Kind,Value)|P]):- muvy_datatype(Kind,Value,correct).
muvy_insert(ValueI,Value,[(ValueI,Kind,OldVal)|P],[(ValueI,Kind,OldVal)|P]):- muvy_datatype(Kind,Value,incorrect),writeln(ValueI),!,fail.
muvy_insert(ValueI,Value,[H|T1],[H|T2]) :- H \= (ValueI,_), muvy_insert(ValueI, Value, T1, T2).

% Defining the expression for loop statements. 
muvy_limit_value(mvy_scope(A,B,_),Var,Resultant,true):- muvy_eval_c(A,Var,Var1),muvy_boolean_comparison(B,Var1,Resultant,true).
muvy_limit_value(mvy_scope(A,B,_),Var,Resultant,false):- muvy_eval_c(A,Var,Var1),muvy_boolean_comparison(B,Var1,Resultant,false).
muvy_limit(mvy_scope(_,B,C),Var,Resultant,true):- muvy_eval_c(C,Var,Var1),muvy_boolean_comparison(B,Var1,Resultant,true).
muvy_limit(mvy_scope(_,B,C),Var,Resultant,false):- muvy_eval_c(C,Var,Var1),muvy_boolean_comparison(B,Var1,Resultant,false).

% Run the muvy file.
run(MvyFile) :- 
    open(MvyFile, read, InFile), 
    read(InFile, P), 
    close(InFile), e_muvypgm(P).
    