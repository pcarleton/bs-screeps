
let logSpawning game =
    let open Types.Spawn in 
    let open Types.GameState in 
    Types.StringMap.iter (fun _ spawn ->
        Js.log spawn.spawning
    ) game.spawns

let executePlan () = 
    let game = Converter.convertGlobal () in
    let spawnPlan = Action.makeSpawnActions game in
    logSpawning game;
    List.map Converter.applySpawnAction spawnPlan


