'use strict'

class Zazo.Templates.CharactersUsed

  # private

  container = '.characters_used'
  feedback  = '.characters_count'
  textarea  = '[name="template[body]"]'

  updateFeedback = ->
    setFeedback getLength $(textarea).val()

  setFeedback = (value) ->
    $(feedback).html value

  getLength = (text) ->
    text.replace(/<%=.*?%>/g, '')
        .replace(/\s+(?=\s)/g, '')
        .replace(/\s+$/, '')
        .length

  # public

  constructor: ->
    feedback = "#{container} #{feedback}"

  init: ->
    updateFeedback()
    $(textarea).keyup -> updateFeedback()

$ ->
  (new Zazo.Templates.CharactersUsed()).init()
