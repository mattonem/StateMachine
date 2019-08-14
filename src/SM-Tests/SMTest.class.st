"
A SMTest is a test class for testing the behavior of SM
"
Class {
	#name : #SMTest,
	#superclass : #TestCase,
	#category : #'SM-Tests'
}

{ #category : #tests }
SMTest >> groupLoveStateMachine [
	| little lot passion nope group |
	group := StateMachine group: [ little := self petalState: 'a little'.
			lot := self petalState: 'a lot'.
			passion := self petalState: 'passionately'.
			nope := self petalState: 'not at all'.
			little on: #next goto: lot.
			lot on: #next goto: passion.
			passion on: #next goto: nope.
			nope on: #next goto: little.
			little ].
	^ group
]

{ #category : #tests }
SMTest >> loveStateMachine: nbPetal [
	| start group |
	start := StateMachine state
		name: 'start';
		exits: #(next);
		action: [ :s :r | 
			r paramAt: #petals put: nbPetal.
			s exit: #next ].
	group := self groupLoveStateMachine.
	start on: #next goto: group.
	group on: #end goto: StateMachine endState.
	^ start
]

{ #category : #tests }
SMTest >> petalState: name [
	^ StateMachine state
		name: name;
		exits: #(next end);
		action: [ :s :r | 
			(r paramAt: #petals) == 1
				ifTrue: [ r paramAt: #love put: name.
					s exit: #end. ]
				ifFalse: [ r paramAt: #petals put: (r paramAt: #petals) - 1.
					s exit: #next ] ]
]

{ #category : #tests }
SMTest >> testInstanceCreation [
	| state1 state2 boolean |
	boolean := false.
	state1 := StateMachine state
		name: 'state1';
		exits: #(exit1);
		action: [ :state | state exit: #exit1 ].
	state2 := StateMachine state
		name: 'state2';
		exits: #(exit2);
		action: [ :state | 
			boolean := true.
			state exit: 'exit2' ].
	state1 on: 'exit1' goto: state2.
	state2 on: 'exit2' goto: StateMachine endState.
	state1 runner start.
	self assert: boolean
]

{ #category : #tests }
SMTest >> testPetal [
	| machine runner |
	machine := self loveStateMachine: 1.
	runner := machine runner.
	runner start.
	self assert: (runner paramAt: #love) equals: 'a little'.
	machine := self loveStateMachine: 10.
	runner := machine runner.
	runner start.
	self assert: (runner paramAt: #love) equals: 'a lot'
	
]
