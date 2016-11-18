# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Nando Rossi"
	twitter: ""
	description: ""


## Load video
vid = new VideoLayer
	width: 750
	height: 720
	video: "images/balloons.mp4"

vid.center()

vid.onClick ->
	if this.player.paused
		this.player.play()
	else
		this.player.pause()

## Define the path layer (where the circle will go)
layerPath = new Layer x:0, y:0, width:400, height:400, backgroundColor:"transparent"

layerPath.center()

layerPath.html = '<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 400 400" enable-background="new 0 0 400 400" xml:space="preserve">
	 <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="100%" stop-color="#FFC900"/>
        </linearGradient>
    </defs>

<path id="svgPath2" xmlns="http://www.w3.org/2000/svg" id="svg_2" d="m20,200c0,-99.447517 80.552483,-180 180,-180c99.44751,0 180,80.552483 180,180c0,99.44751 -80.55249,180 -180,180c-99.447517,0 -180,-80.55249 -180,-180z" stroke-linecap="round" stroke-linejoin="null" stroke-width="22" stroke="#ccc" fill="none" transform="rotate(90, 200, 200)" stroke-dasharray="1132,1132" stroke-dashoffset="1132"/>

<path id="svgPath" xmlns="http://www.w3.org/2000/svg" id="svg_2" d="m20,200c0,-99.447517 80.552483,-180 180,-180c99.44751,0 180,80.552483 180,180c0,99.44751 -80.55249,180 -180,180c-99.447517,0 -180,-80.55249 -180,-180z" stroke-linecap="round" stroke-linejoin="null" stroke-width="22" stroke=url(#grad1) fill="none" transform="rotate(90, 200, 200)" stroke-dasharray="1132,1132" stroke-dashoffset="1132"/>

</svg>'

pathLength = 0
pathLength2 = 0
data = 0

layerPath.scale = 1.5

## Update circle with video
Events.wrap(vid.player).addEventListener "timeupdate", ->
	print this.currentTime
	sliderNum = Utils.modulate(this.currentTime, [0,this.duration], [0,100])#Utils.round(Utils.modulate(this.currentTime, [0,this.duration], [0,100]),0)
	svgPath = document.getElementById('svgPath')
	pathLength = svgPath.getTotalLength()
	svgPath.style.strokeDasharray = pathLength + ' ' + pathLength;
	svgPath.style.strokeDashoffset = pathLength
	svgPath.getBoundingClientRect()
# 	svgPath.style.transition = svgPath.style.WebkitTransition = 'stroke-dashoffset 2s ease-in-out'
	svgPath.style.strokeDashoffset = pathLength * (1 - (sliderNum / 100))