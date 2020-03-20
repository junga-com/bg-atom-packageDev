BgAtomPackageDevView = require './bg-atom-package-dev-view'
{CompositeDisposable} = require 'atom'

module.exports = BgAtomPackageDev =
  bgAtomPackageDevView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @bgAtomPackageDevView = new BgAtomPackageDevView(state.bgAtomPackageDevViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @bgAtomPackageDevView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'bg-atom-package-dev:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @bgAtomPackageDevView.destroy()

  serialize: ->
    bgAtomPackageDevViewState: @bgAtomPackageDevView.serialize()

  toggle: ->
    console.log 'BgAtomPackageDev was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
