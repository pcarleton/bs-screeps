
let executePlan () = 
    let game = Converter.convertGlobal () in
    let spawnPlan = Action.makeSpawnActions game in
    List.map Converter.applySpawnAction spawnPlan


