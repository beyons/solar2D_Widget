module(..., package.seeall)

local xml = require( "library.xml" ).newParser()
local print_r = require("library.utility").print_r

function feed(filename, base)
    rssFile = "index.rss"
    if filename then
        rssFile = filename
    end
    baseDir = system.CachesDirectory
    if base then
        baseDir = base
    end
    
    local feed = {}
    local stories = {}
    --print("Parsing the feed")
    local myFeed = xml:loadFile(rssFile, baseDir)
    if myFeed == nil then return nil end
    --utility.print_r(myFeed)
    local items = myFeed.child[1].child
    -- print_r(items)
    local i
    --print("Number of items: " .. #items)
    local l = 1
    for i = 1, #items do
        local item = items[i]
        local enclosuers = {}
        local e = 1
        local story = {}
        local thumbnail = {}
        if item.name == "title" then feed.title = item.value end
        if item.name == "link"  then feed.link = item.value end
        if item.name == "description" then feed.description = item.value end
        if item.name == "pubDate" then feed.pubDate = item.value end

        if item.name == "item" then -- we have a story batman!
            --utility.print_r(item.child)
            local j
            for j = 1, #item.child do
                if item.child[j].name == "title" then
                    story.title = item.child[j].value
                end
                if item.child[j].name == "link" then
                    story.link = item.child[j].value
                end
                if item.child[j].name == "pubDate" then
                    story.pubDate = item.child[j].value
                end
                if item.child[j].name == "description" then
                    story.description = item.child[j].value
                end
            end
            --utility.print_r(story)
            stories[l] = {}
            stories[l].link = story.link
            stories[l].title = story.title
            stories[l].pubDate = story.pubDate
            stories[l].description = story.description
            l = l + 1
        end
    end
    feed.items = stories
    return feed
end
