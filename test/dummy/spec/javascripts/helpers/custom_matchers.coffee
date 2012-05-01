beforeEach ->
  @addMatchers

    toBeAnInstanceOf: (expected) -> @actual instanceof expected

    toHaveBeenCalledWithNew: -> @actual.calledWithNew()