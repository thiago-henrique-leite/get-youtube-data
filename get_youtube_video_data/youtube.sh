# !usr/bin/env bash

# author: Thiago Henrique Leite <thiago.leite@unifesp.com>
# description: Get video and channel data on youtube by video url
# version 1.0

function youtube() {
        local _video=$(mktemp)
        local _channel=$(mktemp)

        wget $1 -O "$_video" &> /dev/null

        local _videoTitle=$(grep '<title>' "$_video" | sed -n 1p | sed 's/.*<meta name="title" content="//g' | sed 's/".*//g')
        local _views=$(grep 'videoViewCountRenderer' "$_video" | sed -n 1p | sed 's/<[^>]*>//g;s/ visualizações.*//g;s/.*"//g')
        local _likes=$(grep 'Gostei' "$_video" | sed 's/marcações \\"Gostei.*//g;s/.*"//g')
        local _dislikes=$(grep 'Não gostei' "$_video" | sed 's/marcações \\"Não gostei.*//g;s/.*"//g')
        local _postDate=$(sed -n '/dateText/{p; q;}' "$_video" | sed 's/videoSecondaryInfoRenderer.*//g;s/[{},"]//g;s/.*://g')

        local _url="https://youtube.com/channel"
        local _channelID=$(sed -n '/channelId/{p; q;}' "$_video" | sed 's/"videoId.*//g;s/.*content="//g;s/".*//g')
        
        wget "$_url/$_channelID" -O "$_channel" &> /dev/null

        local _channelTitle=$(grep '<title>' "$_channel" | sed 's/<\/title><meta name="description".*//g;s/.*<title>//g;s/ - YouTube.*//g')
        local _subscribers=$(grep 'subscriberCount' "$_channel" | sed 's/.*subscriberCountText":{"simpleText":"//g;s/".*//g')

        echo ""
        echo "Canal: $_channelTitle"
        echo "Inscritos: $_subscribers"
        echo ""
        echo "Vídeo: $_videoTitle"
        echo "Visualizações: $_views"
        echo "Likes: $_likes"
        echo "Dislikes: $_dislikes"
        echo "Data de publicação: $_postDate"
        echo ""
}

youtube "$1"