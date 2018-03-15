visiting - term
visitTermExpression: aSolTermExpressionNode
	| term prev |
	" Variable definition "
	(self termIsVariableDefinition: aSolTermExpressionNode)
		ifTrue: [ term := self manageVariableDefinition: aSolTermExpressionNode ].
	"Constructor"
	(term isNil and: [ self termIsConstructor: aSolTermExpressionNode ])
		ifTrue: [ prev := 0.
			term := self manageConstructorCall: aSolTermExpressionNode ].
	" Function call / Message send "
	(term isNil and: [ (self termIsFunctionCall: aSolTermExpressionNode) or: [ self termIsMessageSend: aSolTermExpressionNode ] ])
		ifTrue: [ prev := 0.
			term := self manageMessageSend: aSolTermExpressionNode ].
	" Just literal access "
	(term isNil and: [ self termIsLiteralAccess: aSolTermExpressionNode ])
		ifTrue: [ term := self manageLiteralAccess: aSolTermExpressionNode ].
	" Single access "
	(term isNil and: [ self termIsSingleAccess: aSolTermExpressionNode ])
		ifTrue: [ term := self manageSingleAccess: aSolTermExpressionNode ].
	" Cascade access "
	(term isNil and: [ self termIsCascadeAccess: aSolTermExpressionNode ])
		ifTrue: [ term := self manageCascadeAccess: aSolTermExpressionNode ].

	" Nested term management "
	(term isNotNil and: [ self termAccessesReturningExpression: aSolTermExpressionNode ])
		ifTrue: [ self assert: prev = 0.
			self using: term define: [ term := aSolTermExpressionNode nested_term acceptVisitor: self ] ].
	(term isNotNil and: [ self termExecutesReturningExpression: aSolTermExpressionNode ])
		ifTrue: [ term := self manageExecute: term asFunctionWith: aSolTermExpressionNode nested_func_call ].
	term ifNil: [ self halt ].
	^ term