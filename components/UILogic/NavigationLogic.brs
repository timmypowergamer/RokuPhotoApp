sub ShowGroupScreen()
    m.GroupScreen = CreateObject("roSGNode", "PhotoAppGroupGrid")
    m.GroupScreen.ObserveField("groupID", "OnGroupSelected")
    ShowScreen(m.GroupScreen)
end sub

sub ShowGridScreen(groupID as string)
    m.GridScreen = CreateObject("roSGNode", "PhotoGridScreen")
    ShowScreen(m.GridScreen)
    LoadGroupContent(groupID)
end sub

sub OnGroupSelected(event as Object)
    ShowGridScreen(m.GroupScreen.groupID)
end sub