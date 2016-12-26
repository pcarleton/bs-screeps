open Types

let emptyGame : Types.GameState.t = 
    let open Types.GameState in
    { creeps = [||]; spawns = StringMap.empty}

let addSpawn gs spawn = 
    let open Types.GameState in
    let open Types.Spawn in 
    {gs with spawns = StringMap.add spawn.name spawn gs.spawns}


let applyAction spawn action =
    let open Types.Spawn in 
    let open Action.SpawnArgs in 
    match action with
        | Action.Nothing -> Js.log "No action"; (spawn, 0)
        | Action.Spawn args ->
                let (newSpawn, status) = 
                    match spawn.spawning with
                     (* todo: return correct status here *)
                     | Some n -> 
                             Js.log "Already spawning...";
                             (spawn, -1)
                     | None -> 
                         let numParts = Array.length args.parts in
                         let timeNeeded = numParts * 3 in
                         let spawning = {
                             name = args.name;
                             needTime = timeNeeded;
                             remainingTime = timeNeeded;
                            } in
                         let newSpawn =
                             {spawn with spawning = Some spawning} in
                         Js.log "Doing a spawn!";
                         (newSpawn, 0)
                in (newSpawn, status)
                

let applySingleAction game (name, action) =
    let open GameState in 
    if StringMap.mem name game.spawns then
        let oldSpawn = StringMap.find name game.spawns in
        let (newSpawn, result) = applyAction oldSpawn action in
        let newSpawnMap = StringMap.add name newSpawn game.spawns in
        {game with spawns = newSpawnMap}
    else
        game

open Spawn
let advanceSpawn spawn =
    match spawn.spawning with
    | None -> spawn
    | Some spinfo ->
        let newRemaining = spinfo.remainingTime - 1 in
        match newRemaining with
        | 0 -> 
            Js.log "Spawn complete!";
            {spawn with spawning = None}
        | _ ->
            let newSpinfo = {spinfo with remainingTime = newRemaining} in
            {spawn with spawning = Some newSpinfo}
            

open GameState
let advanceSpawns game = 
    let newSpawns =
        StringMap.map advanceSpawn game.spawns
    in
    {game with spawns = newSpawns}

let tick game =
    advanceSpawns game

let makePlayerChanges game = 
    let spawnPlan = Action.makeSpawnActions game in
    List.fold_left applySingleAction game spawnPlan

let testRun () =
    let open Types.Spawn in
    let game = addSpawn emptyGame {name = "Spawn1"; energy = 300;
                                    spawning = None} in
    let gameRef = ref game in
    for i = 0 to 20 do
        gameRef := (makePlayerChanges !gameRef);
        gameRef := (tick !gameRef)
    done

let () =
    ignore (testRun ())
