
#let autoeqnum(numbering: "(1)", mode: "ref", doc) = {
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
		set math.equation(numbering: numbering)
		show math.equation.where(block: true, numbering: numbering): it => {
			if it.has("label") and counter("autoeqnum?" + str(it.at("label"))).final().at(0) == 1 {
				it
			} else {
				counter(math.equation).update(n => n - 1)
				math.equation(it.body, block: true, numbering: none)
			}
		}
		show ref: it => {
			let el = it.element
			if el != none and el.func() == math.equation {
				counter("autoeqnum?" + str(it.target)).update(1)
			}
			it
		}
		doc
	} else if mode == "never" {
		set math.equation(numbering: none)
		doc
	}
}
