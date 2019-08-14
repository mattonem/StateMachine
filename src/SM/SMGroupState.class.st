Class {
	#name : #SMGroupState,
	#superclass : #SMProxyState,
	#instVars : [
		'groupEnds'
	],
	#category : #SM
}

{ #category : #'as yet unclassified' }
SMGroupState >> newExitState [
	^ StateMachine proxyState
]

{ #category : #'as yet unclassified' }
SMGroupState >> nextStateForExit: aString [ 
	^ next
]

{ #category : #'as yet unclassified' }
SMGroupState >> on: aString goto: aSMEndState [ 
	 (groupEnds at: aString) next: aSMEndState.
]

{ #category : #'as yet unclassified' }
SMGroupState >> with: aBlockClosure [
	| content exits |
	content := aBlockClosure value.
	next := content.
	groupEnds := Dictionary new.
	content allStates
		do: [ :state | 
			state exits
				associationsDo: [ :ass | 
					ass value
						ifNil: [ state
								on: ass key
								goto: (groupEnds at: ass key ifAbsentPut: self newExitState) ] ] ]
]
