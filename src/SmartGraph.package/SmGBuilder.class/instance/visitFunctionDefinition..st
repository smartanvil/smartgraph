visiting - functions
visitFunctionDefinition: aSolFunctionDefinitionNode
	| method identifier parameters |
	parameters := aSolFunctionDefinitionNode parameters
		acceptVisitor: self.
	identifier := (aSolFunctionDefinitionNode identifier
		acceptVisitor: self)
		asMethodIdentifier: buildingStrategy
		parameters: parameters.
	method := aSolFunctionDefinitionNode block
		ifNil: [ buildingStrategy createAbstractMethod: identifier ]
		ifNotNil: [ buildingStrategy createMethod: identifier ].
	method parent: self currentContext.
	self
		using: method
		define: [ method parameters: parameters.
			method
				returns:
					(SmGTuple new
						parent: self currentContext;
						yourself).
			method returns
				values:
					(aSolFunctionDefinitionNode returned_types
						ifNotNil: [ :r | r acceptVisitor: self ]).
			aSolFunctionDefinitionNode modifiers acceptVisitor: self.
			aSolFunctionDefinitionNode block
				ifNotNil: [ method
						body:
							((aSolFunctionDefinitionNode block acceptVisitor: self)
								asSmGSequenceNode: buildingStrategy) ] ].
	self currentContext propertyAt: identifier put: method.
	^ method