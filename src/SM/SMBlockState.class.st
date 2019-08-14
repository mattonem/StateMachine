Class {
	#name : #SMBlockState,
	#superclass : #StateMachine,
	#instVars : [
		'name',
		'exits',
		'actionBlock'
	],
	#category : #SM
}

{ #category : #accessing }
SMBlockState >> action: aBlockClosure [ 
	actionBlock := aBlockClosure 
]

{ #category : #'as yet unclassified' }
SMBlockState >> children [
	^ exits values asOrderedCollection
]

{ #category : #'as yet unclassified' }
SMBlockState >> exit: aString [
	exits at: aString ifAbsent: [ Error signal: 'cannot exit this way' ].
	announcer announce: (ExitEvent name: aString).
]

{ #category : #'as yet unclassified' }
SMBlockState >> exits [
	^ exits
]

{ #category : #'as yet unclassified' }
SMBlockState >> exits: aCollection [ 
	aCollection do: [ :ex | exits at: ex put: nil ]
]

{ #category : #accessing }
SMBlockState >> initialize [
	super initialize.
	exits := Dictionary new.

]

{ #category : #'as yet unclassified' }
SMBlockState >> isEndState [
	^false
]

{ #category : #accessing }
SMBlockState >> name: aString [ 
	name := aString
]

{ #category : #accessing }
SMBlockState >> nextStateForExit: aString [ 
	^ exits at: aString
]

{ #category : #accessing }
SMBlockState >> on: aString goto: aSMState [
	exits
		at: aString
		ifPresent: [ exits at: aString put: aSMState ]
		ifAbsent: [ Error signal: 'exit unknown' ]
]

{ #category : #'as yet unclassified' }
SMBlockState >> runOn: aSMRunner [ 
	^ actionBlock cull: self cull: aSMRunner
]

{ #category : #processing }
SMBlockState >> runner [
	^ SMRunner on: self
]
