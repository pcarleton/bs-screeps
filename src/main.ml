
let spawnCreep : Helper.spawn -> string -> string array -> int  = 
    fun sp name parts -> 
    sp##createCreep parts name 

let loop () =
    let
        harvesters = Helper.creepsOfType "harvester"
    and sp = Helper.find_spawn "Spawn1"
    and hparts = [| "move"; "carry"; "work" |]
    in 
        if Array.length harvesters < 1
        then 
            let spawnResult = spawnCreep sp "harvester1" hparts in
            ignore spawnResult;
        Js.log (Array.length harvesters)
    (*let
        spawn = Helper.find_spawn "Spawn1"
    in
    *)
        

    (*Js.log (Helper.find_spawn "Spawn1") *)
