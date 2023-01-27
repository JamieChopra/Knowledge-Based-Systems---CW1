/* Knowledge Base (Frame Representation)*/

problem('trouble starting?').
problem('any fuel?').
problem('a high pitched pedal noise?').
problem('a spongey clutch pedal?').



/* User Interface */

/* Asks the user question and stores answer into the working memory */

begin :- dynamic(car/2),
    repeat,
    problem(A),
    write('Does your car have '), write(A), 
    read(B),
    assert(car(A,B)),
    \+ \+(A='a spongey clutch pedal?'),
    \+(answer).



/* Inference Engine (Production Rules) */

fault('damaged clutch') :- 
    car('trouble starting?',yes),
    car('any fuel?',yes),
    car('a high pitched pedal noise?',yes),
    car('a spongey clutch pedal?',yes).

fault('damaged brakes') :-
    \+(fault('damaged clutch')),
    car('trouble starting?',yes),
    car('any fuel?',yes),
    car('a high pitched pedal noise?',yes).

fault('no fuel') :-
    \+(fault('damaged clutch')),
    \+(fault('damaged brakes')),
    car('trouble starting?',yes).

fault('a dead battery') :- 
    \+(fault('damaged clutch')),
    \+(fault('damaged brakes')),
    \+(fault('no fuel')),
    car('any fuel?',yes).

/* Output */

answer:- carproblem.

carproblem :- 
fault(A), 
write('Your car may have '), 
write(A),nl.