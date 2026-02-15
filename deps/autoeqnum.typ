
#let autoeqnum(numbering: "1", mode: "ref", doc) = {
	if numbering == none {
		// do not input none
		doc
	} else if mode == "always" {
		set math.equation(numbering: numbering)
		doc
	} else if mode == "label" {
		set math.equation(numbering: numbering)
		show math.equation.where(block: true, numbering: numbering): it => {
			if it.has("label") {
				it
			} else {
				counter(math.equation).update(n => n - 1)
				math.equation(it.body, block: true, numbering: none)
			}
		}
		doc
	} else if mode == "ref" {
		let state-visited = state("autoeqnum-visited", ().to-dict())
		set math.equation(numbering: numbering)
		show math.equation.where(block: true, numbering: numbering): it => {
			let visited = state-visited.final()
			if it.has("label") and str(it.at("label")) in visited {
				it
			} else {
				counter(math.equation).update(n => n - 1)
				math.equation(it.body, block: true, numbering: none)
			}
		}
		show ref: it => {
			let el = it.element
			if el != none and el.func() == math.equation {
				state-visited.update(visited => {
					visited.insert(str(it.target), true)
					visited
				})
			}
			it
		}
		doc
	} else if mode == "never" {
		set math.equation(numbering: none)
		doc
	}
}
