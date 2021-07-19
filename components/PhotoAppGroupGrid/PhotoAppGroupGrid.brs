sub init()

    'set up our poster grid
    m.posterGrid = m.top.FindNode("groupGrid")
    BuildContent()
    m.posterGrid.content = m.content
    m.posterGrid.SetFocus(true)
    m.posterGrid.observeField("itemSelected", "itemSelected")
    m.posterGrid.observeField("itemFocused",  "itemFocused")

    m.titleLabel = m.top.FindNode("titleLabel")

    m.top.observeField("visible","OnVisibleChanged")

    'set up the custom entry keyboard
    m.keyboard = m.top.FindNode("keyboard")
    m.keyboard.message = ["Please enter a valid Flickr GroupID or Group Alias"]
    m.keyboard.buttons = ["OK","Cancel"]
    m.keyboard.textEditBox.hintText = "Enter GroupID or Alias"
    m.keyboard.observeField("buttonSelected", "KeyboardButtonPressed")
    m.keyboard.observeField("wasClosed", "KeyboardDismissed")
    m.keyboard.visible = false

end sub

'builds the ContentNode tree for the posterGrid
sub BuildContent()
    groupGrid = createObject("roSGNode","ContentNode")
    for each group in m.global.groups
        newGroup = groupGrid.createChild("ContentNode")
        newGroup.hdposterurl = group.thumbnailURL
        newGroup.title = group.title
        newGroup.id = group.id
    end for
    m.content = groupGrid

end sub


function itemFocused()
    focusedIndex = m.posterGrid.itemFocused
    item = m.posterGrid.content.getChild(focusedIndex)
    'update the title label with the group name
    m.titleLabel.text = item.title
end function

function itemSelected()
    'print "item "; m.posterGrid.itemFocused; " was selected"

    focusedIndex = m.posterGrid.itemFocused
    item = m.posterGrid.content.getChild(focusedIndex)

    if item.id = "" 'empty id means it is "enter your own group" node. Show the keyboard
        m.posterGrid.SetFocus(false)
        m.keyboard.visible = true
        m.keyboard.SetFocus(true)
    else
        'set the groupID, which triggers the photo grid to load
        m.top.groupID = item.id
    end if
end function

function OnVisibleChanged()
    'when coming back in to the scene from the photo grid (or wherever), make sure we focus the posterGrid
    if m.top.visible = true
        m.posterGrid.SetFocus(true)
    end if
end function

function KeyboardButtonPressed()
    '0 is the "ok" button
    if m.keyboard.buttonSelected = 0
        m.top.groupID = m.keyboard.textEditBox.text 'set the groupID with whatever is in the textbox and attempt to load it
    end if    
    KeyboardDismissed()
end function

'hides the keyboard and returns focus to the posterGrid
function KeyboardDismissed()
    m.keyboard.textEditBox.text = ""
    m.keyboard.visible = false
    m.posterGrid.SetFocus(true)
end function