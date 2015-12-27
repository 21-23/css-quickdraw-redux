require '../../../stylesheets/occurrence-indicator.styl'

module.exports = ComponentView = ({items}) ->
	nxt.Element 'div',
		nxt.Class 'qd-occurrence-indicator'
		nxt.Binding items, (items) ->
			nxt.Fragment items.map ({pattern, is_matched}) ->
				nxt.Element 'div',
					nxt.Class 'qd-pattern'
					nxt.Binding is_matched, (is_matched) ->
						if is_matched then nxt.Class '-matched'
					nxt.Text pattern
