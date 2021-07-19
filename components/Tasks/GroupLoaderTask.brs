sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    print "attempting to load group '"+ m.top.groupID +"' photo pool from Flickr"

    'call the flickr REST api to get the list of photos in the group.
    readFromFlickr = CreateObject("roUrlTransfer")
    readFromFlickr.SetCertificatesFile("common:/certs/ca-bundle.crt")
    readFromFlickr.AddHeader("X-Roku-Reserved-Dev-Id", "")
    readFromFlickr.InitClientCertificates()
    'build the url
    url = "https://www.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=" + m.top.flickrAPIKey
    if Instr(0, m.top.groupID, "@") <> 0
        url = url + "&group_id=" + m.top.groupID
    else
        url = url + "&group_path_alias=" + m.top.groupID
    end if
    url = url + "&per_page=100"
    readFromFlickr.setUrl(url)

    'create an XML element to parse the data from the repsonse
    photoGroupXML = CreateObject("roXMLElement")
    photoGroupXML.parse(readFromFlickr.GetToString())

    'create our content tree
    photolistcontent = CreateObject("roSGNode","ContentNode")
    photolistcontent.title = photoGroupXML.getAttributes().stat 

    if photoGroupXML.getAttributes().stat = "ok"
        contentList = photolistcontent.createChild("ContentNode")     
        for each photo in photoGroupXML.photos.GetNamedElements("photo")            
            photothumbnail = contentList.createChild("ContentNode")
            attributes = photo.GetAttributes()

            'create the thumbnail to appear in the rowList
            photothumbnail.hdposterurl = "http://live.staticflickr.com/" + attributes.server.toStr() + "/" + attributes.id.toStr() + "_" + attributes.secret.toStr() + "_q.jpg"
            photothumbnail.title = attributes.title.toStr()

            'create the full-size photo
            photocontent = photothumbnail.createChild("ContentNode")
            photocontent.hdposterurl = "http://live.staticflickr.com/" + attributes.server.toStr() + "/" + attributes.id.toStr() + "_" + attributes.secret.toStr() + "_b.jpg"
            photocontent.title = attributes.title.toStr()
            
        end for
    end if

    'assign to top interface
    m.top.content = photolistcontent
end sub