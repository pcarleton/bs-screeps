
let spawnCreep : Helper.spawn -> string -> string array -> string -> int  = 
    fun sp name parts role -> 
        sp##createCreep parts name [%bs.obj {role = role}]

let run_loop game =
    let sp = Helper.find_spawn game "Spawn1" in
        match Js.Undefined.to_opt sp with
        | None -> Js.log "No spawn!"
        | Some s -> 
            let harvesters = Helper.creepsOfType game "harvester" 
            and hparts = [| "move"; "carry"; "work" |]
                in 
            if Array.length harvesters < 1 then 
                let spawnResult = spawnCreep s "harvester1" hparts "harvester"
                in ignore spawnResult; Js.log (Array.length harvesters)
    (*let
        spawn = Helper.find_spawn "Spawn1"
    in
    *)
        

    (*Js.log (Helper.find_spawn "Spawn1") *)

let loop () =
    run_loop Helper.extGame

