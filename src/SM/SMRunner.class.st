Class {
	#name : #SMRunner,
	#superclass : #Object,
	#instVars : [
		'state',
		'startState',
		'announcer',
		'params'
	],
	#category : #SM
}

{ #category : #'instance creation' }
SMRunner class >> on: aSMState [
	^ self new
		beginState: aSMState;
		activeState: aSMState;
		yourself
]

{ #category : #accessing }
SMRunner >> activeState: aSMState [ 
	| ev |
	ev := ChangeState new oldState: state; newState: aSMState.
	state ifNotNil: [state announcer unsubscribe: self].
	state := aSMState.
	state announcer when: ExitEvent send: #exit: to: self.
	announcer announce: ev
	
]

{ #category : #accessing }
SMRunner >> beginState: aState [

	startState:= aState
]

{ #category : #'as yet unclassified' }
SMRunner >> exit: anExitEvent [ 
	self activeState: (state nextStateForExit: anExitEvent name).
	StopStateException signal.
]

{ #category : #start }
SMRunner >> initialize [ 	
	super initialize.
	announcer := Announcer new.
	params := Dictionary new
]

{ #category : #accessing }
SMRunner >> paramAt: aString [ 
	^ params at: aString
]

{ #category : #'as yet unclassified' }
SMRunner >> paramAt: aString put: anInteger [ 
	params at: aString put: anInteger
]

{ #category : #start }
SMRunner >> start [
	announcer announce: RunnerStart new.
	[ state isEndState ] whileFalse: [ [state runOn: self] on: StopStateException do: [  ] ].
	announcer announce: RunnerStop new
]
