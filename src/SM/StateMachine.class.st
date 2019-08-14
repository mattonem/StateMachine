Class {
	#name : #StateMachine,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #SM
}

{ #category : #processing }
StateMachine class >> endState [
	^ SMEndState instance
]

{ #category : #'instance creation' }
StateMachine class >> faceOrTail [
	<example>
	| input win loose  playTail playFace start |
	start := StateMachine
		group: [ input := StateMachine state
				name: 'input';
				exits: #(playTail playFace);
				action: [ :s :r | 
					s
						exit:
							(UIManager default
								chooseFrom: #(tail face)
								values: #(playTail playFace)
								lines: #(tail face)
								title: 'y') ].
			playTail := self playFaceOrTail: #tail.
			playFace := self playFaceOrTail: #face.
			input on: #playTail goto: playTail.
			input on: #playFace goto: playFace ].
	win := StateMachine state
		name: 'win';
		exits: #(end);
		action: [ :s | 
			UIManager default alert: 'u win'.
			s exit: #end ].
	loose := StateMachine state
		name: 'loose';
		exits: #(end);
		action: [ :s | 
			UIManager default alert: 'u loose'.
			s exit: #end ].
	start on: #win goto: win.
	start on: #loose goto: loose.
	win on: #end goto: StateMachine endState.
	loose on: #end goto: StateMachine endState.
	input runner start
]

{ #category : #'as yet unclassified' }
StateMachine class >> group [
	^ SMGroupState new
]

{ #category : #'instance creation' }
StateMachine class >> group: aBlockClosure [ 
	^ SMGroupState new with: aBlockClosure
]

{ #category : #'instance creation' }
StateMachine class >> playFaceOrTail: v [
	^ StateMachine state
		name: 'input';
		exits: #(win loose);
		action: [ :s :r | 
			#(tail face) atRandom = v
				ifTrue: [ s exit: #win ]
				ifFalse: [ s exit: #loose ] ]
]

{ #category : #'as yet unclassified' }
StateMachine class >> proxyState [
	^ SMProxyState new.
]

{ #category : #'instance creation' }
StateMachine class >> state [
	^ SMBlockState new
]

{ #category : #'instance creation' }
StateMachine class >> state: aString [
	^ SMBlockState new
		name: aString;
		yourself
]

{ #category : #'as yet unclassified' }
StateMachine >> allStates [
	^ self allStatesWithVisited: OrderedCollection new 
]

{ #category : #'as yet unclassified' }
StateMachine >> allStatesWithVisited: aCollection [
	^ (aCollection includes: self)
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ aCollection add: self.
			(self children
				flatCollect: [ :c | c ifNil: [ { } ] ifNotNil: [c allStatesWithVisited: aCollection] ])
				add: self;
				yourself ]
]

{ #category : #announcement }
StateMachine >> announcer [
	^ announcer
]

{ #category : #'as yet unclassified' }
StateMachine >> children [
	self subclassResponsibility 
]

{ #category : #announcement }
StateMachine >> initialize [
	super initialize.
	announcer := Announcer new
]

{ #category : #'instance creation' }
StateMachine >> state: aString [
	^ self class state: aString
]
