
class type _extSpawn = object
    method name: string
    method energy: int
    method createCreep : string array -> string -> 'a Js.t -> int [@bs.meth]
end [@bs]

type extSpawn = _extSpawn Js.t

class type _extCreep = object
    method name : string
end [@bs]
type extCreep = _extCreep Js.t

type 'a objsH

class type _game = object
    method spawns : extSpawn objsH 
    method creeps : extCreep objsH 
end [@bs]

type extGame = _game Js.t

external globalGame : extGame= "Game" [@@bs.val]


external objKeys : 'a objsH -> string array [@bs] = "Object.keys" [@@bs.val]
(* This shouldn't be necessary... I don't know why it doesn't
 * work with the above one *)
(* let spVals : 'a objsH -> 'a array = [%bs.raw "Object.values" ] *)



external getObj : 'a objsH -> string -> 'a Js.undefined = "" [@@bs.get_index]

let convCreep c = 
    let open Types.Creep in
    {name = c##name}

let convSpawn : extSpawn -> Types.Spawn.t = fun s ->
    let open Types.Spawn in
    {name = s##name; energy = s##energy}

let getVals obj =
    let keys = objKeys obj [@bs] in
    let foldfn acc key =
        let opt = getObj obj key in 
        match Js.Undefined.to_opt opt with
            | None -> acc
            | Some s -> s :: acc
    in 
        Array.of_list (List.fold_left foldfn []
            (Array.to_list keys))

let convertExternal : extGame -> Types.GameState.t = fun g ->
    let creeps = Array.map convCreep (getVals g##creeps) in
    let spawns = Array.map convSpawn (getVals g##spawns) in
        let open Types.GameState in
        { creeps; spawns }

let convertGlobal _ =
    convertExternal globalGame

let applySpawnAction (spawnName, action) =
    match action with 
        | Action.Nothing -> Js.log "No spawn action"; 0
        | Action.Spawn args ->
            let spawnRes = getObj globalGame##spawns spawnName in
            let open Action.SpawnArgs in
            match Js.Undefined.to_opt spawnRes with
                | None -> Js.log "No spawn!"; -1
                | Some spawn -> 
                    Js.log "Spawning a creep";
                    spawn##createCreep args.parts args.name
                        [%bs.obj {role = args.role}]

