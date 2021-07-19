sub LoadGroupContent(groupID as string)
    m.contentTask = CreateObject("roSGNode", "GroupLoaderTask")
    m.contentTask.flickrAPIKey = m.global.flickrAPIKey
    m.contentTask.groupID = groupID
    m.contentTask.ObserveField("content", "OnContentLoaded")
    m.contentTask.control = "RUN"
    m.loadingIndicator.visible = true
end sub

sub OnContentLoaded()
    m.GridScreen.SetFocus(true)
    m.loadingIndicator.visible = false
    m.GridScreen.content = m.contentTask.content
end sub
