index access
testArrayAccessFunctionArgumentsApply
	| method functionCall |
	method := self parseExpression: 'variable[1][2](1, 2);'.
	functionCall := method body statements first.
	self assert: functionCall identifier isBind.
	self assert: functionCall arguments size equals: 2.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess)