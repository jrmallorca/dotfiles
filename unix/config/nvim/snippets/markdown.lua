return {
  -- Zettel template
  s("zettel", fmt([[
---
Created on: {}

tags: flashcards
---

- [ ] #todo Complete this thought
- [ ] #todo Link this thought

# Title

{}

---

## Flashcards

]] , {
    f(function()
      return os.date("%Y-%m-%d")
    end),
    i(1, "Insert zettel here")
  }))
}
