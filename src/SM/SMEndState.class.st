Class {
	#name : #SMEndState,
	#superclass : #StateMachine,
	#classInstVars : [
		'instance'
	],
	#category : #SM
}

{ #category : #accessing }
SMEndState class >> Finstance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
SMEndState class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
SMEndState >> children [
	^ OrderedCollection new
]

{ #category : #accessing }
SMEndState >> isEndState [
	^ true
]
