visit statement
visitDoWhileStatement: aSolDoWhileStatementNode
	| condition body while |
	while := buildingStrategy createDoWhileStatement.
	while parent: self currentContext.
	self
		using: while
		define: [ condition := aSolDoWhileStatementNode exp_test acceptVisitor: self.
			body := aSolDoWhileStatementNode statement acceptVisitor: self.
			while condition: condition.
			while body: body ].
	^ while