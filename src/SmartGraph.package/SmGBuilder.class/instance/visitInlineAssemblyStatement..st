visiting assembly
visitInlineAssemblyStatement: aSolInlineAssemblyStatementNode
	^ aSolInlineAssemblyStatementNode asm_block acceptVisitor: self