Class {
	#name : #SMProxyState,
	#superclass : #StateMachine,
	#instVars : [
		'next'
	],
	#category : #SM
}

{ #category : #'as yet unclassified' }
SMProxyState >> isEndState [
	^ false
]

{ #category : #'as yet unclassified' }
SMProxyState >> next: aSMEndState [ 
	next := aSMEndState
]

{ #category : #'as yet unclassified' }
SMProxyState >> nextStateForExit: aString [ 
	^next
]

{ #category : #'as yet unclassified' }
SMProxyState >> runOn: aSMRunner [ 
	announcer announce: (ExitEvent name: #next).
]
