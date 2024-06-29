*** Variables ***
# ExtensionsPage
${ExtensionsPage_Title}
...                                 dom=document.querySelector("extensions-manager").shadowRoot.querySelector("#toolbar").shadowRoot.querySelector("#toolbar").shadowRoot.querySelector("h1")

# ExtensionsSideBar
${ExtensionsSideBar_Shortcuts}
...                                 dom=document.querySelector("extensions-manager").shadowRoot.querySelector("extensions-sidebar").shadowRoot.querySelector("#sectionsShortcuts")

# ShortcutCard
${ShortcutCard_Title}
...                                 dom=document.querySelector("extensions-manager").shadowRoot.querySelector("extensions-keyboard-shortcuts").shadowRoot.querySelector(".card-title")
${ShortcutCard_Edit}
...                                 dom=document.querySelector("extensions-manager").shadowRoot.querySelector("extensions-keyboard-shortcuts").shadowRoot.querySelector("extensions-shortcut-input").shadowRoot.querySelector("#edit")
${ShortcutCard_Input}
...                                 dom=document.querySelector("extensions-manager").shadowRoot.querySelector("extensions-keyboard-shortcuts").shadowRoot.querySelector("extensions-shortcut-input").shadowRoot.querySelector("#input").shadowRoot.querySelector("#input")
