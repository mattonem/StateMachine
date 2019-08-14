Class {
	#name : #ChangeState,
	#superclass : #Announcement,
	#instVars : [
		'oldState',
		'newState'
	],
	#category : #SM
}

{ #category : #accessing }
ChangeState >> newState [
	^ newState
]

{ #category : #accessing }
ChangeState >> newState: aSMState [ 
	newState := aSMState 
]

{ #category : #accessing }
ChangeState >> oldState [
	^ oldState
]

{ #category : #'as yet unclassified' }
ChangeState >> oldState: anUndefinedObject [ 
	oldState := anUndefinedObject
]
