sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    'print "in showChannelSGScreen"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    m.global = screen.getGlobalNode()

    'load our config file. (at the moment this is just for the flickr api key)
    LoadConfigFile()

    scene = screen.CreateScene("PhotoAppMainScene")
    screen.show()

    'start message loop to respond to exit message
    while(true)
        msg = wait(0, m.port)
	msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

sub LoadConfigFile()
    
    config = {}
    groups = []
    text=ReadAsciiFile("pkg:/config.json")
    json = ParseJson(text)
    if json <> invalid
        config.flickrAPIKey = json.flickrAPIKey
        for each group in json.groups
            newGroup = {}
            newGroup.id = group.id
            newGroup.thumbnailURL = group.thumbnailURL
            newGroup.title = group.title
            groups.Push(newGroup)
        end for
        config.groups = groups
    end if

    m.global.AddFields(config)
end sub