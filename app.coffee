# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Nando Rossi"
	twitter: ""
	description: ""


Framer.Device.deviceType = "iphone-5s-silver-hand"

## Define the path layer (where the circle will go)
layerPath = new Layer x:0, y:0, width:400, height:400, backgroundColor:"transparent"

layerPath.center()

layerPath.html = '<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 400 400" enable-background="new 0 0 400 400" xml:space="preserve">
	 <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="#00E2F5"/>
            <stop offset="100%" stop-color="#F5005F"/>
        </linearGradient>
    </defs>

<path id="svgPath2" xmlns="http://www.w3.org/2000/svg" id="svg_2" d="m20,200c0,-99.447517 80.552483,-180 180,-180c99.44751,0 180,80.552483 180,180c0,99.44751 -80.55249,180 -180,180c-99.447517,0 -180,-80.55249 -180,-180z" stroke-linecap="round" stroke-linejoin="null" stroke-width="22" stroke="#ccc" fill="none" transform="rotate(90, 200, 200)" stroke-dasharray="1132,1132" stroke-dashoffset="1132"/>

<path id="svgPath" xmlns="http://www.w3.org/2000/svg" id="svg_2" d="m20,200c0,-99.447517 80.552483,-180 180,-180c99.44751,0 180,80.552483 180,180c0,99.44751 -80.55249,180 -180,180c-99.447517,0 -180,-80.55249 -180,-180z" stroke-linecap="round" stroke-linejoin="null" stroke-width="22" stroke=url(#grad1) fill="none" transform="rotate(90, 200, 200)" stroke-dasharray="1132,1132" stroke-dashoffset="1132"/>

</svg>'

pathLength = 0
pathLength2 = 0
data = 0

layerPath.scale = 1.5

#Create a container to hold the slider UI
sliderContainer = new Layer width:550, height:200,backgroundColor:"transparent"
sliderContainer.centerX()
sliderContainer.y = Screen.height - 300

#The slider background
slider = new Layer width:350, height:2, backgroundColor:"#999"
slider.superLayer = sliderContainer
slider.x = 50
slider.centerY()

#The slider highlight
sliderBar = new Layer width:0, height:2, backgroundColor:"#CC3A88"
sliderBar.superLayer = sliderContainer
sliderBar.x = 50
sliderBar.centerY()

#The slider drag ui
sliderDrag = new Layer width:60, height:60, borderRadius:30, backgroundColor:"#FFF"
sliderDrag.superLayer = sliderContainer
sliderDrag.x = 50
sliderDrag.centerY()
sliderDrag.draggable.enabled = true
sliderDrag.draggable.vertical = false
sliderDrag.draggable.constraints = {x:50, y:0, width:350, height:0}
sliderDrag.draggable.overdrag = false

#slider reading by mapping the drag x position to 0 - 100
sliderText = new Layer width:100, height:100, backgroundColor:"transparent"
sliderText.superLayer = sliderContainer
sliderText.x = 400
sliderText.centerY()
sliderText.html = "0"
sliderText.style = {
	"color" : "#CC3A88"
	"font-size" : "1.5em"
	"text-align": "center"
	"line-height": "100px"
}

#When the bar is drag, update the highlight bar and reading
sliderDrag.on Events.DragMove, ->
	sliderBar.width = sliderDrag.x - 50
	sliderDrag.backgroundColor = "#CC3A88"
	sliderNum = Utils.round(Utils.modulate(sliderDrag.x, [50,340], [0,100]),0)
	
	svgPath = document.getElementById('svgPath')
	pathLength = svgPath.getTotalLength()
	svgPath.style.strokeDasharray = pathLength + ' ' + pathLength;
	svgPath.style.strokeDashoffset = pathLength
	svgPath.getBoundingClientRect()
# 	svgPath.style.transition = svgPath.style.WebkitTransition = 'stroke-dashoffset 2s ease-in-out'
	svgPath.style.strokeDashoffset = pathLength * (1 - (sliderNum / 100))

#When the drag is ended, reset the drag color
sliderDrag.on Events.DragEnd, ->
	sliderDrag.backgroundColor = "#FFF"