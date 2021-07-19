sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    m.global = screen.getGlobalNode()

    'load our config file.
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
    'loads the contents of config.json and dumps them into the global object for easy access later
    config = {}
    groups = []
    text=ReadAsciiFile("pkg:/config.json")
    json = ParseJson(text)
    if json <> invalid
        config.flickrAPIKey = json.flickrAPIKey 'I put the API key in the json so I don't distribute it to a public repo
        'set up the groups that are displayed by default.
        for each group in json.groups
            newGroup = {}
            newGroup.id = group.id
            newGroup.thumbnailURL = group.thumbnailURL  'ideally, thumbnails and titles should maybe be parsed from Flickr's API? but I'm on a time limit here dangit :P
            newGroup.title = group.title
            groups.Push(newGroup)
        end for
        'create one final node that acts as our "enter your own" group
        customGroup = {}
        customGroup.id = ""
        customGroup.thumbnailURL = "pkg:/images/customgroup_icon.png"
        customGroup.title = "Enter Flickr GroupID"
        groups.Push(customGroup)
        config.groups = groups
    end if

    m.global.AddFields(config)
end sub