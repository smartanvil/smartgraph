visiting assembly
visitAssemblyCase: aSolAssemblyCaseNode
	| case |
	case := buildingStrategy
		createCaseOn:
			(aSolAssemblyCaseNode value
				ifNil: [ aSolAssemblyCaseNode defaultToken value asSymbol ]
				ifNotNil: [ :val | val acceptVisitor: self ]).
	case parent: self currentContext.
	self
		using: case
		define: [ case body: (aSolAssemblyCaseNode body acceptVisitor: self) ].
	^ case