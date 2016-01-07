require '../../../stylesheets/occurrence-indicator.styl'

module.exports = ComponentView = ({items}) ->
	nxt.Element 'div',
		nxt.Class 'qd-occurrence-indicator'
		nxt.Binding items, (items) ->
			nxt.Fragment items.map ({pattern, toggled}) ->
				nxt.Element 'div',
					nxt.Class 'qd-pattern'
					nxt.Binding toggled, (toggled) ->
						if toggled then nxt.Class '-matched'
					nxt.Text pattern
