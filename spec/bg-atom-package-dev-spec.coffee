BgAtomPackageDev = require '../lib/bg-atom-package-dev'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "BgAtomPackageDev", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('bg-atom-package-dev')

  describe "when the bg-atom-package-dev:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.bg-atom-package-dev')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'bg-atom-package-dev:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.bg-atom-package-dev')).toExist()

        bgAtomPackageDevElement = workspaceElement.querySelector('.bg-atom-package-dev')
        expect(bgAtomPackageDevElement).toExist()

        bgAtomPackageDevPanel = atom.workspace.panelForItem(bgAtomPackageDevElement)
        expect(bgAtomPackageDevPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'bg-atom-package-dev:toggle'
        expect(bgAtomPackageDevPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.bg-atom-package-dev')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'bg-atom-package-dev:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        bgAtomPackageDevElement = workspaceElement.querySelector('.bg-atom-package-dev')
        expect(bgAtomPackageDevElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'bg-atom-package-dev:toggle'
        expect(bgAtomPackageDevElement).not.toBeVisible()
