Started July, 23rd
Try to finish by August 23rd

- [x] raycasting
- [x] grid highlighting
- [x] make unique
- [x] save as file from blender
- [x] what else?
- [x] selection
- [x] figure out how to handle selection properly
- [x] create UI on selection
- [x] camera zoom in and out
	
- [x] rover
	- [x] move with right click
- [x] refactor selection and stuff

- [x] pathfinding
	- [x] basic pathfinding
	- [x] pathfind around landing craft
	- [x] max recursion depth
	
- [x] ground PBR texture
- [x] disable raycasting on UI interaction

- [x] UI interaction
	- [x] spawn new rover
	- [x] move rover to waypoint
- [x] add resources and resource UI
	- [x] initialize resource grid (tons of regolith per square)
- [x] add mining behavior for rovers (wander until grid with regolith is found, then mine)
- [x] behaviors
	- [x] look for grid
	- [x] move to grid
	- [x] mine
- [x] show total amount of mined regolith in tons on UI

- [x] show kW
	- [x] lander should produce 10kW
	- [x] rover should consume 5kW when active
	- [x] dispatch signals to show consumption rates
	- [x] if power is over-consumed, throttle efficiency rates

- [x] add resource-processor
	- [x] rovers go to resource processor when full
- [x] rover power requirements
- [x] regolith processor efficiency
- [ ] regolith to element conversion rates (O2 45%, Si 21%, Metals 25%)
- [ ] add Metals, Metalloids, and Organics generated from regolith processor
- [ ] add efficency to UI

- [ ] add solar panels	
- [ ] solar panel energy production

- [ ] fix bug where hovering over the first rover highlights all of them

- [ ] add object construction from rover
	- [ ] solar panels
	- [ ] regolith processor

- [ ] take a break and watch the tutemic video

- [ ] show amount of regolith inside rover
- [ ] dust particles when mining and driving
- [ ] create conduit paths between solar panels and resource extractors
- [ ] create a unit cap. Only rovers can increase unit cap
