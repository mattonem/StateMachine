Class {
	#name : #ExitEvent,
	#superclass : #Announcement,
	#instVars : [
		'name'
	],
	#category : #SM
}

{ #category : #'instance creation' }
ExitEvent class >> name: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #accessing }
ExitEvent >> name [
	^ name
]

{ #category : #accessing }
ExitEvent >> name: aString [ 
	name := aString
]
