sub init()
    m.photo = m.top.FindNode("mainPhoto")
    m.title = m.top.FindNode("title")
end sub

sub photoContentChanged()
    m.photo.uri = m.top.contentToDisplay.hdposterurl
    m.title.text = m.top.contentToDisplay.title
end sub