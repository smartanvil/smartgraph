visiting
visitAssemblySwitch: aSolAssemblySwitchNode
	| switch expression |
	expression := aSolAssemblySwitchNode expression acceptVisitor: self.
	switch := buildingStrategy createSwitch.
	switch expression: expression.
	switch parent: self currentContext.
	self
		using: switch
		define: [ switch cases: (aSolAssemblySwitchNode caseses acceptVisitor: self) ].
	^ switch