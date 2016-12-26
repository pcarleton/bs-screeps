
let logSpawning game =
    let open Types.Spawn in 
    let open Types.GameState in 
    let open Types.Creep in 
    Types.StringMap.iter (fun _ spawn ->
        Js.log spawn.spawning
    ) game.spawns;
    Array.iter (fun c -> Js.log c.name) game.creeps

let executePlan () = 
    let game = Converter.convertGlobal () in
    let spawnPlan = Action.makeSpawnActions game in
    logSpawning game;
    List.map Converter.applySpawnAction spawnPlan


