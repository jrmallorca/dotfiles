return {
  -- Zettel template
  s("zettel", fmt([[
---
Created on: {}

tags: [to-complete, to-tag, to-add-links, to-generate-flashcards]
deck: Zettelkasten
---

# Title

{}

---

## References

-

---

## Flashcards

]] , {
    f(function()
      return os.date("%Y-%m-%d")
    end),
    i(1, "Insert zettel here")
  })),

  s("flashcards", fmt([[
Q: {}
A: {}
]] , {
    i(1, "Insert question here"),
    i(2, "Insert answer here")
  }))
}
