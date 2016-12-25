open Types

let emptyGame : Types.GameState.t = 
    let open Types.GameState in
    { creeps = [||]; spawns = StringMap.empty}

let addSpawn gs spawn = 
    let open Types.GameState in
    let open Types.Spawn in 
    {gs with spawns = StringMap.add spawn.name spawn gs.spawns}


let applyAction spawn action =
    match action with
        | Action.Nothing -> Js.log "No action"; (spawn, 0)
        | Action.Spawn args ->
                Js.log "Doing a spawn!";
                (* TODO: Actually spawn here *)
                (* TODO: Make a type for the spawn result other than int *)
                (spawn, 0)

let applySingleAction game (name, action) =
    let open GameState in 
    if StringMap.mem name game.spawns then
        let oldSpawn = StringMap.find name game.spawns in
        let (newSpawn, result) = applyAction oldSpawn action in
        let newSpawnMap = StringMap.add name newSpawn game.spawns in
        {game with spawns = newSpawnMap}
    else
        game




let testRun () =
    let open Types.Spawn in
    let game = addSpawn emptyGame {name = "Spawn1"; energy = 300} in
    let spawnPlan = Action.makeSpawnActions game in
    List.fold_left applySingleAction game spawnPlan

let () =
    ignore (testRun ())
