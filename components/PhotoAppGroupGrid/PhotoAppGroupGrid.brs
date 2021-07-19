sub init()

    m.posterGrid = m.top.FindNode("groupGrid")
    BuildContent()
    m.posterGrid.content = m.content
    m.posterGrid.SetFocus(true)

    m.titleLabel = m.top.FindNode("titleLabel")

    m.posterGrid.observeField("itemSelected", "itemSelected")
    m.posterGrid.observeField("itemFocused",  "itemFocused")
    m.top.observeField("visible","OnVisibleChanged")

end sub

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
    m.titleLabel.text = item.title
end function

function itemSelected()
    print "item "; m.posterGrid.itemFocused; " was selected"

    focusedIndex = m.posterGrid.itemFocused
    item = m.posterGrid.content.getChild(focusedIndex)

    m.top.groupID = item.id
end function

function OnVisibleChanged()
    if m.top.visible = true
        m.posterGrid.SetFocus(true)
    end if
end function