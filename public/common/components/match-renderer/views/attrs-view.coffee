AttrsView = (attrs) ->
	parts = for attrName, attrValue of attrs
		[
			nxt.Element 'span',
				nxt.Class 'attr-name'
				nxt.Text " #{attrName}"
			nxt.Element 'span',
				nxt.Class 'punctuator'
				nxt.Text '='
			nxt.Element 'span',
				nxt.Class 'attr-value'
				nxt.Text "\"#{attrValue}\""
		]

	nxt.Fragment parts...

module.exports = AttrsView
