function init()
    print "in PhotoAppMainScene init()"

    m.top.backgroundColor = "0x111111"
    m.top.backgroundUri=""
    m.loadingIndicator = m.top.FindNode("loadingIndicator")

    InitScreenStack()
    ShowGroupScreen()
end function

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function