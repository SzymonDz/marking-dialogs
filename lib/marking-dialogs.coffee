{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'marking-dialogs:toggle': => @toggle()
      'marking-dialogs:wrap-with-<d>': => @tagg("<d", 0)
      'marking-dialogs:wrap-with-<ds>': => @tagg("<d type='song'", 0)
      'marking-dialogs:wrap-with-<dt>': => @tagg("<d type='thought'", 0)
      'marking-dialogs:wrap-with-<dl>': => @tagg("<d type='letter'", 0)
      'marking-dialogs:wrap-with-<dp>': => @tagg("<d type='poem'", 0)
      'marking-dialogs:wrap-with-<dc>': => @tagg("<d type='continuation'", 0)
      'marking-dialogs:wrap-with-<d+>': => @tagg("<d", 1)
      'marking-dialogs:wrap-with-<ds+>': => @tagg("<d type='song'", 1)
      'marking-dialogs:wrap-with-<dt+>': => @tagg("<d type='thought'", 1)
      'marking-dialogs:wrap-with-<dl+>': => @tagg("<d type='letter'", 1)
      'marking-dialogs:wrap-with-<dp+>': => @tagg("<d type='poem'", 1)
      'marking-dialogs:wrap-with-<dc+>': => @tagg("<d type='continuation'", 1)

  deactivate: ->
    @subscriptions.dispose()

  tagg: (text, lvl)->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      rest =  if lvl == 1 then text + " layer='" + lvl + "'" else text
      editor.insertText(rest + ">" + selection +  "</d>")

  toggle: ->
    console.log 'MarkingDialogs was toggled!'
