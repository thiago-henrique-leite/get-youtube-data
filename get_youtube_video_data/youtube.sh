# !usr/bin/env bash

# author: Thiago Henrique Leite <thiago.leite@unifesp.com>
# description: Get video and channel data on youtube by video url
# version 2.0

function youtube() {

        _bl="\e[34;1m"
        _gr="\e[32;1m"
        _red="\e[31;1m"
        _of="\e[m"

        local _video=$(mktemp)
        local _channel=$(mktemp)

        wget "$1" -O "$_video" &> /dev/null

        local _videoTitle=$(grep '<title>' "$_video" | sed -n 1p | sed 's/.*<meta name="title" content="//g' | sed 's/".*//g')
        local _views=$(grep 'videoViewCountRenderer' "$_video" | sed -n 1p | sed 's/<[^>]*>//g;s/ visualizações.*//g;s/.*"//g')
        local _likes=$(grep 'Gostei' "$_video" | sed 's/marcações \\"Gostei.*//g;s/.*"//g')
        local _dislikes=$(grep 'Não gostei' "$_video" | sed 's/marcações \\"Não gostei.*//g;s/.*"//g')
        local _postDate=$(sed -n '/dateText/{p; q;}' "$_video" | sed 's/videoSecondaryInfoRenderer.*//g;s/[{},"]//g;s/.*://g')

        local _url="https://youtube.com/channel"
        local _channelID=$(sed -n '/channelId/{p; q;}' "$_video" | sed 's/"videoId.*//g;s/.*content="//g;s/".*//g')
        wget "$_url/$_channelID" -O "$_channel" &> /dev/null

        local _channelTitle=$(grep '<title>' "$_channel" | sed 's/<\/title><meta name="description".*//g;s/.*<title>//g;s/ - YouTube.*//g')
        local _subscribers=$(grep 'subscriberCount' "$_channel" | sed 's/.*subscriberCountText//g;s/.*"}},"simpleText"//g;s/"},"tvBanner".*//g;s/:"//g')

        echo ""
        echo -e "$_red    ############# YouTube #############"
        echo ""
        echo -e "$_bl Canal:$_gr $_channelTitle"
        echo -e "$_bl Inscritos:$_gr $_subscribers"
        echo ""
        echo -e "$_bl Vídeo:$_gr $_videoTitle"
        echo -e "$_bl Visualizações:$_gr $_views"
        echo -e "$_bl Likes:$_gr $_likes"
        echo -e "$_bl Dislikes:$_gr $_dislikes"
        echo -e "$_bl Data de publicação:$_gr $_postDate $_of"
        echo ""
}
youtube "$1"
