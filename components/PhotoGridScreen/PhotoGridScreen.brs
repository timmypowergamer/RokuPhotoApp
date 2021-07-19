function init()
    print "in PhotoGridScreen init()"
    
    m.rowRect = m.top.findNode("rowRect")
    m.rowList = m.rowRect.findNode("rowList")
    m.rowlist.setFocus(true)
    m.rowRect.visible = false

    m.titleLabel = m.top.findNode("titleLabel")

    m.mainPhoto = m.top.findNode("mainPhoto")

    m.rowList.observeField("rowItemSelected", "itemSelected")
end function

function itemSelected()
    'print "item "; m.rowList.rowItemSelected[1]; " in row "; m.rowList.rowItemSelected[0]; " was selected"

    focusedIndex = m.rowlist.rowItemFocused
    row = m.rowlist.content.getChild(focusedIndex[0])
    item = row.getChild(focusedIndex[1])
    subItem = item.getChild(0)
    m.titleLabel.text = subItem.title
    m.mainPhoto.uri = subItem.hdPosterUrl
    m.rowRect.visible = false
    m.rowlist.setFocus(false)
    m.mainPhoto.setFocus(true)
    m.currentIndex = focusedIndex

end function

function rowListContentChanged()
    print "rowListContentChanged"

    if m.top.content.title = "ok"
        m.rowList.content = m.top.content
        m.rowlist.rowItemFocused = [0,0]
        itemSelected()
        m.rowRect.visible = true
        m.rowlist.setFocus(true)
    else
        m.titleLabel.text = "Group could not be loaded. Please try another"
    end if



end function

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press and m.top.content.title = "ok"
        if m.rowRect.visible = false
            m.rowRect.visible = true
            m.rowlist.setFocus(true)
            result = true
        else if key = "up" OR key = "down"
            print key
            m.rowlist.rowItemFocused = m.currentIndex
            itemSelected()        
            result =  true
        end if
    endif
    return result
end function